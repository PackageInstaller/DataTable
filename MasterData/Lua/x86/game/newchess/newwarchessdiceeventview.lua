local NewWarChessDiceEventView = class("NewWarChessDiceEventView", ReduxView)

function NewWarChessDiceEventView:UIName()
	return "UI/NewWarChess/NewWarChessDiceUI"
end

function NewWarChessDiceEventView:UIParent()
	return manager.ui.uiMain.transform
end

function NewWarChessDiceEventView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessDiceEventView:InitUI()
	self:BindCfgUI()

	self.diceFrameClickHandler_ = handler(self, self.OnDiceFrameClick)
	self.diceClickHandler_ = handler(self, self.OnDiceClick)
	self.skillClickHandler_ = handler(self, self.OnSkillItemClick)
	self.diceFramActiveController_ = ControllerUtil.GetController(self.diceframeListGo_.transform, "num")
	self.diceFramSymbolController_ = ControllerUtil.GetController(self.diceframeListGo_.transform, "symbol")
	self.yesBtnController_ = ControllerUtil.GetController(self.yesbtn_.transform, "disable")
	self.diceFrameItem_ = {}

	for iter_4_0 = 1, 3 do
		self.diceFrameItem_[iter_4_0] = NewWarChessDiceFrameItem.New(self["diceframe" .. iter_4_0 .. "_"], self.diceFrameClickHandler_, iter_4_0)
	end

	self.diceList_ = LuaList.New(handler(self, self.IndexDice), self.diceListGo_, NewWarChessDiceItem)
	self.skillList_ = LuaList.New(handler(self, self.IndexSkill), self.skillListGo_, NewWarChessSkillItem)
end

function NewWarChessDiceEventView:OnDiceUpdate()
	self:RefreshDiceList()
	self:RefreshDiceFrameList()
end

function NewWarChessDiceEventView:RefreshDiceList()
	self.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	self.diceList_:StartScroll(#self.diceDataList_)
end

function NewWarChessDiceEventView:AddUIListener()
	self:AddBtnListener(self.backbtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.yesbtn_, nil, function()
		if not self.yesBtnClickAble_ then
			return
		end

		local var_9_0 = {}

		for iter_9_0 = 1, #self.diceFrameIDList_ do
			table.insert(var_9_0, self.diceFrameItem_[iter_9_0].dicePoint_)
		end

		if self.chanceItemCfg_.jump_event[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
			NewWarChessAction.SelectChanceItem(self.chanceItemID_, var_9_0, function()
				if not BattleNewWarChessStageCfg[self.chanceItemCfg_.jump_event[2]] then
					-- block empty
				end

				if NewWarChessData:CheckIsAllDie() then
					ShowTips("ACTIVITY_NEW_WARCHESS_ALL_HERO_DIE")

					return
				end

				local var_10_0 = {}

				if self.chanceItemCfg_.jump_event[5] then
					local var_10_1 = 0

					for iter_10_0, iter_10_1 in pairs(var_9_0) do
						var_10_1 = var_10_1 + iter_10_1
					end

					for iter_10_2, iter_10_3 in pairs(self.chanceItemCfg_.jump_event[5]) do
						local var_10_2 = deepClone(iter_10_3)

						var_10_2[2] = var_10_1

						table.insert(var_10_0, var_10_2)
					end
				end

				manager.NewChessManager:BattleStart(self.chanceID_, self.chanceItemID_, var_9_0, var_10_0)
				gameContext:Go("/sectionSelectHero", {
					section = self.chanceItemCfg_.jump_event[2],
					sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS,
					activityID = NewWarChessData:GetCurrentActivity()
				})
			end)
		else
			NewWarChessAction.SelectChanceItem(self.chanceItemID_, var_9_0, function()
				self:ExecuteChanceItem(self.chanceItemID_)
			end)
		end
	end)
end

function NewWarChessDiceEventView:IndexSkill(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.skillDataList_[arg_12_1])
	arg_12_2:SetClickCallBack(self.skillClickHandler_)
	arg_12_2:BindSkillRedPoint()
end

function NewWarChessDiceEventView:OnSkillItemClick(arg_13_1)
	JumpTools.OpenPageByJump("/newWarChessDiceSkillView", {
		skillID = arg_13_1
	})
end

function NewWarChessDiceEventView:OnDiceClick(arg_14_1)
	NewWarChessData:ClearAniCache()

	if self.diceDataList_[arg_14_1].hasInput == true then
		for iter_14_0 = 1, #self.diceFrameIDList_ do
			if self.diceFrameItem_[iter_14_0].diceIndex_ == arg_14_1 then
				self.diceDataList_[arg_14_1].hasInput = false

				self.diceFrameItem_[iter_14_0]:ResetDiceData()
				self.diceFrameItem_[iter_14_0]:RefreshUI()
				self:RefreshDiceList()
				self:RefreshBtn()
				self:RefreshUIText()

				return
			end
		end
	end

	local var_14_0 = self.diceDataList_[arg_14_1][1]
	local var_14_1 = 0
	local var_14_2 = 0

	for iter_14_1 = 1, #self.diceFrameIDList_ do
		if self.diceFrameItem_[iter_14_1].dicePoint_ > 0 then
			var_14_1 = var_14_1 + self.diceFrameItem_[iter_14_1].dicePoint_
			var_14_2 = var_14_2 + 1
		end
	end

	if var_14_2 < #self.diceFrameIDList_ then
		if self.diceLimitType_ == NewChessConst.DICE_LIMIT_TYPE.TWAIN then
			local var_14_3 = 0

			for iter_14_2 = 1, #self.diceFrameIDList_ do
				if self.diceFrameItem_[iter_14_2].dicePoint_ ~= 0 then
					var_14_3 = self.diceFrameItem_[iter_14_2].dicePoint_

					break
				end
			end

			if var_14_3 > 0 and var_14_0 ~= var_14_3 then
				ShowTips("ACTIVITY_NEW_WARCHESS_DICE_NOT_IS_TWAIN")

				return
			end
		end

		if self.outputLimit_ ~= 0 then
			if var_14_1 + var_14_0 > self.outputLimit_ then
				ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), self.outputLimit_))

				return
			end

			if var_14_2 == #self.diceFrameIDList_ - 1 then
				if var_14_1 + var_14_0 < self.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_SMALLER"), self.outputLimit_))

					return
				elseif var_14_1 + var_14_0 > self.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), self.outputLimit_))

					return
				end
			end
		end

		for iter_14_3 = 1, #self.diceFrameIDList_ do
			if self.diceFrameItem_[iter_14_3]:CheckInputLimit(arg_14_1) then
				self.diceFrameItem_[iter_14_3]:SetInputDice(arg_14_1)

				self.diceDataList_[arg_14_1].hasInput = true

				self:RefreshDiceList()
				self:RefreshBtn()
				self:RefreshUIText()

				return
			end
		end

		ShowTips("ACTIVITY_NEW_WARCHESS_DICE_UNDESIRABLE")
	end
