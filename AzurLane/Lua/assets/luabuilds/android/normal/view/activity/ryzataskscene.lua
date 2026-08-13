class = var_0_10000

local var_0_0 = "RyzaTaskScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
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

function var_0_1.getUIName(arg_1_0)
	return "RyzaTaskUI"
end

local var_0_22 = 4
local var_0_23 = 5
local var_0_24 = 4

function var_0_1.init(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivityByType

	ActivityConst = var_1_10003
	arg_2_0.activityId = var_2_1(var_2_0, var_1_10003.ACTIVITY_TYPE_TASK_RYZA).id

	local var_2_2

	if not arg_2_0.contextData.task_id then
		var_2_2 = nil
	end

	arg_2_0.enterTaskId = var_2_2
	pg = var_2_2
	arg_2_0.taskGroups = var_2_2.activity_template[arg_2_0.activityId].config_data
	arg_2_0.leanTweens = {}
	arg_2_0.exitFlag = false
	pg = var_1

	local var_2_3 = var_1.activity_template[arg_2_0.activityId].config_client

	pg = var_2
	arg_2_0.ptName = var_2.player_resource[var_2_3.pt_id].name
	arg_2_0.ptBuffs = var_2_3.pt_buff
	arg_2_0.maxNum = arg_2_0.ptBuffs[#arg_2_0.ptBuffs].pt[1]
	findTF = var_2

	local var_2_4 = var_2(arg_2_0._tf, "ad")

	findTF = var_3
	arg_2_0.btnBack = var_3(var_2_4, "btnBack")
	findTF = var_3
	arg_2_0.btnMain = var_3(var_2_4, "btnMain")
	findTF = var_3
	arg_2_0.btnHelp = var_3(var_2_4, "btnHelp")
	findTF = var_3
	arg_2_0.btnGetAll = var_3(var_2_4, "btnGetAll")
	findTF = var_3
	arg_2_0.btnPoint = var_3(var_2_4, "btnPoint")
	findTF = var_3
	arg_2_0.imgPoint = var_3(var_2_4, "btnPoint/imgPoint")
	findTF = var_3
	arg_2_0.taskTagPanel = var_3(var_2_4, "taskTagPanel")
	findTF = var_3
	arg_2_0.taskListPanel = var_3(var_2_4, "taskListPanel")
	findTF = var_3

	local var_2_5 = var_3(var_2_4, "taskListPanel/Content")

	arg_2_0.scrollRect = var_3.GetComponent(var_2_5, "LScrollRect")
	findTF = var_3
	arg_2_0.taskDetailPanel = var_3(var_2_4, "taskDetailPanel")
	findTF = var_3
	arg_2_0.detailTag = var_3(arg_2_0.taskDetailPanel, "tag")
	findTF = var_3
	arg_2_0.detailTitleText = var_3(arg_2_0.taskDetailPanel, "title/text")
	findTF = var_3
	arg_2_0.detailIcon = var_3(arg_2_0.taskDetailPanel, "icon/image")
	findTF = var_3
	arg_2_0.detailDescText = var_3(arg_2_0.taskDetailPanel, "desc/text")
	findTF = var_3
	arg_2_0.detaiProgressText = var_3(arg_2_0.taskDetailPanel, "progress/text")
	findTF = var_3
	arg_2_0.detailAwardContent = var_3(arg_2_0.taskDetailPanel, "awardDisplay/viewport/content")
	findTF = var_3
	arg_2_0.detailBtnGo = var_3(arg_2_0.taskDetailPanel, "btnGo")
	findTF = var_3
	arg_2_0.detailBtnGet = var_3(arg_2_0.taskDetailPanel, "btnGet")
	findTF = var_3
	arg_2_0.detailBtnSubmit = var_3(arg_2_0.taskDetailPanel, "btnSubmit")
	findTF = var_3
	arg_2_0.detailBtnDetail = var_3(arg_2_0.taskDetailPanel, "btnDetail")
	findTF = var_3
	arg_2_0.detailActive = var_3(arg_2_0.taskDetailPanel, "active")
	findTF = var_3
	arg_2_0.taskItemTpl = var_3(var_2_4, "tpl/taskItemTpl")
	findTF = var_3
	arg_2_0.IconTpl = var_3(var_2_4, "tpl/IconTpl")
	findTF = var_3

	local var_2_6 = var_3(arg_2_0._tf, "pop")

	findTF = var_4
	arg_2_0.pointPanel = var_4(var_2_6, "pointPanel")
	setActive = var_4

	var_4(arg_2_0.pointPanel, false)

	findTF = var_4
	arg_2_0.pointProgressText = var_4(arg_2_0.pointPanel, "progressContent/progress")
	findTF = var_4
	arg_2_0.pointProgressSlider = var_4(arg_2_0.pointPanel, "slider")
	findTF = var_4
	arg_2_0.pointLevelStar = var_4(arg_2_0.pointPanel, "levelStar")
	findTF = var_4
	arg_2_0.pointStarTpl = var_4(arg_2_0.pointPanel, "levelStar/starTpl")
	findTF = var_4
	arg_2_0.pointAdd = var_4(arg_2_0.pointPanel, "add")
	findTF = var_4
	arg_2_0.pointClose = var_4(arg_2_0.pointPanel, "btnClose")
	findTF = var_4
	arg_2_0.pointMask = var_4(arg_2_0.pointPanel, "mask")
	findTF = var_4
	arg_2_0.submitPanel = var_4(var_2_6, "submitPanel")
	findTF = var_4
	arg_2_0.submitDisplayContent = var_4(arg_2_0.submitPanel, "itemDisplay/viewport/content")
	findTF = var_4
	arg_2_0.submitConfirm = var_4(arg_2_0.submitPanel, "btnComfirm")
	findTF = var_4
	arg_2_0.submitCancel = var_4(arg_2_0.submitPanel, "btnCancel")
	findTF = var_4
	arg_2_0.subimtItem = var_4(arg_2_0.submitPanel, "itemDisplay/viewport/content/item")
	findTF = var_4
	arg_2_0.submitItemDesc = var_4(arg_2_0.submitPanel, "itemDesc")
	findTF = var_4
	arg_2_0.btnCancel = var_4(arg_2_0.submitPanel, "btnCancel")
	setText = var_4
	findTF = var_5

	local var_2_7 = var_5(arg_2_0.btnPoint, "text")

	i18n = var_6

	var_4(var_2_7, var_6(var_0_2))

	for iter_2_0 = 1, var_0_22 do
		findTF = var_1_10008
		var_1_10008 = var_1_10008(arg_2_0.taskTagPanel, "btn" .. iter_2_0)
		setText = var_1_10009
		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_1_10008, "off/text")
		i18n = var_11

		var_1_10009(var_1_10010, var_11(var_0_7[iter_2_0]))

		setText = var_1_10009
		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_1_10008, "on/text")
		i18n = var_11

		var_1_10009(var_1_10010, var_11(var_0_7[iter_2_0]))
	end

	setText = var_4
	findTF = var_5

	local var_2_8 = var_5(arg_2_0.taskDetailPanel, "desc/title")

	i18n = var_6

	var_4(var_2_8, var_6(var_0_8))

	setText = var_4
	findTF = var_2_8

	local var_2_9 = var_2_8(arg_2_0.taskDetailPanel, "awardText")

	i18n = var_6

	var_4(var_2_9, var_6(var_0_9))

	setText = var_4
	findTF = var_2_9

	local var_2_10 = var_2_9(arg_2_0.taskDetailPanel, "btnGet/text")

	i18n = var_6

	var_4(var_2_10, var_6(var_0_11))

	setText = var_4
	findTF = var_2_10

	local var_2_11 = var_2_10(arg_2_0.taskDetailPanel, "btnGo/text")

	i18n = var_6

	var_4(var_2_11, var_6(var_0_10))

	setText = var_4
	findTF = var_2_11

	local var_2_12 = var_2_11(arg_2_0.taskDetailPanel, "btnSubmit/text")

	i18n = var_6

	var_4(var_2_12, var_6(var_0_13))

	setText = var_4
	findTF = var_2_12

	local var_2_13 = var_2_12(arg_2_0.taskDetailPanel, "btnDetail/text")

	i18n = var_6

	var_4(var_2_13, var_6(var_0_12))

	setText = var_4
	findTF = var_2_13

	local var_2_14 = var_2_13(arg_2_0.btnGetAll, "text")

	i18n = var_6

	var_4(var_2_14, var_6(var_0_14))

	setText = var_4
	findTF = var_2_14

	local var_2_15 = var_2_14(arg_2_0.submitPanel, "btnComfirm/text")

	i18n = var_6

	var_4(var_2_15, var_6(var_0_15))

	setText = var_4
	findTF = var_2_15

	local var_2_16 = var_2_15(arg_2_0.submitPanel, "btnCancel/text")

	i18n = var_6

	var_4(var_2_16, var_6(var_0_16))

	setText = var_4
	findTF = var_2_16

	local var_2_17 = var_2_16(arg_2_0.submitPanel, "bg/text")

	i18n = var_6

	var_4(var_2_17, var_6(var_0_20))

	setText = var_4
	findTF = var_2_17

	local var_2_18 = var_2_17(arg_2_0.pointPanel, "title")

	i18n = var_6

	var_4(var_2_18, var_6(var_0_2))

	setText = var_4
	findTF = var_2_18

	local var_2_19 = var_2_18(arg_2_0.pointPanel, "levelNum/text")

	i18n = var_6

	var_4(var_2_19, var_6(var_0_17))

	setText = var_4
	findTF = var_2_19

	local var_2_20 = var_2_19(arg_2_0.pointPanel, "levelBuff/text")

	i18n = var_6

	var_4(var_2_20, var_6(var_0_18))

	arg_2_0.pointStarTfs = {}

	local var_2_21 = arg_2_0.pointLevelStar.sizeDelta.x

	for iter_2_1 = 1, #arg_2_0.ptBuffs do
		tf = var_1_10009
		Instantiate = var_1_10010
		var_1_10009 = var_1_10009(var_1_10010(arg_2_0.pointStarTpl))
		SetParent = var_1_10010

		var_1_10010(var_1_10009, arg_2_0.pointLevelStar)

		setActive = var_1_10010

		var_1_10010(var_1_10009, true)

		setText = var_1_10010
		findTF = var_11

		var_1_10010(var_11(var_1_10009, "bg/text"), iter_2_1)

		setText = var_1_10010
		findTF = var_11

		var_1_10010(var_11(var_1_10009, "img/text"), iter_2_1)

		var_1_10010 = arg_2_0.ptBuffs[iter_2_1].pt[1]
		Vector3 = var_11
		var_1_10009.anchoredPosition = var_11(var_1_10010 / arg_2_0.maxNum * var_2_21, -18, 0)
		table = var_11

		var_11.insert(arg_2_0.pointStarTfs, var_1_10009)

		if iter_2_1 == 1 then
			setActive = var_11

			var_11(var_1_10009, false)
		end
	end

	arg_2_0:updateTask()

	return
