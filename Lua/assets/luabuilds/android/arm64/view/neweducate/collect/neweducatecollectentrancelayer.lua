local var_0_0 = class("NewEducateCollectEntranceLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateCollectEntranceUI"
end

function var_0_0.getGroupName(arg_2_0)
	return "NewEducateBaseUI"
end

function var_0_0.init(arg_3_0)
	arg_3_0.anim = arg_3_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_3_0.animEvent = arg_3_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_3_0.animEvent:SetEndEvent(function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_3_0.contentTF = arg_3_0._tf:Find("anim_root/content")
	arg_3_0.contentTF.offsetMin = Vector2(arg_3_0.contextData.isSelect and 208 or 0, 0)
	arg_3_0.contentTF.offsetMax = Vector2(0, 0)
	arg_3_0.memoryBtn = arg_3_0.contentTF:Find("memory_btn")
	arg_3_0.polaroidBtn = arg_3_0.contentTF:Find("polaroid_btn")
	arg_3_0.polaroidBtn2 = arg_3_0.contentTF:Find("polaroid_btn2")
	arg_3_0.buffBtn = arg_3_0.contentTF:Find("buff_btn")
	arg_3_0.endingBtn = arg_3_0.contentTF:Find("ending_btn")
	arg_3_0.reviewBtn = arg_3_0.contentTF:Find("review_btn")
	arg_3_0.leftTF = arg_3_0._tf:Find("anim_root/left")
	arg_3_0.togglesTF = arg_3_0.leftTF:Find("toggles")
	arg_3_0.ids = {
		0
	}
	arg_3_0.ids = table.mergeArray(arg_3_0.ids, pg.child2_data.all)
	arg_3_0.toggleList = UIItemList.New(arg_3_0.togglesTF, arg_3_0.togglesTF:Find("tpl"))

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:BlurPanel(arg_5_0._tf)
	onButton(arg_5_0, arg_5_0._tf, function()
		arg_5_0:_close()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.memoryBtn, function()
		if arg_5_0.contextData.id == 0 then
			arg_5_0:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = EducateCollectMediatorTemplate,
				viewComponent = EducateMemoryLayer
			}))
		else
			arg_5_0:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = NewEducateCollectMediatorTemplate,
				viewComponent = NewEducateMemoryLayer,
				data = {
					permanentData = arg_5_0.permanentData
				}
			}))
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.polaroidBtn, function()
		if arg_5_0.contextData.id == 0 then
			arg_5_0:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = EducateCollectMediatorTemplate,
				viewComponent = EducatePolaroidLayer
			}))
			setActive(arg_5_0.polaroidBtn:Find("new"), false)
		else
			arg_5_0:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = NewEducateCollectMediatorTemplate,
				viewComponent = NewEducatePolaroidLayer,
				data = {
					permanentData = arg_5_0.permanentData
				}
			}))
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.polaroidBtn2, function()
		arg_5_0:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
			mediator = NewEducateCollectMediatorTemplate,
			viewComponent = NewEducatePolaroidLayer,
			data = {
				permanentData = arg_5_0.permanentData
			}
		}))

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.endingBtn:Find("unlock"), function()
		if arg_5_0.contextData.id == 0 then
			if isActive(arg_5_0.endingBtn:Find("lock")) then
				return
			end

			arg_5_0:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = EducateCollectMediatorTemplate,
				viewComponent = EducateEndingLayer
			}))
		else
			arg_5_0:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
				mediator = NewEducateCollectMediatorTemplate,
				viewComponent = NewEducateEndingLayer,
				data = {
					permanentData = arg_5_0.permanentData
				}
			}))
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.reviewBtn, function()
		if arg_5_0.contextData.id == 0 then
			arg_5_0:emit(var_0_0.ON_CLOSE)
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
				page = WorldMediaCollectionScene.PAGE_MEMORTY,
				memoryGroup = EducateConst.REVIEW_GROUP_ID
			})
		else
			local var_11_0 = pg.child2_data[arg_5_0.contextData.id].memory_group

			arg_5_0:emit(var_0_0.ON_CLOSE)
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
				page = WorldMediaCollectionScene.PAGE_MEMORTY,
				memoryGroup = var_11_0
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.buffBtn, function()
		arg_5_0:emit(NewEducateCollectEntranceMediator.GO_SUBLAYER, Context.New({
			mediator = NewEducateCollectMediatorTemplate,
			viewComponent = NewEducateBuffLayer,
			data = {
				permanentData = arg_5_0.permanentData
			}
		}))

		return
	end, SFX_PANEL)
	arg_5_0.toggleList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventInit then
			local var_13_0 = arg_5_0.ids[arg_13_1 + 1]

			arg_13_2.name = arg_5_0.ids[arg_13_1 + 1]

			LoadImageSpriteAsync("qicon/" .. (var_13_0 == 0 and "linghangyuan1_1" or pg.child2_data[var_13_0].head), arg_13_2:Find("icon"))
			onToggle(arg_5_0, arg_13_2, function(arg_14_0)
				if arg_14_0 then
					arg_5_0.contextData.id = var_13_0

					if arg_5_0.contextData.id == 0 then
						arg_5_0:FlushTBView()
					else
						arg_5_0:FlushView(arg_5_0.contextData.id)
					end
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_5_0.toggleList:align(#arg_5_0.ids)
	setActive(arg_5_0.leftTF, arg_5_0.contextData.isSelect)

	if arg_5_0.contextData.isSelect then
		triggerToggle(arg_5_0.togglesTF:Find(tostring(arg_5_0.contextData.id)), true)
	else
		arg_5_0:FlushView(arg_5_0.contextData.id)
	end

	return
end

function var_0_0.FlushView(arg_15_0, arg_15_1)
	arg_15_0.permanentData = getProxy(NewEducateProxy):GetChar(arg_15_1):GetPermanentData()

	setText(arg_15_0.memoryBtn:Find("Text"), #arg_15_0.permanentData:GetUnlockMemoryIds() .. "/" .. #arg_15_0.permanentData:GetAllMemoryIds())
	setActive(arg_15_0.memoryBtn:Find("new"), false)

	local var_15_0 = arg_15_0.permanentData:IsTarotType()
	local var_15_1 = #arg_15_0.permanentData:GetUnlockPolaroidGroups()
	local var_15_2 = #arg_15_0.permanentData:GetAllPolaroidGroups()

	setText(arg_15_0.polaroidBtn:Find("Text"), var_15_1 .. "/" .. var_15_2)
	setText(arg_15_0.polaroidBtn2:Find("Text"), var_15_1 .. "/" .. var_15_2)
	setActive(arg_15_0.polaroidBtn:Find("new"), false)
	setActive(arg_15_0.polaroidBtn2:Find("new"), false)
	setActive(arg_15_0.polaroidBtn, not var_15_0)
	setActive(arg_15_0.polaroidBtn2, var_15_0)
	setActive(arg_15_0.buffBtn, var_15_0)

	if var_15_0 then
		setText(arg_15_0.buffBtn:Find("Text"), arg_15_0.permanentData:GetAllUnlockBuffCnt() .. "/" .. arg_15_0.permanentData:GetAllBuffCnt())
	end

	setText(arg_15_0.endingBtn:Find("unlock/Text"), #arg_15_0.permanentData:GetActivatedEndings() .. "/" .. #arg_15_0.permanentData:GetAllEndingIds())

	local var_15_3 = NewEducateConst.LOCK_ENDING and arg_15_0.permanentData:GetGameCnt()

	setActive(arg_15_0.endingBtn:Find("unlock"), not var_15_3)
	setActive(arg_15_0.endingBtn:Find("lock"), var_15_3)

	return
end

function var_0_0.FlushTBView(arg_16_0)
	local var_16_0 = getProxy(EducateProxy)
	local var_16_1 = var_16_0:GetAllEndings()

	setText(arg_16_0.memoryBtn:Find("Text"), #var_16_0:GetMemories() .. "/" .. #pg.child_memory.all)
	arg_16_0:UpdateMemoryTip()

	local var_16_2, var_16_3 = var_16_0:GetPolaroidGroupCnt()

	setText(arg_16_0.polaroidBtn:Find("Text"), var_16_2 .. "/" .. var_16_3)
	setActive(arg_16_0.polaroidBtn:Find("lock"), not EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_POLAROID))
	setActive(arg_16_0.polaroidBtn:Find("new"), EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_POLAROID))
	setActive(arg_16_0.polaroidBtn, true)
	setActive(arg_16_0.polaroidBtn2, false)
	setActive(arg_16_0.buffBtn, false)
	setText(arg_16_0.endingBtn:Find("unlock/Text"), #var_16_1 .. "/" .. #pg.child_ending.all)

	local var_16_4 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_ENDING) or #var_16_1 > 0

	setActive(arg_16_0.endingBtn:Find("unlock"), var_16_4)
	setActive(arg_16_0.endingBtn:Find("lock"), not var_16_4)

	return
end

function var_0_0.UpdateMemoryTip(arg_17_0)
	setActive(arg_17_0.memoryBtn:Find("new"), (underscore.any(pg.child_memory.all, function(arg_18_0)
		return EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_MEMORY, arg_18_0)
	end)))

	return
end

function var_0_0._close(arg_19_0)
	arg_19_0.anim:Play("anim_educate_collectentrance_out")

	return
end

function var_0_0.onBackPressed(arg_20_0)
	arg_20_0:_close()

	return
end

function var_0_0.willExit(arg_21_0)
	arg_21_0.animEvent:SetEndEvent(nil)
	arg_21_0:UnOverlayPanel(arg_21_0._tf)

	return
end

return var_0_0
