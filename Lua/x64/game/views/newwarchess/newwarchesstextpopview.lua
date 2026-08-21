local var_0_0 = class("NewWarChessTextPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessTextPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		JumpTools.Back()

		if arg_4_0.params_.callBack then
			arg_4_0.params_.callBack()
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.ID_ = arg_6_0.params_.ID

	local var_6_0 = NewWarChessContentCfg[arg_6_0.ID_]

	if var_6_0.icon and var_6_0.icon ~= 0 then
		SetActive(arg_6_0.itemGo_, true)

		arg_6_0.itemiconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/NewWarChess/Item/" .. var_6_0.icon)
	else
		SetActive(arg_6_0.itemGo_, false)
	end

	arg_6_0.textnameText_.text = var_6_0.name
	arg_6_0.textinfoText_.text = var_6_0.content
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
