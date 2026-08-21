_class("UIChooseMainBgController", UIController)
UIChooseMainBgController = UIChooseMainBgController

function UIChooseMainBgController:Constructor()
  self._itemCountPerRow = 1
  self._bgTypeBtns = {}
  self._btnStatus = nil
  self._curSecondBtn = nil
  self._spawnBtnList = {}
  self._initScrollViewFlag = false
  self._str2anim = {
    OnShow = "uieff_Assistant_ChangeBg_In",
    OnHide = "uieff_Assistant_ChangeBg_Out"
  }
end

function UIChooseMainBgController:OnShow(uiParams)
  self._pivot = Vector2(0.5, 0.5)
  self._itemModule = self:GetModule(ItemModule)
  self._roleModule = self:GetModule(RoleModule)
  self._bookModule = self:GetModule(BookModule)
  self._curBGInfo = nil
  self._currentMainBgID = self._roleModule:UI_GetMainBgID()
  self._currentMainBgType = self._roleModule.m_choose_painting.background_type
  self._current_is_hand_operate = self._roleModule.m_choose_painting.is_hand_operate
  self._current_hand_spine_index = self._roleModule.m_choose_painting.spine_id
  self._currentMainBgID = self._currentMainBgID == 0 and 2 or self._currentMainBgID
  self._currentMainBgType = self._currentMainBgType == 0 and 1 or self._currentMainBgType
  self._current_hand_spine_index = self._current_hand_spine_index == 0 and 1 or self._current_hand_spine_index
  if self._currentMainBgType == UIChooseAssistantBgType.Normal and not Cfg.cfg_main_bg[self._currentMainBgID] then
    self._currentMainBgID = 1
  end
  self:_GetComponents()
  self:_OnValue()
  self:_ShowCgBgUI()
  self:ShowDialogAnim()
  self:InitBtn()
  local controller = GameGlobal.UIStateManager():GetController("UIChooseMainCgController")
  if controller then
    controller:SetCgControllerShowOrHide(false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.Bg, true)
end

function UIChooseMainBgController:_GetComponents()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "scrollView")
  self._anim = self:GetUIComponent("Animation", "UIChooseMainBgController")
  self._move2 = self:GetGameObject("move2")
  self._togGo = self:GetGameObject("toggleP")
  self._go = self:GetGameObject()
  self._tog = self:GetUIComponent("Toggle", "Toggle")
  self._viewBg = self:GetUIComponent("RectTransform", "viewBg")
  self._bgRect = self:GetUIComponent("RectTransform", "bg")
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bgRect)
  self._mulSpineGo = self:GetGameObject("mulSpine")
  self._multiSpineArrowsGo = self:GetGameObject("multiSpineArrows")
  self._autoSwithSpineGo = self:GetGameObject("autoSwithSpineBtn")
  self._manulSwitchSpineGo = self:GetGameObject("manulSwitchSpine")
  local btn1, btn2, btn3, btn4 = {}, {}, {}, {}
  btn1.selectObj = self:GetGameObject("sceneSelected")
  btn1.data = self:GetSceneBgData()
  btn2.selectObj = self:GetGameObject("storySelected")
  btn2.data = self:GetStoryBgData()
  btn3.selectObj = self:GetGameObject("skinSelected")
  btn3.data = self:GetSkinBgData()
  btn4.selectObj = self:GetGameObject("seasonSelected")
  btn4.data = self:GetSeasonBgData()
  self._bgTypeBtns[UIChooseAssistantBgType.Normal] = btn1
  self._bgTypeBtns[UIChooseAssistantBgType.Story] = btn2
  self._bgTypeBtns[UIChooseAssistantBgType.Skin] = btn3
  self._bgTypeBtns[UIChooseAssistantBgType.Season] = btn4
end

function UIChooseMainBgController:_OnValue()
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  self._safeArea = Vector2(realWidth, realHeight)
end

function UIChooseMainBgController:InitBtn()
  if self._currentMainBgType == UIChooseAssistantBgType.Normal then
    self:SceneBtnOnClick()
  elseif self._currentMainBgType == UIChooseAssistantBgType.Story then
    self:StoryBtnOnClick()
  elseif self._currentMainBgType == UIChooseAssistantBgType.Skin then
    self:SkinBtnOnClick()
  elseif self._currentMainBgType == UIChooseAssistantBgType.Season then
    self:SeasonBtnOnClick()
  end
end

function UIChooseMainBgController:GetSceneBgData()
  return self:_GetSceneData()
