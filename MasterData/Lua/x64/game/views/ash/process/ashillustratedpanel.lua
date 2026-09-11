local AshIllustratedPanel = class("AshIllustratedPanel", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/Panel/IllustratedPanel"
local var_0_2 = {
	Weapon = 1,
	Skill = 2,
	Prop = 3
}

function AshIllustratedPanel:Ctor(arg_1_1)
	self.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
	self.transform_ = self.gameObject_.transform
	self.transform_.parent = arg_1_1
	self.transform_.localPosition = Vector3.zero
	self.transform_.localRotation = Quaternion.identity
	self.transform_.localScale = Vector3.zero

	self:Init()
end

function AshIllustratedPanel:Init()
	self:BindCfgUI()

	self.context = {
		page = {
			[var_0_2.Prop] = nil,
			[var_0_2.Skill] = nil,
			[var_0_2.Weapon] = nil
		},
		pageScript = {
			[var_0_2.Prop] = AshILLPropPage,
			[var_0_2.Skill] = AshILLSkillPage,
			[var_0_2.Weapon] = AshILLWeaponPage
		},
		pageContainer = {
			[var_0_2.Prop] = self.propObj_.transform,
			[var_0_2.Skill] = self.skillObj_.transform,
			[var_0_2.Weapon] = self.weaponObj_.transform
		},
		pageState = {
			[var_0_2.Prop] = "prop",
			[var_0_2.Skill] = "skill",
			[var_0_2.Weapon] = "weapon"
		}
	}
	self.controller = self.controller_:GetController("tabSwitch")

	self:AddUIListener()
end

function AshIllustratedPanel:AddUIListener()
	self:AddBtnListener(self.weaponBtn_, nil, function()
		self:SwitchPage(var_0_2.Weapon)
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		self:SwitchPage(var_0_2.Skill)
	end)
	self:AddBtnListener(self.propBtn_, nil, function()
		self:SwitchPage(var_0_2.Prop)
	end)
end

function AshIllustratedPanel:ExitPanel(arg_7_1)
	self.transform_.localScale = Vector3.zero
end

function AshIllustratedPanel:SwitchPage(arg_8_1, arg_8_2)
	local var_8_0 = self.context.curPage
	local var_8_1

	if self.context.curPage == nil then
		var_8_1 = arg_8_1
	else
		if self.context.curPage ~= arg_8_1 then
			var_8_1 = arg_8_1
		end

		if arg_8_2 then
			var_8_1 = arg_8_1
		end
	end

	if var_8_0 and var_8_1 then
		self.context.page[var_8_0]:ExitPanel(self)
	end

	if var_8_1 then
		self.context.page[var_8_1] = self.context.page[var_8_1] or self.context.pageScript[var_8_1].New(self.context.pageContainer[var_8_1])
		self.context.curPage = var_8_1

		self.context.page[var_8_1]:EnterPanel(self)
		self.controller:SetSelectedState(self.context.pageState[var_8_1])
	end
end

function AshIllustratedPanel:PlayAnim(arg_9_1)
	local var_9_0 = arg_9_1:GetCustomSceneController()

	var_9_0:SwitchToShow(1)
	var_9_0:PlayHeroAnim("1083ui_dynamic", "GodHood_2", 0.1)
end

function AshIllustratedPanel:EnterPanel(arg_10_1)
	self.transform_.localScale = Vector3.one

	self:PlayAnim(arg_10_1)
	self:SwitchPage(var_0_2.Weapon, true)
end

function AshIllustratedPanel:Render()
	return
end

function AshIllustratedPanel:Dispose()
	for iter_12_0, iter_12_1 in pairs(var_0_2) do
		if self.context.page[iter_12_1] then
			self.context.page[iter_12_1]:Dispose()

			self.context.page[iter_12_1] = nil
		end
	end

	GameObject.DestroyImmediate(self.gameObject_)
	Asset.Unload(var_0_1)
	self.super.Dispose(self)
end

return AshIllustratedPanel
