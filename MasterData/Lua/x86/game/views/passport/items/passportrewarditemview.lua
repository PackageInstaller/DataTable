local PassportRewardItemView = class("PassportRewardItemView", ReduxView)

function PassportRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PassportRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function PassportRewardItemView:InitUI()
	self:BindCfgUI()

	self.commonItem1_ = CommonItemView.New(self.commonItemGo1_)
	self.commonItem2_ = CommonItemView.New(self.commonItemGo2_)
	self.CommonData1 = clone(ItemTemplateData)
	self.CommonData2 = clone(ItemTemplateData)
end

function PassportRewardItemView:AddEventListeners()
	self:RegistEventListener(GET_BONUS_SUCCESS, handler(self, self.OnGetBonus))
	self:RegistEventListener(PASSPORT_BUYED, handler(self, self.OnPassportBuyed))
end

function PassportRewardItemView:OnPassportBuyed()
	self:UpdateView()
end

function PassportRewardItemView:OnGetBonus(arg_6_1)
	if arg_6_1 == self.cfg_.id or arg_6_1 == 0 then
		self:UpdateView()
	end
end

function PassportRewardItemView:SetData(arg_7_1, arg_7_2)
	self.index_ = arg_7_1
	self.cfg_ = BattlePassCfg[arg_7_2]
	self.levelCfg_ = GameLevelSetting[self.index_]

	self:UpdateView()
end

function PassportRewardItemView:UpdateView()
	self.levelLabel_.text = string.format("%d", self.index_)
	self.bottomLabel_.text = string.format("%d", self.index_)

	local var_8_0 = PassportData:GetRewardStatus(self.index_, self.cfg_.id)
	local var_8_1 = {
		id = self.cfg_.reward_free[1][1],
		number = self.cfg_.reward_free[1][2],
		clickFun = function(self)
			self:OnItemClick(self.id, self.number, 1)
		end
	}
	local var_8_2 = {
		id = self.cfg_.reward_pay[1][1],
		number = self.cfg_.reward_pay[1][2],
		clickFun = function(self)
			self:OnItemClick(self.id, self.number, 2)
		end
	}

	var_8_1.highLight = false
	var_8_1.completedFlag = false
	var_8_2.highLight = false
	var_8_2.completedFlag = false
	var_8_2.locked = false

	if PassportData:GetPayLevel() <= 0 then
		var_8_2.locked = true
	end

	if var_8_0 == "payHaveGet" then
		var_8_2.completedFlag = true
		var_8_1.completedFlag = true
	elseif var_8_0 == "payCanGet" then
		var_8_2.highLight = true
		var_8_1.highLight = true
	elseif var_8_0 == "freeHaveGet" then
		var_8_1.completedFlag = true
	elseif var_8_0 == "freeCanGet" then
		var_8_1.highLight = true

		SetActive(self.redGo1_, true)
	elseif var_8_0 == "payHalfCanGet" then
		var_8_1.completedFlag = true
		var_8_2.highLight = true
	end

	CommonTools.SetCommonData(self.commonItem1_, var_8_1, self.CommonData1)
	CommonTools.SetCommonData(self.commonItem2_, var_8_2, self.CommonData2)
end

function PassportRewardItemView:AddUIListener()
	return
end

function PassportRewardItemView:OnItemClick(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 == 1 and PassportData:GetRewardStatus(self.index_, self.cfg_.id) ~= "freeCanGet" and PassportData:GetRewardStatus(self.index_, self.cfg_.id) ~= "payCanGet" then
		if arg_12_1 ~= 0 and arg_12_2 ~= 0 then
			ShowPopItem(POP_ITEM, {
				arg_12_1,
				arg_12_2
			})
		end

		return
	end

	if arg_12_3 == 2 and PassportData:GetRewardStatus(self.index_, self.cfg_.id) ~= "payCanGet" and PassportData:GetRewardStatus(self.index_, self.cfg_.id) ~= "payHalfCanGet" then
		if arg_12_1 ~= 0 and arg_12_2 ~= 0 then
			ShowPopItem(POP_ITEM, {
				arg_12_1,
				arg_12_2
			})
		end

		return
	end

	if PassportData:GetPayLevel() > 0 then
		PassportAction.RequestGetBonus(self.cfg_.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	else
		local var_12_0 = PassportData:GetLevel()
		local var_12_1 = PassportData:GetReceiveInfo()
		local var_12_2 = false

		for iter_12_0, iter_12_1 in ipairs(GameSetting.battlepass_level_noti.value) do
			if PassportData:GetReceiveInfo(BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type][iter_12_1]) or var_12_0 < iter_12_1 then
				var_12_2 = false
			else
				var_12_2 = true

				break
			end
		end

		if var_12_2 then
			JumpTools.OpenPageByJump("passportBuyPopView")
		else
			PassportAction.RequestGetBonus(self.cfg_.id, PassportData:GetPayLevel() > 0 and 1 or 0)
		end
	end
end

function PassportRewardItemView:Dispose()
	self:RemoveAllEventListener()

	if self.commonItem1_ then
		self.commonItem1_:Dispose()

		self.commonItem1_ = nil
	end

	if self.commonItem2_ then
		self.commonItem2_:Dispose()

		self.commonItem2_ = nil
	end

	self.CommonData1 = nil
	self.CommonData2 = nil

	PassportRewardItemView.super.Dispose(self)
end

return PassportRewardItemView