end

function var_0_1.updateTask(arg_3_0, arg_3_1)
	arg_3_0.displayTask = {}
	arg_3_0.allDisplayTask = {}
	getProxy = var_2
	ActivityTaskProxy = var_1_10003

	local var_3_0 = var_2(var_1_10003)
	local var_3_1 = var_2.getTaskById(var_3_0, arg_3_0.activityId)

	arg_3_0.getAllTasks = {}

	for iter_3_0 = 1, #var_3_1 do
		local var_3_2 = var_3_1[iter_3_0].id

		var_1_10010 = var_7

		local var_3_3 = var_7.getProgress(var_1_10010)

		var_1_10011 = var_7
		var_1_10010 = var_7.getTarget(var_1_10011)
		var_1_10011 = var_7:getConfig("ryza_type")
		var_1_10013 = var_7

		local var_3_4 = var_7.getConfig(var_1_10013, "type")

		var_1_10014 = var_7
		var_1_10013 = var_7.getConfig(var_1_10014, "sub_type")

		if 0 < var_1_10011 then
			if not arg_3_0.displayTask[var_1_10011] then
				var_1_10014 = arg_3_0.displayTask
				var_1_10014[var_1_10011] = {}
			end

			table = var_1_10014

			var_1_10014.insert(arg_3_0.displayTask[var_1_10011], var_7)

			table = var_1_10014

			var_1_10014.insert(arg_3_0.allDisplayTask, var_7)

			var_1_10015 = var_7

			if var_7.isFinish(var_1_10015) then
				var_1_10015 = var_7

				if var_7.isOver(var_1_10015) or var_1_10013 == 1006 then
					-- block empty
				else
					table = var_1_10014

					var_1_10014.insert(arg_3_0.getAllTasks, var_3_2)
				end
			end
		end
	end

	getProxy = var_3
	ActivityProxy = var_4

	local var_3_5 = var_3(var_4)
	local var_3_6 = var_3.getActivityById(var_3_5, arg_3_0.activityId)
	local var_3_7 = {}

	if var_3_6 then
		var_3_7 = var_3_6.data1_list
	end

	if var_3_7 then
		local var_3_8 = #var_3_7

		if 0 < var_3_8 then
			for iter_3_1 = 1, #var_3_7 do
				local var_3_9 = var_3_7[iter_3_1]

				ActivityTask = var_1_10010

				local var_3_10 = var_1_10010.New(arg_3_0.activityId, {
					progress = 0,
					id = var_3_9
				})

				var_1_10010.setOver(var_3_10)

				if var_1_10010:getConfig("ryza_type") > 0 then
					local var_3_11

					if not arg_3_0.displayTask[var_1_10011] then
						var_3_11 = arg_3_0.displayTask
						var_3_11[var_1_10011] = {}
					end

					table = var_3_11

					var_3_11.insert(arg_3_0.displayTask[var_1_10011], var_1_10010)

					table = var_12

					var_12.insert(arg_3_0.allDisplayTask, var_1_10010)
				end
			end
		end
	end

	local function var_3_12(arg_4_0, arg_4_1)
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

	pairs = iter_3_0

	for iter_3_2, iter_3_3 in iter_3_0(arg_3_0.displayTask) do
		table = var_1_10011

		var_1_10011.sort(iter_3_3, var_3_12)
	end

	table = var_6

	var_6.sort(arg_3_0.allDisplayTask, var_3_12)

	if arg_3_1 then
		arg_3_0:onClickTag()
	end

	local var_3_13 = #arg_3_0.getAllTasks

	if 0 < var_3_13 then
		setActive = var_3_13

		var_3_13(arg_3_0.btnGetAll, true)
	else
		setActive = var_3_13

		var_3_13(arg_3_0.btnGetAll, false)
	end

	getProxy = var_3_13
	PlayerProxy = var_7

	local var_3_14 = var_3_13(var_7)
	local var_3_15

	if not var_6.getData(var_3_14)[arg_3_0.ptName] then
		var_3_15 = 0
	end

	local var_3_16 = 1

	if var_3_15 > arg_3_0.maxNum then
		var_3_15 = arg_3_0.maxNum
	end

	for iter_3_4 = #arg_3_0.ptBuffs, 1, -1 do
		var_3_16 = arg_3_0.ptBuffs[iter_3_4].pt[1] <= var_3_15 and var_3_16 < iter_3_4 and iter_3_4 or var_3_16
	end

	for iter_3_5 = 1, #arg_3_0.pointStarTfs do
		local var_3_17 = arg_3_0.pointStarTfs[iter_3_5]

		if iter_3_5 <= var_3_16 then
			setActive = var_1_10013
			findTF = var_1_10014

			var_1_10013(var_1_10014(var_3_17, "img"), true)
		else
			setActive = var_1_10013
			findTF = var_1_10014

			var_1_10013(var_1_10014(var_3_17, "img"), false)
		end
	end

	local var_3_18 = arg_3_0.ptBuffs[var_3_16].benefit

	for iter_3_6 = 1, #var_3_18 do
		local var_3_19 = var_3_18[iter_3_6]

		pg = var_1_10014
		var_1_10014 = var_1_10014.benefit_buff_template[var_3_19].desc
		findTF = var_1_10015
		var_1_10015 = var_1_10015(arg_3_0.pointPanel, "add/" .. iter_3_6)
		PLATFORM_CODE = var_3_20
		PLATFORM_JP = var_17

		local var_3_20

		if var_3_20 == var_17 then
			findTF = var_3_20
			var_3_20 = var_3_20(var_1_10015, "img")
			Vector2 = var_17
			var_3_20.sizeDelta = var_17(450, 70)
			setText = var_3_20
			findTF = var_17

			var_3_20(var_17(var_1_10015, "text_jp"), var_1_10014)
		else
			setText = var_3_20
			findTF = var_17

			var_3_20(var_17(var_1_10015, "text"), var_1_10014)
		end
	end

	setSlider = var_9

	var_9(arg_3_0.pointProgressSlider, 0, arg_3_0.maxNum, var_3_15)

	setText = var_9

	var_9(arg_3_0.pointProgressText, var_3_15 .. "/" .. arg_3_0.maxNum)

	setText = var_9
	findTF = var_10

	local var_3_21 = var_10(arg_3_0.btnPoint, "text")

	i18n = var_11

	var_9(var_3_21, var_11(var_0_2) .. "Lv." .. var_3_16)

	setText = var_9
	findTF = var_3_21

	var_9(var_3_21(arg_3_0.pointPanel, "levelNum/num"), "Lv." .. var_3_16)

	setText = var_9
	findTF = var_10

	var_9(var_10(arg_3_0.pointPanel, "levelBuff/num"), "Lv." .. var_3_16)

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.btnBack

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.emit(var_6_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.btnGetAll

	local function var_5_5()
		local var_7_0 = arg_5_0.getAllTasks
		local var_7_1 = arg_5_0
		local var_7_2 = var_1.emit

		RyzaTaskMediator = var_2_10003

		var_7_2(var_7_1, var_2_10003.SUBMIT_TASK_ALL, {
			activityId = arg_5_0.activityId,
			ids = var_7_0
		})

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.btnPoint

	local function var_5_8()
		isActive = var_2_10000

		if var_2_10000(arg_5_0.pointPanel) then
			setActive = var_0

			var_0(arg_5_0.pointPanel, false)
		else
			setActive = var_0

			var_0(arg_5_0.pointPanel, true)
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10005)

	onButton = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.btnMain

	local function var_5_11()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.emit

		BaseUI = var_2_10002

		var_9_1(var_9_0, var_2_10002.ON_HOME)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10005)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.btnHelp

	local function var_5_14()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		i18n = var_2_10003
		var_10_2.helps = var_2_10003("ryza_task_help_tip")

		var_10_1(var_10_0, var_10_2)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_12, var_5_13, var_5_14, var_1_10005)

	onButton = var_1_10001

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.detailBtnGo

	local function var_5_17()
		Task = var_2_10000

		local var_11_0 = var_2_10000.New(arg_5_0.selectTask)
		local var_11_1 = arg_5_0
		local var_11_2 = var_1.emit

		RyzaTaskMediator = var_2_10003

		var_11_2(var_11_1, var_2_10003.TASK_GO, {
			taskVO = var_11_0
		})

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_15, var_5_16, var_5_17, var_1_10005)

	onButton = var_1_10001

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.pointMask

	local function var_5_20()
		setActive = var_2_10000

		var_2_10000(arg_5_0.pointPanel, false)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_18, var_5_19, var_5_20, var_1_10005)

	onButton = var_1_10001

	local var_5_21 = arg_5_0
	local var_5_22 = arg_5_0.pointClose

	local function var_5_23()
		setActive = var_2_10000

		var_2_10000(arg_5_0.pointPanel, false)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_21, var_5_22, var_5_23, var_1_10005)

	onButton = var_1_10001

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.detailBtnSubmit

	local function var_5_26()
		local var_14_0 = arg_5_0.selectTask
		local var_14_1 = var_0.getConfig(var_14_0, "type")
		local var_14_2 = arg_5_0.selectTask

		if var_1.getConfig(var_14_2, "sub_type") == 1006 then
			local var_14_3 = arg_5_0

			var_2.openSubmitPanel(var_14_3, arg_5_0.selectTask)
		else
			local var_14_4 = arg_5_0
			local var_14_5 = var_2.emit

			RyzaTaskMediator = var_2_10004

			var_14_5(var_14_4, var_2_10004.SUBMIT_TASK, {
				activityId = arg_5_0.activityId,
				id = arg_5_0.selectTask.id
			})
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_24, var_5_25, var_5_26, var_1_10005)

	onButton = var_1_10001

	local var_5_27 = arg_5_0
	local var_5_28 = arg_5_0.detailBtnGet

	local function var_5_29()
		local var_15_0 = arg_5_0.selectTask
		local var_15_1 = var_0.getConfig(var_15_0, "type")
		local var_15_2 = arg_5_0.selectTask

		if var_1.getConfig(var_15_2, "sub_type") == 1006 then
			local var_15_3 = arg_5_0

			var_2.openSubmitPanel(var_15_3, arg_5_0.selectTask)
		else
			local var_15_4 = arg_5_0
			local var_15_5 = var_2.emit

			RyzaTaskMediator = var_2_10004

			var_15_5(var_15_4, var_2_10004.SUBMIT_TASK, {
				activityId = arg_5_0.activityId,
				id = arg_5_0.selectTask.id
			})
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_27, var_5_28, var_5_29, var_1_10005)

	onButton = var_1_10001

	local var_5_30 = arg_5_0
	local var_5_31 = arg_5_0.detailBtnDetail

	local function var_5_32()
		if arg_5_0.selectTask then
			tonumber = var_0

			local var_16_0 = arg_5_0.selectTask

			if var_0(var_1.getConfig(var_16_0, "target_id_2")) and 0 < var_0 then
				AtelierMaterial = var_1

				local var_16_1 = var_1.New
				local var_16_2 = {
					configId = var_0
				}
				local var_16_3 = arg_5_0.selectTask

				var_16_2.count = var_3.getConfig(var_16_3, "target_num")

				local var_16_4 = var_16_1(var_16_2)
				local var_16_5 = arg_5_0
				local var_16_6 = var_2.emit

				RyzaTaskMediator = var_16_3

				var_16_6(var_16_5, var_16_3.SHOW_DETAIL, var_16_4)
			end
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_30, var_5_31, var_5_32, var_1_10005)

	onButton = var_1_10001

	local var_5_33 = arg_5_0
	local var_5_34 = arg_5_0.submitConfirm

	local function var_5_35()
		local var_17_0 = arg_5_0
		local var_17_1 = var_0.emit

		RyzaTaskMediator = var_2_10002

		var_17_1(var_17_0, var_2_10002.SUBMIT_TASK, {
			activityId = arg_5_0.activityId,
			id = arg_5_0.selectTask.id
		})

		setActive = var_17_1

		var_17_1(arg_5_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_33, var_5_34, var_5_35, var_1_10005)

	onButton = var_1_10001

	local var_5_36 = arg_5_0
	local var_5_37 = arg_5_0.submitCancel

	local function var_5_38()
		setActive = var_2_10000

		var_2_10000(arg_5_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_5_36, var_5_37, var_5_38, var_1_10005)

	arg_5_0.btnTags = {}

	for iter_5_0 = 1, var_0_22 do
		var_1_10005 = iter_5_0
		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_5_0.taskTagPanel, "btn" .. var_1_10005)
		onButton = var_7

		var_7(arg_5_0, var_1_10006, function()
			if arg_5_0.showTagIndex then
				setActive = var_0
				findTF = var_2_10001

				var_0(var_2_10001(arg_5_0.btnTags[arg_5_0.showTagIndex], "on"), false)

				if arg_5_0.showTagIndex == var_1_10005 then
					arg_5_0.showTagIndex = nil
				else
					local var_19_0 = arg_5_0

					var_19_0.showTagIndex = var_1_10005
					setActive = var_19_0
					findTF = var_1

					var_19_0(var_1(arg_5_0.btnTags[arg_5_0.showTagIndex], "on"), true)
				end
			else
				local var_19_1 = arg_5_0

				var_19_1.showTagIndex = var_1_10005
				setActive = var_19_1
				findTF = var_1

				var_19_1(var_1(arg_5_0.btnTags[arg_5_0.showTagIndex], "on"), true)
			end

			local var_19_2 = arg_5_0

			var_0.onClickTag(var_19_2)

			return
		end)

		table = var_7

		var_7.insert(arg_5_0.btnTags, var_1_10006)
	end

	function arg_5_0.scrollRect.onUpdateItem(arg_20_0, arg_20_1)
		local var_20_0 = arg_5_0

		var_2.onUpdateTaskItem(var_20_0, arg_20_0, arg_20_1)

		return
	end

	arg_5_0.iconTfs = {}
	arg_5_0.awards = {}

	local var_5_39 = arg_5_0

	arg_5_0.onClickTag(var_5_39)

	local var_5_40 = false

	PlayerPrefs = var_5_39

	local var_5_41 = var_5_39.GetInt
	local var_5_42 = "ryza_task_help_"

	getProxy = iter_5_0
	PlayerProxy = var_1_10005

	local var_5_43 = iter_5_0(var_1_10005)

	if var_5_41(var_5_42 .. var_4.getRawData(var_5_43).id) ~= 1 then
		var_5_40 = true
	end

	if var_5_40 then
		PlayerPrefs = var_3

		local var_5_44 = var_3.SetInt
		local var_5_45 = "ryza_task_help_"

		getProxy = var_5_43
		PlayerProxy = var_1_10006

		local var_5_46 = var_5_43(var_1_10006)

		var_5_44(var_5_45 .. var_5.getRawData(var_5_46).id, 1)

		pg = var_5_44

		local var_5_47 = var_5_44.MsgboxMgr.GetInstance()
		local var_5_48 = var_3.ShowMsgBox
		local var_5_49 = {}

		MSGBOX_TYPE_HELP = var_5_46
		var_5_49.type = var_5_46
		i18n = var_5_46
		var_5_49.helps = var_5_46("ryza_task_help_tip")

		var_5_48(var_5_47, var_5_49)
	end

	return
