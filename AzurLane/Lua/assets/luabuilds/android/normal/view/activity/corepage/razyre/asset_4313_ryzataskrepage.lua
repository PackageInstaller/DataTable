class = var_0_10000

local var_0_0 = "RyzaTaskRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = "ryza_task_level_desc"
local var_0_3 = "ryza_task_tag_explore"
local var_0_4 = "ryza_task_tag_battle"
local var_0_5 = "ryza_task_tag_dalegate"
local var_0_6 = "ryza_task_tag_develop"
local var_0_7 = {
	var_0_3,
	var_0_4,
	var_0_5,
	var_0_6
}
local var_0_8 = "ryza_task_detail_content"
local var_0_9 = "ryza_task_detail_award"
local var_0_10 = "ryza_task_go"
local var_0_11 = "ryza_task_get"
local var_0_12 = "ryza_task_detail"
local var_0_13 = "ryza_task_submit"
local var_0_14 = "ryza_task_get_all"
local var_0_15 = "ryza_task_confirm"
local var_0_16 = "ryza_task_cancel"
local var_0_17 = "ryza_task_level_num"
local var_0_18 = "ryza_task_level_add"
local var_0_19 = "ryza_task_empty_tag"
local var_0_20 = "sub_item_warning"
local var_0_21 = "ui/ryzaicon_atlas"
local var_0_22 = 4
local var_0_23 = 5
local var_0_24 = 4

