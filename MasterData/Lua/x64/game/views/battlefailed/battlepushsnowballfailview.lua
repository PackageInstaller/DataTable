local BattlePushSnowBallFailView = class("BattlePushSnowBallFailView", ReduxView)
local BattleInstance = import("game.tools.BattleInstance")

function BattlePushSnowBallFailView:UIName()
	return "UI/BattleResult/BattleFailed"
end

function BattlePushSnowBallFailView:UIParent()
	return manager.ui.uiMain.transform
end

function BattlePushSnowBallFailView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BattlePushSnowBallFailView:InitUI()
	self:BindCfgUI()

	self.stayTime = 6
end

function BattlePushSnowBallFailView:AddUIListener()
	self:AddBtnListener(self.mask_, nil, function()
		if self.isEnd then
			return
		end

		if Time.realtimeSinceStartup - self.startTime < 2 then
			return
		end

		self:Quit()
	end)
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		self:GoToBattleStatistics()
	end)
end

function BattlePushSnowBallFailView:GoToBattleStatistics()
	if self.isEnd then
		return
	end

	self:RemoveTimer()
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = self.stageData,
		battleTime = self:GetBattleTime()
	})
end

function BattlePushSnowBallFailView:GetBattleTime()
	return manager.time:DescCdTime2((LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()).dataForLua.battleTime)
end

function BattlePushSnowBallFailView:Quit()
	self.isEnd = true

	self:RemoveTimer()

	self.timer_ = Timer.New(function()
		self:QuitUI()
	end, 1, 1)

	self.timer_:Start()
	self.animator_:Play("battleFailed_out")
end

function BattlePushSnowBallFailView:OnEnter()
	BattleInstance.hideBattlePanel()
	self:RecordThreeStar()

	self.startTime = Time.realtimeSinceStartup
	self.isEnd = false

	SetActive(self.btnBattleCount_.gameObject, false)

	for iter_12_0 = 1, 3 do
		SetActive(self["text" .. iter_12_0 .. "Go_"], false)
	end

	self:RemoveTimer()

	self.timer_ = Timer.New(function()
		self:Quit()
	end, self.stayTime, 1)

	self.timer_:Start()

	self.battleTimeText_.text = self:GetBattleTime()

	self.animator_:Play("battleFailed")
end

function BattlePushSnowBallFailView:OnExit()
	self:RemoveTimer()
end

function BattlePushSnowBallFailView:RemoveTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BattlePushSnowBallFailView:QuitUI()
	local var_16_0 = PlayerData:GetlevelUpInfos()

	if #var_16_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_16_0,
			callback = function()
				FrameTimer.New(function()
					BattleInstance.QuitBattle(self.params_.stageData, true, true)
				end, 1, 1):Start()
			end
		})
	else
		BattleInstance.QuitBattle(self.params_.stageData, true, true)
	end
end

function BattlePushSnowBallFailView:RecordThreeStar()
	self.stageData_ = self.params_.stageData
	self.stageID_ = self.stageData_:GetStageId()
	self.stageType_ = self.stageData_:GetType()

	local var_19_0 = self.params_.starMissionData
	local var_19_1 = {}

	for iter_19_0 = 1, 3 do
		if var_19_0 ~= nil and var_19_0[iter_19_0] ~= nil then
			local var_19_2 = ThreeStarConditionCfg[var_19_0[iter_19_0].id]
			local var_19_3

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == self.stageType_ then
				var_19_3 = BattleStageData:GetStageData()[self.stageID_]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == self.stageType_ then
				var_19_3 = BattleBossChallengeNormalData:GetStarList(self.stageID_)
			end

			var_19_1[iter_19_0] = ((var_19_2.id == 15 or var_19_2.id == 16 or nil) and var_19_0[iter_19_0].isComplete or not not (var_19_3 and var_19_3.stars and var_19_3.stars[iter_19_0] == 1)) and 1 or 0
		end
	end

	BattleInstance.RecordThreeStar(self.stageType_, self.stageID_, var_19_1)
end

return BattlePushSnowBallFailView
