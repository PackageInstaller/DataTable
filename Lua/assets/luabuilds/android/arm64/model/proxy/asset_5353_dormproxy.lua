local DormProxy = class("DormProxy", import(".NetProxy"))

DormProxy.DORM_UPDATEED = "DormProxy updated"
DormProxy.LEVEL_UP = "DormProxy level up"
DormProxy.FURNITURE_ADDED = "DormProxy FURNITURE ADDED"
DormProxy.FURNITURE_UPDATED = "DormProxy FURNITURE UPDATED"
DormProxy.SHIP_ADDED = "DormProxy ship added"
DormProxy.SHIP_EXIT = "DormProxy ship exit"
DormProxy.INIMACY_AND_MONEY_ADD = "DormProxy inimacy and money added"
DormProxy.SHIPS_EXP_ADDED = "DormProxy SHIPS_EXP_ADDED"
DormProxy.THEME_ADDED = "DormProxy THEME_ADDED"
DormProxy.THEME_DELETED = "DormProxy THEME_DELETED"
DormProxy.THEME_TEMPLATE_UPDATED = "DormProxy THEME_TEMPLATE_UPDATED"
DormProxy.THEME_TEMPLATE_DELTETED = "DormProxy THEME_TEMPLATE_DELTETED"
DormProxy.COLLECTION_THEME_TEMPLATE_ADDED = "DormProxy COLLECTION_THEME_TEMPLATE_ADDED"
DormProxy.COLLECTION_THEME_TEMPLATE_DELETED = "DormProxy COLLECTION_THEME_TEMPLATE_DELETED"
DormProxy.THEME_TEMPLATE_ADDED = "DormProxy THEME_TEMPLATE_ADDED"
DormProxy.SHOP_THEME_TEMPLATE_DELETED = "DormProxy SHOP_THEME_TEMPLATE_DELETED"

function DormProxy:register()
	self.TYPE = 2
	self.PAGE = 1
	self.MAX_PAGE = 10
	self.lastPages = {
		[2] = math.huge,
		[3] = math.huge,
		[5] = math.huge
	}
	self.friendData = nil
	self.systemThemes = {}

	self:on(19001, function(arg_2_0)
		self:sendNotification(GAME.GET_BACKYARD_DATA, {
			isMine = true,
			data = arg_2_0
		})

		return
	end)
	self:RequestPopEvent()

	return
end

function DormProxy:OnEnterBackyard()
	self:SettlementShipExp()

	return
end

function DormProxy:OnExitBackyard()
	self:ClearRequestShipExp()

	return
end

function DormProxy:SettlementShipExp()
	self:ClearRequestShipExp()

	if self.data:ShouldRequestShipExp() then
		self:sendNotification(GAME.BACKYARD_REQUEST_SHIP_EXP)
	else
		self:RequestShipExp()
	end

	return
end

function DormProxy:RequestShipExp()
	self.requestShipExpTimer = Timer.New(function()
		self:ClearRequestShipExp()
		self:sendNotification(GAME.BACKYARD_REQUEST_SHIP_EXP)

		return
	end, self.data:GetNextSettlementShipExpTime() - pg.TimeMgr.GetInstance():GetServerTime(), 1)

	self.requestShipExpTimer:Start()

	return
end

function DormProxy:ClearRequestShipExp()
	if self.requestShipExpTimer then
		self.requestShipExpTimer:Stop()

		self.requestShipExpTimer = nil
	end

	return
end

function DormProxy:RequestPopEvent()
	self:ClearRequestPopEvent()

	self.requestEventTimer = Timer.New(function()
		self:sendNotification(GAME.BACKYARD_REQUEST_POP_EVENT)

		return
	end, pg.gameset.dorm_pop_time.key_value, -1)

	self.requestEventTimer:Start()

	return
end

function DormProxy:ClearRequestPopEvent()
	if self.requestEventTimer then
		self.requestEventTimer:Stop()

		self.requestEventTimer = nil
	end

	return
end

function DormProxy:GetVisitorShip()
	return self.visitorShip
end

function DormProxy:SetVisitorShip(arg_13_1)
	self.visitorShip = arg_13_1

	return
end

