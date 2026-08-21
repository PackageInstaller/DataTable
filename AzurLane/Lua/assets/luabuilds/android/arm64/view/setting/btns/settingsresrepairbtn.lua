local var_0_0 = class("SettingsResRepairBtn")

function var_0_0.InitTpl(arg_1_0, arg_1_1)
	arg_1_0._tf = cloneTplTo(arg_1_1.tpl, arg_1_1.container, "REPAIR")
	arg_1_0._go = arg_1_0._tf.gameObject

	setImageSprite(arg_1_0._tf:Find("icon"), arg_1_1.iconSP)

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0:InitTpl(arg_2_1)
	pg.DelegateInfo.New(arg_2_0)

	arg_2_0.Progress = arg_2_0._tf:Find("progress")
	arg_2_0.ProgressHandle = arg_2_0._tf:Find("progress/handle")
	arg_2_0.Info1 = arg_2_0._tf:Find("status")
	arg_2_0.Info2 = arg_2_0._tf:Find("version")
	arg_2_0.LabelNew = arg_2_0._tf:Find("version/new")
	arg_2_0.Dot = arg_2_0._tf:Find("new")
	arg_2_0.Loading = arg_2_0._tf:Find("loading")

	setText(arg_2_0._tf:Find("title"), i18n("repair_setting_label"))

	local var_2_0 = false

	setActive(arg_2_0._tf:Find("BG"), not var_2_0)
	setActive(arg_2_0._tf:Find("BGDel"), var_2_0)

	local var_2_1 = arg_2_0._tf:Find("version")
	local var_2_3 = arg_2_0._tf:Find("status")

	if var_2_0 then
		local var_2_4 = {
			y = -106
		}

		if not {
			y = -106
		} then
			var_2_4 = {
				y = -135
			}
		end

		var_2_2(var_2_3, var_2_4)

		local var_2_6 = var_2_1

		if var_2_0 then
			local var_2_7 = {
				y = -160
			}

			if not {
				y = -160
			} then
				var_2_7 = {
					y = -198
				}
			end

			var_2_5(var_2_6, var_2_7)
			arg_2_0:Init()

			return
		end
	end
end

function var_0_0.Init(arg_3_0)
	arg_3_0:UpdateRepairStatus()
	onButton(arg_3_0, arg_3_0._tf, function()
		pg.RepairResMgr.GetInstance():Repair()

		return
	end, SFX_PANEL)
	setActive(findTF(arg_3_0._tf, "DelBtn"), false)

	return
end

function var_0_0.UpdateRepairStatus(arg_5_0)
	setSlider(arg_5_0.Progress, 0, 1, 0)
	setActive(arg_5_0.Dot, false)
	setActive(arg_5_0.Loading, false)
	setText(arg_5_0.Info1, (i18n("word_files_repair")))
	setText(arg_5_0.Info2, "")

	local var_5_0 = 1

	setSlider(arg_5_0.Progress, 0, 1, 1)
	setActive(arg_5_0.ProgressHandle, var_5_0 ~= 0 and var_5_0 ~= 1)
	setActive(arg_5_0.Dot, false)
	setActive(arg_5_0.Loading, false)
	setActive(arg_5_0.LabelNew, false)

	return
end

function var_0_0.Dispose(arg_6_0)
	pg.DelegateInfo.Dispose(arg_6_0)

	return
end

return var_0_0
