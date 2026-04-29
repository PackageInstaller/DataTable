_class("UIHomelandBuildEdit", UICustomWidget)
UIHomelandBuildEdit = UIHomelandBuildEdit

function UIHomelandBuildEdit:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.mItem = GameGlobal.GetModule(ItemModule)
  self.liveableRaw = self.mHomeland:GetAmbientValue()
  self.liveable = self.liveableRaw
  self.list = {}
  self.quaternionShowHide = Quaternion.identity
  self.curFilterId = 0
  self.curFilterChildId = 100
  self.doDragBuildingIntoScene = false
  self.newFilters = {}
  self.allFilterID = 100
  self._firstShow = true
  self.skins = {}
  self._needSave = false
  self._tplIDSubTypeCache = {}
  self.filterID2SubType = {}
  self.filterID2SubType[UIHomelandBuildEdit.MainBuildingFilterID] = ArchitectureSubType.White_Tower
  self.filterID2SubType[UIHomelandBuildEdit.MuseumFilterID] = ArchitectureSubType.Museum
  self.filterID2SubType[UIHomelandBuildEdit.ShopFilterID] = ArchitectureSubType.Shop
  self.filterID2SubType[UIHomelandBuildEdit.WishingPoolFilterID] = ArchitectureSubType.Wishing_Pool
end

function UIHomelandBuildEdit:OnShow()
  self.txtLivable = self:GetUIComponent("UILocalizationText", "txtLivable")
  self.tglGrid = self:GetUIComponent("Toggle", "tglGrid")
  
  function self.OnValueChanged(isOn)
    self.homeBuildManager:ShowGrid(isOn)
  end
  
  self.tglGrid.onValueChanged:AddListener(self.OnValueChanged)
  self.arrange = self:GetGameObject("arrange")
  self.arrangeTitle = self:GetGameObject("arrangeTitle")
  self.operate = self:GetGameObject("operate")
  self.changeSkin = self:GetGameObject("changeSkin")
  self.saveBtn = self:GetGameObject("imgSave")
  self.noItem = self:GetGameObject("noItem")
  self.moreGo = self:GetGameObject("more")
  self.lessGo = self:GetGameObject("less")
  self.moreValue = self:GetUIComponent("UILocalizationText", "moreValue")
  self.lessValue = self:GetUIComponent("UILocalizationText", "lessValue")
  self._animPlayer = EZTL_Player:New()
  local camera = GameGlobal.UIStateManager():GetControllerCamera("UIHomelandBuild")
  self._sr = self:GetUIComponent("ScrollRect", "sv")
  self._svHelper = H3DScrollViewHelper:New(self, "sv", "UIHomelandBuildEditItem", function(index, ui)
    ui:Init(camera, BuildEditListType.BT_Default)
    ui:SetDragItem(self.goDragItem, self.poolDragItem, self.dragItem)
    ui:Flush(self.list[index]:GetTemplateID())
    return ui
  end, nil, nil)
  self._svHelper:SetCalcScale(false)
  self._svHelper:SetEndSnappingCallback(nil)
  self._svHelper:SetItemPassSnapPosCallback(nil)
  self.imgShowHideList = self:GetUIComponent("RectTransform", "imgShowHideList")
  self.listBG = self:GetGameObject("listBG")
  self.goList = self:GetGameObject("goList")
  self.rectList = self:GetUIComponent("RectTransform", "goList")
  self.tabs1 = self:GetUIComponent("UISelectObjectPath", "tabs1")
  self.tabs2 = self:GetUIComponent("UISelectObjectPath", "tabs2")
  self.goDragItem = self:GetGameObject("dragItem")
  self.goDragItem:SetActive(false)
  self.poolDragItem = self:GetUIComponent("UISelectObjectPath", "dragItem")
  self.dragItem = self:GetUIComponent("RectTransform", "dragItem")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.goTakeIn = self:GetGameObject("imgTakeIn")
  self.goRotate = self:GetGameObject("imgRotate")
  self.goConfirm = self:GetGameObject("imgConfirm")
  self._rotateImg = self:GetUIComponent("Image", "rotateimg")
  self:AttachEvent(GameEventType.HomeBuildOnAmbientChanged, self.HomeBuildOnAmbientChanged)
  self:AttachEvent(GameEventType.HomeBuildOnSelectBuilding, self.HomeBuildOnSelectBuilding)
  self:AttachEvent(GameEventType.HomelandBuildFilterTab1, self.HomelandBuildFilterTab1)
  self:AttachEvent(GameEventType.HomelandBuildFilterTab2, self.HomelandBuildFilterTab2)
  self:AttachEvent(GameEventType.HomelandShowHideDragItem, self.HomelandShowHideDragItem)
  self:AttachEvent(GameEventType.DragBuildingIntoScene, self.DragBuildingIntoScene)
  self:AttachEvent(GameEventType.HomelandRefreshBuildFilterNew, self.OnItemNewClear)
  self:AttachEvent(GameEventType.HomelandBuildChangeSkin, self.OnChangeSkin)
  self:AttachEvent(GameEventType.OnHomeBuildRotateOpen, self.OnOpenRotate)
  self.txtLivable:SetText(self.liveable)
  self.moreGo:SetActive(false)
  self.lessGo:SetActive(false)
  self.tglGrid.isOn = false
  self:HomeBuildOnSelectBuilding()
  self:OnOpenRotate(false)
