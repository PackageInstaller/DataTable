_class("UIN37Helper", Object)
UIN37Helper = UIN37Helper

function UIN37Helper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N37
end

function UIN37Helper.GetComponentId(name)
  local tb = {
    login = ECampaignN37ComponentID.ECAMPAIGN_N37_CUMULATIVE_LOGIN,
    line = ECampaignN37ComponentID.ECAMPAIGN_N37_LINE_MISSION,
    hard = ECampaignN37ComponentID.ECAMPAIGN_N37_HARD_LINE_MISSION,
    black = ECampaignN37ComponentID.ECAMPAIGN_N37_BLACK_DIFFICULT_MISSION,
    power = ECampaignN37ComponentID.ECAMPAIGN_N37_POWER2ITEM,
    exchange = ECampaignN37ComponentID.ECAMPAIGN_N37_SHOP,
    trun = ECampaignN37ComponentID.ECAMPAIGN_N37_TURNCARD,
    quest = ECampaignN37ComponentID.ECAMPAIGN_N37_QUEST
  }
  return tb[name]
end

function UIN37Helper.GetComponent(campaign, name)
  local cmptId = UIN37Helper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UIN37Helper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
  local useStateUI = false
  local open_sample = bp_campaign:CheckCampaignOpen()
  if open_sample then
    local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonCampaignEnter")
    obj:SetData(bp_campaign, useStateUI)
  end
  local obj = uiView:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UIN37Helper.SetExchangeBtn(uiView, widgetName, campaign)
  local cmptId, component, componentInfo = UIN37Helper.GetComponent(campaign, "exchange")
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  local btnName = "ExchangeBtn"
  
  local function newCallback()
    local new = not UIN37Helper.LocalDB_Has(btnName, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(cmptId) and campaign:CheckComponentRed(cmptId)
  end
  
  obj:SetRed("_red", redCallback)
  local color1, color2 = "#71a29c", "#ffffff"
  UIN37Helper.SetExchangeCostItem_PreZero(component, obj, "icon", "text", color1, color2)
  
  local function clickCallback()
    UIN37Helper.LocalDB_Set(btnName, "New")
    GameGlobal.UIStateManager():ShowDialog("UIN37ExchangeController")
  end
  
  obj:SetData(campaign, clickCallback)
end

function UIN37Helper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetItemIcon(uiView, itemId, widgeIcon)
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    count = math.min(count, 999999)
    local preZero = UIActivityHelper.GetZeroStrFrontNum(6, count)
    local str = UIActivityHelper.GetColorText(color1, preZero, color2, tostring(count))
    return str
  end)
end

function UIN37Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UIN37Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UIN37Helper.LocalDB_Has(btnName, funcName)
  local key = UIN37Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UIN37Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UIN37Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UIN37Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UIN37Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UIN37Helper.LocalDB_Delete(btnName, funcName)
  local key = UIN37Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end
