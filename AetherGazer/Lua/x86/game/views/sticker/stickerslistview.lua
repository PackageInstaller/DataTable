local var_0_0 = class("StickersListView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/paster/StickersListUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.medalList_ = {}
	arg_4_0.medalScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.MedalRenderer), arg_4_0.listGo_, MedalItem)
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = PlayerData:GetStickerList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = ItemCfg[iter_6_1]
		local var_6_2 = PlayerData:GetSticker(iter_6_1)

		if var_6_1.sub_type ~= 1302 or var_6_2.unlock ~= 0 then
			table.insert(arg_6_0.medalList_, var_6_2)
		end
	end

	table.sort(arg_6_0.medalList_, function(arg_7_0, arg_7_1)
		if arg_7_0.unlock ~= arg_7_1.unlock then
			return arg_7_0.unlock > arg_7_1.unlock
		end

		return arg_7_0.id < arg_7_1.id
	end)
	arg_6_0.medalScrollHelper_:StartScroll(#arg_6_0.medalList_)
end

function var_0_0.MedalRenderer(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshItem(arg_8_0.medalList_[arg_8_1])
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.medalList_ = {}

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	arg_11_0.medalScrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
