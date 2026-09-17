local this = class("modulePetLevelInfo", G_UIModuleBase)
local _petLevelTpl = L_GameTpl:getPetLevelTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local LvUpColorStr = "#e8a112"
local _LvTweenSpeed = 4
local _LvTweenMaxTime = 0.7
local _LvTweenMinTime = 0.4

function this.bind()
  return {
    go_upLevel = false,
    txt_curLv = "",
    txt_maxLv = "",
    txt_exp = "",
    fill_petExp = 0,
    fill_curExp = 0,
    active_isMaxLevel = false
  }
end

function this.methods()
  return {}
end

function this:show()
  this.super.show(self)
  if not (self.bindComponents and self.bindComponents.fx_levelup) or not self.bindComponents.fx_lvMax then
    return
  end
  self.bindComponents.fx_levelup.gameObject:SetActive(false)
  self.bindComponents.fx_lvMax.gameObject:SetActive(false)
end

function this:close()
  this.super.close(self)
  self:killCurLvTween()
  self:killExpAddTween()
  self:killLvUpTween()
end

function this:setShowPetGuid(petGuid)
  self.petGuid = petGuid
end

function this:refreshUI()
  if not self.petGuid then
    errorf("modulePetLevelInfo 未设置需要展示的宠物Guid")
    return
  end
  self.pet = L_PetStore:getPetItem(self.petGuid)
  self.maxLv = L_PetStore:getPetMaxLevel(true)
  self.bind.txt_maxLv = tostring(self.maxLv)
  self:onEvent_petExpChange()
end

function this:onEvent_petExpChange(selectInfo)
  local pet = L_PetStore:getPetItem(self.petGuid)
  if not selectInfo then
    self:setPetInfo(pet.lv, 0, 0)
    return
  end
  local tempExpAll = 0
  for _, v in ipairs(selectInfo) do
    local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(v.item_id))[1]
    tempExpAll = tempExpAll + v.item_num * exp
  end
  local tempExp = tempExpAll + pet.exp
  local tempLv = pet.lv
  for i = tempLv, self.maxLv - 1 do
    if 0 > tempExp - _petLevelTpl:getExp(_petLevelTpl:getTplById(i)) then
      break
    end
    tempLv = i + 1
    tempExp = tempExp - _petLevelTpl:getExp(_petLevelTpl:getTplById(i))
  end
  self:setPetInfo(tempLv, tempExpAll, tempExp)
end

function this:getShowMaxExpByLv(lv)
  if lv >= self.maxLv then
    return _petLevelTpl:getExp(_petLevelTpl:getTplById(lv - 1))
  end
  return _petLevelTpl:getExp(_petLevelTpl:getTplById(lv))
end

function this:setPetInfo(lv, addExp, overflowExp)
  local pet = L_PetStore:getPetItem(self.petGuid)
  local petExp = pet.exp
  if not self.lastAddExp then
    self.lastAddExp = 0
  end
  local isPreview = 0 < addExp
  if not isPreview then
    self:refreshCurLvToValue(lv, false)
  elseif addExp > self.lastAddExp and lv > pet.lv and lv > (self.lv or pet.lv) then
    local fromLv = self.lv and math.max(self.lv, pet.lv) or pet.lv
    self:playCurLvTween(fromLv, lv)
  else
    self:killCurLvTween()
    self:updateCurLvValue(lv, true)
    self.curDisplayLv = lv
  end
  local maxExp = self:getShowMaxExpByLv(lv)
  if 0 < addExp then
    self.bind.txt_exp = string.format("%s%s/%d", petExp, L_GameUtil.fillColor("+" .. tostring(addExp), LvUpColorStr), maxExp)
  elseif maxExp == 0 then
    local showExp = _petLevelTpl:getExp(_petLevelTpl:getTplById(pet.lv - 1))
    self.bind.txt_exp = string.format("%s/%d", showExp, showExp)
  else
    self.bind.txt_exp = string.format("%s/%d", petExp, maxExp)
  end
  if self.bindComponents.gradient then
    self.bindComponents.gradient.enabled = false
  end
  if addExp > self.lastAddExp then
    if lv > pet.lv and lv > self.lv then
      self.parent.bindComponents.anim:Play("anim_petfeed_normal")
      FrameScheduler.add(function()
        if not self.parent then
          return
        end
        self.parent.bindComponents.anim:Play("anim_petfeed_levelup")
        L_AudioUtil.playSound("Play_SFX_System_UI_Qibo_Level_PreUp")
      end)
      if not (lv >= self.maxLv) or not 1 then
        local overflowExpRatio = overflowExp / _petLevelTpl:getExp(_petLevelTpl:getTplById(lv))
      end
    else
      local ratio = overflowExp / _petLevelTpl:getExp(_petLevelTpl:getTplById(lv))
    end
  else
    self:killCurLvTween()
    self:killLvUpTween()
    self:killExpAddTween()
    if lv >= self.maxLv then
      if self.maxLv == L_PetStore:getPetMaxLevel() then
        self.bind.fill_petExp = 1
      else
        self.bind.fill_petExp = 0
      end
      self.bind.fill_curExp = 0
    elseif lv > pet.lv then
      self.bind.fill_curExp = overflowExp / _petLevelTpl:getExp(_petLevelTpl:getTplById(lv))
      self.bind.fill_petExp = 0
    else
      self.bind.fill_petExp = petExp / maxExp
      self.bind.fill_curExp = (addExp + petExp) / _petLevelTpl:getExp(_petLevelTpl:getTplById(lv))
    end
  end
  if addExp == 0 and pet.lv >= L_PetStore:getPetMaxLevel() then
    self.bind.active_isMaxLevel = true
    if self.bindComponents.gradient and pet.lv >= L_PetStore:getPetMaxLevel() then
      self.bindComponents.gradient.enabled = true
    end
  else
    self.bind.active_isMaxLevel = false
    if self.bindComponents.gradient and pet.lv >= L_PetStore:getPetMaxLevel() then
      self.bindComponents.gradient.enabled = false
    end
  end
  self.lv = lv
  self.lastAddExp = addExp
