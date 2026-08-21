local var_0_0 = class("NewShipDocumentView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewShipDocumentView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListener()
	setActive(arg_2_0._tf, true)
	LeanTween.move(rtf(arg_2_0._tf), Vector3(-30, 0, 0), 0.3)

	return
end

function var_0_0.OnDestroy(arg_3_0)
	arg_3_0._shipVO = nil
	arg_3_0.confirmFunc = nil

	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.skillContainer = arg_4_0._tf:Find("bg/skill_panel/frame/skill_list/viewport")
	arg_4_0.skillTpl = arg_4_0:getTpl("bg/skill_panel/frame/skilltpl", arg_4_0._tf)
	arg_4_0.emptyTpl = arg_4_0:getTpl("bg/skill_panel/frame/emptytpl", arg_4_0._tf)
	arg_4_0.addTpl = arg_4_0:getTpl("bg/skill_panel/frame/addtpl", arg_4_0._tf)

	return
end

function var_0_0.AddListener(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf:Find("qr_btn"), function()
		arg_5_0.confirmFunc()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.initSkills(arg_7_0)
	local var_7_0 = 1

	for iter_7_0, iter_7_1 in ipairs(pg.ship_data_template[arg_7_0._shipVO:getMaxConfigId()].buff_list_display) do
		local var_7_1 = getSkillConfig(iter_7_1)
		local var_7_2

		if arg_7_0._shipVO.skills[iter_7_1] then
			var_7_2 = cloneTplTo(arg_7_0.skillTpl, arg_7_0.skillContainer)

			onButton(arg_7_0, var_7_2, function()
				arg_7_0:emit(NewShipMediator.ON_SKILLINFO, var_7_1.id, var_0[iter_7_1])

				return
			end, SFX_PANEL)
		else
			var_7_2 = cloneTplTo(arg_7_0.emptyTpl, arg_7_0.skillContainer)

			setActive(var_7_2:Find("mask"), true)
			onButton(arg_7_0, var_7_2, function()
				arg_7_0:emit(NewShipMediator.ON_SKILLINFO, var_7_1.id)

				return
			end, SFX_PANEL)
		end

		var_7_0 = var_7_0 + 1

		LoadImageSpriteAsync("skillicon/" .. var_7_1.icon, findTF(var_7_2, "icon"))
	end

	for iter_7_2 = var_7_0, 3 do
		cloneTplTo(arg_7_0.addTpl, arg_7_0.skillContainer)
	end

	return
end

function var_0_0.UpdatePropertyPanel(arg_10_0)
	arg_10_0.propertyPanel = PropertyPanel.New(arg_10_0._tf:Find("bg/property_panel/frame"))

	arg_10_0.propertyPanel:initProperty(arg_10_0._shipVO.configId)

	return
end

function var_0_0.getTpl(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:Find(arg_11_1)

	var_11_0:SetParent(arg_11_0._tf, false)
	SetActive(var_11_0, false)

	return var_11_0
end

function var_0_0.SetParams(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._shipVO = arg_12_1
	arg_12_0.confirmFunc = arg_12_2

	return
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:initSkills()
	arg_13_0:UpdatePropertyPanel()

	return
end

return var_0_0
