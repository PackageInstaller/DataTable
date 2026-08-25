local AlchemyPage = AlchemyDefine.AlchemyPage
local TOGGLE_ANIM_DURATION_FRAME = 1
local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local AlchemyMainView, Super = NewClass("AlchemyMainView", BaseView)
AlchemyMainView.uiResCls = UI_Alchemy_Panel_MainResource

function AlchemyMainView:ctor(jumpToAlchemyType, jumpToItemTid)
  Super.ctor(self)
  self.jumpToAlchemyType = jumpToAlchemyType
  self.jumpToItemTid = jumpToItemTid
end

function AlchemyMainView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnAlchemyPageChanged, self.SwitchPage, self)
end

function AlchemyMainView:RegisterEvents()
end

function AlchemyMainView:OnEnterView()
  Super.OnEnterView(self)
  self:_OnInitViewData()
  self:_OnInitCloseBtn()
  self:_OnInitDefaultPage()
  self:_OnInitToggle()
  self:RefreshView()
  self:_PlayToggleAnim()
end

function AlchemyMainView:_OnInitToggle()
  for _, toggleObj in pairs(self.toggleObjectList) do
    self:AddZ1ToggleValueChangedListener(toggleObj.obj, toggleObj.onToggleChange)
    self:AddViewComponentOnce(UI_Bag_Item_ToggleResource(toggleObj.obj).Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, toggleObj.redFunc)
    if Utils.IsLangEN() then
      StrUtils.SetChildTextPreferredFontSize(toggleObj.obj)
    end
  end
end

function AlchemyMainView:_OnInitDefaultPage()
  local selectSort = math.maxinteger
  if self.jumpToAlchemyType then
    selectSort = self.toggleObjectList[self.jumpToAlchemyType].showSort
  else
    for _, toggleInfo in pairs(self.toggleObjectList) do
      local _, unlocked = PlayerDataUtils.IsFeatureUnlock(toggleInfo.featureId, PlayerDataUtils.GetFeatureMainTypeKey())
      if unlocked and selectSort > toggleInfo.showSort then
        selectSort = toggleInfo.showSort
      end
    end
  end
  if self.jumpToItemTid then
    self.model:Set_jumpToItemTid(self.jumpToItemTid)
  end
  for _, toggleInfo in pairs(self.toggleObjectList) do
    if toggleInfo.showSort == selectSort then
      RedPointDataUtils.ReqRemoveData(toggleInfo.redType, RedPointDataUtils.RedAttrType.IsNew)
      self.model:Set_curPage(toggleInfo.page)
      self:SetZ1Toggle(toggleInfo.obj, true)
      return
    end
  end
end

function AlchemyMainView:SwitchPage(newPage)
  if not newPage then
    return
  end
  if newPage == AlchemyPage.Quit then
    UIManager.Instance:ReShowBehindPanel(self)
    self:Close()
    return
  end
  self:SwitchChildTapView(newPage)
end

function AlchemyMainView:_OnInitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    self.model:Set_curPage(AlchemyPage.Quit)
    self.closeBtn:PlayCloseAnim()
  end)
end

function AlchemyMainView:RefreshView()
  self:RefreshToggle()
end

function AlchemyMainView:RefreshToggle()
  for _, toggleObj in pairs(self.toggleObjectList) do
    self:SetZ1ToggleTextColorType(toggleObj.obj, toggleObj.page == self.model:Get_curPage() and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal)
  end
end

