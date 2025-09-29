-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueEventJudgeView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueEventJudgeView", package.seeall)

local M = class("RogueEventJudgeView", RogueJudgeView)

function M:ctor()
	M.super.ctor(self)
end

function M:onEnter()
	self:setEvent(true)

	self._txtEnemyHp.text = "x0"

	local eventId = self:getFirstParam()[1]
	local replyCo = self:getFirstParam()[2]

	if eventId == nil or replyCo == nil then
		print("打开界面参数为空", tostring(eventId ~= nil), tostring(replyCo ~= nil), debug.traceback())
		self:close()

		return
	end

	RogueMgr.instance:enterEvent(eventId, replyCo.type + 1)
	M.super.onEnter(self)
	self:showEventTypeTips(replyCo)
	self:updateEventInfo(replyCo)
end

function M:onExit()
	M.super.onExit(self)
	self:onShowExtraResultFinish()
	removetimer(self.onShowExtraResultFinish, self)
	removetimer(self.onShowEventTipsFinish, self)
	removetimer(self.onShowEventStartFinish, self)
	removetimer(self.onShowEventEndFinish, self)
end

function M:updateEventInfo(replyCo)
	local eventProp = RogueMgr.instance:getModel():getCurEventProp()
	local map = RoguelikeConst.PROP_LANG_MAP[eventProp]
	local diff = replyCo.difficulty + RogueMgr.instance:getModel():getEventChangeDifficulty()

	diff = math.max(1, diff)

	for i = 1, 6 do
		goutil.setActive(self._goPatternSelects[i], i == eventProp)
		goutil.setActive(self._goPatternNormals[i], i ~= eventProp)
	end

	self._txtEventDiff.text = string.format(lang("tip_r_event_diff"), diff)

	IconLoader.setSprite(self._iconEventJudge, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(eventProp)))

	local eventMo = RogueMgr.instance:getModel() and RogueMgr.instance:getModel():getCurEventMo() or nil

	if eventMo then
		eventMo.eventInfo:setIcon(eventProp)
	end
end

function M:showEventTypeTips(replyCo)
	if self._goEventTypeTips == nil then
		self._goEventTypeTips = self:getResInstance(ResName.Rungroupother_judgement_type_view)

		goutil.addChildToParent(self._goEventTypeTips, self.mainGO)
	end

	goutil.setActive(self._goEventTypeTips, true)

	local type1 = goutil.findChild(self._goEventTypeTips, "type1")
	local type2 = goutil.findChild(self._goEventTypeTips, "type2")
	local type1Text = goutil.findChildTextComponent(self._goEventTypeTips, "type1/text")
	local type2Text = goutil.findChildTextComponent(self._goEventTypeTips, "type2/text")
	local isSingleEvent = replyCo.type == RoguelikeConst.ROGUE_EVENT_TYPE_1.SINGLE_EVENT
	local map = RoguelikeConst.PROP_LANG_MAP[RogueMgr.instance:getModel():getCurEventProp()]

	type1Text.text = string.format(lang("tip_r_single_judge"), map.name)
	type2Text.text = string.format(lang("tip_r_mult_judge"), map.name)

	if replyCo.type == RoguelikeConst.ROGUE_EVENT_TYPE_1.ENCOUNTER_EVENT then
		type2Text.text = string.format(lang("tip_r_encounter_judge"))
	end

	goutil.setActive(type1, isSingleEvent)
	goutil.setActive(type2, not isSingleEvent)
	settimer(1, self.onShowEventTipsFinish, self, false)
end

function M:onShowEventTipsFinish()
	goutil.setActive(self._goEventTypeTips, false)
	self:showEventStartTips()
end

