local var_0_0 = class("NewEducateMemoryLayer", import(".NewEducateCollectLayerTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateMemoryUI"
end

function var_0_0.initConfig(arg_2_0)
	arg_2_0.config = pg.child2_memory
	arg_2_0.allIds = arg_2_0.contextData.permanentData:GetAllMemoryIds()
	arg_2_0.unlockIds = arg_2_0.contextData.permanentData:GetUnlockMemoryIds()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitPageInfo()
	setText(arg_3_0.performTF:Find("review_btn/Text"), i18n("child_btn_review"))
	setText(arg_3_0.curCntTF, #arg_3_0.unlockIds)
	setText(arg_3_0.allCntTF, "/" .. #arg_3_0.allIds)
	arg_3_0:UpdatePage()

	return
end

function var_0_0.UpdateItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.config[arg_4_1]
	local var_4_1 = table.contains(arg_4_0.unlockIds, arg_4_0.config[arg_4_1].id)

	setActive(arg_4_2:Find("lock"), not var_4_1)
	setActive(arg_4_2:Find("unlock"), var_4_1)
	setActive(arg_4_2:Find("unlock/new"), false)

	if var_4_1 then
		LoadImageSpriteAsync("bg/" .. arg_4_0.config[arg_4_1].pic, arg_4_2:Find("unlock/mask/Image"))
		setText(arg_4_2:Find("unlock/name"), arg_4_0.config[arg_4_1].desc)
		onButton(arg_4_0, arg_4_2, function()
			arg_4_0:ShowPerformWindow(var_4_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_4_2)
		setText(arg_4_2:Find("lock/Text"), i18n("child_collect_lock"))
	end

	return
end

function var_0_0.ShowPerformWindow(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.performTF:Find("Image")

	LoadImageSpriteAsync("bg/" .. arg_6_1.pic, var_6_0)
	setActive(arg_6_0.performTF, true)
	onButton(arg_6_0, var_6_0, function()
		setActive(arg_6_0.performTF, false)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.performTF:Find("review_btn"), function()
		pg.NewStoryMgr.GetInstance():Play(arg_6_1.lua, nil, true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.PlayAnimChange(arg_9_0)
	arg_9_0.anim:Stop()
	arg_9_0.anim:Play("anim_educate_memory_change")

	return
end

function var_0_0.PlayAnimClose(arg_10_0)
	arg_10_0.anim:Play("anim_educate_memory_out")

	return
end

return var_0_0
