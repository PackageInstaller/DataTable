local NewWarChessChanceView = class("NewWarChessChanceView", ReduxView)

function NewWarChessChanceView:UIName()
	return "UI/NewWarChess/NewWarChessChanceUI"
end

function NewWarChessChanceView:UIParent()
	return manager.ui.uiMain.transform
end

function NewWarChessChanceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessChanceView:InitUI()
	self:BindCfgUI()

	self.executeChanceItemHandle_ = handler(self, self.ExecuteChanceItem)
	self.itemList_ = {}
	self.diceList_ = LuaList.New(handler(self, self.IndexDiceItem), self.diceListGo_, NewWarChessDiceItem)
	self.isShowingBuff_ = false
	self.curShowBuffIndex_ = 0
	self.buffList_ = LuaList.New(handler(self, self.IndexBuffItem), self.buffList_, NewWarChessBuffItem)
	self.clickBuffHandler_ = handler(self, self.OnClickBuff)
end

function NewWarChessChanceView:IndexDiceItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.diceDataList_[arg_5_1])
	arg_5_2:SetClickCallBack(function(arg_6_0)
		NewWarChessData:ClearAniCache()
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_CHECK_DICE_TO_MOVEPOINT"), arg_5_2.dicePoint_, arg_5_2.dicePoint_),
			OkCallback = function()
				local var_7_0 = arg_5_2.dicePoint_

				NewWarChessAction.DiceToMovePoint(arg_5_2.dicePoint_, function()
					local var_8_0 = math.floor(var_7_0 * (NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_TO_MOVE_POINT_TIMES") / 1000))

					NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", var_8_0)
					manager.NewChessManager:CreateTips({
						tipsType = NewChessConst.TIPS_TYPE.SWITCH,
						tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_TO_MOVEPOINT"), var_7_0, var_8_0),
						tipsDiceNum = var_7_0
					})
					NewWarChessData:RemoveDice({
						arg_5_2.dicePoint_
					})
					self:GoNewChance(self.chanceID_)
				end)
			end
		})
	end)
end

function NewWarChessChanceView:IndexBuffItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_1, self.curShowBuffIndex_, self.buffEntityList_[arg_9_1])
	arg_9_2:SetClickCallBack(self.clickBuffHandler_)
end

function NewWarChessChanceView:OnClickBuff(arg_10_1, arg_10_2, arg_10_3)
	if self.isShowingBuff_ then
		SetActive(self.buffInfoGo_, false)

		self.curShowBuffIndex_ = 0

		self.buffList_:Refresh()

		self.isShowingBuff_ = false
	else
		SetActive(self.buffInfoGo_, true)

		self.curShowBuffIndex_ = arg_10_1
		self.buffInfoNameText_.text = arg_10_2
		self.buffInfoDesText_.text = arg_10_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoContentTrans_)

		self.isShowingBuff_ = true
	end
end

function NewWarChessChanceView:AddUIListener()
	self:AddBtnListener(self.buffinfoBtn_, nil, function()
		if self.isShowingBuff_ then
			self.isShowingBuff_ = false
			self.curShowBuffIndex_ = 0

			SetActive(self.buffInfoGo_, false)
			self.buffList_:Refresh()
		end
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		NewChessTools.ExitNewChessScene(false)
	end)
end

function NewWarChessChanceView:OnEnter()
	if self.params_.chanceItemID then
		self:ExecuteChanceItem(self.params_.chanceItemID)

		self.params_.chanceItemID = nil
	else
		if self.params_.chanceID then
			self.chanceID_ = self.params_.chanceID
			self.params_.chanceID = nil
		end

		self:GoNewChance(self.chanceID_)
	end
end

function NewWarChessChanceView:OnTop()
	return
end

