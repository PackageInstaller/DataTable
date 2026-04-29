_class("UIActivityValentineGetController", UIController)
UIActivityValentineGetController = UIActivityValentineGetController

function UIActivityValentineGetController:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self._listPerPageCount = 5
  self._curItemPage = 1
  self._curPageFirstIndex = 1
  self._listPageCount = 0
  self._listItemTotalCount = 0
  self._mainBgIcon = self:GetUIComponent("RawImageLoader", "mainBgIcon")
  self._mainBgPanel = self:GetGameObject("mainBgPanel")
  self._mainBgPanel:SetActive(false)
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ItemList")
  self.selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._bg = self:GetUIComponent("RectTransform", "canvasGroup")
  self._bg.localScale = Vector3(1, 1, 1)
  self._actTipsText = self:GetUIComponent("RollingText", "txt_activity_tips")
  self._actTipsGo = self:GetGameObject("ActivityTipsArea")
  self._anim = self:GetUIComponent("Animation", "anim")
  if self._actTipsGo then
    if uiParams[4] then
      local txt = uiParams[4]
      if txt == "" then
        self._actTipsGo:SetActive(false)
      else
        self._actTipsGo:SetActive(true)
        self._actTipsText:RefreshText(txt)
      end
    else
      self._actTipsGo:SetActive(false)
    end
  end
  self._titleText = self:GetUIComponent("UILocalizationText", "txt_title")
  self._titleTextGo = self:GetGameObject("txt_title")
  if self._titleText and uiParams[5] then
    local txt = uiParams[5]
    if txt == "" then
      self._titleTextGo:SetActive(false)
    else
      self._titleTextGo:SetActive(true)
      self._titleText:SetText(txt)
    end
  end
  self._itemList = {}
  self._beforeTime = 200
  self._inited = false
  local item_module = GameGlobal.GetModule(ItemModule)
  local itemlist
  if uiParams[1] then
    if table.count(uiParams[1]) == 0 then
      Log.fatal("###[UIActivityValentineGetController] table.count(uiParams[1]) == 0 !")
    end
  else
    Log.fatal("###[UIActivityValentineGetController] uiParams[1] is nil !")
  end
  if uiParams[3] then
    itemlist = uiParams[1]
  else
    itemlist = item_module:SortRoleAsset(uiParams[1])
  end
  self._getMainBgList = {}
  for i = 1, table.count(itemlist) do
    local ItemTempleate = Cfg.cfg_item[itemlist[i].assetid]
    if ItemTempleate then
      self._itemList[i] = {
        item_id = itemlist[i].assetid,
        item_count = itemlist[i].count,
        item_des = itemlist[i].des,
        award_type = itemlist[i].type,
        icon = ItemTempleate.Icon,
        item_name = ItemTempleate.Name,
        simple_desc = ItemTempleate.RpIntro,
        color = ItemTempleate.Color
      }
      if ItemTempleate.ItemSubType == ItemSubType.ItemSubType_BackGroudPicture then
        table.insert(self._getMainBgList, itemlist[i].assetid)
      end
    end
  end
  self._listItemTotalCount = table.count(self._itemList)
  self:CalcPage()
  self._selectItemIndex = -1
  if self._scrollView then
    self._scrollView:InitListView(1, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
    self._inited = true
  end
  local bgCanvas = self:GetUIComponent("Canvas", "BGCanvas")
  self._blur = self:GetUIComponent("H3DUIBlurHelper", "Blur")
  self._blur.OwnerCamera = bgCanvas.worldCamera
  self._blur:RefreshBlurTexture()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
end

function UIActivityValentineGetController:DoAnimation()
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "canvasGroup")
  self._canvasGroup.alpha = 0
  self._tweener = self._canvasGroup:DOFade(1, 0.02)
end

function UIActivityValentineGetController:ClosePanel()
  if #self._getMainBgList > 0 then
    self._mainBgPanel:SetActive(true)
    self:ShowMainBgList()
  else
    self:StartTask(self._Close, self)
  end
