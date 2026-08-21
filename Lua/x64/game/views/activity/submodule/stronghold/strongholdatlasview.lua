local var_0_0 = class("StrongholdAtlasView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdAtlasUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, StrongholdAtlasItem)
	arg_4_0.typeController = ControllerUtil.GetController(arg_4_0.transform_, "type")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.atlasType1Btn, function()
		arg_5_0:SelectAtlas(0)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.atlasType2Btn, function()
		arg_5_0:SelectAtlas(1)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.atlasType3Btn, function()
		arg_5_0:SelectAtlas(2)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.atlasType4Btn, function()
		arg_5_0:SelectAtlas(3)
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activity_id = arg_11_0.params_.activity_id

	arg_11_0:SelectAtlas(0, true)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.SelectAtlas(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == arg_13_0.curIndex_ and not arg_13_2 then
		return
	end

	arg_13_0.curIndex_ = arg_13_1

	arg_13_0.typeController:SetSelectedIndex(arg_13_1)

	arg_13_0.atlas = ActivityStrongholdArtifactCfg.get_id_list_by_type[arg_13_1] or {}

	table.sort(arg_13_0.atlas, function(arg_14_0, arg_14_1)
		local var_14_0 = StrongholdData:GetAtlasUseCount(arg_13_0.activity_id, arg_14_0) == 0 and 0 or 1
		local var_14_1 = StrongholdData:GetAtlasUseCount(arg_13_0.activity_id, arg_14_1) == 0 and 0 or 1

		if var_14_0 == var_14_1 then
			return ActivityStrongholdArtifactCfg[arg_14_0].rare > ActivityStrongholdArtifactCfg[arg_14_1].rare
		else
			return var_14_1 < var_14_0
		end
	end)

	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.atlas) do
		if StrongholdData:GetAtlasUseCount(arg_13_0.activity_id, iter_13_1) ~= 0 then
			var_13_0 = var_13_0 + 1
		end
	end

	local var_13_1 = #arg_13_0.atlas

	arg_13_0.m_processLab.text = var_13_0 .. "/" .. var_13_1

	arg_13_0.list:StartScroll(var_13_1)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.list:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.IndexItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.atlas[arg_16_1]

	arg_16_2:SetData(var_16_0, arg_16_0.activity_id)
end

return var_0_0
