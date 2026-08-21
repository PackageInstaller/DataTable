local var_0_0 = {
	GetChallengeCurrencyID = function(arg_1_0)
		if arg_1_0 == ActivityConst.XUHENG_PT2 then
			return CurrencyIdMapCfg.CURRENCY_XUHENG_TICKET.item_id
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return CurrencyIdMapCfg.CURRENCY_XUHENG_PT_TICKET.item_id
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_2_PT2 then
			return CurrencyIdMapCfg.CURRENCY_XUHENG_PT_TICKET_2_2.item_id
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return CurrencyIdMapCfg.CURRENCY_PT_TICKET_2_4_UP.item_id
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return CurrencyIdMapCfg.CURRENCY_PT_TICKET_2_4_DOWN.item_id
		elseif arg_1_0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return CurrencyIdMapCfg.CURRENCY_PT_TICKET_2_7.item_id
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return CurrencyIdMapCfg.CURRENCY_PT_COIN_2_8.item_id
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return CurrencyIdMapCfg.CURRENCY_PT_COIN_2_9.item_id
		else
			return CurrencyIdMapCfg.CURRENCY_XUHENG_TICKET.item_id
		end
	end,
	GetHelpKey = function(arg_2_0)
		if arg_2_0 == ActivityConst.XUHENG_PT2 then
			return "ACTIVITY_XUHENG_PT_DESCRIBE"
		elseif arg_2_0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "ACTIVITY_XUHENG_PT_DESCRIBE_1"
		elseif arg_2_0 == ActivityConst.ACTIVITY_2_2_PT2 then
			return "ACTIVITY_XUHENG_PT_DESCRIBE_2_2"
		elseif arg_2_0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "ACTIVITY_PT_DESCRIBE_2_4_UP"
		elseif arg_2_0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "ACTIVITY_PT_DESCRIBE_2_4_DOWN"
		elseif arg_2_0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return "ACTIVITY_PT_DESCRIBE_2_7"
		elseif arg_2_0 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return "ACTIVITY_PT_DESCRIBE_2_8"
		elseif arg_2_0 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return "ACTIVITY_PT_DESCRIBE_2_9"
		else
			return ""
		end
	end,
	GetEnterUIName = function(arg_3_0)
		if arg_3_0 == ActivityConst.XUHENG_PT2 then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtHomeUI"
		elseif arg_3_0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndPtUI/XH2ndPtMainUI"
		elseif arg_3_0 == ActivityConst.ACTIVITY_2_2_PT2 then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdPtUI/XH3rdPtMainUI"
		elseif arg_3_0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPtMainUpUI"
		elseif arg_3_0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPtMainDownUI"
		elseif arg_3_0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPtDownUI/JapanRegionPtMainDownUI"
		elseif arg_3_0 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTUp/IndiaPTUpMainUI"
		elseif arg_3_0 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTDown/IndiaPTDownMainUI"
		else
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtHomeUI"
		end
	end,
	GetMainUIName = function(arg_4_0)
		if arg_4_0 == ActivityConst.XUHENG_PT2 then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtMainUI"
		elseif arg_4_0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndPtUI/XH2ndPtLevelUI"
		elseif arg_4_0 == ActivityConst.ACTIVITY_2_2_PT2 then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdPtUI/XH3rdPtLevelUI"
		elseif arg_4_0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPTLevelUpUI"
		elseif arg_4_0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPTLevelDownUI"
		elseif arg_4_0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPtDownUI/JapanRegionPTLevelDownUI"
		elseif arg_4_0 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTUp/IndiaPTUpLevelUI"
		elseif arg_4_0 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTDown/IndiaPTDownLevelUI"
		else
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtMainUI"
		end
	end
}

function var_0_0.GetToggleClickEffect(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.GetEffectList(arg_5_0)

	if var_5_0 and #var_5_0 > 0 then
		local var_5_1

		if #var_5_0 > 1 then
			var_5_1 = var_5_0[arg_5_1]
		else
			var_5_1 = var_5_0[1]
		end

		return var_5_1[1], var_5_1[2], var_5_1[3]
	else
		return "", "", ""
	end
end

function var_0_0.GetEffectList(arg_6_0)
	local var_6_0 = {}

	if arg_6_0 == ActivityConst.XUHENG_PT2 then
		var_6_0 = {
			{
				"minigame_activity_2_0",
				"minigame_activity_2_0_pt_whoosh",
				""
			}
		}
	elseif arg_6_0 == ActivityConst.ACTIVITY_2_2_PT2 then
		var_6_0 = {
			{
				"minigame_activity_2_2",
				"minigame_activity_2_2_pt_loop01",
				""
			},
			{
				"minigame_activity_2_2",
				"minigame_activity_2_2_pt_loop02",
				""
			},
			{
				"minigame_activity_2_2",
				"minigame_activity_2_2_pt_loop03",
				""
			}
		}
	end

	return var_6_0
end

function var_0_0.GetBtnEnterAnimation(arg_7_0)
	if arg_7_0 == ActivityConst.ACTIVITY_2_1_PT2 then
		return "Fx_easylevel_cx"
	elseif arg_7_0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
		return "Fx_level_cx"
	elseif arg_7_0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
		return "Fx_level_cx"
	else
		return ""
	end
end

function var_0_0.GetBtnDisappearAnimation(arg_8_0)
	if arg_8_0 == ActivityConst.ACTIVITY_2_1_PT2 then
		return "Fx_easylevel_xuanzhong_xs"
	elseif arg_8_0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
		return "Fx_tuichu"
	elseif arg_8_0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
		return "Fx_tuichu"
	else
		return ""
	end
end

function var_0_0.GetBtnAppearAnimation(arg_9_0)
	if arg_9_0 == ActivityConst.ACTIVITY_2_1_PT2 then
		return "Fx_easylevel_xuanzhong_cx"
	elseif arg_9_0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
		return "Fx_dianji"
	elseif arg_9_0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
		return "Fx_dianji"
	else
		return ""
	end
end

function var_0_0.GetTaskActivityID(arg_10_0, arg_10_1)
	if arg_10_1 == ActivityConst.XUHENG_PT2 then
		return ActivityConst.XUHENG_PT2_TASK
	elseif arg_10_1 == ActivityConst.ACTIVITY_2_1_PT2 then
		return ActivityConst.ACTIVITY_2_1_PT2_TASK
	elseif arg_10_1 == ActivityConst.ACTIVITY_2_2_PT2 then
		return ActivityConst.ACTIVITY_2_2_PT2_TASK
	elseif arg_10_1 == ActivityConst.ACTIVITY_2_4_PT2_UP then
		return ActivityConst.ACTIVITY_2_4_PT2_TASK_UP
	elseif arg_10_1 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
		return ActivityConst.ACTIVITY_2_4_PT2_TASK_DOWN
	elseif arg_10_1 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
		return ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_TASK_DOWN
	elseif arg_10_1 == ActivityConst.ACTIVITY_2_8_PT2_UP then
		return ActivityConst.ACTIVITY_2_8_PT2_TASK_UP
	elseif arg_10_1 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
		return ActivityConst.ACTIVITY_2_8_PT2_TASK_DOWN
	else
		return ActivityConst.XUHENG_PT2_TASK
	end
end

function var_0_0.GetMainActivityID(arg_11_0, arg_11_1)
	local var_11_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_PT_2]

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = ActivityCfg[iter_11_1].sub_activity_list

		if table.indexof(var_11_1, arg_11_1) then
			return iter_11_1
		end
	end
end

return var_0_0
