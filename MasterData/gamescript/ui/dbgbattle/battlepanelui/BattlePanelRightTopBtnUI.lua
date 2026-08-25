local BP = bc.BattleProperty
local BattlePanelRightTopBtnUI, Super = System.NewComponent("BattlePanelRightTopBtnUI")

function BattlePanelRightTopBtnUI:ctor(battlePanel, uiNode)
  Super.ctor(self)
  self.ui = UI_Battle_Panel_DbgResource(uiNode)
  self.battlePanel = battlePanel
end

function BattlePanelRightTopBtnUI:OnBind(binder)
  self.binder = binder
  self:BindSettingBtn(binder)
  local deathResistName = AwakerDataUtils.GetAttrCnName(bc.RoleProperty.death_resist)
  local deathResit = {
    go = self.ui.Group_Dead,
    title = deathResistName,
    textFunc = function()
      local deathResist = bg.battleDataCenter:GetPlayerRoleProperty(BP.death_resist)
      local deathResistTimes = bg.battleDataCenter:GetPlayerRoleProperty(BP.death_resist_times)
      local cfgCoff = 1 - bg.DT.GetConstant("Death_resist_coefficient", 0.5)
      local coffPlus = bg.battleDataCenter:GetPlayerRoleProperty(BP.death_resist_coefficient_plus) or 0
      local deathResistCoff = 1 - (cfgCoff - coffPlus / 100)
      do return string.format, "%d%%", math.ceil(deathResist * deathResistCoff ^ deathResistTimes) end
      return string.format, "%d%%", math.ceil(deathResist * deathResistCoff ^ deathResistTimes)
    end,
    popTipTittle = deathResistName,
    popTipDesFunc = function()
      local desc = LT.Text("Battle_Tips_DeathResist", true)
      return desc
    end
  }
  self:BindBtnInfo(deathResit)
  local boutBtnInfo = {
    go = self.ui.Group_Times,
    title = LT.Text("Battle_Btn_TurnInfo"),
    textFunc = function()
      local state = bg.battleDataCenter:GetPlayerStateById(DT.GetConstant("RoundLimitState", 0))
      local layer = state and state.layer or 0
      local boutNum = bg.battleRender.boutMgr:GetBoutNum()
      if layer > 0 then
        if layer <= boutNum then
          do return string.color, (string.format("%s/%s", boutNum, layer)) end
          return string.color, string.format("%s/%s", boutNum, layer), "#ff5a5a", boutNum, layer
        end
        do return string.format, "%s/%s", boutNum end
        return string.format, "%s/%s", boutNum, layer, layer
      end
      do return tostring, bg.battleRender.boutMgr:GetBoutNum() end
      return tostring, bg.battleRender.boutMgr:GetBoutNum()
    end,
    popTipTittle = LT.Text("Battle_Btn_TurnInfo"),
    popTipDesFunc = function()
      do return LT.Text, "Battle_Tips_TurnInfo" end
      return LT.Text, "Battle_Tips_TurnInfo", true
    end
  }
  self:BindBtnInfo(boutBtnInfo)
  self:RefreshTrackBackNewTag()
  binder:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self.OnCloseUIPanel))
  binder:BindToVisible(self.ui.Group_BeHit, function()
    return true
  end)
  local beHitInfo = {
    go = self.ui.Group_BeHit,
    title = nil,
    textFunc = function()
      do return self.GetHitDamage end
      return self.GetHitDamage, self
    end,
    popTipTittle = LT.Text("Battle_Btn_BeDamageInfo"),
    popTipDesFunc = function()
      do return LT.Text, "Battle_Tips_BeDamageInfo" end
      return LT.Text, "Battle_Tips_BeDamageInfo", true
    end
  }
  self:BindBtnInfo(beHitInfo)
  local enchantName = AwakerDataUtils.GetAttrCnName(bc.RoleProperty.blackcoin_upgrade_per)
  local luckyEnchant = {
    go = self.ui.Group_Fortunate,
    title = enchantName,
    textFunc = function()
      local property = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.blackcoin_upgrade_per)
      do return string.format, "%s%%" end
      return string.format, "%s%%", property
    end,
    popTipTittle = enchantName,
    popTipDesFunc = function()
      do return LT.Text, "Battle_Tips_PhiloStoneDropBonusesTips" end
      return LT.Text, "Battle_Tips_PhiloStoneDropBonusesTips", true
    end
  }
  self:BindBtnInfo(luckyEnchant)
  local existsInitStates = false
  local isHide = false
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData then
    existsInitStates = StageInitialStateModel.Instance:ExistsInitialState(stageData.stageId)
    isHide = StageInitialStateModel.Instance:IsHideStageInitState(stageData.stageId)
    if CopyDataUtils.IsNewStageChapter(stageData.stageId) then
      self.binder:BindComponent(CopyChapterVueComp(self.ui.UI_Common_Btn_StageChapter, stageData.stageId, true))
    else
      self.binder:SetActive(self.ui.UI_Common_Btn_StageChapter, false)
    end
  else
    self.binder:SetActive(self.ui.UI_Common_Btn_StageChapter, false)
  end
  self.binder:SetActive(self.ui.Group_Dissolution, existsInitStates and not isHide)
  if existsInitStates then
    local btnIconPath = CommonRes.StageInitialStateBtnIcon.Debuff
    if StageInitialStateModel.Instance:HasPositiveInitialBuffState(stageData.stageId) then
      btnIconPath = CommonRes.StageInitialStateBtnIcon.Buff
    end
    self.binder:SetImage(self.ui.Image_Icon_Suppress, btnIconPath)
    self.binder:BindToText(self.ui.Text_Suppress, function()
      do return LT.Text, StageInitialStateModel.Instance:GetStageInitStateText(stageData.stageId) end
      return LT.Text, StageInitialStateModel.Instance:GetStageInitStateText(stageData.stageId)
    end)
    self.binder:BindButtonClick(self.ui.Group_Dissolution, function()
      UIManager.Instance:Reopen(Urls.StageInitialStateDetailView, stageData.stageId)
    end)
  end
  self:_UpdateRightBtnSpacing()
