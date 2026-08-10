DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local var_0_0 = class("DormInfomationModifierModule", DormInfomationModuleBase)

function var_0_0.ModuleName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/item/Infomation/ModifierPanel"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListener()

	arg_2_0.uiList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiListGo_, DormIlluHeroItem)
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

	local var_4_1 = {}

	arg_4_0.info_.text = string.format(BackhomeContentNoticeCfg[arg_4_1].desc, "")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.idLst[arg_5_1])
	arg_5_2:RegistCallBack(function(arg_6_0)
		return
	end)
	arg_5_2:SetUnlock(true)
end

function var_0_0.OpenDetailView(arg_7_0, arg_7_1)
	JumpTools.OpenPageByJump("/dormIlluHeroDetail", {
		heroID = arg_7_1,
		heroIDList = arg_7_0.idLst
	})
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.uiList_:Dispose()

	arg_8_0.uiList_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
