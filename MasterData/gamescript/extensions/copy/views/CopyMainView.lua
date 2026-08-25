local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local Page_MainChapter = cd.MainCopyPanelPage.MainChapter
local Page_LargeSubplot = cd.MainCopyPanelPage.LargeSubplot
local Page_SmallSubplot = cd.MainCopyPanelPage.SmallSubplot
local Page_Vindicate = cd.MainCopyPanelPage.Vindicate
local Page_SpecialSubplot = cd.MainCopyPanelPage.SpecialSubplot
local Page_LinkageActivity = cd.MainCopyPanelPage.LinkageActivity
local CopyMainView, Super = NewClass("CopyMainView", BaseView)
CopyMainView.uiResCls = UI_Copy_Main_ViewResource

function CopyMainView:ctor(targetPage, targetDifficulty, extraParam)
  Super.ctor(self)
  self.targetPage = targetPage or Page_MainChapter
  self.targetDifficulty = targetDifficulty
  if extraParam then
    self._targetStageGroupTid = extraParam.targetStageGroupTid
  end
end

function CopyMainView:GetTempDependenciesResources()
  if self.targetPage then
    return {
      CopyExtModel.Instance:GetCopyPageResUrl(self.targetPage)
    }
  end
end

function CopyMainView:OnBuildView()
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.compBtnClosed = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    self:Close()
  end)
  self.mainBgCanvasGroup = self.ui.Mainbg:GetComponent(T_CanvasGroup)
end

function CopyMainView:_InitChildrenTapViews()
  self.childrenTapViews = {
    [Page_MainChapter] = {
      UIUrl = Urls.CopyMainChapterView,
      UINodeName = "ScrollView_Chaper",
      parent = self.ui.uiNode,
      viewInstance = nil,
      position = {33, -30},
      title = LT.Text("MainCopyTitle"),
      toggle = self.ui.toggle_1,
      bg = "UIResources/UIBigImages/UI_Common/UI_Large_Bg_01.png"
    },
    [Page_SmallSubplot] = {
      UIUrl = Urls.CopySmallBranchView,
      Name = "CopySmallBranchView",
      UINodeName = "ScrollView_SmallBranch",
      parent = self.ui.Image_branch,
      viewInstance = nil,
      title = LT.Text("SmallSubplotTitle"),
      illustrate = {
        LT.Text("SmallSubplotTipsTitle"),
        LT.Text("SmallSubplotTipsText")
      },
      toggle = self.ui.toggle_2,
      featureId = cd.FeatureId.SmallSubplotTab,
      bg = "UIResources/UIBigImages/UI_Common/UI_Large_Bg_01.png"
    },
    [Page_LargeSubplot] = {
      UIUrl = Urls.CopyLargeBranchView,
      Name = "CopyLargeBranchView",
      UINodeName = "ScrollView_branch",
      parent = self.ui.Image_branch,
      viewInstance = nil,
      title = LT.Text("LargeSubplotTitle"),
      illustrate = {
        LT.Text("LargeSubplotTipsTitle"),
        LT.Text("LargeSubplotTipsText")
      },
      toggle = self.ui.toggle_3,
      featureId = cd.FeatureId.LargeSubplotTab,
      bg = "UIResources/UIBigImages/UI_Common/UI_Large_Bg_01.png",
      hideFunc = function()
        local groupList = CopyExtModel.Instance:GetSublplotLargeGroupList()
        return 0 == #groupList
      end
    },
    [Page_Vindicate] = {
      UIUrl = Urls.CopyVindicateView,
      Name = "CopyVindicateView",
      UINodeName = "UI_Chapter_Vindicate_View",
      parent = self.ui.Image_branch,
      viewInstance = nil,
      title = LT.Text("VindicateTitle"),
      illustrate = {
        LT.Text("ConfessionEventRulesTitle"),
        LT.Text("ConfessionEventRulesDesc")
      },
      toggle = self.ui.toggle_4,
      featureId = cd.FeatureId.ConfessionEvent,
      resident = true,
      bg = "UIResources/UIBigImages/UI_Common/UI_Large_Bg_01.png"
    },
    [Page_LinkageActivity] = {
      UIUrl = Urls.CopyLinkageActivityView,
      params = {
        CopyExtModel.Instance:GetLinkageActivityNormalGroupList()
      },
      UINodeName = "UI_Chapter_Special_View",
      parent = self.ui.Image_branch,
      viewInstance = nil,
      title = LT.Text("LinkageActivityTitle"),
      toggle = self.ui.toggle_6,
      featureId = cd.FeatureId.SpecialSubplotTab,
      illustrate = {
        LT.Text("CollaborationSubplotTipsTitle"),
        LT.Text("CollaborationSubplotTipsText")
      },
      bg = "UIResources/UIBigImages/UI_Chapter/UI_Chaper_Image_Bg.png",
      hideFunc = function()
        local groupList = CopyExtModel.Instance:GetLinkageActivityNormalGroupList()
        return 0 == #groupList
      end
    },
    [Page_SpecialSubplot] = {
      UIUrl = Urls.CopySpecialBranchView,
      params = {
        CopyExtModel.Instance:GetSpecialGroupList()
      },
      UINodeName = "UI_Chapter_Dream_View",
      parent = self.ui.Image_branch,
      viewInstance = nil,
      title = LT.Text("SpecialSubplotTitle"),
      toggle = self.ui.toggle_5,
      illustrate = {
        LT.Text("SpecialSubplotTipsTitle"),
        LT.Text("SpecialSubplotTipsText")
      },
      featureId = cd.FeatureId.SpecialSubplotTab,
      bg = "UIResources/UIBigImages/UI_Chapter/UI_Chaper_Image_Bg.png"
    }
  }
