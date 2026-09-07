local SelectDorm3DScene = class("SelectDorm3DScene", import("view.base.BaseUI"))

function SelectDorm3DScene:getUIName()
	return "SelectDorm3DUI"
end

function SelectDorm3DScene:init()
	self.rtMap = self._tf:Find("Map")
	self.rtIconTip = self.rtMap:Find("tip")

	setActive(self.rtIconTip, false)
	onButton(self, self.rtIconTip:Find("bg"), function()
		self:HideIconTipWindow()

		return
	end, SFX_CANCEL)
	setText(self.rtIconTip:Find("window/btn_cancel/Text"), i18n("text_cancel"))
	onButton(self, self.rtIconTip:Find("window/btn_cancel"), function()
		self:HideIconTipWindow()

		return
	end, SFX_CANCEL)
	setText(self.rtIconTip:Find("window/btn_confirm/Text"), i18n("text_confirm"))

	self.rtMain = self._tf:Find("Main")

	setText(self.rtMain:Find("title/Text"), i18n("dorm3d_role_choose"))
	onButton(self, self.rtMain:Find("btn_back"), function()
		self.clearSceneCache = true

		self:closeView()

		return
	end, SFX_CANCEL)

	self.insBtn = Dorm3dInsBtn.New(self.rtMain:Find("btn_ins"))

	onButton(self, self.insBtn.root, function()
		self:emit(SelectDorm3DMediator.OPEN_INS_LAYER, self.insBtn.IsNewPhoneCall())

		return
	end)
	setActive(self.rtMain:Find("btn_ins"), not DORM_LOCK_INS)

	if not pg.TimeMgr.GetInstance():IsSameWeek(pg.TimeMgr.GetInstance():GetServerTime(), PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftWeekRefreshTimeStamp", 0)) then
		ApartmentProxy.RefreshGiftDailyTip()
	end

	setActive(self.rtMain:Find("btn_shop/tip"), Dorm3dShopUI.ShouldShowAllTip())
	onButton(self, self.rtMain:Find("btn_shop"), function()
		self:emit(SelectDorm3DMediator.OPEN_SHOP_LAYER, function()
			setActive(self.rtMain:Find("btn_shop/tip"), Dorm3dShopUI.ShouldShowAllTip())

			return
		end)

		return
	end)
	onButton(self, self.rtMain:Find("option/setting"), function()
		self:emit(SelectDorm3DMediator.OPEN_SETTING_LAYER)

		return
	end)
	onButton(self, self.rtMain:Find("option/home"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end)

	self.rtStamina = self.rtMain:Find("stamina")
	self.rtRes = self.rtMain:Find("res")

	self:InitResBar()

	self.rtWeekTask = self.rtMain:Find("task")

	self:UpdateWeekTask()

	self.rtLayer = self._tf:Find("Layer")
	self.floorData = _.keys(pg.dorm3d_rooms.get_id_list_by_in_map)

	table.sort(self.floorData, function(arg_11_0, arg_11_1)
		return (tonumber(string.match(arg_11_0, "%d+")) or 0) < (tonumber(string.match(arg_11_1, "%d+")) or 0)
	end)
	self:SetMapSwitch()

	return
end

function SelectDorm3DScene:didEnter()
	self:SetFloor(self.floorData[self.selectedFloorId])
	self:UpdateStamina()
	self:CheckGuide("DORM3D_GUIDE_02")
	self:FlushInsBtn()

	if not ApartmentProxy.CheckDeviceRAMEnough() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("drom3d_memory_limit_tip"))
	end

	return
end

function SelectDorm3DScene:FlushInsBtn()
	self.insBtn:Flush()

	return
end

function SelectDorm3DScene:UpdateStamina()
	setText(self.rtStamina:Find("Text"), string.format("%d/%d", getProxy(ApartmentProxy):getStamina()))
	setActive(self.rtStamina:Find("vfx_ui_stamina01"), getProxy(ApartmentProxy):getStamina() > 0)

	return
end

function SelectDorm3DScene:SetFloor(arg_15_1)
	local var_15_0

	eachChild(self.rtMap, function(arg_16_0)
		setActive(arg_16_0, arg_16_0.name == arg_15_1)

		if arg_16_0.name == arg_15_1 then
			var_15_0 = arg_16_0
		end

		return
	end)
	assert(nil)

	self.roomDic = {}

	for iter_15_0, iter_15_1 in ipairs(pg.dorm3d_rooms.get_id_list_by_in_map[arg_15_1]) do
		self.roomDic[iter_15_1] = (nil):Find(pg.dorm3d_rooms[iter_15_1].assets_prefix)

		self:InitIconTrigger(iter_15_1)
		self:UpdateIconState(iter_15_1)
	end

	self:ReplaceSpecialRoomIcon()

	return
end

function SelectDorm3DScene:FlushFloor()
	self:SetFloor(self.floorData[self.selectedFloorId])

	return
end

function SelectDorm3DScene:InitIconTrigger(arg_18_1)
	local var_18_0 = self.roomDic[arg_18_1]

	GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_icon_%s", string.lower(pg.dorm3d_rooms[arg_18_1].assets_prefix)), "", self.roomDic[arg_18_1]:Find("icon"))
	onButton(self, self.roomDic[arg_18_1], function()
		if BLOCK_DORM3D_ROOMS and table.contains(BLOCK_DORM3D_ROOMS, arg_18_1) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_system_switch"))

			return
		end

		if arg_18_1 ~= 1 then
			if getProxy(ApartmentProxy):getRoom(1) then
				if not pg.NewStoryMgr.GetInstance():IsPlayed("DORM3D_GUIDE_02") then
					if not DORM_LOCK_GUIDE then
						pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_tip"))

						return
					end
				end
			end
		end

		local var_19_0 = getProxy(ApartmentProxy):getRoom(arg_18_1)

		if pg.dorm3d_rooms[arg_18_1].type == 1 then
			if arg_18_1 ~= 4 then
				if not pg.NewStoryMgr.GetInstance():IsPlayed("DORM3D_GUIDE_06") and not DORM_LOCK_GUIDE then
					pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_tip2"))

					return
				end
			end

			if not var_19_0 then
				self:emit(SelectDorm3DMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_18_1)
			else
				self:TryDownloadResource({
					click = true,
					roomId = arg_18_1
				}, function()
					local var_20_0 = ApartmentProxy.GetRoomInviteList(arg_18_1)

					self:emit(SelectDorm3DMediator.OPEN_INVITE_LAYER, arg_18_1, (self:CheckGuide("DORM3D_GUIDE_06") or nil) and {}, function()
						self:FlushFloor()

						return
					end)

					return
				end)
			end
		elseif pg.dorm3d_rooms[arg_18_1].type == 2 then
			if not var_19_0 then
				self:ShowIconTipWindow(arg_18_1, var_18_0)
			else
				self:TryDownloadResource({
					click = true,
					roomId = arg_18_1
				}, function()
					self:emit(SelectDorm3DMediator.ON_DORM, {
						roomId = var_19_0.id,
						groupIds = var_19_0:getInviteList()
					})

					return
				end)
			end
		else
			assert(false)
		end

		return
	end, SFX_PANEL)

	return
end

function SelectDorm3DScene:UpdateIconState(arg_23_1)
	local var_23_0 = self.roomDic[arg_23_1]
	local var_23_1 = getProxy(ApartmentProxy):getRoom(arg_23_1)
	local var_23_2 = var_23_1 and var_23_1:getState() or "lock"

	setActive(self.roomDic[arg_23_1]:Find("icon/mask"), var_23_2 ~= "complete")
	eachChild(var_23_0:Find("front"), function(arg_24_0)
		setActive(arg_24_0, arg_24_0.name == var_23_2)

		return
	end)
	switch(var_23_2, {
		loading = function()
			setSlider(var_23_0:Find("front/loading/progress"), 0, DormGroupConst.DormDownloadLock.totalSize, DormGroupConst.DormDownloadLock.curSize)

			return
		end,
		complete = function()
			local var_26_0 = var_23_0:Find("front/complete")
			local var_26_1 = var_23_1:isPersonalRoom()

			setActive(var_26_0, var_26_1)

			if var_26_1 then
				local var_26_2 = getProxy(ApartmentProxy):getApartment(var_23_1:getPersonalGroupId())
				local var_26_3 = var_26_2:getIconTip(var_23_1:GetConfigID())

				eachChild(var_26_0:Find("tip"), function(arg_27_0)
					setActive(arg_27_0, arg_27_0.name == var_26_3)

					return
				end)
				setText(var_26_0:Find("favor/Text"), var_26_2.level)
			end

			return
		end
	})

	if arg_23_1 == 4 then
		setActive(var_23_0:Find("inivite_tip"), PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dRoomInviteSuccess_" .. arg_23_1, 1) == 0)
	end

	setActive(var_23_0:Find("tip"), (function()
		if not var_23_1 or not var_23_1:isPersonalRoom() then
			return false
		end

		return getProxy(ApartmentProxy):HasShipGroupGiftExpireSoon(var_23_1:getConfig("character")[1])
	end)())

	return
end

function SelectDorm3DScene:UpdateShowIcon(arg_29_1, arg_29_2)
	removeOnButton(arg_29_2)
	setActive(arg_29_2:Find("icon/mask"), false)
	eachChild(arg_29_2:Find("front"), function(arg_30_0)
		setActive(arg_30_0, false)

		return
	end)

	return
end

function SelectDorm3DScene:ReplaceSpecialRoomIcon()
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(getProxy(ApartmentProxy):getRawData()) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1:getSpecialTalking()) do
			if self.roomDic[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]] then
				var_31_0[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]] = var_31_0[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]] or {}

				table.insert(var_31_0[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]], iter_31_3)
			end
		end
	end

	for iter_31_4, iter_31_5 in pairs(var_31_0) do
		setActive(self.roomDic[iter_31_4], false)

		local var_31_1 = cloneTplTo(self.roomDic[iter_31_4], self.roomDic[iter_31_4].parent, self.roomDic[iter_31_4].name .. "_special")

		self:UpdateShowIcon(iter_31_4, var_31_1)
		GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_icon_%s", string.lower(pg.dorm3d_rooms[iter_31_4].assets_prefix)), "", var_31_1:Find("icon"))
		setActive(var_31_1:Find("front/complete"), true)
		setActive(var_31_1:Find("front/complete/favor"), false)
		eachChild(var_31_1:Find("front/complete/tip"), function(arg_32_0)
			setActive(arg_32_0, arg_32_0.name == "main")

			return
		end)
		table.sort(iter_31_5)

		local var_31_2 = iter_31_5[1]
		local var_31_3 = pg.dorm3d_dialogue_group[iter_31_5[1]]

		if DORM_LOCK_GUIDE and iter_31_5[1] == 26 then
			return
		end

		onButton(self, var_31_1, function()
			self:TryDownloadResource({
				click = true,
				roomId = var_31_3.room_id
			}, function()
				self:emit(SelectDorm3DMediator.ON_DORM, {
					roomId = var_31_3.room_id,
					groupIds = {
						var_31_3.char_id
					},
					specialId = var_31_2
				})

				return
			end)

			return
		end, SFX_PANEL)
	end

	return
