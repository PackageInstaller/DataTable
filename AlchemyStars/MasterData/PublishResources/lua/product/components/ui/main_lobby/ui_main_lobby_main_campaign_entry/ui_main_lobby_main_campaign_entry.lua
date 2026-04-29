_class("UIMainLobbyMainCampaignEntry", UICustomWidget)
UIMainLobbyMainCampaignEntry = UIMainLobbyMainCampaignEntry

function UIMainLobbyMainCampaignEntry:Constructor()
  self._clsObjName = nil
end

function UIMainLobbyMainCampaignEntry:OnShow()
  self._entryLoader = self:GetUIComponent("UISelectObjectPath", "EntryLoader")
end

function UIMainLobbyMainCampaignEntry:OnHide()
end

function UIMainLobbyMainCampaignEntry:SetData(latestCampObj, controller)
  if latestCampObj then
    local sampleInfo = latestCampObj:GetSampleInfo()
    local campConfig = Cfg.cfg_campaign[sampleInfo.id]
    if campConfig and campConfig.EntranceIcon and table.count(campConfig.EntranceIcon) >= 3 then
      local entryPrefab = campConfig.EntranceIcon[2]
      local entryClass = campConfig.EntranceIcon[3]
      if entryPrefab and entryClass then
        if self._clsObjName == entryClass then
        else
          self._entryLoader:ClearWidgets()
        end
        self._clsObjName = entryClass
        self._entryLoader.dynamicInfoOfEngine:SetObjectName(entryPrefab)
        self._main_campaign = self._entryLoader:SpawnObject(entryClass)
        if not self._main_campaign then
          Log.fatal("UIMainLobbyMainCampaignEntry SpawnObject is null ,entryClas = ", entryClass)
          return
        end
        if not self._main_campaign.SetData then
          Log.fatal("UIMainLobbyMainCampaignEntry , entry no SetData Method,  entryClas = ", entryClass)
          return
        end
        self._main_campaign:SetData(sampleInfo, controller)
        return true
      end
    end
    self._entryLoader:ClearWidgets()
    Log.fatal("###[UIMainLobbyMainCampaignEntry] 新版主界面入口，需要每个活动自己单独做，该活动配置错误，id:", sampleInfo.id)
  else
    self._entryLoader:ClearWidgets()
    Log.fatal("###[UIMainLobbyMainCampaignEntry] 当前没有主活动，这种情况基本不会出现吧。。")
  end
end

function UIMainLobbyMainCampaignEntry:RefreshCampSampleInfo(latestCampObj, controller)
  self:SetData(latestCampObj, controller)
end
