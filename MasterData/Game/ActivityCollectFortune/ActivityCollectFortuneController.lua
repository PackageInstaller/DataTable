local ActivityCollectFortuneController = class("ActivityCollectFortuneController", ControllerBase)
local base = ControllerBase
local ActivityCollectFortuneData = require("Game.ActivityCollectFortune.Data.ActivityCollectFortuneData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local cs_MessageCommon = CS.MessageCommon

function ActivityCollectFortuneController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_collectfortune_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_collectfortune_trad_item)
  ConfigData:LoadDynCfg(eDynConfigData.activity_collectfortune_award_pool)
  self._dataDic = {}
end

function ActivityCollectFortuneController:InitCollectFortune(msg)
  local data = ActivityCollectFortuneData.New()
  self._dataDic[msg.actId] = data
  data:InitCollectFortuneData(msg)
  return data
end

function ActivityCollectFortuneController:GetCollectFortuneDataByActId(actId)
  return self._dataDic[actId]
end

function ActivityCollectFortuneController:GetCollectFortuneData()
  for k, v in pairs(self._dataDic) do
    if v then
      return v
    end
  end
end

function ActivityCollectFortuneController:IsHaveCollectFortuneActivity()
  return table.IsEmptyTable(self._dataDic)
end

function ActivityCollectFortuneController:RemoveCollectFortune(actId)
  self._dataDic[actId] = nil
end

function ActivityCollectFortuneController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_collectfortune_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_collectfortune_trad_item)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_collectfortune_award_pool)
end

return ActivityCollectFortuneController
