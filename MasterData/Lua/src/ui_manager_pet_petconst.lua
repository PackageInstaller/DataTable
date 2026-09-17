L_PetConst = {}
L_PetConst.GradeFrameBg = {
  [1] = "Page/PetBox/tex_pet_frame_cdbg_s",
  [2] = "Page/PetBox/tex_pet_frame_cdbg_s",
  [3] = "Page/PetBox/tex_pet_frame_cdbg_s",
  [4] = "Page/PetBox/tex_pet_frame_abbg2_s",
  [5] = "Page/PetBox/tex_pet_frame_sbg2_s",
  [6] = "Page/PetBox/tex_pet_frame_ssbg2_s",
  [7] = "Page/PetBox/tex_pet_frame_sssbg2_s"
}
L_PetConst.PetCatchQualityBg = {
  [1] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_bs.png",
  [2] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_lys.png",
  [3] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_ls.png",
  [4] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_zs.png",
  [5] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_js.png"
}
L_PetConst.PetCatchElementBg = {
  [1] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_5.png",
  [2] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_4.png",
  [3] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_3.png",
  [4] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_2.png",
  [5] = "UI/Atlas/PetDuelIcon/tex_petduel_icon_kpdi_1.png"
}
L_PetConst.PetCatchLensItemIds = {
  [1] = 1800001,
  [2] = 1800002,
  [3] = 1800003
}
L_PetConst.SatietyStatus = {
  LESS = 1,
  MIDDLE = 2,
  FULL = 3
}
L_PetConst.SatietyStatusColor = {
  [L_PetConst.SatietyStatus.FULL] = C_Color(0.5882353, 0.9764706, 1, 1),
  [L_PetConst.SatietyStatus.MIDDLE] = C_Color(1, 0.8588235, 0.2078431, 1),
  [L_PetConst.SatietyStatus.LESS] = C_Color(1, 0.4941176, 0.427451, 1)
}
L_PetConst.SatietyTextColor = {
  [L_PetConst.SatietyStatus.FULL] = L_Const.colorHtml.white001,
  [L_PetConst.SatietyStatus.MIDDLE] = L_Const.colorHtml.yellow011,
  [L_PetConst.SatietyStatus.LESS] = L_Const.colorHtml.red001
}
L_PetConst.SatietyStatusColorPetInfo = {
  [L_PetConst.SatietyStatus.FULL] = C_Color(0.153, 0.682, 0.537, 1),
  [L_PetConst.SatietyStatus.MIDDLE] = C_Color(0.945098, 0.6588235, 0.03921569, 1),
  [L_PetConst.SatietyStatus.LESS] = C_Color(1, 0.4941176, 0.427451, 1)
}
L_PetConst.SatietyStatusIconColor = {
  [L_PetConst.SatietyStatus.LESS] = "#ff7e6d",
  [L_PetConst.SatietyStatus.MIDDLE] = "#c9973d",
  [L_PetConst.SatietyStatus.FULL] = "#c9973d"
}
L_PetConst.NewSatietyTextColor = {
  [L_PetConst.SatietyStatus.FULL] = L_Const.colorHtml.white001,
  [L_PetConst.SatietyStatus.MIDDLE] = L_Const.colorHtml.white001,
  [L_PetConst.SatietyStatus.LESS] = L_Const.colorHtml.red001
}
L_PetConst.SatietyStatusText = {
  [L_PetConst.SatietyStatus.FULL] = "ui_cookingHungry_01",
  [L_PetConst.SatietyStatus.MIDDLE] = "ui_cookingHungry_02",
  [L_PetConst.SatietyStatus.LESS] = "ui_cookingHungry_03"
}
L_PetConst.PetEggState = {
  None = 0,
  Idle = 1,
  QueueAndNotHatching = 2,
  Hatching = 3,
  Hatched = 4
}
L_PetConst.filterPetBox = {
  grade = 1,
  level = 2,
  satiety = 3,
  labor = 4,
  laborOnlyGrade = 5,
  none = 6
}
L_PetConst.PetSystemVoiceType = {
  CaptureSuccess = "Captured",
  CaptureFail = "CaptureFail",
  PropertyDetail = "Greeting",
  Upgrade = "Upgrade",
  Evolve = "Evolve",
  IntoTeam = "IntoTeam",
  IntoWheel = "IntoWheel",
  IntoRide = "IntoRide",
  Touched = "Touch",
  Sleep = "Sleep",
  Hungry = "Hungry",
  Idle = "Idle"
}
L_PetConst.PetPropertyId = {Speed = 35}
L_PetConst.PetDuelEntranceCellMode = {
  None = 0,
  Entrance = 1,
  PrepareSelf = 2,
  PrepareEnemy = 3,
  FormationSlot = 4,
  FormationPetPool = 5,
  FormationPreviewSlot = 6,
  FormationNestTeamMember = 7,
  PreparePvp = 8
}
L_PetConst.PetDuelSkillCellMode = {
  None = 0,
  Entrance = 1,
  FormationShow = 2,
  SelectView = 3
}
L_PetConst.PetBoxFilterEnums = {
  None = 0,
  PetDuel = 1,
  Formation = 2
}
L_PetConst.PetDuelLinePosEnums = {
  None = 0,
  PreCondition = 1,
  Vertical = 2,
  AfterCondition = 3
}
L_PetConst.PetDuelChallengeMode = {
  None = 0,
  NPCMode = 1,
  ChapterLevel = 2
}
L_PetConst.PetDuelFormationType = {
  Normal = 1,
  Formation = 2,
  Nest = 3,
  View = 4,
  pvpMatch = 5,
  pvpInvite = 6,
  Teach = 7
}
L_PetConst.PetDuelGameType = {Arena = 1, Battle = 2}
L_PetConst.PetDuelLevelType = {
  Normal = 1,
  Trail = 2,
  Lock = 3,
  Activity = 4
}
L_PetConst.PetDuelPlayerState = {
  Ready = 1,
  Formation = 2,
  MapEdit = 3,
  ModeEdit = 4,
  unReady = 5
}
L_PetConst.PetDuelQAType = {
  MapChangeQA = 1,
  ModeChangeQA = 2,
  EqualModeQA = 3
}
L_PetConst.EnumCamName = {
  Feed = "petCamera",
  StarSoul = "starSoulCam"
}
L_PetConst.SKILLBORDERICON = {
  [0] = "#828282",
  [1] = "#fb7675",
  [2] = "#fd9c47",
  [3] = "#e5b933",
  [4] = "#5dca95",
  [5] = "#47cdc9",
  [6] = "#16d0ff",
  [7] = "#708bff",
  [8] = "#e2ca2a",
  [9] = "#9a76f5"
}
L_PetConst.TagPosEnum = {
  Top = 1,
  Bottom = 2,
  Left = 3,
  Right = 4,
  TopLeft = 5,
  TopRight = 6,
  BottomLeft = 7,
  BottomRight = 8,
  Center = 9
}
L_PetConst.TagEnum = {
  ReleaseSelect = 1,
  ReddotNew = 2,
  Skin = 3,
  Team = 4,
  Gene = 5,
  Evolution = 6,
  Starsoul = 7,
  TalentGrade = 8,
  Annoy = 9,
  ReleaseStatus = 10,
  WorkStatus = 11,
  Lock = 12
}
L_PetConst.PageType = {
  House = 1,
  Home = 2,
  Formation = 3,
  Other = 4
}
