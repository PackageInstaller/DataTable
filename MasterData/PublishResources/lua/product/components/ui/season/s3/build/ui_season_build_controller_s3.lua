_class("UISeasonBuildControllerS3", UIController)
UISeasonBuildControllerS3 = UISeasonBuildControllerS3

function UISeasonBuildControllerS3:LoadDataOnEnter(TT, res)
  self._seaonModule = GameGlobal.GetModule(SeasonModule)
  self._context = self._seaonModule:GetSeasonBuildContext()
  if not self._context then
    self._context = UISeasonBuildContextS3:New()
    self._context:Init()
    self._seaonModule:SetSeasonBuildContext(self._context)
  end
  self._uiModule = GameGlobal.GetUIModule(SeasonModule)
  res:SetSucc(true)
end

function UISeasonBuildControllerS3:OnShow(uiParams)
  self._hide = false
  self._eventPoint = uiParams[1]
  self._backCb = uiParams[2]
  self:InitWidget()
  self:InitTabBtn(1)
  self:RefreshBuildView()
  self:Lock("UISeasonBuildControllerS3:_EnterAnimation")
  self:StartTask(function(TT)
    self:_EnterAnimation(TT)
  end)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UISeasonBuildControllerS3:OnHide()
  self._hide = true
end

function UISeasonBuildControllerS3:_EnterAnimation(TT)
  self.animation:Play("uieff_UISeasonBuildControllerS3_in")
  YIELD(TT, 1000)
  self:UnLock("UISeasonBuildControllerS3:_EnterAnimation")
end

function UISeasonBuildControllerS3:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UISeasonTopBtn")
  self._backBtns:SetData(function()
    self:CloseDialog()
    if self._backCb then
      self._backCb(true)
    end
  end, function()
    self._uiModule:ExitSeasonTo(UIStateType.UIMain)
  end, nil, function()
    self:ShowDialog("UIIntroLoader", "UISeasonS3BuildIntro", MaskType.MT_BlurMask)
  end, nil)
  self.tabBtn = self:GetUIComponent("UISelectObjectPath", "tabBtn")
  self.plan = self:GetUIComponent("UISelectObjectPath", "plan")
  self.program = self:GetUIComponent("UISelectObjectPath", "program")
  self.planGo = self:GetGameObject("plan")
  self.programGo = self:GetGameObject("program")
  self.levelUpEffGo = self:GetGameObject("levelupEff")
  self.levelUpingEffGo = self:GetGameObject("levelUpingEff")
  local viewPool = self:GetUIComponent("UISelectObjectPath", "buildView")
  self.buildView = viewPool:SpawnObject("UISeasonBuildViewS3")
  self.buildView:Init(self._context)
  local selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfo")
  self._tips = selectInfoPool:SpawnObject("UISelectInfo")
  self.txtUpTips = self:GetUIComponent("UILocalizationText", "txtUpTips")
  self.animation = self:GetUIComponent("Animation", "animation")
  self.switchAni = self:GetUIComponent("Animation", "switchAni")
end

function UISeasonBuildControllerS3:InitTabBtn(defaultIndex)
  local btns = {
    [1] = {
      index = 1,
      name = "str_season_s3_castle_tab_1"
    },
    [2] = {
      index = 2,
      name = "str_season_s3_castle_tab_2"
    }
  }
  local len = #btns
  self.btnTabWidgets = self.tabBtn:SpawnObjects("UISeasonBuildTabBtnS3", len)
  for i, cfg in ipairs(btns) do
    local subWidget = self.btnTabWidgets[i]
    subWidget:SetData(cfg, function(index)
      self:OnTabBtnClicked(index)
    end)
  end
  self.tabIndex = defaultIndex or 1
  self:RefreshTabBtnSelect()
  self:RefreshContentByIndex(self.tabIndex)
end

function UISeasonBuildControllerS3:RefreshBuildView()
  self.buildView:Refresh()
end

function UISeasonBuildControllerS3:OnTabBtnClicked(index)
  if index == self.tabIndex then
    return
  end
  self.tabIndex = index
  self:RefreshTabBtnSelect()
  self:RefreshContentByIndex(self.tabIndex)
  if index == 1 then
    self.switchAni:Play("uieff_UISeasonBuildControllerS3_Switch02")
  else
    self.switchAni:Play("uieff_UISeasonBuildControllerS3_Switch01")
  end
