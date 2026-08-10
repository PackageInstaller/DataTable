local var_0_0 = class("MenuPopView", ReduxView)
local var_0_1 = {
	userCenter = 9901,
	activity = 9910,
	shop = 9911,
	query = 9905,
	suggest = 9902,
	info = 9912,
	psq = 9907,
	forum = 9904,
	attention = 9908,
	uccn = 9909,
	cdk = 9903
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/MenuUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()

	arg_3_0.OnHideMenuHanlder_ = handler(arg_3_0, arg_3_0.OnHideMenu)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.menuList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexMenuItem), arg_4_0.listGo_, MenuPopItem)
	arg_4_0.menuFunctionList_ = {}
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.musicBtn_, nil, function()
		JumpTools.OpenPageByJump("/illuMusic", {
			isEnter = true
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.GoToSystem("/task", {
			initNormalizedPosition = true,
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)
	arg_5_0:AddBtnListener(arg_5_0.mailBtn_, nil, function()
		local var_8_0 = handler(arg_5_0, function()
			JumpTools.GoToSystem("/mailBox")
		end)

		MailData.GetMailListFromServer(var_8_0)
		MailData.ClickMailBtn(manager.time:GetServerTime())
	end)
	arg_5_0:AddBtnListener(arg_5_0.settingBtn_, nil, function()
		JumpTools.GoToSystem("/setting", {
			setType = SettingConst.SETTING_TYPE.SYSTEM
		}, ViewConst.SYSTEM_ID.SETTING)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_exitBtn, function()
		ShowMessageBox({
			content = GetTips("TIP_LOGOUT_GOTO_LOGIN_VIEW"),
			OkCallback = function()
				GotoLoginView()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.userCenterBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)

	arg_5_0.menuFunctionList_[MenuPopConst.Servant] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_1")
		SDKTools.SendMessageToSDK("weapon_servant_touch", {
			touch_times = 1
		})
		JumpTools.OpenPageByJump("/weaponServant")
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Illustrated] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_3")
		JumpTools.GoToSystem("/illustratedMain", nil, ViewConst.SYSTEM_ID.ILLUSTRATION)
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Achieve] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_4")
		JumpTools.GoToSystem("/achievementManager", nil, ViewConst.SYSTEM_ID.ACHIEVEMENT)
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Explore] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_5")
		JumpTools.OpenPageByJump("/adminCatExploreView", nil, ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE)
	end
	arg_5_0.menuFunctionList_[MenuPopConst.HeartStory] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_6")
		JumpTools.GoToSystem("/newHeroArchiveView")
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Sign] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_7")
		JumpTools.OpenPageByJump("sign", {
			check = true,
			activityID = ActivityConst.SIGN
		}, ViewConst.SYSTEM_ID.SIGN)
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Announcement] = function(arg_22_0)
		OperationRecorder.RecordButtonTouch("homepage_expand_8")

		local var_22_0 = arg_22_0:GetBulletinID()

		if var_22_0 == false then
			ShowTips("NO_ANNOUNCEMENT")
		else
			JumpTools.OpenPageByJump("bulletin", {
				bulletinID = var_22_0
			}, ViewConst.SYSTEM_ID.ANNOUNCEMENT)
		end
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Survey] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_9")
		SurveyAction.SetSurveyRedPointData()
		JumpTools.OpenPageByJump("survey", {
			type = OperationConst.SURVEY_TYPE.NORMAL
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 4,
			direction_channel = 4
		})
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Infomation] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_17")

		local var_24_0 = {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		}

		OperationAction.OpenOperationUrl("INFORMATION_URL", var_24_0)
		RedPointAction.HandleRedPoint(RED_POINT_ID.INFOMATION)
		manager.redPoint:setTip(RedPointConst.INFOMATION, 0)
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Forum] = function()
		local var_25_0 = {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		}

		if _G.ChannelLoginInfo ~= nil then
			var_25_0.gameAppId = _G.ChannelLoginInfo.channelAppId
			var_25_0.token = _G.ChannelLoginInfo.channelToken
		end

		OperationRecorder.RecordButtonTouch("homepage_expand_12")
		OperationAction.OpenOperationUrl("FORUM_URL", var_25_0)
		RedPointAction.HandleNeedRedPoint(RED_POINT_ID.FORUM)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 4
		})
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
		manager.redPoint:setTip(RedPointConst.FORUM_UNREAD, 0)
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Cdk] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_11")
		JumpTools.OpenPageByJump("GiftPopUp")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 7,
			direction_channel = 4
		})
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Attention] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_10")
		saveData("SDK", "followGift", 0)
		manager.redPoint:setTip(RedPointConst.FOLLOW_GIFT, 0)
		JumpTools.OpenPageByJump("/followGift")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 5,
			direction_channel = 4
		})
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Shop] = function()
		local var_28_0 = {}

		OperationRecorder.RecordButtonTouch("homepage_expand_14")
		OperationAction.OpenOperationUrl("SHOPPING_URL", var_28_0)
		RedPointAction.HandleNeedRedPoint(RED_POINT_ID.SHOP_TAOBAO)
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 10,
			direction_channel = 4
		})
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Inquery] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_15")

		local var_29_0 = {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		}

		OperationAction.OpenOperationUrl("INQUERY_URL", var_29_0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 6,
			direction_channel = 4
		})
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Suggest] = function()
		if GameToSDK.IsPCPlatform() then
			local var_30_0 = {
				userId = PlayerData:GetPlayerInfo().userID,
				signUserId = PlayerData:GetPlayerInfo().signUserId
			}

			OperationAction.OpenOperationUrl("PC_FEEDBACK", var_30_0)
			manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, 0)
		else
			OperationRecorder.RecordButtonTouch("homepage_expand_16")
			NeedGameUserInfo()
			SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
			manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, 0)
			SDKTools.SendMessageToSDK("direction", {
				direction_type = 3,
				direction_channel = 4
			})
		end
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Cooperation] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_19")

		if CooperationAction.CheckCooperationApplyLimit(true) then
			return
		end

		JumpTools.OpenPageByJump("cooperationApply")
	end
	arg_5_0.menuFunctionList_[MenuPopConst.Activity] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_13")

		local var_32_0 = {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		}

		OperationAction.OpenOperationUrl("ACTIVITY_URL", var_32_0)
		RedPointAction.HandleNeedRedPoint(RED_POINT_ID.ACTIVITY)
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end
	arg_5_0.menuFunctionList_[MenuPopConst.OfficialWeb] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_18")
		OperationAction.OpenOperationUrl("OFFICIAL_URL")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 1,
			direction_channel = 4
		})
	end
	arg_5_0.menuFunctionList_[MenuPopConst.friend] = function()
		local var_34_0 = ViewConst.SYSTEM_ID.FRIEND
		local var_34_1 = JumpTools.IsSystemLocked(var_34_0)

		if var_34_0 and var_34_1 then
			ShowTips(JumpTools.GetSystemLockedTip(var_34_0, var_34_1))

			return
		end

		FriendsAction:TryToRefreshFriendsView(FriendsConst.FRIEND_TYPE.MY_FRIENDS, function()
			OperationRecorder.RecordButtonTouch("homepage_firend")
			JumpTools.GoToSystem("/friendsUI", {
				friendPage = FriendsConst.FRIEND_TYPE.MY_FRIENDS
			}, ViewConst.SYSTEM_ID.FRIEND)
		end)
	end
	arg_5_0.menuFunctionList_[MenuPopConst.AdminSystem] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_22")
		JumpTools.GoToSystem("/adminHomePageView", nil, ViewConst.SYSTEM_ID.ADMIN_SYSTEM)
	end
