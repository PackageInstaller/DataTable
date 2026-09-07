local MangaView = class("MangaView", import("..base.BaseSubView"))

MangaView.MangaGroupName = "MANGA"

function MangaView:getUIName()
	return "MangaUI"
end

function MangaView:OnInit()
	self:initData()
	self:initUI()
	self:addListener()
	self:updateBtnList()
	self:Show()
	self:updatePanel()
	self:tryShowTipMsgBox()

	return
end

function MangaView:OnDestroy()
	self.resLoader:Clear()
	self:stopUpdateEmpty()
	self:stopUpdateDownloadBtnPanel()

	return
end

function MangaView:onBackPressed()
	return true
end

function MangaView:initData()
	self.appreciateProxy = getProxy(AppreciateProxy)
	self.resLoader = AutoLoader.New()
	self.isShowNotRead = false
	self.isShowLike = false
	self.isUpOrder = false
	self.group = GroupHelper.GetGroupMgrByName(MangaView.MangaGroupName)
	self.mangaIDListForShow = self:getMangaIDListForShow()

	return
end

function MangaView:initUI()
	setLocalPosition(self._tf, Vector2.zero)

	self._tf.anchorMin = Vector2.zero
	self._tf.anchorMax = Vector2.one
	self._tf.offsetMax = Vector2.zero
	self._tf.offsetMin = Vector2.zero

	local var_6_0 = self._tf:Find("BtnList")

	self.likeFilteBtn = var_6_0:Find("LikeFilterBtn")
	self.readFilteBtn = var_6_0:Find("ReadFilteBtn")
	self.orderBtn = var_6_0:Find("OrderBtn")
	self.repairBtn = var_6_0:Find("RepairBtn")
	self.scrollView = self._tf:Find("ScrollView")
	self.emptyPanel = self._tf:Find("EmptyPanel")
	self.downloadBtnPanel = self._tf:Find("UpdatePanel")
	self.mangaContainer = self._tf:Find("ScrollView/Content")
	self.lScrollRectSC = self._tf:Find("ScrollView/Content"):GetComponent("LScrollRect")
	self.mangaTpl = self._tf:Find("MangaTpl")

	self.lScrollRectSC:BeginLayout()
	self.lScrollRectSC:EndLayout()
	self:initUIText()

	return
end

function MangaView:initUIText()
	setText(self.readFilteBtn:Find("ShowingAll/Text"), i18n("cartoon_notall"))
	setText(self.readFilteBtn:Find("ShowingNotRead/Text"), i18n("cartoon_notall"))
	setText(self.mangaTpl:Find("Content/Bottom/BottomNotRead/Tag/Text"), i18n("cartoon_notall"))
	setText(self.emptyPanel:Find("Text"), i18n("cartoon_haveno"))

	return
end