function var_0_1.OnInit(arg_1_0)
	ActivityConst = var_1_10001
	arg_1_0.activityId = var_1_10001.RYZA_TASK

	local var_1_0

	if not arg_1_0.contextData.task_id then
		var_1_0 = nil
	end

	arg_1_0.enterTaskId = var_1_0
	pg = var_1_0
	arg_1_0.taskGroups = var_1_0.activity_template[arg_1_0.activityId].config_data
	arg_1_0.leanTweens = {}
	arg_1_0.exitFlag = false
	pg = var_1

	local var_1_1 = var_1.activity_template[arg_1_0.activityId].config_client

	pg = var_2
	arg_1_0.ptName = var_2.player_resource[var_1_1.pt_id].name
	arg_1_0.ptBuffs = var_1_1.pt_buff
	arg_1_0.maxNum = arg_1_0.ptBuffs[#arg_1_0.ptBuffs].pt[1]
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tf, "AD")

	findTF = var_3
	arg_1_0.btnBack = var_3(var_1_2, "btnBack")
	findTF = var_3
	arg_1_0.btnMain = var_3(var_1_2, "btnMain")
	findTF = var_3
	arg_1_0.btnHelp = var_3(var_1_2, "btnHelp")
	findTF = var_3
	arg_1_0.btnGetAll = var_3(var_1_2, "btnGetAll")
	findTF = var_3
	arg_1_0.btnPoint = var_3(var_1_2, "btnPoint")
	findTF = var_3
	arg_1_0.imgPoint = var_3(var_1_2, "btnPoint/imgPoint")
	findTF = var_3
	arg_1_0.taskTagPanel = var_3(var_1_2, "taskTagPanel")
	findTF = var_3
	arg_1_0.taskListPanel = var_3(var_1_2, "taskListPanel")
	findTF = var_3

	local var_1_3 = var_3(var_1_2, "taskListPanel/Content")

	arg_1_0.scrollRect = var_3.GetComponent(var_1_3, "LScrollRect")
	findTF = var_3
	arg_1_0.taskDetailPanel = var_3(var_1_2, "taskDetailPanel")
	findTF = var_3
	arg_1_0.detailTag = var_3(arg_1_0.taskDetailPanel, "tag")
	findTF = var_3
	arg_1_0.detailTitleText = var_3(arg_1_0.taskDetailPanel, "title/text")
	findTF = var_3
	arg_1_0.detailIcon = var_3(arg_1_0.taskDetailPanel, "icon/image")
	findTF = var_3
	arg_1_0.detailDescText = var_3(arg_1_0.taskDetailPanel, "desc/text")
	findTF = var_3
	arg_1_0.detaiProgressText = var_3(arg_1_0.taskDetailPanel, "progress/text")
	findTF = var_3
	arg_1_0.detailAwardContent = var_3(arg_1_0.taskDetailPanel, "awardDisplay/viewport/content")
	findTF = var_3
	arg_1_0.detailBtnGo = var_3(arg_1_0.taskDetailPanel, "btnGo")
	findTF = var_3
	arg_1_0.detailBtnGet = var_3(arg_1_0.taskDetailPanel, "btnGet")
	findTF = var_3
	arg_1_0.detailBtnSubmit = var_3(arg_1_0.taskDetailPanel, "btnSubmit")
	findTF = var_3
	arg_1_0.detailBtnDetail = var_3(arg_1_0.taskDetailPanel, "btnDetail")
	findTF = var_3
	arg_1_0.detailActive = var_3(arg_1_0.taskDetailPanel, "active")
	findTF = var_3
	arg_1_0.taskItemTpl = var_3(var_1_2, "tpl/taskItemTpl")
	findTF = var_3
	arg_1_0.IconTpl = var_3(var_1_2, "tpl/IconTpl")
	findTF = var_3

	local var_1_4 = var_3(arg_1_0._tf, "AD/pop")

	findTF = var_4
	arg_1_0.pointPanel = var_4(var_1_4, "pointPanel")
	setActive = var_4

	var_4(arg_1_0.pointPanel, false)

	findTF = var_4
	arg_1_0.pointProgressText = var_4(arg_1_0.pointPanel, "progressContent/progress")
	findTF = var_4
	arg_1_0.pointProgressSlider = var_4(arg_1_0.pointPanel, "slider")
	findTF = var_4
	arg_1_0.pointLevelStar = var_4(arg_1_0.pointPanel, "levelStar")
	findTF = var_4
	arg_1_0.pointStarTpl = var_4(arg_1_0.pointPanel, "levelStar/starTpl")
	findTF = var_4
	arg_1_0.pointAdd = var_4(arg_1_0.pointPanel, "add")
	findTF = var_4
	arg_1_0.pointClose = var_4(arg_1_0.pointPanel, "btnClose")
	findTF = var_4
	arg_1_0.pointMask = var_4(arg_1_0.pointPanel, "mask")
	findTF = var_4
	arg_1_0.submitPanel = var_4(var_1_4, "submitPanel")
	findTF = var_4
	arg_1_0.submitDisplayContent = var_4(arg_1_0.submitPanel, "itemDisplay/viewport/content")
	findTF = var_4
	arg_1_0.submitConfirm = var_4(arg_1_0.submitPanel, "btnComfirm")
	findTF = var_4
	arg_1_0.submitCancel = var_4(arg_1_0.submitPanel, "btnCancel")
	findTF = var_4
	arg_1_0.subimtItem = var_4(arg_1_0.submitPanel, "itemDisplay/viewport/content/item")
	findTF = var_4
	arg_1_0.submitItemDesc = var_4(arg_1_0.submitPanel, "itemDesc")
	findTF = var_4
	arg_1_0.btnCancel = var_4(arg_1_0.submitPanel, "btnCancel")
	setText = var_4
	findTF = var_5

	local var_1_5 = var_5(arg_1_0.btnPoint, "text")

	i18n = var_6

	var_4(var_1_5, var_6(var_0_2))

	for iter_1_0 = 1, var_0_22 do
		findTF = var_1_10008
		var_1_10008 = var_1_10008(arg_1_0.taskTagPanel, "btn" .. iter_1_0)
		setText = var_1_10009
		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_1_10008, "off/text")
		i18n = var_11

		var_1_10009(var_1_10010, var_11(var_0_7[iter_1_0]))

		setText = var_1_10009
		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_1_10008, "on/text")
		i18n = var_11

		var_1_10009(var_1_10010, var_11(var_0_7[iter_1_0]))
	end

	setText = var_4
	findTF = var_5

	local var_1_6 = var_5(arg_1_0.taskDetailPanel, "desc/title")

	i18n = var_6

	var_4(var_1_6, var_6(var_0_8))

	setText = var_4
	findTF = var_1_6

	local var_1_7 = var_1_6(arg_1_0.taskDetailPanel, "awardText")

	i18n = var_6

	var_4(var_1_7, var_6(var_0_9))

	setText = var_4
	findTF = var_1_7

	local var_1_8 = var_1_7(arg_1_0.taskDetailPanel, "btnGet/text")

	i18n = var_6

	var_4(var_1_8, var_6(var_0_11))

	setText = var_4
	findTF = var_1_8

	local var_1_9 = var_1_8(arg_1_0.taskDetailPanel, "btnGo/text")

	i18n = var_6

	var_4(var_1_9, var_6(var_0_10))

	setText = var_4
	findTF = var_1_9

	local var_1_10 = var_1_9(arg_1_0.taskDetailPanel, "btnSubmit/text")

	i18n = var_6

	var_4(var_1_10, var_6(var_0_13))

	setText = var_4
	findTF = var_1_10

	local var_1_11 = var_1_10(arg_1_0.taskDetailPanel, "btnDetail/text")

	i18n = var_6

	var_4(var_1_11, var_6(var_0_12))

	setText = var_4
	findTF = var_1_11

	local var_1_12 = var_1_11(arg_1_0.btnGetAll, "text")

	i18n = var_6

	var_4(var_1_12, var_6(var_0_14))

	setText = var_4
	findTF = var_1_12

	local var_1_13 = var_1_12(arg_1_0.submitPanel, "btnComfirm/text")

	i18n = var_6

	var_4(var_1_13, var_6(var_0_15))

	setText = var_4
	findTF = var_1_13

	local var_1_14 = var_1_13(arg_1_0.submitPanel, "btnCancel/text")

	i18n = var_6

	var_4(var_1_14, var_6(var_0_16))

	setText = var_4
	findTF = var_1_14

	local var_1_15 = var_1_14(arg_1_0.submitPanel, "bg/text")

	i18n = var_6

	var_4(var_1_15, var_6(var_0_20))

	setText = var_4
	findTF = var_1_15

	local var_1_16 = var_1_15(arg_1_0.pointPanel, "title")

	i18n = var_6

	var_4(var_1_16, var_6(var_0_2))

	setText = var_4
	findTF = var_1_16

	local var_1_17 = var_1_16(arg_1_0.pointPanel, "levelNum/text")

	i18n = var_6

	var_4(var_1_17, var_6(var_0_17))

	setText = var_4
	findTF = var_1_17

	local var_1_18 = var_1_17(arg_1_0.pointPanel, "levelBuff/text")

	i18n = var_6

	var_4(var_1_18, var_6(var_0_18))

	arg_1_0.pointStarTfs = {}

	local var_1_19 = arg_1_0.pointLevelStar.sizeDelta.x

	for iter_1_1 = 1, #arg_1_0.ptBuffs do
		tf = var_1_10009
		Instantiate = var_1_10010
		var_1_10009 = var_1_10009(var_1_10010(arg_1_0.pointStarTpl))
		SetParent = var_1_10010

		var_1_10010(var_1_10009, arg_1_0.pointLevelStar)

		setActive = var_1_10010

		var_1_10010(var_1_10009, true)

		setText = var_1_10010
		findTF = var_11

		var_1_10010(var_11(var_1_10009, "bg/text"), iter_1_1)

		setText = var_1_10010
		findTF = var_11

		var_1_10010(var_11(var_1_10009, "img/text"), iter_1_1)

		var_1_10010 = arg_1_0.ptBuffs[iter_1_1].pt[1]
		Vector3 = var_11
		var_1_10009.anchoredPosition = var_11(var_1_10010 / arg_1_0.maxNum * var_1_19, -18, 0)
		table = var_11

		var_11.insert(arg_1_0.pointStarTfs, var_1_10009)

		if iter_1_1 == 1 then
			setActive = var_11

			var_11(var_1_10009, false)
		end
	end

	arg_1_0:updateTask()

	return
