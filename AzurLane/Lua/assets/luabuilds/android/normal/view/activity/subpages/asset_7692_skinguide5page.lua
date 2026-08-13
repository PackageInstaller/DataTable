class = var_0_10000

local var_0_0 = "SkinGuide5Page"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = {
	"guandao",
	"lafei2",
	"kelifulan",
	"xingzuo"
}
local var_0_3
local var_0_4 = "ui/activityuipage/skinguide5page_atlas"

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.ad = var_1.Find(var_1_0, "AD")
	PLATFORM_CODE = var_1_1
	PLATFORM_JP = var_1_0

	local var_1_1

	if var_1_1 == var_1_0 then
		var_1_1 = {}
		Vector2 = var_1_0
		var_1_1[1] = var_1_0(-488, 52)
		Vector2 = var_1_0
		var_1_1[2] = var_1_0(-420, -41)
		Vector2 = var_1_0
		var_1_1[3] = var_1_0(102, -82)
		Vector2 = var_1_0
		var_1_1[4] = var_1_0(-471, -128)
		var_0_3 = var_1_1
	else
		PLATFORM_CODE = var_1_1
		PLATFORM_US = var_1_0

		if var_1_1 == var_1_0 then
			var_1_1 = {}
			Vector2 = var_1_0
			var_1_1[1] = var_1_0(-480, 189)
			Vector2 = var_1_0
			var_1_1[2] = var_1_0(-445, -101)
			Vector2 = var_1_0
			var_1_1[3] = var_1_0(-410, -101)
			Vector2 = var_1_0
			var_1_1[4] = var_1_0(-354, -108)
			var_0_3 = var_1_1
		else
			var_1_1 = {}
			Vector2 = var_1_0
			var_1_1[1] = var_1_0(-490, 130)
			Vector2 = var_2
			var_1_1[2] = var_2(-400, -128)
			Vector2 = var_2
			var_1_1[3] = var_2(89, 10)
			Vector2 = var_2
			var_1_1[4] = var_2(-478, 57)
			var_0_3 = var_1_1
		end
	end

	findTF = var_1_1
	arg_1_0.paint = var_1_1(arg_1_0.ad, "paint")
	findTF = var_1
	arg_1_0.paintGot = var_1(arg_1_0.paint, "show/got")
	GetComponent = var_1

	local var_1_2 = arg_1_0.paint

	typeof = var_3
	Animator = var_1_10004
	arg_1_0.paintAnim = var_1(var_1_2, var_3(var_1_10004))
	findTF = var_1
	arg_1_0.itemContent = var_1(arg_1_0.ad, "items/content")
	findTF = var_1
	arg_1_0.itemTpl = var_1(arg_1_0.ad, "items/content/itemTpl")
	setActive = var_1

	var_1(arg_1_0.itemTpl, false)

	findTF = var_1
	arg_1_0.iconContent = var_1(arg_1_0.ad, "iconContent")
	findTF = var_1
	arg_1_0.iconTpl = var_1(arg_1_0.ad, "iconContent/IconTpl")
	setActive = var_1

	var_1(arg_1_0.iconTpl, false)

	findTF = var_1
	arg_1_0.desc = var_1(arg_1_0.ad, "desc")
	findTF = var_1
	arg_1_0.got = var_1(arg_1_0.ad, "got")
	findTF = var_1
	arg_1_0.get = var_1(arg_1_0.ad, "get")
	findTF = var_1
	arg_1_0.getBound = var_1(arg_1_0.ad, "get_bound")
	findTF = var_1
	arg_1_0.times = var_1(arg_1_0.ad, "times")
	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.get

	local function var_1_5()
		if arg_1_0.selectIndex then
			getProxy = var_0
			TaskProxy = var_2_10001

			local var_2_0 = var_0(var_2_10001)
			local var_2_1 = var_0.getTaskById(var_2_0, arg_1_0.skinDatas[arg_1_0.selectIndex].task)
			local var_2_2 = arg_1_0
			local var_2_3 = var_1.emit

			ActivityMediator = var_3

			var_2_3(var_2_2, var_3.ON_TASK_SUBMIT, var_2_1)
		end

		return
	end

	sound = var_1_10005
	guideData = var_1_10006

	var_1(var_1_3, var_1_4, var_1_5, var_1_10005, var_1_10006)

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_3_0.taskProxy = var_1_10001(var_1_10002)

	local var_3_0 = arg_3_0.activity

	arg_3_0.taskList = var_1.getConfig(var_3_0, "config_data")
	arg_3_0.totalCnt = #arg_3_0.taskList

	if not arg_3_0.skinDatas then
		arg_3_0.skinDatas = {}

		for iter_3_0 = 1, #arg_3_0.taskList do
			local var_3_1 = arg_3_0.taskList[iter_3_0]
			local var_3_2 = var_0_2[iter_3_0]

			tf = var_1_10007
			instantiate = var_1_10008
			var_1_10007 = var_1_10007(var_1_10008(arg_3_0.itemTpl))
			setParent = var_1_10008

			var_1_10008(var_1_10007, arg_3_0.itemContent)

			setActive = var_1_10008

			var_1_10008(var_1_10007, true)

			onButton = var_1_10008

			local var_3_3 = arg_3_0
			local var_3_4 = var_1_10007

			local function var_3_5()
				local var_4_0 = arg_3_0

				var_0.selectItem(var_4_0, iter_3_0)

				return
			end

			SFX_CONFIRM = var_1_10012

			var_1_10008(var_3_3, var_3_4, var_3_5, var_1_10012)

			GetComponent = var_1_10008

			local var_3_6 = var_1_10007

			typeof = var_3_4
			Image = var_3_5
			var_1_10008 = var_1_10008(var_3_6, var_3_4(var_3_5))
			GetSpriteFromAtlas = var_3_6
			var_1_10008.sprite = var_3_6(var_0_4, "item_" .. var_3_2)
			tf = var_9
			Instantiate = var_10

			local var_3_7 = var_9(var_10(arg_3_0.iconTpl))

			setParent = var_10

			var_10(var_3_7, arg_3_0.iconContent)

			setActive = var_10

			var_10(var_3_7, true)

			local var_3_8 = arg_3_0.taskProxy
			local var_3_10

			if not var_10.getTaskById(var_3_8, var_3_1) then
				local var_3_9 = arg_3_0.taskProxy

				var_3_10 = var_10.getFinishTaskById(var_3_9, var_3_1)
			end

			var_1_10012 = var_3_10

			local var_3_11 = var_3_10.getConfig(var_1_10012, "award_display")[1]

			var_1_10012 = {
				type = var_3_11[1],
				id = var_3_11[2],
				count = var_3_11[3]
			}
			updateDrop = var_13

			var_13(var_3_7, var_1_10012)

			onButton = var_13

			local var_3_12 = arg_3_0
			local var_3_13 = var_3_7

			local function var_3_14()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_2_10002

				var_5_1(var_5_0, var_2_10002.ON_DROP, var_1_10012)

				return
			end

			SFX_PANEL = var_1_10017

			var_13(var_3_12, var_3_13, var_3_14, var_1_10017)

			table = var_13

			var_13.insert(arg_3_0.skinDatas, {
				task = var_3_1,
				name = var_3_2,
				item = var_1_10007,
				icon = var_3_7
			})
		end
	end

	return
