-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/PlayerCourseModel.lua

module("logic.extensions.playerinfo.model.PlayerCourseModel", package.seeall)

local M = class("PlayerCourseModel", BaseModel)
local EditType = GameEnum.DisplayTypeEnum
local EditValue = GameEnum.DisplayTargetEnum

function M:ctor()
	return
end

function M:onInit()
	self._permission = false
end

function M:onReset()
	self._displayData = nil
	self._editInfo = nil
	self._lockInfo = nil
	self._permission = false
end

function M:permission()
	return self._permission
end

function M:editPermission()
	return self._userId == PlayerModel.instance:getId()
end

function M:getCourseUserId()
	return self._userId
end

function M:getVisitType()
	return self._visitType
end

function M:getMainlineId()
	return self._mainlineId
end

function M:getMainlineDiary()
	return self._mainLineDiary
end

function M:getEditInfo(editType)
	return self._editInfo and self._editInfo[editType] or EditValue.All
end

function M:isLock(editType)
	return self._lockInfo and self._lockInfo[editType] or false
end

function M:getDisplayData(type)
	return self._displayData[type]
end

function M:getVisitType()
	local userId = self._userId

	return userId == PlayerModel.instance:getId() and EditValue.Self or FriendModel.instance:isInRelationType(GameEnum.RelationTypeEnum.Friend, tonumber(userId)) and EditValue.Friend or EditValue.All
end

function M:getEditDatas(type)
	local display = self._displayData[type]

	if type == EditType.Hero then
		return display:getDisplayHero(), HeroDepotModel.instance:getHeroDepotData():getShowDataList():getMoList()
	end

	if type == EditType.Cup then
		return display:getDisplayCup(), MonumentModel.instance:getFinishedMaxLvMonuments()
	end

	if type == EditType.HouseLiveRoom then
		return display:getDisplayHouse(), LivingFacilitiesZoneModel.instance:getAllEffectiveZone()
	end
end

function M:buildCourseData(msg)
	assert(msg, "请求历程信息为空")

	self._displayData = {}
	self._editInfo = {}
	self._lockInfo = {}
	self._mainlineId = msg.mainlineId
	self._mainLineDiary = msg.mainlineDiary
	self._displayData[EditType.Hero] = CourseCharacterCollectData.New(msg.hero, msg.camp, msg.heroCnt)
	self._displayData[EditType.Cup] = CourseCupCollectData.New(msg.cup)
	self._displayData[EditType.HouseLiveRoom] = CourseHouseCollectData.New(msg.roomInfo)
	self._displayData[EditType.AirStudio] = CourseAirDisplayData.New(msg.airStudio)
	self._displayData[EditType.Roguelike] = CourseRoguelikeCollectData.New(msg.roguelike)

	self:updateEditInfo(msg.target)
	self:_buildLockInfo(msg.locked)

	self._permission = true
end

function M:_buildLockInfo(lockedTypes)
	for i = EditType.Hero, EditType.Roguelike do
		self._lockInfo[i] = false
	end

	for _, v in ipairs(lockedTypes) do
		self._lockInfo[v] = true
	end

	self._lockInfo[EditType.AirStudio] = true
end

function M:updateEditInfo(info)
	for _, v in ipairs(info) do
		self._editInfo[v.type] = v.target
	end
end

function M:updateShowContent(info)
	if self._displayData[info.type] then
		self._displayData[info.type]:updateContent(info.id)
	end
end

function M:setCourseUserId(userId)
	self._userId = userId
end

M.instance = M.New()

return M
