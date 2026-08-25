local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local T_GridLayoutGroup = typeof(CS.UnityEngine.UI.GridLayoutGroup)
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TOTALNUM = 16
local EmojiMainView, Super = NewClass("EmojiMainView", BaseView)
EmojiMainView.uiResCls = UI_Pvp_Popup_Expression_ManageResource

function EmojiMainView:OnEnterView()
  Super.OnEnterView(self)
  self:_InitViewData()
  self:_RefreshOwnedEmojiGroup()
  self:_RefreshSelectedEmojiGroup()
  self:_RefreshSelectEmojiDetail()
  self:_OnClickBtnEmoji()
end

function EmojiMainView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClickClose))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self._OnClickClose))
  self:AddButtonClickListener(self.ui.Btn_Emoji, System.fn(self, self._OnClickBtnEmoji))
  self:AddButtonClickListener(self.ui.Btn_Emoji_Overview, System.fn(self, self._OnClickBtnEmojiOverview))
end

function EmojiMainView:_OnClickBtnEmoji()
  self:SetButtonChosen(self.ui.Btn_Emoji, true)
  self:SetButtonChosen(self.ui.Btn_Emoji_Overview, false)
  self:SetActive(self.ui.Image_Role, true)
  self:SetActive(self.ui.Image_EmojiStory, false)
  local contentTf = self.ui.ScrollView:GetComponentInParent(T_ScrollRect).content.transform
  contentTf.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
  self._selectIconId = self.groupList[1].emojiList[1].iconId
  for index, group in ipairs(self.groupList or {}) do
    local list = group.emojiList
    for _, emojiData in ipairs(list) do
      emojiData.selecting = false
      local usingData = self:_GetEmojiDataFormList(self.usinglist, emojiData.iconId)
      if usingData then
        emojiData.selected = true
      end
    end
  end
  self.tableView:ReloadData()
end

function EmojiMainView:_OnClickBtnEmojiOverview()
  self:SetButtonChosen(self.ui.Btn_Emoji, false)
  self:SetButtonChosen(self.ui.Btn_Emoji_Overview, true)
  self:SetActive(self.ui.Image_Role, false)
  self:SetActive(self.ui.Image_EmojiStory, true)
  local contentTf = self.ui.ScrollView:GetComponentInParent(T_ScrollRect).content.transform
  contentTf.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
  self._selectIconId = self.groupList[1].emojiList[1].iconId
  for _, group in ipairs(self.groupList) do
    local list = group.emojiList
    for _, emojiData in ipairs(list) do
      emojiData.selected = false
      emojiData.selecting = emojiData.iconId == self._selectIconId
    end
  end
  self.tableView:ReloadData()
  self:_RefreshSelectEmojiDetail()
end

function EmojiMainView:_OnClickRemoveItem(iconId)
  local usingData = self:_GetEmojiDataFormList(self.usinglist, iconId)
  usingData.iconId = 0
  usingData.grayEndTime = 0
  usingData.clickCB = nil
  self:_OptionOwnItem(iconId, false)
  self.rightListCom:UpdateShow()
end

function EmojiMainView:_OnClickAddItem(iconId)
  local targetIconData = self:_GetOwnedEmojiData(iconId)
  RedPointDataUtils.ReqRemoveItemNew(targetIconData.uid)
  if self:_IsInEmojiManagerPage() then
    self:_OnClicAddItemWhenInManagerPage(iconId)
  elseif self:_IsInEmojiDetailPage() then
    self:_OnClicAddItemWhenInDetailPage(iconId)
  end
  self.tableView:Refresh()
end

function EmojiMainView:_OnClicAddItemWhenInManagerPage(iconId)
  for index, group in ipairs(self.groupList) do
    local list = group.emojiList
    local owndata = self:_GetEmojiDataFormList(list, iconId)
    if nil ~= owndata then
      owndata.selected = false
      break
    end
  end
  local usingData = self:_GetEmojiDataFormList(self.usinglist, iconId)
  if usingData then
    self:_OnClickRemoveItem(iconId)
    return
  end
  if self:_GetUsingRealCnt() >= TOTALNUM then
    Alert.Show(10838)
    return
  end
  self:_OptionOwnItem(iconId, true)
  self:_AddData2EmptyPos(iconId)
end

function EmojiMainView:_OnClicAddItemWhenInDetailPage(iconId)
  self:_SetSelectIconId(iconId)
  for index, group in ipairs(self.groupList) do
    local list = group.emojiList
    for _, emojiData in ipairs(list) do
      emojiData.selecting = emojiData.iconId == self._selectIconId
    end
  end
end

function EmojiMainView:_OnClickClose()
  if self.change then
    local list = {}
    for i = 1, TOTALNUM do
      local v = self.usinglist[i]
      if nil == v then
        table.insert(list, 0)
      else
        table.insert(list, v.iconId or 0)
      end
    end
    EmojiController.Instance:ReqUpdateEmojiList(list, function()
      Alert.Show(10842)
    end)
  end
  self:Close()