function AlchemyMainView:_OnInitViewData()
  self.model = AlchemyMainExtModel.Instance
  self.isAlchemyClosed = false
  self.childrenTapViews = {
    [AlchemyPage.CompositePanel] = {
      Name = "AlchemyCompositeView",
      UINodeName = "UI_Alchemy_Popup_Compound",
      labelName = LT.Text("ComposeTitle"),
      viewInstance = nil,
      UIUrl = Urls.AlchemyCompositeView
    },
    [AlchemyPage.DecompositePanel] = {
      Name = "AlchemyDecomposeWeaponView",
      UINodeName = "UI_Alchemy_Popup_ResolveWeapon",
      labelName = LT.Text("DecomposeTitle"),
      viewInstance = nil,
      UIUrl = Urls.AlchemyDecomposeWeaponView
    },
    [AlchemyPage.TrinketDecompositePanel] = {
      Name = "AlchemyDecomposeTrinketView",
      UINodeName = "UI_Alchemy_Popup_ResolveMaterials",
      labelName = LT.Text("TrinketDecomposeTitle"),
      viewInstance = nil,
      UIUrl = Urls.AlchemyDecomposeTrinketView
    },
    [AlchemyPage.ItemDecompositePanel] = {
      Name = "AlchemyDecomposeItemView",
      UINodeName = "UI_Alchemy_Popup_ResolveItem",
      labelName = LT.Text("ItemDecomposeTitle"),
      viewInstance = nil,
      UIUrl = Urls.AlchemyDecomposeItemView
    },
    [AlchemyPage.ExchangePanel] = {
      Name = "AlchemyExchangeView",
      UINodeName = "UI_Alchemy_Popup_Permute_Optimize",
      labelName = LT.Text("Exchange_Start"),
      viewInstance = nil,
      UIUrl = Urls.AlchemyExchangeView
    }
  }
  self.toggleObjectList = {
    [AlchemyDefine.AlchemyType.Compose] = {
      obj = self.ui.Toggle_Alchemy,
      redType = RedPointDataUtils.RedType.ComposeNew,
      redFunc = RedPointDataUtils.IsShowNewCompose,
      onToggleChange = System.fn(self, self._OnToggleAlchemy),
      showSort = 1,
      featureId = CommonDefine.FeatureId.Compose,
      page = AlchemyPage.CompositePanel
    },
    [AlchemyDefine.AlchemyType.Decompose] = {
      obj = self.ui.Toggle_Resolve,
      redType = RedPointDataUtils.RedType.DecomposeNew,
      redFunc = RedPointDataUtils.IsShowNewDecompose,
      onToggleChange = System.fn(self, self._OnToggleDecompose),
      showSort = 4,
      featureId = CommonDefine.FeatureId.Decompose,
      page = AlchemyPage.DecompositePanel,
      needBan = not table.next(ItemDataUtils.GetRedundantWeaponList())
    },
    [AlchemyDefine.AlchemyType.Exchange] = {
      obj = self.ui.Toggle_Permute,
      redType = RedPointDataUtils.RedType.ExchangeNew,
      redFunc = RedPointDataUtils.IsShowNewExchange,
      onToggleChange = System.fn(self, self._OnToggleExchange),
      showSort = 3,
      featureId = CommonDefine.FeatureId.Exchange,
      page = AlchemyPage.ExchangePanel
    },
    [AlchemyDefine.AlchemyType.TrinketDecompose] = {
      obj = self.ui.Toggle_ResolveMaterials,
      redType = RedPointDataUtils.RedType.DecomposeNew,
      redFunc = RedPointDataUtils.IsShowNewDecompose,
      onToggleChange = System.fn(self, self._OnToggleTrinketDecompose),
      showSort = 5,
      featureId = CommonDefine.FeatureId.TrinketDecompose,
      page = AlchemyPage.TrinketDecompositePanel
    },
    [AlchemyDefine.AlchemyType.ItemDecompose] = {
      obj = self.ui.Toggle_ResolveItem,
      redType = RedPointDataUtils.RedType.DecomposeNew,
      redFunc = RedPointDataUtils.IsShowNewDecompose,
      onToggleChange = System.fn(self, self._OnToggleItemDecompose),
      showSort = 6,
      featureId = CommonDefine.FeatureId.MaterialDecompose,
      page = AlchemyPage.ItemDecompositePanel
    }
  }
  for idx, toggleInfo in pairs(self.toggleObjectList) do
    if toggleInfo.needBan then
      self:SetActive(toggleInfo.obj, false)
      self.toggleObjectList[idx] = nil
    end
  end
end

function AlchemyMainView:RefreshOnRendered()
end

function AlchemyMainView:OnEnterViewFinished()
end

function AlchemyMainView:_PlayToggleAnim()
  local playIdx = 1
  local toggleAnimGroup = {}
  for _, toggleObj in pairs(self.toggleObjectList) do
    toggleObj.obj:SetActive(false)
    table.insert(toggleAnimGroup, toggleObj)
  end
  table.sort(toggleAnimGroup, function(a, b)
    return a.showSort < b.showSort
  end)
  for _, toggleObj in ipairs(toggleAnimGroup) do
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(toggleObj.featureId, PlayerDataUtils.GetFeatureMainTypeKey())
    if unlocked then
      FrameWaiter.OnNextFrame(function()
        if self.isAlchemyClosed then
          return
        end
        toggleObj.obj:SetActive(unlocked)
        local toggleGo = UI_Common_Item_Toggle_4Resource(toggleObj.obj)
        local animController = toggleGo.uiNode:GetComponent(typeof(UIAnimationController))
        animController:PlayState("UI_Common_Item_Toggle_4_Open")
      end, TOGGLE_ANIM_DURATION_FRAME * playIdx)
      playIdx = playIdx + 1
    end
  end
end

function AlchemyMainView:Close()
  self.isAlchemyClosed = true
  Super.Close(self)
end

function AlchemyMainView:_OnToggleAlchemy()
  self:_OnToggleEnable(RedPointDataUtils.RedType.ComposeNew, AlchemyDefine.AlchemyPage.CompositePanel)
end

function AlchemyMainView:_OnToggleDecompose()
  self:_OnToggleEnable(RedPointDataUtils.RedType.DecomposeNew, AlchemyDefine.AlchemyPage.DecompositePanel)
end

function AlchemyMainView:_OnToggleTrinketDecompose()
  self:_OnToggleEnable(RedPointDataUtils.RedType.DecomposeNew, AlchemyDefine.AlchemyPage.TrinketDecompositePanel)
end

function AlchemyMainView:_OnToggleItemDecompose()
  self:_OnToggleEnable(RedPointDataUtils.RedType.DecomposeNew, AlchemyDefine.AlchemyPage.ItemDecompositePanel)
end

function AlchemyMainView:_OnToggleExchange()
  self:_OnToggleEnable(RedPointDataUtils.RedType.ExchangeNew, AlchemyDefine.AlchemyPage.ExchangePanel)
end

function AlchemyMainView:_OnToggleEnable(redType, page)
  RedPointDataUtils.ReqRemoveData(redType, RedPointDataUtils.RedAttrType.IsNew)
  self.model:Set_curPage(page)
end

function AlchemyMainView:OnExitView()
  Super.OnExitView(self)
end

return AlchemyMainView
