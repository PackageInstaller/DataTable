local BattlePushSnowBallSingleResultView = class("BattlePushSnowBallSingleResultView", ReduxView)

function BattlePushSnowBallSingleResultView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballResultSingleModeUI"
end

function BattlePushSnowBallSingleResultView:UIParent()
	return manager.ui.uiMain.transform
end

function BattlePushSnowBallSingleResultView:Init()
	self:InitUI()
	self:AddListener()
end

function BattlePushSnowBallSingleResultView:InitUI()
	self:BindCfgUI()
end

function BattlePushSnowBallSingleResultView:AddListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.restartBtn_, nil, function()
		self:OnClickRestart()
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

function BattlePushSnowBallSingleResultView:HideAllUI()
	SetActive(self.backBtn_.gameObject, false)
	SetActive(self.shareBtn_.gameObject, false)
	SetActive(self.restartBtn_.gameObject, false)
end

function BattlePushSnowBallSingleResultView:RecoverAllUI()
	SetActive(self.backBtn_.gameObject, true)
	SetActive(self.shareBtn_.gameObject, true)
	SetActive(self.restartBtn_.gameObject, true)
end

function BattlePushSnowBallSingleResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.score = self.params_.score
	self.useSecond = self.params_.useSecond
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()

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

function BattlePushSnowBallSingleResultView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(self.stageData)
end

function BattlePushSnowBallSingleResultView:OnClickRestart()
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

function BattlePushSnowBallSingleResultView:RefreshUI()
	self.scoreText_.text = self.score
	self.useSecondText_.text = self.useSecond
	self.nameText_.text = self.stageData:GetName()
	self.playerNameText_.text = PlayerData:GetPlayerInfo().nick
	self.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait2/" .. PushSnowBallData:GetSelectedHeroID())
end

function BattlePushSnowBallSingleResultView:OnExit()
	return
end

function BattlePushSnowBallSingleResultView:Dispose()
	BattlePushSnowBallSingleResultView.super.Dispose(self)
end

return BattlePushSnowBallSingleResultView
