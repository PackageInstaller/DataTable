_class("UICN17N46Helper", Object)
UICN17N46Helper = UICN17N46Helper

function UICN17N46Helper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N17
end

function UICN17N46Helper.GetComponentId(name)
  local tb = {
    login = ECampaignCN17ComponentID.ECAMPAIGN_N17_CUMULATIVE_LOGIN,
    power = ECampaignCN17ComponentID.ECAMPAIGN_N17_POWER2ITEM,
    line = ECampaignCN17ComponentID.ECAMPAIGN_N17_LINE_MISSION,
    exchange = ECampaignCN17ComponentID.ECAMPAIGN_N17_SHOP,
    share = ECampaignCN17ComponentID.ECAMPAIGN_N17_SHARED,
    black = ECampaignCN17ComponentID.ECAMPAIGN_N17_HEIXIA
  }
  return tb[name]
end

function UICN17N46Helper.GetComponent(campaign, name)
  local cmptId = UICN17N46Helper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  return component
end

function UICN17N46Helper.GetComponentInfo(campaign, name)
  local cmptId = UICN17N46Helper.GetComponentId(name)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return componentInfo
end

function UICN17N46Helper.CheckCampaignTimeState(campaign)
  local tb = {
    [1] = {type = 1},
    [2] = {
      type = 2,
      cmptId = UICN17N46Helper.GetComponentId("black")
    }
  }
  local pass = 0
  for i, v in ipairs(tb) do
    if v.type == 1 then
      pass = i
    elseif v.type == 2 then
      local component = campaign:GetComponent(v.cmptId)
      pass = component:ComponentIsOpen() and i or pass
    end
  end
  return pass
end

function UICN17N46Helper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
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

function UICN17N46Helper.SetExchangeBtn(uiView, widgetName, campaign, anim)
  local name = "exchange"
  local component = UICN17N46Helper.GetComponent(campaign, name)
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = not UICN17N46Helper.LocalDB_Has(name, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(component.m_component_info.m_component_id) and campaign:CheckComponentRed(component.m_component_info.m_component_id)
  end
  
  obj:SetRed("_red", redCallback)
  local color1, color2 = "#FAF0E2", "#FAF0E2"
  UICN17N46Helper.SetExchangeCostItem_PreZero(component, obj, "icon", "text", color1, color2)
  UIWidgetHelper.SetRawImage(obj, "icon", "toptoon_3000374")
  
  local function clickCallback()
    UICN17N46Helper.LocalDB_Set(name, "New")
    if campaign:CheckCampaignClose_ShowClientError() then
      return
    end
    UIActivityHelper.OpenCampaignShop(campaign)
  end
  
  obj:SetData(campaign, clickCallback)
  if anim then
    local animCom = obj:GetUIComponent("Animation", "anim")
    animCom:Stop()
    animCom:Play("uieffanim_UICN17N46_ExchangeBtn")
  end
end

function UICN17N46Helper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    return count
  end)
end

function UICN17N46Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UICN17N46Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UICN17N46Helper.LocalDB_Has(btnName, funcName)
  local key = UICN17N46Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UICN17N46Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UICN17N46Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UICN17N46Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UICN17N46Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UICN17N46Helper.LocalDB_Delete(btnName, funcName)
  local key = UICN17N46Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end

function UICN17N46Helper.LocalDB_Get_CrossDay(btnName, funcName)
  local lastTime = UICN17N46Helper.LocalDB_Get(btnName, funcName)
  Log.debug("UICN17N46Helper.LocalDB_Get_CrossDay() btnName =", btnName, ", funcName =", funcName, ", lastTime =", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  return isCross
end

function UICN17N46Helper.LocalDB_Set_CrossDay(btnName, funcName)
  local value = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UICN17N46Helper.LocalDB_Set(btnName, funcName, value)
end

function UICN17N46Helper.CalcNew(campaign)
  local new = false
  local tb = {
    "login",
    "line",
    "black",
    "exchange"
  }
  for _, v in ipairs(tb) do
    local n = UICN17N46Helper.CalcNew_Component(campaign, v)
    new = new or n
  end
  return new
end

function UICN17N46Helper.CalcRed(campaign)
  local red = false
  local tb = {
    "login",
    "line",
    "black",
    "exchange"
  }
  for _, v in ipairs(tb) do
    local n = UICN17N46Helper.CalcRed_Component(campaign, v)
    red = red or n
  end
  return red
end

function UICN17N46Helper.CalcNew_Component(campaign, name)
  local component = UICN17N46Helper.GetComponent(campaign, name)
  local isOpen = component and component:ComponentIsOpen()
  local isNew = not UICN17N46Helper.LocalDB_Has(name, "New")
  return isOpen and isNew
end

function UICN17N46Helper.CalcRed_Component(campaign, name)
  local component = UICN17N46Helper.GetComponent(campaign, name)
  local red = component and component:HaveRedPoint()
  local tb = {line = true, black = true}
  local checkCrossDay = tb[name]
  if not checkCrossDay then
    return red
  end
  local key = UICN17N46Helper._LocalDB_GetKey(name, "Red")
  local isCross = not UIActivityHelper.HasCmptRedViewed(key)
  return isCross and red
end

function UICN17N46Helper.CalcBlackRed_Component(component, name)
  local red = false
  local completeInfo = component:GetComponentInfo().infos
  if completeInfo ~= nil then
    local array = {}
    for key, value in pairs(completeInfo) do
      table.insert(array, {key = key, value = value})
    end
    table.sort(array, function(a, b)
      return a.key < b.key
    end)
    if next(array) then
      local lastItem = array[#array]
      if lastItem.value ~= nil then
        local status = lastItem.value.status
        red = status ~= 1
      end
    end
  end
  return red
end
