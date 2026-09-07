local NavalAcademyMediator = class("NavalAcademyMediator", import("..base.ContextMediator"))

NavalAcademyMediator.ON_OPEN_CLASSROOM = "NavalAcademyMediator:ON_OPEN_CLASSROOM"
NavalAcademyMediator.ON_OPEN_COMMANDER = "NavalAcademyMediator:ON_OPEN_COMMANDER"
NavalAcademyMediator.ON_OPEN_COLLECTION = "NavalAcademyMediator:ON_OPEN_COLLECTION"
NavalAcademyMediator.ON_OPEN_OILRESFIELD = "NavalAcademyMediator:ON_OPEN_OILRESFIELD"
NavalAcademyMediator.ON_OPEN_GOLDRESFIELD = "NavalAcademyMediator:ON_OPEN_GOLDRESFIELD"
NavalAcademyMediator.ON_OPEN_SUPPLYSHOP = "NavalAcademyMediator:ON_OPEN_SUPPLYSHOP"
NavalAcademyMediator.ON_OPEN_TACTICROOM = "NavalAcademyMediator:ON_OPEN_TACTICROOM"
NavalAcademyMediator.ON_OPEN_MINIGAMEHALL = "NavalAcademyMediator:ON_OPEN_MINIGAMEHALL"
NavalAcademyMediator.UPGRADE_FIELD = "NavalAcademyMediator:UPGRADE_FIELD"
NavalAcademyMediator.GO_SCENE = "NavalAcademyMediator:GO_SCENE"
NavalAcademyMediator.OPEN_ACTIVITY_PANEL = "NavalAcademyMediator:OPEN_ACTIVITY_PANEL"
NavalAcademyMediator.OPEN_ACTIVITY_SHOP = "NavalAcademyMediator:OPEN_ACTIVITY_SHOP"
NavalAcademyMediator.OPEN_SCROLL = "NavalAcademyMediator:OPEN_SCROLL"
NavalAcademyMediator.ACTIVITY_OP = "NavalAcademyMediator:ACTIVITY_OP"
NavalAcademyMediator.TASK_GO = "NavalAcademyMediator:TASK_GO"
NavalAcademyMediator.GO_TASK_SCENE = "NavalAcademyMediator:GO_TASK_SCENE"
NavalAcademyMediator.ON_GET_CLASS_RES = "NavalAcademyMediator:ON_GET_CLASS_RES"
NavalAcademyMediator.ON_GET_RES = "NavalAcademyMediator:ON_GET_RES"

function NavalAcademyMediator:register()
	self:bind(NavalAcademyMediator.ON_GET_CLASS_RES, function(arg_2_0)
		self:sendNotification(GAME.HARVEST_CLASS_RES)

		return
	end)
	self:bind(NavalAcademyMediator.ON_GET_RES, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.HARVEST_RES, arg_3_1)

		return
	end)
	self:bind(NavalAcademyMediator.GO_TASK_SCENE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.TASK, arg_4_1)

		return
	end)
	self:bind(NavalAcademyMediator.TASK_GO, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.TASK_GO, arg_5_1)

		return
	end)
	self:bind(NavalAcademyMediator.ACTIVITY_OP, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_6_1)

		return
	end)
	self:bind(NavalAcademyMediator.OPEN_SCROLL, function(arg_7_0, arg_7_1)
		assert(false, "问卷系统已废弃")

		return
	end)
	self:bind(NavalAcademyMediator.OPEN_ACTIVITY_SHOP, function(arg_8_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	self:bind(NavalAcademyMediator.OPEN_ACTIVITY_PANEL, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_9_1
		})

		return
	end)
	self:bind(NavalAcademyMediator.GO_SCENE, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.GO_SCENE, arg_10_1[1], arg_10_1[2])

		return
	end)
	self:bind(NavalAcademyMediator.UPGRADE_FIELD, function(arg_11_0, arg_11_1)
		self:sendNotification(GAME.SHOPPING, {
			count = 1,
			id = arg_11_1
		})

		return
	end)
	self:bind(NavalAcademyMediator.ON_OPEN_CLASSROOM, function(arg_12_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.CLASS)

		return
	end)
	self:bind(NavalAcademyMediator.ON_OPEN_COMMANDER, function(arg_13_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			fleetType = CommanderCatScene.FLEET_TYPE_COMMON
		})

		return
	end)
	self:bind(NavalAcademyMediator.ON_OPEN_COLLECTION, function(arg_14_0)
		self:addSubLayers(Context.New({
			mediator = TrophyGalleryMediator,
			viewComponent = TrophyGalleryLayer
		}))

		return
	end)
	self:bind(NavalAcademyMediator.ON_OPEN_GOLDRESFIELD, function(arg_15_0)
		self.viewComponent:OpenGoldResField()

		return
	end)
	self:bind(NavalAcademyMediator.ON_OPEN_OILRESFIELD, function(arg_16_0)
		self.viewComponent:OpenOilResField()

		return
	end)
	self:bind(NavalAcademyMediator.ON_OPEN_SUPPLYSHOP, function(arg_17_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_SHOP_STREET
		})

		return
	end)
	self:bind(NavalAcademyMediator.ON_OPEN_TACTICROOM, function(arg_18_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS, {
			shipToLesson = self.contextData.shipToLesson
		})

		self.contextData.shipToLesson = nil

		return
	end)
	self:bind(NavalAcademyMediator.ON_OPEN_MINIGAMEHALL, function(arg_19_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.GAME_HALL)

		return
	end)

	local var_1_0 = getProxy(NavalAcademyProxy)

	self.viewComponent:SetOilResField(var_1_0:GetOilVO())
	self.viewComponent:SetGoldResField(var_1_0:GetGoldVO())
	self.viewComponent:SetClassResField(var_1_0:GetClassVO())
	self.viewComponent:SetPlayer((getProxy(PlayerProxy):getData()))

	return
