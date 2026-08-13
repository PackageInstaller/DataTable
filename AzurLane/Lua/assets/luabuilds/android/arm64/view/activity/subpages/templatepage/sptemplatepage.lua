class = var_0_10000

local var_0_0 = "SpTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.buildBtn = var_1.Find(var_1_0, "build_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	local var_2_0 = arg_2_0.activity
	local var_2_1

	if not var_1.getConfig(var_2_0, "config_client").linkPoolActID then
		pg = var_1_10002
		var_2_1 = var_1_10002.TipsMgr.GetInstance()

		var_1_10002.ShowTips(var_2_1, "未配置linkPoolActID！！！")
	else
		getProxy = var_1_10002
		ActivityProxy = var_2_1

		local var_2_2 = var_1_10002(var_2_1)

		if var_2.getActivityById(var_2_2, var_1) and not var_2:isEnd() then
			setActive = var_2_0

			var_2_0(arg_2_0.buildBtn, true)

			pg = var_2_0

			local var_2_3

			if not var_2_0.activity_template[var_1].config_client.id or not var_4 then
				::label_2_0::

				BuildShipScene = var_2_3
				var_2_3 = var_2_3.PROJECTS.SPECIAL
			end

			local var_2_4 = {}

			BuildShipScene = var_1_10007
			var_2_4[1] = var_1_10007.PROJECTS.SPECIAL
			BuildShipScene = var_7
			var_2_4[2] = var_7.PROJECTS.LIGHT
			BuildShipScene = var_7
			var_2_4[3] = var_7.PROJECTS.HEAVY
			BuildShipScene = var_7
			var_2_4[4] = var_7.PROJECTS.ACTIVITY
			onButton = var_7

			local var_2_5 = arg_2_0
			local var_2_6 = arg_2_0.buildBtn

			local function var_2_7()
				local var_3_0 = arg_2_0
				local var_3_1 = var_0.emit

				ActivityMediator = var_2_10003

				local var_3_2 = var_2_10003.EVENT_GO_SCENE

				SCENE = var_2_10004

				local var_3_3 = var_2_10004.GETBOAT
				local var_3_4 = {}

				BuildShipScene = var_2_10006
				var_3_4.page = var_2_10006.PAGE_BUILD
				var_3_4.projectName = var_2_4[var_2_3]

				var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

				return
			end

			SFX_PANEL = var_1_10012

			var_7(var_2_5, var_2_6, var_2_7, var_1_10012)
		else
			setActive = var_2_0

			var_2_0(arg_2_0.buildBtn, false)
		end
	end

	return
end

return var_0_1
