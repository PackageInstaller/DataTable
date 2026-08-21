local var_0_0 = class("RyzaTaskRePage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = "ryza_task_level_desc"
local var_0_2 = {}

;({})[1] = "ryza_task_tag_explore"
;({})[2] = "ryza_task_tag_battle"
;({})[3] = "ryza_task_tag_dalegate"
;({})[4] = "ryza_task_tag_develop"

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
local var_0_17 = 4

function var_0_0.OnInit(arg_1_0)
	arg_1_0.activityId = ActivityConst.RYZA_TASK
	arg_1_0.enterTaskId = arg_1_0.contextData.task_id or nil
	arg_1_0.taskGroups = pg.activity_template[arg_1_0.activityId].config_data
	arg_1_0.leanTweens = {}
	arg_1_0.exitFlag = false
	arg_1_0.ptName = pg.player_resource[pg.activity_template[arg_1_0.activityId].config_client.pt_id].name
	arg_1_0.ptBuffs = pg.activity_template[arg_1_0.activityId].config_client.pt_buff
	arg_1_0.maxNum = arg_1_0.ptBuffs[#arg_1_0.ptBuffs].pt[1]

	local var_1_0 = findTF(arg_1_0._tf, "AD")

	arg_1_0.btnBack = findTF(var_1_0, "btnBack")
	arg_1_0.btnMain = findTF(var_1_0, "btnMain")
	arg_1_0.btnHelp = findTF(var_1_0, "btnHelp")
	arg_1_0.btnGetAll = findTF(var_1_0, "btnGetAll")
	arg_1_0.btnPoint = findTF(var_1_0, "btnPoint")
	arg_1_0.imgPoint = findTF(var_1_0, "btnPoint/imgPoint")
	arg_1_0.taskTagPanel = findTF(var_1_0, "taskTagPanel")
	arg_1_0.taskListPanel = findTF(var_1_0, "taskListPanel")
	arg_1_0.scrollRect = findTF(var_1_0, "taskListPanel/Content"):GetComponent("LScrollRect")
	arg_1_0.taskDetailPanel = findTF(var_1_0, "taskDetailPanel")
	arg_1_0.detailTag = findTF(arg_1_0.taskDetailPanel, "tag")
	arg_1_0.detailTitleText = findTF(arg_1_0.taskDetailPanel, "title/text")
	arg_1_0.detailIcon = findTF(arg_1_0.taskDetailPanel, "icon/image")
	arg_1_0.detailDescText = findTF(arg_1_0.taskDetailPanel, "desc/text")
	arg_1_0.detaiProgressText = findTF(arg_1_0.taskDetailPanel, "progress/text")
	arg_1_0.detailAwardContent = findTF(arg_1_0.taskDetailPanel, "awardDisplay/viewport/content")
	arg_1_0.detailBtnGo = findTF(arg_1_0.taskDetailPanel, "btnGo")
	arg_1_0.detailBtnGet = findTF(arg_1_0.taskDetailPanel, "btnGet")
	arg_1_0.detailBtnSubmit = findTF(arg_1_0.taskDetailPanel, "btnSubmit")
	arg_1_0.detailBtnDetail = findTF(arg_1_0.taskDetailPanel, "btnDetail")
	arg_1_0.detailActive = findTF(arg_1_0.taskDetailPanel, "active")
	arg_1_0.taskItemTpl = findTF(var_1_0, "tpl/taskItemTpl")
	arg_1_0.IconTpl = findTF(var_1_0, "tpl/IconTpl")

	local var_1_1 = findTF(arg_1_0._tf, "AD/pop")

	arg_1_0.pointPanel = findTF(var_1_1, "pointPanel")

	setActive(arg_1_0.pointPanel, false)

	arg_1_0.pointProgressText = findTF(arg_1_0.pointPanel, "progressContent/progress")
	arg_1_0.pointProgressSlider = findTF(arg_1_0.pointPanel, "slider")
	arg_1_0.pointLevelStar = findTF(arg_1_0.pointPanel, "levelStar")
	arg_1_0.pointStarTpl = findTF(arg_1_0.pointPanel, "levelStar/starTpl")
	arg_1_0.pointAdd = findTF(arg_1_0.pointPanel, "add")
	arg_1_0.pointClose = findTF(arg_1_0.pointPanel, "btnClose")
	arg_1_0.pointMask = findTF(arg_1_0.pointPanel, "mask")
	arg_1_0.submitPanel = findTF(var_1_1, "submitPanel")
	arg_1_0.submitDisplayContent = findTF(arg_1_0.submitPanel, "itemDisplay/viewport/content")
	arg_1_0.submitConfirm = findTF(arg_1_0.submitPanel, "btnComfirm")
	arg_1_0.submitCancel = findTF(arg_1_0.submitPanel, "btnCancel")
	arg_1_0.subimtItem = findTF(arg_1_0.submitPanel, "itemDisplay/viewport/content/item")
	arg_1_0.submitItemDesc = findTF(arg_1_0.submitPanel, "itemDesc")
	arg_1_0.btnCancel = findTF(arg_1_0.submitPanel, "btnCancel")

	setText(findTF(arg_1_0.btnPoint, "text"), i18n(var_0_1))

	for iter_1_0 = 1, var_0_17 do
		local var_1_2 = findTF(arg_1_0.taskTagPanel, "btn" .. iter_1_0)

		setText(findTF(var_1_2, "off/text"), i18n(var_0_2[iter_1_0]))
		setText(findTF(var_1_2, "on/text"), i18n(var_0_2[iter_1_0]))
	end

	setText(findTF(arg_1_0.taskDetailPanel, "desc/title"), i18n(var_0_3))
	setText(findTF(arg_1_0.taskDetailPanel, "awardText"), i18n(var_0_4))
	setText(findTF(arg_1_0.taskDetailPanel, "btnGet/text"), i18n(var_0_6))
	setText(findTF(arg_1_0.taskDetailPanel, "btnGo/text"), i18n(var_0_5))
	setText(findTF(arg_1_0.taskDetailPanel, "btnSubmit/text"), i18n(var_0_8))
	setText(findTF(arg_1_0.taskDetailPanel, "btnDetail/text"), i18n(var_0_7))
	setText(findTF(arg_1_0.btnGetAll, "text"), i18n(var_0_9))
	setText(findTF(arg_1_0.submitPanel, "btnComfirm/text"), i18n(var_0_10))
	setText(findTF(arg_1_0.submitPanel, "btnCancel/text"), i18n(var_0_11))
	setText(findTF(arg_1_0.submitPanel, "bg/text"), i18n(var_0_15))
	setText(findTF(arg_1_0.pointPanel, "title"), i18n(var_0_1))
	setText(findTF(arg_1_0.pointPanel, "levelNum/text"), i18n(var_0_12))
	setText(findTF(arg_1_0.pointPanel, "levelBuff/text"), i18n(var_0_13))

	arg_1_0.pointStarTfs = {}

	for iter_1_1 = 1, #arg_1_0.ptBuffs do
		local var_1_3 = tf(Instantiate(arg_1_0.pointStarTpl))

		SetParent(var_1_3, arg_1_0.pointLevelStar)
		setActive(var_1_3, true)
		setText(findTF(var_1_3, "bg/text"), iter_1_1)
		setText(findTF(var_1_3, "img/text"), iter_1_1)

		var_1_3.anchoredPosition = Vector3(arg_1_0.ptBuffs[iter_1_1].pt[1] / arg_1_0.maxNum * arg_1_0.pointLevelStar.sizeDelta.x, -18, 0)

		table.insert(arg_1_0.pointStarTfs, var_1_3)

		if iter_1_1 == 1 then
			setActive(var_1_3, false)
		end
	end

	arg_1_0:updateTask()

	return
end

function var_0_0.updateTask(arg_2_0, arg_2_1)
	arg_2_0.displayTask = {}
	arg_2_0.allDisplayTask = {}

	local var_2_0 = getProxy(ActivityTaskProxy):getTaskById(arg_2_0.activityId)

	arg_2_0.getAllTasks = {}

	for iter_2_0 = 1, #var_2_0 do
		local var_2_1 = var_2_0[iter_2_0]:getProgress()
		local var_2_2 = var_2_0[iter_2_0]:getTarget()
		local var_2_3 = var_2_0[iter_2_0]:getConfig("ryza_type")
		local var_2_4 = var_2_0[iter_2_0]:getConfig("type")
		local var_2_5 = var_2_0[iter_2_0]:getConfig("sub_type")

		if var_2_3 > 0 then
			arg_2_0.displayTask[var_2_3] = arg_2_0.displayTask[var_2_3] or {}

			table.insert(arg_2_0.displayTask[var_2_3], var_2_0[iter_2_0])
			table.insert(arg_2_0.allDisplayTask, var_2_0[iter_2_0])

			if not var_2_0[iter_2_0]:isFinish() or var_2_0[iter_2_0]:isOver() or var_2_5 == 1006 then
				-- block empty
			else
				table.insert(arg_2_0.getAllTasks, var_2_0[iter_2_0].id)
			end
		end
	end

	local var_2_6 = getProxy(ActivityProxy):getActivityById(arg_2_0.activityId)
	local var_2_7 = {}

	if var_2_6 then
		var_2_7 = var_2_6.data1_list
	end

	if var_2_7 and #var_2_7 > 0 then
		for iter_2_1 = 1, #var_2_7 do
			local var_2_8 = ActivityTask.New(arg_2_0.activityId, {
				progress = 0,
				id = var_2_7[iter_2_1]
			})

			var_2_8:setOver()

			local var_2_9 = var_2_8:getConfig("ryza_type")

			if var_2_9 > 0 then
				arg_2_0.displayTask[var_2_9] = arg_2_0.displayTask[var_2_9] or {}

				table.insert(arg_2_0.displayTask[var_2_9], var_2_8)
				table.insert(arg_2_0.allDisplayTask, var_2_8)
			end
		end
	end

	local function var_2_10(arg_3_0, arg_3_1)
		if arg_3_0:isOver() and not arg_3_1:isOver() then
			return false
		elseif not arg_3_0:isOver() and arg_3_1:isOver() then
			return true
		end

		if arg_3_0:isFinish() and not arg_3_1:isFinish() then
			return true
		elseif not arg_3_0:isFinish() and arg_3_1:isFinish() then
			return false
		end

		if arg_3_0:isNew() and not arg_3_1:isNew() then
			return true
		elseif not arg_3_0:isNew() and arg_3_1:isNew() then
			return false
		end

		if arg_3_0.id > arg_3_1.id then
			return false
		elseif arg_3_0.id < arg_3_1.id then
			return true
		end

		return
	end

	for iter_2_2, iter_2_3 in pairs(arg_2_0.displayTask) do
		table.sort(iter_2_3, var_2_10)
	end

	table.sort(arg_2_0.allDisplayTask, var_2_10)

	if arg_2_1 then
		arg_2_0:onClickTag()
	end

	if #arg_2_0.getAllTasks > 0 then
		setActive(arg_2_0.btnGetAll, true)
	else
		setActive(arg_2_0.btnGetAll, false)
	end

	local var_2_11 = getProxy(PlayerProxy)
	local var_2_12 = var_2_11:getData()[arg_2_0.ptName]

	var_2_12 = var_2_12 or 0

	local var_2_13 = 1

	if var_2_12 > arg_2_0.maxNum then
		var_2_12 = arg_2_0.maxNum
	end

	for iter_2_4 = #arg_2_0.ptBuffs, 1, -1 do
		var_2_13 = var_2_12 >= arg_2_0.ptBuffs[iter_2_4].pt[1] and var_2_13 < iter_2_4 and iter_2_4 or var_2_13
	end

	for iter_2_5 = 1, #arg_2_0.pointStarTfs do
		if iter_2_5 <= var_2_13 then
			setActive(findTF(arg_2_0.pointStarTfs[iter_2_5], "img"), true)
		else
			setActive(findTF(arg_2_0.pointStarTfs[iter_2_5], "img"), false)
		end
	end

	for iter_2_6 = 1, #arg_2_0.ptBuffs[var_2_13].benefit do
		local var_2_14 = findTF(arg_2_0.pointPanel, "add/" .. iter_2_6)

		if PLATFORM_CODE == PLATFORM_JP then
			findTF(var_2_14, "img").sizeDelta = Vector2(450, 70)

			setText(findTF(var_2_14, "text_jp"), pg.benefit_buff_template[arg_2_0.ptBuffs[var_2_13].benefit[iter_2_6]].desc)
		else
			setText(findTF(var_2_14, "text"), pg.benefit_buff_template[arg_2_0.ptBuffs[var_2_13].benefit[iter_2_6]].desc)
		end
	end

	setSlider(arg_2_0.pointProgressSlider, 0, arg_2_0.maxNum, var_2_12)
	setText(arg_2_0.pointProgressText, var_2_12 .. "/" .. arg_2_0.maxNum)
	setText(findTF(arg_2_0.btnPoint, "text"), i18n(var_0_1) .. "Lv." .. var_2_13)
	setText(findTF(arg_2_0.pointPanel, "levelNum/num"), "Lv." .. var_2_13)
	setText(findTF(arg_2_0.pointPanel, "levelBuff/num"), "Lv." .. var_2_13)

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	onButton(arg_4_0, arg_4_0.btnBack, function()
		arg_4_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.btnGetAll, function()
		pg.m02:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_0.activityId,
			task_ids = arg_4_0.getAllTasks
		})

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.btnPoint, function()
		if isActive(arg_4_0.pointPanel) then
			setActive(arg_4_0.pointPanel, false)
		else
			setActive(arg_4_0.pointPanel, true)
		end

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.btnMain, function()
		arg_4_0:emit(BaseUI.ON_HOME)

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("ryza_task_help_tip")
		})

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.detailBtnGo, function()
		pg.m02:sendNotification(GAME.TASK_GO, {
			taskVO = Task.New(arg_4_0.selectTask)
		})

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.pointMask, function()
		setActive(arg_4_0.pointPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.pointClose, function()
		setActive(arg_4_0.pointPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.detailBtnSubmit, function()
		local var_13_0 = arg_4_0.selectTask:getConfig("type")

		if arg_4_0.selectTask:getConfig("sub_type") == 1006 then
			arg_4_0:openSubmitPanel(arg_4_0.selectTask)
		else
			pg.m02:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
				act_id = arg_4_0.activityId,
				task_ids = {
					arg_4_0.selectTask.id
				}
			})
		end

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.detailBtnGet, function()
		local var_14_0 = arg_4_0.selectTask:getConfig("type")

		if arg_4_0.selectTask:getConfig("sub_type") == 1006 then
			arg_4_0:openSubmitPanel(arg_4_0.selectTask)
		else
			pg.m02:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
				act_id = arg_4_0.activityId,
				task_ids = {
					arg_4_0.selectTask.id
				}
			})
		end

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.detailBtnDetail, function()
		if arg_4_0.selectTask then
			local var_15_0 = tonumber(arg_4_0.selectTask:getConfig("target_id_2"))

			if var_15_0 and var_15_0 > 0 then
				local var_15_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

				arg_4_0:emit(ActivityMediator.OPEN_LAYER, Context.New({
					mediator = AtelierMaterialDetailMediator,
					viewComponent = AtelierMaterialDetailLayer,
					data = {
						material = AtelierMaterial.New({
							configId = var_15_0,
							count = arg_4_0.selectTask:getConfig("target_num")
						})
					}
				}))
			end
		end

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.submitConfirm, function()
		pg.m02:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_0.activityId,
			task_ids = {
				arg_4_0.selectTask.id
			}
		})
		setActive(arg_4_0.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.submitCancel, function()
		setActive(arg_4_0.submitPanel, false)

		return
	end, SOUND_BACK)

	arg_4_0.btnTags = {}

	for iter_4_0 = 1, var_0_17 do
		local var_4_0 = findTF(arg_4_0.taskTagPanel, "btn" .. iter_4_0)

		onButton(arg_4_0, var_4_0, function()
			if arg_4_0.showTagIndex then
				setActive(findTF(arg_4_0.btnTags[arg_4_0.showTagIndex], "on"), false)

				if arg_4_0.showTagIndex == var_0 then
					arg_4_0.showTagIndex = nil
				else
					arg_4_0.showTagIndex = var_0

					setActive(findTF(arg_4_0.btnTags[arg_4_0.showTagIndex], "on"), true)
				end
			else
				arg_4_0.showTagIndex = var_0

				setActive(findTF(arg_4_0.btnTags[arg_4_0.showTagIndex], "on"), true)
			end

			arg_4_0:onClickTag()

			return
		end)
		table.insert(arg_4_0.btnTags, var_4_0)
	end

	function arg_4_0.scrollRect.onUpdateItem(arg_19_0, arg_19_1)
		arg_4_0:onUpdateTaskItem(arg_19_0, arg_19_1)

		return
	end

	arg_4_0.iconTfs = {}
	arg_4_0.awards = {}

	arg_4_0:onClickTag()

	local var_4_1 = false

	if PlayerPrefs.GetInt("ryza_task_help_" .. getProxy(PlayerProxy):getRawData().id) ~= 1 then
		var_4_1 = true
	end

	if var_4_1 then
		PlayerPrefs.SetInt("ryza_task_help_" .. getProxy(PlayerProxy):getRawData().id, 1)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("ryza_task_help_tip")
		})
	end

	return
