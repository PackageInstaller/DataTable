local NewWarChessDiceSkillView = class("NewWarChessDiceSkillView", ReduxView)

function NewWarChessDiceSkillView:UIName()
	return "UI/NewWarChess/NewWarChessDiceSkillView"
end

function NewWarChessDiceSkillView:UIParent()
	return manager.ui.uiPop.transform
end

function NewWarChessDiceSkillView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessDiceSkillView:InitUI()
	self:BindCfgUI()

	self.diceFrameClickHandler_ = handler(self, self.OnDiceFrameClick)
	self.diceClickHandler_ = handler(self, self.OnDiceClick)
	self.diceFramActiveController_ = ControllerUtil.GetController(self.diceframeListGo_.transform, "num")
	self.diceFramSymbolController_ = ControllerUtil.GetController(self.diceframeListGo_.transform, "symbol")
	self.yesBtnController_ = ControllerUtil.GetController(self.yesBtn_.transform, "enabled")
	self.diceFrameItem_ = {}

	for iter_4_0 = 1, 3 do
		self.diceFrameItem_[iter_4_0] = NewWarChessDiceFrameItem.New(self["diceframe" .. iter_4_0 .. "_"], self.diceFrameClickHandler_, iter_4_0)
	end

	self.diceList_ = LuaList.New(handler(self, self.IndexDice), self.diceListGo_, NewWarChessDiceItem)
end

function NewWarChessDiceSkillView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.yesBtn_, nil, function()
		if not self.yesBtnClickAble_ then
			return
		end

		local var_7_0 = {}

		for iter_7_0 = 1, #self.diceFrameIDList_ do
			table.insert(var_7_0, self.diceFrameItem_[iter_7_0].dicePoint_)
		end

		NewWarChessAction.UseDiceSkill(self.skillID_, var_7_0, function()
			NewWarChessData:RemoveDice(var_7_0)
			NewWarChessData:UseSkill(self.skillID_)
			JumpTools.Back()
		end)
	end)
	self:AddBtnListener(self.mask_, nil, function()
		JumpTools.Back()
	end)
end

function NewWarChessDiceSkillView:IndexSkill(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1)
end

function NewWarChessDiceSkillView:OnDiceClick(arg_11_1)
	NewWarChessData:ClearAniCache()

	if self.diceDataList_[arg_11_1].hasInput == true then
		for iter_11_0 = 1, #self.diceFrameIDList_ do
			if self.diceFrameItem_[iter_11_0].diceIndex_ == arg_11_1 then
				self.diceDataList_[arg_11_1].hasInput = false

				self.diceFrameItem_[iter_11_0]:ResetDiceData()
				self.diceFrameItem_[iter_11_0]:RefreshUI()
				self:RefreshDiceList()
				self:RefreshBtn()
				self:RefreshUIText()

				return
			end
		end
	end

	local var_11_0 = self.diceDataList_[arg_11_1][1]
	local var_11_1 = 0
	local var_11_2 = 0

	for iter_11_1 = 1, #self.diceFrameIDList_ do
		if self.diceFrameItem_[iter_11_1].dicePoint_ > 0 then
			var_11_1 = var_11_1 + self.diceFrameItem_[iter_11_1].dicePoint_
			var_11_2 = var_11_2 + 1
		end
	end

	if var_11_2 < #self.diceFrameIDList_ then
		if self.diceLimitType_ == NewChessConst.DICE_LIMIT_TYPE.TWAIN then
			local var_11_3 = 0

			for iter_11_2 = 1, #self.diceFrameIDList_ do
				if self.diceFrameItem_[iter_11_2].dicePoint_ ~= 0 then
					var_11_3 = self.diceFrameItem_[iter_11_2].dicePoint_

					break
				end
			end

			if var_11_3 > 0 and var_11_0 ~= var_11_3 then
				ShowTips("ACTIVITY_NEW_WARCHESS_DICE_NOT_IS_TWAIN")

				return
			end
		end

		if self.outputLimit_ ~= 0 then
			if var_11_1 + var_11_0 > self.outputLimit_ then
				ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), self.outputLimit_))

				return
			end

			if var_11_2 == #self.diceFrameIDList_ - 1 then
				if var_11_1 + var_11_0 < self.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_SMALLER"), self.outputLimit_))

					return
				elseif var_11_1 + var_11_0 > self.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), self.outputLimit_))

					return
				end
			end
		end

		for iter_11_3 = 1, #self.diceFrameIDList_ do
			if self.diceFrameItem_[iter_11_3]:CheckInputLimit(arg_11_1) then
				self.diceFrameItem_[iter_11_3]:SetInputDice(arg_11_1)

				self.diceDataList_[arg_11_1].hasInput = true

				self:RefreshDiceList()
				self:RefreshBtn()
				self:RefreshUIText()

				return
			end
		end

		ShowTips("ACTIVITY_NEW_WARCHESS_DICE_UNDESIRABLE")
	end
