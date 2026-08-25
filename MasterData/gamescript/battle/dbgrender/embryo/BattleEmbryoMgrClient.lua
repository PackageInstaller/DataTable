local BattleEmbryoMgrClient = System.NewClass("BattleEmbryoMgrClient")

function BattleEmbryoMgrClient:ctor()
  self.EmbryoSwallowRef = 0
end

function BattleEmbryoMgrClient:Awake()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.DoEffect, self.OnDoEffect, self)
end

function BattleEmbryoMgrClient:Dispose()
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function BattleEmbryoMgrClient:OnDoEffect(data)
  if data.effectType == bc.BattleEffectType.BELaunchSwallow and data.cardUidList and #data.cardUidList > 0 then
    bg.battlePanel.cardUI:StartSwallowEmbryoCards(data.cardUidList)
  end
end

function BattleEmbryoMgrClient:StartSwallowEmbryo()
  self.EmbryoSwallowRef = self.EmbryoSwallowRef + 1
  bg.battleRender.recordMgr:SetRecordState(bc.BattleRecordPlayState.Pause)
end

function BattleEmbryoMgrClient:CompleteSwallowEmbryo()
  self.EmbryoSwallowRef = self.EmbryoSwallowRef - 1
  if self.EmbryoSwallowRef < 0 then
    self.EmbryoSwallowRef = 0
  end
  if 0 == self.EmbryoSwallowRef then
    bg.battleRender.recordMgr:SetRecordState(bc.BattleRecordPlayState.Play)
  end
end

function BattleEmbryoMgrClient.GetPlaybackSpeed()
  local gameSpeed = bg.battleRender and bg.battleRender.gameSpeed or 1
  gameSpeed = gameSpeed or 1
  if 1 == gameSpeed then
    return 1
  end
  return 1.5
end

return BattleEmbryoMgrClient