end

function var_0_0.onClickTag(arg_20_0)
	print("点击了Tag")

	if arg_20_0.showTagIndex and arg_20_0.showTagIndex > 0 then
		if arg_20_0.displayTask[arg_20_0.showTagIndex] and #arg_20_0.displayTask[arg_20_0.showTagIndex] > 0 then
			arg_20_0.showTasks = arg_20_0.displayTask[arg_20_0.showTagIndex]
		else
			triggerButton(arg_20_0.btnTags[arg_20_0.showTagIndex])

			return
		end
	else
		arg_20_0.showTasks = arg_20_0.allDisplayTask
	end

	if arg_20_0.enterTaskId and arg_20_0.enterTaskId > 0 then
		for iter_20_0 = 1, #arg_20_0.showTasks do
			if arg_20_0.showTasks[iter_20_0].id == arg_20_0.enterTaskId then
				arg_20_0.scrollIndex = iter_20_0
			end
		end
	end

	if isActive(arg_20_0._tf) then
		arg_20_0.scrollRect:SetTotalCount(#arg_20_0.showTasks, 0)

		if arg_20_0.scrollIndex ~= nil then
			arg_20_0.scrollRect:ScrollTo((arg_20_0.scrollRect:HeadIndexToValue(arg_20_0.scrollIndex - 1)))
		end
	end

	return
end

function var_0_0.onUpdateTaskItem(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.exitFlag then
		return
	end

	arg_21_0.leanTweens[arg_21_2] = arg_21_2

	table.insert(arg_21_0.leanTweens, arg_21_2)

	local var_21_0 = GetComponent(arg_21_2, typeof(CanvasGroup))

	GetComponent(arg_21_2, typeof(CanvasGroup)).alpha = 0

	LeanTween.value(arg_21_2, 0, 1, 0.3):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_22_0)
		var_21_0.alpha = arg_22_0

		return
	end)):setOnComplete(System.Action(function()
		arg_21_0.leanTweens[arg_21_2] = nil

		return
	end))

	arg_21_1 = arg_21_1 + 1

	local var_21_1 = arg_21_0.showTasks[arg_21_1]
	local var_21_2 = arg_21_0.showTasks[arg_21_1].id
	local var_21_3 = arg_21_0.showTasks[arg_21_1]:getProgress()
	local var_21_4 = arg_21_0.showTasks[arg_21_1]:getConfig("name")
	local var_21_5 = arg_21_0.showTasks[arg_21_1]:getConfig("ryza_icon")
	local var_21_6 = arg_21_0.showTasks[arg_21_1]:isOver()
	local var_21_7 = arg_21_0.showTasks[arg_21_1]:isFinish()
	local var_21_8 = arg_21_0.showTasks[arg_21_1]:isCircle()

	setActive(findTF(arg_21_2, "selected"), arg_21_0.selectIndex == arg_21_1)
	setActive(findTF(arg_21_2, "typeNew"), var_21_1:isNew())
	setActive(findTF(arg_21_2, "typeCircle"), var_21_1:isCircle())
	setActive(findTF(arg_21_2, "finish"), var_21_6)
	setActive(findTF(arg_21_2, "mask"), var_21_6)
	setActive(findTF(arg_21_2, "complete"), not var_21_6 and var_21_7 and not var_21_8)
	setText(findTF(arg_21_2, "desc/text"), shortenString(var_21_4, 10))

	if not var_21_5 or var_21_5 == 0 then
		var_21_5 = "attack"
	end

	setImageSprite(findTF(arg_21_2, "icon/image"), LoadSprite(var_0_16, var_21_5))
	onButton(arg_21_0, tf(arg_21_2), function()
		if arg_21_0.selectItem then
			setActive(findTF(arg_21_0.selectItem, "selected"), false)
		end

		setActive(findTF(arg_21_2, "selected"), true)

		arg_21_0.selectIndex = arg_21_1
		arg_21_0.selectItem = arg_21_2
		arg_21_0.selectTask = var_21_1

		arg_21_0:updateDetail()

		return
	end)

	if arg_21_0.enterTaskId ~= nil and arg_21_0.enterTaskId > 0 then
		if var_21_2 == arg_21_0.enterTaskId then
			triggerButton(arg_21_2)

			arg_21_0.enterTaskId = nil
			arg_21_0.scrollIndex = nil
		end
	elseif arg_21_1 == 1 then
		triggerButton(arg_21_2)

		arg_21_0.scrollIndex = nil
	end

	return
