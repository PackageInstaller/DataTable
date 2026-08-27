local WarChessDeployTeamData = class("WarChessDeployTeamData")

function WarChessDeployTeamData:ctor(index, fmtData)
  self.__index = index
  self.__fmtData = fmtData
  self.__teamName = nil
  self.__bornPoint = nil
  self.__firstHeroData = nil
  self.__teamPower = nil
  self.__isFixedTeam = false
  self.__inheritTeamIndex = nil
  self:RefreshFmtData()
end

function WarChessDeployTeamData:RefreshFmtData()
  self:__RefreshFirstHeroId()
  self.__teamName = self.__fmtData.name
  if string.IsNullOrEmpty(self.__teamName) then
    self.__teamName = string.format(ConfigData:GetTipContent(TipContent.WarChess_TeamDefaultName), tostring(self.__index))
  end
end

function WarChessDeployTeamData:GetFirstHeroData()
  return self.__firstHeroData
end

function WarChessDeployTeamData:SetInheritTeamIndex(inheritTeamIndex)
  self.__inheritTeamIndex = inheritTeamIndex
end

function WarChessDeployTeamData:GetInheritTeamIndex()
  return self.__inheritTeamIndex
end

function WarChessDeployTeamData:GetFmtId()
  return self.__fmtData.id
end

function WarChessDeployTeamData:GetFmtCSTId()
  local savingData = self.__fmtData:GetFmtCSTData()
  return savingData.id
end

function WarChessDeployTeamData:SetDTeamIsFixedTeam(bool)
  self.__isFixedTeam = bool
end

function WarChessDeployTeamData:GetDTeamIsFixedTeam()
  return self.__isFixedTeam
end

function WarChessDeployTeamData:SetBornPoint(bornPoint)
  self.__bornPoint = bornPoint
end

function WarChessDeployTeamData:GetBornPoint()
  return self.__bornPoint
end

function WarChessDeployTeamData:GetIsDeploied()
  return self:GetBornPoint() ~= nil
end

function WarChessDeployTeamData:GetDTeamIndex()
  return self.__index
end

function WarChessDeployTeamData:GetDTeamHeroData(index)
  return self.__fmtData:GetFormationHeroData(index)
end

function WarChessDeployTeamData:GetDTeamHeroDic()
  return self.__fmtData:GetFormationHeroDic(false)
end

function WarChessDeployTeamData:SetDTeamTeamPower(power)
  self.__teamPower = power
end

function WarChessDeployTeamData:GetDTeamTeamPower()
  return self.__teamPower
end

function WarChessDeployTeamData:GetDTeamName()
  return self.__teamName
end

function WarChessDeployTeamData:GetTeamMemberHeroDataList()
  local heroDataList = {}
  for i = 1, ConfigData.formation_rule[0].stage_num do
    local heroData = self.__fmtData:GetFormationHeroData(i)
    table.insert(heroDataList, heroData)
  end
  return heroDataList
end

function WarChessDeployTeamData:__RefreshFirstHeroId()
  for i = 1, ConfigData.formation_rule[0].stage_num do
    local heroData = self.__fmtData:GetFormationHeroData(i)
    if heroData ~= nil then
      self.__firstHeroData = heroData
      return
    end
  end
  self.__firstHeroData = nil
end

function WarChessDeployTeamData:GetWcDTeamFmtData()
  return self.__fmtData
end

function WarChessDeployTeamData:GetOfficeAssistData()
  return self.__fmtData:GetFmtOfficeAssistData()
end

function WarChessDeployTeamData:GetWCFairyUID()
  return self.__fmtData:GetFmtFairyUID()
end

function WarChessDeployTeamData:GetFmtFairyData()
  return self.__fmtData:GetFmtFairyData()
end

function WarChessDeployTeamData:SetDTeamIsDead(bool)
  self.__isDead = bool
end

function WarChessDeployTeamData:GetDTeamIsDead()
  return self.__isDead
end

return WarChessDeployTeamData