end

function UIChooseMainBgController:_GetSceneData()
  local datas = {}
  local cfg_main_bg = Cfg.cfg_main_bg({})
  if cfg_main_bg and next(cfg_main_bg) then
    for i = 1, #cfg_main_bg do
      local unLock = true
      local data = {}
      data.type = UIChooseAssistantBgType.Normal
      local itemid = cfg_main_bg[i].ItemID
      if itemid then
        data.itemid = itemid
        local itemcount = self._itemModule:GetItemCount(itemid)
        if itemcount and 0 < itemcount then
        else
          unLock = false
        end
      end
      if unLock then
        data.id = cfg_main_bg[i].ID
        data.bg = cfg_main_bg[i].BG
        data.name = cfg_main_bg[i].Name
        table.insert(datas, data)
      end
    end
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local sortlist = datas
  
  local function getItemFunc(id)
    local items = itemModule:GetItemByTempId(id)
    if items and table.count(items) > 0 then
      for key, value in pairs(items) do
        return value
      end
    end
  end
  
  table.sort(sortlist, function(a, b)
    local aUsing = a.id == self._currentMainBgID and a.type == self._currentMainBgType
    local bUsing = b.id == self._currentMainBgID and b.type == self._currentMainBgType
    if aUsing or bUsing then
      return aUsing
    else
      return a.id < b.id
    end
  end)
  return sortlist
end

function UIChooseMainBgController:GetStoryBgData()
  return self:GetCGDataListByMulTyps({
    UIChooseAssistantBgType.Story
  })
end

function UIChooseMainBgController:GetSkinBgData()
  return self:GetCGDataListByMulTyps({
    UIChooseAssistantBgType.Skin,
    UIChooseAssistantBgType.MultiSpineSkin
  })
end

function UIChooseMainBgController:GetSeasonBgData()
  return self:GetCGDataListByMulTyps({
    UIChooseAssistantBgType.Season
  })
end

function UIChooseMainBgController:_ShowCgBgUI()
  local petid = self._roleModule:GetResId()
  self._haveAs = true
  if petid and petid == -1 then
    self._haveAs = false
  end
  self._togGo:SetActive(self._haveAs)
  self._togValue = not self._haveAs
  self._tog.isOn = self._togValue
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainLobbyHideAssistant, self._togValue)
  self._tog.onValueChanged:AddListener(function(value)
    self:_OnToggleChange(value)
  end)
end

function UIChooseMainBgController:_OnToggleChange(value)
  self._togValue = value
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainLobbyHideAssistant, self._togValue)
end

function UIChooseMainBgController:_InitScrollView()
  self._spawnBtnList = {}
  if self._scrollView then
    self._initScrollViewFlag = true
    self._scrollView:InitListView(table.count(self._curBGInfo), function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
  end
end

function UIChooseMainBgController:_ResetListView()
  self._scrollView:SetListItemCount(table.count(self._curBGInfo), true)
  self._spawnBtnList = {}
  self._scrollView:RefreshAllShownItem()
  table.sort(self._spawnBtnList, function(a, b)
    local aUsing = a:GetUsing()
    local bUsing = b:GetUsing()
    local aId = a:GetID()
    local bId = b:GetID()
    if aUsing or bUsing then
      return aUsing
    else
      return aId < bId
    end
  end)
end

function UIChooseMainBgController:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChooseMainBgItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local rowitem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > table.count(self._curBGInfo) then
      rowitem:GetGameObject():SetActive(false)
    else
      self:_ShowItem(rowitem, itemIndex)
    end
    table.insert(self._spawnBtnList, rowitem)
  end
  return item
end

function UIChooseMainBgController:_ShowItem(item, index)
  local data = self._curBGInfo[index]
  item:GetGameObject():SetActive(true)
  if data ~= nil then
    item:SetData(data.id, data.itemid, data.type, data.id == self._currentMainBgID and data.type == self._currentMainBgType, data.id == self._currentChooseID and data.type == self._btnStatus, data.bg, data.name, function(id, type)
      self:_ChooseOneBg(id, type)
    end)
  end
end

function UIChooseMainBgController:_ChooseOneBg(id, type)
  if self._currentChooseID == id and self._currentChooseType == type then
    return
  end
  self._currentChooseID = id
  self._currentChooseType = type
  self.spineIndex = nil
  local cfg, arrlen = self:CheckMulSpineCg(self._currentChooseID)
  if cfg then
    self:ResetBgIndex(true)
    self:_RefreshCtrBtns()
    return
  end
  self:_RefreshCtrBtns()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeMainBg, self._btnStatus, self._currentChooseID, true, false, false, false, self.spineIndex)
