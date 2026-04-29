_class("UIN27LotteryPlot", UIController)
UIN27LotteryPlot = UIN27LotteryPlot
local UIN27LotteryPlotState = {
  locked = 1,
  new = 2,
  read = 3
}
_enum("UIN27LotteryPlotState", UIN27LotteryPlotState)

function UIN27LotteryPlot:Constructor()
  self._idPage = 1
end

function UIN27LotteryPlot:LoadDataOnEnter(TT, res, uiParams)
  self._plots = uiParams[1]
  self._fnCloseInvoke = uiParams[2]
  if self._plots == nil or self._fnCloseInvoke == nil then
    res:SetSucc(false)
  else
    res:SetSucc(true)
  end
end

function UIN27LotteryPlot:OnShow(uiParams)
  self._uiPageUnlocked = self:GetUIComponent("RectTransform", "uiPageUnlocked")
  self._uiPageLocked = self:GetUIComponent("RectTransform", "uiPageLocked")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._newWorkBook = self:GetUIComponent("RectTransform", "newWorkBook")
  self._txtNameValue = self:GetUIComponent("UILocalizationText", "txtNameValue")
  self._turningPoint = self:GetGameObject("turningPoint"):GetComponent("UISelectObjectPath")
  self._imgSnapshotLoader = self:GetUIComponent("RawImageLoader", "imgSnapshot")
  self._senderValue = self:GetUIComponent("UILocalizationText", "senderValue")
  self._receiverValue = self:GetUIComponent("UILocalizationText", "receiverValue")
  self._receiverSignIcon = self:GetUIComponent("Image", "receiverSignIcon")
  self._bookContent = self:GetUIComponent("UILocalizationText", "bookContent")
  self._txtUnlockedDesc = self:GetUIComponent("UILocalizationText", "txtUnlockedDesc")
  self._btnPageLeft = self:GetUIComponent("RectTransform", "btnPageLeft")
  self._btnPageRight = self:GetUIComponent("RectTransform", "btnPageRight")
  self:CreateTurningPoint()
  self:FlushCurrentPage()
  self:TurnPage(self._idPage, self._idPage)
  self:TurnPagePoint(self._idPage, self._idPage)
end

function UIN27LotteryPlot:OnHide()
end

function UIN27LotteryPlot:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIN27LotteryPlot:CreateTurningPoint()
  self._turningPointPool = {}
  for i = 1, self._plots.count do
    local go = self._turningPoint:SpawnOneObject(i - 1)
    self:ResetCellSize(go, Vector2(23, 23))
    local imgPointCur = self:GetChildComponent(go, "Image", "imgPointCur")
    imgPointCur.gameObject:SetActive(false)
    table.insert(self._turningPointPool, {
      structName = "UIN27LotteryPlot::PagePoint",
      root = go,
      animation = go:GetComponent("Animation"),
      imgPointCur = imgPointCur
    })
  end
end

function UIN27LotteryPlot:ResetCellSize(go, cellSize)
  if go == nil then
    return
  end
  local rt = go.transform
  rt.pivot = Vector2.one * 0.5
  rt.localScale = Vector3.one
  rt.anchorMin = Vector2.one * 0.5
  rt.anchorMax = Vector2.one * 0.5
  rt.sizeDelta = cellSize
  rt.anchoredPosition = Vector2.zero
end

function UIN27LotteryPlot:FlushCurrentPage()
  self._idPage = 1
  if self._plots.manualBrowse then
    local idNewState, idReadState
    for i = 1, self._plots.count do
      local v = self._plots[i]
      if v.state == UIN27LotteryPlotState.new then
        idNewState = i
      elseif v.state == UIN27LotteryPlotState.read then
        idReadState = i
      end
    end
    if idNewState ~= nil then
      self._idPage = idNewState
    elseif idReadState ~= nil then
      self._idPage = idReadState
    end
  else
    for i = 1, self._plots.count do
      local v = self._plots[i]
      if self._plots.curPlot == v then
        self._idPage = i
        break
      end
    end
  end
end

