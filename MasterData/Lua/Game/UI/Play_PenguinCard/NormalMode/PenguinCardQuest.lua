local PenguinCardQuest = class("PenguinCardQuest")
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")

function PenguinCardQuest:ctor(nId)
  self:Clear()
  self:Init(nId)
end

function PenguinCardQuest:Clear()
  self.nId = nil
  self.nLevel = nil
  self.nTurnLimit = nil
  self.nBuffGroup = nil
  self.nType = nil
  self.tbParam = nil
  self.sDesc = nil
  self.nTurnCount = nil
  self.nAimCount = nil
  self.nMaxAim = nil
  self.nBuffId = nil
end

function PenguinCardQuest:Init(nId)
  self.nId = nId
  self:ParseConfigData(nId)
end

function PenguinCardQuest:ParseConfigData(nId)
  local mapCfg = ConfigTable.GetData("PenguinCardQuest", nId)
  if nil == mapCfg then
    return
  end
  self.nLevel = mapCfg.Level
  self.nTurnLimit = mapCfg.TurnLimit
  self.nBuffGroup = mapCfg.BuffGroup
  self.nType = mapCfg.Type
  self.tbParam = {}
  for i = 1, 4 do
    table.insert(self.tbParam, mapCfg["Param" .. i])
  end
  self.sDesc = self:SetDesc(mapCfg)
  self.nTurnCount = 0
  self.nAimCount = 0
  self.nMaxAim = self.tbParam[1]
  self:CreateBuffId()
end

function PenguinCardQuest:SetDesc(mapCfg)
  local function ParseParam(tbParam, nIndex)
    if nIndex == 0 then
      return self.nTurnLimit
    end
    local nParam = tbParam[nIndex]
    if self.nType == GameEnum.PenguinCardQuestType.SuitCount and nIndex == 2 then
      return PenguinCardUtils.SuitName[nParam]
    elseif self.nType == GameEnum.PenguinCardQuestType.HandRank and nIndex == 2 then
      local mapHandRankCfg = ConfigTable.GetData("PenguinCardHandRank", nParam)
      if mapHandRankCfg then
        return mapHandRankCfg.Title
      end
    end
    return nParam
  end
  
  local result = string.gsub(mapCfg.Desc, "%b{}", function(token)
    local content = string.match(token, "^{(.-)}$")
    local sParameterKey, lang, langIdx = ParseLanguageParam(content)
    if lang ~= nil then
      token = string.format("{%s}", sParameterKey)
    end
    local trigIdx = string.match(token, "^{(%d+)}$")
    if trigIdx then
      local idx = tonumber(trigIdx)
      local str = ParseParam(self.tbParam, idx)
      str = LanguagePost(lang, langIdx, str)
      return str
    end
    return token
  end)
  return result
end

function PenguinCardQuest:CreateBuffId()
  local mapCfg = ConfigTable.GetData("PenguinCardBuffWeight", self.nBuffGroup)
  if not mapCfg then
    return
  end
  local tbBuffId = PenguinCardUtils.WeightedRandom(mapCfg.BuffList, mapCfg.Weight, 1)
  self.nBuffId = tbBuffId[1]
end

function PenguinCardQuest:AddTurnCount()
  self.nTurnCount = self.nTurnCount + 1
end

function PenguinCardQuest:AddProgress(nType, mapData)
  if nType ~= self.nType then
    return
  end
  if self.nType == GameEnum.PenguinCardQuestType.Score then
    self:ChangeAimCount(mapData.nCount)
  elseif self.nType == GameEnum.PenguinCardQuestType.HandRank then
    local nAimId = self.tbParam[2]
    if mapData.nId == nAimId then
      self:ChangeAimCount(mapData.nCount)
    end
  elseif self.nType == GameEnum.PenguinCardQuestType.SuitCount then
    local nAimId = self.tbParam[2]
    if mapData.nId == nAimId then
      self:ChangeAimCount(mapData.nCount)
    end
  end
end

function PenguinCardQuest:ChangeAimCount(nChange)
  local nBefore = self.nAimCount
  self.nAimCount = self.nAimCount + nChange
  if NovaAPI.IsEditorPlatform() and nBefore ~= self.nAimCount then
    printLog("任务进度变化：" .. "  " .. self.nAimCount .. "/" .. self.nMaxAim)
  end
  EventManager.Hit("PenguinCard_ChangeQuestProcess", nChange)
end

function PenguinCardQuest:CheckExpired()
  return self.nTurnCount >= self.nTurnLimit
end

function PenguinCardQuest:CheckComplete()
  return self.nAimCount >= self.nMaxAim
end

function PenguinCardQuest:Serialize()
  return {
    nId = self.nId,
    nTurnCount = self.nTurnCount,
    nAimCount = self.nAimCount,
    nBuffId = self.nBuffId
  }
end

function PenguinCardQuest:Deserialize(mapData)
  self:Init(mapData.nId)
  self.nTurnCount = mapData.nTurnCount
  self.nAimCount = mapData.nAimCount
  self.nBuffId = mapData.nBuffId
end

return PenguinCardQuest
