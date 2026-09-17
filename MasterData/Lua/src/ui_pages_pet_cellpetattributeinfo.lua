local this = class("cellPetAttributeInfo", G_UIModuleBase)
local _petLearingEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local _petTalentUpgradeTpl = L_GameTpl:getPetTalentUpgradeTpl()
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local ColorOfTextComprehensionLevel = {
  NORMAL = C_LuaUtility.ParseHtmlStringColor("#806E5B"),
  UPGRADE = C_LuaUtility.ParseHtmlStringColor("#E0923E")
}
local qualitySuper = {ss = true, sss = false}
local qualityTextColorGradient = {ss = "#e0923e", sss = "#ff5d92"}
local lightIconColor = {ss = "#ffbf5b", sss = "#ff9dab"}
local upIconColor = {
  "#ffceae",
  "#9dbb94",
  "#aeaad1",
  "#d9c17e"
}

function this.bind()
  return {
    img_attributeIcon = "",
    img_attributeLightIcon = "",
    toggle_attrQuality = false,
    active_attrSuperQuality = false,
    color_attrIconColor = nil,
    color_attrLightIcon = nil,
    color_attrRingColor = nil,
    text_curAttrNum = "",
    text_addAttrNum = "",
    txt_attrLevel = "",
    txt_attrExp = "",
    active_isUpLevel = false,
    active_isMaxLevel = false,
    fill_petExp = 0,
    fill_curExp = 0,
    active_fx = false,
    upColor = nil,
    up2Color = nil
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  this.super.open(self)
  self.bind.active_fx = false
end

function this:setAddResultExpLayoutWidth()
  local width = self.bindComponents.trans_image_curExp.rect.width
  local height = self.bindComponents.trans_image_curExp.rect.height
  self.bindComponents.trans_layout_addResultExp.sizeDelta = C_Vector2(width, height)
  self.addResultExpLayoutWidth = width
  self.addResultExpLayoutHeight = height
end

function this:setShowPetGuidAndAttrEnumNum(petGuid, attrEnumNum)
  self.petGuid = petGuid
  self.attrEnumNum = attrEnumNum
  self.comprehensionMaxLevel = _petTalentUpgradeTpl:getTargetComprehensionMaxLevel(self.attrEnumNum)
end

function this:setAttrUpColor(index)
  local _, _color = C_ColorUtility.TryParseHtmlString(upIconColor[index])
  self.bind.upColor = _color
  self.bind.up2Color = _color
end

function this:refreshBaseInfoUI()
  if self.petGuid == nil or self.attrEnumNum == nil then
    errorf("cellPetAttributeInfo 未设置需要展示的宠物Guid和属性枚举")
    return
  end
  self.bind.active_isUpLevel = false
  self.bind.active_isMaxLevel = false
  self.bind.text_addAttrNum = ""
  self.bind.img_attributeLightIcon = ""
  self.bind.active_fx = false
  self.petItem = L_PetStore:getPetItem(self.petGuid)
  local petItem = self.petItem
  local petProperty = L_PetStore:getPetProperty(petItem)
  self.petProperty = petProperty
  local petLearingEnumTpl = _petLearingEnumTpl:getTplByEnumId(self.attrEnumNum)
  self.bind.img_attributeIcon = _petLearingEnumTpl:getNewIcon(petLearingEnumTpl)
  local color = _petLearingEnumTpl:getIconColor(petLearingEnumTpl)
  if string.isEmpty(color) then
    color = "#ffffff"
  end
  local _, attrColor = C_ColorUtility.TryParseHtmlString(color)
  self.bind.color_attrIconColor = attrColor
  self.bind.color_attrRingColor = attrColor
  self:refreshAttrQuality()
  self.curAttrNum = L_PetStore:getPetAttFinalValue(petProperty, self.attrEnumNum, self.petGuid)
  self.curAttrNumTxt = _battleInfoTpl:getShowTxtComma(self.attrEnumNum, self.curAttrNum)
  self.bind.text_curAttrNum = self.curAttrNumTxt
  local selfAttrComprehension = petItem:getTargetAttributeComprehension(self.attrEnumNum)
  self.selfAttrComprehension = selfAttrComprehension
  self.bind.txt_attrLevel = string.format("Lv. <size=24>%s</size>", tostring(selfAttrComprehension.level))
  local isMaxLv = selfAttrComprehension.level >= self.comprehensionMaxLevel
  self.bind.active_isMaxLevel = isMaxLv
  local tpl = _petTalentUpgradeTpl:getTplByAttrEnumNumAndLevel(self.attrEnumNum, selfAttrComprehension.level)
  local nextExp = _petTalentUpgradeTpl:getCurLevelMaxExp(tpl)
  local curExp = isMaxLv and nextExp or selfAttrComprehension.cur_exp
  self.bind.txt_attrExp = string.format("%d/%d", curExp, nextExp)
  self.bind.fill_petExp = curExp / nextExp
  self.bind.fill_curExp = curExp / nextExp
  self.lastAddExp = nil
  self.lastLevel = nil
end

function this:refreshPreAddComprehensionExpUI(addExp, newLv)
  local petItem = L_PetStore:getPetItem(self.petGuid)
  addExp = addExp or 0
  if addExp == 0 and newLv == petItem.lv then
    self.lastAddExp = nil
    self.lastLevel = nil
    self:refreshBaseInfoUI()
    return
  end
  if self.selfAttrComprehension.level >= self.comprehensionMaxLevel then
    return
  end
  local maxNeedExpOfOneComprehension = _petTalentUpgradeTpl:getMaxNeedExpOfOneComprehension(self.attrEnumNum)
  local selfAttrComprehension = self.petItem:getTargetAttributeComprehension(self.attrEnumNum)
  local tpl = _petTalentUpgradeTpl:getTplByAttrEnumNumAndLevel(self.attrEnumNum, selfAttrComprehension.level)
  local nextExp = _petTalentUpgradeTpl:getCurLevelMaxExp(tpl)
  local curComprehensionExp = selfAttrComprehension.cur_exp + nextExp
  if maxNeedExpOfOneComprehension <= addExp + curComprehensionExp then
    addExp = maxNeedExpOfOneComprehension - curComprehensionExp
  end
  if 0 < addExp then
    self.bind.txt_attrExp = string.format("%d%s/%d", self.selfAttrComprehension.cur_exp, L_GameUtil.fillColor("+" .. tostring(addExp), L_Const.colorHtml.yellow005), nextExp)
  else
    self.bind.txt_attrExp = string.format("%d/%d", self.selfAttrComprehension.cur_exp, nextExp)
  end
  local targetLevel = _petTalentUpgradeTpl:getTargetLevelByAttrEnumNumCurLevelCurExpAddExp(self.attrEnumNum, self.selfAttrComprehension.level, self.selfAttrComprehension.cur_exp, addExp)
  if targetLevel > self.selfAttrComprehension.level then
    local function deep_clone(object)
      local lookup_table = {}
      
      local function _copy(object)
        if type(object) ~= "table" then
          return object
        elseif lookup_table[object] then
          return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
          new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
      end
      
      return _copy(object)
    end
    
    local newPetItem = deep_clone(self.petItem)
    for _, comprehension in ipairs(newPetItem.comprehension) do
      if comprehension.attr_id == self.attrEnumNum then
        comprehension.level = targetLevel
        local petTalentUpgradeTpl = _petTalentUpgradeTpl:getTplByAttrEnumNumAndLevel(self.attrEnumNum, targetLevel)
        comprehension.value = _petTalentUpgradeTpl:getStartValue(petTalentUpgradeTpl)
      end
    end
    local newPetProperty = L_PetStore:getPetProperty(newPetItem, newLv)
    local newAttrNum = L_PetStore:getPetAttFinalValue(newPetProperty, self.attrEnumNum)
    local oldAttrNum = L_PetStore:getPetAttFinalValue(self.petProperty, self.attrEnumNum)
    local deltaAttrNum = newAttrNum - oldAttrNum
    if deltaAttrNum ~= 0 then
      self.bind.text_addAttrNum = string.format(" +%s", _battleInfoTpl:getShowTxtComma(self.attrEnumNum, deltaAttrNum))
    else
      self.bind.text_addAttrNum = ""
    end
  else
    local old_property = self.petProperty
    local property = L_PetStore:getPetProperty(self.petItem, newLv)
    local old_value = L_PetStore:getPetAttFinalValue(old_property, self.attrEnumNum)
    local value = L_PetStore:getPetAttFinalValue(property, self.attrEnumNum)
    if value ~= old_value then
      self.bind.text_addAttrNum = string.format(" +%s", _battleInfoTpl:getShowTxtComma(self.attrEnumNum, value - old_value))
    else
      self.bind.text_addAttrNum = ""
    end
  end
  local needExp = 0
  for i = self.selfAttrComprehension.level, targetLevel - 1 do
    local exp = _petTalentUpgradeTpl:getCurLevelMaxExp(_petTalentUpgradeTpl:getTplByAttrEnumNumAndLevel(self.attrEnumNum, i))
    needExp = needExp + exp
  end
  local overflowExp = self.selfAttrComprehension.cur_exp + addExp - needExp
  if not self.lastAddExp then
    self.lastAddExp = 0
  end
  if not self.lastLevel then
    self.lastLevel = 0
  end
  if addExp > self.lastAddExp then
    if targetLevel > self.selfAttrComprehension.level and targetLevel > self.lastLevel then
      local overflowExpRatio = overflowExp / nextExp
      self.bindComponents.anim:Play("anim_petfeed_cell_levelup")
      self:playLvUpDoTween(overflowExpRatio, true)
    else
      self.bindComponents.anim:Play("anim_petfeed_cell_normal")
      FrameScheduler.add(function()
        self.bindComponents.anim:Play("anim_petfeed_cell_add")
      end)
      self:playExpAddDoTween(overflowExp / nextExp, 0.2, true, false)
    end
  else
    self:killExpAddTween()
    self.bind.fill_curExp = overflowExp / nextExp
    if targetLevel > self.selfAttrComprehension.level then
      self.bind.fill_petExp = 0
      if self.bind.fill_curExp == 1 then
        self.bind.fill_curExp = 0
      end
    else
      local exp = _petTalentUpgradeTpl:getCurLevelMaxExp(_petTalentUpgradeTpl:getTplByAttrEnumNumAndLevel(self.attrEnumNum, self.selfAttrComprehension.level))
      self.bind.fill_petExp = self.selfAttrComprehension.cur_exp / exp
    end
  end
  if targetLevel > self.selfAttrComprehension.level then
    self.bind.txt_attrLevel = L_GameUtil.fillColor(string.format("Lv. <size=24>%s</size>", tostring(targetLevel)), L_Const.colorHtml.yellow005)
    self.bind.active_isUpLevel = true
    if not self.lastLevel or targetLevel > self.lastLevel then
      L_AudioUtil.playSound("Play_SFX_System_UI_Qibo_Stat_PreUp")
    end
  else
    self.bind.txt_attrLevel = string.format("Lv. <size=24>%s</size>", tostring(selfAttrComprehension.level))
    self.bind.active_isUpLevel = false
  end
  self.lastAddExp = addExp
  self.lastLevel = targetLevel
end

function this:attrLevelUp(isLevelUp)
  local petItem = L_PetStore:getPetItem(self.petGuid)
  local selfAttrComprehension = petItem:getTargetAttributeComprehension(self.attrEnumNum)
  local isMaxLv = selfAttrComprehension.level >= self.comprehensionMaxLevel
  local tpl = _petTalentUpgradeTpl:getTplByAttrEnumNumAndLevel(self.attrEnumNum, selfAttrComprehension.level)
  local nextExp = _petTalentUpgradeTpl:getCurLevelMaxExp(tpl)
  local curExp = isMaxLv and nextExp or selfAttrComprehension.cur_exp
  if isLevelUp then
    self.bind.active_fx = true
    self:refreshAttrQuality(true)
  end
  self:playLvUpDoTween(curExp / nextExp, false, function()
    self.bind.active_fx = false
    self:refreshBaseInfoUI()
  end)
end

function this:getAttrEnumNum()
  return self.attrEnumNum
end

function this:close()
  this.super.close(self)
  self:killExpAddTween()
  self:killLvUpTween()
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

function this:playLvUpDoTween(overflowExpRatio, isPreview, callback)
  local function getter()
    return self.bind.fill_curExp
  end
  
  local function setter(v)
    self.bind.fill_curExp = v
  end
  
  self:killLvUpTween()
  self:killExpAddTween()
  local time = (1 - self.bind.fill_petExp) * 0.33
  self.lvUpTween = DOTween.To(getter, setter, 1, time):SetEase(Tweening.Ease.OutQuint):OnComplete(function()
    self.bind.fill_curExp = 0
    self:playExpAddDoTween(overflowExpRatio, 0.3, isPreview, true, callback)
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

function this:refreshAttrQuality(playAnim)
  local petItem = self.petItem
  local topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, petItem.comprehension)
  local attr_id
  for n, k in pairs(topRankComprehension) do
    if k.attr_id == self.attrEnumNum then
      attr_id = k.rankId
      break
    end
  end
  if attr_id then
    local tpl = petLearningAblityTpl:getTplById(attr_id)
    local level = petLearningAblityTpl:getLevel(tpl)
    if qualitySuper[level] ~= nil then
      self.bind.active_attrSuperQuality = true
      self.bind.toggle_attrQuality = qualitySuper[level]
      if playAnim then
        self.bindComponents.qualityAnim:Play("anim_petfeed_quality_in")
      end
      self.bind.color_attrIconColor = C_Color(1, 1, 1, 1)
      self.bind.color_attrRingColor = C_Color(1, 1, 1, 1)
    else
      self.bind.active_attrSuperQuality = false
    end
    local qualityColor = qualityTextColorGradient[level]
    if qualityColor then
      local _1, topColor = C_ColorUtility.TryParseHtmlString("#353130")
      local _2, bottomColor = C_ColorUtility.TryParseHtmlString(qualityColor)
      self.bindComponents.LText_curAttrNum:SetColorGradient(topColor, topColor, bottomColor, bottomColor)
    end
  end
end

return this
