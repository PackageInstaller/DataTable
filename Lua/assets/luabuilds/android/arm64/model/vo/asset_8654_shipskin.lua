local ShipSkin = class("ShipSkin", import(".BaseVO"))

ShipSkin.SKIN_TYPE_DEFAULT = -1
ShipSkin.SKIN_TYPE_COMMON_FASHION = 0
ShipSkin.SKIN_TYPE_PROPOSE = 1
ShipSkin.SKIN_TYPE_REMAKE = 2
ShipSkin.SKIN_TYPE_OLD = 3
ShipSkin.SKIN_TYPE_NOT_HAVE_HIDE = 4
ShipSkin.SKIN_TYPE_SHOW_IN_TIME = 5
ShipSkin.SKIN_TYPE_TB = 6
ShipSkin.WITH_LIVE2D = 1
ShipSkin.WITH_BG = 2
ShipSkin.WITH_EFFECT = 3
ShipSkin.WITH_DYNAMIC_BG = 4
ShipSkin.WITH_BGM = 5
ShipSkin.WITH_SPINE = 6
ShipSkin.WITH_SPINE_PLUS = 7
ShipSkin.WITH_CHANGE = 8
ShipSkin.WITH_LIVE2D_PLUS = 9
ShipSkin.WITH_DOUBLE_VIOCE = 10
ShipSkin.WITH_ASMR = 11
ShipSkin.VOICE_LANG_JP = 1
ShipSkin.VOICE_LANG_CN = 2

function ShipSkin:Tag2Name()
	ShipSkin.Tag2NameTab = ShipSkin.Tag2NameTab or {
		[ShipSkin.WITH_BG] = "bg",
		[ShipSkin.WITH_BGM] = "bgm",
		[ShipSkin.WITH_DYNAMIC_BG] = "dtbg",
		[ShipSkin.WITH_EFFECT] = "effect",
		[ShipSkin.WITH_LIVE2D] = "live2d",
		[ShipSkin.WITH_SPINE] = "spine",
		[ShipSkin.WITH_SPINE_PLUS] = "spine_plus",
		[ShipSkin.WITH_CHANGE] = "change",
		[ShipSkin.WITH_LIVE2D_PLUS] = "live2d_plus",
		[ShipSkin.WITH_DOUBLE_VIOCE] = "double_voice",
		[ShipSkin.WITH_ASMR] = "asmr_skin"
	}

	return ShipSkin.Tag2NameTab[self]
end

function ShipSkin:GetShopTypeIdBySkinId(arg_2_1)
	if arg_2_1[self] then
		return arg_2_1[self]
	end

	for iter_2_0, iter_2_1 in pairs(pg.ship_skin_template.get_id_list_by_shop_type_id) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			arg_2_1[iter_2_3] = iter_2_0

			if iter_2_3 == self then
				return iter_2_0
			end
		end
	end

	return
end

local var_0_1 = pg.ship_skin_template.get_id_list_by_ship_group

function ShipSkin:GetSkinByType(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(var_0_1[self] or {}) do
		if pg.ship_skin_template[iter_3_1].skin_type == arg_3_1 then
			return pg.ship_skin_template[iter_3_1]
		end
	end

	return
end

function ShipSkin:GetAllSkinByGroup()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(var_0_1[self] or {}) do
		if pg.ship_skin_template[iter_4_1].no_showing ~= "1" then
			table.insert(var_4_0, pg.ship_skin_template[iter_4_1])
		end
	end

	return var_4_0
end

function ShipSkin:GetShareSkinsByGroupId()
	local function var_5_0(arg_6_0)
		local var_6_0 = arg_6_0:getConfig("skin_type")

		return not (var_6_0 == ShipSkin.SKIN_TYPE_DEFAULT or var_6_0 == ShipSkin.SKIN_TYPE_REMAKE or var_6_0 == ShipSkin.SKIN_TYPE_OLD)
	end

	if not pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[self][1]].share_group_id or #pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[self][1]].share_group_id <= 0 then
		return {}
	end

	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[self][1]].share_group_id) do
		for iter_5_2, iter_5_3 in ipairs(pg.ship_skin_template.get_id_list_by_ship_group[iter_5_1]) do
			local var_5_2 = ShipSkin.New({
				id = iter_5_3
			})

			if var_5_0(var_5_2) then
				table.insert(var_5_1, var_5_2)
			end
		end
	end

	return var_5_1
end

