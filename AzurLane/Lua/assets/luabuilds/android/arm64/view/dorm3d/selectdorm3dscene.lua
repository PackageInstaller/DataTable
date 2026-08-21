local var_0_0 = class("SelectDorm3DScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "SelectDorm3DUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.rtMap = arg_2_0._tf:Find("Map")
	arg_2_0.rtIconTip = arg_2_0.rtMap:Find("tip")

	setActive(arg_2_0.rtIconTip, false)
	onButton(arg_2_0, arg_2_0.rtIconTip:Find("bg"), function()
		arg_2_0:HideIconTipWindow()

		return
	end, SFX_CANCEL)
	setText(arg_2_0.rtIconTip:Find("window/btn_cancel/Text"), i18n("text_cancel"))
	onButton(arg_2_0, arg_2_0.rtIconTip:Find("window/btn_cancel"), function()
		arg_2_0:HideIconTipWindow()

		return
	end, SFX_CANCEL)
	setText(arg_2_0.rtIconTip:Find("window/btn_confirm/Text"), i18n("text_confirm"))

	arg_2_0.rtMain = arg_2_0._tf:Find("Main")

	setText(arg_2_0.rtMain:Find("title/Text"), i18n("dorm3d_role_choose"))
	onButton(arg_2_0, arg_2_0.rtMain:Find("btn_back"), function()
		arg_2_0.clearSceneCache = true

		arg_2_0:closeView()

		return
	end, SFX_CANCEL)

	arg_2_0.insBtn = Dorm3dInsBtn.New(arg_2_0.rtMain:Find("btn_ins"))

	onButton(arg_2_0, arg_2_0.insBtn.root, function()
		arg_2_0:emit(SelectDorm3DMediator.OPEN_INS_LAYER, arg_2_0.insBtn.IsNewPhoneCall())

		return
	end)
	setActive(arg_2_0.rtMain:Find("btn_ins"), not DORM_LOCK_INS)

	if not pg.TimeMgr.GetInstance():IsSameWeek(pg.TimeMgr.GetInstance():GetServerTime(), PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftWeekRefreshTimeStamp", 0)) then
		ApartmentProxy.RefreshGiftDailyTip()
	end

	setActive(arg_2_0.rtMain:Find("btn_shop/tip"), Dorm3dShopUI.ShouldShowAllTip())
	onButton(arg_2_0, arg_2_0.rtMain:Find("btn_shop"), function()
		arg_2_0:emit(SelectDorm3DMediator.OPEN_SHOP_LAYER, function()
			setActive(arg_2_0.rtMain:Find("btn_shop/tip"), Dorm3dShopUI.ShouldShowAllTip())

			return
		end)

		return
	end)
	onButton(arg_2_0, arg_2_0.rtMain:Find("option/setting"), function()
		arg_2_0:emit(SelectDorm3DMediator.OPEN_SETTING_LAYER)

		return
	end)
	onButton(arg_2_0, arg_2_0.rtMain:Find("option/home"), function()
		arg_2_0:emit(BaseUI.ON_HOME)

		return
	end)

	arg_2_0.rtStamina = arg_2_0.rtMain:Find("stamina")
	arg_2_0.rtRes = arg_2_0.rtMain:Find("res")

	arg_2_0:InitResBar()

	arg_2_0.rtWeekTask = arg_2_0.rtMain:Find("task")

	arg_2_0:UpdateWeekTask()

	arg_2_0.rtLayer = arg_2_0._tf:Find("Layer")
	arg_2_0.floorData = _.keys(pg.dorm3d_rooms.get_id_list_by_in_map)

	table.sort(arg_2_0.floorData, function(arg_11_0, arg_11_1)
		local var_11_0 = tonumber(string.match(arg_11_0, "%d+")) or 0
		local var_11_1 = tonumber(string.match(arg_11_1, "%d+")) or 0

		return var_11_0 < var_11_1
	end)
	arg_2_0:SetMapSwitch()

	return
end

function var_0_0.didEnter(arg_12_0)
	arg_12_0:SetFloor(arg_12_0.floorData[arg_12_0.selectedFloorId])
	arg_12_0:UpdateStamina()
	arg_12_0:CheckGuide("DORM3D_GUIDE_02")
	arg_12_0:FlushInsBtn()

	if not ApartmentProxy.CheckDeviceRAMEnough() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("drom3d_memory_limit_tip"))
	end

	return
end

function var_0_0.FlushInsBtn(arg_13_0)
	arg_13_0.insBtn:Flush()

	return
end

function var_0_0.UpdateStamina(arg_14_0)
	setText(arg_14_0.rtStamina:Find("Text"), string.format("%d/%d", getProxy(ApartmentProxy):getStamina()))

	local var_14_0 = getProxy(ApartmentProxy)

	setActive(arg_14_0.rtStamina:Find("vfx_ui_stamina01"), var_14_0:getStamina() > 0)

	return
end

function var_0_0.SetFloor(arg_15_0, arg_15_1)
	local var_15_0

	eachChild(arg_15_0.rtMap, function(arg_16_0)
		setActive(arg_16_0, arg_16_0.name == arg_15_1)

		if arg_16_0.name == arg_15_1 then
			var_15_0 = arg_16_0
		end

		return
	end)
	assert(nil)

	arg_15_0.roomDic = {}

	for iter_15_0, iter_15_1 in ipairs(pg.dorm3d_rooms.get_id_list_by_in_map[arg_15_1]) do
		arg_15_0.roomDic[iter_15_1] = (nil):Find(pg.dorm3d_rooms[iter_15_1].assets_prefix)

		arg_15_0:InitIconTrigger(iter_15_1)
		arg_15_0:UpdateIconState(iter_15_1)
	end

	arg_15_0:ReplaceSpecialRoomIcon()

	return
end

function var_0_0.FlushFloor(arg_17_0)
	arg_17_0:SetFloor(arg_17_0.floorData[arg_17_0.selectedFloorId])

	return
end

function var_0_0.InitIconTrigger(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.roomDic[arg_18_1]

	GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_icon_%s", string.lower(pg.dorm3d_rooms[arg_18_1].assets_prefix)), "", arg_18_0.roomDic[arg_18_1]:Find("icon"))
	onButton(arg_18_0, arg_18_0.roomDic[arg_18_1], function()
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

				local var_19_0 = getProxy(ApartmentProxy):getRoom(arg_18_1)

				if pg.dorm3d_rooms[arg_18_1].type == 1 then
					if arg_18_1 ~= 4 then
						if not pg.NewStoryMgr.GetInstance():IsPlayed("DORM3D_GUIDE_06") and not DORM_LOCK_GUIDE then
							pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_tip2"))

							return
						end
					end

					if not var_19_0 then
						arg_18_0:emit(SelectDorm3DMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_18_1)
					else
						arg_18_0:TryDownloadResource({
							click = true,
							roomId = arg_18_1
						}, function()
							local var_20_0 = ApartmentProxy.GetRoomInviteList(arg_18_1)

							if arg_18_0:CheckGuide("DORM3D_GUIDE_06") then
								var_20_0 = {}
							end

							arg_18_0:emit(SelectDorm3DMediator.OPEN_INVITE_LAYER, arg_18_1, var_20_0, function()
								arg_18_0:FlushFloor()

								return
							end)

							return
						end)
					end
				elseif pg.dorm3d_rooms[arg_18_1].type == 2 then
					if not var_19_0 then
						arg_18_0:ShowIconTipWindow(arg_18_1, var_18_0)
					else
						arg_18_0:TryDownloadResource({
							click = true,
							roomId = arg_18_1
						}, function()
							arg_18_0:emit(SelectDorm3DMediator.ON_DORM, {
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
			end
		end
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateIconState(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.roomDic[arg_23_1]
	local var_23_1 = getProxy(ApartmentProxy):getRoom(arg_23_1)
	local var_23_2 = var_23_1 and var_23_1:getState() or "lock"

	setActive(arg_23_0.roomDic[arg_23_1]:Find("icon/mask"), var_23_2 ~= "complete")
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

	local var_23_3 = getProxy(PlayerProxy):getRawData().id

	if arg_23_1 == 4 then
		setActive(var_23_0:Find("inivite_tip"), PlayerPrefs.GetInt(var_23_3 .. "_dorm3dRoomInviteSuccess_" .. arg_23_1, 1) == 0)
	end

	setActive(var_23_0:Find("tip"), (function()
		if not var_23_1 or not var_23_1:isPersonalRoom() then
			return false
		end

		return getProxy(ApartmentProxy):HasShipGroupGiftExpireSoon(var_23_1:getConfig("character")[1])
	end)())

	return
end

function var_0_0.UpdateShowIcon(arg_29_0, arg_29_1, arg_29_2)
	removeOnButton(arg_29_2)
	setActive(arg_29_2:Find("icon/mask"), false)
	eachChild(arg_29_2:Find("front"), function(arg_30_0)
		setActive(arg_30_0, false)

		return
	end)

	return
end

function var_0_0.ReplaceSpecialRoomIcon(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(getProxy(ApartmentProxy):getRawData()) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1:getSpecialTalking()) do
			if arg_31_0.roomDic[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]] then
				local var_31_0 = ({})[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]]

				if not ({})[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]] then
					var_31_0 = {}
				end

				;({})[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]] = var_31_0

				table.insert(({})[pg.dorm3d_dialogue_group[iter_31_3].trigger_config[1]], iter_31_3)
			end
		end
	end

	for iter_31_4, iter_31_5 in pairs({}) do
		setActive(arg_31_0.roomDic[iter_31_4], false)

		local var_31_1 = cloneTplTo(arg_31_0.roomDic[iter_31_4], arg_31_0.roomDic[iter_31_4].parent, arg_31_0.roomDic[iter_31_4].name .. "_special")

		arg_31_0:UpdateShowIcon(iter_31_4, var_31_1)
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

		onButton(arg_31_0, var_31_1, function()
			arg_31_0:TryDownloadResource({
				click = true,
				roomId = var_31_3.room_id
			}, function()
				arg_31_0:emit(SelectDorm3DMediator.ON_DORM, {
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

function var_0_0.DownloadUpdate(arg_35_0, arg_35_1, arg_35_2)
	switch(arg_35_2, {
		start = function()
			if arg_35_0.roomDic[arg_35_1] then
				arg_35_0:UpdateIconState(arg_35_1)
			end

			return
		end,
		loading = function()
			if arg_35_0.roomDic[arg_35_1] then
				setSlider(arg_35_0.roomDic[arg_35_1]:Find("front/loading/progress"), 0, DormGroupConst.DormDownloadLock.totalSize, DormGroupConst.DormDownloadLock.curSize)
			end

			return
		end,
		finish = function()
			for iter_38_0, iter_38_1 in pairs(arg_35_0.roomDic) do
				arg_35_0:UpdateIconState(iter_38_0)
			end

			arg_35_0:CheckGuide("DORM3D_GUIDE_02")

			return
		end,
		delete = function()
			if arg_35_0.roomDic[arg_35_1] then
				arg_35_0:UpdateIconState(arg_35_1)
			end

			return
		end
	})

	return
end

function var_0_0.AfterRoomUnlock(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.roomId

	if isActive(arg_40_0.rtIconTip) then
		arg_40_0:HideIconTipWindow()
	end

	eachChild(arg_40_0.roomDic[arg_40_1.roomId]:Find("icon/mask"), function(arg_41_0)
		setActive(arg_41_0, true)

		return
	end)
	quickPlayAnimation(arg_40_0.roomDic[arg_40_1.roomId], "anim_Dorm3d_selectDorm_icon_unlock")
	pg.UIMgr.GetInstance():LoadingOn(false)
	LeanTween.delayedCall(1.2333333333333334, System.Action(function()
		pg.UIMgr.GetInstance():LoadingOff(false)
		arg_40_0:UpdateIconState(var_40_0)
		arg_40_0:TryDownloadResource(arg_40_1)
		arg_40_0:CheckGuide("DORM3D_GUIDE_02")
		arg_40_0:SetMapSwitch()

		return
	end))

	return
end

function var_0_0.ShowIconTipWindow(arg_43_0, arg_43_1, arg_43_2)
	setLocalPosition(arg_43_0.rtIconTip:Find("window"), arg_43_0.rtIconTip:InverseTransformPoint(arg_43_2.position))
	removeAllChildren(arg_43_0.rtIconTip:Find("window/icon"))

	arg_43_2 = cloneTplTo(arg_43_2, arg_43_0.rtIconTip:Find("window/icon"))

	arg_43_0:UpdateShowIcon(arg_43_1, arg_43_2)
	setAnchoredPosition(arg_43_2, Vector2.zero)

	local var_43_0 = ApartmentRoom.New({
		id = arg_43_1
	})
	local var_43_1, var_43_2 = var_43_0:getDownloadNeedSize()

	setText(arg_43_0.rtIconTip:Find("window/Text"), i18n("dorm3d_role_assets_download", ShipGroup.getDefaultShipNameByGroupID(var_43_0:getPersonalGroupId()), var_43_0:needDownload() and var_43_2 or "0B"))
	onButton(arg_43_0, arg_43_0.rtIconTip:Find("window/btn_confirm"), function()
		arg_43_0:emit(SelectDorm3DMediator.ON_UNLOCK_DORM_ROOM, arg_43_1)

		return
	end, SFX_CONFIRM)
	setActive(arg_43_0.rtIconTip, true)

	return
end

function var_0_0.HideIconTipWindow(arg_45_0)
	setActive(arg_45_0.rtIconTip, false)

	return
end

function var_0_0.TryDownloadResource(arg_46_0, arg_46_1, arg_46_2)
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

function var_0_0.InitResBar(arg_48_0)
	arg_48_0.goldMax = arg_48_0.rtRes:Find("gold/max"):GetComponent(typeof(Text))
	arg_48_0.goldValue = arg_48_0.rtRes:Find("gold/Text"):GetComponent(typeof(Text))
	arg_48_0.oilMax = arg_48_0.rtRes:Find("oil/max"):GetComponent(typeof(Text))
	arg_48_0.oilValue = arg_48_0.rtRes:Find("oil/Text"):GetComponent(typeof(Text))
	arg_48_0.gemValue = arg_48_0.rtRes:Find("gem/Text"):GetComponent(typeof(Text))

	onButton(arg_48_0, arg_48_0.rtRes:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(arg_48_0, arg_48_0.rtRes:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(arg_48_0, arg_48_0.rtRes:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	arg_48_0:UpdateRes()

	return
end

function var_0_0.UpdateRes(arg_52_0)
	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), arg_52_0.goldMax, arg_52_0.goldValue, arg_52_0.oilMax, arg_52_0.oilValue, arg_52_0.gemValue)

	return
end

function var_0_0.UpdateWeekTask(arg_53_0)
	local var_53_0 = getProxy(TaskProxy):getTaskVO(getDorm3dGameset("drom3d_weekly_task")[1])
	local var_53_1 = var_53_0:isReceive()
	local var_53_2 = var_53_1 and 3 or var_53_0:getProgress()
	local var_53_3 = arg_53_0.rtWeekTask:Find("content")

	for iter_53_0 = 1, 3 do
		triggerToggle(var_53_3:Find("tpl_" .. iter_53_0), iter_53_0 <= var_53_2)
	end

	updateCustomDrop(var_53_3:Find("Dorm3dIconTpl"), (Drop.Create(var_53_0:getConfig("award_display")[1])))
	onButton(arg_53_0, var_53_3:Find("Dorm3dIconTpl"), function()
		if not var_53_1 and var_53_0:isFinish() then
			arg_53_0:emit(SelectDorm3DMediator.ON_SUBMIT_TASK, var_0)
		else
			arg_53_0:emit(BaseUI.ON_NEW_DROP, {
				drop = var_0
			})
		end

		return
	end, SFX_CONFIRM)
	setActive(var_53_3:Find("Dorm3dIconTpl/get"), not var_53_1 and var_53_0:isFinish())
	setGray(var_53_3:Find("Dorm3dIconTpl"), var_53_1)
	onButton(arg_53_0, arg_53_0._tf:Find("Main/task_done"), function()
		setActive(arg_53_0.rtWeekTask, true)
		setActive(arg_53_0._tf:Find("Main/task_done"), false)

		return
	end)
	onButton(arg_53_0, arg_53_0.rtWeekTask:Find("title"), function()
		if var_53_1 then
			setActive(arg_53_0.rtWeekTask, false)
			setActive(arg_53_0._tf:Find("Main/task_done"), true)
		end

		return
	end)

	return
end

function var_0_0.CheckGuide(arg_57_0, arg_57_1)
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

function var_0_0.SetMapSwitch(arg_63_0)
	local var_63_0 = getProxy(PlayerProxy):getRawData().id

	arg_63_0.selectedFloorId = PlayerPrefs.GetInt("DORM_SELECTED_FLOOR_ID" .. var_63_0, 1)

	if pg.NewGuideMgr.GetInstance():GetCurrentGuideName() == "DORM3D_GUIDE_01" then
		arg_63_0.selectedFloorId = 1
	elseif not DORM_LOCK_SELECT_NEW then
		if PlayerPrefs.GetInt("DORM_SELECTED_NEW_ROOM_FLOOR" .. var_63_0 .. pg.dorm3d_set.drom3d_new_room_remind.key_value_int, 0) == 0 then
			arg_63_0.selectedFloorId = table.indexof(arg_63_0.floorData, pg.dorm3d_rooms[pg.dorm3d_set.drom3d_new_room_remind.key_value_int].in_map)

			PlayerPrefs.SetInt("DORM_SELECTED_NEW_ROOM_FLOOR" .. var_63_0 .. pg.dorm3d_set.drom3d_new_room_remind.key_value_int, 1)
		end
	end

	local var_63_1 = arg_63_0._tf:Find("interludeAni")
	local var_63_2 = var_63_1:GetComponent(typeof(Animation))
	local var_63_3 = var_63_1:GetComponent(typeof(DftAniEvent))

	onButton(arg_63_0, arg_63_0.rtMain:Find("btn_switch/left"), function()
		var_63_3:SetTriggerEvent(function()
			arg_63_0:ChangeMap(arg_63_0.selectedFloorId - 1)

			return
		end)
		var_63_2:Play("anim_InterludeAni")

		return
	end)
	onButton(arg_63_0, arg_63_0.rtMain:Find("btn_switch/right"), function()
		var_63_3:SetTriggerEvent(function()
			arg_63_0:ChangeMap(arg_63_0.selectedFloorId + 1)

			return
		end)
		var_63_2:Play("anim_InterludeAni")

		return
	end)
	setActive(arg_63_0.rtMain:Find("btn_switch/switchPanel"), false)

	local var_63_4 = arg_63_0.rtMain:Find("btn_switch/switchPanel"):GetComponent(typeof(Animation))

	arg_63_0.rtMain:Find("btn_switch/switchPanel"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(arg_63_0.rtMain:Find("btn_switch/switchPanel"), false)

		return
	end)
	onButton(arg_63_0, arg_63_0.rtMain:Find("btn_switch/switch"), function()
		setActive(arg_63_0.rtMain:Find("btn_switch/switchPanel"), true)

		return
	end)
	onButton(arg_63_0, arg_63_0.rtMain:Find("btn_switch/switchPanel"), function()
		var_63_4:Play("anim_switchPanel_exit")

		return
	end)

	local var_63_5 = UIItemList.New(arg_63_0.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content"), arg_63_0.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content/floor"))

	var_63_5:make(function(arg_71_0, arg_71_1, arg_71_2)
		if arg_71_0 == UIItemList.EventUpdate then
			local var_71_1 = Clone(pg.dorm3d_rooms.get_id_list_by_in_map[arg_63_0.floorData[arg_71_1 + 1]])

			for iter_71_0 = #var_71_1, 1, -1 do
				if pg.dorm3d_rooms[var_71_1[iter_71_0]].is_common == 1 then
					table.remove(var_71_1, iter_71_0)
				end
			end

			setActive(arg_71_2:Find("select"), arg_71_1 + 1 == arg_63_0.selectedFloorId)
			setText(arg_71_2:Find("name"), i18n("dorm3d_room_" .. var_71_0))
			table.sort(var_71_1, CompareFuncs({
				function(arg_72_0)
					local var_72_0 = getProxy(ApartmentProxy):getRoom(arg_72_0)
					local var_72_1 = var_72_0 and var_72_0:getState() or "lock"

					return var_72_1 == "complete" and 0 or 1
				end,
				function(arg_73_0)
					return pg.dorm3d_rooms[arg_73_0].type == 2 and 0 or 1
				end
			}))

			local var_71_2 = UIItemList.New(arg_71_2:Find("rooms"), arg_71_2:Find("rooms/room"))

			var_71_2:make(function(arg_74_0, arg_74_1, arg_74_2)
				if arg_74_0 == UIItemList.EventUpdate then
					local var_74_0 = var_71_1[arg_74_1 + 1]
					local var_74_2 = getProxy(ApartmentProxy):getRoom(var_71_1[arg_74_1 + 1])
					local var_74_3 = var_74_2 and var_74_2:getState() or "lock"

					setActive(arg_74_2:Find("lock"), var_74_3 ~= "complete")
					GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_icon_%s", string.lower(var_74_1.assets_prefix)), "", arg_74_2:Find("normal/mask/icon"), false)
					setText(arg_74_2:Find("roomId"), var_74_0)
				end

				return
			end)
			var_71_2:align(#var_71_1)
			onButton(arg_63_0, arg_71_2, function()
				var_63_3:SetTriggerEvent(function()
					arg_63_0:ChangeMap(arg_71_1 + 1)

					return
				end)
				var_63_2:Play("anim_InterludeAni")
				var_63_4:Play("anim_switchPanel_exit")

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_63_5:align(#arg_63_0.floorData)
	arg_63_0:ChangeMap(arg_63_0.selectedFloorId)

	return
end

function var_0_0.ChangeMap(arg_77_0, arg_77_1)
	arg_77_0.selectedFloorId = arg_77_1

	local var_77_0 = getProxy(PlayerProxy):getRawData().id

	PlayerPrefs.SetInt("DORM_SELECTED_FLOOR_ID" .. var_77_0, arg_77_0.selectedFloorId)
	arg_77_0:SetFloor(arg_77_0.floorData[arg_77_0.selectedFloorId])
	setActive(arg_77_0.rtMain:Find("btn_switch/left"), arg_77_0.selectedFloorId > 1)
	setActive(arg_77_0.rtMain:Find("btn_switch/right"), arg_77_0.selectedFloorId < #arg_77_0.floorData)
	setText(arg_77_0.rtMain:Find("btn_switch/switch/currentName"), i18n("dorm3d_room_" .. arg_77_0.floorData[arg_77_0.selectedFloorId]))

	for iter_77_0 = 0, #arg_77_0.floorData - 1 do
		local var_77_1 = arg_77_0.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content"):GetChild(iter_77_0)

		setActive(var_77_1:Find("select"), iter_77_0 + 1 == arg_77_1)
	end

	arg_77_0.floorTipFlag = {}
	arg_77_0.floorRoomTipFlag = {}

	for iter_77_1, iter_77_2 in ipairs(arg_77_0.floorData) do
		local var_77_2 = false
		local var_77_3 = {}

		for iter_77_3, iter_77_4 in ipairs(pg.dorm3d_rooms.get_id_list_by_in_map[iter_77_2]) do
			if pg.dorm3d_rooms[iter_77_4].is_common == 0 then
				var_77_3[iter_77_4] = false

				local var_77_4 = getProxy(ApartmentProxy):getRoom(iter_77_4)
				local var_77_5 = var_77_4 and var_77_4:getState() or "lock"

				if var_77_5 == "complete" and var_77_4:isPersonalRoom() then
					local var_77_6 = getProxy(ApartmentProxy):getApartment(var_77_4:getPersonalGroupId())

					if var_77_6:getIconTip(var_77_4:GetConfigID()) then
						var_77_2 = true
						var_77_3[iter_77_4] = true
					end
				end

				if var_77_5 == "complete" and not var_77_4:isPersonalRoom() then
					var_77_3[iter_77_4] = PlayerPrefs.GetInt(var_77_0 .. "_dorm3dRoomInviteSuccess_" .. iter_77_4, 1) == 0
				end
			end
		end

		table.insert(arg_77_0.floorTipFlag, var_77_2)
		table.insert(arg_77_0.floorRoomTipFlag, var_77_3)
	end

	if arg_77_0.selectedFloorId > 1 then
		setActive(arg_77_0.rtMain:Find("btn_switch/left/tip"), arg_77_0.floorTipFlag[arg_77_0.selectedFloorId - 1])
	end

	if arg_77_0.selectedFloorId < #arg_77_0.floorData then
		setActive(arg_77_0.rtMain:Find("btn_switch/right/tip"), arg_77_0.floorTipFlag[arg_77_0.selectedFloorId + 1])
	end

	setActive(arg_77_0.rtMain:Find("btn_switch/switch/tip"), table.contains(arg_77_0.floorTipFlag, true))

	for iter_77_5 = 0, arg_77_0.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content").childCount - 1 do
		local var_77_7 = arg_77_0.rtMain:Find("btn_switch/switchPanel/switchScrollView/Viewport/Content"):GetChild(iter_77_5)

		for iter_77_6 = 0, var_77_7:Find("rooms").childCount - 1 do
			local var_77_8 = var_77_7:Find("rooms"):GetChild(iter_77_6)
			local var_77_9 = var_77_8:Find("roomId")

			setActive(var_77_8:Find("normal/tip"), arg_77_0.floorRoomTipFlag[iter_77_5 + 1][tonumber(var_77_9:GetComponent(typeof(Text)).text)])
		end
	end

	return
end

function var_0_0.onBackPressed(arg_78_0)
	if isActive(arg_78_0.rtIconTip) then
		arg_78_0:HideIconTipWindow()
	else
		var_0_0.super.onBackPressed(arg_78_0)
	end

	return
end

function var_0_0.willExit(arg_79_0)
	if isActive(arg_79_0.rtIconTip) then
		arg_79_0:HideIconTipWindow()
	end

	if arg_79_0.clearSceneCache then
		-- block empty
	end

	return
end

return var_0_0