end

function NavalAcademyMediator:listNotificationInterests()
	return {
		GAME.LOAD_LAYERS,
		GAME.REMOVE_LAYERS,
		GAME.HARVEST_RES_DONE,
		PlayerProxy.UPDATED,
		NavalAcademyProxy.RESOURCE_UPGRADE,
		NavalAcademyProxy.RESOURCE_UPGRADE_DONE,
		CollectionProxy.TROPHY_UPDATE,
		GAME.BEGIN_STAGE_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		GAME.HARVEST_CLASS_RES_DONE
	}
end

function NavalAcademyMediator:handleNotification(arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == GAME.LOAD_LAYERS then
		self.viewComponent:OnAddLayer()
	elseif var_21_0 == GAME.REMOVE_LAYERS then
		self.viewComponent:OnRemoveLayer(var_21_1)
	elseif var_21_0 == GAME.HARVEST_RES_DONE then
		self.viewComponent:OnGetRes(var_21_1.type, var_21_1.outPut)
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_levelMediator_ok_takeResource"))
	elseif var_21_0 == PlayerProxy.UPDATED then
		self.viewComponent:UpdatePlayer(var_21_1)
	elseif var_21_0 == NavalAcademyProxy.RESOURCE_UPGRADE then
		self.viewComponent:UpdatePlayer(getProxy(PlayerProxy):getData())
		self.viewComponent:OnStartUpgradeResField(var_21_1.resVO)
	elseif var_21_0 == NavalAcademyProxy.RESOURCE_UPGRADE_DONE then
		local var_21_2 = var_21_1.field

		if isa(var_21_1.field, GoldResourceField) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_upgrade_complete", pg.navalacademy_data_template[3].name, var_21_1.value))
		elseif isa(var_21_2, OilResourceField) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_upgrade_complete", pg.navalacademy_data_template[4].name, var_21_1.value))
		elseif isa(var_21_2, ClassResourceField) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_class_upgrade_complete", pg.navalacademy_data_template[1].name, var_21_1.value, var_21_1.rate, var_21_1.exp))
		end

		self.viewComponent:OnResFieldLevelUp(var_21_2)
	elseif var_21_0 == CollectionProxy.TROPHY_UPDATE then
		self.viewComponent:OnCollectionUpdate()
	elseif var_21_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_21_1)
	elseif var_21_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		self.viewComponent:RefreshChars()
	elseif var_21_0 == GAME.HARVEST_CLASS_RES_DONE then
		self.viewComponent:OnGetRes(3, var_21_1.value)
	end

	return
end

return NavalAcademyMediator
