local var_0_0 = class("SkinGuide5Page", import("...base.BaseActivityPage"))
local var_0_1 = {
	"guandao",
	"lafei2",
	"kelifulan",
	"xingzuo"
}
local var_0_2
local var_0_3 = "ui/activityuipage/skinguide5page_atlas"

function var_0_0.OnInit(arg_1_0)
	arg_1_0.ad = arg_1_0._tf:Find("AD")
	var_0_2 = PLATFORM_CODE == PLATFORM_JP and {
		Vector2(-488, 52),
		Vector2(-420, -41),
		Vector2(102, -82),
		Vector2(-471, -128)
	} or PLATFORM_CODE == PLATFORM_US and {
		Vector2(-480, 189),
		Vector2(-445, -101),
		Vector2(-410, -101),
		Vector2(-354, -108)
	} or {
		Vector2(-490, 130),
		Vector2(-400, -128),
		Vector2(89, 10),
		Vector2(-478, 57)
	}
	arg_1_0.paint = findTF(arg_1_0.ad, "paint")
	arg_1_0.paintGot = findTF(arg_1_0.paint, "show/got")
	arg_1_0.paintAnim = GetComponent(arg_1_0.paint, typeof(Animator))
	arg_1_0.itemContent = findTF(arg_1_0.ad, "items/content")
	arg_1_0.itemTpl = findTF(arg_1_0.ad, "items/content/itemTpl")

	setActive(arg_1_0.itemTpl, false)

	arg_1_0.iconContent = findTF(arg_1_0.ad, "iconContent")
	arg_1_0.iconTpl = findTF(arg_1_0.ad, "iconContent/IconTpl")

	setActive(arg_1_0.iconTpl, false)

	arg_1_0.desc = findTF(arg_1_0.ad, "desc")
	arg_1_0.got = findTF(arg_1_0.ad, "got")
	arg_1_0.get = findTF(arg_1_0.ad, "get")
	arg_1_0.getBound = findTF(arg_1_0.ad, "get_bound")
	arg_1_0.times = findTF(arg_1_0.ad, "times")

	onButton(arg_1_0, arg_1_0.get, function()
		if arg_1_0.selectIndex then
			arg_1_0:emit(ActivityMediator.ON_TASK_SUBMIT, (getProxy(TaskProxy):getTaskById(arg_1_0.skinDatas[arg_1_0.selectIndex].task)))
		end

		return
	end, sound, guideData)

	return
end

