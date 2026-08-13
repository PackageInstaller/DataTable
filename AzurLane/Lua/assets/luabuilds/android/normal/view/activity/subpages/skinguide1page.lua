class = var_0_10000

local var_0_0 = "SkinGuide1Page"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = "ui/activityuipage/skinguide1page_atlas"
local var_0_3 = {
	"xiafei",
	"weiyan",
	"kuersike",
	"deliyasite",
	"fuluoxiluofu"
}

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD/mask")

	local var_1_1 = arg_1_0.bg

	arg_1_0.countTF = var_1.Find(var_1_1, "rightPanel/count")

	local var_1_2 = arg_1_0.bg

	arg_1_0.itemTpl = var_1.Find(var_1_2, "itemTpl")
	setActive = var_1

	var_1(arg_1_0.itemTpl, false)

	local var_1_3 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_3, "rightPanel/items")

	local var_1_4 = arg_1_0.bg

	arg_1_0.countImg = var_1.Find(var_1_4, "countImg")

	local var_1_5 = arg_1_0.bg

	arg_1_0.paintings = var_1.Find(var_1_5, "paintings")

	local var_1_6 = arg_1_0.bg

	arg_1_0.paintingsSelected = var_1.Find(var_1_6, "paintingsSelected")

	local var_1_7 = arg_1_0.bg

	arg_1_0.descTf = var_1.Find(var_1_7, "rightPanel/desc")

	local var_1_8 = arg_1_0.bg

	arg_1_0.rightPanel = var_1.Find(var_1_8, "rightPanel")
	arg_1_0.itemTfs = {}
	arg_1_0.selectedIndex = 1
	arg_1_0.paintingTfs = {}

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_2_0.taskProxy = var_1_10001(var_1_10002)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskList = var_1.getConfig(var_2_0, "config_data")
	arg_2_0.totalCnt = #arg_2_0.taskList

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity

	arg_3_0.usedCnt = var_1.getData1(var_3_0)
	pg = var_1

	local var_3_1 = var_1.TimeMgr.GetInstance()
	local var_3_2 = var_1.DiffDay
	local var_3_3 = arg_3_0.activity
	local var_3_4 = var_3.getStartTime(var_3_3)

	pg = var_3_3

	local var_3_5 = var_3_3.TimeMgr.GetInstance()

	arg_3_0.unlockCnt = var_3_2(var_3_1, var_3_4, var_4.GetServerTime(var_3_5)) + 1

	local var_3_6 = arg_3_0.unlockCnt

	tonumber = var_3_1

	local var_3_7 = arg_3_0.activity

	arg_3_0.unlockCnt = var_3_6 * var_3_1(var_3.getConfig(var_3_7, "config_id"))

	local var_3_8

	if not (arg_3_0.unlockCnt > arg_3_0.totalCnt) or not arg_3_0.totalCnt then
		var_3_8 = arg_3_0.unlockCnt
	end

	arg_3_0.unlockCnt = var_3_8
	arg_3_0.remainCnt = arg_3_0.usedCnt >= arg_3_0.totalCnt and 0 or arg_3_0.unlockCnt - arg_3_0.usedCnt

	local var_3_9 = 1

	for iter_3_0 = 1, #arg_3_0.taskList do
		local var_3_10 = iter_3_0

		tf = var_1_10007
		instantiate = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008(arg_3_0.itemTpl))
		setParent = var_1_10008

		var_1_10008(var_1_10007, arg_3_0.items)

		Vector2 = var_1_10008
		var_1_10007.anchoredPosition = var_1_10008(0, 0)
		setActive = var_1_10008

		var_1_10008(var_1_10007, false)

		var_1_10008 = arg_3_0.taskList[iter_3_0]

		local var_3_11 = arg_3_0.taskProxy
		local var_3_13

		if not var_9.getTaskById(var_3_11, var_1_10008) then
			local var_3_12 = arg_3_0.taskProxy

			var_3_13 = var_9.getFinishTaskById(var_3_12, var_1_10008)
		end

		local var_3_14 = var_3_13:getConfig("award_display")[1]
		local var_3_15 = {
			type = var_3_14[1],
			id = var_3_14[2],
			count = var_3_14[3]
		}

		updateDrop = var_12
		findTF = var_1_10013

		var_12(var_1_10013(var_1_10007, "item"), var_3_15)

		onButton = var_12
		var_1_10013 = arg_3_0

		local var_3_16 = var_1_10007

		local function var_3_17()
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			BaseUI = var_2_10002

			var_4_1(var_4_0, var_2_10002.ON_DROP, var_3_15)

			return
		end

		SFX_PANEL = var_1_10016

		var_12(var_1_10013, var_3_16, var_3_17, var_1_10016)

		table = var_12

		var_12.insert(arg_3_0.itemTfs, var_1_10007)

		var_1_10013 = var_1_10007

		local var_3_18 = var_1_10007.Find(var_1_10013, "get")

		onButton = var_1_10013

		local var_3_19 = arg_3_0
		local var_3_20 = var_3_18

		function var_1_10016()
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_5_1(var_5_0, var_2_10002.ON_TASK_SUBMIT, var_3_13)

			return
		end

		SFX_PANEL = var_1_10017

		var_1_10013(var_3_19, var_3_20, var_1_10016, var_1_10017)

		findTF = var_1_10013
		var_1_10013 = var_1_10013(arg_3_0.paintings, var_0_3[iter_3_0])
		table = var_14

		var_14.insert(arg_3_0.paintingTfs, var_1_10013)

		GetComponent = var_14
		findTF = var_15

		local var_3_21 = var_15(var_1_10013, "normal")

		typeof = var_1_10016
		Image = var_1_10017
		var_14(var_3_21, var_1_10016(var_1_10017)).alphaHitTestMinimumThreshold = 0.5
		onButton = var_15
		var_1_10016 = arg_3_0
		findTF = var_1_10017
		var_1_10017 = var_1_10017(var_1_10013, "normal")

		local function var_3_22()
			local var_6_0 = arg_3_0

			var_0.selectedChange(var_6_0, var_3_10)

			return
		end

		SFX_PANEL = var_19

		var_15(var_1_10016, var_1_10017, var_3_22, var_19)

		var_1_10016 = var_3_13

		if var_3_13.getTaskStatus(var_1_10016) == 1 then
			var_1_10016 = arg_3_0.remainCnt

			if not (0 < var_1_10016) then
				var_1_10016 = false
			else
				var_1_10016 = true
			end

			if var_1_10016 then
				var_3_9 = iter_3_0
			end
		end
	end

	arg_3_0:updateUI()
	arg_3_0:selectedChange(var_3_9)

	return
