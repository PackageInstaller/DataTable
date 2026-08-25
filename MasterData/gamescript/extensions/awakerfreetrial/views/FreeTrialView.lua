local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local T_GridLayoutGroup = typeof(CS.UnityEngine.UI.GridLayoutGroup)
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local FreeTrialView, Super = NewClass("FreeTrialView", BaseView)
FreeTrialView.uiResCls = UI_Dungeons_Panel_TryResource

function FreeTrialView:ctor()
  Super.ctor(self)
  self.defaultStageId = nil
end

function FreeTrialView:OnBuildView()
  Super.OnBuildView(self)
end

function FreeTrialView:RefreshOnRendered()
  self.uiAnimController:PlayState("UI_Dungeons_Panel_Try_Open")
  self:PlayTableViewFadeInAnim(self.ui.ScrollView_Wake)
end

function FreeTrialView:OnEnterView()
  Super.OnEnterView(self)
  self.defaultStageId = nil
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self:InitAwakerGroups()
  self:_RefreshToggleState()
  local isShowLimitAwaker = self:IsShowLimitAwaker()
  self:SetActive(self.ui.Btn_Activity_Awaker, isShowLimitAwaker)
end

function FreeTrialView:_RefreshToggleState()
  self:SetZ1Toggle(self.ui.Btn_Activity_Awaker, false, true)
  self:SetZ1Toggle(self.ui.Btn_Star_Awaker, false, true)
  self:SetZ1Toggle(self.ui.Btn_Normal_Awaker, false, true)
  local trialType = FreeTrialModel.Instance:GetTrialType()
  if trialType == CommonDefine.TrialType.Normal then
    self:SetZ1Toggle(self.ui.Btn_Normal_Awaker, true, true)
    self:OnToggleNormalAwaker(true)
  elseif trialType == CommonDefine.TrialType.Limit then
    self:SetZ1Toggle(self.ui.Btn_Activity_Awaker, true, true)
    self:OnToggleLimitAwaker(true)
  elseif trialType == CommonDefine.TrialType.Star then
    self:SetZ1Toggle(self.ui.Btn_Star_Awaker, true, true)
    self:OnToggleStarAwaker(true)
  end
end

function FreeTrialView:OnEnterViewFinished()
  self.uiAnimController:PlayState("UI_Dungeons_Panel_Try_Open")
end

function FreeTrialView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Wake, System.fn(self, self.Click2Awake))
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self.ReqGetPrize))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Try, System.fn(self, self.TrialPlay))
  self:AddButtonClickListener(self.ui.Btn_Check, System.fn(self, self.ShowAwakerDetail))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Activity_Awaker, System.fn(self, self.OnToggleLimitAwaker))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Normal_Awaker, System.fn(self, self.OnToggleNormalAwaker))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Star_Awaker, System.fn(self, self.OnToggleStarAwaker))
end

function FreeTrialView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnSelectTrialAwaker, self.UpdateSelectAwaker, self)
  self:RegisterLocalNotify(NotifyId.UpdateTrialAwaker, self.UpdateAwakerDesc, self)
  self:RegisterNotify(NotifyId.OnPanelClosing, self.OnPanelClosing, self)
end

function FreeTrialView:OnPanelClosing(url)
  if url == Urls.CommonillustrateView then
    local go = GuidePanelUtils.GetNodeGo("UI_Dungeons_Main_View(Clone).UI_Common_Btn_Back3.Image_Icon")
    NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_ExitAwakerTrail", go, Urls.DungeonsMainView)
  end
end

function FreeTrialView:IsShowLimitAwaker()
  local groupList = FreeTrialController.Instance:GetSchoolGoupsData(cd.TrialType.Limit)
  return #groupList > 0
end

function FreeTrialView:OnToggleLimitAwaker(isOn)
  if isOn then
    self:OnChangeTrialType(cd.TrialType.Limit)
  end
end

function FreeTrialView:OnToggleNormalAwaker(isOn)
  if isOn then
    self:OnChangeTrialType(cd.TrialType.Normal)
  end
end

function FreeTrialView:OnToggleStarAwaker(isOn)
  if isOn then
    self:OnChangeTrialType(cd.TrialType.Star)
  end
end

