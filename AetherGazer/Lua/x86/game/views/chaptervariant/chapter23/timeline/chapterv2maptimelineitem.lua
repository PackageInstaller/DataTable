local var_0_0 = class("ChapterV2MapTimelineItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.typeControl_ = arg_1_0.conEx_:GetController("information")
	arg_1_0.clueControl_ = arg_1_0.conEx_:GetController("clue")
	arg_1_0.mainSelectControl_ = arg_1_0.conEx_:GetController("LordSelect")
	arg_1_0.sideSelectControl_ = arg_1_0.conEx_:GetController("BranchSelect")
	arg_1_0.sideUnfinishControl_ = arg_1_0.conEx_:GetController("LordUnfinished")
	arg_1_0.clueUnfinishControl_ = arg_1_0.conEx_:GetController("FragmentUnfinished")
	arg_1_0.sideLockControl_ = arg_1_0.conEx_:GetController("LordLock")
	arg_1_0.clueList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.clueUiList_, ChapterV2MapTimelineClueItem)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.selectBtn_, nil, function()
		manager.notify:CallUpdateFunc(CHAPTER_MAP_TIMELINE_EVENT_CLICK, arg_2_0.eventId_, arg_2_0)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.eventId_ = arg_4_1
	arg_4_0.clueReadCount_ = 0
	arg_4_0.clueTotalCount_ = 0

	arg_4_0:RefreshUI(arg_4_2)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1 <= arg_5_0.clueReadCount_)
end

function var_0_0.AddClue(arg_6_0, arg_6_1)
	if ChapterV2MapData:IsEventCompleted(arg_6_1) then
		arg_6_0.clueReadCount_ = arg_6_0.clueReadCount_ + 1
	end

	arg_6_0.clueTotalCount_ = arg_6_0.clueTotalCount_ + 1

	arg_6_0:UIUpdateClue()
end

function var_0_0.UIUpdateSelect(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.eventId_
	local var_7_1 = ChapterV2MapEventCfg[var_7_0]

	if var_7_1.type == ChapterV2MapConst.MapEventType.MAIN then
		arg_7_0.mainSelectControl_:SetSelectedState(arg_7_1 and "on" or "off")
	elseif var_7_1.type == ChapterV2MapConst.MapEventType.SIDE then
		arg_7_0.sideSelectControl_:SetSelectedState(arg_7_1 and "on" or "off")
	end
end

function var_0_0.UIUpdateComplete(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.eventId_
	local var_8_1 = ChapterV2MapEventCfg[var_8_0]

	arg_8_0.sideUnfinishControl_:SetSelectedState(arg_8_1 and "off" or "on")
end

function var_0_0.UIUpdateInteractable(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.eventId_

	if ChapterV2MapEventCfg[var_9_0].type == ChapterV2MapConst.MapEventType.SIDE then
		arg_9_0.sideLockControl_:SetSelectedState(arg_9_1 and "off" or "on")
	end
end

function var_0_0.UIUpdateClue(arg_10_0)
	if arg_10_0.clueTotalCount_ == 0 then
		arg_10_0.clueControl_:SetSelectedState("off")
	else
		arg_10_0.clueControl_:SetSelectedState("on")
		arg_10_0.clueUnfinishControl_:SetSelectedState(arg_10_0.clueTotalCount_ > arg_10_0.clueReadCount_ and "on" or "off")
		arg_10_0.clueList_:StartScroll(arg_10_0.clueTotalCount_)

		if arg_10_0.clueTotalCount_ <= 4 then
			arg_10_0.bgRect_.sizeDelta = Vector2(164, arg_10_0.bgRect_.sizeDelta.y)
		else
			arg_10_0.bgRect_.sizeDelta = Vector2(202, arg_10_0.bgRect_.sizeDelta.y)
		end
	end
end

function var_0_0.RefreshUI(arg_11_0, arg_11_1)
	arg_11_0.isSelect_ = arg_11_1
	arg_11_0.gameObject_.name = arg_11_0.eventId_

	local var_11_0 = arg_11_0.eventId_
	local var_11_1 = ChapterV2MapEventCfg[var_11_0]

	arg_11_0.text_.text = var_11_1.name

	if var_11_1.type == ChapterV2MapConst.MapEventType.MAIN then
		arg_11_0.typeControl_:SetSelectedState("Lord")
	elseif var_11_1.type == ChapterV2MapConst.MapEventType.SIDE then
		arg_11_0.typeControl_:SetSelectedState("Branch")
	end

	arg_11_0:UIUpdateSelect(arg_11_0.isSelect_)
	arg_11_0:UIUpdateComplete(ChapterV2MapData:IsEventCompleted(var_11_0))
	arg_11_0:UIUpdateInteractable(ChapterV2MapData:IsEventCompleted(var_11_0) or ChapterV2MapTools.IsEventInteractable(var_11_0))
	arg_11_0:UIUpdateClue()
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	if arg_12_0.clueList_ then
		arg_12_0.clueList_:Dispose()

		arg_12_0.clueList_ = nil
	end

	Object.Destroy(arg_12_0.gameObject_)

	arg_12_0.gameObject_ = nil
	arg_12_0.transform_ = nil
end

return var_0_0