end

function SelectDorm3DScene:DownloadUpdate(arg_35_1, arg_35_2)
	switch(arg_35_2, {
		start = function()
			if self.roomDic[arg_35_1] then
				self:UpdateIconState(arg_35_1)
			end

			return
		end,
		loading = function()
			if self.roomDic[arg_35_1] then
				setSlider(self.roomDic[arg_35_1]:Find("front/loading/progress"), 0, DormGroupConst.DormDownloadLock.totalSize, DormGroupConst.DormDownloadLock.curSize)
			end

			return
		end,
		finish = function()
			for iter_38_0, iter_38_1 in pairs(self.roomDic) do
				self:UpdateIconState(iter_38_0)
			end

			self:CheckGuide("DORM3D_GUIDE_02")

			return
		end,
		delete = function()
			if self.roomDic[arg_35_1] then
				self:UpdateIconState(arg_35_1)
			end

			return
		end
	})

	return
end

function SelectDorm3DScene:AfterRoomUnlock(arg_40_1)
	local var_40_0 = arg_40_1.roomId

	if isActive(self.rtIconTip) then
		self:HideIconTipWindow()
	end

	eachChild(self.roomDic[arg_40_1.roomId]:Find("icon/mask"), function(arg_41_0)
		setActive(arg_41_0, true)

		return
	end)
	quickPlayAnimation(self.roomDic[arg_40_1.roomId], "anim_Dorm3d_selectDorm_icon_unlock")
	pg.UIMgr.GetInstance():LoadingOn(false)
	LeanTween.delayedCall(1.2333333333333334, System.Action(function()
		pg.UIMgr.GetInstance():LoadingOff(false)
		self:UpdateIconState(var_40_0)
		self:TryDownloadResource(arg_40_1)
		self:CheckGuide("DORM3D_GUIDE_02")
		self:SetMapSwitch()

		return
	end))

	return