end

function EmojiMainView:_InitViewData()
  self.groupList = EmojiController.Instance:GetOwnEmojiList()
  local firstGroup = self.groupList and self.groupList[1] or nil
  local firstEmoji = firstGroup and firstGroup.emojiList and firstGroup.emojiList[1] or nil
  self._selectIconId = firstEmoji and firstEmoji.iconId or 0
end

function EmojiMainView:_SetSelectIconId(numVal)
  self._selectIconId = numVal
  self:_RefreshSelectEmojiDetail()
end

function EmojiMainView:_GetOwnedEmojiData(iconId)
  for index, group in ipairs(self.groupList) do
    local list = group.emojiList
    local owndata = self:_GetEmojiDataFormList(list, iconId)
    if owndata then
      return owndata
    end
  end
  return nil
end

function EmojiMainView:_GetEmojiDataFormList(list, iconId)
  for _, v in ipairs(list) do
    if v.iconId == iconId then
      return v
    end
  end
end

function EmojiMainView:_GetUsingRealCnt()
  local cnt = 0
  for _, v in ipairs(self.usinglist) do
    if 0 ~= v.iconId and v.iconId ~= nil then
      cnt = cnt + 1
    end
  end
  return cnt
end

function EmojiMainView:_AddData2EmptyPos(iconId)
  local emptyData
  for _, v in ipairs(self.usinglist) do
    if 0 == v.iconId or v.iconId == nil then
      v.iconId = iconId
      emptyData = v
      break
    end
  end
  if nil == emptyData then
    emptyData = EmojiController.Instance:AddUsingEmoji(iconId)
    table.insert(self.usinglist, emptyData)
  end
  emptyData.clickCB = System.fn(self, self._OnClickRemoveItem)
  self.rightListCom:UpdateShow()
end

function EmojiMainView:_IsInEmojiManagerPage()
  return self.ui.Image_Role.activeSelf
end

function EmojiMainView:_IsInEmojiDetailPage()
  return self.ui.Image_EmojiStory.activeSelf
end

function EmojiMainView:_RefreshSelectedEmojiGroup()
  local usinglist = EmojiController.Instance:GetUsingEmojiList()
  local removeFunc = System.fn(self, self._OnClickRemoveItem)
  for i, v in ipairs(usinglist) do
    v.clickCB = removeFunc
  end
  self.rightListCom = self:AddViewComponentOnce(self.ui.uiNode, EmojiShow_Com, usinglist)
  self.usinglist = usinglist
end

function EmojiMainView:_RefreshOwnedEmojiGroup()
  self:CalcAndCacheSize()
  local groupList = self.groupList
  self.tableView = self:CreateTableview(self.ui.ScrollView, function()
    return #groupList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Pvp_Item_Expression_Manage)
    self:AddViewComponentOnce(cell.gameObject, EmojiGroup_Com, groupList[index], System.fn(self, self._OnClickAddItem))
    return cell
  end, function(view, index)
    return self.CacheSize[index].x, self.CacheSize[index].y
  end)
  self.tableView:ReloadData()
end

function EmojiMainView:_RefreshSelectEmojiDetail()
  if not self:_IsInEmojiDetailPage() then
    return
  end
  local itemCfg = ItemCfgUtils.GetCfg(self._selectIconId)
  if not itemCfg then
    return
  end
  self:SetText(self.ui.Text_EmojiName, LT.Text(itemCfg.Name))
  self:SetText(self.ui.Text_Introduction, LT.Text(itemCfg.Desc))
  self:SetImage(self.ui.Icon_Emoji, itemCfg.Icon)
end

function EmojiMainView:CalcAndCacheSize()
  local cellRT = self.ui.UI_Pvp_Item_Expression_Manage:GetComponent(TYPEOF_RectTransform)
  local tempUI = UI_Pvp_Item_Expression_ManageResource(self.ui.UI_Pvp_Item_Expression_Manage)
  local gridCom = tempUI.Content:GetComponent(T_GridLayoutGroup)
  local colsNum = gridCom.constraintCount
  local ySpace = gridCom.spacing.y
  local itemHeight = gridCom.cellSize.y
  local width, baseheight = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.CacheSize = {}
  for index, group in ipairs(self.groupList) do
    self.CacheSize[index] = {}
    local dataCnt = #group.emojiList
    local rowNum = math.ceil(dataCnt / colsNum)
    local realH = rowNum * itemHeight + (rowNum - 1) * ySpace + baseheight
    self.CacheSize[index].x = width
    self.CacheSize[index].y = realH + 30
  end
end

function EmojiMainView:_OptionOwnItem(iconId, selected)
  self.change = true
  for index, group in ipairs(self.groupList) do
    local list = group.emojiList
    local owndata = self:_GetEmojiDataFormList(list, iconId)
    if nil ~= owndata then
      owndata.selected = selected
      self.tableView:Refresh()
      break
    end
  end
end

return EmojiMainView
