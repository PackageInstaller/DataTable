local var_0_0 = {
	BOSS_STAGE = 3,
	USER_STOP = 2,
	BATTLE_FAILED = 1,
	ALL_FINISH = 5,
	LIMIT_TIME = 4
}
local var_0_1 = {
	[var_0_0.BATTLE_FAILED] = 432037,
	[var_0_0.USER_STOP] = 432038,
	[var_0_0.BOSS_STAGE] = 432039,
	[var_0_0.LIMIT_TIME] = 432040,
	[var_0_0.ALL_FINISH] = 432041
}
local SpireAutoRunComp = class("SpireAutoRunComp", require("app.fairyGUI.spire.UI_SpireAutoRunComp"))

function SpireAutoRunComp:ctor()
	self._lastRunTime = 0
	self._curStep = 0

	self.m_stopBtn:addClickListener(handler(self, self._onStopClick))
end

function SpireAutoRunComp:setTowerData(arg_2_1)
	self._tower = arg_2_1
	self._curStep = 0
end

function SpireAutoRunComp:onLoad()
	self:newSchedule(handler(self, self.checkAutoAction), 4)
	self:checkAutoAction()
end

function SpireAutoRunComp:checkAutoAction()
	local var_4_0 = g.core.common.ServerTime:getTime()

	if var_4_0 - self._lastRunTime < 1 then
		return
	end

	self._lastRunTime = var_4_0

	local var_4_1 = self._tower:getCurFloor():getCurStageStruct()

	if self._tower:isPass() then
		self:doFinishAutoAction(var_0_0.ALL_FINISH)

		return
	end

	if var_4_1:isBossStage() then
		self:doFinishAutoAction(var_0_0.BOSS_STAGE)

		return
	end

	if not var_4_1:isBossStage() and not g.core.model.User.spireData:hasChallengeTimes(self._tower) then
		self:doFinishAutoAction(var_0_0.LIMIT_TIME)

		return
	end

	local var_4_2 = g.core.module.ModuleManager:getCurModule()
	local var_4_3 = var_4_2.display:getName()

	if var_4_3 == "SpireChallengeLayer" and self._curStep == 0 then
		if var_4_2.display:doAutoAction() then
			self._curStep = 1
		end
	elseif var_4_3 == "BattleScene" then
		local var_4_4 = g.core.battle.BattleProxy:getBattleLayer()

		if var_4_4 and self._curStep == 1 and var_4_4:doAutoAction() then
			self._curStep = 2
		end
	elseif var_4_3 == "BattleResultLayer" then
		self._curStep = 0

		if not var_4_2.display:doAutoAction() then
			self:doFinishAutoAction(var_0_0.BATTLE_FAILED)

			return
		end
	end

	local var_4_5 = self._tower:getCurFloor()

	self.m_levelTxt:setText(g.core.lang:get(432042, {
		floor = self._tower:getCurFloorIndex(),
		stage = var_4_5:getCurPassStage()
	}))
end

function SpireAutoRunComp:doFinishAutoAction(arg_5_1)
	local var_5_0 = fgui.UIPackage:createObject("spire", "SpireAutoFinishPop")

	var_5_0:setPosition(display.width / 2 + display.cx, display.height / 2 + display.cy)
	var_5_0:updateAutoReason({
		levelTxt = g.core.lang:get(432013, {
			floor = self._tower:getCurFloorIndex(),
			stage = self._tower:getCurFloor():getCurPassStage()
		}),
		desc = g.core.lang:get(var_0_1[arg_5_1])
	})
	g.core.layer.LayerManager:getGuideTopLayer():addChild(var_5_0)
	self:cancelAllSchedule()
	self:removeFromParent()
end

function SpireAutoRunComp:_onStopClick()
	self:doFinishAutoAction(var_0_0.USER_STOP)
end

return SpireAutoRunComp
