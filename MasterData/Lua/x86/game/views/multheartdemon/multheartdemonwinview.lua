NewBattleScoreResultView = import("game.views.battleResult.score.NewBattleScoreResultView")

local MultHeartDemonResultView = class("MultHeartDemonResultView", NewBattleScoreResultView)

function MultHeartDemonResultView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_BattleResultWinUI"
end

function MultHeartDemonResultView:InitUI()
	self:BindCfgUI()

	self.heroModule = {
		MultHeartDemonWinHeadItem.New(self.heroHead1Obj_),
		MultHeartDemonWinHeadItem.New(self.heroHead2Obj_),
		(MultHeartDemonWinHeadItem.New(self.heroHead3Obj_))
	}
end

function MultHeartDemonResultView:AddListener()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		self:GoToBattleStatistics()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "closeCombat")
		ShowMessageBox({
			isTop = true,
			content = GetTips("MULTI_HEART_DEMON_NOT_SAVE_CONFIRM_TIPS"),
			OkCallback = function()
				self:ShowVitalityBox(function()
					self:ShowEquipBox(function()
						BattleInstance.QuitBattle(self.params_.stageData)
					end)
				end)
			end
		})
	end)
	self:OnAddListner()
end

function MultHeartDemonResultView:CloseFunc()
	local function var_10_0()
		self:ShowVitalityBox(function()
			self:ShowEquipBox(function()
				BattleInstance.QuitBattle(self.params_.stageData)
				MultHeartDemonAction.SaveBattle({
					activity_id = self.stageData:GetActivityID(),
					stage_id = self.stageId
				})
			end)
		end)
	end

	OperationRecorder.Record(self.class.__cname, "closeCombat")

	if _G.SkipTip.SkipActivityMultiDemonContinueConfirm then
		var_10_0()
	else
		ShowMessageBox({
			isTop = true,
			content = GetTips("MULTI_HEART_DEMON_SAVE_CONFIRM_TIPS"),
			OkCallback = var_10_0,
			ToggleCallback = function(arg_14_0)
				_G.SkipTip.SkipActivityMultiDemonContinueConfirm = arg_14_0
			end
		})
	end
end

function MultHeartDemonResultView:SaveData()
	MultHeartDemonAction.SaveBattle({
		activity_id = self.stageData:GetActivityID(),
		stage_id = self.stageId
	})
end

local function var_0_1(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	return (arg_16_0 == 0 and 0 or 1 / (arg_16_2 / arg_16_0 + arg_16_3 / arg_16_0)) + (arg_16_1 == 0 and 0 or 1 / (arg_16_2 / arg_16_1 + arg_16_3 / arg_16_1))
end

function MultHeartDemonResultView:RefreshHeroS()
	local var_17_0, var_17_1 = self.stageData:GetHeroTeam()
	local var_17_2 = 1
	local var_17_3 = MultHeartDemonData:GetDataByPara("difficultyData")
	local var_17_4 = var_17_3[self.stageData:GetDifficult()].heroIdList

	for iter_17_0, iter_17_1 in ipairs(var_17_4) do
		if var_17_0[1] == iter_17_1 then
			var_17_2 = iter_17_0
		end
	end

	local var_17_5 = var_17_3[self.stageData:GetDifficult()].heroHPList or {}
	local var_17_6 = HeroViewDataProxy.New(1)

	for iter_17_2 = 1, 3 do
		if iter_17_2 == 1 then
			local var_17_7 = self.stageData:GetHeroDataByPos(iter_17_2)
			local var_17_8 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua

			self.heroModule[1]:ShowCaptain(true)

			local var_17_9, var_17_10 = var_17_8.currentHP[0]:tonum2()
			local var_17_11, var_17_12 = var_17_8.MaxHP[0]:tonum2()
			local var_17_13 = var_0_1(var_17_9, var_17_10, var_17_11, var_17_12) * 100

			var_17_13 = var_17_13 > 1 and math.round(var_17_13) or var_17_13 > 0 and 1 or 0

			self.heroModule[iter_17_2]:SetHp(var_17_13)
			self.heroModule[1]:SetHeroData({
				star = 0,
				id = var_17_7.id,
				using_skin = var_17_7.using_skin
			})
		else
			local var_17_14 = (var_17_2 + iter_17_2 - 1) % 3 == 0 and 3 or (var_17_2 + iter_17_2 - 1) % 3

			if HeroStandardSystemCfg[var_17_4[(var_17_2 + iter_17_2 - 1) % 3 == 0 and 3 or (var_17_2 + iter_17_2 - 1) % 3]] then
				self.heroModule[iter_17_2]:SetHp(var_17_5[var_17_4[var_17_14]] == nil and 100 or 0)
				self.heroModule[iter_17_2]:ShowCaptain(false)
				self.heroModule[iter_17_2]:SetHeroData({
					star = 0,
					id = HeroStandardSystemCfg[var_17_4[var_17_14]].hero_id,
					using_skin = HeroStandardSystemCfg[var_17_4[var_17_14]].skin_id
				})
			else
				self.heroModule[iter_17_2]:SetHeroData({
					star = 0,
					id = var_17_4[var_17_14],
					using_skin = var_17_6:GetHeroUsingSkinInfo(var_17_4[var_17_14]).id
				})
				self.heroModule[iter_17_2]:SetHp(var_17_5[var_17_4[var_17_14]] == nil and 100 or 0)
				self.heroModule[iter_17_2]:ShowCaptain(false)
			end
		end
	end
end

function MultHeartDemonResultView:ShowContent()
	self.areaCfg = {}

	self:BindCfgUI(Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleChallengeContent"), self.contentContainer_), self.areaCfg)

	self.areaCfg.scoreTitleTxt_.text = GetTips("MULTI_HEART_DEMON_TITLE_SCORE")
	self.areaCfg.scoreText_.text = MultHeartDemonData:GetDataByPara("battleScore")
end

function MultHeartDemonResultView:Dispose()
	self:RemoveExpTween()

	for iter_19_0 = 1, 3 do
		self.heroModule[iter_19_0]:Dispose()
	end

	if self.missionView then
		self.missionView:Dispose()
	end

	self.spriteRef = nil

	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	ReduxFactory.GetInstance():OnManagedObjDisposed(self)
	self:CheckListenersLeak()
	self:DisposeImageWrap()
end

return MultHeartDemonResultView
