local BattlePet = class("BattlePet", function()
	return cc.Node:create()
end)
local var_0_1 = g.core.config.pet_info
local var_0_2 = g.core.config.passive_skill_info
local BattleKnight = require("app.view.battle.BattleKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePath = require("app.view.battle.BattlePath")

function BattlePet:ctor(arg_2_1, arg_2_2, arg_2_3)
	self._identity = arg_2_1
	self._id = arg_2_2
	self._battleLayer = arg_2_3

	local var_2_0 = self._battleLayer:getCamera()
	local var_2_1 = var_0_1.get(arg_2_2)

	self._info = var_2_1
	self._resId = var_2_1.resource
	self._spineReady = nil
	self._spine = nil

	if var_2_1.passive_skill_1 > 0 then
		self._skill1 = var_0_2.get(var_2_1.passive_skill_1).passive_skill_value
	end

	if var_2_1.passive_skill_2 > 0 then
		self._skill2 = var_0_2.get(var_2_1.passive_skill_2).passive_skill_value
	end

	if var_2_1.passive_skill_3 > 0 then
		self._skill3 = var_0_2.get(var_2_1.passive_skill_3).passive_skill_value
	end

	if var_2_1.link_passive_skill_1 > 0 then
		self._belongSkill1 = var_0_2.get(var_2_1.link_passive_skill_1).passive_skill_value
	end

	if var_2_1.link_passive_skill_2 > 0 then
		self._belongSkill2 = var_0_2.get(var_2_1.link_passive_skill_2).passive_skill_value
	end

	if var_2_1.link_passive_skill_3 > 0 then
		self._belongSkill3 = var_0_2.get(var_2_1.link_passive_skill_3).passive_skill_value
	end

	self._nodeRoot = cc.Node:create():addTo(self)

	self._nodeRoot:setCascadeOpacityEnabled(true)
	self._nodeRoot:setCascadeColorEnabled(true)
	self:setCascadeOpacityEnabled(true)
	self:setCascadeColorEnabled(true)

	self._spine = BattleKnight.new({
		resId = self._resId,
		listener = handler(self, self._onSpineEvent)
	})

	self._nodeRoot:addChild(self._spine, 3)

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

	local var_2_2 = var_2_0:getCenter()

	self._pos = var_2_2

	self:setPosition(var_2_2.x, var_2_2.y)
	self._nodeEffectUp1:setPosition(var_2_2.x, var_2_2.y)
	self._nodeEffectUp2:setPosition(var_2_2.x, var_2_2.y)
	self._nodeEffectDown1:setPosition(var_2_2.x, var_2_2.y)
	self._nodeEffectDown2:setPosition(var_2_2.x, var_2_2.y)
	self._nodeEffectDown3:setPosition(var_2_2.x, var_2_2.y)
	self:updateDir()
end

function BattlePet:playAction(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0

	if string.find(arg_3_1, "skill") then
		var_3_0 = BattleConst.SPINE_ACTION_TYPE.SKILL

		if not self._actionName or self._actionName ~= arg_3_1 then
			self._actionData = json.decodeFileIfExists((BattlePath.getSpineEffectGroupPath(arg_3_1)))
			self._actionName = arg_3_1
		end
	end

	self._spine:setVisible(true)
	self._spine:setAnimation(0, var_3_0)
end

function BattlePet:setVisible(arg_4_1)
	self._spine:setVisible(arg_4_1)
end

function BattlePet:playReadyAction()
	self:playAction("action_pet" .. var_0_1.get(self._id).resource .. "_ready")
end

function BattlePet:getQuality()
	return self._info.quality
end

function BattlePet:_onSpineEvent(arg_7_1)
	local var_7_0 = arg_7_1.type

	if arg_7_1.eventData then
		var_7_0 = arg_7_1.eventData.name
	end

	if arg_7_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		if arg_7_1.animation == BattleConst.SPINE_ACTION_TYPE.BACK then
			return
		elseif arg_7_1.animation == BattleConst.SPINE_ACTION_TYPE.FLY then
			return
		elseif arg_7_1.animation == BattleConst.SPINE_ACTION_TYPE.FALL then
			return
		end
	end

	if self._actionCallback then
		if arg_7_1.type == BattleConst.SPINE_EVENT.COMPLETE then
			self._actionCallback("finish")
		else
			self._actionCallback(var_7_0)
		end
	end
end

function BattlePet:_update()
	return
end

function BattlePet:getMemberId()
	return 7
end

function BattlePet:setIdentity(arg_10_1)
	self._identity = arg_10_1

	self:updateDir()
end

function BattlePet:updateDir()
	local var_11_0 = 1

	if self._identity == 2 then
		var_11_0 = -1
	end

	self._spine:setScaleX(var_11_0)
	self._nodeEffectUp1:setScaleX(var_11_0)
	self._nodeEffectUp2:setScaleX(var_11_0)
	self._nodeEffectDown1:setScaleX(var_11_0)
	self._nodeEffectDown2:setScaleX(var_11_0)
	self._nodeEffectDown3:setScaleX(var_11_0)
end

function BattlePet:getBones()
	return self._spine
end

function BattlePet:getSpine()
	return self._spine
end

function BattlePet:addKnightActionMark(arg_14_1)
	self._actionMark = true
	self._cutActionCallback = arg_14_1
end

function BattlePet:getKnightActionMark()
	return self._actionMark
end

function BattlePet:resetActionMark()
	if self._actionMark and self._cutActionCallback then
		self._cutActionCallback(true)

		self._actionMark = false
		self._cutActionCallback = nil
	else
		self._actionMark = false
		self._cutActionCallback = nil
	end
end

function BattlePet:addKnightPosMark(arg_17_1)
	self._posMark = true
	self._resetPosCallback = arg_17_1
end

function BattlePet:getKnightPosMark()
	return self._posMark
end

function BattlePet:resetKnightPos()
	if self._posMark and self._resetPosCallback then
		self._resetPosCallback(true)

		self._posMark = false
		self._resetPosCallback = nil
	else
		self._posMark = false
		self._resetPosCallback = nil
	end
end

function BattlePet:getBaseKnightInfo()
	return self._info
end

function BattlePet:hasSkill(arg_21_1)
	if self._skill1 == arg_21_1 then
		return true
	end

	if self._skill2 == arg_21_1 then
		return true
	end

	if self._skill3 == arg_21_1 then
		return true
	end

	if self._belongSkill1 == arg_21_1 then
		return true
	end

	if self._belongSkill2 == arg_21_1 then
		return true
	end

	if self._belongSkill3 == arg_21_1 then
		return true
	end

	return false
end

function BattlePet:playDefaultAction()
	return
end

function BattlePet:getInitPosition()
	return self._pos
end

function BattlePet:getKnightInfo()
	return self._info
end

function BattlePet:getPlayInfoBySkillId(arg_25_1)
	local var_25_0 = self:getKnightInfo().advance_id
	local var_25_1 = g.core.config.play_info.get(arg_25_1, var_25_0, 0)

	assert(var_25_1, string.format("play_info can't find code = %d, skillId = %d", var_25_0, arg_25_1))

	return var_25_1
end

function BattlePet:getIdentity()
	return self._identity
end

function BattlePet:getLocationScale()
	return 1
end

function BattlePet:setToTopOrder()
	self:setLocalZOrder(120)
end

function BattlePet:resetToOrder()
	self:setLocalZOrder(100)
end

function BattlePet:follow()
	local var_30_0, var_30_1 = self:getPosition()

	self._nodeEffectDown1:setPosition(var_30_0, var_30_1)
	self._nodeEffectDown2:setPosition(var_30_0, var_30_1)
	self._nodeEffectDown3:setPosition(var_30_0, var_30_1)
	self._nodeEffectUp1:setPosition(var_30_0, var_30_1)
	self._nodeEffectUp2:setPosition(var_30_0, var_30_1)
end

function BattlePet:playRunAction()
	return
end

function BattlePet:getFrameCount()
	local var_32_0 = self._spine:getCurrentAnimationData()

	if var_32_0 then
		return (var_32_0:getMaxFrames())
	end

	return 0
end

function BattlePet:showHpBar(arg_33_1)
	return
end

function BattlePet:getKeyFrameNum(arg_34_1, arg_34_2)
	if not self._actionData then
		return 0, 0, 1
	end

	arg_34_2 = arg_34_2 or 1

	if not self._actionData[arg_34_2].keyFrames then
		return 0, 0, 1
	end

	local var_34_0 = 0
	local var_34_1 = 9999
	local var_34_2 = 0

	for iter_34_0, iter_34_1 in ipairs(self._actionData[arg_34_2].keyFrames) do
		local var_34_3
		local var_34_4

		if type(self._actionData[arg_34_2].keyFrames[iter_34_0]) == "table" then
			var_34_3 = self._actionData[arg_34_2].keyFrames[iter_34_0].t or self._actionData[arg_34_2].keyFrames[iter_34_0].type
			var_34_4 = self._actionData[arg_34_2].keyFrames[iter_34_0].f or self._actionData[arg_34_2].keyFrames[iter_34_0].frame
		else
			var_34_3 = "hit"
			var_34_4 = self._actionData[arg_34_2].keyFrames[iter_34_0]
		end

		if var_34_3 == arg_34_1 then
			var_34_0 = var_34_0 + 1

			if var_34_4 < var_34_1 then
				var_34_1 = var_34_4
			end

			if var_34_2 < var_34_4 then
				var_34_2 = var_34_4
			end
		end
	end

	return var_34_0, var_34_0, var_34_2 - var_34_1
end

function BattlePet:getEventHitNum()
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

function BattlePet:getEventHurtNum()
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

function BattlePet:getEventRecoverNum()
	local var_37_0 = 0

	for iter_37_0, iter_37_1 in pairs(self._spine:getEventNames() or {}) do
		if string.match(iter_37_1, "recover") then
			var_37_0 = var_37_0 + 1
		end
	end

	return var_37_0
end

function BattlePet:getEventHealNum()
	local var_38_0 = 0
	local var_38_1 = ""

	for iter_38_0, iter_38_1 in pairs(self._spine:getEventNames() or {}) do
		if string.match(iter_38_1, "heal") then
			var_38_0 = var_38_0 + 1

			if var_38_1 == "" then
				var_38_1 = iter_38_1
			end
		end
	end

	return var_38_0
end

function BattlePet:getSkin()
	return 0
end

function BattlePet:isBigBoss()
	return false
end

function BattlePet:isGoingDead()
	return false
end

function BattlePet:clear()
	if self._spine then
		-- block empty
	end

	self._nodeEffectUp1:removeAllChildren(true)
	self._nodeEffectUp2:removeAllChildren(true)
	self._nodeEffectDown1:removeAllChildren(true)
	self._nodeEffectDown2:removeAllChildren(true)
	self._nodeEffectDown3:removeAllChildren(true)
end

return BattlePet