end

function UIActivityValentineGetController:ShowMainBgList()
  if #self._getMainBgList > 0 then
    local mainBgID = self._getMainBgList[1]
    table.remove(self._getMainBgList, 1)
    self:ShowMainBgUnit(mainBgID)
  else
    self:StartTask(self._Close, self)
  end
end

function UIActivityValentineGetController:ShowMainBgUnit(id)
  local cfg_main_bg = Cfg.cfg_main_bg({ItemID = id})
  if cfg_main_bg and table.count(cfg_main_bg) > 0 then
    local cg = cfg_main_bg[1].BG
    self._mainBgIcon:LoadImage(cg)
  else
    Log.fatal("###[UIActivityValentineGetController] cfg_main_bg is nil ! itemid --> " .. id)
  end
end

function UIActivityValentineGetController:MainBgPanelOnClick(go)
  self:ShowMainBgList()
end

function UIActivityValentineGetController:OnHide()
end

function UIActivityValentineGetController:_Close(TT)
  self:Lock("UIActivityValentineGetController_Close")
  self._anim:Play("uieff_UIActivityValentineGetController_SafeArea_out")
  YIELD(TT, 500)
  if self._closeCallback then
    Log.debug("关闭回调调用")
    self._closeCallback()
  end
  self:UnLock("UIActivityValentineGetController_Close")
  self:CloseDialog()
end

function UIActivityValentineGetController:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local count
  if table.count(self._itemList) > 5 then
    count = 5
  else
    count = table.count(self._itemList)
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityValentineGetItem", count)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, count do
    local giftItem = rowList[i]
    local itemIndex = self:_GetCurPageFirstIndex() + i - 1
    if itemIndex > self._listItemTotalCount then
      giftItem:GetGameObject():SetActive(false)
    else
      self:_ShowItem(giftItem, itemIndex, i)
    end
  end
  return item
end

function UIActivityValentineGetController:_ShowItem(giftItem, index, tweenIdx)
  local beforeTime = 0
  if not self._inited then
    beforeTime = self._beforeTime
  end
  local item_data = self:_GetItemDataByIndex(index)
  if item_data then
    giftItem:SetData(item_data, index, function(id, pos)
      self:OnItemSelect(id, pos)
    end, Color(1, 1, 1, 1), tweenIdx, beforeTime)
    giftItem:GetGameObject():SetActive(true)
  else
    giftItem:GetGameObject():SetActive(false)
  end
end

function UIActivityValentineGetController:OnItemSelect(id, pos)
  if not self._selectInfo then
    self._selectInfo = self.selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(id, pos)
end

function UIActivityValentineGetController:NextOnClick(go)
  if self._selectItemIndex ~= -1 then
    self._selectItemIndex = -1
  elseif self:_GetNextPageIndex() ~= -1 then
    self._scrollView:RefreshAllShownItem()
    self._selectItemIndex = -1
  else
    self:ClosePanel()
  end
end

local modf = math.modf

function UIActivityValentineGetController:CalcPage()
  local pageCount, mod = modf(self._listItemTotalCount / self._listPerPageCount)
  if mod ~= 0 then
    pageCount = pageCount + 1
  end
  self._listPageCount = pageCount
end

function UIActivityValentineGetController:_GetNextPageIndex()
  local index = self._curItemPage * self._listPerPageCount + 1
  if index <= self._listItemTotalCount then
    self._curItemPage = self._curItemPage + 1
    self._curPageFirstIndex = index
    return index
  end
  return -1
end

function UIActivityValentineGetController:_GetCurPageFirstIndex()
  return self._curPageFirstIndex
end

function UIActivityValentineGetController:_GetItemDataByIndex(index)
  if index > #self._itemList then
    return nil
  end
  return self._itemList[index]
end

function UIActivityValentineGetController:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end
