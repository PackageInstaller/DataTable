local GearItemMonster, Super = System.NewClass("GearItemMonster", GearItemBase)

function GearItemMonster:OnTriggerChild(svrData)
  self.svrData = svrData or {}
  self:SetInTrigger()
  if svrData.data.prize then
    self.battleResult = 1
    self:OnGearItemHandle(svrData.data)
  elseif not svrData.data.checkStartBattleAgain and svrData.data.battleTid and 0 ~= svrData.data.battleTid then
    Super.OnTrigger(self)
    self:StartBattle(svrData.data)
  end
end

function GearItemMonster:StartBattle(data)
  EventMgr.Instance.BattleFinish:RegisterEvent(System.fn(self, self.OnBattleFinish))
  BattleManager.Instance:EnterBattle(data, self:IsRecovering())
end

function GearItemMonster:OnBattleFinish()
end

function GearItemMonster:PlayUp()
  Super.PlayUp(self)
end

function GearItemMonster:SetDismissChoas(isDismiss)
  Super.SetDismissChoas(self, isDismiss)
end

function GearItemMonster:PlayDown(fromTime)
  Super.PlayDown(self, fromTime)
end

function GearItemMonster:LoadPrefab(prefabPath)
  Super.LoadPrefab(self, prefabPath)
end

function GearItemMonster:OnGearItemHandle(data)
  if not data then
    return
  end
  if self.manager.parent:isDestroyed() then
    Logger.Warn("地图已经销毁了~")
    return
  end
  if 0 == self.battleResult then
    Logger.Info("[NewMap] 战斗失败不在这弹结算")
    return
  end
  local stageComp = self.manager.parent.owner
  if IntroductionDataUtils.IsFirstBattle() then
    stageComp:EndFirstBattle()
  else
    local sceneType = CommonDefine.SceneType.Copies
    UIManager.Instance:RegisterPanelClose(Urls.WorldStageRelicThreeSelectPanel, System.fn(self, self.GearMonsterAfterTrigger))
    UIManager.Instance:RegisterPanelClose(Urls.SummonNewItemPanel, System.fn(self, self.GearMonsterAfterTrigger))
    CopyDataUtils.HandleGearBattleResult(data, sceneType, System.fn(self, self.GearMonsterAfterTrigger))
  end
end

function GearItemMonster:OnRemove()
  Super.OnRemove(self)
  self:AfterTrigger()
end

function GearItemMonster:AfterTrigger()
  if self._isMonsterTriggered or self:GetIsCfgChoasNode() and self:GetIsChoas() then
    return
  end
  print("[Stage]GearMonsterAfterTrigger", debug.traceback())
  UIManager.Instance:RegisterPanelClose(Urls.CardFeatureInfoPanel, System.fn(self, self.GearMonsterAfterTrigger))
  UIManager.Instance:RegisterPanelClose(Urls.WorldStageRelicShowPanel, System.fn(self, self.GearMonsterAfterTrigger))
  TimerManager.Instance:StopTimer(self.safeTimer)
  self.safeTimer = TimerManager.Instance:CreateTimer(2, 0, nil, function()
    self:ClearPanelCloseCb()
    if self._isMonsterTriggered then
      return
    end
    self:GearMonsterAfterTrigger()
  end)
end

function GearItemMonster:GearMonsterAfterTrigger()
  print("[Stage]GearMonsterAfterTrigger Function", debug.traceback())
  if Main.isAppDestroyed then
    return
  end
  TimerManager.Instance:StopTimer(self.safeTimer)
  self:ClearPanelCloseCb()
  self.safeTimer = nil
  if self._isMonsterTriggered then
    return
  end
  self:UpdateMist()
  self._isMonsterTriggered = true
  Super.AfterTrigger(self)
end

function GearItemMonster:ClearPanelCloseCb()
  UIManager.Instance:RemovePanelCloseCb(Urls.WorldStageRelicThreeSelectPanel, System.fn(self, self.GearMonsterAfterTrigger))
  UIManager.Instance:RemovePanelCloseCb(Urls.SummonNewItemPanel, System.fn(self, self.GearMonsterAfterTrigger))
  UIManager.Instance:RemovePanelCloseCb(Urls.CardFeatureInfoPanel, System.fn(self, self.GearMonsterAfterTrigger))
  UIManager.Instance:RemovePanelCloseCb(Urls.WorldStageRelicShowPanel, System.fn(self, self.GearMonsterAfterTrigger))
  UIManager.Instance:RemovePanelCloseCb(Urls.WorldStageBattleRewardPanel, System.fn(self, self.GearMonsterAfterTrigger))
end

function GearItemMonster:PlayShowAnim(state)
  Super.PlayShowAnim(self, state)
  local MapGuideManager = self.manager:GetComponent(MapGuideManager)
  MapGuideManager:TriggerEvent(CommonDefine.GuideEvent.GearAppear, self:GetTid())
end

function GearItemMonster:Dispose()
  Super.Dispose(self)
  EventMgr.Instance.BattleFinish:RemoveEvent(System.fn(self, self.OnBattleFinish))
  Logger.Info("[NewMap]GearItemMonster:Dispose")
  DOTweenUtils.KillAllTweensByTarget(self)
  TimerManager.Instance:StopTimer(self.safeTimer)
  self.safeTimer = nil
  self:ClearPanelCloseCb()
end

return GearItemMonster
