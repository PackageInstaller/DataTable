local WeaponModuleConditionItem = class("WeaponModuleConditionItem", ReduxView)

function WeaponModuleConditionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
	self:AddUIListener()
end

function WeaponModuleConditionItem:Init()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.controller_ = ControllerUtil.GetController(self.transform_, "condition")
end

function WeaponModuleConditionItem:AddUIListener()
	self:AddBtnListener(self.jumpBtn_, nil, function()
		JumpTools.JumpToPage(self.source_)
	end)
end

function WeaponModuleConditionItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.desText_.text = GetI18NText(ConditionCfg[arg_5_1].desc)

	if ConditionCfg[arg_5_1].type == 5001 then
		self.desText_.text = string.format(GetI18NText(ConditionCfg[arg_5_1].desc), GetI18NText(StoryCfg[HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[arg_5_2][1]].plot_id[#HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[arg_5_2][1]].plot_id]].name))
	end

	if IsConditionAchieved(arg_5_1, {
		heroId = arg_5_2
	}) then
		self.controller_:SetSelectedState("clear")
		SetActive(self.jumpBtn_.gameObject, false)
	else
		self.controller_:SetSelectedState("notClear")

		if arg_5_3 and arg_5_3[1] then
			self.source_ = arg_5_3

			SetActive(self.jumpBtn_.gameObject, true)
		else
			SetActive(self.jumpBtn_.gameObject, false)
		end
	end
end

function WeaponModuleConditionItem:SetIsShow(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function WeaponModuleConditionItem:Dispose()
	WeaponModuleConditionItem.super.Dispose(self)
end

return WeaponModuleConditionItem
