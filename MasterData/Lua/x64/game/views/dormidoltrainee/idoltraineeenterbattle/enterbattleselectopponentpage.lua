local EnterBattleSelectOpponentPage = class("EnterBattleSelectOpponentPage", ReduxView)

function EnterBattleSelectOpponentPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function EnterBattleSelectOpponentPage:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
	self:RegisterEvents()

	self.opponentUIList_ = LuaList.New(handler(self, self.IndexItem), self.opponentList_, SelectOpponentListItem)
	self.showFlag = false
	self.typeController_ = self.mainControllerEx_:GetController("type")
	self.stateController = self.mainControllerEx_:GetController("state")
end

function EnterBattleSelectOpponentPage:RegisterEvents()
	self:RegistEventListener(IDOL_TRAINEE_REFRESH_OPPONENT, function()
		return
	end)
end

function EnterBattleSelectOpponentPage:ShowPage(arg_5_1)
	if self.showFlag == arg_5_1 then
		return
	end

	self.showFlag = arg_5_1

	if arg_5_1 then
		self.stateController:SetSelectedState("show")
		self:OnEnter()
	else
		self.stateController:SetSelectedState("close")
		self:OnExit()
	end
end

function EnterBattleSelectOpponentPage:AddUIListener()
	self:AddBtnListener(self.strangerBtn_, nil, function()
		if self.canClick then
			self.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.stranger, function()
				self:ChangeContent(IdolTraineeConst.friendType.stranger)

				self.canClick = true
			end)
		end
	end)
	self:AddBtnListener(self.friendBtn_, nil, function()
		if self.canClick then
			self.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.friend, function()
				self:ChangeContent(IdolTraineeConst.friendType.friend)

				self.canClick = true
			end)
		end
	end)
	self:AddBtnListener(self.refreshBtn_, nil, function()
		if self.canClick then
			self.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.stranger, function()
				self:ChangeContent(self.curContent_, true)

				self.canClick = true
			end, true)
		end
	end)
end

function EnterBattleSelectOpponentPage:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.infoList[arg_13_1], self.curContent_)
end

function EnterBattleSelectOpponentPage:RefreshUI(arg_14_1)
	local var_14_0

	if not arg_14_1 then
		::label_14_0::

		var_14_0 = self.curContent_ or IdolTraineeConst.friendType.friend
	end

	self:ChangeContent(var_14_0, true)
end

function EnterBattleSelectOpponentPage:ChangeContent(arg_15_1, arg_15_2)
	if self.curContent_ == arg_15_1 and not arg_15_2 then
		return
	end

	self.curContent_ = arg_15_1

	if arg_15_1 == IdolTraineeConst.friendType.friend then
		self.typeController_:SetSelectedState("friend")
	else
		self.typeController_:SetSelectedState("stranger")
	end

	self:RefreshPlayerInfoList()
end

function EnterBattleSelectOpponentPage:OnEnter()
	self.canClick = true

	if self.canClick then
		self.canClick = false

		IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.friend, function()
			local var_17_0 = IdolTraineeTools:GetOpponentList(IdolTraineeConst.friendType.friend)

			if not var_17_0 or #var_17_0 == 0 then
				self:ChangeContent(IdolTraineeConst.friendType.stranger)
			else
				self:ChangeContent(IdolTraineeConst.friendType.friend)
			end

			self.canClick = true
		end)
	end
end

function EnterBattleSelectOpponentPage:OnExit()
	self:RemoveAllEventListener()
end

function EnterBattleSelectOpponentPage:RefreshPlayerInfoList()
	self.infoList = IdolTraineeTools:GetOpponentList(self.curContent_)

	if self.infoList then
		self.opponentUIList_:StartScroll(#self.infoList)
	end
end

function EnterBattleSelectOpponentPage:Dispose()
	self.infoList = nil

	self.opponentUIList_:Dispose()

	self.opponentUIList_ = nil

	EnterBattleSelectOpponentPage.super.Dispose(self)
end

return EnterBattleSelectOpponentPage
