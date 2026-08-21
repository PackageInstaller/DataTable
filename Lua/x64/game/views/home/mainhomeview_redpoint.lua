local var_0_0 = partialClass("MainHomeView", ReduxView)

function var_0_0.CheckIsNeedOpenWebPage(arg_1_0)
	local var_1_0 = GameToSDK.GetData("{\"dataType\" : \"GetWebPageURL\"}")

	if var_1_0 == "{}" then
		var_1_0 = nil
	end

	print("check webPageUrl", var_1_0)

	if not string.isNullOrEmpty(var_1_0) then
		LuaForUtil.OpenWebView(var_1_0, true)
	end
end

function var_0_0.UpdateFollowGiftRedPoint(arg_2_0)
	local var_2_0 = getData("SDK", "followGift") or 1
	local var_2_1 = OperationData:GetOperationOpenList()

	if not table.keyof(var_2_1, OperationConst.ATTENTION) then
		var_2_0 = 0
	end

	manager.redPoint:setTip(RedPointConst.FOLLOW_GIFT, var_2_0)
end

function var_0_0.UpdateDormArchitectureRedPoint(arg_3_0)
	local var_3_0 = DormData:GetAllHeroInDorm()
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = iter_3_1.architectureID
		local var_3_3 = iter_3_1.heroID
		local var_3_4 = DormData:GetDormHero(var_3_3):GetEarnings()
		local var_3_5 = DormTools.getHeroEarn(var_3_3)

		var_3_1[var_3_2] = (var_3_1[var_3_2] or 0) + var_3_5 + var_3_4
	end

	for iter_3_2, iter_3_3 in pairs(var_3_1) do
		if iter_3_3 > GameSetting.dorm_entrance_red_dot_need.value[1] then
			manager.redPoint:setTip(RedPointConst.DORM_TOTAL_EARN, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.DORM_TOTAL_EARN, 0)
end

function var_0_0.UpdateDormSpecialEventRedPoint(arg_4_0)
	if #DormData:GetSpecialEvents() ~= 0 then
		manager.redPoint:setTip(RedPointConst.DORM_SPECIAL_EVENT, 1)
	else
		manager.redPoint:setTip(RedPointConst.DORM_SPECIAL_EVENT, 0)
	end
end

function var_0_0.UpdataSettingNewFunctionRedPoint(arg_5_0)
	local var_5_0 = getData("setting", "newFunction") or 1

	manager.redPoint:setTip(RedPointConst.SETTING_REMIND, var_5_0)
end

function var_0_0.UpdateSubModuleRedDot(arg_6_0)
	arg_6_0:UpdateDailyFatigueRedDot()
end

function var_0_0.UpdateDailyFatigueRedDot(arg_7_0)
	local var_7_0 = DailyFatigueData:GetRedCount()

	manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, var_7_0)
end

function var_0_0.UpdataOperationViewRedPoint(arg_8_0)
	local var_8_0 = OperationData:GetOperationOpenList()

	if RedPointData:GetRedPointOpen(RED_POINT_ID.ACTIVITY) and table.keyof(var_8_0, OperationConst.ACTIVITY) ~= nil then
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 1)
	else
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.FORUM) and table.keyof(var_8_0, OperationConst.FORUM) ~= nil then
		manager.redPoint:setTip(RedPointConst.FORUM, 1)
	else
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.SHOP_TAOBAO) and table.keyof(var_8_0, OperationConst.SHOP_TAOBAO) ~= nil then
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 1)
	else
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.INFOMATION) and table.keyof(var_8_0, OperationConst.INFOMATION) ~= nil then
		manager.redPoint:setTip(RedPointConst.INFOMATION, 1)
	else
		manager.redPoint:setTip(RedPointConst.INFOMATION, 0)
	end
end

function var_0_0.UpdateShopBtnTag(arg_9_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) and ActivityNoobData:IsFirstRechargeNewTag() then
		SetActive(arg_9_0.shopBtnTagGo_, true)

		arg_9_0.shopBtnTagText_.text = GetTips("RECHARGE_WELFARE")
	else
		SetActive(arg_9_0.shopBtnTagGo_, false)
	end
end

function var_0_0.UpdateChipRedPoint(arg_10_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) then
		ChipAction:UpdateChipRed()
	end
end

