-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseFragmentView.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseFragmentView", package.seeall)

local M = class("PlayerCourseFragmentView", DynamicFragmentView)
local EditViewType = GameEnum.DisplayTypeEnum

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnEdit = self:getBtn("player_course_panel_949561592")
	self._btnConfirm = self:getBtn("player_course_panel_788878726")
	self._btnCancel = self:getBtn("player_course_panel_1756922427")
	self._btnTrailing = self:getBtn("player_course_panel_1071781820")
	self._txtTrailing = self:getText("player_course_panel_856636027")
	self._txtTrailingTitle = self:getText("player_course_panel_1659504961")
	self._goRedPoint = self:getGo("player_course_panel_1800156188")
	self._guiAnimation = goutil.addComponentOnce(self._registry:getMainGO(), typeof(Astral.GUITimelineAniLua))
	self._widgets = {
		[EditViewType.Hero] = CourseHeroCollectWidgets.New(self):buildUI(),
		[EditViewType.Cup] = CourseCupWidgets.New(self):buildUI(),
		[EditViewType.HouseLiveRoom] = CourseHouseWidgets.New(self):buildUI(),
		[EditViewType.AirStudio] = CourseAirWidgets.New(self):buildUI(),
		[EditViewType.Roguelike] = CourseRoguelikeWidgets.New(self):buildUI()
	}
end

function M:destroyUI()
	self._btnEdit = nil
	self._btnConfirm = nil
	self._btnCancel = nil
	self._btnTrailing = nil
	self._txtTrailing = nil
	self._goRedPoint = nil

	self:destroyAllWidgets()
end

function M:bindEvents()
	self._btnEdit:AddClickListener(self._onClickEdit, self)
	self._btnConfirm:AddClickListener(self._clickConfirm, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnTrailing:AddClickListener(self._onClickTrailing, self)
	GlobalDispatcher:addEventListener(EventType.COURSE_INFO_GOT, self._onDataGot, self)

	for _, v in pairs(self._widgets) do
		v:bindEvents()
	end
end

function M:unbindEvents()
	self._btnEdit:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnTrailing:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.COURSE_INFO_GOT, self._onDataGot, self)

	for _, v in pairs(self._widgets) do
		v:unbindEvents()
	end
end

function M:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")

	if not PlayerCourseModel.instance:permission() then
		return
	end

	self:initEditActive()
	self:initAllWidgets()

	local mainline = PlayerCourseModel.instance:getMainlineId()
	local cfg = DungeonConfig.instance:getDungeonCfgById(mainline)

	if cfg then
		self._txtTrailing.text = string.format("%s%s", cfg.index, cfg.name)

		local chapter = DungeonConfig.instance:getCfgMainLineChapterByDungeonId(mainline)

		if chapter then
			self._txtTrailingTitle.text = chapter.name
		end
	end

	RedDotModel.instance:createDotView({
		dotNode = self._goRedPoint,
		keyList = {
			GameEnum.RedPointEnum.MainlineDiary
		}
	})
end

function M:onExit()
	self:clearAllWidgets()
end

function M:initEditActive()
	goutil.setActive(self._btnEdit.gameObject, PlayerCourseModel.instance:editPermission())
	goutil.setActive(self._btnCancel.gameObject, false)
	goutil.setActive(self._btnConfirm.gameObject, false)
end

function M:setEditState(isInEdit)
	goutil.setActive(self._btnEdit.gameObject, not isInEdit)
	goutil.setActive(self._btnCancel.gameObject, isInEdit)
	goutil.setActive(self._btnConfirm.gameObject, isInEdit)
	self:setAllWidgetsEditState(isInEdit)
end

function M:initAllWidgets()
	for _, v in pairs(self._widgets) do
		v:onInit()
	end
end

function M:clearAllWidgets()
	for _, v in pairs(self._widgets) do
		v:onClear()
	end
end

function M:destroyAllWidgets()
	for _, v in pairs(self._widgets) do
		v:destroyUI()
	end

	self._widgets = nil
end

function M:setAllWidgetsEditState(isInEdit)
	for _, v in pairs(self._widgets) do
		v:setIsInEdit(isInEdit)
	end
end

function M:_onClickEdit()
	self:setEditState(true)
end

function M:_clickConfirm()
	self:setEditState(false)

	local editInfo = {}

	for _, v in pairs(self._widgets) do
		editInfo[v:getEditType()] = v:getEditValue()
	end

	PlayerCourseAgent.instance:sendSetDisplayTargetRequest(editInfo)
end

function M:_onDataGot()
	self:onEnter()
end

function M:_onClickCancel()
	self:setEditState(false)
end

function M:_onClickTrailing()
	ViewMgr.instance:open(ViewName.PlayerCourseDiaryView)
end

return M
