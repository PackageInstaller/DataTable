local SpringCoupletPage = class("SpringCoupletPage", import("...base.BaseActivityPage"))
local var_0_1 = 7
local var_0_2 = 7
local var_0_3 = 7
local var_0_4 = 400
local var_0_5 = 78
local var_0_6 = 1
local var_0_7 = "ui/activityuipage/springcoupletpage_atlas"
local var_0_8 = "couplete_activty_desc"
local var_0_9 = "couplete_click_desc"
local var_0_10 = "couplet_index_desc"
local var_0_12 = "couplete_drag_tip"
local var_0_13 = "couplete_remind"
local var_0_14 = "couplete_complete"
local var_0_15 = "couplete_enter"
local var_0_16 = "couplete_stay"
local var_0_17 = "couplete_task"
local var_0_18 = {
	"couplete_pass_1",
	"couplete_pass_2"
}
local var_0_19 = {
	"couplete_fail_1",
	"couplete_fail_2"
}
local var_0_20 = 20

function SpringCoupletPage:OnInit()
	self.itemTpl = findTF(self._tf, "AD/itemTpl")
	self.iconTpl = findTF(self._tf, "AD/iconTpl")
	self.wordTpl = findTF(self._tf, "AD/wordTpl")
	self.itemContainer = findTF(self._tf, "AD/itemContainer")
	self.taskIcon = findTF(self._tf, "AD/task/icon")
	self.taskSlider = findTF(self._tf, "AD/task/Slider")
	self.taskBtnGet = findTF(self._tf, "AD/task/btnGet")
	self.taskBtnGot = findTF(self._tf, "AD/task/btnGot")
	self.taskBtnGo = findTF(self._tf, "AD/task/btnGo")
	self.taskDesc = findTF(self._tf, "AD/task/desc")
	self.taskCur = findTF(self._tf, "AD/task/cur")
	self.taskMax = findTF(self._tf, "AD/task/max")
	self.finalAward = findTF(self._tf, "AD/finalAward")
	self.charPos = findTF(self._tf, "AD/charPos")
	self.charClick = findTF(self.charPos, "click")
	self.btnConfirm = findTF(self._tf, "AD/btnConfirm")
	self.imgComplete = findTF(self._tf, "AD/imgComplete")
	self.charTip = findTF(self._tf, "AD/charTip")

	setActive(self.charTip, false)

	self.btnHelp = findTF(self._tf, "AD/btnHelp")
	self.remindDesc = findTF(self._tf, "AD/remindDesc")

	setText(self.remindDesc, i18n(var_0_9))

	self.dragTip = findTF(self._tf, "AD/dragTip")

	setText(self.dragTip, i18n(var_0_12))

	self.btnPre = findTF(self._tf, "AD/pre")
	self.btnNext = findTF(self._tf, "AD/next")
	self.activityDesc = findTF(self._tf, "AD/desc")

	setText(self.activityDesc, i18n(var_0_8))

	self.coupletUpImg = GetComponent(findTF(self._tf, "AD/coupletUp/contents/img"), typeof(Image))
	self.coupletUpContents = findTF(self._tf, "AD/coupletUp/contents")
	self.coupletBottomContents = findTF(self._tf, "AD/coupletBottom/contents")
	self.coupletUpLock = findTF(self._tf, "AD/coupletUp/lock")
	self.coupletBottomLock = findTF(self._tf, "AD/coupletBottom/lock")
	self.awardIcon = tf(instantiate(self.iconTpl))
	self.awardIcon.anchoredPosition = Vector2(0, 0)

	setActive(self.awardIcon, true)
	setParent(self.awardIcon, self.taskIcon)

	self.countDesc = findTF(self._tf, "AD/countDesc")
	self.items = {}

	for iter_1_0 = 1, var_0_2 do
		local var_1_0 = tf(instantiate(self.itemTpl))

		setActive(var_1_0, true)
		setParent(var_1_0, self.itemContainer)
		table.insert(self.items, var_1_0)
	end

	self.coupletBottomWords = {}

	for iter_1_1 = 1, var_0_3 do
		local var_1_1 = self:createWord(iter_1_1, self.coupletBottomContents)

		self:addCoupletWordEvent(var_1_1)
		table.insert(self.coupletBottomWords, var_1_1)
	end

	self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 2, -1)

	self.timer:Start()
	onButton(self, self.btnConfirm, function()
		self:finishCouplete()

		return
	end)
	onButton(self, self.btnPre, function()
		self.coupletIndex = self.coupletIndex - 1

		self:selectCoupletChange()

		return
	end)
	onButton(self, self.btnNext, function()
		self.coupletIndex = self.coupletIndex + 1

		self:selectCoupletChange()

		return
	end)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.couplete_help.tip
		})

		return
	end)
	onButton(self, self.charClick, function()
		self.charClickCount = self.charClickCount or 0
		self.charClickCount = self.charClickCount + 1

		if self.charClickCount % 3 == 0 and not self.coupletComplete and self.coupletUnLock then
			self:showTips(i18n(var_0_13, i18n("couplete_pair_" .. self.coupletIndex)), true)
		end

		return
	end)
	onButton(self, self.taskBtnGo, function()
		self:emit(ActivityMediator.ON_TASK_GO, self.taskVO)

		return
	end, SFX_PANEL)
	onButton(self, self.taskBtnGet, function()
		pg.m02:sendNotification(GAME.SUBMIT_TASK, {
			normal_submit = true,
			virtual = false,
			taskId = self.taskVO.id
		})
		self:showTips(i18n(var_0_15), true)

		return
	end, SFX_PANEL)
	PoolMgr.GetInstance():GetSpineChar(Ship.New({
		skin_id = 502010,
		configId = 502011
	}):getPrefab(), true, function(arg_10_0)
		self.model = arg_10_0
		self.model.transform.localScale = Vector3(0.7, 0.7, 0.7)
		self.model.transform.localPosition = Vector3.zero

		self.model.transform:SetParent(findTF(self.charPos, "pos"), false)

		self.anim = self.model:GetComponent(typeof(SpineAnimUI))

		self.anim:SetAction("stand", 0)

		return
	end)

	return
