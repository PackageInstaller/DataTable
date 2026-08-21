local var_0_0 = class("MainLiveAreaPage", import("view.base.BaseSubView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:bind(NewMainScene.UPDATE_COVER, function(arg_2_0)
		arg_1_0:ExecuteAction("UpdateCover")

		return
	end)

	return
end

function var_0_0.getUIName(arg_3_0)
	return "MainLiveAreaUI"
end

function var_0_0.OnLoaded(arg_4_0)
	arg_4_0._bg = arg_4_0._tf:Find("bg")

	setText(arg_4_0._bg:Find("day/Text"), i18n("word_harbour"))
	setText(arg_4_0._bg:Find("night/Text"), i18n("word_harbour"))

	arg_4_0.timeCfg = pg.gameset.main_live_area_time.description
	arg_4_0._coverBtn = arg_4_0._tf:Find("cover_btn")
	arg_4_0._academyBtn = arg_4_0._tf:Find("school_btn")
	arg_4_0._haremBtn = arg_4_0._tf:Find("backyard_btn")
	arg_4_0._commanderBtn = arg_4_0._tf:Find("commander_btn")
	arg_4_0._educateBtn = arg_4_0._tf:Find("educate_btn")
	arg_4_0._islandBtn = arg_4_0._tf:Find("island_btn")
	arg_4_0.islandAwardTF = arg_4_0._islandBtn:Find("banners/award")

	setText(arg_4_0.islandAwardTF:Find("Text"), i18n("island_post_acceptable"))

	arg_4_0.islandEmptyTF = arg_4_0._islandBtn:Find("banners/empty")

	setText(arg_4_0.islandEmptyTF:Find("Text"), i18n("island_post_vacant"))

	arg_4_0._dormBtn = arg_4_0._tf:Find("dorm_btn")
	arg_4_0._islandBtnEffect = arg_4_0._islandBtn:Find("VX")
	arg_4_0.coverPage = LivingAreaCoverPage.New(arg_4_0._tf, arg_4_0.event, {
		onHide = function()
			arg_4_0:UpdateCoverTip()

			return
		end,
		onSelected = function(arg_6_0)
			arg_4_0:UpdateCoverTemp(arg_6_0)

			return
		end
	})

	local var_4_0 = pg.EasyRedDotMgr.GetInstance()

	arg_4_0.redDotUIList = {
		arg_4_0._haremBtn:Find("tip"),
		arg_4_0._academyBtn:Find("tip"),
		arg_4_0._commanderBtn:Find("tip")
	}

	var_4_0:RegisterRedDot(arg_4_0.redDotUIList[1], {
		"COURTYARD"
	}, function(arg_7_0)
		setActive(arg_7_0, getProxy(DormProxy):IsShowRedDot())

		return
	end)
	var_4_0:RegisterRedDot(arg_4_0.redDotUIList[2], {
		"SCHOOL"
	}, function(arg_8_0)
		setActive(arg_8_0, getProxy(NavalAcademyProxy):IsShowTip())

		return
	end)
	var_4_0:RegisterRedDot(arg_4_0.redDotUIList[3], {
		"COMMANDER"
	}, function(arg_9_0)
		if getProxy(PlayerProxy):getRawData().level < 40 then
			setActive(arg_9_0, false)

			return
		end

		local var_9_0 = getProxy(CommanderProxy):IsFinishAllBox()

		if not LOCK_CATTERY then
			local var_9_1

			if not var_9_0 then
				::label_9_0::

				var_9_1 = getProxy(CommanderProxy):AnyCatteryExistOP()
				var_9_1 = var_9_1 or getProxy(CommanderProxy):AnyCatteryCanUse()
			end

			setActive(arg_9_0, var_9_1)
		else
			setActive(arg_9_0, var_9_0)
		end

		return
	end)

	return
end

function var_0_0.OnInit(arg_10_0)
	arg_10_0.mediator = MainLiveAreaPageMediator.New()

	onButton(arg_10_0, arg_10_0._coverBtn, function()
		arg_10_0.coverPage:ExecuteAction("Show")

		return
	end, SFX_MAIN)
	onButton(arg_10_0, arg_10_0._commanderBtn, function()
		arg_10_0.mediator:GoScene(SCENE.COMMANDERCAT, {
			fromMain = true,
			fleetType = CommanderCatScene.FLEET_TYPE_COMMON
		})
		arg_10_0:Hide()

		return
	end, SFX_MAIN)
	onButton(arg_10_0, arg_10_0._haremBtn, function()
		arg_10_0.mediator:GoScene(SCENE.COURTYARD)

		return
	end, SFX_MAIN)
	onButton(arg_10_0, arg_10_0._academyBtn, function()
		arg_10_0.mediator:GoScene(SCENE.NAVALACADEMYSCENE)
		arg_10_0:Hide()

		return
	end, SFX_MAIN)
	onButton(arg_10_0, arg_10_0._educateBtn, function()
		if LOCK_EDUCATE_SYSTEM then
			return
		end

		if LOCK_NEW_EDUCATE_SYSTEM then
			arg_10_0.mediator:GoScene(SCENE.EDUCATE, {
				isMainEnter = true
			})
		else
			arg_10_0.mediator:GoScene(SCENE.NEW_EDUCATE_SELECT)
		end

		arg_10_0:Hide()

		return
	end, SFX_MAIN)
	onButton(arg_10_0, arg_10_0._islandBtn, function()
		if LOCK_ISLAND_DISPLAY then
			return
		end

		local var_16_0 = {}
		local var_16_1 = "MAP"

		if Application.isEditor or GroupHelper.IsGroupVerLastest("MAP") or not GroupHelper.IsGroupWaitToUpdate("MAP") then
			-- block empty
		else
			local var_16_2 = GroupHelper.GetGroupSize("MAP")
			local var_16_3 = HashUtil.BytesToString(var_16_2)

			if var_16_2 > 0 then
				table.insert(var_16_0, function(arg_17_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						modal = true,
						locked = true,
						type = MSGBOX_TYPE_FILE_DOWNLOAD,
						content = string.format(i18n("group_download_tip", var_16_3)),
						onYes = arg_17_0
					})

					return
				end)
			end

			table.insert(var_16_0, function(arg_18_0)
				local var_18_0 = GroupHelper.GetGroupMgrByName(var_16_1)

				if var_18_0.toUpdate then
					for iter_18_0 = 0, var_18_0.toUpdate.Count - 1 do
						table.insert({}, var_18_0.toUpdate[iter_18_0][0])
					end
				end

				;({})[1] = {
					groupName = var_16_1,
					fileNameList = {}
				}
				;({}).dataList = {}
				;({}).onFinish = arg_18_0

				pg.FileDownloadMgr.GetInstance():Main({})

				return
			end)
		end

		local var_16_4 = pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d", true)

		if not LOCK_ISLAND_ENTER_TIP_WINDOW and PlayerPrefs.GetString("ISLAND_ENTER_TIP_WINDOW", "") ~= var_16_4 then
			table.insert(var_16_0, function(arg_19_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					showStopRemind = true,
					toggleStatus = true,
					type = MSGBOX_TYPE_HELP,
					helps = i18n("island_urgent_notice"),
					onYes = function()
						if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
							PlayerPrefs.SetString("ISLAND_ENTER_TIP_WINDOW", var_16_4)
						end

						arg_19_0()

						return
					end,
					onNo = function()
						if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
							PlayerPrefs.SetString("ISLAND_ENTER_TIP_WINDOW", var_16_4)
						end

						arg_19_0()

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_16_0, function()
			arg_10_0.mediator:GoIsland(getProxy(PlayerProxy):getRawData().id)
			arg_10_0:Hide()

			return
		end)

		return
	end, SFX_MAIN)
	onButton(arg_10_0, arg_10_0._dormBtn, function()
		arg_10_0.mediator:OpenDormSelectLayer()
		arg_10_0:Hide()

		return
	end, SFX_MAIN)
	onButton(arg_10_0, arg_10_0._tf, function()
		arg_10_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_24_0, arg_24_1, arg_24_2)
	var_0_0.super.Show(arg_24_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_24_0._tf, {
		staticBlur = true
	})

	local var_24_0 = getProxy(PlayerProxy):getRawData()

	arg_24_0._commanderBtn:GetComponent(typeof(Image)).color = not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_24_0.level, "CommanderCatMediator") and Color(0.5, 0.5, 0.5, 1) or Color(1, 1, 1, 1)

	local var_24_1 = pg.SystemOpenMgr.GetInstance()
	local var_24_2

	if not var_24_1:isOpenSystem(var_24_0.level, "CourtYardMediator") then
		arg_24_0._haremBtn:GetComponent(typeof(Image)).color = Color(0.5, 0.5, 0.5, 1)
	else
		arg_24_0._haremBtn:GetComponent(typeof(Image)).color = Color(1, 1, 1, 1)
		var_24_2 = pg.SystemOpenMgr.GetInstance()
	end

	arg_24_0._educateBtn:GetComponent(typeof(Image)).color = not var_24_2:isOpenSystem(var_24_0.level, LOCK_NEW_EDUCATE_SYSTEM and "EducateMediator" or "NewEducateSelectMediator") and Color(0.5, 0.5, 0.5, 1) or Color(1, 1, 1, 1)

	setActive(arg_24_0._educateBtn:Find("tip"), NewEducateHelper.IsShowNewChildTip())

	arg_24_0._dormBtn:GetComponent(typeof(Image)).color = not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_24_0.level, "SelectDorm3DMediator") and Color(0.5, 0.5, 0.5, 1) or Color(1, 1, 1, 1)

	;(function()
		local var_25_0 = var_0 and Dorm3dShopUI.ShouldShowAllTip()
		local var_25_1 = var_0 and Dorm3dFurniture.IsTimelimitShopTip()
		local var_25_3 = var_25_0 or getProxy(ApartmentProxy):HasGiftExpireSoon()

		var_25_2(arg_24_0._dormBtn:Find("tip"), var_25_3)
		setActive(arg_24_0._dormBtn:Find("tagFurniture"), var_25_1)

		return
	end)()

	arg_24_0._islandBtn:GetComponent(typeof(Image)).color = not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_24_0.level, "IslandMediator") and Color(0.5, 0.5, 0.5, 1) or Color(1, 1, 1, 1)

	arg_24_0:UpdataIslandTip()
	arg_24_0:UpdateCover()
	arg_24_0:UpdateCoverTip()
	arg_24_0:UpdateTime()

	arg_24_0.timer = Timer.New(function()
		arg_24_0:UpdateTime()

		return
	end, 60, -1)

	arg_24_0.timer:Start()
	setActive(arg_24_0._islandBtnEffect, tobool(arg_24_1))

	if arg_24_2 then
		arg_24_2()
	end

	return
