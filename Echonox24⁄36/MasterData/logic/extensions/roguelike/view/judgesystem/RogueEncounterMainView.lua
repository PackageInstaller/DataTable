-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueEncounterMainView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueEncounterMainView", package.seeall)

local M = class("RogueEncounterMainView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("0&title_view_-878360263")
	self._btnFight = self:getBtn("run_group_emergency_view_1047258851")
	self._txtEventName = self:getText("run_group_emergency_view_-247688990")
	self._txtDesc = self:getText("run_group_emergency_view_203620152")
	self._txtProp = self:getText("run_group_emergency_view_-1593064410")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnFight:AddClickListener(self._onClickFight, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnFight:RemoveClickListener()
end

function M:onEnter()
	RoguelikeAgent.instance:sendJudgeArchiveRequest(nil)

	self._eventId = self:getFirstParam()

	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(self._eventId)
	local replyIds = eventCo.replys or {}
	local replyCo = RoguelikeConfig.instance:getEventReplyById(replyIds[1])

	self._replyCo = replyCo

	if replyCo == nil then
		printError("找不到应对id", self._eventId, #replyIds)
	end

	self._txtEventName.text = eventCo.name
	self._txtDesc.text = eventCo.description

	local map = RoguelikeConst.PROP_LANG_MAP[replyCo.testedAttribute]

	self._txtProp.text = lang("tip_r_judge_prop") .. map.name .. " x" .. replyCo.difficulty
	self._eventCo = eventCo
end

function M:onExit()
	return
end

function M:_onClickClose()
	self:close()
	ViewMgr.instance:close(ViewName.RogueMap)
	RoguelikeController.instance:exitRunGroupSceneFlow()
end

function M:_onClickFight()
	local result = RogueMgr.instance:getModel():setFirstActiveRoleIndex()

	if result == 0 then
		return
	end

	RogueMgr.instance:getModel():setCurReplyCo(self._replyCo)
	RogueMgr.instance:getModel():setEventProp(self._replyCo.testedAttribute)
	RogueMgr.instance:getModel():setCurEventInfo({
		self._eventId,
		self._replyCo
	})
	RoguelikeController.instance:enterRunGroupJudgeScene(function()
		ViewMgr.instance:close(ViewName.RogueMap)

		local eventInfo = RogueMgr.instance:getModel():getCurEventInfo()

		ViewMgr.instance:open(ViewName.RogueEventJudge, eventInfo)
		RogueMgr.instance:getModel():setCurEventInfo(nil)
	end)
	self:close()
end

return M
