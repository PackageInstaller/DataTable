local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.model.User.allianceTrialData
local var_0_2 = g.core.const.ConstMgr.AllianceConst
local AllianceTrialGameWorld = require("app.view.module.allianceTrial.map.AllianceTrialGameWorld")
local AllianceTrialMapComp = class("AllianceTrialMapComp", require("app.fairyGUI.allianceTrial.UI_AllianceTrialMapComp"))

function AllianceTrialMapComp:ctor()
	self._mapWorld = nil
	self._npcStoryId = 0
	self._bgMusic = nil
	self._isShowingPop = false
end

function AllianceTrialMapComp:loadTiledMap()
	if self._mapWorld then
		self._mapWorld:removeSelf()

		self._mapWorld = nil
	end

	self._mapWorld = AllianceTrialGameWorld.new(self, var_0_0:getParams(var_0_2.PARAMETER.TRIAL_MAP_ID))

	self._mapWorld:startObserver(self.m_touchMap)
	self.m_tiledHold:addNode(self._mapWorld)
	self:_addBgMusic()
end

function AllianceTrialMapComp:startWorld()
	if self._mapWorld then
		self._mapWorld:startWorld()
		self._mapWorld:refreshEntityState()
	end
end

function AllianceTrialMapComp:_addBgMusic()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_LMSL)
end

function AllianceTrialMapComp:getMapWorld()
	return self._mapWorld
end

function AllianceTrialMapComp:getMapGround()
	return self._mapWorld:getMapGround()
end

function AllianceTrialMapComp:autoGoToTerminus(arg_7_1)
	local var_7_0 = self._mapWorld:getBindEntity(arg_7_1)

	if var_7_0 then
		self._mapWorld:autoRouteTalk(var_7_0)
	end
end

function AllianceTrialMapComp:talkTrigger(arg_8_1)
	local var_8_0 = arg_8_1:getBindID()

	if var_8_0 == nil then
		return
	end

	local var_8_1 = var_0_1:getMonsterInfoByBindId(var_8_0)

	if var_8_1 and not self._isShowingPop then
		self._isShowingPop = true

		self._mapWorld:playerAttackMonster(g.core.model.User:getId(), function()
			self:showAllianceTrialBattlePop(var_8_1)
		end)
	end
end

function AllianceTrialMapComp:resumeMusic()
	if self._bgMusic then
		g.core.sound.SoundManager:resumeMusic()
	end
end

function AllianceTrialMapComp:setAutoSearchPath()
	return
end

function AllianceTrialMapComp:showAllianceTrialBattlePop(arg_12_1)
	self._isShowingPop = false

	g.core.module.ModuleManager:pushPopup(require("app.view.module.allianceTrial.view.AllianceTrialChallengePop").new({
		monsterInfo = arg_12_1
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

function AllianceTrialMapComp:syncRoomUserStatus()
	self._mapWorld:removeOldRoomUser()
	self._mapWorld:createUserEntity()
end

function AllianceTrialMapComp:updateMonster()
	self._mapWorld:updateMonsterState()
end

function AllianceTrialMapComp:createShamUser()
	self._mapWorld:createShamUser()
end

function AllianceTrialMapComp:notifyExit(arg_16_1)
	self._mapWorld:delUserEntity(arg_16_1)
end

function AllianceTrialMapComp:notifyUserChallenge(arg_17_1, arg_17_2)
	self._mapWorld:playerAttackMonster(arg_17_1)
end

function AllianceTrialMapComp:removeAllSchedule()
	self._mapWorld:removeAllSchedule()
end

return AllianceTrialMapComp
