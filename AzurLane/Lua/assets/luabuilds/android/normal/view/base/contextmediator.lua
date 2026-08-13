class = var_0_10000

local var_0_0 = "ContextMediator"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.Mediator)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0:initNotificationHandleDic()
	var_0_1.super.Ctor(arg_1_0, nil, arg_1_1)

	return
end

function var_0_1.initNotificationHandleDic(arg_2_0)
	arg_2_0.handleDic, arg_2_0.handleElse = nil

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	if arg_3_0.handleDic then
		underscore = var_1

		return var_1.keys(arg_3_0.handleDic)
	else
		return var_0_1.super.listNotificationInterests(arg_3_0)
	end

	return
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	if arg_4_0.handleDic then
		switch = var_2

		var_2(arg_4_1:getName(), arg_4_0.handleDic, arg_4_0.handleElse, arg_4_0, arg_4_1)
	else
		var_0_1.super.handleNotification(arg_4_0, arg_4_1)
	end

	return
end

function var_0_1.onRegister(arg_5_0)
	arg_5_0.event = {}

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bind

	BaseUI = var_1_10003

	var_5_1(var_5_0, var_1_10003.ON_BACK_PRESSED, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0

		var_2.onBackPressed(var_6_0, arg_6_1)

		return
	end)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.bind

	BaseUI = var_3

	var_5_3(var_5_2, var_3.AVALIBLE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.onUIAvalible(var_7_0)

		return
	end)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.bind

	BaseUI = var_3

	var_5_5(var_5_4, var_3.ON_BACK, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_2 and 0 < arg_8_2 then
			pg = var_3

			local var_8_0 = var_3.UIMgr.GetInstance()

			var_3.LoadingOn(var_8_0, false)

			LeanTween = var_3

			local var_8_1 = var_3.delayedCall
			local var_8_2 = arg_8_2

			System = var_2_10005

			var_8_1(var_8_2, var_2_10005.Action(function()
				pg = var_3_10000

				local var_9_0 = var_3_10000.UIMgr.GetInstance()

				var_0.LoadingOff(var_9_0)

				local var_9_1 = arg_5_0
				local var_9_2 = var_0.sendNotification

				GAME = var_3_10002

				var_9_2(var_9_1, var_3_10002.GO_BACK, nil, arg_8_1)

				return
			end))
		else
			local var_8_3 = arg_5_0
			local var_8_4 = var_3.sendNotification

			GAME = var_2_10005

			var_8_4(var_8_3, var_2_10005.GO_BACK, nil, arg_8_1)
		end

		return
	end)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bind

	BaseUI = var_3

	var_5_7(var_5_6, var_3.ON_RETURN, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_5_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10004

		var_10_1(var_10_0, var_2_10004.GO_BACK, arg_10_1)

		return
	end)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.bind

	BaseUI = var_3

	var_5_9(var_5_8, var_3.ON_HOME, function(arg_11_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10002

		local var_11_0 = var_2_10001(var_2_10002)
		local var_11_1 = var_1.getCurrentContext(var_11_0).mediator

		NewMainMediator = var_2_10004

		if var_11_1 == var_2_10004 then
			for iter_11_0 = #var_2.children, 1, -1 do
				var_2_10007 = var_2.children[iter_11_0]

				local var_11_2 = arg_5_0
				local var_11_3 = var_8.sendNotification

				GAME = var_2_10010

				var_11_3(var_11_2, var_2_10010.REMOVE_LAYERS, {
					context = var_2_10007
				})
			end

			return
		end

		if var_2:retriveLastChild() and var_3 ~= var_2 then
			local var_11_4 = arg_5_0
			local var_11_5 = var_4.sendNotification

			GAME = iter_11_0

			var_11_5(var_11_4, iter_11_0.REMOVE_LAYERS, {
				onHome = true,
				context = var_3
			})
		end

		local var_11_6 = arg_5_0
		local var_11_7 = var_4.sendNotification

		GAME = iter_11_0

		local var_11_8 = iter_11_0.GO_SCENE

		SCENE = var_2_10007

		var_11_7(var_11_6, var_11_8, var_2_10007.MAINUI)

		return
	end)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.bind

	BaseUI = var_3

	var_5_11(var_5_10, var_3.ON_CLOSE, function(arg_12_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10002

		local var_12_0 = var_2_10001(var_2_10002)
		local var_12_1 = var_1.getCurrentContext(var_12_0)

		if var_2.getContextByMediator(var_12_1, arg_5_0.class) then
			local var_12_2 = arg_5_0
			local var_12_3 = var_4.sendNotification

			GAME = var_2_10006

			var_12_3(var_12_2, var_2_10006.REMOVE_LAYERS, {
				context = var_3
			})
		end

		return
	end)

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.bind

	BaseUI = var_3

	var_5_13(var_5_12, var_3.ON_AWARD, function(arg_13_0, arg_13_1)
		local var_13_0 = {}

		_ = var_2_10003

		if var_2_10003.all(arg_13_1.items, function(arg_14_0)
			local var_14_0 = arg_14_0.type

			DROP_TYPE_ICON_FRAME = var_3_10002

			local var_14_3

			if var_14_0 ~= var_3_10002 then
				local var_14_1 = arg_14_0.type

				DROP_TYPE_CHAT_FRAME = var_3_10002

				if var_14_1 ~= var_3_10002 then
					local var_14_2 = arg_14_0.type

					DROP_TYPE_LIVINGAREA_COVER = var_3_10002

					if var_14_2 ~= var_3_10002 then
						var_14_3 = false

						goto label_14_0
					end
				end
			end

			var_14_3 = true

			::label_14_0::

			return var_14_3
		end) then
			table = var_3

			var_3.insert(var_13_0, function(arg_15_0)
				onNextTick = var_3_10001

				var_3_10001(arg_15_0)

				return
			end)
		else
			table = var_3

			var_3.insert(var_13_0, function(arg_16_0)
				local var_16_0 = arg_5_0
				local var_16_1 = var_1.addSubLayers

				Context = var_3_10003

				local var_16_2 = var_3_10003.New
				local var_16_3 = {}

				AwardInfoMediator = var_3_10005
				var_16_3.mediator = var_3_10005
				AwardInfoLayer = var_3_10005
				var_16_3.viewComponent = var_3_10005
				setmetatable = var_3_10005
				var_16_3.data = var_3_10005({
					removeFunc = arg_16_0,
					auto = arg_13_1.auto
				}, {
					__index = arg_13_1
				})

				var_16_1(var_16_0, var_16_2(var_16_3))

				return
			end)
		end

		seriesAsync = var_3

		var_3(var_13_0, arg_13_1.removeFunc)

		return
	end)

	local function var_5_14(arg_17_0, arg_17_1)
		getProxy = var_2_10002
		BayProxy = var_2_10003

		local var_17_0 = var_2_10002(var_2_10003)
		local var_17_1 = var_2.getNewShip(var_17_0, true)
		local var_17_2 = {}

		pairs = var_5

		for iter_17_0, iter_17_1 in var_5(var_17_1) do
			if iter_17_1:isMetaShip() then
				table = var_10

				var_10.insert(var_17_2, iter_17_1.configId)
			end
		end

		local var_17_3 = #var_17_1

		underscore = var_6

		var_6.each(arg_17_0, function(arg_18_0)
			local var_18_0 = arg_18_0.type

			DROP_TYPE_OPERATION = var_3_10002

			if var_18_0 == var_3_10002 then
				table = var_18_0

				local var_18_1 = var_18_0.insert

				var_3_10002 = var_17_1

				local var_18_2 = var_0

				var_18_1(var_3_10002, var_3.getShipById(var_18_2, arg_18_0.count))
			else
				local var_18_3 = arg_18_0.type

				DROP_TYPE_VITEM = var_3_10002

				if var_18_3 == var_3_10002 then
					var_3_10002 = arg_18_0

					if arg_18_0.getConfig(var_3_10002, "virtual_type") == 17 then
						getProxy = var_1
						ActivityProxy = var_3_10002
						var_3_10002 = var_1(var_3_10002)

						local var_18_4 = var_1.getActivityById(var_3_10002, arg_18_0:getConfig("link_id"))

						table = var_3_10002
						var_3_10002 = var_3_10002.insert

						local var_18_5 = var_17_1

						var_3_10005 = var_0

						var_3_10002(var_18_5, var_4.getShipById(var_3_10005, var_18_4.data2))

						goto label_18_0
					end
				end

				local var_18_6 = arg_18_0.type

				DROP_TYPE_SHIP = var_3_10002

				if var_18_6 == var_3_10002 then
					local var_18_7

					if not arg_18_0.configId then
						var_18_7 = arg_18_0.id
					end

					Ship = var_3_10002

					if var_3_10002.isMetaShipByConfigID(var_18_7) then
						table = var_2

						if var_2.indexof(var_17_2, var_18_7) then
							table = var_3

							var_3.remove(var_17_2, var_2)

							var_17_3 = var_17_3 - 1
						else
							Ship = var_3

							local var_18_8 = var_3.New({
								configId = var_18_7
							})

							getProxy = var_4
							BayProxy = var_3_10005

							local var_18_9 = var_4(var_3_10005)

							if var_4.getMetaTransItemMap(var_18_9, var_18_8.configId) then
								var_18_8:setReMetaSpecialItemVO(var_4)
							end

							table = var_18_9

							var_18_9.insert(var_17_1, var_18_8)
						end
					else
						var_17_3 = var_17_3 - 1
					end
				end
			end

			::label_18_0::

			return
		end)

		underscore = var_6
		var_17_1 = var_6.rest(var_17_1, var_17_3 + 1)
		pg = var_6

		if var_6.gameset.award_ship_limit then
			pg = var_6

			local var_17_4

			if not var_6.gameset.award_ship_limit.key_value then
				var_17_4 = 20
			end

			if #var_17_1 <= var_17_4 then
				ipairs = var_7

				for iter_17_2, iter_17_3 in var_7(var_17_1) do
					table = var_2_10012

					var_2_10012.insert(arg_17_1, function(arg_19_0)
						local var_19_0 = arg_5_0
						local var_19_1 = var_1.addSubLayers

						Context = var_3_10003

						local var_19_2 = var_3_10003.New
						local var_19_3 = {}

						NewShipMediator = var_3_10005
						var_19_3.mediator = var_3_10005
						NewShipLayer = var_3_10005
						var_19_3.viewComponent = var_3_10005
						var_19_3.data = {
							ship = iter_17_3
						}
						var_19_3.onRemoved = arg_19_0

						var_19_1(var_19_0, var_19_2(var_19_3))

						return
					end)
				end
			end

			return
		end
	end

	local function var_5_15(arg_20_0, arg_20_1)
		ipairs = var_2_10002

		for iter_20_0, iter_20_1 in var_2_10002(arg_20_0) do
			local var_20_0 = iter_20_1.type

			DROP_TYPE_SKIN = var_2_10008

			if var_20_0 == var_2_10008 then
				pg = var_20_0

				local var_20_1 = var_20_0.ship_skin_template[iter_20_1.id].skin_type

				ShipSkin = var_2_10008

				if var_20_1 ~= var_2_10008.SKIN_TYPE_REMAKE then
					table = var_20_1

					var_20_1.insert(arg_20_1, function(arg_21_0)
						local var_21_0 = arg_5_0
						local var_21_1 = var_1.addSubLayers

						Context = var_3_10003

						local var_21_2 = var_3_10003.New
						local var_21_3 = {}

						NewSkinMediator = var_3_10005
						var_21_3.mediator = var_3_10005
						NewSkinLayer = var_3_10005
						var_21_3.viewComponent = var_3_10005
						var_21_3.data = {
							skinId = iter_20_1.id
						}
						var_21_3.onRemoved = arg_21_0

						var_21_1(var_21_0, var_21_2(var_21_3))

						return
					end)
				end
			end

			local var_20_2 = iter_20_1.type

			DROP_TYPE_SKIN_TIMELIMIT = var_2_10008

			if var_20_2 == var_2_10008 then
				local var_20_3 = iter_20_1.count

				if 0 < var_20_3 then
					getProxy = var_20_3
					ShipSkinProxy = var_2_10008
					var_2_10008 = var_20_3(var_2_10008)

					if not var_20_3.hasNonLimitSkin(var_2_10008, iter_20_1.id) then
						table = var_20_3

						var_20_3.insert(arg_20_1, function(arg_22_0)
							local var_22_0 = arg_5_0
							local var_22_1 = var_1.addSubLayers

							Context = var_3_10003

							local var_22_2 = var_3_10003.New
							local var_22_3 = {}

							NewSkinMediator = var_3_10005
							var_22_3.mediator = var_3_10005
							NewSkinLayer = var_3_10005
							var_22_3.viewComponent = var_3_10005
							var_22_3.data = {
								timeLimit = true,
								skinId = iter_20_1.id
							}
							var_22_3.onRemoved = arg_22_0

							var_22_1(var_22_0, var_22_2(var_22_3))

							return
						end)

						goto label_20_0
					end
				end

				table = var_20_3

				var_20_3.insert(arg_20_1, function(arg_23_0)
					pg = var_3_10001

					local var_23_0 = var_3_10001.TipsMgr.GetInstance()
					local var_23_1 = var_1.ShowTips

					i18n = var_3_10003

					var_23_1(var_23_0, var_3_10003("already_have_the_skin"))
					arg_23_0()

					return
				end)
			end

			::label_20_0::
		end

		return
	end

	local function var_5_16(arg_24_0, arg_24_1)
		local var_24_0 = 0

		ipairs = var_2_10003

		for iter_24_0, iter_24_1 in var_2_10003(arg_24_0) do
			local var_24_1 = iter_24_1.type

			DROP_TYPE_COMMANDER_CAT = var_2_10009

			if var_24_1 == var_2_10009 then
				var_24_0 = var_24_0 + 1
			end
		end

		if var_24_0 == 0 then
			return
		end

		getProxy = var_3
		CommanderProxy = var_4

		local var_24_2 = var_3(var_4)
		local var_24_3 = var_3.GetNewestCommander(var_24_2, var_24_0)

		ipairs = var_24_2

		for iter_24_2, iter_24_3 in var_24_2(var_24_3) do
			table = var_2_10009

			var_2_10009.insert(arg_24_1, function(arg_25_0)
				local var_25_0 = arg_5_0
				local var_25_1 = var_1.addSubLayers

				Context = var_3_10003

				local var_25_2 = var_3_10003.New
				local var_25_3 = {}

				NewCommanderScene = var_3_10005
				var_25_3.viewComponent = var_3_10005
				NewCommanderMediator = var_3_10005
				var_25_3.mediator = var_3_10005
				var_25_3.data = {
					commander = iter_24_3,
					onExit = arg_25_0
				}

				var_25_1(var_25_0, var_25_2(var_25_3))

				return
			end)
		end

		return
	end

	local var_5_17 = arg_5_0
	local var_5_18 = arg_5_0.bind

	BaseUI = var_1_10006

	var_5_18(var_5_17, var_1_10006.ON_ACHIEVE, function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = {}

		if #arg_26_1 > 0 then
			table = var_4

			var_4.insert(var_26_0, function(arg_27_0)
				local var_27_0 = arg_5_0.viewComponent
				local var_27_1 = var_1.emit

				BaseUI = var_3_10003

				var_27_1(var_27_0, var_3_10003.ON_AWARD, {
					items = arg_26_1,
					removeFunc = arg_27_0
				})

				return
			end)

			table = var_4

			var_4.insert(var_26_0, function(arg_28_0)
				var_5_14(arg_26_1, var_26_0)
				var_5_15(arg_26_1, var_26_0)
				var_5_16(arg_26_1, var_26_0)
				arg_28_0()

				return
			end)
		end

		seriesAsyncExtend = var_4

		var_4(var_26_0, arg_26_2)

		return
	end)

	local var_5_19 = arg_5_0
	local var_5_20 = arg_5_0.bind

	BaseUI = var_6

	var_5_20(var_5_19, var_6.ON_ACHIEVE_AUTO, function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		local var_29_0 = {}

		if #arg_29_1 > 0 then
			table = var_5

			var_5.insert(var_29_0, function(arg_30_0)
				local var_30_0 = arg_5_0.viewComponent
				local var_30_1 = var_1.emit

				BaseUI = var_3_10003

				local var_30_2 = var_3_10003.ON_AWARD
				local var_30_3 = {
					items = arg_29_1,
					removeFunc = arg_30_0
				}
				local var_30_4

				if not arg_29_2 then
					var_30_4 = 2
				end

				var_30_3.auto = var_30_4

				var_30_1(var_30_0, var_30_2, var_30_3)

				return
			end)

			table = var_5

			var_5.insert(var_29_0, function(arg_31_0)
				var_5_14(arg_29_1, var_29_0)
				var_5_15(arg_29_1, var_29_0)
				var_5_16(arg_29_1, var_29_0)
				arg_31_0()

				return
			end)
		end

		seriesAsyncExtend = var_5

		var_5(var_29_0, arg_29_3)

		return
	end)

	local var_5_21 = arg_5_0
	local var_5_22 = arg_5_0.bind

	BaseUI = var_6

	var_5_22(var_5_21, var_6.ON_WORLD_ACHIEVE, function(arg_32_0, arg_32_1)
		local var_32_0 = {}

		if #arg_32_1.items > 0 then
			table = var_4

			var_4.insert(var_32_0, function(arg_33_0)
				local var_33_0 = arg_5_0.viewComponent
				local var_33_1 = var_1.emit

				BaseUI = var_3_10003

				local var_33_2 = var_3_10003.ON_AWARD

				setmetatable = var_3_10004

				var_33_1(var_33_0, var_33_2, var_3_10004({
					removeFunc = arg_33_0
				}, {
					__index = arg_32_1
				}))

				return
			end)

			table = var_4

			var_4.insert(var_32_0, function(arg_34_0)
				var_5_14(var_0, var_32_0)
				var_5_15(var_0, var_32_0)
				var_5_16(var_0, var_32_0)
				arg_34_0()

				return
			end)
		end

		seriesAsyncExtend = var_4

		var_4(var_32_0, arg_32_1.removeFunc)

		return
	end)

	local var_5_23 = arg_5_0
	local var_5_24 = arg_5_0.bind

	BaseUI = var_6

	var_5_24(var_5_23, var_6.ON_SHIP_EXP, function(arg_35_0, arg_35_1, arg_35_2)
		local var_35_0 = arg_5_0
		local var_35_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_35_2 = var_2_10005.New
		local var_35_3 = {}

		ShipExpMediator = var_2_10007
		var_35_3.mediator = var_2_10007
		ShipExpLayer = var_2_10007
		var_35_3.viewComponent = var_2_10007
		var_35_3.data = arg_35_1
		var_35_3.onRemoved = arg_35_2

		var_35_1(var_35_0, var_35_2(var_35_3))

		return
	end)

	local var_5_25 = arg_5_0
	local var_5_26 = arg_5_0.bind

	BaseUI = var_6

	var_5_26(var_5_25, var_6.ON_SPWEAPON, function(arg_36_0, arg_36_1)
		defaultValue = var_2_10002

		local var_36_0 = arg_36_1.type

		SpWeaponInfoLayer = var_2_10004
		arg_36_1.type = var_2_10002(var_36_0, var_2_10004.TYPE_DEFAULT)

		local var_36_1 = arg_5_0
		local var_36_2 = var_2.addSubLayers

		Context = var_4

		local var_36_3 = var_4.New
		local var_36_4 = {}

		SpWeaponInfoMediator = var_2_10006
		var_36_4.mediator = var_2_10006
		SpWeaponInfoLayer = var_2_10006
		var_36_4.viewComponent = var_2_10006
		var_36_4.data = arg_36_1

		local var_36_5

		if not arg_36_1 or not arg_36_1.onRemoved then
			var_36_5 = nil
		end

		var_36_4.onRemoved = var_36_5

		var_36_2(var_36_1, var_36_3(var_36_4))

		return
	end)

	local var_5_27 = arg_5_0
	local var_5_28 = arg_5_0.bind

	BaseUI = var_6

	var_5_28(var_5_27, var_6.ON_ADD_SUBLAYER, function(arg_37_0, arg_37_1)
		local var_37_0 = arg_5_0

		var_2.addSubLayers(var_37_0, arg_37_1)

		return
	end)
	arg_5_0:commonBind()
	arg_5_0:register()

	return
end

function var_0_1.commonBind(arg_38_0)
	local var_38_0 = var_0_1
	local var_38_1

	if not var_0_1.CommonBindDic then
		var_38_1 = {}
		BaseUI = var_1_10003
		var_38_1[var_1_10003.ON_DROP] = function(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
			local var_39_0 = arg_39_2.type

			DROP_TYPE_EQUIP = var_2_10005

			if var_39_0 == var_2_10005 then
				var_2_10005 = arg_39_0

				local var_39_1 = arg_39_0.addSubLayers

				Context = var_2_10006
				var_2_10006 = var_2_10006.New
				var_2_10007 = {}
				EquipmentInfoMediator = var_2_10008
				var_2_10007.mediator = var_2_10008
				EquipmentInfoLayer = var_2_10008
				var_2_10007.viewComponent = var_2_10008
				var_2_10008 = {
					equipmentId = arg_39_2:getConfig("id")
				}
				EquipmentInfoMediator = var_9
				var_2_10008.type = var_9.TYPE_DISPLAY
				var_2_10008.onRemoved = arg_39_3
				var_2_10007.data = var_2_10008

				var_39_1(var_2_10005, var_2_10006(var_2_10007))
			else
				local var_39_2 = arg_39_2.type

				DROP_TYPE_SPWEAPON = var_2_10005

				if var_39_2 == var_2_10005 then
					var_2_10005 = arg_39_0

					local var_39_3 = arg_39_0.addSubLayers

					Context = var_2_10006
					var_2_10006 = var_2_10006.New
					var_2_10007 = {}
					SpWeaponInfoMediator = var_2_10008
					var_2_10007.mediator = var_2_10008
					SpWeaponInfoLayer = var_2_10008
					var_2_10007.viewComponent = var_2_10008
					var_2_10008 = {
						spWeaponConfigId = arg_39_2:getConfig("id")
					}
					SpWeaponInfoLayer = var_9
					var_2_10008.type = var_9.TYPE_DISPLAY
					var_2_10008.onRemoved = arg_39_3
					var_2_10007.data = var_2_10008

					var_39_3(var_2_10005, var_2_10006(var_2_10007))
				else
					local var_39_4 = arg_39_2.type

					DROP_TYPE_EQUIPMENT_SKIN = var_2_10005

					if var_39_4 == var_2_10005 then
						var_2_10005 = arg_39_0

						local var_39_5 = arg_39_0.addSubLayers

						Context = var_2_10006
						var_2_10006 = var_2_10006.New
						var_2_10007 = {}
						EquipmentSkinMediator = var_2_10008
						var_2_10007.mediator = var_2_10008
						EquipmentSkinLayer = var_2_10008
						var_2_10007.viewComponent = var_2_10008
						var_2_10008 = {
							skinId = arg_39_2:getConfig("id")
						}
						EquipmentSkinLayer = var_9
						var_2_10008.mode = var_9.DISPLAY
						var_2_10007.data = var_2_10008

						var_39_5(var_2_10005, var_2_10006(var_2_10007))
					else
						local var_39_6 = arg_39_2.type

						DROP_TYPE_EMOJI = var_2_10005

						if var_39_6 == var_2_10005 then
							var_2_10005 = arg_39_0

							local var_39_7 = arg_39_0.addSubLayers

							Context = var_2_10006
							var_2_10006 = var_2_10006.New
							var_2_10007 = {}
							ContextMediator = var_2_10008
							var_2_10007.mediator = var_2_10008
							EmojiInfoLayer = var_2_10008
							var_2_10007.viewComponent = var_2_10008
							var_2_10007.data = {
								id = arg_39_2.cfg.id
							}

							var_39_7(var_2_10005, var_2_10006(var_2_10007))
						else
							local var_39_8 = arg_39_2.type

							DROP_TYPE_COMBAT_UI_STYLE = var_2_10005

							if var_39_8 == var_2_10005 and not arg_39_2.notPlay then
								local var_39_9 = arg_39_0

								var_39_8 = arg_39_0.addSubLayers
								Context = var_2_10006

								local var_39_10 = var_2_10006.New

								var_2_10007 = {}
								CombatSkinInfoMediator = var_2_10008
								var_2_10007.mediator = var_2_10008
								CombatSkinInfoLayer = var_2_10008
								var_2_10007.viewComponent = var_2_10008
								var_2_10007.data = {
									skinID = arg_39_2:getConfig("id")
								}

								var_39_8(var_39_9, var_39_10(var_2_10007))
							else
								pg = var_39_8

								local var_39_11 = var_39_8.MsgboxMgr.GetInstance()
								local var_39_12 = var_4.ShowMsgBox
								local var_39_13 = {}

								MSGBOX_TYPE_SINGLE_ITEM = var_2_10007
								var_39_13.type = var_2_10007
								var_39_13.drop = arg_39_2
								var_39_13.onNo = arg_39_3
								var_39_13.onYes = arg_39_3

								var_39_12(var_39_11, var_39_13)
							end
						end
					end
				end
			end

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_DROP_LIST] = function(arg_40_0, arg_40_1, arg_40_2)
			pg = var_2_10003

			local var_40_0 = var_2_10003.MsgboxMgr.GetInstance()
			local var_40_1 = var_3.ShowMsgBox
			local var_40_2 = {
				hideNo = true
			}

			MSGBOX_TYPE_ITEM_BOX = var_2_10006
			var_40_2.type = var_2_10006
			var_40_2.items = arg_40_2.itemList
			var_40_2.content = arg_40_2.content
			var_40_2.item2Row = arg_40_2.item2Row

			function var_40_2.itemFunc(arg_41_0)
				local var_41_0 = arg_40_0.viewComponent
				local var_41_1 = var_1.emit

				BaseUI = var_3_10003

				var_41_1(var_41_0, var_3_10003.ON_DROP, arg_41_0, function()
					local var_42_0 = arg_40_0.viewComponent
					local var_42_1 = var_0.emit

					BaseUI = var_4_10002

					var_42_1(var_42_0, var_4_10002.ON_DROP_LIST, arg_40_2)

					return
				end)

				return
			end

			var_40_1(var_40_0, var_40_2)

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_DROP_LIST_OWN] = function(arg_43_0, arg_43_1, arg_43_2)
			pg = var_2_10003

			local var_43_0 = var_2_10003.MsgboxMgr.GetInstance()
			local var_43_1 = var_3.ShowMsgBox
			local var_43_2 = {
				hideNo = true
			}

			MSGBOX_TYPE_DROP_ITEM_ESKIN = var_2_10006
			var_43_2.type = var_2_10006
			var_43_2.items = arg_43_2.itemList
			var_43_2.content = arg_43_2.content
			var_43_2.item2Row = arg_43_2.item2Row

			function var_43_2.itemFunc(arg_44_0)
				local var_44_0 = arg_43_0.viewComponent
				local var_44_1 = var_1.emit

				BaseUI = var_3_10003

				var_44_1(var_44_0, var_3_10003.ON_DROP, arg_44_0, function()
					local var_45_0 = arg_43_0.viewComponent
					local var_45_1 = var_0.emit

					BaseUI = var_4_10002

					var_45_1(var_45_0, var_4_10002.ON_DROP_LIST, arg_43_2)

					return
				end)

				return
			end

			var_43_1(var_43_0, var_43_2)

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_ITEM] = function(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
			local var_46_0 = arg_46_0
			local var_46_1 = arg_46_0.addSubLayers

			Context = var_2_10006

			local var_46_2 = var_2_10006.New
			local var_46_3 = {}

			ItemInfoMediator = var_2_10008
			var_46_3.mediator = var_2_10008
			ItemInfoLayer = var_2_10008
			var_46_3.viewComponent = var_2_10008

			local var_46_4 = {}

			Drop = var_2_10009

			local var_46_5 = var_2_10009.New
			local var_46_6 = {}

			DROP_TYPE_ITEM = var_2_10011
			var_46_6.type = var_2_10011
			var_46_6.id = arg_46_2
			var_46_4.drop = var_46_5(var_46_6)
			var_46_4.confirmCall = arg_46_3
			var_46_3.data = var_46_4

			var_46_1(var_46_0, var_46_2(var_46_3))

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_ITEM_EXTRA] = function(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
			local var_47_0 = arg_47_0
			local var_47_1 = arg_47_0.addSubLayers

			Context = var_2_10006

			local var_47_2 = var_2_10006.New
			local var_47_3 = {}

			ItemInfoMediator = var_2_10008
			var_47_3.mediator = var_2_10008
			ItemInfoLayer = var_2_10008
			var_47_3.viewComponent = var_2_10008

			local var_47_4 = {}

			Drop = var_2_10009

			local var_47_5 = var_2_10009.New
			local var_47_6 = {}

			DROP_TYPE_ITEM = var_2_10011
			var_47_6.type = var_2_10011
			var_47_6.id = arg_47_2
			var_47_6.extra = arg_47_3
			var_47_4.drop = var_47_5(var_47_6)
			var_47_3.data = var_47_4

			var_47_1(var_47_0, var_47_2(var_47_3))

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_SHIP] = function(arg_48_0, arg_48_1, arg_48_2)
			local var_48_0 = arg_48_0
			local var_48_1 = arg_48_0.addSubLayers

			Context = var_2_10005

			local var_48_2 = var_2_10005.New
			local var_48_3 = {}

			ItemInfoMediator = var_2_10007
			var_48_3.mediator = var_2_10007
			ItemInfoLayer = var_2_10007
			var_48_3.viewComponent = var_2_10007

			local var_48_4 = {}

			Drop = var_2_10008

			local var_48_5 = var_2_10008.New
			local var_48_6 = {}

			DROP_TYPE_SHIP = var_2_10010
			var_48_6.type = var_2_10010
			var_48_6.id = arg_48_2
			var_48_4.drop = var_48_5(var_48_6)
			var_48_3.data = var_48_4

			var_48_1(var_48_0, var_48_2(var_48_3))

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_EQUIPMENT] = function(arg_49_0, arg_49_1, arg_49_2)
			defaultValue = var_2_10003

			local var_49_0 = arg_49_2.type

			EquipmentInfoMediator = var_2_10005
			arg_49_2.type = var_2_10003(var_49_0, var_2_10005.TYPE_DEFAULT)

			local var_49_1 = arg_49_0
			local var_49_2 = arg_49_0.addSubLayers

			Context = var_5

			local var_49_3 = var_5.New
			local var_49_4 = {}

			EquipmentInfoMediator = var_2_10007
			var_49_4.mediator = var_2_10007
			EquipmentInfoLayer = var_2_10007
			var_49_4.viewComponent = var_2_10007
			var_49_4.data = arg_49_2

			local var_49_5

			if not arg_49_2 or not arg_49_2.onRemoved then
				var_49_5 = nil
			end

			var_49_4.onRemoved = var_49_5

			var_49_2(var_49_1, var_49_3(var_49_4))

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_NEW_DROP] = function(arg_50_0, arg_50_1, arg_50_2)
			pg = var_2_10003

			local var_50_0 = var_2_10003.NewStyleMsgboxMgr.GetInstance()
			local var_50_1 = var_3.Show

			pg = var_2_10005

			var_50_1(var_50_0, var_2_10005.NewStyleMsgboxMgr.TYPE_DROP, arg_50_2)

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_NEW_STYLE_DROP] = function(arg_51_0, arg_51_1, arg_51_2)
			pg = var_2_10003

			local var_51_0 = var_2_10003.NewStyleMsgboxMgr.TYPE_COMMON_DROP
			local var_51_1 = arg_51_2

			if arg_51_2.useDeepShow then
				pg = var_5

				local var_51_2 = var_5.NewStyleMsgboxMgr.GetInstance()

				var_5.DeepShow(var_51_2, var_51_0, var_51_1)
			else
				pg = var_5

				local var_51_3 = var_5.NewStyleMsgboxMgr.GetInstance()

				var_5.Show(var_51_3, var_51_0, var_51_1)
			end

			return
		end
		BaseUI = var_3
		var_38_1[var_3.ON_NEW_STYLE_ITEMS] = function(arg_52_0, arg_52_1, arg_52_2)
			pg = var_2_10003

			local var_52_0 = var_2_10003.NewStyleMsgboxMgr.TYPE_COMMON_ITEMS

			setmetatable = var_2_10004

			local var_52_1 = arg_52_2
			local var_52_2 = {}
			local var_52_3 = {}
			local var_52_4 = {}
			local var_52_5 = {}

			pg = var_2_10010
			var_52_5.type = var_2_10010.NewStyleMsgboxMgr.BUTTON_TYPE.confirm
			i18n = var_10
			var_52_5.name = var_10("msgbox_text_confirm")
			SFX_CONFIRM = var_10
			var_52_5.sound = var_10
			var_52_4[1] = var_52_5
			var_52_3.btnList = var_52_4
			var_52_3.items = arg_52_2.itemList
			var_52_3.content = arg_52_2.content

			function var_52_3.itemFunc(arg_53_0)
				local var_53_0 = arg_52_0.viewComponent
				local var_53_1 = var_1.emit

				BaseUI = var_3_10003

				var_53_1(var_53_0, var_3_10003.ON_NEW_STYLE_DROP, {
					useDeepShow = true,
					drop = arg_53_0
				})

				return
			end

			var_52_2.__index = var_52_3

			local var_52_6 = var_2_10004(var_52_1, var_52_2)

			if arg_52_2.useDeepShow then
				pg = var_5

				local var_52_7 = var_5.NewStyleMsgboxMgr.GetInstance()

				var_5.DeepShow(var_52_7, var_52_0, var_52_6)
			else
				pg = var_5

				local var_52_8 = var_5.NewStyleMsgboxMgr.GetInstance()

				var_5.Show(var_52_8, var_52_0, var_52_6)
			end

			return
		end
	end

	var_38_0.CommonBindDic = var_38_1
	pairs = var_38_0

	for iter_38_0, iter_38_1 in var_38_0(var_0_1.CommonBindDic) do
		arg_38_0:bind(iter_38_0, function(...)
			return iter_38_1(arg_38_0, ...)
		end)
	end

	return
