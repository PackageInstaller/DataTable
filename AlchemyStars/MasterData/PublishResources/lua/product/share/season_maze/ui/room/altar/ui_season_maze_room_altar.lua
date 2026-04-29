require("ui_season_maze_room_base")
_class("UISeasonMazeRoom_Altar", UISeasonMazeRoomBase)
UISeasonMazeRoom_Altar = UISeasonMazeRoom_Altar
_enum("UISeasonMazeAltarType", {
  None = 0,
  Delete = 1,
  Reset = 2
})

function UISeasonMazeRoom_Altar:SetTopIcon()
  self._UISeasonMazeTopIconWidget = self._UISeasonMazeTopIconPool:SpawnObject("UISeasonMazeTopIcon")
  self._UISeasonMazeTopIconWidget:SetData({
    SeasonMazeTopIconType.Money
  })
end

function UISeasonMazeRoom_Altar:InitWidget()
  self._rectTransform = self:GetUIComponent("RectTransform", "Center")
  self._pool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._UISeasonMazeTopIconPool = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeTopIcon")
  self._scrollRect = self:GetUIComponent("ScrollRect", "Scroll View")
  self._deleteRt = self:GetUIComponent("RectTransform", "deleteRt")
  self._resetRt = self:GetUIComponent("RectTransform", "resetRt")
  self._curOperate = 0
  self.effGo = {}
  self.effGo[1] = self:GetGameObject("delEff")
  self.effGo[2] = self:GetGameObject("resetEff")
  local templatePool = self:GetUIComponent("UISelectObjectPath", "templateCard")
  self._templateWidget = templatePool:SpawnObject("UISeasonMazeCardItem")
  self._templateGO = self:GetGameObject("templateCard")
  self._templateRt = self:GetUIComponent("RectTransform", "templateCard")
  self._txtDelCost = self:GetUIComponent("UILocalizationText", "txtDelCost")
  self._txtResetCost = self:GetUIComponent("UILocalizationText", "txtResetCost")
  self._pageAniamtion = self:GetUIComponent("Animation", "pageAnimation")
  self._plotAnimation = self:GetUIComponent("Animation", "plotAnimation")
  self._aniNames = {
    pageOut = {
      "uieff_UISeasonMazeRoom_Altar_out",
      333
    },
    plotDelIn = {
      "uieff_UISeasonMazeRoom_Altar_xuanzhong_in",
      933
    },
    plotDelOut = {
      "uieff_UISeasonMazeRoom_Altar_xuanzhong_out",
      333
    },
    plotResetIn = {
      "uieff_UISeasonMazeRoom_Altar_xuanzhong01_in",
      933
    },
    plotResetOut = {
      "uieff_UISeasonMazeRoom_Altar_xuanzhong01_out",
      333
    },
    cardIn = {
      "uieff_UISeasonMazeCardItem_MazeRoom_Altar_in",
      933
    },
    cardOut = {
      "uieff_UISeasonMazeCardItem_MazeRoom_out",
      800
    },
    cardRefresh = {
      "uieff_UISeasonMazeCardItem_MazeRoom_Altar_refresh",
      1200
    }
  }
end

