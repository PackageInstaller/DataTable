local GeZiURExchangePage = class("GeZiURExchangePage", import("view.activity.CorePage.Helena.HelenaUrExchangePage"))

local function var_0_1(arg_1_0)
	return (arg_1_0._tf:Find("AD/rw/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function GeZiURExchangePage:Hx4Channel()
	local var_2_0 = var_0_1(self)

	if not IsNil(var_2_0) then
		setActive(var_2_0, HXSet.isHx())
	end

	return
end

function GeZiURExchangePage:OnFirstFlush()
	GeZiURExchangePage.super.OnFirstFlush(self)
	self:Hx4Channel()

	return
end

return GeZiURExchangePage