end

function UIHomelandBuildEdit:OnHide()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
  self._svHelper:Dispose()
  self.tglGrid.onValueChanged:RemoveListener(self.OnValueChanged)
  self.tglGrid = nil
  if self._animPlayer and self._animPlayer:IsPlaying() then
    self._animPlayer:Stop()
    self._animPlayer = nil
  end
  self:DetachEvent(GameEventType.HomeBuildOnAmbientChanged, self.HomeBuildOnAmbientChanged)
  self:DetachEvent(GameEventType.HomeBuildOnSelectBuilding, self.HomeBuildOnSelectBuilding)
  self:DetachEvent(GameEventType.HomelandBuildFilterTab1, self.HomelandBuildFilterTab1)
  self:DetachEvent(GameEventType.HomelandBuildFilterTab2, self.HomelandBuildFilterTab2)
  self:DetachEvent(GameEventType.HomelandShowHideDragItem, self.HomelandShowHideDragItem)
  self:DetachEvent(GameEventType.DragBuildingIntoScene, self.DragBuildingIntoScene)
  self:DetachEvent(GameEventType.HomelandRefreshBuildFilterNew, self.OnItemNewClear)
  self:DetachEvent(GameEventType.HomelandBuildChangeSkin, self.OnChangeSkin)
end

function UIHomelandBuildEdit:FlushArrange()
  self:FlushTabNews()
  self:FlushTabs1()
  self:FlushTabs2()
  if self._firstShow then
    self:FlushList()
    self._firstShow = false
  else
    self:FlushListNoMove()
  end
end

function UIHomelandBuildEdit:OnItemNewClear()
  self:FlushTabNews()
  local filters = UIHomelandBuildEdit.GetBuildFilters()
  local uis = self.tabs1:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local item = filters[i]
    if item then
      ui:SetNew(self.newFilters[item.id])
    end
  end
  local filter = UIHomelandBuildEdit.GetBuildFilterById(self.curFilterId)
  local uis = self.tabs2:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local item = filter.children[i]
    if item then
      ui:SetNew(self.newFilters[item.id])
    end
  end
end

function UIHomelandBuildEdit:FlushOperate()
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  self.txtName:SetText(UIHomelandBuildEdit.GetBuildingName(homeBuilding:GetBuildId()))
  if not homeBuilding:ShowDeleteBtn() then
    self.goTakeIn:SetActive(false)
  else
    local canDelete, reason, showBtn = UIHomelandBuildEdit.CanBuildingDelete(homeBuilding)
    self.goTakeIn:SetActive(showBtn)
    if UIHomelandBuildEdit.CanBuildingMove(homeBuilding:GetBuildId()) then
      self.goRotate:SetActive(true)
      self.goConfirm:SetActive(true)
    else
      self.goRotate:SetActive(false)
      self.goConfirm:SetActive(false)
    end
  end
end

