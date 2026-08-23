local BattleSummon = class("BattleSummon", function()
	return cc.Node:create()
end)
local var_0_2 = table.insert
local var_0_4 = g.core.config.skill_summon_info
local BattleKnight = require("app.view.battle.BattleKnight")
local BattlePath = require("app.view.battle.BattlePath")
local SpineBase = require("app.view.common.SpineBase")
local BattleConst = require("app.view.battle.const.BattleConst")

function BattleSummon:ctor(arg_2_1, arg_2_2)
	self._identity = arg_2_2:getActorByMemberId(arg_2_1.owner_serial_id):getIdentity()
	self._id = arg_2_1.summon_id
	self._data = arg_2_1
	self._battleLayer = arg_2_2

	local var_2_0 = self._battleLayer:getCamera()
	local var_2_1 = var_0_4.get(arg_2_1.summon_id)

	self._info = var_2_1
	self._nodeRoot = cc.Node:create():addTo(self)

	self._nodeRoot:setCascadeOpacityEnabled(true)
	self._nodeRoot:setCascadeColorEnabled(true)
	self:setCascadeOpacityEnabled(true)
	self:setCascadeColorEnabled(true)

	self._spine = BattleKnight.new({
		resId = var_2_1.battle_res,
		listener = handler(self, self._onSpineEvent)
	})

	self._nodeRoot:addChild(self._spine, 2)

	local var_2_2 = cc.Node:create():addTo(self._nodeRoot, 3)

	var_2_2:setCascadeColorEnabled(true)
	var_2_2:setCascadeOpacityEnabled(true)

	self._nodeBonesUp = var_2_2

	local var_2_3 = cc.Node:create():addTo(self._nodeRoot, 1)

	var_2_3:setCascadeColorEnabled(true)
	var_2_3:setCascadeOpacityEnabled(true)

	self._nodeBonesDown = var_2_3
	self._nodeEffectDown1 = cc.Node:create()
	self._nodeEffectDown2 = cc.Node:create()
	self._nodeEffectDown3 = cc.Node:create()
	self._nodeEffectUp1 = cc.Node:create()
	self._nodeEffectUp2 = cc.Node:create()

	var_2_0:addToNodeHeroDown(self._nodeEffectDown2)
	var_2_0:addToNodeHeroUp(self._nodeEffectUp1)
	var_2_0:addToNodeHero(self._nodeEffectDown1, 3)
	var_2_0:addToNodeHero(self._nodeEffectUp2, 43)
	var_2_0:addToNodeHero(self._nodeEffectDown3, 51)

	self._effects = {}

	local var_2_4 = var_2_0:getCenter()

	self._pos = var_2_4

	self:setPosition(var_2_4.x, var_2_4.y)
	self._nodeEffectUp1:setPosition(var_2_4.x, var_2_4.y)
	self._nodeEffectUp2:setPosition(var_2_4.x, var_2_4.y)
	self._nodeEffectDown1:setPosition(var_2_4.x, var_2_4.y)
	self._nodeEffectDown2:setPosition(var_2_4.x, var_2_4.y)
	self._nodeEffectDown3:setPosition(var_2_4.x, var_2_4.y)
	self:updateDir()
	self:addEffect()
end

function BattleSummon:setData(arg_3_1)
	self._id = arg_3_1.summon_id
	self._info = var_0_4.get(arg_3_1.summon_id)
	self._identity = self._battleLayer:getActorByMemberId(arg_3_1.owner_serial_id):getIdentity()
	self._data = arg_3_1

	self:updateDir()
	self._nodeRoot:setOpacity(255)
end

function BattleSummon:getBones()
	return self._spine
end

function BattleSummon:getSpine()
	return self._spine
end

function BattleSummon:addKnightActionMark(arg_6_1)
	self._actionMark = true
	self._cutActionCallback = arg_6_1
end

function BattleSummon:getKnightActionMark()
	return self._actionMark
end

function BattleSummon:resetActionMark()
	if self._actionMark and self._cutActionCallback then
		self._cutActionCallback(true)

		self._actionMark = false
		self._cutActionCallback = nil
	else
		self._actionMark = false
		self._cutActionCallback = nil
	end
end

function BattleSummon:addKnightPosMark(arg_9_1)
	self._posMark = true
	self._resetPosCallback = arg_9_1
end

function BattleSummon:getKnightPosMark()
	return self._posMark
end

function BattleSummon:resetKnightPos()
	if self._posMark and self._resetPosCallback then
		self._resetPosCallback(true)

		self._posMark = false
		self._resetPosCallback = nil
	else
		self._posMark = false
		self._resetPosCallback = nil
	end
end

function BattleSummon:getBaseKnightInfo()
	return self._info
end

