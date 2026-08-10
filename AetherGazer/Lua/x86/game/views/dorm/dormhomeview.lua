local var_0_0 = class("DormHomeView", ReduxView)
local var_0_1

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormitoryUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.likeBtnStateController = arg_4_0.controller:GetController("praise")
	arg_4_0.praiseAnimator = arg_4_0.praiseGo_:GetComponent("Animator")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RegisterEvents()
	arg_5_0:UpdataViewType()
	arg_5_0:RefreshRoomNameInfo()
	arg_5_0:RefreshDevInfo()
	arg_5_0.quickView:OnEnter()
	arg_5_0.tempquickGo_.transform:SetAsLastSibling()
	arg_5_0.quickView:ShowView(false)
	arg_5_0:UpdataDormitoryInternalRedPoint()
	arg_5_0:RefreshRedPonit()
	arg_5_0:AutoOpenSuitHelpPage()
	DormLuaBridge.SetIsCanEditTag(false)
	arg_5_0:RefreshLikeNum()
	arg_5_0:RefreshLikeBtnState()
	arg_5_0:RefreshUITime()
end

function var_0_0.OnTop(arg_6_0)
	arg_6_0:HideUiInfo(true)
	SetActive(arg_6_0.storeDiscount_, DormTools:AnyShopInDiscount())
end

function var_0_0.UpdataViewType(arg_7_0)
	arg_7_0.sceneID_ = DormData:GetCurrectSceneID()

	if arg_7_0.sceneID_ > DormConst.DORM_VISIT_ROOM_MIN then
		arg_7_0.stateController:SetSelectedState("visit")

		local var_7_0 = DormVisitTools:GetCurVisitPlayerType()

		if var_7_0 == 1 then
			arg_7_0.friendController:SetSelectedState("true")
		elseif var_7_0 == 2 then
			arg_7_0.friendController:SetSelectedState("false")
		end

		SetActive(arg_7_0.collectBtn_.gameObject, not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM))
	else
		arg_7_0.stateController:SetSelectedState("room")

		if arg_7_0.sceneID_ == DormVisitTools:GetCurTemplateExhibit() then
			arg_7_0.exhibitController:SetSelectedState("true")
		else
			arg_7_0.exhibitController:SetSelectedState("false")
		end
	end
end

function var_0_0.RefreshRoomNameInfo(arg_8_0)
	if BackHomeCfg[arg_8_0.sceneID_].type == DormConst.BACKHOME_TYPE.PublicDorm or BackHomeCfg[arg_8_0.sceneID_].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		arg_8_0.roomName.text = GetTips("DORM_LOBBY_NAME")

		arg_8_0.publicTextController:SetSelectedState("false")
	elseif BackHomeCfg[arg_8_0.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm or BackHomeCfg[arg_8_0.sceneID_].type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		local var_8_0 = DormitoryData:GetDormSceneData(arg_8_0.sceneID_).archiveIDList[1]

		if BackHomeCfg[arg_8_0.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			arg_8_0.publicTextController:SetSelectedState("true")
		else
			arg_8_0.publicTextController:SetSelectedState("false")
		end

		if var_8_0 then
			local var_8_1 = HeroRecordCfg.get_id_list_by_hero_id[var_8_0][1]

			if var_8_1 then
				local var_8_2 = HeroRecordCfg[var_8_1].name

				if var_8_2 then
					arg_8_0.roomName.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), GetI18NText(var_8_2))
				end

				arg_8_0:RefreshRoomLevel()
			end
		end
	end
end

function var_0_0.RefreshRedPonit(arg_9_0)
	manager.redPoint:bindUIandKey(arg_9_0.positionBtn_.transform, RedPointConst.DORM_PLACEMENT)
	manager.redPoint:bindUIandKey(arg_9_0.fureidbtnBtn_.transform, RedPointConst.DORM_FURNITURE)
	manager.redPoint:bindUIandKey(arg_9_0.btn_storeBtn_.transform, RedPointConst.DORM_SUIT_SHOP)
	manager.redPoint:bindUIandKey(arg_9_0.navigationBtn_.transform, RedPointConst.DORM_NAVI)

	for iter_9_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		DormRedPointTools:UpdataDormFurRedPoint(arg_9_0.sceneID_, iter_9_0)
	end

	if DormTools:ShouldShowBirthdayBtn(arg_9_0.sceneID_) then
		SetActive(arg_9_0.birthdayBtn_.gameObject, true)
	else
		SetActive(arg_9_0.birthdayBtn_.gameObject, false)
	end
end

