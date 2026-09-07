local RyzaTaskScene = class("RyzaTaskScene", import("..base.BaseUI"))
local var_0_1 = "ryza_task_level_desc"
local var_0_2 = {}

var_0_2[1] = "ryza_task_tag_explore"
var_0_2[2] = "ryza_task_tag_battle"
var_0_2[3] = "ryza_task_tag_dalegate"
var_0_2[4] = "ryza_task_tag_develop"

local var_0_3 = "ryza_task_detail_content"
local var_0_4 = "ryza_task_detail_award"
local var_0_5 = "ryza_task_go"
local var_0_6 = "ryza_task_get"
local var_0_7 = "ryza_task_detail"
local var_0_8 = "ryza_task_submit"
local var_0_9 = "ryza_task_get_all"
local var_0_10 = "ryza_task_confirm"
local var_0_11 = "ryza_task_cancel"
local var_0_12 = "ryza_task_level_num"
local var_0_13 = "ryza_task_level_add"
local var_0_15 = "sub_item_warning"
local var_0_16 = "ui/ryzaicon_atlas"

function RyzaTaskScene:getUIName()
	return "RyzaTaskUI"
end

local var_0_17 = 4

function RyzaTaskScene:init()
	self.activityId = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TASK_RYZA).id
	self.enterTaskId = self.contextData.task_id or nil
	self.taskGroups = pg.activity_template[self.activityId].config_data
	self.leanTweens = {}
	self.exitFlag = false
	self.ptName = pg.player_resource[pg.activity_template[self.activityId].config_client.pt_id].name
	self.ptBuffs = pg.activity_template[self.activityId].config_client.pt_buff
	self.maxNum = self.ptBuffs[#self.ptBuffs].pt[1]

	local var_2_0 = findTF(self._tf, "ad")

	self.btnBack = findTF(var_2_0, "btnBack")
	self.btnMain = findTF(var_2_0, "btnMain")
	self.btnHelp = findTF(var_2_0, "btnHelp")
	self.btnGetAll = findTF(var_2_0, "btnGetAll")
	self.btnPoint = findTF(var_2_0, "btnPoint")
	self.imgPoint = findTF(var_2_0, "btnPoint/imgPoint")
	self.taskTagPanel = findTF(var_2_0, "taskTagPanel")
	self.taskListPanel = findTF(var_2_0, "taskListPanel")
	self.scrollRect = findTF(var_2_0, "taskListPanel/Content"):GetComponent("LScrollRect")
	self.taskDetailPanel = findTF(var_2_0, "taskDetailPanel")
	self.detailTag = findTF(self.taskDetailPanel, "tag")
	self.detailTitleText = findTF(self.taskDetailPanel, "title/text")
	self.detailIcon = findTF(self.taskDetailPanel, "icon/image")
	self.detailDescText = findTF(self.taskDetailPanel, "desc/text")
	self.detaiProgressText = findTF(self.taskDetailPanel, "progress/text")
	self.detailAwardContent = findTF(self.taskDetailPanel, "awardDisplay/viewport/content")
	self.detailBtnGo = findTF(self.taskDetailPanel, "btnGo")
	self.detailBtnGet = findTF(self.taskDetailPanel, "btnGet")
	self.detailBtnSubmit = findTF(self.taskDetailPanel, "btnSubmit")
	self.detailBtnDetail = findTF(self.taskDetailPanel, "btnDetail")
	self.detailActive = findTF(self.taskDetailPanel, "active")
	self.taskItemTpl = findTF(var_2_0, "tpl/taskItemTpl")
	self.IconTpl = findTF(var_2_0, "tpl/IconTpl")

	local var_2_1 = findTF(self._tf, "pop")

	self.pointPanel = findTF(var_2_1, "pointPanel")

	setActive(self.pointPanel, false)

	self.pointProgressText = findTF(self.pointPanel, "progressContent/progress")
	self.pointProgressSlider = findTF(self.pointPanel, "slider")
	self.pointLevelStar = findTF(self.pointPanel, "levelStar")
	self.pointStarTpl = findTF(self.pointPanel, "levelStar/starTpl")
	self.pointAdd = findTF(self.pointPanel, "add")
	self.pointClose = findTF(self.pointPanel, "btnClose")
	self.pointMask = findTF(self.pointPanel, "mask")
	self.submitPanel = findTF(var_2_1, "submitPanel")
	self.submitDisplayContent = findTF(self.submitPanel, "itemDisplay/viewport/content")
	self.submitConfirm = findTF(self.submitPanel, "btnComfirm")
	self.submitCancel = findTF(self.submitPanel, "btnCancel")
	self.subimtItem = findTF(self.submitPanel, "itemDisplay/viewport/content/item")
	self.submitItemDesc = findTF(self.submitPanel, "itemDesc")
	self.btnCancel = findTF(self.submitPanel, "btnCancel")

	setText(findTF(self.btnPoint, "text"), i18n(var_0_1))

	for iter_2_0 = 1, var_0_17 do
		local var_2_2 = findTF(self.taskTagPanel, "btn" .. iter_2_0)

		setText(findTF(var_2_2, "off/text"), i18n(var_0_2[iter_2_0]))
		setText(findTF(var_2_2, "on/text"), i18n(var_0_2[iter_2_0]))
	end

	setText(findTF(self.taskDetailPanel, "desc/title"), i18n(var_0_3))
	setText(findTF(self.taskDetailPanel, "awardText"), i18n(var_0_4))
	setText(findTF(self.taskDetailPanel, "btnGet/text"), i18n(var_0_6))
	setText(findTF(self.taskDetailPanel, "btnGo/text"), i18n(var_0_5))
	setText(findTF(self.taskDetailPanel, "btnSubmit/text"), i18n(var_0_8))
	setText(findTF(self.taskDetailPanel, "btnDetail/text"), i18n(var_0_7))
	setText(findTF(self.btnGetAll, "text"), i18n(var_0_9))
	setText(findTF(self.submitPanel, "btnComfirm/text"), i18n(var_0_10))
	setText(findTF(self.submitPanel, "btnCancel/text"), i18n(var_0_11))
	setText(findTF(self.submitPanel, "bg/text"), i18n(var_0_15))
	setText(findTF(self.pointPanel, "title"), i18n(var_0_1))
	setText(findTF(self.pointPanel, "levelNum/text"), i18n(var_0_12))
	setText(findTF(self.pointPanel, "levelBuff/text"), i18n(var_0_13))

	self.pointStarTfs = {}

	for iter_2_1 = 1, #self.ptBuffs do
		local var_2_3 = tf(Instantiate(self.pointStarTpl))

		SetParent(var_2_3, self.pointLevelStar)
		setActive(var_2_3, true)
		setText(findTF(var_2_3, "bg/text"), iter_2_1)
		setText(findTF(var_2_3, "img/text"), iter_2_1)

		var_2_3.anchoredPosition = Vector3(self.ptBuffs[iter_2_1].pt[1] / self.maxNum * self.pointLevelStar.sizeDelta.x, -18, 0)

		table.insert(self.pointStarTfs, var_2_3)

		if iter_2_1 == 1 then
			setActive(var_2_3, false)
		end
	end

	self:updateTask()

	return
end

function RyzaTaskScene:updateTask(arg_3_1)
	self.displayTask = {}
	self.allDisplayTask = {}

	local var_3_0 = getProxy(ActivityTaskProxy):getTaskById(self.activityId)

	self.getAllTasks = {}

	for iter_3_0 = 1, #var_3_0 do
		local var_3_1 = var_3_0[iter_3_0]:getProgress()
		local var_3_2 = var_3_0[iter_3_0]:getTarget()
		local var_3_3 = var_3_0[iter_3_0]:getConfig("ryza_type")
		local var_3_4 = var_3_0[iter_3_0]:getConfig("type")

		if var_3_3 > 0 then
			self.displayTask[var_3_3] = self.displayTask[var_3_3] or {}

			table.insert(self.displayTask[var_3_3], var_3_0[iter_3_0])
			table.insert(self.allDisplayTask, var_3_0[iter_3_0])

			if not var_3_0[iter_3_0]:isFinish() or var_3_0[iter_3_0]:isOver() or var_3_0[iter_3_0]:getConfig("sub_type") == 1006 then
				-- block empty
			else
				table.insert(self.getAllTasks, var_3_0[iter_3_0].id)
			end
		end
	end

	local var_3_5 = getProxy(ActivityProxy):getActivityById(self.activityId)
	local var_3_6 = {}

	if var_3_5 then
		var_3_6 = var_3_5.data1_list
	end

	if var_3_6 and #var_3_6 > 0 then
		for iter_3_1 = 1, #var_3_6 do
			local var_3_7 = ActivityTask.New(self.activityId, {
				progress = 0,
				id = var_3_6[iter_3_1]
			})

			var_3_7:setOver()

			local var_3_8 = var_3_7:getConfig("ryza_type")

			if var_3_8 > 0 then
				self.displayTask[var_3_8] = self.displayTask[var_3_8] or {}

				table.insert(self.displayTask[var_3_8], var_3_7)
				table.insert(self.allDisplayTask, var_3_7)
			end
		end
	end

	local function var_3_9(arg_4_0, arg_4_1)
		if arg_4_0:isOver() and not arg_4_1:isOver() then
			return false
		elseif not arg_4_0:isOver() and arg_4_1:isOver() then
			return true
		end

		if arg_4_0:isFinish() and not arg_4_1:isFinish() then
			return true
		elseif not arg_4_0:isFinish() and arg_4_1:isFinish() then
			return false
		end

		if arg_4_0:isNew() and not arg_4_1:isNew() then
			return true
		elseif not arg_4_0:isNew() and arg_4_1:isNew() then
			return false
		end

		if arg_4_0.id > arg_4_1.id then
			return false
		elseif arg_4_0.id < arg_4_1.id then
			return true
		end

		return
	end

	for iter_3_2, iter_3_3 in pairs(self.displayTask) do
		table.sort(iter_3_3, var_3_9)
	end

	table.sort(self.allDisplayTask, var_3_9)

	if arg_3_1 then
		self:onClickTag()
	end

	if #self.getAllTasks > 0 then
		setActive(self.btnGetAll, true)
	else
		setActive(self.btnGetAll, false)
	end

	local var_3_10 = getProxy(PlayerProxy):getData()[self.ptName]

	var_3_10 = var_3_10 or 0

	local var_3_11 = 1

	if var_3_10 > self.maxNum then
		var_3_10 = self.maxNum
	end

	for iter_3_4 = #self.ptBuffs, 1, -1 do
		var_3_11 = var_3_10 >= self.ptBuffs[iter_3_4].pt[1] and var_3_11 < iter_3_4 and iter_3_4 or var_3_11
	end

	for iter_3_5 = 1, #self.pointStarTfs do
		if iter_3_5 <= var_3_11 then
			setActive(findTF(self.pointStarTfs[iter_3_5], "img"), true)
		else
			setActive(findTF(self.pointStarTfs[iter_3_5], "img"), false)
		end
	end

	for iter_3_6 = 1, #self.ptBuffs[var_3_11].benefit do
		local var_3_12 = findTF(self.pointPanel, "add/" .. iter_3_6)

		if PLATFORM_CODE == PLATFORM_JP then
			findTF(var_3_12, "img").sizeDelta = Vector2(450, 70)

			setText(findTF(var_3_12, "text_jp"), pg.benefit_buff_template[self.ptBuffs[var_3_11].benefit[iter_3_6]].desc)
		else
			setText(findTF(var_3_12, "text"), pg.benefit_buff_template[self.ptBuffs[var_3_11].benefit[iter_3_6]].desc)
		end
	end

	setSlider(self.pointProgressSlider, 0, self.maxNum, var_3_10)
	setText(self.pointProgressText, var_3_10 .. "/" .. self.maxNum)
	setText(findTF(self.btnPoint, "text"), i18n(var_0_1) .. "Lv." .. var_3_11)
	setText(findTF(self.pointPanel, "levelNum/num"), "Lv." .. var_3_11)
	setText(findTF(self.pointPanel, "levelBuff/num"), "Lv." .. var_3_11)

	return
end

function RyzaTaskScene:didEnter()
	onButton(self, self.btnBack, function()
		self:emit(RyzaTaskScene.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self.btnGetAll, function()
		self:emit(RyzaTaskMediator.SUBMIT_TASK_ALL, {
			activityId = self.activityId,
			ids = self.getAllTasks
		})

		return
	end, SOUND_BACK)
	onButton(self, self.btnPoint, function()
		if isActive(self.pointPanel) then
			setActive(self.pointPanel, false)
		else
			setActive(self.pointPanel, true)
		end

		return
	end, SOUND_BACK)
	onButton(self, self.btnMain, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SOUND_BACK)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("ryza_task_help_tip")
		})

		return
	end, SOUND_BACK)
	onButton(self, self.detailBtnGo, function()
		self:emit(RyzaTaskMediator.TASK_GO, {
			taskVO = Task.New(self.selectTask)
		})

		return
	end, SOUND_BACK)
	onButton(self, self.pointMask, function()
		setActive(self.pointPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, self.pointClose, function()
		setActive(self.pointPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, self.detailBtnSubmit, function()
		local var_14_0 = self.selectTask:getConfig("type")

		if self.selectTask:getConfig("sub_type") == 1006 then
			self:openSubmitPanel(self.selectTask)
		else
			self:emit(RyzaTaskMediator.SUBMIT_TASK, {
				activityId = self.activityId,
				id = self.selectTask.id
			})
		end

		return
	end, SOUND_BACK)
	onButton(self, self.detailBtnGet, function()
		local var_15_0 = self.selectTask:getConfig("type")

		if self.selectTask:getConfig("sub_type") == 1006 then
			self:openSubmitPanel(self.selectTask)
		else
			self:emit(RyzaTaskMediator.SUBMIT_TASK, {
				activityId = self.activityId,
				id = self.selectTask.id
			})
		end

		return
	end, SOUND_BACK)
	onButton(self, self.detailBtnDetail, function()
		if self.selectTask then
			local var_16_0 = tonumber(self.selectTask:getConfig("target_id_2"))

			if var_16_0 and var_16_0 > 0 then
				self:emit(RyzaTaskMediator.SHOW_DETAIL, (AtelierMaterial.New({
					configId = var_16_0,
					count = self.selectTask:getConfig("target_num")
				})))
			end
		end

		return
	end, SOUND_BACK)
	onButton(self, self.submitConfirm, function()
		self:emit(RyzaTaskMediator.SUBMIT_TASK, {
			activityId = self.activityId,
			id = self.selectTask.id
		})
		setActive(self.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, self.submitCancel, function()
		setActive(self.submitPanel, false)

		return
	end, SOUND_BACK)

	self.btnTags = {}

	for iter_5_0 = 1, var_0_17 do
		local var_5_0 = iter_5_0
		local var_5_1 = findTF(self.taskTagPanel, "btn" .. iter_5_0)

		onButton(self, var_5_1, function()
			if self.showTagIndex then
				setActive(findTF(self.btnTags[self.showTagIndex], "on"), false)

				if self.showTagIndex == var_5_0 then
					self.showTagIndex = nil
				else
					self.showTagIndex = var_5_0

					setActive(findTF(self.btnTags[self.showTagIndex], "on"), true)
				end
			else
				self.showTagIndex = var_5_0

				setActive(findTF(self.btnTags[self.showTagIndex], "on"), true)
			end

			self:onClickTag()

			return
		end)
		table.insert(self.btnTags, var_5_1)
	end

	function self.scrollRect.onUpdateItem(arg_20_0, arg_20_1)
		self:onUpdateTaskItem(arg_20_0, arg_20_1)

		return
	end

	self.iconTfs = {}
	self.awards = {}

	self:onClickTag()

	if PlayerPrefs.GetInt("ryza_task_help_" .. getProxy(PlayerProxy):getRawData().id) ~= 1 then
		PlayerPrefs.SetInt("ryza_task_help_" .. getProxy(PlayerProxy):getRawData().id, 1)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("ryza_task_help_tip")
		})
	end

	return
end

function RyzaTaskScene:onClickTag()
	print("点击了Tag")

	if self.showTagIndex and self.showTagIndex > 0 then
		if self.displayTask[self.showTagIndex] and #self.displayTask[self.showTagIndex] > 0 then
			self.showTasks = self.displayTask[self.showTagIndex]
		else
			triggerButton(self.btnTags[self.showTagIndex])

			return
		end
	else
		self.showTasks = self.allDisplayTask
	end

	if self.enterTaskId and self.enterTaskId > 0 then
		for iter_21_0 = 1, #self.showTasks do
			if self.showTasks[iter_21_0].id == self.enterTaskId then
				self.scrollIndex = iter_21_0
			end
		end
	end

	self.scrollRect:SetTotalCount(#self.showTasks, 0)

	if self.scrollIndex ~= nil then
		self.scrollRect:ScrollTo((self.scrollRect:HeadIndexToValue(self.scrollIndex - 1)))
	end

	return
end

function RyzaTaskScene:onUpdateTaskItem(arg_22_1, arg_22_2)
	if self.exitFlag then
		return
	end

	self.leanTweens[arg_22_2] = arg_22_2

	table.insert(self.leanTweens, arg_22_2)

	local var_22_0 = GetComponent(arg_22_2, typeof(CanvasGroup))

	var_22_0.alpha = 0

	LeanTween.value(arg_22_2, 0, 1, 0.3):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_23_0)
		var_22_0.alpha = arg_23_0

		return
	end)):setOnComplete(System.Action(function()
		self.leanTweens[arg_22_2] = nil

		return
	end))

	arg_22_1 = arg_22_1 + 1

	local var_22_1 = self.showTasks[arg_22_1]
	local var_22_2 = self.showTasks[arg_22_1].id
	local var_22_3 = self.showTasks[arg_22_1]:getProgress()
	local var_22_4 = self.showTasks[arg_22_1]:getConfig("name")
	local var_22_5 = self.showTasks[arg_22_1]:getConfig("ryza_icon")
	local var_22_6 = self.showTasks[arg_22_1]:isOver()
	local var_22_7 = self.showTasks[arg_22_1]:isFinish()
	local var_22_8 = self.showTasks[arg_22_1]:isCircle()

	setActive(findTF(arg_22_2, "selected"), self.selectIndex == arg_22_1)
	setActive(findTF(arg_22_2, "typeNew"), var_22_1:isNew())
	setActive(findTF(arg_22_2, "typeCircle"), var_22_1:isCircle())
	setActive(findTF(arg_22_2, "finish"), var_22_6)
	setActive(findTF(arg_22_2, "mask"), var_22_6)
	setActive(findTF(arg_22_2, "complete"), not var_22_6 and var_22_7 and not var_22_8)
	setText(findTF(arg_22_2, "desc/text"), shortenString(var_22_4, 10))

	if not var_22_5 or var_22_5 == 0 then
		var_22_5 = "attack"
	end

	setImageSprite(findTF(arg_22_2, "icon/image"), LoadSprite(var_0_16, var_22_5))
	onButton(self, tf(arg_22_2), function()
		if self.selectItem then
			setActive(findTF(self.selectItem, "selected"), false)
		end

		setActive(findTF(arg_22_2, "selected"), true)

		self.selectIndex = arg_22_1
		self.selectItem = arg_22_2
		self.selectTask = var_22_1

		self:updateDetail()

		return
	end)

	if self.enterTaskId ~= nil and self.enterTaskId > 0 then
		if var_22_2 == self.enterTaskId then
			triggerButton(arg_22_2)

			self.enterTaskId = nil
			self.scrollIndex = nil
		end
	elseif arg_22_1 == 1 then
		triggerButton(arg_22_2)

		self.scrollIndex = nil
	end

	return
