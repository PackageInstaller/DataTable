local System = require("System.System")
local Logger = require("Utility.Logger")
local DataCenter = require("Data.DataCenter")
local PlayerDataUtils = require("Data.PlayerDataUtils")
local AwakerDataUtils = require("Data.AwakerDataUtils")
local Urls = require("Managers.UI.Urls")
local UIManager = require("Managers.UI.UIManager")
local ProtoManager = require("Net.ProtoManager")
local Alert = require("System.Alert")
local WorldStageComp = require("Managers.WorldStage.Comp.WorldStageComp")
local DBGTeamDataUtils = require("Data.DBGTeamDataUtils")
local DT = require("System.DataTable")
local LT = require("System.LangTable")
local EventMgr = require("Managers.EventManager.EventMgr")
local WorldWeekStageComp = System.NewClass("WorldWeekStageComp", WorldStageComp)
local TeamAssignDataUtils = require("Data.TeamAssignDataUtils")

function WorldWeekStageComp:EnterWorldStage(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnWeekChallenge", function(copyData)
    if callback then
      callback()
    end
    self:HandleEnterWorldData(copyData)
  end, function(data, errcode)
    Logger.Error(string.format("WorldWeekStageComp进入副本失败:%s errcode:%s", table.tostring(data or {}), table.tostring(errcode or {})))
  end, self.stageData.stageId)
end

function WorldWeekStageComp:ShowTeamPanel()
  local cost = self.stageCfg.Cost
  if cost > PlayerDataUtils.GetEnergy() then
    PlayerDataUtils.ShowEnergyRestorePanel()
    return
  end
  local callfunc = System.fn(self, self.OnTeamReady)
  local panelData = TeamAssignDataUtils.GetTeamBuildPanelDataByStageCfg(self.stageCfg, callfunc)
  self:ProcessForbidden(panelData)
  DBGTeamDataUtils.EnterDBGTeamPanel(panelData)
end

function WorldWeekStageComp:ProcessForbidden(data)
  local forbidden = {}
  local usedAwaker = DataCenter.copyData.weekStage[self.stageData.groupId].usedAwaker
  if usedAwaker then
    for k, v in pairs(usedAwaker) do
      if v ~= self.stageData.stageId then
        table.insert(forbidden, k)
        for k1, v1 in pairs(data.teamAwakerTids) do
          if v1 == k then
            data.teamAwakerTids[k1] = 0
          end
        end
      end
    end
  end
  data.forbidden = forbidden
end

function WorldWeekStageComp:OnTeamReady(teamIdx, tAwakerTids, callback)
  local function confirm()
    self.teamIdx = teamIdx
    
    self.tAwakerTids = tAwakerTids
    self:EnterWorldStage(callback)
  end
  
  Alert.Show(20056, nil, confirm, nil, LT.Textf(DT.TipsType[20056].Desc, DT.StageGroup[self.stageData.groupId].Name))
end

return WorldWeekStageComp
