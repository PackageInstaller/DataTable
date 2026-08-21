_class("UISideEnterBtnConst", Object)
UISideEnterBtnConst = UISideEnterBtnConst

function UISideEnterBtnConst:Constructor()
end

function UISideEnterBtnConst._GetObj_Safe(className)
  local baseName = "UIActivityDataLoaderBase"
  local desc = "cfg_main_side_enter_btn[CheckType] 中配置的 "
  if UILogHelper.Exception_CheckClassFromBase(desc, className, baseName) then
    local obj = _createInstance(className)
    return obj
  end
end

function UISideEnterBtnConst.CheckOpen(TT, btnCfg)
  local checkTypes = btnCfg.CheckType or {}
  for _, v in ipairs(checkTypes) do
    local func = UISideEnterBtnCheckFunc.GetFunc(v)
    local isOpen = func(TT, btnCfg)
    if not isOpen then
      return false
    end
  end
  return true
end

function UISideEnterBtnConst.ForceOpenUI(btnCfg)
  local tb = btnCfg and btnCfg.ForceOpenUI or {}
  if table.count(tb) < 2 then
    return
  end
  local useStateUI = tb[1] == "[state]" and true or false
  local uiName = tb[2]
  if uiName == "[campaign_default]" then
    return UISideEnterBtnConst.ForceOpenUI_Campaign(btnCfg, useStateUI)
  end
  local params = {}
  for i = 3, #tb do
    table.insert(params, tb[i])
  end
  if useStateUI then
    return function()
      GameGlobal.UIStateManager():SwitchState(uiName, table.unpack(params))
    end
  else
    return function()
      GameGlobal.UIStateManager():ShowDialog(uiName, table.unpack(params))
    end
  end
end

function UISideEnterBtnConst.ForceOpenUI_Campaign(btnCfg, useStateUI)
  local campaignType, campaignId = btnCfg.CampaignType, btnCfg.CampaignId
  local campaign = UIActivityHelper.LoadCampaign_Local(campaignType, campaignId)
  return function()
    UIActivityHelper.PlayFirstPlot_Campaign(campaign, function()
      campaign:OpenMainUI(useStateUI)
    end, true)
  end
end
