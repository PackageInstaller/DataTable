local BattleEffect = require("app.view.battle.BattleEffect")
local BattlePath = require("app.view.battle.BattlePath")
local BattleUtils = require("app.view.battle.BattleUtils")
local AtkEffectEntry = class("AtkEffectEntry", require("app.view.battle.entry.Entry"))

function AtkEffectEntry:ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._groupName = arg_1_1
	self._battleLayer = arg_1_3
	self._actor = arg_1_2
	self._oldMovieSpeed = 1
	self._oldIsPaused = false
	self._skillData = arg_1_4
	self._nodeRoot = cc.Node:create()

	self._nodeRoot:retain()

	self._effects = {}
	self._effectsData = {}
	self._index = 0
	self._indexMax = 0
	self._isIdle = true
	self._bottomSpineFullScreenCenter = false
	self._shakeData = {
		isNew = false,
		name = "shake"
	}
	self._shakeExtData = {
		isNew = false,
		name = "shakeExt"
	}

	self._battleLayer:setPreActionFrames("attack", 0)
	AtkEffectEntry.super.ctor(self)
end

function AtkEffectEntry:getNodeRoot()
	return self._nodeRoot
end

function AtkEffectEntry:initEntry()
	AtkEffectEntry.super.initEntry(self)

	self._isInit = false
	self._isDone = false

	self.addEntryToQueue(self, self, self._step)
end

function AtkEffectEntry:_init()
	if self._isInit == true then
		return
	end

	self._isInit = true

	local var_4_0 = json.decodeFileIfExists((BattlePath.getSpineEffectGroupPath(self._groupName)))

	if self._groupName == "600090_skill_group" then
		self._bottomSpineFullScreenCenter = true
	end

	if not var_4_0 or type(var_4_0) ~= "table" then
		self._isDone = true

		self:destroyEntry()

		return
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		self:addEffect(iter_4_1)
	end

	self:getMaxFrame()
	self:gotoFrame(0)
end