end

function UIChooseMainBgController:_RefreshCtrBtns()
  local cfg, arrlen = self:CheckMulSpineCg(self._currentChooseID)
  local isMultiSpine = cfg ~= nil
  self._mulSpineGo:SetActive(isMultiSpine)
  self._multiSpineArrowsGo:SetActive(false)
  if not isMultiSpine then
    return
  end
  self:_RefreshMultiSpinesModel()
end

function UIChooseMainBgController:_RefreshMultiSpinesModel()
  self._manulSwitchSpineGo:SetActive(not self.bMultiSpineAuto)
  self._autoSwithSpineGo:SetActive(self.bMultiSpineAuto)
  self._multiSpineArrowsGo:SetActive(not self.bMultiSpineAuto)
end

function UIChooseMainBgController:cancelBtnOnClick(go)
  local cgtrl = GameGlobal.UIStateManager():GetController("UIChooseMainCgController")
  local preIndex = -1
  if cgtrl ~= nil then
    preIndex = cgtrl.curDressIndex
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangeSave, UIChooseAssistantType.Bg2MainLobby, UIChooseAssistantState.Cancel, -1, -1, preIndex)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.None)
  self:CloseDialogAnim()
  local controller = GameGlobal.UIStateManager():GetController("UIChooseMainCgController")
  if controller then
    controller:SetCgControllerShowOrHide(true)
    controller:SetShowAssistant()
  else
    self:ShowDialog("UIChooseMainCgController")
  end
end

function UIChooseMainBgController:CloseDialogAnim()
  self:Lock("UIChooseMainBgController:CloseDialogAnim")
  self._anim:Play(self._str2anim.OnHide)
  self:StartTask(function(TT)
    YIELD(TT, 433)
    self:UnLock("UIChooseMainBgController:CloseDialogAnim")
    self:CloseDialog()
  end, self)
end

function UIChooseMainBgController:ShowDialogAnim()
  self:Lock("UIChooseMainBgController:ShowDialogAnim")
  self._anim:Play(self._str2anim.OnShow)
  self:StartTask(function(TT)
    YIELD(TT, 433)
    self:UnLock("UIChooseMainBgController:ShowDialogAnim")
  end, self)
end

function UIChooseMainBgController:MoveBtnOnClick(go)
  if self._haveAs and self._togValue then
    self:HideAsReq(function()
      self:ShowDialog("UIChooseMainCgController", UIChooseAssistantType.Change2Bg, self._currentChooseID, self._currentChooseType)
    end)
  else
    self:CloseDialogAnim()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeMainBg, self._btnStatus, self._currentChooseID, true, true, true, true, self.spineIndex)
    self:ShowDialog("UIChooseMainCgController", UIChooseAssistantType.Change2Bg, self._currentChooseID, self._currentChooseType)
  end
end

function UIChooseMainBgController:saveBtnOnClick(go)
  local cancel = false
  if self._currentChooseID == 0 then
    cancel = true
  end
  if self._currentMainBgID == self._currentChooseID then
    cancel = true
  end
  if cancel then
    local cgtrl = GameGlobal.UIStateManager():GetController("UIChooseMainCgController")
    local preIndex = -1
    if cgtrl ~= nil then
      preIndex = cgtrl.curDressIndex
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangeSave, UIChooseAssistantType.Bg2MainLobby, UIChooseAssistantState.Save, self._currentChooseID, self._btnStatus, preIndex)
    self:CloseDialogAnim()
    self:SaveAsState()
  else
    self:CloseDialogAnim()
  end
  ChooseAssistantHelper:SaveTmpChooseBgPaintingData(true, self._currentChooseID, self._currentChooseType)
  local controller = GameGlobal.UIStateManager():GetController("UIChooseMainCgController")
  if controller then
    controller:SetCgControllerShowOrHide(true)
    controller:SetCgShowInfo({
      UIChooseAssistantType.Change2Bg,
      self._currentChooseID,
      self._currentChooseType
    })
  else
    self:ShowDialog("UIChooseMainCgController", UIChooseAssistantType.Change2Bg, self._currentChooseID, self._currentChooseType)
  end
end

function UIChooseMainBgController:OnSaveBtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeMainBg, self._btnStatus, self._currentChooseID, true, true, true, true, self.spineIndex)
  self:SaveAsState()
  self:CloseDialogAnim()
