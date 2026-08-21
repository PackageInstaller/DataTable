local var_0_0 = class("IslandTaskTrackCard")

var_0_0.TYPES = {
	OTHER = 2,
	MAIN = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0.type = arg_1_3
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.iconTF = arg_1_0._tf:Find("title/icon")
	arg_1_0.nameTF = arg_1_0._tf:Find("title/name")
	arg_1_0.finishedTF = arg_1_0._tf:Find("target/finished")
	arg_1_0.unFinishTF = arg_1_0._tf:Find("target/unfinish")
	arg_1_0.targetUIList = UIItemList.New(arg_1_0.unFinishTF, arg_1_0.unFinishTF:Find("tpl"))

	arg_1_0.targetUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateTargetItem(arg_2_1, arg_2_2)
		end

		return
	end)

	arg_1_0.targetBtnUIList = UIItemList.New(arg_1_0._tf:Find("btns"), arg_1_0._tf:Find("btns/tpl"))

	arg_1_0.targetBtnUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateTargetBtnItem(arg_3_1, arg_3_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateTargetItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.task:GetTargetList()[arg_4_1 + 1]
	local var_4_1 = var_4_0:IsFinish()

	setActive(arg_4_2:Find("status/unfinish"), not var_4_1)
	setActive(arg_4_2:Find("status/finished"), var_4_1)

	if var_4_1 then
		arg_4_2:GetComponent(typeof(Animation)):Play("Island3dTaskTrackPanel_tpl_finish_in")
	else
		arg_4_2:GetComponent(typeof(Animation)):Play("Island3dTaskTrackPanel_tpl_unfinished_in")
	end

	GetOrAddComponent(arg_4_2:Find("content"), "CanvasGroup").alpha = var_4_1 and 0.5 or 1

	local var_4_2 = arg_4_0:GetMapTip(tonumber(var_4_0:GetTrackParma()))

	if var_4_2 and not var_4_1 then
		setText(arg_4_2:Find("content/Text"), var_4_2)
		setText(arg_4_2:Find("content/num"), "")
	else
		setText(arg_4_2:Find("content/Text"), HXSet.hxLan(var_4_0:getConfig("name")))

		local var_4_3 = var_4_0:GetProgress()
		local var_4_4 = var_4_0:GetTargetNum()
		local var_4_5 = var_4_3 < var_4_4 and setColorStr(var_4_3, "#dd374e") or var_4_3

		setText(arg_4_2:Find("content/num"), "(" .. var_4_5 .. "/" .. var_4_4 .. ")")
	end

	return
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.unlock = arg_5_2
	arg_5_0.task = arg_5_1

	setActive(arg_5_0._tf, arg_5_0.task)

	if not arg_5_0.task then
		return
	end

	arg_5_0.curMapId = getProxy(IslandProxy):GetIsland():GetMapId()

	local var_5_0 = arg_5_0.task:GetShowType()

	GetImageSpriteFromAtlasAsync("island/islandtasktype", "track_" .. IslandTaskType.ShowTypeFields[var_5_0], arg_5_0.iconTF)
	setImageColor(arg_5_0._tf:Find("title/bg"), Color.NewHex(IslandTaskType.ShowTypeTrackColors[var_5_0]))
	setText(arg_5_0.nameTF, HXSet.hxLan(arg_5_0.task:GetName()))
	arg_5_0:UpdateTarget()
	arg_5_0:TrackUI()

	return
end

function var_0_0.UpdateProgress(arg_6_0, arg_6_1)
	arg_6_0.task = arg_6_1

	if not arg_6_0.task then
		return
	end

	arg_6_0:UpdateTarget()
	arg_6_0:TrackUI()

	return
end

function var_0_0.UpdateTarget(arg_7_0)
	local var_7_0 = not arg_7_0.task:IsSubmitImmediately() and arg_7_0.task:IsFinish()
	local var_7_1 = #arg_7_0.task:GetTargetList()

	arg_7_0.targetUIList:align(var_7_1)
	arg_7_0.targetBtnUIList:align(var_7_1 + (var_7_0 and 1 or 0))
	setActive(arg_7_0.finishedTF, var_7_0)

	if var_7_0 then
		local var_7_2 = arg_7_0:GetMapTip(tonumber(arg_7_0.task:GetTraceParam()))

		if var_7_2 then
			setText(arg_7_0.finishedTF:Find("Text"), var_7_2)
		else
			setText(arg_7_0.finishedTF:Find("Text"), HXSet.hxLan(arg_7_0.task:GetFinishedDesc()))
		end
	end

	return
end

function var_0_0.RemoveTask(arg_8_0)
	arg_8_0:UnTrackUI()
	setActive(arg_8_0._tf, false)

	return
end

function var_0_0.TrackUI(arg_9_0)
	if not arg_9_0.unlock then
		return
	end

	local var_9_0 = tonumber((arg_9_0.task:GetTraceParam()))

	if var_9_0 then
		if _IslandCore then
			_IslandCore:GetController():NotifiyCore(ISLAND_EVT.TRACKING, {
				id = var_9_0,
				typ = arg_9_0.task:GetType(),
				trackType = arg_9_0.type
			})
		end
	else
		arg_9_0:UnTrackUI()
	end

	return
end

function var_0_0.UnTrackUI(arg_10_0)
	if not arg_10_0.unlock then
		return
	end

	if _IslandCore then
		_IslandCore:GetController():NotifiyCore(ISLAND_EVT.UNTRACKING, arg_10_0.type)
	end

	return
end

function var_0_0.GetMapTip(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return nil
	end

	local var_11_0 = pg.island_world_objects[arg_11_1]

	if not pg.island_world_objects[arg_11_1] then
		return nil
	end

	if arg_11_0.curMapId == var_11_0.mapId then
		return nil
	end

	return i18n("island_word_go") .. pg.island_map[var_11_0.mapId].name
end

function var_0_0._SkipBtn(arg_12_0, arg_12_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_main_btns[arg_12_1].ability_id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_systemnoopen_tips"))

		return
	end

	if pg.island_main_btns[arg_12_1].open_page ~= "" then
		arg_12_0:emit(IslandMediator.OPEN_PAGE, pg.island_main_btns[arg_12_1].open_page, pg.island_main_btns[arg_12_1].page_param)
	end

	return
end

function var_0_0._SkipObj(arg_13_0, arg_13_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockMap(pg.island_world_objects[arg_13_1].mapId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_placenoopen_tips"))

		return
	end

	arg_13_0:emit(IslandBaseMediator.SWITCH_MAP, pg.island_world_objects[arg_13_1].mapId, pg.island_map[pg.island_world_objects[arg_13_1].mapId].born_object)

	return
end

function var_0_0.UpdateTargetBtnItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.task:GetTargetList()[arg_14_1 + 1]
	local var_14_1 = arg_14_2:Find("btn")

	removeOnButton(var_14_1)
	setActive(var_14_1, false)

	if var_14_0 then
		local var_14_2 = tonumber(pg.island_task_target[var_14_0.id].tips)
		local var_14_3 = tonumber(pg.island_task_target[var_14_0.id].jump_ui)

		if not var_14_0:IsFinish() then
			if tonumber(pg.island_task_target[var_14_0.id].jump_ui) then
				setActive(var_14_1, true)
				onButton(arg_14_0, var_14_1, function()
					arg_14_0:_SkipBtn(var_14_3)

					return
				end, SFX_PANEL)
			elseif var_14_2 then
				if IslandMainBtnTipHelper.IsUnlock("map") and arg_14_0.curMapId ~= pg.island_world_objects[var_14_2].mapId then
					setActive(var_14_1, true)
					onButton(arg_14_0, var_14_1, function()
						arg_14_0:_SkipObj(var_14_2)

						return
					end, SFX_PANEL)
				end
			end
		end
	else
		setActive(var_14_1, false)

		local var_14_4 = tonumber(arg_14_0.task:getConfig("complete_data"))

		if var_14_4 and var_14_4 ~= 0 then
			if IslandMainBtnTipHelper.IsUnlock("map") and arg_14_0.curMapId ~= pg.island_world_objects[var_14_4].mapId then
				setActive(var_14_1, true)
				onButton(arg_14_0, var_14_1, function()
					arg_14_0:_SkipObj(var_14_4)

					return
				end, SFX_PANEL)
			end
		end
	end

	return
end

function var_0_0.emit(arg_18_0, ...)
	arg_18_0.event:emit(...)

	return
end

function var_0_0.Dispose(arg_19_0)
	pg.DelegateInfo.Dispose(arg_19_0)

	return
end

return var_0_0