end

function var_0_1.register(arg_55_0)
	return
end

function var_0_1.onUIAvalible(arg_56_0)
	return
end

function var_0_1.setContextData(arg_57_0, arg_57_1)
	arg_57_0.contextData = arg_57_1

	return
end

function var_0_1.bind(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0.viewComponent.event

	var_3.connect(var_58_0, arg_58_1, arg_58_2)

	table = var_3

	var_3.insert(arg_58_0.event, {
		event = arg_58_1,
		callback = arg_58_2
	})

	return
end

function var_0_1.onRemove(arg_59_0)
	arg_59_0:remove()

	ipairs = var_1

	for iter_59_0, iter_59_1 in var_1(arg_59_0.event) do
		local var_59_0 = arg_59_0.viewComponent.event

		var_6.disconnect(var_59_0, iter_59_1.event, iter_59_1.callback)
	end

	arg_59_0.event = {}

	return
end

function var_0_1.remove(arg_60_0)
	return
end

function var_0_1.addSubLayers(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4)
	assert = var_1_10005
	isa = var_1_10006

	local var_61_0 = arg_61_1

	Context = var_1_10008

	var_1_10005(var_1_10006(var_61_0, var_1_10008), "should be an instance of Context")

	local var_61_1 = arg_61_0:GetContext()

	if arg_61_2 then
		while var_61_1.parent do
			var_61_1 = var_61_1.parent
		end
	end

	local var_61_2 = {
		parentContext = var_61_1,
		context = arg_61_1,
		callback = arg_61_3
	}

	if arg_61_4 then
		table = var_7
		var_61_2 = var_7.merge(var_61_2, arg_61_4) or var_61_2
	end

	local var_61_3 = arg_61_0
	local var_61_4 = arg_61_0.sendNotification

	GAME = var_1_10009

	var_61_4(var_61_3, var_1_10009.LOAD_LAYERS, var_61_2)

	return
end

function var_0_1.GetContext(arg_62_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_62_0 = var_1_10001(var_1_10002)
	local var_62_1 = var_1.getCurrentContext(var_62_0)

	return var_2.getContextByMediator(var_62_1, arg_62_0.class)
end

function var_0_1.blockEvents(arg_63_0)
	if arg_63_0.event then
		ipairs = var_1

		for iter_63_0, iter_63_1 in var_1(arg_63_0.event) do
			local var_63_0 = arg_63_0.viewComponent.event

			var_6.block(var_63_0, iter_63_1.event, iter_63_1.callback)
		end
	end

	return
end

function var_0_1.unblockEvents(arg_64_0)
	if arg_64_0.event then
		ipairs = var_1

		for iter_64_0, iter_64_1 in var_1(arg_64_0.event) do
			local var_64_0 = arg_64_0.viewComponent.event

			var_6.unblock(var_64_0, iter_64_1.event, iter_64_1.callback)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_65_0, arg_65_1)
	pg = var_1_10002

	local var_65_0 = var_1_10002.CriMgr.GetInstance()
	local var_65_1 = var_2.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_65_1(var_65_0, var_1_10004)

	getProxy = var_65_1
	ContextProxy = var_65_0

	local var_65_2 = var_65_1(var_65_0)

	if arg_65_1 then
		local var_65_3 = var_65_2

		if var_65_2.getContextByMediator(var_65_3, arg_65_0.class).parent then
			pg = var_65_3

			local var_65_4 = var_65_3.m02

			if var_4.retrieveMediator(var_65_4, var_3.mediator.__cname) and var_4.viewComponent then
				local var_65_5 = var_4.viewComponent

				var_5.onBackPressed(var_65_5)
			end
		end
	else
		local var_65_6 = arg_65_0.viewComponent

		var_3.closeView(var_65_6)
	end

	return
end

function var_0_1.removeSubLayers(arg_66_0, arg_66_1, arg_66_2)
	assert = var_1_10003
	isa = var_1_10004

	var_1_10003(var_1_10004(arg_66_1, var_0_1), "should be a ContextMediator Class")

	getProxy = var_1_10003
	ContextProxy = var_4

	local var_66_0 = var_1_10003(var_4)
	local var_66_1 = var_3.getContextByMediator
	local var_66_2

	if not arg_66_0.class then
		var_66_2 = arg_66_0
	end

	if not var_66_1(var_66_0, var_66_2) then
		return
	end

	if not var_4:getContextByMediator(arg_66_1) then
		return
	end

	local var_66_3 = arg_66_0
	local var_66_4 = arg_66_0.sendNotification

	GAME = var_1_10008

	var_66_4(var_66_3, var_1_10008.REMOVE_LAYERS, {
		context = var_5,
		callback = arg_66_2
	})

	return
end

return var_0_1
