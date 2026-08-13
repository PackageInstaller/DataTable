class = var_0_10000

local var_0_0 = "NewShipDocumentView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewShipDocumentView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListener()

	setActive = var_1

	var_1(arg_2_0._tf, true)

	LeanTween = var_1

	local var_2_0 = var_1.move

	rtf = var_2

	local var_2_1 = var_2(arg_2_0._tf)

	Vector3 = var_3

	var_2_0(var_2_1, var_3(-30, 0, 0), 0.3)

	return
end

function var_0_1.OnDestroy(arg_3_0)
	arg_3_0._shipVO = nil
	arg_3_0.confirmFunc = nil

	return
end

function var_0_1.InitUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.skillContainer = var_1.Find(var_4_0, "bg/skill_panel/frame/skill_list/viewport")
	arg_4_0.skillTpl = arg_4_0:getTpl("bg/skill_panel/frame/skilltpl", arg_4_0._tf)
	arg_4_0.emptyTpl = arg_4_0:getTpl("bg/skill_panel/frame/emptytpl", arg_4_0._tf)
	arg_4_0.addTpl = arg_4_0:getTpl("bg/skill_panel/frame/addtpl", arg_4_0._tf)

	return
end

function var_0_1.AddListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_3.Find(var_5_1, "qr_btn")

	local function var_5_3()
		arg_5_0.confirmFunc()

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5)

	return
end

function var_0_1.initSkills(arg_7_0)
	local var_7_0 = arg_7_0._shipVO
	local var_7_1 = var_1.getMaxConfigId(var_7_0)

	pg = var_7_0

	local var_7_2 = var_7_0.ship_data_template[var_7_1]
	local var_7_3 = 1

	ipairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(var_7_2.buff_list_display) do
		getSkillConfig = var_1_10009
		var_1_10009 = var_1_10009(iter_7_1)

		local var_7_4 = arg_7_0._shipVO.skills
		local var_7_5

		if var_7_4[iter_7_1] then
			cloneTplTo = var_12
			var_7_5 = var_12(arg_7_0.skillTpl, arg_7_0.skillContainer)
			onButton = var_12

			local var_7_6 = arg_7_0
			local var_7_7 = var_7_5

			local function var_7_8()
				local var_8_0 = arg_7_0
				local var_8_1 = var_0.emit

				NewShipMediator = var_2_10002

				var_8_1(var_8_0, var_2_10002.ON_SKILLINFO, var_1_10009.id, var_7_4[iter_7_1])

				return
			end

			SFX_PANEL = var_1_10016

			var_12(var_7_6, var_7_7, var_7_8, var_1_10016)
		else
			cloneTplTo = var_12
			var_7_5 = var_12(arg_7_0.emptyTpl, arg_7_0.skillContainer)
			setActive = var_12

			var_12(var_7_5:Find("mask"), true)

			onButton = var_12

			local var_7_9 = arg_7_0
			local var_7_10 = var_7_5

			local function var_7_11()
				local var_9_0 = arg_7_0
				local var_9_1 = var_0.emit

				NewShipMediator = var_2_10002

				var_9_1(var_9_0, var_2_10002.ON_SKILLINFO, var_1_10009.id)

				return
			end

			SFX_PANEL = var_1_10016

			var_12(var_7_9, var_7_10, var_7_11, var_1_10016)
		end

		var_7_3 = var_7_3 + 1
		LoadImageSpriteAsync = var_12

		local var_7_12 = "skillicon/" .. var_1_10009.icon

		findTF = var_14

		var_12(var_7_12, var_14(var_7_5, "icon"))
	end

	for iter_7_2 = var_7_3, 3 do
		cloneTplTo = iter_7_1

		iter_7_1(arg_7_0.addTpl, arg_7_0.skillContainer)
	end

	return
end

function var_0_1.UpdatePropertyPanel(arg_10_0)
	PropertyPanel = var_1_10001

	local var_10_0 = var_1_10001.New
	local var_10_1 = arg_10_0._tf

	arg_10_0.propertyPanel = var_10_0(var_2.Find(var_10_1, "bg/property_panel/frame"))

	local var_10_2 = arg_10_0.propertyPanel

	var_1.initProperty(var_10_2, arg_10_0._shipVO.configId)

	return
end

function var_0_1.getTpl(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:Find(arg_11_1)

	var_3.SetParent(var_11_0, arg_11_0._tf, false)

	SetActive = var_4

	var_4(var_3, false)

	return var_3
end

function var_0_1.SetParams(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._shipVO = arg_12_1
	arg_12_0.confirmFunc = arg_12_2

	return
end

function var_0_1.RefreshUI(arg_13_0)
	arg_13_0:initSkills()
	arg_13_0:UpdatePropertyPanel()

	return
end

return var_0_1
