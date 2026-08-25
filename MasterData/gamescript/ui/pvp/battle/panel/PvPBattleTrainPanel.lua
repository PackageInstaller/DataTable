local PvPBattleTrainPanel, Super = System.NewClass("PvPBattleTrainPanel", UIBasePanel)
PvPBattleTrainPanel.uiResCls = UI_Pvp_Panel_TrainResource

function PvPBattleTrainPanel:ctor()
  Super.ctor(self)
  self.curPos = 1
end

function PvPBattleTrainPanel:OnBind(binder)
  self.binder = binder
  self.pvpCollectModel = binder:createModel(PVPCollectionListPanelModel, cd.PVPCollectionFilterType.Weapon)
  self.binder:BindButtonClick(self.ui.Btn_Popup, System.fn(self, self.OnPopup))
  binder:BindComponent(ShortCutComp(self.ui.Text_ShortCutPopup, cd.SettingUniqueName.KeyTraning1, function()
    self:OnPopup()
  end))
  self.binder:BindButtonClick(self.ui.Btn_Reset, System.fn(self, self.OnReset))
  binder:BindComponent(ShortCutComp(self.ui.Text_ShortCutReset, cd.SettingUniqueName.KeyTraning2, function()
    self:OnReset()
  end))
  self.binder:BindButtonClick(self.ui.Btn_Position, System.fn(self, self.OnPosition))
  binder:BindComponent(ShortCutComp(self.ui.Text_ShortCutPosition, cd.SettingUniqueName.KeyTraning3, function()
    self:OnPosition()
  end))
  self.binder:BindButtonClick(self.ui.Btn_Weapons, System.fn(self, self.OnWeapons))
  binder:BindComponent(ShortCutComp(self.ui.Text_ShortCutWeapons, cd.SettingUniqueName.KeyTraning4, function()
    self:OnWeapons()
  end))
  self.binder:BindButtonClick(self.ui.Btn_KeeperSkills, System.fn(self, self.OnKeeperSkills))
  binder:BindComponent(ShortCutComp(self.ui.Text_ShortCutKeeperSkills, cd.SettingUniqueName.KeyTraning5, function()
    self:OnKeeperSkills()
  end))
  self.binder:SetActive(self.ui.Btn_SelectRelic, true)
  self.binder:BindButtonClick(self.ui.Btn_SelectRelic, System.fn(self, self.OnSelectRelic))
  self.binder:BindButtonClick(self.ui.Btn_Left, System.fn(self, self.OnLeft))
  self.binder:BindButtonClick(self.ui.Btn_Right, System.fn(self, self.OnRight))
  self.binder:SetActive(self.ui.Group_Arrows, false)
end

function PvPBattleTrainPanel:OnPopup()
  self.binder:SetActive(self.ui.Group_Btns, not self.ui.Group_Btns.activeSelf)
end

function PvPBattleTrainPanel:OnReset()
  local curTime = TimeUtils:GetServerTime()
  if curTime - (self._lastResetTime or 0) < 2 then
    Alert.ShowStr(LT.Text("PVPTraning_ResetCooldown"))
    return
  end
  self._lastResetTime = curTime
  local command = DT.GetConstant("PVPTraning_Reset")
  if not command then
    Logger.Error("PVPTraning_Reset not found")
    return
  end
  local msgData = {
    gm = bc.BattleGMType.ExeCmd,
    cmd = command
  }
  local battleEngine = BattleManager.Instance.battleEngine
  if battleEngine then
    print("执行命令", command)
    battleEngine:lg_GM(msgData)
  end
end

function PvPBattleTrainPanel:OnPosition()
  self.binder:SetActive(self.ui.Group_Arrows, not self.ui.Group_Arrows.activeSelf)
  self:CreateHidePosBtnTimer()
end

