local var_0_0 = class("EducateMemoryLayer", import(".EducateCollectLayerTemplate"))
local var_0_1 = {
	frame_1 = "frame1",
	frame_5 = "frame3",
	frame_3 = "frame2",
	frame_4 = "frame3",
	frame_2 = "frame3"
}

function var_0_0.getUIName(arg_1_0)
	return "EducateMemoryUI"
end

function var_0_0.initConfig(arg_2_0)
	arg_2_0.config = pg.child_memory

	return
end

function var_0_0.didEnter(arg_3_0)
	setText(arg_3_0.windowTF:Find("tip"), i18n("child_buy_memory_tip"))
	setText(arg_3_0.performTF:Find("review_btn/Text"), i18n("child_btn_review"))

	arg_3_0.addPrice = pg.gameset.child_cg_add_price.key_value
	arg_3_0.maxPrice = pg.gameset.child_cg_max_price.key_value

	arg_3_0:Flush()

	return
end

function var_0_0.SetData(arg_4_0)
	local var_4_0 = getProxy(EducateProxy)

	arg_4_0.memories = var_4_0:GetMemories()
	arg_4_0.gameCnt = var_4_0:GetGameCnt()
	arg_4_0.bugCnt = var_4_0:GetMemoryBuyCnt()

	return
end

function var_0_0.Flush(arg_5_0)
	arg_5_0:SetData()
	setText(arg_5_0.curCntTF, #arg_5_0.memories)
	setText(arg_5_0.allCntTF, "/" .. #arg_5_0.config.all)
	arg_5_0:updatePage()

	return
end

function var_0_0.updateItem(arg_6_0, arg_6_1, arg_6_2)
	GetImageSpriteFromAtlasAsync("ui/educatememoryui_atlas", var_0_1[arg_6_2.name] .. "_" .. arg_6_1.sp_bg, arg_6_2)
	LoadImageSpriteAsync("bg/" .. arg_6_1.pic, arg_6_2:Find("icon/Image"))
	setText(arg_6_2:Find("unlock/name"), arg_6_1.desc)
	setText(arg_6_2:Find("lock/name"), arg_6_1.lock_name)
	setText(arg_6_2:Find("lock/desc/Text"), arg_6_1.unlock_desc)

	local var_6_0 = table.contains(arg_6_0.memories, arg_6_1.id)

	setActive(arg_6_2:Find("icon/lock"), not var_6_0)
	setActive(arg_6_2:Find("lock"), not var_6_0)
	setActive(arg_6_2:Find("unlock"), var_6_0)

	if var_6_0 then
		setActive(arg_6_2:Find("unlock/new"), EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_MEMORY, arg_6_1.id))
		onButton(arg_6_0, arg_6_2, function()
			arg_6_0:showPerformWindow(arg_6_1)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_6_2)

		local var_6_1 = arg_6_2:Find("lock/unlock_btn")

		setActive(var_6_1, arg_6_0.gameCnt > 1)
		onButton(arg_6_0, var_6_1, function()
			arg_6_0:OnClickBuyBtn(arg_6_1)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.showPerformWindow(arg_9_0, arg_9_1)
	EducateTipHelper.ClearNewTip(EducateTipHelper.NEW_MEMORY, arg_9_1.id)

	local var_9_0 = arg_9_0.performTF:Find("Image")

	LoadImageSpriteAsync("bg/" .. arg_9_1.pic, var_9_0)
	setActive(arg_9_0.performTF, true)
	onButton(arg_9_0, var_9_0, function()
		setActive(arg_9_0.performTF, false)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.performTF:Find("review_btn"), function()
		pg.PerformMgr.GetInstance():PlayOne(arg_9_1.performance)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnClickBuyBtn(arg_12_0, arg_12_1)
	arg_12_0:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
		content = i18n("child_cg_buy", math.min(arg_12_0.maxPrice, arg_12_1.child_cg_basic_price + arg_12_0.bugCnt * arg_12_0.addPrice), arg_12_1.lock_name),
		onYes = function()
			arg_12_0:emit(EducateCollectMediatorTemplate.UNLOCK, {
				type = EducateBuyCollectCommand.TYPE.MEMORY,
				id = arg_12_1.id,
				cost = var_0
			})

			return
		end
	})

	return
end

function var_0_0.playAnimChange(arg_14_0)
	arg_14_0.anim:Stop()
	arg_14_0.anim:Play("anim_educate_memory_change")

	return
end

function var_0_0.playAnimClose(arg_15_0)
	arg_15_0.anim:Play("anim_educate_memory_out")

	return
end

return var_0_0
