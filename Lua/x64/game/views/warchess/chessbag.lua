local var_0_0 = class("ChessBag", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessBag"
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

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.itempanelGo_, ChessBagItem)
	arg_4_0.scrollHelperKey_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItemKey), arg_4_0.itempanel_keyGo_, ChessBagKeyItem)
	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.transform_, "conName")
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_1, arg_5_0.itemList_[arg_5_1])
end

function var_0_0.indexItemKey(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(arg_6_0.itemList_[arg_6_1])
end

function var_0_0.UpdateData(arg_7_0, arg_7_1)
	arg_7_0.itemList_ = {}

	if arg_7_1 == 1 then
		local var_7_0 = WarChessData:GetItemData()

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			local var_7_1 = WarchessObjectCfg[iter_7_0]

			if var_7_1.type ~= ChessConst.OBJECT_TYPE.ENERGY then
				arg_7_0.itemList_[#arg_7_0.itemList_ + 1] = {
					id = iter_7_0,
					number = iter_7_1,
					iconPath = "TextureConfig/WarChess_Battle/" .. var_7_1.icon
				}
			end
		end
	elseif arg_7_1 == 2 then
		local var_7_2 = WarChessData:GetArtifactData()

		for iter_7_2, iter_7_3 in pairs(var_7_2) do
			if not (WarchessItemCfg[iter_7_2].identify_buff == 1) then
				table.insert(arg_7_0.itemList_, {
					id = iter_7_2,
					num = iter_7_3
				})
			end
		end
	elseif arg_7_1 == 3 then
		local var_7_3 = WarChessData:GetArtifactData()

		for iter_7_4, iter_7_5 in pairs(var_7_3) do
			if WarchessItemCfg[iter_7_4].identify_buff == 1 then
				table.insert(arg_7_0.itemList_, {
					id = iter_7_4,
					num = iter_7_5
				})
			end
		end
	end

	if arg_7_0.type_ ~= arg_7_1 then
		arg_7_0:RecordStay(arg_7_1)
	end

	arg_7_0.type_ = arg_7_1
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddToggleListener(arg_8_0.toggle1Tgl_, function(arg_9_0)
		if arg_9_0 then
			arg_8_0:UpdateData(1)
			arg_8_0.scrollHelperKey_:StartScroll(#arg_8_0.itemList_)
			arg_8_0.controller_:SetSelectedState("key")
			OperationRecorder.Record("chess", "key")
		end
	end)
	arg_8_0:AddToggleListener(arg_8_0.toggle2Tgl_, function(arg_10_0)
		if arg_10_0 then
			arg_8_0:UpdateData(2)
			arg_8_0.scrollHelper_:StartScroll(#arg_8_0.itemList_)
			arg_8_0.controller_:SetSelectedState("artifact")
			OperationRecorder.Record("chess", "artifact")
		end
	end)
	arg_8_0:AddToggleListener(arg_8_0.toggle3Tgl_, function(arg_11_0)
		if arg_11_0 then
			arg_8_0:UpdateData(3)
			arg_8_0.scrollHelper_:StartScroll(#arg_8_0.itemList_)
			arg_8_0.controller_:SetSelectedState("artifact")
			OperationRecorder.Record("chess", "artifact")
		end
	end)
end

function var_0_0.OnEnter(arg_12_0)
	if arg_12_0.toggle1Tgl_.isOn then
		arg_12_0:UpdateData(1)
		arg_12_0.scrollHelperKey_:StartScroll(#arg_12_0.itemList_)
		arg_12_0.controller_:SetSelectedState("key")
	else
		arg_12_0.toggle1Tgl_.isOn = true
	end

	arg_12_0.state = arg_12_0.params_.state

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	arg_13_0:RecordStay(arg_13_0.type_)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.scrollHelper_:Dispose()
	arg_14_0.scrollHelperKey_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.RecordStay(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetStayTime()

	if var_15_0 == 0 then
		return
	end

	local var_15_1 = 0

	if arg_15_1 == 1 then
		var_15_1 = 30205
	elseif arg_15_1 == 2 then
		var_15_1 = 30204
	end

	OperationRecorder.RecordStayView("STAY_VIEW_CHESS_BAG", var_15_0, var_15_1)
	arg_15_0:UpdateLastOpenTime()
end

return var_0_0
