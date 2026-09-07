local Dorm3dInsCharRoom = class("Dorm3dInsCharRoom", import(".Dorm3dInsRoom"))

function Dorm3dInsCharRoom:Ctor(arg_1_1)
	Dorm3dInsCharRoom.super.Ctor(self, arg_1_1)

	self.groupId = self:GetConfig("character")[1]
	self.isCare = getProxy(Dorm3dChatProxy):GetChatCare(self.groupId) == 1

	return
end

function Dorm3dInsCharRoom:GetName()
	return ShipGroup.getDefaultShipNameByGroupID(self.groupId)
end

function Dorm3dInsCharRoom:GetFurnitureNum()
	local var_3_0 = getProxy(ApartmentProxy):getRoom(self.id)

	if not var_3_0 then
		return 0
	end

	return #_.keys(var_3_0:GetFurnitures())
end

function Dorm3dInsCharRoom:GetGiftNum()
	local var_4_0 = getProxy(ApartmentProxy)

	return _.reduce(pg.dorm3d_gift.get_id_list_by_ship_group_id[self.groupId], 0, function(arg_5_0, arg_5_1)
		return arg_5_0 + var_4_0:GetGiftShopCount(arg_5_1)
	end)
end

function Dorm3dInsCharRoom:GetLastVisit()
	local var_6_0 = getProxy(ApartmentProxy):getApartment(self.groupId)
	local var_6_1

	if var_6_0 then
		var_6_1 = var_6_0.visitTime or 0

		if var_6_1 == 0 then
			return i18n("dorm3d_privatechat_no_visit_time")
		end
	end

	local var_6_2 = math.floor((pg.TimeMgr.GetInstance():GetServerTime() - var_6_1) / 0)

	return var_6_2 == 0 and i18n("dorm3d_privatechat_visit_time_now") or i18n("dorm3d_privatechat_visit_time", var_6_2)
end

function Dorm3dInsCharRoom:GetFavorLevel()
	local var_7_0 = getProxy(ApartmentProxy):getApartment(self.groupId)

	return (var_7_0 or nil) and (var_7_0.level or 0)
end

function Dorm3dInsCharRoom:GetCard()
	return string.format("dorm3dselect/apartment_skin_%d", (Apartment.New({
		ship_group = self.groupId
	}):GetSkinModelID(self:GetConfig("tag"))))
end

function Dorm3dInsCharRoom:IsCare()
	return self.isCare
end

function Dorm3dInsCharRoom:SetCare(arg_10_1)
	self.isCare = arg_10_1 == 1

	getProxy(Dorm3dChatProxy):SetChatCare(self.groupId, arg_10_1)

	return
end

function Dorm3dInsCharRoom:ShouldTip()
	return self:GetInsContent() or self:GetChatContent() or self:GetChatContent()
end

function Dorm3dInsCharRoom:GetInsContent()
	if self:IsDownloaded() then
		if getProxy(Dorm3dInsProxy):AnyInstagramShouldTip(self.groupId) then
			local var_12_1 = i18n("dorm3d_privatechat_new_topics", self:GetConfig("room"))

			do return end

			goto label_12_0
		end
	end

	do
		local var_12_3 = i18n("dorm3d_privatechat_nonew_topics")

		return
	end

	::label_12_0::

	return
end

function Dorm3dInsCharRoom:GetPhoneContent()
	if self:IsDownloaded() then
		if getProxy(Dorm3dInsProxy):ShoudTipPhoneById(self.groupId) then
			local var_13_1 = i18n("dorm3d_privatechat_new_calls")

			do return end

			goto label_13_0
		end
	end

	do
		local var_13_3 = i18n("dorm3d_privatechat_nonew_calls")

		return
	end

	::label_13_0::

	return
end

function Dorm3dInsCharRoom:GetChatContent()
	if self:IsDownloaded() then
		if getProxy(Dorm3dChatProxy):ShouldShowShipTip(self.groupId) then
			local var_14_1 = i18n("dorm3d_privatechat_nonew_messages")

			do return end

			goto label_14_0
		end
	end

	do
		local var_14_3 = i18n("dorm3d_privatechat_new_messages")

		return
	end

	::label_14_0::

	return
end

return Dorm3dInsCharRoom