end

function NewWarChessDiceSkillView:OnDiceFrameClick(arg_12_1)
	if self.diceFrameItem_[arg_12_1].diceIndex_ ~= 0 then
		self.diceDataList_[self.diceFrameItem_[arg_12_1].diceIndex_].hasInput = false

		self.diceFrameItem_[arg_12_1]:ResetDiceData()
		self.diceFrameItem_[arg_12_1]:RefreshUI()
		self:RefreshUI()
	end
end

function NewWarChessDiceSkillView:OnEnter()
	self.skillID_ = self.params_.skillID
	self.skillCfg_ = NewWarChessDiceSkillCfg[self.skillID_]
	self.data_ = NewWarChessData:GetSkillInfo(self.skillID_)
	self.leftUseLimit_ = self.data_.useLimit
	self.totalUseLimit_ = self.skillCfg_.use_limit

	if self.skillCfg_.dice_type > 0 then
		self.diceEventCfg_ = NewWarChessDiceEventCfg[self.skillCfg_.dice_type]
		self.diceFrameIDList_ = self.diceEventCfg_.dice_configuration
		self.diceLimitType_ = self.diceEventCfg_.dice_limit_type
		self.outputLimit_ = self.diceEventCfg_.dice_limit_output
	end

	self:RefreshUI()
	self:RefreshDiceFrameList()
end

function NewWarChessDiceSkillView:RefreshUI()
	self:RefreshUIText()
	self:RefreshBtn()
	self:RefreshDiceList()
end

function NewWarChessDiceSkillView:RefreshBtn()
	for iter_15_0 = 1, #self.diceFrameIDList_ do
		if self.diceFrameItem_[iter_15_0].dicePoint_ == 0 then
			self.yesBtnController_:SetSelectedState("false")

			self.yesBtnClickAble_ = false

			return
		end
	end

	self.yesBtnClickAble_ = true

	self.yesBtnController_:SetSelectedState("true")
end

function NewWarChessDiceSkillView:RefreshUIText()
	self.skillDescText_.text = self.skillCfg_.description
	self.skillNameText_.text = self.skillCfg_.name
	self.iconImage_.sprite = getSprite("Atlas/NewWarChess", self.skillCfg_.icon)
	self.useText_.text = self.leftUseLimit_ .. "/" .. self.totalUseLimit_
	self.simpleDescText_.text = self.skillCfg_.simple_description
end

function NewWarChessDiceSkillView:RefreshDiceList()
	self.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	self.diceList_:StartScroll(#self.diceDataList_)
end

function NewWarChessDiceSkillView:IndexDice(arg_18_1, arg_18_2)
	arg_18_2:SetData(arg_18_1, self.diceDataList_[arg_18_1])
	arg_18_2:SetClickCallBack(self.diceClickHandler_)
end

function NewWarChessDiceSkillView:RefreshDiceFrameList()
	if self.skillCfg_.dice_type > 0 then
		self.diceDescText_.text = self.diceEventCfg_.dice_description

		SetActive(self.relesGo_, true)

		if self.diceLimitType_ == 1 then
			self.diceFramSymbolController_:SetSelectedState("double")
		elseif self.outputLimit_ ~= 0 then
			self.diceFramSymbolController_:SetSelectedState("add")
		else
			self.diceFramSymbolController_:SetSelectedState("empty")
		end

		self.diceFramActiveController_:SetSelectedState(tostring(#self.diceFrameIDList_))

		for iter_19_0 = 1, 3 do
			self.diceFrameItem_[iter_19_0]:SetData(self.diceFrameIDList_[iter_19_0] or 0)
		end
	else
		SetActive(self.relesGo_, false)
	end
end

function NewWarChessDiceSkillView:OnExit()
	NewWarChessData:ClearDiceContinuousList()

	for iter_20_0 = 1, 3 do
		self.diceFrameItem_[iter_20_0]:ResetData()
	end
end

function NewWarChessDiceSkillView:Dispose()
	for iter_21_0, iter_21_1 in pairs(self.diceFrameItem_) do
		iter_21_1:Dispose()
	end

	if self.diceList_ then
		self.diceList_:Dispose()

		self.diceList_ = nil
	end

	self.diceFrameItem_ = nil
	self.diceFrameClickHandler_ = nil

	NewWarChessDiceSkillView.super.Dispose(self)
end

return NewWarChessDiceSkillView
