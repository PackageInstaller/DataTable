local var_0_0 = class("MangaView", import("..base.BaseSubView"))

var_0_0.MangaGroupName = "MANGA"

function var_0_0.getUIName(arg_1_0)
	return "MangaUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()
	arg_2_0:updateBtnList()
	arg_2_0:Show()
	arg_2_0:updatePanel()
	arg_2_0:tryShowTipMsgBox()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	arg_3_0.resLoader:Clear()
	arg_3_0:stopUpdateEmpty()
	arg_3_0:stopUpdateDownloadBtnPanel()

	return
end

function var_0_0.onBackPressed(arg_4_0)
	return true
end

function var_0_0.initData(arg_5_0)
	arg_5_0.appreciateProxy = getProxy(AppreciateProxy)
	arg_5_0.resLoader = AutoLoader.New()
	arg_5_0.isShowNotRead = false
	arg_5_0.isShowLike = false
	arg_5_0.isUpOrder = false
	arg_5_0.group = GroupHelper.GetGroupMgrByName(var_0_0.MangaGroupName)
	arg_5_0.mangaIDListForShow = arg_5_0:getMangaIDListForShow()

	return
end

function var_0_0.initUI(arg_6_0)
	setLocalPosition(arg_6_0._tf, Vector2.zero)

	arg_6_0._tf.anchorMin = Vector2.zero
	arg_6_0._tf.anchorMax = Vector2.one
	arg_6_0._tf.offsetMax = Vector2.zero
	arg_6_0._tf.offsetMin = Vector2.zero

	local var_6_0 = arg_6_0._tf:Find("BtnList")

	arg_6_0.likeFilteBtn = var_6_0:Find("LikeFilterBtn")
	arg_6_0.readFilteBtn = var_6_0:Find("ReadFilteBtn")
	arg_6_0.orderBtn = var_6_0:Find("OrderBtn")
	arg_6_0.repairBtn = var_6_0:Find("RepairBtn")
	arg_6_0.scrollView = arg_6_0._tf:Find("ScrollView")
	arg_6_0.emptyPanel = arg_6_0._tf:Find("EmptyPanel")
	arg_6_0.downloadBtnPanel = arg_6_0._tf:Find("UpdatePanel")
	arg_6_0.mangaContainer = arg_6_0._tf:Find("ScrollView/Content")
	arg_6_0.lScrollRectSC = arg_6_0._tf:Find("ScrollView/Content"):GetComponent("LScrollRect")
	arg_6_0.mangaTpl = arg_6_0._tf:Find("MangaTpl")

	arg_6_0.lScrollRectSC:BeginLayout()
	arg_6_0.lScrollRectSC:EndLayout()
	arg_6_0:initUIText()

	return
end