function ShipSkin:Ctor(arg_7_1)
	self.id = arg_7_1.id
	self.configId = arg_7_1.id
	self.endTime = arg_7_1.end_time or arg_7_1.time or 0

	if self:getConfig("skin_type") == ShipSkin.SKIN_TYPE_TB then
		self.shipName = NewEducateHelper.GetShipNameBySecId(NewEducateHelper.GetSecIdBySkinId(self.id))
	else
		local var_7_0 = ShipGroup.getDefaultShipConfig((self:getConfig("ship_group")))

		if var_7_0 then
			self.shipName = var_7_0.name or ""
		end
	end

	self.skinName = self:getConfig("name")

	return
end

function ShipSkin:bindConfigTable()
	return pg.ship_skin_template
end

function ShipSkin:isExpireType()
	return self.endTime > 0
end

function ShipSkin:getExpireTime()
	return self.endTime
end

function ShipSkin:isExpired()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.endTime
end

function ShipSkin:getRemainTime()
	return self:getExpireTime() - pg.TimeMgr.GetInstance():GetServerTime()
end

function ShipSkin:getIcon()
	return self:getConfig("painting")
end

function ShipSkin:InShowTime()
	return getProxy(ShipSkinProxy):InShowTime(self.id)
end

function ShipSkin:IsDefault()
	return self:getConfig("skin_type") == ShipSkin.SKIN_TYPE_DEFAULT
end

function ShipSkin:IsType(arg_16_1)
	return self:getConfig("shop_type_id") == arg_16_1
end

function ShipSkin:IsMatchKey(arg_17_1)
	if not arg_17_1 or arg_17_1 == "" then
		return true
	end

	arg_17_1 = string.lower(string.gsub(arg_17_1, "%.", "%%."))
	arg_17_1 = string.lower(string.gsub(arg_17_1, "%-", "%%-"))

	return string.find(string.lower(self.shipName), arg_17_1) or string.find(string.lower(self.skinName), arg_17_1)
end

function ShipSkin:ToShip()
	local var_18_0 = ShipGroup.getDefaultShipConfig((self:getConfig("ship_group")))

	if var_18_0 then
		return Ship.New({
			id = 1,
			intimacy = 10000,
			template_id = var_18_0.id,
			skin_id = self.id
		})
	else
		return nil
	end

	return
end

function ShipSkin:GetDefaultShipConfig()
	return (ShipGroup.getDefaultShipConfig((self:getConfig("ship_group"))))
end

function ShipSkin:IsLive2d()
	self.isLive2dTag = self.isLive2dTag or table.contains(self:getConfig("tag"), ShipSkin.WITH_LIVE2D)

	return self.isLive2dTag
end

function ShipSkin:IsDbg()
	self.isDGBTag = self.isDGBTag or table.contains(self:getConfig("tag"), ShipSkin.WITH_DYNAMIC_BG)

	return self.isDGBTag
end

function ShipSkin:IsBG()
	self.isBGTag = self.isBGTag or table.contains(self:getConfig("tag"), ShipSkin.WITH_BG)

	return self.isBGTag
end

function ShipSkin:IsEffect()
	self.isEffectTag = self.isEffectTag or table.contains(self:getConfig("tag"), ShipSkin.WITH_EFFECT)

	return self.isEffectTag
end

function ShipSkin:isBgm()
	self.isBgmTag = self.isBgmTag or table.contains(self:getConfig("tag"), ShipSkin.WITH_BGM)

	return self.isBgmTag
end

function ShipSkin:IsSpine()
	self.isSpine = self.isSpine or table.contains(self:getConfig("tag"), ShipSkin.WITH_SPINE)

	return self.isSpine
end

function ShipSkin:IsSpinePlus()
	self.isSpinePlus = self.isSpinePlus or table.contains(self:getConfig("tag"), ShipSkin.WITH_SPINE_PLUS)

	return self.isSpinePlus
end

function ShipSkin:IsLive2dPlus()
	self.isLive2dPlusTag = self.isLive2dPlusTag or table.contains(self:getConfig("tag"), ShipSkin.WITH_LIVE2D_PLUS)

	return self.isLive2dPlusTag
end

function ShipSkin:CantUse()
	local var_28_0 = self:getConfig("ship_group")

	return not getProxy(BayProxy):_ExistGroupShip(var_28_0, self:IsTransSkin(), (self:IsProposeSkin())) or getProxy(CollectionProxy).shipGroups[var_28_0] == nil
end

function ShipSkin:OwnShip()
	return (getProxy(BayProxy):_ExistGroupShip(self:getConfig("ship_group"), self:IsTransSkin(), (self:IsProposeSkin())))
end

function ShipSkin:WithoutUse()
	local var_30_0 = getProxy(BayProxy):CanUseShareSkinPhantoms(self.id)

	return #var_30_0 > 0 and underscore.all(var_30_0, function(arg_31_0)
		return arg_31_0:getSkinId() ~= self.id and not ShipSkin.IsSameChangeSkinGroup(arg_31_0:getSkinId(), self.id)
	end)
