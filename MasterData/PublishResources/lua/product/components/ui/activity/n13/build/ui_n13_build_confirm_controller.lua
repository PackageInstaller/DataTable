_class("UIN13BuildConfirmController", UIController)
UIN13BuildConfirmController = UIN13BuildConfirmController

function UIN13BuildConfirmController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN13BuildConfirmController:_SpawnObjects(widgetName, className, count)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local objs = {}
  pool:SpawnObjects(className, count, objs)
  return objs
end

function UIN13BuildConfirmController:_SetRawImage(widgetName, url)
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(url)
end

function UIN13BuildConfirmController:_SetText(widgetName, txt)
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(txt)
end

function UIN13BuildConfirmController:OnShow(uiParams)
  self._buildManager = uiParams[1]
  self._buildItemId = uiParams[2]
  if uiParams[3] then
    self._reviewType = uiParams[3]
  else
    self._reviewType = nil
  end
  self._component = self._buildManager._buildComponent
  self._isOpen = true
  local curStatus = self._buildManager:GetBuildCurStatus(self._buildItemId)
  local type = curStatus == UIBuildComponentBuildStatus.Init and 1 or 2
  self:_SetTitleText(type)
  self:_SetBtnText(type)
  self:_SetScore(self._reviewType)
  self:_SetChangeImage(self._buildItemId)
  self:_SetCost(self._buildItemId)
end

function UIN13BuildConfirmController:OnHide()
  self._isOpen = false
end

function UIN13BuildConfirmController:_SetTitleText(type)
  local tb = {
    "str_n13_build_tips_title",
    "str_n13_build_deco_tips_title"
  }
  self:_SetText("_title", StringTable.Get(tb[type]))
end

function UIN13BuildConfirmController:_SetBtnText(type)
  local tb = {
    "str_n13_build_tips_btn",
    "str_n13_build_deco_tips_btn"
  }
  self:_SetText("_txtBuild", StringTable.Get(tb[type]))
  self:_SetText("_txtBuild2", StringTable.Get(tb[type]))
end

function UIN13BuildConfirmController:_SetScore(reviewType)
  local obj = self:_SpawnObject("_score", "UIN13BuildScore")
  obj:SetData(reviewType)
end

function UIN13BuildConfirmController:_SetChangeImage(buildItemId)
  local curStatus = self._buildManager:GetBuildCurStatus(buildItemId)
  local nextStatus = self._buildManager:GetBuildNextStatus(buildItemId, curStatus)
  local curData = self._buildManager._buildItemData:GetBuildItemData(buildItemId, curStatus)
  local nextData = self._buildManager._buildItemData:GetBuildItemData(buildItemId, nextStatus)
  local name = self._buildManager:GetName(buildItemId)
  local curStr = StringTable.Get("str_n13_build_confirm_old", name)
  local nextStr = StringTable.Get("str_n13_build_confirm_new", name)
  self:_SetText("_oldTxt", curStr)
  self:_SetText("_newTxt", nextStr)
  local curTips = self._buildManager._buildItemData:GetTipsIcon(curData)
  local nextTips = self._buildManager._buildItemData:GetTipsIcon(nextData)
  self:_SetRawImage("_oldImage", curTips)
  self:_SetRawImage("_newImage", nextTips)
end

function UIN13BuildConfirmController:_SetCost(buildItemId)
  local url = UIActivityN13Helper.GetCoinItemIconName(self._reviewType)
  self._cost = self._buildManager:GetCostCount(buildItemId) or 0
  self:_SetRawImage("_icon", url)
  self:_SetText("_cost", self._cost)
  self:_SetText("_cost2", self._cost)
  local itemCount = UIActivityN13Helper.GetCoinItemCount(self._reviewType)
  local idx = itemCount >= self._cost and 1 or 2
  local tb = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_cost", "_txtBuild"},
    {"_cost2", "_txtBuild2"}
  })
  UIWidgetHelper.SetObjGroupShow(tb, idx)
end

function UIN13BuildConfirmController:Building()
  local curStatus = self._buildManager:GetBuildCurStatus(self._buildItemId)
  local nextStatus = self._buildManager:GetBuildNextStatus(self._buildItemId, curStatus)
  if not nextStatus then
    self:CloseDialog()
    return
  end
  local storyType = self._buildManager:GetCompleteStoryType(self._buildItemId)
  local storyId = self._buildManager:GetCompleteStoryId(self._buildItemId)
  self._component:Start_HandleBuild(self._buildItemId, nextStatus, function(res, rewardList)
    self:_OnBuild(res, rewardList, storyType, storyId, curStatus, self._buildItemId)
  end)
end

function UIN13BuildConfirmController:_OnBuild(res, rewardList, storyType, storyId, status, buildItemId)
  self:CloseDialog()
  if res:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingAllBuildingComplete)
    if storyId and 0 < storyId then
      local storyInfo = {
        storyType,
        storyId,
        status,
        buildItemId
      }
      UIActivityN13Helper.PlayStory_Build(self._component, storyInfo, function()
        self:StartTask(self._PlayOut, self, buildItemId, rewardList)
      end)
    else
      self:StartTask(self._PlayOut, self, buildItemId, rewardList)
    end
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingMainRefresh)
    Log.error("UIN13BuildConfirmController:_OnBuild() error")
  end
end

function UIN13BuildConfirmController:_PlayOut(TT, buildItemId, rewardList)
  local lockName = "UIN13BuildConfirmController:_PlayOut"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingBuildingComplete, buildItemId)
  YIELD(TT, 1500)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingMainRefresh)
  YIELD(TT, 200)
  GameGlobal.UIStateManager():UnLock(lockName)
  UIActivityHelper.ShowUIGetRewards(rewardList)
end

function UIN13BuildConfirmController:CloseBtnOnClick()
  self:CloseDialog()
end

function UIN13BuildConfirmController:CancelBtnOnClick()
  self:CloseDialog()
end

function UIN13BuildConfirmController:BuildingBtnOnClick()
  local itemCount = UIActivityN13Helper.GetCoinItemCount(self._reviewType)
  if itemCount < self._cost then
    ToastManager.ShowToast(StringTable.Get("str_n13_build_tips_item_count_not_enouth"))
    return
  end
  self:Building()
end