end

function SpringCoupletPage:OnShowFlush()
	self.tipStayIndex = var_0_20

	if self.data1List and self.data2List and #self.data1List ~= #self.data2List then
		self:showTips(i18n(var_0_15))
	elseif self.data1List and self.data2List and #self.data1List == #self.data2List and not self.coupletFinishAll then
		self:showTips(i18n(var_0_17))
	elseif self.coupletFinishAll then
		self:showTips(i18n(var_0_14))
	end

	return
end

function SpringCoupletPage:OnHideFlush()
	setActive(self.charTip, false)

	return
end

function SpringCoupletPage:OnDataSetting()
	if not self.coupletIds then
		self.coupletIds = self.activity:getConfig("config_client").couplet
		self.coupletDatas = {}

		for iter_13_0 = 1, #self.coupletIds do
			table.insert(self.coupletDatas, pg.activity_spring_couplets[self.coupletIds[iter_13_0]])
		end
	end

	self.taskProxy = getProxy(TaskProxy)
	self.taskActivity = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").linkActID)
	self.taskGroup = self.taskActivity:getConfig("config_data")
	self.tipStayIndex = var_0_20

	return updateActivityTaskStatus(self.taskActivity)
end

function SpringCoupletPage:onTimer()
	if self.tipStayIndex and self.tipStayIndex > 0 then
		self.tipStayIndex = self.tipStayIndex - 1
	elseif self.tipStayIndex == 0 then
		self.tipStayIndex = -1

		self:showTips(i18n(var_0_16), true)
	end

	if self.charClickCount and self.charClickCount > 0 then
		self.charClickCount = self.charClickCount - 1
	end

	return
end

function SpringCoupletPage:OnFirstFlush()
	self:updateUI()
	self:finishAll()

	return
end

function SpringCoupletPage:OnUpdateFlush()
	self:updateUI()

	return
end

