local DBGEntryPage = CommonDefine.DBGEntryPage
local Page_Material = DBGEntryPage.MaterialPanel
local Page_Trinket = DBGEntryPage.TrinketPanel
local Page_WeekBoss = DBGEntryPage.WeekBossPanel
local Page_SchoolTower = DBGEntryPage.SchoolTowerPanel
local Page_Mock = DBGEntryPage.MockPanel
local Page_Send = DBGEntryPage.SendPanel
local FeatureId = CommonDefine.FeatureId
local DefaultBgImagePath = DT.GetConstant("ChallengeDefaultPicture")
local DungeonsMainView, Super = NewClass("DungeonsMainView", BaseView)
DungeonsMainView.uiResCls = UI_Dungeons_Main_ViewResource

function DungeonsMainView:ctor(targetPage)
  Super.ctor(self)
  self.targetPage = targetPage or Page_Material
  DungeonMainModel.Instance.curDBGEntryPage = self.targetPage
  self.Closing = false
end

function DungeonsMainView:_InitChildrenTapViews()
  self.childrenTapViews = {
    [Page_Material] = {
      UIUrl = Urls.DungeonMaterialView,
      Name = "DungeonMaterialView",
      UINodeName = "UI_Dungeons_Material_View",
      viewInstance = nil,
      toggleUI = self.ui.Btn_Material,
      featureId = FeatureId.ResCopy,
      redPoint = self.ui.RedDot_Material,
      redFunc = RedPointDataUtils.IsShowResCopy,
      redType = RedPointDataUtils.RedType.ResCopyNew,
      closeAnim = "UI_Dungeons_Material_View_Close",
      rules = {
        titleKey = "RuleTipsTitle",
        contentKey = "DailyCopyRules"
      }
    },
    [Page_Trinket] = {
      UIUrl = Urls.DungeonsTrinketView,
      Name = "DungeonsTrinketView",
      UINodeName = "UI_Dungeons_Trinket_View",
      viewInstance = nil,
      toggleUI = self.ui.Btn_Trinket,
      featureId = FeatureId.TrinketCopy,
      redPoint = self.ui.RedDot_Trinket,
      redFunc = RedPointDataUtils.IsShowTrinketNew,
      redType = RedPointDataUtils.RedType.TrinketCopyNew,
      closeAnim = "UI_Dungeons_Trinket_View_Close",
      rules = {
        titleKey = "RuleTipsTitle",
        contentKey = "TrinketCopyRules"
      }
    },
    [Page_WeekBoss] = {
      UIUrl = Urls.WeekBossView,
      Name = "WeekBossView",
      UINodeName = "UI_Dungeons_Panel_WeekBOSS",
      viewInstance = nil,
      toggleUI = self.ui.Btn_WeekBOSS,
      redPoint = self.ui.RedDot_WeekBOSS,
      featureId = FeatureId.WeekBossChallenge,
      redFunc = RedPointDataUtils.IsShowWeekBossNew,
      redType = RedPointDataUtils.RedType.WeekBossChallenge,
      closeAnim = "UI_Dungeons_Panel_WeekBOSS_Close"
    },
    [Page_SchoolTower] = {
      UIUrl = Urls.SchoolTowerView,
      Name = "SchoolTowerView",
      UINodeName = "UI_Dungeons_Panel_Realms",
      viewInstance = nil,
      redPoint = self.ui.RedDot_Realms,
      toggleUI = self.ui.Btn_Realms,
      featureId = FeatureId.AlternationSchoolTower,
      redFunc = RedPointDataUtils.IsShowSchoolTowerNew,
      redType = RedPointDataUtils.RedType.AlternationSchoolTower,
      rules = {
        titleKey = "RuleTipsTitle",
        contentKey = "SchoolTowerRuleTxt"
      },
      closeAnim = "UI_Dungeons_Panel_Realms_Close"
    },
    [Page_Mock] = {
      UIUrl = Urls.DungeonMockPanel,
      Name = "DungeonMockPanel",
      UINodeName = "UI_Dungeons_Panel_Mock",
      viewInstance = nil,
      toggleUI = self.ui.Btn_Mock,
      featureId = FeatureId.MockBattle,
      redPoint = self.ui.RedDot_Mock,
      redFunc = RedPointDataUtils.IsShowMock,
      redType = RedPointDataUtils.RedType.MockCopy
    },
    [Page_Send] = {
      UIUrl = Urls.TaskDispatchView,
      Name = "TaskDispatchView",
      UINodeName = "UI_Dungeons_Panel_Send",
      viewInstance = nil,
      toggleUI = self.ui.Btn_Send,
      featureId = FeatureId.Task,
      featureTypeKey = 1,
      redPoint = self.ui.RedDot_Send,
      redFunc = RedPointDataUtils.IsShowDispatchTaskRed,
      redType = 0,
      closeAnim = "UI_Research_Panel_Dispatch_Close"
    }
  }
end

function DungeonsMainView:_OnChildTapViewSwitchedFinished()
  Super._OnChildTapViewSwitchedFinished(self)
end

function DungeonsMainView:OnBuildView()
  self.compCloseBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.OnClose))
  self:SetText(self.ui.Text_Title, LT.Text("MainInterface_Challenge"))
