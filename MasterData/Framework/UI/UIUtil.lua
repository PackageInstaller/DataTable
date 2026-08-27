UIUtil = {}
local cst_LuaBinding = typeof(CS.XLua.Binding.LuaBinding)
local cs_Material = CS.UnityEngine.Material
local cs_Application = CS.UnityEngine.Application
local Stack = require("Framework.Lib.Stack")
local _cacheResIds
local _cacheIsSetNoBackData = false
UIUtil.GlobalHideTopStatus = false
UIUtil.GlobalIsBlockEsc = false
local TopStatusData = require("Game.TopStatus.TopStatusData")
local TopStatusDataPool = CommonPool.New(function(uiTab)
  return TopStatusData.New(uiTab)
end, function(p)
  p:ResetTopStatusData()
  return true
end)
local TempStackPool = CommonPool.New(function()
  return Stack.New()
end, function(stack)
  stack:Clear()
  return true
end)
UIUtil.GetResAddFuncDic = {
  [ConstGlobalItem.SKey] = function()
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    local quickPurchaseWin = UIManager:GetWindow(UIWindowTypeID.QuickBuyKey)
    if (quickPurchaseWin == nil or quickPurchaseWin.active == false or quickPurchaseWin.isSlideOuting) and shopCtrl:GetIsUnlock() then
      return function()
        local JumpManager = require("Game.Jump.JumpManager")
        JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
      end
    end
  end
}
UIUtil.GetResAddFuncDicByActionType = {
  [eItemActionType.QuickBuy] = function(itemCfg)
    if #itemCfg.arg ~= 2 then
      error("itemCfg.arg error, itemId:" .. tostring(itemCfg.id))
      return
    end
    local shopId = itemCfg.arg[1]
    local shelfId = itemCfg.arg[2]
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    shopCtrl:GetIsUnlock()
    if shopCtrl:GetIsUnlock() then
      return function()
        local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
        ctrl:GetShopData(shopId, function(shopData)
          local goodData = shopData.shopGoodsDic[shelfId]
          UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
            if win == nil then
              error("can't open QuickBuy win")
              return
            end
            win:SlideIn()
            win:InitBuyTarget(goodData, nil, true, {
              ConstGlobalItem.PaidItem,
              ConstGlobalItem.PaidSubItem
            })
            win:OnClickAdd(true)
          end)
        end)
      end
    end
  end
}

function UIUtil.GetItemResAddFunc(itemId)
  if UIUtil.GetResAddFuncDic[itemId] ~= nil then
    return UIUtil.GetResAddFuncDic[itemId]()
  end
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("cant get itemCfg, itemId:" .. tostring(itemId))
    return
  end
  if UIUtil.GetResAddFuncDicByActionType[itemCfg.action_type] ~= nil then
    return UIUtil.GetResAddFuncDicByActionType[itemCfg.action_type](itemCfg)
  end
end

function UIUtil.AddButtonListener(btn, tbl, callback)
  if tbl == nil then
    btn.onClick:AddListener(callback)
    return
  end
  local onClick = BindCallback(tbl, callback)
  btn.onClick:AddListener(onClick)
end

function UIUtil.RemoveButtonListener(btn)
  btn.onClick:RemoveAllListeners()
end

function UIUtil.AddButtonListenerWithArg(btn, tbl, callback, ...)
  local onClick = BindCallback(tbl, callback, ...)
  btn.onClick:AddListener(onClick)
end

function UIUtil.AddValueChangedListener(obj, tbl, callback, ...)
  local valueChange = BindCallback(tbl, callback, ...)
  obj.onValueChanged:AddListener(valueChange)
end

function UIUtil.LuaUIBindingTable(obj, tab)
  if tab == nil then
    return
  end
  local uibinding = obj:GetComponent(cst_LuaBinding)
  if IsNull(uibinding) then
    return
  end
  local vars = uibinding.variables.Variables
  for i = 0, vars.Count - 1 do
    local value = vars[i]:GetValue()
    if vars[i].VariableTypeInt == 11 then
      local valueTab = {}
      tab[vars[i].Name] = valueTab
      for i = 0, value.Length - 1 do
        table.insert(valueTab, value[i]:GetValue())
      end
    else
      tab[vars[i].Name] = value
    end
  end
end

function UIUtil.BindFunc(...)
  return BindCallback(...)
end

UIUtil.backStack = Stack.New()

function UIUtil.CreateNewTopStatusData(uiTab)
  local data = TopStatusDataPool:PoolGet()
  data:InitTopStatusData(uiTab)
  return data
end

function UIUtil.SetTopStatusBtnShow(showHome, showNav)
  local topStatusWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatusWindow ~= nil then
    local topData = UIUtil.backStack:Peek()
    if topData ~= nil and not topData.settedGoHomeAndNaviBtn then
      topData.settedGoHomeAndNaviBtn = true
      topData.prefShowGoHomeBtn = topStatusWindow.topGroup:GetShowTopBtnGroupGoHomeBtn() == true
      topData.prefShowNaviBtn = topStatusWindow.topGroup:GetShowNaviBtn() == true
    end
    topStatusWindow.topGroup:ShowTopBtnGroupGoHomeBtn(showHome)
    topStatusWindow.topGroup:RefreshouldShowNaviBtn(showNav)
  end
end

function UIUtil.SetTopStatus(tab, backFunc, resIds, infoFunc, resAddCallbackDic, hideTopStatus, onWinShowFunc)
  local data = UIUtil.CreateNewTopStatusData(tab):SetTopStatusBackAction(backFunc):SetTopStatusResData(resIds, resAddCallbackDic):SetTopStatusInfoFunc(infoFunc):SetTopStatusVisible(not hideTopStatus):SetTopStatusOnWinShowFunc(onWinShowFunc):PushTopStatusDataToBackStack()
  return data
end

function UIUtil.AddClickHomeCheckFunc(preCheckFunc)
  local data = UIUtil.backStack:Peek()
  if data ~= nil then
    data.preCheckFunc = preCheckFunc
  end
end

function UIUtil.SetTopStateInfoBuledot(flag)
  local data = UIUtil.backStack:Peek()
  if data == nil then
    return
  end
  data.infoActionBuledot = flag
  local topStatusWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatusWindow ~= nil then
    topStatusWindow.topGroup:SetInfoBtnBluedot(flag)
  end
end

function UIUtil.SetTopStateInfoFunc(tab, infoFunc)
  if infoFunc == nil then
    return
  end
  local data = UIUtil.backStack:Peek()
  if data == nil then
    return
  end
  if data.winTypeID ~= tab:GetUIWindowTypeId() then
    return
  end
  data.infoAction = UIUtil.BindFunc(tab, infoFunc)
  local topStatusWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatusWindow ~= nil then
    topStatusWindow.topGroup:SetInfoClickAction(data.infoAction)
    topStatusWindow.topGroup:SetInfoBtnActive(true)
  end
end

function UIUtil.TryClickReturnHome(returnCallback)
  local data = UIUtil.backStack:Peek()
  if data ~= nil and data.preCheckFunc ~= nil then
    return data.preCheckFunc(returnCallback)
  end
  returnCallback()
end

function UIUtil.RefreshTopResId(resIds, resAddCallbackDic, isSetNoBackData, uitab)
  local data
  if uitab ~= nil then
    data = UIUtil.FindTopStatusDataByUiTab(uitab)
  else
    data = UIUtil.backStack:Peek()
  end
  if isSetNoBackData and data == nil then
    data = UIUtil.CreateNewTopStatusData():SetTopStatusResData(resIds):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  end
  if data ~= nil then
    data:SetTopStatusResData(resIds, resAddCallbackDic)
    data:SetTopStatusVisible(true)
  end
  if data ~= UIUtil.backStack:Peek() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.TopStatus, function(win)
    if win ~= nil then
      win:SetTopStatusResIds(data ~= nil and data.resIds or nil)
      win:SetTopStatusResAddFuncs(data.resIds, data.resAddCallbackDic)
    end
  end)
end

function UIUtil.SetCurButtonGroupActive(active)
  local data = UIUtil.backStack:Peek()
  if data == nil then
    return
  end
  active = active or false
  data.hideTopButton = not active
  local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if window ~= nil then
    window:SetTopButtonGroup(active)
  end
end

function UIUtil.SetTopOnlyShowReturn(onlyShowReturn)
  local data = UIUtil.backStack:Peek()
  if data == nil then
    return
  end
  onlyShowReturn = onlyShowReturn or false
  data.topBtnOnlyReturn = onlyShowReturn
  local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if window ~= nil then
    window.topGroup:SetUITopStatusBtnShow(not onlyShowReturn, not onlyShowReturn)
  end
end

function UIUtil.SetBack2FrontCallback(back2FrontCallback)
  local data = UIUtil.backStack:Peek()
  if data == nil then
    return
  end
  data.back2FrontCallback = back2FrontCallback
end

function UIUtil.SetIsBlockTopStatusEsc(isBlock)
  local data = UIUtil.backStack:Peek()
  if data == nil then
    return
  end
  data:SetTopstatusBlockEsc(isBlock)
end

function UIUtil.HideTopStatus()
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
end

function UIUtil.ReShowTopStatus()
  local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if window ~= nil and not window.active then
    window:Show()
  end
end

function UIUtil._HandleBackStackData(data, isToHome)
  isToHome = isToHome or false
  if data == nil or data:GetIsEmptyTab() then
    UIUtil._ForcePopBackStackData(data, true)
    return
  end
  if not data.uiTab.isHandledTopStatus then
    data.uiTab.isHandledTopStatus = true
    local cb = data.backAction
    if cb ~= nil and cb(isToHome) == false then
      data.uiTab.isHandledTopStatus = false
      return
    end
  end
  UIUtil._ForcePopBackStackData(data, true)
end

function UIUtil.RefreshTopStatus(isAsyncData)
  local lastData = UIUtil.backStack:Peek()
  if lastData ~= nil then
    if not isAsyncData and lastData.back2FrontCallback ~= nil then
      lastData.back2FrontCallback()
    end
    local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
    if topStatus ~= nil then
      topStatus:RefreshTopStatusUI(lastData)
      if not UIUtil.GlobalHideTopStatus then
        if lastData.hideTopStatus then
          topStatus:Hide()
        else
          topStatus:Show()
        end
      end
    end
  end
  if UIUtil.backStack:Empty() then
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
  end
end

function UIUtil._CheckBackStatusTopChanged(oldTopData)
  local newCurrentTopData = UIUtil.backStack:Peek()
  if newCurrentTopData ~= nil and newCurrentTopData ~= oldTopData and newCurrentTopData.OnTopNodeChange ~= nil then
    newCurrentTopData:OnTopNodeChange(newCurrentTopData.uiTab)
  end
end

function UIUtil.TryReplaceDataByAsyncWindowId(asyncWindowId, newTopData)
  if UIUtil.backStack:Empty() or asyncWindowId == nil or newTopData == nil then
    return nil
  end
  local oldTopData = UIUtil.backStack:Peek()
  local tempTopStatusStack = TempStackPool:PoolGet()
  local targetData, currentData
  local loopCount = 0
  while not UIUtil.backStack:Empty() do
    loopCount = loopCount + 1
    if 100 < loopCount then
      error("返回栈溢出")
      return
    end
    currentData = UIUtil.backStack:Pop()
    if currentData:GetAsyncWindowId() == asyncWindowId then
      targetData = currentData
      tempTopStatusStack:Push(newTopData)
      TopStatusDataPool:PoolPut(currentData)
      break
    else
      tempTopStatusStack:Push(currentData)
    end
  end
  while not tempTopStatusStack:Empty() do
    UIUtil.backStack:Push(tempTopStatusStack:Pop())
  end
  TempStackPool:PoolPut(tempTopStatusStack)
  return targetData
end

function UIUtil._GetBackStackData(judgeFunc)
  if UIUtil.backStack:Empty() then
    return
  end
  local targetData = UIUtil.backStack:Find(judgeFunc)
  return targetData
end

function UIUtil.ForceOnClickBack()
  local targetData = UIUtil._GetBackStackData(function(data)
    return true
  end)
  if targetData ~= nil or isGameDev then
  end
  UIUtil._HandleBackStackData(targetData)
end

function UIUtil.OnClickBackByWinId(winTypeID)
  if winTypeID == nil then
    return
  end
  local targetData = UIUtil._GetBackStackData(function(data)
    return data.winTypeID == winTypeID
  end)
  if targetData ~= nil or isGameDev then
  end
  UIUtil._HandleBackStackData(targetData)
end

function UIUtil.OnClickBackByUiTab(uiTab)
  if uiTab == nil then
    return
  end
  local targetData = UIUtil._GetBackStackData(function(data)
    return data.uiTab == uiTab
  end)
  if targetData ~= nil or isGameDev then
  end
  UIUtil._HandleBackStackData(targetData)
end

function UIUtil.FindTopStatusDataByUiTab(uiTab)
  local targetData = UIUtil._GetBackStackData(function(data)
    return data.uiTab == uiTab
  end)
  return targetData
end

function UIUtil.FindTopStatusDataByWinId(winTypeID)
  local targetData = UIUtil._GetBackStackData(function(data)
    return data.winTypeID == winTypeID
  end)
  return targetData
end

function UIUtil.ReturnHome()
  local loopCount = 0
  while not UIUtil.backStack:Empty() do
    if 100 < loopCount then
      error("返回栈溢出")
      return
    end
    loopCount = loopCount + 1
    local data = UIUtil.backStack:Peek()
    UIUtil._HandleBackStackData(data, true)
    if UIUtil.isRunningJump then
      UIUtil.isRunningJump = nil
      break
    end
  end
  if UIUtil.backStack:Empty() then
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
  end
end

function UIUtil.CheckTopNodeByTab(uiTab)
  if uiTab == nil then
    return false
  end
  local data = UIUtil.PeekBackStack()
  if data == nil or data.uiTab ~= uiTab then
    return false
  end
  return true
end

function UIUtil.CheckTopIsWindow(winTypeID)
  if winTypeID == nil then
    return false
  end
  local data = UIUtil.PeekBackStack()
  if data == nil then
    return false
  end
  return data.winTypeID == winTypeID
end

function UIUtil.CheckTopWindowAndClear(winTypeID)
  if winTypeID == nil then
    return false
  end
  local data = UIUtil.PeekBackStack()
  if data == nil then
    return false
  end
  if data.winTypeID == winTypeID then
    UIUtil._ForcePopBackStackData(data, true)
    return true
  end
  return false
end

function UIUtil.CheckIsHaveSpecialMarker(winTypeID)
  if winTypeID == nil then
    return false
  end
  for deepIndex = UIUtil.backStack:Count(), UIUtil.backStack.bottom, -1 do
    if UIUtil.backStack.data[deepIndex].winTypeID == winTypeID then
      return true, deepIndex
    end
  end
  return false
end

function UIUtil.ReturnUntil2Marker(winTypeID, isInclude)
  local haveMarker = UIUtil.CheckIsHaveSpecialMarker(winTypeID)
  if not haveMarker then
    return
  end
  local loopCount = 0
  local pickNext = false
  while not UIUtil.backStack:Empty() do
    if 100 < loopCount then
      error("返回栈溢出")
      return
    end
    loopCount = loopCount + 1
    local data = UIUtil.backStack:Peek()
    if data.winTypeID == winTypeID then
      if isInclude then
        pickNext = true
      else
        return
      end
    elseif pickNext then
      return
    end
    UIUtil._HandleBackStackData(data)
  end
end

function UIUtil.Push2BackStack(...)
  local tab = select(1, ...)
  local data = UIUtil.CreateNewTopStatusData(tab):SetTopStatusBackAction(select(2, ...)):SetTopStatusVisible(true)
  local frontData = UIUtil.backStack:Peek()
  if frontData ~= nil then
    data:SetTopStatusResData(frontData.resIds, frontData.resAddCallbackDic)
  end
  data:PushTopStatusDataToBackStack()
  return data
end

function UIUtil.ForcePopFromBackStack()
  local targetData = UIUtil._GetBackStackData(function(data)
    return true
  end)
  UIUtil._ForcePopBackStackData(targetData, true)
end

function UIUtil.PopFromBackStackByWinId(winTypeID)
  if winTypeID == nil then
    return
  end
  local targetData = UIUtil._GetBackStackData(function(data)
    return data:GetWinTypeID() == winTypeID
  end)
  UIUtil._ForcePopBackStackData(targetData, true)
end

function UIUtil.PopFromBackStackByUiTab(uiTab)
  if uiTab == nil then
    return
  end
  local targetData = UIUtil._GetBackStackData(function(data)
    return data:GetUiTab() == uiTab
  end)
  UIUtil._ForcePopBackStackData(targetData, true)
end

function UIUtil.PopFromBackStackByAsyncWindowId(asyncWindowId)
  if asyncWindowId == nil then
    return
  end
  local targetData = UIUtil._GetBackStackData(function(data)
    return data:GetAsyncWindowId() == asyncWindowId
  end)
  UIUtil._ForcePopBackStackData(targetData, false)
end

function UIUtil._ForcePopBackStackData(topStatusData, isClearEmptyTab)
  if topStatusData == nil then
    return
  end
  local isAsyncData = topStatusData:GetAsyncWindowId() ~= nil
  if UIUtil.backStack:Empty() then
    return
  end
  local oldTopData = UIUtil.backStack:Peek()
  local tempTopStatusStack = TempStackPool:PoolGet()
  local currentData
  local loopCount = 0
  while not UIUtil.backStack:Empty() do
    loopCount = loopCount + 1
    if 100 < loopCount then
      error("返回栈溢出")
      return
    end
    currentData = UIUtil.backStack:Pop()
    if not (isClearEmptyTab and currentData:GetIsEmptyTab()) or currentData:GetAsyncWindowId() ~= nil then
      if currentData ~= topStatusData then
        tempTopStatusStack:Push(currentData)
      else
        currentData.uiTab.isHandledTopStatus = nil
        currentData.uiTab.settedTopStatus = nil
        if currentData.settedGoHomeAndNaviBtn then
          local topStatusWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
          if topStatusWindow ~= nil then
            topStatusWindow.topGroup:ShowTopBtnGroupGoHomeBtn(currentData.prefShowGoHomeBtn)
            topStatusWindow.topGroup:RefreshouldShowNaviBtn(currentData.prefShowNaviBtn)
          end
        end
        TopStatusDataPool:PoolPut(currentData)
        break
      end
    else
      currentData.uiTab.isHandledTopStatus = nil
      currentData.uiTab.settedTopStatus = nil
      TopStatusDataPool:PoolPut(currentData)
    end
  end
  while not tempTopStatusStack:Empty() do
    UIUtil.backStack:Push(tempTopStatusStack:Pop())
  end
  UIUtil._CheckBackStatusTopChanged(oldTopData)
  TempStackPool:PoolPut(tempTopStatusStack)
  UIUtil.RefreshTopStatus(isAsyncData)
end

function UIUtil.PeekBackStack()
  return UIUtil.backStack:Peek()
end

function UIUtil.ClearTopHome()
  UIUtil.backStack:Clear()
  UIUtil.RefreshTopStatus()
end

UIUtil.__coverDic = {}

local function _ShowCover(coverData)
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(SafeUnpack(coverData.argTable))
end

function UIUtil.AddOneCover(fromWhere, argTable)
  if UIUtil.__coverDic == nil then
    UIUtil.__coverDic = {}
  end
  if argTable == nil then
    argTable = SafePack(nil, nil, nil, Color.clear, false)
  end
  local coverData = {fromWhere = fromWhere, argTable = argTable}
  UIUtil.__coverDic[fromWhere] = coverData
  _ShowCover(coverData)
end

function UIUtil.CloseOneCover(fromWhere)
  if UIUtil.__coverDic ~= nil and UIUtil.__coverDic[fromWhere] ~= nil then
    UIUtil.__coverDic[fromWhere] = nil
  end
  if UIUtil.__coverDic == nil or table.count(UIUtil.__coverDic) <= 0 then
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
end

function UIUtil.CloseAllCover()
  UIUtil.__coverDic = {}
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

function UIUtil.LoadABAssetAsyncAndSetTexture(resLoader, path, rawImageGo)
  rawImageGo.enabled = false
  resLoader:LoadABAssetAsync(path, function(texture)
    if IsNull(rawImageGo.transform) then
      return
    end
    rawImageGo.texture = texture
    rawImageGo.enabled = true
  end)
end

function UIUtil.ScrollRectLocation(scroll, item, isForceUpdateCanvases, donotRollWhenCouldSee, layoutGroup)
  if IsNull(scroll) == nil or IsNull(item) == nil then
    error("scroll is NULL or item is NULL")
    return
  end
  if not item.transform:IsChildOf(scroll.transform) then
    error("Item not Child Of scroll")
    return
  end
  if isForceUpdateCanvases then
    CS.UnityEngine.Canvas.ForceUpdateCanvases()
  end
  if scroll.horizontal then
    local targetWidth = item.transform.localPosition.x + item.transform.rect.width * (1 - item.transform.pivot.x)
    local scrollWidth = scroll.transform.rect.width
    local rectWidth = scroll.content.transform.rect.width
    if targetWidth <= scrollWidth or scrollWidth >= rectWidth then
      scroll.horizontalNormalizedPosition = 0
    else
      local diffX = targetWidth - scrollWidth
      local ratio = diffX / (rectWidth - scrollWidth)
      scroll.horizontalNormalizedPosition = ratio
    end
  end
  if scroll.vertical then
    local targetHeight = item.transform.localPosition.y - item.transform.rect.height * item.transform.pivot.y
    if item.transform.parent ~= scroll.content then
      local tepVec = Vector3.Temp(0, targetHeight, 0)
      tepVec = item.transform.parent:TransformPoint(tepVec)
      tepVec = scroll.content:InverseTransformPoint(tepVec)
      targetHeight = -tepVec.y
    else
      targetHeight = -targetHeight
    end
    local scrollHeight = scroll.transform.rect.height
    local rectHeight = scroll.content.transform.rect.height
    if targetHeight <= scrollHeight or scrollHeight >= rectHeight then
      scroll.verticalNormalizedPosition = 1
    else
      if donotRollWhenCouldSee then
        local curCoulShowRange = (1 - scroll.verticalNormalizedPosition) * (rectHeight - scrollHeight)
        if targetHeight > curCoulShowRange and targetHeight < curCoulShowRange + scrollHeight then
          return
        end
      end
      local diffY = targetHeight - scrollHeight
      local layoutBttom = IsNull(layoutGroup) and 0 or layoutGroup.padding.bottom
      local ratio = 1 - diffY / (rectHeight - layoutBttom - scrollHeight)
      scroll.verticalNormalizedPosition = ratio
    end
  end
end

function UIUtil.ShowCommonReward(rewards, crItemTransDic, showOverFunc)
  if rewards == nil then
    return
  end
  local rewardIds = {}
  local rewardNums = {}
  for itemId, itemCount in pairs(rewards) do
    table.insert(rewardIds, itemId)
    table.insert(rewardNums, itemCount)
  end
  if 0 < #rewardIds then
    local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(heroIdSnapShoot, false):SetCRNotHandledGreat(true):SetCRItemTransDic(crItemTransDic):SetCRShowOverFunc(function()
        local achievementSystemWin = UIManager:GetWindow(UIWindowTypeID.AchievementSystem)
        if achievementSystemWin ~= nil then
          achievementSystemWin.achievementLevelNode.__NeedRefreshPlayerLevel()
        end
        if showOverFunc then
          showOverFunc()
        end
      end)
      window:AddAndTryShowReward(CRData)
    end)
  end
end

function UIUtil.IsRewardNeedShowInSide(rewardIds, rewardNums, crItemTransDic)
  if #rewardIds ~= 1 then
    return false
  end
  if crItemTransDic == nil or crItemTransDic[rewardIds[1]] == nil then
    return false
  end
  local isNeedShowInSide = false
  local showInSideItemList = ConfigData.game_config.getItemOnSide
  local messageSideDataList = PlayerDataCenter:GetItemOverflowTransItemIdAndNum(rewardIds[1], rewardNums[1])
  for index, itemId in ipairs(showInSideItemList) do
    if itemId == messageSideDataList[1].itemId and not isNeedShowInSide then
      isNeedShowInSide = true
    end
  end
  return isNeedShowInSide, messageSideDataList
end

function UIUtil.RewardShowInSide(messageSideDataList, callback)
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    if window == nil then
      return
    end
    for index, messageSideData in pairs(messageSideDataList) do
      window:ShowTips(messageSideData, 2, eMessageSideType.ecParameter)
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function UIUtil.SetGlobalHideTopStatus(value)
  UIUtil.GlobalHideTopStatus = value
end

function UIUtil.SetGlobalIsBlockEsc(value)
  UIUtil.GlobalIsBlockEsc = value
end

function UIUtil.GetImageMaterial(image)
  if IsNull(image) then
    return
  end
  local newMaterial = cs_Material(image.material)
  image.material = newMaterial
  return newMaterial
end

function UIUtil.OpenHerfURL(herfStr)
  local arg = {}
  local index = string.find(herfStr, ":")
  if index == nil then
    error("超链接格式错误！没有找到冒号:")
    return
  end
  arg[1] = string.sub(herfStr, 1, index - 1)
  arg[2] = string.sub(herfStr, index + 1, -1)
  if arg[1] == "GameJump" then
    local typeAndArgs = string.split(arg[2], "=")
    local jumpTypeId = tonumber(typeAndArgs[1])
    local jumpArgs
    if typeAndArgs[2] ~= nil then
      jumpArgs = CommonUtil.SplitStrToNumber(typeAndArgs[2], "_")
    end
    if 0 < jumpTypeId then
      JumpManager:Jump(jumpTypeId, function(jumpCallback)
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, jumpArgs)
    end
  elseif arg[1] == "link" then
    local webLink = arg[2]
    cs_Application.OpenURL(webLink)
  elseif arg[1] == "token" then
    local webLink = arg[2]
    webLink = UrlUtil.GetWebURL(webLink)
    cs_Application.OpenURL(webLink)
  end
end
