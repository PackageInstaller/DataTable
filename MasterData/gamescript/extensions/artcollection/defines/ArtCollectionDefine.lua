local System = require("System.System")
local Readonly = System.readonly
local ArtCollectionDefine = {}
ArtCollectionDefine.TaskServerIndex = CommonDefine.TaskServerIndex.CollectionHallTask
ArtCollectionDefine.CompleteCond = "CollectionCountType"
ArtCollectionDefine.RewardType = Readonly({
  WorldView = "WorldView",
  StoryLineCG = "StoryLineCG",
  ScenesCG = "ScenesCG",
  PromotionVideo = "PromotionVideo",
  ActivityCG = "ActivityCG",
  RadioDrama = "RadioDrama",
  Music = "Music",
  Role = "Role",
  Event = "Event",
  Creation = "Creation",
  Trinket = "Trinket",
  Weapon = "Weapon",
  None = nil
})
ArtCollectionDefine.defaultProgressLangKey = "CollectionHall_Progress_Default"
ArtCollectionDefine.progressLangKeys = Readonly({
  [ArtCollectionDefine.RewardType.WorldView] = "CollectionHall_Progress_WorldView",
  [ArtCollectionDefine.RewardType.StoryLineCG] = "CollectionHall_Progress_StoryLineCG",
  [ArtCollectionDefine.RewardType.ScenesCG] = "CollectionHall_Progress_ScenesCG",
  [ArtCollectionDefine.RewardType.PromotionVideo] = "CollectionHall_Progress_PromotionVideo",
  [ArtCollectionDefine.RewardType.ActivityCG] = "CollectionHall_Progress_ActivityCG",
  [ArtCollectionDefine.RewardType.RadioDrama] = "CollectionHall_Progress_RadioDrama",
  [ArtCollectionDefine.RewardType.Music] = "CollectionHall_Progress_Music",
  [ArtCollectionDefine.RewardType.Role] = "CollectionHall_Progress_Role",
  [ArtCollectionDefine.RewardType.Event] = "CollectionHall_Progress_Event",
  [ArtCollectionDefine.RewardType.Creation] = "CollectionHall_Progress_Creation",
  [ArtCollectionDefine.RewardType.Trinket] = "CollectionHall_Progress_Trinket",
  [ArtCollectionDefine.RewardType.Weapon] = "CollectionHall_Progress_Weapon"
})
ArtCollectionDefine.CGList = Readonly({
  ArtCollectionDefine.RewardType.StoryLineCG,
  ArtCollectionDefine.RewardType.ScenesCG,
  ArtCollectionDefine.RewardType.PromotionVideo,
  ArtCollectionDefine.RewardType.ActivityCG,
  ArtCollectionDefine.RewardType.RadioDrama
})
ArtCollectionDefine.CGType = "CG"
do return Readonly, ArtCollectionDefine end
return Readonly, ArtCollectionDefine, "ArtCollectionDefine", ArtCollectionDefine.RewardType.ScenesCG, ArtCollectionDefine.RewardType.PromotionVideo, ArtCollectionDefine.RewardType.ActivityCG, ArtCollectionDefine.RewardType.RadioDrama
