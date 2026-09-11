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

	manager.redPoint:setTip(RedPointConst.FOLLOW_GIFT, (not table.keyof(OperationData:GetOperationOpenList(), OperationConst.ATTENTION) or nil) and 0)
end

function var_0_0.UpdateDormArchitectureRedPoint(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs((DormData:GetAllHeroInDorm())) do
		var_3_0[iter_3_1.architectureID] = (var_3_0[iter_3_1.architectureID] or 0) + DormTools.getHeroEarn(iter_3_1.heroID) + DormData:GetDormHero(iter_3_1.heroID):GetEarnings()
	end

	for iter_3_2, iter_3_3 in pairs(var_3_0) do
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
	manager.redPoint:setTip(RedPointConst.SETTING_REMIND, getData("setting", "newFunction") or 1)
end

function var_0_0:UpdateSubModuleRedDot()
	self:UpdateDailyFatigueRedDot()
end

function var_0_0.UpdateDailyFatigueRedDot(arg_7_0)
	manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, (DailyFatigueData:GetRedCount()))
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

function var_0_0:UpdateShopBtnTag()
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) and ActivityNoobData:IsFirstRechargeNewTag() then
		SetActive(self.shopBtnTagGo_, true)

		self.shopBtnTagText_.text = GetTips("RECHARGE_WELFARE")
	else
		SetActive(self.shopBtnTagGo_, false)
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

function var_0_0:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.btn_mail_transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:bindUIandKey(self.btn_combat_transform, RedPointConst.COMBAT)
	manager.redPoint:bindUIandKey(self.btn_goddess_transform, RedPointConst.GODDESS)
	manager.redPoint:bindUIandKey(self.btn_task_transform, RedPointConst.TASK)
	manager.redPoint:bindUIandKey(self.hero_transform, RedPointConst.HERO)
	manager.redPoint:bindUIandKey(self.btn_passport.transform, RedPointConst.PASSPORT)
	manager.redPoint:bindUIandKey(self.btn_shop.transform, RedPointConst.RECHARGE_ENTER)
	manager.redPoint:bindUIandKey(self.btn_message.transform, RedPointConst.ILLU_MAIN)
	manager.redPoint:bindUIandKey(self.transformNewbie_, RedPointConst.NEWBIE_POINT)
	manager.redPoint:bindUIandKey(self.btnGuild_.transform, RedPointConst.GUILD)
	manager.redPoint:bindUIandKey(self.btn_regression.transform, RedPointConst.NEW_REGRESSION)
	manager.redPoint:bindUIandKey(self.btnPreviewTask_.transform, RedPointConst.PREVIEW_TASK)
	manager.redPoint:bindUIandKey(self.btn_menu.transform, RedPointConst.MAIN_HOME_MENU)
	manager.redPoint:bindUIandKey(self.btn_callback.transform, RedPointConst.RECALL)
	manager.redPoint:bindUIandKey(self.btn_newbie_task.transform, RedPointConst.NOOB_ADVANCE)
	manager.redPoint:bindUIandKey(self.btn_dorm_.transform, RedPointConst.BACKHOME)
	manager.redPoint:bindUIandKey(self.btn_draw.transform, RedPointConst.DRAW_HOME)
	manager.redPoint:bindUIandKey(self.momoTalkBtn_.transform, RedPointConst.MOMO_CHAT_RED)
	manager.redPoint:bindUIandKey(self.btn_chat.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.redPoint:bindUIandKey(self.btn_newServer.transform, RedPointConst.ACTIVITY_NEW_SERVER)
end

function var_0_0:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.btn_mail_transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:unbindUIandKey(self.btn_combat_transform, RedPointConst.COMBAT)
	manager.redPoint:unbindUIandKey(self.btn_goddess_transform, RedPointConst.GODDESS)
	manager.redPoint:unbindUIandKey(self.btn_task_transform, RedPointConst.TASK)
	manager.redPoint:unbindUIandKey(self.hero_transform, RedPointConst.HERO)
	manager.redPoint:unbindUIandKey(self.btn_passport.transform, RedPointConst.PASSPORT)
	manager.redPoint:unbindUIandKey(self.btn_shop.transform, RedPointConst.RECHARGE_ENTER)
	manager.redPoint:unbindUIandKey(self.btn_message.transform, RedPointConst.ILLU_MAIN)
	manager.redPoint:unbindUIandKey(self.transformNewbie_, RedPointConst.NEWBIE_POINT)
	manager.redPoint:unbindUIandKey(self.btnGuild_.transform, RedPointConst.GUILD)
	manager.redPoint:unbindUIandKey(self.btn_regression.transform, RedPointConst.NEW_REGRESSION)
	manager.redPoint:unbindUIandKey(self.btnPreviewTask_.transform, RedPointConst.PREVIEW_TASK)
	manager.redPoint:unbindUIandKey(self.btn_menu.transform, RedPointConst.MAIN_HOME_MENU)
	manager.redPoint:unbindUIandKey(self.btn_callback.transform, RedPointConst.RECALL)
	manager.redPoint:unbindUIandKey(self.btn_newbie_task.transform, RedPointConst.NOOB_ADVANCE)
	manager.redPoint:unbindUIandKey(self.btn_dorm_.transform, RedPointConst.BACKHOME)
	manager.redPoint:unbindUIandKey(self.btn_draw.transform, RedPointConst.DRAW_HOME)
	manager.redPoint:unbindUIandKey(self.momoTalkBtn_.transform, RedPointConst.MOMO_CHAT_RED)
	manager.redPoint:unbindUIandKey(self.btn_chat.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.redPoint:unbindUIandKey(self.btn_newServer.transform, RedPointConst.ACTIVITY_NEW_SERVER)
end
