local BattlePushSnowBallTeamSurvivalResultView = class("BattlePushSnowBallTeamSurvivalResultView", ReduxView)

function BattlePushSnowBallTeamSurvivalResultView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballResultNeckingModeUI"
end

function BattlePushSnowBallTeamSurvivalResultView:UIParent()
	return manager.ui.uiMain.transform
end

function BattlePushSnowBallTeamSurvivalResultView:Init()
	self:InitUI()
	self:AddListener()

	self.resultController_ = ControllerUtil.GetController(self.transform_, "result")
	self.killController_ = ControllerUtil.GetController(self.transform_, "killNum")
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, PushSnowBallTeamResultItem)
end

function BattlePushSnowBallTeamSurvivalResultView:InitUI()
	self:BindCfgUI()
end

function BattlePushSnowBallTeamSurvivalResultView:AddListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			self:HideAllUI()
		end, function()
			self:RecoverAllUI()
		end, function()
			return
		end)
	end)
end

function BattlePushSnowBallTeamSurvivalResultView:HideAllUI()
	SetActive(self.backBtn_.gameObject, false)
	SetActive(self.shareBtn_.gameObject, false)
end

function BattlePushSnowBallTeamSurvivalResultView:RecoverAllUI()
	SetActive(self.backBtn_.gameObject, true)
	SetActive(self.shareBtn_.gameObject, true)
end

function BattlePushSnowBallTeamSurvivalResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.resultInfo = self.params_.resultInfo
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()
	self.playerID = tostring(PlayerData:GetPlayerInfo().userID)

	table.sort(self.resultInfo, function(arg_14_0, arg_14_1)
		return arg_14_0.score > arg_14_1.score
	end)

	for iter_13_0, iter_13_1 in ipairs(self.resultInfo) do
		iter_13_1.rank = iter_13_0

		if iter_13_1.user_id == self.playerID then
			self.info = iter_13_1
		end
	end

	BattleInstance.hideBattlePanel()
	self:RefreshUI()

	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end
end

function BattlePushSnowBallTeamSurvivalResultView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(self.stageData)
end

function BattlePushSnowBallTeamSurvivalResultView:OnClickRestart()
	if self.params_.condition then
		local var_17_0, var_17_1 = self.params_.condition()

		if var_17_0 then
			BattleController.GetInstance():LaunchBattle(self.params_.stageData)
		else
			ShowTips(var_17_1)
		end
	else
		BattleController.GetInstance():LaunchBattle(self.params_.stageData)
	end
end

function BattlePushSnowBallTeamSurvivalResultView:RefreshUI()
	self.rankText_.text = self.info.rank
	self.killNumText_.text = self.info.score
	self.nameText_.text = self.stageData:GetName()
	self.playerNameText_.text = PlayerData:GetPlayerInfo().nick

	if self.info.rank == 1 then
		self.resultController_:SetSelectedState("win")
	else
		self.resultController_:SetSelectedState("lose")
	end

	self.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait2/" .. PushSnowBallData:GetSelectedHeroID())

	self.uiList_:StartScroll(#self.resultInfo)
end

function BattlePushSnowBallTeamSurvivalResultView:IndexItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_1, self.resultInfo[arg_19_1])
end

function BattlePushSnowBallTeamSurvivalResultView:OnExit()
	return
end

function BattlePushSnowBallTeamSurvivalResultView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	BattlePushSnowBallTeamSurvivalResultView.super.Dispose(self)
end

return BattlePushSnowBallTeamSurvivalResultView
