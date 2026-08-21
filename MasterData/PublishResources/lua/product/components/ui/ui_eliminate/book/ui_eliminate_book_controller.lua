_class("UIEliminateBookController", UIController)
UIEliminateBookController = UIEliminateBookController

function UIEliminateBookController:Constructor()
  self._pageStatus = nil
  self._itemCountPerRow = 4
  self._isInit = false
  self._taskList = {}
  self._spawnItemList = {}
  self._AsyncLoadFlagMap = {}
  self._selectItemID = nil
  self.ItemColorToText = {
    [ItemColor.ItemColor_White] = "str_item_public_color_white",
    [ItemColor.ItemColor_Green] = "str_item_public_color_green",
    [ItemColor.ItemColor_Blue] = "str_item_public_color_blue",
    [ItemColor.ItemColor_Purple] = "str_item_public_color_purple",
    [ItemColor.ItemColor_Yellow] = "str_item_public_color_yellow",
    [ItemColor.ItemColor_Golden] = "str_item_public_color_golden"
  }
end

function UIEliminateBookController:OnShow(uiParams)
  self._anipopModule = GameGlobal.GetModule(AnipopModule)
  self:_GetComponents()
  self:_InitComponent()
end

function UIEliminateBookController:_GetComponents()
  local topBarPool = self:GetUIComponent("UISelectObjectPath", "CommonTopBar")
  local topBtns = topBarPool:SpawnObject("UINewCommonTopButton")
  topBtns:SetData(function()
    self:_Close()
  end)
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._info = self:GetUIComponent("UILocalizationText", "info")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "Scroll View")
  self._typeTxt = self:GetUIComponent("UILocalizationText", "typeTxt")
  self._levelType = self:GetUIComponent("Image", "levelType")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._select1Obj = self:GetGameObject("select1")
  self._select2Obj = self:GetGameObject("select2")
  self._levelTypeObj = self:GetGameObject("levelType")
  self._eliminateAtlas = self:GetAsset("UIEliminate.spriteatlas", LoadType.SpriteAtlas)
end

function UIEliminateBookController:_InitComponent()
  self:SelectPageStatus(EliminateBookStatus.Page1)
  self._isInit = true
end

function UIEliminateBookController:SelectPageStatus(status)
  if status == self._pageStatus then
    return
  end
  self._spawnItemList = {}
  self._pageStatus = status
  self._selectItemID = nil
  if status == EliminateBookStatus.Page1 then
    self._select1Obj:SetActive(true)
    self._select2Obj:SetActive(false)
    self._spawnCfgs = Cfg.cfg_eliminate_relic_book({Type = 1})
  elseif status == EliminateBookStatus.Page2 then
    self._select1Obj:SetActive(false)
    self._select2Obj:SetActive(true)
    self._spawnCfgs = Cfg.cfg_eliminate_relic_book({Type = 2})
    self._selectItemID = self._spawnCfgs[1].ID
  end
  if self._isInit then
    self:_ResetListView()
  else
    self:_InitScrollView()
  end
  if not self._selectItemID then
    local anipopInfo = self._anipopModule:GetAniPopInfo()
    local relicID = anipopInfo.relic_info.init_skill_relic
    self._selectItemID = Cfg.cfg_eliminate_relic_book({ItemID = relicID})[1].ID
  end
  local selectBookItem = self:_GetItemByID(self._selectItemID)
  selectBookItem:BtnOnClick()
end

function UIEliminateBookController:_Close()
  self:StartTask(function(TT)
    self:Lock("UIEliminateBookController_Close")
    self._anim:Play("uieff_UIEliminateBookController_out")
    YIELD(TT, 200)
    self:UnLock("UIEliminateBookController_Close")
    self:CloseDialog()
  end)
end

function UIEliminateBookController:SetInfo(item)
  self._selectItemID = item:GetID()
  local seleftCfg = item:GetCfg()
  local cfg = Cfg.cfg_item[seleftCfg.ItemID]
  self._icon:LoadImage(cfg.Icon)
  self._title:SetText(StringTable.Get(cfg.Name))
  self._info:SetText(StringTable.Get(cfg.Intro))
  if self._pageStatus == EliminateBookStatus.Page1 then
    self._levelTypeObj:SetActive(false)
    self:Lock("anipopModule:AnipopChangeSkill")
    self:StartTask(function(TT)
      local res = self._anipopModule:AnipopChangeSkill(TT, seleftCfg.ItemID)
      if res:GetSucc() then
        self:RefreshUsing()
        self:UnLock("anipopModule:AnipopChangeSkill")
      else
        Log.fatal("装备初始技能失败！！！", res:GetResult())
        self:UnLock("anipopModule:AnipopChangeSkill")
      end
    end)
  else
    local levelTypeImgTxt = "qdhl_new_pinji0"
    self._levelTypeObj:SetActive(true)
    self._levelType.sprite = self._eliminateAtlas:GetSprite(levelTypeImgTxt .. cfg.Color)
    self._typeTxt:SetText(StringTable.Get(self.ItemColorToText[cfg.Color]))
  end
