_class("UIN43Helper", Object)
UIN43Helper = UIN43Helper

function UIN43Helper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N43
end

function UIN43Helper.GetComponentId(name)
  local tb = {
    login = ECampaignN43ComponentID.ECAMPAIGN_N43_CUMULATIVE_LOGIN,
    power = ECampaignN43ComponentID.ECAMPAIGN_N43_POWER2ITEM,
    exchange = ECampaignN43ComponentID.ECAMPAIGN_N43_SHOP
  }
  return tb[name]
end

function UIN43Helper.GetComponent(campaign, name)
  local cmptId = UIN43Helper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UIN43Helper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
  local useStateUI = false
  local open_sample = bp_campaign:CheckCampaignOpen()
  if open_sample then
    local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonCampaignEnter")
    obj:SetData(bp_campaign, useStateUI)
  end
  local obj = uiView:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UIN43Helper.SetExchangeBtn(uiView, widgetName, campaign)
  local name = "exchange"
  local cmptId, component, componentInfo = UIN43Helper.GetComponent(campaign, name)
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = not UIN43Helper.LocalDB_Has(name, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(cmptId) and campaign:CheckComponentRed(cmptId)
  end
  
  obj:SetRed("_red", redCallback)
  local color1, color2 = "#fff1e3", "#fff1e3"
  UIN43Helper.SetExchangeCostItem_PreZero(component, obj, "icon", "text", color1, color2)
  
  local function clickCallback()
    UIN43Helper.LocalDB_Set(name, "New")
    if campaign:CheckCampaignClose_ShowClientError() then
      return
    end
    UIActivityHelper.OpenCampaignShop(campaign)
  end
  
  obj:SetData(campaign, clickCallback)
end

function UIN43Helper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetItemIcon(uiView, itemId, widgeIcon)
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    count = math.min(count, 999999)
    local preZero = UIActivityHelper.GetZeroStrFrontNum(6, count)
    local str = UIActivityHelper.GetColorText(color1, preZero, color2, tostring(count))
    return str
  end)
end

function UIN43Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UIN43Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UIN43Helper.LocalDB_Has(btnName, funcName)
  local key = UIN43Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UIN43Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UIN43Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UIN43Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UIN43Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UIN43Helper.LocalDB_Delete(btnName, funcName)
  local key = UIN43Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end

function UIN43Helper.LocalDB_Get_CrossDay(btnName, funcName)
  local lastTime = UIN43Helper.LocalDB_Get(btnName, funcName)
  Log.debug("UIN43Helper.LocalDB_Get_CrossDay() btnName =", btnName, ", funcName =", funcName, ", lastTime =", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  return isCross
end

function UIN43Helper.LocalDB_Set_CrossDay(btnName, funcName)
  local value = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UIN43Helper.LocalDB_Set(btnName, funcName, value)
end

function UIN43Helper.CalcNew(campaign)
  local new = false
  local tb = {
    "login",
    "power",
    "exchange"
  }
  for _, v in ipairs(tb) do
    local n = UIN43Helper.CalcNew_Component(campaign, v)
    new = new or n
  end
  return new
end

function UIN43Helper.CalcRed(campaign)
  local red = false
  local tb = {
    "login",
    "power",
    "exchange"
  }
  for _, v in ipairs(tb) do
    local n = UIN43Helper.CalcRed_Component(campaign, v)
    red = red or n
  end
  return red
end

function UIN43Helper.CalcNew_Component(campaign, name)
  local cmptId, component, componentInfo = UIN43Helper.GetComponent(campaign, name)
  local isOpen = component and component:ComponentIsOpen()
  local isNew = not UIN43Helper.LocalDB_Has(name, "New")
  return isOpen and isNew
end

function UIN43Helper.CalcRed_Component(campaign, name)
  local cmptId, component, componentInfo = UIN43Helper.GetComponent(campaign, name)
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
  local isCross = UIN43Helper.LocalDB_Get_CrossDay(name, "Red")
  return isCross and red
end
