_class("UIHomelandBackpack", UIController)
UIHomelandBackpack = UIHomelandBackpack
local ItemDetailBgTemplate = {
  Default = 1,
  Lv = 2,
  Architecture = 3
}

function UIHomelandBackpack:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetHomelandBackpackData()
  self.mItem = GameGlobal.GetModule(ItemModule)
  self.minShowItemCount = 20
  self.countPerRow = 4
  self.tabMaterial = 1
  self.tabTool = 2
  self.tabArchitecture = 3
  self.tabTree = 4
  self.tabFish = 5
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioOpenBackpack)
  self._atlas = self:GetAsset("UIHomelandBackpack.spriteatlas", LoadType.SpriteAtlas)
  self.keyLockAnim = "UIHomelandBackpackonGetItemByIndex"
end

function UIHomelandBackpack:OnShow(uiParams)
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.tabs = self:GetUIComponent("UISelectObjectPath", "tabs")
  self.sv = self:GetUIComponent("UIDynamicScrollView", "sv")
  self.default = self:GetGameObject("default")
  self.lv = self:GetGameObject("lv")
  self.architecture = self:GetGameObject("architecture")
  self.bgImg = self:GetUIComponent("Image", "bgImg")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.txtCurLv = self:GetUIComponent("UILocalizationText", "txtCurLv")
  self.txtLv = self:GetUIComponent("UILocalizationText", "txtLv")
  self.btnLvUp = self:GetGameObject("btnLvUp")
  self.lvUpRed = self:GetGameObject("lvUpRed")
  self.txtSize = self:GetUIComponent("UILocalizationText", "txtSize")
  self.txtPlace = self:GetUIComponent("UILocalizationText", "txtPlace")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.goUse = self:GetGameObject("btnUse")
  self._btnUseText = self:GetUIComponent("UILocalizationText", "btnUseText")
  self.itemInfo = self:GetGameObject("itemInfo")
  self.empty = self:GetGameObject("empty")
  self.presentMask = self:GetGameObject("PresentTipMask")
  self.presentBtnImage = self:GetUIComponent("Image", "PresentBtn")
  self.presentTip = self:GetGameObject("PresentTip")
  self.presentTipText = self:GetUIComponent("UILocalizationText", "PresentTipText")
  self._safaAreaAnim = self:GetUIComponent("Animation", "SafeArea")
  self.useSv = self:GetGameObject("useSv")
  self.txtUseDesc = self:GetUIComponent("UILocalizationText", "txtUseDesc")
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:AttachEvent(GameEventType.HomelandBackpackFoldFilter, self.FoldFilter)
  self:AttachEvent(GameEventType.HomelandBackpackSelectItem, self.HomelandBackpackSelectItem)
  self:AttachEvent(GameEventType.OnItemUpgrade, self.OnItemUpgrade)
  self.filterId = uiParams[1]
  self.subFilter = uiParams[2]
  self.callback = uiParams[3]
  self.curId = 0
  self:Init()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBackpackFoldFilter, self.filterId or 1)
end

function UIHomelandBackpack:OnHide()
  self.imgIcon:DestoryLastImage()
  self:DetachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:DetachEvent(GameEventType.HomelandBackpackFoldFilter, self.FoldFilter)
  self:DetachEvent(GameEventType.HomelandBackpackSelectItem, self.HomelandBackpackSelectItem)
  self:DetachEvent(GameEventType.OnItemUpgrade, self.OnItemUpgrade)
  if GameGlobal.UIStateManager():IsLocked() then
    self:CancelExpirationLock(self.keyLockAnim)
  end
end

function UIHomelandBackpack:Init()
  self:InitSrollView()
  self:InitFilter()
end

function UIHomelandBackpack:InitFilter()
  local len = table.count(self.data.filters)
  if self.filterId then
    len = 1
  end
  self.tabs:SpawnObjects("UIHomelandBackpackTab", len)
  local uis = self.tabs:GetAllSpawnList()
  local i = 1
  for _, filter in pairs(self.data.filters) do
    if self.filterId then
      if self.filterId == filter.id then
        uis[len]:Init(filter.id)
        break
      end
    else
      uis[i]:Init(filter.id)
      i = i + 1
    end
  end
end

function UIHomelandBackpack:InitSrollView()
  self:CalcList()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 180
  self.sv:InitListView(self.countRC, function(scrollView, index)
    return self:onGetItemByIndex(scrollView, index)
  end, param)
