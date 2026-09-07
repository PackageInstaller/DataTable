local WWFPtPage = class("WWFPtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = 6000

function WWFPtPage:OnInit()
	WWFPtPage.super.OnInit(self)

	self.helpBtn = self.bg:Find("help_btn")
	self.collectBtn = self.bg:Find("collect_btn")
	self.taskRedDot = self.collectBtn:Find("red_dot")
	self.resNumTF = self.collectBtn:Find("res_num")
	self.title = self.bg:Find("title")
	self.tags = self.bg:Find("tags")
	self.convertBtn = self.bg:Find("convert_btn")
	self.switchBtn = self.bg:Find("switch_btn")
	self.switchRedDot = self.switchBtn:Find("red_dot")
	self.paintings = {
		self.bg:Find("paintings/ninghai"),
		self.bg:Find("paintings/pinghai")
	}
	self.anim = self.bg:Find("anim")
	self.ninghaiTF = self.bg:Find("anim/panda_anim/ninghai")
	self.pinghaiTF = self.bg:Find("anim/panda_anim/pinghai")
	self.heartImages = self.bg:Find("hearts")
	self.step2 = self.bg:Find("step2")
	self.taskWindow = self._tf:Find("TaskWindow")
	self.closeBtn = self.taskWindow:Find("panel/close_btn")
	self.maskBtn = self.taskWindow:Find("mask")
	self.item = self.taskWindow:Find("panel/scrollview/item")
	self.items = self.taskWindow:Find("panel/scrollview/items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.typeImages = self.taskWindow:Find("panel/tags")
	self.barImages = self.taskWindow:Find("panel/bars")
	self.guide = self._tf:Find("Guide")
	self.guideTarget = self.guide:Find("target")
	self.guideContent = self.guide:Find("dialogBox/content")

	return
end

function WWFPtPage:OnDataSetting()
	self.titleTxts = {
		i18n("wwf_bamboo_tip1"),
		i18n("wwf_bamboo_tip2")
	}
	self.resID = self.activity:getConfig("config_client").convertRes
	self.subActivities = self.activity:getConfig("config_client").ptActID
	self.taskList = self.activity:getConfig("config_data")

	self:initPtData()
	self:initTaskData()
	self:initLocalData()

	return
end

function WWFPtPage:initPtData()
	self.subPtDate = {}

	for iter_3_0, iter_3_1 in ipairs(self.subActivities) do
		local var_3_0 = getProxy(ActivityProxy):getActivityById(iter_3_1)

		if self.subPtDate[iter_3_1] then
			self.subPtDate[iter_3_1]:Update(var_3_0)
		else
			self.subPtDate[iter_3_1] = ActivityPtData.New(var_3_0)
		end
	end

	self.resNum = getProxy(PlayerProxy):getRawData():getResource(self.resID)

	return
end

function WWFPtPage:setPtActIndex()
	self.curActIndex = self.lastSelectIndex
	self.curSubActID = self.subActivities[self.curActIndex]

	if not self.subPtDate[self.curSubActID]:CanGetMorePt() or self.subPtDate[self.subActivities[self.curActIndex == 1 and 2 or 1]]:CanGetAward() then
		self.curActIndex = self.curActIndex == 1 and 2 or 1
		self.curSubActID = self.subActivities[self.curActIndex]

		PlayerPrefs.SetInt("wwf_select_index_" .. self.playerId, self.lastSelectIndex)
		PlayerPrefs.Save()
	end

	return
end

function WWFPtPage:setStep2Progress()
	setImageSprite(self.step2, self.heartImages:Find(tostring(self.curActIndex)):GetComponent(typeof(Image)).sprite)

	self.step2:GetComponent(typeof(Image)).fillAmount = self.subPtDate[self.curSubActID].count / var_0_1

	return
end

function WWFPtPage:initTaskData()
	self.taskProxy = getProxy(TaskProxy)
	self.curTask = {}
	self.todoTaskNum = 0

	for iter_6_0, iter_6_1 in ipairs(self.taskList) do
		local var_6_0 = self.taskProxy:getTaskById(iter_6_1) or self.taskProxy:getFinishTaskById(iter_6_1)

		if var_6_0 then
			table.insert(self.curTask, var_6_0.id)

			if var_6_0:getTaskStatus() == 0 then
				self.todoTaskNum = self.todoTaskNum + 1
			end
		end
	end

	return
end

function WWFPtPage:initLocalData()
	self.playerId = getProxy(PlayerProxy):getData().id
	self.isFirst = PlayerPrefs.GetInt("wwf_first_" .. self.playerId)
	self.lastSelectIndex = PlayerPrefs.GetInt("wwf_select_index_" .. self.playerId) == 0 and 1 or PlayerPrefs.GetInt("wwf_select_index_" .. self.playerId)
	self.showTaskRedDot = false

	local var_7_0 = PlayerPrefs.GetInt("wwf_todo_task_num_" .. self.playerId)

	if (var_7_0 == 0 and not self.todoTaskNum == 0 or var_7_0 < self.todoTaskNum) and not self:isFinishAllAct() then
		self.showTaskRedDot = true
	end

	self.hasClickTask = false

	PlayerPrefs.SetInt("wwf_todo_task_num_" .. self.playerId, self.todoTaskNum)
	PlayerPrefs.Save()

	return
end

function WWFPtPage:OnFirstFlush()
	onButton(self, self.awardTF, function()
		self:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			type = self.subPtDate[self.curSubActID].type,
			dropList = self.subPtDate[self.curSubActID].dropList,
			targets = self.subPtDate[self.curSubActID].targets,
			level = self.subPtDate[self.curSubActID].level,
			count = self.subPtDate[self.curSubActID].count,
			resId = self.subPtDate[self.curSubActID].resId
		})

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_10_0 = {}
		local var_10_1 = self.subPtDate[self.curSubActID]:GetAward()

		if var_10_1.type == DROP_TYPE_RESOURCE and var_10_1.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_10_1.count) then
			table.insert(var_10_0, function(arg_11_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
					onYes = arg_11_0
				})

				return
			end)
		end

		local function var_10_2()
			if not self.subPtDate[self.curSubActID]:CanGetNextAward() then
				triggerButton(self.switchBtn)
			end

			return
		end

		seriesAsync(var_10_0, function()
			local var_13_0, var_13_1 = self.subPtDate[self.curSubActID]:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.subPtDate[self.curSubActID]:GetId(),
				arg1 = var_13_1,
				callback = var_10_2
			})

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("wwf_bamboo_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.convertBtn, function()
		if self.resNum <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("wwf_bamboo_tip3"))
			self:openTask()
		else
			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 5,
				activity_id = self.curSubActID,
				arg1 = self.resID
			})
			self:playSpineAni()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.switchBtn, function()
		if self.isSwitching then
			return
		end

		self.curActIndex = self.curActIndex == 1 and 2 or 1
		self.lastSelectIndex = self.curActIndex

		PlayerPrefs.SetInt("wwf_select_index_" .. self.playerId, self.lastSelectIndex)
		PlayerPrefs.Save()

		self.curSubActID = self.subActivities[self.curActIndex]

		self:OnUpdatePtAct()
		self:playPaintingAni()
		self:setStep2Progress()

		return
	end, SFX_PANEL)
	onButton(self, self.collectBtn, function()
		self:openTask()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:closeTask()

		return
	end, SFX_PANEL)
	onButton(self, self.maskBtn, function()
		self:closeTask()

		return
	end, SFX_PANEL)
	onButton(self, self.guideTarget, function()
		setActive(self.guide, false)
		self:openTask()
		PlayerPrefs.SetInt("wwf_first_" .. self.playerId, 1)
		PlayerPrefs.Save()

		if #self.finishItemList > 0 then
			self:autoFinishTask()
		end

		return
	end, SFX_PANEL)

	local var_8_0 = "ninghai_7"
	local var_8_1 = "pinghai_7"

	if not self.model1 then
		pg.UIMgr.GetInstance():LoadingOn()
		PoolMgr.GetInstance():GetSpineChar("ninghai_7", true, function(arg_21_0)
			pg.UIMgr.GetInstance():LoadingOff()

			self.prefab1 = var_8_0
			self.model1 = arg_21_0
			tf(arg_21_0).localScale = Vector3(1, 1, 1)

			setParent(arg_21_0, self.ninghaiTF)
			setActive(arg_21_0, false)

			return
		end)
	end

	if not self.model2 then
		pg.UIMgr.GetInstance():LoadingOn()
		PoolMgr.GetInstance():GetSpineChar("pinghai_7", true, function(arg_22_0)
			pg.UIMgr.GetInstance():LoadingOff()

			self.prefab2 = var_8_1
			self.model2 = arg_22_0
			tf(arg_22_0).localScale = Vector3(1, 1, 1)

			setParent(arg_22_0, self.pinghaiTF)
			setActive(arg_22_0, false)

			return
		end)
	end

	self:setPtActIndex()
	self:setStep2Progress()
	self:initTaskWindow()

	if self.isFirst == 0 then
		setActive(self.guide, true)
		setText(self.guideContent, i18n("wwf_guide_tip"))
	elseif #self.finishItemList > 0 then
		self:openTask()
		self:autoFinishTask()
	end

	return
