local HeroFileGiftTrustLvUpTaskItem = class("HeroFileGiftTrustLvUpTaskItem", ReduxView)

function HeroFileGiftTrustLvUpTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroFileGiftTrustLvUpTaskItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileGiftTrustLvUpTaskItem:InitUI()
	self:BindCfgUI()

	self.completeStateController_ = self.conditionControllerEx_:GetController("completeState")
end

function HeroFileGiftTrustLvUpTaskItem:AddUIListener()
	return
end

function HeroFileGiftTrustLvUpTaskItem:SetData(arg_5_1, arg_5_2)
	self.nameText_.text = ConditionCfg[arg_5_1] and ConditionCfg[arg_5_1].type == 8023 and string.format(GetI18NText(ConditionCfg[arg_5_1].desc), HeroCfg[arg_5_2].suffix) or ConditionCfg[arg_5_1] and GetI18NText(ConditionCfg[arg_5_1].desc) or ""

	local var_5_1, var_5_2, var_5_3 = IsConditionAchieved(arg_5_1, {
		heroId = arg_5_2
	})
	local var_5_4 = math.min(var_5_2, var_5_3)

	if var_5_1 then
		self.completeStateController_:SetSelectedState("done")

		self.processText_.text = var_5_4 .. "/" .. var_5_3
	else
		self.completeStateController_:SetSelectedState("not")

		self.processText_.text = "<color=#F65632>" .. var_5_4 .. "</color>" .. "/" .. var_5_3
	end
end

function HeroFileGiftTrustLvUpTaskItem:Dispose()
	HeroFileGiftTrustLvUpTaskItem.super.Dispose(self)
end

return HeroFileGiftTrustLvUpTaskItem
