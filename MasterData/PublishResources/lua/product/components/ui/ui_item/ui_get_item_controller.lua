_class("UIGetItemController", UIController)
UIGetItemController = UIGetItemController

function UIGetItemController:OnShow(uiParams)
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
  self._titleText2 = self:GetUIComponent("UILocalizationText", "txt_title2")
  self._titleText_zh = self:GetUIComponent("UILocalizationText", "txt_title_zh")
  self._titleText2_zh = self:GetUIComponent("UILocalizationText", "txt_title2_zh")
  self._titleTextGo = self:GetGameObject("txt_title")
  self._titleTextGo2 = self:GetGameObject("txt_title2")
  self._titleTextGo_zh = self:GetGameObject("txt_title_zh")
  self._titleTextGo2_zh = self:GetGameObject("txt_title2_zh")
  local en_go = self:GetGameObject("en_title")
  local zh_go = self:GetGameObject("zh_title")
  local t1, t2, t1go, t2go
  local type = Localization.GetCurLanguage()
  en_go:SetActive(type == LanguageType.us)
  zh_go:SetActive(type ~= LanguageType.us)
  if type == LanguageType.us then
    t1 = self._titleText
    t2 = self._titleText2
    t1go = self._titleTextGo
    t2go = self._titleTextGo2
  else
    t1 = self._titleText_zh
    t2 = self._titleText2_zh
    t1go = self._titleTextGo_zh
    t2go = self._titleTextGo2_zh
  end
  if t1 and uiParams[5] then
    local txt = uiParams[5]
    if txt == "" then
      t1go:SetActive(false)
      t2go:SetActive(false)
    else
      t1go:SetActive(true)
      t2go:SetActive(true)
      t1:SetText(txt)
      t2:SetText(txt)
    end
  end
  self._itemList = {}
  self._beforeTime = 200
  self._inited = false
  local item_module = GameGlobal.GetModule(ItemModule)
  local itemlist
  if uiParams[1] then
    if table.count(uiParams[1]) == 0 then
      Log.fatal("###[UIGetItemController] table.count(uiParams[1]) == 0 !")
    end
  else
    Log.fatal("###[UIGetItemController] uiParams[1] is nil !")
  end
  if uiParams[3] then
    itemlist = uiParams[1]
  else
    itemlist = item_module:SortRoleAsset(uiParams[1])
  end
  self:_SortHeartStone(itemlist)
  self._getMainBgList = {}
  for i = 1, table.count(itemlist) do
    local itemData = itemlist[i]
    if itemData.isSeasonMazeAtt then
      self._itemList[i] = {
        item_id = itemData.attType,
        item_count = itemData.count,
        item_des = nil,
        award_type = itemData.type,
        heartstone = itemData.heartstone,
        icon = itemData.icon,
        item_name = itemData.name,
        simple_desc = nil,
        color = itemData.quality,
        effectType = itemData.effectType,
        attType = itemData.attType,
        isSeasonMazeAtt = true
      }
    else
      local ItemTempleate = Cfg.cfg_item[itemData.assetid]
      if ItemTempleate then
        self._itemList[i] = {
          item_id = itemData.assetid,
          item_count = itemData.count,
          item_des = itemData.des,
          award_type = itemData.type,
          heartstone = itemData.heartstone,
          icon = ItemTempleate.Icon,
          item_name = ItemTempleate.Name,
          simple_desc = ItemTempleate.RpIntro,
          color = ItemTempleate.Color
        }
        if ItemTempleate.ItemSubType == ItemSubType.ItemSubType_BackGroudPicture then
          table.insert(self._getMainBgList, itemData.assetid)
        end
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

function UIGetItemController:_SortHeartStone(itemlist)
  for _, value in pairs(itemlist) do
    if value.heartstone then
      table.removev(itemlist, value)
      table.insert(itemlist, 1, value)
      break
    end
  end
end

function UIGetItemController:DoAnimation()
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "canvasGroup")
  self._canvasGroup.alpha = 0
  self._tweener = self._canvasGroup:DOFade(1, 0.02)
end

function UIGetItemController:ClosePanel()
  if #self._getMainBgList > 0 then
    self._mainBgPanel:SetActive(true)
    self:ShowMainBgList()
  else
    self:CloseDialog()
  end
end