end

function WWFPtPage:OnUpdateFlush()
	for iter_23_0, iter_23_1 in ipairs(self.subActivities) do
		local var_23_0 = getProxy(ActivityProxy):getActivityById(iter_23_1)

		if self.subPtDate[iter_23_1] then
			self.subPtDate[iter_23_1]:Update(var_23_0)
		else
			self.subPtDate[iter_23_1] = ActivityPtData.New(var_23_0)
		end
	end

	self.resNum = getProxy(PlayerProxy):getRawData():getResource(self.resID)

	setText(self.resNumTF, self.resNum)
	self:OnUpdatePtAct()

	local var_23_1 = self.curActIndex == 1 and 2 or 1

	GetOrAddComponent(self.paintings[self.curActIndex], typeof(CanvasGroup)).alpha = 1
	GetOrAddComponent(self.paintings[var_23_1], typeof(CanvasGroup)).alpha = 0

	return
end

function WWFPtPage:OnUpdatePtAct()
	setText(self.title, self.titleTxts[self.curActIndex])
	eachChild(self.tags, function(arg_25_0)
		setActive(arg_25_0, tonumber(arg_25_0.name) == self.curActIndex)

		return
	end)

	local var_24_0, var_24_1, var_24_2 = self.subPtDate[self.curSubActID]:GetLevelProgress()
	local var_24_3, var_24_4, var_24_5 = self.subPtDate[self.curSubActID]:GetResProgress()

	eachChild(self.step, function(arg_26_0)
		setActive(arg_26_0, tonumber(arg_26_0.name) < var_24_0 and true or false)

		return
	end)
	setText(self.progress, (var_24_5 >= 1 and setColorStr(var_24_3, "#94D979") or var_24_3) .. "/" .. var_24_4)
	updateDrop(self.awardTF, (self.subPtDate[self.curSubActID]:GetAward()))

	local var_24_6 = self.subPtDate[self.curSubActID]:CanGetAward()
	local var_24_7 = self.subPtDate[self.curSubActID]:CanGetNextAward()
	local var_24_8 = self.subPtDate[self.curSubActID]:CanGetMorePt()

	setActive(self.convertBtn, not var_24_6)
	setActive(self.getBtn, var_24_6)
	setActive(self.gotBtn, not var_24_7)
	setActive(self.step:Find("10"), not var_24_7)
	setActive(self.switchRedDot, not var_24_7 and not self:isFinishAllAct())
	setActive(self.taskRedDot, self.showTaskRedDot and not self.hasClickTask)

	return