end

function UIHomelandBackpack:onGetItemByIndex(scrollView, index)
  if index < 0 then
    return nil
  end
  local countPerRC = self.countPerRow
  local rowItem = scrollView:NewListViewItem("RowItem")
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", rowItem.gameObject)
  if rowItem.IsInitHandlerCalled == false then
    rowItem.IsInitHandlerCalled = true
    pool:SpawnObjects("UIHomelandBackpackItem", countPerRC)
  end
  local animCount = 0
  local msStep = 75
  local uis = pool:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local idxItem = index * countPerRC + i
    local item = self.list[idxItem]
    local go = ui:GetGameObject()
    if item then
      go:SetActive(true)
      ui:Flush(self.filterId, self:GetItemID(item))
      ui:FlushSelect(self.curId)
      if self._flushingList then
        ui:PlayShowAnim(index, msStep)
        animCount = animCount + 1
      end
    else
      go:SetActive(false)
    end
  end
  if self._flushingList and 0 < animCount then
    self:ExpirationLock(self.keyLockAnim, animCount * msStep + 333)
  end
  return rowItem
end

function UIHomelandBackpack:GetItemID(item)
  if item and item.GetID then
    return item:GetID()
  end
end

function UIHomelandBackpack:GetItemTplID(item)
  if item and item.GetTemplateID then
    return item:GetTemplateID()
  end
end

function UIHomelandBackpack:FlushList()
  self._flushingList = true
  self:CalcList()
  self.sv:SetListItemCount(self.countRC)
  self.sv:MovePanelToItemIndex(0, 0)
  self:FlushTabRed()
  self._flushingList = false
end

function UIHomelandBackpack:FlushCurItem()
  local item = self:GetCurSelectItem()
  if item then
    self.itemInfo:SetActive(true)
    self.empty:SetActive(false)
    local tpl = item:GetTemplate()
    self.txtName:SetText(StringTable.Get(tpl.Name))
    self.imgIcon:LoadImage(tpl.Icon)
    self.txtDesc:SetText(StringTable.Get(tpl.Intro))
    local useDesc = StringTable.Get(tpl.UseDesc)
    if tpl.UseType == ItemUseType.ItemUseType_ManualUse or tpl.IsDecompose then
      local show = true
      if tpl.ItemSubType == ItemSubType.ItemSubType_Seed or tpl.ItemSubType == ItemSubType.ItemSubType_CultivationItem then
        show = self.callback ~= nil
      end
      self.goUse:SetActive(show)
    else
      self.goUse:SetActive(false)
    end
    local useBtnStr = "str_common_use"
    if tpl.IsDecompose and not self.callback then
      useBtnStr = "str_homeland_decompose"
    end
    self._btnUseText:SetText(StringTable.Get(useBtnStr))
    if self.filterId == self.tabMaterial then
      self:FlushCurItemDefault()
      self:FlushUseDesc(ItemDetailBgTemplate.Default, useDesc)
    elseif self.filterId == self.tabTool then
      self:FlushCurItemTool()
      self:FlushUseDesc(ItemDetailBgTemplate.Lv, useDesc)
    elseif self.filterId == self.tabFish then
      self:FlushCurItemFish()
      self:FlushUseDesc(ItemDetailBgTemplate.Architecture, useDesc)
    else
      local tplId = item:GetTemplateID()
      if Cfg.cfg_item_architecture[tplId] then
        self:FlushCurItemArchitecture()
        self:FlushUseDesc(ItemDetailBgTemplate.Architecture, useDesc)
      else
        self:FlushCurItemDefault()
        self:FlushUseDesc(ItemDetailBgTemplate.Default, useDesc)
      end
    end
    self._showPresentTip = false
    self.presentTip:SetActive(false)
    self.presentMask:SetActive(false)
    if self:_CanPresent(item) then
      self.presentBtnImage.sprite = self._atlas:GetSprite("n17_pack_icon07")
    else
      self.presentBtnImage.sprite = self._atlas:GetSprite("n17_pack_icon08")
    end
  else
    self.itemInfo:SetActive(false)
    self.empty:SetActive(true)
  end
end

function UIHomelandBackpack:FormatCount(count)
  if 999999 < count then
    local c = math.floor(count * 0.001) * 0.1
    return StringTable.Get("str_homeland_backpack_n_w", c)
  end
  return tostring(count)