end

function SelectDorm3DScene:ShowIconTipWindow(arg_43_1, arg_43_2)
	setLocalPosition(self.rtIconTip:Find("window"), self.rtIconTip:InverseTransformPoint(arg_43_2.position))
	removeAllChildren(self.rtIconTip:Find("window/icon"))

	arg_43_2 = cloneTplTo(arg_43_2, self.rtIconTip:Find("window/icon"))

	self:UpdateShowIcon(arg_43_1, arg_43_2)
	setAnchoredPosition(arg_43_2, Vector2.zero)

	local var_43_0 = ApartmentRoom.New({
		id = arg_43_1
	})
	local var_43_1, var_43_2 = var_43_0:getDownloadNeedSize()

	setText(self.rtIconTip:Find("window/Text"), i18n("dorm3d_role_assets_download", ShipGroup.getDefaultShipNameByGroupID(var_43_0:getPersonalGroupId()), var_43_0:needDownload() and var_43_2 or "0B"))
	onButton(self, self.rtIconTip:Find("window/btn_confirm"), function()
		self:emit(SelectDorm3DMediator.ON_UNLOCK_DORM_ROOM, arg_43_1)

		return
	end, SFX_CONFIRM)
	setActive(self.rtIconTip, true)

	return
end

function SelectDorm3DScene:HideIconTipWindow()
	setActive(self.rtIconTip, false)

	return
