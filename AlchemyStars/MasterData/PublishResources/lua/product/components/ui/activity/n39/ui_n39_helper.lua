_class("UIN39Helper", Object)
UIN39Helper = UIN39Helper

function UIN39Helper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N39
end

function UIN39Helper.GetComponentIds()
  return {
    ECampaignN39ComponentID.ECAMPAIGN_N39_CUMULATIVE_LOGIN,
    ECampaignN39ComponentID.ECAMPAIGN_N39_LINE_MISSION,
    ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION,
    ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION,
    ECampaignN39ComponentID.ECAMPAIGN_N39_POWER2ITEM,
    ECampaignN39ComponentID.ECAMPAIGN_N39_SHOP
  }
end

function UIN39Helper.GetComponentId(name)
  local tb = {
    login = ECampaignN39ComponentID.ECAMPAIGN_N39_CUMULATIVE_LOGIN,
    line = ECampaignN39ComponentID.ECAMPAIGN_N39_LINE_MISSION,
    hard = ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION,
    black = ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION,
    power = ECampaignN39ComponentID.ECAMPAIGN_N39_POWER2ITEM,
    exchange = ECampaignN39ComponentID.ECAMPAIGN_N39_SHOP
  }
  return tb[name]
end

function UIN39Helper.CheckComRedTime(tag)
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local key = "n39_red_time" .. tag .. open_id
  local val = LocalDB.GetInt(key, 0)
  if val == 0 then
    return true
  else
    local svrTime = math.modf(GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001)
    if UIN39Helper.IsSameDay(svrTime, val) then
      return true
    else
      return false
    end
  end
end

function UIN39Helper.SetComRedTime(tag)
  if UIN39Helper.CheckComRedTime(tag) then
    local open_id = GameGlobal.GameLogic():GetOpenId()
    local key = "n39_red_time" .. tag .. open_id
    local svrTime = math.modf(GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001)
    LocalDB.SetInt(key, svrTime)
  end
end

function UIN39Helper.IsSameDay(svrTime, localTime)
  if 86400 <= svrTime - localTime then
    return true
  else
    local next_zero_time = GameGlobal.GetModule(LoginModule):GetGMTNextZeroTime()
    local hourOffset = 5
    next_zero_time = next_zero_time + (hourOffset - 24) * 60 * 60
    if svrTime > next_zero_time then
      if localTime < next_zero_time then
        return true
      else
        return false
      end
    else
      return false
    end
  end
end

function UIN39Helper.CheckNew(tag)
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local key = "n39" .. tag .. open_id
  local val = LocalDB.GetInt(key, 0)
  return val == 0
end

function UIN39Helper.ClearNew(tag)
  local isNew = UIN39Helper.CheckNew(tag)
  if isNew then
    local open_id = GameGlobal.GameLogic():GetOpenId()
    local key = "n39" .. tag .. open_id
    LocalDB.SetInt(key, 1)
  end
end

function UIN39Helper.GetComponent(campaign, name)
  local cmptId = UIN39Helper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UIN39Helper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
  local useStateUI = false
  local open_sample = bp_campaign:CheckCampaignOpen()
  if open_sample then
    local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonCampaignEnter")
    obj:SetData(bp_campaign, useStateUI)
  end
  local obj = uiView:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UIN39Helper.SetExchangeBtn(uiView, widgetName, campaign)
  local cmptId, component, componentInfo = UIN39Helper.GetComponent(campaign, "exchange")
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  local btnName = "ExchangeBtn"
  
  local function newCallback()
    local new = not UIN39Helper.LocalDB_Has(btnName, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(cmptId) and campaign:CheckComponentRed(cmptId)
  end
  
  obj:SetRed("_red", redCallback)
  local color1, color2 = "#71a29c", "#ffffff"
  UIN39Helper.SetExchangeCostItem_PreZero(component, obj, "icon", "text", color1, color2)
  
  local function clickCallback()
    if UIN39Helper.CheckCampaignOpen(campaign) then
      UIN39Helper.LocalDB_Set(btnName, "New")
      GameGlobal.UIStateManager():ShowDialog("UIN39ExchangeController")
    end
  end
  
  obj:SetData(campaign, clickCallback)
end

function UIN39Helper.CheckCampaignOpen(campaign)
  local open_sample = campaign:CheckCampaignOpen()
  if open_sample then
    return true
  else
    local tips = StringTable.Get("str_activity_common_notice_content")
    ToastManager.ShowToast(tips)
    return false
  end
end

function UIN39Helper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    count = math.min(count, 999999)
    local preZero = UIActivityHelper.GetZeroStrFrontNum(6, count)
    local str = UIActivityHelper.GetColorText(color1, preZero, color2, tostring(count))
    return str
  end)
end

function UIN39Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UIN39Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UIN39Helper.LocalDB_Has(btnName, funcName)
  local key = UIN39Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UIN39Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UIN39Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UIN39Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UIN39Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UIN39Helper.LocalDB_Delete(btnName, funcName)
  local key = UIN39Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end
