local var_0_0 = class("IslandMainTechnologyBtn", import(".IslandMainBaseBtn"))

var_0_0.STATUS = {
	NORMAL = 3,
	STUDYING = 1,
	UNLOCK = 2
}
var_0_0.STATUS2ICON = {
	[var_0_0.STATUS.STUDYING] = "technology_studying",
	[var_0_0.STATUS.UNLOCK] = "technology_unlock",
	[var_0_0.STATUS.NORMAL] = "technology"
}

function var_0_0.Init(arg_1_0)
	arg_1_0._tf.name = arg_1_0.config.btn_name

	onButton(arg_1_0, arg_1_0._tf, function()
		arg_1_0:OnClick()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Flush(arg_3_0)
	var_0_0.super.Flush(arg_3_0)
	arg_3_0:StatusCheck()

	return
end

function var_0_0.StatusCheck(arg_4_0)
	local var_4_0 = arg_4_0:GetStatus()

	if not arg_4_0.status or arg_4_0.status ~= var_4_0 then
		arg_4_0.status = var_4_0

		LoadImageSpriteAtlasAsync("island/islandbtnicon", var_0_0.STATUS2ICON[arg_4_0.status], arg_4_0.iconTF, true)
	end

	return
end

function var_0_0.GetStatus(arg_5_0)
	local var_5_9000
	local var_5_0 = getProxy(IslandProxy)
	local var_5_1 = var_5_0.GetIsland(var_5_9000)
	local var_5_2 = var_5_1:GetBuildingAgency().GetBuilding(var_5_0, IslandTechnologyAgency.PLACE_ID)

	for iter_5_0, iter_5_1 in ipairs((IslandTechnologyAgency.GetSlotIds())) do
		local var_5_3 = var_5_2:GetDelegationSlotData(iter_5_1)

		if var_5_3 and var_5_3:GetSlotRoleData() then
			return var_0_0.STATUS.STUDYING
		end
	end

	for iter_5_2, iter_5_3 in pairs(var_5_1:GetTechnologyAgency():GetTechnologys()) do
		if iter_5_3:IsUnlock() and iter_5_3:GetFinishedCnt() <= 0 then
			return var_0_0.STATUS.UNLOCK
		end
	end

	return var_0_0.STATUS.NORMAL
end

return var_0_0