function DormProxy:addDorm(arg_14_1)
	assert(isa(arg_14_1, Dorm), "dorm should instance of Dorm")

	self.data = arg_14_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inBackyard")

	return
end

function DormProxy:updateDrom(arg_15_1, arg_15_2)
	assert(isa(arg_15_1, Dorm), "dorm should instance of Dorm")
	assert(arg_15_1, "drom should exist")

	self.data = arg_15_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inBackyard")
	self.facade:sendNotification(DormProxy.DORM_UPDATEED, {}, arg_15_2)

	return
end

function DormProxy:getData()
	if not self.data then
		-- block empty
	end

	return Dorm.New({
		id = 1
	}):clone()
end

function DormProxy:GetCustomThemeTemplates()
	return self.customThemeTemplates
end

function DormProxy:SetCustomThemeTemplates(arg_18_1)
	self.customThemeTemplates = arg_18_1

	return
end

function DormProxy:GetCustomThemeTemplateById(arg_19_1)
	return self.customThemeTemplates[arg_19_1]
end

function DormProxy:UpdateCustomThemeTemplate(arg_20_1)
	self.customThemeTemplates[arg_20_1.id] = arg_20_1

	self:sendNotification(DormProxy.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM,
		template = arg_20_1
	})

	return
end

function DormProxy:DeleteCustomThemeTemplate(arg_21_1)
	self.customThemeTemplates[arg_21_1] = nil

	self:sendNotification(DormProxy.THEME_TEMPLATE_DELTETED, {
		templateId = arg_21_1
	})

	return
end

function DormProxy:AddCustomThemeTemplate(arg_22_1)
	self.customThemeTemplates[arg_22_1.id] = arg_22_1

	self:sendNotification(DormProxy.THEME_TEMPLATE_ADDED, {
		template = arg_22_1
	})

	return
end

function DormProxy:GetUploadThemeTemplateCnt()
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(self.customThemeTemplates) do
		if iter_23_1:IsPushed() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function DormProxy:GetShopThemeTemplates()
	return self.shopThemeTemplates
end

function DormProxy:SetShopThemeTemplates(arg_25_1)
	self.shopThemeTemplates = arg_25_1

	return
end

function DormProxy:GetShopThemeTemplateById(arg_26_1)
	return self.shopThemeTemplates[arg_26_1]
end

function DormProxy:IsInitShopThemeTemplates()
	return self.shopThemeTemplates ~= nil
end

function DormProxy:UpdateShopThemeTemplate(arg_28_1)
	self.shopThemeTemplates[arg_28_1.id] = arg_28_1

	self:sendNotification(DormProxy.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_SHOP,
		template = arg_28_1
	})

	return
end

function DormProxy:DeleteShopThemeTemplate(arg_29_1)
	self.shopThemeTemplates[arg_29_1] = nil

	self:sendNotification(DormProxy.SHOP_THEME_TEMPLATE_DELETED, {
		id = arg_29_1
	})

	return
end

function DormProxy:GetCollectionThemeTemplates()
	return self.collectionThemeTemplates
end

function DormProxy:SetCollectionThemeTemplates(arg_31_1)
	self.collectionThemeTemplates = arg_31_1

	return
end

function DormProxy:GetCollectionThemeTemplateById(arg_32_1)
	return self.collectionThemeTemplates[arg_32_1]
end

function DormProxy:AddCollectionThemeTemplate(arg_33_1)
	self.collectionThemeTemplates[arg_33_1.id] = arg_33_1

	self:sendNotification(DormProxy.COLLECTION_THEME_TEMPLATE_ADDED, {
		template = arg_33_1
	})

	return
end

function DormProxy:DeleteCollectionThemeTemplate(arg_34_1)
	self.collectionThemeTemplates[arg_34_1] = nil

	self:sendNotification(DormProxy.COLLECTION_THEME_TEMPLATE_DELETED, {
		id = arg_34_1
	})

	return
end

function DormProxy:GetThemeTemplateCollectionCnt()
	return table.getCount(self.collectionThemeTemplates or {})
end

