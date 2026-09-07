local ShipModMediator = class("ShipModMediator", import("..base.ContextMediator"))

ShipModMediator.ON_SELECT_MATERIAL_SHIPS = "ShipModMediator:ON_SELECT_MATERIAL_SHIPS"
ShipModMediator.ON_AUTO_SELECT_SHIP = "ShipModMediator:ON_AUTO_SELECT_SHIP"
ShipModMediator.MOD_SHIP = "ShipModMediator:MOD_SHIP"
ShipModMediator.ON_SKILL = "ShipModMediator:ON_SKILL"
ShipModMediator.LOADEND = "ShipModMediator:LOADEND"

function ShipModMediator:register()
	local var_1_0 = getProxy(BayProxy)

	self.viewComponent:setShipVOs((var_1_0:getRawData()))
	self.viewComponent:setShip((var_1_0:getShipById(self.contextData.shipId)))
	self:bind(ShipModMediator.ON_SELECT_MATERIAL_SHIPS, function(arg_2_0)
		local var_2_0 = pg.ShipFlagMgr.GetInstance():FilterShips(ShipStatus.FILTER_SHIPS_FLAGS_1)

		table.insert(var_2_0, 1, self.contextData.shipId)
		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			blockLock = true,
			destroyCheck = true,
			selectedMax = 12,
			leftTopInfo = i18n("word_equipment_intensify"),
			mode = DockyardScene.MODE_MOD,
			onShip = ShipStatus.canDestroyShip,
			ignoredIds = var_2_0,
			selectedIds = self.contextData.materialShipIds,
			onSelected = function(arg_3_0)
				self.contextData.materialShipIds = arg_3_0

				return
			end,
			sortData = {
				Asc = true,
				sort = 1
			},
			hideTagFlags = ShipStatus.TAG_HIDE_DESTROY
		})

		return
	end)
	self:bind(ShipModMediator.ON_AUTO_SELECT_SHIP, function(arg_4_0)
		local var_4_1 = var_1_0:getModRecommendShip(self.viewComponent.shipVO, self.contextData.materialShipIds or {})

		if #var_4_1 > 0 then
			self.contextData.materialShipIds = var_4_1

			self.viewComponent:initSelectedShips()
			self.viewComponent:initAttrs()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("without_selected_ship"))
		end

		return
	end)
	self:bind(ShipModMediator.MOD_SHIP, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.MOD_SHIP, {
			shipId = arg_5_1,
			shipIds = self.contextData.materialShipIds
		})

		return
	end)
	self:bind(ShipModMediator.ON_SKILL, function(arg_6_0, arg_6_1, arg_6_2)
		self:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SkillInfoLayer,
			data = {
				skillOnShip = arg_6_2,
				skillId = arg_6_1
			}
		}))

		return
	end)
	self:bind(ShipModMediator.LOADEND, function(arg_7_0, arg_7_1)
		self:sendNotification(ShipModMediator.LOADEND, arg_7_1)

		return
	end)

	return
end

function ShipModMediator:listNotificationInterests()
	return {
		GAME.MOD_SHIP_DONE
	}
end

function ShipModMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getBody()

	if arg_9_1:getName() == GAME.MOD_SHIP_DONE then
		self.contextData.materialShipIds = nil

		self.viewComponent:setShip(var_9_0.newShip)
		self.viewComponent:modAttrAnim(var_9_0.newShip, var_9_0.oldShip)
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_shipModLayer_modSuccess"))

		if table.getCount(var_9_0.equipments) > 0 then
			local var_9_1 = {}

			for iter_9_0, iter_9_1 in pairs(var_9_0.equipments) do
				table.insert(var_9_1, iter_9_1)
			end

			self:addSubLayers(Context.New({
				viewComponent = ResolveEquipmentLayer,
				mediator = ResolveEquipmentMediator,
				data = {
					Equipments = var_9_1
				}
			}))
		end
	end

	return
end

return ShipModMediator
