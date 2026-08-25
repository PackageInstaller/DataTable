local Alert = {}
Alert.BanTopTipsGroup = {
  "Voice Starvation",
  "Source starvation"
}

local function _SetBtnFunc(funcType, funcs, funcField, cancelFunc, confirmFunc)
  if funcType then
    if 1 == funcType then
      funcs[funcField] = cancelFunc
    else
      funcs[funcField] = confirmFunc
    end
  end
end

function Alert.ShowStr(str, cancelFunc, confirmFunc, title)
  if DT.TipsType[str] then
    do return Alert.Show, str, cancelFunc, confirmFunc end
    return Alert.Show, str, cancelFunc, confirmFunc, title, nil, nil
  end
  if not confirmFunc or not cancelFunc then
    UIManager.Instance:Reopen(Urls.PopMsgPanel, str)
  else
    local rst = title or LT.Text("UniversalAlertTitle")
    Alert.Show(20001, cancelFunc, confirmFunc, rst, str)
  end
end

function Alert.ShowStrForErrCode(str, cancelFunc, confirmFunc, title)
  if DT.TipsType[str] then
    do return Alert.Show, str, cancelFunc, confirmFunc end
    return Alert.Show, str, cancelFunc, confirmFunc, title, nil, nil
  end
  if not confirmFunc and not cancelFunc then
    UIManager.Instance:Reopen(Urls.PopMsgPanel, str)
  else
    local rst = title or LT.Text("UniversalAlertTitle")
    Alert.Show(20003, cancelFunc, confirmFunc, rst, str)
  end
end

local function _CreateTipData(tipTid, title, desc, bottomDesc)
  local tipConfig = DT.TipsType[tipTid]
  local _title = tipConfig.Title and LT.Text(tipConfig.Title) or nil
  return {
    tipTid = tipTid,
    title = title or _title,
    desc = desc or LT.Text(tipConfig.Desc),
    bottomDesc = bottomDesc or tipConfig.BottomDesc and LT.Text(tipConfig.BottomDesc),
    btnLeftDesc = LT.Text(tipConfig.LeftBtnDesc),
    btnRightDesc = LT.Text(tipConfig.RightBtnDesc),
    icon = tipConfig.Icon,
    dontRemind = tipConfig.DonotRemind,
    funcs = {leftBtnFunc = nil, rightBtnFunc = nil}
  }
end

local function _ToShowAlertConfirm(tipTid, confirmFunc, cancelFunc)
  local tipConfig = DT.TipsType[tipTid]
  if tipConfig.DonotRemind then
    local dontRemind
    local record = UIPopTipsDataUtils.GetDontRemindSetting(tipTid)
    if record and record.time and record.time > 0 then
      local futureDay = tipConfig.DonotRemind or 0
      if futureDay > 0 then
        local refreshTime = TimeUtils.GetFutureTime(futureDay, TimeCfgUtils.ServerRefreshTime_2_Local(), record.time)
        dontRemind = refreshTime > TimeUtils.GetServerTime()
      else
        dontRemind = false
      end
    else
      dontRemind = false
    end
    if dontRemind and record.funcType then
      if 1 == record.funcType then
        if cancelFunc then
          cancelFunc()
        end
      elseif 2 == record.funcType and confirmFunc then
        confirmFunc()
      end
      return false
    end
  end
  return true
end

function Alert.SetShowAllLangFont(boolVal)
  Alert.showAllLangFont = boolVal
end

function Alert.SetBlankMaskBtnFunc(func)
  Alert.blankMaskBtnFunc = func
end

function Alert.SetMaskClickClose(boolVal)
  if nil == boolVal then
    return
  end
  Alert.maskClickClose = boolVal
end

function Alert.SetShowCloseBtn(boolVal)
  if nil == boolVal then
    return
  end
  Alert.showCloseBtn = boolVal
end

function Alert.ShowCoin(coins, showBg, costData)
  local alertView = UIManager.Instance:GetWindow(Urls.AlertConfirm2Panel)
  if alertView then
    alertView:ShowCoin(coins, showBg, costData)
  end
end

function Alert.ShowWithParams(tipTid, tipsParams, cancelFunc, confirmFunc)
  local tipConfig = DT.TipsType[tipTid]
  local desc
  if tipsParams then
    desc = LT.Textf(tipConfig.Desc, table.unpack(tipsParams))
  end
  Alert.Show(tipTid, cancelFunc, confirmFunc, nil, desc)
end

function Alert.ShowPayMoneyBuyConfirm(costAmount, confirmFunc)
  local tipsId = "PayMoneyBuyConfirmDescDetail"
  local title = DT.TipsType[tipsId].Title
  local payMoneyCostNum, freePayMoneyCostNum = ItemDataUtils.CalcPayMoneyCost(costAmount)
  local desc = LT.Textf(LT.Text(DT.TipsType[tipsId].Desc), costAmount, payMoneyCostNum, freePayMoneyCostNum)
  Alert.SetMaskClickClose(true)
  Alert.Show(tipsId, nil, confirmFunc, title, desc)
end

