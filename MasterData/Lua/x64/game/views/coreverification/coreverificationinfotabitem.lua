local CoreVerificationInfoTabItem = class("CoreVerificationInfoTabItem", ReduxView)

function CoreVerificationInfoTabItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationInfoTabItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationInfoTabItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
end

function CoreVerificationInfoTabItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		if self.click_ then
			self.click_()
		end
	end)
end

function CoreVerificationInfoTabItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.click_ = arg_6_4

	local var_6_0 = CoreVerificationData:GetInfoCfgByTypeAndDiff(arg_6_1, arg_6_2)
	local var_6_1 = CoreVerificationData:GetStageIdByTypeAndDiff(arg_6_1, arg_6_2 - 1)
	local var_6_2 = CoreVerificationData:GetStageInfoByTypeAndDiff(arg_6_1, arg_6_2 - 1)
	local var_6_3 = CoreVerificationData:IsOpenChallgeByType(1)
	local var_6_4 = CoreVerificationData:IsOpenChallgeByType(2)

	self.nameText_.text = ""

	local var_6_5 = PlayerData:GetPlayerInfo().userLevel < var_6_0.unlock_level

	if CoreVerificationData:IsChallengeType(var_6_0.id) then
		if var_6_3 and var_6_4 and not var_6_5 then
			self.lockController_:SetSelectedState("false")
		else
			self.lockController_:SetSelectedState("true")
		end

		self.diffText_.text = GetTips("CORE_VERIFICATION_TAB_DES_2")
	else
		if arg_6_2 == 1 or var_6_2 then
			self.lockController_:SetSelectedState("false")
		else
			self.lockController_:SetSelectedState("true")
		end

		self.diffText_.text = string.format(GetTips("CORE_VERIFICATION_TAB_DES_1"), arg_6_2)

		if var_6_5 then
			self.lockController_:SetSelectedState("true")
		end
	end

	self.selectController_:SetSelectedState(arg_6_2 == arg_6_3 and "true" or "false")
end

function CoreVerificationInfoTabItem:Select(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function CoreVerificationInfoTabItem:Dispose()
	CoreVerificationInfoTabItem.super.Dispose(self)
end

return CoreVerificationInfoTabItem
