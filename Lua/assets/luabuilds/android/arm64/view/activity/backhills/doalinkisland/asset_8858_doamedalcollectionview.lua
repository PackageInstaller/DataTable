local DoaMedalCollectionView = class("DoaMedalCollectionView", import("view.base.BaseUI"))

DoaMedalCollectionView.FADE_OUT_TIME = 1
DoaMedalCollectionView.PAGE_NUM = 7
DoaMedalCollectionView.MEDAL_NUM_PER_PAGE = 2

function DoaMedalCollectionView:getUIName()
	return "DoaMedalCollectionUI"
end

function DoaMedalCollectionView:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function DoaMedalCollectionView:didEnter()
	self:checkAward()
	setText(self.progressText, setColorStr(tostring(#self.activeIDList), COLOR_WHITE) .. "/" .. #self.allIDList)
	triggerToggle(self.switchBtnList[1], true)

	return
end

function DoaMedalCollectionView:willExit()
	if LeanTween.isTweening(go(self.picture)) then
		LeanTween.cancel(go(self.picture), false)
	end

	return
end

function DoaMedalCollectionView:getBGM()
	return math.random() > 0.5 and "doa_main_day" or "doa_main_night"
end

function DoaMedalCollectionView:initData()
	self.activityProxy = getProxy(ActivityProxy)
	self.activityData = self.activityProxy:getActivityById(ActivityConst.DOA_MEDAL_ACT_ID)
	self.allIDList = self.activityData:GetPicturePuzzleIds()

	print(#self.allIDList)

	self.pageIDList = {}

	for iter_6_0 = 1, DoaMedalCollectionView.PAGE_NUM do
		self.pageIDList[iter_6_0] = {}

		for iter_6_1 = 1, DoaMedalCollectionView.MEDAL_NUM_PER_PAGE do
			self.pageIDList[iter_6_0][iter_6_1] = self.allIDList[(iter_6_0 - 1) * DoaMedalCollectionView.MEDAL_NUM_PER_PAGE + iter_6_1]
		end
	end

	self.activatableIDList = self.activityData.data1_list
	self.activeIDList = self.activityData.data2_list
	self.curPage = nil
	self.newMedalID = nil

	return
end

function DoaMedalCollectionView:findUI()
	self.bg = self._tf:Find("BG")

	local var_7_0 = self._tf:Find("NotchAdapt")

	self.backBtn = var_7_0:Find("BackBtn")
	self.progressText = var_7_0:Find("ProgressImg/ProgressText")
	self.helpBtn = var_7_0:Find("HelpBtn")

	local var_7_1 = self._tf:Find("SwitchBtnList")

	self.tplButtom = findTF(var_7_1, "tplButtom")
	self.imgGot = var_7_0:Find("ProgressImg/got")
	self.switchBtnList = {}
	self.medalTfList = {}

	for iter_7_0 = 1, DoaMedalCollectionView.PAGE_NUM do
		local var_7_2 = tf(instantiate(go(self.tplButtom)))

		LoadSpriteAtlasAsync("ui/doamedalcollectionui_atlas", "ship" .. iter_7_0 .. "Icon", function(arg_8_0)
			if var_7_2 then
				setImageSprite(findTF(var_7_2, "icon"), arg_8_0, true)
			end

			return
		end)
		LoadSpriteAtlasAsync("ui/doamedalcollectionui_atlas", "ship" .. iter_7_0 .. "Name", function(arg_9_0)
			if var_7_2 then
				setImageSprite(findTF(var_7_2, "name"), arg_9_0, true)
			end

			return
		end)
		LoadSpriteAtlasAsync("ui/doamedalcollectionui_atlas", "ship" .. iter_7_0 .. "NameSelect", function(arg_10_0)
			if var_7_2 then
				setImageSprite(findTF(var_7_2, "nameSelect"), arg_10_0, true)
			end

			return
		end)
		setParent(var_7_2, var_7_1)
		setActive(var_7_2, true)
		table.insert(self.switchBtnList, var_7_2)

		for iter_7_1 = 1, DoaMedalCollectionView.MEDAL_NUM_PER_PAGE do
			local var_7_3 = findTF(self._tf, "MedalContainer/medal" .. (iter_7_0 - 1) * DoaMedalCollectionView.MEDAL_NUM_PER_PAGE + iter_7_1)

			setActive(var_7_3, false)
			GetComponent(findTF(var_7_3, "disAcive/lock"), typeof(Image)):SetNativeSize()
			GetComponent(findTF(var_7_3, "disAcive/unlock"), typeof(Image)):SetNativeSize()
			table.insert(self.medalTfList, var_7_3)
		end
	end

	self.picture = findTF(self._tf, "picture")
	self.pictureName = findTF(self._tf, "picture/name")
	self.leftPage = findTF(self._tf, "book/leftPage")
	self.rightPage = findTF(self._tf, "book/rightPage")

	return
end

function DoaMedalCollectionView:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.doa_collection.tip
		})

		return
	end, SFX_PANEL)

	for iter_11_0, iter_11_1 in ipairs(self.switchBtnList) do
		onToggle(self, iter_11_1, function(arg_14_0)
			if arg_14_0 == true then
				local var_14_0 = self.curPage ~= iter_11_0

				self.curPage = iter_11_0

				self:updateSwitchBtnTF()
				self:updateMedalContainerView(iter_11_0, var_14_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function DoaMedalCollectionView:UpdateActivity(arg_15_1)
	self:checkAward()

	return
end

function DoaMedalCollectionView:updateMedalContainerView(arg_16_1, arg_16_2)
	local var_16_0 = self.pageIDList[arg_16_1]

	if arg_16_2 then
		setActive(self.picture, false)
		LoadSpriteAtlasAsync("ui/doamedalcollectionui_atlas", "pictureImage" .. arg_16_1, function(arg_17_0)
			setImageSprite(self.picture, arg_17_0, true)

			if LeanTween.isTweening(go(self.picture)) then
				LeanTween.cancel(go(self.picture), false)
			end

			LeanTween.value(go(self.picture), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_18_0)
				GetComponent(self.picture, typeof(CanvasGroup)).alpha = arg_18_0

				return
			end))
			setActive(self.picture, true)

			return
		end)
	else
		setActive(self.picture, true)
		LoadSpriteAtlasAsync("ui/doamedalcollectionui_atlas", "pictureImage" .. arg_16_1, function(arg_19_0)
			setImageSprite(self.picture, arg_19_0, true)

			return
		end)
	end

	LoadSpriteAtlasAsync("ui/doamedalcollectionui_atlas", "pictureName" .. arg_16_1, function(arg_20_0)
		setImageSprite(self.pictureName, arg_20_0, true)

		return
	end)

	for iter_16_0 = 1, #self.medalTfList do
		if (arg_16_1 - 1) * DoaMedalCollectionView.MEDAL_NUM_PER_PAGE < iter_16_0 and iter_16_0 <= (arg_16_1 - 1) * DoaMedalCollectionView.MEDAL_NUM_PER_PAGE + DoaMedalCollectionView.MEDAL_NUM_PER_PAGE then
			setActive(self.medalTfList[iter_16_0], true)
		else
			setActive(self.medalTfList[iter_16_0], false)
		end
	end

	for iter_16_1, iter_16_2 in ipairs(var_16_0) do
		self:updateMedalView(var_16_0, iter_16_2)
	end

	return
end

function DoaMedalCollectionView:updateMedalView(arg_21_1, arg_21_2)
	local var_21_0 = table.contains(self.activeIDList, arg_21_2)
	local var_21_1 = table.contains(self.activatableIDList, arg_21_2) and not var_21_0
	local var_21_3 = self.medalTfList[(self.curPage - 1) * DoaMedalCollectionView.MEDAL_NUM_PER_PAGE + table.indexof(arg_21_1, arg_21_2, 1)]

	if var_21_0 then
		setActive(findTF(var_21_3, "isActive"), true)
		setActive(findTF(var_21_3, "disAcive"), false)
	else
		setActive(findTF(var_21_3, "isActive"), false)
		setActive(findTF(var_21_3, "disAcive"), true)

		if var_21_1 then
			onButton(self, findTF(var_21_3, "disAcive"), function()
				pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
					id = arg_21_2,
					actId = self.activityData.id
				})

				return
			end, SFX_PANEL)
			setActive(findTF(var_21_3, "disAcive/lock"), false)
			setActive(findTF(var_21_3, "disAcive/unlock"), true)
		else
			setActive(findTF(var_21_3, "disAcive/lock"), true)
			setActive(findTF(var_21_3, "disAcive/unlock"), false)
		end
	end

	return
