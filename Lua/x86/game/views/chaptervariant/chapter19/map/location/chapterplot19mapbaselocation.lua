local var_0_0 = class("ChapterPlot19MapBaseLocation", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
end

function var_0_0.OnUpdate(arg_2_0)
	arg_2_0:UpdateLocation()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetLocationID(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.chapterID_ = arg_5_1
	arg_5_0.locationID_ = arg_5_3

	if arg_5_0.mapID_ ~= arg_5_2 then
		arg_5_0.needRefreshAnimaor_ = true
	else
		arg_5_0.needRefreshAnimaor_ = false
	end

	arg_5_0.mapID_ = arg_5_2
	arg_5_0.disabled_ = false

	arg_5_0:UpdateLocation()
end

function var_0_0.UpdateLocation(arg_6_0)
	local var_6_0 = ChapterTools.NeedShowLocation(arg_6_0.mapID_, arg_6_0.locationID_)

	arg_6_0:Show(var_6_0)

	local var_6_1 = ChapterLocationCfg[arg_6_0.locationID_]

	arg_6_0.transform_.localPosition = Vector3(var_6_1.position[1], var_6_1.position[2], var_6_1.position[3])
end

function var_0_0.Disabled(arg_7_0)
	arg_7_0.disabled_ = true

	arg_7_0:Show(false)
end

function var_0_0.IsDisabled(arg_8_0)
	return arg_8_0.disabled_
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.RefreshSelectState(arg_10_0, arg_10_1)
	local var_10_0 = BattleFieldData:GetChapterLocationID(arg_10_0.chapterID_)

	if arg_10_0.locationID_ == var_10_0 and arg_10_1 then
		arg_10_0.selectController_:SetSelectedState("yes")
	else
		arg_10_0.selectController_:SetSelectedState("no")
	end
end

return var_0_0
