local var_0_0 = class("AdminCatExploreEventView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.data = arg_4_1
	arg_4_0.adminCatID = arg_4_2
	arg_4_0.startTime = arg_4_3

	arg_4_0:UpdateView()
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.UpdateView(arg_6_0)
	local var_6_0 = ExploringEventCfg[arg_6_0.data.content]
	local var_6_1 = ExploringEventCfg[arg_6_0.data.address]
	local var_6_2 = ExploreMeowCfg[arg_6_0.adminCatID]

	arg_6_0.timeTxt_.text = manager.time:DescCDTime(arg_6_0.data.time)

	local var_6_3 = (GetI18NText(var_6_2.meow_name) .. GetI18NText(var_6_1.description)) .. GetI18NText(var_6_0.description)

	if var_6_0.event_type == 3 then
		var_6_3 = var_6_3 .. "\n" .. GetTips("EXPLORE_PROCESS_EVENT_REWARD")

		for iter_6_0, iter_6_1 in ipairs(var_6_0.reward) do
			var_6_3 = var_6_3 .. "<color=#CFB9FB>" .. ItemTools.getItemName(iter_6_1[1]) .. " x " .. iter_6_1[2] .. "</color>  "
		end
	end

	arg_6_0.contentTxt_.text = var_6_3
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:UpdateView()
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
