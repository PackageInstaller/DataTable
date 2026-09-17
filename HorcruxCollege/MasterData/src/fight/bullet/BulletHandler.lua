local var_0_1 = table.insert
local var_0_2 = table.remove
local audio_manager = require("controller.audio_manager")
local FightUIElementsManager = require("fight.FightUIElementsManager")

local function var_0_5(arg_1_0, arg_1_1)
	if arg_1_1 then
		if arg_1_0:doSequence(arg_1_1) then
			arg_1_0:setHitted(false)
			arg_1_0._movingMgr:init(arg_1_0.info.finalpos, arg_1_0)
			arg_1_0:switchDirection()

			if arg_1_0.info.movingani then
				arg_1_0:play(arg_1_0.info.movingani)
			end

			arg_1_0.yield = false
		else
			arg_1_0:destroy(true)
		end
	else
		arg_1_0:destroy(true)
	end
end

local function var_0_6(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1.sound then
		if type(arg_2_1.sound) == "string" then
			audio_manager:playFightEffect(arg_2_1.sound, nil, FightManager.getBossSpeedUp())
		elseif type(arg_2_1.sound) == "table" then
			audio_manager:playFightEffect(arg_2_1.sound[1], arg_2_1.sound[2], FightManager.getBossSpeedUp())
		end
	end

	if arg_2_1.shake then
		FightUIElementsManager.getCamera().shake(arg_2_1.shake, arg_2_1.shake.period, arg_2_1.shake.time)
	end

	if arg_2_1.effect then
		arg_2_2.effect = {}

		local var_2_0 = arg_2_0:getRelativeDir(arg_2_2.assigned_target)

		for iter_2_0, iter_2_1 in pairs(arg_2_1.effect) do
			if iter_2_1.object == "self" then
				arg_2_0.character:playEffect(iter_2_1.name, iter_2_1.ani, iter_2_1.offsetX, iter_2_1.offsetY, iter_2_1.offsetZ)
			else
				var_0_1(arg_2_2.effect, {
					name = iter_2_1.name,
					ani = iter_2_1.ani,
					offsetX = iter_2_1.offsetX,
					offsetY = iter_2_1.offsetY,
					offsetZ = iter_2_1.offsetZ,
					direction = var_2_0
				})
			end
		end
	end

	if arg_2_1.force then
		arg_2_2.force = {}

		for iter_2_2, iter_2_3 in pairs(arg_2_1.force) do
			if iter_2_3.object == "self" then
				arg_2_0.character:playForce(iter_2_3.distance, arg_2_0:getDirection(), iter_2_3.time, false)
			else
				var_0_1(arg_2_2.force, {
					distance = iter_2_3.distance,
					time = iter_2_3.time,
					shutdown = iter_2_3.shutdown
				})
			end
		end
	end

	if arg_2_1.forceY then
		if arg_2_1.forceY[1] then
			arg_2_2.forceY = {}

			for iter_2_4, iter_2_5 in ipairs(arg_2_1.forceY) do
				var_0_1(arg_2_2.forceY, {
					distance = iter_2_5.distance,
					time = iter_2_5.time,
					speed = iter_2_5.speed,
					shutdown = iter_2_5.shutdown
				})
			end
		else
			arg_2_2.forceY = {
				{
					distance = arg_2_1.forceY.distance,
					time = arg_2_1.forceY.time,
					speed = arg_2_1.forceY.speed,
					shutdown = arg_2_1.forceY.shutdown
				}
			}
		end
	end

	if arg_2_1.behitted then
		arg_2_2.behitted = arg_2_1.behitted
	end

	arg_2_2.id = arg_2_1.id

	FightManager.runSkill(arg_2_0.character, arg_2_2)
end

local var_0_7 = 1
local var_0_9 = 3
local var_0_10 = 4

function BulletSprite.initBulletHandlers(arg_3_0)
	arg_3_0.handlerQueue = {}
	arg_3_0.attackHandler = var_0_6
	arg_3_0.skillcompleteHandler = var_0_5
end

function BulletSprite:pushInAttackHandler(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == 0 then
		self:attackHandler(arg_4_2, arg_4_3)
	else
		var_0_1(self.handlerQueue, {
			time = arg_4_1,
			handlertype = var_0_7,
			data = {
				arg_4_2,
				arg_4_3
			}
		})
	end
end

function BulletSprite:pushInSkillCompleteHandler(arg_5_1, arg_5_2)
	var_0_1(self.handlerQueue, {
		time = arg_5_1,
		handlertype = var_0_9,
		data = {
			arg_5_2
		}
	})
end

function BulletSprite:pushInBulletDestroyHandler(arg_6_1)
	var_0_1(self.handlerQueue, {
		time = arg_6_1,
		handlertype = var_0_10
	})
end

function BulletSprite.cleanAllHandlers(arg_7_0)
	arg_7_0.handlerQueue = {}
end

function BulletSprite:executeHandler(arg_8_1, arg_8_2)
	if arg_8_1 == var_0_7 then
		self:attackHandler(arg_8_2[1], arg_8_2[2])
	elseif arg_8_1 == var_0_9 then
		self:skillcompleteHandler(arg_8_2[1])
	elseif arg_8_1 == var_0_10 then
		self:destroy()
	end
end

function BulletSprite:updateBulletHandlers(arg_9_1)
	while self.handlerQueue[1] do
		self.handlerQueue[1].time = self.handlerQueue[1].time - arg_9_1

		local var_9_0

		if self.handlerQueue[1].time <= 0 then
			self:executeHandler(self.handlerQueue[1].handlertype, self.handlerQueue[1].data)
			var_0_2(self.handlerQueue, 1)
		else
			var_9_0 = 1 + 1
		end
	end
end