end

function DungeonsMainView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnDungeonEntryPageChanged, self.SwitchPage, self)
end

function DungeonsMainView:RegisterEvents()
  for page, cfg in pairs(self.childrenTapViews) do
    self:AddZ1ToggleValueChangedListener(cfg.toggleUI, function(isOn)
      self:_OnClickPage(page)
    end)
  end
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickRules))
end

function DungeonsMainView:OnEnterView()
  Super.OnEnterView(self)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self.uiAnimController:PlayState("UI_Dungeons_Main_View_Open")
  local targetPageCfg = self.childrenTapViews[self.targetPage]
  if not self:_CheckChildrenViewUnlock(targetPageCfg) then
    self.targetPage = self:_GetDefaultPage()
    DungeonMainModel.Instance.curDBGEntryPage = self.targetPage
  end
  self.targetPage = nil
  self:SwitchPage(DungeonMainModel.Instance:GetCurDBGEntryPage())
end

function DungeonsMainView:SwitchPage(curPage)
  if self.targetPage == curPage then
    return
  end
  self.targetPage = curPage
  local cfg = self.childrenTapViews[curPage]
  RedPointDataUtils.ReqRemoveData(cfg.redType, RedPointDataUtils.RedAttrType.IsNew)
  self:_RefreshChildrenTaps()
  self:SwitchChildTapView(curPage)
  if self._illustrateTimer then
    self:StopTimer(self._illustrateTimer)
  end
  self._illustrateTimer = self:BindTimer(0.1, 0, nil, function()
    if cfg.rules then
      PlayerDataUtils.OpenFirstTimeIllustrate(cfg.Name, LT.Text(cfg.rules.titleKey), LT.Text(cfg.rules.contentKey))
    end
  end)
end

function DungeonsMainView:_RefreshChildrenTaps()
  local curPage = DungeonMainModel.Instance:GetCurDBGEntryPage()
  for page, cfg in pairs(self.childrenTapViews) do
    local toggleUI = cfg.toggleUI
    local unlocked = self:_CheckChildrenViewUnlock(cfg)
    toggleUI:SetActive(unlocked)
    if not unlocked then
    else
      self:AddViewComponentOnce(cfg.redPoint, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, cfg.redFunc)
      self:SetZ1Toggle(toggleUI, curPage == page, true)
    end
  end
  self:SetText(self.ui.Text_Label, DungeonMainModel.Instance:GetDBGEntryPageTitle(curPage))
  local curCfg = self.childrenTapViews[curPage]
  local bgImagePath = curCfg.specialBackgroung or DefaultBgImagePath
  self:SetImageSync(self.ui.Image_Bg, bgImagePath)
  self.ui.UI_Common_Btn_Question:SetActive(curCfg.rules ~= nil)
end

function DungeonsMainView:_OnClickPage(page)
  AudioManager.Instance:PostSoundEvent("UI_MATERIAL_PAGE_FLIP")
  DungeonMainModel.Instance:SetCurDBGEntryPage(page)
end

function DungeonsMainView:_OnClickRules()
  local curPage = DungeonMainModel.Instance:GetCurDBGEntryPage()
  local curCfg = self.childrenTapViews[curPage]
  if curCfg.rules ~= nil then
    UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text(curCfg.rules.titleKey), LT.Text(curCfg.rules.contentKey))
  end
end

function DungeonsMainView:OnClose()
  if self.Closing then
    return
  end
  self.compCloseBtn:PlayCloseAnim()
  DungeonMaterialModel.Instance:ResetStageGroupId()
  local viewInstance = self.childrenTapViews[self.targetPage].viewInstance
  local closeAnim = self.childrenTapViews[self.targetPage].closeAnim
  self.Closing = true
  if viewInstance and closeAnim then
    local childAnimController = viewInstance.uiAnimController
    if childAnimController then
      childAnimController:PlayState(closeAnim)
    end
  end
  UIManager.Instance:ReShowBehindPanel(self)
  if self.closeWithoutAnim then
    self:Close()
  else
    self.uiAnimController:PlayState("UI_Dungeons_Main_View_Close", function()
      self:Close()
    end)
  end
end

function DungeonsMainView:Close()
  Super.Close(self)
  if not CopyBackJumpUtils.needStackJump and not SceneMgr.Instance:IsInTown() then
    SceneMgr.Instance:EnterTown()
  end
end

function DungeonsMainView:_GetDefaultPage()
  local rst = CommonDefine.DBGEntryPage.Quit
  for page, cfg in pairs(self.childrenTapViews) do
    local unlocked = self:_CheckChildrenViewUnlock(cfg)
    if unlocked then
      rst = math.min(page, rst)
    end
  end
  if rst == CommonDefine.DBGEntryPage.Quit then
    return CommonDefine.DBGEntryPage.MaterialPanel
  end
  return rst
end

function DungeonsMainView:_CheckChildrenViewUnlock(cfg)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cfg.featureId, cfg.featureTypeKey or 0)
  if cfg.activityOpenedFunc and unlocked then
    unlocked = cfg.activityOpenedFunc()
  end
  return unlocked
end

return DungeonsMainView
