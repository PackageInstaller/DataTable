local ActivitySectorIIIEnum = {}
ActivitySectorIIIEnum.eActRedDotTypeId = {
  task = "task",
  tech = "tech",
  map = "map"
}
ActivitySectorIIIEnum.eActRedDotIsRedType = {
  [ActivitySectorIIIEnum.eActRedDotTypeId.task] = true
}
return ActivitySectorIIIEnum
