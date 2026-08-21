_class("UIReviewActivityBase", Object)
UIReviewActivityBase = UIReviewActivityBase

function UIReviewActivityBase:Constructor(id, obj, idx)
  self._id = id
  self._idx = idx
  self._camg_cfg = Cfg.cfg_campaign[self._id]
  if not self._camg_cfg then
    ReviewError("找不到回顾活动配置:", self._id)
  end
  self:UpdateCampaignObj(obj)
end

function UIReviewActivityBase:UpdateCampaignObj(obj)
  self._campObj = obj
end

function UIReviewActivityBase:ReqDetailInfo(TT, res)
  if not self:IsUnlock() then
    ReviewError("回顾活动没有解锁，不能获取详细信息")
  end
  self._campaign = UIActivityCampaign:New()
  res = res or AsyncRequestRes:New()
  self._campaign:LoadCampaignInfo(TT, res, self:ActivityType())
  self._campaign:ReLoadCampaignInfo_Force(TT, res, self:ActivityType())
  if res:GetSucc() then
    return self._campaign
  else
    self._campaign = nil
    return nil
  end
end

function UIReviewActivityBase:ClearDetailInfo()
  self._campaign = nil
end

function UIReviewActivityBase:AssetPackageID()
  ReviewError(self._className .. "未重写AssetPackageID()方法：", debug.traceback())
end

function UIReviewActivityBase:ActivityOnOpen()
  ReviewError(self._className .. "未重写ActivityOnOpen()方法：", debug.traceback())
end

function UIReviewActivityBase:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  ReviewError(self._className .. "未重写GetBattleExitParam()方法：", debug.traceback())
end

function UIReviewActivityBase:ActivityID()
  return self._id
end

function UIReviewActivityBase:Index()
  return self._idx
end

function UIReviewActivityBase:ActivityType()
  if self:IsUnlock() then
    return self._campObj:GetSampleInfo().camp_type
  end
end

function UIReviewActivityBase:Title()
  return StringTable.Get(self._camg_cfg.CampaignName)
end

function UIReviewActivityBase:HasRedPoint()
  if self:IsUnlock() then
    return self._campObj:GetSampleInfo():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
  end
  return false
end

function UIReviewActivityBase:CanUnlock()
  if self:IsUnlock() then
    return false
  end
  if self:IsOpen() then
    local asset = self:UnlockCost()
    local have = GameGlobal.GetModule(ItemModule):GetItemCount(asset.assetid)
    return have >= asset.count
  end
  return false
end

function UIReviewActivityBase:UnlockCost()
  local cfg = Cfg.cfg_campaign[self:ActivityID()]
  if cfg.CostItem == nil or #cfg.CostItem == 0 then
    ReviewError("回顾活动配置错误，必须有解锁消耗CostItem:", self:ActivityID())
  end
  local id = cfg.CostItem[1][1]
  local count = cfg.CostItem[1][2]
  return NewRoleAsset(id, count)
end

function UIReviewActivityBase:IsUnlock()
  return self._campObj ~= nil
end

function UIReviewActivityBase:IsDownloaded()
  if EDITOR or not APPVER1110 then
    return true
  end
  return not HotUpdate.ActivityLuaProxy.HasDownloadList(self:AssetPackageID())
end

function UIReviewActivityBase:IsFinished()
  if self:IsUnlock() then
    return self:ProgressPercent() >= 100 and not self:HasRedPoint()
  end
  return false
end

function UIReviewActivityBase:IsOpen()
  local openTime
  if self._campObj then
    openTime = self._campObj:GetSampleInfo().begin_time
  else
    openTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(self._camg_cfg.BeginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  end
  return openTime <= GetSvrTimeNow()
end

function UIReviewActivityBase:ProgressPercent()
  if self:IsUnlock() then
    return self._campObj:GetSampleInfo().m_extend_info[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_POINT_PROGRESS]
  end
end

function UIReviewActivityBase:GetDetailInfo()
  return self._campaign
end

function UIReviewActivityBase:Download()
  local packageID = self:AssetPackageID()
  if HotUpdate.ActivityLuaProxy.IsDownloaderBusy() then
    local curID = HotUpdate.ActivityLuaProxy.CurrProcessingActivityID()
    if curID == packageID then
      ToastManager.ShowToast(StringTable.Get("str_review_tip1"))
    else
      ToastManager.ShowToast(StringTable.Get("str_review_tip2"))
    end
    return
  end
  HotUpdate.ActivityLuaProxy.AddListener(function(callbackType, activityId, unityActionCallBack)
    if callbackType == HotUpdate.ActivityDownloaderCallbackType.DownloadError or callbackType == HotUpdate.ActivityDownloaderCallbackType.FatalError then
      ToastManager.ShowToast(StringTable.Get("str_review_tip6"))
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIReviewOnDownloadStateChanged, packageID)
      ReviewError("下载活动包失败：", packageID)
    elseif callbackType == HotUpdate.ActivityDownloaderCallbackType.Finish then
      ToastManager.ShowToast(StringTable.Get("str_review_tip3", self:Title()))
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIReviewOnDownloadStateChanged, packageID)
      Log.debug("下载活动包完成:", packageID)
    elseif callbackType == HotUpdate.ActivityDownloaderCallbackType.SpaceNotEnough then
      ToastManager.ShowToast(StringTable.Get("str_review_tip4"))
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIReviewOnDownloadStateChanged, packageID)
      ReviewError("下载活动包失败，磁盘空间不足:", packageID)
    elseif callbackType == HotUpdate.ActivityDownloaderCallbackType.NotUseWifi then
      ToastManager.ShowToast(StringTable.Get("str_review_tip5"))
      Log.debug("使用4G下载活动包:", packageID)
      unityActionCallBack:DynamicInvoke(true)
    end
  end)
  Log.debug("开始下载活动资源包:", packageID)
  HotUpdate.ActivityLuaProxy.StartDownload(packageID)
end

function UIReviewActivityBase:IsDownLoading()
  return HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() == self:AssetPackageID()
end

function UIReviewActivityBase:DownloadProgress()
  if self:IsDownLoading() then
    return HotUpdate.ActivityLuaProxy.GetProgress()
  end
end

function UIReviewActivityBase:DownloadPackageSize()
  local size = HotUpdate.ActivityLuaProxy.GetTotalSize(self:AssetPackageID())
  return tonumber(size)
end

function UIReviewActivityBase:DownloadedSize()
  if self:IsDownLoading() then
    return HotUpdate.ActivityLuaProxy.GetDownloadedSize()
  end
end
