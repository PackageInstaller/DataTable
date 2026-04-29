_class("UIBookEntryCell", Object)
UIBookEntryCell = UIBookEntryCell

function UIBookEntryCell:Constructor()
  self.localCfg = {
    [BookMainType.RenShiQingBao] = {
      StringTable.Get("str_book_main_renshi"),
      "tujian_main_tu1",
      "tujian_main_icon1",
      "tujian_main_guang1",
      "tujian_main_lock4",
      true
    },
    [BookMainType.CG] = {
      StringTable.Get("str_book_main_cg"),
      "tujian_main_tu2",
      "tujian_main_icon2",
      "tujian_main_guang2",
      "tujian_main_lock3",
      true
    },
    [BookMainType.Music] = {
      StringTable.Get("str_book_main_music"),
      "tujian_main_tu3",
      "tujian_main_icon3",
      "tujian_main_guang3",
      "tujian_main_lock3",
      true
    },
    [BookMainType.Plot] = {
      StringTable.Get("str_book_main_plot"),
      "tujian_main_tu4",
      "tujian_main_icon6",
      "tujian_main_guang6",
      "tujian_main_lock4",
      false
    },
    [BookMainType.Medal] = {
      StringTable.Get("str_book_main_medal"),
      "tujian_main_tu5",
      "tujian_main_icon7",
      "tujian_main_guang7",
      "tujian_main_lock4",
      false
    }
  }
end

function UIBookEntryCell:OnShow(uiView)
  self.uiView = uiView
  self.nameTxt = self.uiView:GetUIComponent("UILocalizationText", "name")
  self.pic = self.uiView:GetUIComponent("RawImageLoader", "pic")
  self.picGO = self.uiView:GetGameObject("pic")
  self.selectImg = self.uiView:GetUIComponent("Image", "press")
  self.logo = self.uiView:GetUIComponent("Image", "logo")
  self.logoSelectGO = self.uiView:GetGameObject("press")
  self.logoSelectGO:SetActive(false)
  self.chooseGO = self.uiView:GetGameObject("choose")
  self.chooseGO:SetActive(false)
  self.lockGO = self.uiView:GetGameObject("lock")
  self.unLockGO = self.uiView:GetGameObject("unlock")
  self._uiCustomEventListener = UICustomUIEventListener:New()
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.picGO), UIEvent.Press, function(go)
    self.logoSelectGO:SetActive(true)
    self.chooseGO:SetActive(true)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.picGO), UIEvent.Release, function(go)
    self.logoSelectGO:SetActive(false)
    self.chooseGO:SetActive(false)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.picGO), UIEvent.Click, function(go)
    if self.bookMainType == BookMainType.RenShiQingBao then
      GameGlobal.UIStateManager():ShowDialog("UIBookRoleMapController")
    elseif self.bookMainType == BookMainType.CG then
      GameGlobal.UIStateManager():ShowDialog("UIBookCGPreviewController")
    elseif self.bookMainType == BookMainType.Music then
      GameGlobal.UIStateManager():ShowDialog("UIAlbumController")
    elseif self.bookMainType == BookMainType.Plot then
      local mMission = GameGlobal.GetModule(MissionModule)
      local data = mMission:GetDiscoveryData()
      local canReviewStages = data:GetCanReviewStorys()
      if not canReviewStages or table.count(canReviewStages) <= 0 then
        ToastManager.ShowToast(StringTable.Get("str_discovery_no_can_review_plot"))
        return
      end
      local stage = canReviewStages[table.count(canReviewStages)]
      GameGlobal.UIStateManager():ShowDialog("UIPlot", stage, canReviewStages)
    elseif self.bookMainType == BookMainType.Medal then
      local unLock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_MEDAL)
      if not unLock then
        ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
      else
        GameGlobal.UIStateManager():ShowDialog("UIMedalMainController")
      end
    end
  end)
end

function UIBookEntryCell:GetLocalCfg()
  return self.localCfg[self.bookMainType]
end

function UIBookEntryCell:Refresh(uiView, bookMainType, atlas)
  self:OnShow(uiView)
  self.bookMainType = bookMainType
  local name = self:GetLocalCfg()[1]
  self.nameTxt:SetText(name)
  self.pic:LoadImage(self:GetLocalCfg()[2])
  self.logo.sprite = atlas:GetSprite(self:GetLocalCfg()[3])
  self.selectImg.sprite = atlas:GetSprite(self:GetLocalCfg()[4])
end

function UIBookEntryCell:OnHide()
  self._uiCustomEventListener:Dispose()
end

function UIBookEntryCell:picOnClick()
end

function UIBookEntryCell:SetUnlock(bUnlock)
  self.unLockGO:SetActive(bUnlock)
  self.lockGO:SetActive(not bUnlock)
end

function UIBookEntryCell:SetRed(bRed)
  if not self._red then
    self._red = self.uiView:GetGameObject("red")
  end
  if self._red then
    self._red:SetActive(bRed)
  end
end