end

function var_0_0.UpdateTime(arg_27_0)
	local var_27_0 = pg.TimeMgr.GetInstance()
	local var_27_1 = var_27_0:GetServerHour()
	local var_27_2 = var_27_1 < 12

	setActive(arg_27_0._bg:Find("AM"), var_27_1 < 12)
	setActive(arg_27_0._bg:Find("PM"), not var_27_2)

	local var_27_3 = arg_27_0:getCoverType(var_27_1)

	setActive(arg_27_0._bg:Find("day"), var_27_3 == LivingAreaCover.TYPE_DAY)
	setActive(arg_27_0._bg:Find("night"), var_27_3 == LivingAreaCover.TYPE_NIGHT)
	setActive(arg_27_0._islandBtn:Find("lock/day"), var_27_3 == LivingAreaCover.TYPE_DAY)
	setActive(arg_27_0._islandBtn:Find("lock/night"), var_27_3 ~= LivingAreaCover.TYPE_DAY)
	setText(arg_27_0._bg:Find("date"), (var_27_0:CurrentSTimeDesc("%Y/%m/%d", true)))

	if var_27_1 > 12 then
		var_27_1 = var_27_1 - 12
	end

	setText(arg_27_0._bg:Find("time"), var_27_1 .. var_27_0:CurrentSTimeDesc(":%M", true))
	setText(arg_27_0._bg:Find("date/week"), (EducateHelper.GetWeekStrByNumber(var_27_0:GetServerWeek())))

	return
