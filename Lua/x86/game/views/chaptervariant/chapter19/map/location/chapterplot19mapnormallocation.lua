ChapterPlot19MapBaseLocation = import(".ChapterPlot19MapBaseLocation")

local var_0_0 = class("ChapterPlot19MapNormalLocation", ChapterPlot19MapBaseLocation)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.controller_ = arg_1_0.controllerEx_:GetController("stage")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if not ChapterTools.IsEnableLocation(arg_3_0.locationID_) then
			return
		end

		BattleFieldData:SetChapterLocationID(arg_3_0.chapterID_, arg_3_0.locationID_)
		manager.notify:Invoke(CHAPTER_SELECT_LOCATION)
		arg_3_0:Go("chapterPlot19MapLocationInfo", {
			chapterID = arg_3_0.chapterID_,
			locationID = arg_3_0.locationID_
		})
	end)
end

function var_0_0.UpdateLocation(arg_5_0)
	var_0_0.super.UpdateLocation(arg_5_0)

	local var_5_0 = arg_5_0.locationID_
	local var_5_1 = ChapterLocationCfg[var_5_0]

	arg_5_0.nameText_.text = GetI18NText(var_5_1.name)

	if ChapterTools.HasNewLocationMainStage(var_5_0) then
		arg_5_0.controller_:SetSelectedState("state1")
	elseif ChapterTools.HasNewLocationStage(mapID, var_5_0) then
		arg_5_0.controller_:SetSelectedState("state0")
	else
		arg_5_0.controller_:SetSelectedState("state2")
	end
end

function var_0_0.Show(arg_6_0, arg_6_1)
	var_0_0.super.Show(arg_6_0, arg_6_1)

	if arg_6_1 and arg_6_0.needRefreshAnimaor_ then
		arg_6_0.animator_:Play("verStage", -1, 0)
	end

	arg_6_0.needRefreshAnimaor_ = false
end

return var_0_0
