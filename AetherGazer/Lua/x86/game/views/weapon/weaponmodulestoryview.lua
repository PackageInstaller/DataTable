local var_0_0 = class("WeaponModuleStoryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModuleStoryPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = WeaponModuleCfg[arg_7_0.params_.heroID]

	arg_7_0.nameText_.text = GetI18NText(var_7_0.name)
	arg_7_0.storyText_.text = GetI18NText(var_7_0.story)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.contentTrans_)

	arg_7_0.contentTrans_.localPosition = Vector3.New(0, 0, 0)
	arg_7_0.moduleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. arg_7_0.params_.heroID)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