function MangaView:addListener()
	onButton(self, self.likeFilteBtn, function()
		self.isShowLike = not self.isShowLike
		self.mangaIDListForShow = self:getMangaIDListForShow()

		self:updateBtnList()
		self:updatePanel()

		return
	end, SFX_PANEL)
	onButton(self, self.readFilteBtn, function()
		self.isShowNotRead = not self.isShowNotRead
		self.mangaIDListForShow = self:getMangaIDListForShow()

		self:updateBtnList()
		self:updatePanel()

		return
	end, SFX_PANEL)
	onButton(self, self.orderBtn, function()
		self.isUpOrder = not self.isUpOrder
		self.mangaIDListForShow = self:getMangaIDListForShow()

		self:updateBtnList()
		self:updatePanel()

		return
	end, SFX_PANEL)
	onButton(self, self.repairBtn, function()
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
							self.group:StartVerifyForLua()
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

function MangaView:updateMangaTpl(arg_14_1, arg_14_2)
	local var_14_0 = tf(arg_14_2)

	assert(self.mangaIDListForShow[arg_14_1], "null mangaID")
	setActive(var_14_0:Find("Update"), false)

	local var_14_1 = var_14_0:Find("Content/Mask/Pic")
	local var_14_2 = var_14_0:Find("Content/Bottom/BottomNew")
	local var_14_3 = var_14_0:Find("Content/Bottom/BottomNotRead")
	local var_14_4 = var_14_0:Find("Content/Bottom/BottomNormal")
	local var_14_5 = MangaConst.isMangaEverReadByID(self.mangaIDListForShow[arg_14_1])
	local var_14_6 = MangaConst.isMangaNewByID(self.mangaIDListForShow[arg_14_1])

	setActive(var_14_0:Find("Content/Bottom/BottomTip"), false)
	setActive(var_14_2, not var_14_5)
	setActive(var_14_3, false)
	setActive(var_14_4, var_14_5)
	setActive(var_14_0:Find("TopSpecial"), not var_14_5)
	setText(var_14_2:Find("NumText"), "#" .. pg.cartoon[self.mangaIDListForShow[arg_14_1]].cartoon_id)
	setText(var_14_3:Find("NumText"), "#" .. pg.cartoon[self.mangaIDListForShow[arg_14_1]].cartoon_id)
	setText(var_14_4:Find("NumText"), "#" .. pg.cartoon[self.mangaIDListForShow[arg_14_1]].cartoon_id)
	removeOnButton(var_14_0)
	onButton(self, var_14_0, function()
		self:openMangaViewLayer(arg_14_1)

		return
	end, SFX_PANEL)

	local var_14_7 = GetComponent(var_14_1, "Image").sprite

	if not IsNil(var_14_7) then
		if var_14_7.name ~= pg.cartoon[self.mangaIDListForShow[arg_14_1]].resource then
			self.resLoader:LoadSprite(MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[self.mangaIDListForShow[arg_14_1]].resource, pg.cartoon[self.mangaIDListForShow[arg_14_1]].resource, var_14_1, false)
		end
	else
		self.resLoader:LoadSprite(MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[self.mangaIDListForShow[arg_14_1]].resource, pg.cartoon[self.mangaIDListForShow[arg_14_1]].resource, var_14_1, false)
	end

	return
end

function MangaView:initEmpty(arg_16_1)
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
		if checkABExist(MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[iter_16_1].resource) then
			var_16_6 = pg.cartoon[iter_16_1].resource

			break
		end
	end

	self.resLoader:LoadSprite(nil, var_16_6, var_16_0:Find("Content/Mask/Pic"), false)
	setText(var_16_1:Find("Text"), "")
	onButton(self, var_16_3, function()
		if self.group.state == DownloadState.None or self.group.state == DownloadState.CheckFailure then
			self.group:CheckD()
		elseif self.group.state ~= DownloadState.CheckToUpdate then
			if self.group.state == DownloadState.UpdateFailure then
				local var_17_0 = {
					type = MSGBOX_TYPE_NORMAL
				}

				var_17_0.content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.GetGroupSize(MangaView.MangaGroupName))))))

				function var_17_0.onYes()
					self.group:UpdateD()

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox(var_17_0)
			end
		end

		return
	end, SFX_PANEL)
	self:startUpdateEmpty(arg_16_1)

	return
end