function DormProxy:UpdateCollectionThemeTemplate(arg_36_1)
	self.collectionThemeTemplates[arg_36_1.id] = arg_36_1

	self:sendNotification(DormProxy.THEME_TEMPLATE_UPDATED, {
		type = BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION,
		template = arg_36_1
	})

	return
end

function DormProxy:GetTemplateNewID()
	local var_37_1 = _.map(_.values(self.customThemeTemplates or {}), function(arg_38_0)
		return arg_38_0:GetPos()
	end)

	for iter_37_0 = 1, 10 do
		if not table.contains(var_37_1, iter_37_0) then
			return iter_37_0
		end
	end

	return
end

function DormProxy:GetSystemThemes()
	if not self.systemThemes or #self.systemThemes == 0 then
		local var_39_0 = pg.backyard_theme_template

		for iter_39_0, iter_39_1 in ipairs(pg.backyard_theme_template.all) do
			if var_39_0[iter_39_1].is_view == 1 then
				table.insert(self.systemThemes, (BackYardSystemTheme.New({
					id = iter_39_1
				})))
			end
		end
	end

	return self.systemThemes
end

function DormProxy:ResetSystemTheme(arg_40_1)
	if not self.systemThemes or #self.systemThemes == 0 then
		return
	end

	for iter_40_0, iter_40_1 in ipairs(self.systemThemes) do
		if iter_40_1.id == arg_40_1 then
			self.systemThemes[iter_40_0] = BackYardSystemTheme.New({
				id = arg_40_1
			})

			break
		end
	end

	return
end

function DormProxy:NeedRefreshThemeTemplateShop()
	self.refreshThemeTemplateShopTime = self.refreshThemeTemplateShopTime or 0

	local var_41_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_41_0 > self.refreshThemeTemplateShopTime then
		self.refreshThemeTemplateShopTime = var_41_0 + BackYardConst.AUTO_REFRESH_THEME_TEMPLATE_TIME

		return true
	end

	return false
end

function DormProxy:NeedCollectionTip()
	local var_42_0 = getProxy(PlayerProxy)
	local var_42_1 = var_42_0:getRawData().id
	local var_42_2 = PlayerPrefs.GetInt("backyard_template" .. var_42_1, 0)
	local var_42_3 = self:GetThemeTemplateCollectionCnt()

	if var_42_0 ~= var_42_2 then
		PlayerPrefs.SetInt("backyard_template" .. var_42_1, var_42_3)
		PlayerPrefs.Save()
	end

	if var_42_3 < var_42_2 then
		return true
	end

	return false
end

function DormProxy:NeedShopShowHelp()
	local var_43_0 = getProxy(PlayerProxy):getRawData().id

	if PlayerPrefs.GetInt("backyard_template_help" .. var_43_0, 0) <= 0 then
		PlayerPrefs.SetInt("backyard_template_help" .. var_43_0, 1)
		PlayerPrefs.Save()

		return true
	end

	return false
end

function DormProxy:GetTag7Furnitures()
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(pg.furniture_data_template.get_id_list_by_tag[7]) do
		if pg.furniture_shop_template[iter_44_1] and pg.furniture_shop_template[iter_44_1].not_for_sale == 0 then
			if pg.TimeMgr.GetInstance():inTime(pg.furniture_shop_template[iter_44_1].time) then
				table.insert(var_44_0, iter_44_1)
			end
		end
	end

	return var_44_0
end

function DormProxy:IsShowRedDot()
	local var_45_0 = getProxy(PlayerProxy)
	local var_45_1 = pg.SystemOpenMgr.GetInstance()
	local var_45_2 = getProxy(DormProxy).getRawData(var_45_0)
	local var_45_3

	if var_45_1:isOpenSystem(var_45_0:getRawData().level, "CourtYardMediator") and not var_45_2.IsLackOfFood(var_45_1) and not var_45_2:AnyShipExistIntimacyOrMoney() then
		::label_45_2::

		var_45_3 = getProxy(SettingsProxy):IsTipNewTheme()
		var_45_3 = var_45_3 or getProxy(SettingsProxy):IsTipNewGemFurniture()
	end

	return var_45_3
end

function DormProxy:remove()
	self:ClearRequestPopEvent()
	self:ClearRequestShipExp()

	return
end

return DormProxy
