local var_0_0 = {}

function var_0_0.OpenGameTips()
	local var_1_0 = var_0_0.GetGameHelpKey()

	JumpTools.OpenPageByJump(var_1_0.view, var_1_0.params)
end

function var_0_0.GetGameHelpKey()
	if var_0_0.helpKey == nil then
		var_0_0.helpKey = {
			view = "gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = GameSetting.linkgame_describe.value
			}
		}
	end

	return var_0_0.helpKey
end

function var_0_0.GetMainUIName(arg_3_0)
	return "Widget/Version/Alone_LinkGame/Alone_LinkGameMainUI"
end

function var_0_0.GetVersionCharaImgPath(arg_4_0)
	if ActivityTools.GetActivityTheme(arg_4_0) == ActivityConst.THEME.ACTIVITY_5_0 then
		return "TextureConfig/VersionUI/Alone_LinkGame/Linkgame_character_02"
	else
		return "TextureConfig/VersionUI/Alone_LinkGame/Linkgame_character_01"
	end
end

function var_0_0.GetTaskActivityID(arg_5_0, arg_5_1)
	return ActivityTools.GetAllTaskSubActivityID(arg_5_1)[1]
end

function var_0_0.GetLevelActivityList(arg_6_0, arg_6_1)
	return ActivityTools.GetAllSubActivityByTemplate(arg_6_1, ActivityTemplateConst.LIANLIANKAN_LEVEL)
end

function var_0_0.GetLostTimeStr(arg_7_0, arg_7_1)
	local var_7_0 = ActivityData:GetActivityData(ActivityLinkGameCfg[arg_7_1].activity_id).stopTime - TimeMgr.GetInstance():GetServerTime()
	local var_7_1 = math.floor(var_7_0 / 86400)
	local var_7_2 = math.fmod(math.floor(var_7_0 / 3600), 24)
	local var_7_3 = math.fmod(math.floor(var_7_0 / 60), 60)

	if var_7_1 > 0 then
		return (nil).format(GetTips("ACTIVITY_LINKGAME_TIME_LIMIT"), var_7_1 + 1)
	elseif var_7_2 > 0 then
		return var_7_2 + 1 .. GetTips("HOUR")
	elseif var_7_3 > 0 then
		return var_7_3 + 1 .. GetTips("MINUTE")
	elseif math.fmod(var_7_0, 60) > 0 then
		return var_7_3 + 1 .. GetTips("MINUTE")
	end
end

