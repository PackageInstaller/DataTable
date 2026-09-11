local NewBattleFailedView = class("NewBattleFailedView", (import("game.views.pop.PopFramingBaseView")))
local BattleInstance = import("game.tools.BattleInstance")

function NewBattleFailedView:UIName()
	return "Widget/System/BattleResult/BattleFailed/BattleResultLoseUI"
end

function NewBattleFailedView:UIParent()
	return manager.ui.uiPop.transform
end

function NewBattleFailedView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewBattleFailedView:InitUI()
	self:BindCfgUI()

	self.styleController = self.controllerEx_:GetController("default0")
	self.posController = self.controllerEx_:GetController("move")
	self.lvController = self.lvController_:GetController("red")
	self.btnController = self.btnController_:GetController("btn")
	self.typeImgs = {}
	self.criList = LuaList.New(handler(self, self.indexTypeItem), self.criListObj_, BattleFailedCriItem)
end

function NewBattleFailedView:AddUIListener()
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		self:GoToBattleStatistics()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		self:OnClickBack()
	end)
	self:AddBtnListener(self.restartBtn_, nil, function()
		self:OnClickRestart()
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back(false, handler(self, self.OnClickBack))
	end)
	SetActive(self.btnMask_.gameObject, true)
	self.btnController:SetSelectedState("nobtn")
end

function NewBattleFailedView:GoToBattleStatistics()
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = self.params_.stageData,
		battleTime = self:GetBattleTime()
	})
end

function NewBattleFailedView:GetBattleTime()
	return manager.time:DescCdTime2((LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()).dataForLua.battleTime)
end

function NewBattleFailedView:OnEnter()
	self.stageData_ = self.params_.stageData
	self.stageID_ = self.stageData_:GetStageId()
	self.stageType_ = self.stageData_:GetType()
	self.recommendAttriList = {}

	BattleInstance.hideBattlePanel()
	self:RebuildUI()
	self:RecordThreeStar()
end

function NewBattleFailedView:OnExit()
	return
end

function NewBattleFailedView:RebuildUI()
	self:ChangeStyle()
	self:RefreshRecommendType()
	self:RefreshRecommendLevel()

	local var_14_0 = {
		GetTips("BATTLE_TOTAL_TIME"),
		": "
	}

	var_14_0[3] = self:GetBattleTime() or "00"
	self.battleTimeText_.text = table.concat(var_14_0)
	self.titleTxt_.text = BattleStageTools.GetStageName(self.stageType_, self.stageID_)

	local var_14_1 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if var_14_1.is_hide_failed_tips and var_14_1.is_hide_failed_tips >= 1 then
		self.posController:SetSelectedState("true")
		SetActive(self.tipsTitleObj_, false)
		SetActive(self.tips1Obj_, false)
		SetActive(self.tips2Obj_, false)
		SetActive(self.tips3Obj_, false)
		SetActive(self.bottomLineObj_, false)
	else
		self.posController:SetSelectedState("false")
		SetActive(self.tipsTitleObj_, true)
		SetActive(self.tips1Obj_, true)
		SetActive(self.tips2Obj_, true)
		SetActive(self.tips3Obj_, true)
		SetActive(self.bottomLineObj_, true)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoTrans_)
end

function NewBattleFailedView:ChangeStyle()
	if self.params_.isHalfWay_ then
		self.styleController:SetSelectedState("end")
	else
		self.styleController:SetSelectedState("lose")
	end
end

function NewBattleFailedView:OnClickBack()
	self:QuitUI()
end

function NewBattleFailedView:QuitUI()
	local var_17_0 = PlayerData:GetlevelUpInfos()

	if #var_17_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_17_0,
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

function NewBattleFailedView:OnClickRestart()
	LuaExchangeHelper.GameOver(2)
	BattleController.GetInstance():LaunchBattle(self.params_.stageData)
	LuaForCursor.SwitchCursor(false)
end

function NewBattleFailedView:RecordThreeStar()
	local var_21_0 = self.params_.starMissionData
	local var_21_1 = {}

	for iter_21_0 = 1, 3 do
		if var_21_0 ~= nil and var_21_0[iter_21_0] ~= nil then
			local var_21_2 = ThreeStarConditionCfg[var_21_0[iter_21_0].id]
			local var_21_3

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == self.stageType_ then
				var_21_3 = BattleStageData:GetStageData()[self.stageID_]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == self.stageType_ then
				var_21_3 = BattleBossChallengeNormalData:GetStarList(self.stageID_)
			end

			var_21_1[iter_21_0] = ((var_21_2.id == 15 or var_21_2.id == 16 or nil) and var_21_0[iter_21_0].isComplete or not not (var_21_3 and var_21_3.stars and var_21_3.stars[iter_21_0] == 1)) and 1 or 0
		end
	end

	BattleInstance.RecordThreeStar(self.stageType_, self.stageID_, var_21_1)
end

function NewBattleFailedView:RefreshRecommendType()
	local var_22_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if var_22_0 then
		local var_22_1 = var_22_0.recommend_attribute_list or {}

		if #var_22_1 > 0 then
			SetActive(self.recommendTypeObj_, true)

			self.recommendAttriList = var_22_1

			self.criList:StartScroll(#var_22_1)
		else
			SetActive(self.recommendTypeObj_, false)
		end
	else
		SetActive(self.recommendTypeObj_, false)
	end
end

function NewBattleFailedView:RefreshRecommendLevel()
	local var_23_0 = 0
	local var_23_1, var_23_2 = self.params_.stageData:GetHeroTeam()

	for iter_23_0 = 1, 3 do
		if var_23_1[iter_23_0] and var_23_1[iter_23_0] ~= 0 then
			var_23_0 = math.max(self.params_.stageData:GetHeroDataByPos(iter_23_0).level, var_23_0)
		end
	end

	local var_23_3 = self:GetRecommendLevel()

	if var_23_3 and var_23_3 ~= 0 then
		SetActive(self.lvController_.gameObject, true)

		self.recommendNumTxt_.text = var_23_3

		if var_23_3 <= var_23_0 then
			self.lvController:SetSelectedState("state0")
		else
			self.lvController:SetSelectedState("state1")
		end
	else
		SetActive(self.lvController_.gameObject, false)
	end
end

function NewBattleFailedView:indexTypeItem(arg_24_1, arg_24_2)
	arg_24_2:OnRenderItem(HeroTools.GetSkillAttributeIcon(self.recommendAttriList[arg_24_1]))
end

function NewBattleFailedView:GetRecommendLevel()
	return BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).recommend_level
end

function NewBattleFailedView:Dispose()
	self.criList:Dispose()
	NewBattleFailedView.super.Dispose(self)
end

return NewBattleFailedView