end

function UIEliminateBookController:SelectBtn1OnClick()
  self:SelectPageStatus(EliminateBookStatus.Page1)
end

function UIEliminateBookController:SelectBtn2OnClick()
  self:SelectPageStatus(EliminateBookStatus.Page2)
end

function UIEliminateBookController:_InitScrollView()
  local totalRow = self:GetSpawnRowNum()
  if self._scrollView then
    self._scrollView:InitListView(totalRow, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
  end
end

function UIEliminateBookController:_InitListView(scrollView, index)
  local anipopInfo = self._anipopModule:GetAniPopInfo()
  local usingID = anipopInfo.relic_info.init_skill_relic
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIEliminateBookItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, table.count(rowList) do
    local bookItem = rowList[i]
    if not bookItem then
      break
    end
    local itemIndex = index * self._itemCountPerRow + i
    table.insert(self._spawnItemList, bookItem)
    self:_ShowBookItem(bookItem, itemIndex, true)
    if self._selectItemID and bookItem:GetID() and self._selectItemID == bookItem:GetID() then
      bookItem:SetSelect(true)
    else
      bookItem:SetSelect(false)
    end
    bookItem:SetUse(false)
    if bookItem:GetID() then
      local itemCfg = Cfg.cfg_eliminate_relic_book[bookItem:GetID()]
      if itemCfg.ItemID == usingID then
        bookItem:SetUse(true)
      end
    end
  end
  return item
end

function UIEliminateBookController:GetHasItemAsyncLoading()
  for _, v in pairs(self._AsyncLoadFlagMap) do
    if v == 1 then
      return true
    end
  end
  return false
end

function UIEliminateBookController:_GetItemByID(id)
  for _, item in pairs(self._spawnItemList) do
    if item:GetID() == id then
      return item
    end
  end
  return nil
end

function UIEliminateBookController:_ShowBookItem(bookItem, index, anim)
  local item_data = self:_GetItemData(index)
  bookItem:SetData(item_data, index, function(item)
    self._selectItemID = item:GetID()
    self:SetInfo(item)
    self:RefreshSelecting()
  end)
  if anim then
    bookItem:PlayFadeInAnim()
  else
    bookItem:ResetInAnim()
  end
end

function UIEliminateBookController:RefreshUsing()
  local anipopInfo = self._anipopModule:GetAniPopInfo()
  local usingID = anipopInfo.relic_info.init_skill_relic
  for _, item in pairs(self._spawnItemList) do
    local id = item:GetID()
    if not id then
      item:SetUse(false)
    else
      local itemCfg = Cfg.cfg_eliminate_relic_book[id]
      if self._pageStatus == EliminateBookStatus.Page1 and itemCfg.ItemID == usingID then
        item:SetUse(true)
      else
        item:SetUse(false)
      end
    end
  end
end

function UIEliminateBookController:RefreshSelecting()
  for _, item in pairs(self._spawnItemList) do
    local id = item:GetID()
    if not id then
      item:SetSelect(false)
    elseif id == self._selectItemID then
      item:SetSelect(true)
    else
      item:SetSelect(false)
    end
  end
end

function UIEliminateBookController:_GetItemData(index)
  return self._spawnCfgs[index]
end

function UIEliminateBookController:_ResetListView()
  local totalRow = self:GetSpawnRowNum()
  self._scrollView:SetListItemCount(totalRow)
  self._scrollView:ResetListView()
  self._scrollView:RefreshAllShownItem()
  self._scrollView:SetListItemCount(totalRow)
end

function UIEliminateBookController:GetSpawnRowNum()
  local totalRow = math.ceil(table.count(self._spawnCfgs) / self._itemCountPerRow)
  return totalRow
end

local EliminateBookStatus = {Page1 = 1, Page2 = 2}
_enum("EliminateBookStatus", EliminateBookStatus)