end

function var_0_1.selectedChange(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.itemTfs do
		setActive = var_1_10006

		var_1_10006(arg_7_0.itemTfs[iter_7_0], iter_7_0 == arg_7_1)

		var_1_10006 = arg_7_0.paintingTfs[iter_7_0]
		setActive = var_7
		findTF = var_8

		var_7(var_8(var_1_10006, "name"), iter_7_0 == arg_7_1)

		setActive = var_7
		findTF = var_8

		var_7(var_8(var_1_10006, "selected"), iter_7_0 == arg_7_1)

		setActive = var_7
		findTF = var_8

		var_7(var_8(var_1_10006, "normal"), iter_7_0 ~= arg_7_1)

		local var_7_0 = arg_7_0.taskList[iter_7_0]
		local var_7_1 = arg_7_0.taskProxy
		local var_7_3

		if not var_8.getTaskById(var_7_1, var_7_0) then
			local var_7_2 = arg_7_0.taskProxy

			var_7_3 = var_8.getFinishTaskById(var_7_2, var_7_0)
		end

		local var_7_4 = var_7_3:getTaskStatus() == 2

		setActive = var_1_10011
		findTF = var_1_10012

		var_1_10011(var_1_10012(var_1_10006, "mask"), not var_7_4 or arg_7_1 == iter_7_0)

		if iter_7_0 == arg_7_1 then
			setParent = var_1_10011

			var_1_10011(var_1_10006, arg_7_0.paintingsSelected)

			var_1_10012 = var_1_10006

			var_1_10006.SetAsLastSibling(var_1_10012)
		else
			setParent = var_1_10011

			var_1_10011(var_1_10006, arg_7_0.paintings)
		end
	end

	if arg_7_0.selectedIndex ~= arg_7_1 then
		setActive = var_2

		var_2(arg_7_0.rightPanel, false)

		setActive = var_2

		var_2(arg_7_0.rightPanel, true)
	end

	arg_7_0.selectedIndex = arg_7_1

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	local var_8_0 = 0

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.taskList) do
		local var_8_1 = arg_8_0.taskProxy

		if var_7.getFinishTaskById(var_8_1, iter_8_1) ~= nil then
			var_8_0 = var_8_0 + 1
		end
	end

	local var_8_2

	if arg_8_0.usedCnt ~= var_8_0 then
		arg_8_0.usedCnt = var_8_0
		var_8_2 = arg_8_0.activity
		var_8_2.data1 = arg_8_0.usedCnt
		getProxy = var_3
		ActivityProxy = var_4

		local var_8_3 = var_3(var_4)

		var_3.updateActivity(var_8_3, var_8_2)
	end

	pg = var_8_2

	local var_8_4 = var_8_2.TimeMgr.GetInstance()
	local var_8_5 = var_2.DiffDay
	local var_8_6 = arg_8_0.activity
	local var_8_7 = var_4.getStartTime(var_8_6)

	pg = var_8_6

	local var_8_8 = var_8_6.TimeMgr.GetInstance()

	arg_8_0.unlockCnt = var_8_5(var_8_4, var_8_7, var_5.GetServerTime(var_8_8)) + 1

	local var_8_9 = arg_8_0.unlockCnt

	tonumber = var_8_4

	local var_8_10 = arg_8_0.activity

	arg_8_0.unlockCnt = var_8_9 * var_8_4(var_4.getConfig(var_8_10, "config_id"))

	local var_8_11

	if not (arg_8_0.unlockCnt > arg_8_0.totalCnt) or not arg_8_0.totalCnt then
		var_8_11 = arg_8_0.unlockCnt
	end

	arg_8_0.unlockCnt = var_8_11
	arg_8_0.remainCnt = arg_8_0.usedCnt >= arg_8_0.totalCnt and 0 or arg_8_0.unlockCnt - arg_8_0.usedCnt
	setText = var_2

	local var_8_12 = arg_8_0.countTF

	tostring = var_4

	var_2(var_8_12, var_4(arg_8_0.remainCnt))

	local var_8_13 = arg_8_0.activity
	local var_8_14 = var_2.getConfig(var_8_13, "config_client").story

	ipairs = var_8_13

	for iter_8_2, iter_8_3 in var_8_13(arg_8_0.taskList) do
		local var_8_15 = arg_8_0.taskProxy

		if var_8.getFinishTaskById(var_8_15, iter_8_3) then
			checkExist = var_8_15

			if var_8_15(var_8_14, {
				iter_8_2
			}, {
				1
			}) then
				pg = var_9

				local var_8_16 = var_9.NewStoryMgr.GetInstance()

				var_9.Play(var_8_16, var_8_14[iter_8_2][1])
			end
		end
	end

	arg_8_0:updateUI()

	return