function var_0_0.initUIText(arg_7_0)
	setText(arg_7_0.readFilteBtn:Find("ShowingAll/Text"), i18n("cartoon_notall"))
	setText(arg_7_0.readFilteBtn:Find("ShowingNotRead/Text"), i18n("cartoon_notall"))
	setText(arg_7_0.mangaTpl:Find("Content/Bottom/BottomNotRead/Tag/Text"), i18n("cartoon_notall"))
	setText(arg_7_0.emptyPanel:Find("Text"), i18n("cartoon_haveno"))

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.likeFilteBtn, function()
		arg_8_0.isShowLike = not arg_8_0.isShowLike
		arg_8_0.mangaIDListForShow = arg_8_0:getMangaIDListForShow()

		arg_8_0:updateBtnList()
		arg_8_0:updatePanel()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.readFilteBtn, function()
		arg_8_0.isShowNotRead = not arg_8_0.isShowNotRead
		arg_8_0.mangaIDListForShow = arg_8_0:getMangaIDListForShow()

		arg_8_0:updateBtnList()
		arg_8_0:updatePanel()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.orderBtn, function()
		arg_8_0.isUpOrder = not arg_8_0.isUpOrder
		arg_8_0.mangaIDListForShow = arg_8_0:getMangaIDListForShow()

		arg_8_0:updateBtnList()
		arg_8_0:updatePanel()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.repairBtn, function()
		if IsUnityEditor then
			PlayerPrefs.SetInt("mangaVersion", 0)
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideYes = true,
			content = i18n("resource_verify_warn"),
			custom = {
				{
					text = i18n("msgbox_repair"),
					onCallback = function()
						if PathMgr.FileExists(Application.persistentDataPath .. "/hashes-manga.csv") then
							arg_8_0.group:StartVerifyForLua()
						else
							pg.TipsMgr.GetInstance():ShowTips(i18n("word_no_cache"))
						end

						return
					end
				}
			}
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateMangaTpl(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = tf(arg_14_2)

	assert(arg_14_0.mangaIDListForShow[arg_14_1], "null mangaID")
	setActive(var_14_0:Find("Update"), false)

	local var_14_1 = var_14_0:Find("Content/Mask/Pic")
	local var_14_2 = var_14_0:Find("Content/Bottom/BottomNew")
	local var_14_3 = var_14_0:Find("Content/Bottom/BottomNotRead")
	local var_14_4 = var_14_0:Find("Content/Bottom/BottomNormal")
	local var_14_5 = MangaConst.isMangaEverReadByID(arg_14_0.mangaIDListForShow[arg_14_1])
	local var_14_6 = MangaConst.isMangaNewByID(arg_14_0.mangaIDListForShow[arg_14_1])

	setActive(var_14_0:Find("Content/Bottom/BottomTip"), false)
	setActive(var_14_2, not var_14_5)
	setActive(var_14_3, false)
	setActive(var_14_4, var_14_5)
	setActive(var_14_0:Find("TopSpecial"), not var_14_5)
	setText(var_14_2:Find("NumText"), "#" .. pg.cartoon[arg_14_0.mangaIDListForShow[arg_14_1]].cartoon_id)
	setText(var_14_3:Find("NumText"), "#" .. pg.cartoon[arg_14_0.mangaIDListForShow[arg_14_1]].cartoon_id)
	setText(var_14_4:Find("NumText"), "#" .. pg.cartoon[arg_14_0.mangaIDListForShow[arg_14_1]].cartoon_id)
	removeOnButton(var_14_0)
	onButton(arg_14_0, var_14_0, function()
		arg_14_0:openMangaViewLayer(arg_14_1)

		return
	end, SFX_PANEL)

	local var_14_7 = GetComponent(var_14_1, "Image").sprite

	if not IsNil(var_14_7) then
		if var_14_7.name ~= pg.cartoon[arg_14_0.mangaIDListForShow[arg_14_1]].resource then
			arg_14_0.resLoader:LoadSprite(MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[arg_14_0.mangaIDListForShow[arg_14_1]].resource, pg.cartoon[arg_14_0.mangaIDListForShow[arg_14_1]].resource, var_14_1, false)
		end
	else
		arg_14_0.resLoader:LoadSprite(MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[arg_14_0.mangaIDListForShow[arg_14_1]].resource, pg.cartoon[arg_14_0.mangaIDListForShow[arg_14_1]].resource, var_14_1, false)
	end

	return
end

function var_0_0.initEmpty(arg_16_0, arg_16_1)
	local var_16_0 = tf(arg_16_1)

	setActive(var_16_0:Find("TopSpecial"), false)

	local var_16_1 = var_16_0:Find("Content/Bottom/BottomTip")

	setActive(var_16_0:Find("Content/Bottom/BottomNew"), false)
	setActive(var_16_0:Find("Content/Bottom/BottomNotRead"), false)
	setActive(var_16_0:Find("Content/Bottom/BottomNormal"), false)
	setActive(var_16_1, true)

	local var_16_2 = var_16_0:Find("Update")
	local var_16_3 = var_16_2:Find("Btn")
	local var_16_4 = var_16_2:Find("Progress")
	local var_16_5 = var_16_4:Find("Slider")

	setActive(var_16_2, true)
	setActive(var_16_3, true)
	setActive(var_16_4, false)

	local var_16_6

	for iter_16_0, iter_16_1 in ipairs(pg.cartoon.all) do
		local var_16_7

		if checkABExist(MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[iter_16_1].resource) then
			var_16_6 = pg.cartoon[iter_16_1].resource
			var_16_7 = MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[iter_16_1].resource

			break
		end
	end

	arg_16_0.resLoader:LoadSprite(nil, var_16_6, var_16_0:Find("Content/Mask/Pic"), false)
	setText(var_16_1:Find("Text"), "")
	onButton(arg_16_0, var_16_3, function()
		if arg_16_0.group.state == DownloadState.None or arg_16_0.group.state == DownloadState.CheckFailure then
			arg_16_0.group:CheckD()

			goto label_17_0
		end

		::label_17_0::

		if arg_16_0.group.state ~= DownloadState.CheckToUpdate then
			if arg_16_0.group.state == DownloadState.UpdateFailure then
				({
					type = MSGBOX_TYPE_NORMAL
				}).content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.GetGroupSize(var_0_0.MangaGroupName))))))
				;({
					type = MSGBOX_TYPE_NORMAL
				}).onYes = function()
					arg_16_0.group:UpdateD()

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_NORMAL
				})
			end

			return
		end
	end, SFX_PANEL)
	arg_16_0:startUpdateEmpty(arg_16_1)

	return
