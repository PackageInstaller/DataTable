local TrinketStrengthenTap = CommonDefine.TrinketStrengthenTap
local ModuleType = GuideNoteDefine.ModuleType
local Page = GuideNoteDefine.Page
local GuideNoteMainView, Super = NewClass("GuideNoteMainView", BaseView)
GuideNoteMainView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Panel_Main.prefab"

local function GetPrefabNameByUiUrl(uiUrl)
  if nil == uiUrl or "" == uiUrl then
    return nil
  end
  local uiCls = require("GameScript." .. uiUrl)
  local uiResCls = uiCls and uiCls.uiResCls or nil
  if type(uiResCls) ~= "string" or "" == uiResCls then
    return nil
  end
  return string.match(uiResCls, "([^/]+)%.prefab$") or uiResCls
end

local function GetAwakerStrengthSwitchArgs()
  local trinketUid = 0
  if AwakerTrinketExtModel and AwakerTrinketExtModel.Instance then
    trinketUid = AwakerTrinketExtModel.Instance:GetCurChoosenTrinketUid() or 0
  end
  local strengthenType = TrinketStrengthenTap and TrinketStrengthenTap.Upgrade or nil
  return strengthenType, trinketUid, nil
end

function GuideNoteMainView:ctor(params)
  Super.ctor(self)
  if type(params) == "number" then
    self._params = {}
    self._defaultPage = params
  else
    self._params = params or {}
    self._defaultPage = self._params.defaultPage or Page.DailyTraining
  end
end

function GuideNoteMainView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnGuideNoteMainModuleChanged, self._OnModuleChanged, self)
  self:RegisterNotify(NotifyId.OnDailyChallengeDataChanged, self._RefreshSidebarRedDotMap, self)
  self:RegisterLocalNotify(NotifyId.OnGuideNoteDataChanged, self._RefreshSidebarRedDotMap, self)
end

function GuideNoteMainView:RegisterEvents()
  Super.RegisterEvents(self)
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, System.fn(self, self._OnTaskViewUpdateForSidebarRed))
end

function GuideNoteMainView:_OnTaskViewUpdateForSidebarRed(taskSvrIdx)
  if nil ~= taskSvrIdx and taskSvrIdx ~= CommonDefine.TaskServerIndex.Daily and taskSvrIdx ~= CommonDefine.TaskServerIndex.Weekly then
    return
  end
  self:_RefreshSidebarRedDotMap()
end

function GuideNoteMainView:OnBuildView()
  Super.OnBuildView(self)
  self:_InitPageConfigs()
  self:_RefreshMainTitle()
  self:_InitCloseBtn()
  self:_InitSidebarToggles()
  self:_InitSidebarRedDots()
  self:_InitRulesBtn()
end

function GuideNoteMainView:_InitPageConfigs()
  self._pageConfigList = {
    {
      page = Page.DailyTraining,
      toggle = self.ui.Toggle_DailyActivity,
      uiUrl = Urls.GuideNoteDailyTaskView,
      UINodeName = "UI_GuideNote_Panel_Task_Daily",
      subTitle = LT.Text("GuideNote_Title2"),
      rulesTitleKey = "GuideNote_Rules_Title1",
      rulesDescKey = "GuideNote_Rules_Description1"
    },
    {
      page = Page.WeeklyTraining,
      toggle = self.ui.Toggle_WeeklyActivity,
      uiUrl = Urls.GuideNoteWeeklyTaskView,
      UINodeName = "UI_GuideNote_Panel_Task_Weekly",
      subTitle = LT.Text("GuideNote_Title3"),
      rulesTitleKey = "GuideNote_Rules_Title2",
      rulesDescKey = "GuideNote_Rules_Description2"
    },
    {
      page = Page.AwakerStrengthen,
      toggle = self.ui.Toggle_AwakerStrength,
      uiUrl = Urls.GuideNoteAwakerStrengthView,
      buildSwitchArgs = GetAwakerStrengthSwitchArgs,
      subTitle = LT.Text("GuideNote_Title4"),
      rulesTitleKey = "GuideNote_Rules_Title3",
      rulesDescKey = "GuideNote_Rules_Description3"
    },
    {
      page = Page.PermTraining,
      toggle = self.ui.Toggle_PermTrain,
      uiUrl = Urls.GuideNotePermTrainingView,
      subTitle = LT.Text("GuideNote_Title5"),
      rulesTitleKey = "GuideNote_Rules_Title4",
      rulesDescKey = "GuideNote_Rules_Description4"
    },
    {
      page = Page.StoryGuide,
      toggle = self.ui.Toggle_Story,
      uiUrl = Urls.CopyStoryGuideView,
      buildSwitchArgs = function()
        return self._params and self._params.targetStageGroupTid
      end,
      subTitle = LT.Text("GuideNote_Title6"),
      rulesTitleKey = "GuideNote_Rules_Title5",
      rulesDescKey = "GuideNote_Rules_Description5"
    },
    {
      page = Page.ResExploration,
      toggle = self.ui.Toggle_ResExploration,
      uiUrl = Urls.GuideNoteResExplorationView,
      subTitle = LT.Text("GuideNote_Title7"),
      rulesTitleKey = "GuideNote_Rules_Title6",
      rulesDescKey = "GuideNote_Rules_Description6"
    }
  }
  self._pageConfigByPage = {}
  for _, cfg in ipairs(self._pageConfigList) do
    cfg.UINodeName = cfg.UINodeName or GetPrefabNameByUiUrl(cfg.uiUrl)
    self._pageConfigByPage[cfg.page] = cfg
  end
