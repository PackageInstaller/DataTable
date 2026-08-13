class = var_0_10000

local var_0_0 = "ShipProfileMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.CLICK_ROTATE_BTN = "ShipProfileMediator:CLICK_ROTATE_BTN"
var_0_1.OPEN_CRYPTOLALIA = "ShipProfileMediator:OPEN_CRYPTOLALIA"
var_0_1.OPEN_EQUIP_CODE_SHARE = "ShipProfileMediator.OPEN_EQUIP_CODE_SHARE"
var_0_1.OPEN_PAINTING_SHOW = "ShipProfileMediator.OPEN_PAINTING_SHOW"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	CollectionProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	local var_1_1 = var_1_10002(var_1_10003)

	arg_1_0.showTrans = arg_1_0.contextData.showTrans
	arg_1_0.groupId = arg_1_0.contextData.groupId

	local var_1_2 = var_1_0:getShipGroup(arg_1_0.groupId)
	local var_1_3 = arg_1_0.viewComponent

	var_4.setShipGroup(var_1_3, var_1_2)

	local var_1_4 = arg_1_0.viewComponent

	var_4.setShowTrans(var_1_4, arg_1_0.showTrans)

	local var_1_5 = arg_1_0.viewComponent

	var_4.setOwnedSkinList(var_1_5, var_1_1:getSkinList())
	arg_1_0:bind(var_0_1.OPEN_CRYPTOLALIA, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_2_1(var_2_0, var_2_2, var_2_10005.CRYPTOLALIA, {
			groupId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_ROTATE_BTN, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_3_2 = var_2_10006.New
		local var_3_3 = {}

		ShipRotateMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		ShipRotateLayer = var_2_10008
		var_3_3.viewComponent = var_2_10008
		var_3_3.data = {
			shipGroup = arg_3_1,
			showTrans = arg_3_2,
			skin = arg_3_3
		}

		function var_3_3.onRemoved()
			setActive = var_3_10000

			var_3_10000(arg_1_0.viewComponent.blurPanel, true)

			setActive = var_3_10000

			var_3_10000(arg_1_0.viewComponent._tf, true)

			return
		end

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	ShipProfileScene = var_6

	var_1_7(var_1_6, var_6.SHOW_SKILL_INFO, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		SkillInfoMediator = var_2_10007
		var_5_3.mediator = var_2_10007
		SkillInfoLayer = var_2_10007
		var_5_3.viewComponent = var_2_10007
		var_5_3.data = {
			skillOnShip = arg_5_2,
			skillId = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	ShipProfileScene = var_6

	var_1_9(var_1_8, var_6.SHOW_EVALUATION, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_2 then
			pg = var_2_10003

			local var_6_0 = var_2_10003.TipsMgr.GetInstance()
			local var_6_1 = var_3.ShowTips

			i18n = var_2_10005

			var_6_1(var_6_0, var_2_10005("npc_evaluation_tip"))

			return
		end

		local var_6_2 = arg_1_0
		local var_6_3 = var_3.sendNotification

		GAME = var_2_10005

		var_6_3(var_6_2, var_2_10005.FETCH_EVALUATION, arg_6_1)

		return
	end)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.bind

	ShipProfileScene = var_6

	var_1_11(var_1_10, var_6.WEDDING_REVIEW, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0.viewComponent

		var_2.onWeddingReview(var_7_0, true)

		local var_7_1 = arg_1_0
		local var_7_2 = var_2.addSubLayers

		Context = var_4

		local var_7_3 = var_4.New
		local var_7_4 = {}

		ProposeMediator = var_2_10006
		var_7_4.mediator = var_2_10006
		ProposeUI = var_2_10006
		var_7_4.viewComponent = var_2_10006
		var_7_4.data = {
			review = true,
			group = arg_7_1.group,
			skinID = arg_7_1.skinID,
			finishCallback = function()
				local var_8_0 = arg_1_0.viewComponent

				var_0.onWeddingReview(var_8_0, false)

				return
			end
		}

		var_7_2(var_7_1, var_7_3(var_7_4))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EQUIP_CODE_SHARE, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_9_2 = var_2_10004.New
		local var_9_3 = {}

		EquipCodeShareMediator = var_2_10006
		var_9_3.mediator = var_2_10006
		EquipCodeShareLayer = var_2_10006
		var_9_3.viewComponent = var_2_10006
		var_9_3.data = {
			shipGroupId = arg_9_1
		}

		var_9_1(var_9_0, var_9_2(var_9_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_PAINTING_SHOW, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_1_0
		local var_10_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_10_2 = var_2_10005.New
		local var_10_3 = {}

		PaintingShowMediator = var_2_10007
		var_10_3.mediator = var_2_10007
		PaintingShowScene = var_2_10007
		var_10_3.viewComponent = var_2_10007
		var_10_3.data = {
			skinId = arg_10_1,
			callback = arg_10_2
		}

		var_10_1(var_10_0, var_10_2(var_10_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_11_0)
	local var_11_0 = {}

	GAME = var_1_10002
	var_11_0[1] = var_1_10002.FETCH_EVALUATION_DONE
	CollectionProxy = var_2
	var_11_0[2] = var_2.GROUP_INFO_UPDATE
	ShipSkinProxy = var_2
	var_11_0[3] = var_2.SHIP_SKINS_UPDATE

	return var_11_0
end

function var_0_1.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1
	local var_12_2 = arg_12_1.getBody(var_12_1)

	GAME = var_12_1

	local var_12_3

	if var_12_0 == var_12_1.FETCH_EVALUATION_DONE then
		var_1_10005 = arg_12_0
		var_12_3 = arg_12_0.addSubLayers
		Context = var_1_10006
		var_1_10006 = var_1_10006.New

		local var_12_4 = {}

		ShipEvaluationMediator = var_1_10008
		var_12_4.mediator = var_1_10008
		ShipEvaluationLayer = var_1_10008
		var_12_4.viewComponent = var_1_10008
		var_12_4.data = {
			groupId = var_12_2,
			showTrans = arg_12_0.showTrans
		}

		var_12_3(var_1_10005, var_1_10006(var_12_4))
	else
		CollectionProxy = var_12_3

		local var_12_5

		if var_12_0 == var_12_3.GROUP_INFO_UPDATE then
			var_12_5 = var_12_2

			if arg_12_0.groupId == var_12_5 then
				getProxy = var_1_10005
				CollectionProxy = var_1_10006

				local var_12_6 = var_1_10005(var_1_10006)
				local var_12_7 = var_1_10005.getShipGroup(var_12_6, var_12_5)
				local var_12_8 = arg_12_0.viewComponent

				var_7.setShipGroup(var_12_8, var_12_7)

				local var_12_9 = arg_12_0.viewComponent

				var_7.FlushHearts(var_12_9)
			end
		else
			ShipSkinProxy = var_12_5

			if var_12_0 == var_12_5.SHIP_SKINS_UPDATE then
				getProxy = var_4
				ShipSkinProxy = var_1_10005

				local var_12_10 = var_4(var_1_10005)
				local var_12_11 = arg_12_0.viewComponent

				var_5.setOwnedSkinList(var_12_11, var_12_10:getSkinList())
			end
		end
	end

	return
end

return var_0_1
