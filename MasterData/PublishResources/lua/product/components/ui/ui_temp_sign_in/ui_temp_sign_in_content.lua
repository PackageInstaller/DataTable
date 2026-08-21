require("ui_side_enter_center_content_base")
_class("UITempSignInContent", UISideEnterCenterContentBase)
UITempSignInContent = UITempSignInContent

function UITempSignInContent:DoInit()
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, "_descTmp", "UITempSignIn_Material.mat", self._matReq)
end

function UITempSignInContent:DoShow()
  self:_AttachEvent()
  self._signInModule = self:GetModule(SignInModule)
  self.result2str = {
    [SIGN_IN_RESULT_CODE.SIGN_DAY_NUM_ERROR] = "str_temp_sign_in_SIGN_DAY_NUM_ERROR",
    [SIGN_IN_RESULT_CODE.SIGN_DAY_NUM_ACCEPTED] = "str_temp_sign_in_SIGN_DAY_NUM_ACCEPTED",
    [SIGN_IN_RESULT_CODE.SIGN_DAY_NUM_NOT_ENOUGH] = "str_temp_sign_in_SIGN_DAY_NUM_NOT_ENOUGH"
  }
  self:_Refresh()
end

function UITempSignInContent:DoHide()
  self:_DetachEvent()
  UIWidgetHelper.ClearWidgets(self, "itemInfo")
end

function UITempSignInContent:DoDestroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UITempSignInContent:_Refresh(notMove)
  self._currentDay = self._signInModule:GetTotalSignInDayNum()
  self._itemDatas = self:_SetItemDatas()
  self:_SetItems()
  local maxDay = #self._itemDatas
  UIWidgetHelper.SetLocalizedTMPText(self, "_descTmp", StringTable.Get("str_temp_sign_in_title", maxDay))
  if not notMove then
    self:_InitScrollPos()
  end
end

function UITempSignInContent:_SetItemDatas()
  local tb_out = {}
  local dayInfo, rewardInfo = self._signInModule:GetNewPlayerSignupStatus()
  for index, value in ipairs(dayInfo) do
    local item = {}
    item.day = index
    item.got = value
    item.awardList = rewardInfo[index]
    table.insert(tb_out, item)
  end
  return tb_out
end

function UITempSignInContent:_InitScrollPos()
  local canGetIdx = self:_CheckCanGetIndex()
  if canGetIdx ~= 0 then
    local content = self:GetUIComponent("RectTransform", "Content")
    local height = (canGetIdx - 1) * 149
    content.anchoredPosition = Vector2(content.anchoredPosition.x, height)
  end
end

function UITempSignInContent:_CheckCanGetIndex()
  local tb = {
    NewPlayerLoginStatus.NPLS_UnAccept
  }
  local idx = UITempSignInEnter.CheckDayStatus(tb)
  return idx
end

function UITempSignInContent:_SetItems()
  local items = UIWidgetHelper.SpawnObjects(self, "Content", "UITempSignInItem", #self._itemDatas - 1)
  local lastItem = UIWidgetHelper.SpawnObject(self, "lastDataPool", "UITempSignInItem")
  table.insert(items, lastItem)
  self._items = items
  for i, v in ipairs(self._items) do
    local itemData = self._itemDatas[i]
    local isLastDay = i == #self._items
    v:SetData(i, itemData, self._currentDay, function(idx)
      for i, v in ipairs(self._items) do
        v:SetSelected(i == idx)
      end
    end, function(idx)
      self:GetAwardReq(idx)
    end, function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "itemInfo", matid, pos)
    end, isLastDay)
  end
end

function UITempSignInContent:GetAwardReq(idx)
  Log.debug("###[UITempSignInContent] temp sign in get reward !")
  self._getIdx = idx
  self:Lock("UITempSignInContent:GetAwardReq")
  self:StartTask(function(TT)
    local data = self._itemDatas[self._getIdx]
    local res = self._signInModule:RequestAcceptNewPlayerReward(TT, data.day)
    self:UnLock("UITempSignInContent:GetAwardReq")
    if res:GetSucc() then
      Log.debug("###[UITempSignInContent] succ !")
      data.got = NewPlayerLoginStatus.NPLS_Accepted
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTempSignInAwardGot, data.day)
      self._items[idx]:OnAwardGot(data)
    else
      local result = res:GetResult()
      Log.error("###[UITempSignInItem] getOnClick fail -- result --> ", result)
      local toastStr = self.result2str[result]
      ToastManager.ShowToast(StringTable.Get(toastStr))
    end
  end)
end

function UITempSignInContent:_AttachEvent()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UITempSignInContent:_DetachEvent()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UITempSignInContent:OnUIGetItemCloseInQuest()
  self:_Refresh(true)
end
