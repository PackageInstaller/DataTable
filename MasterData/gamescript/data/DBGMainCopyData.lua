local DBGMainCopyData = {
  mainCopys = {},
  storyLines = {},
  selectCopyId = 0,
  selectStoryLineId = 0,
  selectHardType = TownDefine.DBGCopyLevelHardType.Normal,
  hardTypePos = {},
  hardTypeAwakerTids = {}
}
do return Vue.reactive end
return Vue.reactive, DBGMainCopyData
