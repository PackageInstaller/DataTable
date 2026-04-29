_class("UICN21N50Helper", Object)
UICN21N50Helper = UICN21N50Helper

function UICN21N50Helper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N21
end

function UICN21N50Helper.GetComponentId(name)
  local tb = {
    login = ECampaignCN21ComponentID.ECN21_CUMULATIVE_LOGIN,
    power = ECampaignCN21ComponentID.ECN21_POWER2ITEM,
    line = ECampaignCN21ComponentID.ECN21_LINE_MISSION,
    black = ECampaignCN21ComponentID.ECN21_HEIXIA,
    share = ECampaignCN21ComponentID.ECN21_SHARED,
    exchange = ECampaignCN21ComponentID.ECN21_SHOP
  }
  return tb[name]
end

function UICN21N50Helper.GetComponent(campaign, name)
  local cmptId = UICN21N50Helper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  return component
end

function UICN21N50Helper.GetComponentInfo(campaign, name)
  local cmptId = UICN21N50Helper.GetComponentId(name)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return componentInfo
end

function UICN21N50Helper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
  local useStateUI = false
  local open_sample = bp_campaign:CheckCampaignOpen()
  if open_sample then
    local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonCampaignEnter")
    
    local function clickCallback()
      UIActivityBattlePassHelper.OpenMainController()
    end
    
    obj:SetData(bp_campaign, useStateUI, clickCallback)
  end
  local obj = uiView:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UICN21N50Helper.SetExchangeBtn(uiView, widgetName, campaign, componentId, closeCallback)
  local name = "exchange"
  local component = UICN21N50Helper.GetComponent(campaign, name)
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = not UICN21N50Helper.LocalDB_Has(name, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(component.m_component_info.m_component_id) and campaign:CheckComponentRed(component.m_component_info.m_component_id)
  end
  
  obj:SetRed("_red", redCallback)
  local color1, color2 = "#fc95bd", "#FFFFFF"
  UICN21N50Helper.SetExchangeCostItem_PreZero(component, obj, "icon", "text", color1, color2)
  UIWidgetHelper.SetRawImage(obj, "icon", "toptoon_3000381")
  
  local function clickCallback()
    UICN21N50Helper.LocalDB_Set(name, "New")
    if campaign:CheckCampaignClose_ShowClientError() then
      return
    end
    UIActivityHelper.OpenCampaignShop(campaign)
  end
  
  obj:SetData(campaign, clickCallback)
  return obj
end

function UICN21N50Helper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    count = math.min(count, 9999999)
    local preZero = UIActivityHelper.GetZeroStrFrontNum(6, count)
    local str = UIActivityHelper.GetColorText(color1, preZero, color2, tostring(count))
    return str
  end)
end

function UICN21N50Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UICN21N50Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UICN21N50Helper.LocalDB_Has(btnName, funcName)
  local key = UICN21N50Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UICN21N50Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UICN21N50Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UICN21N50Helper.CalcNew_Component(campaign, name)
  local component = UICN21N50Helper.GetComponent(campaign, name)
  local isOpen = component and component:ComponentIsOpen()
  local isNew = not UICN21N50Helper.LocalDB_Has(name, "New")
  return isOpen and isNew
end

function UICN21N50Helper.CalcRed_Component(campaign, name)
  local component = UICN21N50Helper.GetComponent(campaign, name)
  local red = component and component:HaveRedPoint()
  local tb = {line = true, black = true}
  local checkCrossDay = tb[name]
  if not checkCrossDay then
    return red
  end
  local key = UICN21N50Helper._LocalDB_GetKey(name, "Red")
  local isCross = not UIActivityHelper.HasCmptRedViewed(key)
  return isCross and red
end
