local CommonKnight = require("app.view.common.CommonKnight")
local BattlePath = require("app.view.battle.BattlePath")
local var_0_2 = g.core.const.ConstMgr.SpineConst
local var_0_3 = g.core.config.knight_info
local BattleEffect = require("app.view.battle.BattleEffect")
local MysteryBossMapPosComp = class("MysteryBossMapPosComp", require("app.fairyGUI.mystery.UI_MysteryBossMapPosComp"))

function MysteryBossMapPosComp:ctor()
	self._player = nil
	self._effects = {}
	self._effectsData = {}
end

function MysteryBossMapPosComp:updateMapPosInfo(arg_2_1, arg_2_2)
	if arg_2_1 then
		local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.user_id)

		if var_2_0 then
			self._userSnap = var_2_0

			local var_2_1, var_2_2 = g.core.common.GlobalFunc.checkAndGetRobotData(var_2_0)
			local var_2_3 = not var_2_1 and g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(self._userSnap) or {
				snapshot = var_2_0
			}

			var_2_3.showMainRole = true
			self._player = CommonKnight.new(var_2_3)

			self.m_placeHolderComp:removeChildren()
			self.m_placeHolderComp:addChild(self._player)
			self.m_emptyPosController:setSelectedIndex(0)
			self:_initEffectAttackGroup()
		end
	else
		self._player = nil

		self:destroyEntry()
		self.m_placeHolderComp:removeChildren()
		self.m_emptyPosController:setSelectedIndex(1)
	end

	if self.m_isWaitPosController then
		self.m_isWaitPosController:setSelectedIndex(arg_2_2 == 0 and 1 or 0)
	end
end

function MysteryBossMapPosComp:playAction(arg_3_1)
	if self._player then
		self._player:playAction(arg_3_1)

		if arg_3_1 == var_0_2.ACTION.ATTACK and not self._scheduler then
			self._scheduler = self:newSchedule(handler(self, self.onUpdate), 0.03333333333333333)

			self:gotoFrame(0)
		end
	end
end

function MysteryBossMapPosComp:_initEffectAttackGroup()
	if self._isInit == true then
		return
	end

	self._isInit = true
	self._groupName = string.format("%d_attack_group", self:getKnightSex() == 0 and 200000 or 210000)

	local var_4_0 = json.decodeFileIfExists((BattlePath.getSpineEffectGroupPath(self._groupName)))

	if not var_4_0 or type(var_4_0) ~= "table" then
		self:destroyEntry()

		return
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		self:addEffect(iter_4_1)
	end

	self:getMaxFrame()
	self:gotoFrame(0)
end

function MysteryBossMapPosComp:addEffect(arg_5_1)
	if not arg_5_1.desc then
		return
	end

	self._effectsData[arg_5_1.desc] = arg_5_1

	local var_5_0 = arg_5_1.name
	local var_5_1

	if not arg_5_1.name then
		do return end

		var_5_1 = nil
	end

	if not arg_5_1.type or arg_5_1.type == 1 then
		local var_5_2 = BattleEffect.new({
			isReverse = false,
			resId = var_5_0
		})
		local var_5_3 = {}

		var_5_3.x = arg_5_1.x or 0
		var_5_3.y = arg_5_1.y or 0

		var_5_2:setPosition(var_5_3)

		if arg_5_1.desc == "actorMin2" then
			self.m_placeDown2:addNode(var_5_2)
		elseif arg_5_1.desc == "actorMin1" then
			self.m_placeDown1:addNode(var_5_2)
		elseif arg_5_1.desc == "actorAdd1" then
			self.m_placeUp2:addNode(var_5_2)
		elseif arg_5_1.desc == "actorAdd2" then
			self.m_placeUp2:addNode(var_5_2, 100)
		else
			self.m_placeUp1:addNode(var_5_2)
		end

		self._effects[arg_5_1.desc] = var_5_2
	end
end

function MysteryBossMapPosComp:getMaxFrame()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(self._effects) do
		local var_6_1 = self._effectsData[iter_6_0].startFrame or 0
		local var_6_2 = 0

		self._effectsData[iter_6_0].type = self._effectsData[iter_6_0].type or 1

		if self._effectsData[iter_6_0].type == 1 then
			var_6_2 = iter_6_1:getAnimationDuration() / 0.03333333333333333
		elseif self._effectsData[iter_6_0].type == 2 then
			var_6_2 = iter_6_1:getTotalFrame()
		end

		var_6_0 = math.max(var_6_1 + var_6_2, var_6_0)
	end

	self._indexMax = var_6_0 + 1

	return var_6_0
end

function MysteryBossMapPosComp:onUpdate()
	if tolua.isnull(self._player) then
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

function MysteryBossMapPosComp:gotoFrame(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self._effects) do
		local var_8_0 = self._effectsData[iter_8_0]
		local var_8_1 = 0
		local var_8_2 = not self._effectsData[iter_8_0].type or var_8_0.type == 1

		if not self._effectsData[iter_8_0].type or var_8_0.type == 1 then
			if tolua.isnull(iter_8_1) then
				self._index = self._indexMax

				return
			end

			iter_8_1:resume()

			var_8_1 = iter_8_1:getAnimationDuration()
		end

		local var_8_3 = true
		local var_8_4 = (arg_8_1 - var_8_0.startFrame) * 0.03333333333333333

		if (arg_8_1 - var_8_0.startFrame) * 0.03333333333333333 < 0 then
			var_8_3 = false
			var_8_4 = 0
		end

		if var_8_1 < var_8_4 then
			var_8_3 = false
			var_8_4 = var_8_1
		end

		iter_8_1:setVisible(var_8_3)

		local var_8_5 = (arg_8_1 - var_8_0.startFrame) * 0.03333333333333333

		if (arg_8_1 - var_8_0.startFrame) * 0.03333333333333333 < 0 then
			var_8_5 = 0
		end

		if var_8_1 < var_8_5 then
			var_8_5 = var_8_1
		end

		if var_8_4 <= var_8_5 then
			if var_8_2 then
				iter_8_1:play(var_8_4, var_8_5)
			end
		else
			assert(var_8_4, "Spine播放值设置错误！！！")
		end
	end

	self._index = arg_8_1
end

function MysteryBossMapPosComp:getKnightSex()
	if not self._userSnap then
		return nil
	end

	local var_9_0 = var_0_3.get(self._userSnap.base_id)

	if not var_9_0 then
		return nil
	end

	return var_9_0.sex
end

function MysteryBossMapPosComp:destroyEntry()
	for iter_10_0, iter_10_1 in pairs(self._effects) do
		if not self._effectsData[iter_10_0].type or self._effectsData[iter_10_0].type == 1 then
			self._effects[iter_10_0]:clear()
			self._effects[iter_10_0]:removeFromParent()
		end
	end

	self._effects = {}
	self._effectsData = {}
	self._index = 0
	self._indexMax = 0
	self._groupName = nil
	self._isInit = false
end

function MysteryBossMapPosComp:cancelUpdateSchedule()
	if self._scheduler then
		self:cancelSchedule(self._scheduler)

		self._scheduler = nil
	end
end

return MysteryBossMapPosComp