end

function var_0_0.OnEnter(arg_37_0)
	arg_37_0.btnList_ = {}

	arg_37_0:RefreshBtnOpen()
	arg_37_0:RefreshLock()
	arg_37_0.menuList_:StartScroll(#arg_37_0.btnList_)
	arg_37_0:RefreshMusic()
	arg_37_0:BindRedPointUI()
	arg_37_0:CheckPosterGirlDebut()
	manager.notify:RegistListener(HOME_HIDE_MENU_POP, arg_37_0.OnHideMenuHanlder_)
end

function var_0_0.IndexMenuItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0.btnList_[arg_38_1]

	arg_38_2:SetData(var_38_0, arg_38_0.menuFunctionList_[var_38_0.id])
	arg_38_2:UnBindRedPointUI()
	arg_38_2:BindRedPointUI()
end

function var_0_0.RefreshBtnOpen(arg_39_0)
	local var_39_0 = OperationData:GetOperationOpenList()
	local var_39_1 = PlayerData:GetPlayerInfo().userLevel

	SetActive(arg_39_0.userCenterBtn_.gameObject, table.keyof(var_39_0, OperationConst.USER_CENTER) ~= nil and var_39_1 >= SystemCfg[var_0_1.userCenter].open_condition[1][2])

	local var_39_2 = clone(MenuPopConst.MenuBtnList)

	for iter_39_0, iter_39_1 in pairs(var_39_2) do
		if not MenuPopConst.MenuToOperation[iter_39_0] or table.keyof(var_39_0, MenuPopConst.MenuToOperation[iter_39_0]) ~= nil and var_39_1 >= SystemCfg[iter_39_1.systemId].open_condition[1][2] then
			if iter_39_1.id ~= MenuPopConst.Cooperation then
				if iter_39_1.id ~= MenuPopConst.Guide then
					table.insert(arg_39_0.btnList_, iter_39_1)
				end
			elseif CooperationTools.GetShowInviteRoot() then
				table.insert(arg_39_0.btnList_, iter_39_1)
			end
		end
	end

	table.sort(arg_39_0.btnList_, function(arg_40_0, arg_40_1)
		local var_40_0 = arg_40_0.sort and arg_40_0.sort or 0
		local var_40_1 = arg_40_1.sort and arg_40_1.sort or 0

		if var_40_0 == var_40_1 then
			return arg_40_0.id < arg_40_1.id
		end

		return var_40_1 < var_40_0
	end)
end

function var_0_0.RefreshLock(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.btnList_) do
		if iter_41_1.id == MenuPopConst.Chip then
			iter_41_1.lock = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER)
		elseif iter_41_1.id == MenuPopConst.Explore then
			iter_41_1.lock = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE)
		elseif iter_41_1.id == MenuPopConst.friend then
			local var_41_0 = ViewConst.SYSTEM_ID.FRIEND

			iter_41_1.lock = JumpTools.IsSystemLocked(var_41_0)
		elseif iter_41_1.id == MenuPopConst.AdminSystem then
			local var_41_1 = ViewConst.SYSTEM_ID.ADMIN_SYSTEM

			iter_41_1.lock = JumpTools.IsSystemLocked(var_41_1)
		end
	end