end

function UISeasonBuildControllerS3:RefreshTabBtnSelect()
  for i, cfg in ipairs(self.btnTabWidgets) do
    local subWidget = self.btnTabWidgets[i]
    subWidget:SetSelect(self.tabIndex == i)
  end
end

function UISeasonBuildControllerS3:RefreshContentByIndex(index)
  self.planGo:SetActive(index == 2)
  self.programGo:SetActive(index == 1)
  if index == 1 then
    self:RefreshProgram()
  else
    self:RefreshPlan()
  end
end

function UISeasonBuildControllerS3:RefreshProgram()
  if not self.programWidget then
    self.programWidget = self.program:SpawnObject("UISeasonBuildProgramS3")
    self.programWidget:InitWithRewardClickCb(function(itemId, pos)
      self:ShowItemInfo(itemId, pos)
    end)
  end
  self.programWidget:SetData(self._context, function()
    self:OnBuildLevelUpBtnClick()
  end)
end

function UISeasonBuildControllerS3:RefreshPlan()
  if not self.planWidget then
    self.planWidget = self.plan:SpawnObject("UISeasonBuildPlanS3")
    self.planWidget:InitWithRewardClickCb(function(itemId, pos)
      self:ShowItemInfo(itemId, pos)
    end)
  end
  self.planWidget:SetData(self._context)
end

function UISeasonBuildControllerS3:OnBuildLevelUpBtnClick()
  if self._seaonModule:GetCurSeasonID() < 1 then
    self:_SeasonEnd()
    return
  end
  local level = self._context:GetCurLevel()
  local cfg = self._context:GetBuildCfgByLevel(level)
  local showCfg = Cfg.cfg_season_castle_show[cfg.ID]
  if showCfg then
    self.txtUpTips:SetText(StringTable.Get(showCfg.AndongTalk))
  end
  self:StartTask(function(TT)
    self:Lock("UISeasonBuildControllerS3_Up_Castle")
    self:_RequestLevelUp(TT)
  end)
end

function UISeasonBuildControllerS3:_RequestLevelUp(TT)
  local level = self._context:GetCurLevel()
  local cfg = self._context:GetBuildCfgByLevel(level)
  local res, msg = self._seaonModule:HandleSeasonCastleReq(TT, cfg.ID)
  if not msg then
    Log.error("UISeasonBuildContextS3 _RequestLevelUp error ", res.m_result)
    self:UnLock("UISeasonBuildControllerS3_Up_Castle")
    if res.m_result == 3 then
      self:_SeasonEnd()
    end
    return
  end
  self:RefreshBuildView()
  self.animation:Play("uieff_UISeasonBuildControllerS3_leveluping")
  YIELD(TT, 4300)
  if self._hide or self._seaonModule:GetCurSeasonID() < 1 then
    self:_SeasonEnd()
    self:UnLock("UISeasonBuildControllerS3_Up_Castle")
    return
  end
  local rewardList = {}
  for k, v in pairs(cfg.Reward) do
    local subReard = RoleAsset:New()
    subReard.assetid = v[1]
    subReard.count = v[2]
    table.insert(rewardList, subReard)
  end
  UISeasonHelper.ShowUIGetRewards(rewardList)
  self:RefreshProgram()
  self:UnLock("UISeasonBuildControllerS3_Up_Castle")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonBuildLevelUp)
end

function UISeasonBuildControllerS3:OnUIGetItemCloseInQuest()
  self:Lock("UISeasonBuildControllerS3_Up_UIGetItemClose")
  self.levelUpEffGo:SetActive(true)
  self:StartTask(function(TT)
    YIELD(TT, 1700)
    self:UnLock("UISeasonBuildControllerS3_Up_UIGetItemClose")
    if not self._hide then
      self.levelUpEffGo:SetActive(false)
    end
  end)
end

function UISeasonBuildControllerS3:ShowItemInfo(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UISeasonBuildControllerS3:_SeasonEnd()
  self._seaonModule:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
  self._seaonModule:UIModule():ExitSeasonTo(UIStateType.UIMain)
end
