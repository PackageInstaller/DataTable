local var_0_0 = class("SequentialBattleBuffInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = SequentialBattleChapterCfg[arg_1_0.params_.buffInfoActivityID].main_id
	local var_1_1 = SequentialBattleUICfg.get_id_list_by_main_activity_id[var_1_0][1]

	return SequentialBattleUICfg[var_1_1].buff_info_prefab
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectBuffHandler_ = handler(arg_3_0, arg_3_0.RefreshSelectBuff)
	arg_3_0.buffUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, SequentialBattleBuffInfoItem)
	arg_3_0.conditionList_ = {}
	arg_3_0.buffController_ = arg_3_0.buffControllerEx_:GetController("enabled")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID_ = arg_4_0.params_.buffInfoActivityID
	arg_4_0.stageID_ = arg_4_0.params_.stageID

	local var_4_0 = SequentialBattleChapterCfg[arg_4_0.activityID_].main_id

	arg_4_0.buffList_ = clone(SequentialBattleBuffCfg.get_id_list_by_activity_id[var_4_0])

	if arg_4_0.stageID_ ~= nil then
		local var_4_1 = table.keyof(SequentialBattleChapterCfg[arg_4_0.activityID_].stage_id, arg_4_0.stageID_)
		local var_4_2 = SequentialBattleTools.GetEnabledBuff(arg_4_0.activityID_, var_4_1)

		for iter_4_0 = #arg_4_0.buffList_, 1, -1 do
			if table.keyof(var_4_2, arg_4_0.buffList_[iter_4_0]) then
				table.remove(arg_4_0.buffList_, iter_4_0)
			end
		end

		table.insertto(var_4_2, arg_4_0.buffList_)

		arg_4_0.buffList_ = var_4_2
	end

	arg_4_0.selectID_ = arg_4_0.buffList_[1]

	arg_4_0.buffUIList_:StartScroll(#arg_4_0.buffList_)
	manager.notify:RegistListener(SEQUENTIAL_BATTLE_BUFF, arg_4_0.selectBuffHandler_)
	arg_4_0:RefreshSelectBuff(arg_4_0.selectID_)
	arg_4_0:RefreshTitle()
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(SEQUENTIAL_BATTLE_BUFF, arg_5_0.selectBuffHandler_)

	arg_5_0.params_.stageID = nil
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.selectBuffHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.conditionList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.conditionList_ = nil

	arg_6_0.buffUIList_:Dispose()

	arg_6_0.buffUIList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.RefreshItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.buffList_[arg_9_1]
	local var_9_1 = false

	if arg_9_0.stageID_ ~= nil then
		local var_9_2 = table.keyof(SequentialBattleChapterCfg[arg_9_0.activityID_].stage_id, arg_9_0.stageID_)
		local var_9_3 = SequentialBattleTools.GetEnabledBuff(arg_9_0.activityID_, var_9_2)

		if table.keyof(var_9_3, var_9_0) then
			var_9_1 = true
		end
	end

	arg_9_2:SetData(var_9_0, var_9_1)
	arg_9_2:RefreshSelect(arg_9_0.selectID_)
end

function var_0_0.RefreshTitle(arg_10_0)
	return
end

function var_0_0.RefreshSelectBuff(arg_11_0, arg_11_1)
	arg_11_0.selectID_ = arg_11_1

	for iter_11_0, iter_11_1 in pairs(arg_11_0.buffUIList_:GetItemList()) do
		iter_11_1:RefreshSelect(arg_11_1)
	end

	arg_11_0:RefreshRightPanel()
	arg_11_0:RefreshCondition()
end

function var_0_0.RefreshRightPanel(arg_12_0)
	local var_12_0 = SequentialBattleBuffCfg[arg_12_0.selectID_]
	local var_12_1 = var_12_0.affix_id
	local var_12_2 = AffixTypeCfg[var_12_1]
	local var_12_3 = PublicBuffCfg[var_12_2.affix_buff_id].icon

	arg_12_0.selectIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MaedukAffix/" .. var_12_3)

	local var_12_4 = false

	if arg_12_0.stageID_ ~= nil then
		local var_12_5 = table.keyof(SequentialBattleChapterCfg[arg_12_0.activityID_].stage_id, arg_12_0.stageID_)
		local var_12_6 = SequentialBattleTools.GetEnabledBuff(arg_12_0.activityID_, var_12_5)

		if table.keyof(var_12_6, arg_12_0.selectID_) then
			var_12_4 = true
		end
	end

	if var_12_4 == true then
		arg_12_0.buffController_:SetSelectedState("true")
	else
		arg_12_0.buffController_:SetSelectedState("false")
	end

	arg_12_0.nameText_.text = GetI18NText(getAffixName({
		var_12_1
	}))
	arg_12_0.descText_.text = GetI18NText(var_12_0.desc)
end

function var_0_0.RefreshCondition(arg_13_0)
	local var_13_0 = SequentialBattleBuffCfg[arg_13_0.selectID_]

	for iter_13_0 = #arg_13_0.conditionList_, #var_13_0.type + 1, -1 do
		arg_13_0.conditionList_[iter_13_0]:Show(false)
	end

	for iter_13_1 = 1, #var_13_0.type do
		arg_13_0.conditionList_[iter_13_1] = arg_13_0.conditionList_[iter_13_1] or SequentialBattleBuffInfoCondition.New(arg_13_0.conditionItem_, arg_13_0.conditionParent_)

		arg_13_0.conditionList_[iter_13_1]:SetData(arg_13_0.activityID_, arg_13_0.stageID_, arg_13_0.selectID_, iter_13_1)
	end
end

return var_0_0