end

function var_0_0.updateDetail(arg_25_0)
	local var_25_0 = arg_25_0.showTasks[arg_25_0.selectIndex]:getProgress()
	local var_25_1 = arg_25_0.showTasks[arg_25_0.selectIndex].target
	local var_25_2 = pg.task_data_template[arg_25_0.showTasks[arg_25_0.selectIndex].id]
	local var_25_3 = arg_25_0.showTasks[arg_25_0.selectIndex]:isFinish()
	local var_25_4 = arg_25_0.showTasks[arg_25_0.selectIndex]:isOver()
	local var_25_5 = arg_25_0.showTasks[arg_25_0.selectIndex]:isCircle()
	local var_25_6 = arg_25_0.showTasks[arg_25_0.selectIndex]:isSubmit()

	arg_25_0.awards = pg.task_data_template[arg_25_0.showTasks[arg_25_0.selectIndex].id].award_display

	local var_25_7 = var_25_2.desc
	local var_25_8 = var_25_2.ryza_icon
	local var_25_9 = arg_25_0.showTasks[arg_25_0.selectIndex]:getConfig("sub_type")

	if not var_25_2.ryza_icon or var_25_8 == 0 then
		var_25_8 = "attack"
	end

	if not var_25_6 and var_25_1 < var_25_0 then
		var_25_0 = var_25_1
	end

	setText(arg_25_0.detailDescText, var_25_7)

	if not var_25_4 then
		setText(arg_25_0.detaiProgressText, var_25_0 .. "/" .. var_25_1)
	else
		setText(arg_25_0.detaiProgressText, "--/--")
	end

	setText(arg_25_0.detailTitleText, var_25_2.name)
	setActive(arg_25_0.detailBtnDetail, var_25_9 == 1006 and not var_25_3 and not var_25_4)
	setActive(arg_25_0.detailBtnGo, not var_25_4 and not var_25_3 and var_25_9 ~= 1006)
	setActive(arg_25_0.detailBtnGet, not var_25_4 and var_25_3 and not var_25_6)
	setActive(arg_25_0.detailBtnSubmit, not var_25_4 and var_25_3 and var_25_6)
	setActive(arg_25_0.detailActive, not var_25_4 and not var_25_3 and not var_25_5)
	setImageSprite(arg_25_0.detailIcon, LoadSprite(var_0_16, var_25_8))

	if #arg_25_0.iconTfs < #arg_25_0.awards then
		for iter_25_0 = 1, #arg_25_0.awards - #arg_25_0.iconTfs do
			local var_25_10 = tf(Instantiate(arg_25_0.IconTpl))

			setParent(var_25_10, arg_25_0.detailAwardContent)
			setActive(var_25_10, true)
			table.insert(arg_25_0.iconTfs, var_25_10)
		end
	end

	for iter_25_1 = 1, #arg_25_0.iconTfs do
		if iter_25_1 <= #arg_25_0.awards then
			updateDrop(arg_25_0.iconTfs[iter_25_1], {
				type = arg_25_0.awards[iter_25_1][1],
				id = arg_25_0.awards[iter_25_1][2],
				count = arg_25_0.awards[iter_25_1][3]
			})
			onButton(arg_25_0, arg_25_0.iconTfs[iter_25_1], function()
				arg_25_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(arg_25_0.iconTfs[iter_25_1], true)
		else
			setActive(arg_25_0.iconTfs[iter_25_1], false)
		end
	end

	return
end

function var_0_0.OnUpdateFlush(arg_27_0)
	arg_27_0:updateTask(true)

	return
end

function var_0_0.OnShowFlush(arg_28_0)
	arg_28_0:updateTask(true)

	return
end

function var_0_0.openSubmitPanel(arg_29_0, arg_29_1)
	setActive(arg_29_0.submitPanel, true)

	local var_29_0 = tonumber(arg_29_1:getConfig("target_id_2"))

	updateDrop(arg_29_0.subimtItem, {
		type = DROP_TYPE_RYZA_DROP,
		id = tonumber(var_29_0),
		count = arg_29_1:getConfig("target_num")
	})
	setText(arg_29_0.submitItemDesc, pg.activity_ryza_item[var_29_0].name)

	return
end

function var_0_0.willExit(arg_30_0)
	arg_30_0.exitFlag = true

	if arg_30_0.leanTweens and #arg_30_0.leanTweens > 0 then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.leanTweens) do
			if LeanTween.isTweening(iter_30_1) then
				LeanTween.cancel(iter_30_1)
			end
		end

		arg_30_0.leanTweens = {}
	end

	for iter_30_2 = 1, #arg_30_0.allDisplayTask do
		if arg_30_0.allDisplayTask[iter_30_2]:isNew() then
			arg_30_0.allDisplayTask[iter_30_2]:changeNew()
		end
	end

	ClearLScrollrect(arg_30_0.scrollRect)

	return
end

return var_0_0
