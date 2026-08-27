local FairyHelper = {}
local eFairyEnum = require("Game.Fairy.eFairyEnum")

function FairyHelper.FairyCommonSort(fairyDataList)
  table.sort(fairyDataList, function(fairyA, fairyB)
    local rankA = fairyA:GetFairyCurLevel()
    local rankB = fairyB:GetFairyCurLevel()
    if rankA ~= rankB then
      return rankA > rankB
    end
    local qualityA = fairyA:GetCurFairyQuality()
    local qualityB = fairyB:GetCurFairyQuality()
    if qualityA ~= qualityB then
      return qualityA < qualityB
    end
    return fairyA:GetFairyUID() > fairyB:GetFairyUID()
  end)
end

FairyHelper.qualityColor = {
  [eFairyEnum.fairyQualityType.s] = Color.New(1, 0.447, 0.0196),
  [eFairyEnum.fairyQualityType.a] = Color.New(0.7411, 0.4509, 0.9568),
  [eFairyEnum.fairyQualityType.b] = Color.New(0.2156, 0.6666, 0.945),
  [eFairyEnum.fairyQualityType.c] = Color.New(0.3137, 0.8392, 0.4784)
}

function FairyHelper.GetFairyQualitColor(quality)
  return FairyHelper.qualityColor[quality]
end

local formulaStr2FuncDic = {}

function FairyHelper.GetFairyBattlePow(fairyData)
  local pow = 0
  for _, fairySkillData in pairs(fairyData:GetFairySkillDic()) do
    local formulaStr = fairySkillData:GetFairyPowFormulaStr()
    if string.IsNullOrEmpty(formulaStr) then
      error("Cant get FairyBattlePow formula")
      pow = pow + 0
    else
      local lv = fairySkillData:GetFairySkillLevel()
      if formulaStr2FuncDic[formulaStr] == nil then
        local formulaFunc = load("return function(lv) return " .. formulaStr .. " end")()
        formulaStr2FuncDic[formulaStr] = formulaFunc
      end
      pow = pow + formulaStr2FuncDic[formulaStr](lv)
    end
  end
  return pow
end

function FairyHelper.IsSelectAllBetterSkills(orginSkillList, skillSelectList)
  local num = #skillSelectList
  local tempList = {}
  for _, fairySkillData in pairs(orginSkillList) do
    local rareLevel = fairySkillData:GetFairySkillRareLevel()
    table.insert(tempList, rareLevel)
  end
  table.sort(tempList)
  local dic = {}
  for i = 1, num do
    local rareLevel = tempList[i]
    dic[rareLevel] = (dic[rareLevel] or 0) + 1
  end
  for _, fairySkillData in ipairs(skillSelectList) do
    local rareLevel = fairySkillData:GetFairySkillRareLevel()
    if dic[rareLevel] ~= nil and 0 < dic[rareLevel] then
      dic[rareLevel] = dic[rareLevel] - 1
    else
      return false
    end
  end
  return true
end

function FairyHelper.SetFairyCountText(textItemInfo, fairyCtrl)
  local nowNum = fairyCtrl:GetFairyCount()
  local maxNum = fairyCtrl:GetFairyBagMaxNum()
  if (nowNum or 0) >= (maxNum or 0) then
    textItemInfo:SetIndex(0, tostring(nowNum), tostring(maxNum))
    return
  end
  textItemInfo:SetIndex(1, tostring(nowNum), tostring(maxNum))
end

return FairyHelper