end

function var_0_1.updateUI(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.itemTfs do
		local var_9_0 = arg_9_0.taskList[iter_9_0]
		local var_9_1 = arg_9_0.taskProxy
		local var_9_3

		if not var_6.getTaskById(var_9_1, var_9_0) then
			local var_9_2 = arg_9_0.taskProxy

			var_9_3 = var_6.getFinishTaskById(var_9_2, var_9_0)
		end

		local var_9_4 = arg_9_0.itemTfs[iter_9_0]
		local var_9_5 = var_7.Find(var_9_4, "item")
		local var_9_6 = var_9_3:getTaskStatus()
		local var_9_7 = arg_9_0.itemTfs[iter_9_0]
		local var_9_8 = var_9.Find(var_9_7, "got")
		local var_9_9 = arg_9_0.itemTfs[iter_9_0]
		local var_9_10 = var_10.Find(var_9_9, "get")
		local var_9_11 = var_9_6 == 1 and arg_9_0.remainCnt > 0
		local var_9_12 = var_9_6 == 2

		setActive = var_1_10013

		var_1_10013(var_9_10, var_9_11)

		setActive = var_1_10013

		var_1_10013(var_9_8, var_9_12)

		var_1_10013 = arg_9_0.paintingTfs[iter_9_0]
		setActive = var_14
		findTF = var_15

		var_14(var_15(var_1_10013, "got"), var_9_12)

		setActive = var_14
		findTF = var_15

		var_14(var_15(var_1_10013, "mask"), not var_9_12 or arg_9_0.selectedIndex == iter_9_0)
	end

	return
end

function var_0_1.OnShowFlush(arg_10_0)
	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