function var_0_0.RefreshBar(arg_10_0)
	if arg_10_0.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})

		local var_10_0 = GameSetting.dorm_info_describe.value

		if #var_10_0 > 0 then
			manager.windowBar:SetGameHelpKey({
				view = "/gameHelpPro",
				type = "jump",
				params = {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = var_10_0
				}
			})
		end
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end

	manager.windowBar:RegistBackCallBack(function()
		if DormVisitTools:GetIsOtherSystem() then
			local var_11_0 = DormVisitTools:GetBackFunc()

			if var_11_0 then
				var_11_0()
			else
				BackHomeTools:OtherSystemVisitExit()
				OpenPageUntilLoaded("/home")
			end

			return
		end

		if arg_10_0.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
			JumpTools.OpenPageByJump("/dormChooseRoomView")
		else
			DormVisitTools:ClearVisitRoomData()

			if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
				BackHomeTools:BackHomeGotoMain()
				OpenPageUntilLoaded("/dormVisitView")
			else
				DormitoryData:VisitFlag(true)
				BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
			end
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		BackHomeTools:BackHomeGotoMain()
	end)
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_13_0.positionBtn_.transform, RedPointConst.DORM_PLACEMENT)
	manager.redPoint:unbindUIandKey(arg_13_0.fureidbtnBtn_.transform, RedPointConst.DORM_FURNITURE)
	manager.redPoint:unbindUIandKey(arg_13_0.btn_storeBtn_.transform, RedPointConst.DORM_SUIT_SHOP)
	manager.redPoint:unbindUIandKey(arg_13_0.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	arg_13_0.menuController:SetSelectedState("off")

	arg_13_0.menuState = false

	arg_13_0:RemoveAllEventListener()
	arg_13_0.quickView:OnExit()
	arg_13_0:ExitSendMgr()
end

function var_0_0.InitUI(arg_14_0)
	arg_14_0:BindCfgUI()

	arg_14_0.cacheRoles = {}
	arg_14_0.menuState = false
	arg_14_0.menuController = ControllerUtil.GetController(arg_14_0.btn_menuGo_.transform, "menu")
	arg_14_0.stateController = ControllerUtil.GetController(arg_14_0.transform_, "state")
	arg_14_0.exhibitController = ControllerUtil.GetController(arg_14_0.exhib.transform, "state")
	arg_14_0.publicTextController = ControllerUtil.GetController(arg_14_0.transform_, "public")
	arg_14_0.showUiController = ControllerUtil.GetController(arg_14_0.btn_hideGo_.transform, "btn")
	arg_14_0.friendController = ControllerUtil.GetController(arg_14_0.transform_, "addFriend")
	arg_14_0.menuAnimator = arg_14_0:FindCom(typeof(Animator), "", arg_14_0.menu_listTrs_)
	arg_14_0.quickView = BackHomeQuickJumpView.New(arg_14_0.tempquickGo_)
end

function var_0_0.AddUIListener(arg_15_0)
	arg_15_0:AddBtnListenerScale(arg_15_0.navigationBtn_, nil, function()
		if arg_15_0.sceneID_ > DormConst.DORM_VISIT_ROOM_MIN then
			return
		end

		JumpTools.OpenPageByJump("dormNavigation", {
			isMain = false
		})
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.positionBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.characterplacebtnBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormHeroDeployView")
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.templateBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormTemplateView", {
			pos = 1
		})
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.fureidbtnBtn_, nil, function()
		DormHeroTools.HideAllCharacter()
		JumpTools.OpenPageByJump("/roomEdit")
		DormFurEditStateData:EnterEditState()
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.dormlevelBtn_, nil, function()
		if BackHomeCfg[arg_15_0.sceneID_].type ~= DormConst.BACKHOME_TYPE.PrivateDorm then
			return
		end

		local var_21_0 = DormitoryData:GetArchiveIDViaRoomID(arg_15_0.sceneID_)[1]

		if var_21_0 then
			JumpTools.OpenPageByJump("/dormLevelInfoView", {
				archiveID = var_21_0
			})
		end
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.btn_storeBtn_, nil, function()
		local var_22_0 = DormTools:GetAllDormShopIDList()

		JumpTools.GoToSystem("/dormShop", {
			hideHomeBtn = true,
			shop = ShopConst.SHOP_ID.DORM_SHOP,
			shopList = var_22_0
		}, ViewConst.SYSTEM_ID.DORM_SHOP)
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.btn_menuBtn_, nil, function()
		if arg_15_0.menuState then
			arg_15_0.menuController:SetSelectedState("off")

			arg_15_0.menuState = false
		else
			arg_15_0.menuController:SetSelectedState("on")

			arg_15_0.menuState = true

			arg_15_0.menuAnimator:Play("DormitoryUI_menu_list")
		end
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.exhibBtn_, nil, function()
		local var_24_0 = DormVisitTools:GetCurTemplateExhibit()

		if not var_24_0 or arg_15_0.sceneID_ ~= var_24_0 then
			if SDKTools.IsSDK() then
				arg_15_0:PreSetupShow()
			else
				DormAction:SetFurTemplateExhibit(arg_15_0.sceneID_)
			end
		else
			ShowTips(GetTips("DORM_DISPLAY_ALREADY"))
		end
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.collectBtn_, nil, function()
		local var_25_0, var_25_1 = DormVisitTools:CheckCanSaveTemplate()

		if var_25_0 then
			JumpTools.OpenPageByJump("/dormVisitTemplateView")
		else
			ShowTips(var_25_1)
		end
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.addFriendBtn_, nil, function()
		local var_26_0 = DormVisitTools:GetVisitUserID()

		if var_26_0 then
			FriendsAction:TryToRequestToFriend(var_26_0, FriendConst.ADD_FRIEND_SOURCE.DORM)
		end
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.btn_hideBtn_, nil, function()
		if arg_15_0.uiShow then
			arg_15_0:HideUiInfo(false)
		else
			arg_15_0:HideUiInfo(true)
		end
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.giftBtn_, nil, function()
		local var_28_0 = DormData:GetCurrectSceneID()

		if BackHomeCfg[var_28_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			local var_28_1 = DormitoryData:GetArchiveIDViaRoomID(var_28_0)[1]
			local var_28_2 = DormData:GetHeroInfo(var_28_1)

			if var_28_2 then
				if var_28_2:GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
					local var_28_3 = DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero)
					local var_28_4

					for iter_28_0, iter_28_1 in Dorm.storage:ForeachData(var_28_3, pairs) do
						var_28_4 = iter_28_1
					end

					if var_28_4 then
						DormLuaBridge.ActAsClickToEntity(var_28_4)
					else
						print("未找到人物eid")
					end
				else
					JumpTools.OpenPageByJump("/dormHeroGiftView", {
						archiveID = var_28_1
					})
				end
			end
		end
	end)
	arg_15_0.quickView:AddClickCallBack(function()
		manager.windowBar:HideBar()
	end)
	arg_15_0.quickView:CloseCallBack(function()
		arg_15_0:RefreshBar()
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.reportBtn_, nil, function()
		local var_31_0 = DormVisitTools:GetVisitUserID()

		if var_31_0 then
			local var_31_1 = DormVisitTools:GetExhibitListByUserID(var_31_0)
			local var_31_2 = DormVisitTools:GetLayoutID()

			if var_31_1 then
				local var_31_3 = var_31_1.nick or ""

				JumpTools.OpenPageByJump("/chatReport", {
					reportType = ChatConst.CHAT_REPORT_TYPE.DORM,
					reportData = {
						nick = var_31_3,
						userID = var_31_0,
						layout_uid = var_31_2,
						architecture_id = var_31_1.architecture_id or var_31_1.backhome_architecture_id
					}
				}, ViewConst.SYSTEM_ID.CHAT_REPORT)
			end
		end
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.devbtnBtn_, nil, function()
		local var_32_0 = DormData:GetDevModelFlag()

		DormData:ChangeDevModelFlag(not var_32_0)
		arg_15_0:RefreshDevInfo()
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.likeBtn, nil, function()
		if arg_15_0.stateController:GetSelectedState() == "visit" then
			local var_33_0 = DormVisitTools:GetVisitUserID()
			local var_33_1 = DormVisitTools:GetCurVisitRoomData()

			if var_33_1.todayLikeNum < GameSetting.dorm_room_like_limted.value[1] and var_33_1 then
				DormAction.LikeDormRoom(var_33_0, var_33_1.architecture_id, function()
					DormAction:AskFurTemplateExhibitList(3)
				end)
			else
				ShowTips("DORM_SINGLE_ROOM_PRAISE_NUM")
			end
		end
	end)