function NewWarChessChanceView:GoNewChance(arg_16_1)
	self.animator_:Play("ani")

	self.chanceID_ = arg_16_1
	self.cfg_ = NewWarChessChanceCfg[self.chanceID_]
	self.nametext_.text = self.cfg_.name
	self.desText_.text = NewChessTools.GetChanceDes(self.cfg_)
	self.chanceItemList_ = NewWarChessData:GetCurChanceItemList()

	local var_16_0 = 1

	for iter_16_0, iter_16_1 in pairs(self.chanceItemList_) do
		if not self.itemList_[var_16_0] then
			self.itemList_[var_16_0] = NewWarChessChanceItem.New((Object.Instantiate(self.chanceItemGo_, self.content_)))

			self.itemList_[var_16_0]:SetNewChanceHandle(self.executeChanceItemHandle_)
		end

		self.itemList_[var_16_0]:SetIsShow(true)
		self.itemList_[var_16_0]:SetData(self.chanceID_, self.chanceItemList_[var_16_0].chanceItemID)

		var_16_0 = var_16_0 + 1
	end

	for iter_16_2, iter_16_3 in pairs(self.itemList_) do
		if var_16_0 <= iter_16_2 then
			iter_16_3:SetIsShow(false)
		end
	end

	SetActive(self.buffInfoGo_, false)

	self.curShowBuffIndex_ = 0
	self.isShowingBuff_ = false

	self:RefreshDiceList()
	self:RefreshBuffList()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)
end

function NewWarChessChanceView:OnNewWarChessBuffUpDate()
	self:RefreshBuffList()
end

function NewWarChessChanceView:OnDiceUpdate()
	self:RefreshDiceList()
end

function NewWarChessChanceView:RefreshDiceList()
	self.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	self.diceList_:StartScroll(#self.diceDataList_)
end

function NewWarChessChanceView:RefreshBuffList()
	self.buffEntityList_ = manager.NewChessManager.buffManager_:GetActiveBuffEntityList()

	self.buffList_:StartScroll(#self.buffEntityList_)
end

function NewWarChessChanceView:ExecuteChanceItem(arg_21_1)
	self:ExecuteNewWarChessEvent(arg_21_1)
	self:ExecuteChanceJumpEvent(NewWarChessChanceItemCfg[arg_21_1].jump_event)
end

function NewWarChessChanceView:ExecuteNewWarChessEvent(arg_22_1)
	if NewWarChessChanceItemCfg[arg_22_1].new_warchess_event ~= 0 then
		manager.NewChessManager:ExecutChess(NewChessConst.TIMING_CHANCE_CHOOSE, manager.NewChessManager:GetChanceInteracChess(), (NewWarChessData:GetServerEvent(NewChessConst.TIMING_CHANCE_CHOOSE, {
			arg_22_1
		})))
		manager.NewChessManager:StartExecuteEvent()
	end
end

function NewWarChessChanceView:ExecuteChanceJumpEvent(arg_23_1)
	if arg_23_1[1] then
		if arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.NEW_CHANCE then
			self:GoNewChance(arg_23_1[2])
		elseif arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHOUTSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		elseif arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		elseif arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
			self:GoNewChance(arg_23_1[3])
		elseif arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.SELECT_CHANCE then
			if arg_23_1[3] <= NewWarChessData:GetAttribute(arg_23_1[2]) then
				self:GoNewChance(arg_23_1[4])
			else
				self:GoNewChance(arg_23_1[5])
			end
		end
	end
end

function NewWarChessChanceView:OnExit()
	NewWarChessData:ClearDiceContinuousList()
	self.diceList_:StopRender()
	self.buffList_:StopRender()
end

function NewWarChessChanceView:Dispose()
	for iter_25_0, iter_25_1 in pairs(self.itemList_) do
		iter_25_1:Dispose()
	end

	self.itemList_ = {}
	self.executeChanceItemHandle_ = nil

	if self.diceList_ then
		self.diceList_:Dispose()

		self.diceList_ = nil
	end

	if self.buffList_ then
		self.buffList_:Dispose()

		self.buffList_ = nil
	end

	self.clickBuffHandler_ = nil

	self.super.Dispose(self)
end

return NewWarChessChanceView
