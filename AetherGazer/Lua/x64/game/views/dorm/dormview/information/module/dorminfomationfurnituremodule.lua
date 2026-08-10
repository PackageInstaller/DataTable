DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local var_0_0 = class("DormInfomationFurnitureModule", DormInfomationModuleBase)

function var_0_0.ModuleName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/item/Infomation/FurniturePanel"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListener()

	arg_2_0.uiList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiListGo_, FurnitureItemSimple)
end

function var_0_0.AddListener(arg_3_0)
	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	var_0_0.super.Show(arg_4_0, arg_4_1)

	local var_4_0 = BackhomeContentNoticeCfg[arg_4_1].params

	arg_4_0.idLst = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		table.insert(arg_4_0.idLst, iter_4_1)
	end

	arg_4_0.uiList_:StartScroll(#arg_4_0.idLst)

	arg_4_0.info_.text = string.format(BackhomeContentNoticeCfg[arg_4_1].desc, "")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.idLst[arg_5_1])
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.uiList_ then
		arg_6_0.uiList_:Dispose()

		arg_6_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
