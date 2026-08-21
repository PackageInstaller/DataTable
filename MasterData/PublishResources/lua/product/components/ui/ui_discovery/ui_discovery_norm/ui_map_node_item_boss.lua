_class("UIMapNodeItemBoss", UIMapNodeItemBase)
UIMapNodeItemBoss = UIMapNodeItemBoss

function UIMapNodeItemBoss:OnShow()
  UIMapNodeItemBoss.super.OnShow(self)
  self._imgCG = self:GetUIComponent("MultiplyImageLoader", "imgCG")
end

function UIMapNodeItemBoss:Flush()
  UIMapNodeItemBoss.super.Flush(self)
  local stageType = self.nodeInfo:GetStageType()
  if stageType == DiscoveryStageType.FightBoss then
    if state == DiscoveryStageState.CanPlay then
      self._imgCG:Load(self.nodeInfo.monstercg, "tip_big_multiply")
    else
      self._imgCG:Load(self.nodeInfo.monstercg, "white")
    end
  end
end

function UIMapNodeItemBoss:GetTipAnimName()
  return "uieff_UINormNodeBoss_in"
end