end

function CopyMainView:_OnChildTapViewSwitchedFinished()
  Super._OnChildTapViewSwitchedFinished(self)
  local curPage = CopyExtModel.Instance:GetCurCopyPage()
  if curPage == Page_MainChapter and self.hasPlayOpenedAnim then
    self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_Chaper_Open")
  end
  if not self.hasPlayOpenedAnim then
    self.hasPlayOpenedAnim = true
    self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_Open")
  end
  if curPage == Page_LargeSubplot then
    local largeGroupIdList = CopyExtModel.Instance:GetSublplotLargeGroupList()
    self.ui.Group_Null_White:SetActive(0 == #largeGroupIdList)
  elseif curPage == Page_SmallSubplot then
    local groupIdList = CopyExtModel.Instance:GetSubplotGroupList()
    self.ui.Group_Null_White:SetActive(0 == #groupIdList)
  else
    self.ui.Group_Null_White:SetActive(false)
  end
end

function CopyMainView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnCopyPagedChanged, self._OnCopyPagedChanged, self)
  self:RegisterLocalNotify(NotifyId.OnCopyMainDifficultyChanged, self._OnCopyDifficultyChanged, self)
  self:RegisterNotify(NotifyId.OnClientDataChanged, self._OnClientDataChange, self)
end

function CopyMainView:RegisterEvents()
  self:_RegisterCopyTypeToggleEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickBtnTips))
end

function CopyMainView:_RegisterCopyTypeToggleEvents()
  for page, info in pairs(self.childrenTapViews) do
    if info.toggle then
      self:AddZ1ToggleValueChangedListener(info.toggle, function(isOn)
        if isOn then
          CopyExtModel.Instance:SetCurCopyPage(page)
          if info.Name and info.illustrate then
            PlayerDataUtils.OpenFirstTimeIllustrate(info.Name, info.illustrate[1], info.illustrate[2])
          end
        end
      end)
    end
  end
end

function CopyMainView:OnEnterView()
  Super.OnEnterView(self)
  self:_PrefetchSubplotBranchStageDataForRedDot()
  if CopyExtModel.Instance.curCopyPage ~= self.targetPage then
    CopyExtModel.Instance.curCopyPage = self.targetPage
  end
  if self.targetPage == Page_MainChapter then
    self.mainBgCanvasGroup.alpha = 0
  end
  self.hasPlayOpenedAnim = false
  self:SwitchPage(self.targetPage)
end

function CopyMainView:OnExitView()
  Super.OnExitView(self)
