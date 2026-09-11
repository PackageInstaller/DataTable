local AutoChessOpenCardItem = class("AutoChessOpenCardItem", ReduxView)

function AutoChessOpenCardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessOpenCardItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessOpenCardItem:InitUI()
	self.btnController_ = self.controller_:GetController("Btn")
	self.isCompleteController_ = self.controller_:GetController("completeBtn")
end

function AutoChessOpenCardItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if self.activityId_ == ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD then
			if not ActivityData:GetActivityIsOpen(self.activityId_) then
				return
			end

			if AutoChessCardData:GetFriendCardList() == nil then
				AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.FRIEND, function()
					if AutoChessCardData:GetOtherCardList() == nil then
						AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER, function()
							JumpTools.OpenPageByJump("/autoChessDesireMainView")
						end)
					else
						JumpTools.OpenPageByJump("/autoChessDesireMainView")
					end
				end)
			elseif AutoChessCardData:GetOtherCardList() == nil then
				AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER, function()
					JumpTools.OpenPageByJump("/autoChessDesireMainView")
				end)
			else
				JumpTools.OpenPageByJump("/autoChessDesireMainView")
			end
		elseif self.activityId_ == ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8 then
			if AutoChessCardData:GetCardBagPower() >= GameSetting.auto_chess_2_pack_energy_max.value[1] then
				saveData("auto_chess_4_8", "card_power_is_show", 0)
			end

			manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
			JumpTools.OpenPageByJump("/autoChessRemakeMainView", {
				isStartMatch = true
			})
		end
	end)
end

function AutoChessOpenCardItem:SetData(arg_9_1)
	self.activityId_ = arg_9_1

	self:RefreshUI()
end

function AutoChessOpenCardItem:RefreshUI()
	local var_10_1 = 0

	if self.activityId_ == ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD then
		self.txtTitle_.text = GetTips("AUTO_CHESS_2_SOURCE_EXCHANGE")

		local var_10_2 = GameSetting.auto_chess_2_exchange_reward_pack_num.value[1]

		var_10_1 = AutoChessCardData:GetIsDayReward() == 1 and 0 or var_10_2
		self.txtNum_.text = string.format("%d/%d", var_10_1, var_10_2)
	else
		self.txtTitle_.text = GetTips("AUTO_CHESS_2_SOURCE_BATTLE")
		var_10_1 = AutoChessCardData:GetCardBagPower()
		self.txtNum_.text = string.format("%d/%d", var_10_1, GameSetting.auto_chess_2_pack_energy_max.value[1])
	end

	if var_10_1 == 0 then
		self.btnController_:SetSelectedState("completeBtn")
		self.isCompleteController_:SetSelectedState("on")
	else
		self.btnController_:SetSelectedState("goBtn")
	end
end

function AutoChessOpenCardItem:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function AutoChessOpenCardItem:GetBtnTransform()
	return self.goBtn_.transform
end

function AutoChessOpenCardItem:Dispose()
	AutoChessOpenCardItem.super.Dispose(self)
end

return AutoChessOpenCardItem
