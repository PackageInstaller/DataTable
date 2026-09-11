local DormHomeView = class("DormHomeView", ReduxView)
local var_0_1

function DormHomeView:UIName()
	return "Widget/BackHouseUI/Dorm/DormitoryUI"
end

function DormHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function DormHomeView:OnCtor()
	return
end

function DormHomeView:Init()
	self:InitUI()
	self:AddUIListener()

	self.likeBtnStateController = self.controller:GetController("praise")
	self.praiseAnimator = self.praiseGo_:GetComponent("Animator")
end

function DormHomeView:OnEnter()
	self:RegisterEvents()
	self:UpdataViewType()
	self:RefreshRoomNameInfo()
	self:RefreshDevInfo()
	self.quickView:OnEnter()
	self.tempquickGo_.transform:SetAsLastSibling()
	self.quickView:ShowView(false)
	self:UpdataDormitoryInternalRedPoint()
	self:RefreshRedPonit()
	self:AutoOpenSuitHelpPage()
	DormLuaBridge.SetIsCanEditTag(false)
	self:RefreshLikeNum()
	self:RefreshLikeBtnState()
	self:RefreshUITime()
end

function DormHomeView:OnTop()
	self:HideUiInfo(true)
	SetActive(self.storeDiscount_, DormTools:AnyShopInDiscount())
end

function DormHomeView:UpdataViewType()
	self.sceneID_ = DormData:GetCurrectSceneID()

	if self.sceneID_ > DormConst.DORM_VISIT_ROOM_MIN then
		self.stateController:SetSelectedState("visit")

		local var_7_0 = DormVisitTools:GetCurVisitPlayerType()

		if var_7_0 == 1 then
			self.friendController:SetSelectedState("true")
		elseif var_7_0 == 2 then
			self.friendController:SetSelectedState("false")
		end

		SetActive(self.collectBtn_.gameObject, not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM))
	else
		self.stateController:SetSelectedState("room")

		if self.sceneID_ == DormVisitTools:GetCurTemplateExhibit() then
			self.exhibitController:SetSelectedState("true")
		else
			self.exhibitController:SetSelectedState("false")
		end
	end
end

function DormHomeView:RefreshRoomNameInfo()
	if BackHomeCfg[self.sceneID_].type == DormConst.BACKHOME_TYPE.PublicDorm or BackHomeCfg[self.sceneID_].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		self.roomName.text = GetTips("DORM_LOBBY_NAME")

		self.publicTextController:SetSelectedState("false")
	elseif BackHomeCfg[self.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm or BackHomeCfg[self.sceneID_].type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		local var_8_0 = DormitoryData:GetDormSceneData(self.sceneID_).archiveIDList[1]

		if BackHomeCfg[self.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			self.publicTextController:SetSelectedState("true")
		else
			self.publicTextController:SetSelectedState("false")
		end

		if var_8_0 then
			if HeroRecordCfg.get_id_list_by_hero_id[var_8_0][1] then
				if HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[var_8_0][1]].name then
					self.roomName.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), GetI18NText(HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[var_8_0][1]].name))
				end

				self:RefreshRoomLevel()
			end
		end
	end
end

function DormHomeView:RefreshRedPonit()
	manager.redPoint:bindUIandKey(self.positionBtn_.transform, RedPointConst.DORM_PLACEMENT)
	manager.redPoint:bindUIandKey(self.fureidbtnBtn_.transform, RedPointConst.DORM_FURNITURE)
	manager.redPoint:bindUIandKey(self.btn_storeBtn_.transform, RedPointConst.DORM_SUIT_SHOP)
	manager.redPoint:bindUIandKey(self.navigationBtn_.transform, RedPointConst.DORM_NAVI)

	for iter_9_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		DormRedPointTools:UpdataDormFurRedPoint(self.sceneID_, iter_9_0)
	end

	if DormTools:ShouldShowBirthdayBtn(self.sceneID_) then
		SetActive(self.birthdayBtn_.gameObject, true)
	else
		SetActive(self.birthdayBtn_.gameObject, false)
	end
