local RedPointData = Vue.reactive({})
RedPointData.awaker = {}
RedPointData.awakerCount = 0
RedPointData.newWeaponCount = 0
RedPointData.subTask = {}
RedPointData.task = {}
RedPointData.coursePrize = {}
RedPointData.avg = {
  localKey = "AvgRedPointTime",
  localValue = 0
}
RedPointData.defaultCard = {}
RedPointData.AnnouncementEnter = {isNew = 0}
return RedPointData
