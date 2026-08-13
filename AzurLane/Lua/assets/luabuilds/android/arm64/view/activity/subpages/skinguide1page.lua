class = var_0_10000

local var_0_0 = "SkinGuide1Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))
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
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1_10001(var_1_10003)

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
	local var_3_4 = var_4.getStartTime(var_3_3)

	pg = var_1_10005

	local var_3_5 = var_1_10005.TimeMgr.GetInstance()

	arg_3_0.unlockCnt = var_3_2(var_3_1, var_3_4, var_5.GetServerTime(var_3_5)) + 1

	local var_3_6 = arg_3_0.unlockCnt

	tonumber = var_1_10002

	local var_3_7 = arg_3_0.activity

	arg_3_0.unlockCnt = var_3_6 * var_1_10002(var_4.getConfig(var_3_7, "config_id"))

	local var_3_8

	if not (arg_3_0.unlockCnt > arg_3_0.totalCnt) or not arg_3_0.totalCnt then
		var_3_8 = arg_3_0.unlockCnt
	end

	arg_3_0.unlockCnt = var_3_8
	arg_3_0.remainCnt = arg_3_0.usedCnt >= arg_3_0.totalCnt and 0 or arg_3_0.unlockCnt - arg_3_0.usedCnt

	local var_3_9 = 1

	for iter_3_0 = 1, #arg_3_0.taskList do
		local var_3_10 = iter_3_0

		tf = var_3_11
		instantiate = var_1_10009

		local var_3_11 = var_3_11(var_1_10009(arg_3_0.itemTpl))

		setParent = var_1_10008

		var_1_10008(var_3_11, arg_3_0.items)

		Vector2 = var_1_10008
		var_3_11.anchoredPosition = var_1_10008(0, 0)
		setActive = var_1_10008

		var_1_10008(var_3_11, false)

		var_1_10008 = arg_3_0.taskList[iter_3_0]

		local var_3_12 = arg_3_0.taskProxy

		if not var_1_10009.getTaskById(var_3_12, var_1_10008) then
			local var_3_13 = arg_3_0.taskProxy

			var_1_10009 = var_1_10009.getFinishTaskById(var_3_13, var_1_10008)
		end

		local var_3_14 = var_1_10009:getConfig("award_display")[1]
		local var_3_15 = {
			type = var_3_14[1],
			id = var_3_14[2],
			count = var_3_14[3]
		}

		updateDrop = var_12
		findTF = var_1_10014

		var_12(var_1_10014(var_3_11, "item"), var_3_15)

		onButton = var_12
		var_1_10014 = arg_3_0

		local var_3_16 = var_3_11

		local function var_3_17()
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			BaseUI = var_2_10003

			var_4_1(var_4_0, var_2_10003.ON_DROP, var_3_15)

			return
		end

		SFX_PANEL = var_17

		var_12(var_1_10014, var_3_16, var_3_17, var_17)

		table = var_12

		var_12.insert(arg_3_0.itemTfs, var_3_11)

		var_1_10014 = var_3_11

		local var_3_18 = var_3_11.Find(var_1_10014, "get")

		onButton = var_13

		local var_3_19 = arg_3_0
		local var_3_20 = var_3_18

		local function var_3_21()
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_5_1(var_5_0, var_2_10003.ON_TASK_SUBMIT, var_1_10009)

			return
		end

		SFX_PANEL = var_1_10018

		var_13(var_3_19, var_3_20, var_3_21, var_1_10018)

		findTF = var_13

		local var_3_22 = var_13(arg_3_0.paintings, var_0_3[iter_3_0])

		table = var_1_10014

		var_1_10014.insert(arg_3_0.paintingTfs, var_3_22)

		GetComponent = var_1_10014
		findTF = var_16

		local var_3_23 = var_16(var_3_22, "normal")

		typeof = var_17
		Image = var_19
		var_1_10014 = var_1_10014(var_3_23, var_17(var_19))
		var_1_10014.alphaHitTestMinimumThreshold = 0.5
		onButton = var_15

		local var_3_24 = arg_3_0

		findTF = var_1_10018
		var_1_10018 = var_1_10018(var_3_22, "normal")

		local function var_3_25()
			local var_6_0 = arg_3_0

			var_0.selectedChange(var_6_0, var_3_10)

			return
		end

		SFX_PANEL = var_20

		var_15(var_3_24, var_1_10018, var_3_25, var_20)

		if var_1_10009:getTaskStatus() == 1 and arg_3_0.remainCnt > 0 then
			var_3_9 = iter_3_0
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
		setActive = var_1_10007
		findTF = var_9

		var_1_10007(var_9(var_1_10006, "name"), iter_7_0 == arg_7_1)

		setActive = var_1_10007
		findTF = var_9

		var_1_10007(var_9(var_1_10006, "selected"), iter_7_0 == arg_7_1)

		setActive = var_1_10007
		findTF = var_9

		var_1_10007(var_9(var_1_10006, "normal"), iter_7_0 ~= arg_7_1)

		var_1_10007 = arg_7_0.taskList[iter_7_0]

		local var_7_0 = arg_7_0.taskProxy
		local var_7_2

		if not var_8.getTaskById(var_7_0, var_1_10007) then
			local var_7_1 = arg_7_0.taskProxy

			var_7_2 = var_8.getFinishTaskById(var_7_1, var_1_10007)
		end

		local var_7_3 = var_7_2
		local var_7_4 = var_7_2.getTaskStatus(var_7_3) == 2

		setActive = var_7_3
		findTF = var_1_10013

		var_7_3(var_1_10013(var_1_10006, "mask"), not var_7_4 or arg_7_1 == iter_7_0)

		if iter_7_0 == arg_7_1 then
			setParent = var_7_3

			var_7_3(var_1_10006, arg_7_0.paintingsSelected)

			var_1_10013 = var_1_10006

			var_1_10006.SetAsLastSibling(var_1_10013)
		else
			setParent = var_7_3

			var_7_3(var_1_10006, arg_7_0.paintings)
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
		var_1_10009 = arg_8_0.taskProxy

		if var_7.getFinishTaskById(var_1_10009, iter_8_1) ~= nil then
			var_8_0 = var_8_0 + 1
		end
	end

	local var_8_1

	if arg_8_0.usedCnt ~= var_8_0 then
		arg_8_0.usedCnt = var_8_0
		var_8_1 = arg_8_0.activity
		var_8_1.data1 = arg_8_0.usedCnt
		getProxy = var_3
		ActivityProxy = iter_8_0

		local var_8_2 = var_3(iter_8_0)

		var_3.updateActivity(var_8_2, var_8_1)
	end

	pg = var_8_1

	local var_8_3 = var_8_1.TimeMgr.GetInstance()
	local var_8_4 = var_2.DiffDay
	local var_8_5 = arg_8_0.activity
	local var_8_6 = var_5.getStartTime(var_8_5)

	pg = iter_8_1

	local var_8_7 = iter_8_1.TimeMgr.GetInstance()

	arg_8_0.unlockCnt = var_8_4(var_8_3, var_8_6, var_6.GetServerTime(var_8_7)) + 1

	local var_8_8 = arg_8_0.unlockCnt

	tonumber = var_3

	local var_8_9 = arg_8_0.activity

	arg_8_0.unlockCnt = var_8_8 * var_3(var_5.getConfig(var_8_9, "config_id"))

	local var_8_10

	if not (arg_8_0.unlockCnt > arg_8_0.totalCnt) or not arg_8_0.totalCnt then
		var_8_10 = arg_8_0.unlockCnt
	end

	arg_8_0.unlockCnt = var_8_10

	local var_8_11 = arg_8_0.usedCnt

	arg_8_0.remainCnt = arg_8_0.totalCnt <= var_8_11 and 0 or arg_8_0.unlockCnt - arg_8_0.usedCnt
	setText = var_2

	local var_8_12 = arg_8_0.countTF

	tostring = var_5

	var_2(var_8_12, var_5(arg_8_0.remainCnt))

	local var_8_13 = arg_8_0.activity
	local var_8_14 = var_2.getConfig(var_8_13, "config_client").story

	ipairs = var_3

	for iter_8_2, iter_8_3 in var_3(arg_8_0.taskList) do
		local var_8_15 = arg_8_0.taskProxy

		if var_8.getFinishTaskById(var_8_15, iter_8_3) then
			checkExist = var_1_10009

			if var_1_10009(var_8_14, {
				iter_8_2
			}, {
				1
			}) then
				pg = var_1_10009

				local var_8_16 = var_1_10009.NewStoryMgr.GetInstance()

				var_1_10009.Play(var_8_16, var_8_14[iter_8_2][1])
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

		setActive = var_13

		var_13(var_9_10, var_9_11)

		setActive = var_13

		var_13(var_9_8, var_9_12)

		local var_9_13 = arg_9_0.paintingTfs[iter_9_0]

		setActive = var_1_10014
		findTF = var_16

		var_1_10014(var_16(var_9_13, "got"), var_9_12)

		setActive = var_1_10014
		findTF = var_16

		var_1_10014(var_16(var_9_13, "mask"), not var_9_12 or arg_9_0.selectedIndex == iter_9_0)
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