end

function this:getCurrentLv()
  return self.lv
end

local function playFxGo(fx)
  if fx == nil or fx.gameObject == nil then
    return
  end
  fx.gameObject:SetActive(false)
  fx.gameObject:SetActive(true)
end

function this:playLevelUpFx(isMaxLv)
  if not (self.bindComponents and self.bindComponents.fx_levelup) or not self.bindComponents.fx_lvMax then
    return
  end
  playFxGo(self.bindComponents.fx_levelup)
  if isMaxLv then
    playFxGo(self.bindComponents.fx_lvMax)
    self:playLvMaxAnim()
  end
end

function this:updateCurLvValue(displayLv, isPreview)
  local lvStr = tostring(math.floor(displayLv))
  if isPreview then
    self.bind.txt_curLv = L_GameUtil.fillColor(lvStr, LvUpColorStr)
    self.bind.go_upLevel = true
  else
    self.bind.txt_curLv = lvStr
    self.bind.go_upLevel = false
  end
end

function this:refreshCurLvToValue(targetLv, isPreview)
  self:killCurLvTween()
  self:updateCurLvValue(targetLv, isPreview)
  self.curDisplayLv = targetLv
end

function this:getLvTweenCurve()
  local curveHolder = self.bindComponents.lvCurveHolder
  if curveHolder ~= nil and curveHolder.curves ~= nil and curveHolder.curves.Count > 0 then
    return curveHolder.curves[0]
  end
  return nil
end

function this:getCurLvTweenDuration(delta)
  local duration = delta / _LvTweenSpeed
  if duration > _LvTweenMaxTime then
    return _LvTweenMaxTime
  end
  if duration < _LvTweenMinTime then
    return _LvTweenMinTime
  end
  return duration
end

function this:killCurLvTween()
  if self.curLvTween then
    self.curLvTween:Kill()
    self.curLvTween = nil
  end
end

function this:playCurLvTween(fromLv, toLv)
  self:killCurLvTween()
  fromLv = fromLv or 0
  toLv = toLv or fromLv
  local delta = math.abs(toLv - fromLv)
  if delta <= 0 then
    self:refreshCurLvToValue(toLv, true)
    return
  end
  local duration = self:getCurLvTweenDuration(delta)
  self.curDisplayLv = fromLv
  self:updateCurLvValue(fromLv, true)
  
  local function getter()
    return fromLv
  end
  
  local function setter(value)
    self:updateCurLvValue(value, true)
  end
  
  self.curLvTween = DOTween.To(getter, setter, toLv, duration)
  local curve = self:getLvTweenCurve()
  if curve ~= nil then
    self.curLvTween:SetEase(curve)
  else
    self.curLvTween:SetEase(Tweening.Ease.Linear)
  end
  self.curLvTween:OnComplete(function()
    self.curLvTween = nil
    self.curDisplayLv = toLv
    self:updateCurLvValue(toLv, true)
  end)
  self:playLvUpAnim()
end

function this:playLvUpAnim()
  local animName = "anim_uplevel_show"
  if self.bindComponents.anim_upLevel and self.bindComponents.anim_upLevel:GetClip(animName) then
    self.bindComponents.anim_upLevel:Play(animName)
  end
end

function this:playLvMaxAnim()
  local animName = "anim_modulePetFeed_levelmax"
  if self.bindComponents.anim_maxLevel and self.bindComponents.anim_maxLevel:GetClip(animName) then
    self.bindComponents.anim_maxLevel:Play(animName)
  end
end

function this:playExpAddDoTween(ratio, time, isPreview, hideOther, callback)
  if hideOther then
    if isPreview then
      self.bind.fill_petExp = 0
    else
      self.bind.fill_curExp = 0
    end
  end
  
  local function getter()
    return isPreview and self.bind.fill_curExp or self.bind.fill_petExp
  end
  
  local function setter(v)
    if isPreview then
      self.bind.fill_curExp = v
    else
      self.bind.fill_petExp = v
    end
  end
  
  self:killExpAddTween()
  self.expAddTween = DOTween.To(getter, setter, ratio, time):SetEase(Tweening.Ease.OutQuint):OnComplete(function()
    if callback then
      callback()
    end
  end)
end

function this:playLvUpDoTween(overflowExpRatio, isPreview, endCallback, upCallback)
  local function getter()
    return self.bind.fill_curExp
  end
  
  local function setter(v)
    self.bind.fill_curExp = v
  end
  
  self:killLvUpTween()
  self:killExpAddTween()
  local time = (1 - self.bind.fill_petExp) * 0.33
  local toRate = overflowExpRatio
  if isPreview then
    toRate = 1
  end
  self.lvUpTween = DOTween.To(getter, setter, toRate, time):SetEase(Tweening.Ease.OutQuint):OnComplete(function()
    if upCallback then
      upCallback()
    end
    if not isPreview or overflowExpRatio < 1 then
      self.bind.fill_curExp = 0
    end
    self:playExpAddDoTween(overflowExpRatio, 0.6, isPreview, true, endCallback)
  end)
end

function this:killExpAddTween()
  if self.expAddTween then
    self.expAddTween:Kill()
    self.expAddTween = nil
  end
end

function this:killLvUpTween()
  if self.lvUpTween then
    self.lvUpTween:Kill()
    self.lvUpTween = nil
  end
end

return this