function FreeTrialView:OnChangeTrialType(trailType)
  FreeTrialModel.Instance:SetTrialType(trailType)
  self.groupList = FreeTrialController.Instance:GetSchoolGoupsData()
  self:CalcAndCacheSize()
  self.tableView:ReloadData()
  self:SetActive(self.ui.Btn_Wake, trailType == cd.TrialType.Normal)
  self:PlayTableViewFadeInAnim(self.ui.ScrollView_Wake)
  self:SelectDefault()
end

function FreeTrialView:ShowAwakerDetail()
  local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(FreeTrialModel.Instance.curStageId)
  
  local function panelOpenFunc()
    local awakerBasePanelData = {}
    awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
    awakerBasePanelData.specialAwakerList = {
      AwakerDataUtils.GetAwakerData(awakerTid)
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
end

function FreeTrialView:ReqGetPrize()
  FreeTrialController.Instance:ReqGetPrize(FreeTrialModel.Instance.curStageId)
end

function FreeTrialView:TrialPlay()
  FreeTrialController.Instance:TrialPlay(FreeTrialModel.Instance.curStageId)
end

function FreeTrialView:Click2Awake()
  local awakerId = FreeTrialController.Instance:GetAwakerByStageId(FreeTrialModel.Instance.curStageId)
  local school = AwakerDataUtils.GetAwakerSchool(awakerId)
  for _, cfg in pairs(DT.Summon) do
    if cfg.Type == CommonDefine.SummonPoolType.NormalAwaker and cfg.ShowSchool == school then
      SummonDataUtils.SetSelectCareer(cfg.ID)
      SummonDataUtils.ReqChooseCareer(cfg.ID)
      SummonDataUtils.OpenSummonPanel(cfg.ID)
      break
    end
  end
end

function FreeTrialView:UpdateAwakerDesc()
  self:UpdateScrollView_Rewards()
  self:UpdateFinishState()
  self:UpdateRed()
end

function FreeTrialView:UpdateSelectAwaker(curSelectId, awakerId)
  FreeTrialModel.Instance.curStageId = curSelectId
  self:ChangeAwakerTid(awakerId)
  self:SetAwakerDesc(awakerId)
  self:UpdateScrollView_Rewards()
  self:UpdateFinishState()
  self:UpdateRed()
  self:ResetDescribe()
end

function FreeTrialView:UpdateFinishState()
  local controller = FreeTrialController.Instance
  self.ui.Group_Finish:SetActive(controller:FinshAndGetedAward(FreeTrialModel.Instance.curStageId))
  self.ui.Btn_Receive:SetActive(controller:CanGetAward(FreeTrialModel.Instance.curStageId))
  self.ui.Image_Undone:SetActive(not controller:FinishTrial(FreeTrialModel.Instance.curStageId))
end

function FreeTrialView:SetAwakerDesc(awakerId)
  local _, _, awakerName = CopyDataUtils.GetAwakerByStageId(FreeTrialModel.Instance.curStageId)
  self:SetText(self.ui.Text_Name, awakerName)
  self:SetText(self.ui.Text_Position, AwakerDataUtils.GetAwakerType(awakerId))
  self:SetText(self.ui.Text_Describe, AwakerDataUtils.GetAwakerIntroduction(awakerId))
  StrUtils.SetPreferredHeight(self.ui.Text_Describe)
end

function FreeTrialView:ChangeAwakerTid(awakerId)
  if self.portraitCom == nil then
    local params = {
      awakerTid = awakerId,
      portraitAlign = CommonDefine.PortraitAlign.Center
    }
    self.portraitCom = self:AddViewComponentOnce(self.ui.Container_Awaker_Half, UICompAwakerPortrait, params)
  else
    self.portraitCom:SetAwakerTid(awakerId)
  end
end

function FreeTrialView:UpdateRed()
  local func = RedPointDataUtils.TrialStageHasAward
  if self.redCom == nil then
    self.redCom = self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
      do return func end
      return func, FreeTrialModel.Instance.curStageId
    end)
  else
    local result = func(FreeTrialModel.Instance.curStageId)
    self.redCom:SetRedDotShow(CommonDefine.RedDotType.Dot, result)
  end
  local limitStageIdList = FreeTrialModel.Instance:GetStageIdListByType(cd.TrialType.Limit)
  local hasLimitReward = FreeTrialController.Instance:HasAwardInStageIdList(limitStageIdList)
  self:SetActive(self.ui.Activity_RedDot, hasLimitReward)
  local normalStageIdList = FreeTrialModel.Instance:GetStageIdListByType(cd.TrialType.Normal)
  local normalLimitReward = FreeTrialController.Instance:HasAwardInStageIdList(normalStageIdList)
  self:SetActive(self.ui.Normal_RedDot, normalLimitReward)
  local starStageIdList = FreeTrialModel.Instance:GetStageIdListByType(cd.TrialType.Star)
  local starLimitReward = FreeTrialController.Instance:HasAwardInStageIdList(starStageIdList)
  self:SetActive(self.ui.Star_RedDot, starLimitReward)