end

function var_0_1.updateTask(arg_2_0, arg_2_1)
	arg_2_0.displayTask = {}
	arg_2_0.allDisplayTask = {}
	getProxy = var_2
	ActivityTaskProxy = var_1_10003

	local var_2_0 = var_2(var_1_10003)
	local var_2_1 = var_2.getTaskById(var_2_0, arg_2_0.activityId)

	arg_2_0.getAllTasks = {}

	for iter_2_0 = 1, #var_2_1 do
		local var_2_2 = var_2_1[iter_2_0].id

		var_1_10010 = var_7

		local var_2_3 = var_7.getProgress(var_1_10010)

		var_1_10011 = var_7
		var_1_10010 = var_7.getTarget(var_1_10011)
		var_1_10011 = var_7:getConfig("ryza_type")
		var_1_10013 = var_7

		local var_2_4 = var_7.getConfig(var_1_10013, "type")

		var_1_10014 = var_7
		var_1_10013 = var_7.getConfig(var_1_10014, "sub_type")

		if 0 < var_1_10011 then
			if not arg_2_0.displayTask[var_1_10011] then
				var_1_10014 = arg_2_0.displayTask
				var_1_10014[var_1_10011] = {}
			end

			table = var_1_10014

			var_1_10014.insert(arg_2_0.displayTask[var_1_10011], var_7)

			table = var_1_10014

			var_1_10014.insert(arg_2_0.allDisplayTask, var_7)

			var_1_10015 = var_7

			if var_7.isFinish(var_1_10015) then
				var_1_10015 = var_7

				if var_7.isOver(var_1_10015) or var_1_10013 == 1006 then
					-- block empty
				else
					table = var_1_10014

					var_1_10014.insert(arg_2_0.getAllTasks, var_2_2)
				end
			end
		end
	end

	getProxy = var_3
	ActivityProxy = var_4

	local var_2_5 = var_3(var_4)
	local var_2_6 = var_3.getActivityById(var_2_5, arg_2_0.activityId)
	local var_2_7 = {}

	if var_2_6 then
		var_2_7 = var_2_6.data1_list
	end

	if var_2_7 then
		local var_2_8 = #var_2_7

		if 0 < var_2_8 then
			for iter_2_1 = 1, #var_2_7 do
				local var_2_9 = var_2_7[iter_2_1]

				ActivityTask = var_1_10010

				local var_2_10 = var_1_10010.New(arg_2_0.activityId, {
					progress = 0,
					id = var_2_9
				})

				var_1_10010.setOver(var_2_10)

				if var_1_10010:getConfig("ryza_type") > 0 then
					local var_2_11

					if not arg_2_0.displayTask[var_1_10011] then
						var_2_11 = arg_2_0.displayTask
						var_2_11[var_1_10011] = {}
					end

					table = var_2_11

					var_2_11.insert(arg_2_0.displayTask[var_1_10011], var_1_10010)

					table = var_12

					var_12.insert(arg_2_0.allDisplayTask, var_1_10010)
				end
			end
		end
	end

	local function var_2_12(arg_3_0, arg_3_1)
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

	pairs = iter_2_0

	for iter_2_2, iter_2_3 in iter_2_0(arg_2_0.displayTask) do
		table = var_1_10011

		var_1_10011.sort(iter_2_3, var_2_12)
	end

	table = var_6

	var_6.sort(arg_2_0.allDisplayTask, var_2_12)

	if arg_2_1 then
		arg_2_0:onClickTag()
	end

	local var_2_13 = #arg_2_0.getAllTasks

	if 0 < var_2_13 then
		setActive = var_2_13

		var_2_13(arg_2_0.btnGetAll, true)
	else
		setActive = var_2_13

		var_2_13(arg_2_0.btnGetAll, false)
	end

	getProxy = var_2_13
	PlayerProxy = var_7

	local var_2_14 = var_2_13(var_7)
	local var_2_15

	if not var_6.getData(var_2_14)[arg_2_0.ptName] then
		var_2_15 = 0
	end

	local var_2_16 = 1

	if var_2_15 > arg_2_0.maxNum then
		var_2_15 = arg_2_0.maxNum
	end

	for iter_2_4 = #arg_2_0.ptBuffs, 1, -1 do
		var_2_16 = arg_2_0.ptBuffs[iter_2_4].pt[1] <= var_2_15 and var_2_16 < iter_2_4 and iter_2_4 or var_2_16
	end

	for iter_2_5 = 1, #arg_2_0.pointStarTfs do
		local var_2_17 = arg_2_0.pointStarTfs[iter_2_5]

		if iter_2_5 <= var_2_16 then
			setActive = var_1_10013
			findTF = var_1_10014

			var_1_10013(var_1_10014(var_2_17, "img"), true)
		else
			setActive = var_1_10013
			findTF = var_1_10014

			var_1_10013(var_1_10014(var_2_17, "img"), false)
		end
	end

	local var_2_18 = arg_2_0.ptBuffs[var_2_16].benefit

	for iter_2_6 = 1, #var_2_18 do
		local var_2_19 = var_2_18[iter_2_6]

		pg = var_1_10014
		var_1_10014 = var_1_10014.benefit_buff_template[var_2_19].desc
		findTF = var_1_10015
		var_1_10015 = var_1_10015(arg_2_0.pointPanel, "add/" .. iter_2_6)
		PLATFORM_CODE = var_2_20
		PLATFORM_JP = var_17

		local var_2_20

		if var_2_20 == var_17 then
			findTF = var_2_20
			var_2_20 = var_2_20(var_1_10015, "img")
			Vector2 = var_17
			var_2_20.sizeDelta = var_17(450, 70)
			setText = var_2_20
			findTF = var_17

			var_2_20(var_17(var_1_10015, "text_jp"), var_1_10014)
		else
			setText = var_2_20
			findTF = var_17

			var_2_20(var_17(var_1_10015, "text"), var_1_10014)
		end
	end

	setSlider = var_9

	var_9(arg_2_0.pointProgressSlider, 0, arg_2_0.maxNum, var_2_15)

	setText = var_9

	var_9(arg_2_0.pointProgressText, var_2_15 .. "/" .. arg_2_0.maxNum)

	setText = var_9
	findTF = var_10

	local var_2_21 = var_10(arg_2_0.btnPoint, "text")

	i18n = var_11

	var_9(var_2_21, var_11(var_0_2) .. "Lv." .. var_2_16)

	setText = var_9
	findTF = var_2_21

	var_9(var_2_21(arg_2_0.pointPanel, "levelNum/num"), "Lv." .. var_2_16)

	setText = var_9
	findTF = var_10

	var_9(var_10(arg_2_0.pointPanel, "levelBuff/num"), "Lv." .. var_2_16)

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnBack

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.btnGetAll

	local function var_4_5()
		local var_6_0 = arg_4_0.getAllTasks

		pg = var_2_10001

		local var_6_1 = var_2_10001.m02
		local var_6_2 = var_1.sendNotification

		GAME = var_2_10003

		var_6_2(var_6_1, var_2_10003.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_0.activityId,
			task_ids = var_6_0
		})

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10005)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.btnPoint

	local function var_4_8()
		isActive = var_2_10000

		if var_2_10000(arg_4_0.pointPanel) then
			setActive = var_0

			var_0(arg_4_0.pointPanel, false)
		else
			setActive = var_0

			var_0(arg_4_0.pointPanel, true)
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10005)

	onButton = var_1_10001

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.btnMain

	local function var_4_11()
		local var_8_0 = arg_4_0
		local var_8_1 = var_0.emit

		BaseUI = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_HOME)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_9, var_4_10, var_4_11, var_1_10005)

	onButton = var_1_10001

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.btnHelp

	local function var_4_14()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		i18n = var_2_10003
		var_9_2.helps = var_2_10003("ryza_task_help_tip")

		var_9_1(var_9_0, var_9_2)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_12, var_4_13, var_4_14, var_1_10005)

	onButton = var_1_10001

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.detailBtnGo

	local function var_4_17()
		Task = var_2_10000

		local var_10_0 = var_2_10000.New(arg_4_0.selectTask)

		pg = var_1

		local var_10_1 = var_1.m02
		local var_10_2 = var_1.sendNotification

		GAME = var_2_10003

		var_10_2(var_10_1, var_2_10003.TASK_GO, {
			taskVO = var_10_0
		})

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_15, var_4_16, var_4_17, var_1_10005)

	onButton = var_1_10001

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_0.pointMask

	local function var_4_20()
		setActive = var_2_10000

		var_2_10000(arg_4_0.pointPanel, false)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_18, var_4_19, var_4_20, var_1_10005)

	onButton = var_1_10001

	local var_4_21 = arg_4_0
	local var_4_22 = arg_4_0.pointClose

	local function var_4_23()
		setActive = var_2_10000

		var_2_10000(arg_4_0.pointPanel, false)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_21, var_4_22, var_4_23, var_1_10005)

	onButton = var_1_10001

	local var_4_24 = arg_4_0
	local var_4_25 = arg_4_0.detailBtnSubmit

	local function var_4_26()
		local var_13_0 = arg_4_0.selectTask
		local var_13_1 = var_0.getConfig(var_13_0, "type")
		local var_13_2 = arg_4_0.selectTask

		if var_1.getConfig(var_13_2, "sub_type") == 1006 then
			local var_13_3 = arg_4_0

			var_13_2.openSubmitPanel(var_13_3, arg_4_0.selectTask)
		else
			pg = var_13_2

			local var_13_4 = var_13_2.m02
			local var_13_5 = var_2.sendNotification

			GAME = var_2_10004

			var_13_5(var_13_4, var_2_10004.SUBMIT_ACTIVITY_TASK, {
				act_id = arg_4_0.activityId,
				task_ids = {
					arg_4_0.selectTask.id
				}
			})
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_24, var_4_25, var_4_26, var_1_10005)

	onButton = var_1_10001

	local var_4_27 = arg_4_0
	local var_4_28 = arg_4_0.detailBtnGet

	local function var_4_29()
		local var_14_0 = arg_4_0.selectTask
		local var_14_1 = var_0.getConfig(var_14_0, "type")
		local var_14_2 = arg_4_0.selectTask

		if var_1.getConfig(var_14_2, "sub_type") == 1006 then
			local var_14_3 = arg_4_0

			var_14_2.openSubmitPanel(var_14_3, arg_4_0.selectTask)
		else
			pg = var_14_2

			local var_14_4 = var_14_2.m02
			local var_14_5 = var_2.sendNotification

			GAME = var_2_10004

			var_14_5(var_14_4, var_2_10004.SUBMIT_ACTIVITY_TASK, {
				act_id = arg_4_0.activityId,
				task_ids = {
					arg_4_0.selectTask.id
				}
			})
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_27, var_4_28, var_4_29, var_1_10005)

	onButton = var_1_10001

	local var_4_30 = arg_4_0
	local var_4_31 = arg_4_0.detailBtnDetail

	local function var_4_32()
		if arg_4_0.selectTask then
			tonumber = var_0

			local var_15_0 = arg_4_0.selectTask

			if var_0(var_1.getConfig(var_15_0, "target_id_2")) and 0 < var_0 then
				getProxy = var_1
				ActivityProxy = var_15_0

				local var_15_1 = var_1(var_15_0)
				local var_15_2 = var_1.getActivityByType

				ActivityConst = var_3

				local var_15_3 = var_15_2(var_15_1, var_3.ACTIVITY_TYPE_ATELIER_LINK)

				AtelierMaterial = var_15_1

				local var_15_4 = var_15_1.New
				local var_15_5 = {
					configId = var_0
				}
				local var_15_6 = arg_4_0.selectTask

				var_15_5.count = var_4.getConfig(var_15_6, "target_num")

				local var_15_7 = var_15_4(var_15_5)
				local var_15_8 = arg_4_0
				local var_15_9 = var_3.emit

				ActivityMediator = var_15_6

				local var_15_10 = var_15_6.OPEN_LAYER

				Context = var_6

				local var_15_11 = var_6.New
				local var_15_12 = {}

				AtelierMaterialDetailMediator = var_2_10008
				var_15_12.mediator = var_2_10008
				AtelierMaterialDetailLayer = var_2_10008
				var_15_12.viewComponent = var_2_10008
				var_15_12.data = {
					material = var_15_7
				}

				var_15_9(var_15_8, var_15_10, var_15_11(var_15_12))
			end
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_30, var_4_31, var_4_32, var_1_10005)

	onButton = var_1_10001

	local var_4_33 = arg_4_0
	local var_4_34 = arg_4_0.submitConfirm

	local function var_4_35()
		pg = var_2_10000

		local var_16_0 = var_2_10000.m02
		local var_16_1 = var_0.sendNotification

		GAME = var_2_10002

		var_16_1(var_16_0, var_2_10002.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_0.activityId,
			task_ids = {
				arg_4_0.selectTask.id
			}
		})

		setActive = var_16_1

		var_16_1(arg_4_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_33, var_4_34, var_4_35, var_1_10005)

	onButton = var_1_10001

	local var_4_36 = arg_4_0
	local var_4_37 = arg_4_0.submitCancel

	local function var_4_38()
		setActive = var_2_10000

		var_2_10000(arg_4_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_36, var_4_37, var_4_38, var_1_10005)

	arg_4_0.btnTags = {}

	for iter_4_0 = 1, var_0_22 do
		var_1_10005 = iter_4_0
		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_4_0.taskTagPanel, "btn" .. var_1_10005)
		onButton = var_7

		var_7(arg_4_0, var_1_10006, function()
			if arg_4_0.showTagIndex then
				setActive = var_0
				findTF = var_2_10001

				var_0(var_2_10001(arg_4_0.btnTags[arg_4_0.showTagIndex], "on"), false)

				if arg_4_0.showTagIndex == var_1_10005 then
					arg_4_0.showTagIndex = nil
				else
					local var_18_0 = arg_4_0

					var_18_0.showTagIndex = var_1_10005
					setActive = var_18_0
					findTF = var_1

					var_18_0(var_1(arg_4_0.btnTags[arg_4_0.showTagIndex], "on"), true)
				end
			else
				local var_18_1 = arg_4_0

				var_18_1.showTagIndex = var_1_10005
				setActive = var_18_1
				findTF = var_1

				var_18_1(var_1(arg_4_0.btnTags[arg_4_0.showTagIndex], "on"), true)
			end

			local var_18_2 = arg_4_0

			var_0.onClickTag(var_18_2)

			return
		end)

		table = var_7

		var_7.insert(arg_4_0.btnTags, var_1_10006)
	end

	function arg_4_0.scrollRect.onUpdateItem(arg_19_0, arg_19_1)
		local var_19_0 = arg_4_0

		var_2.onUpdateTaskItem(var_19_0, arg_19_0, arg_19_1)

		return
	end

	arg_4_0.iconTfs = {}
	arg_4_0.awards = {}

	local var_4_39 = arg_4_0

	arg_4_0.onClickTag(var_4_39)

	local var_4_40 = false

	PlayerPrefs = var_4_39

	local var_4_41 = var_4_39.GetInt
	local var_4_42 = "ryza_task_help_"

	getProxy = iter_4_0
	PlayerProxy = var_1_10005

	local var_4_43 = iter_4_0(var_1_10005)

	if var_4_41(var_4_42 .. var_4.getRawData(var_4_43).id) ~= 1 then
		var_4_40 = true
	end

	if var_4_40 then
		PlayerPrefs = var_3

		local var_4_44 = var_3.SetInt
		local var_4_45 = "ryza_task_help_"

		getProxy = var_4_43
		PlayerProxy = var_1_10006

		local var_4_46 = var_4_43(var_1_10006)

		var_4_44(var_4_45 .. var_5.getRawData(var_4_46).id, 1)

		pg = var_4_44

		local var_4_47 = var_4_44.MsgboxMgr.GetInstance()
		local var_4_48 = var_3.ShowMsgBox
		local var_4_49 = {}

		MSGBOX_TYPE_HELP = var_4_46
		var_4_49.type = var_4_46
		i18n = var_4_46
		var_4_49.helps = var_4_46("ryza_task_help_tip")

		var_4_48(var_4_47, var_4_49)
	end

	return
