local var_0_0 = class("GuildTechnologyGroupCard", import(".GuildTechnologyCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.devBtn = arg_1_0.breakoutTF:Find("dev_btn")
	arg_1_0.cancelBtn = arg_1_0.breakoutTF:Find("cancel_btn")
	arg_1_0.devBtnTxt = arg_1_0.devBtn:Find("Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_1.id

	arg_2_0.titleImg.text = arg_2_1:getConfig("name")
	arg_2_0.iconImag.sprite = GetSpriteFromAtlas("GuildTechnology", arg_2_1.id)
	arg_2_0.descTxt.text = arg_2_1:GetDesc()

	local var_2_1 = arg_2_1:GetMaxLevel()
	local var_2_2 = arg_2_1:GetLevel()
	local var_2_3 = arg_2_1:GetState()

	setActive(arg_2_0.maxTF, var_2_1 <= var_2_2)
	setActive(arg_2_0.breakoutTF, var_2_2 < var_2_1)
	setActive(arg_2_0.devBtn, var_2_3 == GuildTechnologyGroup.STATE_STOP and var_2_2 < var_2_1)
	setActive(arg_2_0.breakoutSlider.gameObject, var_2_3 == GuildTechnologyGroup.STATE_START)
	setActive(arg_2_0.cancelBtn, false)

	if var_2_2 < var_2_1 then
		onButton(arg_2_0, arg_2_0._tf, function()
			if not arg_2_3 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_non_admin"))

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("guild_start_tech_group_tip", arg_2_1:getConfig("name")),
				onYes = function()
					arg_2_0.view:emit(GuildTechnologyMediator.ON_START, var_2_0)

					return
				end
			})

			return
		end, SFX_PANEL)

		arg_2_0.levelTxt.text = "Lv." .. var_2_2 .. "/" .. var_2_1
	else
		arg_2_0.levelTxt.text = "Lv." .. var_2_1 .. "/" .. var_2_1
	end

	if var_2_3 == GuildTechnologyGroup.STATE_START then
		local var_2_4 = arg_2_1:GetTargetProgress()
		local var_2_5 = arg_2_1:GetProgress()

		arg_2_0.breakoutSlider.value = var_2_5 / var_2_4
		arg_2_0.breakoutTxt.text = var_2_5 .. "/" .. var_2_4
	end

	onButton(arg_2_0, arg_2_0.cancelBtn, function()
		if not arg_2_3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_non_admin"))

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_cancel_tech_tip", arg_2_1:getConfig("name")),
			onYes = function()
				arg_2_0.view:emit(GuildTechnologyMediator.ON_CANCEL_TECH, var_2_0)

				return
			end
		})

		return
	end, SFX_PANEL)

	arg_2_0.devBtnTxt.text = i18n("guild_tech_donate_target", arg_2_1:GetTargetProgress())

	return
end

return var_0_0
