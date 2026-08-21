local var_0_0 = class("SkuldSystemPhotoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_PhotoPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.index_ = arg_7_0.params_.index

	local var_7_0 = GameSetting["skuld_photo" .. arg_7_0.index_].value

	arg_7_0.image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Skuld/Skuld_Photos/" .. var_7_0[1])
	arg_7_0.nameText_.text = GetTips(var_7_0[2])
	arg_7_0.desText_.text = formatText(GetTips(var_7_0[3]))
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