end

function var_0_0.RegisterEvents(arg_35_0)
	arg_35_0:RegistEventListener(ON_PLAYER_CLICK_INTERACT, function(arg_36_0, arg_36_1)
		if not DormHeroTools:CheckIsVisitHero(arg_36_0) then
			arg_35_0.showUiController:SetSelectedState("off")
			SetActive(arg_35_0.btn_hideBtn_.gameObject, false)
			manager.windowBar:HideBar()

			if arg_35_0.sceneID_ > DormConst.DORM_VISIT_ROOM_MIN then
				return
			end

			Dorm.DormEntityManager.EnablePlayerInput = false

			DormUtils.ClearCharaHasSpecialVfx(arg_36_0)
			DormUtils.HideCharaSpecialVfx(arg_36_0)
			Timer.New(function()
				arg_35_0.showUiController:SetSelectedState("on")
				SetActive(arg_35_0.btn_hideBtn_.gameObject, true)
				JumpTools.OpenPageByJump("/heroInteractView", {
					heroEID = arg_36_0
				})
			end, DormConst.CHARACTER_INTERACT_CAMERA_MOVE_TIME, 1):Start()
			DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.InteractCam)

			local var_36_0 = DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero)

			for iter_36_0, iter_36_1 in Dorm.storage:ForeachData(var_36_0, pairs) do
				if iter_36_1 ~= arg_36_0 then
					Dorm.DormEntityManager.FadeOutNearPoint(iter_36_1, UnityEngine.Camera.main.transform, DormLuaBridge.GetCamFadeOtherCharaParam(nil, nil))
				end
			end
		elseif DormData:CanReceiveVisitReward() then
			BackHomeAction:RequestReward(function(arg_38_0)
				DormData:SetReceiveVisitReward(false)
				DormUtils.HideCharaSpecialVfx(arg_36_0)
				JumpTools.OpenPageByJump("/dormRewardNewPopView", {
					awardList = arg_38_0
				})
			end)
		end
	end)
	arg_35_0:RegistEventListener(DORM_REFRESH_EXIBIT, function()
		if arg_35_0.sceneID_ == DormVisitTools:GetCurTemplateExhibit() then
			ShowTips(GetTips("DORM_DISPLAY_SET_SUCCESS"))
			arg_35_0.exhibitController:SetSelectedState("true")
		else
			arg_35_0.exhibitController:SetSelectedState("false")
		end
	end)
	arg_35_0:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function()
		ShowTips(GetTips("DORM_LEVEL_UP_TIPS"))
		arg_35_0:RefreshRoomLevel()
	end)
	arg_35_0:RegistEventListener(ON_DORM_CHARACTER_GRAB_STARTED, function()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.UpCharacter)
	end)
	arg_35_0:RegistEventListener(ON_DORM_CHARACTER_GRAB_RELEASED, function()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.DownCharacter)
	end)
	arg_35_0:RegistEventListener(ON_BEGIN_STORY, function(arg_43_0)
		SetActive(arg_35_0.birthdayBtn_.gameObject, false)
		manager.windowBar:HideBar()
		DormCharacterManager.GetInstance():OnBeginStory(arg_43_0)
		DormFurnitureManager.GetInstance():OnBeginStory(arg_43_0)
	end)
	arg_35_0:RegistEventListener(ON_FINISH_STORY, function(arg_44_0)
		GameObject.Destroy(var_0_1)

		var_0_1 = nil

		SetActive(arg_35_0.gameObject_, true)
		arg_35_0:RefreshBar()
		DormFurnitureManager.GetInstance():OnFinishStory(arg_44_0)
		DormCharacterManager.GetInstance():OnFinishStory(arg_44_0)
	end)
	arg_35_0:RegistEventListener(DORM_LIKE_NUM_REFRESH, function()
		arg_35_0:RefreshLikeNum()
		arg_35_0:RefreshLikeBtnState()
	end)
	arg_35_0:RegistEventListener(SDK_UPLOAD_IMG, function(arg_46_0)
		arg_35_0:UploadImageSuccess(arg_46_0)
	end)
