class = var_0_10000

local var_0_0 = "ShipProfileDetailPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShipProfileDetailPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.detailRightBlurRect = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.propertyTF = var_1.Find(var_2_1, "bg/property_panel/frame")

	local var_2_2 = arg_2_0._tf

	arg_2_0.skillRect = var_1.Find(var_2_2, "bg/skill_panel/frame/skills_rect")

	local var_2_3 = arg_2_0.skillRect

	arg_2_0.skillPanel = var_1.Find(var_2_3, "skills")

	local var_2_4 = arg_2_0.skillRect

	arg_2_0.skillTpl = var_1.Find(var_2_4, "skilltpl")

	local var_2_5 = arg_2_0._tf

	arg_2_0.skillArrLeft = var_1.Find(var_2_5, "bg/skill_panel/frame/arrow1")

	local var_2_6 = arg_2_0._tf

	arg_2_0.skillArrRight = var_1.Find(var_2_6, "bg/skill_panel/frame/arrow2")

	return
end

function var_0_1.OnInit(arg_3_0)
	return
end

function var_0_1.EnterAnim(arg_4_0, arg_4_1, arg_4_2)
	LeanTween = var_1_10003

	local var_4_0 = var_1_10003.moveX

	rtf = var_1_10005

	local var_4_1 = var_4_0(var_1_10005(arg_4_0._tf), 0, arg_4_1)
	local var_4_2 = var_3.setEase

	LeanTweenType = var_6

	local var_4_3 = var_4_2(var_4_1, var_6.easeInOutSine)
	local var_4_4 = var_3.setOnComplete

	System = var_6

	var_4_4(var_4_3, var_6.Action(function()
		if arg_4_2 then
			arg_4_2()
		end

		return
	end))

	return
end

function var_0_1.ExistAnim(arg_6_0, arg_6_1, arg_6_2)
	LeanTween = var_1_10003

	local var_6_0 = var_1_10003.moveX

	rtf = var_1_10005

	local var_6_1 = var_6_0(var_1_10005(arg_6_0._tf), 1000, arg_6_1)
	local var_6_2 = var_3.setEase

	LeanTweenType = var_6

	local var_6_3 = var_6_2(var_6_1, var_6.easeInOutSine)
	local var_6_4 = var_3.setOnComplete

	System = var_6

	var_6_4(var_6_3, var_6.Action(function()
		if arg_6_2 then
			arg_6_2()
		end

		local var_7_0 = arg_6_0

		var_0.Hide(var_7_0)

		return
	end))

	return
end