end

function var_0_0.getCoverType(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.timeCfg) do
		if arg_28_1 >= iter_28_1[1][1] and arg_28_1 < iter_28_1[1][2] then
			return iter_28_1[2]
		end
	end

	return LivingAreaCover.TYPE_DAY
end

function var_0_0.UpdateCover(arg_29_0)
	local var_29_0 = getProxy(LivingAreaCoverProxy):GetCurCover()

	if arg_29_0.cover and arg_29_0.cover.id == var_29_0.id then
		return
	end

	arg_29_0.cover = var_29_0

	arg_29_0:_loadBg()

	return
end

function var_0_0.UpdateCoverTemp(arg_30_0, arg_30_1)
	if arg_30_0.cover and arg_30_0.cover.id == arg_30_1.id then
		return
	end

	arg_30_0.cover = arg_30_1

	arg_30_0:_loadBg()

	return
end

function var_0_0._loadBg(arg_31_0)
	setImageSprite(arg_31_0._bg:Find("day"), GetSpriteFromAtlas(arg_31_0.cover:GetBg(LivingAreaCover.TYPE_DAY), ""), true)
	setImageSprite(arg_31_0._bg:Find("night"), GetSpriteFromAtlas(arg_31_0.cover:GetBg(LivingAreaCover.TYPE_NIGHT), ""), true)

	return
