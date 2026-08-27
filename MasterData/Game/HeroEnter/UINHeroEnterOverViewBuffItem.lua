local UINHeroEnterOverViewBuffItem = class("UINHeroEnterBuildingBuffInfo", UIBaseNode)
local base = UIBaseNode
local valueFuncTable = {
  [eLogicType.ResourceLimit] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local itemName = LanguageUtil.GetLocaleText(ConfigData.item[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    local temp = tostring(math.floor(theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID] * heroScoreRate))
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.ResourceLimit, itemName, temp)
  end,
  [eLogicType.ResourceOutput] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local itemName = LanguageUtil.GetLocaleText(ConfigData.item[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    local speed = theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID] * 36 // 1000
    local temp = tostring(math.floor(speed * heroScoreRate))
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.ResourceOutput, itemName, temp)
  end,
  [eLogicType.CampBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local campName = LanguageUtil.GetLocaleText(ConfigData.camp[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID]].name)
    local attrValue = theSelf.levelBuffCfg.buff_para3[theSelf.buffCfhID]
    local temp = attrName .. "+" .. math.floor(attrValue * heroScoreRate)
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.CampBuff, campName, temp)
  end,
  [eLogicType.CareerBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local careerName = LanguageUtil.GetLocaleText(ConfigData.career[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID]].name)
    local attrValue = theSelf.levelBuffCfg.buff_para3[theSelf.buffCfhID]
    local temp = attrName .. "+" .. math.floor(attrValue * heroScoreRate)
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.CareerBuff, careerName, temp)
  end,
  [eLogicType.FactoryPipelie] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local temp = tostring(math.floor(theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID] * heroScoreRate))
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.FactoryPipelie, temp)
  end,
  [eLogicType.GlobalExpCeiling] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local expLimt = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    local temp = tostring(math.floor(expLimt * heroScoreRate))
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.GlobalExpCeiling, temp)
  end,
  [eLogicType.StaminaCeiling] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local staminaLimt = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    local temp = tostring(math.floor(staminaLimt * heroScoreRate))
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.StaminaCeiling, temp)
  end,
  [eLogicType.StaminaOutput] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local speed = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID] * 0.036
    local temp = tostring(math.floor(speed * heroScoreRate))
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.StaminaOutput, temp)
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
    local temp = GetPreciseDecimalStr(theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID] / 10 * heroScoreRate, 2) .. "%"
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.ResOutputEfficiency, itemName, temp)
  end,
  [eLogicType.BuildQueue] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local listPlace = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    local listNum = theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID]
    local temp = tostring(math.floor(listNum * heroScoreRate))
    if listPlace == 1 then
      theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.BuildQueue, temp)
    else
      theSelf.ui.tex_BuildAdd:SetIndex(16, temp)
    end
  end,
  [eLogicType.BuildSpeed] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local speed = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    local temp = GetPreciseDecimalStr(speed / 10 * heroScoreRate, 2) .. "%"
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.BuildSpeed, temp)
  end,
  [eLogicType.GlobalExpRatio] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local rate = theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]
    local temp = GetPreciseDecimalStr(rate / 10 * heroScoreRate, 2) .. "%"
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.GlobalExpRatio, temp)
  end,
  [eLogicType.AllHeroBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
    local attrName = LanguageUtil.GetLocaleText(ConfigData.attribute[theSelf.levelBuffCfg.buff_para1[theSelf.buffCfhID]].name)
    local attrValue = theSelf.levelBuffCfg.buff_para2[theSelf.buffCfhID]
    local temp = attrName .. "+" .. math.floor(attrValue * heroScoreRate)
    theSelf.ui.tex_BuildAdd:SetIndex(eLogicType.AllHeroBuff, temp)
  end
}

function UINHeroEnterOverViewBuffItem:OnInit()
  self.levelBuffCfg = nil
  self.buffCfhID = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroEnterOverViewBuffItem:InitBuff(levelBuffCfg, buffCfhID)
  self.levelBuffCfg = levelBuffCfg
  self.buffCfhID = buffCfhID
end

function UINHeroEnterOverViewBuffItem:SetValue(heroScoreRate, newHreoScoreRate)
  local logic = self.levelBuffCfg.buff_logic[self.buffCfhID]
  valueFuncTable[logic](heroScoreRate, newHreoScoreRate, self)
end

function UINHeroEnterOverViewBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroEnterOverViewBuffItem
