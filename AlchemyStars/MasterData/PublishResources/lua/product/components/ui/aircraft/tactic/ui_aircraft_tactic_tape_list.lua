_class("UIAircraftTacticTapeList", UICustomWidget)
UIAircraftTacticTapeList = UIAircraftTacticTapeList

function UIAircraftTacticTapeList:OnShow(uiParams)
  self:InitWidget()
  self.scrollView:InitListView(0, function(scrollview, index)
    return self:_newItem(scrollview, index)
  end)
  self._tipIsShown = false
  self._scrollTip:SetActive(false)
  self._isInit = true
end

function UIAircraftTacticTapeList:InitWidget()
  self.scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._content = self._scrollRect.content
  self._scrollWidth = self._scrollRect.viewport.rect.width
  self._scrollTip = self:GetGameObject("tip")
  self._scrollRect.onValueChanged:AddListener(function(pos)
    self:onScroll(pos)
  end)
end

function UIAircraftTacticTapeList:SetData(tapeList, packCount, activityN8)
  self._activityN8 = activityN8
  self._packCount = packCount
  self._tapeList = tapeList
  
  function self._onClick(data, index)
    self:StartTask(self.tryScroll, self, index, data)
  end
  
  local count = #self._tapeList + packCount
  self.scrollView:SetListItemCount(count, false)
  self.scrollView:RefreshAllShownItem()
  if self._curSelct then
    local found = false
    for i, data in ipairs(tapeList) do
      if self._curSelct == data then
        found = true
        break
      end
    end
    if not found then
      self._curSelct = nil
    end
  end
  self._showTip = self._content.rect.width > self._scrollWidth and 0 < count
  if not self._showTip and self._tipIsShown then
    self._scrollTip:SetActive(false)
    self._tipIsShown = false
  elseif self._showTip and not self._tipIsShown then
    self._scrollTip:SetActive(true)
    self._tipIsShown = true
  end
  self:onScroll(self._scrollRect.normalizedPosition)
  if self._isInit then
    self._isInit = false
  end
end

function UIAircraftTacticTapeList:playBtnOnClick(go)
  if not self._curSelct then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_tactic_select_tape_first"))
    return
  end
  self:ShowDialog("UITacticTapeInfo", self._curSelct, self._activityN8)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8DefaultClick)
end

function UIAircraftTacticTapeList:onScroll(pos)
  if self._showTip and pos.x > 0.9995 and self._tipIsShown then
    self._scrollTip:SetActive(false)
    self._tipIsShown = false
  elseif self._showTip and pos.x < 0.9995 and not self._tipIsShown then
    self._scrollTip:SetActive(true)
    self._tipIsShown = true
  end
end

function UIAircraftTacticTapeList:_newItem(scrollview, index)
  if index < 0 then
    return nil
  end
  index = index + 1
  local item = scrollview:NewListViewItem("item")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
  end
  local itemWidget = cellPool:SpawnObject("UITacticTapeItem")
  if index <= self._packCount then
    itemWidget:SetData(nil, index, self._onClick, false, self._isInit)
  else
    local data = self._tapeList[index - self._packCount]
    itemWidget:SetData(data, index, self._onClick, self._curSelct == data, self._isInit)
  end
  if itemWidget:GetGameObject().activeSelf then
    local anim = itemWidget:GetGameObject():GetComponent("Animation")
    anim:Play("uieff_Tape_In")
    anim:Stop()
  else
    itemWidget:GetGameObject():SetActive(true)
    local anim = itemWidget:GetGameObject():GetComponent("Animation")
    anim:Play("uieff_Tape_In")
    anim:Stop()
    itemWidget:GetGameObject():SetActive(false)
  end
  return item
end

function UIAircraftTacticTapeList:tryScroll(TT, idx, data)
  self._scrollRect:StopMovement()
  local tapeWidth = 504
  local padding = 0
  local left = -(idx - 1) * (tapeWidth + padding)
  local right = self._scrollWidth - (idx * (tapeWidth + padding) - padding)
  local x = self._content.anchoredPosition.x
  local target
  if x - left < -1 then
    target = left
  else
    if 1 < x - right then
      target = right
    else
    end
  end
  if target then
    self:Lock("FocusTape")
    self._content:DOLocalMoveX(target, 0.5, true)
    YIELD(TT, 500)
    self:UnLock("FocusTape")
  end
  if data then
    Log.fatal("点击1个卡带")
    if self._curSelct == data then
      return
    end
    self._scrollRect:StopMovement()
    self._curSelct = data
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftTacticOnSelectItemChanged, data)
  else
    Log.fatal("点击1个礼包")
    if self._activityN8 then
      self:StartTask(self.openGiftN8, self)
    else
      self:StartTask(self.openGift, self)
    end
  end
end

function UIAircraftTacticTapeList:openGift(TT)
  local module = self:GetModule(AircraftModule)
  self:Lock("ReqOpenTacticGift")
  AirLog("打开礼包")
  local ack, msg = module:RequestOpenCartridgeGift(TT)
  self:UnLock("ReqOpenTacticGift")
  if ack:GetSucc() then
    self:ShowDialog("UITacticTapeObtain", msg.m_reward_list[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftTacticRefreshTapeList)
    local room = module:GetRoomByRoomType(AirRoomType.TacticRoom)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshRoomUI, room:SpaceId())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshNavMenuData)
  else
    ToastManager.ShowToast(module:GetErrorMsg(ack:GetResult()))
  end
end

function UIAircraftTacticTapeList:openGiftN8(TT)
  if not self._campaign then
    self._campaign = UIActivityCampaign:New()
    self._campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_N8)
  end
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_CombatSimulator, 1)
  self:Lock("ReqOpenTacticGift")
  local res = AsyncRequestRes:New()
  local id = component:HandleCombatSimulatorComponentOpenGift(TT, res)
  Log.info("UIAircraftTacticTapeList:openGiftN8() 打开礼包N8, id = ", id)
  self:UnLock("ReqOpenTacticGift")
  if res:GetSucc() then
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = id
    roleAsset.count = 1
    self:ShowDialog("UITacticTapeObtain", roleAsset)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftTacticRefreshTapeList)
  else
    self._campaign:CheckErrorCode(res.m_result, nil, function()
      self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIActivityN8MainController, UIStateType.UIMain, nil, self._campaign._id)
    end)
  end
end