function var_0_1.Update(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:Show()

	arg_8_0.shipGroup = arg_8_1
	arg_8_0.showTrans = arg_8_2

	arg_8_0:InitSkills()
	arg_8_0:InitProperty()

	if arg_8_3 then
		arg_8_3()
	end

	return
end

function var_0_1.InitProperty(arg_9_0)
	PropertyPanel = var_1_10001
	arg_9_0.propertyPanel = var_1_10001.New(arg_9_0.propertyTF)

	local var_9_0 = arg_9_0.propertyPanel

	var_1.initProperty(var_9_0, arg_9_0.shipGroup.shipConfig.id)

	if arg_9_0.showTrans and arg_9_0.shipGroup.trans then
		local var_9_1 = arg_9_0.propertyPanel

		var_1.initRadar(var_9_1, arg_9_0.shipGroup.groupConfig.trans_radar_chart)
	end

	return
end

function var_0_1.InitSkills(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.ship_data_template
	local var_10_1 = arg_10_0.shipGroup
	local var_10_2 = var_10_0[var_2.getShipConfigId(var_10_1, arg_10_0.showTrans)]
	local var_10_3 = 0

	Clone = var_1_10003

	local var_10_4 = var_1_10003(var_10_2.buff_list_display)

	if not arg_10_0.showTrans then
		_ = var_4

		var_4.each(arg_10_0.shipGroup.groupConfig.trans_skill, function(arg_11_0)
			table = var_2_10001

			var_2_10001.removebyvalue(var_10_4, arg_11_0)

			return
		end)
	end

	local var_10_5 = arg_10_0.skillPanel.childCount
	local var_10_6 = #var_10_4 < 3 and 3 or #var_10_4

	for iter_10_0 = var_10_5 + 1, var_10_6 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_10_0.skillTpl, arg_10_0.skillPanel)
	end

	local var_10_7 = arg_10_0.skillPanel.childCount

	for iter_10_1 = 1, var_10_7 do
		local var_10_8 = arg_10_0.skillPanel
		local var_10_9 = var_10.GetChild(var_10_8, iter_10_1 - 1)

		if iter_10_1 <= #var_10_4 then
			var_1_10011 = var_10_4[iter_10_1]

			arg_10_0:UpdateSkill(var_10_9, var_1_10011)
		else
			setActive = var_1_10011

			var_1_10011(var_10_9:Find("icon"), false)

			setActive = var_1_10011

			var_1_10011(var_10_9:Find("add"), true)
		end

		setActive = var_1_10011

		var_1_10011(var_10_9, iter_10_1 <= var_10_6)
	end

	setActive = var_6

	var_6(arg_10_0.skillArrLeft, #var_10_4 > 3)

	setActive = var_6

	var_6(arg_10_0.skillArrRight, #var_10_4 > 3)

	if #var_10_4 > 3 then
		onScroll = var_6

		var_6(arg_10_0, arg_10_0.skillRect, function(arg_12_0)
			setActive = var_2_10001

			var_2_10001(arg_10_0.skillArrLeft, arg_12_0.x > 0.01)

			setActive = var_2_10001

			var_2_10001(arg_10_0.skillArrRight, arg_12_0.x < 0.99)

			return
		end)
	else
		GetComponent = var_6

		local var_10_10 = arg_10_0.skillRect

		typeof = var_9
		ScrollRect = var_1_10011

		local var_10_11 = var_6(var_10_10, var_9(var_1_10011)).onValueChanged

		var_6.RemoveAllListeners(var_10_11)
	end

	setAnchoredPosition = var_6

	var_6(arg_10_0.skillPanel, {
		x = 0
	})

	return
end

function var_0_1.UpdateSkill(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.shipGroup

	if var_3.isBluePrintGroup(var_13_0) then
		ipairs = var_3

		local var_13_1 = arg_13_0.shipGroup

		for iter_13_0, iter_13_1 in var_3(var_5.getBluePrintChangeSkillList(var_13_1)) do
			if iter_13_1[1] == arg_13_2 then
				arg_13_2 = iter_13_1[2]

				break
			end
		end
	end

	findTF = var_3

	local var_13_2 = var_3(arg_13_1, "icon")

	getSkillConfig = var_1_10004

	local var_13_3 = var_1_10004(arg_13_2)

	LoadImageSpriteAsync = var_5

	var_5("skillicon/" .. var_13_3.icon, var_13_2)

	setActive = var_5

	var_5(arg_13_1:Find("icon"), true)

	setActive = var_5

	var_5(arg_13_1:Find("add"), false)

	onButton = var_5

	local var_13_4 = arg_13_0
	local var_13_5 = arg_13_1

	local function var_13_6()
		local var_14_0 = arg_13_0
		local var_14_1 = var_0.emit

		ShipProfileScene = var_2_10003

		local var_14_2 = var_2_10003.SHOW_SKILL_INFO
		local var_14_3 = var_13_3.id
		local var_14_4 = {
			id = var_13_3.id
		}

		pg = var_6
		var_14_4.level = var_6.skill_data_template[var_13_3.id].max_level

		var_14_1(var_14_0, var_14_2, var_14_3, var_14_4)

		return
	end

	SFX_PANEL = var_10

	var_5(var_13_4, var_13_5, var_13_6, var_10)

	return
end

function var_0_1.OnDestroy(arg_15_0)
	return
end

return var_0_1
