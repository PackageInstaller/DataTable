local module = class("cellAttrItem", G_UIModuleBase)
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local gameConstTpl = L_GameTpl:getGameConstTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    shiningImg = {
      ss = "Page/Common/tex_pet_frame_sx_di2",
      sss = "Page/Common/tex_pet_frame_sx_di"
    },
    rideShiningImg = {
      [8] = "Page/Common/tex_pet_frame_sx_di2",
      [9] = "Page/Common/tex_pet_frame_sx_di"
    },
    textColorType = {
      [1] = "#4C5E87",
      [2] = "#4767DF"
    },
    topRankColor = {sss = "#ebc2d9", ss = "#edb200"}
  }
end

function module.bind()
  return {
    show_shiningBg = false,
    attrIcon = "",
    shiningAttrIcon = "",
    shiningIcon_color = CS.UnityEngine.Color(1, 1, 1),
    shingingBg = "",
    name = "",
    name_b = "",
    value = "",
    addBgActive = false,
    bgActive = true,
    color_bg = C_Color(1, 1, 1, 1),
    addValueText = "",
    color_addValueText = C_Color(0.2968, 0.3672, 0.5273, 1),
    toggle_nameIsBold = false,
    alpha_valueBg = 1
  }
end

function module.methods()
  return {
    onClick_detail = function(self)
      if self.bind.cbk then
        self.bind.cbk(self)
      end
    end
  }
end

function module:open()
  self:refreshInfo()
  self:playUpAnim("anim_cellattrItem_list_in")
end

function module:refreshAttrCS(params)
  self.bind.attrIcon = params.attrIcon
  self.bind.value = params.value
  self.bind.name = params.name
  self.bind.attrId = params.attrId
  self:refreshInfo()
end

function module:playUpAnim(animName)
  local clip = self.bindComponents.levelUpAnim:get_Item(animName)
  if clip == nil then
    return
  end
  self.bind.alpha_valueBg = 1
  clip.time = 0
  self.bindComponents.levelUpAnim:Sample()
  if self.bind.isInit then
    self.bindComponents.levelUpAnim:Play(animName)
  end
end

function module:refresh()
  self:refreshInfo()
end

function module:refreshInfo()
  if not math.isEmpty(self.bind.attrId) then
    local tpl = petLearningAblityTpl:getTplById(self.bind.attrId)
    local level = petLearningAblityTpl:getLevel(tpl)
    local enumId = petLearningAblityTpl:getEnumId(tpl)
    local enumTpl = petLearningEnumTpl:getTplById(enumId)
    local rawValue = self.bind.value
    if not self.bind.controlValueColor then
      self.bind.value = string.format("<color=#4767DF>%s</color>", rawValue)
    end
    self.bind.name_b = self.bind.name
    self.bind.toggle_nameIsBold = true
  elseif not math.isEmpty(self.bind.mountId) and not math.isEmpty(self.bind.baseSpeed) then
    local speedFactor = gameConstTpl:getData("PET_RIDERSPEEDMULT", L_Const.GameTplType.int)
    local value = math.floor(self.bind.baseSpeed * (1 + self.bind.bonusSpeed / 10000) * speedFactor)
    local index = 0
    local speedRankList = gameConstTpl:getData("PET_RIDEREXTRASPEED", L_Const.GameTplType.list_list_int)
    for i, v in ipairs(speedRankList) do
      if self.bind.bonusSpeed >= v[1] and self.bind.bonusSpeed <= v[2] then
        index = i
        break
      end
    end
    self.bind.value = tostring(value)
  end
  if self.bind.showAddBg == nil then
    self.bind.showAddBg = false
  end
  if not self.bind.showAddBg then
    self.bind.addValueText = self.bind.value
  end
  self.bind.addBgActive = self.bind.showAddBg
  if self.bind.abilityLimit then
    self.bind.color_addValueText = C_Color(0.8633, 0.4063, 0.4063, 1)
  end
end

function module:close()
  if self.doTween then
    self.doTween:Kill()
    self.doTween = nil
  end
end

function module:playLevelUpAni(index)
  local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
  if self.bindComponents.levelUpAnim then
    Timer.once(index * 0.033, function()
      if not self.bindComponents.levelUpAnim then
        return
      end
      self.bindComponents.levelUpAnim:Play("anim_cell_up")
      self.bind.value = battleInfoTpl:getShowTxtComma(self.bind.showId, self.bind.currentValue)
      self.bind.addValueText = self.bind.value
      local value = self.bind.currentValue
      
      local function getter()
        return value
      end
      
      local function setter(v)
        if not self.isBind then
          return
        end
        self.bind.value = battleInfoTpl:getShowTxtComma(self.bind.showId, math.ceil(v))
        self.bind.addValueText = self.bind.value
      end
      
      local targetValue = self.bind.currentValue + self.bind.addValue
      Timer.once(0.033, function()
        if not self.isBind then
          return
        end
        self.doTween = DOTween.To(getter, setter, targetValue, 0.333)
        self.doTween:SetEase(Tweening.Ease.OutQuad)
      end, self)
      Timer.once(0.165, function()
        if not self.isBind then
          return
        end
        self.bind.addBgActive = false
      end, self)
    end, self)
  end
end

function module:stopAni()
  if self.isBind then
    if not self.bindComponents.levelUpAnim then
      return
    end
    self.bindComponents.levelUpAnim:Stop()
  end
end

return module
