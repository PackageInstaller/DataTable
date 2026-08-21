local var_0_0 = class("ActivityReforgeTeamView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTeamUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.teamList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTeamItem), arg_4_0.listGo_, ActivityReforgeTeamItem)
end

function var_0_0.IndexTeamItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.teamIDList_[arg_5_1]

	arg_5_2:SetData(arg_5_0.chapterActivityID_, arg_5_0.levelID_, arg_5_0.curWaveID_, var_5_0)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.chapterActivityID_ = arg_8_0.params_.chapterActivityID
	arg_8_0.levelID_ = arg_8_0.params_.levelID
	arg_8_0.curWaveID_ = arg_8_0.params_.curWaveID
	arg_8_0.levelCfg_ = ActivityReforgeLevelCfg[arg_8_0.levelID_]

	arg_8_0:SortTeam()
	arg_8_0.teamList_:StartScroll(#arg_8_0.teamIDList_)
end

function var_0_0.SortTeam(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}
	local var_9_4 = 0
	local var_9_5 = ActivityReforgeWaveCfg[arg_9_0.curWaveID_]

	for iter_9_0, iter_9_1 in pairs(arg_9_0.levelCfg_.team_list) do
		local var_9_6 = ActivityReforgeData:GetTeamCurUsingWaveID(iter_9_1)

		if var_9_6 > 0 then
			if var_9_6 == arg_9_0.curWaveID_ then
				var_9_4 = iter_9_1
			elseif table.indexof(var_9_5.recommend_team, iter_9_1) then
				table.insert(var_9_3, iter_9_1)
			else
				table.insert(var_9_2, iter_9_1)
			end
		elseif table.indexof(var_9_5.recommend_team, iter_9_1) then
			table.insert(var_9_1, iter_9_1)
		else
			table.insert(var_9_0, iter_9_1)
		end
	end

	arg_9_0.teamIDList_ = {}

	if var_9_4 > 0 then
		table.insert(arg_9_0.teamIDList_, var_9_4)
	end

	for iter_9_2, iter_9_3 in pairs(var_9_1) do
		table.insert(arg_9_0.teamIDList_, iter_9_3)
	end

	for iter_9_4, iter_9_5 in pairs(var_9_0) do
		table.insert(arg_9_0.teamIDList_, iter_9_5)
	end

	for iter_9_6, iter_9_7 in pairs(var_9_3) do
		table.insert(arg_9_0.teamIDList_, iter_9_7)
	end

	for iter_9_8, iter_9_9 in pairs(var_9_2) do
		table.insert(arg_9_0.teamIDList_, iter_9_9)
	end
end

function var_0_0.OnActivityReforgeCurLevelUpdate(arg_10_0)
	arg_10_0.teamList_:Refresh()
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.teamList_ then
		arg_11_0.teamList_:Dispose()

		arg_11_0.teamList_ = nil
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
