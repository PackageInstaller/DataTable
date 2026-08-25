local BackTrackSelectPanel, Super = System.NewClass("BackTrackSelectPanel", UIBasePanel)
BackTrackSelectPanel.uiResCls = UI_Awaker_Popup_Backtrace_TipResource

function BackTrackSelectPanel:ctor(itemId)
  Super.ctor(self)
  self.itemId = itemId
  self._tabSelectedIndexDict = {}
end

function BackTrackSelectPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(BackTrackSelectModel, self.itemId)
  self.itemModel = binder:createModel(CommonIconItemModel)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:BindAwakerList()
  self:BindWeaponList()
  local tRelativeUIs = {
    [CommonDefine.BackTrackType.NormalAwaker] = {
      self.ui.Btn_Bookmark_1,
      self.ui.ScrollView_Awake
    },
    [CommonDefine.BackTrackType.UniqueAwaker] = {
      self.ui.Btn_Bookmark_2,
      self.ui.ScrollView_Awake
    },
    [CommonDefine.BackTrackType.Weapon] = {
      self.ui.Btn_Bookmark_3,
      self.ui.ScrollView_Thing
    }
  }
  for tabType, relativeData in pairs(tRelativeUIs) do
    local toggleUi, relativeUi = relativeData[1], relativeData[2]
    binder:BindToZ1Toggle(toggleUi, relativeUi, function(isOn)
      if isOn then
        self.model:SetCurTab(tabType)
      end
    end)
  end
  self:BindDetailBtn()
  self:BindConfirmBtn()
  binder:BindToRaw(function(childBinder, show)
    self.ui.Group_Null_Black:SetActive(show)
    self.ui.Btn_Confirm:SetActive(not show)
    self.ui.Btn_Details:SetActive(not show)
  end, function()
    local curTab = self.model:GetCurTab()
    if curTab == CommonDefine.BackTrackType.Weapon then
      local list = self.model.weaponList
      return #list <= 0
    else
      local list = self.model.awakerList
      return #list <= 0
    end
  end)
end

function BackTrackSelectPanel:UseBackItemSuccess(name, selectId)
  local function confirmFunc()
    local curTab = self.model:GetCurTab()
    
    if curTab == CommonDefine.BackTrackType.NormalAwaker or curTab == CommonDefine.BackTrackType.UniqueAwaker then
      local awakerBasePanelData = {
        jumpPage = CommonDefine.AwakerPage.BackTrack,
        selectAwakerId = selectId
      }
      UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
    else
      UIManager.Instance:Reopen(Urls.AwakerWeaponStrengthPanel, selectId, true)
    end
  end
  
  local tipsId = 20116
  local desc = LT.Textf(DT.TipsType[tipsId].Desc, name)
  Alert.Show(tipsId, nil, confirmFunc, nil, desc)
end

function BackTrackSelectPanel:BindConfirmBtn()
  self.binder:BindZ1Button(self.ui.Btn_Confirm, function()
    local curTab = self.model:GetCurTab()
    local isSelected = curTab == CommonDefine.BackTrackType.Weapon and self.model:GetCurWeaponUid() or self.model:GetCurAwakerId()
    if not isSelected then
      return
    end
    local name = ""
    local selectId = 0
    local isInTask = false
    
    local function reqFunc()
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("GameRequest", "OnUseBacktrackItem", function(data)
        self:UseBackItemSuccess(name, selectId)
        self:Close()
      end, function(_, code)
        Logger.Error("[回溯道具使用] 失败！错误码: %s", code.code)
      end, self.itemId, self.model:GetChooseTid())
    end
    
    if curTab == CommonDefine.BackTrackType.NormalAwaker or curTab == CommonDefine.BackTrackType.UniqueAwaker then
      name = AwakerDataUtils.GetAwakerName(self.model:GetCurAwakerId())
      selectId = self.model:GetCurAwakerId()
      isInTask = TaskDataUtils.AwakerInTask(self.model:GetCurAwakerId())
    else
      selectId = self.model:GetCurWeaponUid()
      name = ItemDataUtils.GetItemName(self.model:GetCurWeaponTid())
    end
    local backTips = 20114
    if isInTask then
      backTips = 20126
      Alert.Show(backTips)
    else
      if curTab == CommonDefine.BackTrackType.UniqueAwaker then
        Alert.ShowWithParams(20165, {name}, nil, reqFunc)
        return
      end
      if curTab == CommonDefine.BackTrackType.Weapon and ItemDataUtils.CheckIsMaxLvSSRWeapon(selectId) and DBGTeamDataUtils.IsTogetherWithSSRWeapon(selectId) then
        Alert.ShowWithParams(20213, {name}, nil, reqFunc)
      else
        Alert.ShowWithParams(backTips, {name}, nil, reqFunc)
      end
    end
  end, function()
    local curTab = self.model:GetCurTab()
    local isSelected = curTab == CommonDefine.BackTrackType.Weapon and self.model:GetCurWeaponUid() or self.model:GetCurAwakerId()
    local isInTask = false
    if curTab == CommonDefine.BackTrackType.NormalAwaker or curTab == CommonDefine.BackTrackType.UniqueAwaker then
      isInTask = TaskDataUtils.AwakerInTask(self.model:GetCurAwakerId())
    end
    local canBackTrack = isSelected and not isInTask
    return canBackTrack and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Unclickable
  end)