function M:showEventStartTips()
	if self._goStateTips == nil then
		self._goStateTips = self:getResInstance(ResName.Rungroupother_judgement_state_view)

		goutil.addChildToParent(self._goStateTips, self.mainGO)

		self._aniStateTips = goutil.addComponentOnce(self._goStateTips, typeof(Astral.GUITimelineAniLua))
	end

	goutil.setActive(self._goStateTips, true)

	local type1 = goutil.findChild(self._goStateTips, "type1")
	local type1Text = goutil.findChildTextComponent(self._goStateTips, "type1/text")

	type1Text.text = lang("判定开始")

	goutil.setActive(type1, true)
	self._aniStateTips:StopTimelineAni()
	self._aniStateTips:PlayAniByName("open")
	settimer(1, self.onShowEventStartFinish, self, false)
end

function M:onShowEventStartFinish()
	goutil.setActive(self._goStateTips, false)
end

function M:showEnterBroadCast()
	local msg2, isTitle2 = RoguelikeConfig.getBroadCast("Broadcast_Event_Start")

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg2, isTitle2)

	local replyCo = self:getFirstParam()[2]
	local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Event_Info")
	local msg = string.format(format, RoguelikeConst.AttrType2GraphicText[RoguelikeUtil.instance:convertCAttrType2SType(RogueMgr.instance:getModel():getCurEventProp())], replyCo.difficulty + RogueMgr.instance:getModel():getEventChangeDifficulty())

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
end

function M:setGoActive()
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()
	local isEncounterEvent = eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT

	for k, v in pairs(roleMos) do
		-- block empty
	end

	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		mapMgr:setActive(false)
	end
end

function M:_onResultFinish(sender, isWin)
	self:showEventEndFinish(isWin)

	if not isWin then
		goutil.setActive(self._goEventFail, true)
		goutil.setActive(self._iconEventJudge.gameObject, false)
		settimer(1.5, self.onShowExtraResultFinish, self, false)

		return
	end
end

function M:showEventEndFinish(isWin)
	goutil.setActive(self._goStateTips, true)

	local type1 = goutil.findChild(self._goStateTips, "type1")
	local type1Text = goutil.findChildTextComponent(self._goStateTips, "type1/text")
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT or eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		type1Text.text = isWin and lang("tip_r_judge_success") or lang("tip_r_judge_fail")
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		type1Text.text = lang("判定结束")
	end

	goutil.setActive(type1, true)
	self._aniStateTips:StopTimelineAni()
	self._aniStateTips:PlayAniByName("open")
	settimer(1.5, self.onShowEventEndFinish, self, false)
end

function M:onShowEventEndFinish()
	goutil.setActive(type1, false)
end

function M:onShowResultFinish()
	goutil.setActive(self._goResult, false)
	goutil.setActive(self._goEventFail, false)
	goutil.setActive(self._iconEventJudge.gameObject, true)
	self:_onClickClose()
end

function M:_onGambleCountdown(sender, time)
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()
	local isShowHp = false

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		self._txtGamblePunish.text = RoguelikeConfig.instance:getConstByName("GambleSingleEventEffectDesc").strValue
		self._gambleEffectId = RoguelikeConfig.instance:getConstByName("GambleSingleEventEffectId").numValue
		isShowHp = true
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		self._txtGamblePunish.text = RoguelikeConfig.instance:getConstByName("GambleMultEventEffectDesc").strValue
		self._gambleEffectId = RoguelikeConfig.instance:getConstByName("GambleMultEventEffectId").numValue
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		self._txtGamblePunish.text = RoguelikeConfig.instance:getConstByName("GambleEncounterEventEffectDesc").strValue
		self._gambleEffectId = RoguelikeConfig.instance:getConstByName("GambleEncounterEventEffectId").numValue
	end

	goutil.setActive(self._goGamble, time > 0)
end

function M:_updateCombatDice(sender, dices)
	if dices then
		self._txtEnemyHp.text = "x" .. #dices
		self._combatDiceCount = #dices
	end
end

function M:_changeCombatDice(sender, changeCount)
	if changeCount then
		self._combatDiceCount = self._combatDiceCount - changeCount
	else
		self._combatDiceCount = RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDiceCount()
	end

	if self._combatDiceCount < 0 then
		self._combatDiceCount = 0
	end

	self._txtEnemyHp.text = "x" .. self._combatDiceCount
end

return M