end

function GuideNoteMainView:_EnsurePageConfigs()
  if self._pageConfigList == nil or nil == self._pageConfigByPage then
    self:_InitPageConfigs()
  end
end

function GuideNoteMainView:_InitChildrenTapViews()
  self:_EnsurePageConfigs()
  local parent = self.ui.CompCon or self.ui.uiNode
  self.childrenTapViews = {}
  for _, cfg in ipairs(self._pageConfigList) do
    self.childrenTapViews[cfg.page] = {
      UIUrl = cfg.uiUrl,
      UINodeName = cfg.UINodeName,
      parent = parent
    }
  end
end

function GuideNoteMainView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshSidebarRedDotMap()
  local page = self:_NormalizePage(self._defaultPage)
  local changed = GuideNoteModel.Instance:SetCurPage(page)
  if changed then
    return
  end
  self:_ApplyPage(page)
end

function GuideNoteMainView:_RefreshSidebarRedDotMap()
  if GuideNoteModel and GuideNoteModel.Instance and GuideNoteModel.Instance.RefreshSidebarRedDotMap then
    GuideNoteModel.Instance:RefreshSidebarRedDotMap()
  end
end

function GuideNoteMainView:OnEnterViewFinished()
  self:_SyncToggle(self:_NormalizePage(self._defaultPage))
end

function GuideNoteMainView:Close()
  Super.Close(self)
  if not SceneMgr.Instance:IsInTown() then
    SceneMgr.Instance:EnterTown(true)
  end
end

function GuideNoteMainView:_InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    UIManager.Instance:CloseByUrl(Urls.GuideNoteTierRewardTipView)
    self:Close()
  end)
end

function GuideNoteMainView:_InitSidebarToggles()
  self:_EnsurePageConfigs()
  self._toggleByPage = {}
  for _, cfg in ipairs(self._pageConfigList) do
    local toggle = cfg.toggle
    if toggle then
      self._toggleByPage[cfg.page] = toggle
      self:AddZ1ToggleValueChangedListener(toggle, function(isOn)
        if isOn then
          GuideNoteModel.Instance:SetCurPage(cfg.page)
        end
      end)
    end
  end
end