end

function var_0_0.RefreshRoomLevel(arg_47_0)
	local var_47_0 = DormitoryData:GetDormLevel(arg_47_0.sceneID_)

	if var_47_0 then
		arg_47_0.roomLevel.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), var_47_0)
	end
end

function var_0_0.UpdateView(arg_48_0)
	local var_48_0 = DormData:GetCurrectSceneID()

	arg_48_0.attractiveLabel_.text = DormData:GetSceneAttractiveValue(var_48_0)
end

function var_0_0.HideUiInfo(arg_49_0, arg_49_1)
	arg_49_0.uiShow = arg_49_1

	if arg_49_0.uiShow then
		arg_49_0.showUiController:SetSelectedState("on")
		arg_49_0:RefreshBar()
	else
		arg_49_0.showUiController:SetSelectedState("off")
		manager.windowBar:HideBar()
	end
end

function var_0_0.RefreshDevInfo(arg_50_0)
	local var_50_0 = DormData:GetDevModelFlag()

	if var_50_0 then
		SetActive(arg_50_0.devbtnBtn_.transform.gameObject, var_50_0)
	end

	SetActive(arg_50_0.devText, var_50_0)
end

function var_0_0.AutoOpenSuitHelpPage(arg_51_0)
	if not DormSuitData:GetSuitHelpFlag() then
		FrameTimer.New(function()
			if not manager.guide:IsPlaying() and arg_51_0.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
				local var_52_0 = GameSetting.dorm_info_describe.value

				JumpTools.OpenPageByJump("gameHelpPro", {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = var_52_0,
					startIndex = GameSetting.dorm_how_to_play_forced_eject.value[1]
				})
				DormSuitData:SetSuitHelpFlag(true)
			end
		end, 0.1, 1):Start()
	end