end

function SelectDorm3DScene:TryDownloadResource(arg_46_1, arg_46_2)
	if DormGroupConst.IsDownloading() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_now_is_downloading"))

		return
	end

	local var_46_0 = getProxy(ApartmentProxy):getRoom(arg_46_1.roomId)
	local var_46_1 = var_46_0:getDownloadNameList()

	if #var_46_1 > 0 then
		DormGroupConst.DormDownload({
			isShowBox = true,
			fileList = var_46_1,
			finishFunc = function(arg_47_0)
				if arg_47_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_resource_download_complete"))
				end

				return
			end,
			roomId = var_46_0.configId
		})
	else
		existCall(arg_46_2)
	end

	return
end

function SelectDorm3DScene:InitResBar()
	self.goldMax = self.rtRes:Find("gold/max"):GetComponent(typeof(Text))
	self.goldValue = self.rtRes:Find("gold/Text"):GetComponent(typeof(Text))
	self.oilMax = self.rtRes:Find("oil/max"):GetComponent(typeof(Text))
	self.oilValue = self.rtRes:Find("oil/Text"):GetComponent(typeof(Text))
	self.gemValue = self.rtRes:Find("gem/Text"):GetComponent(typeof(Text))

	onButton(self, self.rtRes:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(self, self.rtRes:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(self, self.rtRes:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	self:UpdateRes()

	return
end

function SelectDorm3DScene:UpdateRes()
	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), self.goldMax, self.goldValue, self.oilMax, self.oilValue, self.gemValue)

	return
end

function SelectDorm3DScene:UpdateWeekTask()
	local var_53_0 = getDorm3dGameset("drom3d_weekly_task")[1]
	local var_53_1 = getProxy(TaskProxy):getTaskVO(var_53_0)
	local var_53_2 = var_53_1:isReceive()
	local var_53_3 = var_53_2 and 3 or var_53_1:getProgress()
	local var_53_4 = self.rtWeekTask:Find("content")

	for iter_53_0 = 1, 3 do
		triggerToggle(var_53_4:Find("tpl_" .. iter_53_0), iter_53_0 <= var_53_3)
	end

	local var_53_5 = Drop.Create(var_53_1:getConfig("award_display")[1])

	updateCustomDrop(var_53_4:Find("Dorm3dIconTpl"), var_53_5)
	onButton(self, var_53_4:Find("Dorm3dIconTpl"), function()
		if not var_53_2 and var_53_1:isFinish() then
			self:emit(SelectDorm3DMediator.ON_SUBMIT_TASK, var_53_0)
		else
			self:emit(BaseUI.ON_NEW_DROP, {
				drop = var_53_5
			})
		end

		return
	end, SFX_CONFIRM)
	setActive(var_53_4:Find("Dorm3dIconTpl/get"), not var_53_2 and var_53_1:isFinish())
	setGray(var_53_4:Find("Dorm3dIconTpl"), var_53_2)
	onButton(self, self._tf:Find("Main/task_done"), function()
		setActive(self.rtWeekTask, true)
		setActive(self._tf:Find("Main/task_done"), false)

		return
	end)
	onButton(self, self.rtWeekTask:Find("title"), function()
		if var_53_2 then
			setActive(self.rtWeekTask, false)
			setActive(self._tf:Find("Main/task_done"), true)
		end

		return
	end)

	return
end

function SelectDorm3DScene:CheckGuide(arg_57_1)
	if pg.NewStoryMgr.GetInstance():IsPlayed(arg_57_1) then
		return
	end

	if DORM_LOCK_GUIDE then
		return false
	end

	return switch(arg_57_1, {
		DORM3D_GUIDE_02 = function()
			local var_58_0 = getProxy(ApartmentProxy):getApartment(20220)

			if var_58_0 and not var_58_0:needDownload() then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = arg_57_1
				})
				pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(1, pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_57_1)))
				pg.NewGuideMgr.GetInstance():Play(arg_57_1, nil, function()
					pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(2, pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_57_1)))

					return
				end)

				return true
			end

			return
		end,
		DORM3D_GUIDE_06 = function()
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = arg_57_1
			})
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(1, pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_57_1)))
			pg.NewGuideMgr.GetInstance():Play(arg_57_1, nil, function()
				pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(2, pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_57_1)))

				return
			end)

			return true
		end
	}, function()
		return false
	end)
