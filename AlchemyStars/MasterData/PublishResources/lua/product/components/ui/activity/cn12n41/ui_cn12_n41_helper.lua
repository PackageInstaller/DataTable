_class("UICN12N41Helper", Object)
UICN12N41Helper = UICN12N41Helper

function UICN12N41Helper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N12
end

function UICN12N41Helper.GetComponentId(name)
  local tb = {
    login = ECampaignCN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN,
    power = ECampaignCN12ComponentID.ECAMPAIGN_N12_POWER2ITEM,
    line = ECampaignCN12ComponentID.ECAMPAIGN_N12_LINE_MISSION,
    hard = ECampaignCN12ComponentID.ECAMPAIGN_N12_DIFFICULT_MISSION,
    exchange = ECampaignCN12ComponentID.ECAMPAIGN_N12_SHOP,
    share = ECampaignCN12ComponentID.ECAMPAIGN_N12_SHARED,
    black = ECampaignCN12ComponentID.ECAMPAIGN_N12_HEIXIA
  }
  return tb[name]
end

function UICN12N41Helper.GetComponent(campaign, name)
  local cmptId = UICN12N41Helper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  return component
end

function UICN12N41Helper.GetComponentInfo(campaign, name)
  local cmptId = UICN12N41Helper.GetComponentId(name)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return componentInfo
end

function UICN12N41Helper.CheckCampaignTimeState(campaign)
  local tb = {
    [1] = {type = 1},
    [2] = {
      type = 2,
      cmptId = UICN12N41Helper.GetComponentId("hard")
    },
    [3] = {
      type = 2,
      cmptId = UICN12N41Helper.GetComponentId("black")
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

function UICN12N41Helper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
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

function UICN12N41Helper.SetExchangeBtn(uiView, widgetName, campaign, componentId, closeCallback)
  local name = "exchange"
  local component = UICN12N41Helper.GetComponent(campaign, name)
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = not UICN12N41Helper.LocalDB_Has(name, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(component.m_component_info.m_component_id) and campaign:CheckComponentRed(component.m_component_info.m_component_id)
  end
  
  obj:SetRed("_red", redCallback)
  local color1, color2 = "#FAF0E2", "#FAF0E2"
  UICN12N41Helper.SetExchangeCostItem_PreZero(component, obj, "icon", "text", color1, color2)
  UIWidgetHelper.SetRawImage(obj, "icon", "toptoon_3000356")
  
  local function clickCallback()
    UICN12N41Helper.LocalDB_Set(name, "New")
    if campaign:CheckCampaignClose_ShowClientError() then
      return
    end
    UIActivityHelper.OpenCampaignShop(campaign)
  end
  
  obj:SetData(campaign, clickCallback)
end

function UICN12N41Helper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    count = math.min(count, 9999999)
    local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
    local str = UIActivityHelper.GetColorText(color1, preZero, color2, tostring(count))
    return str
  end)
end

function UICN12N41Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UICN12N41Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UICN12N41Helper.LocalDB_Has(btnName, funcName)
  local key = UICN12N41Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UICN12N41Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UICN12N41Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UICN12N41Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UICN12N41Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UICN12N41Helper.LocalDB_Delete(btnName, funcName)
  local key = UICN12N41Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end

function UICN12N41Helper.LocalDB_Get_CrossDay(btnName, funcName)
  local lastTime = UICN12N41Helper.LocalDB_Get(btnName, funcName)
  Log.debug("UICN12N41Helper.LocalDB_Get_CrossDay() btnName =", btnName, ", funcName =", funcName, ", lastTime =", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  return isCross
end

function UICN12N41Helper.LocalDB_Set_CrossDay(btnName, funcName)
  local value = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UICN12N41Helper.LocalDB_Set(btnName, funcName, value)
end

function UICN12N41Helper.CalcNew(campaign)
  local new = false
  local tb = {
    "login",
    "line",
    "hard",
    "exchange",
    "black"
  }
  for _, v in ipairs(tb) do
    local n = UICN12N41Helper.CalcNew_Component(campaign, v)
    new = new or n
  end
  return new
end

function UICN12N41Helper.CalcRed(campaign)
  local red = false
  local tb = {
    "login",
    "line",
    "hard",
    "exchange",
    "black"
  }
  for _, v in ipairs(tb) do
    local n = UICN12N41Helper.CalcRed_Component(campaign, v)
    red = red or n
  end
  return red
end

function UICN12N41Helper.CalcNew_Component(campaign, name)
  local component = UICN12N41Helper.GetComponent(campaign, name)
  local isOpen = component and component:ComponentIsOpen()
  local isNew = not UICN12N41Helper.LocalDB_Has(name, "New")
  return isOpen and isNew
end

function UICN12N41Helper.CalcRed_Component(campaign, name)
  local component = UICN12N41Helper.GetComponent(campaign, name)
  local red = component and component:HaveRedPoint()
  local tb = {
    line = true,
    hard = true,
    black = true
  }
  local checkCrossDay = tb[name]
  if not checkCrossDay then
    return red
  end
  if name == "black" then
    if component:ComponentIsOpen() then
      red = UICN12N41Helper.CalcBlackRed_Component(component, name)
    else
      red = false
    end
  end
  local isCross = UICN12N41Helper.LocalDB_Get_CrossDay(name, "Red")
  return isCross and red
end

function UICN12N41Helper.CalcBlackRed_Component(component, name)
  local red = true
  local completeInfo = component:GetComponentInfo().infos
  if completeInfo ~= nil then
    local array = {}
    for key, value in pairs(completeInfo) do
      table.insert(array, {key = key, value = value})
    end
    table.sort(array, function(a, b)
      return a.key < b.key
    end)
    if #array == 3 then
      local lastItem = array[#array]
      if lastItem.value ~= nil then
        local status = lastItem.value.status
        red = status ~= 1
      end
    end
  end
  return red
end