end

function var_0_0.UpdataDormitoryInternalRedPoint(arg_53_0)
	local var_53_0 = {}
	local var_53_1 = DormData:GetCurrectSceneID()
	local var_53_2 = BackHomeCfg[var_53_1].type

	if var_53_2 == DormConst.BACKHOME_TYPE.PublicDorm then
		var_53_0 = {
			RedPointConst.DORM_FULL_PUBLIC_SUIT,
			RedPointConst.DORM_PART_SUIT
		}
	elseif var_53_2 == DormConst.BACKHOME_TYPE.PrivateDorm then
		var_53_0 = {
			RedPointConst.DORM_FULL_PRIVATE_SUIT,
			RedPointConst.DORM_PART_SUIT
		}
	end

	manager.redPoint:addGroup(RedPointConst.DORM_SUIT, var_53_0, true)
	DormRedPointTools:UpdataSuitRedPoint()
end

function var_0_0.RefreshLikeNum(arg_54_0)
	if arg_54_0.stateController:GetSelectedState() == "room" then
		local var_54_0 = DormData:GetCurrectSceneID()
		local var_54_1 = DormitoryData:GetDormSceneData(var_54_0)

		if var_54_1 then
			arg_54_0.likeNum.text = NumberTools.RetractNumberForWindBar(var_54_1.likeNum)
		end

		if DormitoryData:GetLastLikeNum() < var_54_1.likeNum then
			arg_54_0.praiseAnimator:Play("btn_praise", 0, 0)
		end

		DormitoryData:SetLastLikeNum(var_54_1.likeNum)
	end
end

function var_0_0.RefreshLikeBtnState(arg_55_0)
	if arg_55_0.stateController:GetSelectedState() == "visit" then
		local var_55_0 = DormVisitTools:GetCurVisitRoomData()

		if var_55_0.todayLikeNum and var_55_0.todayLikeNum > 0 then
			arg_55_0.likeBtnStateController:SetSelectedState("true")
		else
			arg_55_0.likeBtnStateController:SetSelectedState("false")
		end

		arg_55_0.curLikeNum.text = NumberTools.RetractNumberForWindBar(var_55_0.likeNum)
	end
end

function var_0_0.PreSetupShow(arg_56_0)
	SetForceShowQuanquan(true)

	arg_56_0.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 4), math.floor(Screen.height / 4), 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_56_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_56_0) then
		var_56_0:CaptureSnapshot(arg_56_0.snapShot)
	end

	local var_56_1 = FrameTimer.New(function()
		local var_57_0 = manager.share:SaveRenderTextureByModule("room_edit", arg_56_0.snapShot)

		arg_56_0.snapShot:Release()

		arg_56_0.snapShot = nil

		SDKUploadImage("room_edit", var_57_0)
	end, 1, 1):Start()
end

function var_0_0.UploadImageSuccess(arg_58_0, arg_58_1)
	if arg_58_1.code == 1 then
		DormAction:SetFurTemplateExhibit(arg_58_0.sceneID_, arg_58_1.url)
	else
		ShowTips("IMAGE_UPLOAD_FAIL")
	end

	SetForceShowQuanquan(false)
end

function var_0_0.RefreshUITime(arg_59_0)
	arg_59_0.uiTimeId_ = nil

	if BackHomeCfg[arg_59_0.sceneID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
		arg_59_0.uiTimeId_ = "dormNumerous"
	elseif BackHomeCfg[arg_59_0.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		arg_59_0.uiTimeId_ = "dormSingle"
	end

	arg_59_0:EnterSendMgr()
end

function var_0_0.EnterSendMgr(arg_60_0)
	manager.uiTime:OnEnterRoute(arg_60_0.uiTimeId_)
end

function var_0_0.ExitSendMgr(arg_61_0)
	manager.uiTime:OnExitRoute(arg_61_0.uiTimeId_)
end

function var_0_0.Dispose(arg_62_0)
	arg_62_0.quickView:Dispose()
	var_0_0.super.Dispose(arg_62_0)
end

return var_0_0
