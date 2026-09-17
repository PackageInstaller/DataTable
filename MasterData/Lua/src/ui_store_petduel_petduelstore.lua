local this = class("petDuelStore", G_BaseStore)
this.event = {
  refresh_formationInfo = "refresh_formationInfo",
  refresh_recordInfo = "refresh_recordInfo",
  chapterPass_close = "chapterPass_close",
  chapterModeUnlock_close = "chapterModeUnlock_close",
  refresh_areaInfo = "refresh_areaInfo",
  refresh_unlockSkill = "refresh_unlockSkill",
  areaLevel_changed = "areaLevel_changed",
  changePetDuelMode = "changePetDuelMode",
  changePetDuelMap = "changePetDuelMap"
}
this.unlockContentType = {level = 1, skill = 2}
this:importPartialClass(require(L_R.store .. "petDuel.petDuelState"))
this:importPartialClass(require(L_R.store .. "petDuel.petDuelAction"))
return this
