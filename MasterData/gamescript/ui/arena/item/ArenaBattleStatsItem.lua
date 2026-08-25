local ArenaBattleStatsItem, Super = System.NewComponent("ArenaBattleStatsItem")

function ArenaBattleStatsItem:ctor(uiNode, myStats, opStats, myMaxDamage, opMaxDamage)
  Super.ctor(self)
  self.ui = Item_Arena_Statistics_RpgResource(uiNode)
  self.myStats = myStats
  self.opStats = opStats
  self.myMaxDamage = myMaxDamage
  self.opMaxDamage = opMaxDamage
end

function ArenaBattleStatsItem:OnBind(binder)
  self.binder = binder
  if self.myStats then
    local iconData = {}
    iconData.configId = self.myStats.actorTid
    iconData.lv = self.myStats.lv
    iconData.star = self.myStats.star
    binder:BindComponent(RpgTeamRoleIconItem(self.ui.Image_Awaker, iconData))
    binder:SetImageFillAmount(self.ui.Image_Hurt_Progress, self.myStats.damage / self.myMaxDamage)
    binder:SetText(self.ui.Text_Hurt_Count, self.myStats.damage)
  end
  binder:SetActive(self.ui.Image_Awaker, self.myStats)
  binder:SetActive(self.ui.Item_Hurt_Progress, self.myStats)
  if self.opStats then
    local opIconData = {}
    opIconData.configId = self.opStats.actorTid
    opIconData.lv = self.opStats.lv
    opIconData.star = self.opStats.star
    binder:BindComponent(RpgTeamRoleIconItem(self.ui.Item_Enemy_Head, opIconData))
    binder:SetImageFillAmount(self.ui.Image_Survival_Progress, self.opStats.damage / self.opMaxDamage)
    binder:SetText(self.ui.Text_Survival_Count, self.opStats.damage)
  end
  binder:SetActive(self.ui.Item_Enemy_Head, self.opStats)
  binder:SetActive(self.ui.Item_Survival_Progress, self.opStats)
end

return ArenaBattleStatsItem
