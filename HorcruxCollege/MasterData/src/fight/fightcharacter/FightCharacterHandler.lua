local var_0_2 = table.insert
local var_0_3 = table.remove
local attackhandler = require("fight.fighthandler.attackhandler")
local bullethandler = require("fight.fighthandler.bullethandler")
local skillstarthandler = require("fight.fighthandler.skillstarthandler")
local skillcompletehandler = require("fight.fighthandler.skillcompletehandler")
local playerwinhandler = require("fight.fighthandler.playerwinhandler")
local playerdiehandler = require("fight.fighthandler.playerdiehandler")
local monsterdiehandler = require("fight.fighthandler.monsterdiehandler")
local revivalhandler = require("fight.fighthandler.revivalhandler")

local function var_0_12(arg_1_0)
	arg_1_0.logic:reset()
end

local function var_0_13(arg_2_0, arg_2_1)
	arg_2_0:dieAction(arg_2_1)
end

local function var_0_14(arg_3_0)
	arg_3_0.logic:updateFight("dowait")
end

local function var_0_15(arg_4_0)
	arg_4_0:pushInResetHandler()
end

local function var_0_16(arg_5_0)
	arg_5_0._lock = false
end

local var_0_17 = 1
local var_0_18 = 2
local var_0_19 = 3
local var_0_20 = 4
local var_0_21 = 5
local var_0_22 = 6
local var_0_23 = 7
local var_0_24 = 8
local var_0_25 = 9
local var_0_26 = 10
local var_0_27 = 11

function FightCharacter.initFightHandlers(arg_6_0)
	arg_6_0.handlerQueue = {
		reset = false,
		fight = {},
		callfuncs = {}
	}
	arg_6_0.fightresetHandler = var_0_12
	arg_6_0.attackHandler = attackhandler
	arg_6_0.bulletHandler = bullethandler
	arg_6_0.skillstartHandler = skillstarthandler
	arg_6_0.skillcompleteHandler = skillcompletehandler
	arg_6_0.dieonxpHandler = var_0_13
	arg_6_0.fightwaitHandler = var_0_14
	arg_6_0.revivalHandler = revivalhandler
	arg_6_0.shutdownHandler = var_0_15
	arg_6_0._attackwait = nil
end

function FightCharacter:initPlayerBasicHandlers()
	self.winHandler = playerwinhandler
	self.dieHandler = playerdiehandler
	self.handlerQueue.win = nil
	self.handlerQueue.die = nil
end

function FightCharacter:initMonsterBasicHandlers()
	self.winHandler = playerwinhandler
	self.dieHandler = monsterdiehandler
	self.handlerQueue.win = nil
	self.handlerQueue.die = nil
end

function FightCharacter:initSlaveBasicHandlers()
	self.winHandler = playerwinhandler
	self.dieHandler = var_0_16
	self.handlerQueue.win = nil
	self.handlerQueue.die = nil
end

