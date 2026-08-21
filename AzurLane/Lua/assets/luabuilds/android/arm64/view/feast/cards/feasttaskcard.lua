local var_0_0 = class("FeastTaskCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.nameTxt = arg_1_0._tf:Find("name/Text"):GetComponent(typeof(Text))
	arg_1_0.descTxt = arg_1_0._tf:Find("desc"):GetComponent(typeof(Text))
	arg_1_0.progressTxt = arg_1_0._tf:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.progress = arg_1_0._tf:Find("progress/bar")
	arg_1_0.uilist = UIItemList.New(arg_1_0._tf:Find("awards"), arg_1_0._tf:Find("awards/award"))
	arg_1_0.getBtn = arg_1_0._tf:Find("btns/get")
	arg_1_0.gotBtn = arg_1_0._tf:Find("btns/got")
	arg_1_0.goBtn = arg_1_0._tf:Find("btns/go")
	arg_1_0.sprites = {
		GetSpriteFromAtlas("ui/feasttask_atlas", "t_frame_1"),
		GetSpriteFromAtlas("ui/feasttask_atlas", "t_frame_2")
	}
	arg_1_0.barSprites = {
		GetSpriteFromAtlas("ui/feasttask_atlas", "t_progress_1"),
		GetSpriteFromAtlas("ui/feasttask_atlas", "t_progress_2")
	}
	arg_1_0.tags = {
		i18n("feast_task_tag_daily"),
		i18n("feast_task_tag_activity")
	}
	arg_1_0.barImg = arg_1_0._tf:Find("progress/bar"):GetComponent(typeof(Image))
	arg_1_0.bgImg = arg_1_0._tf:GetComponent(typeof(Image))

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(TaskProxy)
	local var_2_1 = var_2_0:getTaskById(arg_2_1) or var_2_0:getFinishTaskById(arg_2_1)
	local var_2_2 = var_2_1:IsActRoutineType() and 1 or 2

	arg_2_0.nameTxt.text = arg_2_0.tags[var_2_2] .. var_2_1:getConfig("name")
	arg_2_0.descTxt.text = var_2_1:getConfig("desc")
	arg_2_0.bgImg.sprite = arg_2_0.sprites[var_2_2]
	arg_2_0.barImg.sprite = arg_2_0.barSprites[var_2_2]

	local var_2_3 = var_2_1:getProgress()
	local var_2_4 = var_2_1:getConfig("target_num")

	arg_2_0.progressTxt.text = var_2_3 .. "/" .. var_2_4

	setFillAmount(arg_2_0.progress, var_2_3 / var_2_4)

	local var_2_5 = var_2_1:getConfig("award_display")

	arg_2_0.uilist:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			updateDrop(arg_3_2, {
				type = var_2_5[arg_3_1 + 1][1],
				id = var_2_5[arg_3_1 + 1][2],
				count = var_2_5[arg_3_1 + 1][3]
			})
			onButton(arg_2_0.binder, arg_3_2, function()
				arg_2_0.binder:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_2_0.uilist:align(#var_2_1:getConfig("award_display"))

	local var_2_6 = var_2_1:isFinish()
	local var_2_7 = var_2_1:isReceive()

	setActive(arg_2_0.getBtn, var_2_6 and not var_2_7)
	setActive(arg_2_0.gotBtn, var_2_6 and var_2_7)
	setActive(arg_2_0.goBtn, not var_2_6)
	onButton(arg_2_0.binder, arg_2_0.getBtn, function()
		arg_2_0.binder:emit(FeastMediator.ON_SUBMIT, arg_2_1)

		return
	end, SFX_PANEL)
	onButton(arg_2_0.binder, arg_2_0.goBtn, function()
		arg_2_0.binder:emit(FeastMediator.ON_GO, var_2_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.sprites = nil
	arg_7_0.barSprites = nil

	return
end

return var_0_0