function UISeasonMazeRoom_Altar:SetCards()
  self._templateGO:SetActive(false)
  self._pool:SpawnObjects("UISeasonMazeCardItem", #self._cards)
  local pools = self._pool:GetAllSpawnList()
  self._deletePrice = 0
  if self._cfg_s_maze_global.HandDeletCount then
    if self._deleteTime > #self._cfg_s_maze_global.HandDeletCount then
      self._deletePrice = self._cfg_s_maze_global.HandDeletCount[#self._cfg_s_maze_global.HandDeletCount]
    else
      self._deletePrice = self._cfg_s_maze_global.HandDeletCount[self._deleteTime]
    end
  end
  self._resetPrice = 0
  if self._cfg_s_maze_global.HandResetCount then
    if self._resetTime > #self._cfg_s_maze_global.HandResetCount then
      self._resetPrice = self._cfg_s_maze_global.HandResetCount[#self._cfg_s_maze_global.HandResetCount]
    else
      self._resetPrice = self._cfg_s_maze_global.HandResetCount[self._resetTime]
    end
  end
  local curMoney = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if curMoney < self._deletePrice then
    self._txtDelCost:SetText(UIActivityHelper.GetColorText("#ff6f6f", self._deletePrice))
  else
    self._txtDelCost:SetText(self._deletePrice)
  end
  if curMoney < self._resetPrice then
    self._txtResetCost:SetText(UIActivityHelper.GetColorText("#ff6f6f", self._resetPrice))
  else
    self._txtResetCost:SetText(self._resetPrice)
  end
  for i = 1, #self._cards do
    local widget = pools[i]
    local card = self._cards[i]
    widget:SetData(1, card, function()
    end, nil, true, self)
    widget:RootAlpha(1)
    local rt = widget:RectTransform()
    rt.localScale = Vector3(0.54, 0.54, 1)
  end
end

function UISeasonMazeRoom_Altar:OnCardOperate(cardId, operate)
  local bDelete = operate == 1
  if bDelete then
    if 1 >= #self._cards then
      local tips = StringTable.Get("str_season_maze_alart_1_tips")
      ToastManager.ShowToast(tips)
      self:_OnDragFail()
      return
    end
  elseif operate == 2 then
  else
    self:_OnDragFail()
    return
  end
  if self:CheckMoneyEnough(bDelete) then
    local plotRt
    if bDelete then
      plotRt = self._deleteRt
    else
      plotRt = self._resetRt
    end
    self._templateRt.anchoredPosition = Vector2(plotRt.anchoredPosition.x, plotRt.anchoredPosition.y - 8)
    local rt = self._templateWidget:RectTransform()
    rt.localScale = Vector3(0.76, 0.76, 1)
    self._templateWidget:PlayAnim(self._aniNames.cardIn[1])
    self:PlayCardAni("cardIn", function()
      self:_PopChangeConfirm(cardId, bDelete)
    end)
  else
    self:_OnDragFail()
  end
end

function UISeasonMazeRoom_Altar:_PopChangeConfirm(cardId, bDelete)
  local title = ""
  local desc = ""
  if bDelete then
    title = StringTable.Get("str_season_maze_hand_room_tips_delete")
    desc = StringTable.Get("str_season_maze_hand_room_desc_delete")
  else
    title = StringTable.Get("str_season_maze_hand_room_tips_refresh")
    desc = StringTable.Get("str_season_maze_hand_room_desc_refresh")
  end
  UISeasonMazeModule.PopMsgBox(title, desc, SeasonMazeMsgBoxType.OkCancel, function()
    self:Lock("UISeasonMazeRoom_Altar:OnReqChangeCard")
    GameGlobal.TaskManager():StartTask(self.OnReqChangeCard, self, cardId, bDelete)
  end, nil, function()
    self:_OnDragFail(true)
  end)
end

function UISeasonMazeRoom_Altar:CheckMoneyEnough(bDelete)
  local enough = true
  local curMoney = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if bDelete then
    if curMoney < self._deletePrice then
      enough = false
    end
  elseif curMoney < self._resetPrice then
    enough = false
  end
  if not enough then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_gold_not_enough"))
  end
  return enough
end

function UISeasonMazeRoom_Altar:OnReqChangeCard(TT, cardId, isDelete)
  local card = cardId
  local area = 1
  if table.icontains(self._comInfo.wait_hands, card) then
    area = 0
  end
  local res = AsyncRequestRes:New()
  local response = self._component:HandleSeasonMazeAltar(TT, res, card, isDelete, area)
  self:UnLock("UISeasonMazeRoom_Altar:OnReqChangeCard")
  if res:GetSucc() then
    Log.debug("###[UISeasonMazeRoom_Altar] take card succ ! card:", card, "isDelete", isDelete, "area", area)
    if isDelete then
      self:PlayCardAni("cardOut", function()
        self:_RefreshAfterOperate(isDelete, cardId, response.cfg_id)
      end)
    else
      self:PlayCardAni("cardRefresh", function()
        self:PlayCardAni("cardOut", function()
          self:_RefreshAfterOperate(isDelete, cardId, response.cfg_id)
        end)
      end)
      self._templateWidget:SetData(1, response.cfg_id, function()
      end, nil, false, nil, false)
    end
  else
    self:_OnDragFail(true)
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoom_Altar] HandleSeasonMazeAltar fail ! result :", result)
    if result == CampaignErrorType.E_COMPONENT_SEASON_MAZE_ALL_HAND then
      ToastManager.ShowToast(StringTable.Get("str_season_maze_hand_full"))
    end
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoom_Altar:_RefreshAfterOperate(isDelete, cardId, responseCfgId)
  for k, v in pairs(self.effGo) do
    v:SetActive(false)
  end
  self:RefreshRoomInfo()
  self:RefreshData(isDelete, cardId, responseCfgId)
  self:SetCards()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
end

function UISeasonMazeRoom_Altar:RefreshData(isDelete, cardId, newCardID)
  self._cfg_s_maze_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  self._resetTime = self._roomInfo.var_param_1 + 1
  self._deleteTime = self._roomInfo.var_param + 1
  local idx = 0
  for i, v in ipairs(self._cards) do
    if v == cardId then
      idx = i
    end
  end
  if isDelete then
    table.remove(self._cards, idx)
  else
    self._cards[idx] = newCardID
  end
end

function UISeasonMazeRoom_Altar:CreateData()
  self._module = GameGlobal.GetModule(SeasonMazeModule)
  self._cards = {}
  self._cfg_s_maze_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  self._resetTime = self._roomInfo.var_param_1 + 1
  self._deleteTime = self._roomInfo.var_param + 1
  if self._comInfo.wait_hands and next(self._comInfo.wait_hands) then
    for index, value in ipairs(self._comInfo.wait_hands) do
      table.insert(self._cards, value)
    end
  end
  if self._comInfo.fold_hands and next(self._comInfo.fold_hands) then
    for index, value in ipairs(self._comInfo.fold_hands) do
      table.insert(self._cards, value)
    end
  end
end

function UISeasonMazeRoom_Altar:OnShowUI()
  self:InitWidget()
  self:CreateData()
  self:SetTopIcon()
  self:SetCards()
  self:_CheckGuide()
end

function UISeasonMazeRoom_Altar:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeRoom_Altar)
end

function UISeasonMazeRoom_Altar:PuaseBtnOnClick()
  self:PlayAni(self._pageAniamtion, "pageOut", function()
    self:OnlyHideUI()
  end)
end

function UISeasonMazeRoom_Altar:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonMazeRoom_Altar:CloseBtnOnClick(go)
  UISeasonMazeModule.PopMsgBox(StringTable.Get("str_season_maze_common_tips_title"), StringTable.Get("str_season_maze_hand_room_return"), SeasonMazeMsgBoxType.OkCancel, function()
    self:PlayAni(self._pageAniamtion, "pageOut", function()
      self:OnHideUI()
    end)
  end)
end

function UISeasonMazeRoom_Altar:OnBeginDrag(eventData, card)
  if self._idDraging then
    return
  end
  self._idDraging = true
  self._curDragCard = card
  self._templateRt.position = card:Position()
  self._templateWidget:SetData(card:Index(), card:ID(), function()
  end, nil, false, nil, false)
  self._templateWidget:RootAlpha(1)
  self._templateWidget:QualityAlpha(1)
  self._templateWidget:Mark(true)
  local rt = self._templateWidget:RectTransform()
  rt.localScale = Vector3(0.54, 0.54, 1)
end

function UISeasonMazeRoom_Altar:_RefreshDragTargetEff()
  for k, v in pairs(self.effGo) do
    v:SetActive(k == self._curOperate)
  end
end

function UISeasonMazeRoom_Altar:OnDrag(eventData)
  if self._idDraging and self._curDragCard then
    if not self._templateGO.activeSelf then
      self._templateGO:SetActive(true)
      self._curDragCard:RootAlpha(0)
    end
    local position = self:ScreenPointToLocalPointInRectangle(self._rectTransform, eventData)
    self._templateRt.anchoredPosition = Vector3(position.x, position.y, 0)
    self:_OnDragCheck()
    self:_RefreshDragTargetEff()
  end
end

function UISeasonMazeRoom_Altar:OnDragEnd(eventData)
  if self._curDragCard then
    if self._curOperate > 0 then
      self:_OnDragSucc(self._curOperate)
    else
      self:_OnDragFail()
    end
  end
end

function UISeasonMazeRoom_Altar:_OnDragCheck()
  if not self._operateRect then
    self._operateRect = {}
    self._operateRect[1] = {}
    self._operateRect[2] = {}
    self._operateRect[1][1] = Vector3(self._deleteRt.anchoredPosition.x - self._deleteRt.sizeDelta.x / 2, self._deleteRt.anchoredPosition.y - self._deleteRt.sizeDelta.y / 2)
    self._operateRect[1][2] = Vector3(self._deleteRt.anchoredPosition.x + self._deleteRt.sizeDelta.x / 2, self._deleteRt.anchoredPosition.y + self._deleteRt.sizeDelta.y / 2)
    self._operateRect[2][1] = Vector3(self._resetRt.anchoredPosition.x - self._resetRt.sizeDelta.x / 2, self._resetRt.anchoredPosition.y - self._resetRt.sizeDelta.y / 2)
    self._operateRect[2][2] = Vector3(self._resetRt.anchoredPosition.x + self._resetRt.sizeDelta.x / 2, self._resetRt.anchoredPosition.y + self._resetRt.sizeDelta.y / 2)
  end
  self._curOperate = 0
  local tempalteLeftUp = Vector3(self._templateRt.anchoredPosition.x - self._templateRt.sizeDelta.x / 2, self._templateRt.anchoredPosition.y - self._templateRt.sizeDelta.y / 2)
  local tempalteRightDown = Vector3(self._templateRt.anchoredPosition.x + self._templateRt.sizeDelta.x / 2, self._templateRt.anchoredPosition.y + self._templateRt.sizeDelta.y / 2)
  local tempalteRightUp = Vector3(self._templateRt.anchoredPosition.x + self._templateRt.sizeDelta.x / 2, self._templateRt.anchoredPosition.y - self._templateRt.sizeDelta.y / 2)
  local tempalteLeftDown = Vector3(self._templateRt.anchoredPosition.x - self._templateRt.sizeDelta.x / 2, self._templateRt.anchoredPosition.y + self._templateRt.sizeDelta.y / 2)
  self._curOperate = 0
  for operate, d in pairs(self._operateRect) do
    if self:CheckPointInRect(tempalteLeftUp, d[1], d[2]) or self:CheckPointInRect(tempalteRightDown, d[1], d[2]) or self:CheckPointInRect(tempalteRightUp, d[1], d[2]) or self:CheckPointInRect(tempalteLeftDown, d[1], d[2]) then
      self._curOperate = operate
      break
    end
  end
end

function UISeasonMazeRoom_Altar:CheckPointInRect(point, leftDown, rightUp)
  return point.x > leftDown.x and point.x < rightUp.x and point.y > leftDown.y and point.y < rightUp.y
end

function UISeasonMazeRoom_Altar:OnReleased()
  self._idDraging = false
end

function UISeasonMazeRoom_Altar:_OnDragSucc(operate)
  local cardID = self._curDragCard:ID()
  self:OnCardOperate(cardID, operate)
end

function UISeasonMazeRoom_Altar:_OnDragFail(withAni)
  if withAni then
    self:PlayCardAni("cardOut", function()
      self:_ResetAfterDrawFail()
    end)
  else
    self:_ResetAfterDrawFail()
  end
  for k, v in pairs(self.effGo) do
    v:SetActive(false)
  end
end

function UISeasonMazeRoom_Altar:_ResetAfterDrawFail()
  self._templateGO:SetActive(false)
  self._curDragCard:RootAlpha(1)
end

function UISeasonMazeRoom_Altar:ScreenPointToLocalPointInRectangle(rect, eventData)
  local res, position = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, eventData.position, eventData.pressEventCamera, nil)
  return position
end

function UISeasonMazeRoom_Altar:PlayAni(animation, aniKey, callback)
  local ani = self._aniNames[aniKey]
  animation:Play(ani[1])
  local lockName = "UISeasonMazeRoom_Altar_" .. aniKey
  self:Lock(lockName)
  local duration = ani[2]
  self:StartTask(function(TT)
    YIELD(TT, duration)
    self:UnLock(lockName)
    if callback then
      callback()
    end
  end)
end

function UISeasonMazeRoom_Altar:PlayCardAni(aniKey, callback)
  local ani = self._aniNames[aniKey]
  self._templateWidget:PlayAnim(ani[1])
  local lockName = "UISeasonMazeRoom_Altar_" .. aniKey
  self:Lock(lockName)
  local duration = ani[2]
  self:StartTask(function(TT)
    YIELD(TT, duration)
    self:UnLock(lockName)
    if callback then
      callback()
    end
  end)
end