function UIN27LotteryPlot:TurnPage(idOldPage, idPage)
  idPage = math.max(idPage, 1)
  idPage = math.min(idPage, self._plots.count)
  self._idPage = idPage
  local current = self._plots[self._idPage]
  local isShowLeft = 1 < self._idPage
  local isShowRight = self._idPage < self._plots.count
  self._btnPageLeft.gameObject:SetActive(isShowLeft)
  self._btnPageRight.gameObject:SetActive(isShowRight)
  self._uiPageUnlocked.gameObject:SetActive(current.state ~= UIN27LotteryPlotState.locked)
  self._uiPageLocked.gameObject:SetActive(current.state == UIN27LotteryPlotState.locked)
  self._newWorkBook.gameObject:SetActive(current.state == UIN27LotteryPlotState.new)
  self._imgSnapshotLoader:LoadImage(current.cfg.RecvIcon)
  self._txtNameValue:SetText(StringTable.Get(current.cfg.BookName))
  self._senderValue:SetText(StringTable.Get(current.cfg.Sender))
  self._receiverValue:SetText(StringTable.Get(current.cfg.Receiver))
  self._bookContent:SetText(StringTable.Get(current.cfg.BookContent))
  local atlas = self:CallUIMethod("UIN27LotteryMain", "GetSpriteAtlas")
  self._receiverSignIcon.sprite = atlas:GetSprite(current.cfg.ReceiverSign)
  if current.state == UIN27LotteryPlotState.locked then
    self._txtNameValue:SetText(StringTable.Get(current.cfg.BookLockedName))
  end
  local levelUp = 600
  if current.cfg.PlotLevel ~= nil then
    levelUp = current.cfg.PlotLevel
  end
  local cost = (levelUp - self._plots.completed) * self._plots.costCount
  cost = math.max(cost, 0)
  local txtUnlockedDesc = StringTable.Get("str_n27_lottery_package_unlock_count", cost)
  self._txtUnlockedDesc:SetText(txtUnlockedDesc)
  if self._plots.manualBrowse and current.state == UIN27LotteryPlotState.new then
    current.state = UIN27LotteryPlotState.read
  elseif current.state == UIN27LotteryPlotState.new then
    current.state = UIN27LotteryPlotState.read
  end
end

function UIN27LotteryPlot:TurnPagePoint(idOldPage, idPage)
  idPage = math.max(idPage, 1)
  idPage = math.min(idPage, self._plots.count)
  self._idPage = idPage
  local tpWidget = self._turningPointPool[idOldPage]
  tpWidget.imgPointCur.gameObject:SetActive(false)
  self:ResetCellSize(tpWidget.root, Vector2(23, 23))
  local tpWidget = self._turningPointPool[self._idPage]
  self:ResetCellSize(tpWidget.root, Vector2(84, 23))
  tpWidget.imgPointCur.gameObject:SetActive(true)
  tpWidget.imgPointCur.transform.anchoredPosition = Vector2.zero
  UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(self._turningPoint.transform)
end

function UIN27LotteryPlot:BtnCloseOnClick(go)
  self:StartTask(function()
    self:Lock("UIN27LotteryPlot:CloseDialog")
    self._animation:Play("uieffanim_UIN27LotteryPlot_out")
    YIELD(TT, 133)
    self:UnLock("UIN27LotteryPlot:CloseDialog")
    self:CloseDialog()
    if self._fnCloseInvoke then
      self:StartTask(self.CloseInvokeTask, self)
    end
  end)
end

function UIN27LotteryPlot:CloseInvokeTask(TT)
  self:Lock("UIN27LotteryPlot:CloseInvoke")
  YIELD(TT, 100)
  self:UnLock("UIN27LotteryPlot:CloseInvoke")
  self._fnCloseInvoke()
end

function UIN27LotteryPlot:BtnPageLeftOnClick(go)
  self:StartTask(self.TurnPageAnimationTask, self, self._idPage, self._idPage - 1)
  self:StartTask(self.TurnPagePointAnimationTask, self, self._idPage, self._idPage - 1)
end

function UIN27LotteryPlot:BtnPageRightOnClick(go)
  self:StartTask(self.TurnPageAnimationTask, self, self._idPage, self._idPage + 1)
  self:StartTask(self.TurnPagePointAnimationTask, self, self._idPage, self._idPage + 1)
end

function UIN27LotteryPlot:TurnPageAnimationTask(TT, idOldPage, idPage)
  self:Lock("UIN27LotteryPlot:TurnPageAnimation")
  self._animation:Play("uieffanim_UIN27LotteryPlot_turn")
  YIELD(TT, 200)
  self:TurnPage(idOldPage, idPage)
  YIELD(TT, 600)
  self:UnLock("UIN27LotteryPlot:TurnPageAnimation")
end

function UIN27LotteryPlot:TurnPagePointAnimationTask(TT, idOldPage, idPage)
  self:Lock("UIN27LotteryPlot:TurnPagePointAnimation")
  local tpWidget = self._turningPointPool[idOldPage]
  if idOldPage < idPage then
    tpWidget.animation:Play("uieffanim_UIN27LotteryTurningpoint_R")
  else
    tpWidget.animation:Play("uieffanim_UIN27LotteryTurningpoint_L")
  end
  YIELD(TT, 400)
  self:TurnPagePoint(idOldPage, idPage)
  self:UnLock("UIN27LotteryPlot:TurnPagePointAnimation")
end

function UIN27LotteryPlot:BtnViewPlotOnClick(go)
  local current = self._plots[self._idPage]
  self:ShowDialog("UIStoryController", current.cfg.PlotID, function()
  end)
end
