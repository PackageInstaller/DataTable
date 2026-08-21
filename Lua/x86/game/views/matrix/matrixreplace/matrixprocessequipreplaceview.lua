local var_0_0 = class("MatrixProcessEquipReplaceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Process/MatrixProcessEquipReplaceUI"
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

	arg_4_0.item_ = MatrixProcessRewardItem.New(arg_4_0.m_item)
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_list, MatrixProcessRewardItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_okBtn, nil, function()
		if arg_5_0.params_.callback then
			local var_6_0 = arg_5_0.equipData[arg_5_0.selectItemIndex]

			arg_5_0.params_.callback(var_6_0)
		end

		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_cancelBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.heroId = arg_8_0.params_.heroId
	arg_8_0.equipId = arg_8_0.params_.equipId
	arg_8_0.equipData = arg_8_0:GetHeroData(arg_8_0.heroId):GetEquipList()

	arg_8_0:Refresh()
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_11_0)
	arg_11_0.selectItemIndex = 1

	arg_11_0.item_:Refresh(arg_11_0.equipId)
	arg_11_0.list_:StartScroll(#arg_11_0.equipData)
end

function var_0_0.indexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.equipData[arg_12_1]

	arg_12_2:RegistCallBack(handler(arg_12_0, arg_12_0.OnItemClick))
	arg_12_2:Refresh(var_12_0, arg_12_1)
	arg_12_2:SetSelected(arg_12_1 == arg_12_0.selectItemIndex)
end

function var_0_0.OnItemClick(arg_13_0, arg_13_1)
	if arg_13_1 == arg_13_0.selectItemIndex then
		return
	end

	arg_13_0.selectItemIndex = arg_13_1

	local var_13_0 = arg_13_0.list_:GetItemList()

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_1 = iter_13_1:GetIndex()

		iter_13_1:SetSelected(var_13_1 == arg_13_0.selectItemIndex)
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.item_:Dispose()
	arg_14_0.list_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.GetHeroData(arg_15_0, arg_15_1)
	return MatrixData:GetHeroData(arg_15_1)
end

return var_0_0
