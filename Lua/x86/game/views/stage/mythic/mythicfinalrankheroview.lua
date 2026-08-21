local var_0_0 = class("MythicFinalRankHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicRankHeroPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.list_ = LuaList.New(handler(arg_6_0, arg_6_0.IndexItem), arg_6_0.listgo_, MythicFinalRankHeroItem)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, arg_7_0.params_.herolist[arg_7_1], arg_7_0.userID_)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.userID_ = arg_8_0.params_.userID
	arg_8_0.nametext_.text = GetI18NText(arg_8_0.params_.name)

	arg_8_0.list_:StartScroll(#arg_8_0.params_.herolist)
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.list_ then
		arg_9_0.list_:Dispose()

		arg_9_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