end

function WWFPtPage:playPaintingAni()
	self.isSwitching = true

	local var_27_0 = self.paintings[self.curActIndex]
	local var_27_1 = GetOrAddComponent(self.paintings[self.curActIndex], typeof(CanvasGroup))
	local var_27_2 = GetOrAddComponent(self.paintings[self.curActIndex == 1 and 2 or 1], typeof(CanvasGroup))

	LeanTween.value(go(self.paintings[self.curActIndex == 1 and 2 or 1]), 1, 0, 0.4):setOnUpdate(System.Action_float(function(arg_28_0)
		var_27_2.alpha = arg_28_0

		return
	end)):setOnComplete(System.Action(function()
		LeanTween.value(go(var_27_0), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_30_0)
			var_27_1.alpha = arg_30_0

			return
		end)):setOnComplete(System.Action(function()
			self.isSwitching = false

			return
		end))

		return
	end))

	return
end

function WWFPtPage:playSpineAni()
	setActive(self.anim, true)

	local var_32_0 = 0.4
	local var_32_1 = self.anim:Find("panda_anim")
	local var_32_2 = self.anim:Find("heart_anim")
	local var_32_3 = GetOrAddComponent(var_32_1, typeof(CanvasGroup))

	setActive(var_32_1, true)

	var_32_3.alpha = 1

	LeanTween.value(go(var_32_1), 0, 1, var_32_0):setOnUpdate(System.Action_float(function(arg_33_0)
		var_32_3.alpha = arg_33_0

		return
	end))

	local function var_32_4()
		LeanTween.value(go(var_32_1), 1, 0, var_32_0):setOnUpdate(System.Action_float(function(arg_35_0)
			var_32_3.alpha = arg_35_0

			return
		end))
		LeanTween.scale(var_32_1, Vector3(1, 0, 1), var_32_0):setFrom(Vector3(1, 1, 1)):setOnComplete(System.Action(function()
			setActive(var_32_1, false)

			return
		end))
		setActive(var_32_2, true)
		LeanTween.delayedCall(2, System.Action(function()
			setActive(var_32_2, false)
			LeanTween.value(go(self.step2), self.step2:GetComponent(typeof(Image)).fillAmount, self.subPtDate[self.curSubActID].count / var_0_1, 1):setOnUpdate(System.Action_float(function(arg_38_0)
				self.step2:GetComponent(typeof(Image)).fillAmount = arg_38_0

				return
			end)):setOnComplete(System.Action(function()
				setActive(self.anim, false)

				self.heartAni = false

				return
			end))

			return
		end))

		return
	end

	if self.curActIndex == 1 then
		local var_32_5 = self.model1 or self.model2
	end

	LeanTween.scale(var_32_1, Vector3(1, 1, 1), var_32_0):setFrom(Vector3(1, 0, 1)):setOnComplete(System.Action(function()
		setActive(var_32_5, true)
		var_32_5:GetComponent("SpineAnimUI"):SetActionCallBack(function(arg_41_0)
			if arg_41_0 == "finish" then
				var_32_5:GetComponent("SpineAnimUI"):SetActionCallBack(nil)
				setActive(var_32_5, false)
				var_32_4()
			end

			return
		end)
		var_32_5:GetComponent("SpineAnimUI"):SetAction("event", 0)

		return
	end))

	self.heartAni = false

	onButton(self, self.anim, function()
		if self.heartAni then
			return
		end

		var_32_5:GetComponent("SpineAnimUI"):SetActionCallBack(nil)
		setActive(var_32_5, false)

		self.heartAni = true

		var_32_4()

		return
	end, SFX_PANEL)

	return
