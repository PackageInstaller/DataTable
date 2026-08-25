local TentacleModeSwitch, Super = System.NewClass("TentacleModeSwitch", UIBasePanel)
TentacleModeSwitch.uiResCls = UI_Battle_ShenHai_SwitchResource

function TentacleModeSwitch:ctor(roleData)
  Super.ctor(self)
  self.roleData = roleData
end

function TentacleModeSwitch:OnBind(binder)
  self.binder = binder
  self:_OnBindGuideBattlePanel()
  self.curOceanMode = 1
  self:_OnBindShortCutComps(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, function()
    self:Close()
  end)
  binder:BindToText(self.ui.text_Title, function()
    do return LT.Text end
    return LT.Text, "TentacleModeSwitchTips"
  end)
  binder:BindToText(self.ui.Text_Name_Combat, function()
    do return LT.Text end
    return LT.Text, self:_GetOceanModeInfoCfg(BattleConst.OceanModel.OceanModel1).Name, self, BattleConst.OceanModel.OceanModel1
  end)
  binder:BindToText(self.ui.Text_Active_Combat, function()
    do return self._GetOceanModeSkillDesc, self end
    return self._GetOceanModeSkillDesc, self, BattleConst.OceanModel.OceanModel1
  end)
  binder:BindToText(self.ui.Text_Activate, function()
    do return LT.Text end
    return LT.Text, "TentacleModeSwitchNew"
  end)
  binder:BindButtonClick(self.ui.Btn_Click_Combat, System.fn(self, self._OnClickOceanMode1))
  binder:BindToText(self.ui.Text_Name_Defense, function()
    do return LT.Text end
    return LT.Text, self:_GetOceanModeInfoCfg(BattleConst.OceanModel.OceanModel2).Name, self, BattleConst.OceanModel.OceanModel2
  end)
  binder:BindToText(self.ui.Text_Active_Activate, function()
    do return self._GetOceanModeSkillDesc, self end
    return self._GetOceanModeSkillDesc, self, BattleConst.OceanModel.OceanModel2
  end)
  binder:BindButtonClick(self.ui.Btn_Click_Defense, System.fn(self, self._OnClickOceanMode2))
  binder:BindToText(self.ui.Text_Name_Frantic, function()
    do return LT.Text end
    return LT.Text, self:_GetOceanModeInfoCfg(BattleConst.OceanModel.OceanModel3).Name, self, BattleConst.OceanModel.OceanModel3
  end)
  binder:BindToText(self.ui.Text_Active_Describe, function()
    do return self._GetOceanModeSkillDesc, self end
    return self._GetOceanModeSkillDesc, self, BattleConst.OceanModel.OceanModel3
  end)
  binder:BindToText(self.ui.Text_Disable_Frantic, function()
    do return LT.Text end
    return LT.Text, "TentacleModeSwitchCondString"
  end)
  binder:BindToText(self.ui.Text_Disable_Defense, function()
    do return LT.Text end
    return LT.Text, "TentacleModeSwitchCondString"
  end)
  binder:BindButtonClick(self.ui.Btn_Click_Frantic, System.fn(self, self._OnClickOceanMode3))
  binder:BindToVisible(self.ui.Image_Select_Frantic, function()
    return not self:_IsCrazyDisable() and not self:_IsCrazyInCd()
  end)
  binder:BindToVisible(self.ui.Image_Disable_Frantic, function()
    return self:_IsCrazyDisable() or self:_IsCrazyInCd()
  end)
  binder:BindToVisible(self.ui.Image_Select_Defense, function()
    return not self:_IsDefenseInCd()
  end)
  binder:BindToVisible(self.ui.Image_Disable_Defense, function()
    do return self._IsDefenseInCd end
    return self._IsDefenseInCd, self
  end)
  local combatAutoComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Active_Combat, 0, 0, 0, nil, true)
  local activateAutoComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Active_Activate, 0, 0, 0, nil, true)
  local describeAutoComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Active_Describe, 0, 0, 0, nil, true)
  if combatAutoComp then
    combatAutoComp:SetBtn(self.ui.Btn_Click_Combat)
  end
  if activateAutoComp then
    activateAutoComp:SetBtn(self.ui.Btn_Click_Defense)
  end
  if describeAutoComp then
    describeAutoComp:SetBtn(self.ui.Btn_Click_Frantic)
  end
end

function TentacleModeSwitch:_OnBindShortCutComps(binder)
  local extraParam = {withoutForwardPanel = true}
  binder:BindComponent(ShortCutComp(self.ui.Text_Combat_ShortCut, "KeyCard1", System.fn(self, self._OnClickOceanMode1), extraParam))
  binder:BindComponent(ShortCutComp(self.ui.Text_Defense_ShortCut, "KeyCard2", System.fn(self, self._OnClickOceanMode2), extraParam))
  binder:BindComponent(ShortCutComp(self.ui.Text_Frantic_ShortCut, "KeyCard3", System.fn(self, self._OnClickOceanMode3), extraParam))
end

function TentacleModeSwitch:OnUnbind()
end

function TentacleModeSwitch:_GetOceanModeInfoCfg(key)
  local skillId = DT.Constant[key].Data[1]
  return DT.Skill[skillId]
end

function TentacleModeSwitch:_GetOceanModeSkillDesc(oceanModelKey)
  local cfg = self:_GetOceanModeInfoCfg(oceanModelKey)
  if not cfg then
    return ""
  end
  local skillArgs = self:_GetOceanModeSkillArgs(cfg.ID)
  return SkillUtils.GetAwakerSkillDesc(self.roleData, cfg.ID, 0, skillArgs) or ""