end

function DormHomeView:RefreshBar()
	if self.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})

		if #GameSetting.dorm_info_describe.value > 0 then
			manager.windowBar:SetGameHelpKey({
				view = "/gameHelpPro",
				type = "jump",
				params = {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = GameSetting.dorm_info_describe.value
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

		if self.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
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

function DormHomeView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.positionBtn_.transform, RedPointConst.DORM_PLACEMENT)
	manager.redPoint:unbindUIandKey(self.fureidbtnBtn_.transform, RedPointConst.DORM_FURNITURE)
	manager.redPoint:unbindUIandKey(self.btn_storeBtn_.transform, RedPointConst.DORM_SUIT_SHOP)
	manager.redPoint:unbindUIandKey(self.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	self.menuController:SetSelectedState("off")

	self.menuState = false

	self:RemoveAllEventListener()
	self.quickView:OnExit()
	self:ExitSendMgr()
end

function DormHomeView:InitUI()
	self:BindCfgUI()

	self.cacheRoles = {}
	self.menuState = false
	self.menuController = ControllerUtil.GetController(self.btn_menuGo_.transform, "menu")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.exhibitController = ControllerUtil.GetController(self.exhib.transform, "state")
	self.publicTextController = ControllerUtil.GetController(self.transform_, "public")
	self.showUiController = ControllerUtil.GetController(self.btn_hideGo_.transform, "btn")
	self.friendController = ControllerUtil.GetController(self.transform_, "addFriend")
	self.menuAnimator = self:FindCom(typeof(Animator), "", self.menu_listTrs_)
	self.quickView = BackHomeQuickJumpView.New(self.tempquickGo_)
end

function DormHomeView:AddUIListener()
	self:AddBtnListenerScale(self.navigationBtn_, nil, function()
		if self.sceneID_ > DormConst.DORM_VISIT_ROOM_MIN then
			return
		end

		JumpTools.OpenPageByJump("dormNavigation", {
			isMain = false
		})
	end)
	self:AddBtnListenerScale(self.positionBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	self:AddBtnListenerScale(self.characterplacebtnBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormHeroDeployView")
	end)
	self:AddBtnListenerScale(self.templateBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormTemplateView", {
			pos = 1
		})
	end)
	self:AddBtnListenerScale(self.fureidbtnBtn_, nil, function()
		DormHeroTools.HideAllCharacter()
		JumpTools.OpenPageByJump("/roomEdit")
		DormFurEditStateData:EnterEditState()
	end)
	self:AddBtnListenerScale(self.dormlevelBtn_, nil, function()
		if BackHomeCfg[self.sceneID_].type ~= DormConst.BACKHOME_TYPE.PrivateDorm then
			return
		end

		local var_21_0 = DormitoryData:GetArchiveIDViaRoomID(self.sceneID_)[1]

		if var_21_0 then
			JumpTools.OpenPageByJump("/dormLevelInfoView", {
				archiveID = var_21_0
			})
		end
	end)
	self:AddBtnListenerScale(self.btn_storeBtn_, nil, function()
		JumpTools.GoToSystem("/dormShop", {
			hideHomeBtn = true,
			shop = ShopConst.SHOP_ID.DORM_SHOP,
			shopList = DormTools:GetAllDormShopIDList()
		}, ViewConst.SYSTEM_ID.DORM_SHOP)
	end)
	self:AddBtnListenerScale(self.btn_menuBtn_, nil, function()
		if self.menuState then
			self.menuController:SetSelectedState("off")

			self.menuState = false
		else
			self.menuController:SetSelectedState("on")

			self.menuState = true

			self.menuAnimator:Play("DormitoryUI_menu_list")
		end
	end)
	self:AddBtnListenerScale(self.exhibBtn_, nil, function()
		local var_24_0 = DormVisitTools:GetCurTemplateExhibit()

		if not var_24_0 or self.sceneID_ ~= var_24_0 then
			if SDKTools.IsSDK() then
				self:PreSetupShow()
			else
				DormAction:SetFurTemplateExhibit(self.sceneID_)
			end
		else
			ShowTips(GetTips("DORM_DISPLAY_ALREADY"))
		end
	end)
	self:AddBtnListenerScale(self.collectBtn_, nil, function()
		local var_25_0, var_25_1 = DormVisitTools:CheckCanSaveTemplate()

		if var_25_0 then
			JumpTools.OpenPageByJump("/dormVisitTemplateView")
		else
			ShowTips(var_25_1)
		end
	end)
	self:AddBtnListenerScale(self.addFriendBtn_, nil, function()
		local var_26_0 = DormVisitTools:GetVisitUserID()

		if var_26_0 then
			FriendsAction:TryToRequestToFriend(var_26_0, FriendConst.ADD_FRIEND_SOURCE.DORM)
		end
	end)
	self:AddBtnListenerScale(self.btn_hideBtn_, nil, function()
		if self.uiShow then
			self:HideUiInfo(false)
		else
			self:HideUiInfo(true)
		end
	end)
	self:AddBtnListenerScale(self.giftBtn_, nil, function()
		local var_28_0 = DormData:GetCurrectSceneID()

		if BackHomeCfg[var_28_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			local var_28_1 = DormitoryData:GetArchiveIDViaRoomID(var_28_0)[1]
			local var_28_2 = DormData:GetHeroInfo(var_28_1)

			if var_28_2 then
				if var_28_2:GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
					local var_28_3

					for iter_28_0, iter_28_1 in Dorm.storage:ForeachData(DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero), pairs) do
						var_28_3 = iter_28_1
					end

					if var_28_3 then
						DormLuaBridge.ActAsClickToEntity(var_28_3)
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
	self.quickView:AddClickCallBack(function()
		manager.windowBar:HideBar()
	end)
	self.quickView:CloseCallBack(function()
		self:RefreshBar()
	end)
	self:AddBtnListenerScale(self.reportBtn_, nil, function()
		local var_31_0 = DormVisitTools:GetVisitUserID()

		if var_31_0 then
			local var_31_1 = DormVisitTools:GetExhibitListByUserID(var_31_0)

			if var_31_1 then
				local var_31_2 = var_31_1.nick or ""
				local var_31_3 = {
					reportType = ChatConst.CHAT_REPORT_TYPE.DORM
				}
				local var_31_4 = {
					nick = var_31_2,
					userID = var_31_0,
					layout_uid = DormVisitTools:GetLayoutID()
				}

				var_31_4.architecture_id = var_31_1.architecture_id or var_31_1.backhome_architecture_id
				var_31_3.reportData = var_31_4

				JumpTools.OpenPageByJump("/chatReport", var_31_3, ViewConst.SYSTEM_ID.CHAT_REPORT)
			end
		end
	end)
	self:AddBtnListenerScale(self.devbtnBtn_, nil, function()
		DormData:ChangeDevModelFlag(not DormData:GetDevModelFlag())
		self:RefreshDevInfo()
	end)
	self:AddBtnListenerScale(self.likeBtn, nil, function()
		if self.stateController:GetSelectedState() == "visit" then
			local var_33_0 = DormVisitTools:GetCurVisitRoomData()

			if var_33_0.todayLikeNum < GameSetting.dorm_room_like_limted.value[1] and var_33_0 then
				DormAction.LikeDormRoom(DormVisitTools:GetVisitUserID(), var_33_0.architecture_id, function()
					DormAction:AskFurTemplateExhibitList(3)
				end)
			else
				ShowTips("DORM_SINGLE_ROOM_PRAISE_NUM")
			end
		end
	end)
end

function DormHomeView:RegisterEvents()
	self:RegistEventListener(ON_PLAYER_CLICK_INTERACT, function(arg_36_0, arg_36_1)
		if not DormHeroTools:CheckIsVisitHero(arg_36_0) then
			self.showUiController:SetSelectedState("off")
			SetActive(self.btn_hideBtn_.gameObject, false)
			manager.windowBar:HideBar()

			if self.sceneID_ > DormConst.DORM_VISIT_ROOM_MIN then
				return
			end

			Dorm.DormEntityManager.EnablePlayerInput = false

			DormUtils.ClearCharaHasSpecialVfx(arg_36_0)
			DormUtils.HideCharaSpecialVfx(arg_36_0)
			Timer.New(function()
				self.showUiController:SetSelectedState("on")
				SetActive(self.btn_hideBtn_.gameObject, true)
				JumpTools.OpenPageByJump("/heroInteractView", {
					heroEID = arg_36_0
				})
			end, DormConst.CHARACTER_INTERACT_CAMERA_MOVE_TIME, 1):Start()
			DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.InteractCam)

			for iter_36_0, iter_36_1 in Dorm.storage:ForeachData(DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero), pairs) do
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
	self:RegistEventListener(DORM_REFRESH_EXIBIT, function()
		if self.sceneID_ == DormVisitTools:GetCurTemplateExhibit() then
			ShowTips(GetTips("DORM_DISPLAY_SET_SUCCESS"))
			self.exhibitController:SetSelectedState("true")
		else
			self.exhibitController:SetSelectedState("false")
		end
	end)
	self:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function()
		ShowTips(GetTips("DORM_LEVEL_UP_TIPS"))
		self:RefreshRoomLevel()
	end)
	self:RegistEventListener(ON_DORM_CHARACTER_GRAB_STARTED, function()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.UpCharacter)
	end)
	self:RegistEventListener(ON_DORM_CHARACTER_GRAB_RELEASED, function()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.DownCharacter)
	end)
	self:RegistEventListener(ON_BEGIN_STORY, function(arg_43_0)
		SetActive(self.birthdayBtn_.gameObject, false)
		manager.windowBar:HideBar()
		DormCharacterManager.GetInstance():OnBeginStory(arg_43_0)
		DormFurnitureManager.GetInstance():OnBeginStory(arg_43_0)
	end)
	self:RegistEventListener(ON_FINISH_STORY, function(arg_44_0)
		GameObject.Destroy(var_0_1)

		var_0_1 = nil

		SetActive(self.gameObject_, true)
		self:RefreshBar()
		DormFurnitureManager.GetInstance():OnFinishStory(arg_44_0)
		DormCharacterManager.GetInstance():OnFinishStory(arg_44_0)
	end)
	self:RegistEventListener(DORM_LIKE_NUM_REFRESH, function()
		self:RefreshLikeNum()
		self:RefreshLikeBtnState()
	end)
	self:RegistEventListener(SDK_UPLOAD_IMG, function(arg_46_0)
		self:UploadImageSuccess(arg_46_0)
	end)