function AtkEffectEntry:addEffect(arg_5_1)
	if not arg_5_1.desc then
		return
	end

	self._effectsData[arg_5_1.desc] = arg_5_1

	local var_5_0 = arg_5_1.name

	if not arg_5_1.name then
		return
	end

	local var_5_1 = arg_5_1.isFullScreen and self._actor:getIdentity() == 2
	local var_5_2
	local var_5_3 = {}
	local var_5_4 = not arg_5_1.type or arg_5_1.type == 1

	if not arg_5_1.type or arg_5_1.type == 1 then
		var_5_2 = BattleEffect.new({
			resId = var_5_0,
			isReverse = var_5_1
		})

		local var_5_5 = {}

		var_5_5.x = arg_5_1.x or 0
		var_5_5.y = arg_5_1.y or 0

		var_5_2:setPosition(var_5_5)
	else
		local var_5_6 = 1

		if not arg_5_1.isFullScreen and arg_5_1.x and arg_5_1.x ~= 0 and self._actor:getIdentity() == 2 then
			var_5_6 = -1
		end

		local var_5_7
		local var_5_8

		if arg_5_1.desc == "bottom" or arg_5_1.desc == "top" then
			var_5_7 = display.width / 2 + var_5_6 * (arg_5_1.x or 0)
			var_5_8 = display.height / 2 + (arg_5_1.y or 0)
		else
			var_5_7 = arg_5_1.x
			var_5_8 = arg_5_1.y or 0
		end

		var_5_3.movieName = var_5_0
		var_5_3.x = var_5_7
		var_5_3.y = var_5_8
		var_5_3.isReverse = var_5_1
	end

	local var_5_9 = self._battleLayer:getCamera()

	if self._actor then
		if arg_5_1.desc == "bottom" then
			if var_5_4 then
				if arg_5_1.isFullScreen then
					if self._bottomSpineFullScreenCenter then
						var_5_9:addToNodeScreenDown(var_5_2)
						var_5_2:setPosition({
							x = display.cx,
							y = display.cy
						})
					else
						var_5_9:addToNodeScreenDown(var_5_2)

						local var_5_10 = BattleUtils.getLocation(self._actor:getIdentity(), 2)
						local var_5_11 = {}

						var_5_11.x = (var_5_10.x + BattleUtils.getLocation(self._actor:getIdentity(), 5).x) / 2 + (arg_5_1.x or 0)
						var_5_11.y = var_5_10.y + (arg_5_1.y or 0)

						var_5_2:setPosition(var_5_11)
					end
				else
					self._actor._nodeEffectDown2:addChild(var_5_2)
				end
			else
				var_5_3.isBottom = true
				var_5_3.zorder = var_5_3.isTextZorder and -3 or 1
				var_5_3.fullScreenState = arg_5_1.isFullScreen and 1 or 0
				var_5_3.isReverse = self._actor:getIdentity() == 2
				var_5_2 = var_5_9:addTopUniteMovie(var_5_3)
			end
		elseif arg_5_1.desc == "actorMin2" then
			if var_5_4 then
				self._actor._nodeEffectDown3:addChild(var_5_2)
			else
				var_5_3.zorder = var_5_3.isTextZorder and -2 or 1
				var_5_3.zorderName = "_node" .. arg_5_1.desc:gsub("^%l", string.upper)
				var_5_2 = self._actor:addAttackEffectMovie(var_5_3)
			end
		elseif arg_5_1.desc == "actorMin1" then
			if var_5_4 then
				self._actor._nodeEffectDown1:addChild(var_5_2)
			else
				var_5_3.zorder = var_5_3.isTextZorder and -1 or 1
				var_5_3.zorderName = "_node" .. arg_5_1.desc:gsub("^%l", string.upper)
				var_5_2 = self._actor:addAttackEffectMovie(var_5_3)
			end
		elseif arg_5_1.desc == "actor" then
			if var_5_4 then
				self._actor:getBones():getNodeForSlot(self._effectsData.main.anim .. "_slot"):addChild(var_5_2)
			else
				var_5_3.zorder = var_5_3.isTextZorder and 0 or 1
				var_5_3.zorderName = "_node" .. arg_5_1.desc:gsub("^%l", string.upper)
				var_5_2 = self._actor:addAttackEffectMovie(var_5_3)
			end
		elseif arg_5_1.desc == "actorAdd1" then
			if var_5_4 then
				self._actor._nodeEffectUp2:addChild(var_5_2)
			else
				var_5_3.zorder = var_5_3.isTextZorder and 1 or 1
				var_5_3.zorderName = "_node" .. arg_5_1.desc:gsub("^%l", string.upper)
				var_5_2 = self._actor:addAttackEffectMovie(var_5_3)
			end
		elseif arg_5_1.desc == "actorAdd2" then
			if var_5_4 then
				self._actor._nodeEffectUp2:addChild(var_5_2, 100)
			else
				var_5_3.zorder = var_5_3.isTextZorder and 2 or 1
				var_5_3.zorderName = "_node" .. arg_5_1.desc:gsub("^%l", string.upper)
				var_5_2 = self._actor:addAttackEffectMovie(var_5_3)
			end
		elseif arg_5_1.desc == "top" then
			if var_5_4 then
				if arg_5_1.isFullScreen then
					var_5_9:addToNodeScreenUp(var_5_2)

					local var_5_12 = BattleUtils.getLocation(self._actor:getIdentity(), 2)
					local var_5_13 = {}

					var_5_13.x = (var_5_12.x + BattleUtils.getLocation(self._actor:getIdentity(), 5).x) / 2 + (arg_5_1.x or 0)
					var_5_13.y = var_5_12.y + (arg_5_1.y or 0)

					var_5_2:setPosition(var_5_13)
				else
					self._actor._nodeEffectUp1:addChild(var_5_2)
				end
			else
				var_5_3.zorder = var_5_3.isTextZorder and 3 or 1
				var_5_3.fullScreenState = arg_5_1.isFullScreen and 1 or 0
				var_5_3.isReverse = self._actor:getIdentity() == 2
				var_5_2 = var_5_9:addTopUniteMovie(var_5_3)
			end
		end
	else
		self._nodeRoot:addChild(var_5_2)
	end

	g.core.common.Scheduler:newScheduleOnce(function(arg_6_0)
		if var_5_4 and var_5_2 and var_5_2.isSpineRemoved and not var_5_2:isSpineRemoved() then
			var_5_2:pause()
		end
	end, 0)

	self._effects[arg_5_1.desc] = var_5_2
end

function AtkEffectEntry:getMaxFrame()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(self._effects) do
		local var_7_1 = self._effectsData[iter_7_0].startFrame or 0
		local var_7_2 = 0

		self._effectsData[iter_7_0].type = self._effectsData[iter_7_0].type or 1

		if self._effectsData[iter_7_0].type == 1 then
			var_7_2 = iter_7_1:getAnimationDuration() / 0.03333333333333333
		elseif self._effectsData[iter_7_0].type == 2 then
			var_7_2 = iter_7_1:getTotalFrame()
		end

		var_7_0 = math.max(var_7_1 + var_7_2, var_7_0)
	end

	self._indexMax = var_7_0

	return var_7_0
end

