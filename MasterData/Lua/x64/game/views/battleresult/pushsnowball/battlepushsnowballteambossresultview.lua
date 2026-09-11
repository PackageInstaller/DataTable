local BattlePushSnowBallTeamBossResultView = class("BattlePushSnowBallTeamBossResultView", ReduxView)

function BattlePushSnowBallTeamBossResultView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballResultBossModeUI"
end

function BattlePushSnowBallTeamBossResultView:UIParent()
	return manager.ui.uiMain.transform
end

function BattlePushSnowBallTeamBossResultView:Init()
	self:InitUI()
	self:AddListener()

	self.resultController_ = ControllerUtil.GetController(self.transform_, "result")
	self.killController_ = ControllerUtil.GetController(self.transform_, "killNum")
	self.teamController_ = ControllerUtil.GetController(self.transform_, "mode")
	self.enemyUiList_ = LuaList.New(handler(self, self.IndexBossItem), self.enemyUiListGo_, PushSnowBallTeamResultItem)
	self.teammateUiList_ = LuaList.New(handler(self, self.IndexItem), self.teammateUiListGo_, PushSnowBallTeamResultItem)
end

function BattlePushSnowBallTeamBossResultView:InitUI()
	self:BindCfgUI()
end

function BattlePushSnowBallTeamBossResultView:AddListener()
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

function BattlePushSnowBallTeamBossResultView:HideAllUI()
	SetActive(self.backBtn_.gameObject, false)
	SetActive(self.shareBtn_.gameObject, false)
end

function BattlePushSnowBallTeamBossResultView:RecoverAllUI()
	SetActive(self.backBtn_.gameObject, true)
	SetActive(self.shareBtn_.gameObject, true)
end

function BattlePushSnowBallTeamBossResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.resultInfo = self.params_.resultInfo
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()
	self.playerID = tostring(PlayerData:GetPlayerInfo().userID)
	self.otherPlayerInfoList = {}

	table.sort(self.resultInfo, function(arg_14_0, arg_14_1)
		return arg_14_0.score > arg_14_1.score
	end)

	for iter_13_0, iter_13_1 in ipairs(self.resultInfo) do
		iter_13_1.rank = iter_13_0

		if iter_13_1.user_id == self.playerID then
			self.info = iter_13_1
		else
			table.insert(self.otherPlayerInfoList, iter_13_1)
		end
	end

	self.teammatePlayerInfoList = {}
	self.bossPlayerInfoList = {}

	for iter_13_2, iter_13_3 in ipairs(self.otherPlayerInfoList) do
		if iter_13_3.type == 1 then
			table.insert(self.bossPlayerInfoList, iter_13_3)
		elseif iter_13_3.type == 0 then
			table.insert(self.teammatePlayerInfoList, iter_13_3)
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

function BattlePushSnowBallTeamBossResultView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(self.stageData)
end

function BattlePushSnowBallTeamBossResultView:OnClickRestart()
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

function BattlePushSnowBallTeamBossResultView:RefreshUI()
	self.scoreText_.text = self.info.score
	self.nameText_.text = self.stageData:GetName()
	self.playerNameText_.text = PlayerData:GetPlayerInfo().nick
	self.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait2/" .. PushSnowBallData:GetSelectedHeroID())

	if self.info.type == 1 then
		self.teamController_:SetSelectedState("boss")

		if self.info.result == 1 then
			self.enemyUiList_:StartScroll(#self.otherPlayerInfoList)
		end
	elseif self.info.type == 0 then
		self.teamController_:SetSelectedState("team")

		if self.info.result == 1 then
			self.enemyUiList_:StartScroll(#self.bossPlayerInfoList)
		end

		self.teammateUiList_:StartScroll(#self.teammatePlayerInfoList)
	end

	if self.info.result == 1 then
		self.resultController_:SetSelectedState("win")
	else
		self.resultController_:SetSelectedState("lose")
	end
end

function BattlePushSnowBallTeamBossResultView:IndexItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_1, self.teammatePlayerInfoList[arg_19_1])
end

function BattlePushSnowBallTeamBossResultView:IndexBossItem(arg_20_1, arg_20_2)
	if self.info.type == 1 then
		arg_20_2:SetData(arg_20_1, self.otherPlayerInfoList[arg_20_1])
	elseif self.info.type == 0 then
		arg_20_2:SetData(arg_20_1, self.bossPlayerInfoList[arg_20_1])
	end
end

function BattlePushSnowBallTeamBossResultView:OnExit()
	return
end

function BattlePushSnowBallTeamBossResultView:Dispose()
	if self.enemyUiList_ then
		self.enemyUiList_:Dispose()

		self.enemyUiList_ = nil
	end

	if self.teammateUiList_ then
		self.teammateUiList_:Dispose()

		self.teammateUiList_ = nil
	end

	BattlePushSnowBallTeamBossResultView.super.Dispose(self)
end

return BattlePushSnowBallTeamBossResultView