end

function BattlePanelRightTopBtnUI:_UpdateRightBtnSpacing()
  local activeCount = 0
  local transform = self.ui.Group_Dissolution.transform.parent
  for i = 1, transform.childCount do
    local go = transform:GetChild(i - 1).gameObject
    if go.activeSelf then
      activeCount = activeCount + 1
    end
  end
  local T_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)
  local horizontalLayoutGroup = transform.gameObject:GetComponent(T_HorizontalLayoutGroup)
  horizontalLayoutGroup.spacing = activeCount > 4 and -17 or -9
end

function BattlePanelRightTopBtnUI:GetHitDamage()
  local blind = bg.battleDataCenter:GetPlayerRoleProperty(bc.BattleProperty.blind)
  if blind and blind > 0 then
    do return LT.Text end
    return LT.Text, "MonsterHideIntention", nil, nil
  end
  local totalDmg = bg.battleDataCenter.monsterDamage.value
  if type(totalDmg) == "table" then
    do return tostring end
    return tostring, bc.NumberToK(totalDmg) and bc.NumberToK(totalDmg).totalDamage or 0, totalDmg
  else
    do return tostring end
    return tostring, bc.NumberToK(totalDmg) or 0, totalDmg
  end
end

function BattlePanelRightTopBtnUI:BindBtnInfo(btnInfo)
  local btnRes = Btn_Battle_DbgResource(btnInfo.go)
  self.binder:BindToText(btnRes.Text_Count, function()
    local textStr = btnInfo.textFunc()
    return textStr
  end)
  if btnInfo.title then
    self.binder:SetText(btnRes.Text_Title, btnInfo.title)
  end
  
  local function clickFunc()
    if not bg.isReplay then
      local battleTid = bg.battleData and bg.battleData.battleTid or 0
      local battleCfg = DT.BattleConfig[battleTid] or {}
      if btnInfo.go == self.ui.Group_Times then
        local isOpenBackTrack = 1 == battleCfg.BacktrackSwitch
        if isOpenBackTrack then
          BattleBackTrackUtils.MarkNewTagClicked()
          self:RefreshTrackBackNewTag()
          UIManager.Instance:Reopen(Urls.BattleTrackBackPanel)
          return
        end
      end
    end
    AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_INFO_ON")
    UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {
      title = btnInfo.popTipTittle,
      desc = btnInfo.popTipDesFunc()
    }, btnInfo.go)
  end
  
  self.binder:BindButtonClick(btnRes.uiNode, clickFunc)
end

function BattlePanelRightTopBtnUI:BindSettingBtn(binder)
  self.curGroupId = WorldStageManager.Instance.curGroupId
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if bg.isReplay then
    self.settingGroup = binder:BindComponent(BattleReplaySettingGroup(self.ui.Set_Bg))
  end
  if stageData and not bg.isReplay then
    self.settingGroup = binder:BindComponent(MapAndBattleSettingGroup(self.ui.Set_Bg, stageData.stageId, self.curGroupId))
  end
  binder:BindButtonClick(self.ui.Btn_Setting, System.fn(self, self.OnBtnSetting))
  binder:BindToVisible(self.ui.Btn_Setting, function()
    if nil == stageData then
      return true
    end
    local curStageData = WorldStageManager.Instance:GetCurStageData()
    if curStageData and not curStageData.isPrize then
      return true
    end
    local banIdList = DT.Constant.PrologueSettingButtonBlock.Data
    return not table.contains(banIdList, curStageData.stageId)
  end)
  local uName = "KeyCancelOrSetting"
  local settingUI = Btn_Battle_DbgResource(self.ui.Btn_Setting)
  binder:BindComponent(ShortCutComp(settingUI.Text_ShortCut, uName, function()
    self:OnSettingShortCut()
  end))
end

function BattlePanelRightTopBtnUI:OnBtnSetting()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if nil == stageData and not bg.isReplay then
    UIManager.Instance:Reopen(Urls.SettingMainPanel)
  else
    self.settingGroup:SwitchVisible()
  end
end

function BattlePanelRightTopBtnUI:OnSettingShortCut()
  self:OnBtnSetting()
end

function BattlePanelRightTopBtnUI:OnCloseUIPanel(url)
  if url == Urls.BpMainView then
    self:RefreshTrackBackNewTag()
  end
end

function BattlePanelRightTopBtnUI:RefreshTrackBackNewTag()
  local shouldShow = BattleBackTrackUtils.ShouldShowNewTag()
  local redDotRes = UIBaseResource(self.ui.RedDot_Times)
  self.binder:SetActive(self.ui.RedDot_Times, shouldShow)
  self.binder:SetActive(redDotRes.Group_New, shouldShow)
end

function BattlePanelRightTopBtnUI:OnUnbind()
end

return BattlePanelRightTopBtnUI