function PvPBattleTrainPanel:CreateHidePosBtnTimer()
  if self._hidePosBtnTimer then
    self.binder:StopTimer(self._hidePosBtnTimer)
    self._hidePosBtnTimer = nil
  end
  self._hidePosBtnTimer = self.binder:BindTimer(5, 0, nil, function()
    self.binder:SetActive(self.ui.Group_Arrows, false)
  end)
end

function PvPBattleTrainPanel:OnWeapons()
  print("OnWeapons")
  local weaponList = self.pvpCollectModel.filterListMap[cd.PVPCollectionFilterType.Weapon]
  local cardList = {}
  for _, tid in ipairs(weaponList) do
    if PVPCollectionDataUtils.IsOpenedInTime(tid) then
      local skillTid = PVPCollectionDataUtils.GetCollectWeaponSkillId(tid)
      if skillTid then
        table.insert(cardList, {
          tid = skillTid,
          desc = SkillUtils.GetAwakerSkillDesc({}, skillTid, 1)
        })
      end
    end
  end
  UIManager.Instance:Reopen(Urls.PVPTrainCardSelectPanel, cardList, {
    callback = function(selectedCards)
      if not selectedCards or not table.next(selectedCards) then
        return
      end
      local msgData = {
        gm = bc.BattleGMType.NewHandCard,
        configId = selectedCards[1]
      }
      local battleEngine = BattleManager.Instance.battleEngine
      if battleEngine then
        battleEngine:lg_GM(msgData)
      end
    end,
    desc = LT.Text("PVPTraning_ChooseWeapon")
  })
end

function PvPBattleTrainPanel:OnKeeperSkills()
  print("OnKeeperSkills")
  local keeperSkillList = self.pvpCollectModel.filterListMap[cd.PVPCollectionFilterType.KeeperSkill]
  local cardList = {}
  for _, tid in ipairs(keeperSkillList) do
    if PVPCollectionDataUtils.IsOpenedInTime(tid) then
      local skillTid = PVPCollectionDataUtils.GetCollectWeaponSkillId(tid)
      if skillTid then
        table.insert(cardList, {
          tid = skillTid,
          desc = SkillUtils.GetAwakerSkillDesc({}, skillTid, 1)
        })
      end
    end
  end
  UIManager.Instance:Reopen(Urls.PVPTrainCardSelectPanel, cardList, {
    callback = function(selectedCards)
      if not selectedCards or not table.next(selectedCards) then
        return
      end
      local msgData = {
        gm = bc.BattleGMType.NewHandCard,
        configId = selectedCards[1]
      }
      local battleEngine = BattleManager.Instance.battleEngine
      if battleEngine then
        battleEngine:lg_GM(msgData)
      end
    end,
    desc = LT.Text("PVPTraning_ChooseKeeperSkill")
  })
end

function PvPBattleTrainPanel:OnSelectRelic()
  UIManager.Instance:Reopen(Urls.PvPSelectCreationPanel, function(selectedRelicTid)
  end)
end

function PvPBattleTrainPanel:OnLeft()
  print("OnLeft")
  self:CreateHidePosBtnTimer()
  local toPos = self.curPos + 1
  if not self:IsPosValid(toPos) then
    return
  end
  self:OnMoveAwaker(self.curPos, toPos)
end

function PvPBattleTrainPanel:OnRight()
  print("OnRight")
  self:CreateHidePosBtnTimer()
  local toPos = self.curPos - 1
  if not self:IsPosValid(toPos) then
    return
  end
  self:OnMoveAwaker(self.curPos, toPos)
end

function PvPBattleTrainPanel:IsPosValid(pos)
  return pos >= 1 and pos <= 4
end

function PvPBattleTrainPanel:OnMoveAwaker(fromPos, toPos)
  local msgData = {
    gm = bc.BattleGMType.MoveAwaker,
    fromPos = fromPos,
    toPos = toPos
  }
  local battleEngine = BattleManager.Instance.battleEngine
  if battleEngine then
    battleEngine:lg_GM(msgData)
    self.curPos = toPos
  end
end

return PvPBattleTrainPanel
