local this = class("multiDungeonStore", G_BaseStore)
this.event = {
  syncMultiDungeonInfo = "multiDungeonStore_syncMultiDungeonInfo",
  syncCurMultiDungeonInfo = "multiDungeonStore_syncCurMultiDungeonInfo",
  syncMatchTeamData = "multiDungeonStore_syncMatchTeamData",
  syncMatchTeamInviteData = "multiDungeonStore_syncMatchTeamInviteData",
  syncMatchedReadyData = "multiDungeonStore_syncMatchedReadyData",
  rejectInviteJoinMatchTeam = "multiDungeonStore_rejectInviteJoinMatchTeam"
}
this:importPartialClass(require(L_R.store .. "multiDungeon.multiDungeonState"))
this:importPartialClass(require(L_R.store .. "multiDungeon.multiDungeonAction"))
return this