function SpringCoupletPage:updateUI()
	self.data1 = self.activity.data1
	self.data2 = self.activity.data2
	self.data3 = self.activity.data3
	self.data1List = self.activity.data1_list
	self.data2List = self.activity.data2_list
	self.data3List = self.activity.data3_list
	self.coupletFinishAll = false

	if self.data2List and #self.data2List == #self.coupletIds then
		self.coupletFinishAll = true
	end

	self.coupletIndex = 1

	for iter_17_0 = #self.coupletIds, 1, -1 do
		if table.contains(self.data1List, self.coupletIds[iter_17_0]) and not table.contains(self.data2List, self.coupletIds[iter_17_0]) then
			self.coupletIndex = iter_17_0
		end

		local var_17_0 = table.contains(self.data2List, self.coupletIds[iter_17_0]) or false
		local var_17_1 = table.contains(self.data1List, self.coupletIds[iter_17_0]) or false
		local var_17_2 = self.items[iter_17_0]

		setActive(findTF(self.items[iter_17_0], "got"), var_17_0 or false)
		setActive(findTF(var_17_2, "bgMask"), not var_17_1 or var_17_0 or false)
		setActive(findTF(var_17_2, "red"), var_17_1)
		setActive(findTF(var_17_2, "lock"), not var_17_1 or false)

		if iter_17_0 == 7 then
			setActive(findTF(self.finalAward, "lock"), not var_17_1 or false)
			setActive(findTF(self.finalAward, "mask"), not var_17_1 or var_17_0 or false)
			setActive(findTF(self.finalAward, "got"), self.coupletFinishAll)
		end
	end

	self:selectCoupletChange()
	self:updateCoupletWord()
	self:updateTask()

	return
end

function SpringCoupletPage:finishAll()
	if #self.data2List == #self.coupletIds and #self.data2List == #self.data1List and self.activity.data1 == 0 then
		pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
			cmd = 1,
			actId = self.activity.id
		})
	end

	return
end

function SpringCoupletPage:updateTask()
	self.nday = self.taskActivity.data3

	local var_19_0 = self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])

	self.taskVO = var_19_0

	local var_19_1 = var_19_0:getConfig("award_display")[1]
	local var_19_2 = {
		type = var_19_1[1],
		id = var_19_1[2],
		count = var_19_1[3]
	}

	updateDrop(self.awardIcon, var_19_2)
	onButton(self, self.taskIcon, function()
		self:emit(BaseUI.ON_DROP, var_19_2)

		return
	end, SFX_PANEL)
	setText(self.taskDesc, (var_19_0:getConfig("desc")))

	local var_19_3 = var_19_0:getTaskStatus()

	setActive(self.taskBtnGo, var_19_3 == 0)
	setActive(self.taskBtnGet, var_19_3 == 1)
	setActive(self.taskBtnGot, var_19_3 == 2)

	local var_19_4 = var_19_0:getProgress()
	local var_19_5 = var_19_0:getConfig("target_num")

	setSlider(self.taskSlider, 0, var_19_5, var_19_4)
	setText(self.taskCur, var_19_4)
	setText(self.taskMax, "/" .. var_19_5)

	return
end

function SpringCoupletPage:finishCouplete()
	if self.coupletUnLock and not self.coupletComplete then
		local var_21_0 = self.coupletIds[self.coupletIndex]

		for iter_21_0 = 1, #self.coupletBottomWords do
			local var_21_1 = false

			if self.coupletBottomWords[iter_21_0].index == self.coupletBottomWords[iter_21_0].swapIndex then
				var_21_1 = true
			elseif PLATFORM_CODE == PLATFORM_JP and self.coupletDatas[self.coupletIndex].repeated_jp and #self.coupletDatas[self.coupletIndex].repeated_jp > 0 then
				for iter_21_1 = 1, #self.coupletDatas[self.coupletIndex].repeated_jp do
					if table.contains(self.coupletDatas[self.coupletIndex].repeated_jp[iter_21_1], self.coupletBottomWords[iter_21_0].index) and table.contains(self.coupletDatas[self.coupletIndex].repeated_jp[iter_21_1], self.coupletBottomWords[iter_21_0].swapIndex) then
						var_21_1 = true
					end
				end
			end

			if not var_21_1 then
				self:showTips(var_0_19, true)

				return
			end
		end

		if table.contains(self.data1List, var_21_0) and not table.contains(self.activity.data2_list, var_21_0) then
			local var_21_2

			if #self.activity.data2_list == #self.coupletIds - 1 then
				function var_21_2(arg_22_0)
					self:emit(ActivityMediator.NEXT_DISPLAY_AWARD, arg_22_0)
					self:finishAll()

					return
				end

				self:showTips(i18n(var_0_14), true)
			else
				self:showTips(var_0_18, true)
			end

			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = var_21_0,
				actId = self.activity.id,
				awardCallback = var_21_2
			})
		end
	elseif not self.coupletUnLock then
		-- block empty
	elseif self.coupletComplete then
		-- block empty
	end

	return