function UIHomelandBuildEdit:FlushLivable(liveable)
  local tls = {}
  if liveable > self.liveableRaw then
    self.moreGo:SetActive(true)
    self.lessGo:SetActive(false)
    local delta = liveable - self.liveableRaw
    if not self._moreValue then
      self._moreValue = 0
    end
    if delta - self._moreValue ~= 0 then
      local tl = EZTL_TextUpAnim:New(self.moreValue, self._moreValue, delta, 800)
      tls[#tls + 1] = tl
    end
    self._lessValue = 0
    self._moreValue = delta
  elseif liveable < self.liveableRaw then
    self.moreGo:SetActive(false)
    self.lessGo:SetActive(true)
    local delta = self.liveableRaw - liveable
    if not self._lessValue then
      self._lessValue = 0
    end
    if delta - self._lessValue ~= 0 then
      local tl = EZTL_TextUpAnim:New(self.lessValue, self._lessValue, delta, 800)
      tls[#tls + 1] = tl
    end
    self._moreValue = 0
    self._lessValue = delta
  else
    self.moreGo:SetActive(false)
    self.lessGo:SetActive(false)
    self._moreValue = 0
    self._lessValue = 0
  end
  if self.liveable ~= liveable then
    local tl = EZTL_TextUpAnim:New(self.txtLivable, self.liveable, liveable, 800)
    tls[#tls + 1] = tl
  end
  self.liveable = liveable
  if 0 < #tls then
    if self._animPlayer:IsPlaying() then
      self._animPlayer:Stop()
    end
    if #tls == 1 then
      self._animPlayer:Play(tls[1])
    else
      self._animPlayer:Play(EZTL_Parallel:New(tls, EZTL_EndTag.All, nil, ""))
    end
  end
end

function UIHomelandBuildEdit:FlushTabNews()
  self.newFilters = {}
  local listAll = self.mItem:GetItemListBySubType(ItemSubType.ItemSubType_Architecture)
  for _, item in ipairs(listAll) do
    local tplId = item:GetTemplateID()
    if UIHomelandBuildEdit.CanBuildingMove(tplId) and self.homeBuildManager:GetBuildCount(tplId) > 0 and item:IsNewOverlay() then
      local filter = UIHomelandBuildEdit.GetBuildingFilter(tplId)
      if not filter then
        Log.exception("建筑" .. tplId .. "缺少Filter配置")
      end
      for _, filterID in ipairs(filter) do
        self.newFilters[filterID] = true
      end
    end
  end
  local parentFilters = {}
  for filter, _ in pairs(self.newFilters) do
    local cfgFilter = Cfg.cfg_homeland_filter({Filter = filter})
    if cfgFilter and 0 < #cfgFilter and cfgFilter[1].Parent then
      parentFilters[cfgFilter[1].Parent] = true
    else
      local parentBuildingCfg = Cfg.cfg_item_father_architecture[filter]
      if parentBuildingCfg then
        parentFilters[UIHomelandBuildEdit.CompositeBuildingID] = true
      end
    end
  end
  table.append(self.newFilters, parentFilters)
end

function UIHomelandBuildEdit:FlushTabs1()
  local filters = UIHomelandBuildEdit.GetBuildFilters()
  local len = table.count(filters)
  self.tabs1:SpawnObjects("UIHomelandBuildEditTab1", len)
  local uis = self.tabs1:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local item = filters[i]
    if item then
      ui:Flush(item.id)
      ui:SetNew(self.newFilters[item.id])
      ui:ShowHideFilter(self.curFilterId)
      if item.id == 4 then
        self._specialTag = ui
      end
    end
  end
end

function UIHomelandBuildEdit:FlushTabs2()
  local filter = UIHomelandBuildEdit.GetBuildFilterById(self.curFilterId)
  local len = table.count(filter.children)
  self.tabs2:SpawnObjects("UIHomelandBuildEditTab2", len)
  local uis = self.tabs2:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local item = filter.children[i]
    if item then
      ui:Flush(filter.id, item.id, self.filterID2SubType)
      ui:SetNew(self.newFilters[item.id])
      ui:HomelandBuildFilterTab2(self.curFilterId, self.curFilterChildId)
      if item.id == 403 then
        self._specialLand = ui
      end
    end
  end
end

function UIHomelandBuildEdit:FlushList()
  if self.curFilterId == self.ChangeSkinFilterID then
    self.noItem:SetActive(false)
    self:FlushSkins()
    return
  end
  local listAll = self.mItem:GetItemListBySubType(ItemSubType.ItemSubType_Architecture)
  self.list = {}
  local parentList = {}
  for _, item in ipairs(listAll) do
    local tplId = item:GetTemplateID()
    local isParent = self:GetSubType(tplId) == ArchitectureSubType.Father_Architecture
    if (isParent or self.homeBuildManager:GetBuildCount(tplId) > 0) and UIHomelandBuildEdit.CanBuildingMove(tplId) then
      local filter = UIHomelandBuildEdit.GetBuildingFilter(tplId)
      for _, filterID in ipairs(filter) do
        if filterID == self.curFilterChildId or self.curFilterChildId == self.allFilterID then
          if isParent and self.curFilterChildId ~= self.allFilterID then
            table.insert(parentList, item)
            break
          end
          table.insert(self.list, item)
          break
        end
      end
    end
  end
  table.sort(self.list, function(a, b)
    local aNew = a:IsNewOverlay()
    local bNew = b:IsNewOverlay()
    if aNew and not bNew then
      return true
    elseif not aNew and bNew then
      return false
    end
    local ta = a:GetTemplate()
    local tb = b:GetTemplate()
    if ta.BagSortIndex == tb.BagSortIndex then
      return ta.ID < tb.ID
    end
    return ta.BagSortIndex > tb.BagSortIndex
  end)
  for _, item in ipairs(parentList) do
    table.insert(self.list, 1, item)
  end
  local camera = GameGlobal.UIStateManager():GetControllerCamera("UIHomelandBuild")
  self._firstItem = nil
  self._svHelper:Dispose()
  self._svHelper:SetItemName("UIHomelandBuildEditItem")
  self._svHelper:SetShowFunction(function(index, ui)
    ui:Init(camera, BuildEditListType.BT_Default)
    ui:SetDragItem(self.goDragItem, self.poolDragItem, self.dragItem)
    ui:Flush(self.list[index]:GetTemplateID())
    if not self._firstItem then
      self._firstItem = ui
    end
    return ui
  end)
  local len = table.count(self.list)
  self._svHelper:Init(len, 0, Vector2(0, 0))
  self._sr.horizontalNormalizedPosition = 0
  self.noItem:SetActive(len == 0)
end

function UIHomelandBuildEdit:FlushListNoMove()
  if self.curFilterId == self.ChangeSkinFilterID then
    self.noItem:SetActive(false)
    self:FlushSkins()
    return
  end
  local listAll = self.mItem:GetItemListBySubType(ItemSubType.ItemSubType_Architecture)
  self.list = {}
  local parentList = {}
  for _, item in ipairs(listAll) do
    local tplId = item:GetTemplateID()
    local isParent = self:GetSubType(tplId) == ArchitectureSubType.Father_Architecture
    if (isParent or self.homeBuildManager:GetBuildCount(tplId) > 0) and UIHomelandBuildEdit.CanBuildingMove(tplId) then
      local filter = UIHomelandBuildEdit.GetBuildingFilter(tplId)
      for _, filterID in ipairs(filter) do
        if filterID == self.curFilterChildId or self.curFilterChildId == self.allFilterID then
          if isParent and self.curFilterChildId ~= self.allFilterID then
            table.insert(parentList, item)
            break
          end
          table.insert(self.list, item)
          break
        end
      end
    end
  end
  table.sort(self.list, function(a, b)
    local aNew = a:IsNewOverlay()
    local bNew = b:IsNewOverlay()
    if aNew and not bNew then
      return true
    elseif not aNew and bNew then
      return false
    end
    local ta = a:GetTemplate()
    local tb = b:GetTemplate()
    if ta.BagSortIndex == tb.BagSortIndex then
      return ta.ID < tb.ID
    end
    return ta.BagSortIndex > tb.BagSortIndex
  end)
  for _, item in ipairs(parentList) do
    table.insert(self.list, 1, item)
  end
  local camera = GameGlobal.UIStateManager():GetControllerCamera("UIHomelandBuild")
  self._firstItem = nil
  self._svHelper:Dispose()
  self._svHelper:SetItemName("UIHomelandBuildEditItem")
  self._svHelper:SetShowFunction(function(index, ui)
    ui:Init(camera, BuildEditListType.BT_Default)
    ui:SetDragItem(self.goDragItem, self.poolDragItem, self.dragItem)
    ui:Flush(self.list[index]:GetTemplateID())
    if not self._firstItem then
      self._firstItem = ui
    end
    return ui
  end)
  local len = table.count(self.list)
  local first = self._svHelper:GetFirstItem()
  self._svHelper:Init(len, first, Vector2(0, 0))
  if first == 1 then
    self._sr.horizontalNormalizedPosition = 0
  end
  self.noItem:SetActive(len == 0)
end

function UIHomelandBuildEdit:GetSubType(tplID)
  if self._tplIDSubTypeCache[tplID] then
    return self._tplIDSubTypeCache[tplID]
  end
  local cfg = Cfg.cfg_item_architecture[tplID]
  if not cfg then
    return
  end
  self._tplIDSubTypeCache[tplID] = cfg.SubType
  return cfg.SubType
end

function UIHomelandBuildEdit:HomeBuildOnAmbientChanged(liveable)
  self:FlushLivable(liveable)
end

function UIHomelandBuildEdit:HomeBuildOnSelectBuilding()
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  if homeBuilding then
    self.arrange:SetActive(false)
    self.operate:SetActive(true)
    self:FlushOperate()
  else
    self.arrange:SetActive(true)
    self.operate:SetActive(false)
    self:FlushArrange()
  end
end

function UIHomelandBuildEdit:btnBackOnClick(go)
  local function Exit()
    self:StartTask(self._Exit, self)
  end
  
  local btn1Data = {
    StringTable.Get("str_homeland_build_exit_directly"),
    function(param)
      self.homeBuildManager:RevertAll()
      Exit()
    end
  }
  local btn2Data = {
    StringTable.Get("str_homeland_build_save_and_exit"),
    function(param)
      self:StartTask(function(TT)
        local key = "UIHomelandBuild_back"
        self:Lock(key)
        self.homeBuildManager:Save(TT)
        self:UnLock(key)
        Exit()
      end, self)
    end
  }
  if self.homeBuildManager:HaveUnsavedModify() then
    self:ShowDialog("UIHomelandMessageBox", StringTable.Get("str_homeland_build_layout_mode"), StringTable.Get("str_homeland_build_save_or_not"), btn1Data, btn2Data)
  else
    Exit()
  end
end

function UIHomelandBuildEdit:_Exit(TT)
  self:Lock("HomeExitBuildMode")
  self:SwitchState(UIStateType.UIHomeland)
  while GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIHomeland do
    YIELD(TT)
  end
  self.homelandClient:FinishBuild(TT)
  self:UnLock("HomeExitBuildMode")
end

function UIHomelandBuildEdit:btnShowHideOnClick(go)
  Log.fatal("###")
end

function UIHomelandBuildEdit:imgLivableOnClick(go)
  Log.fatal("###")
end

function UIHomelandBuildEdit:imgSaveOnClick(go)
  self:StartTask(function(TT)
    local key = "UIHomelandBuildEdit_imgSaveOnClick"
    self:Lock(key)
    self.homeBuildManager:Save(TT)
    self.liveableRaw = self.mHomeland:GetAmbientValue()
    self.liveable = self.liveableRaw
    self:FlushLivable(self.liveable)
    self:UnLock(key)
  end, self)
end

function UIHomelandBuildEdit:ExitChangeSkin()
  self.changeSkin:GetGameObject():SetActive(false)
  self.operate:SetActive(true)
  self:FlushOperate()
end

function UIHomelandBuildEdit:imgShowHideListOnClick(go)
  if self.goList.activeInHierarchy then
    self.goList:SetActive(false)
    self.listBG:SetActive(false)
    self.imgShowHideList.anchoredPosition = Vector2(-57, 83)
    self.imgShowHideList.localScale = Vector3(1, -1, 1)
  else
    self.goList:SetActive(true)
    self.listBG:SetActive(true)
    self.imgShowHideList.anchoredPosition = Vector2(-57, 423)
    self.imgShowHideList.localScale = Vector3.one
  end
  self.imgShowHideList.localRotation = self.quaternionShowHide
end

function UIHomelandBuildEdit:imgCancelOnClick(go)
  self.homeBuildManager:RevertCurrent()
end

function UIHomelandBuildEdit:imgTakeInOnClick(go)
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  local canDelete, reason = UIHomelandBuildEdit.CanBuildingDelete(homeBuilding)
  if not self:CheckCanRemove(homeBuilding) then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_cant_delete_task"))
    return
  end
  if canDelete then
    self.homeBuildManager:Delete()
    self:HomeBuildOnSelectBuilding()
  elseif not string.isnullorempty(reason) then
    ToastManager.ShowHomeToast(reason)
  else
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_cant_delete"))
  end
end

function UIHomelandBuildEdit:imgRotateOnClick(go)
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  if not homeBuilding:CanRotate() then
    ToastManager.ShowToast(StringTable.Get("str_homeland_build_fixed_rotation"))
    return
  end
  self:ShowDialog("UIHomelandBuildEditRotate")
end

function UIHomelandBuildEdit:imgConfirmOnClick(go)
  self.homeBuildManager:DropDown()
end

function UIHomelandBuildEdit:HomelandBuildFilterTab1(id)
  if self.curFilterId == id then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._needSave then
    self:ConfirmExitChangeSkinMode(function()
      self.curFilterId = id
      local filter = UIHomelandBuildEdit.GetBuildFilterById(self.curFilterId)
      self.curFilterChildId = filter.children[1].id
      self:FlushTabs2()
      self:FlushList()
    end)
    return
  end
  self.curFilterId = id
  local filter = UIHomelandBuildEdit.GetBuildFilterById(self.curFilterId)
  self.curFilterChildId = filter.children[1].id
  self:FlushTabs2()
  self:FlushList()
end

function UIHomelandBuildEdit:HomelandBuildFilterTab2(id, childId)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._needSave then
    self:ConfirmExitChangeSkinMode(function()
      self.curFilterId = id
      self.curFilterChildId = childId
      self:FlushList()
    end)
    return
  end
  self.curFilterId = id
  self.curFilterChildId = childId
  self:FlushList()
end

function UIHomelandBuildEdit:HomelandShowHideDragItem(isShow)
  self.doDragBuildingIntoScene = false
end

function UIHomelandBuildEdit:DragBuildingIntoScene(buildingId, pointerId, pos)
  local cfg = Cfg.cfg_item_architecture[buildingId]
  if cfg.SubType == ArchitectureSubType.Father_Architecture and self.homeBuildManager:GetBuildCount(buildingId) <= 0 then
    return
  end
  if not self.doDragBuildingIntoScene and pos.y > self.rectList.rect.height then
    self.doDragBuildingIntoScene = true
    self.goDragItem:SetActive(false)
    if self._uiWidgetBuildCtrl then
      self._uiWidgetBuildCtrl:DragBuildingIntoScene(buildingId, pointerId)
    end
  end
end

function UIHomelandBuildEdit:SetUIWidgetHomelandBuildController(uiWidgetBuildCtrl)
  self._uiWidgetBuildCtrl = uiWidgetBuildCtrl
end

function UIHomelandBuildEdit:FlushSkins()
  local buildCfg = Cfg.cfg_item_architecture({
    SubType = self.filterID2SubType[self.curFilterChildId]
  })
  if not buildCfg or #buildCfg == 0 then
    return
  end
  local buildingID = buildCfg[1].ID
  local buildings = self.homeBuildManager:GetBuildings()
  local curBuilding
  for i = 1, #buildings do
    if buildings[i]:GetBuildId() == buildingID then
      curBuilding = buildings[i]
      break
    end
  end
  if not curBuilding then
    return
  end
  self.curBuildingSkinID = curBuilding:SkinID()
  local cfgs = Cfg.cfg_item_architecture_skin({
    architecture_id = curBuilding:GetBuildId()
  })
  self.skins = {}
  for _, cfg in ipairs(cfgs) do
    if self.mHomeland:HasBuildSkin(cfg.ID) then
      self.skins[#self.skins + 1] = cfg
    end
  end
  table.sort(self.skins, function(a, b)
    return a.ID < b.ID
  end)
  self._svHelper:Dispose()
  self._svHelper:SetItemName("UIHomelandBuildEditItemSkin")
  self._svHelper:SetShowFunction(function(index, ui)
    ui:Flush(self.skins[index], self.curBuildingSkinID)
    return ui
  end)
  self._svHelper:Init(#self.skins, 0, Vector2(0, 0))
end

function UIHomelandBuildEdit:ChangeSkinCancelOnClick(go)
  self:ConfirmExitChangeSkinMode(function()
    self:FlushSkins()
  end)
end

function UIHomelandBuildEdit:ConfirmExitChangeSkinMode(callback)
  local btn1Data = {
    StringTable.Get("str_homeland_build_change_skin_mode_exit_directly"),
    function()
      self:RevertSkin()
      self:LeaveChangeSkinMode()
      if callback then
        callback()
      end
    end
  }
  local btn2Data = {
    StringTable.Get("str_homeland_build_change_skin_mode_exit_after_save"),
    function()
      self:LeaveChangeSkinMode()
      if callback then
        callback()
      end
    end
  }
  self:ShowDialog("UIHomelandMessageBox", nil, StringTable.Get("str_homeland_build_change_skin_mode_exit"), btn1Data, btn2Data, true)
end

function UIHomelandBuildEdit:RevertSkin()
  self.homeBuildManager:RevertCurrentSkin()
end

function UIHomelandBuildEdit:ChangeSkinConfirmOnClick(go)
  self:LeaveChangeSkinMode()
end

function UIHomelandBuildEdit:OnChangeSkin(skinID)
  local curBuilding = self.homeBuildManager:FindBuildingBySubType(self.filterID2SubType[self.curFilterChildId])
  if not self._needSave then
    self:EnterChangeSkinMode()
    self.homeBuildManager:SelectChangeSkinBuilding(curBuilding)
  end
  self.homeBuildManager:ChangeSkin(skinID)
end

function UIHomelandBuildEdit:EnterChangeSkinMode()
  self._needSave = true
  self.homeBuildManager:StartChangeSkin()
  self.changeSkin:SetActive(true)
  self.tglGrid.gameObject:SetActive(false)
  self.arrangeTitle:SetActive(false)
  self.saveBtn:SetActive(false)
end

function UIHomelandBuildEdit:LeaveChangeSkinMode()
  self._needSave = false
  self.homeBuildManager:FinishChangeSkin()
  self.changeSkin:SetActive(false)
  self.tglGrid.gameObject:SetActive(true)
  self.arrangeTitle:SetActive(true)
  self.saveBtn:SetActive(true)
end

function UIHomelandBuildEdit:FlushCompositeBuilding()
  local parentBuildingCfg = Cfg.cfg_item_father_architecture({})
  for _, cfg in pairs(parentBuildingCfg) do
  end
  local buildingID = buildCfg[1].ID
  local buildings = self.homeBuildManager:GetBuildings()
  local curBuilding
  for i = 1, #buildings do
    if buildings[i]:GetBuildId() == buildingID then
      curBuilding = buildings[i]
      break
    end
  end
  if not curBuilding then
    return
  end
  self.curBuildingSkinID = curBuilding:SkinID()
  local cfgs = Cfg.cfg_item_architecture_skin({
    architecture_id = curBuilding:GetBuildId()
  })
  self.skins = {}
  for _, cfg in ipairs(cfgs) do
    if self.mHomeland:HasBuildSkin(cfg.ID) then
      self.skins[#self.skins + 1] = cfg
    end
  end
  table.sort(self.skins, function(a, b)
    return a.ID < b.ID
  end)
  self._svHelper:Dispose()
  self._svHelper:SetItemName("UIHomelandBuildEditItemSkin")
  self._svHelper:SetShowFunction(function(index, ui)
    ui:Flush(self.skins[index], self.curBuildingSkinID)
    return ui
  end)
  self._svHelper:Init(#self.skins, 0, Vector2(0, 0))
end

UIHomelandBuildEdit.CompositeBuildingID = 7
UIHomelandBuildEdit.ChangeSkinFilterID = 99
UIHomelandBuildEdit.MainBuildingFilterID = 9901
UIHomelandBuildEdit.MuseumFilterID = 9902
UIHomelandBuildEdit.ShopFilterID = 9903
UIHomelandBuildEdit.WishingPoolFilterID = 9904

function UIHomelandBuildEdit.GetItemTemplate(tplId)
  local cfg_item = Cfg.cfg_item[tplId]
  return cfg_item
end

function UIHomelandBuildEdit.GetBuildingName(tplId)
  local tpl = UIHomelandBuildEdit.GetItemTemplate(tplId)
  local name = StringTable.Get(tpl.Name)
  return name
end

function UIHomelandBuildEdit.GetItemArchitectureTemplate(tplId)
  local cfg_item_architecture = Cfg.cfg_item_architecture[tplId]
  if not cfg_item_architecture then
    Log.error("### no data in cfg_item_architecture. ID = ", tplId)
  end
  return cfg_item_architecture
end

function UIHomelandBuildEdit.GetBuildingLiveable(tplId)
  local tpl = UIHomelandBuildEdit.GetItemArchitectureTemplate(tplId)
  local livable = tpl.LivableValue
  return livable
end

function UIHomelandBuildEdit.GetBuildingFilter(tplId)
  local tpl = UIHomelandBuildEdit.GetItemArchitectureTemplate(tplId)
  local n = tpl.Filter
  if n then
    return {n}
  end
  local cfgSonArch = Cfg.cfg_item_son_architecture[tplId]
  if cfgSonArch then
    return cfgSonArch.FatherArch
  end
end

function UIHomelandBuildEdit.CanBuildingMove(tplId)
  local tpl = UIHomelandBuildEdit.GetItemArchitectureTemplate(tplId)
  local b = tpl.CanMove
  return b
end

function UIHomelandBuildEdit.CanBuildingDelete(building)
  local tplId = building:GetBuildId()
  local tpl = UIHomelandBuildEdit.GetItemArchitectureTemplate(tplId)
  if not tpl.CanDelete then
    return false, nil, false
  end
  if building:IsNewAdd() then
    return true, nil, true
  end
  if tpl.Type == ArchitectureType.Homeland_Put_Architecture and tpl.SubType == ArchitectureSubType.Dormitory then
    local room = GameGlobal.GetModule(HomelandModule):GetDomitoryByPstID(building:GetBuildPstId())
    for i = 1, 4 do
      local petid = room.petList[i]
      if petid and 0 < petid then
        return false, StringTable.Get("str_homeland_domitory_cant_delete"), true
      end
    end
  end
  if tpl.Type == ArchitectureType.Homeland_Put_Architecture and tpl.SubType == ArchitectureSubType.Land then
    local land = building
    if land:InBreeding() then
      return false, StringTable.Get("str_homeland_build_error36"), true
    end
  end
  return true, nil, true
end

function UIHomelandBuildEdit.CanChangeSkin(tplId)
  local tpl = UIHomelandBuildEdit.GetItemArchitectureTemplate(tplId)
  local b = tpl.DefaultSkin
  if b and 0 < b then
    return true
  end
  return false
end

UIHomelandBuildEdit.filters = {}

function UIHomelandBuildEdit.GetBuildFilters()
  if table.count(UIHomelandBuildEdit.filters) <= 0 then
    UIHomelandBuildEdit.filters = {}
    local children = {}
    local cfg_homeland_filter = Cfg.cfg_homeland_filter()
    for _, cfgv in pairs(cfg_homeland_filter) do
      if cfgv.Type == HomelandFilterType.All or cfgv.Type == HomelandFilterType.Edit then
        local f = HomelandBuildingFilter:New()
        f.id = cfgv.Filter
        f.name = StringTable.Get(cfgv.Name)
        f.icon = cfgv.Icon
        if cfgv.Parent then
          if not children[cfgv.Parent] then
            children[cfgv.Parent] = {}
          end
          table.insert(children[cfgv.Parent], f)
        else
          table.insert(UIHomelandBuildEdit.filters, f)
          if f.id == UIHomelandBuildEdit.CompositeBuildingID then
            children[UIHomelandBuildEdit.CompositeBuildingID] = {}
            local cfgParents = Cfg.cfg_item_father_architecture()
            for _, cfgParentV in pairs(cfgParents) do
              local f = HomelandBuildingFilter:New()
              f.id = cfgParentV.ID
              f.name = StringTable.Get(Cfg.cfg_item[f.id].Name)
              table.insert(children[UIHomelandBuildEdit.CompositeBuildingID], f)
            end
          end
        end
      end
    end
    for _, f in ipairs(UIHomelandBuildEdit.filters) do
      f.children = children[f.id] or {}
    end
  end
  return UIHomelandBuildEdit.filters
end

function UIHomelandBuildEdit.GetBuildFilterById(id)
  local filters = UIHomelandBuildEdit.GetBuildFilters()
  for _, filter in ipairs(filters) do
    if filter.id == id then
      return filter
    end
  end
end

function UIHomelandBuildEdit.GetBuildFilterBy2Id(id, childId)
  local filter = UIHomelandBuildEdit.GetBuildFilterById(id)
  for _, filter in ipairs(filter.children) do
    if filter.id == childId then
      return filter
    end
  end
end

function UIHomelandBuildEdit:GetFirstItem()
  if self._firstItem then
    return self._firstItem:GetBg()
  end
  return nil
end

function UIHomelandBuildEdit:GetSpecialTag()
  return self._specialTag:GetGameObject("imgTab")
end

function UIHomelandBuildEdit:GetSpecialLand()
  return self._specialLand:GetGameObject("imgTab")
end

function UIHomelandBuildEdit:OnOpenRotate(isOpen)
  if isOpen then
    self._rotateImg.color = Color(0.9686274509803922, 0.6823529411764706, 0.17254901960784313)
  else
    self._rotateImg.color = Color.white
  end
end

function UIHomelandBuildEdit:CheckCanRemove(building)
  local task = self.homelandClient:GetHomelandTaskManager():GetRuningTask()
  task = task or self.homelandClient:GetHomelandTaskManager():GetHomelandStoryTaskManager():GetRuningTaskItem()
  if task then
    return task:GetHoldBuilding() ~= building._cfgID
  end
  return true
end
