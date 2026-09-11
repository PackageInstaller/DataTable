local CanteenSkillItem = class("CanteenSkillItem", ReduxView)

function CanteenSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function CanteenSkillItem:InitUI()
	self:BindCfgUI()

	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
end

function CanteenSkillItem:RefreshUI(arg_3_1, arg_3_2, arg_3_3)
	self.lockController:SetSelectedState("unlock")

	self.iconskillImg_.sprite = CanteenTools.GetCanteenSkillSprite(arg_3_1)
	self.skillDec_.text = GetI18NText(DormSkillData:GetSkillDesc(arg_3_1))
	self.skillName_.text = GetI18NText(BackHomeHeroSkillCfg[arg_3_1].name)

	if arg_3_2 then
		local var_3_0 = 0

		if arg_3_3 == 1 then
			var_3_0 = GameSetting.dorm_hero_skill_unlock.value[1]
		elseif arg_3_3 == 2 then
			var_3_0 = GameSetting.dorm_hero_skill_unlock.value[2]
		end

		if arg_3_2 < var_3_0 then
			self.lockController:SetSelectedState("lock")

			self.unLockConText_.text = string.format(GetTips("DORM_CANTEEN_UNLOCK"), var_3_0)
		end
	end
end

function CanteenSkillItem:Dispose()
	CanteenSkillItem.super.Dispose(self)
end

return CanteenSkillItem
