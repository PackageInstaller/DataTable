local IdolMasterMedalCollectionView = class("IdolMasterMedalCollectionView", import("view.base.BaseUI"))

IdolMasterMedalCollectionView.FADE_OUT_TIME = 1
IdolMasterMedalCollectionView.PAGE_NUM = 7
IdolMasterMedalCollectionView.MEDAL_NUM_PER_PAGE = 2
IdolMasterMedalCollectionView.MEDAL_STATUS_UNACTIVATED = 1
IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATED = 2
IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATABLE = 3
IdolMasterMedalCollectionView.INDEX_CONVERT = {
	1,
	2,
	5,
	6,
	7,
	4,
	3
}

function IdolMasterMedalCollectionView:getUIName()
	return "IdolMasterMedalCollectionUI"
end

function IdolMasterMedalCollectionView:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function IdolMasterMedalCollectionView:didEnter()
	self:checkAward()
	setText(self.progressText, setColorStr(tostring(#self.activeIDList), "#8CD5FFFF") .. "/" .. #self.allIDList)
	triggerToggle(self.switchBtnList[1], true)

	return
end

function IdolMasterMedalCollectionView:willExit()
	if LeanTween.isTweening(go(self.photo)) then
		LeanTween.cancel(go(self.photo), false)
	end

	return
end

function IdolMasterMedalCollectionView:initData()
	self.activityProxy = getProxy(ActivityProxy)
	self.activityData = self.activityProxy:getActivityById(ActivityConst.IDOL_MASTER_MEDAL_ID)
	self.allIDList = self.activityData:GetPicturePuzzleIds()
	self.pageIDList = {}

	for iter_5_0 = 1, IdolMasterMedalCollectionView.PAGE_NUM do
		self.pageIDList[iter_5_0] = {}

		for iter_5_1 = 1, IdolMasterMedalCollectionView.MEDAL_NUM_PER_PAGE do
			self.pageIDList[iter_5_0][iter_5_1] = self.allIDList[(IdolMasterMedalCollectionView.INDEX_CONVERT[iter_5_0] - 1) * IdolMasterMedalCollectionView.MEDAL_NUM_PER_PAGE + iter_5_1]
		end
	end

	self.activatableIDList = self.activityData.data1_list
	self.activeIDList = self.activityData.data2_list
	self.curPage = nil
	self.newMedalID = nil

	return
end

function IdolMasterMedalCollectionView:findUI()
	self.bg = self._tf:Find("BG")

	local var_6_0 = self._tf:Find("NotchAdapt")

	self.backBtn = var_6_0:Find("BackBtn")
	self.progressText = var_6_0:Find("ProgressImg/ProgressText")
	self.helpBtn = var_6_0:Find("HelpBtn")

	local var_6_1 = self._tf:Find("SwitchBtnList")

	self.tplButtom = findTF(var_6_1, "tplButtom")
	self.imgGot = var_6_0:Find("ProgressImg/got")
	self.switchBtnList = {}

	for iter_6_0 = 1, IdolMasterMedalCollectionView.PAGE_NUM do
		local var_6_2 = tf(instantiate(go(self.tplButtom)))

		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "icon" .. iter_6_0, function(arg_7_0)
			if var_6_2 then
				setImageSprite(findTF(var_6_2, "icon"), arg_7_0, true)
			end

			return
		end)
		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "iconSelect" .. iter_6_0, function(arg_8_0)
			if var_6_2 then
				setImageSprite(findTF(var_6_2, "iconSelect"), arg_8_0, true)
			end

			return
		end)
		setParent(var_6_2, var_6_1)
		setActive(var_6_2, true)
		table.insert(self.switchBtnList, var_6_2)
	end

	self.infoNode = self._tf:Find("book/info")
	self.photoNode = self._tf:Find("book/photo")
	self.photo = self.photoNode:Find("got")

	return
end

function IdolMasterMedalCollectionView:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.idolmaster_collection.tip
		})

		return
	end, SFX_PANEL)

	for iter_9_0, iter_9_1 in ipairs(self.switchBtnList) do
		onToggle(self, iter_9_1, function(arg_12_0)
			if arg_12_0 == true then
				local var_12_0 = self.curPage ~= iter_9_0

				self.curPage = iter_9_0

				self:updateSwitchBtnTF()
				self:updateMedalContainerView(iter_9_0, var_12_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function IdolMasterMedalCollectionView:UpdateActivity(arg_13_1)
	self:checkAward()

	return
end

function IdolMasterMedalCollectionView:updateMedalContainerView(arg_14_1, arg_14_2)
	self:updatePhotoNode(self.pageIDList[arg_14_1][1], arg_14_2)
	self:updateInfoNode(self.pageIDList[arg_14_1][2])

	return
end

function IdolMasterMedalCollectionView:getMedalStatus(arg_15_1)
	local var_15_0 = table.contains(self.activeIDList, arg_15_1)
	local var_15_1 = table.contains(self.activatableIDList, arg_15_1) and not var_15_0
	local var_15_2 = not var_15_0 and not var_15_1

	if var_15_0 then
		return IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATED
	elseif var_15_1 then
		return IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATABLE
	elseif var_15_2 then
		return IdolMasterMedalCollectionView.MEDAL_STATUS_UNACTIVATED
	end

	return
end

function IdolMasterMedalCollectionView:updatePhotoNode(arg_16_1, arg_16_2)
	local var_16_0 = self.photoNode:Find("task")
	local var_16_1 = self.photoNode:Find("get")
	local var_16_2 = self.photoNode:Find("got")
	local var_16_3 = self:getMedalStatus(arg_16_1)

	if var_16_3 == IdolMasterMedalCollectionView.MEDAL_STATUS_UNACTIVATED then
		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "task" .. (self.curPage - 1) * IdolMasterMedalCollectionView.MEDAL_NUM_PER_PAGE + 1, function(arg_17_0)
			setImageSprite(var_16_0, arg_17_0, true)
			setActive(var_16_0, true)

			return
		end)
	else
		setActive(var_16_0, false)
	end

	if var_16_3 == IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATED then
		if arg_16_2 then
			setActive(self.photo, false)
			LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "photo" .. self.curPage, function(arg_18_0)
				setImageSprite(self.photo, arg_18_0, true)

				if LeanTween.isTweening(go(self.photo)) then
					LeanTween.cancel(go(self.photo), false)
				end

				GetComponent(self.photo, typeof(CanvasGroup)).alpha = 0

				LeanTween.value(go(self.photo), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_19_0)
					GetComponent(self.photo, typeof(CanvasGroup)).alpha = arg_19_0

					return
				end))
				setActive(self.photo, true)

				return
			end)
		else
			LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "photo" .. self.curPage, function(arg_20_0)
				setImageSprite(self.photo, arg_20_0, true)
				setActive(self.photo, true)

				return
			end)
		end
	else
		setActive(self.photo, false)
	end

	setActive(var_16_1, var_16_3 == IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATABLE)

	if var_16_3 == IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATABLE then
		onButton(self, self.photoNode, function()
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = arg_16_1,
				actId = self.activityData.id
			})

			return
		end, SFX_PANEL)
	end

	return
