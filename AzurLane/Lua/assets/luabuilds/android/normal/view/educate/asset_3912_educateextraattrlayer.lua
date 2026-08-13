class = var_0_10000

local var_0_0 = "EducateExtraAttrLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateExtraAttrUI"
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

	arg_3_0.char = var_1.GetCharData(var_3_0)

	local var_3_1 = arg_3_0.char
	local var_3_2 = var_1.GetAttrIdsByType

	EducateChar = var_1_10003
	arg_3_0.attrList = var_3_2(var_3_1, var_1_10003.ATTR_TYPE_PERSONALITY)
	arg_3_0.selectedIndex = 0

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.windowTF = var_1.Find(var_4_0, "window")
	UIItemList = var_1

	local var_4_1 = var_1.New
	local var_4_2 = arg_4_0.windowTF
	local var_4_3 = var_2.Find(var_4_2, "content")
	local var_4_4 = arg_4_0.windowTF

	arg_4_0.attrUIList = var_4_1(var_4_3, var_3.Find(var_4_4, "content/tpl"))

	local var_4_5 = arg_4_0.windowTF

	arg_4_0.avatarTF = var_1.Find(var_4_5, "avatar")

	local var_4_6 = arg_4_0.avatarTF

	arg_4_0.curPersonalText = var_1.Find(var_4_6, "Text")

	local var_4_7 = arg_4_0.windowTF

	arg_4_0.sureBtn = var_1.Find(var_4_7, "sure_btn")

	return
end

function var_0_1.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.sureBtn

	local function var_5_2()
		if arg_5_0.selectedIndex == 0 then
			return
		end

		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit
		local var_6_2 = var_0_1.EDUCATE_ON_MSG_TIP
		local var_6_3 = {}

		i18n = var_2_10004
		var_6_3.content = var_2_10004("child_extraAttr_sure_tip")

		function var_6_3.onYes()
			local var_7_0 = arg_5_0
			local var_7_1 = var_0.emit

			EducateExtraAttrMediator = var_3_10002

			var_7_1(var_7_0, var_3_10002.ON_ATTR_ADD, {
				id = arg_5_0.attrList[arg_5_0.selectedIndex]
			})

			local var_7_2 = arg_5_0

			var_0.emit(var_7_2, var_0_1.ON_CLOSE)

			return
		end

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:OverlayPanel(arg_8_0._tf, {
		groupDelta = 1
	})

	local var_8_0 = arg_8_0.attrUIList

	var_1.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		local var_9_0

		if arg_9_0 == var_2_10003.EventInit then
			pg = var_9_0
			var_9_0 = var_9_0.child_attr[arg_8_0.attrList[arg_9_1 + 1]]
			LoadImageSpriteAsync = var_4

			var_4("educateprops/" .. var_9_0.icon, arg_9_2:Find("icon"), true)

			setText = var_4

			var_4(arg_9_2:Find("name"), var_9_0.name)

			onButton = var_4

			local var_9_1 = arg_8_0
			local var_9_2 = arg_9_2

			local function var_9_3()
				if arg_8_0.selectedIndex == arg_9_1 + 1 then
					return
				end

				arg_8_0.selectedIndex = arg_9_1 + 1

				local var_10_0 = arg_8_0

				var_0.updateView(var_10_0)

				return
			end

			SFX_PANEL = var_8

			var_4(var_9_1, var_9_2, var_9_3, var_8)
		else
			UIItemList = var_9_0

			if arg_9_0 == var_9_0.EventUpdate then
				setActive = var_3

				var_3(arg_9_2:Find("selected"), arg_8_0.selectedIndex == arg_9_1 + 1)
			end
		end

		return
	end)
	arg_8_0:updateView()

	return
end

function var_0_1.updateView(arg_11_0)
	local var_11_0 = arg_11_0.attrUIList

	var_1.align(var_11_0, #arg_11_0.attrList)

	local var_11_1 = arg_11_0.char
	local var_11_2 = var_1.GetPaintingName(var_11_1)
	local var_11_3 = arg_11_0.char
	local var_11_4 = var_2.GetPersonalityId(var_11_3)

	setText = var_11_3

	local var_11_5 = arg_11_0.curPersonalText
	local var_11_6 = "当前主导个性："

	pg = var_1_10006

	var_11_3(var_11_5, var_11_6 .. var_1_10006.child_attr[var_11_4].name)

	return
end

function var_0_1.willExit(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_1