end

function RyzaTaskScene:updateDetail()
	local var_26_0 = self.showTasks[self.selectIndex]:getProgress()
	local var_26_1 = self.showTasks[self.selectIndex].target
	local var_26_2 = pg.task_data_template[self.showTasks[self.selectIndex].id]
	local var_26_3 = self.showTasks[self.selectIndex]:isFinish()
	local var_26_4 = self.showTasks[self.selectIndex]:isOver()
	local var_26_5 = self.showTasks[self.selectIndex]:isCircle()
	local var_26_6 = self.showTasks[self.selectIndex]:isSubmit()

	self.awards = pg.task_data_template[self.showTasks[self.selectIndex].id].award_display

	local var_26_7 = var_26_2.desc
	local var_26_8 = var_26_2.ryza_icon
	local var_26_9 = self.showTasks[self.selectIndex]:getConfig("sub_type")

	if not var_26_2.ryza_icon or var_26_8 == 0 then
		var_26_8 = "attack"
	end

	if not var_26_6 and var_26_1 < var_26_0 then
		var_26_0 = var_26_1
	end

	setText(self.detailDescText, var_26_7)

	if not var_26_4 then
		setText(self.detaiProgressText, var_26_0 .. "/" .. var_26_1)
	else
		setText(self.detaiProgressText, "--/--")
	end

	setText(self.detailTitleText, var_26_2.name)
	setActive(self.detailBtnDetail, var_26_9 == 1006 and not var_26_3 and not var_26_4)
	setActive(self.detailBtnGo, not var_26_4 and not var_26_3 and var_26_9 ~= 1006)
	setActive(self.detailBtnGet, not var_26_4 and var_26_3 and not var_26_6)
	setActive(self.detailBtnSubmit, not var_26_4 and var_26_3 and var_26_6)
	setActive(self.detailActive, not var_26_4 and not var_26_3 and not var_26_5)
	setImageSprite(self.detailIcon, LoadSprite(var_0_16, var_26_8))

	if #self.iconTfs < #self.awards then
		for iter_26_0 = 1, #self.awards - #self.iconTfs do
			local var_26_10 = tf(Instantiate(self.IconTpl))

			setParent(var_26_10, self.detailAwardContent)
			setActive(var_26_10, true)
			table.insert(self.iconTfs, var_26_10)
		end
	end

	for iter_26_1 = 1, #self.iconTfs do
		if iter_26_1 <= #self.awards then
			local var_26_11 = {
				type = self.awards[iter_26_1][1],
				id = self.awards[iter_26_1][2],
				count = self.awards[iter_26_1][3]
			}

			updateDrop(self.iconTfs[iter_26_1], var_26_11)
			onButton(self, self.iconTfs[iter_26_1], function()
				self:emit(BaseUI.ON_DROP, var_26_11)

				return
			end, SFX_PANEL)
			setActive(self.iconTfs[iter_26_1], true)
		else
			setActive(self.iconTfs[iter_26_1], false)
		end
	end

	return
end

function RyzaTaskScene:openSubmitPanel(arg_28_1)
	setActive(self.submitPanel, true)

	local var_28_0 = tonumber(arg_28_1:getConfig("target_id_2"))

	updateDrop(self.subimtItem, {
		type = DROP_TYPE_RYZA_DROP,
		id = tonumber(var_28_0),
		count = arg_28_1:getConfig("target_num")
	})
	setText(self.submitItemDesc, pg.activity_ryza_item[var_28_0].name)

	return
end

function RyzaTaskScene:willExit()
	self.exitFlag = true

	if self.leanTweens and #self.leanTweens > 0 then
		for iter_29_0, iter_29_1 in pairs(self.leanTweens) do
			if LeanTween.isTweening(iter_29_1) then
				LeanTween.cancel(iter_29_1)
			end
		end

		self.leanTweens = {}
	end

	for iter_29_2 = 1, #self.allDisplayTask do
		if self.allDisplayTask[iter_29_2]:isNew() then
			self.allDisplayTask[iter_29_2]:changeNew()
		end
	end

	return
end

return RyzaTaskScene