end

function var_0_1.onClickTag(arg_21_0)
	print = var_1_10001

	var_1_10001("点击了Tag")

	if arg_21_0.showTagIndex and var_1 > 0 then
		if arg_21_0.displayTask[var_1] and #arg_21_0.displayTask[var_1] > 0 then
			arg_21_0.showTasks = arg_21_0.displayTask[var_1]
		else
			triggerButton = var_2

			var_2(arg_21_0.btnTags[arg_21_0.showTagIndex])

			return
		end
	else
		arg_21_0.showTasks = arg_21_0.allDisplayTask
	end

	if arg_21_0.enterTaskId and arg_21_0.enterTaskId > 0 then
		for iter_21_0 = 1, #arg_21_0.showTasks do
			if arg_21_0.showTasks[iter_21_0].id == arg_21_0.enterTaskId then
				arg_21_0.scrollIndex = iter_21_0
			end
		end
	end

	local var_21_0 = arg_21_0.scrollRect

	var_2.SetTotalCount(var_21_0, #arg_21_0.showTasks, 0)

	if arg_21_0.scrollIndex ~= nil then
		local var_21_1 = arg_21_0.scrollRect
		local var_21_2 = var_2.HeadIndexToValue(var_21_1, arg_21_0.scrollIndex - 1)
		local var_21_3 = arg_21_0.scrollRect

		var_3.ScrollTo(var_21_3, var_21_2)
	end

	return
end

function var_0_1.onUpdateTaskItem(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.exitFlag then
		return
	end

	local var_22_0 = arg_22_0.leanTweens

	var_22_0[arg_22_2] = arg_22_2
	table = var_22_0

	var_22_0.insert(arg_22_0.leanTweens, arg_22_2)

	GetComponent = var_3

	local var_22_1 = arg_22_2

	typeof = var_5
	CanvasGroup = var_1_10006

	local var_22_2 = var_3(var_22_1, var_5(var_1_10006))

	var_22_2.alpha = 0
	LeanTween = var_4

	local var_22_3 = var_4.value(arg_22_2, 0, 1, 0.3)
	local var_22_4 = var_4.setEase

	LeanTweenType = var_6

	local var_22_5 = var_22_4(var_22_3, var_6.linear)
	local var_22_6 = var_4.setOnUpdate

	System = var_6

	local var_22_7 = var_22_6(var_22_5, var_6.Action_float(function(arg_23_0)
		var_22_2.alpha = arg_23_0

		return
	end))
	local var_22_8 = var_4.setOnComplete

	System = var_6

	var_22_8(var_22_7, var_6.Action(function()
		arg_22_0.leanTweens[arg_22_2] = nil

		return
	end))

	arg_22_1 = arg_22_1 + 1

	local var_22_9 = arg_22_0.showTasks[arg_22_1].id
	local var_22_10 = var_4:getProgress()
	local var_22_11 = var_4:getConfig("name")
	local var_22_12 = var_4:getConfig("ryza_icon")
	local var_22_13 = var_4:isOver()
	local var_22_14 = var_4:isFinish()
	local var_22_15 = var_4
	local var_22_16 = var_4.isCircle(var_22_15)

	setActive = var_22_15
	findTF = var_1_10013

	var_22_15(var_1_10013(arg_22_2, "selected"), arg_22_0.selectIndex == arg_22_1)

	setActive = var_22_15
	findTF = var_13

	var_22_15(var_13(arg_22_2, "typeNew"), var_4:isNew())

	setActive = var_22_15
	findTF = var_13

	var_22_15(var_13(arg_22_2, "typeCircle"), var_4:isCircle())

	setActive = var_22_15
	findTF = var_13

	var_22_15(var_13(arg_22_2, "finish"), var_22_13)

	setActive = var_22_15
	findTF = var_13

	var_22_15(var_13(arg_22_2, "mask"), var_22_13)

	setActive = var_22_15
	findTF = var_13

	var_22_15(var_13(arg_22_2, "complete"), not var_22_13 and var_22_14 and not var_22_16)

	setText = var_22_15
	findTF = var_13

	local var_22_17 = var_13(arg_22_2, "desc/text")

	shortenString = var_14

	var_22_15(var_22_17, var_14(var_22_11, 10))

	if not var_22_12 or var_22_12 == 0 then
		var_22_12 = "attack"
	end

	setImageSprite = var_22_15
	findTF = var_22_17

	local var_22_18 = var_22_17(arg_22_2, "icon/image")

	LoadSprite = var_14

	var_22_15(var_22_18, var_14(var_0_21, var_22_12))

	onButton = var_22_15

	local var_22_19 = arg_22_0

	tf = var_14

	var_22_15(var_22_19, var_14(arg_22_2), function()
		if arg_22_0.selectItem then
			setActive = var_0
			findTF = var_2_10001

			var_0(var_2_10001(arg_22_0.selectItem, "selected"), false)
		end

		setActive = var_0
		findTF = var_2_10001

		var_0(var_2_10001(arg_22_2, "selected"), true)

		arg_22_0.selectIndex = arg_22_1
		arg_22_0.selectItem = arg_22_2
		arg_22_0.selectTask = var_0

		local var_25_0 = arg_22_0

		var_0.updateDetail(var_25_0)

		return
	end)

	if arg_22_0.enterTaskId ~= nil and arg_22_0.enterTaskId > 0 then
		if var_22_9 == arg_22_0.enterTaskId then
			triggerButton = var_12

			var_12(arg_22_2)

			arg_22_0.enterTaskId = nil
			arg_22_0.scrollIndex = nil
		end
	elseif arg_22_1 == 1 then
		triggerButton = var_12

		var_12(arg_22_2)

		arg_22_0.scrollIndex = nil
	end

	return
end

function var_0_1.updateDetail(arg_26_0)
	local var_26_0 = arg_26_0.showTasks[arg_26_0.selectIndex].id
	local var_26_1 = var_1:getProgress()
	local var_26_2 = var_1.target

	pg = var_1_10005

	local var_26_3 = var_1_10005.task_data_template[var_26_0]
	local var_26_4 = var_1:isFinish()
	local var_26_5 = var_1:isOver()
	local var_26_6 = var_1:isCircle()
	local var_26_7 = var_1:isSubmit()

	arg_26_0.awards = var_26_3.award_display

	local var_26_8 = var_26_3.desc
	local var_26_9 = var_26_3.ryza_icon
	local var_26_10 = var_1
	local var_26_11 = var_1.getConfig(var_26_10, "sub_type")

	if not var_26_9 or var_26_9 == 0 then
		var_26_9 = "attack"
	end

	if not var_26_7 and var_26_2 < var_26_1 then
		var_26_1 = var_26_2
	end

	setText = var_26_10

	var_26_10(arg_26_0.detailDescText, var_26_8)

	if not var_26_5 then
		setText = var_26_10

		var_26_10(arg_26_0.detaiProgressText, var_26_1 .. "/" .. var_26_2)
	else
		setText = var_26_10

		var_26_10(arg_26_0.detaiProgressText, "--/--")
	end

	setText = var_26_10

	var_26_10(arg_26_0.detailTitleText, var_26_3.name)

	setActive = var_26_10

	var_26_10(arg_26_0.detailBtnDetail, var_26_11 == 1006 and not var_26_4 and not var_26_5)

	setActive = var_26_10

	var_26_10(arg_26_0.detailBtnGo, not var_26_5 and not var_26_4 and var_26_11 ~= 1006)

	setActive = var_26_10

	var_26_10(arg_26_0.detailBtnGet, not var_26_5 and var_26_4 and not var_26_7)

	setActive = var_26_10

	var_26_10(arg_26_0.detailBtnSubmit, not var_26_5 and var_26_4 and var_26_7)

	setActive = var_26_10

	var_26_10(arg_26_0.detailActive, not var_26_5 and not var_26_4 and not var_26_6)

	setImageSprite = var_26_10

	local var_26_12 = arg_26_0.detailIcon

	LoadSprite = var_15

	var_26_10(var_26_12, var_15(var_0_21, var_26_9))

	if #arg_26_0.iconTfs < #arg_26_0.awards then
		local var_26_13 = #arg_26_0.awards - #arg_26_0.iconTfs

		for iter_26_0 = 1, var_26_13 do
			tf = var_1_10018
			Instantiate = var_1_10019
			var_1_10018 = var_1_10018(var_1_10019(arg_26_0.IconTpl))
			setParent = var_1_10019

			var_1_10019(var_1_10018, arg_26_0.detailAwardContent)

			setActive = var_1_10019

			var_1_10019(var_1_10018, true)

			table = var_1_10019

			var_1_10019.insert(arg_26_0.iconTfs, var_1_10018)
		end
	end

	for iter_26_1 = 1, #arg_26_0.iconTfs do
		local var_26_14

		if iter_26_1 <= #arg_26_0.awards then
			var_26_14 = arg_26_0.awards[iter_26_1]

			local var_26_15 = {
				type = var_26_14[1],
				id = var_26_14[2],
				count = var_26_14[3]
			}

			updateDrop = var_19

			var_19(arg_26_0.iconTfs[iter_26_1], var_26_15)

			onButton = var_19

			local var_26_16 = arg_26_0
			local var_26_17 = arg_26_0.iconTfs[iter_26_1]

			local function var_26_18()
				local var_27_0 = arg_26_0
				local var_27_1 = var_0.emit

				BaseUI = var_2_10002

				var_27_1(var_27_0, var_2_10002.ON_DROP, var_26_15)

				return
			end

			SFX_PANEL = var_1_10023

			var_19(var_26_16, var_26_17, var_26_18, var_1_10023)

			setActive = var_19

			var_19(arg_26_0.iconTfs[iter_26_1], true)
		else
			setActive = var_26_14

			var_26_14(arg_26_0.iconTfs[iter_26_1], false)
		end
	end

	return
end

function var_0_1.openSubmitPanel(arg_28_0, arg_28_1)
	setActive = var_1_10002

	var_1_10002(arg_28_0.submitPanel, true)

	tonumber = var_1_10002

	local var_28_0 = arg_28_1
	local var_28_1 = var_1_10002(arg_28_1.getConfig(var_28_0, "target_id_2"))

	pg = var_3

	local var_28_2 = var_3.activity_ryza_item[var_28_1].name

	updateDrop = var_28_0

	local var_28_3 = arg_28_0.subimtItem
	local var_28_4 = {}

	DROP_TYPE_RYZA_DROP = var_1_10007
	var_28_4.type = var_1_10007
	tonumber = var_1_10007
	var_28_4.id = var_1_10007(var_28_1)
	var_28_4.count = arg_28_1:getConfig("target_num")

	var_28_0(var_28_3, var_28_4)

	setText = var_28_0

	var_28_0(arg_28_0.submitItemDesc, var_28_2)

	return
end

function var_0_1.willExit(arg_29_0)
	arg_29_0.exitFlag = true

	if arg_29_0.leanTweens and #arg_29_0.leanTweens > 0 then
		pairs = var_1

		for iter_29_0, iter_29_1 in var_1(arg_29_0.leanTweens) do
			LeanTween = var_1_10006

			if var_1_10006.isTweening(iter_29_1) then
				LeanTween = var_1_10006

				var_1_10006.cancel(iter_29_1)
			end
		end

		arg_29_0.leanTweens = {}
	end

	for iter_29_2 = 1, #arg_29_0.allDisplayTask do
		local var_29_0 = arg_29_0.allDisplayTask[iter_29_2]

		if var_5.isNew(var_29_0) then
			var_5:changeNew()
		end
	end

	return
end

return var_0_1