function BattleSummon:addEffect()
	if self._info.effect_high ~= "0" then
		local var_13_0 = {}

		var_13_0.isLoop = false
		var_13_0.path = BattlePath.getSpineEffectPath(self._info.effect_high)
		var_13_0.anim = BattleConst.SPINE_ACTION_TYPE.PLAY

		local var_13_1 = SpineBase.new(var_13_0)

		self._nodeBonesUp:addChild(var_13_1)
		var_0_2(self._effects, var_13_1)
	end

	if self._info.effect_low ~= "0" then
		local var_13_2 = {}

		var_13_2.isLoop = false
		var_13_2.path = BattlePath.getSpineEffectPath(self._info.effect_low)
		var_13_2.anim = BattleConst.SPINE_ACTION_TYPE.PLAY

		local var_13_3 = SpineBase.new(var_13_2)

		self._nodeBonesDown:addChild(var_13_3)
		var_0_2(self._effects, var_13_3)
	end
end

function BattleSummon:_onSpineEvent(arg_14_1)
	if arg_14_1.eventData then
		-- block empty
	end
end

function BattleSummon:playAction(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0

	if string.find(arg_15_1, "hit") then
		var_15_0 = BattleConst.SPINE_ACTION_TYPE.HIT

		return
	else
		var_15_0 = string.find(arg_15_1, "skill") and BattleConst.SPINE_ACTION_TYPE.SKILL or (string.find(arg_15_1, "attack") or string.find(arg_15_1, "start")) and BattleConst.SPINE_ACTION_TYPE.ATTACK or string.find(arg_15_1, "dead") and BattleConst.SPINE_ACTION_TYPE.DEAD or arg_15_1
	end

	if not self._actionName or self._actionName ~= arg_15_1 then
		self._actionData = json.decodeFileIfExists((BattlePath.getSpineEffectGroupPath(arg_15_1)))
		self._actionName = arg_15_1
	end

	self._spine:setVisible(true)
	self._spine:setAnimation(0, var_15_0)
end

function BattleSummon:playReadyAction()
	return
end

function BattleSummon:_update()
	for iter_17_0, iter_17_1 in ipairs(self._effects) do
		iter_17_1:step()
	end
end

function BattleSummon:setIdentity(arg_18_1)
	self._identity = arg_18_1

	self:updateDir()
end

function BattleSummon:updateDir()
	local var_19_0 = 1

	if self._identity == 2 then
		var_19_0 = -1
	end

	self._spine:setScaleX(var_19_0)
	self._nodeEffectUp1:setScaleX(var_19_0)
	self._nodeEffectUp2:setScaleX(var_19_0)
	self._nodeEffectDown1:setScaleX(var_19_0)
	self._nodeEffectDown2:setScaleX(var_19_0)
	self._nodeEffectDown3:setScaleX(var_19_0)
end

function BattleSummon:playDefaultAction()
	self:playReadyAction()
end

function BattleSummon:setInitPosition(arg_21_1)
	self._initPosition = arg_21_1
end

function BattleSummon:getInitPosition()
	return self._initPosition
end

function BattleSummon:getKnightInfo()
	return self._info
end

function BattleSummon:getResId()
	if self._info then
		return self._info.battle_res
	end

	return 0
end

function BattleSummon:getPlayInfoBySkillId(arg_25_1)
	local var_25_0 = g.core.config.play_info.get(arg_25_1, self._info.advance_id, 0) or g.core.config.play_info.get(arg_25_1, 0, 0)

	assert(var_25_0, string.format("play_info can't find code = %d, skillId = %d, advance_id = %d", 0, arg_25_1, self._info.advance_id))

	return var_25_0
end

function BattleSummon:getIdentity()
	return self._identity
end

function BattleSummon:getLocationScale()
	return 1
end

function BattleSummon:setToTopOrder()
	self:setLocalZOrder(50 + self._initPosition.zorder)
end

function BattleSummon:resetToOrder()
	self:setLocalZOrder(self._initPosition.zorder)
end

function BattleSummon:follow()
	local var_30_0, var_30_1 = self:getPosition()

	self._nodeEffectDown1:setPosition(var_30_0, var_30_1)
	self._nodeEffectDown2:setPosition(var_30_0, var_30_1)
	self._nodeEffectDown3:setPosition(var_30_0, var_30_1)
	self._nodeEffectUp1:setPosition(var_30_0, var_30_1)
	self._nodeEffectUp2:setPosition(var_30_0, var_30_1)
end

function BattleSummon:playRunAction()
	self:playAction("action_" .. self._info.battle_res .. "_run")
end

function BattleSummon:getFrameCount()
	local var_32_0 = self._spine:getCurrentAnimationData()

	if var_32_0 then
		return (var_32_0:getMaxFrames())
	end

	return 0
end

function BattleSummon:showHpBar(arg_33_1)
	return
end

function BattleSummon:playFadeIn()
	self._nodeRoot:setOpacity(0)

	local var_34_0 = require("app.core.common.action.Action").newFadeTo(15, 255)

	var_34_0:startWithTarget(self._nodeRoot)
	self._battleLayer:getMainEntry():addEntryToNewQueue(var_34_0, var_34_0.stepNext)
end

function BattleSummon:getEventHitNum()
	local var_35_0, var_35_1, var_35_2 = self:getKeyFrameNum("hit")

	if var_35_0 > 0 then
		return var_35_0, var_35_1, var_35_2
	end

	local var_35_3 = 0
	local var_35_4 = 0
	local var_35_5 = ""

	for iter_35_0, iter_35_1 in pairs(self._spine:getEventNames() or {}) do
		if string.match(iter_35_1, "hit") then
			var_35_4 = var_35_4 + 1

			if var_35_5 == "" then
				var_35_5 = iter_35_1
			end
		end

		if iter_35_1 == var_35_5 then
			var_35_3 = var_35_3 + 1
		end
	end

	return var_35_4, var_35_3
end

function BattleSummon:getEventHurtNum()
	local var_36_0, var_36_1, var_36_2 = self:getKeyFrameNum("hurt")

	if var_36_0 > 0 then
		return var_36_0, var_36_1, var_36_2
	end

	local var_36_3 = 0
	local var_36_4 = 0
	local var_36_5 = 9999
	local var_36_6 = 0
	local var_36_7 = 9999

	for iter_36_0, iter_36_1 in pairs(self._spine:getEventNames() or {}) do
		if string.match(iter_36_1, "hurt") then
			var_36_4 = var_36_4 + 1

			if iter_36_0 < var_36_5 then
				var_36_5 = iter_36_0
			end

			if var_36_6 < iter_36_0 then
				var_36_6 = iter_36_0
			end
		end

		if iter_36_1 == "finish" then
			var_36_7 = math.min(var_36_7, iter_36_0)
		end

		if iter_36_1 == "hurt1" or iter_36_1 == "hurt" or iter_36_1 == "hurt_1" then
			var_36_3 = var_36_3 + 1
		end
	end

	return var_36_4, var_36_3, math.min(var_36_6, var_36_7) - var_36_5
end

function BattleSummon:getKeyFrameNum(arg_37_1, arg_37_2)
	if not self._actionData then
		return 0, 0, 1
	end

	arg_37_2 = arg_37_2 or 1

	if not self._actionData[arg_37_2].keyFrames then
		return 0, 0, 1
	end

	local var_37_0 = 0
	local var_37_1 = 9999
	local var_37_2 = 0

	for iter_37_0, iter_37_1 in ipairs(self._actionData[arg_37_2].keyFrames) do
		local var_37_3
		local var_37_4

		if type(self._actionData[arg_37_2].keyFrames[iter_37_0]) == "table" then
			var_37_3 = self._actionData[arg_37_2].keyFrames[iter_37_0].t or self._actionData[arg_37_2].keyFrames[iter_37_0].type
			var_37_4 = self._actionData[arg_37_2].keyFrames[iter_37_0].f or self._actionData[arg_37_2].keyFrames[iter_37_0].frame
		else
			var_37_3 = "hit"
			var_37_4 = self._actionData[arg_37_2].keyFrames[iter_37_0]
		end

		if var_37_3 == arg_37_1 then
			var_37_0 = var_37_0 + 1

			if var_37_4 < var_37_1 then
				var_37_1 = var_37_4
			end

			if var_37_2 < var_37_4 then
				var_37_2 = var_37_4
			end
		end
	end

	return var_37_0, var_37_0, var_37_2 - var_37_1
end

function BattleSummon:getSkin()
	return 0
end

function BattleSummon:isBigBoss()
	return false
end

function BattleSummon:isGoingDead()
	return false
end

function BattleSummon:getSerialId()
	if self._data then
		return self._data.serial_id
	end

	return 0
end

function BattleSummon:getCfgId()
	return self._id
end

function BattleSummon:hasData()
	return checkbool(self._data)
end

function BattleSummon:reset()
	local var_44_0 = self:getInitPosition()

	self:setPosition(var_44_0.x, var_44_0.y)
	self:playDefaultAction()
	self:resetToOrder()
	self._nodeRoot:setOpacity(255)
end

function BattleSummon:clear()
	self._data = nil

	self._nodeEffectUp1:removeAllChildren(true)
	self._nodeEffectUp2:removeAllChildren(true)
	self._nodeEffectDown1:removeAllChildren(true)
	self._nodeEffectDown2:removeAllChildren(true)
	self._nodeEffectDown3:removeAllChildren(true)
end

function BattleSummon:cleanCache()
	self:clear()
end

function BattleSummon:getEventRecoverNum()
	local var_47_0 = 0

	for iter_47_0, iter_47_1 in pairs(self._spine:getEventNames() or {}) do
		if string.match(iter_47_1, "recover") then
			var_47_0 = var_47_0 + 1
		end
	end

	return var_47_0
end

function BattleSummon:getEventHealNum()
	local var_48_0 = 0
	local var_48_1 = ""

	for iter_48_0, iter_48_1 in pairs(self._spine:getEventNames() or {}) do
		if string.match(iter_48_1, "heal") then
			var_48_0 = var_48_0 + 1

			if var_48_1 == "" then
				var_48_1 = iter_48_1
			end
		end
	end

	return var_48_0
end

return BattleSummon
