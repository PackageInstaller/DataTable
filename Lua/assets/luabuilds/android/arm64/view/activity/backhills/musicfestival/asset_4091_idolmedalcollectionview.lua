local IdolMedalCollectionView = class("IdolMedalCollectionView", import("view.base.BaseUI"))

IdolMedalCollectionView.FADE_OUT_TIME = 1
IdolMedalCollectionView.PAGE_NUM = 5
IdolMedalCollectionView.MEDAL_NUM_PER_PAGE = 3

function IdolMedalCollectionView:getUIName()
	return "IdolMedalCollectionUI"
end

function IdolMedalCollectionView:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function IdolMedalCollectionView:didEnter()
	self:checkAward()
	setText(self.progressText, setColorStr(tostring(#self.activeIDList), COLOR_RED) .. "/" .. #self.allIDList)
	triggerToggle(self.switchBtnList[1], true)

	return
end

function IdolMedalCollectionView:willExit()
	return
end

function IdolMedalCollectionView:initData()
	self.activityProxy = getProxy(ActivityProxy)
	self.activityData = self.activityProxy:getActivityById(ActivityConst.IDOL_MEDAL_COLLECTION)
	self.allIDList = self.activityData:GetPicturePuzzleIds()
	self.pageIDList = {}

	for iter_5_0 = 1, IdolMedalCollectionView.PAGE_NUM do
		self.pageIDList[iter_5_0] = {}

		for iter_5_1 = 1, IdolMedalCollectionView.MEDAL_NUM_PER_PAGE do
			self.pageIDList[iter_5_0][iter_5_1] = self.allIDList[(iter_5_0 - 1) * IdolMedalCollectionView.MEDAL_NUM_PER_PAGE + iter_5_1]
		end
	end

	self.activatableIDList = self.activityData.data1_list
	self.activeIDList = self.activityData.data2_list
	self.curPage = nil
	self.newMedalID = nil

	return
end

function IdolMedalCollectionView:findUI()
	self.bg = self._tf:Find("BG")

	local var_6_0 = self._tf:Find("NotchAdapt")

	self.backBtn = var_6_0:Find("BackBtn")
	self.progressText = var_6_0:Find("ProgressImg/ProgressText")
	self.helpBtn = var_6_0:Find("HelpBtn")

	local var_6_1 = self._tf:Find("MedalContainer")

	self.medalItemList = {}
	self.medalItemList[1] = var_6_1:Find("Medal1")
	self.medalItemList[2] = var_6_1:Find("Medal2")
	self.medalItemList[3] = var_6_1:Find("Medal3")

	local var_6_2 = var_6_0:Find("SwitchBtnList")

	self.switchBtnList = {}

	for iter_6_0 = 1, 5 do
		self.switchBtnList[iter_6_0] = var_6_2:Find("Button" .. iter_6_0)
	end

	return
end

function IdolMedalCollectionView:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_collection.tip
		})

		return
	end, SFX_PANEL)

	for iter_7_0, iter_7_1 in ipairs(self.switchBtnList) do
		onToggle(self, iter_7_1, function(arg_10_0)
			if arg_10_0 == true then
				self.curPage = iter_7_0

				self:updateSwitchBtnTF()
				self:updateMedalContainerView(iter_7_0)
			end

			return
		end, SFX_PANEL)
	end

	addSlip(SLIP_TYPE_HRZ, self.bg, function()
		if self.curPage > 1 then
			triggerToggle(self.switchBtnList[self.curPage - 1], true)
		else
			return
		end

		return
	end, function()
		if self.curPage < IdolMedalCollectionView.PAGE_NUM then
			triggerToggle(self.switchBtnList[self.curPage + 1], true)
		else
			return
		end

		return
	end)

	return
end

function IdolMedalCollectionView:updateMedalContainerView(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self.pageIDList[arg_13_1]) do
		self:updateMedalView(self.pageIDList[arg_13_1], iter_13_1)
	end

	return
end

function IdolMedalCollectionView:updateMedalView(arg_14_1, arg_14_2)
	local var_14_0 = table.contains(self.activeIDList, arg_14_2)
	local var_14_1 = table.contains(self.activatableIDList, arg_14_2) and not var_14_0
	local var_14_2 = not var_14_0 and not var_14_1
	local var_14_3 = self.medalItemList[table.indexof(arg_14_1, arg_14_2, 1)]
	local var_14_4 = var_14_3:Find("Active")
	local var_14_5 = var_14_3:Find("Activable")
	local var_14_6 = var_14_3:Find("DisActive")

	setActive(var_14_4, var_14_0)
	setActive(var_14_5, var_14_1)
	setActive(var_14_6, var_14_2)

	if var_14_4 then
		setImageSprite(var_14_4, GetSpriteFromAtlas("ui/musicfestivalmedalcollectionui_atlas", tostring(arg_14_2)))
	end

	if var_14_1 then
		onButton(self, var_14_5, function()
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = arg_14_2,
				actId = ActivityConst.IDOL_MEDAL_COLLECTION
			})

			return
		end, SFX_PANEL)
	end

	if var_14_2 then
		setText(var_14_6, self.activityData:getConfig("config_client").unlock_desc[table.indexof(self.allIDList, arg_14_2, 1)])
	end

	return
end

function IdolMedalCollectionView:updateSwitchBtnTF()
	for iter_16_0, iter_16_1 in ipairs(self.switchBtnList) do
		local var_16_0 = iter_16_1:Find("Tip")
		local var_16_1 = var_16_0:Find("Text")
		local var_16_2 = self:caculateActivatable(iter_16_0)

		if var_16_2 == 0 or iter_16_0 == self.curPage then
			setActive(var_16_0, false)
		end

		if var_16_2 > 0 and iter_16_0 ~= self.curPage then
			setActive(var_16_0, true)
			setText(var_16_1, var_16_2)
		end
	end

	return
end

function IdolMedalCollectionView:updateAfterSubmit(arg_17_1)
	self.activityProxy = getProxy(ActivityProxy)
	self.activityData = self.activityProxy:getActivityById(ActivityConst.IDOL_MEDAL_COLLECTION)
	self.activatableIDList = self.activityData.data1_list
	self.activeIDList = self.activityData.data2_list
	self.newMedalID = arg_17_1

	triggerToggle(self.switchBtnList[self.curPage], true)
	setText(self.progressText, setColorStr(tostring(#self.activeIDList), COLOR_RED) .. "/" .. #self.allIDList)
	self:checkAward()

	return
end

function IdolMedalCollectionView:UpdateActivity()
	return
end

function IdolMedalCollectionView:caculateActivatable(arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(self.pageIDList[arg_19_1]) do
		if not table.contains(self.activeIDList, iter_19_1) and table.contains(self.activatableIDList, iter_19_1) then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function IdolMedalCollectionView:checkAward()
	if #self.activeIDList == #self.allIDList and self.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.IDOL_MEDAL_COLLECTION
		})
	end

	return
end

return IdolMedalCollectionView
