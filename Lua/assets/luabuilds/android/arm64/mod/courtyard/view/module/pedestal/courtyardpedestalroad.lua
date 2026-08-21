local var_0_0 = class("CourtYardPedestalRoad", import(".CourtYardPedestalStructure"))
local var_0_1 = {
	-920,
	-1080,
	-1230,
	-1230
}

function var_0_0.GetAssetPath(arg_1_0)
	return "furnitrues/base/road_" .. arg_1_0.level
end

function var_0_0.OnLoaded(arg_2_0, arg_2_1)
	setAnchoredPosition(arg_2_1, Vector3(0, var_0_1[arg_2_0.level], 0))

	if arg_2_0.level ~= 4 then
		onButton(arg_2_0, arg_2_1.transform:Find("warn"), function()
			if CourtYardConst.MAX_STOREY_LEVEL + 1 == arg_2_0.level then
				return
			end

			if arg_2_0:IsEditModeOrIsVisit() then
				return
			end

			arg_2_0.parent.msgBox:ExecuteAction("Show")

			return
		end, SFX_PANEL)
		onButton(arg_2_0, arg_2_1, function()
			if CourtYardConst.MAX_STOREY_LEVEL + 1 == arg_2_0.level then
				return
			end

			if arg_2_0:IsEditModeOrIsVisit() then
				return
			end

			arg_2_0.parent.msgBox:ExecuteAction("Show")

			return
		end, SFX_PANEL)
	end

	tf(arg_2_1):SetSiblingIndex(0)

	return
end

function var_0_0.GetParent(arg_5_0)
	return arg_5_0.parent._tf:Find("base")
end

return var_0_0
