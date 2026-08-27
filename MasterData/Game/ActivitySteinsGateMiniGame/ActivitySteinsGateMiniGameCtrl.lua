local ActivitySteinsGateMiniCtrl = class("ActivitySteinsGateMiniCtrl", ControllerBase)
local base = ControllerBase
local ActivitySteinsGateMiniData = require("Game.ActivitySteinsGateMiniGame.Data.ActivitySteinsGateMiniGameData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ActivitySteinsGateMiniCtrl:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_mashup_main)
  self._dataDic = {}
end

function ActivitySteinsGateMiniCtrl:AddSteinsGateMiniGame(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivitySteinsGateMiniData.New()
  self._dataDic[msg.actId] = data
  data:InitSteinsGateMiniGameData(msg)
end

function ActivitySteinsGateMiniCtrl:UpdateSteinsGateMiniGame(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateSteinsGateMiniGameData(msg)
end

function ActivitySteinsGateMiniCtrl:RemoveUpdateSteinsGateMiniGame(actId)
  self._dataDic[actId] = nil
end

function ActivitySteinsGateMiniCtrl:IsHaveSteinsGateMiniGame()
  return table.count(self._dataDic) > 0
end

function ActivitySteinsGateMiniCtrl:GetSteinsGateMiniGameData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivitySteinsGateMiniCtrl:GetSteinsGateMiniGameDataByActId(actId)
  return self._dataDic[actId]
end

function ActivitySteinsGateMiniCtrl:GetSteinsGateMiniGameDataByFrameId(actFrameId)
  for k, data in pairs(self._dataDic) do
    if data:GetActFrameId() == actFrameId then
      return data
    end
  end
  return nil
end

function ActivitySteinsGateMiniCtrl:TryOpenSteinsGateMiniGame(actId, callback)
  if actId == nil then
    return false
  end
  local sgMiniGameData = self:GetSteinsGateMiniGameDataByActId(actId)
  if sgMiniGameData == nil then
    return false
  end
  local win = UIManager:GetWindow(UIWindowTypeID.ActivitySteinsGateMiniGameMain)
  if win ~= nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivitySteinsGateMiniGameMain, function(win)
    if sgMiniGameData == nil or not sgMiniGameData:IsActivityOpen() then
      UIUtil.ReturnHome()
      return
    end
    if win == nil then
      return
    end
    win:InitActSGMiniGame(actId, callback)
  end)
end

function ActivitySteinsGateMiniCtrl:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_mashup_main)
end

return ActivitySteinsGateMiniCtrl
