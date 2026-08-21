local var_0_0 = class("IlluEquipManual", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluEquipUI"
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

	arg_4_0.itemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, IlluEquipManualItem)
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.UpdateDate(arg_6_0)
	arg_6_0.itemList_ = {}

	local var_6_0 = HideInfoData:GetEquipSuitHideList()
	local var_6_1 = 1

	for iter_6_0, iter_6_1 in ipairs(EquipSuitCfg.all) do
		if not var_6_0[iter_6_1] then
			arg_6_0.itemList_[var_6_1] = {
				id = iter_6_1
			}
			var_6_1 = var_6_1 + 1
		end
	end
end

function var_0_0.indexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(arg_7_0.itemList_[arg_7_1])
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_8_0:UpdateDate()

	if arg_8_0.params_.scrollPos_ then
		arg_8_0.itemScroll_:StartScrollByPosition(#arg_8_0.itemList_, arg_8_0.params_.scrollPos_)
	else
		arg_8_0.itemScroll_:StartScroll(#arg_8_0.itemList_)
	end

	local var_8_0 = IlluTools.GetEquipAll()

	arg_8_0.numText_.text = var_8_0 .. "/" .. EquipTools.GetSuitTotalNum() * 6
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()

	arg_9_0.params_.scrollPos_ = arg_9_0.itemScroll_:GetScrolledPosition()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.itemScroll_:Dispose()

	arg_10_0.itemScroll_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
