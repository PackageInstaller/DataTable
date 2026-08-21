_class("UISeasonMazePickCard", UIController)
UISeasonMazePickCard = UISeasonMazePickCard

function UISeasonMazePickCard:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazePickCard.Test()
  local srcLv = 2
  local data = {
    {
      1,
      2,
      3
    },
    {
      4,
      5,
      6,
      7
    },
    {
      8,
      9,
      10
    },
    {
      11,
      12,
      13
    },
    {
      14,
      15,
      16,
      17
    }
  }
  GameGlobal.UIStateManager():ShowDialog("UISeasonMazePickCard", srcLv, data)
end

function UISeasonMazePickCard:OnShow(uiParams)
  self:InitWidget()
  self._sourceLv = uiParams[1]
  self._data = uiParams[2]
  self._amount = #self._data
  self._curAmount = 1
  self._selectResults = {}
  self._tipHideMask:SetActive(false)
  self:_Refresh()
end

function UISeasonMazePickCard:_OnShowDetail(idx, pos)
  if not self._tipWidget then
    self._tipWidget = self.tip:SpawnObject("UISeasonMazePickCardTip")
  end
  local cfgID = self._cardWigets[idx]:CfgID()
  self._tipWidget:DoShow(cfgID, pos)
  self._tipHideMask:SetActive(true)
end

function UISeasonMazePickCard:_OnSeletItem(idx, pos)
  if self._selectIdx then
    self._cardWigets[self._selectIdx]:Select(false)
  end
  self._selectIdx = idx
  self._cardWigets[self._selectIdx]:Select(true)
  self._cardWigets[self._selectIdx]:PlayAnim("uieff_UISeasonMazePickCardItem_touch")
  if self._tipWidget then
    self._tipWidget:DoHide()
    self._tipHideMask:SetActive(false)
  end
end

function UISeasonMazePickCard:InitWidget()
  self.cards = self:GetUIComponent("UISelectObjectPath", "cards")
  self.tip = self:GetUIComponent("UISelectObjectPath", "Tip")
  self._tipHideMask = self:GetGameObject("TipCloseMask")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonMazePickCard:ConfirmBtnOnClick(go)
  if not self._selectIdx or self._selectIdx <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_lvup_pickcard_error"))
    return
  end
  if self._tipWidget then
    self._tipWidget:DoHide()
    self._tipHideMask:SetActive(false)
  end
  local lvKey = self._sourceLv + self._curAmount
  self._selectResults[lvKey] = self._selectIdx - 1
  self:StartTask(self._SwitchAnim, self)
end

function UISeasonMazePickCard:_SwitchAnim(TT)
  local data = self._data[self._curAmount]
  local count = #data
  for i = 1, count do
    if i == self._selectIdx then
      self._cardWigets[i]:PlayAnim("uieff_UISeasonMazePickCardItem_DBout")
      self._cardWigets[i]:PlayAnim("uieff_UISeasonMazePickCardItem_Carout", true)
    else
      self._cardWigets[i]:PlayAnim("uieff_UISeasonMazePickCardItem_Allout")
    end
  end
  self:Lock("UISeasonMazePickCard:_SwitchAnim")
  YIELD(TT, 900)
  self:UnLock("UISeasonMazePickCard:_SwitchAnim")
  if not self.view then
    return
  end
  if self._curAmount >= self._amount then
    self:GetGameObject("cards"):SetActive(false)
    self:_ReqSelect(TT)
  else
    self._curAmount = self._curAmount + 1
    self:_Refresh()
  end
end

function UISeasonMazePickCard:_ReqSelect(TT)
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  self:Lock("UISeasonMazePickCard.HandleSeasonMazeNewHand")
  Log.info("升级选择卡牌结果:", echo(self._selectResults))
  cpt:HandleSeasonMazeNewHand(TT, res, self._selectResults)
  if res:GetSucc() then
    self._anim:Play("uieff_UISeasonMazePickCard_out")
    YIELD(TT, 833)
    if not self.view then
      self:UnLock("UISeasonMazePickCard.HandleSeasonMazeNewHand")
      return
    end
    self:UnLock("UISeasonMazePickCard.HandleSeasonMazeNewHand")
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazePickCardFinish)
    SMazeAdaptor.OnPickCardFinish()
  else
    self:UnLock("UISeasonMazePickCard.HandleSeasonMazeNewHand")
    Log.error("挑选新手牌失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazePickCard:_Refresh()
  self._selectIdx = nil
  if self._tipWidget then
    self._tipWidget:DoHide()
    self._tipHideMask:SetActive(false)
  end
  local data = self._data[self._curAmount]
  local count = #data
  self._cardWigets = self.cards:SpawnObjects("UISeasonMazePickCardItem", count)
  for i = 1, count do
    self._cardWigets[i]:SetData(i, data[i], function(idx, pos)
      self:_OnSeletItem(idx, pos)
    end, function(idx, pos)
      self:_OnShowDetail(idx, pos)
    end)
  end
  self:StartTask(self._EnterAnim, self, count)
end

function UISeasonMazePickCard:_EnterAnim(TT, count)
  self:Lock("UISeasonMazePickCard:_EnterAnim")
  for i = 1, count do
    self._cardWigets[i]:GetGameObject():SetActive(false)
  end
  for i = 1, count do
    self._cardWigets[i]:GetGameObject():SetActive(true)
    self._cardWigets[i]:PlayAnim("uieff_UISeasonMazePickCardItem_in")
    YIELD(TT, 50)
    if not self.view then
      self:UnLock("UISeasonMazePickCard:_EnterAnim")
      return
    end
  end
  YIELD(TT, 620)
  self:UnLock("UISeasonMazePickCard:_EnterAnim")
end

function UISeasonMazePickCard:TipCloseMaskOnClick()
  if self._tipWidget then
    self._tipWidget:DoHide()
  end
  self._tipHideMask:SetActive(false)
end

function UISeasonMazePickCard:GiveUpBtnOnClick()
  if self._tipWidget then
    self._tipWidget:DoHide()
    self._tipHideMask:SetActive(false)
  end
  UISeasonMazeModule.PopMsgBox("", StringTable.Get("str_season_maze_card_giveup"), SeasonMazeMsgBoxType.OkCancel, function()
    local lvKey = self._sourceLv + self._curAmount
    self._selectResults[lvKey] = -1
    if self._curAmount >= self._amount then
      self:StartTask(self._AnimGiveUp, self)
    else
      self._curAmount = self._curAmount + 1
      self:_Refresh()
    end
  end)
end

function UISeasonMazePickCard:_AnimGiveUp(TT)
  if not self.view or not self._cardWigets then
    return
  end
  local data = self._data[self._curAmount]
  local count = #data
  for i = 1, count do
    local widget = self._cardWigets[i]
    if widget then
      widget:PlayAnim("uieff_UISeasonMazePickCardItem_Allout")
    end
  end
  self:Lock("UISeasonMazePickCard:_AnimGiveUp")
  YIELD(TT, 50)
  self:UnLock("UISeasonMazePickCard:_AnimGiveUp")
  if not self.view then
    return
  end
  self:_ReqSelect(TT)
end
