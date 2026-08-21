local var_0_0 = class("EducateCollectEntranceLayer", import("..base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateCollectEntranceUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	local var_3_0 = getProxy(EducateProxy)

	arg_3_0.memories = var_3_0:GetMemories()
	arg_3_0.endings = var_3_0:GetAllEndings()

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.anim = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_4_0.animEvent = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_4_0.animEvent:SetEndEvent(function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_4_0.contentTF = arg_4_0._tf:Find("anim_root/content")
	arg_4_0.memoryBtn = arg_4_0.contentTF:Find("memory_btn")
	arg_4_0.polaroidBtn = arg_4_0.contentTF:Find("polaroid_btn")
	arg_4_0.endingBtn = arg_4_0.contentTF:Find("ending_btn")
	arg_4_0.reviewBtn = arg_4_0.contentTF:Find("review_btn")

	return
end

function var_0_0.addListener(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf, function()
		arg_6_0:_close()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.memoryBtn, function()
		arg_6_0:emit(var_0_0.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateCollectMediatorTemplate,
			viewComponent = EducateMemoryLayer
		}))

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.polaroidBtn, function()
		if isActive(arg_6_0.polaroidBtn:Find("lock")) then
			return
		end

		arg_6_0:emit(var_0_0.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateCollectMediatorTemplate,
			viewComponent = EducatePolaroidLayer
		}))
		setActive(arg_6_0.polaroidBtn:Find("new"), false)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.endingBtn, function()
		if isActive(arg_6_0.endingBtn:Find("lock")) then
			return
		end

		arg_6_0:emit(var_0_0.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateCollectMediatorTemplate,
			viewComponent = EducateEndingLayer
		}))

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.reviewBtn, function()
		arg_6_0:emit(var_0_0.ON_CLOSE)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_MEMORTY,
			memoryGroup = EducateConst.REVIEW_GROUP_ID
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_12_0)
	setText(arg_12_0.memoryBtn:Find("Text"), #arg_12_0.memories .. "/" .. #pg.child_memory.all)
	arg_12_0:updateMemoryTip()

	local var_12_0, var_12_1 = getProxy(EducateProxy):GetPolaroidGroupCnt()

	setText(arg_12_0.polaroidBtn:Find("Text"), var_12_0 .. "/" .. var_12_1)
	setActive(arg_12_0.polaroidBtn:Find("lock"), not EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_POLAROID))
	setActive(arg_12_0.polaroidBtn:Find("new"), EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_POLAROID))
	setText(arg_12_0.endingBtn:Find("unlock/Text"), #arg_12_0.endings .. "/" .. #pg.child_ending.all)

	local var_12_2 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_ENDING) or #arg_12_0.endings > 0

	setActive(arg_12_0.endingBtn:Find("unlock"), var_12_2)
	setActive(arg_12_0.endingBtn:Find("lock"), not var_12_2)
	arg_12_0:BlurPanel(arg_12_0._tf)
	EducateGuideSequence.CheckGuide(arg_12_0.__cname, function()
		return
	end)

	return
end

function var_0_0.updateMemoryTip(arg_14_0)
	setActive(arg_14_0.memoryBtn:Find("new"), (underscore.any(pg.child_memory.all, function(arg_15_0)
		return EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_MEMORY, arg_15_0)
	end)))

	return
end

function var_0_0._close(arg_16_0)
	arg_16_0.anim:Play("anim_educate_collectentrance_out")

	return
end

function var_0_0.onBackPressed(arg_17_0)
	arg_17_0:_close()

	return
end

function var_0_0.willExit(arg_18_0)
	arg_18_0.animEvent:SetEndEvent(nil)
	arg_18_0:UnOverlayPanel(arg_18_0._tf)

	return
end

return var_0_0
