class = var_0_10000

local var_0_0 = "EducateNewsLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".base.EducateBaseUI"))
local var_0_2 = {}

EducateSpecialEvent = var_2
var_0_2[var_2.TAG_ING] = "5ACEFE"
EducateSpecialEvent = var_2
var_0_2[var_2.TAG_COMING] = "CB99FF"
EducateSpecialEvent = var_2
var_0_2[var_2.TAG_END] = "7C7E81"

local var_0_3 = {}

EducateSpecialEvent = var_3
var_0_3[var_3.TAG_ING] = "393A3C"
EducateSpecialEvent = var_3
var_0_3[var_3.TAG_COMING] = "393A3C"
EducateSpecialEvent = var_3
var_0_3[var_3.TAG_END] = "7C7E81"

function var_0_1.getUIName(arg_1_0)
	return "EducateNewsUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	arg_3_0.curTime = var_1.GetCurTime(var_3_0)
	getProxy = var_1
	EducateProxy = var_3_0

	local var_3_1 = var_1(var_3_0)
	local var_3_2 = var_1.GetEventProxy(var_3_1)

	arg_3_0.finishEvents = var_1.GetFinishSpecEventIds(var_3_2)
	arg_3_0.importEvents = {}
	arg_3_0.otherEvents = {}
	getProxy = var_1
	EducateProxy = var_3_2

	local var_3_3 = var_1(var_3_2)
	local var_3_4 = var_1.GetPersonalityId(var_3_3)

	ipairs = var_3_3
	pg = var_1_10003

	for iter_3_0, iter_3_1 in var_3_3(var_1_10003.child_event_special.all) do
		EducateSpecialEvent = var_1_10007

		local var_3_5 = var_1_10007.New(iter_3_1)

		if var_1_10007.IsShow(var_3_5) and var_1_10007:InMonth(arg_3_0.curTime.month) and var_1_10007:IsUnlockSite() and var_1_10007:IsMatch(var_3_4) then
			if var_1_10007:IsImport() then
				table = var_8

				var_8.insert(arg_3_0.importEvents, var_1_10007)
			elseif var_1_10007:IsOther() then
				table = var_8

				var_8.insert(arg_3_0.otherEvents, var_1_10007)
			end
		end
	end

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "anim_root")
	local var_4_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_4_0.anim = var_4_2(var_4_1, var_3(var_1_10004))

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.Find(var_4_3, "anim_root")
	local var_4_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_4_0.animEvent = var_4_5(var_4_4, var_3(var_1_10004))

	local var_4_6 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_6, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_4_7 = arg_4_0._tf

	arg_4_0.windowTF = var_1.Find(var_4_7, "anim_root/window")

	local var_4_8 = arg_4_0.windowTF

	arg_4_0.tplTF = var_1.Find(var_4_8, "tpl")
	setActive = var_1

	var_1(arg_4_0.tplTF, false)

	local var_4_9 = arg_4_0.windowTF

	arg_4_0.importTF = var_1.Find(var_4_9, "scrollview/view/content/import_news")
	UIItemList = var_1

	local var_4_10 = var_1.New
	local var_4_11 = arg_4_0.importTF

	arg_4_0.importUIList = var_4_10(var_2.Find(var_4_11, "list"), arg_4_0.tplTF)
	setText = var_1

	local var_4_12 = arg_4_0.importTF
	local var_4_13 = var_2.Find(var_4_12, "title/Text")

	i18n = var_4_12

	var_1(var_4_13, var_4_12("child_news_import_title"))

	setText = var_1

	local var_4_14 = arg_4_0.importTF
	local var_4_15 = var_2.Find(var_4_14, "empty/Text")

	i18n = var_4_14

	var_1(var_4_15, var_4_14("child_news_import_empty"))

	local var_4_16 = arg_4_0.windowTF

	arg_4_0.otherTF = var_1.Find(var_4_16, "scrollview/view/content/other_news")
	UIItemList = var_1

	local var_4_17 = var_1.New
	local var_4_18 = arg_4_0.otherTF

	arg_4_0.otherUIList = var_4_17(var_2.Find(var_4_18, "list"), arg_4_0.tplTF)
	setText = var_1

	local var_4_19 = arg_4_0.otherTF
	local var_4_20 = var_2.Find(var_4_19, "title/Text")

	i18n = var_4_19

	var_1(var_4_20, var_4_19("child_news_other_title"))

	setText = var_1

	local var_4_21 = arg_4_0.otherTF
	local var_4_22 = var_2.Find(var_4_21, "empty/Text")

	i18n = var_4_21

	var_1(var_4_22, var_4_21("child_news_other_empty"))

	return