end

function BackTrackSelectPanel:BindDetailBtn()
  self.binder:BindZ1Button(self.ui.Btn_Details, function()
    local curTab = self.model:GetCurTab()
    local isSelected = curTab == CommonDefine.BackTrackType.Weapon and self.model:GetCurWeaponUid() or self.model:GetCurAwakerId()
    if not isSelected then
      return
    end
    if curTab == CommonDefine.BackTrackType.NormalAwaker or curTab == CommonDefine.BackTrackType.UniqueAwaker then
      local function panelOpenFunc()
        local awakerId = self.model:GetCurAwakerId()
        
        if not awakerId or 0 == awakerId then
          return
        end
        local awakerBasePanelData = {}
        awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
        awakerBasePanelData.specialAwakerList = {
          AwakerDataUtils.GetAwakerData(awakerId)
        }
        UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
      end
      
      FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
    else
      local weaponUid = self.model:GetCurWeaponUid()
      local weaponTid = self.model:GetCurWeaponTid()
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Group_Top, weaponUid, weaponTid, true)
    end
  end, function()
    local curTab = self.model:GetCurTab()
    local isSelected = curTab == CommonDefine.BackTrackType.Weapon and self.model:GetCurWeaponUid() or self.model:GetCurAwakerId()
    return isSelected and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Unclickable
  end)
end

function BackTrackSelectPanel:BindAwakerList()
  self.binder:BindToCircularListView(self.ui.ScrollView_Awake, function()
    return self.model.awakerList
  end, function(childBinder, obj, index)
    local list = self.model.awakerList
    local awakerData = list[index]
    local itemData = {
      awakerData = awakerData,
      clickFunc = function()
        local curTab = self.model:GetCurTab()
        self._tabSelectedIndexDict[curTab] = index
        self.model:SetCurAwakerId(awakerData.tid)
      end,
      selectFunc = function()
        return awakerData.tid == self.model:GetCurAwakerId()
      end,
      wrongBgFunc = function()
        do return TaskDataUtils.AwakerInTask end
        return TaskDataUtils.AwakerInTask, awakerData.tid
      end,
      showPotencyInfoFunc = function()
        do return AwakerDataUtils.HasOwnedAwaker end
        return AwakerDataUtils.HasOwnedAwaker, awakerData.tid
      end
    }
    childBinder:BindComponent(CommonAwakerListItem(obj, itemData))
    local curTab = self.model:GetCurTab()
    local curSelectedIndex = self._tabSelectedIndexDict[curTab] or 1
    if curSelectedIndex == index then
      self.model:SetCurAwakerId(awakerData.tid)
    end
  end)
end

function BackTrackSelectPanel:BindWeaponList()
  self.binder:BindToCircularListView(self.ui.ScrollView_Thing, function()
    return self.model.weaponList
  end, function(childBinder, obj, index)
    local list = self.model.weaponList
    local value = list[index]
    local itemData = {
      tid = value.tid,
      uid = value.uid,
      model = self.itemModel,
      callback = function()
        local curTab = self.model:GetCurTab()
        self._tabSelectedIndexDict[curTab] = index
        self.model:SetCurWeaponUid(value.uid)
        self.model:SetCurWeaponTid(value.tid)
      end,
      ShowRedDot = false,
      ShowLockImg = false,
      ShowOwnAwaker = false,
      clickFrameShowFunc = function()
        return value.uid == self.model:GetCurWeaponUid()
      end,
      showName = true
    }
    self.binder:BindComponent(CommonIconItem(obj, itemData))
    local curTab = self.model:GetCurTab()
    local curSelectedIndex = self._tabSelectedIndexDict[curTab] or 1
    if curSelectedIndex == index then
      self.model:SetCurWeaponUid(value.uid)
      self.model:SetCurWeaponTid(value.tid)
    end
  end)
end

return BackTrackSelectPanel