function FightCharacter:pushInAttackHandler(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == 0 then
		self:attackHandler(arg_10_2, arg_10_3)
	else
		var_0_2(self.handlerQueue.fight, {
			time = arg_10_1,
			handlertype = var_0_17,
			data = {
				arg_10_2,
				arg_10_3
			}
		})
	end
end

function FightCharacter:pushInBulletHandler(arg_11_1, arg_11_2, arg_11_3)
	var_0_2(self.handlerQueue.fight, {
		time = arg_11_1,
		handlertype = var_0_20,
		data = {
			arg_11_2,
			arg_11_3
		}
	})
end

function FightCharacter:pushInSkillStartHandler(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1 == 0 then
		self:skillstartHandler(arg_12_2, arg_12_3)
	else
		var_0_2(self.handlerQueue.fight, {
			time = arg_12_1,
			handlertype = var_0_18,
			data = {
				arg_12_2,
				arg_12_3
			}
		})
	end
end

function FightCharacter:pushInSkillCompleteHandler(arg_13_1, arg_13_2, arg_13_3)
	var_0_2(self.handlerQueue.fight, {
		time = arg_13_1,
		handlertype = var_0_19,
		data = {
			arg_13_2,
			arg_13_3
		}
	})
end

function FightCharacter:pushInDelayCallFuncs(arg_14_1, arg_14_2)
	var_0_2(self.handlerQueue.callfuncs, {
		time = arg_14_1,
		func = arg_14_2
	})
end

function FightCharacter:pushInResetHandler()
	self.handlerQueue.reset = true
end

function FightCharacter:pushInShutDownHandler(arg_16_1)
	self.handlerQueue.shutdown = arg_16_1
end

function FightCharacter:pushInXPDieHandler(arg_17_1)
	self.handlerQueue.xpdie = {
		arg_17_1
	}
end

function FightCharacter:pushInFightWaitHandler(arg_18_1)
	self.handlerQueue.wait = arg_18_1
end

function FightCharacter:pushInRevivalHandler(arg_19_1)
	self.handlerQueue.revival = arg_19_1
end

function FightCharacter:cleanAllFightHandlers()
	self.handlerQueue.fight = {}
	self.handlerQueue.callfuncs = {}
	self.handlerQueue.reset = false
	self.handlerQueue.wait = nil
	self.handlerQueue.shutdown = nil
end

function FightCharacter:pushInDieHandler(arg_21_1)
	self.handlerQueue.die = arg_21_1
end

function FightCharacter:pushInWinHandler(arg_22_1)
	self.handlerQueue.win = arg_22_1
end

function FightCharacter.setWaitAttackTimer(arg_23_0, arg_23_1)
	arg_23_0._attackwait = arg_23_1 and arg_23_1 > 0 and arg_23_1 or nil
end

function FightCharacter:needWaitForAttack()
	return self._attackwait ~= nil
end

function FightCharacter:cleanAllHandlers()
	self.handlerQueue.fight = {}
	self.handlerQueue.callfuncs = {}
	self.handlerQueue.reset = false
	self.handlerQueue.win = nil
	self.handlerQueue.die = nil
	self.handlerQueue.xpdie = nil
	self.handlerQueue.revival = nil
	self.handlerQueue.shutdown = nil
	self._attackwait = nil
end

function FightCharacter:executeHandler(arg_26_1, arg_26_2)
	if arg_26_1 == var_0_17 then
		self:attackHandler(arg_26_2[1], arg_26_2[2])
	elseif arg_26_1 == var_0_20 then
		self:bulletHandler(arg_26_2[1], arg_26_2[2])
	elseif arg_26_1 == var_0_18 then
		self:skillstartHandler(arg_26_2[1], arg_26_2[2])
	elseif arg_26_1 == var_0_19 then
		self:skillcompleteHandler(arg_26_2[1], arg_26_2[2])
	elseif arg_26_1 == var_0_21 then
		self:winHandler()
	elseif arg_26_1 == var_0_22 then
		self:dieHandler()
	elseif arg_26_1 == var_0_23 then
		self:fightresetHandler()
	elseif arg_26_1 == var_0_24 then
		self:dieonxpHandler(arg_26_2[1])
	elseif arg_26_1 == var_0_25 then
		self:fightwaitHandler()
	elseif arg_26_1 == var_0_26 then
		self:revivalHandler()
	elseif arg_26_1 == var_0_27 then
		self:shutdownHandler()
	end
end

function FightCharacter:updateShutDown(arg_27_1)
	if self.handlerQueue.shutdown then
		self.handlerQueue.shutdown = self.handlerQueue.shutdown - arg_27_1

		if self.handlerQueue.shutdown <= 0 then
			self.handlerQueue.shutdown = nil

			self:executeHandler(var_0_27)
		end
	end
end

function FightCharacter:updateHandlers(arg_28_1)
	self:updateShutDown(arg_28_1)

	local var_28_0 = 1

	while self.handlerQueue.fight[var_28_0] do
		self.handlerQueue.fight[var_28_0].time = self.handlerQueue.fight[var_28_0].time - arg_28_1

		if self.handlerQueue.fight[var_28_0].time <= 0 then
			self:executeHandler(self.handlerQueue.fight[var_28_0].handlertype, self.handlerQueue.fight[var_28_0].data)
			var_0_3(self.handlerQueue.fight, var_28_0)
		else
			var_28_0 = var_28_0 + 1
		end
	end

	local var_28_1 = 1

	while self.handlerQueue.callfuncs[var_28_1] do
		self.handlerQueue.callfuncs[var_28_1].time = self.handlerQueue.callfuncs[var_28_1].time - arg_28_1

		if self.handlerQueue.callfuncs[var_28_1].time <= 0 then
			var_0_3(self.handlerQueue.callfuncs, var_28_1).func()
		else
			var_28_1 = var_28_1 + 1
		end
	end

	if self.handlerQueue.win then
		self.handlerQueue.win = self.handlerQueue.win - arg_28_1

		if self.handlerQueue.win <= 0 then
			self.handlerQueue.win = nil

			self:executeHandler(var_0_21)
		end
	end

	if self.handlerQueue.die then
		self.handlerQueue.die = self.handlerQueue.die - arg_28_1

		if self.handlerQueue.die <= 0 then
			self.handlerQueue.die = nil

			self:executeHandler(var_0_22)
		end
	end

	if self.handlerQueue.reset then
		self:executeHandler(var_0_23)

		self.handlerQueue.reset = false
	end

	if self.handlerQueue.xpdie then
		self:executeHandler(var_0_24, self.handlerQueue.xpdie)

		self.handlerQueue.xpdie = nil
	end

	if self.handlerQueue.wait then
		self.handlerQueue.wait = self.handlerQueue.wait - arg_28_1

		if self.handlerQueue.wait <= 0 then
			self.handlerQueue.wait = nil

			self:executeHandler(var_0_25)
		end
	end

	if self.handlerQueue.revival then
		self.handlerQueue.revival = self.handlerQueue.revival - arg_28_1

		if self.handlerQueue.revival <= 0 then
			self.handlerQueue.revival = nil

			self:executeHandler(var_0_26)
		end
	end

	if self._attackwait then
		self._attackwait = self._attackwait - arg_28_1

		if self._attackwait <= 0 then
			self._attackwait = nil
		end
	end
end