end

function DormHomeView:RefreshRoomLevel()
	local var_47_0 = DormitoryData:GetDormLevel(self.sceneID_)

	if var_47_0 then
		self.roomLevel.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), var_47_0)
	end
end

function DormHomeView:UpdateView()
	self.attractiveLabel_.text = DormData:GetSceneAttractiveValue((DormData:GetCurrectSceneID()))
end

function DormHomeView:HideUiInfo(arg_49_1)
	self.uiShow = arg_49_1

	if self.uiShow then
		self.showUiController:SetSelectedState("on")
		self:RefreshBar()
	else
		self.showUiController:SetSelectedState("off")
		manager.windowBar:HideBar()
	end
end

function DormHomeView:RefreshDevInfo()
	local var_50_0 = DormData:GetDevModelFlag()

	if var_50_0 then
		SetActive(self.devbtnBtn_.transform.gameObject, var_50_0)
	end

	SetActive(self.devText, var_50_0)
end

function DormHomeView:AutoOpenSuitHelpPage()
	if not DormSuitData:GetSuitHelpFlag() then
		FrameTimer.New(function()
			if not manager.guide:IsPlaying() and self.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
				JumpTools.OpenPageByJump("gameHelpPro", {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = GameSetting.dorm_info_describe.value,
					startIndex = GameSetting.dorm_how_to_play_forced_eject.value[1]
				})
				DormSuitData:SetSuitHelpFlag(true)
			end
		end, 0.1, 1):Start()
	end