end

function UIChooseMainBgController:HideAsReq(callbcak)
  self:Lock("UIChooseMainBgController:HideAsReq()")
  GameGlobal.TaskManager():StartTask(function(TT)
    local id = -1
    local grade = -1
    local skinID = -1
    local asID = -1
    local res = self._roleModule:RequestChoosePainting(TT, id, grade, skinID, asID)
    if res and res:GetSucc() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeMainBg, self._btnStatus, self._currentChooseID, true, true, true, true, self.spineIndex)
      self:SaveAsState()
      self:CloseDialogAnim()
      if callbcak then
        callbcak()
      end
    else
      ToastManager.ShowToast("###[UIChooseMainBgController] HideAsReq fail ! result --> ", res:GetResult())
      Log.error("###[UIChooseMainBgController] HideAsReq fail ! result --> ", res:GetResult())
    end
    self:UnLock("UIChooseMainBgController:HideAsReq()")
  end, self)
end

function UIChooseMainBgController:SaveAsState()
  local value = self._togValue and 1 or 0
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local key = "MAIN_BG_AS_ACTIVE" .. open_id
  LocalDB.SetInt(key, value)
end

function UIChooseMainBgController:GetCGDataListByMulTyps(typeArray)
  local types = {}
  for k, subType in pairs(typeArray) do
    types[subType] = true
  end
  local cgs = {}
  local bookModule = self:GetModule(BookModule)
  local storyData = bookModule:GetCGStoryData()
  if types[UIChooseAssistantBgType.Story] then
    local bgTb = HelperProxy:GetInstance():pairsByKeys(storyData.TypeList[BookCGType.Main])
    local extBgTb = HelperProxy:GetInstance():pairsByKeys(storyData.TypeList[BookCGType.Ext])
    cgs = self:_InsertBgList(cgs, UIChooseAssistantBgType.Story, bgTb)
    cgs = self:_InsertBgList(cgs, UIChooseAssistantBgType.Story, extBgTb)
  end
  if types[UIChooseAssistantBgType.Skin] then
    local bgTb = HelperProxy:GetInstance():pairsByKeys(storyData.TypeList[BookCGType.Pet])
    cgs = self:_InsertBgList(cgs, UIChooseAssistantBgType.Skin, bgTb)
  end
  if types[UIChooseAssistantBgType.Season] then
    local bgTb = HelperProxy:GetInstance():pairsByKeys(storyData.TypeList[BookCGType.Season])
    cgs = self:_InsertBgList(cgs, UIChooseAssistantBgType.Season, bgTb)
  end
  if types[UIChooseAssistantBgType.MultiSpineSkin] then
    local skinCgs = bookModule:GetMultiSpinesSkinCgs()
    if skinCgs then
      for k, subCfg in pairs(skinCgs) do
        local data = {}
        data.id = subCfg.ID
        data.bg = subCfg.Preview
        data.name = subCfg.PreviewTitle
        data.type = UIChooseAssistantBgType.Skin
        table.insert(cgs, data)
      end
    end
  end
  if not cgs or #cgs == 0 then
    return
  end
  table.sort(cgs, function(a, b)
    local priorityA = 0
    local priorityB = 0
    if self._currentMainBgID == a.id and self._currentMainBgType == a.type then
      priorityA = priorityA + 10000
    elseif self._currentMainBgID == b.id and self._currentMainBgType == b.type then
      priorityB = priorityA + 10000
    end
    if priorityA ~= priorityB then
      return priorityA > priorityB
    end
    return a.id < b.id
  end)
  return cgs
end

function UIChooseMainBgController:_InsertBgList(tb, type, pairsByKeys)
  for cgId, active in pairsByKeys, nil, nil do
    if active then
      local cfg = Cfg.cfg_cg_book[cgId]
      if cfg.IsActive then
        local k, isUnLock = self._bookModule:GetSeasonStory(cfg)
        if isUnLock then
          local data = {}
          data.id = cgId
          data.bg = cfg.Preview
          data.name = cfg.PreviewTitle
          data.type = type
          table.insert(tb, data)
        end
      end
    end
  end
  return tb
end

function UIChooseMainBgController:SceneBtnOnClick()
  if self._btnStatus == UIChooseAssistantBgType.Normal then
    return
  end
  self:TypeBtnClick(UIChooseAssistantBgType.Normal)
end

