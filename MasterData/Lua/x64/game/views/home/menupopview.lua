local MenuPopView = class("MenuPopView", ReduxView)
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

function MenuPopView:UIName()
	return "Widget/System/Main/MenuUI_new"
end

function MenuPopView:UIParent()
	return manager.ui.uiPop.transform
end

function MenuPopView:Init()
	self:InitUI()
	self:AddUIListeners()

	self.OnHideMenuHanlder_ = handler(self, self.OnHideMenu)
end

function MenuPopView:InitUI()
	self:BindCfgUI()

	self.menuList_ = LuaList.New(handler(self, self.IndexMenuItem), self.listGo_, MenuPopItem)
	self.menuFunctionList_ = {}
end

function MenuPopView:AddUIListeners()
	self:AddBtnListener(self.musicBtn_, nil, function()
		JumpTools.OpenPageByJump("/illuMusic", {
			isEnter = true
		})
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.GoToSystem("/task", {
			initNormalizedPosition = true,
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)
	self:AddBtnListener(self.mailBtn_, nil, function()
		MailData.GetMailListFromServer((handler(self, function()
			JumpTools.GoToSystem("/mailBox")
		end)))
		MailData.ClickMailBtn(manager.time:GetServerTime())
	end)
	self:AddBtnListener(self.settingBtn_, nil, function()
		JumpTools.GoToSystem("/setting", {
			setType = SettingConst.SETTING_TYPE.SYSTEM
		}, ViewConst.SYSTEM_ID.SETTING)
	end)
	self:AddBtnListener(nil, self.m_exitBtn, function()
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
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.userCenterBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)

	self.menuFunctionList_[MenuPopConst.Servant] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_1")
		SDKTools.SendMessageToSDK("weapon_servant_touch", {
			touch_times = 1
		})
		JumpTools.OpenPageByJump("/weaponServant")
	end
	self.menuFunctionList_[MenuPopConst.Illustrated] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_3")
		JumpTools.GoToSystem("/illustratedMain", nil, ViewConst.SYSTEM_ID.ILLUSTRATION)
	end
	self.menuFunctionList_[MenuPopConst.Achieve] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_4")
		JumpTools.GoToSystem("/achievementManager", nil, ViewConst.SYSTEM_ID.ACHIEVEMENT)
	end
	self.menuFunctionList_[MenuPopConst.Explore] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_5")
		JumpTools.OpenPageByJump("/adminCatExploreView", nil, ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE)
	end
	self.menuFunctionList_[MenuPopConst.HeartStory] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_6")
		JumpTools.GoToSystem("/newHeroArchiveView")
	end
	self.menuFunctionList_[MenuPopConst.Sign] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_7")
		JumpTools.OpenPageByJump("sign", {
			check = true,
			activityID = ActivityConst.SIGN
		}, ViewConst.SYSTEM_ID.SIGN)
	end
	self.menuFunctionList_[MenuPopConst.Announcement] = function(arg_22_0)
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
	self.menuFunctionList_[MenuPopConst.Survey] = function()
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
	self.menuFunctionList_[MenuPopConst.Infomation] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_17")
		OperationAction.OpenOperationUrl("INFORMATION_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		RedPointAction.HandleRedPoint(RED_POINT_ID.INFOMATION)
		manager.redPoint:setTip(RedPointConst.INFOMATION, 0)
	end
	self.menuFunctionList_[MenuPopConst.Forum] = function()
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
	self.menuFunctionList_[MenuPopConst.Cdk] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_11")
		JumpTools.OpenPageByJump("GiftPopUp")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 7,
			direction_channel = 4
		})
	end
	self.menuFunctionList_[MenuPopConst.Attention] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_10")
		saveData("SDK", "followGift", 0)
		manager.redPoint:setTip(RedPointConst.FOLLOW_GIFT, 0)
		JumpTools.OpenPageByJump("/followGift")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 5,
			direction_channel = 4
		})
	end
	self.menuFunctionList_[MenuPopConst.Shop] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_14")
		OperationAction.OpenOperationUrl("SHOPPING_URL", {})
		RedPointAction.HandleNeedRedPoint(RED_POINT_ID.SHOP_TAOBAO)
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 10,
			direction_channel = 4
		})
	end
	self.menuFunctionList_[MenuPopConst.Inquery] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_15")
		OperationAction.OpenOperationUrl("INQUERY_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 6,
			direction_channel = 4
		})
	end
	self.menuFunctionList_[MenuPopConst.Suggest] = function()
		if GameToSDK.IsPCPlatform() then
			OperationAction.OpenOperationUrl("PC_FEEDBACK", {
				userId = PlayerData:GetPlayerInfo().userID,
				signUserId = PlayerData:GetPlayerInfo().signUserId
			})
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
	self.menuFunctionList_[MenuPopConst.Cooperation] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_19")

		if CooperationAction.CheckCooperationApplyLimit(true) then
			return
		end

		JumpTools.OpenPageByJump("cooperationApply")
	end
	self.menuFunctionList_[MenuPopConst.Activity] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_13")
		OperationAction.OpenOperationUrl("ACTIVITY_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		RedPointAction.HandleNeedRedPoint(RED_POINT_ID.ACTIVITY)
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end
	self.menuFunctionList_[MenuPopConst.OfficialWeb] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_18")
		OperationAction.OpenOperationUrl("OFFICIAL_URL")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 1,
			direction_channel = 4
		})
	end
	self.menuFunctionList_[MenuPopConst.friend] = function()
		local var_34_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND)

		if ViewConst.SYSTEM_ID.FRIEND and var_34_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.FRIEND, var_34_0))

			return
		end

		FriendsAction:TryToRefreshFriendsView(FriendsConst.FRIEND_TYPE.MY_FRIENDS, function()
			OperationRecorder.RecordButtonTouch("homepage_firend")
			JumpTools.GoToSystem("/friendsUI", {
				friendPage = FriendsConst.FRIEND_TYPE.MY_FRIENDS
			}, ViewConst.SYSTEM_ID.FRIEND)
		end)
	end
	self.menuFunctionList_[MenuPopConst.AdminSystem] = function()
		OperationRecorder.RecordButtonTouch("homepage_expand_22")
		JumpTools.GoToSystem("/adminHomePageView", nil, ViewConst.SYSTEM_ID.ADMIN_SYSTEM)
	end