function GuideNoteMainView:_InitSidebarRedDots()
  if self.ui.Redot_DailyActivity then
    self:AddRedPoint(self.ui.Redot_DailyActivity, RedDotDefine.DynamicRedDotID.GuideNoteSidebarTab, {
      moduleType = ModuleType.DailyActivity
    })
  end
  if self.ui.Redot_WeeklyActivity then
    self:AddRedPoint(self.ui.Redot_WeeklyActivity, RedDotDefine.DynamicRedDotID.GuideNoteSidebarTab, {
      moduleType = ModuleType.WeeklyActivity
    })
  end
  if self.ui.Redot_AwakerStrength then
    self:AddRedPoint(self.ui.Redot_AwakerStrength, RedDotDefine.DynamicRedDotID.GuideNoteSidebarTab, {
      moduleType = ModuleType.AwakerStrength
    })
  end
  if self.ui.Redot_PermTrain then
    self:AddRedPoint(self.ui.Redot_PermTrain, RedDotDefine.DynamicRedDotID.GuideNoteSidebarTab, {
      moduleType = ModuleType.PermTrain
    })
  end
  if self.ui.Redot_Story then
    self:AddRedPoint(self.ui.Redot_Story, RedDotDefine.DynamicRedDotID.GuideNoteSidebarTab, {
      moduleType = ModuleType.StoryGuide
    })
  end
end

function GuideNoteMainView:_SwitchToPage(page)
  self:_EnsurePageConfigs()
  local cfg = self._pageConfigByPage[page]
  local buildSwitchArgs = cfg and cfg.buildSwitchArgs or nil
  if nil ~= buildSwitchArgs then
    local arg1, arg2, arg3, arg4 = buildSwitchArgs()
    self:SwitchChildTapView(page, arg1, arg2, arg3, arg4)
    if page == Page.StoryGuide and self._params then
      self._params.targetStageGroupTid = nil
    end
  else
    self:SwitchChildTapView(page)
  end
end

function GuideNoteMainView:_OnModuleChanged(page)
  self:_ApplyPage(self:_NormalizePage(page))
end

function GuideNoteMainView:_ApplyPage(page)
  self:_RefreshSubTitle(page)
  self:_RefreshRulesBtn(page)
  self:_SwitchToPage(page)
  self:_SyncToggle(page)
end

function GuideNoteMainView:_RefreshMainTitle()
  if self.ui and self.ui.Text_Title then
    self:SetText(self.ui.Text_Title, LT.Text("GuideNote_Title1"))
  end
end

function GuideNoteMainView:_RefreshSubTitle(page)
  self:_EnsurePageConfigs()
  if self.ui == nil or nil == self.ui.Text_Label then
    return
  end
  local cfg = self._pageConfigByPage and self._pageConfigByPage[page] or nil
  local subTitle = cfg and cfg.subTitle or ""
  self:SetText(self.ui.Text_Label, subTitle)
end

function GuideNoteMainView:_InitRulesBtn()
  if self.ui.UI_Common_Btn_Question then
    self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickRulesBtn))
  end
end

function GuideNoteMainView:_RefreshRulesBtn(page)
  if not self.ui or not self.ui.UI_Common_Btn_Question then
    return
  end
  self:_EnsurePageConfigs()
  local cfg = self._pageConfigByPage and self._pageConfigByPage[page] or nil
  local rulesDescKey = cfg and cfg.rulesDescKey or nil
  local hasDesc = false
  if rulesDescKey and "" ~= rulesDescKey then
    local descText = LT.Text(rulesDescKey)
    hasDesc = nil ~= descText and "" ~= descText and descText ~= rulesDescKey
  end
  self.ui.UI_Common_Btn_Question:SetActive(hasDesc)
end

function GuideNoteMainView:_OnClickRulesBtn()
  local page = GuideNoteModel.Instance:GetCurPage() or self._defaultPage
  self:_EnsurePageConfigs()
  local cfg = self._pageConfigByPage and self._pageConfigByPage[page] or nil
  if not cfg then
    return
  end
  local rulesTitleKey = cfg.rulesTitleKey
  local rulesDescKey = cfg.rulesDescKey
  if not rulesTitleKey or not rulesDescKey then
    return
  end
  local title = LT.Text(rulesTitleKey)
  local desc = LT.Text(rulesDescKey)
  if not desc or "" == desc or desc == rulesDescKey then
    return
  end
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, desc)
end

function GuideNoteMainView:_NormalizePage(page)
  self:_EnsurePageConfigs()
  if self._pageConfigByPage[page] ~= nil then
    return page
  end
  return self._defaultPage
end

function GuideNoteMainView:_SyncToggle(page)
  if not self._toggleByPage then
    return
  end
  for targetPage, toggle in pairs(self._toggleByPage) do
    self:SetZ1Toggle(toggle, page == targetPage, true)
  end
end

return GuideNoteMainView
