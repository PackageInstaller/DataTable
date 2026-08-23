local var_0_0 = g.core.const.ConstMgr.MysteryBossConst
local var_0_1 = g.core.const.ConstMgr.SpineConst
local SpineBase = require("app.view.common.SpineBase")
local BattlePath = require("app.view.battle.BattlePath")
local BattleEffect = require("app.view.battle.BattleEffect")
local CommonKnight = require("app.view.common.CommonKnight")
local MysteryBossMapComp = class("MysteryBossMapComp", require("app.fairyGUI.mystery.UI_MysteryBossMapComp"))

function MysteryBossMapComp:ctor()
	self._isBossHit = false
	self._isBossAttack = false
	self._bossModel = nil
	self._attackSchedule = nil
	self._effects = {}
	self._effectsData = {}
	self._index = 0
	self._indexMax = 0
	self._isInit = false
end

function MysteryBossMapComp:updateMapInfo(arg_2_1)
	self._boss = arg_2_1
	self._bossType = self._boss:getBossType()
	self._posCount = var_0_0.NORMAL_POS_NUM
	self._compStr = self._bossType == var_0_0.BOSS_TYPE.LIMIT and "m_mapLimitPos" or "m_mapPos"

	if self._bossType == var_0_0.BOSS_TYPE.LIMIT then
		self._posCount = var_0_0.LIMIT_POS_NUM

		self.m_bossTypeController:setSelectedIndex(1)
	else
		self.m_bossTypeController:setSelectedIndex(0)
	end

	for iter_2_0 = 0, self._posCount do
		self[self._compStr .. iter_2_0]:updateMapPosInfo(self._boss:getBossUserDataByPos(iter_2_0), iter_2_0)
	end

	if self._boss:getBossAlive() and not self._bossModel then
		local var_2_0 = self._boss:getBossMonsterInfo()
		local var_2_1 = var_2_0 and var_2_0.res_id

		if var_2_0 and var_2_0.res_id then
			self._bossModel = CommonKnight.new({
				resId = var_2_1
			})

			self.m_bossPlaceHolderComp:addChild(self._bossModel)
			self:_initBossEffAttackGroup()

			self._attackSchedule = self._attackSchedule or self:newSchedule(handler(self, self.playBossAttackAction), 12)
		end
	end
end

function MysteryBossMapComp:playUserAction(arg_3_1, arg_3_2)
	if self[(self._bossType == var_0_0.BOSS_TYPE.LIMIT and "m_mapLimitPos" or "m_mapPos") .. arg_3_1] then
		self[(self._bossType == var_0_0.BOSS_TYPE.LIMIT and "m_mapLimitPos" or "m_mapPos") .. arg_3_1]:playAction(arg_3_2)
	end
end

function MysteryBossMapComp:playBossHitAction(arg_4_1)
	if self._bossModel and not self._isBossHit and not self._isBossAttack then
		self._isBossHit = true

		self._bossModel:playAction(var_0_1.ACTION.HIT, handler(self, self._resetHitState))
	end

	if arg_4_1 and arg_4_1 > 0 then
		self._damgeNum = arg_4_1

		self:_updatePureNumberView()
	end
end

function MysteryBossMapComp:_resetHitState()
	self._isBossHit = false
end

function MysteryBossMapComp:_createPureNumberView()
	local var_6_0 = cc.Node:create()

	var_6_0:setCascadeOpacityEnabled(true)

	local var_6_1 = cc.Label:createWithBMFont("font/putongshanghai.fnt", g.core.utils.Number.transTextNumFormation(self._damgeNum))

	if var_6_1 then
		var_6_1:setAdditionalKerning(-16)
		var_6_0:addChild(var_6_1)
	end

	return var_6_0
end

function MysteryBossMapComp:_updatePureNumberView()
	local var_7_0 = {}

	var_7_0.resId = "battletxt_damage"
	var_7_0.isLoop = false
	var_7_0.path = BattlePath.getSpineTweenPath("battletxt_damage")
	var_7_0.anim = "play"
	var_7_0.isReverse = true

	local var_7_1 = SpineBase.new(var_7_0)

	var_7_1:addNodesAtSlots({
		{
			slotStr = "txt_slot",
			node = self:_createPureNumberView()
		}
	})
	self.m_bossEff:addNode(var_7_1)

	self._damgeNum = 0
end

function MysteryBossMapComp:playBossDeadAction()
	if self._bossModel then
		self._bossModel:playAction(var_0_1.ACTION.DEAD)
		self:newScheduleOnce(handler(self, self._removeSelf), 3)
	end
end

function MysteryBossMapComp:_removeSelf()
	self.m_bossPlaceHolderComp:removeChildren()

	self._bossModel = nil

	self:destroyEntry()
	self:dispatchCompEvent("SHOW_MYSTERYBOSS_RESULT")
end

function MysteryBossMapComp:playBossAttackAction()
	if self._bossModel then
		self._isBossAttack = true

		self._bossModel:playAction(var_0_1.ACTION.ATTACK)
		self:newScheduleOnce(handler(self, self._resetAttackState), 2)

		if not self._scheduler then
			self._scheduler = self:newSchedule(handler(self, self.onUpdate), 0.03333333333333333)

			self:gotoFrame(0)
		end
	end
end

function MysteryBossMapComp:_resetAttackState()
	self._isBossAttack = false

	for iter_11_0 = 0, self._posCount do
		self[self._compStr .. iter_11_0]:playAction(var_0_1.ACTION.HIT)
	end
