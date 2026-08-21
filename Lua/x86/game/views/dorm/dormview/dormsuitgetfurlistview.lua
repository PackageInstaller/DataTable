local var_0_0 = class("DormSuitGetFurListView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormFurnitureGetPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
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

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, FurnitureItem)
	arg_5_0.stateController = ControllerUtil.GetController(arg_5_0.transform_, "state")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.canStorageList = arg_6_0.params_.furEidList or nil

	arg_6_0:RefreshView()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListenerScale(arg_8_0.confirmBtn, nil, function()
		if arg_8_0.canStorageList then
			for iter_9_0, iter_9_1 in pairs(arg_8_0.canStorageList) do
				for iter_9_2 = 0, iter_9_1.Length - 1 do
					DormFurnitureManager.GetInstance().FindAndRemove(iter_9_1[iter_9_2])
					DormFurEditStateData:ReviseFurNumInEditRoom(iter_9_0, -1)
				end
			end
		end

		if arg_8_0.params_.callBack then
			arg_8_0.params_.callBack()
		end

		arg_8_0.params_.furEidList = nil
		arg_8_0.canStorageList = nil

		JumpTools.Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.cancelBtn, nil, function()
		arg_8_0.params_.furEidList = nil
		arg_8_0.canStorageList = nil

		JumpTools.Back()
	end)
end

function var_0_0.RefreshView(arg_11_0)
	if arg_11_0.canStorageList then
		arg_11_0.stateController:SetSelectedState("have")
		arg_11_0:RefreshFurInfoList()
	else
		arg_11_0.stateController:SetSelectedState("no")
	end
end

function var_0_0.RefreshFurInfoList(arg_12_0)
	if arg_12_0.canStorageList then
		arg_12_0.furInfoList = {}

		for iter_12_0, iter_12_1 in pairs(arg_12_0.canStorageList) do
			local var_12_0 = {
				furID = iter_12_0,
				canStorageNum = iter_12_1.Length
			}

			table.insert(arg_12_0.furInfoList, var_12_0)
		end

		arg_12_0.scrollHelper_:StartScroll(#arg_12_0.furInfoList)
	end
end

function var_0_0.indexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_0.furInfoList[arg_13_1], nil, DormEnum.FurItemType.StorageFurShow, nil, arg_13_1)
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.scrollHelper_ then
		arg_14_0.scrollHelper_:Dispose()
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
