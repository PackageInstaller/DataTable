local ChessMutiBattleView = class("ChessMutiBattleView", ReduxView)

function ChessMutiBattleView:UIName()
	return "Widget/System/WarChess_system/WarChessTeamToPrepareUI"
end

function ChessMutiBattleView:UIParent()
	return manager.ui.uiMain.transform
end

function ChessMutiBattleView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessMutiBattleView:InitUI()
	self:BindCfgUI()

	self.changehandler_ = handler(self, self.OnChangeBtnClick)
	self.confirmhandler_ = handler(self, self.OnConfirmBtnClick)
	self.changeindex_1 = 0
	self.changeindex_2 = 0
	self.heroList_ = LuaList.New(handler(self, self.indexHeroList), self.uilistGo_, ChessMutiBattleItemView)
end

function ChessMutiBattleView:OnChangeBtnClick(arg_5_1)
	if self.changeindex_1 == 0 then
		self.changeindex_1 = arg_5_1

		for iter_5_0, iter_5_1 in pairs((self.heroList_:GetItemList())) do
			iter_5_1:OnChangeRefreshStatus(arg_5_1)
		end

		SetActive(self.btn_warbeganGo_, false)
	else
		self:ResetStatus()
	end
end

function ChessMutiBattleView:OnConfirmBtnClick(arg_6_1)
	self.changeindex_2 = arg_6_1

	if self.changeindex_1 ~= 0 and self.changeindex_2 ~= 0 then
		ReserveTools.SwapTeam(ReserveConst.RESERVE_TYPE.MULTI_CHESS, self.activityID_, self.changeindex_1, self.changeindex_2)
		self.heroList_:StartScroll(self.times_)
	end

	self:ResetStatus()
end

function ChessMutiBattleView:ResetStatus()
	self.changeindex_1 = 0
	self.changeindex_2 = 0

	for iter_7_0, iter_7_1 in pairs((self.heroList_:GetItemList())) do
		iter_7_1:ResetState()
	end

	SetActive(self.btn_warbeganGo_, true)
end

function ChessMutiBattleView:indexHeroList(arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_1, self.battleList_[arg_8_1], self.typeList_[arg_8_1], self.activityID_, #self.battleList_)
	arg_8_2:RegionHandler(self.changehandler_, self.confirmhandler_)
end

function ChessMutiBattleView:AddUIListener()
	self:AddBtnListener(self.btn_warbeganBtn_, nil, function()
		if not ChessTools.CheckCanEnterMutiBattle(self.times_, self.activityID_) then
			ShowTips("ERROR_MULTIPLE_BATTLES_REQUIREMENT")

			return
		end

		ReserveAction.SaveMultiChessContData(self.xz_.x, self.xz_.z, self.times_, self.activityID_, function()
			local var_11_0 = {}

			for iter_11_0 = 1, self.times_ do
				var_11_0[iter_11_0] = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, self.battleList_[iter_11_0], self.activityID_, (ReserveParams.New(ReserveConst.RESERVE_TYPE.MULTI_CHESS, self.activityID_, iter_11_0, {
					stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS,
					stageID = self.battleList_[index]
				})))

				if iter_11_0 > 1 then
					var_11_0[iter_11_0 - 1]:SetNextStage(var_11_0[iter_11_0])
				end
			end

			BattleController.GetInstance():LaunchBattle(var_11_0[1])
		end)
	end)
end

function ChessMutiBattleView:OnEnter()
	manager.ui:SetMainCamera("battleHeroSelect")

	self.times_ = self.params_.times
	self.battleList_ = self.params_.battleList
	self.activityID_ = self.params_.activityID
	self.xz_ = self.params_.xz
	self.typeList_ = self.params_.typeList
end

function ChessMutiBattleView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.changeindex_1 ~= 0 then
			self:ResetStatus()
		else
			JumpTools.Back()
		end
	end)
	self.heroList_:StartScroll(self.times_)
end

function ChessMutiBattleView:OnExit()
	manager.windowBar:HideBar()
	self:ResetStatus()
end

function ChessMutiBattleView:Dispose()
	if self.heroList_ then
		self.heroList_:Dispose()

		self.heroList_ = nil
	end

	self.changehandler_ = nil
	self.confirmhandler_ = nil

	ChessMutiBattleView.super.Dispose(self)
end

return ChessMutiBattleView
