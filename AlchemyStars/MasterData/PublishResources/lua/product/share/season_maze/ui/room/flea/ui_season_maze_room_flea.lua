_class("UISeasonMazeRoomFlea", UISeasonMazeRoomBase)
UISeasonMazeRoomFlea = UISeasonMazeRoomFlea

function UISeasonMazeRoomFlea:Constructor()
  self._module = GameGlobal.GetModule(SeasonMazeModule)
end

function UISeasonMazeRoomFlea:LoadDataOnEnter(TT, res)
end

function UISeasonMazeRoomFlea:OnShowUI(uiParams)
  self:InitWidget()
  local count = table.count(self._roomInfo.market)
  if count <= 0 then
    self:Lock("HandleSeasonMazeGetMarket")
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      self._component:HandleSeasonMazeGetMarket(TT, res)
      if not res:GetSucc() then
        self._module:UIModule():ExitTo(UIStateType.UISeasonMazeMain)
        self:UnLock("HandleSeasonMazeGetMarket")
        if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
          return
        end
        return
      end
      self:UnLock("HandleSeasonMazeGetMarket")
      self:_InitData()
      self:_OnValue()
    end, self)
  else
    self:_InitData()
    self:_OnValue()
  end
  self:_CheckGuide()
end

function UISeasonMazeRoomFlea:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeRoomFlea)
end

function UISeasonMazeRoomFlea:InitWidget()
  self._grid = self:GetUIComponent("UISelectObjectPath", "Grid")
  self.tipBtn = self:GetGameObject("TipBtn")
  self.tipBtn:SetActive(false)
  self.beadTips = self:GetGameObject("BeadTips")
  self.tipsTitle = self:GetUIComponent("UILocalizationText", "TipsTitle")
  self.tipsDesc = self:GetUIComponent("UILocalizationText", "TipsDesc")
  self.tipsBgRect = self:GetUIComponent("RectTransform", "Tips")
  self.canvasGroup = self:GetUIComponent("CanvasGroup", "TipBtn")
end

function UISeasonMazeRoomFlea:_OnValue()
  self._grid:SpawnObjects("UISeasonMazeRoomFleaItem", 6)
  self._itemWidgets = self._grid:GetAllSpawnList()
  for key, widget in ipairs(self._itemWidgets) do
    widget:SetData(key, self._data[key], function(index)
      self:_OnClickBead(index)
    end, function(position, titleStr, descStr)
      self:ShowBeadTips(position, titleStr, descStr)
    end)
  end
  self:_PlayAnimation()
end

function UISeasonMazeRoomFlea:_PlayAnimation()
  self:Lock("UISeasonMazeRoomFleaPlayAnimation")
  self:StartTask(function(TT)
    for index, widget in ipairs(self._itemWidgets) do
      widget:PlayAnimation()
      YIELD(TT, (index - 1) * 15)
    end
    self:UnLock("UISeasonMazeRoomFleaPlayAnimation")
  end)
end

function UISeasonMazeRoomFlea:_InitData()
  self:RefreshRoomInfo()
  self._data = {}
  for pstid, roleInfo in pairs(self._roomInfo.market) do
    local t = {}
    t.pstid = pstid
    t.roleInfo = roleInfo
    table.insert(self._data, t)
  end
end

function UISeasonMazeRoomFlea:TipsBtnOnClick(go)
  self:ShowBeadTips(go.transform.position, "str_season_maze_room_flea_intro_title", "str_season_maze_room_flea_intro_desc")
end

function UISeasonMazeRoomFlea:ShowBeadTips(position, titleStr, descStr)
  self:Lock("UISeasonMazeRoomFleaTips")
  self:StartTask(function(TT)
    self:_ShowBeadTips(TT, position, titleStr, descStr)
    self:UnLock("UISeasonMazeRoomFleaTips")
  end)
end

function UISeasonMazeRoomFlea:_ShowBeadTips(TT, position, titleStr, descStr)
  self.tipBtn:SetActive(true)
  self.tipsTitle:SetText(StringTable.Get(titleStr))
  self.tipsDesc:SetText(StringTable.Get(descStr))
  self.canvasGroup.alpha = 0
  YIELD(TT)
  local controllName = self:GetName()
  local camera = GameGlobal.UIStateManager():GetControllerCamera(controllName)
  local controller = GameGlobal.UIStateManager():GetController(controllName)
  local gameObject = controller:GetGameObject()
  local transform = gameObject.transform:Find("UICanvas")
  local rectTransform = transform:GetComponent(typeof(UnityEngine.RectTransform))
  local point = camera:WorldToScreenPoint(position)
  local res, position = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, point, camera, nil)
  if position.x + self.tipsBgRect.sizeDelta.x > rectTransform.sizeDelta.x * 0.5 then
    position.x = rectTransform.sizeDelta.x * 0.5 - self.tipsBgRect.sizeDelta.x
  end
  if position.y + rectTransform.sizeDelta.y * 0.5 < self.tipsBgRect.sizeDelta.y then
    position.y = self.tipsBgRect.sizeDelta.y - rectTransform.sizeDelta.y * 0.5
  end
  self.beadTips.transform.localPosition = position
  self.canvasGroup.alpha = 1
end

function UISeasonMazeRoomFlea:TipBtnOnClick(go)
  self.tipBtn:SetActive(false)
end

function UISeasonMazeRoomFlea:CancleBtnOnClick(go)
  UISeasonMazeModule.PopMsgBox(StringTable.Get("str_season_maze_common_tips_title"), StringTable.Get("str_season_maze_room_market_giveup"), SeasonMazeMsgBoxType.OkCancel, function()
    self:OnHideUI()
  end)
end

function UISeasonMazeRoomFlea:_OnClickBead(index)
  self:ShowDialog("UISeasonMazeRoomFleaBeadBag", self._component, true, self._data[index], function()
    self:_InitData()
    self:_OnValue()
  end)
end

function UISeasonMazeRoomFlea:_CloseAfterToast()
  self:Lock("UISeasonMazeRoomFlea")
  self:StartTask(function(TT)
    ToastManager.ShowToast(StringTable.Get("str_season_maze_room_flea_close_tips"))
    YIELD(TT, 1500)
    self:OnHideUI()
    self:UnLock("UISeasonMazeRoomFlea")
  end)
end

function UISeasonMazeRoomFlea:BackBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
  self._seasonMazeModule:UIModule():SetTempRoom(self:GetName())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTempCloseRoom, true)
  self:CloseDialog()
end
