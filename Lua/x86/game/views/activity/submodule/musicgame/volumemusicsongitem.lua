local var_0_0 = class("VolumeMusicSongItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, VolumeMusicRewardItem)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.music_id = arg_4_1

	arg_4_0:Refresh()
end

function var_0_0.Refresh(arg_5_0)
	local var_5_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_5_0.music_id] or {}

	arg_5_0.rewards = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if ActivityMusicCfg[iter_5_1] and #ActivityMusicCfg[iter_5_1].reward > 0 then
			table.insert(arg_5_0.rewards, iter_5_1)
		end
	end

	local var_5_1 = arg_5_0.rewards[1]
	local var_5_2 = ActivityData:GetActivityData(arg_5_0.music_id)

	if var_5_2 and var_5_2:IsActivitying() then
		arg_5_0.m_name.text = ActivityMusicCfg[var_5_1] and GetI18NText(ActivityMusicCfg[var_5_1].name) or ""
	else
		arg_5_0.m_name.text = "???"
	end

	local var_5_3 = math.min(#arg_5_0.rewards, 2)

	arg_5_0.list_:StartScroll(var_5_3)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.rewards[arg_6_1]

	arg_6_2:SetData(var_6_0)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.list_:Dispose()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
