local var_0_0 = class("GuildActivityAffixRaceItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1.gameObject
	arg_1_0.transform_ = arg_1_1

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.Btn_, nil, function()
		if arg_4_0.selectCallBack_ then
			arg_4_0.selectCallBack_(arg_4_0.raceID_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.raceID_ = arg_6_1
end

function var_0_0.SetSelectCallBack(arg_7_0, arg_7_1)
	arg_7_0.selectCallBack_ = arg_7_1
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.gameObject_ = nil
	arg_9_0.transform_ = nil
	arg_9_0.selectCallBack_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.BindRedPoint(arg_11_0, arg_11_1)
	if arg_11_0.raceID_ ~= nil then
		manager.redPoint:bindUIandKey(arg_11_0.transform_, string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, arg_11_1, arg_11_0.raceID_))
	end
end

function var_0_0.UnBindRedPoint(arg_12_0, arg_12_1)
	if arg_12_0.raceID_ ~= nil then
		manager.redPoint:unbindUIandKey(arg_12_0.transform_, string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, arg_12_1, arg_12_0.raceID_))
	end
end

return var_0_0
