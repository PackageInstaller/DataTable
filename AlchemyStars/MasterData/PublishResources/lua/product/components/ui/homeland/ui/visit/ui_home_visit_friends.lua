_class("UIHomeVisitFriends", UIController)
UIHomeVisitFriends = UIHomeVisitFriends

function UIHomeVisitFriends:LoadDataOnEnter(TT, res, uiParams)
  self._friends = nil
  self._logs = nil
  self:Lock("ReqHomeFriendList")
  self._friends, self._logs = GameGlobal.GetUIModule(HomelandModule):ReqFriendList(TT)
  self:UnLock("ReqHomeFriendList")
  if not self._friends or not self._logs then
    res:SetSucc(false)
    return
  end
  table.sort(self._friends, function(a, b)
    if a:CanGetGift() ~= b:CanGetGift() then
      return a:CanGetGift()
    end
    if a:CanSpeedup() ~= b:CanSpeedup() then
      return a:CanSpeedup()
    end
    if a:CanWater() ~= b:CanWater() then
      return a:CanWater()
    end
    if a:Level() ~= b:Level() then
      return a:Level() >= b:Level()
    end
    return a:PstID() < b:PstID()
  end)
  table.sort(self._logs, function(a, b)
    return a:Time() > b:Time()
  end)
end

function UIHomeVisitFriends:OnShow(uiParams)
  self:InitWidget()
  self.friendList:InitListView(#self._friends, function(scrollView, idx)
    return self:_NewFriendItem(scrollView, idx)
  end)
  self.logList:InitListView(#self._logs, function(scrollView, idx)
    return self:_NewLogItem(scrollView, idx)
  end)
  local atlas = self:GetAsset("UIHomelandVisit.spriteatlas", LoadType.SpriteAtlas)
  local friendImage = self:GetUIComponent("Image", "FriendBtn")
  local friendText = self:GetUIComponent("UILocalizationText", "FriendBtnText")
  local logImage = self:GetUIComponent("Image", "LogBtn")
  local logText = self:GetUIComponent("UILocalizationText", "LogBtnText")
  self._friendBtn = UIHomeStateWidget:New({
    {
      UI = friendImage,
      Type = UIHomeStateWidgetType.SpriteSwap,
      States = {
        [1] = atlas:GetSprite("n17_homie_btn1"),
        [2] = atlas:GetSprite("n17_homie_btn2")
      }
    },
    {
      UI = friendText,
      Type = UIHomeStateWidgetType.ColorTint,
      States = {
        [1] = Color.white,
        [2] = Color(0.28627450980392155, 0.28627450980392155, 0.28627450980392155)
      }
    }
  })
  self._logBtn = UIHomeStateWidget:New({
    {
      UI = logImage,
      Type = UIHomeStateWidgetType.SpriteSwap,
      States = {
        [1] = atlas:GetSprite("n17_homie_btn1"),
        [2] = atlas:GetSprite("n17_homie_btn2")
      }
    },
    {
      UI = logText,
      Type = UIHomeStateWidgetType.ColorTint,
      States = {
        [1] = Color.white,
        [2] = Color(0.28627450980392155, 0.28627450980392155, 0.28627450980392155)
      }
    }
  })
  self:_ShowLogs(false)
  self:_ShowFriends(true)
end

function UIHomeVisitFriends:InitWidget()
  self.friendList = self:GetUIComponent("UIDynamicScrollView", "friendList")
  self.logList = self:GetUIComponent("UIDynamicScrollView", "logList")
  self.friendBtn = self:GetUIComponent("Button", "FriendBtn")
  self.logBtn = self:GetUIComponent("Button", "LogBtn")
  self._friendsListGo = self:GetGameObject("friendList")
  self._logListGo = self:GetGameObject("logList")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._empty = self:GetUIComponent("UILocalizationText", "empty")
  self._helpTip = self:GetUIComponent("UISelectObjectPath", "Tips")
  self:ShowHelpTip()
end

function UIHomeVisitFriends:_ShowFriends(show)
  self._friendsListGo:SetActive(show)
  if show then
    self._friendBtn:ChangeState(1)
    self._title:SetText(StringTable.Get("str_homeland_visit_friend_list"))
    if #self._friends == 0 then
      self._empty:SetText(StringTable.Get("str_homeland_visit_no_friend"))
    else
      self._empty:SetText("")
    end
  else
    self._friendBtn:ChangeState(2)
  end
end

function UIHomeVisitFriends:_ShowLogs(show)
  self._logListGo:SetActive(show)
  if show then
    self._logBtn:ChangeState(1)
    self._title:SetText(StringTable.Get("str_homeland_visit_log_title"))
    if #self._logs == 0 then
      self._empty:SetText(StringTable.Get("str_homeland_visit_no_log"))
    else
      self._empty:SetText("")
    end
  else
    self._logBtn:ChangeState(2)
  end
end

function UIHomeVisitFriends:_NewFriendItem(scrollview, idx)
  if idx < 0 then
    return
  end
  local item = scrollview:NewListViewItem("item")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local friend = rowPool:SpawnObject("UIHomeVisitFriendItem")
  friend:SetData(self._friends[idx + 1])
  return item
end

function UIHomeVisitFriends:_NewLogItem(scrollview, idx)
  if idx < 0 then
    return
  end
  local item = scrollview:NewListViewItem("item")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local log = rowPool:SpawnObject("UIHomeVisitLogItem")
  log:SetData(self._logs[idx + 1])
  UIHelper.RefreshLayout(item.gameObject:GetComponent("RectTransform"))
  return item
end

function UIHomeVisitFriends:FriendBtnOnClick(go)
  self:_ShowLogs(false)
  self:_ShowFriends(true)
end

function UIHomeVisitFriends:LogBtnOnClick(go)
  self:_ShowFriends(false)
  self:_ShowLogs(true)
end

function UIHomeVisitFriends:BackBtnOnClick()
  self:CloseDialog()
end

function UIHomeVisitFriends:ShowHelpTip()
  local tip = self._helpTip:SpawnObject("UIHomelandCommonHelp")
  tip:SetData("UIHomeVisitFriends")
end
