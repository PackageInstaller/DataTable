local this = class("cellPetExpItem", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local petLevelTpl = L_GameTpl:getPetLevelTpl()

function this.bind()
  return {
    petIcon = "",
    levelText = "",
    expValue = 0,
    maxIconActive = false,
    levelUpIconActive = false,
    active_mvpFrame = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.noTip then
        return
      end
      L_ItemTplManager:showInfoTip(L_Const.resType.pet, self._itemId)
    end
  }
end

function this:open(options)
  self.noTip = true
end

function this:setPetContent(data)
  self.bind.guid = data.guid
  self.bind.nowExp = data.nowExp
  self.bind.oldExp = data.oldExp
  self.bind.nowLevel = data.nowLevel
  self.bind.oldLevel = data.oldLevel
  self:refresh()
end

function this:setSimpleContent(itemId, noTip)
  local cfg = petTpl:getTplById(itemId)
  if not cfg then
    return
  end
  self._itemId = itemId
  self.bind.petIcon = petTpl:getPetIcon(cfg, false)
  self.bind.levelText = cfg.name
  if noTip == nil then
    noTip = true
  end
  self.noTip = noTip
end

function this:refresh()
  if not self.isBind then
    return
  end
  local petItem = L_PetStore:getPetItem(self.bind.guid)
  if not petItem then
    return
  end
  local configId = petItem:petCfgId()
  local cfg = petTpl:getTplById(configId)
  self.bind.petIcon = petTpl:getPetIcon(cfg, petItem:isSpecialPet())
  self.bind.levelUpIconActive = self.bind.oldLevel ~= self.bind.nowLevel
  self.bind.levelText = tostring(self.bind.oldLevel)
  self.petMaxLevel = L_PetStore:getPetMaxLevel()
  self.bind.maxIconActive = self.bind.nowLevel >= self.petMaxLevel
  self.bind.active_mvpFrame = self.bind.mvpGuid == self.bind.guid
  if not (self.bind.nowLevel >= self.petMaxLevel) then
    self:showFx()
  end
end

function this:showFx()
  if self.tween then
    self.tween:Kill()
  end
  local isLevelUp = self.bind.oldLevel ~= self.bind.nowLevel
  if not isLevelUp then
    local levelTpl = petLevelTpl:getTplById(self.bind.oldLevel)
    local max = petLevelTpl:getExp(levelTpl)
    local startV = self.bind.oldExp / max
    local targetV = self.bind.nowExp / max
    self:expTween(startV, targetV)
  else
    self:upGradeTween()
  end
end

function this:upGradeTween()
  local curLevel = self.bind.oldLevel
  local curExp = self.bind.oldExp
  local levelTpl = petLevelTpl:getTplById(curLevel)
  local max = petLevelTpl:getExp(levelTpl)
  local startV = curExp / max
  local targetV = 1
  self:expTween(startV, targetV, function()
    self:onTweenComplete(curLevel)
  end)
end

function this:onTweenComplete(curLevel)
  curLevel = curLevel + 1
  self.bind.levelText = tostring(curLevel)
  local targetV, startV
  if curLevel < self.bind.nowLevel then
    startV = 0
    targetV = 1
    self:playLevelUp()
    self:expTween(startV, targetV, function()
      self:onTweenComplete(curLevel)
    end)
  elseif curLevel == self.petMaxLevel then
    self.bind.maxIconActive = true
    self:playLevelUp()
  elseif self.bind.nowLevel == curLevel then
    local curTpl = petLevelTpl:getTplById(curLevel)
    if curTpl == nil then
      return
    end
    local curMax = petLevelTpl:getExp(curTpl)
    startV = 0
    targetV = self.bind.nowExp / curMax
    self:playLevelUp()
    self:expTween(startV, targetV)
  end
end

function this:playLevelUp()
  if self.bindComponents.animation:IsPlaying("anim_petduel_lvup") then
    self.bindComponents.animation:Stop()
  end
  self.bindComponents.animation:Play("anim_petduel_lvup")
  L_AudioUtil.playSound("Play_SFX_System_UI_Qibo_Level_LevelUp")
end

function this:expTween(start, target, onComplete)
  self.sv = start
  if self.tween then
    self.tween:Kill()
  end
  
  local function getter()
    return self.sv
  end
  
  local function setter(r)
    self.sv = r
    self.bind.expValue = r
  end
  
  self.tween = DOTween.To(getter, setter, target, 0.33):SetEase(Tweening.Ease.Linear):OnComplete(function()
    if onComplete then
      onComplete()
    end
  end)
end

function this:close()
  if self.tween then
    self.tween:Kill()
  end
end

return this