end

function TentacleModeSwitch:_GetOceanModeSkillArgs(skillId)
  local schoolArgs = self.roleData.schoolArgs and self.roleData.schoolArgs[cd.SchoolId.Ocean]
  if not schoolArgs then
    return nil
  end
  local skillCfg = DT.Skill[skillId]
  if not skillCfg then
    return nil
  end
  local params = {
    breakSkillLevel = 0,
    potencyLevel = 0,
    skillId = skillId,
    awaker = self.roleData
  }
  local cnDesc = BattleSkillUtils.GetSkillBattleDesc(skillCfg, 0, 0, params)
  if not cnDesc then
    return nil
  end
  local cmdParser = BattleCmdParserClient({
    skillId = skillId,
    awaker = self.roleData
  })
  local rawArgs = SkillUtils.__GetSkillArgs(cmdParser)
  local curValues = {}
  local index = 0
  for gainStr in string.gmatch(cnDesc, "%b[]") do
    gainStr = string.sub(gainStr, 2, #gainStr - 1)
    local subStrs = string.split(gainStr, ":")
    local argName = subStrs[#subStrs]
    local argIndex = tonumber(argName:match("Arg(%d+)"))
    index = index + 1
    local v = argIndex and rawArgs["Arg" .. argIndex] or 0
    if type(v) == "number" then
      v = math.ceil(v)
    end
    curValues[index] = v
  end
  if 0 == index then
    return nil
  end
  return {curValues = curValues}
end

function TentacleModeSwitch:_OnClickOceanMode1()
  if PVEBattleReplayUtils.CheckReplayForbidTips() then
    return
  end
  Alert.ShowStr(LT.Text("TentacleModeSwitch1"))
end

function TentacleModeSwitch:_OnClickOceanMode2()
  if PVEBattleReplayUtils.CheckReplayForbidTips() then
    return
  end
  if self:_IsDefenseInCd() then
    Alert.ShowStr(LT.Textf("TentacleModeSwitch3", self.roleData:GetOceanModeGrayCd()))
    return
  end
  if not bg.battleDataCenter:IsMyActionCamp() then
    Alert.ShowStr(LT.Text("TentacleModeSwitchCondString"))
    return
  end
  self:_OnSendSwitchOceanModelCommand(BattleConst.OceanModel.OceanModel2)
  self:Close()
end

function TentacleModeSwitch:_OnClickOceanMode3()
  if PVEBattleReplayUtils.CheckReplayForbidTips() then
    return
  end
  if self:_IsCrazyInCd() then
    Alert.ShowStr(LT.Textf("TentacleModeSwitch4", self.roleData:GetOceanModeRedCd()))
    return
  end
  if self:_IsCrazyDisable() then
    Alert.ShowStr(LT.Text("TentacleModeSwitch2"))
    return
  end
  if not bg.battleDataCenter:IsMyActionCamp() then
    Alert.ShowStr(LT.Text("TentacleModeSwitchCondString"))
    return
  end
  self:_OnSendSwitchOceanModelCommand(BattleConst.OceanModel.OceanModel3)
  self:Close()
end

function TentacleModeSwitch:_OnSendSwitchOceanModelCommand(targetModel)
  bg.battleRender:SendCommand(BattleCommand.lg_SwitchOceanModel, {model = targetModel})
  EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideCondOceanModeSwitched, {targetModel})
end

function TentacleModeSwitch:_IsDefenseInCd()
  local cmdParser = BattleCmdParserClient({})
  local cond = DT.BattleApi.OceanModel2Cond.Data
  local ret = cmdParser:GetValueByCmd(cond)
  return true ~= ret
end

function TentacleModeSwitch:_IsCrazyDisable()
  local cmdParser = BattleCmdParserClient({})
  local cond = DT.BattleApi.OceanModel3Cond.Data
  local ret = cmdParser:GetValueByCmd(cond)
  return true ~= ret
end

function TentacleModeSwitch:_OnBindGuideBattlePanel()
  local nodeName
  local defenceTrigger = CommonDefine.GuideGameObjType.GuideCompOceanModeSwtichToDefence
  local franticTrigger = CommonDefine.GuideGameObjType.GuideCompOceanModeSwtichToFrantic
  local guideTid = DataCenter.guideData.guideId
  local guideCfgList = DT.GuideConfig[guideTid]
  if not guideCfgList then
    return
  end
  local guideCfg = guideCfgList.data_list[1]
  if guideCfg.GuideGameObj == defenceTrigger then
    nodeName = "UI_Battle_ShenHai_Switch(Clone).Btn_Click_Defense"
  elseif guideCfg.GuideGameObj == franticTrigger then
    nodeName = "UI_Battle_ShenHai_Switch(Clone).Btn_Click_Frantic"
  end
  if not nodeName then
    return
  end
  local viewData = {
    guideCfg = guideCfg,
    nodeName = nodeName,
    direction = CommonDefine.GuidePos.GO_DOWN
  }
  UIManager.Instance:Reopen(Urls.NewbieGuideBattleView, viewData)
end

function TentacleModeSwitch:_IsCrazyInCd()
  local cmdParser = BattleCmdParserClient({})
  local cond = DT.BattleApi.OceanModel4Cond and DT.BattleApi.OceanModel4Cond.Data
  if not cond then
    return false
  end
  local ret = cmdParser:GetValueByCmd(cond)
  return true ~= ret
end

return TentacleModeSwitch