function Alert.Show(tipTid, cancelFunc, confirmFunc, title, desc, bottomDesc, useConfirm3, confirm3Params, playAnim)
  if type(tipTid) == "number" then
    tipTid = tostring(tipTid)
  end
  local tipConfig = DT.TipsType[tipTid]
  if tipConfig.Type == CommonDefine.TipsType.FeatureBottomTips then
    UIManager.Instance:Reopen(Urls.FeatureBottomTipsPanel, tipConfig.Desc)
    return
  end
  local data = _CreateTipData(tipTid, title, desc, bottomDesc)
  _SetBtnFunc(tipConfig.LeftBtn, data.funcs, "leftBtnFunc", cancelFunc, confirmFunc)
  _SetBtnFunc(tipConfig.RightBtn, data.funcs, "rightBtnFunc", cancelFunc, confirmFunc)
  data.blankMaskBtnFunc = Alert.blankMaskBtnFunc
  data.maskClickClose = Alert.maskClickClose
  data.showCloseBtn = Alert.showCloseBtn
  Alert.blankMaskBtnFunc = nil
  Alert.maskClickClose = nil
  Alert.showCloseBtn = nil
  UIPopTipsDataUtils.SetSuspend(tipConfig.Type)
  
  local function cb()
    UIPopTipsDataUtils.ClearSuspend(tipConfig.Type)
  end
  
  local panel
  if tipConfig.Type == CommonDefine.TipsType.PopMsg then
    UIManager.Instance:Reopen(Urls.PopMsgPanel, data.desc, nil, cb)
  elseif tipConfig.Type == CommonDefine.TipsType.AlertConfirm then
    if not _ToShowAlertConfirm(tipTid, confirmFunc, cancelFunc) then
      return
    end
    if useConfirm3 then
      panel = UIManager.Instance:Show(Urls.AlertConfirm3Panel, data, cb, confirm3Params, playAnim)
    else
      panel = UIManager.Instance:Show(Urls.AlertConfirm2Panel, data, cb, playAnim)
    end
  else
    Logger.Info("暂未支持Alert类型:", tipConfig.Type)
  end
  return panel
end

function Alert.ShowEx(tipTid, packParams)
  if type(tipTid) == "number" then
    tipTid = tostring(tipTid)
  end
  local cancelFunc = packParams.cancelFunc
  local confirmFunc = packParams.confirmFunc
  local closeCb = packParams.closeCb
  local title = packParams.title
  local desc = packParams.desc
  local bottomDesc = packParams.bottomDesc
  local useConfirm3 = packParams.useConfirm3
  local confirm3Params = packParams.confirm3Params
  local playAnim = packParams.playAnim
  local leftBtnTypeFunc = packParams.leftBtnTypeFunc
  local tipConfig = DT.TipsType[tipTid]
  local data = _CreateTipData(tipTid, title, desc, bottomDesc)
  _SetBtnFunc(tipConfig.LeftBtn, data.funcs, "leftBtnFunc", cancelFunc, confirmFunc)
  _SetBtnFunc(tipConfig.RightBtn, data.funcs, "rightBtnFunc", cancelFunc, confirmFunc)
  data.blankMaskBtnFunc = Alert.blankMaskBtnFunc
  data.maskClickClose = Alert.maskClickClose
  data.closeCb = closeCb
  data.leftBtnTypeFunc = leftBtnTypeFunc
  Alert.blankMaskBtnFunc = nil
  Alert.maskClickClose = nil
  UIPopTipsDataUtils.SetSuspend(tipConfig.Type)
  
  local function cb()
    UIPopTipsDataUtils.ClearSuspend(tipConfig.Type)
  end
  
  local panel
  if tipConfig.Type == CommonDefine.TipsType.PopMsg then
    UIManager.Instance:Reopen(Urls.PopMsgPanel, data.desc, nil, cb)
  elseif tipConfig.Type == CommonDefine.TipsType.AlertConfirm then
    if not _ToShowAlertConfirm(tipTid, confirmFunc, cancelFunc) then
      return
    end
    if useConfirm3 then
      panel = UIManager.Instance:Reopen(Urls.AlertConfirm3Panel, data, cb, confirm3Params, playAnim)
    else
      panel = UIManager.Instance:Reopen(Urls.AlertConfirm2Panel, data, cb, playAnim)
    end
  else
    Logger.Info("暂未支持Alert类型:", tipConfig.Type)
  end
  return panel
end

function Alert.ShowToolTips(tipTid, root, title, desc, ownText)
  local tipConfig = DT.TipsType[tipTid]
  if tipConfig.Type ~= CommonDefine.TipsType.ToolTips then
    Logger.Warn("提示语不是tooltips类型:", tipTid)
    return
  end
  local panel
  if tipConfig.Icon then
    panel = Urls.AlertIconToolTipsPanel
  else
    panel = Urls.AlertToolTipsPanel
  end
  local data = {
    tipTid = tipTid,
    title = title,
    desc = desc,
    ownText = ownText
  }
  do return UIManager.Instance.Reopen, UIManager.Instance, panel, data end
  return UIManager.Instance.Reopen, UIManager.Instance, panel, data, root
end

function Alert.ShowToolTipsByData(data, root)
  if not data then
    return
  end
  local panelUrl
  if data.iconPath and data.iconPath ~= "" then
    panelUrl = Urls.AlertIconToolTipsPanel
  else
    panelUrl = Urls.AlertToolTipsPanel
  end
  return UIManager.Instance:Reopen(panelUrl, data, root), panelUrl
end

function Alert.ShowTopTips(descOrId)
  local desc = descOrId
  if type(descOrId) == "number" then
    local tipConfig = DT.TipsType[descOrId]
    desc = tipConfig and tipConfig.Desc
  end
  if Alert.NeedNotShowTipsTips(desc) then
    return
  end
  local tipsPanel = UIManager.Instance:GetWindow(Urls.CommonFloatTipsPanel)
  if nil == tipsPanel then
    tipsPanel = UIManager.Instance:Show(Urls.CommonFloatTipsPanel)
  end
  tipsPanel:ShowCommonTips(desc)
end

function Alert.NeedNotShowTipsTips(desc)
  local rst = false
  for _, banDesc in pairs(Alert.BanTopTipsGroup) do
    if string.match(desc, banDesc) then
      rst = true
    end
  end
  return rst
end

return Alert
