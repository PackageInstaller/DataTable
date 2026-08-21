local var_0_0 = class("DreamTourPtPage", import("view.activity.CorePage.Helena.HelenaPtNewPage"))

local function var_0_1(arg_1_0)
	return (arg_1_0._tf:Find("AD/rw/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function var_0_0.Hx4Channel(arg_2_0)
	local var_2_0 = var_0_1(arg_2_0)

	if not IsNil(var_2_0) then
		setActive(var_2_0, HXSet.isHx())
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	var_0_0.super.OnFirstFlush(arg_3_0)
	arg_3_0:Hx4Channel()

	return
end

return var_0_0
