local this = class("journey_task_shell", G_BaseConfig)
local core = G_Tables.TDJourneyTaskTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  order = 1,
  tabId = 2,
  unlockCondition = 3,
  unlockDesc = 4,
  unlockDescNum = 5,
  isFirstTask = 6,
  nextTask = 7,
  taskType = 8,
  needCompleteNum = 9,
  isPetPic = 10,
  chapterTitle = 11,
  chapterTitleDesc = 12,
  title = 13,
  isRecommend = 14,
  pic = 15,
  param = 16,
  taskReward = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getTabid(offset)
  return core:GetInt(offset, this.indexMap.tabId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_task", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

function this:_getUnlockdescnum(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_task", core:GetVString(offset, this.indexMap.unlockDescNum))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDescNum")
end

function this:_getIsfirsttask(offset)
  return core:GetInt(offset, this.indexMap.isFirstTask)
end

function this:_getNexttask(offset)
  return core:GetInt(offset, this.indexMap.nextTask)
end

function this:_getTasktype(offset)
  return core:GetInt(offset, this.indexMap.taskType)
end

function this:_getNeedcompletenum(offset)
  return core:GetInt(offset, this.indexMap.needCompleteNum)
end

function this:_getIspetpic(offset)
  return core:GetInt(offset, this.indexMap.isPetPic)
end

function this:_getChaptertitle(offset)
  return core:GetInt(offset, this.indexMap.chapterTitle)
end

function this:_getChaptertitledesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_task", core:GetVString(offset, this.indexMap.chapterTitleDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "chapterTitleDesc")
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_task", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getIsrecommend(offset)
  return core:GetInt(offset, this.indexMap.isRecommend)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTaskreward(offset)
  local str = core:GetVString(offset, this.indexMap.taskReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  order = this._getOrder,
  tabId = this._getTabid,
  unlockCondition = this._getUnlockcondition,
  unlockDesc = this._getUnlockdesc,
  unlockDescNum = this._getUnlockdescnum,
  isFirstTask = this._getIsfirsttask,
  nextTask = this._getNexttask,
  taskType = this._getTasktype,
  needCompleteNum = this._getNeedcompletenum,
  isPetPic = this._getIspetpic,
  chapterTitle = this._getChaptertitle,
  chapterTitleDesc = this._getChaptertitledesc,
  title = this._getTitle,
  isRecommend = this._getIsrecommend,
  pic = this._getPic,
  param = this._getParam,
  taskReward = this._getTaskreward
}
return this