end

function DormHomeView:UpdataDormitoryInternalRedPoint()
	local var_53_0 = {}
	local var_53_1 = BackHomeCfg[DormData:GetCurrectSceneID()].type

	if var_53_1 == DormConst.BACKHOME_TYPE.PublicDorm then
		var_53_0 = {
			RedPointConst.DORM_FULL_PUBLIC_SUIT,
			RedPointConst.DORM_PART_SUIT
		}
	elseif var_53_1 == DormConst.BACKHOME_TYPE.PrivateDorm then
		var_53_0 = {
			RedPointConst.DORM_FULL_PRIVATE_SUIT,
			RedPointConst.DORM_PART_SUIT
		}
	end

	manager.redPoint:addGroup(RedPointConst.DORM_SUIT, var_53_0, true)
	DormRedPointTools:UpdataSuitRedPoint()
end

function DormHomeView:RefreshLikeNum()
	if self.stateController:GetSelectedState() == "room" then
		local var_54_0 = DormitoryData:GetDormSceneData((DormData:GetCurrectSceneID()))

		if var_54_0 then
			self.likeNum.text = NumberTools.RetractNumberForWindBar(var_54_0.likeNum)
		end

		if DormitoryData:GetLastLikeNum() < var_54_0.likeNum then
			self.praiseAnimator:Play("btn_praise", 0, 0)
		end

		DormitoryData:SetLastLikeNum(var_54_0.likeNum)
	end
