L_MapConst = L_MapConst or {}
local C_Convert = CS.System.Convert
local C_MapConst = CS.Azur.Gameplay.MapManager.MapConst
local C_MapSievingType = CS.Azur.Gameplay.MapManager.mapSievingType
local C_WorldConst = CS.Lens.Gameplay.Modules.Azur.WorldConst

local function enumToInt(value)
  return C_Convert.ToInt32(value)
end

L_MapConst.OpenMode = {
  Default = enumToInt(C_WorldConst.EPagBigMapOpenMode.Default),
  UnlockHomeArea = enumToInt(C_WorldConst.EPagBigMapOpenMode.UnlockHomeArea),
  UnlockAreaMask = enumToInt(C_WorldConst.EPagBigMapOpenMode.UnlockAreaMask)
}
L_MapConst.CollectionStatus = {
  Working = enumToInt(C_MapConst.CollectionStatus.Working),
  NotSetPet = enumToInt(C_MapConst.CollectionStatus.NotSetPet),
  Pause = enumToInt(C_MapConst.CollectionStatus.Pause),
  Free = enumToInt(C_MapConst.CollectionStatus.Free),
  UnFixed = enumToInt(C_MapConst.CollectionStatus.UnFixed),
  Full = enumToInt(C_MapConst.CollectionStatus.Full),
  CanCollect = enumToInt(C_MapConst.CollectionStatus.CanCollect)
}
L_MapConst.CollectionStatusText = {
  [L_MapConst.CollectionStatus.Working] = "notice_cellHomeCollection_01",
  [L_MapConst.CollectionStatus.NotSetPet] = "notice_cellHomeCollection_02",
  [L_MapConst.CollectionStatus.Pause] = "notice_cellHomeCollection_03",
  [L_MapConst.CollectionStatus.Free] = "notice_cellHomeCollection_04",
  [L_MapConst.CollectionStatus.UnFixed] = "",
  [L_MapConst.CollectionStatus.Full] = "notice_cellHomeCollection_05",
  [L_MapConst.CollectionStatus.CanCollect] = "notice_cellHomeCollection_04"
}
L_MapConst.CollectionStatusColor = {
  [L_MapConst.CollectionStatus.Working] = "#819965",
  [L_MapConst.CollectionStatus.NotSetPet] = "#ba3f2e",
  [L_MapConst.CollectionStatus.Pause] = "#ba3f2e",
  [L_MapConst.CollectionStatus.Free] = "#87725A",
  [L_MapConst.CollectionStatus.UnFixed] = "#87725A",
  [L_MapConst.CollectionStatus.Full] = "#e0923e",
  [L_MapConst.CollectionStatus.CanCollect] = "#87725A"
}
L_MapConst.CollectionStatusIcon = {
  [L_MapConst.CollectionStatus.Working] = "UI/Atlas/Collection/tex_home_collection_markers_icon_gzz.png",
  [L_MapConst.CollectionStatus.NotSetPet] = "UI/Atlas/Collection/tex_home_collection_markers_icon_cw.png",
  [L_MapConst.CollectionStatus.Pause] = "UI/Atlas/Collection/tex_home_collection_markers_icon_jg.png",
  [L_MapConst.CollectionStatus.Free] = "",
  [L_MapConst.CollectionStatus.UnFixed] = "",
  [L_MapConst.CollectionStatus.Full] = "UI/Atlas/Collection/tex_home_collection_markers_icon_ck.png",
  [L_MapConst.CollectionStatus.CanCollect] = ""
}
L_MapConst.mapSievingType = {
  none = enumToInt(C_MapSievingType.none),
  all = enumToInt(C_MapSievingType.all),
  transfer = enumToInt(C_MapSievingType.transfer),
  npc = enumToInt(C_MapSievingType.npc),
  wood = enumToInt(C_MapSievingType.wood),
  kiboduelGroup = enumToInt(C_MapSievingType.kiboduelGroup),
  ore = enumToInt(C_MapSievingType.ore),
  gem = enumToInt(C_MapSievingType.gem),
  stone = enumToInt(C_MapSievingType.stone),
  collection = enumToInt(C_MapSievingType.collection),
  dungeon = enumToInt(C_MapSievingType.dungeon),
  boss = enumToInt(C_MapSievingType.boss),
  dynamicDungeon = enumToInt(C_MapSievingType.dynamicDungeon),
  selfNode = enumToInt(C_MapSievingType.selfNode),
  fish = enumToInt(C_MapSievingType.fish),
  dungeonBoss = enumToInt(C_MapSievingType.dungeonBoss),
  sceneBorderTransfer = enumToInt(C_MapSievingType.sceneBorderTransfer),
  homeArea = enumToInt(C_MapSievingType.homeArea),
  kiboDuel = enumToInt(C_MapSievingType.kiboDuel),
  entrustTaskNpc = enumToInt(C_MapSievingType.entrustTaskNpc),
  kiboHabitat = enumToInt(C_MapSievingType.kiboHabitat),
  wildBuffBuild = enumToInt(C_MapSievingType.wildBuffBuild),
  challenge = enumToInt(C_MapSievingType.challenge),
  explore = enumToInt(C_MapSievingType.explore),
  nestCoop = enumToInt(C_MapSievingType.nestCoop),
  wumi = enumToInt(C_MapSievingType.wumi),
  areaBlock = enumToInt(C_MapSievingType.areaBlock),
  miniAreaBlock = enumToInt(C_MapSievingType.miniAreaBlock),
  areaMask = enumToInt(C_MapSievingType.areaMask),
  areaBoundary = enumToInt(C_MapSievingType.areaBoundary),
  areaLevel = enumToInt(C_MapSievingType.areaLevel),
  kiboDuelPvp = enumToInt(C_MapSievingType.kiboDuelPvp),
  kiboGroup = enumToInt(C_MapSievingType.kiboGroup),
  abbys = enumToInt(C_MapSievingType.abbys),
  task = enumToInt(C_MapSievingType.task),
  taskNpc = enumToInt(C_MapSievingType.taskNpc),
  target = enumToInt(C_MapSievingType.target),
  mythicalPet = enumToInt(C_MapSievingType.mythicalPet),
  homeTrace = enumToInt(C_MapSievingType.homeTrace),
  specialPet = enumToInt(C_MapSievingType.specialPet),
  mapCollectionItem = enumToInt(C_MapSievingType.mapCollectionItem),
  mapFxEffect = enumToInt(C_MapSievingType.mapFxEffect)
}
L_MapConst.SpecialMapNodeRes = nil
L_MapConst.mapTargetType = {
  npc = 1,
  item = 2,
  task = 3,
  choice = 4,
  obj = 5
}
L_MapConst.mapExploreFilter = {
  spawner = 101,
  singleCount = 201,
  collectionBuilding = 301
}
L_MapConst.mapExploreDetailType = {
  reward = 1,
  boss = 2,
  sight = 3
}