end

function var_0_1.onClickTag(arg_20_0)
	print = var_1_10001

	var_1_10001("点击了Tag")

	if arg_20_0.showTagIndex and var_1 > 0 then
		if arg_20_0.displayTask[var_1] and #arg_20_0.displayTask[var_1] > 0 then
			arg_20_0.showTasks = arg_20_0.displayTask[var_1]
		else
			triggerButton = var_2

			var_2(arg_20_0.btnTags[arg_20_0.showTagIndex])

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

	isActive = var_2

	if var_2(arg_20_0._tf) then
		local var_20_0 = arg_20_0.scrollRect

		var_2.SetTotalCount(var_20_0, #arg_20_0.showTasks, 0)

		if arg_20_0.scrollIndex ~= nil then
			local var_20_1 = arg_20_0.scrollRect
			local var_20_2 = var_2.HeadIndexToValue(var_20_1, arg_20_0.scrollIndex - 1)
			local var_20_3 = arg_20_0.scrollRect

			var_3.ScrollTo(var_20_3, var_20_2)
		end
	end

	return
end

function var_0_1.onUpdateTaskItem(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.exitFlag then
		return
	end

	local var_21_0 = arg_21_0.leanTweens

	var_21_0[arg_21_2] = arg_21_2
	table = var_21_0

	var_21_0.insert(arg_21_0.leanTweens, arg_21_2)

	GetComponent = var_3

	local var_21_1 = arg_21_2

	typeof = var_5
	CanvasGroup = var_1_10006

	local var_21_2 = var_3(var_21_1, var_5(var_1_10006))

	var_21_2.alpha = 0
	LeanTween = var_4

	local var_21_3 = var_4.value(arg_21_2, 0, 1, 0.3)
	local var_21_4 = var_4.setEase

	LeanTweenType = var_6

	local var_21_5 = var_21_4(var_21_3, var_6.linear)
	local var_21_6 = var_4.setOnUpdate

	System = var_6

	local var_21_7 = var_21_6(var_21_5, var_6.Action_float(function(arg_22_0)
		var_21_2.alpha = arg_22_0

		return
	end))
	local var_21_8 = var_4.setOnComplete

	System = var_6

	var_21_8(var_21_7, var_6.Action(function()
		arg_21_0.leanTweens[arg_21_2] = nil

		return
	end))

	arg_21_1 = arg_21_1 + 1

	local var_21_9 = arg_21_0.showTasks[arg_21_1].id
	local var_21_10 = var_4:getProgress()
	local var_21_11 = var_4:getConfig("name")
	local var_21_12 = var_4:getConfig("ryza_icon")
	local var_21_13 = var_4:isOver()
	local var_21_14 = var_4:isFinish()
	local var_21_15 = var_4
	local var_21_16 = var_4.isCircle(var_21_15)

	setActive = var_21_15
	findTF = var_1_10013

	var_21_15(var_1_10013(arg_21_2, "selected"), arg_21_0.selectIndex == arg_21_1)

	setActive = var_21_15
	findTF = var_13

	var_21_15(var_13(arg_21_2, "typeNew"), var_4:isNew())

	setActive = var_21_15
	findTF = var_13

	var_21_15(var_13(arg_21_2, "typeCircle"), var_4:isCircle())

	setActive = var_21_15
	findTF = var_13

	var_21_15(var_13(arg_21_2, "finish"), var_21_13)

	setActive = var_21_15
	findTF = var_13

	var_21_15(var_13(arg_21_2, "mask"), var_21_13)

	setActive = var_21_15
	findTF = var_13

	var_21_15(var_13(arg_21_2, "complete"), not var_21_13 and var_21_14 and not var_21_16)

	setText = var_21_15
	findTF = var_13

	local var_21_17 = var_13(arg_21_2, "desc/text")

	shortenString = var_14

	var_21_15(var_21_17, var_14(var_21_11, 10))

	if not var_21_12 or var_21_12 == 0 then
		var_21_12 = "attack"
	end

	setImageSprite = var_21_15
	findTF = var_21_17

	local var_21_18 = var_21_17(arg_21_2, "icon/image")

	LoadSprite = var_14

	var_21_15(var_21_18, var_14(var_0_21, var_21_12))

	onButton = var_21_15

	local var_21_19 = arg_21_0

	tf = var_14

	var_21_15(var_21_19, var_14(arg_21_2), function()
		if arg_21_0.selectItem then
			setActive = var_0
			findTF = var_2_10001

			var_0(var_2_10001(arg_21_0.selectItem, "selected"), false)
		end

		setActive = var_0
		findTF = var_2_10001

		var_0(var_2_10001(arg_21_2, "selected"), true)

		arg_21_0.selectIndex = arg_21_1
		arg_21_0.selectItem = arg_21_2
		arg_21_0.selectTask = var_0

		local var_24_0 = arg_21_0

		var_0.updateDetail(var_24_0)

		return
	end)

	if arg_21_0.enterTaskId ~= nil and arg_21_0.enterTaskId > 0 then
		if var_21_9 == arg_21_0.enterTaskId then
			triggerButton = var_12

			var_12(arg_21_2)

			arg_21_0.enterTaskId = nil
			arg_21_0.scrollIndex = nil
		end
	elseif arg_21_1 == 1 then
		triggerButton = var_12

		var_12(arg_21_2)

		arg_21_0.scrollIndex = nil
	end

	return
end

function var_0_1.updateDetail(arg_25_0)
	local var_25_0 = arg_25_0.showTasks[arg_25_0.selectIndex].id
	local var_25_1 = var_1:getProgress()
	local var_25_2 = var_1.target

	pg = var_1_10005

	local var_25_3 = var_1_10005.task_data_template[var_25_0]
	local var_25_4 = var_1:isFinish()
	local var_25_5 = var_1:isOver()
	local var_25_6 = var_1:isCircle()
	local var_25_7 = var_1:isSubmit()

	arg_25_0.awards = var_25_3.award_display

	local var_25_8 = var_25_3.desc
	local var_25_9 = var_25_3.ryza_icon
	local var_25_10 = var_1
	local var_25_11 = var_1.getConfig(var_25_10, "sub_type")

	if not var_25_9 or var_25_9 == 0 then
		var_25_9 = "attack"
	end

	if not var_25_7 and var_25_2 < var_25_1 then
		var_25_1 = var_25_2
	end

	setText = var_25_10

	var_25_10(arg_25_0.detailDescText, var_25_8)

	if not var_25_5 then
		setText = var_25_10

		var_25_10(arg_25_0.detaiProgressText, var_25_1 .. "/" .. var_25_2)
	else
		setText = var_25_10

		var_25_10(arg_25_0.detaiProgressText, "--/--")
	end

	setText = var_25_10

	var_25_10(arg_25_0.detailTitleText, var_25_3.name)

	setActive = var_25_10

	var_25_10(arg_25_0.detailBtnDetail, var_25_11 == 1006 and not var_25_4 and not var_25_5)

	setActive = var_25_10

	var_25_10(arg_25_0.detailBtnGo, not var_25_5 and not var_25_4 and var_25_11 ~= 1006)

	setActive = var_25_10

	var_25_10(arg_25_0.detailBtnGet, not var_25_5 and var_25_4 and not var_25_7)

	setActive = var_25_10

	var_25_10(arg_25_0.detailBtnSubmit, not var_25_5 and var_25_4 and var_25_7)

	setActive = var_25_10

	var_25_10(arg_25_0.detailActive, not var_25_5 and not var_25_4 and not var_25_6)

	setImageSprite = var_25_10

	local var_25_12 = arg_25_0.detailIcon

	LoadSprite = var_15

	var_25_10(var_25_12, var_15(var_0_21, var_25_9))

	if #arg_25_0.iconTfs < #arg_25_0.awards then
		local var_25_13 = #arg_25_0.awards - #arg_25_0.iconTfs

		for iter_25_0 = 1, var_25_13 do
			tf = var_1_10018
			Instantiate = var_1_10019
			var_1_10018 = var_1_10018(var_1_10019(arg_25_0.IconTpl))
			setParent = var_1_10019

			var_1_10019(var_1_10018, arg_25_0.detailAwardContent)

			setActive = var_1_10019

			var_1_10019(var_1_10018, true)

			table = var_1_10019

			var_1_10019.insert(arg_25_0.iconTfs, var_1_10018)
		end
	end

	for iter_25_1 = 1, #arg_25_0.iconTfs do
		local var_25_14

		if iter_25_1 <= #arg_25_0.awards then
			var_25_14 = arg_25_0.awards[iter_25_1]

			local var_25_15 = {
				type = var_25_14[1],
				id = var_25_14[2],
				count = var_25_14[3]
			}

			updateDrop = var_19

			var_19(arg_25_0.iconTfs[iter_25_1], var_25_15)

			onButton = var_19

			local var_25_16 = arg_25_0
			local var_25_17 = arg_25_0.iconTfs[iter_25_1]

			local function var_25_18()
				local var_26_0 = arg_25_0
				local var_26_1 = var_0.emit

				BaseUI = var_2_10002

				var_26_1(var_26_0, var_2_10002.ON_DROP, var_25_15)

				return
			end

			SFX_PANEL = var_1_10023

			var_19(var_25_16, var_25_17, var_25_18, var_1_10023)

			setActive = var_19

			var_19(arg_25_0.iconTfs[iter_25_1], true)
		else
			setActive = var_25_14

			var_25_14(arg_25_0.iconTfs[iter_25_1], false)
		end
	end

	return
end

function var_0_1.OnUpdateFlush(arg_27_0)
	arg_27_0:updateTask(true)

	return
end

function var_0_1.OnShowFlush(arg_28_0)
	arg_28_0:updateTask(true)

	return
end

function var_0_1.openSubmitPanel(arg_29_0, arg_29_1)
	setActive = var_1_10002

	var_1_10002(arg_29_0.submitPanel, true)

	tonumber = var_1_10002

	local var_29_0 = arg_29_1
	local var_29_1 = var_1_10002(arg_29_1.getConfig(var_29_0, "target_id_2"))

	pg = var_3

	local var_29_2 = var_3.activity_ryza_item[var_29_1].name

	updateDrop = var_29_0

	local var_29_3 = arg_29_0.subimtItem
	local var_29_4 = {}

	DROP_TYPE_RYZA_DROP = var_1_10007
	var_29_4.type = var_1_10007
	tonumber = var_1_10007
	var_29_4.id = var_1_10007(var_29_1)
	var_29_4.count = arg_29_1:getConfig("target_num")

	var_29_0(var_29_3, var_29_4)

	setText = var_29_0

	var_29_0(arg_29_0.submitItemDesc, var_29_2)

	return
end

function var_0_1.willExit(arg_30_0)
	arg_30_0.exitFlag = true

	if arg_30_0.leanTweens and #arg_30_0.leanTweens > 0 then
		pairs = var_1

		for iter_30_0, iter_30_1 in var_1(arg_30_0.leanTweens) do
			LeanTween = var_1_10006

			if var_1_10006.isTweening(iter_30_1) then
				LeanTween = var_1_10006

				var_1_10006.cancel(iter_30_1)
			end
		end

		arg_30_0.leanTweens = {}
	end

	for iter_30_2 = 1, #arg_30_0.allDisplayTask do
		local var_30_0 = arg_30_0.allDisplayTask[iter_30_2]

		if var_5.isNew(var_30_0) then
			var_5:changeNew()
		end
	end

	ClearLScrollrect = var_1

	var_1(arg_30_0.scrollRect)

	return
end

return var_0_1
