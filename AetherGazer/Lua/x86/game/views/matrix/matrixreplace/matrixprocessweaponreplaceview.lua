local var_0_0 = class("MatrixProcessWeaponReplaceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Process/MatrixProcessWeaponReplaceUI"
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

	arg_4_0.item_l = MatrixProcessRewardItem.New(arg_4_0.m_item_l)
	arg_4_0.item_r = MatrixProcessRewardItem.New(arg_4_0.m_item_r)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_okBtn, nil, function()
		if arg_5_0.params_.callback then
			arg_5_0.params_.callback()
		end

		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_cancelBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.heroId = arg_9_0.params_.heroId

	local var_9_0 = arg_9_0:GetHeroData(arg_9_0.heroId):GetWeaponServant()

	arg_9_0.item_r:Refresh(var_9_0)

	arg_9_0.weaponId = arg_9_0.params_.weaponId

	arg_9_0.item_l:Refresh(arg_9_0.weaponId)
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.item_l:Dispose()
	arg_11_0.item_r:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.GetHeroData(arg_12_0, arg_12_1)
	return MatrixData:GetHeroData(arg_12_1)
end

return var_0_0