function UIGetItemController:ShowMainBgList()
  if #self._getMainBgList > 0 then
    local mainBgID = self._getMainBgList[1]
    table.remove(self._getMainBgList, 1)
    self:ShowMainBgUnit(mainBgID)
  else
    self:CloseDialog()
  end
end

function UIGetItemController:ShowMainBgUnit(id)
  local cfg_main_bg = Cfg.cfg_main_bg({ItemID = id})
  if cfg_main_bg and table.count(cfg_main_bg) > 0 then
    local cg = cfg_main_bg[1].BG
    self._mainBgIcon:LoadImage(cg)
  else
    Log.fatal("###[UIGetItemController] cfg_main_bg is nil ! itemid --> " .. id)
  end
end

function UIGetItemController:mainBgPanelOnClick(go)
  self:ShowMainBgList()
end

function UIGetItemController:OnHide()
  Log.debug("关闭获取物品界面")
  if self._closeCallback then
    Log.debug("关闭回调调用")
    self._closeCallback()
  end
end

function UIGetItemController:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local count = table.count(self._itemList)
  if 5 < count then
    count = 5
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    self:_SpawnGetItemControllerItem(rowPool, count)
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

function UIGetItemController:_SpawnGetItemControllerItem(rowPool, count)
  rowPool:SpawnObjects("UIGetItemControllerItem", count)
end

function UIGetItemController:_GetItemCallBack()
  local function callback(id, pos)
    self:OnItemSelect(id, pos)
  end
  
  return callback
end

function UIGetItemController:_ShowItem(giftItem, index, tweenIdx)
  local beforeTime = 0
  if not self._inited then
    beforeTime = self._beforeTime
  end
  local item_data = self:_GetItemDataByIndex(index)
  if item_data then
    giftItem:SetData(item_data, index, self:_GetItemCallBack(), Color(0.2039, 0.2039, 0.2039, 1), tweenIdx, beforeTime)
    giftItem:GetGameObject():SetActive(true)
  else
    giftItem:GetGameObject():SetActive(false)
  end
end

function UIGetItemController:OnItemSelect(id, pos)
  if not self._selectInfo then
    self._selectInfo = self.selectInfoPool:SpawnObject("UISelectInfo")
  end
  local isSeasonMazeAtt = false
  local seasonMazeEffectType, seasonMazeAttrType
  for _, value in pairs(self._itemList) do
    if value.item_id == id then
      if value.isSeasonMazeAtt then
        isSeasonMazeAtt = value.isSeasonMazeAtt
        seasonMazeEffectType = value.effectType
        seasonMazeAttrType = value.attType
      end
      break
    end
  end
  if isSeasonMazeAtt then
    local effect = SeasonMazeEffect:New()
    effect.type = seasonMazeEffectType
    effect.id = seasonMazeAttrType
    effect.value_min = self:_GetSeasonMazeAttCount(seasonMazeEffectType, seasonMazeAttrType)
    effect.value_max = effect.value_min
    self._selectInfo:SetSeasonMazeData(effect, effect.value_min, pos)
  else
    self._selectInfo:SetData(id, pos)
  end
end

function UIGetItemController:_GetSeasonMazeAttCount(effectType, id)
  local count = 0
  if effectType and id then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    local seasonMazeObj = seasonMazeModule:CurSeasonObj()
    if seasonMazeObj then
      local component = seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
      if component then
        count = component:GetEffectNum(effectType, id)
      end
    end
  end
  return count
end

function UIGetItemController:NextOnClick(go)
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

function UIGetItemController:CalcPage()
  local pageCount, mod = modf(self._listItemTotalCount / self._listPerPageCount)
  if mod ~= 0 then
    pageCount = pageCount + 1
  end
  self._listPageCount = pageCount
end

function UIGetItemController:_GetNextPageIndex()
  local index = self._curItemPage * self._listPerPageCount + 1
  if index <= self._listItemTotalCount then
    self._curItemPage = self._curItemPage + 1
    self._curPageFirstIndex = index
    return index
  end
  return -1
end

function UIGetItemController:_GetCurPageFirstIndex()
  return self._curPageFirstIndex
end

function UIGetItemController:_GetItemDataByIndex(index)
  if index > #self._itemList then
    return nil
  end
  return self._itemList[index]
end

function UIGetItemController:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end
