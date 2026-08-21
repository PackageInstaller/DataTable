_class("UISeasonExchangeController", UIController)
UISeasonExchangeController = UISeasonExchangeController

function UISeasonExchangeController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:GetGameObject():SetActive(endTime ~= nil)
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function()
    self:_Refresh()
  end)
end

function UISeasonExchangeController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, false, nil)
end

function UISeasonExchangeController:_Back()
  self:_PlayAnim("out", function()
    self:CloseDialog()
  end)
end

function UISeasonExchangeController:_SetSpine()
  if not self._uiCfg then
    return
  end
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  local rt = self:GetUIComponent("RectTransform", "_spine")
  local spineName = self._uiCfg and self._uiCfg.Spine
  if spineName then
    obj:LoadSpine(spineName)
  end
  local spineOffsetY = self._uiCfg.SpineOffsetY
  if spineOffsetY then
    local pos = Vector2(0, spineOffsetY)
    rt.anchoredPosition = pos
  end
end

function UISeasonExchangeController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UISeasonExchangeController:_PlayAnim(type, callback)
  local tb = {
    ["in"] = {
      animName = "uieff_UIS5ExchangeController_in",
      duration = 667
    },
    out = {
      animName = "uieff_UIS5ExchangeController_out",
      duration = 567
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[type].animName, tb[type].duration, callback)
end

function UISeasonExchangeController:_CheckGuide()
end

function UISeasonExchangeController:LoadDataOnEnter(TT, res, uiParams)
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  local reqRes = self._seasonModule:ForceRequestCurSeasonData(TT)
  self._seasonId = self._seasonModule:GetCurSeasonID()
  self._component = self._seasonModule:GetCurSeasonExchangeComponent()
  if reqRes and not reqRes:GetSucc() then
    self._seasonModule:CheckErrorCode(reqRes.m_result, nil, nil)
    res:SetSucc(false)
    return
  end
end

function UISeasonExchangeController:OnShow(uiParams)
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  if self._component == nil then
    return
  end
  self:InitWidgets()
  self._uiCfg = UISeasonHelper.GetCurExchangeCfg()
  local time = self._component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_time", "str_season_main_time_exchange", time)
  self:InitUI()
  self:_SetCommonTopButton()
  self:_SetSpine()
  self:_PlayAnim("in")
  self:_Refresh(true)
  self:_AttachEvents()
end

function UISeasonExchangeController:OnHide()
  self:_DetachEvents()
end

function UISeasonExchangeController:InitWidgets()
  self.goodsBg = self:GetUIComponent("RawImageLoader", "goodsBg")
  self.logoTitle = self:GetUIComponent("RawImageLoader", "logoTitle")
  self.desc = self:GetUIComponent("UILocalizationText", "Desc")
end

function UISeasonExchangeController:InitUI()
  local logoName = self._uiCfg and self._uiCfg.LogoName
  local descKey = self._uiCfg and self._uiCfg.Desc
  if logoName then
    self.logoTitle:LoadImage(logoName)
  end
  if descKey then
    self.desc:SetText(StringTable.Get(descKey))
  end
end

function UISeasonExchangeController:_Refresh(isFirst)
  self:_SetTaken()
  self:_SetTopTips()
  self:_SetDynamicList()
  self:_DynamicListPlayAnimation(isFirst)
end

function UISeasonExchangeController:_SetTaken()
  local itemInfo = self._component:GetExchangeItemSpecial()
  local show = self._component:IsExchangeItemSoldout(itemInfo)
  self:GetGameObject("_taken"):SetActive(show)
end

function UISeasonExchangeController:_SetTopTips()
  local id1, id2 = self._component:GetCostItemId(true), self._component:GetCostItemId(false)
  local tb = {id1, id2}
  local objs = UIWidgetHelper.SpawnObjects(self, "_topTips", "UIS1TopTips", #tb)
  for i, v in ipairs(objs) do
    v:SetData(tb[i])
  end
end

function UISeasonExchangeController:_SetDynamicListData()
  self._infos = UISeasonExchangeHelper.GetExchangeItemList_Sort(self._component)
  self._itemCountPerRow = 1
  self._dynamicListSize = math.floor((table.count(self._infos) - 1) / self._itemCountPerRow + 1)
end

function UISeasonExchangeController:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "DynamicList")
    self._dynamicList:InitListView(self._dynamicListSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListSize, self._dynamicList)
  end
end

function UISeasonExchangeController:_RefreshList(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UISeasonExchangeController:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local idx = index * self._itemCountPerRow + 1
  local isLarge = self._infos[idx].m_is_special
  local prefabName = isLarge and "CellLarge" or "CellSmall"
  local className = "UISeasonExchangeCell"
  local item = scrollView:NewListViewItem(prefabName)
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects(className, self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UISeasonExchangeController:_SetListItemData(item, index)
  local info = self._infos[index]
  item:SetData(index, info, self._seasonId, self._component, self._tipsCallback)
  if info.m_is_special then
    local goodsBgName = self._uiCfg and self._uiCfg.GoodBgName
    if goodsBgName then
      item:SetBigBg(goodsBgName)
    end
  end
end

function UISeasonExchangeController:_DynamicListPlayAnimation(isPlay)
  if isPlay ~= true then
    return
  end
  local showTabIds = self._dynamicList:GetVisibleItemIDsInScrollView()
  for index = 0, showTabIds.Count - 1 do
    local id = math.floor(showTabIds[index])
    local item = self._dynamicList:GetShownItemByItemIndex(id)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local rowList = rowPool:GetAllSpawnList()
    for i = 1, self._itemCountPerRow do
      local listItem = rowList[i]
      local itemIndex = index * self._itemCountPerRow + i
      listItem:PlayAnimationInSequence(itemIndex)
    end
  end
end

function UISeasonExchangeController:SkinBtnOnClick(go)
  local item = self._component:GetExchangeItemSpecial()
  local itemId = item.m_reward.assetid
  self._tipsCallback(itemId)
end

function UISeasonExchangeController:_AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UISeasonExchangeController:_DetachEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UISeasonExchangeController:_CheckActivityClose(id)
  if self._seasonId == id then
    self:CloseDialog()
  end
end