end

function NewWarChessDiceEventView:OnDiceFrameClick(arg_15_1)
	if self.diceFrameItem_[arg_15_1].diceIndex_ ~= 0 then
		self.diceDataList_[self.diceFrameItem_[arg_15_1].diceIndex_].hasInput = false

		self.diceFrameItem_[arg_15_1]:ResetDiceData()
		self.diceFrameItem_[arg_15_1]:RefreshUI()
		self:RefreshBtn()
		self:RefreshUIText()
		self:RefreshDiceList()
	end
end

function NewWarChessDiceEventView:OnEnter()
	self.chanceID_ = self.params_.chanceID
	self.chanceCfg_ = NewWarChessChanceCfg[self.chanceID_]
	self.chanceItemID_ = self.params_.chanceItemID
	self.chanceItemCfg_ = NewWarChessChanceItemCfg[self.chanceItemID_]
	self.eventPoolCfg_ = NewWarChessEventPoolCfg[self.chanceItemCfg_.new_warchess_event]
	self.diceEventCfg_ = NewWarChessDiceEventCfg[self.chanceItemCfg_.dice_type]
	self.diceFrameIDList_ = self.diceEventCfg_.dice_configuration
	self.diceLimitType_ = self.diceEventCfg_.dice_limit_type
	self.outputLimit_ = self.diceEventCfg_.dice_limit_output

	self:RefreshUI()
end