end

function IdolMasterMedalCollectionView:updateInfoNode(arg_22_1)
	local var_22_0 = self.infoNode:Find("task")
	local var_22_1 = self.infoNode:Find("get")
	local var_22_2 = self.infoNode:Find("got")
	local var_22_3 = self:getMedalStatus(arg_22_1)

	if var_22_3 == IdolMasterMedalCollectionView.MEDAL_STATUS_UNACTIVATED then
		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "task" .. (self.curPage - 1) * IdolMasterMedalCollectionView.MEDAL_NUM_PER_PAGE + 2, function(arg_23_0)
			setImageSprite(var_22_0, arg_23_0, true)
			setActive(var_22_0, true)

			return
		end)
	else
		setActive(var_22_0, false)
	end

	if var_22_3 == IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATED then
		LoadSpriteAtlasAsync("ui/idolmastermedalcollectionui_atlas", "info" .. self.curPage, function(arg_24_0)
			setImageSprite(var_22_2, arg_24_0, true)
			setActive(var_22_2, true)

			return
		end)
	else
		setActive(var_22_2, false)
	end

	setActive(var_22_1, var_22_3 == IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATABLE)

	if var_22_3 == IdolMasterMedalCollectionView.MEDAL_STATUS_ACTIVATABLE then
		onButton(self, self.infoNode, function()
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = arg_22_1,
				actId = self.activityData.id
			})

			return
		end, SFX_PANEL)
	end

	return
end

function IdolMasterMedalCollectionView:updateSwitchBtnTF()
	for iter_26_0, iter_26_1 in ipairs(self.switchBtnList) do
		local var_26_0 = iter_26_1:Find("tip")
		local var_26_1 = self:caculateActivatable(iter_26_0)

		if var_26_1 == 0 or iter_26_0 == self.curPage then
			setActive(var_26_0, false)
		end

		if var_26_1 > 0 and iter_26_0 ~= self.curPage then
			setActive(var_26_0, true)
		end

		local var_26_2 = iter_26_0 == self.curPage

		setActive(iter_26_1:Find("icon"), not (iter_26_0 == self.curPage))
		setActive(iter_26_1:Find("iconSelect"), var_26_2)
	end

	return
end

function IdolMasterMedalCollectionView:updateAfterSubmit(arg_27_1)
	self.activityProxy = getProxy(ActivityProxy)
	self.activityData = self.activityProxy:getActivityById(ActivityConst.IDOL_MASTER_MEDAL_ID)
	self.activatableIDList = self.activityData.data1_list
	self.activeIDList = self.activityData.data2_list
	self.newMedalID = arg_27_1

	triggerToggle(self.switchBtnList[self.curPage], true)
	setText(self.progressText, setColorStr(tostring(#self.activeIDList), COLOR_WHITE) .. "/" .. #self.allIDList)
	self:checkAward()

	return
end

function IdolMasterMedalCollectionView:caculateActivatable(arg_28_1)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(self.pageIDList[arg_28_1]) do
		if not table.contains(self.activeIDList, iter_28_1) and table.contains(self.activatableIDList, iter_28_1) then
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function IdolMasterMedalCollectionView:checkAward()
	setActive(self.imgGot, #self.activeIDList == #self.allIDList and self.activityData.data1 == 1)

	if #self.activeIDList == #self.allIDList and self.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.IDOL_MASTER_MEDAL_ID
		})
		setActive(self.imgGot, true)
	end

	return
end

return IdolMasterMedalCollectionView
