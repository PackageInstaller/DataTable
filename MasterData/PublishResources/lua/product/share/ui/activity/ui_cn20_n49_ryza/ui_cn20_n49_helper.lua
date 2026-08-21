_class("UICN20N49Helper", Object)
UICN20N49Helper = UICN20N49Helper

function UICN20N49Helper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N20
end

function UICN20N49Helper.GetComponentId(name)
  local tb = {
    login = ECampaignCN20ComponentID.ECN20_CUMULATIVE_LOGIN,
    line = ECampaignCN20ComponentID.ECN20_LINE_MISSION,
    talent = ECampaignCN20ComponentID.ECN20_LINE_MISSION_TALEN,
    tree = ECampaignCN20ComponentID.ECN20_TALENT_TREE,
    exchange = ECampaignCN20ComponentID.ECN20_SHOP,
    power = ECampaignCN20ComponentID.ECN20_POWER2ITEM,
    actionPoint = ECampaignCN20ComponentID.ECN20_ACTION_POINT,
    alchemy = ECampaignCN20ComponentID.ECN20_ALCHEMY,
    alchemyShop = ECampaignCN20ComponentID.ECN20_PERSON_PROGRESS,
    share = ECampaignCN20ComponentID.ECN20_SHARED
  }
  return tb[name]
end

function UICN20N49Helper.GetComponent(campaign, name)
  local cmptId = UICN20N49Helper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  return component
end

function UICN20N49Helper.GetComponentInfo(campaign, name)
  local cmptId = UICN20N49Helper.GetComponentId(name)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return componentInfo
end

function UICN20N49Helper.CheckCampaignTimeState(campaign)
  local tb = {
    [1] = {type = 1},
    [2] = {
      type = 2,
      cmptId = UICN20N49Helper.GetComponentId("talent")
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

function UICN20N49Helper.CheckContainTalentTreeCost(campaign, itemList)
  local allContainsCost = {}
  local treeComponent = UICN20N49Helper.GetComponent(campaign, "tree")
  local allCanCostLevel = treeComponent:GetAllCanCostLevelItemCount()
  for _, itemInfo in ipairs(itemList) do
    if allCanCostLevel[itemInfo[1]] ~= nil then
      for _, item in pairs(allCanCostLevel[itemInfo[1]]) do
        table.insert(allContainsCost, item)
      end
    end
  end
  return allContainsCost
end

function UICN20N49Helper.GetTalentTreeAllCost(campaign)
  local costList = {}
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = UICN20N49Helper.GetComponent(campaign, "tree"):GetComponentCfgId()
  })
  for i, cfg in ipairs(cfgs) do
    if cfg.CostItemId ~= 0 and not table.icontains(costList, cfg.CostItemId) then
      table.insert(costList, cfg.CostItemId)
    end
  end
  return costList
end

function UICN20N49Helper.GetActionPointCount()
  local actionPointItemId = 8800006
  local itemModule = GameGlobal.GetModule(ItemModule)
  return itemModule:GetItemCount(actionPointItemId)
end

function UICN20N49Helper.GetComponentInfo(campaign, name)
  local cmptId = UICN20N49Helper.GetComponentId(name)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return componentInfo
end

function UICN20N49Helper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
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

function UICN20N49Helper.SetExchangeBtn(uiView, widgetName, campaign, componentId, closeCallback)
  local name = "exchange"
  local component = UICN20N49Helper.GetComponent(campaign, name)
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  
  local function newCallback()
    local new = not UICN20N49Helper.LocalDB_Has(name, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(component.m_component_info.m_component_id) and campaign:CheckComponentRed(component.m_component_info.m_component_id)
  end
  
  obj:SetRed("_red", redCallback)
  local color1, color2 = "#F5DB9A", "#F5DB9A"
  UICN20N49Helper.SetExchangeCostItem_PreZero(component, obj, "icon", "text", color1, color2)
  
  local function clickCallback()
    UICN20N49Helper.LocalDB_Set(name, "New")
    if campaign:CheckCampaignClose_ShowClientError() then
      return
    end
    UIActivityHelper.OpenCampaignShop(campaign)
  end
  
  obj:SetData(campaign, clickCallback)
  return obj
end

function UICN20N49Helper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetImageSprite(uiView, widgeIcon, "UICommon.spriteatlas", "toptoon_8800005")
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    count = math.min(count, 999999)
    local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
    local str = UIActivityHelper.GetColorText(color1, preZero, color2, tostring(count))
    return str
  end)
end

function UICN20N49Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UICN20N49Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UICN20N49Helper.LocalDB_Has(btnName, funcName)
  local key = UICN20N49Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UICN20N49Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UICN20N49Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UICN20N49Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UICN20N49Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UICN20N49Helper.LocalDB_Delete(btnName, funcName)
  local key = UICN20N49Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end

function UICN20N49Helper.LocalDB_Get_CrossDay(btnName, funcName)
  local lastTime = UICN20N49Helper.LocalDB_Get(btnName, funcName)
  Log.debug("UICN20N49Helper.LocalDB_Get_CrossDay() btnName =", btnName, ", funcName =", funcName, ", lastTime =", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  return isCross
end

function UICN20N49Helper.LocalDB_Set_CrossDay(btnName, funcName)
  local value = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UICN20N49Helper.LocalDB_Set(btnName, funcName, value)
end

function UICN20N49Helper.CalcNew(campaign)
  local new = false
  local tb = {
    "login",
    "line",
    "talent",
    "exchange",
    "power",
    "actionPoint",
    "alchemy",
    "alchemyShop"
  }
  for _, v in ipairs(tb) do
    local n = UICN20N49Helper.CalcNew_Component(campaign, v)
    new = new or n
  end
  return new
end

function UICN20N49Helper.CalcRed(campaign)
  local red = false
  local tb = {
    "login",
    "line",
    "talent",
    "exchange",
    "power",
    "actionPoint",
    "alchemy",
    "alchemyShop"
  }
  for _, v in ipairs(tb) do
    local n = UICN20N49Helper.CalcRed_Component(campaign, v)
    red = red or n
  end
  return red
end

function UICN20N49Helper.CalcNew_Component(campaign, name)
  local component = UICN20N49Helper.GetComponent(campaign, name)
  local isOpen = component and component:ComponentIsOpen()
  local isNew = not UICN20N49Helper.LocalDB_Has(name, "New")
  return isOpen and isNew
end

function UICN20N49Helper.CalcRed_Component(campaign, name)
  local component = UICN20N49Helper.GetComponent(campaign, name)
  local red = component and component:HaveRedPoint()
  if name == "talent" then
    local action_component = UICN20N49Helper.GetComponent(campaign, "actionPoint")
    local talent_component = UICN20N49Helper.GetComponent(campaign, "talent")
    return action_component:GetItemCount() > 0 and not talent_component:ComponentIsClose()
  end
  local tb = {line = true}
  local checkCrossDay = tb[name]
  if not checkCrossDay then
    return red
  end
  local key = UICN20N49Helper._LocalDB_GetKey(name, "Red")
  local isCross = not UIActivityHelper.HasCmptRedViewed(key)
  return isCross and red
end