end

function SpringCoupletPage:selectCoupletChange()
	if self.coupletIndex > var_0_1 then
		self.coupletIndex = 1
	end

	if self.coupletIndex <= 0 then
		self.coupletIndex = var_0_1
	end

	local var_23_0 = self.coupletIds[self.coupletIndex]

	self.coupletComplete = table.contains(self.data2List, self.coupletIds[self.coupletIndex]) or false
	self.coupletUnLock = table.contains(self.data1List, var_23_0) or false

	if not self.coupletUnLock then
		self.btnConfirm:GetComponent("UIGrayScale").enabled = true
		self.btnConfirm:GetComponent("Image").raycastTarget = false

		setActive(self.imgComplete, false)
		setActive(self.btnConfirm, true)
	elseif self.coupletComplete then
		setActive(self.imgComplete, true)
		setActive(self.btnConfirm, false)
	else
		self.btnConfirm:GetComponent("UIGrayScale").enabled = false
		self.btnConfirm:GetComponent("Image").raycastTarget = true

		setActive(self.imgComplete, false)
		setActive(self.btnConfirm, true)
	end

	self:updateCoupletWord()

	return
end

function SpringCoupletPage:updateCoupletWord()
	setImageSprite(self.coupletUpImg, (GetSpriteFromAtlas(var_0_7, "couplet_" .. self.coupletIndex .. "_list")))
	setActive(self.coupletUpContents, self.coupletUnLock)
	setActive(self.coupletUpLock, not self.coupletUnLock)

	local var_24_0 = {}

	if not self.coupletComplete then
		for iter_24_0 = 1, var_0_3 do
			table.insert(var_24_0, iter_24_0)
		end
	end

	for iter_24_1 = 1, #self.coupletBottomWords do
		local var_24_1 = self.coupletBottomWords[iter_24_1]
		local var_24_2 = #var_24_0 > 0 and table.remove(var_24_0, math.random(1, #var_24_0)) or iter_24_1

		var_24_1.swapIndex = var_24_2
		var_24_1.tf.anchoredPosition = self:getWordPosition(var_24_2)

		setImageSprite(findTF(var_24_1.tf, "img"), GetSpriteFromAtlas(var_0_7, "couplet_" .. self.coupletIndex .. "_" .. var_24_1.index), true)

		local var_24_3 = false

		if var_24_1.index == var_24_1.swapIndex then
			var_24_3 = var_24_1.index == var_24_1.swapIndex
		elseif PLATFORM_CODE == PLATFORM_JP and self.coupletDatas[self.coupletIndex].repeated_jp and #self.coupletDatas[self.coupletIndex].repeated_jp > 0 then
			for iter_24_2 = 1, #self.coupletDatas[self.coupletIndex].repeated_jp do
				if table.contains(self.coupletDatas[self.coupletIndex].repeated_jp[iter_24_2], var_24_1.index) and table.contains(self.coupletDatas[self.coupletIndex].repeated_jp[iter_24_2], var_24_1.swapIndex) then
					var_24_3 = true
				end
			end
		end

		setActive(findTF(var_24_1.tf, "bgOn"), var_24_3)
		GetComponent(findTF(var_24_1.tf, "bgOn"), typeof(Image)):SetNativeSize()
		GetComponent(findTF(var_24_1.tf, "bgOff"), typeof(Image)):SetNativeSize()
	end

	setActive(self.coupletBottomContents, self.coupletUnLock)
	setActive(self.coupletBottomLock, not self.coupletUnLock)
	setText(self.countDesc, i18n(var_0_10, self.coupletIndex))

	return
end

function SpringCoupletPage:addCoupletWordEvent(arg_25_1)
	arg_25_1.event:AddBeginDragFunc(function(arg_26_0, arg_26_1)
		if self.coupletUnLock and not self.coupletComplete and not self.swapWord then
			self.swapWord = arg_25_1
		end

		return
	end)
	arg_25_1.event:AddDragFunc(function(arg_27_0, arg_27_1)
		if self.swapWord then
			arg_27_1.position.y = arg_27_1.position.y

			local var_27_0 = self:getWordByPosition((self._uiCamera:ScreenToWorldPoint(arg_27_1.position)))

			if var_27_0 and self.swapWord ~= var_27_0 then
				var_27_0.swapIndex = self.swapWord.swapIndex
				self.swapWord.swapIndex = var_27_0.swapIndex

				self:tweenWord(self.swapWord)
				self:tweenWord(var_27_0)
			end
		end

		return
	end)
	arg_25_1.event:AddDragEndFunc(function(arg_28_0, arg_28_1)
		self.swapWord = nil

		return
	end)

	return
