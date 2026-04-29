_class("UIActivityErrorHelper", Object)
UIActivityErrorHelper = UIActivityErrorHelper

function UIActivityErrorHelper.CheckErrorCode(result, campaignId, refreshCallback, closeCallback)
  Log.info("UIActivityErrorHelper.CheckErrorCode(), result =", result)
  UIActivityErrorHelper.ShowErrorToast(result, true)
  if refreshCallback and UIActivityErrorHelper.IsErrorNeedRefresh(result) then
    refreshCallback()
  end
  if closeCallback and UIActivityErrorHelper.IsErrorNeedClose(result) then
    closeCallback()
  end
  if campaignId and UIActivityErrorHelper.IsErrorNeedCloseAll(result) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, campaignId)
  end
end

function UIActivityErrorHelper.ShowErrorToast(result, hideErrorId)
  local strId = "str_activity_error_" .. result
  local errorStr = StringTable.Get(strId)
  local noStr = "ERR:" .. strId
  if errorStr ~= noStr then
    local formatStr = hideErrorId and "%s" or "%s [%s]"
    local msg = string.format(formatStr, errorStr, result)
    ToastManager.ShowToast(msg)
  end
end

function UIActivityErrorHelper.IsErrorNeedRefresh(result)
  if not CampaignModule.ErrorRefreshList then
    local temp = {
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CONFIG_CHANGE,
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_Cross_Day,
      CampaignErrorType.E_EXCHANGEITEM_COMPONENT_NOT_FOUND_ITEM,
      CampaignErrorType.E_EXCHANGEITEM_COMPONENT_ITEM_LOCK,
      CampaignErrorType.E_EXCHANGEITEM_COMPONENT_EXCHANGE_LIMIT,
      CampaignErrorType.E_EXCHANGEITEM_COMPONENT_COST_ITEM_NOT_ENOUGH,
      CampaignErrorType.E_COMPONENT_CUMULATIVE_LOGIN_ERROR_DAY,
      CampaignErrorType.E_COMPONENT_CUMULATIVE_LOGIN_DAY_NO_OPEN,
      CampaignErrorType.E_COMPONENT_CUMULATIVE_LOGIN_RECEIVED,
      CampaignErrorType.E_COMPONENT_CUMULATIVE_LOGIN_EXPIRED,
      CampaignErrorType.E_COMPONENT_PersonProgress_Not_Exist_Progress,
      CampaignErrorType.E_COMPONENT_PersonProgress_Reward_Received,
      CampaignErrorType.E_COMPONENT_PersonProgress_Not_Reach_Progress,
      CampaignErrorType.E_COMPONENT_STORY_IS_RECVED,
      CampaignErrorType.E_COMPONENT_STORY_CAM_POINT_NOT_ENOUGH,
      CampaignErrorType.E_COMPONENT_LOTTERY_COST_ITEM_NOT_ENOUGH,
      CampaignErrorType.E_COMPONENT_LOTTERY_JACKPOT_LOTTERY_COUNT_NOT_ENOUGH,
      CampaignErrorType.E_COMPONENT_LOTTERY_JACKPOT_LOCK,
      CampaignErrorType.E_COMPONENT_LOTTERY_EXPEND_ITEM_ERROR,
      CampaignErrorType.E_COMPONENT_LOTTERY_ADD_REWARD_ERROR
    }
    CampaignModule.ErrorRefreshList = table.reverse(temp)
  end
  return CampaignModule.ErrorRefreshList[result] ~= nil
end

function UIActivityErrorHelper.IsErrorNeedClose(result)
  if not CampaignModule.ErrorCloseList then
    local temp = {
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR,
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_ID_ERROR,
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CONFIG_ERROR,
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK,
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NOT_COMPLETE,
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE
    }
    CampaignModule.ErrorCloseList = table.reverse(temp)
  end
  return CampaignModule.ErrorCloseList[result] ~= nil
end

function UIActivityErrorHelper.IsErrorNeedCloseAll(result)
  if not CampaignModule.ErrorCloseAllList then
    local temp = {
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED,
      CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    }
    CampaignModule.ErrorCloseAllList = table.reverse(temp)
  end
  return CampaignModule.ErrorCloseAllList[result] ~= nil
end
