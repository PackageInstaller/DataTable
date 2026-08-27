local VirtualFormationData = class("VirtualFormationData")
local FormationData = require("Game.PlayerData.FormationData")

function VirtualFormationData:ctor(treeId, specialRuleGenerator, isUseGlobalCSTSavingData)
  if treeId == nil or ConfigData.commander_skill[treeId] == nil then
    treeId = 1
  end
  self.formation = FormationData.FromCustomData(0, {}, treeId, {})
  if isUseGlobalCSTSavingData then
    self.formation.commandTrees = PlayerDataCenter.globalTreeSavingData
  end
  self.formation.isVirtualFormation = true
  self.formation.specialRuleGenerator = specialRuleGenerator
  self.buffIds = {}
end

function VirtualFormationData:TryRestoreFormation(weeklyFmt)
  if weeklyFmt == nil then
    weeklyFmt = {}
  else
    for k, lastHeroid in pairs(weeklyFmt) do
      if not table.contain(self.formation.specialRuleGenerator.specialRuler.heroIds, lastHeroid) then
        weeklyFmt = {}
        break
      end
    end
  end
  self.formation:CleanFormation()
  for index, heroId in pairs(weeklyFmt) do
    self.formation:SetHero2Formation(index, heroId)
  end
end

function VirtualFormationData:SetFormation(formation)
  self.formation.data = formation
end

function VirtualFormationData:SetBuffList(buffIds)
  self.buffIds = buffIds
end

function VirtualFormationData:VirtualFmtSetCst(cstDataList, selectedTreeId)
  self.formation:ModifyCSTData(cstDataList, selectedTreeId)
end

function VirtualFormationData:GetVirFmtCSTDatDic()
  return self.formation:GetFmtCSTDatDic()
end

function VirtualFormationData:GetCstTreeId()
  return self.formation:GetFmtCSTDataCurId()
end

function VirtualFormationData:GetVirFmtCstData()
  return self.formation:GetFmtCSTData()
end

function VirtualFormationData:GetVirFmtFairyData()
  return self.formation:GetFmtFairyData()
end

return VirtualFormationData
