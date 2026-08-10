local var_0_0 = class("AshIllustratedPanel", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/Panel/IllustratedPanel"
local var_0_2 = {
	Weapon = 1,
	Skill = 2,
	Prop = 3
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.transform_.parent = arg_1_1
	arg_1_0.transform_.localPosition = Vector3.zero
	arg_1_0.transform_.localRotation = Quaternion.identity
	arg_1_0.transform_.localScale = Vector3.zero

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.context = {
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
			[var_0_2.Prop] = arg_2_0.propObj_.transform,
			[var_0_2.Skill] = arg_2_0.skillObj_.transform,
			[var_0_2.Weapon] = arg_2_0.weaponObj_.transform
		},
		pageState = {
			[var_0_2.Prop] = "prop",
			[var_0_2.Skill] = "skill",
			[var_0_2.Weapon] = "weapon"
		}
	}
	arg_2_0.controller = arg_2_0.controller_:GetController("tabSwitch")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.weaponBtn_, nil, function()
		arg_3_0:SwitchPage(var_0_2.Weapon)
	end)
	arg_3_0:AddBtnListener(arg_3_0.skillBtn_, nil, function()
		arg_3_0:SwitchPage(var_0_2.Skill)
	end)
	arg_3_0:AddBtnListener(arg_3_0.propBtn_, nil, function()
		arg_3_0:SwitchPage(var_0_2.Prop)
	end)
end

function var_0_0.ExitPanel(arg_7_0, arg_7_1)
	arg_7_0.transform_.localScale = Vector3.zero
end

function var_0_0.SwitchPage(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.context.curPage
	local var_8_1

	if arg_8_0.context.curPage == nil then
		var_8_1 = arg_8_1
	else
		if arg_8_0.context.curPage ~= arg_8_1 then
			var_8_1 = arg_8_1
		end

		if arg_8_2 then
			var_8_1 = arg_8_1
		end
	end

	if var_8_0 and var_8_1 then
		arg_8_0.context.page[var_8_0]:ExitPanel(arg_8_0)
	end

	if var_8_1 then
		if not arg_8_0.context.page[var_8_1] then
			arg_8_0.context.page[var_8_1] = arg_8_0.context.pageScript[var_8_1].New(arg_8_0.context.pageContainer[var_8_1])
		end

		arg_8_0.context.curPage = var_8_1

		arg_8_0.context.page[var_8_1]:EnterPanel(arg_8_0)
		arg_8_0.controller:SetSelectedState(arg_8_0.context.pageState[var_8_1])
	end
end

function var_0_0.PlayAnim(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetCustomSceneController()

	var_9_0:SwitchToShow(1)
	var_9_0:PlayHeroAnim("1083ui_dynamic", "GodHood_2", 0.1)
end

function var_0_0.EnterPanel(arg_10_0, arg_10_1)
	arg_10_0.transform_.localScale = Vector3.one

	arg_10_0:PlayAnim(arg_10_1)
	arg_10_0:SwitchPage(var_0_2.Weapon, true)
end

function var_0_0.Render(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(var_0_2) do
		if arg_12_0.context.page[iter_12_1] then
			arg_12_0.context.page[iter_12_1]:Dispose()

			arg_12_0.context.page[iter_12_1] = nil
		end
	end

	GameObject.DestroyImmediate(arg_12_0.gameObject_)
	Asset.Unload(var_0_1)
	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