end

function MenuPopView:OnEnter()
	self.btnList_ = {}

	self:RefreshBtnOpen()
	self:RefreshLock()
	self.menuList_:StartScroll(#self.btnList_)
	self:RefreshMusic()
	self:BindRedPointUI()
	self:CheckPosterGirlDebut()
	manager.notify:RegistListener(HOME_HIDE_MENU_POP, self.OnHideMenuHanlder_)
end

function MenuPopView:IndexMenuItem(arg_38_1, arg_38_2)
	arg_38_2:SetData(self.btnList_[arg_38_1], self.menuFunctionList_[self.btnList_[arg_38_1].id])
	arg_38_2:UnBindRedPointUI()
	arg_38_2:BindRedPointUI()
end

function MenuPopView:RefreshBtnOpen()
	local var_39_0 = OperationData:GetOperationOpenList()
	local var_39_1 = PlayerData:GetPlayerInfo().userLevel

	SetActive(self.userCenterBtn_.gameObject, table.keyof(var_39_0, OperationConst.USER_CENTER) ~= nil and var_39_1 >= SystemCfg[var_0_1.userCenter].open_condition[1][2])

	for iter_39_0, iter_39_1 in pairs((clone(MenuPopConst.MenuBtnList))) do
		if not MenuPopConst.MenuToOperation[iter_39_0] or table.keyof(var_39_0, MenuPopConst.MenuToOperation[iter_39_0]) ~= nil and var_39_1 >= SystemCfg[iter_39_1.systemId].open_condition[1][2] then
			if iter_39_1.id ~= MenuPopConst.Cooperation then
				if iter_39_1.id ~= MenuPopConst.Guide then
					table.insert(self.btnList_, iter_39_1)
				end
			elseif CooperationTools.GetShowInviteRoot() then
				table.insert(self.btnList_, iter_39_1)
			end
		end
	end

	table.sort(self.btnList_, function(arg_40_0, arg_40_1)
		local var_40_0

		if arg_40_0.sort then
			var_40_0 = arg_40_0.sort or 0

			local var_40_1

			if arg_40_1.sort then
				var_40_1 = arg_40_1.sort or 0

				if var_40_0 == var_40_1 then
					return arg_40_0.id < arg_40_1.id
				end
			end
		end

		return var_40_1 < var_40_0
	end)
end

function MenuPopView:RefreshLock()
	for iter_41_0, iter_41_1 in ipairs(self.btnList_) do
		if iter_41_1.id == MenuPopConst.Chip then
			iter_41_1.lock = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER)
		elseif iter_41_1.id == MenuPopConst.Explore then
			iter_41_1.lock = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE)
		elseif iter_41_1.id == MenuPopConst.friend then
			iter_41_1.lock = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND)
		elseif iter_41_1.id == MenuPopConst.AdminSystem then
			iter_41_1.lock = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_SYSTEM)
		end
	end
end

function MenuPopView:RefreshMusic()
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
				for iter_42_0, iter_42_1 in ipairs(MusicRecordCfg.all) do
					if MusicRecordCfg[iter_42_1] and MusicRecordCfg[iter_42_1].cueName == var_42_3 and MusicRecordCfg[iter_42_1].cuesheet == var_42_4 then
						var_42_0 = iter_42_1
					end
				end
			end
		end
	end

	self.musicTxt_.text = GetI18NText(MusicRecordCfg[var_42_0].musicName)
end

function MenuPopView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.settingBtn_.transform, RedPointConst.SETTING_NEW_FUNCTION)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.TASK)
	manager.redPoint:bindUIandKey(self.mailBtn_.transform, RedPointConst.MAIL_UNREAD)
end

function MenuPopView:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.settingBtn_.transform, RedPointConst.SETTING_NEW_FUNCTION)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.TASK)
	manager.redPoint:unbindUIandKey(self.mailBtn_.transform, RedPointConst.MAIL_UNREAD)
end

function MenuPopView:CheckPosterGirlDebut()
	if PlayerData:GetPosterGirlDebut() then
		self:OnHideMenu(true)
	end
end

function MenuPopView:OnHideMenu(arg_46_1)
	SetActive(self.gameObject_, not arg_46_1)
end

function MenuPopView:OnTop()
	return
end

function MenuPopView:OnExit()
	if self.menuList_ then
		for iter_48_0, iter_48_1 in ipairs((self.menuList_:GetItemList())) do
			iter_48_1:OnExit()
		end
	end

	self:UnBindRedPointUI()
	manager.notify:RemoveListener(HOME_HIDE_MENU_POP, self.OnHideMenuHanlder_)
end

function MenuPopView:Dispose()
	self:RemoveAllListeners()

	if self.menuList_ then
		self.menuList_:Dispose()
	end

	MenuPopView.super.Dispose(self)
end

function MenuPopView:OnExitInput()
	self:Back()
end

return MenuPopView
