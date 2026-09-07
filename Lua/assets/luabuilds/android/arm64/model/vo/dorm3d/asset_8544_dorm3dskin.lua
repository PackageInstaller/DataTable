local Dorm3dSkin = class("Dorm3dSkin", import("model.vo.BaseVO"))

function Dorm3dSkin:bindConfigTable()
	return pg.dorm3d_resource
end

function Dorm3dSkin:GetName()
	return self:getConfig("name")
end

function Dorm3dSkin:GetType()
	return self:getConfig("type")
end

function Dorm3dSkin:GetUnlock()
	return self:getConfig("unlock")
end

function Dorm3dSkin:GetShopId()
	return self:getConfig("shop_id")
end

function Dorm3dSkin:GetPublicRoomId()
	return self:GetUnlock()[2]
end

function Dorm3dSkin:GetIcon()
	return self:getConfig("head_Icon")
end

function Dorm3dSkin:GetUnlockText()
	return self:getConfig("unlock_text")
end

function Dorm3dSkin:GetSwitchAnim()
	return self:getConfig("switch_anim")
end

function Dorm3dSkin:GetWearAnim()
	return self:getConfig("wear_anim")
end

function Dorm3dSkin:GetRemarks()
	return self:getConfig("remarks")
end

function Dorm3dSkin:GetGroupId()
	return self:getConfig("ship_group")
end

function Dorm3dSkin:ShouldApplyHiddenPartInTimeline()
	return self:getConfig("hidden_part_apply_in_timeline") == 1
end

function Dorm3dSkin:GetHiddenPartIcons(arg_14_1)
	local var_14_0 = self:getConfig("hidden_part")
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_2 = iter_14_0.find(var_14_0, function(arg_15_0)
			return arg_15_0[1] == iter_14_1
		end)

		if var_14_2 then
			table.insert(var_14_1, var_14_2[2])
		end
	end

	return var_14_1
end

function Dorm3dSkin:GetActiveAndHiddenPartNames(arg_16_1)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs((self:getConfig("hidden_part"))) do
		if table.contains(arg_16_1, iter_16_1[1]) then
			table.insert(var_16_1, iter_16_1[3])
		else
			table.insert(var_16_0, iter_16_1[3])
		end
	end

	return var_16_0, var_16_1
end

function Dorm3dSkin:GetRarity()
	return 5
end

function Dorm3dSkin:GetModelName()
	return self:getConfig("model_id")
end

function Dorm3dSkin:IsShow()
	return self:getConfig("is_show_change_skin") == 1
end

return Dorm3dSkin