end

function UIHomelandBackpack:FlushCurItemDefault()
  self.default:SetActive(true)
  self.lv:SetActive(false)
  self.architecture:SetActive(false)
  local item = self:GetCurSelectItem()
  local tplId = item:GetTemplateID()
  local curCount = self.mItem:GetItemCount(tplId)
  self.txtCount:SetText(self:FormatCount(curCount))
end

function UIHomelandBackpack:FlushCurItemTool()
  self.default:SetActive(false)
  self.lv:SetActive(true)
  self.architecture:SetActive(false)
  local item = self:GetCurSelectItem()
  local tplId = item:GetTemplateID()
  local toolItem = self.data:GetHomelandBackpackToolItemByTplId(tplId)
  if toolItem then
    local strCurLv = StringTable.Get("str_homeland_backpack_tool_cur_lv")
    if toolItem:IsLevelMax() then
      self.btnLvUp:SetActive(false)
      self.lvUpRed:SetActive(false)
      strCurLv = strCurLv .. "<color=#E8B429>" .. StringTable.Get("str_homeland_backpack_max_lv") .. "</color>"
    else
      self.btnLvUp:SetActive(true)
      local pstId = item:GetID()
      self.lvUpRed:SetActive(self.data:IsItemLvSatisfy(pstId))
    end
    self.txtCurLv:SetText(strCurLv)
    self.txtLv:SetText(toolItem.lv)
  end
end

function UIHomelandBackpack:FlushCurItemArchitecture()
  self.default:SetActive(false)
  self.lv:SetActive(false)
  self.architecture:SetActive(true)
  local item = self:GetCurSelectItem()
  local tplId = item:GetTemplateID()
  local cfg_item_architecture = Cfg.cfg_item_architecture[tplId]
  if cfg_item_architecture then
    local x = cfg_item_architecture.Size[1]
    local y = cfg_item_architecture.Size[2]
    self.txtSize:SetText(x .. "*" .. y)
  else
    self.txtSize:SetText("--")
    Log.error("### no data in cfg_item_architecture. id =", tplId)
  end
  local curCount, placedCount = 0, 0
  curCount, placedCount = UIForgeData.GetOwnPlaceCount(tplId)
  self.txtPlace:SetText(self:FormatCount(placedCount) .. "/" .. self:FormatCount(curCount))
end

function UIHomelandBackpack:FlushCurItemFish()
  self.default:SetActive(false)
  self.lv:SetActive(false)
  self.architecture:SetActive(true)
  self.txtSize:SetText("--")
  local item = self:GetCurSelectItem()
  local tplId = item:GetTemplateID()
  local curCount, placedCount = 0, 0
  curCount = GameGlobal.GetModule(ItemModule):GetItemCount(tplId)
  placedCount = self.mHomeland:GetFishsInBuilding(tplId)
  self.txtPlace:SetText(self:FormatCount(placedCount) .. "/" .. self:FormatCount(curCount))
end

function UIHomelandBackpack:FlushUseDesc(template, useDesc)
  self.useSv:SetActive(useDesc ~= nil)
  if useDesc then
    self.txtUseDesc:SetText(useDesc)
  end
  if template == ItemDetailBgTemplate.Default then
    self.bgImg.sprite = self._atlas:GetSprite(useDesc == nil and "n17_shop_di07" or "n17_pack_di08")
  elseif template == ItemDetailBgTemplate.Lv then
    self.bgImg.sprite = self._atlas:GetSprite(useDesc == nil and "n17_pack_di02" or "n17_pack_di07")
  elseif template == ItemDetailBgTemplate.Architecture then
    self.bgImg.sprite = self._atlas:GetSprite(useDesc == nil and "n17_shop_di10" or "n17_pack_di09")
  end
  self.bgImg:SetNativeSize()
end

function UIHomelandBackpack:CalcList()
  self.list = {}
  for _, item in ipairs(self.data.list) do
    if item:GetTemplate().TabType == self.filterId and (not self.subFilter or self.subFilter(item)) then
      table.insert(self.list, item)
    end
  end
  local len = table.count(self.list)
  if len < self.minShowItemCount then
    for i = len + 1, self.minShowItemCount do
      table.insert(self.list, {})
    end
  end
  self.count = table.count(self.list)
  self.countRC = math.ceil(self.count / self.countPerRow)
end