end

function var_0_0.UpdateCoverTip(arg_32_0)
	setActive(arg_32_0._coverBtn:Find("tip"), getProxy(LivingAreaCoverProxy):IsTip())

	return
end

function var_0_0.UpdataIslandTip(arg_33_0)
	setActive(arg_33_0._islandBtn:Find("banners"), not LOCK_ISLAND_DISPLAY)

	if LOCK_ISLAND_DISPLAY then
		return
	end

	local var_33_0, var_33_1 = getProxy(SystemTipProxy):GetIslandTipInfos()

	setActive(arg_33_0.islandAwardTF, var_33_0 > 0)
	setActive(arg_33_0.islandEmptyTF, var_33_1 > 0)

	return
end

function var_0_0.Hide(arg_34_0)
	if arg_34_0.coverPage and arg_34_0.coverPage:GetLoaded() and arg_34_0.coverPage:isShowing() then
		arg_34_0.coverPage:Hide()

		return
	end

	if arg_34_0:isShowing() then
		var_0_0.super.Hide(arg_34_0)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_34_0._tf, arg_34_0._parentTf)
	end

	if arg_34_0.timer ~= nil then
		arg_34_0.timer:Stop()

		arg_34_0.timer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_35_0)
	local var_35_0 = pg.EasyRedDotMgr.GetInstance()

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.redDotUIList) do
		var_35_0:UnRegisterRedDot(iter_35_1)
	end

	arg_35_0.redDotUIList = nil

	arg_35_0.mediator:Dispose()

	arg_35_0.mediator = nil

	arg_35_0:Hide()
	arg_35_0.coverPage:Destroy()

	arg_35_0.coverPage = nil
	arg_35_0.cover = nil

	return
end

return var_0_0