function var_0_0.UpdateOathRedPoint(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(WeddingCfg.all) do
		OathSupportData:UpdateOathNewHeroNotice(iter_11_1)
		OathSupportData:UpdateOathCanCompleteNotice(iter_11_1)
	end
end

function var_0_0.UpdateFriendsRedPoint(arg_12_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
		FriendsAction:UpdateFriendsRedTip()
	end
end

function var_0_0.BindRedPointUI(arg_13_0)
	manager.redPoint:bindUIandKey(arg_13_0.btn_mail_transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:bindUIandKey(arg_13_0.btn_combat_transform, RedPointConst.COMBAT)
	manager.redPoint:bindUIandKey(arg_13_0.btn_goddess_transform, RedPointConst.GODDESS)
	manager.redPoint:bindUIandKey(arg_13_0.btn_task_transform, RedPointConst.TASK)
	manager.redPoint:bindUIandKey(arg_13_0.hero_transform, RedPointConst.HERO)
	manager.redPoint:bindUIandKey(arg_13_0.btn_passport.transform, RedPointConst.PASSPORT)
	manager.redPoint:bindUIandKey(arg_13_0.btn_shop.transform, RedPointConst.RECHARGE_ENTER)
	manager.redPoint:bindUIandKey(arg_13_0.btn_message.transform, RedPointConst.ILLU_MAIN)
	manager.redPoint:bindUIandKey(arg_13_0.transformNewbie_, RedPointConst.NEWBIE_POINT)
	manager.redPoint:bindUIandKey(arg_13_0.btnGuild_.transform, RedPointConst.GUILD)
	manager.redPoint:bindUIandKey(arg_13_0.btn_regression.transform, RedPointConst.NEW_REGRESSION)
	manager.redPoint:bindUIandKey(arg_13_0.btnPreviewTask_.transform, RedPointConst.PREVIEW_TASK)
	manager.redPoint:bindUIandKey(arg_13_0.btn_menu.transform, RedPointConst.MAIN_HOME_MENU)
	manager.redPoint:bindUIandKey(arg_13_0.btn_callback.transform, RedPointConst.RECALL)
	manager.redPoint:bindUIandKey(arg_13_0.btn_newbie_task.transform, RedPointConst.NOOB_ADVANCE)
	manager.redPoint:bindUIandKey(arg_13_0.btn_dorm_.transform, RedPointConst.BACKHOME)
	manager.redPoint:bindUIandKey(arg_13_0.btn_draw.transform, RedPointConst.DRAW_HOME)
	manager.redPoint:bindUIandKey(arg_13_0.momoTalkBtn_.transform, RedPointConst.MOMO_CHAT_RED)
	manager.redPoint:bindUIandKey(arg_13_0.btn_chat.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.redPoint:bindUIandKey(arg_13_0.btn_newServer.transform, RedPointConst.ACTIVITY_NEW_SERVER)
end

function var_0_0.UnBindRedPointUI(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_mail_transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_combat_transform, RedPointConst.COMBAT)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_goddess_transform, RedPointConst.GODDESS)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_task_transform, RedPointConst.TASK)
	manager.redPoint:unbindUIandKey(arg_14_0.hero_transform, RedPointConst.HERO)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_passport.transform, RedPointConst.PASSPORT)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_shop.transform, RedPointConst.RECHARGE_ENTER)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_message.transform, RedPointConst.ILLU_MAIN)
	manager.redPoint:unbindUIandKey(arg_14_0.transformNewbie_, RedPointConst.NEWBIE_POINT)
	manager.redPoint:unbindUIandKey(arg_14_0.btnGuild_.transform, RedPointConst.GUILD)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_regression.transform, RedPointConst.NEW_REGRESSION)
	manager.redPoint:unbindUIandKey(arg_14_0.btnPreviewTask_.transform, RedPointConst.PREVIEW_TASK)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_menu.transform, RedPointConst.MAIN_HOME_MENU)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_callback.transform, RedPointConst.RECALL)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_newbie_task.transform, RedPointConst.NOOB_ADVANCE)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_dorm_.transform, RedPointConst.BACKHOME)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_draw.transform, RedPointConst.DRAW_HOME)
	manager.redPoint:unbindUIandKey(arg_14_0.momoTalkBtn_.transform, RedPointConst.MOMO_CHAT_RED)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_chat.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.redPoint:unbindUIandKey(arg_14_0.btn_newServer.transform, RedPointConst.ACTIVITY_NEW_SERVER)
end