function UIHomelandBackpack:FoldFilter(id)
  self._safaAreaAnim.enabled = true
  self._safaAreaAnim:Play("UIHomelandBackpack_ui_Switching")
  self._safaAreaAnim:Rewind("UIHomelandBackpack_ui_Switching")
  self.filterId = id
  self:FlushList()
  local pstId = self:GetItemID(self.list[1])
  if pstId then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBackpackSelectItem, pstId)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBackpackSelectItem, 0)
  end
end

function UIHomelandBackpack:FlushTabRed()
  local uis = self.tabs:GetAllSpawnList()
  if not uis then
    return
  end
  if #uis <= 1 then
    local ui = uis[1]
    local isShow = self.data:IsFilterNew(self.filterId)
    ui:FlushRed(isShow)
  else
    local i = 1
    for _, filter in pairs(self.data.filters) do
      local ui = uis[i]
      local isShow = self.data:IsFilterNew(filter.id)
      ui:FlushRed(isShow)
      i = i + 1
    end
  end
end

function UIHomelandBackpack:HomelandBackpackSelectItem(id, byClick, item)
  self.curId = id
  self:FlushCurItem()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if byClick then
    local dataItem = self:GetCurSelectItem()
    if dataItem then
      local tplId = dataItem:GetTemplateID()
      local pstId = dataItem:GetID()
      if dataItem:IsHomelandNew() then
        self:StartTask(function(TT)
          self:Lock("UIHomelandBackpack:HomelandBackpackSelectItem")
          self.ignoreItemCountChangeEvent = true
          self.mItem:SetItemUnnew(TT, pstId)
          self.data:UnnewItem(self.filterId, pstId)
          self:FlushTabRed()
          item:FlushRed()
          self.ignoreItemCountChangeEvent = false
          self:UnLock("UIHomelandBackpack:HomelandBackpackSelectItem")
        end)
      end
    end
  end
end

function UIHomelandBackpack:OnItemUpgrade(tplId)
  if self.list and table.count(self.list) > 0 then
    for _, item in ipairs(self.list) do
      local pstId = self:GetItemID(item)
      local tplId = self:GetItemTplID(item)
      if tplId == tplId then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBackpackSelectItem, pstId)
        break
      end
    end
  end
end

function UIHomelandBackpack:GetCurSelectItem()
  local item = self.data:GetItemById(self.curId)
  return item
end

function UIHomelandBackpack:ItemCountChanged()
  if self.ignoreItemCountChangeEvent then
    return
  end
  self.data:Init()
  local dataItem = self.data:GetItemById(self.curId)
  if not dataItem and self.list[1].GetID then
    self.curId = self.list[1]:GetID()
  end
  self:FlushList()
  self:FlushCurItem()
end

function UIHomelandBackpack:btnBackOnClick(go)
  self:CloseDialog()
end

function UIHomelandBackpack:btnGetFromOnClick(go)
  local item = self:GetCurSelectItem()
  if item then
    self:ShowDialog("UIHomelandGetPath", item:GetTemplateID())
  end
end

function UIHomelandBackpack:btnUseOnClick(go)
  local item = self:GetCurSelectItem()
  local tpl = item:GetTemplate()
  if tpl.UseType ~= ItemUseType.ItemUseType_ManualUse and not tpl.IsDecompose then
    return
  end
  if not self:CheckLessTime(tpl.ID) then
    ToastManager.ShowHomeToast(StringTable.Get("str_item_public_time_out"))
    return
  end
  
  local function UseItem(isGift)
    if item:GetCount() == 1 then
      self:StartTaskUseItem(item, 1, isGift)
    else
      self:ShowDialog("UIHomelandSaleAndUseWithCount", item, EnumItemSaleAndUseState.Use, function(item_data, count)
        self:StartTaskUseItem(item_data, count, isGift)
      end)
    end
  end
  
  if tpl.ItemSubType == ItemSubType.ItemSubType_Base then
    if item:IsAwakeDirectlyItem() then
      self:ShowDialog("UIAwakeDirectly", item, function(data, petID)
        self:StartTaskUseItem(data, 1, false, petID)
      end)
    else
      UseItem(false)
    end
  elseif tpl.ItemSubType == ItemSubType.ItemSubType_Seed or tpl.ItemSubType == ItemSubType.ItemSubType_CultivationItem or tpl.ItemSubType == ItemSubType.ItemSubType_Architecture then
    if self.callback then
      local result = self.callback(item)
      if result then
        self:CloseDialog()
      end
    elseif tpl.IsDecompose then
      self:ShowDialog("UIHomelandDecompose", item)
    end
  else
    local giftType = self.mItem:GetItemGiftType(item:GetTemplateID())
    if giftType ~= ItemGiftType.ItemGiftType_Choose then
      UseItem(true)
    elseif self.mItem:IsChoosePetGift(item:GetTemplateID()) then
      self:ShowDialog("UIPetBackPackBox", item)
    elseif item:GetCount() == 1 then
      self:ShowDialog("UIHomelandBackpackBox", item, 1)
    else
      self:ShowDialog("UIHomelandSaleAndUseWithCount", item, EnumItemSaleAndUseState.Use, function(item_data, count)
        self:ShowDialog("UIHomelandBackpackBox", item_data, count)
      end)
    end
  end