end

function WWFPtPage:initTaskWindow()
	self.finishItemList = {}
	self.finishTaskVOList = {}

	self.uilist:make(function(arg_44_0, arg_44_1, arg_44_2)
		if arg_44_0 == UIItemList.EventUpdate then
			local var_44_0 = arg_44_2:Find("item")
			local var_44_1 = self.taskProxy:getTaskById(self.curTask[arg_44_1 + 1]) or self.taskProxy:getFinishTaskById(self.curTask[arg_44_1 + 1])

			assert(var_44_1, "without this task by id: " .. self.curTask[arg_44_1 + 1])

			local var_44_2 = var_44_1:getConfig("award_display")[1]
			local var_44_3 = {
				type = var_44_2[1],
				id = var_44_2[2],
				count = var_44_2[3]
			}

			updateDrop(var_44_0, var_44_3)
			onButton(self, var_44_0, function()
				self:emit(BaseUI.ON_DROP, var_44_3)

				return
			end, SFX_PANEL)

			local var_44_4 = var_44_1:getProgress()
			local var_44_5 = var_44_1:getConfig("target_num")

			setText(arg_44_2:Find("description"), var_44_1:getConfig("desc"))
			setText(arg_44_2:Find("progressText"), var_44_4 .. "/" .. var_44_5)
			setSlider(arg_44_2:Find("progress"), 0, var_44_5, var_44_4)

			local var_44_6 = arg_44_2:Find("go_btn")
			local var_44_7 = var_44_1:getTaskStatus()

			if var_44_7 == 1 then
				table.insert(self.finishItemList, arg_44_2)
				table.insert(self.finishTaskVOList, var_44_1)
			end

			setActive(arg_44_2:Find("finnal"), var_44_7 == 2)
			onButton(self, var_44_6, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_44_1)

				return
			end, SFX_PANEL)

			local var_44_8 = var_44_1:getConfig("type")

			setImageSprite(arg_44_2:Find("type"), self.typeImages:Find(tostring(var_44_8)):GetComponent(typeof(Image)).sprite, true)
			setImageSprite(arg_44_2:Find("progress/slider"), self.barImages:Find(tostring(var_44_8)):GetComponent(typeof(Image)).sprite)
		end

		return
	end)
	self.uilist:align(#self.curTask)
	setActive(self.taskWindow, false)

	return
end

function WWFPtPage:closeTask()
	setActive(self.taskWindow, false)

	return
end

function WWFPtPage:openTask()
	if not self.curSubActID then
		self:setPtActIndex()
		self:setStep2Progress()
	end

	setActive(self.taskWindow, true)

	if self.showTaskRedDot then
		setActive(self.taskRedDot, false)
		getProxy(ActivityProxy):updateActivity(self.activity)
	end

	self.hasClickTask = true

	eachChild(self.items, function(arg_49_0)
		if isActive(arg_49_0:Find("finnal")) then
			arg_49_0:SetAsLastSibling()
		end

		return
	end)

	return
end

function WWFPtPage:autoFinishTask()
	local var_50_0 = 0.01
	local var_50_1 = 0.5

	for iter_50_0, iter_50_1 in ipairs(self.finishItemList) do
		local var_50_2 = GetOrAddComponent(iter_50_1, typeof(CanvasGroup))

		self:managedTween(LeanTween.delayedCall, function()
			iter_50_1:SetAsFirstSibling()
			LeanTween.value(go(iter_50_1), 1, 0, var_50_1):setOnUpdate(System.Action_float(function(arg_52_0)
				var_50_2.alpha = arg_52_0

				return
			end)):setOnComplete(System.Action(function()
				var_50_2.alpha = 1

				setActive(iter_50_1:Find("finnal"), true)
				iter_50_1:SetAsLastSibling()

				return
			end))

			return
		end, var_50_0, nil)

		var_50_0 = var_50_0 + 0.5 + 0.1
	end

	self:managedTween(LeanTween.delayedCall, function()
		pg.m02:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
			resultList = self.finishTaskVOList
		})

		return
	end, var_50_0, nil)

	return