function var_0_0.OnDataSetting(arg_3_0)
	arg_3_0.taskProxy = getProxy(TaskProxy)
	arg_3_0.taskList = arg_3_0.activity:getConfig("config_data")
	arg_3_0.totalCnt = #arg_3_0.taskList

	if not arg_3_0.skinDatas then
		arg_3_0.skinDatas = {}

		for iter_3_0 = 1, #arg_3_0.taskList do
			local var_3_0 = tf(instantiate(arg_3_0.itemTpl))

			setParent(var_3_0, arg_3_0.itemContent)
			setActive(var_3_0, true)
			onButton(arg_3_0, var_3_0, function()
				arg_3_0:selectItem(iter_3_0)

				return
			end, SFX_CONFIRM)

			GetComponent(var_3_0, typeof(Image)).sprite = GetSpriteFromAtlas(var_0_3, "item_" .. var_0_1[iter_3_0])

			local var_3_1 = tf(Instantiate(arg_3_0.iconTpl))

			setParent(var_3_1, arg_3_0.iconContent)
			setActive(var_3_1, true)

			local var_3_2 = arg_3_0.taskProxy:getTaskById(arg_3_0.taskList[iter_3_0]) or arg_3_0.taskProxy:getFinishTaskById(arg_3_0.taskList[iter_3_0])
			local var_3_3 = var_3_2:getConfig("award_display")[1]

			updateDrop(var_3_1, {
				type = var_3_3[1],
				id = var_3_3[2],
				count = var_3_3[3]
			})
			onButton(arg_3_0, var_3_1, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			table.insert(arg_3_0.skinDatas, {
				task = arg_3_0.taskList[iter_3_0],
				name = var_0_1[iter_3_0],
				item = var_3_0,
				icon = var_3_1
			})
		end
	end

	return
end

function var_0_0.selectItem(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0.skinDatas do
		if LeanTween.isTweening(go(arg_6_0.skinDatas[iter_6_0].item)) then
			return
		end
	end

	local var_6_0 = 0

	for iter_6_1 = arg_6_1 + 1, #arg_6_0.skinDatas do
		arg_6_0.skinDatas[iter_6_1].item:SetAsFirstSibling()
		setActive(arg_6_0.skinDatas[iter_6_1].item, iter_6_1 ~= arg_6_1)
		setActive(arg_6_0.skinDatas[iter_6_1].icon, iter_6_1 == arg_6_1)

		arg_6_0.skinDatas[iter_6_1].targetPos = Vector2(var_6_0 * 215, 0)
		var_6_0 = var_6_0 + 1
	end

	for iter_6_2 = 1, arg_6_1 do
		arg_6_0.skinDatas[iter_6_2].item:SetAsFirstSibling()
		setActive(arg_6_0.skinDatas[iter_6_2].item, iter_6_2 ~= arg_6_1)
		setActive(arg_6_0.skinDatas[iter_6_2].icon, iter_6_2 == arg_6_1)

		arg_6_0.skinDatas[iter_6_2].targetPos = Vector2(var_6_0 * 215, 0)
		var_6_0 = var_6_0 + 1
	end

	local var_6_2 = arg_6_0.taskProxy:getFinishTaskById(arg_6_0.skinDatas[arg_6_1].task)

	setActive(arg_6_0.get, not var_6_2 and arg_6_0.remainCnt > 0)
	setActive(arg_6_0.getBound, not var_6_2 and arg_6_0.remainCnt > 0)
	setActive(arg_6_0.got, var_6_2)

	arg_6_0.paintGot.anchoredPosition = var_0_2[arg_6_1]

	setActive(arg_6_0.paintGot, var_6_2)

	local var_6_3 = GetComponent(findTF(arg_6_0.paint, "show"), typeof(Image))

	var_6_3.sprite = GetSpriteFromAtlas(var_0_3, "bg_" .. arg_6_0.skinDatas[arg_6_1].name)

	var_6_3:SetNativeSize()

	local var_6_4 = GetComponent(findTF(arg_6_0.paint, "temp"), typeof(Image))

	var_6_4.sprite = arg_6_0.selectIndex and GetSpriteFromAtlas(var_0_3, "bg_" .. arg_6_0.skinDatas[arg_6_0.selectIndex].name) or GetSpriteFromAtlas(var_0_3, "bg_" .. arg_6_0.skinDatas[arg_6_1].name)

	var_6_4:SetNativeSize()

	if arg_6_0.selectIndex and arg_6_0.selectIndex ~= arg_6_1 then
		arg_6_0.paintAnim:SetTrigger((arg_6_0.selectIndex ~= 1 or arg_6_1 ~= #arg_6_0.skinDatas or false) and (arg_6_0.selectIndex == #arg_6_0.skinDatas and arg_6_1 == 1 and true or arg_6_1 > arg_6_0.selectIndex) and "next" or "pre")
		arg_6_0:updateItemPos(true, var_6_5)
	else
		arg_6_0:updateItemPos(false)
	end

	arg_6_0.selectIndex = arg_6_1

	return
end

function var_0_0.OnFirstFlush(arg_7_0)
	arg_7_0.usedCnt = arg_7_0.activity:getData1()
	arg_7_0.unlockCnt = pg.TimeMgr.GetInstance():DiffDay(arg_7_0.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1

	if arg_7_0.unlockCnt > arg_7_0.totalCnt then
		arg_7_0.unlockCnt = arg_7_0.totalCnt or arg_7_0.unlockCnt
		arg_7_0.remainCnt = arg_7_0.usedCnt >= arg_7_0.totalCnt and 0 or arg_7_0.unlockCnt - arg_7_0.usedCnt

		setText(arg_7_0.desc, i18n("skin_page_desc", arg_7_0.activity:getConfig("config_id")))
		setText(findTF(arg_7_0.get, "desc"), i18n("skin_page_sign"))

		local var_7_0 = 1

		for iter_7_0 = 1, #arg_7_0.skinDatas do
			local var_7_1 = arg_7_0.taskProxy:getFinishTaskById(arg_7_0.skinDatas[iter_7_0].task) or false

			if not var_7_1 then
				var_7_0 = var_7_0 or iter_7_0
			end
		end

		arg_7_0:selectItem(var_7_0)
		arg_7_0:updateItemData()

		return
	end
end

function var_0_0.OnUpdateFlush(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskList) do
		if arg_8_0.taskProxy:getFinishTaskById(iter_8_1) ~= nil then
			var_8_0 = var_8_0 + 1
		end
	end

	if arg_8_0.usedCnt ~= var_8_0 then
		arg_8_0.usedCnt = var_8_0
		arg_8_0.activity.data1 = arg_8_0.usedCnt

		getProxy(ActivityProxy):updateActivity(arg_8_0.activity)
	end

	local var_8_1 = pg.TimeMgr.GetInstance()

	arg_8_0.unlockCnt = (var_8_1:DiffDay(arg_8_0.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1) * arg_8_0.activity:getConfig("config_id")

	if arg_8_0.unlockCnt > arg_8_0.totalCnt then
		arg_8_0.unlockCnt = arg_8_0.totalCnt or arg_8_0.unlockCnt
		arg_8_0.remainCnt = arg_8_0.usedCnt >= arg_8_0.totalCnt and 0 or arg_8_0.unlockCnt - arg_8_0.usedCnt

		setText(findTF(arg_8_0.times, "desc"), i18n("last_times_sign", arg_8_0.remainCnt))

		local var_8_2 = arg_8_0.activity:getConfig("config_client").story

		for iter_8_2, iter_8_3 in ipairs(arg_8_0.taskList) do
			if arg_8_0.taskProxy:getFinishTaskById(iter_8_3) and checkExist(var_8_2, {
				iter_8_2
			}, {
				1
			}) then
				pg.NewStoryMgr.GetInstance():Play(var_8_2[iter_8_2][1])
			end
		end

		arg_8_0:selectItem(arg_8_0.selectIndex)
		arg_8_0:updateItemData()

		return
	end
end

local var_0_4 = 215

function var_0_0.updateItemPos(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Vector2(-var_0_4, 0)
	local var_9_1 = Vector2((#arg_9_0.skinDatas - 1) * var_0_4, 0)

	for iter_9_0 = 1, #arg_9_0.skinDatas do
		local var_9_2 = arg_9_0.skinDatas[iter_9_0].item

		if LeanTween.isTweening(go(arg_9_0.skinDatas[iter_9_0].item)) then
			LeanTween.cancel(go(var_9_2))
		end

		local var_9_3 = arg_9_0.skinDatas[iter_9_0].targetPos

		if arg_9_1 then
			local var_9_4 = {}

			if not arg_9_2 and var_9_2.anchoredPosition.x > var_9_3.x then
				table.insert(var_9_4, var_9_1)
				table.insert(var_9_4, var_9_0)
			elseif arg_9_2 and var_9_2.anchoredPosition.x < var_9_3.x then
				table.insert(var_9_4, var_9_0)
				table.insert(var_9_4, var_9_1)
			end

			table.insert(var_9_4, var_9_3)
			table.insert(var_9_4, var_9_3)
			arg_9_0:tweenItem(var_9_2, var_9_4)
		else
			var_9_2.anchoredPosition = var_9_3
		end
	end

	return
end

function var_0_0.tweenItem(arg_10_0, arg_10_1, arg_10_2)
	if #arg_10_2 >= 2 then
		local var_10_0 = table.remove(arg_10_2, 1)
		local var_10_1 = table.remove(arg_10_2, 1)

		LeanTween.value(go(arg_10_1), arg_10_1.anchoredPosition.x, var_10_0.x, math.abs(var_10_0.x - arg_10_1.anchoredPosition.x) / var_0_4 * 0.25):setOnUpdate(System.Action_float(function(arg_11_0)
			var_0.x = arg_11_0
			arg_10_1.anchoredPosition = var_0

			return
		end)):setOnComplete(System.Action(function()
			arg_10_1.anchoredPosition = var_10_1

			arg_10_0:tweenItem(arg_10_1, arg_10_2)

			return
		end))
	end

	return
end

function var_0_0.updateItemData(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.skinDatas do
		local var_13_0 = arg_13_0.taskProxy:getFinishTaskById(arg_13_0.skinDatas[iter_13_0].task) or false

		setActive(findTF(arg_13_0.skinDatas[iter_13_0].item, "got"), var_13_0)
	end

	return
end

function var_0_0.OnDestroy(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.skinDatas do
		if LeanTween.isTweening(go(arg_14_0.skinDatas[iter_14_0].item)) then
			LeanTween.cancel(go(arg_14_0.skinDatas[iter_14_0].item), false)
		end
	end

	return
end

return var_0_0
