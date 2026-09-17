local module = class("cellAttrItemPetTalent", G_UIModuleBase)
local petInfoTpl = L_GameTpl:getPetTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()

local function getLearningTalentRow(enumId, currentLevel)
  if math.isEmpty(enumId) then
    return ""
  end
  local enumTpl = petLearningEnumTpl:getTplByEnumId(enumId)
  if enumTpl == nil then
    return ""
  end
  local abilityEnumKey = petLearningEnumTpl:getId(enumTpl)
  local rowList = petLearningAblityTpl:getTplByEnumId(abilityEnumKey)
  if rowList == nil then
    return ""
  end
  local lv = currentLevel or 0
  for _, v in pairs(rowList) do
    local rowType = v.type or v.Type
    if rowType == lv then
      local icon = petLearningAblityTpl:getIcon(v) or ""
      return icon
    end
  end
  return ""
end

function module:ctor(...)
  module.super.ctor(self, ...)
  self._currentLevel = 0
  self._valuePlain = ""
  self._abilityLimit = false
end

function module.bind()
  return {
    attrIcon = "",
    colorIcon = nil,
    name = "",
    value = "",
    imgRecommend = false,
    levelIcon = "",
    attr_addValue = "",
    go_addValue = false
  }
end

function module.methods()
  return {}
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
  self:refreshInfo()
end

function module:setData(data, abilityLimit, petConfigId)
  self._petConfigId = petConfigId
  self._attrEnumId = data and data.attrEnumId
  self._currentLevel = data and data.currentLevel or 0
  self._valuePlain = tostring(data and data.value or "")
  local oldTargetLevel = self._previewTargetLevel
  self._previewDelta = data and data.previewDelta
  self._previewTargetLevel = data and data.previewTargetLevel
  self._levelIncreased = (self._previewTargetLevel or 0) > (oldTargetLevel or 0)
  self.bind.attrIcon = data and data.attrIcon or ""
  local color = data and data.colorIcon or ""
  if string.isEmpty(color) then
    color = "#ffffff"
  end
  local _, attrColor = C_ColorUtility.TryParseHtmlString(color)
  attrColor.a = 0.66
  self.bind.colorIcon = attrColor
  self.bind.name = data and data.name or ""
  self.bind.value = self._valuePlain
  self._abilityLimit = abilityLimit
  self:refreshInfo()
end

function module:refreshInfo()
  local raw = self._valuePlain or ""
  local levelForIcon = self._currentLevel
  if self._previewTargetLevel and self._previewTargetLevel > self._currentLevel then
    levelForIcon = self._previewTargetLevel
    if self._levelIncreased then
      self:playLevelUpFx()
    end
  end
  self.bind.levelIcon = getLearningTalentRow(self._attrEnumId, levelForIcon)
  self.bind.value = self._abilityLimit and string.format("<color=#dd6868>%s</color>", raw) or raw
  if self._previewDelta and self._previewDelta > 0 then
    local addText = battleInfoTpl:getShowTxtComma(self._attrEnumId, self._previewDelta)
    self.bind.attr_addValue = "+" .. addText
    self.bind.go_addValue = true
  else
    self.bind.attr_addValue = ""
    self.bind.go_addValue = false
  end
  self:_refreshRecommendVisible()
end

local function playFxGo(fx)
  if fx == nil or fx.gameObject == nil then
    return
  end
  fx.gameObject:SetActive(false)
  fx.gameObject:SetActive(true)
end

function module:playLevelUpFx()
  if not self.bindComponents or not self.bindComponents.fx_levelup then
    return
  end
  playFxGo(self.bindComponents.fx_levelup)
end

function module:_refreshRecommendVisible()
  self.bind.imgRecommend = false
  if math.isEmpty(self._petConfigId) then
    return
  end
  local enumId = self._attrEnumId
  local petTpl = petInfoTpl:getTplById(self._petConfigId)
  local attrRecommend = petTpl and petTpl.attrRecommend or {}
  local recommendMain = attrRecommend[1]
  local recommendSub = attrRecommend[2]
  local isMainRecommend = recommendMain ~= nil and enumId == recommendMain
  local isSubRecommend = recommendSub ~= nil and enumId == recommendSub
  self.bind.imgRecommend = isMainRecommend or isSubRecommend
end

function module:close()
end

function module:show()
  module.super.show(self)
  if not self.bindComponents or not self.bindComponents.fx_levelup then
    return
  end
  self.bindComponents.fx_levelup.gameObject:SetActive(false)
end

return module