end

function var_0_0.RefreshMusic(arg_42_0)
	local var_42_0 = MusicRecordCfg.all[1]
	local var_42_1 = GetHomeMusicID()

	if var_42_1 ~= 0 and MusicRecordCfg[var_42_1] then
		var_42_0 = var_42_1
	else
		local var_42_2 = manager.audio:GetBgmPlayer()

		if var_42_2 then
			local var_42_3 = var_42_2.cueName or ""
			local var_42_4 = var_42_2.cueSheet or ""

			if var_42_3 ~= "" and var_42_4 ~= "" then
				local var_42_5 = MusicRecordCfg.all

				for iter_42_0, iter_42_1 in ipairs(var_42_5) do
					local var_42_6 = MusicRecordCfg[iter_42_1]

					if var_42_6 and var_42_6.cueName == var_42_3 and var_42_6.cuesheet == var_42_4 then
						var_42_0 = iter_42_1
					end
				end
			end
		end
	end

	arg_42_0.musicTxt_.text = GetI18NText(MusicRecordCfg[var_42_0].musicName)
end

function var_0_0.BindRedPointUI(arg_43_0)
	manager.redPoint:bindUIandKey(arg_43_0.settingBtn_.transform, RedPointConst.SETTING_NEW_FUNCTION)
	manager.redPoint:bindUIandKey(arg_43_0.taskBtn_.transform, RedPointConst.TASK)
	manager.redPoint:bindUIandKey(arg_43_0.mailBtn_.transform, RedPointConst.MAIL_UNREAD)
end

function var_0_0.UnBindRedPointUI(arg_44_0)
	manager.redPoint:unbindUIandKey(arg_44_0.settingBtn_.transform, RedPointConst.SETTING_NEW_FUNCTION)
	manager.redPoint:unbindUIandKey(arg_44_0.taskBtn_.transform, RedPointConst.TASK)
	manager.redPoint:unbindUIandKey(arg_44_0.mailBtn_.transform, RedPointConst.MAIL_UNREAD)
end

function var_0_0.CheckPosterGirlDebut(arg_45_0)
	if PlayerData:GetPosterGirlDebut() then
		arg_45_0:OnHideMenu(true)
	end
end

function var_0_0.OnHideMenu(arg_46_0, arg_46_1)
	SetActive(arg_46_0.gameObject_, not arg_46_1)
end

function var_0_0.OnTop(arg_47_0)
	return
end

function var_0_0.OnExit(arg_48_0)
	if arg_48_0.menuList_ then
		local var_48_0 = arg_48_0.menuList_:GetItemList()

		for iter_48_0, iter_48_1 in ipairs(var_48_0) do
			iter_48_1:OnExit()
		end
	end

	arg_48_0:UnBindRedPointUI()
	manager.notify:RemoveListener(HOME_HIDE_MENU_POP, arg_48_0.OnHideMenuHanlder_)
end

function var_0_0.Dispose(arg_49_0)
	arg_49_0:RemoveAllListeners()

	if arg_49_0.menuList_ then
		arg_49_0.menuList_:Dispose()
	end

	var_0_0.super.Dispose(arg_49_0)
end

function var_0_0.OnExitInput(arg_50_0)
	arg_50_0:Back()
end

return var_0_0