end

function WWFPtPage:canFinishTask(arg_55_1)
	local var_55_0 = false

	for iter_55_0, iter_55_1 in pairs(self) do
		if (arg_55_1:getTaskById(iter_55_1) or arg_55_1:getFinishTaskById(iter_55_1)):getTaskStatus() == 1 then
			var_55_0 = true

			break
		end
	end

	return var_55_0
end

function WWFPtPage:canAddProgress(arg_56_1)
	local var_56_0 = false

	for iter_56_0, iter_56_1 in pairs(arg_56_1) do
		local var_56_1, var_56_2, var_56_3 = iter_56_1:GetResProgress()

		if self >= var_56_2 - var_56_1 and iter_56_1:CanGetNextAward() then
			var_56_0 = true

			break
		end
	end

	return var_56_0
end

function WWFPtPage:canGetPtAward()
	local var_57_0 = false

	for iter_57_0, iter_57_1 in pairs(self) do
		if iter_57_1:CanGetAward() then
			var_57_0 = true

			break
		end
	end

	return var_57_0
end

function WWFPtPage:isFinishAllAct()
	local var_58_0 = true

	for iter_58_0, iter_58_1 in pairs(self.subPtDate) do
		if iter_58_1:CanGetNextAward() then
			var_58_0 = false

			break
		end
	end

	return var_58_0
