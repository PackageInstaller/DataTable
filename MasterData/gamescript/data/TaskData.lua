local TaskData = Vue.reactive({})
TaskData.taskTid2DataDict = {}
TaskData.taskSvrIdx2TidsDict = {}
TaskData.appointRefreshCount = 0
TaskData.sendTeamNum = 0
TaskData.maxTeamNum = 0
TaskData.curShowTaskType = nil
TaskData.completeDelegateNum = 0
TaskData.maxCompleteDelegateNum = 0
TaskData.isSpecialAppoint = 1
TaskData.dailyTaskTid = nil
return TaskData
