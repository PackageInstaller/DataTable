local var_0_0 = class("EducateEndingLayer", import(".EducateCollectLayerTemplate"))
local var_0_1 = {
	frame_1 = "frame1",
	frame_5 = "frame3",
	frame_3 = "frame2",
	frame_4 = "frame3",
	frame_2 = "frame2"
}

function var_0_0.getUIName(arg_1_0)
	return "EducateEndingUI"
end

function var_0_0.initConfig(arg_2_0)
	arg_2_0.config = pg.child_ending

	return
end

function var_0_0.didEnter(arg_3_0)
	setText(arg_3_0.windowTF:Find("tip"), i18n("child_buy_ending_tip"))
	setText(arg_3_0.performTF:Find("review_btn/Text"), i18n("child_btn_review"))

	arg_3_0.tpl = arg_3_0.windowTF:Find("condition_tpl")
	arg_3_0.addPrice = pg.gameset.child_cg_add_price.key_value
	arg_3_0.maxPrice = pg.gameset.child_cg_max_price.key_value

	arg_3_0:Flush()

	return
end

function var_0_0.SetData(arg_4_0)
	local var_4_0 = getProxy(EducateProxy)

	arg_4_0.endings = var_4_0:GetAllEndings()
	arg_4_0.completeEndings = var_4_0:GetCompleteEndings()
	arg_4_0.char = var_4_0:GetCharData()
	arg_4_0.gameCnt = var_4_0:GetGameCnt()
	arg_4_0.bugCnt = var_4_0:GetEndingBuyCnt()

	return
end

function var_0_0.Flush(arg_5_0)
	arg_5_0:SetData()
	setText(arg_5_0.curCntTF, #arg_5_0.endings)
	setText(arg_5_0.allCntTF, "/" .. #arg_5_0.config.all)
	arg_5_0:updatePage()

	return
end

function var_0_0.updateItem(arg_6_0, arg_6_1, arg_6_2)
	GetImageSpriteFromAtlasAsync("ui/educateendingui_atlas", var_0_1[arg_6_2.name] .. "_" .. arg_6_1.sp_bg, arg_6_2)
	LoadImageSpriteAsync("bg/" .. arg_6_1.pic, arg_6_2:Find("icon/Image"))
	setText(arg_6_2:Find("unlock/name"), arg_6_1.name)
	setText(arg_6_2:Find("lock/name"), arg_6_1.lock_name)

	local var_6_0 = table.contains(arg_6_0.endings, arg_6_1.id)

	setActive(arg_6_2:Find("icon/lock"), not var_6_0)
	setActive(arg_6_2:Find("unlock"), var_6_0)
	setActive(arg_6_2:Find("lock"), not var_6_0)

	if var_6_0 then
		onButton(arg_6_0, arg_6_2, function()
			arg_6_0:showPerformWindow(arg_6_1)

			return
		end, SFX_PANEL)
		setActive(arg_6_2:Find("unlock/complete"), table.contains(arg_6_0.completeEndings, arg_6_1.id))
	else
		removeOnButton(arg_6_2)

		local var_6_1 = arg_6_2:Find("lock/desc/conditions")

		arg_6_0:updateConditions(arg_6_1.condition, var_6_1)
		setActive(var_6_1, #arg_6_1.condition > 0)

		local var_6_2 = arg_6_2:Find("lock/desc/Text")

		setText(var_6_2, arg_6_1.unlock_desc)
		setActive(var_6_2, arg_6_1.unlock_desc ~= "")

		local var_6_3 = arg_6_2:Find("lock/unlock_btn")

		setActive(var_6_3, arg_6_0.gameCnt > 1)
		onButton(arg_6_0, var_6_3, function()
			arg_6_0:OnClickBuyBtn(arg_6_1)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateConditions(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	for iter_9_0 = 1, #arg_9_1 do
		local var_9_1 = arg_9_1[iter_9_0]

		if arg_9_1[iter_9_0][1] == EducateConst.DROP_TYPE_ATTR then
			var_9_0 = var_9_0 + 1

			local var_9_2 = iter_9_0 <= arg_9_2.childCount and arg_9_2:GetChild(iter_9_0 - 1) or cloneTplTo(arg_9_0.tpl, arg_9_2)
			local var_9_3 = false
			local var_9_4 = ""

			if var_9_1[3] then
				var_9_3 = arg_9_0.char:GetAttrById(var_9_1[2]) >= var_9_1[3]
				var_9_4 = pg.child_attr[var_9_1[2]].name .. " > " .. var_9_1[3]
			else
				var_9_3 = arg_9_0.char:GetPersonalityId() == var_9_1[2]
				var_9_4 = i18n("child_nature_title") .. pg.child_attr[var_9_1[2]].name
			end

			setActive(var_9_2:Find("icon/unlock"), var_9_3)
			setTextColor(var_9_2:Find("Text"), Color.NewHex(var_9_3 and "F59F48" or "FFFFFF"))
			setText(var_9_2:Find("Text"), var_9_4)
		end
	end

	for iter_9_1 = 1, arg_9_2.childCount do
		setActive(arg_9_2:GetChild(iter_9_1 - 1), iter_9_1 <= var_9_0)
	end

	return
end

function var_0_0.showPerformWindow(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.performTF:Find("Image")

	LoadImageSpriteAsync("bg/" .. arg_10_1.pic, var_10_0)
	setActive(arg_10_0.performTF, true)
	onButton(arg_10_0, var_10_0, function()
		setActive(arg_10_0.performTF, false)

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.performTF:Find("review_btn"), function()
		pg.PerformMgr.GetInstance():PlayGroup(arg_10_1.performance)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnClickBuyBtn(arg_13_0, arg_13_1)
	arg_13_0:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
		content = i18n("child_cg_buy", math.min(arg_13_0.maxPrice, arg_13_1.child_cg_basic_price + arg_13_0.bugCnt * arg_13_0.addPrice), arg_13_1.lock_name),
		onYes = function()
			arg_13_0:emit(EducateCollectMediatorTemplate.UNLOCK, {
				type = EducateBuyCollectCommand.TYPE.ENDING,
				id = arg_13_1.id,
				cost = var_0
			})

			return
		end
	})

	return
end

function var_0_0.playAnimChange(arg_15_0)
	arg_15_0.anim:Stop()
	arg_15_0.anim:Play("anim_educate_ending_change")

	return
end

function var_0_0.playAnimClose(arg_16_0)
	arg_16_0.anim:Play("anim_educate_ending_out")

	return
end

return var_0_0
