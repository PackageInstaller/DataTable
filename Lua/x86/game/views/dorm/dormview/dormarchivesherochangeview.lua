local var_0_0 = class("DormArchivesHeroChangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HouseUI/TempUi/DormTempSameHeroChange"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(arg_6_0.heroIDList[arg_6_1], arg_6_0.selheroID)
	arg_6_2:RegisterClickCallBack(function(arg_7_0)
		arg_6_0.selheroID = arg_7_0

		arg_6_0.heroScroll:Refresh()
	end)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListenerScale(arg_8_0.cancelbtnBtn_, nil, function()
		JumpTools:back()
	end)
	arg_8_0:AddBtnListenerScale(arg_8_0.confirmbtnBtn_, nil, function()
		local var_10_0 = DormData:GetCurrectSceneID()
		local var_10_1 = {}

		table.insert(var_10_1, arg_8_0.selheroID)
		DormAction:DeployHeroInRoom(var_10_0, var_10_1, DormEnum.DormDeployType.ReCall)
		JumpTools:back()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.heroID = arg_11_0.params_.heroID or 0

	arg_11_0:UpdataHerolList(arg_11_0.heroID)
	arg_11_0.heroScroll:StartScroll(#arg_11_0.heroIDList)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.UpdataHerolList(arg_12_0, arg_12_1)
	local var_12_0 = DormData:GetHeroArchiveID(arg_12_1)

	if HeroRecordCfg[var_12_0] then
		arg_12_0.heroIDList = HeroRecordCfg[var_12_0].hero_id
	else
		Debug.LogError("不存在角色档案信息")
	end
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
