L_FormationConst = {}
L_FormationConst.FormationPosNum = L_GameConstTpl:getData("FORMATION_NUMBER", L_Const.GameTplType.int)
L_FormationConst.FormationMaxCount = L_GameConstTpl:getData("FORMATION_PARTY_NUMBER", L_Const.GameTplType.int) or 4
L_FormationConst.FormationEditStatus = {
  Switching = 0,
  Overlook = 1,
  EditHero = 2,
  EditPet = 3
}
L_FormationConst.FormationTipType = {
  LastOneLeave = 1,
  InReadyStatus = 2,
  TeamEmpty = 3,
  NoAliveExist = 4,
  DeadJoinEmpty = 5,
  UnableSwitch = 6,
  RestModeUnableSwitch = 7,
  UnableSwitchToDead = 8
}
L_FormationConst.FormationTipDesc = {
  [L_FormationConst.FormationTipType.LastOneLeave] = "notice_fightTeam_02",
  [L_FormationConst.FormationTipType.InReadyStatus] = "notice_fightTeam_03",
  [L_FormationConst.FormationTipType.TeamEmpty] = "notice_fightTeam_04",
  [L_FormationConst.FormationTipType.NoAliveExist] = "notice_fightTeam_05",
  [L_FormationConst.FormationTipType.DeadJoinEmpty] = "notice_fightTeam_06",
  [L_FormationConst.FormationTipType.UnableSwitch] = "notice_fightTeam_07",
  [L_FormationConst.FormationTipType.RestModeUnableSwitch] = "notice_fightTeam_08",
  [L_FormationConst.FormationTipType.UnableSwitchToDead] = "notice_fightTeam_09"
}
L_FormationConst.FormationEditTarget = {Hero = 1, Pet = 2}
L_FormationConst.FormationType = {
  world = 1,
  tower = 4,
  kiBoDuel = 5
}
L_FormationConst.FormationTeamPresetCount = {
  [L_FormationConst.FormationType.world] = L_FormationConst.FormationMaxCount
}
L_FormationConst.FormationCamName = {
  Overlook = "camOverlook",
  EditHero = "camEditHero",
  Pet1 = "camPet1",
  Pet2 = "camPet2",
  Pet3 = "camPet3"
}
L_FormationConst.FormationCamTargetName = {
  [L_FormationConst.FormationCamName.Pet1] = "targetPet1",
  [L_FormationConst.FormationCamName.Pet2] = "targetPet2",
  [L_FormationConst.FormationCamName.Pet3] = "targetPet3"
}
L_FormationConst.FormationCamTargetDefaultPos = {
  [L_FormationConst.FormationCamName.Pet1] = L_Vector3.new(1.842456, 0.9, 0.162323) + L_Vector3.UnityV3ToLua(C_UIMgr.SceneLoadDefaultPosition),
  [L_FormationConst.FormationCamName.Pet2] = L_Vector3.new(0.427954, 0.9, 0.1686634) + L_Vector3.UnityV3ToLua(C_UIMgr.SceneLoadDefaultPosition),
  [L_FormationConst.FormationCamName.Pet3] = L_Vector3.new(-2.8694, 1.28, -0.0123) + L_Vector3.UnityV3ToLua(C_UIMgr.SceneLoadDefaultPosition)
}
