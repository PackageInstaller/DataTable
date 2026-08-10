local var_0_0 = class("ChapterV2MapGoLocationItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = arg_1_0.controllerEx_:GetController("goBtn")

	arg_1_0:BindRedPoint()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		ChapterV2MapTools.GoMap(arg_2_0.tagCfg_.behaviour_parameters[1])
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.locationId_ = arg_4_1
	arg_4_0.isSelect_ = arg_4_2

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = ChapterV2MapLocationCfg[arg_5_0.locationId_]

	arg_5_0.transform_:SetLocalPosition(Vector2(var_5_0.position[1], var_5_0.position[2]))

	arg_5_0.tagList_ = ChapterV2MapData:GetLocationActiveTagList(arg_5_0.locationId_)
	arg_5_0.tagCfg_ = ChapterV2MapTagCfg[arg_5_0.tagList_[1]]

	arg_5_0.lockController_:SetSelectedState(tostring(not ChapterV2MapTools.IsLocationUnlock(arg_5_0.locationId_)))

	arg_5_0.nameText_.text = var_5_0.name
end

function var_0_0.SetClickTag(arg_6_0, arg_6_1)
	arg_6_0.clickTag_ = arg_6_1
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:UnbindRedPoint()
	Object.Destroy(arg_7_0.gameObject_)
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.BindRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.nameText_.transform, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_LOCATION, arg_8_0.locationId_))
end

function var_0_0.UnbindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.nameText_.transform)
end

return var_0_0
