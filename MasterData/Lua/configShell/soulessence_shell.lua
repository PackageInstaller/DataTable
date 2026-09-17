local this = class("soulessence_shell", G_BaseConfig)
local core = G_Tables.TDSoulessenceTable.GetInstance()

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
  name = 1,
  rarity = 2,
  validProfession = 3,
  gradeItem = 4,
  attribute = 5,
  reishiExp = 6,
  icon = 7,
  textureBg = 8,
  textureFace = 9,
  resourcePath = 10,
  cgPath = 11,
  uiPath = 12,
  desc = 13,
  video = 14,
  videoSound = 15,
  animationSound = 16,
  animationBgm = 17,
  task = 18,
  story = 19,
  storyLock = 20,
  isValid = 21,
  handbooksoulessence = 22,
  decomposed = 23,
  way = 24,
  wayDesc = 25,
  SoulessenceSelectPic = 26,
  offsetZoom = 27
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("soulessence", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getValidprofession(offset)
  return core:GetInt(offset, this.indexMap.validProfession)
end

function this:_getGradeitem(offset)
  return core:GetInt(offset, this.indexMap.gradeItem)
end

function this:_getAttribute(offset)
  return core:GetInt(offset, this.indexMap.attribute)
end

function this:_getReishiexp(offset)
  return core:GetInt(offset, this.indexMap.reishiExp)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 5)
end

function this:_getTexturebg(offset)
  local str = core:GetVString(offset, this.indexMap.textureBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTextureface(offset)
  local str = core:GetVString(offset, this.indexMap.textureFace).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getResourcepath(offset)
  local str = core:GetVString(offset, this.indexMap.resourcePath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCgpath(offset)
  local str = core:GetVString(offset, this.indexMap.cgPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUipath(offset)
  local str = core:GetVString(offset, this.indexMap.uiPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("soulessence", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getVideo(offset)
  local str = core:GetVString(offset, this.indexMap.video).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getVideosound(offset)
  return core:GetVString(offset, this.indexMap.videoSound).value
end

function this:_getAnimationsound(offset)
  return core:GetVString(offset, this.indexMap.animationSound).value
end

function this:_getAnimationbgm(offset)
  return core:GetVString(offset, this.indexMap.animationBgm).value
end

function this:_getTask(offset)
  return core:GetInt(offset, this.indexMap.task)
end

function this:_getStory(offset)
  return core:GetInt(offset, this.indexMap.story)
end

function this:_getStorylock(offset)
  local str = core:GetVString(offset, this.indexMap.storyLock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getIsvalid(offset)
  return core:GetInt(offset, this.indexMap.isValid)
end

function this:_getHandbooksoulessence(offset)
  return core:GetInt(offset, this.indexMap.handbooksoulessence)
end

function this:_getDecomposed(offset)
  local str = core:GetVString(offset, this.indexMap.decomposed).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("soulessence", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "soulessence")
end

function this:_getSoulessenceselectpic(offset)
  local str = core:GetVString(offset, this.indexMap.SoulessenceSelectPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getOffsetzoom(offset)
  return core:GetVString(offset, this.indexMap.offsetZoom).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  rarity = this._getRarity,
  validProfession = this._getValidprofession,
  gradeItem = this._getGradeitem,
  attribute = this._getAttribute,
  reishiExp = this._getReishiexp,
  icon = this._getIcon,
  textureBg = this._getTexturebg,
  textureFace = this._getTextureface,
  resourcePath = this._getResourcepath,
  cgPath = this._getCgpath,
  uiPath = this._getUipath,
  desc = this._getDesc,
  video = this._getVideo,
  videoSound = this._getVideosound,
  animationSound = this._getAnimationsound,
  animationBgm = this._getAnimationbgm,
  task = this._getTask,
  story = this._getStory,
  storyLock = this._getStorylock,
  isValid = this._getIsvalid,
  handbooksoulessence = this._getHandbooksoulessence,
  decomposed = this._getDecomposed,
  way = this._getWay,
  wayDesc = this._getWaydesc,
  SoulessenceSelectPic = this._getSoulessenceselectpic,
  offsetZoom = this._getOffsetzoom
}
return this