end

function var_0_0.updateEmpty(arg_19_0, arg_19_1)
	local var_19_0 = tf(arg_19_1):Find("Update")
	local var_19_1 = var_19_0:Find("Btn")
	local var_19_2 = var_19_1:Find("Text")
	local var_19_3 = var_19_0:Find("Progress")

	if arg_19_0.group.state == DownloadState.None then
		setText(var_19_2, "None")
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif arg_19_0.group.state == DownloadState.Checking then
		setText(var_19_2, i18n("word_manga_checking"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif arg_19_0.group.state == DownloadState.CheckToUpdate then
		setText(var_19_2, i18n("word_manga_checktoupdate"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif arg_19_0.group.state == DownloadState.CheckOver then
		setText(var_19_2, "Latest Ver")
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif arg_19_0.group.state == DownloadState.CheckFailure then
		setText(var_19_2, i18n("word_manga_checkfailure"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif arg_19_0.group.state == DownloadState.Updating then
		setText(var_19_2, i18n("word_manga_updating", arg_19_0.group.downloadCount, arg_19_0.group.downloadTotal))
		setActive(var_19_1, false)
		setActive(var_19_3, true)
		setSlider(var_19_3:Find("Slider"), 0, arg_19_0.group.downloadTotal, arg_19_0.group.downloadCount)
	elseif arg_19_0.group.state == DownloadState.UpdateSuccess then
		setText(var_19_2, i18n("word_manga_updatesuccess"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)

		arg_19_0.mangaIDListForShow = arg_19_0:getMangaIDListForShow()

		arg_19_0:updatePanel()
	elseif arg_19_0.group.state == DownloadState.UpdateFailure then
		setText(var_19_2, i18n("word_manga_updatefailure"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	end

	return
end

function var_0_0.startUpdateEmpty(arg_20_0, arg_20_1)
	if arg_20_0.timer then
		arg_20_0.timer:Stop()
	end

	arg_20_0.timer = Timer.New(function()
		arg_20_0:updateEmpty(arg_20_1)

		return
	end, 0.5, -1)

	arg_20_0.timer:Start()
	arg_20_0:updateEmpty(arg_20_1)

	return
end

function var_0_0.stopUpdateEmpty(arg_22_0, arg_22_1)
	if arg_22_0.timer then
		arg_22_0.timer:Stop()
	end

	return
end

function var_0_0.updateMangaList(arg_23_0)
	arg_23_0.resLoader:Clear()

	function arg_23_0.lScrollRectSC.onReturnItem(arg_24_0, arg_24_1)
		arg_24_0 = arg_24_0 + 1

		if arg_23_0.mangaIDListForShow[arg_24_0] == false then
			arg_23_0:stopUpdateEmpty(arg_24_1)
		end

		return
	end

	function arg_23_0.lScrollRectSC.onUpdateItem(arg_25_0, arg_25_1)
		arg_25_0 = arg_25_0 + 1

		if arg_23_0.mangaIDListForShow[arg_25_0] == false then
			arg_23_0:initEmpty(arg_25_1)
			arg_23_0:updateEmpty(arg_25_1)
		else
			arg_23_0:updateMangaTpl(arg_25_0, arg_25_1)
		end

		return
	end

	arg_23_0.lScrollRectSC:SetTotalCount(#arg_23_0.mangaIDListForShow)

	return
end

function var_0_0.initDownloadBtnPanel(arg_26_0)
	local var_26_0 = arg_26_0.downloadBtnPanel:Find("Btn")
	local var_26_1 = var_26_0:Find("Text")
	local var_26_2 = arg_26_0.downloadBtnPanel:Find("Progress")
	local var_26_3 = var_26_2:Find("Slider")

	setActive(var_26_0, true)
	setActive(var_26_2, false)
	onButton(arg_26_0, var_26_0, function()
		if arg_26_0.group.state == DownloadState.None or arg_26_0.group.state == DownloadState.CheckFailure then
			arg_26_0.group:CheckD()

			goto label_27_0
		end

		::label_27_0::

		if arg_26_0.group.state ~= DownloadState.CheckToUpdate then
			if arg_26_0.group.state == DownloadState.UpdateFailure then
				({
					type = MSGBOX_TYPE_NORMAL
				}).content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.GetGroupSize(var_0_0.MangaGroupName))))))
				;({
					type = MSGBOX_TYPE_NORMAL
				}).onYes = function()
					arg_26_0.group:UpdateD()

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_NORMAL
				})
			end

			return
		end
	end, SFX_PANEL)
	arg_26_0:startUpdateDownloadBtnPanel()

	return
end

function var_0_0.updateDownloadBtnPanel(arg_29_0)
	local var_29_0 = arg_29_0.downloadBtnPanel:Find("Btn")
	local var_29_1 = var_29_0:Find("Text")
	local var_29_2 = arg_29_0.downloadBtnPanel:Find("Progress")

	if arg_29_0.group.state == DownloadState.None then
		setText(var_29_1, "None")
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif arg_29_0.group.state == DownloadState.Checking then
		setText(var_29_1, i18n("word_manga_checking"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif arg_29_0.group.state == DownloadState.CheckToUpdate then
		setText(var_29_1, i18n("word_manga_checktoupdate"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif arg_29_0.group.state == DownloadState.CheckOver then
		setText(var_29_1, "Latest Ver")
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif arg_29_0.group.state == DownloadState.CheckFailure then
		setText(var_29_1, i18n("word_manga_checkfailure"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif arg_29_0.group.state == DownloadState.Updating then
		setText(var_29_1, i18n("word_manga_updating", arg_29_0.group.downloadCount, arg_29_0.group.downloadTotal))
		setActive(var_29_0, false)
		setActive(var_29_2, true)
		setSlider(var_29_2:Find("Slider"), 0, arg_29_0.group.downloadTotal, arg_29_0.group.downloadCount)
	elseif arg_29_0.group.state == DownloadState.UpdateSuccess then
		setText(var_29_1, i18n("word_manga_updatesuccess"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)

		arg_29_0.mangaIDListForShow = arg_29_0:getMangaIDListForShow()

		arg_29_0:updatePanel()
	elseif arg_29_0.group.state == DownloadState.UpdateFailure then
		setText(var_29_1, i18n("word_manga_updatefailure"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	end

	return
end

function var_0_0.startUpdateDownloadBtnPanel(arg_30_0)
	if arg_30_0.timer then
		arg_30_0.timer:Stop()
	end

	arg_30_0.timer = Timer.New(function()
		arg_30_0:updateDownloadBtnPanel()

		return
	end, 0.5, -1)

	arg_30_0.timer:Start()
	arg_30_0:updateDownloadBtnPanel()

	return
end

function var_0_0.stopUpdateDownloadBtnPanel(arg_32_0)
	if arg_32_0.timer then
		arg_32_0.timer:Stop()
	end

	return
end

function var_0_0.updatePanel(arg_33_0)
	local var_33_0 = #arg_33_0.mangaIDListForShow <= 0
	local var_33_1 = #arg_33_0.mangaIDListForShow == 1 and arg_33_0.mangaIDListForShow[1] == false

	setActive(arg_33_0.emptyPanel, #arg_33_0.mangaIDListForShow <= 0)
	setActive(arg_33_0.downloadBtnPanel, var_33_1)
	setActive(arg_33_0.scrollView, not var_33_0 and not var_33_1)
	arg_33_0:stopUpdateEmpty()
	arg_33_0:stopUpdateDownloadBtnPanel()

	if not var_33_0 and not var_33_1 then
		arg_33_0:updateMangaList()
	elseif var_33_1 then
		arg_33_0:initDownloadBtnPanel()
	end

	return
end

function var_0_0.updateBtnList(arg_34_0)
	setActive(arg_34_0.likeFilteBtn:Find("On"), arg_34_0.isShowLike)
	setActive(arg_34_0.readFilteBtn:Find("ShowingAll"), not arg_34_0.isShowNotRead)
	setActive(arg_34_0.readFilteBtn:Find("ShowingNotRead"), arg_34_0.isShowNotRead)
	setActive(arg_34_0.orderBtn:Find("Up"), arg_34_0.isUpOrder)
	setActive(arg_34_0.orderBtn:Find("Down"), not arg_34_0.isUpOrder)

	return
end

function var_0_0.tryShowTipMsgBox(arg_35_0)
	if arg_35_0.appreciateProxy:isMangaHaveNewRes() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			hideClose = true,
			content = i18n("res_cartoon_new_tip", MangaConst.NewCount),
			onYes = function()
				PlayerPrefs.SetInt("mangaVersion", MangaConst.Version)
				arg_35_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end,
			onCancel = function()
				PlayerPrefs.SetInt("mangaVersion", MangaConst.Version)
				arg_35_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end,
			onClose = function()
				PlayerPrefs.SetInt("mangaVersion", MangaConst.Version)
				arg_35_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end
		})
	end

	return
end

function var_0_0.openMangaViewLayer(arg_37_0, arg_37_1)
	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = MangaFullScreenMediator,
		viewComponent = MangaFullScreenLayer,
		data = {
			mangaIndex = arg_37_1,
			mangaIDLIst = arg_37_0.mangaIDListForShow,
			mangaContext = arg_37_0,
			isShowingNotRead = isActive(arg_37_0.readFilteBtn:Find("ShowingNotRead"))
		},
		onRemoved = function()
			return
		end
	}))

	return
end

function var_0_0.updateLineAfterRead(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.mangaContainer:Find(tostring(table.indexof(arg_39_0.mangaIDListForShow, arg_39_1) - 1))

	if var_39_0 then
		local var_39_1 = var_39_0:Find("Content/Bottom/BottomNotRead")
		local var_39_2 = var_39_0:Find("Content/Bottom/BottomNormal")
		local var_39_3 = var_39_0:Find("TopSpecial")
		local var_39_4 = MangaConst.isMangaEverReadByID(arg_39_1)
		local var_39_5 = MangaConst.isMangaNewByID(arg_39_1)

		setActive(var_39_0:Find("Content/Bottom/BottomNew"), var_39_5 and not var_39_4)
		setActive(var_39_1, not var_39_5 and not var_39_4)
		setActive(var_39_2, var_39_4)
		setActive(var_39_3, not var_39_4)
	end

	return
end

function var_0_0.updateToMangaID(arg_40_0, arg_40_1)
	arg_40_0.lScrollRectSC:SetTotalCount(#arg_40_0.mangaIDListForShow, defaultValue(arg_40_0.lScrollRectSC:HeadIndexToValue(table.indexof(arg_40_0.mangaIDListForShow, arg_40_1) - 1), -1))

	return
end

function var_0_0.getMangaIDListForShow(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(pg.cartoon.all) do
		if arg_41_0:isMangaExist(iter_41_1) then
			local var_41_0 = MangaConst.isMangaEverReadByID(iter_41_1)
			local var_41_1 = MangaConst.isMangaLikeByID(iter_41_1)

			if arg_41_0.isShowNotRead and arg_41_0.isShowLike then
				if not var_41_0 and var_41_1 then
					table.insert({}, iter_41_1)
				end
			elseif arg_41_0.isShowNotRead and not arg_41_0.isShowLike then
				if not var_41_0 then
					table.insert({}, iter_41_1)
				end
			elseif not arg_41_0.isShowNotRead and arg_41_0.isShowLike then
				if var_41_1 then
					table.insert({}, iter_41_1)
				end
			else
				table.insert({}, iter_41_1)
			end
		end
	end

	table.sort({}, function(arg_42_0, arg_42_1)
		if pg.cartoon[arg_42_1].cartoon_id < pg.cartoon[arg_42_0].cartoon_id then
			return not arg_41_0.isUpOrder
		elseif pg.cartoon[arg_42_0].cartoon_id == pg.cartoon[arg_42_1].cartoon_id then
			return arg_42_0 < arg_42_1
		elseif pg.cartoon[arg_42_0].cartoon_id < pg.cartoon[arg_42_1].cartoon_id then
			return arg_41_0.isUpOrder
		end

		return
	end)

	if arg_41_0:isNeedShowDownBtn() then
		table.insert({}, 1, false)
	end

	return {}
end

function var_0_0.isMangaExist(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.group:CheckF(MangaConst.MANGA_PATH_PREFIX .. arg_43_1)

	return var_43_0 == DownloadState.None or var_43_0 == DownloadState.UpdateSuccess
end

function var_0_0.isNeedShowDownBtn(arg_44_0)
	if Application.isEditor then
		return false
	end

	if GroupHelper.IsGroupVerLastest(var_0_0.MangaGroupName) then
		return false
	end

	if not GroupHelper.IsGroupWaitToUpdate(var_0_0.MangaGroupName) then
		return false
	end

	return true
end

return var_0_0