function NewWarChessDiceEventView:RefreshSkillList()
	self.skillDataList_ = NewWarChessData:GetSkillList()

	self.skillList_:StartScroll(#self.skillDataList_)
end

function NewWarChessDiceEventView:RefreshUI()
	self:RefreshBtn()
	self:RefreshUIText()
	self:RefreshDiceList()
	self:RefreshDiceFrameList()
	self:RefreshSkillList()
end

function NewWarChessDiceEventView:RefreshBtn()
	for iter_19_0 = 1, #self.diceFrameIDList_ do
		if self.diceFrameItem_[iter_19_0].dicePoint_ == 0 then
			self.yesBtnController_:SetSelectedState("true")

			self.yesBtnClickAble_ = false

			return
		end
	end

	self.yesBtnClickAble_ = true

	self.yesBtnController_:SetSelectedState("false")
end

function NewWarChessDiceEventView:RefreshUIText()
	self.nameText_.text = self.chanceItemCfg_.name
	self.destext_.text = NewChessTools.GetChanceDes(self.chanceCfg_)
	self.diceDescText_.text = self.diceEventCfg_.dice_description

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(self.diceFrameItem_) do
		if iter_20_1.dicePoint_ ~= 0 then
			table.insert(var_20_0, iter_20_1.dicePoint_)
		end
	end

	self.eventDescText_.text = NewChessTools.GetDiceEventDes(self.chanceItemCfg_, var_20_0, self.yesBtnClickAble_)
end

function NewWarChessDiceEventView:IndexDice(arg_21_1, arg_21_2)
	arg_21_2:SetData(arg_21_1, self.diceDataList_[arg_21_1])
	arg_21_2:SetClickCallBack(self.diceClickHandler_)
end

function NewWarChessDiceEventView:RefreshDiceFrameList()
	if self.diceLimitType_ == NewChessConst.DICE_LIMIT_TYPE.TWAIN then
		self.diceFramSymbolController_:SetSelectedState("double")
	elseif self.outputLimit_ ~= 0 then
		self.diceFramSymbolController_:SetSelectedState("add")
	else
		self.diceFramSymbolController_:SetSelectedState("empty")
	end

	self.diceFramActiveController_:SetSelectedState(tostring(#self.diceFrameIDList_))

	for iter_22_0 = 1, 3 do
		self.diceFrameItem_[iter_22_0]:SetData(self.diceFrameIDList_[iter_22_0] or 0)
	end
end

function NewWarChessDiceEventView:ExecuteChanceItem(arg_23_1)
	self:ExecuteNewWarChessEvent(arg_23_1)
	self:ExecuteChanceJumpEvent(NewWarChessChanceItemCfg[arg_23_1].jump_event)
end

function NewWarChessDiceEventView:ExecuteNewWarChessEvent(arg_24_1)
	local var_24_0 = {}

	for iter_24_0 = 1, #self.diceFrameIDList_ do
		table.insert(var_24_0, self.diceFrameItem_[iter_24_0].dicePoint_)
	end

	NewWarChessData:RemoveDice(var_24_0)

	if NewWarChessChanceItemCfg[arg_24_1].new_warchess_event ~= 0 then
		manager.NewChessManager:ExecutChess(NewChessConst.TIMING_CHANCE_CHOOSE, manager.NewChessManager:GetChanceInteracChess(), (NewWarChessData:GetServerEvent(NewChessConst.TIMING_CHANCE_CHOOSE, {
			arg_24_1
		})))
		manager.NewChessManager:StartExecuteEvent()
	end
end

function NewWarChessDiceEventView:ExecuteChanceJumpEvent(arg_25_1)
	if arg_25_1[1] then
		if arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.NEW_CHANCE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.SELECT_CHANCE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.DICE_SWITCH_CHANCE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.DICE_SUM_SWITCH_CHANCE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.ATTRIBUTE_SWITCH_CHANCE then
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = NewWarChessData:GetServerChanceID()
			})
		elseif arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHOUTSAVE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		end
	end
end

function NewWarChessDiceEventView:OnTop()
	self:RefreshUI()
end

function NewWarChessDiceEventView:OnExit()
	NewWarChessData:ClearDiceContinuousList()

	for iter_27_0 = 1, 3 do
		self.diceFrameItem_[iter_27_0]:ResetData()
	end
end

function NewWarChessDiceEventView:Dispose()
	self.diceFrameClickHandler_ = nil
	self.skillClickHandler_ = nil

	for iter_28_0, iter_28_1 in pairs(self.diceFrameItem_) do
		iter_28_1:Dispose()
	end

	self.diceFrameItem_ = nil

	if self.diceList_ then
		self.diceList_:Dispose()

		self.diceList_ = nil
	end

	if self.skillList_ then
		self.skillList_:Dispose()

		self.skillList_ = nil
	end

	NewWarChessDiceEventView.super.Dispose(self)
end

return NewWarChessDiceEventView