end

function CopyMainView:Close()
  self.compBtnClosed:PlayCloseAnim()
  UIManager.Instance:ReShowBehindPanel(self)
  self:_DisableAllCanvasGroupInteractable()
  self.uiAnimController:PlayState("UI_Chapter_Panel_Main2_Close", function()
    UIManager.Instance:CloseByUrl(Urls.CopyStageDetailView)
    UIManager.Instance:CloseByUrl(Urls.MainCopyChapterPanel)
    self:_ResumeAllCanvasGroupInteractable()
    Super.Close(self)
  end)
  if not SceneMgr.Instance:IsInTown() then
    SceneMgr.Instance:EnterTown()
  end
end

function CopyMainView:_RefreshCopyView()
  self:_RefreshCopyPage()
end

function CopyMainView:_RefreshCopyPage()
  local curPage = CopyExtModel.Instance:GetCurCopyPage()
  local childPageInfo = self.childrenTapViews[curPage]
  self:SetText(self.ui.Text_Title, childPageInfo.title or "")
  self.ui.UI_Common_Btn_Question:SetActive(childPageInfo.illustrate ~= nil)
  local isHideAllToggle = self:IsHideAllToggle()
  for page, info in pairs(self.childrenTapViews) do
    if info.toggle then
      self:SetZ1Toggle(info.toggle, curPage == page, true)
      local isShowToggle = true
      if info.resident then
        isShowToggle = true
      elseif info.featureId then
        local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(info.featureId, 0)
        isShowToggle = isUnlock
      end
      if info.hideFunc and info.hideFunc() then
        isShowToggle = false
      end
      if isHideAllToggle then
        isShowToggle = false
      end
      info.toggle:SetActive(isShowToggle)
    end
  end
end

function CopyMainView:IsHideAllToggle()
  if self.targetPage == Page_Vindicate then
    local info = self.childrenTapViews[Page_Vindicate]
    local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(info.featureId, 0)
    if not isUnlock then
      return true
    end
  end
end

function CopyMainView:_PrefetchSubplotBranchStageDataForRedDot()
  local stageGroupIdList = {}
  local idSet = {}
  for _, groupId in ipairs(CopyExtModel.Instance:GetSpecialGroupList()) do
    if not idSet[groupId] then
      idSet[groupId] = true
      table.insert(stageGroupIdList, groupId)
    end
  end
  for _, groupId in ipairs(CopyExtModel.Instance:GetLinkageActivityNormalGroupList()) do
    if not idSet[groupId] then
      idSet[groupId] = true
      table.insert(stageGroupIdList, groupId)
    end
  end
  CopyController.Instance:ReqSubplotBranchStageData(stageGroupIdList)
end

function CopyMainView:SwitchPage(curPage)
  local page = CopyExtModel.Instance:GetCurCopyPage()
  if curPage ~= page then
    CopyExtModel.Instance.curCopyPage = curPage
  end
  local pageInfo = self.childrenTapViews[curPage] or {}
  self:_RefreshCopyView()
  local targetDifficulty = self.targetDifficulty
  self.targetDifficulty = nil
  local targetStageGroupTid = self._targetStageGroupTid
  self._targetStageGroupTid = nil
  local params = pageInfo.params or {}
  self:SwitchChildTapView(curPage, targetDifficulty, targetStageGroupTid, table.unpack(params))
  if pageInfo.bg then
    self:SetImage(self.ui.bg, pageInfo.bg)
  end
end

function CopyMainView:_OnCopyPagedChanged(curPage)
  self:SwitchPage(curPage)
end

function CopyMainView:_OnClientDataChange()
  self:_RefreshCopyPage()
end

function CopyMainView:_OnCopyDifficultyChanged()
  self.uiAnimController:StopPlayableGraph()
end

function CopyMainView:_OnClickBtnTips()
  local curPage = CopyExtModel.Instance:GetCurCopyPage()
  local pageInfo = self.childrenTapViews[curPage]
  if pageInfo and pageInfo.illustrate then
    local title, content = table.unpack(pageInfo.illustrate)
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
  end
end

return CopyMainView
