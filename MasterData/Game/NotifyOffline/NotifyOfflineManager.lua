local NotifyOfflineEnum = require("Game.NotifyOffline.NotifyOfflineEnum")
local NotifyOfflineFunc = require("Game.NotifyOffline.NotifyOfflineFunc")
local NotifyOfflineManager = {}
local cs_NotifyOfflineCenter = CS.NotifyOffline.NotifyOfflineCenter

function NotifyOfflineManager:InitManager()
  CS.MonoDriver.Instance:onApplicationPause("+", BindCallback(self, self.__ApplicatonPause))
end

function NotifyOfflineManager:__AddNotifyOfflineByDelaySec(delaySec, isRepeatDay, cfgTable)
  local id = cfgTable.id
  local title = LanguageUtil.GetLocaleText(cfgTable.title)
  local context = LanguageUtil.GetLocaleText(cfgTable.context)
  cs_NotifyOfflineCenter.AddNotify(id, delaySec, isRepeatDay, title, context)
end

function NotifyOfflineManager:__ApplicatonPause(flag)
  if flag then
    if PlayerDataCenter ~= nil and PlayerDataCenter.isOnline then
      local func = BindCallback(self, self.__AddNotifyOfflineByDelaySec)
      for k, v in pairs(ConfigData.offline_push) do
        NotifyOfflineFunc[v.type](v, func)
      end
    end
    local battleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
    if battleWin ~= nil then
      battleWin:TryClickBattlePause()
    end
  else
    cs_NotifyOfflineCenter.ClearNotify()
  end
end

return NotifyOfflineManager