end

function DormHomeView:RefreshLikeBtnState()
	if self.stateController:GetSelectedState() == "visit" then
		local var_55_0 = DormVisitTools:GetCurVisitRoomData()

		if var_55_0.todayLikeNum and var_55_0.todayLikeNum > 0 then
			self.likeBtnStateController:SetSelectedState("true")
		else
			self.likeBtnStateController:SetSelectedState("false")
		end

		self.curLikeNum.text = NumberTools.RetractNumberForWindBar(var_55_0.likeNum)
	end
end

function DormHomeView:PreSetupShow()
	SetForceShowQuanquan(true)

	self.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 4), math.floor(Screen.height / 4), 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_56_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_56_0) then
		var_56_0:CaptureSnapshot(self.snapShot)
	end

	local var_56_1 = FrameTimer.New(function()
		self.snapShot:Release()

		self.snapShot = nil

		SDKUploadImage("room_edit", (manager.share:SaveRenderTextureByModule("room_edit", self.snapShot)))
	end, 1, 1):Start()
end

function DormHomeView:UploadImageSuccess(arg_58_1)
	if arg_58_1.code == 1 then
		DormAction:SetFurTemplateExhibit(self.sceneID_, arg_58_1.url)
	else
		ShowTips("IMAGE_UPLOAD_FAIL")
	end

	SetForceShowQuanquan(false)
end

function DormHomeView:RefreshUITime()
	self.uiTimeId_ = nil

	if BackHomeCfg[self.sceneID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
		self.uiTimeId_ = "dormNumerous"
	elseif BackHomeCfg[self.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		self.uiTimeId_ = "dormSingle"
	end

	self:EnterSendMgr()
end

function DormHomeView:EnterSendMgr()
	manager.uiTime:OnEnterRoute(self.uiTimeId_)
end

function DormHomeView:ExitSendMgr()
	manager.uiTime:OnExitRoute(self.uiTimeId_)
end

function DormHomeView:Dispose()
	self.quickView:Dispose()
	DormHomeView.super.Dispose(self)
end

return DormHomeView