end

function var_0_1.selectItem(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0.skinDatas do
		local var_6_0 = arg_6_0.skinDatas[iter_6_0].item

		LeanTween = var_1_10007
		var_1_10007 = var_1_10007.isTweening
		go = var_1_10008

		if var_1_10007(var_1_10008(var_6_0)) then
			return
		end
	end

	local var_6_1 = 0

	for iter_6_1 = arg_6_1 + 1, #arg_6_0.skinDatas do
		local var_6_2 = arg_6_0.skinDatas[iter_6_1].item

		var_7.SetAsFirstSibling(var_6_2)

		setActive = var_7

		var_7(arg_6_0.skinDatas[iter_6_1].item, iter_6_1 ~= arg_6_1)

		setActive = var_7

		var_7(arg_6_0.skinDatas[iter_6_1].icon, iter_6_1 == arg_6_1)

		local var_6_3 = arg_6_0.skinDatas[iter_6_1]

		Vector2 = var_8
		var_6_3.targetPos = var_8(var_6_1 * 215, 0)
		var_6_1 = var_6_1 + 1
	end

	for iter_6_2 = 1, arg_6_1 do
		local var_6_4 = arg_6_0.skinDatas[iter_6_2].item

		var_7.SetAsFirstSibling(var_6_4)

		setActive = var_7

		var_7(arg_6_0.skinDatas[iter_6_2].item, iter_6_2 ~= arg_6_1)

		setActive = var_7

		var_7(arg_6_0.skinDatas[iter_6_2].icon, iter_6_2 == arg_6_1)

		local var_6_5 = arg_6_0.skinDatas[iter_6_2]

		Vector2 = var_8
		var_6_5.targetPos = var_8(var_6_1 * 215, 0)
		var_6_1 = var_6_1 + 1
	end

	local var_6_6 = arg_6_0.skinDatas[arg_6_1].task
	local var_6_7 = arg_6_0.skinDatas[arg_6_1].task
	local var_6_8 = arg_6_0.taskProxy
	local var_6_9 = var_5.getFinishTaskById(var_6_8, var_6_7)

	setActive = var_6_8

	var_6_8(arg_6_0.get, not var_6_9 and arg_6_0.remainCnt > 0)

	setActive = var_6_8

	var_6_8(arg_6_0.getBound, not var_6_9 and arg_6_0.remainCnt > 0)

	setActive = var_6_8

	var_6_8(arg_6_0.got, var_6_9)

	local var_6_10 = arg_6_0.paintGot

	var_6_10.anchoredPosition = var_0_3[arg_6_1]
	setActive = var_6_10

	var_6_10(arg_6_0.paintGot, var_6_9)

	GetComponent = var_6_10
	findTF = var_7

	local var_6_11 = var_7(arg_6_0.paint, "show")

	typeof = var_8
	Image = var_9

	local var_6_12 = var_6_10(var_6_11, var_8(var_9))

	GetSpriteFromAtlas = var_6_11
	var_6_12.sprite = var_6_11(var_0_4, "bg_" .. arg_6_0.skinDatas[arg_6_1].name)

	local var_6_13 = var_6_12

	var_6_12.SetNativeSize(var_6_13)

	GetComponent = var_7
	findTF = var_6_13

	local var_6_14 = var_6_13(arg_6_0.paint, "temp")

	typeof = var_9
	Image = var_10

	local var_6_15 = var_7(var_6_14, var_9(var_10))

	if arg_6_0.selectIndex then
		GetSpriteFromAtlas = var_8
		var_6_15.sprite = var_8(var_0_4, "bg_" .. arg_6_0.skinDatas[arg_6_0.selectIndex].name)
	else
		GetSpriteFromAtlas = var_8
		var_6_15.sprite = var_8(var_0_4, "bg_" .. arg_6_0.skinDatas[arg_6_1].name)
	end

	var_6_15:SetNativeSize()

	if arg_6_0.selectIndex and arg_6_0.selectIndex ~= arg_6_1 then
		local var_6_16
		local var_6_17 = (arg_6_0.selectIndex ~= 1 or arg_6_1 ~= #arg_6_0.skinDatas or false) and (arg_6_0.selectIndex == #arg_6_0.skinDatas and arg_6_1 == 1 and true or arg_6_1 > arg_6_0.selectIndex and true or false)
		local var_6_18 = arg_6_0.paintAnim

		var_9.SetTrigger(var_6_18, var_6_17 and "next" or "pre")
		arg_6_0:updateItemPos(true, var_6_17)
	else
		arg_6_0:updateItemPos(false)
	end

	arg_6_0.selectIndex = arg_6_1

	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	local var_7_0 = arg_7_0.activity

	arg_7_0.usedCnt = var_1.getData1(var_7_0)
	pg = var_1

	local var_7_1 = var_1.TimeMgr.GetInstance()
	local var_7_2 = var_1.DiffDay
	local var_7_3 = arg_7_0.activity
	local var_7_4 = var_3.getStartTime(var_7_3)

	pg = var_7_3

	local var_7_5 = var_7_3.TimeMgr.GetInstance()

	arg_7_0.unlockCnt = var_7_2(var_7_1, var_7_4, var_4.GetServerTime(var_7_5)) + 1

	local var_7_6

	if not (arg_7_0.unlockCnt > arg_7_0.totalCnt) or not arg_7_0.totalCnt then
		var_7_6 = arg_7_0.unlockCnt
	end

	arg_7_0.unlockCnt = var_7_6
	arg_7_0.remainCnt = arg_7_0.usedCnt >= arg_7_0.totalCnt and 0 or arg_7_0.unlockCnt - arg_7_0.usedCnt
	setText = var_1

	local var_7_7 = arg_7_0.desc

	i18n = var_7_4

	local var_7_8 = "skin_page_desc"
	local var_7_9 = arg_7_0.activity

	var_1(var_7_7, var_7_4(var_7_8, var_5.getConfig(var_7_9, "config_id")))

	setText = var_1
	findTF = var_7_7

	local var_7_10 = var_7_7(arg_7_0.get, "desc")

	i18n = var_3

	var_1(var_7_10, var_3("skin_page_sign"))

	local var_7_11 = 1

	for iter_7_0 = 1, #arg_7_0.skinDatas do
		local var_7_12 = arg_7_0.skinDatas[iter_7_0].task
		local var_7_13 = arg_7_0.taskProxy
		local var_7_14

		if not var_7.getFinishTaskById(var_7_13, var_7_12) then
			var_7_14 = false
		end

		if not var_7_14 then
			var_7_11 = var_7_11 or iter_7_0
		end
	end

	arg_7_0:selectItem(var_7_11)
	arg_7_0:updateItemData()

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
	local var_8_9 = var_8_5(var_8_4, var_8_7, var_5.GetServerTime(var_8_8)) + 1
	local var_8_10 = arg_8_0.activity

	arg_8_0.unlockCnt = var_8_9 * var_3.getConfig(var_8_10, "config_id")

	local var_8_11

	if not (arg_8_0.unlockCnt > arg_8_0.totalCnt) or not arg_8_0.totalCnt then
		var_8_11 = arg_8_0.unlockCnt
	end

	arg_8_0.unlockCnt = var_8_11

	local var_8_12 = arg_8_0.usedCnt

	arg_8_0.remainCnt = arg_8_0.totalCnt <= var_8_12 and 0 or arg_8_0.unlockCnt - arg_8_0.usedCnt
	setText = var_2
	findTF = var_3

	local var_8_13 = var_3(arg_8_0.times, "desc")

	i18n = var_4

	var_2(var_8_13, var_4("last_times_sign", arg_8_0.remainCnt))

	local var_8_14 = arg_8_0.activity
	local var_8_15 = var_2.getConfig(var_8_14, "config_client").story

	ipairs = var_8_14

	for iter_8_2, iter_8_3 in var_8_14(arg_8_0.taskList) do
		local var_8_16 = arg_8_0.taskProxy

		if var_8.getFinishTaskById(var_8_16, iter_8_3) then
			checkExist = var_8_16

			if var_8_16(var_8_15, {
				iter_8_2
			}, {
				1
			}) then
				pg = var_9

				local var_8_17 = var_9.NewStoryMgr.GetInstance()

				var_9.Play(var_8_17, var_8_15[iter_8_2][1])
			end
		end
	end

	arg_8_0:selectItem(arg_8_0.selectIndex)
	arg_8_0:updateItemData()

	return
end

local var_0_5 = 215

function var_0_1.updateItemPos(arg_9_0, arg_9_1, arg_9_2)
	Vector2 = var_1_10003

	local var_9_0 = var_1_10003(-var_0_5, 0)

	Vector2 = var_4

	local var_9_1 = var_4((#arg_9_0.skinDatas - 1) * var_0_5, 0)

	for iter_9_0 = 1, #arg_9_0.skinDatas do
		local var_9_2 = arg_9_0.skinDatas[iter_9_0].item

		LeanTween = var_1_10010
		var_1_10010 = var_1_10010.isTweening
		go = var_1_10011

		if var_1_10010(var_1_10011(var_9_2)) then
			LeanTween = var_1_10010
			var_1_10010 = var_1_10010.cancel
			go = var_1_10011

			var_1_10010(var_1_10011(var_9_2))
		end

		var_1_10010 = arg_9_0.skinDatas[iter_9_0].targetPos

		if arg_9_1 then
			var_1_10011 = var_9_2.anchoredPosition

			local var_9_3 = {}

			if not arg_9_2 and var_1_10011.x > var_1_10010.x then
				table = var_1_10013

				var_1_10013.insert(var_9_3, var_9_1)

				table = var_1_10013

				var_1_10013.insert(var_9_3, var_9_0)
			elseif arg_9_2 and var_1_10011.x < var_1_10010.x then
				table = var_1_10013

				var_1_10013.insert(var_9_3, var_9_0)

				table = var_1_10013

				var_1_10013.insert(var_9_3, var_9_1)
			end

			table = var_1_10013

			var_1_10013.insert(var_9_3, var_1_10010)

			table = var_1_10013

			var_1_10013.insert(var_9_3, var_1_10010)
			arg_9_0:tweenItem(var_9_2, var_9_3)
		else
			var_9_2.anchoredPosition = var_1_10010
		end
	end

	return
end

function var_0_1.tweenItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = #arg_10_2

	if 2 <= var_10_0 then
		local var_10_1 = arg_10_1.anchoredPosition

		table = var_4

		local var_10_2 = var_4.remove(arg_10_2, 1)

		table = var_5

		local var_10_3 = var_5.remove(arg_10_2, 1)

		math = var_6

		local var_10_4 = var_6.abs(var_10_2.x - var_10_1.x) / var_0_5 * 0.25

		LeanTween = var_7

		local var_10_5 = var_7.value

		go = var_8

		local var_10_6 = var_10_5(var_8(arg_10_1), var_10_1.x, var_10_2.x, var_10_4)
		local var_10_7 = var_7.setOnUpdate

		System = var_9

		local var_10_8 = var_10_7(var_10_6, var_9.Action_float(function(arg_11_0)
			var_10_1.x = arg_11_0
			arg_10_1.anchoredPosition = var_10_1

			return
		end))
		local var_10_9 = var_7.setOnComplete

		System = var_9

		var_10_9(var_10_8, var_9.Action(function()
			arg_10_1.anchoredPosition = var_10_3

			local var_12_0 = arg_10_0

			var_0.tweenItem(var_12_0, arg_10_1, arg_10_2)

			return
		end))
	end

	return
end

function var_0_1.updateItemData(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.skinDatas do
		local var_13_0 = arg_13_0.skinDatas[iter_13_0].item
		local var_13_1 = arg_13_0.skinDatas[iter_13_0].task
		local var_13_2 = arg_13_0.taskProxy
		local var_13_3

		if not var_7.getFinishTaskById(var_13_2, var_13_1) then
			var_13_3 = false
		end

		setActive = var_13_2
		findTF = var_9

		var_13_2(var_9(var_13_0, "got"), var_13_3)
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.skinDatas do
		local var_14_0 = arg_14_0.skinDatas[iter_14_0].item

		LeanTween = var_1_10006
		var_1_10006 = var_1_10006.isTweening
		go = var_1_10007

		if var_1_10006(var_1_10007(var_14_0)) then
			LeanTween = var_1_10006
			var_1_10006 = var_1_10006.cancel
			go = var_1_10007

			var_1_10006(var_1_10007(var_14_0), false)
		end
	end

	return
end

return var_0_1
