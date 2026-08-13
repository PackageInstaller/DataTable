class = var_0_10000

local var_0_0 = "MetaCharacterMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.OPEN_PT_PREVIEW_LAYER = "MetaCharacterMediator:OPEN_PT_PREVIEW_LAYER"
var_0_1.OPEN_PT_GET_WAY_LAYER = "MetaCharacterMediator:OPEN_PT_GET_WAY_LAYER"
var_0_1.OPEN_INDEX_LAYER = "MetaCharacterMediator:OPEN_INDEX_LAYER"
var_0_1.ON_REPAIR = "MetaCharacterMediator:ON_REPAIR"
var_0_1.ON_ENERGY = "MetaCharacterMediator:ON_ENERGY"
var_0_1.ON_TACTICS = "MetaCharacterMediator:ON_TACTICS"
var_0_1.ON_SYN = "MetaCharacterMediator:ON_SYN"
var_0_1.ON_UNLOCK = "MetaCharacterMediator:ON_UNLOCK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_PT_PREVIEW_LAYER, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		MetaPTAwardPreviewLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		MetaPTAwardPreviewMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		var_2_3.data = {
			metaProgressVO = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_PT_GET_WAY_LAYER, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		MetaPTGetPreviewLayer = var_2_10007
		var_3_3.viewComponent = var_2_10007
		MetaPTGetPreviewMediator = var_2_10007
		var_3_3.mediator = var_2_10007
		var_3_3.data = {}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_INDEX_LAYER, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		CustomIndexLayer = var_2_10008
		var_4_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		var_4_3.data = arg_4_1

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_REPAIR, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.enbalePage

		Context = var_2_10006

		local var_5_2 = var_2_10006.New
		local var_5_3 = {}

		MetaCharacterRepairLayer = var_2_10009
		var_5_3.viewComponent = var_2_10009
		MetaCharacterRepairMediator = var_2_10009
		var_5_3.mediator = var_2_10009

		local var_5_4 = {
			shipID = arg_5_1
		}
		local var_5_5 = arg_1_0.viewComponent

		var_5_4.groupName = var_10.getGroupName(var_5_5)
		var_5_3.data = var_5_4

		function var_5_3.onRemoved()
			local var_6_0 = arg_1_0.viewComponent

			var_0.enterMenuPage(var_6_0, false)

			arg_1_0.viewComponent.curPageIndex = nil

			local var_6_1 = arg_1_0.viewComponent

			var_0.resetToggleList(var_6_1)

			local var_6_2 = arg_1_0.viewComponent

			var_0.refreshBannerTF(var_6_2)

			local var_6_3 = arg_1_0.viewComponent

			var_0.updateRedPoints(var_6_3)

			return
		end

		var_5_1(var_5_0, var_5_2(var_5_3), arg_5_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ENERGY, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0.viewComponent.isMainOpenLayerTag and true or nil

		arg_1_0.viewComponent.isMainOpenLayerTag = nil

		local var_7_1 = arg_1_0
		local var_7_2 = var_4.enbalePage

		Context = var_2_10007

		local var_7_3 = var_2_10007.New
		local var_7_4 = {}

		MetaCharacterEnergyLayer = var_2_10010
		var_7_4.viewComponent = var_2_10010
		MetaCharacterEnergyMediator = var_2_10010
		var_7_4.mediator = var_2_10010

		local var_7_5 = {
			shipID = arg_7_1
		}
		local var_7_6 = arg_1_0.viewComponent

		var_7_5.groupName = var_11.getGroupName(var_7_6)
		var_7_5.isMainOpen = var_7_0
		var_7_4.data = var_7_5

		function var_7_4.onRemoved()
			local var_8_0 = arg_1_0.viewComponent

			var_0.enterMenuPage(var_8_0, false)

			arg_1_0.viewComponent.curPageIndex = nil

			local var_8_1 = arg_1_0.viewComponent

			var_0.resetToggleList(var_8_1)

			local var_8_2 = arg_1_0.viewComponent

			var_0.refreshBannerTF(var_8_2)

			local var_8_3 = arg_1_0.viewComponent

			var_0.updateRedPoints(var_8_3)

			return
		end

		var_7_2(var_7_1, var_7_3(var_7_4), arg_7_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TACTICS, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_1_0.viewComponent.isMainOpenLayerTag and true or nil

		arg_1_0.viewComponent.isMainOpenLayerTag = nil

		local var_9_1 = arg_1_0
		local var_9_2 = var_4.enbalePage

		Context = var_2_10007

		local var_9_3 = var_2_10007.New
		local var_9_4 = {}

		MetaCharacterTacticsLayer = var_2_10010
		var_9_4.viewComponent = var_2_10010
		MetaCharacterTacticsMediator = var_2_10010
		var_9_4.mediator = var_2_10010

		local var_9_5 = {
			shipID = arg_9_1
		}
		local var_9_6 = arg_1_0.viewComponent

		var_9_5.groupName = var_11.getGroupName(var_9_6)
		var_9_5.isMainOpen = var_9_0
		var_9_4.data = var_9_5

		function var_9_4.onRemoved()
			if arg_1_0.contextData.isFromNavalMeta == true then
				local var_10_0 = arg_1_0.viewComponent

				var_0.closeView(var_10_0)

				arg_1_0.contextData.isFromNavalMeta = nil
			else
				local var_10_1 = arg_1_0.viewComponent

				var_0.enterMenuPage(var_10_1, false)

				arg_1_0.viewComponent.curPageIndex = nil

				local var_10_2 = arg_1_0.viewComponent

				var_0.resetToggleList(var_10_2)

				local var_10_3 = arg_1_0.viewComponent

				var_0.updateRedPoints(var_10_3)
			end

			return
		end

		var_9_2(var_9_1, var_9_3(var_9_4), arg_9_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SYN, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_1_0.viewComponent.isMainOpenLayerTag and true or nil

		arg_1_0.viewComponent.isMainOpenLayerTag = nil

		local var_11_1 = arg_1_0
		local var_11_2 = var_4.enbalePage

		Context = var_2_10007

		local var_11_3 = var_2_10007.New
		local var_11_4 = {}

		MetaCharacterSynLayer = var_2_10010
		var_11_4.viewComponent = var_2_10010
		MetaCharacterSynMediator = var_2_10010
		var_11_4.mediator = var_2_10010

		local var_11_5 = {
			shipID = arg_11_1
		}
		local var_11_6 = arg_1_0.viewComponent

		var_11_5.groupName = var_11.getGroupName(var_11_6)
		var_11_5.isMainOpen = var_11_0
		var_11_4.data = var_11_5

		function var_11_4.onRemoved()
			local var_12_0 = arg_1_0.viewComponent

			var_0.enterMenuPage(var_12_0, false)

			arg_1_0.viewComponent.curPageIndex = nil

			local var_12_1 = arg_1_0.viewComponent

			var_0.resetToggleList(var_12_1)

			local var_12_2 = arg_1_0.viewComponent

			var_0.updateRedPoints(var_12_2)

			return
		end

		var_11_2(var_11_1, var_11_3(var_11_4), arg_11_2)

		return
	end)

	return
end

function var_0_1.enbalePage(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		var_1_10005 = arg_13_0

		arg_13_0.addSubLayers(var_1_10005, arg_13_1)
	else
		getProxy = var_1_10003
		ContextProxy = var_1_10005

		local var_13_0 = var_1_10003(var_1_10005)

		if var_3.getContextByMediator(var_13_0, arg_13_1.mediator) then
			local var_13_1 = arg_13_0
			local var_13_2 = arg_13_0.sendNotification

			GAME = var_1_10008

			var_13_2(var_13_1, var_1_10008.REMOVE_LAYERS, {
				context = var_4
			})
		end
	end

	return
end

function var_0_1.listNotificationInterests(arg_14_0)
	local var_14_0 = {}

	GAME = var_1_10002
	var_14_0[1] = var_1_10002.ACT_NEW_PT_DONE
	BayProxy = var_2
	var_14_0[2] = var_2.SHIP_ADDED
	GAME = var_2
	var_14_0[3] = var_2.GET_META_PT_AWARD_DONE

	return var_14_0
end

function var_0_1.handleNotification(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_1.getName(var_15_0)
	local var_15_2 = arg_15_1:getBody()

	BayProxy = var_15_0

	if var_15_1 == var_15_0.SHIP_ADDED then
		local var_15_3 = arg_15_0.viewComponent
		local var_15_4 = var_4.getCurMetaProgressVO(var_15_3)

		var_4.updateDataAfterAddShip(var_15_4)

		if var_4:isPassType() or var_4:isBuildType() then
			local var_15_5 = arg_15_0.viewComponent

			var_5.refreshBannerTF(var_15_5)

			local var_15_6 = arg_15_0.viewComponent

			var_5.updateMain(var_15_6)
		end
	else
		GAME = var_4

		if var_15_1 == var_4.GET_META_PT_AWARD_DONE then
			local function var_15_7()
				if var_15_2.callback then
					var_15_2.callback()
				end

				local var_16_0 = arg_15_0.viewComponent

				var_0.refreshBannerTF(var_16_0)

				local var_16_1 = arg_15_0.viewComponent

				var_0.updateMain(var_16_1, true)

				return
			end

			local var_15_8 = arg_15_0.viewComponent
			local var_15_9 = var_5.emit

			BaseUI = var_1_10008

			var_15_9(var_15_8, var_1_10008.ON_ACHIEVE, var_15_2.awards, var_15_7)
		end
	end

	return
end

return var_0_1