end

function UIHomelandBackpack:CheckLessTime(id)
  local cfg_item = Cfg.cfg_item[id]
  if not cfg_item then
    Log.error("###[UIBackPackItem] cfg is nil ! id --> ", id)
  end
  if not string.isnullorempty(cfg_item.DeadTime) then
    local timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
    if cfg_item.TimeTransform and cfg_item.TimeTransform == 0 then
      timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
    end
    local lessTime = math.floor(self._loginModule:GetTimeStampByTimeStr(cfg_item.DeadTime, timeType))
    local nowTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    local gapTime = lessTime - nowTime
    if gapTime <= 0 then
      return false
    end
  end
  return true
end

function UIHomelandBackpack:StartTaskUseItem(item, count, isGift, param1, param2, param3)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self._lastIndex = self._selectItemIndex
  self:StartTask(self.UseItem, self, item, count, isGift, param1, param2, param3)
end

function UIHomelandBackpack:UseItem(TT, item, count, isGift, param1, param2, param3)
  local key = "UIHomelandBackpack_UseItem"
  self:Lock(key)
  local tpl = item:GetTemplate()
  GameGlobal.UAReportForceGuideEvent("UIBackPackControllerUseItem", {
    tpl.ID or 0
  }, true)
  local tplId = self:GetItemID(item)
  local res, msg = self.mItem:RequestUseItemByPstID(TT, tplId, count, param1, param2, param3)
  self:UnLock(key)
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.m_reward_list
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        self:CloseDialog("UIPetObtain")
        self:ShowDialog("UIHomeShowAwards", msg.m_reward_list, nil, false)
      end)
    elseif msg.m_reward_list and next(msg.m_reward_list) then
      self:ShowDialog("UIHomeShowAwards", msg.m_reward_list, nil, false)
    end
  elseif item.m_template_data.UseEffect == "PhyGift" then
    local stMsg = StringTable.Get("str_physicalpower_error_phy_add_full")
    ToastManager.ShowHomeToast(stMsg)
  else
    Log.fatal("[item] ### UseItem failed :" .. res.m_result)
  end
end

function UIHomelandBackpack:btnLvUpOnClick(go)
  local item = self:GetCurSelectItem()
  local id = self:GetItemID(item)
  self:ShowDialog("UIHomelandToolLevelUp", id)
end

function UIHomelandBackpack:PresentBtnOnClick()
  self._showPresentTip = true
  self.presentTip:SetActive(true)
  self.presentMask:SetActive(true)
  local item = self:GetCurSelectItem()
  if self:_CanPresent(item) then
    self.presentTipText:SetText(StringTable.Get("str_homeland_backpack_gift_can_present"))
  else
    self.presentTipText:SetText(StringTable.Get("str_homeland_backpack_gift_cant_present"))
  end
end

function UIHomelandBackpack:_CanPresent(item)
  local id = item:GetTemplateID()
  local cfg = Cfg.cfg_homeland_gift_item[id]
  return cfg and cfg.PutMaxNum > 0
end

function UIHomelandBackpack:PresentTipMaskOnClick()
  self._showPresentTip = false
  self.presentTip:SetActive(false)
  self.presentMask:SetActive(false)
end

function UIHomelandBackpack:imgIconOnClick(go)
  local item = self:GetCurSelectItem()
  local str = "del_asset h " .. item:GetTemplateID() .. " " .. item:GetCount()
  HelperProxy:GetInstance():CopyString(str)
  Log.fatal(str)
end
