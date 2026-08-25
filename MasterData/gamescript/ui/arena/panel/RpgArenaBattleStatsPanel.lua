local RpgArenaBattleStatsPanel, Super = System.NewClass("RpgArenaBattleStatsPanel", UIBasePanel)
RpgArenaBattleStatsPanel.uiResCls = Popup_Arena_StatisticsResource

function RpgArenaBattleStatsPanel:ctor(relationData, statistics)
  Super.ctor(self)
  self.relationData = relationData
  self.statsData = statistics
  self.myMaxDamage = 0
  self.opMaxDamage = 0
  self.myStatsInfo = {}
  self.opStatsInfo = {}
  self:InitData()
end

function RpgArenaBattleStatsPanel:InitData()
  if not self.statsData.roleStats then
    return
  end
  local campDamageData = {}
  for camp, roleStats in pairs(self.statsData.roleStats) do
    campDamageData[camp] = campDamageData[camp] or {}
    for actorTid, stats in pairs(roleStats) do
      campDamageData[camp][actorTid] = stats[CommonDefine.BattleStatsType.DamageDone] or 0
    end
  end
  for _, teamRole in ipairs(self.relationData.my.team) do
    local temp = {}
    local data = campDamageData[bc.BattleCamp.Camp1] or {}
    temp.actorTid = teamRole.roleId
    temp.lv = teamRole.lv
    temp.damage = data[temp.actorTid] or 0
    temp.star = teamRole.star
    self.myMaxDamage = temp.damage > self.myMaxDamage and temp.damage or self.myMaxDamage
    table.insert(self.myStatsInfo, temp)
  end
  table.sort(self.myStatsInfo, function(a, b)
    return a.damage > b.damage
  end)
  for _, teamRole in ipairs(self.relationData.opponent.team) do
    local temp = {}
    local data = campDamageData[bc.BattleCamp.Camp2] or {}
    temp.actorTid = teamRole.roleId
    temp.lv = teamRole.lv
    temp.damage = data[temp.actorTid] or 0
    temp.star = teamRole.star
    self.opMaxDamage = temp.damage > self.opMaxDamage and temp.damage or self.opMaxDamage
    table.insert(self.opStatsInfo, temp)
  end
  table.sort(self.opStatsInfo, function(a, b)
    return a.damage > b.damage
  end)
end

function RpgArenaBattleStatsPanel:OnBind(binder)
  self.binder = binder
  local list = #self.myStatsInfo > #self.opStatsInfo and self.myStatsInfo or self.opStatsInfo
  binder:BindToCircularListView(self.ui.ScrollView_Statistics, function()
    return list
  end, function(itemBinder, item, index)
    local myStats = self.myStatsInfo[index]
    local opStats = self.opStatsInfo[index]
    itemBinder:BindComponent(ArenaBattleStatsItem(item, myStats, opStats, self.myMaxDamage, self.opMaxDamage))
  end)
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnClickConfirm))
  binder:BindButtonClick(self.ui.Btn_Save_Team, System.fn(self, self.OnSaveTeam))
end

function RpgArenaBattleStatsPanel:OnSaveTeam()
  Alert.ShowStr("敬请期待~")
end

function RpgArenaBattleStatsPanel:OnClickConfirm()
  self:Close()
end

return RpgArenaBattleStatsPanel