function MangaView:updateEmpty(arg_19_1)
	local var_19_0 = tf(arg_19_1):Find("Update")
	local var_19_1 = var_19_0:Find("Btn")
	local var_19_2 = var_19_1:Find("Text")
	local var_19_3 = var_19_0:Find("Progress")

	if self.group.state == DownloadState.None then
		setText(var_19_2, "None")
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif self.group.state == DownloadState.Checking then
		setText(var_19_2, i18n("word_manga_checking"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif self.group.state == DownloadState.CheckToUpdate then
		setText(var_19_2, i18n("word_manga_checktoupdate"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif self.group.state == DownloadState.CheckOver then
		setText(var_19_2, "Latest Ver")
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif self.group.state == DownloadState.CheckFailure then
		setText(var_19_2, i18n("word_manga_checkfailure"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	elseif self.group.state == DownloadState.Updating then
		setText(var_19_2, i18n("word_manga_updating", self.group.downloadCount, self.group.downloadTotal))
		setActive(var_19_1, false)
		setActive(var_19_3, true)
		setSlider(var_19_3:Find("Slider"), 0, self.group.downloadTotal, self.group.downloadCount)
	elseif self.group.state == DownloadState.UpdateSuccess then
		setText(var_19_2, i18n("word_manga_updatesuccess"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)

		self.mangaIDListForShow = self:getMangaIDListForShow()

		self:updatePanel()
	elseif self.group.state == DownloadState.UpdateFailure then
		setText(var_19_2, i18n("word_manga_updatefailure"))
		setActive(var_19_1, true)
		setActive(var_19_3, false)
	end

	return
end

function MangaView:startUpdateEmpty(arg_20_1)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		self:updateEmpty(arg_20_1)

		return
	end, 0.5, -1)

	self.timer:Start()
	self:updateEmpty(arg_20_1)

	return
end

function MangaView:stopUpdateEmpty(arg_22_1)
	if self.timer then
		self.timer:Stop()
	end

	return
end

function MangaView:updateMangaList()
	self.resLoader:Clear()

	function self.lScrollRectSC.onReturnItem(arg_24_0, arg_24_1)
		arg_24_0 = arg_24_0 + 1

		if self.mangaIDListForShow[arg_24_0] == false then
			self:stopUpdateEmpty(arg_24_1)
		end

		return
	end

	function self.lScrollRectSC.onUpdateItem(arg_25_0, arg_25_1)
		arg_25_0 = arg_25_0 + 1

		if self.mangaIDListForShow[arg_25_0] == false then
			self:initEmpty(arg_25_1)
			self:updateEmpty(arg_25_1)
		else
			self:updateMangaTpl(arg_25_0, arg_25_1)
		end

		return
	end

	self.lScrollRectSC:SetTotalCount(#self.mangaIDListForShow)

	return
end

function MangaView:initDownloadBtnPanel()
	local var_26_0 = self.downloadBtnPanel:Find("Btn")
	local var_26_1 = var_26_0:Find("Text")
	local var_26_2 = self.downloadBtnPanel:Find("Progress")
	local var_26_3 = var_26_2:Find("Slider")

	setActive(var_26_0, true)
	setActive(var_26_2, false)
	onButton(self, var_26_0, function()
		if self.group.state == DownloadState.None or self.group.state == DownloadState.CheckFailure then
			self.group:CheckD()
		elseif self.group.state ~= DownloadState.CheckToUpdate then
			if self.group.state == DownloadState.UpdateFailure then
				local var_27_0 = {
					type = MSGBOX_TYPE_NORMAL
				}

				var_27_0.content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.GetGroupSize(MangaView.MangaGroupName))))))

				function var_27_0.onYes()
					self.group:UpdateD()

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox(var_27_0)
			end
		end

		return
	end, SFX_PANEL)
	self:startUpdateDownloadBtnPanel()

	return
end

function MangaView:updateDownloadBtnPanel()
	local var_29_0 = self.downloadBtnPanel:Find("Btn")
	local var_29_1 = var_29_0:Find("Text")
	local var_29_2 = self.downloadBtnPanel:Find("Progress")

	if self.group.state == DownloadState.None then
		setText(var_29_1, "None")
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif self.group.state == DownloadState.Checking then
		setText(var_29_1, i18n("word_manga_checking"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif self.group.state == DownloadState.CheckToUpdate then
		setText(var_29_1, i18n("word_manga_checktoupdate"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif self.group.state == DownloadState.CheckOver then
		setText(var_29_1, "Latest Ver")
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif self.group.state == DownloadState.CheckFailure then
		setText(var_29_1, i18n("word_manga_checkfailure"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	elseif self.group.state == DownloadState.Updating then
		setText(var_29_1, i18n("word_manga_updating", self.group.downloadCount, self.group.downloadTotal))
		setActive(var_29_0, false)
		setActive(var_29_2, true)
		setSlider(var_29_2:Find("Slider"), 0, self.group.downloadTotal, self.group.downloadCount)
	elseif self.group.state == DownloadState.UpdateSuccess then
		setText(var_29_1, i18n("word_manga_updatesuccess"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)

		self.mangaIDListForShow = self:getMangaIDListForShow()

		self:updatePanel()
	elseif self.group.state == DownloadState.UpdateFailure then
		setText(var_29_1, i18n("word_manga_updatefailure"))
		setActive(var_29_0, true)
		setActive(var_29_2, false)
	end

	return
end

function MangaView:startUpdateDownloadBtnPanel()
	if self.timer then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		self:updateDownloadBtnPanel()

		return
	end, 0.5, -1)

	self.timer:Start()
	self:updateDownloadBtnPanel()

	return
end

function MangaView:stopUpdateDownloadBtnPanel()
	if self.timer then
		self.timer:Stop()
	end

	return
end

function MangaView:updatePanel()
	local var_33_0 = #self.mangaIDListForShow <= 0
	local var_33_1 = #self.mangaIDListForShow == 1 and self.mangaIDListForShow[1] == false

	setActive(self.emptyPanel, #self.mangaIDListForShow <= 0)
	setActive(self.downloadBtnPanel, var_33_1)
	setActive(self.scrollView, not var_33_0 and not var_33_1)
	self:stopUpdateEmpty()
	self:stopUpdateDownloadBtnPanel()

	if not var_33_0 and not var_33_1 then
		self:updateMangaList()
	elseif var_33_1 then
		self:initDownloadBtnPanel()
	end

	return
end

function MangaView:updateBtnList()
	setActive(self.likeFilteBtn:Find("On"), self.isShowLike)
	setActive(self.readFilteBtn:Find("ShowingAll"), not self.isShowNotRead)
	setActive(self.readFilteBtn:Find("ShowingNotRead"), self.isShowNotRead)
	setActive(self.orderBtn:Find("Up"), self.isUpOrder)
	setActive(self.orderBtn:Find("Down"), not self.isUpOrder)

	return
end

function MangaView:tryShowTipMsgBox()
	if self.appreciateProxy:isMangaHaveNewRes() then
		local function var_35_0()
			PlayerPrefs.SetInt("mangaVersion", MangaConst.Version)
			self:emit(CollectionScene.UPDATE_RED_POINT)

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			hideClose = true,
			content = i18n("res_cartoon_new_tip", MangaConst.NewCount),
			onYes = var_35_0,
			onCancel = var_35_0,
			onClose = var_35_0
		})
	end

	return
end

function MangaView:openMangaViewLayer(arg_37_1)
	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = MangaFullScreenMediator,
		viewComponent = MangaFullScreenLayer,
		data = {
			mangaIndex = arg_37_1,
			mangaIDLIst = self.mangaIDListForShow,
			mangaContext = self,
			isShowingNotRead = isActive(self.readFilteBtn:Find("ShowingNotRead"))
		},
		onRemoved = function()
			return
		end
	}))

	return
end

function MangaView:updateLineAfterRead(arg_39_1)
	local var_39_0 = self.mangaContainer:Find(tostring(table.indexof(self.mangaIDListForShow, arg_39_1) - 1))

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

function MangaView:updateToMangaID(arg_40_1)
	self.lScrollRectSC:SetTotalCount(#self.mangaIDListForShow, defaultValue(self.lScrollRectSC:HeadIndexToValue(table.indexof(self.mangaIDListForShow, arg_40_1) - 1), -1))

	return
end

function MangaView:getMangaIDListForShow(arg_41_1)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(pg.cartoon.all) do
		if self:isMangaExist(iter_41_1) then
			local var_41_1 = MangaConst.isMangaEverReadByID(iter_41_1)
			local var_41_2 = MangaConst.isMangaLikeByID(iter_41_1)

			if self.isShowNotRead and self.isShowLike then
				if not var_41_1 and var_41_2 then
					table.insert(var_41_0, iter_41_1)
				end
			elseif self.isShowNotRead and not self.isShowLike then
				if not var_41_1 then
					table.insert(var_41_0, iter_41_1)
				end
			elseif not self.isShowNotRead and self.isShowLike then
				if var_41_2 then
					table.insert(var_41_0, iter_41_1)
				end
			else
				table.insert(var_41_0, iter_41_1)
			end
		end
	end

	table.sort(var_41_0, function(arg_42_0, arg_42_1)
		if pg.cartoon[arg_42_1].cartoon_id < pg.cartoon[arg_42_0].cartoon_id then
			return not self.isUpOrder
		elseif pg.cartoon[arg_42_0].cartoon_id == pg.cartoon[arg_42_1].cartoon_id then
			return arg_42_0 < arg_42_1
		elseif pg.cartoon[arg_42_0].cartoon_id < pg.cartoon[arg_42_1].cartoon_id then
			return self.isUpOrder
		end

		return
	end)

	if self:isNeedShowDownBtn() then
		table.insert(var_41_0, 1, false)
	end

	return var_41_0
end

function MangaView:isMangaExist(arg_43_1)
	local var_43_0 = self.group:CheckF(MangaConst.MANGA_PATH_PREFIX .. arg_43_1)

	return var_43_0 == DownloadState.None or var_43_0 == DownloadState.UpdateSuccess
end

function MangaView:isNeedShowDownBtn()
	if Application.isEditor then
		return false
	end

	if GroupHelper.IsGroupVerLastest(MangaView.MangaGroupName) then
		return false
	end

	if not GroupHelper.IsGroupWaitToUpdate(MangaView.MangaGroupName) then
		return false
	end

	return true
end

return MangaView
