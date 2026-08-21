local var_0_0 = class("NavalAcademyMediator", import("..base.ContextMediator"))

var_0_0.ON_OPEN_CLASSROOM = "NavalAcademyMediator:ON_OPEN_CLASSROOM"
var_0_0.ON_OPEN_COMMANDER = "NavalAcademyMediator:ON_OPEN_COMMANDER"
var_0_0.ON_OPEN_COLLECTION = "NavalAcademyMediator:ON_OPEN_COLLECTION"
var_0_0.ON_OPEN_OILRESFIELD = "NavalAcademyMediator:ON_OPEN_OILRESFIELD"
var_0_0.ON_OPEN_GOLDRESFIELD = "NavalAcademyMediator:ON_OPEN_GOLDRESFIELD"
var_0_0.ON_OPEN_SUPPLYSHOP = "NavalAcademyMediator:ON_OPEN_SUPPLYSHOP"
var_0_0.ON_OPEN_TACTICROOM = "NavalAcademyMediator:ON_OPEN_TACTICROOM"
var_0_0.ON_OPEN_MINIGAMEHALL = "NavalAcademyMediator:ON_OPEN_MINIGAMEHALL"
var_0_0.UPGRADE_FIELD = "NavalAcademyMediator:UPGRADE_FIELD"
var_0_0.GO_SCENE = "NavalAcademyMediator:GO_SCENE"
var_0_0.OPEN_ACTIVITY_PANEL = "NavalAcademyMediator:OPEN_ACTIVITY_PANEL"
var_0_0.OPEN_ACTIVITY_SHOP = "NavalAcademyMediator:OPEN_ACTIVITY_SHOP"
var_0_0.OPEN_SCROLL = "NavalAcademyMediator:OPEN_SCROLL"
var_0_0.ACTIVITY_OP = "NavalAcademyMediator:ACTIVITY_OP"
var_0_0.TASK_GO = "NavalAcademyMediator:TASK_GO"
var_0_0.GO_TASK_SCENE = "NavalAcademyMediator:GO_TASK_SCENE"
var_0_0.ON_GET_CLASS_RES = "NavalAcademyMediator:ON_GET_CLASS_RES"
var_0_0.ON_GET_RES = "NavalAcademyMediator:ON_GET_RES"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_GET_CLASS_RES, function(arg_2_0)
		arg_1_0:sendNotification(GAME.HARVEST_CLASS_RES)

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_RES, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.HARVEST_RES, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.GO_TASK_SCENE, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.TASK, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.TASK_GO, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.TASK_GO, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_0.ACTIVITY_OP, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SCROLL, function(arg_7_0, arg_7_1)
		assert(false, "问卷系统已废弃")

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ACTIVITY_SHOP, function(arg_8_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ACTIVITY_PANEL, function(arg_9_0, arg_9_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_10_0, arg_10_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_10_1[1], arg_10_1[2])

		return
	end)
	arg_1_0:bind(var_0_0.UPGRADE_FIELD, function(arg_11_0, arg_11_1)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			count = 1,
			id = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_CLASSROOM, function(arg_12_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.CLASS)

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_COMMANDER, function(arg_13_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			fleetType = CommanderCatScene.FLEET_TYPE_COMMON
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_COLLECTION, function(arg_14_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = TrophyGalleryMediator,
			viewComponent = TrophyGalleryLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_GOLDRESFIELD, function(arg_15_0)
		arg_1_0.viewComponent:OpenGoldResField()

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_OILRESFIELD, function(arg_16_0)
		arg_1_0.viewComponent:OpenOilResField()

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_SUPPLYSHOP, function(arg_17_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_SHOP_STREET
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_TACTICROOM, function(arg_18_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS, {
			shipToLesson = arg_1_0.contextData.shipToLesson
		})

		arg_1_0.contextData.shipToLesson = nil

		return
	end)
	arg_1_0:bind(var_0_0.ON_OPEN_MINIGAMEHALL, function(arg_19_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.GAME_HALL)

		return
	end)

	local var_1_0 = getProxy(NavalAcademyProxy)

	arg_1_0.viewComponent:SetOilResField(var_1_0:GetOilVO())
	arg_1_0.viewComponent:SetGoldResField(var_1_0:GetGoldVO())
	arg_1_0.viewComponent:SetClassResField(var_1_0:GetClassVO())
	arg_1_0.viewComponent:SetPlayer((getProxy(PlayerProxy):getData()))

	return
end

function var_0_0.listNotificationInterests(arg_20_0)
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

function var_0_0.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == GAME.LOAD_LAYERS then
		arg_21_0.viewComponent:OnAddLayer()
	elseif var_21_0 == GAME.REMOVE_LAYERS then
		arg_21_0.viewComponent:OnRemoveLayer(var_21_1)
	elseif var_21_0 == GAME.HARVEST_RES_DONE then
		arg_21_0.viewComponent:OnGetRes(var_21_1.type, var_21_1.outPut)
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_levelMediator_ok_takeResource"))
	elseif var_21_0 == PlayerProxy.UPDATED then
		arg_21_0.viewComponent:UpdatePlayer(var_21_1)
	elseif var_21_0 == NavalAcademyProxy.RESOURCE_UPGRADE then
		arg_21_0.viewComponent:UpdatePlayer(getProxy(PlayerProxy):getData())
		arg_21_0.viewComponent:OnStartUpgradeResField(var_21_1.resVO)
	elseif var_21_0 == NavalAcademyProxy.RESOURCE_UPGRADE_DONE then
		local var_21_2 = var_21_1.field

		if isa(var_21_1.field, GoldResourceField) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_upgrade_complete", pg.navalacademy_data_template[3].name, var_21_1.value))
		elseif isa(var_21_2, OilResourceField) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_upgrade_complete", pg.navalacademy_data_template[4].name, var_21_1.value))
		elseif isa(var_21_2, ClassResourceField) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_class_upgrade_complete", pg.navalacademy_data_template[1].name, var_21_1.value, var_21_1.rate, var_21_1.exp))
		end

		arg_21_0.viewComponent:OnResFieldLevelUp(var_21_2)
	elseif var_21_0 == CollectionProxy.TROPHY_UPDATE then
		arg_21_0.viewComponent:OnCollectionUpdate()
	elseif var_21_0 == GAME.BEGIN_STAGE_DONE then
		arg_21_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_21_1)
	elseif var_21_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		arg_21_0.viewComponent:RefreshChars()
	elseif var_21_0 == GAME.HARVEST_CLASS_RES_DONE then
		arg_21_0.viewComponent:OnGetRes(3, var_21_1.value)
	end

	return
end

return var_0_0