function var_0_0.GetLevelIDByDiffAndActivityID(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(ActivityLinkGameCfg.all) do
		if ActivityLinkGameCfg[iter_8_1].activity_id == arg_8_1 and ActivityLinkGameCfg[iter_8_1].difficult == arg_8_2 then
			return iter_8_1
		end
	end

	print("未找到活动id")
end

function var_0_0.GetAwardDesc(arg_9_0, arg_9_1)
	if ActivityLinkGameRewardCfg[arg_9_1] then
		if ConditionCfg[ActivityLinkGameRewardCfg[arg_9_1].condition].type == DormLinkGameConst.AwardCondition.Point then
			local var_9_1

			for iter_9_0, iter_9_1 in ipairs(ActivityLinkGameCfg.all) do
				if ActivityLinkGameCfg[iter_9_1].activity_id == ActivityLinkGameRewardCfg[arg_9_1].activity_id then
					var_9_1 = ActivityCfg[ActivityLinkGameRewardCfg[arg_9_1].activity_id].remark

					break
				end
			end

			if var_9_1 then
				return string.format(ConditionCfg[ActivityLinkGameRewardCfg[arg_9_1].condition].desc, var_9_1, ConditionCfg[ActivityLinkGameRewardCfg[arg_9_1].condition].params[2])
			end
		end
	end

	print("未找奖励id")
end

function var_0_0.GetCurrencyID(arg_10_0, arg_10_1)
	return CurrencyIdMapCfg.CURRENCY_LINKGAME_COST.item_id
end

function var_0_0:ChecklevelUnLock(arg_11_1)
	if ActivityLinkGameCfg[arg_11_1] then
		local var_11_0, var_11_1 = self:CheckLevelActivityUnlock(ActivityLinkGameCfg[arg_11_1].activity_id)

		if not var_11_0 then
			return false, var_11_1
		end

		local var_11_2 = ActivityLinkGameCfg[arg_11_1].pre_stage

		if ActivityLinkGameCfg[arg_11_1].pre_stage and var_11_2 ~= 0 and not DormLinkGameData:CheckActivityComplete(var_11_2) then
			return false, DormLinkGameConst.LevelLockType.preLevel, var_11_2
		end

		return true
	end
end

function var_0_0.CheckLevelActivityUnlock(arg_12_0, arg_12_1)
	local var_12_0 = ActivityTools.GetActivityStatus(arg_12_1)

	if var_12_0 == 1 then
		return true
	elseif var_12_0 == 0 then
		return false, DormLinkGameConst.LevelLockType.time, ActivityData:GetActivityData(arg_12_1).startTime
	elseif var_12_0 == 2 then
		return false, DormLinkGameConst.LevelLockType.stop
	else
		return false
	end
end

function var_0_0.CheckAnyLevelInActivityUnlock(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(ActivityLinkGameCfg.get_id_list_by_activity_id[arg_13_1]) do
		local var_13_0 = ActivityLinkGameCfg[iter_13_1].pre_stage or 0

		if var_13_0 == 0 or DormLinkGameData:CheckActivityComplete(var_13_0) then
			return true
		end
	end

	return false
end

function var_0_0.GetDormLinkGameItemIcon(arg_14_0, arg_14_1, arg_14_2)
	if ActivityLinkGameGoodsCfg[arg_14_2].path and ActivityLinkGameGoodsCfg[arg_14_2].goods_icon_id then
		return getSpriteWithoutAtlas(ActivityLinkGameGoodsCfg[arg_14_2].path .. "/" .. ActivityLinkGameGoodsCfg[arg_14_2].goods_icon_id)
	end
end

function var_0_0.GetFoodMaterialIcon(arg_15_0, arg_15_1)
	return getSpriteWithoutAtlas(ActivityLinkGameCellCfg[arg_15_1].path .. "/" .. ActivityLinkGameCellCfg[arg_15_1].album_id)
end

function var_0_0:PlaySpecialVoice(arg_16_1, arg_16_2)
	local var_16_0 = self:FindConformSpecialVoice(arg_16_1, arg_16_2)

	if var_16_0 then
		local var_16_1 = nullable(ActivityLinkGameDialogCfg, var_16_0)

		if var_16_1 then
			local var_16_2 = math.random(#var_16_1.sheetName)

			if var_16_1.sheetName[var_16_2] ~= "" then
				manager.audio:PlayEffect(var_16_1.sheetName[var_16_2], var_16_1.cueName[var_16_2], var_16_1.awbName[var_16_2])
			end
		end
	end
end

function var_0_0:FindConformSpecialVoice(arg_17_1, arg_17_2)
	local var_17_0 = nullable(ActivityLinkGameDialogCfg, "all")

	if var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			if ConditionCfg[ActivityLinkGameDialogCfg[iter_17_1].condition].type == arg_17_1 and self:CheckConditionConform(ActivityLinkGameDialogCfg[iter_17_1].condition, arg_17_2, arg_17_1) then
				return iter_17_1
			end
		end
	end
end

function var_0_0.CheckConditionConform(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 == DormLinkGameConst.SpecialVoiceType.SuccssBatterNum then
		if arg_18_2.oldNum < ConditionCfg[arg_18_1].params[1] and ConditionCfg[arg_18_1].params[1] <= arg_18_2.newNum then
			return true
		end
	elseif arg_18_3 == DormLinkGameConst.SpecialVoiceType.FaileBatterNum then
		if arg_18_2.num >= ConditionCfg[arg_18_1].params[1] then
			return true
		end
	elseif arg_18_3 == DormLinkGameConst.SpecialVoiceType.SuccssfulLevel then
		return true
	elseif arg_18_3 == DormLinkGameConst.SpecialVoiceType.FaileLevel then
		return true
	elseif arg_18_3 == DormLinkGameConst.SpecialVoiceType.LastTime then
		if ConditionCfg[arg_18_1].params[1] < arg_18_2.num + 1 and arg_18_2.num <= ConditionCfg[arg_18_1].params[1] then
			return true
		end
	end

	return false
end

function var_0_0.GetSkillItemDecs(arg_19_0, arg_19_1)
	return string.format(ActivityLinkGameGoodsCfg[arg_19_1].goods_des, ActivityLinkGameGoodsCfg[arg_19_1].coin_num, ActivityLinkGameGoodsCfg[arg_19_1].extra_param[1])
end

function var_0_0:UseSkillItem(arg_20_1)
	local var_20_0 = DormLinkGameData:GetGameCacheInfo()

	var_20_0.useItemList[arg_20_1] = var_20_0.useItemList[arg_20_1] or 0
	var_20_0.useItemList[arg_20_1] = var_20_0.useItemList[arg_20_1] + 1
	var_20_0.costTokenNum = var_20_0.costTokenNum + ActivityLinkGameGoodsCfg[arg_20_1].coin_num

	self:ImplementItemEffect(arg_20_1)
	manager.notify:Invoke(LIANLIANKAN_USE_ITEM)
end

function var_0_0.ImplementItemEffect(arg_21_0, arg_21_1)
	if arg_21_1 == DormLinkGameConst.SkillItemEffectType.Eliminate then
		manager.notify:Invoke(LIANLIANKAN_AUTO_MATCH, ActivityLinkGameGoodsCfg[arg_21_1].extra_param[1])
	elseif arg_21_1 == DormLinkGameConst.SkillItemEffectType.ClearMaterialList then
		manager.notify:Invoke(LIANLIANKAN_PREVIEW_REMOVE_ALL)
		manager.notify:Invoke(LIANLIANKAN_FREEZE, ActivityLinkGameGoodsCfg[arg_21_1].extra_param[1])
	elseif arg_21_1 == DormLinkGameConst.SkillItemEffectType.IgnoreConnection then
		manager.notify:Invoke(LIANLIANKAN_BUFF_IGNORE_CONNECTION, ActivityLinkGameGoodsCfg[arg_21_1].extra_param[1])
	end
end

function var_0_0.ExitGame(arg_22_0)
	DormLinkGameData:DisposeGameCacheInfo()
	LuaExchangeHelper.GoToMain()
	OpenPageUntilLoaded("/dormLinkGameLevelView")
end

return var_0_0
