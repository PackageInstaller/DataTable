local var_0_0 = class("VolumeMusicRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, CommonItemView)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_rewardBtn, nil, function()
		MusicAction.QueryReward({
			arg_4_0.id
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1
	arg_6_0.items = ActivityMusicCfg[arg_6_1].reward

	arg_6_0.list_:StartScroll(#arg_6_0.items)

	arg_6_0.m_des.text = GetI18NText(arg_6_0:GeDes(arg_6_1))

	local var_6_0 = MusicData:GetRewardState(arg_6_1)

	arg_6_0.stateController_:SetSelectedIndex(var_6_0)
end

function var_0_0.GeDes(arg_7_0, arg_7_1)
	local var_7_0 = ActivityMusicCfg[arg_7_1]
	local var_7_1 = var_7_0.difficult
	local var_7_2 = MusicData:GetTargetAccuracyDes(var_7_0.target)

	return GetTips("ACTIVITY_MUSIC_2_10_TASK")
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.items[arg_8_1]
	local var_8_1 = clone(ItemTemplateData)

	var_8_1.id = var_8_0[1]
	var_8_1.number = var_8_0[2]

	function var_8_1.clickFun(arg_9_0)
		ShowPopItem(POP_ITEM, {
			arg_9_0.id,
			arg_9_0.number
		})
	end

	arg_8_2:SetData(var_8_1)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.list_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
