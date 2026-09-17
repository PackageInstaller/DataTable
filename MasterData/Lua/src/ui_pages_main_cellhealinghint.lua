local this = class("cellHealingHint", G_UIModuleBase)
local heroSatietyTpl = L_GameTpl:getChargeSatietyTpl()
local petSatietyTpl = L_GameTpl:getCommonPetSatietyTpl()

function this.bind()
  return {
    selectBg_active = false,
    txt_hint = "",
    txtHint_active = true,
    txt_selectHint = ""
  }
end

function this.methods()
  return {}
end

function this:refresh()
  local hasSelect = self.bind.hasSelect
  local satietyValue = self.bind.satietyValue
  local cellId = self.bind.cellId
  local isPetSatiety = self.bind.isPetSatiety
  local text = isPetSatiety and self:getPetSatietyHintText(cellId) or self:getHeroSatietyHintText(cellId)
  local isSelect = false
  if hasSelect and not isPetSatiety then
    local interval = heroSatietyTpl:getId2IntervalDic()[cellId]
    local min = interval[1]
    local max = interval[2]
    isSelect = satietyValue >= min and satietyValue <= max
  end
  self.bind.selectBg_active = isSelect
  self.bind.txtHint_active = not isSelect
  if isSelect then
    self.bind.txt_selectHint = L_GameUtil.fillColor(text, "#3266b4")
  else
    self.bind.txt_hint = L_GameUtil.fillColor(text, "#76777d")
  end
end

function this:getHeroSatietyHintText(tplId)
  if not tplId then
    return "", false
  end
  local keyColor = L_Const.satietyColor[tplId]
  local interval = heroSatietyTpl:getTplById(tplId).interval
  local min = interval[1]
  local max = interval[2]
  local amplitude = heroSatietyTpl:getAmplitudeById(tplId) / 100
  local amplitudeStr = amplitude > math.floor(amplitude) and string.format("%.1f", amplitude) or string.format("%d", amplitude)
  return L_WordsTpl:getValue("ui_cellHealingHint_01", {
    [0] = L_GameUtil.fillColor(string.format("%d-%d", math.floor(min), math.floor(max)), keyColor),
    [1] = amplitudeStr
  })
end

function this:getPetSatietyHintText(tplId)
  if not tplId then
    return ""
  end
  local keyColor = L_Const.satietyColor[tplId]
  local tpl = petSatietyTpl:getTplById(tplId)
  local satiety = petSatietyTpl:getSatiety(tpl)
  for min, max in pairs(satiety) do
    min = min / 10000
    max = max / 10000
    local gameConstTpl = L_GameTpl:getGameConstTpl()
    local maxSatiety = gameConstTpl:getData("PET_SATIETY_MAX_VALUE", L_Const.GameTplType.int)
    return L_WordsTpl:getValue("ui_cellHealingHint_02", {
      [0] = L_GameUtil.fillColor(string.format("%s-%s", math.floor(min * maxSatiety), math.floor(max * maxSatiety)), keyColor),
      [1] = math.floor(petSatietyTpl:getMoveSpeedSp(tpl) * 100)
    })
  end
end

return this