end

function SelectDorm3DScene:SetMapSwitch()
	local var_63_0 = getProxy(PlayerProxy):getRawData().id

	self.selectedFloorId = PlayerPrefs.GetInt("DORM_SELECTED_FLOOR_ID" .. var_63_0, 1)

	if pg.NewGuideMgr.GetInstance():GetCurrentGuideName() == "DORM3D_GUIDE_01" then
		self.selectedFloorId = 1
	elseif not DORM_LOCK_SELECT_NEW then
		if PlayerPrefs.GetInt("DORM_SELECTED_NEW_ROOM_FLOOR" .. var_63_0 .. pg.dorm3d_set.drom3d_new_room_remind.key_value_int, 0) == 0 then
			self.selectedFloorId = table.indexof(self.floorData, pg.dorm3d_rooms[pg.dorm3d_set.drom3d_new_room_remind.key_value_int].in_map)

			PlayerPrefs.SetInt("DORM_SELECTED_NEW_ROOM_FLOOR" .. var_63_0 .. pg.dorm3d_set.drom3d_new_room_remind.key_value_int, 1)
		end
	end

	local var_63_1 = self._tf:Find("interludeAni")
	local var_63_2 = var_63_1:GetComponent(typeof(Animation))
	local var_63_3 = var_63_1:GetComponent(typeof(DftAniEvent))

	onButton(self, self.rtMain:Find("btn_switch/left"), function()
		var_63_3:SetTriggerEvent(function()
			self:ChangeMap(self.selectedFloorId - 1)

			return
		end)
		var_63_2:Play("anim_InterludeAni")

		return
	end)
	onButton(self, self.rtMain:Find("btn_switch/right"), function()
		var_63_3:SetTriggerEvent(function()
			self:ChangeMap(self.selectedFloorId + 1)

			return
		end)
		var_63_2:Play("anim_InterludeAni")

		return
	end)
	setActive(self.rtMain:Find("btn_switch/switchPanel"), false)

	local var_63_4 = self.rtMain:Find("btn_switch/switchPanel"):GetComponent(typeof(Animation))

	self.rtMain:Find("btn_switch/switchPanel"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(self.rtMain:Find("btn_switch/switchPanel"), false)

		return
	end)
	onButton(self, self.rtMain:Find("btn_switch/switch"), function()
		setActive(self.rtMain:Find("btn_switch/switchPanel"), true)

		return
	end)
	onButton(self, self.rtMain:Find("btn_switch/switchPanel"), function()
		var_63_4:Play("anim_switchPanel_exit")

		return
	end)

	local var_63_5 = UIItemList.New(self.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content"), self.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content/floor"))

	var_63_5:make(function(arg_71_0, arg_71_1, arg_71_2)
		if arg_71_0 == UIItemList.EventUpdate then
			local var_71_0 = self.floorData[arg_71_1 + 1]
			local var_71_1 = Clone(pg.dorm3d_rooms.get_id_list_by_in_map[self.floorData[arg_71_1 + 1]])

			for iter_71_0 = #var_71_1, 1, -1 do
				if pg.dorm3d_rooms[var_71_1[iter_71_0]].is_common == 1 then
					table.remove(var_71_1, iter_71_0)
				end
			end

			setActive(arg_71_2:Find("select"), arg_71_1 + 1 == self.selectedFloorId)
			setText(arg_71_2:Find("name"), i18n("dorm3d_room_" .. var_71_0))
			table.sort(var_71_1, CompareFuncs({
				function(arg_72_0)
					local var_72_0 = getProxy(ApartmentProxy):getRoom(arg_72_0)

					return (var_72_0 and var_72_0:getState() or "lock") == "complete" and 0 or 1
				end,
				function(arg_73_0)
					return pg.dorm3d_rooms[arg_73_0].type == 2 and 0 or 1
				end
			}))

			local var_71_2 = UIItemList.New(arg_71_2:Find("rooms"), arg_71_2:Find("rooms/room"))

			var_71_2:make(function(arg_74_0, arg_74_1, arg_74_2)
				if arg_74_0 == UIItemList.EventUpdate then
					local var_74_0 = var_71_1[arg_74_1 + 1]
					local var_74_1 = pg.dorm3d_rooms[var_71_1[arg_74_1 + 1]]
					local var_74_2 = getProxy(ApartmentProxy):getRoom(var_71_1[arg_74_1 + 1])

					setActive(arg_74_2:Find("lock"), (var_74_2 and var_74_2:getState() or "lock") ~= "complete")
					GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_icon_%s", string.lower(var_74_1.assets_prefix)), "", arg_74_2:Find("normal/mask/icon"), false)
					setText(arg_74_2:Find("roomId"), var_74_0)
				end

				return
			end)
			var_71_2:align(#var_71_1)
			onButton(self, arg_71_2, function()
				var_63_3:SetTriggerEvent(function()
					self:ChangeMap(arg_71_1 + 1)

					return
				end)
				var_63_2:Play("anim_InterludeAni")
				var_63_4:Play("anim_switchPanel_exit")

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_63_5:align(#self.floorData)
	self:ChangeMap(self.selectedFloorId)

	return
end

function SelectDorm3DScene:ChangeMap(arg_77_1)
	self.selectedFloorId = arg_77_1

	local var_77_0 = getProxy(PlayerProxy):getRawData().id

	PlayerPrefs.SetInt("DORM_SELECTED_FLOOR_ID" .. var_77_0, self.selectedFloorId)
	self:SetFloor(self.floorData[self.selectedFloorId])
	setActive(self.rtMain:Find("btn_switch/left"), self.selectedFloorId > 1)
	setActive(self.rtMain:Find("btn_switch/right"), self.selectedFloorId < #self.floorData)
	setText(self.rtMain:Find("btn_switch/switch/currentName"), i18n("dorm3d_room_" .. self.floorData[self.selectedFloorId]))

	for iter_77_0 = 0, #self.floorData - 1 do
		setActive(self.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content"):GetChild(iter_77_0):Find("select"), iter_77_0 + 1 == arg_77_1)
	end

	self.floorTipFlag = {}
	self.floorRoomTipFlag = {}

	for iter_77_1, iter_77_2 in ipairs(self.floorData) do
		local var_77_1 = false
		local var_77_2 = {}

		for iter_77_3, iter_77_4 in ipairs(pg.dorm3d_rooms.get_id_list_by_in_map[iter_77_2]) do
			if pg.dorm3d_rooms[iter_77_4].is_common == 0 then
				var_77_2[iter_77_4] = false

				local var_77_3 = getProxy(ApartmentProxy):getRoom(iter_77_4)
				local var_77_4 = var_77_3 and var_77_3:getState() or "lock"

				if var_77_4 == "complete" and var_77_3:isPersonalRoom() then
					if getProxy(ApartmentProxy):getApartment(var_77_3:getPersonalGroupId()):getIconTip(var_77_3:GetConfigID()) then
						var_77_1 = true
						var_77_2[iter_77_4] = true
					end
				end

				if var_77_4 == "complete" and not var_77_3:isPersonalRoom() then
					var_77_2[iter_77_4] = PlayerPrefs.GetInt(var_77_0 .. "_dorm3dRoomInviteSuccess_" .. iter_77_4, 1) == 0
				end
			end
		end

		table.insert(self.floorTipFlag, var_77_1)
		table.insert(self.floorRoomTipFlag, var_77_2)
	end

	if self.selectedFloorId > 1 then
		setActive(self.rtMain:Find("btn_switch/left/tip"), self.floorTipFlag[self.selectedFloorId - 1])
	end

	if self.selectedFloorId < #self.floorData then
		setActive(self.rtMain:Find("btn_switch/right/tip"), self.floorTipFlag[self.selectedFloorId + 1])
	end

	setActive(self.rtMain:Find("btn_switch/switch/tip"), table.contains(self.floorTipFlag, true))

	for iter_77_5 = 0, self.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content").childCount - 1 do
		local var_77_5 = self.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content"):GetChild(iter_77_5)

		for iter_77_6 = 0, var_77_5:Find("rooms").childCount - 1 do
			local var_77_6 = var_77_5:Find("rooms"):GetChild(iter_77_6)

			setActive(var_77_6:Find("normal/tip"), self.floorRoomTipFlag[iter_77_5 + 1][tonumber(var_77_6:Find("roomId"):GetComponent(typeof(Text)).text)])
		end
	end

	return
end

function SelectDorm3DScene:onBackPressed()
	if isActive(self.rtIconTip) then
		self:HideIconTipWindow()
	else
		SelectDorm3DScene.super.onBackPressed(self)
	end

	return
end

function SelectDorm3DScene:willExit()
	if isActive(self.rtIconTip) then
		self:HideIconTipWindow()
	end

	if self.clearSceneCache then
		-- block empty
	end

	return
end

return SelectDorm3DScene