end

function var_0_1.addListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_3.Find(var_6_1, "anim_root/bg")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0._close(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_0, var_6_2, var_6_3, var_5)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:OverlayPanel(arg_8_0._tf, {
		groupDelta = 1
	})
	arg_8_0:initNewsList()
	arg_8_0:updateNewsList()

	return
end

function var_0_1.initNewsList(arg_9_0)
	local var_9_0 = arg_9_0.importUIList

	var_1.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_0

			var_3.updateEventItem(var_10_0, arg_10_1, arg_10_2, true)
		end

		return
	end)

	local var_9_1 = arg_9_0.otherUIList

	var_1.make(var_9_1, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_9_0

			var_3.updateEventItem(var_11_0, arg_11_1, arg_11_2, false)
		end

		return
	end)

	return
end

function var_0_1.updateEventItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0

	if not arg_12_3 or not arg_12_0.importEvents[arg_12_1 + 1] then
		var_12_0 = arg_12_0.otherEvents[arg_12_1 + 1]
	end

	local var_12_1 = var_12_0
	local var_12_2 = var_12_0.GetTag(var_12_1, arg_12_0.finishEvents, arg_12_0.curTime.week)

	EducateSpecialEvent = var_12_1

	local var_12_3 = var_12_1.TAG2NAME[var_12_2]

	setImageColor = var_7

	local var_12_4 = arg_12_2
	local var_12_5 = arg_12_2.Find(var_12_4, "block")

	Color = var_12_4

	var_7(var_12_5, var_12_4.NewHex(var_0_2[var_12_2]))

	setText = var_7

	var_7(arg_12_2:Find("name"), var_12_0:getConfig("main_desc"))

	setTextColor = var_7

	local var_12_6 = arg_12_2
	local var_12_7 = arg_12_2.Find(var_12_6, "name")

	Color = var_12_6

	var_7(var_12_7, var_12_6.NewHex(var_0_3[var_12_2]))

	eachChild = var_7

	var_7(arg_12_2:Find("name/tags"), function(arg_13_0)
		setActive = var_2_10001

		var_2_10001(arg_13_0, arg_13_0.name == var_12_3)

		return
	end)

	setText = var_7

	var_7(arg_12_2:Find("time/Text"), var_12_0:GetTimeDesc())

	return
end

function var_0_1.updateNewsList(arg_14_0)
	CompareFuncs = var_1_10001

	local var_14_0 = var_1_10001({
		function(arg_15_0)
			return arg_15_0:GetTag(arg_14_0.finishEvents, arg_14_0.curTime.week)
		end,
		function(arg_16_0)
			return arg_16_0.id
		end
	})

	table = var_2

	var_2.sort(arg_14_0.importEvents, var_14_0)

	table = var_2

	var_2.sort(arg_14_0.otherEvents, var_14_0)

	setActive = var_2

	local var_14_1 = arg_14_0.importTF

	var_2(var_3.Find(var_14_1, "empty"), #arg_14_0.importEvents <= 0)

	setActive = var_2

	local var_14_2 = arg_14_0.otherTF

	var_2(var_3.Find(var_14_2, "empty"), #arg_14_0.otherEvents <= 0)

	local var_14_3 = arg_14_0.importUIList

	var_2.align(var_14_3, #arg_14_0.importEvents)

	local var_14_4 = arg_14_0.otherUIList

	var_2.align(var_14_4, #arg_14_0.otherEvents)

	return
end

function var_0_1._close(arg_17_0)
	local var_17_0 = arg_17_0.anim

	var_1.Play(var_17_0, "anim_educate_newsUI_out")

	return
end

function var_0_1.onBackPressed(arg_18_0)
	arg_18_0:_close()

	return
end

function var_0_1.willExit(arg_19_0)
	local var_19_0 = arg_19_0.animEvent

	var_1.SetEndEvent(var_19_0, nil)
	arg_19_0:UnOverlayPanel(arg_19_0._tf)

	return
end

return var_0_1