end

function SpringCoupletPage:createWord(arg_29_1, arg_29_2)
	local var_29_0 = tf(instantiate(self.wordTpl))

	setParent(var_29_0, arg_29_2)
	setActive(var_29_0, true)

	var_29_0.anchoredPosition = self:getWordPosition(arg_29_1)

	return {
		tf = var_29_0,
		index = arg_29_1,
		swapIndex = arg_29_1,
		event = GetComponent(var_29_0, typeof(EventTriggerListener)),
		parent = arg_29_2
	}
end

function SpringCoupletPage:getWordByPosition(arg_30_1)
	local var_30_0 = self.coupletBottomContents:InverseTransformPoint(arg_30_1)

	if math.abs(var_30_0.x) < var_0_4 / 2 then
		local var_30_1 = math.floor(math.abs((var_30_0.y - var_0_5 / 2) / var_0_5)) + 1

		for iter_30_0 = 1, #self.coupletBottomWords do
			if self.coupletBottomWords[iter_30_0].swapIndex == var_30_1 then
				return self.coupletBottomWords[iter_30_0]
			end
		end
	end

	return
end

function SpringCoupletPage:getWordPosition(arg_31_1)
	return Vector2((arg_31_1 - 1) % var_0_6 * var_0_4, -math.floor((arg_31_1 - 1) / var_0_6) * var_0_5)
end

function SpringCoupletPage:tweenWord(arg_32_1)
	if LeanTween.isTweening(go(arg_32_1.tf)) then
		LeanTween.cancel(go(arg_32_1.tf))
	end

	LeanTween.value(go(arg_32_1.tf), arg_32_1.tf.anchoredPosition.y, self:getWordPosition(arg_32_1.swapIndex).y, 0.1):setOnUpdate(System.Action_float(function(arg_33_0)
		arg_32_1.tf.anchoredPosition = Vector2(arg_32_1.tf.anchoredPosition.x, arg_33_0)

		return
	end)):setOnComplete(System.Action(function()
		local var_34_0 = false

		if arg_32_1.index == arg_32_1.swapIndex then
			var_34_0 = arg_32_1.index == arg_32_1.swapIndex
		elseif PLATFORM_CODE == PLATFORM_JP and self.coupletDatas[self.coupletIndex].repeated_jp and #self.coupletDatas[self.coupletIndex].repeated_jp > 0 then
			for iter_34_0 = 1, #self.coupletDatas[self.coupletIndex].repeated_jp do
				if table.contains(self.coupletDatas[self.coupletIndex].repeated_jp[iter_34_0], arg_32_1.index) and table.contains(self.coupletDatas[self.coupletIndex].repeated_jp[iter_34_0], arg_32_1.swapIndex) then
					var_34_0 = true
				end
			end
		end

		setActive(findTF(arg_32_1.tf, "bgOn"), var_34_0)

		return
	end))

	return
end

function SpringCoupletPage:clearTween()
	for iter_35_0 = 1, #self.coupletBottomWords do
		if LeanTween.isTweening(go(self.coupletBottomWords[iter_35_0].tf)) then
			LeanTween.cancel(go(self.coupletBottomWords[iter_35_0].tf))
		end
	end

	return
end

function SpringCoupletPage:showTips(arg_36_1, arg_36_2)
	if type(arg_36_1) == "table" then
		if arg_36_1 and #arg_36_1 > 0 then
			self.tipTime = Time.realtimeSinceStartup

			setText(findTF(self.charTip, "text"), (i18n(arg_36_1[math.random(1, #arg_36_1)])))
			setActive(self.charTip, false)
			setActive(self.charTip, true)
		end
	else
		self.tipTime = Time.realtimeSinceStartup

		setText(findTF(self.charTip, "text"), arg_36_1)
		setActive(self.charTip, false)
		setActive(self.charTip, true)
	end

	return
end

function SpringCoupletPage:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.model then
		PoolMgr.GetInstance():ReturnSpineChar(502011, self.model)
	end

	self:clearTween()

	return
end

return SpringCoupletPage
