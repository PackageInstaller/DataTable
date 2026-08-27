local UINHeroEnterBuildingBuffInfo = class("UINHeroEnterBuildingBuffInfo", UIBaseNode)
local base = UIBaseNode
local valueFuncTable = {
  [eLogicType.ResourceLimit] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local itemName = LanguageUtil.GetLocaleText(ConfigData.item[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.ResourceLimit, itemName)
    theSelf.ui.tex_OldNum.text = tostring(math.floor(theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID] * heroScoreRate))
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = tostring(math.floor(theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID] * newHreoScoreRate))
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.ResourceOutput] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local itemName = LanguageUtil.GetLocaleText(ConfigData.item[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.ResourceOutput, itemName)
    local speed = theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID] * 36 // 1000
    theSelf.ui.tex_OldNum.text = tostring(math.floor(speed * heroScoreRate))
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = tostring(math.floor(speed * newHreoScoreRate))
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.CampBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local campName = LanguageUtil.GetLocaleText(ConfigData.camp[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.CampBuff, campName)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID]].name)
    local attrValue = theSelf.levelBuffCfg.buff_para3[theSelf.buffCfhID]
    theSelf.ui.tex_OldNum.text = attrName .. "+" .. math.floor(attrValue * heroScoreRate)
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = attrName .. "+" .. math.floor(attrValue * newHreoScoreRate)
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.CareerBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local careerName = LanguageUtil.GetLocaleText(ConfigData.career[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.CareerBuff, careerName)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID]].name)
    local attrValue = theSelf.levelBuffCfg.buff_para3[theSelf.buffCfhID]
    theSelf.ui.tex_OldNum.text = attrName .. "+" .. math.floor(attrValue * heroScoreRate)
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = attrName .. "+" .. math.floor(attrValue * newHreoScoreRate)
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.FactoryPipelie] = function(heroScoreRate, newHreoScoreRate, theSelf)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.FactoryPipelie)
    theSelf.ui.tex_OldNum.text = tostring(math.floor(theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID] * heroScoreRate))
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = tostring(math.floor(theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID] * newHreoScoreRate))
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.GlobalExpCeiling] = function(heroScoreRate, newHreoScoreRate, theSelf)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.GlobalExpCeiling)
    local expLimt = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    theSelf.ui.tex_OldNum.text = tostring(math.floor(expLimt * heroScoreRate))
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = tostring(math.floor(expLimt * newHreoScoreRate))
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.StaminaCeiling] = function(heroScoreRate, newHreoScoreRate, theSelf)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.StaminaCeiling)
    local staminaLimt = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    theSelf.ui.tex_OldNum.text = tostring(math.floor(staminaLimt * heroScoreRate))
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = tostring(math.floor(staminaLimt * newHreoScoreRate))
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.StaminaOutput] = function(heroScoreRate, newHreoScoreRate, theSelf)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.StaminaOutput)
    local speed = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID] * 0.036
    theSelf.ui.tex_OldNum.text = tostring(math.floor(speed * heroScoreRate))
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = tostring(math.floor(speed * newHreoScoreRate))
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.ResOutputEfficiency] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local itemName
    if theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID] == 0 then
      itemName = ConfigData:GetTipContent(14010)
    else
      local itemCfg = ConfigData.item[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]]
      if itemCfg == nil then
        itemName = ConfigData:GetTipContent(14009)
      else
        itemName = LanguageUtil.GetLocaleText(itemCfg.name)
      end
    end
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.ResOutputEfficiency, itemName)
    theSelf.ui.tex_OldNum.text = GetPreciseDecimalStr(theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID] / 10 * heroScoreRate, 2) .. "%"
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = GetPreciseDecimalStr(theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID] / 10 * newHreoScoreRate, 2) .. "%"
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.BuildQueue] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local listPlace = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    if listPlace == 1 then
      theSelf.ui.tex_AttriName:SetIndex(eLogicType.BuildQueue)
    else
      theSelf.ui.tex_AttriName:SetIndex(16)
    end
    local listNum = theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID]
    theSelf.ui.tex_OldNum.text = tostring(math.floor(listNum * heroScoreRate))
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = tostring(math.floor(listNum * newHreoScoreRate))
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.BuildSpeed] = function(heroScoreRate, newHreoScoreRate, theSelf)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.BuildSpeed)
    local speed = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    theSelf.ui.tex_OldNum.text = GetPreciseDecimalStr(speed / 10 * heroScoreRate, 2) .. "%"
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = GetPreciseDecimalStr(speed / 10 * newHreoScoreRate, 2) .. "%"
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.GlobalExpRatio] = function(heroScoreRate, newHreoScoreRate, theSelf)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.GlobalExpRatio)
    local rate = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    theSelf.ui.tex_OldNum.text = GetPreciseDecimalStr(rate / 10 * heroScoreRate, 2) .. "%"
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = GetPreciseDecimalStr(rate / 10 * newHreoScoreRate, 2) .. "%"
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end,
  [eLogicType.AllHeroBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
    theSelf.ui.tex_AttriName:SetIndex(eLogicType.AllHeroBuff)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    local attrValue = theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID]
    theSelf.ui.tex_OldNum.text = attrName .. "+" .. math.floor(attrValue * heroScoreRate, 1)
    if newHreoScoreRate then
      theSelf.ui.image:SetActive(true)
      theSelf.ui.tex_NewNum.gameObject:SetActive(true)
      theSelf.ui.tex_NewNum.text = attrName .. "+" .. math.floor(attrValue * newHreoScoreRate, 1)
    else
      theSelf.ui.image:SetActive(false)
      theSelf.ui.tex_NewNum.gameObject:SetActive(false)
    end
  end
}

function UINHeroEnterBuildingBuffInfo:OnInit()
  self.levelBuffCfg = nil
  self.buffCfhID = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.image:SetActive(false)
  self.ui.tex_NewNum.gameObject:SetActive(false)
end

function UINHeroEnterBuildingBuffInfo:InitBuff(levelBuffCfg, buffCfhID)
  self.levelBuffCfg = levelBuffCfg
  self.buffCfhID = buffCfhID
end

function UINHeroEnterBuildingBuffInfo:SetValue(heroScoreRate, newHreoScoreRate)
  local logic = self.levelBuffCfg.buff_logic[self.buffCfhID]
  valueFuncTable[logic](heroScoreRate, newHreoScoreRate, self)
end

function UINHeroEnterBuildingBuffInfo:OnDelete()
  base.OnDelete(self)
end

return UINHeroEnterBuildingBuffInfo