end

function FreeTrialView:InitAwakerGroups()
  self.tableView = self:CreateTableview(self.ui.ScrollView_Wake, function()
    return #self.groupList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Dungeous_Item_Try)
    self:AddViewComponentOnce(cell.gameObject, FreeTrialGroup, self.groupList[index])
    return cell
  end, function(_, index)
    return self.CacheSize[index].x, self.CacheSize[index].y
  end)
end

function FreeTrialView:SetDefaultStageId(trialType, defaultStageId, awakerTid)
  if awakerTid then
    trialType, defaultStageId = FreeTrialModel.Instance:GetTypeAndStageIdByAwakerTid(awakerTid)
  end
  self.defaultStageId = defaultStageId
  FreeTrialModel.Instance:SetTrialType(trialType)
  self:_RefreshToggleState()
end

function FreeTrialView:SelectDefault()
  if not self.defaultStageId then
    FreeTrialModel.Instance:SetTrialType(cd.TrialType.Normal)
  end
  if 0 == #self.groupList or 0 == #self.groupList[1].list then
    return
  end
  local defaultStageId = self.defaultStageId and self.defaultStageId or self.groupList[1].list[1]
  local awakerId = FreeTrialController.Instance:GetAwakerByStageId(defaultStageId)
  self:LocalNotify(NotifyId.OnSelectTrialAwaker, defaultStageId, awakerId)
  self.defaultStageId = nil
end

function FreeTrialView:CalcAndCacheSize()
  local cellRT = self.ui.UI_Dungeous_Item_Try:GetComponent(TYPEOF_RectTransform)
  local tempUI = UI_Dungeous_Item_TryResource(self.ui.UI_Dungeous_Item_Try)
  local gridCom = tempUI.Content:GetComponent(T_GridLayoutGroup)
  local colsNum = gridCom.constraintCount
  local ySpace = gridCom.spacing.y
  local itemHeight = gridCom.cellSize.y
  local width, baseheight = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.CacheSize = {}
  for index, group in ipairs(self.groupList) do
    self.CacheSize[index] = {}
    local dataCnt = #group.list
    local rowNum = math.ceil(dataCnt / colsNum)
    local realH = rowNum * itemHeight + (rowNum - 1) * ySpace + baseheight
    self.CacheSize[index].x = width
    self.CacheSize[index].y = realH
  end
  local lastIndex = #self.groupList
  self.CacheSize[lastIndex].y = self.CacheSize[lastIndex].y
end

function FreeTrialView:UpdateScrollView_Rewards()
  self.rewards = FreeTrialController.Instance:GetPrizeList(FreeTrialModel.Instance.curStageId)
  if self.ScrollView_Award_View == nil then
    local cellRT = self.ui.UI_Common_Item_WuPin_Type2:GetComponent(TYPEOF_RectTransform)
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.ScrollView_Award_View = self:CreateTableview(self.ui.ScrollView_Award, function()
      return #self.rewards
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
      local reward = self.rewards[index]
      self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, reward)
      return cell
    end, function()
      return width, height
    end)
  end
  self.ScrollView_Award_View:ReloadData()
end

function FreeTrialView:ResetDescribe()
  if not self.scrollView_Describe then
    self.scrollView_Describe = self.ui.ScrollView_Describe:GetComponentInParent(T_ScrollRect)
  end
  self.scrollView_Describe.verticalNormalizedPosition = 1
end

return FreeTrialView