end

function WWFPtPage:isNewTask()
	local var_59_0 = PlayerPrefs.GetInt("wwf_todo_task_num_" .. getProxy(PlayerProxy):getData().id)

	if var_59_0 == 0 and not self == 0 or var_59_0 < self then
		return true
	else
		return false
	end

	return
end

function WWFPtPage.IsShowRed()
	local var_60_0 = {}

	for iter_60_0, iter_60_1 in ipairs(pg.activity_template[ActivityConst.WWF_TASK_ID].config_client.ptActID) do
		local var_60_1 = getProxy(ActivityProxy):getActivityById(iter_60_1)

		if var_60_0[iter_60_1] then
			var_60_0[iter_60_1]:Update(var_60_1)
		else
			var_60_0[iter_60_1] = ActivityPtData.New(var_60_1)
		end
	end

	local var_60_2 = getProxy(TaskProxy)
	local var_60_3 = {}
	local var_60_4 = 0

	for iter_60_2, iter_60_3 in ipairs(pg.activity_template[ActivityConst.WWF_TASK_ID].config_data) do
		local var_60_5 = var_60_2:getTaskById(iter_60_3) or var_60_2:getFinishTaskById(iter_60_3)

		if var_60_5 then
			table.insert(var_60_3, var_60_5.id)

			if var_60_5:getTaskStatus() == 0 then
				var_60_4 = var_60_4 + 1
			end
		end
	end

	if (function()
		local var_61_0 = true

		for iter_61_0, iter_61_1 in pairs(var_60_0) do
			if iter_61_1:CanGetNextAward() then
				var_61_0 = false

				break
			end
		end

		return var_61_0
	end)() then
		return false
	else
		return WWFPtPage.canFinishTask(var_60_3, var_60_2) or WWFPtPage.canGetPtAward(var_60_0) or WWFPtPage.canAddProgress(getProxy(PlayerProxy):getRawData():getResource(pg.activity_template[ActivityConst.WWF_TASK_ID].config_client.convertRes), var_60_0) or WWFPtPage.isNewTask(var_60_4)
	end

	return false
end

function WWFPtPage:OnDestroy()
	if self.prefab1 and self.model1 then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab1, self.model1)

		self.prefab1 = nil
		self.model1 = nil
	end

	if self.prefab2 and self.model2 then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab2, self.model2)

		self.prefab2 = nil
		self.model2 = nil
	end

	self:cleanManagedTween()

	return
end

return WWFPtPage