end

function MysteryBossMapComp:_initBossEffAttackGroup()
	if self._isInit == true then
		return
	end

	self._isInit = true
	self._groupName = string.format("%d_attack_group", self._boss:getBossMonsterInfo().res_id)

	local var_12_0 = json.decodeFileIfExists((BattlePath.getSpineEffectGroupPath(self._groupName)))

	if not var_12_0 or type(var_12_0) ~= "table" then
		self:destroyEntry()

		return
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		self:addEffect(iter_12_1)
	end

	self:getMaxFrame()
	self:gotoFrame(0)
end

function MysteryBossMapComp:addEffect(arg_13_1)
	if not arg_13_1.desc then
		return
	end

	self._effectsData[arg_13_1.desc] = arg_13_1

	local var_13_0 = arg_13_1.name
	local var_13_1

	if not arg_13_1.name then
		do return end

		var_13_1 = nil
	end

	if not arg_13_1.type or arg_13_1.type == 1 then
		local var_13_2 = BattleEffect.new({
			isReverse = false,
			resId = var_13_0
		})
		local var_13_3 = {}

		var_13_3.x = arg_13_1.x or 0
		var_13_3.y = arg_13_1.y or 0

		var_13_2:setPosition(var_13_3)

		if arg_13_1.desc == "actorMin2" then
			self.m_placeDown2:addNode(var_13_2)
		elseif arg_13_1.desc == "actorMin1" then
			self.m_placeDown1:addNode(var_13_2)
		elseif arg_13_1.desc == "actorAdd1" then
			self.m_placeUp2:addNode(var_13_2)
		elseif arg_13_1.desc == "actorAdd2" then
			self.m_placeUp2:addNode(var_13_2, 100)
		else
			self.m_placeUp1:addNode(var_13_2)
		end

		self._effects[arg_13_1.desc] = var_13_2
	end
end

function MysteryBossMapComp:getMaxFrame()
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self._effects) do
		local var_14_1 = self._effectsData[iter_14_0].startFrame or 0
		local var_14_2 = 0

		self._effectsData[iter_14_0].type = self._effectsData[iter_14_0].type or 1

		if self._effectsData[iter_14_0].type == 1 then
			var_14_2 = iter_14_1:getAnimationDuration() / 0.03333333333333333
		elseif self._effectsData[iter_14_0].type == 2 then
			var_14_2 = iter_14_1:getTotalFrame()
		end

		var_14_0 = math.max(var_14_1 + var_14_2, var_14_0)
	end

	self._indexMax = var_14_0 + 1

	return var_14_0
end

function MysteryBossMapComp:onUpdate()
	if tolua.isnull(self._bossModel) then
		self:cancelUpdateSchedule()

		self._index = self._indexMax
		self._isDone = true

		return self._isDone
	end

	if self._index + 1 > self._indexMax then
		self._isDone = true

		self:cancelUpdateSchedule()
	else
		self:gotoFrame(self._index + 1)
	end

	return self._isDone
end

function MysteryBossMapComp:gotoFrame(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self._effects) do
		local var_16_0 = self._effectsData[iter_16_0]
		local var_16_1 = 0
		local var_16_2 = not self._effectsData[iter_16_0].type or var_16_0.type == 1

		if not self._effectsData[iter_16_0].type or var_16_0.type == 1 then
			if tolua.isnull(iter_16_1) then
				self._index = self._indexMax

				return
			end

			iter_16_1:resume()

			var_16_1 = iter_16_1:getAnimationDuration()
		end

		local var_16_3 = true
		local var_16_4 = (arg_16_1 - var_16_0.startFrame) * 0.03333333333333333

		if (arg_16_1 - var_16_0.startFrame) * 0.03333333333333333 < 0 then
			var_16_3 = false
			var_16_4 = 0
		end

		if var_16_1 < var_16_4 then
			var_16_3 = false
			var_16_4 = var_16_1
		end

		iter_16_1:setVisible(var_16_3)

		local var_16_5 = (arg_16_1 - var_16_0.startFrame) * 0.03333333333333333

		if (arg_16_1 - var_16_0.startFrame) * 0.03333333333333333 < 0 then
			var_16_5 = 0
		end

		if var_16_1 < var_16_5 then
			var_16_5 = var_16_1
		end

		if var_16_4 <= var_16_5 then
			if var_16_2 then
				iter_16_1:play(var_16_4, var_16_5)
			end
		else
			assert(var_16_4, "Spine播放值设置错误！！！")
		end
	end

	self._index = arg_16_1
end

function MysteryBossMapComp:destroyEntry()
	for iter_17_0, iter_17_1 in pairs(self._effects) do
		if not self._effectsData[iter_17_0].type or self._effectsData[iter_17_0].type == 1 then
			self._effects[iter_17_0]:clear()
			self._effects[iter_17_0]:removeFromParent()
		end
	end

	self._effects = {}
	self._effectsData = {}
	self._index = 0
	self._indexMax = 0
	self._groupName = nil
	self._isInit = false
end

function MysteryBossMapComp:cancelUpdateSchedule()
	if self._scheduler then
		self:cancelSchedule(self._scheduler)

		self._scheduler = nil
	end
end

function MysteryBossMapComp:onUnload()
	if self._attackSchedule then
		self:cancelSchedule(self._attackSchedule)

		self._attackSchedule = nil
	end
end

return MysteryBossMapComp
