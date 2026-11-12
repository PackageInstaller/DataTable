local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local PureAvgPanel = class("PureAvgPanel", BasePanel)
PureAvgPanel._bAddToBackHistory = false
PureAvgPanel._tbDefine = {
  {
    sPrefabPath = "Avg/PureAvgUI.prefab",
    sCtrlName = "Game.UI.Avg.PureAvgCtrl"
  }
}

function PureAvgPanel:LoadData(sType)
  local sJson = LocalData.GetPlayerLocalData("PlayedAvgNodeId")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.tbNodeId = tb
  end
  if (self.tbNodeId[tostring(self.mapData.nNodeId)] or {})[sType] then
    local callback = self.mapData.callback
    if callback then
      callback()
    end
  else
    EventManager.Add("StoryDialog_DialogEnd", self, self.OnEvent_StoryDialog_DialogEnd)
    if not self.tbNodeId[tostring(self.mapData.nNodeId)] then
      self.tbNodeId[tostring(self.mapData.nNodeId)] = {}
    end
    self.tbNodeId[tostring(self.mapData.nNodeId)][sType] = true
    LocalData.SetPlayerLocalData("PlayedAvgNodeId", RapidJson.encode(self.tbNodeId))
    EventManager.Hit("StoryDialog_DialogStart", self.mapData.sAvgId, Settings.sCurrentTxtLanguage, Settings.sCurrentVoLanguage, self.mapData.sGroupId)
  end
end

function PureAvgPanel:Awake()
  self.tbNodeId = {}
  self.mapData = self._tbParam[1]
  if not self.mapData then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      PanelManager.Home()
    end
    
    cs_coroutine.start(wait)
  elseif type(self.mapData.sGroupId) ~= "string" then
    self.mapData.sGroupId = nil
  elseif self.mapData.sGroupId == "" then
    self.mapData.sGroupId = nil
  end
end

function PureAvgPanel:OnEnable()
  if self.mapData.nType == AllEnum.StoryAvgType.Preview then
    EventManager.Add("StoryDialog_DialogEnd", self, self.OnEvent_StoryDialog_DialogEnd)
    EventManager.Hit("StoryDialog_DialogStart", self.mapData.sAvgId, Settings.sCurrentTxtLanguage, Settings.sCurrentVoLanguage, self.mapData.sGroupId)
  elseif self.mapData.nType == AllEnum.StoryAvgType.PureAvg then
    EventManager.Add("StoryDialog_DialogEnd", self, self.OnEvent_StoryDialog_DialogEnd)
    EventManager.Hit("StoryDialog_DialogStart", self.mapData.sAvgId, Settings.sCurrentTxtLanguage, Settings.sCurrentVoLanguage, self.mapData.sGroupId)
  elseif self.mapData.nType == AllEnum.StoryAvgType.BeforeBattle then
    self:LoadData("Before")
  elseif self.mapData.nType == AllEnum.StoryAvgType.AfterBattle then
    self:LoadData("After")
  elseif self.mapData.nType == AllEnum.StoryAvgType.Plot then
    EventManager.Add("StoryDialog_DialogEnd", self, self.OnEvent_StoryDialog_DialogEnd)
    EventManager.Hit("StoryDialog_DialogStart", self.mapData.sAvgId, Settings.sCurrentTxtLanguage, Settings.sCurrentVoLanguage, self.mapData.sGroupId)
  end
end

function PureAvgPanel:OnDisable()
end

function PureAvgPanel:OnDestroy()
end

function PureAvgPanel:OnEvent_StoryDialog_DialogEnd()
  if self.mapData.nType == AllEnum.StoryAvgType.PureAvg then
    EventManager.Hit("LevelStateChanged", true, true)
  elseif self.mapData.nType == AllEnum.StoryAvgType.BeforeBattle or self.mapData.nType == AllEnum.StoryAvgType.AfterBattle then
    local callback = self.mapData.callback
    if callback then
      callback()
    end
  elseif self.mapData.nType == AllEnum.StoryAvgType.Preview then
    EventManager.Hit(EventId.CloesCurPanel)
  elseif self.mapData.nType == AllEnum.StoryAvgType.Plot then
    local callback = self.mapData.callback
    if callback then
      callback()
    end
  end
  EventManager.Remove("StoryDialog_DialogEnd", self, self.OnEvent_StoryDialog_DialogEnd)
end

return PureAvgPanel
