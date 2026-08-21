local var_0_0 = class("HeroActionView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroActList_ = {
		"happy",
		"sad",
		"angry"
	}
	arg_3_0.punishActList_ = {
		"happy",
		"angry"
	}
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, HeroActionItem)
	arg_3_0.sizeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "size")
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:Refresh(arg_4_0.list_[arg_4_1])
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.list_ = arg_6_0.heroActList_

	arg_6_0.scrollHelper_:StartScroll(#arg_6_0.list_)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.RefreshList(arg_8_0, arg_8_1)
	arg_8_0.list_ = arg_8_1 == 1 and arg_8_0.heroActList_ or arg_8_0.punishActList_

	arg_8_0.sizeCon_:SetSelectedState(arg_8_1 == 1 and "true" or "false")
	arg_8_0.scrollHelper_:StartScroll(#arg_8_0.list_)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.scrollHelper_:Dispose()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