end

function DoaMedalCollectionView:updateSwitchBtnTF()
	setText(self.leftPage, (self.curPage - 1) * DoaMedalCollectionView.MEDAL_NUM_PER_PAGE + 1)
	setText(self.rightPage, (self.curPage - 1) * DoaMedalCollectionView.MEDAL_NUM_PER_PAGE + 2)

	for iter_23_0, iter_23_1 in ipairs(self.switchBtnList) do
		local var_23_0 = iter_23_1:Find("Tip")
		local var_23_1 = self:caculateActivatable(iter_23_0)

		if var_23_1 == 0 or iter_23_0 == self.curPage then
			setActive(var_23_0, false)
		end

		if var_23_1 > 0 and iter_23_0 ~= self.curPage then
			setActive(var_23_0, true)
		end
	end

	return
end

function DoaMedalCollectionView:updateAfterSubmit(arg_24_1)
	self.activityProxy = getProxy(ActivityProxy)
	self.activityData = self.activityProxy:getActivityById(ActivityConst.DOA_MEDAL_ACT_ID)
	self.activatableIDList = self.activityData.data1_list
	self.activeIDList = self.activityData.data2_list
	self.newMedalID = arg_24_1

	triggerToggle(self.switchBtnList[self.curPage], true)
	setText(self.progressText, setColorStr(tostring(#self.activeIDList), COLOR_WHITE) .. "/" .. #self.allIDList)
	self:checkAward()

	return
end

function DoaMedalCollectionView:caculateActivatable(arg_25_1)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(self.pageIDList[arg_25_1]) do
		if not table.contains(self.activeIDList, iter_25_1) and table.contains(self.activatableIDList, iter_25_1) then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function DoaMedalCollectionView:checkAward()
	setActive(self.imgGot, #self.activeIDList == #self.allIDList and self.activityData.data1 == 1)

	if #self.activeIDList == #self.allIDList and self.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.DOA_MEDAL_ACT_ID
		})
		setActive(self.imgGot, true)
	end

	return
end

return DoaMedalCollectionView