end

function ShipSkin:NoUse()
	local var_32_0 = getProxy(BayProxy):CanUseShareSkinPhantoms(self.id)

	return #var_32_0 == 0 or #var_32_0 > 0 and underscore.all(var_32_0, function(arg_33_0)
		return arg_33_0:getSkinId() ~= self.id and not ShipSkin.IsSameChangeSkinGroup(arg_33_0:getSkinId(), self.id)
	end)
end

function ShipSkin:ExistShip()
	return pg.ship_data_statistics[tonumber(self:getConfig("ship_group") .. 1)] ~= nil
end

function ShipSkin:IsTransSkin()
	return self:getConfig("skin_type") == ShipSkin.SKIN_TYPE_REMAKE
end

function ShipSkin:IsProposeSkin()
	return self:getConfig("skin_type") == ShipSkin.SKIN_TYPE_PROPOSE
end

function ShipSkin:IsHxDynamicPreview()
	if HXSet.isHx() then
		return self:getConfig("shop_dynamic_hx") == 1
	end

	return false
end

function ShipSkin:IsChangeSkinMainIndex()
	if ShipSkin.IsChangeSkin(self.id) then
		return self:getConfig("change_skin").index == 1
	end

	return false
end

function ShipSkin:MatchChangeSkinMain()
	if ShipSkin.IsChangeSkin(self.id) and not self:IsChangeSkinMainIndex() then
		return false
	end

	return true
end

function ShipSkin:CanShare()
	local var_40_0 = getProxy(ShipSkinProxy):hasSkin(self.configId)

	local function var_40_1()
		if var_40_0 then
			return true
		end

		return self:InShowTime()
	end

	local var_40_3 = self:getConfig("skin_type")

	return not (var_40_3 == ShipSkin.SKIN_TYPE_DEFAULT or var_40_3 == ShipSkin.SKIN_TYPE_REMAKE or var_40_3 == ShipSkin.SKIN_TYPE_OLD or var_40_3 == ShipSkin.SKIN_TYPE_NOT_HAVE_HIDE and not var_40_0 or var_40_3 == ShipSkin.SKIN_TYPE_SHOW_IN_TIME and not var_40_1())
end

function ShipSkin:CanShareInJuus()
	local var_43_0 = getProxy(ShipSkinProxy):hasSkin(self.configId)
	local var_43_1 = self:getConfig("skin_type")

	return not (var_43_1 == ShipSkin.SKIN_TYPE_REMAKE or var_43_1 == ShipSkin.SKIN_TYPE_OLD or var_43_1 == ShipSkin.SKIN_TYPE_NOT_HAVE_HIDE and not var_43_0 or var_43_1 == ShipSkin.SKIN_TYPE_SHOW_IN_TIME and not var_43_0)
end

function ShipSkin:IsShareSkin(arg_44_1)
	return table.contains(pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[self.groupId][1]].share_group_id, pg.ship_skin_template[arg_44_1].ship_group)
end

function ShipSkin:CanUseShareSkinForShip(arg_45_1)
	local var_45_0 = ShipSkin.IsShareSkin(self, arg_45_1)
	local var_45_1 = ShipSkin.New({
		id = arg_45_1
	})
	local var_45_2 = false
	local var_45_3 = var_45_1:CanShare()
	local var_45_4 = var_45_1:IsProposeSkin()

	if var_45_3 and var_45_4 and self.propose then
		var_45_2 = true
	elseif var_45_3 and not var_45_4 then
		var_45_2 = math.floor(self:getIntimacy() / 100) >= self:GetNoProposeIntimacyMax()
	end

	return var_45_0 and var_45_2
end

function ShipSkin:ExistReward()
	return pg.ship_skin_reward[self.configId] ~= nil and #pg.ship_skin_reward[self.configId].reward > 0
end

function ShipSkin:GetRewardList()
	local var_47_0

	if not self:ExistReward() then
		do return {} end

		var_47_0 = {}
	end

	for iter_47_0, iter_47_1 in pairs(pg.ship_skin_reward[self.configId].reward) do
		table.insert(var_47_0, {
			type = iter_47_1[1],
			id = iter_47_1[2],
			count = iter_47_1[3]
		})
	end

	return var_47_0
end

function ShipSkin:GetRewardListDesc()
	local var_48_0 = self:GetRewardList()

	if #var_48_0 <= 0 then
		return ""
	end

	return getDropInfo((_.map(var_48_0, function(arg_49_0)
		return {
			arg_49_0.type,
			arg_49_0.id,
			arg_49_0.count
		}
	end)))
end