function AtkEffectEntry:gotoFrame(arg_8_1)
	self:_checkPlaySpeed()
	self:_checkPlayPause()

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
		else
			var_8_1 = iter_8_1:getTotalTime() / 1000
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

	if self._effectsData.SFX then
		for iter_8_2, iter_8_3 in ipairs(self._effectsData.SFX.keyFrames) do
			if iter_8_3.data and iter_8_3.f == arg_8_1 then
				g.core.sound.SoundManager:playSound(iter_8_3.data.sfx)

				break
			end
		end
	end

	local var_8_6 = self._effectsData.CG
	local var_8_7 = true

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_CG) then
		local var_8_8 = g.core.common.Setting:getValue(g.core.common.Setting.SKIP_CG) or 0

		if var_8_8 == 0 then
			if not g.core.common.Setting:isCGFirstData(string.split(self._groupName, "_")[1]) then
				var_8_7 = false
			end
		elseif var_8_8 == 1 then
			var_8_7 = false
		end
	end

	if var_8_6 and (g.core.model.User.homeData:getCensorListById(tonumber(string.split(self._groupName, "_")[1]), 2) or nil) and false then
		for iter_8_4, iter_8_5 in ipairs(var_8_6.keyFrames) do
			if iter_8_5.data and iter_8_5.f == arg_8_1 then
				iter_8_5.data.isReverse = self._actor:getIdentity() ~= 1

				self._battleLayer:addCriSpriteToNode(iter_8_5.data, {
					actor = self._actor,
					skillCfg = self._skillData,
					memberId = self._actor:getMemberId()
				})

				break
			end
		end
	end

	self._index = arg_8_1
end

function AtkEffectEntry:_step()
	self:_init()

	if tolua.isnull(self._actor) then
		self._index = self._indexMax
		self._isDone = true

		return self._isDone
	end

	self._battleLayer:setPreActionFrames("attack", self._indexMax - (self._index + 1))

	if self._index + 1 > self._indexMax then
		self._isDone = true
	else
		self:gotoFrame(self._index + 1)
	end

	return self._isDone
end

function AtkEffectEntry:_checkPlayPause()
	local var_10_0 = self._battleLayer:isCurPaused()

	if var_10_0 == self._oldIsPaused then
		return
	end

	for iter_10_0, iter_10_1 in pairs(self._effects) do
		if not (not self._effectsData[iter_10_0].type or self._effectsData[iter_10_0].type == 1) then
			iter_10_1:pause(var_10_0)
		end
	end

	self._oldIsPaused = var_10_0
end

function AtkEffectEntry:_checkPlaySpeed()
	local var_11_0 = self._battleLayer:getCurSpeed()

	if var_11_0 == self._oldMovieSpeed then
		return
	end

	for iter_11_0, iter_11_1 in pairs(self._effects) do
		local var_11_1 = self._effectsData[iter_11_0]

		if not (not self._effectsData[iter_11_0].type or var_11_1.type == 1) then
			if var_11_0 == 1.6 and var_11_1.name == "600030_1334x750_4333" then
				iter_11_1:setPlaySpeed(1.58)
			else
				iter_11_1:setPlaySpeed(var_11_0)
			end
		end
	end

	self._oldMovieSpeed = var_11_0
end

function AtkEffectEntry:destroyEntry()
	AtkEffectEntry.super.destroyEntry(self)

	local var_12_0 = self._battleLayer:getCamera()

	for iter_12_0, iter_12_1 in pairs(self._effects) do
		if not self._effectsData[iter_12_0].type or self._effectsData[iter_12_0].type == 1 then
			if not tolua.isnull(self._effects[iter_12_0]) then
				self._effects[iter_12_0]:clear()
				self._effects[iter_12_0]:removeFromParent()
			end
		elseif not tolua.isnull(self._effects[iter_12_0]) then
			self._effects[iter_12_0]:dispose()
		end
	end

	if self._nodeRoot ~= nil and not tolua.isnull(self._nodeRoot) then
		self._nodeRoot:release()

		if not tolua.isnull(self._nodeRoot) then
			self._nodeRoot:removeFromParent(true)
		end
	end

	if (g.core.common.Setting:getValue(g.core.common.Setting.SKIP_CG) or 0) == 0 and string.split(self._groupName, "_")[1] and string.split(self._groupName, "_")[2] and string.split(self._groupName, "_")[2] == "skill" then
		g.core.common.Setting:setCGFirstData(string.split(self._groupName, "_")[1])
	end

	self._effects = {}
	self._effectsData = {}
	self._index = 0
	self._indexMax = 0
	self._isIdle = true
	self._nodeRoot = nil
	self._groupName = nil
	self._actor = nil
end

return AtkEffectEntry
