local DreamTourPtPage = class("DreamTourPtPage", import("view.activity.CorePage.Helena.HelenaPtNewPage"))

local function var_0_1(arg_1_0)
	return (arg_1_0._tf:Find("AD/rw/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function DreamTourPtPage:Hx4Channel()
	local var_2_0 = var_0_1(self)

	if not IsNil(var_2_0) then
		setActive(var_2_0, HXSet.isHx())
	end

	return
end

function DreamTourPtPage:OnFirstFlush()
	DreamTourPtPage.super.OnFirstFlush(self)
	self:Hx4Channel()

	return
end

return DreamTourPtPage