function ShipSkin:GetShareGroupIds()
	local var_50_1

	if pg.ship_data_group.get_id_list_by_group_type[self:getConfig("ship_group")] then
		var_50_1 = pg.ship_data_group.get_id_list_by_group_type[self:getConfig("ship_group")][1] or nil
	end

	local var_50_3 = underscore.to_array((var_50_1 or nil) and (pg.ship_data_group[var_50_1].share_group_id or {}))
end

function ShipSkin:GetAllChangeSkinIds()
	local var_51_0

	if not ShipSkin.GetChangeSkinMainId(self) then
		do return {
			self
		} end

		var_51_0 = {}
	end

	var_51_0[1] = ShipSkin.GetChangeSkinMainId(self)

	local var_51_1 = self

	for iter_51_0 = 1, 10 do
		local var_51_2 = ShipSkin.GetChangeSkinNextId(self)

		if not table.contains(var_51_0, var_51_2) then
			table.insert(var_51_0, var_51_2)
		end

		var_51_1 = var_51_2

		if ShipSkin.GetChangeSkinIndex(var_51_2) == 1 then
			return var_51_0
		end
	end

	return var_51_0
end

function ShipSkin:IsChangeSkin()
	if not pg.ship_skin_template[self] then
		warning("skin not exist " .. self)
	end

	return table.contains(pg.ship_skin_template[self].tag, ShipSkin.WITH_CHANGE) or table.contains(pg.ship_skin_template[self].tag, ShipSkin.WITH_DOUBLE_VIOCE) or table.contains(pg.ship_skin_template[self].tag, ShipSkin.WITH_ASMR)
end

function ShipSkin:GetChangeSkinMainId()
	if not ShipSkin.IsChangeSkin(self) then
		return self
	end

	while ShipSkin.GetChangeSkinIndex(self) ~= 1 do
		self = ShipSkin.GetChangeSkinNextId(self)
	end

	return self
end

function ShipSkin:GetChangeSkinData()
	if not ShipSkin.IsChangeSkin(self) then
		return nil
	end

	local var_54_0 = pg.ship_skin_template[self]

	if pg.ship_skin_template[self] and var_54_0.change_skin and var_54_0.change_skin ~= "" then
		return var_54_0.change_skin
	end

	return nil
end

function ShipSkin:IsSameChangeSkinGroup(arg_55_1)
	if not ShipSkin.IsChangeSkin(self) or not ShipSkin.IsChangeSkin(arg_55_1) then
		return false
	end

	return ShipSkin.GetChangeSkinGroupId(self) == ShipSkin.GetChangeSkinGroupId(arg_55_1)
end

function ShipSkin:GetChangeSkinGroupId()
	local var_56_0 = ShipSkin.GetChangeSkinData(self)

	return (var_56_0 or nil) and (var_56_0.group or nil)
end

function ShipSkin:GetChangeSkinNextId()
	local var_57_0 = ShipSkin.GetChangeSkinData(self)

	return (var_57_0 or nil) and (var_57_0.next or nil)
end

function ShipSkin:GetChangeSkinIndex()
	local var_58_0 = ShipSkin.GetChangeSkinData(self)

	return (var_58_0 or nil) and (var_58_0.index or nil)
end

function ShipSkin:GetChangeSkinState()
	local var_59_0 = ShipSkin.GetChangeSkinData(self)

	return (var_59_0 or nil) and (var_59_0.state or nil)
end

function ShipSkin:GetChangeSkinAction()
	local var_60_0 = ShipSkin.GetChangeSkinData(self)

	return (var_60_0 or nil) and (var_60_0.action or nil)
end

function ShipSkin:GetChangeSkinCustomDataId(arg_61_1)
	local var_61_0 = ShipSkin.GetChangeSkinData(self)

	return (var_61_0 or nil) and (var_61_0[arg_61_1] or nil)
end

function ShipSkin:GetStoreChangeSkinId(arg_62_1)
	local var_62_0, var_62_1 = ShipPhantom.UnpackMark(arg_62_1)
	local var_62_2 = PlayerPrefs.GetInt(ShipSkin.GetStoreChangeSkinPrefsName(self, arg_62_1), 0)

	if var_62_2 == 0 then
		return nil
	else
		return var_62_2
	end

	return
end

function ShipSkin:SetStoreChangeSkinId(arg_63_1)
	local var_63_0 = ShipSkin.GetChangeSkinCustomDataId(self, "asmr") == 1
	local var_63_1, var_63_2 = ShipPhantom.UnpackMark(arg_63_1)

	PlayerPrefs.SetInt(ShipSkin.GetStoreChangeSkinPrefsName(ShipSkin.GetChangeSkinGroupId(self), arg_63_1), self)

	return
end

function ShipSkin.GetStoreChangeSkinPrefsName(...)
	return string.format("change_skin_group_%s", table.concat({
		...
	}, "_"))
end

return ShipSkin
