_class("UINExploreHelper", Object)
UINExploreHelper = UINExploreHelper

function UINExploreHelper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_MAIN_MISSION
end

function UINExploreHelper.GetComponentId(name)
  local tb = {
    login = ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_CUMULATIVE_LOGIN,
    power = ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_POWER2ITEM,
    exchange = ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_SHOP,
    share = ECampaignMainMissionComponentID.ECAMPAIGN__MAIN_MISSION_SHARED
  }
  return tb[name]
end

function UINExploreHelper.GetComponent(campaign, name)
  local cmptId = UINExploreHelper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UINExploreHelper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
  local useStateUI = false
  local open_sample = bp_campaign:CheckCampaignOpen()
  if open_sample then
    local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonCampaignEnter")
    obj:SetData(bp_campaign, useStateUI)
  end
  local obj = uiView:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UINExploreHelper.SetExchangeBtn(uiView, widgetName, campaign)
  local name = "exchange"
  local cmptId, component, componentInfo = UINExploreHelper.GetComponent(campaign, name)
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = not UINExploreHelper.LocalDB_Has(name, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(cmptId) and campaign:CheckComponentRed(cmptId)
  end
  
  obj:SetRed("_red", redCallback)
  local color1, color2 = "#71a29c", "#ffffff"
  UINExploreHelper.SetExchangeCostItem_PreZero(component, obj, "icon", "text", color1, color2)
  
  local function clickCallback()
    UINExploreHelper.LocalDB_Set(name, "New")
    if campaign:CheckCampaignClose_ShowClientError() then
      return
    end
    UIActivityHelper.OpenCampaignShop(campaign)
  end
  
  obj:SetData(campaign, clickCallback)
end

function UINExploreHelper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetItemIcon(uiView, itemId, widgeIcon)
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    count = math.min(count, 999999)
    local preZero = UIActivityHelper.GetZeroStrFrontNum(6, count)
    local str = UIActivityHelper.GetColorText(color1, preZero, color2, tostring(count))
    return str
  end)
end

function UINExploreHelper._LocalDB_GetKey(btnName, funcName)
  local key = "UINExploreHelper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UINExploreHelper.LocalDB_Has(btnName, funcName)
  local key = UINExploreHelper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UINExploreHelper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UINExploreHelper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UINExploreHelper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UINExploreHelper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UINExploreHelper.LocalDB_Delete(btnName, funcName)
  local key = UINExploreHelper._LocalDB_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end

function UINExploreHelper.LocalDB_Get_CrossDay(btnName, funcName)
  local lastTime = UINExploreHelper.LocalDB_Get(btnName, funcName)
  Log.debug("UINExploreHelper.LocalDB_Get_CrossDay() btnName =", btnName, ", funcName =", funcName, ", lastTime =", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  return isCross
end

function UINExploreHelper.LocalDB_Set_CrossDay(btnName, funcName)
  local value = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UINExploreHelper.LocalDB_Set(btnName, funcName, value)
end

function UINExploreHelper.CalcNew(campaign)
  local new = false
  local tb = {
    "login",
    "power",
    "exchange",
    "share"
  }
  for _, v in ipairs(tb) do
    local n = UINExploreHelper.CalcNew_Component(campaign, v)
    new = new or n
  end
  return new
end

function UINExploreHelper.CalcRed(campaign)
  local red = false
  local tb = {
    "login",
    "power",
    "exchange",
    "share"
  }
  for _, v in ipairs(tb) do
    local n = UINExploreHelper.CalcRed_Component(campaign, v)
    red = red or n
  end
  return red
end

function UINExploreHelper.CalcNew_Component(campaign, name)
  local cmptId, component, componentInfo = UINExploreHelper.GetComponent(campaign, name)
  local isOpen = component and component:ComponentIsOpen()
  local isNew = not UINExploreHelper.LocalDB_Has(name, "New")
  return isOpen and isNew
end

function UINExploreHelper.CalcRed_Component(campaign, name)
  local cmptId, component, componentInfo = UINExploreHelper.GetComponent(campaign, name)
  local isOpen = component and component:ComponentIsOpen()
  if not isOpen then
    return isOpen
  end
  local red = component:HaveRedPoint()
  local tb = {}
  local checkCrossDay = tb[name]
  if not checkCrossDay then
    return red
  end
  local isCross = UINExploreHelper.LocalDB_Get_CrossDay(name, "Red")
  return isCross and red
end