function UIChooseMainBgController:StoryBtnOnClick()
  if self._btnStatus == UIChooseAssistantBgType.Story then
    return
  end
  local btn = self._bgTypeBtns[UIChooseAssistantBgType.Story]
  local data = btn.data
  if not data or table.count(data) < 1 then
    local tipsStr = StringTable.Get("str_assistant_cg_bg_tip3")
    ToastManager.ShowToast(tipsStr)
    return
  end
  self:TypeBtnClick(UIChooseAssistantBgType.Story)
end

function UIChooseMainBgController:SkinBtnOnClick()
  if self._btnStatus == UIChooseAssistantBgType.Skin then
    return
  end
  local btn = self._bgTypeBtns[UIChooseAssistantBgType.Skin]
  local data = btn.data
  if not data or table.count(data) < 1 then
    local tipsStr = StringTable.Get("str_assistant_cg_bg_tip1")
    ToastManager.ShowToast(tipsStr)
    return
  end
  self:TypeBtnClick(UIChooseAssistantBgType.Skin)
end

function UIChooseMainBgController:SeasonBtnOnClick()
  if self._btnStatus == UIChooseAssistantBgType.Season then
    return
  end
  local btn = self._bgTypeBtns[UIChooseAssistantBgType.Season]
  local data = btn.data
  if not data or table.count(data) < 1 then
    local tipsStr = StringTable.Get("str_assistant_cg_bg_tip2")
    ToastManager.ShowToast(tipsStr)
    return
  end
  self:TypeBtnClick(UIChooseAssistantBgType.Season)
end

function UIChooseMainBgController:TypeBtnClick(type)
  local curBtn = self._bgTypeBtns[self._btnStatus]
  if curBtn then
    curBtn.selectObj:SetActive(false)
  end
  self._btnStatus = type
  local btn = self._bgTypeBtns[type]
  btn.selectObj:SetActive(true)
  self._curBGInfo = btn.data
  if self._initScrollViewFlag then
    self:_ResetListView()
    self._currentChooseID = self._curBGInfo[1].id
    self._spawnBtnList[1]:bgOnClick()
  else
    self:_InitScrollView()
    self._currentChooseID = self._curBGInfo[1].id
    self._spawnBtnList[1]:bgOnClick()
  end
end

function UIChooseMainBgController:AutoSwithSpineBtnOnClick()
  self.bMultiSpineAuto = false
  self:_RefreshMultiSpinesModel()
  self:ResetBgIndex()
end

function UIChooseMainBgController:ManulSwithSpineBtnOnClick()
  self.bMultiSpineAuto = true
  self:_RefreshMultiSpinesModel()
  self:ResetBgIndex()
end

function UIChooseMainBgController:ResetBgIndex(forceCheckAutho)
  local cfg, num = self:CheckMulSpineCg(self._currentChooseID)
  if cfg then
    if forceCheckAutho then
      if self._currentMainBgID == self._currentChooseID then
        self.bMultiSpineAuto = not self._current_is_hand_operate
      else
        self.bMultiSpineAuto = true
      end
    end
    if self.bMultiSpineAuto then
      self.spineIndex = num
    elseif self._currentMainBgID == self._currentChooseID then
      self.spineIndex = self._current_hand_spine_index
      if self.spineIndex == num then
        self.spineIndex = 1
      end
    else
      self.spineIndex = 1
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeMainBg, self._btnStatus, self._currentChooseID, true, false, false, false, self.spineIndex)
  end
end

function UIChooseMainBgController:PreSpineBtnOnClick()
  self:ChgBgIndexByStep(-1)
end

function UIChooseMainBgController:NextSpineBtnOnClick()
  self:ChgBgIndexByStep(1)
end

function UIChooseMainBgController:ChgBgIndexByStep(step)
  local cfg, arrLen = self:CheckMulSpineCg(self._currentChooseID)
  if not cfg then
    return
  end
  local num = arrLen - 1
  if 1 < num then
    self.spineIndex = self.spineIndex or 1
    self.spineIndex = self.spineIndex + step
    if self.spineIndex <= 0 then
      self.spineIndex = num
    elseif num < self.spineIndex then
      self.spineIndex = 1
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeMainBg, self._btnStatus, self._currentChooseID, true, false, false, false, self.spineIndex)
  end
end

function UIChooseMainBgController:CheckMulSpineCg(cgId)
  local cfg = Cfg.cfg_cg_book[cgId]
  if cfg and cfg.Type == UIChooseAssistantBgType.MultiSpineSkin and cfg.Spine then
    local num = #cfg.Spine
    return cfg, num
  end
end
