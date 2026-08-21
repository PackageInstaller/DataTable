local var_0_0 = class("ContextMediator", pm.Mediator)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:initNotificationHandleDic()
	var_0_0.super.Ctor(arg_1_0, nil, arg_1_1)

	return
end

function var_0_0.initNotificationHandleDic(arg_2_0)
	arg_2_0.handleDic, arg_2_0.handleElse = nil

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	if arg_3_0.handleDic then
		return underscore.keys(arg_3_0.handleDic)
	else
		return var_0_0.super.listNotificationInterests(arg_3_0)
	end

	return
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	if arg_4_0.handleDic then
		switch(arg_4_1:getName(), arg_4_0.handleDic, arg_4_0.handleElse, arg_4_0, arg_4_1)
	else
		var_0_0.super.handleNotification(arg_4_0, arg_4_1)
	end

	return
end

function var_0_0.onRegister(arg_5_0)
	arg_5_0.event = {}

	arg_5_0:bind(BaseUI.ON_BACK_PRESSED, function(arg_6_0, arg_6_1)
		arg_5_0:onBackPressed(arg_6_1)

		return
	end)
	arg_5_0:bind(BaseUI.AVALIBLE, function(arg_7_0, arg_7_1)
		arg_5_0:onUIAvalible()

		return
	end)
	arg_5_0:bind(BaseUI.ON_BACK, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_2 and arg_8_2 > 0 then
			pg.UIMgr.GetInstance():LoadingOn(false)
			LeanTween.delayedCall(arg_8_2, System.Action(function()
				pg.UIMgr.GetInstance():LoadingOff()
				arg_5_0:sendNotification(GAME.GO_BACK, nil, arg_8_1)

				return
			end))
		else
			arg_5_0:sendNotification(GAME.GO_BACK, nil, arg_8_1)
		end

		return
	end)
	arg_5_0:bind(BaseUI.ON_RETURN, function(arg_10_0, arg_10_1)
		arg_5_0:sendNotification(GAME.GO_BACK, arg_10_1)

		return
	end)
	arg_5_0:bind(BaseUI.ON_HOME, function(arg_11_0)
		local var_11_0 = getProxy(ContextProxy):getCurrentContext()

		if var_11_0.mediator == NewMainMediator then
			for iter_11_0 = #var_11_0.children, 1, -1 do
				arg_5_0:sendNotification(GAME.REMOVE_LAYERS, {
					context = var_11_0.children[iter_11_0]
				})
			end

			return
		end

		local var_11_1 = var_11_0:retriveLastChild()

		if var_11_1 and var_11_1 ~= var_11_0 then
			arg_5_0:sendNotification(GAME.REMOVE_LAYERS, {
				onHome = true,
				context = var_11_1
			})
		end

		arg_5_0:sendNotification(GAME.GO_SCENE, SCENE.MAINUI)

		return
	end)
	arg_5_0:bind(BaseUI.ON_CLOSE, function(arg_12_0)
		local var_12_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_5_0.class)

		if var_12_0 then
			arg_5_0:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_12_0
			})
		end

		return
	end)
	arg_5_0:bind(BaseUI.ON_AWARD, function(arg_13_0, arg_13_1)
		if _.all(arg_13_1.items, function(arg_14_0)
			return arg_14_0.type == DROP_TYPE_ICON_FRAME or arg_14_0.type == DROP_TYPE_CHAT_FRAME or arg_14_0.type == DROP_TYPE_LIVINGAREA_COVER
		end) then
			table.insert({}, function(arg_15_0)
				onNextTick(arg_15_0)

				return
			end)
		else
			table.insert({}, function(arg_16_0)
				arg_5_0:addSubLayers(Context.New({
					mediator = AwardInfoMediator,
					viewComponent = AwardInfoLayer,
					data = setmetatable({
						removeFunc = arg_16_0,
						auto = arg_13_1.auto
					}, {
						__index = arg_13_1
					})
				}))

				return
			end)
		end

		seriesAsync({}, arg_13_1.removeFunc)

		return
	end)

	local function var_5_0(arg_17_0, arg_17_1)
		local var_17_0 = getProxy(BayProxy)
		local var_17_1 = getProxy(BayProxy):getNewShip(true)
		local var_17_2 = {}

		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			if iter_17_1:isMetaShip() then
				table.insert({}, iter_17_1.configId)
			end
		end

		local var_17_3 = #var_17_1

		underscore.each(arg_17_0, function(arg_18_0)
			if arg_18_0.type == DROP_TYPE_OPERATION then
				table.insert(var_17_1, var_17_0:getShipById(arg_18_0.count))
			elseif arg_18_0.type == DROP_TYPE_VITEM and arg_18_0:getConfig("virtual_type") == 17 then
				table.insert(var_17_1, var_17_0:getShipById(getProxy(ActivityProxy):getActivityById(arg_18_0:getConfig("link_id")).data2))
			elseif arg_18_0.type == DROP_TYPE_SHIP then
				local var_18_0 = arg_18_0.configId or arg_18_0.id

				if Ship.isMetaShipByConfigID(var_18_0) then
					local var_18_1 = table.indexof(var_17_2, var_18_0)

					if var_18_1 then
						table.remove(var_17_2, var_18_1)

						var_17_3 = var_17_3 - 1
					else
						local var_18_2 = Ship.New({
							configId = var_18_0
						})
						local var_18_3 = getProxy(BayProxy):getMetaTransItemMap(var_18_2.configId)

						if var_18_3 then
							var_18_2:setReMetaSpecialItemVO(var_18_3)
						end

						table.insert(var_17_1, var_18_2)
					end
				else
					var_17_3 = var_17_3 - 1
				end
			end

			return
		end)

		var_17_1 = underscore.rest(var_17_1, #var_17_1 + 1)

		if pg.gameset.award_ship_limit then
			local var_17_4 = pg.gameset.award_ship_limit.key_value or 20

			if var_17_4 >= #var_17_1 then
				for iter_17_2, iter_17_3 in ipairs(var_17_1) do
					table.insert(arg_17_1, function(arg_19_0)
						arg_5_0:addSubLayers(Context.New({
							mediator = NewShipMediator,
							viewComponent = NewShipLayer,
							data = {
								ship = iter_17_3
							},
							onRemoved = arg_19_0
						}))

						return
					end)
				end
			end

			return
		end
	end

	local function var_5_1(arg_20_0, arg_20_1)
		for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
			if iter_20_1.type == DROP_TYPE_SKIN and pg.ship_skin_template[iter_20_1.id].skin_type ~= ShipSkin.SKIN_TYPE_REMAKE then
				table.insert(arg_20_1, function(arg_21_0)
					arg_5_0:addSubLayers(Context.New({
						mediator = NewSkinMediator,
						viewComponent = NewSkinLayer,
						data = {
							skinId = iter_20_1.id
						},
						onRemoved = arg_21_0
					}))

					return
				end)
			end

			if iter_20_1.type == DROP_TYPE_SKIN_TIMELIMIT then
				if iter_20_1.count > 0 then
					local var_20_0 = getProxy(ShipSkinProxy)

					if not var_20_0:hasNonLimitSkin(iter_20_1.id) then
						table.insert(arg_20_1, function(arg_22_0)
							arg_5_0:addSubLayers(Context.New({
								mediator = NewSkinMediator,
								viewComponent = NewSkinLayer,
								data = {
									timeLimit = true,
									skinId = iter_20_1.id
								},
								onRemoved = arg_22_0
							}))

							return
						end)

						goto label_20_0
					end
				end

				table.insert(arg_20_1, function(arg_23_0)
					pg.TipsMgr.GetInstance():ShowTips(i18n("already_have_the_skin"))
					arg_23_0()

					return
				end)
			end

			::label_20_0::
		end

		return
	end

	local function var_5_2(arg_24_0, arg_24_1)
		local var_24_0 = 0

		for iter_24_0, iter_24_1 in ipairs(arg_24_0) do
			if iter_24_1.type == DROP_TYPE_COMMANDER_CAT then
				var_24_0 = var_24_0 + 1
			end
		end

		if var_24_0 == 0 then
			return
		end

		local var_24_1 = getProxy(CommanderProxy)

		for iter_24_2, iter_24_3 in ipairs((var_24_1:GetNewestCommander(var_24_0))) do
			table.insert(arg_24_1, function(arg_25_0)
				arg_5_0:addSubLayers(Context.New({
					viewComponent = NewCommanderScene,
					mediator = NewCommanderMediator,
					data = {
						commander = iter_24_3,
						onExit = arg_25_0
					}
				}))

				return
			end)
		end

		return
	end

	arg_5_0:bind(BaseUI.ON_ACHIEVE, function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = {}

		if #arg_26_1 > 0 then
			table.insert({}, function(arg_27_0)
				arg_5_0.viewComponent:emit(BaseUI.ON_AWARD, {
					items = arg_26_1,
					removeFunc = arg_27_0
				})

				return
			end)
			table.insert({}, function(arg_28_0)
				var_5_0(arg_26_1, var_26_0)
				var_5_1(arg_26_1, var_26_0)
				var_5_2(arg_26_1, var_26_0)
				arg_28_0()

				return
			end)
		end

		seriesAsyncExtend({}, arg_26_2)

		return
	end)
	arg_5_0:bind(BaseUI.ON_ACHIEVE_AUTO, function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		local var_29_0 = {}

		if #arg_29_1 > 0 then
			table.insert({}, function(arg_30_0)
				({
					items = arg_29_1,
					removeFunc = arg_30_0
				}).auto = arg_29_2 or 2

				arg_5_0.viewComponent:emit(BaseUI.ON_AWARD, {
					items = arg_29_1,
					removeFunc = arg_30_0
				})

				return
			end)
			table.insert({}, function(arg_31_0)
				var_5_0(arg_29_1, var_29_0)
				var_5_1(arg_29_1, var_29_0)
				var_5_2(arg_29_1, var_29_0)
				arg_31_0()

				return
			end)
		end

		seriesAsyncExtend({}, arg_29_3)

		return
	end)
	arg_5_0:bind(BaseUI.ON_WORLD_ACHIEVE, function(arg_32_0, arg_32_1)
		local var_32_0 = {}

		if #arg_32_1.items > 0 then
			table.insert({}, function(arg_33_0)
				arg_5_0.viewComponent:emit(BaseUI.ON_AWARD, setmetatable({
					removeFunc = arg_33_0
				}, {
					__index = arg_32_1
				}))

				return
			end)
			table.insert({}, function(arg_34_0)
				var_5_0(var_0, var_32_0)
				var_5_1(var_0, var_32_0)
				var_5_2(var_0, var_32_0)
				arg_34_0()

				return
			end)
		end

		seriesAsyncExtend({}, arg_32_1.removeFunc)

		return
	end)
	arg_5_0:bind(BaseUI.ON_SHIP_EXP, function(arg_35_0, arg_35_1, arg_35_2)
		arg_5_0:addSubLayers(Context.New({
			mediator = ShipExpMediator,
			viewComponent = ShipExpLayer,
			data = arg_35_1,
			onRemoved = arg_35_2
		}))

		return
	end)
	arg_5_0:bind(BaseUI.ON_SPWEAPON, function(arg_36_0, arg_36_1)
		arg_36_1.type = defaultValue(arg_36_1.type, SpWeaponInfoLayer.TYPE_DEFAULT)

		local var_36_0 = arg_5_0
		local var_36_3 = {
			mediator = SpWeaponInfoMediator,
			viewComponent = SpWeaponInfoLayer,
			data = arg_36_1
		}

		if arg_36_1 then
			var_36_3.onRemoved = arg_36_1.onRemoved or nil

			var_36_1(var_36_0, var_36_2(var_36_3))

			return
		end
	end)
	arg_5_0:bind(BaseUI.ON_ADD_SUBLAYER, function(arg_37_0, arg_37_1)
		arg_5_0:addSubLayers(arg_37_1)

		return
	end)
	arg_5_0:commonBind()
	arg_5_0:register()

	return
end

function var_0_0.commonBind(arg_38_0)
	var_0_0.CommonBindDic = var_0_0.CommonBindDic or {
		[BaseUI.ON_DROP] = function(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
			if arg_39_2.type == DROP_TYPE_EQUIP then
				arg_39_0:addSubLayers(Context.New({
					mediator = EquipmentInfoMediator,
					viewComponent = EquipmentInfoLayer,
					data = {
						equipmentId = arg_39_2:getConfig("id"),
						type = EquipmentInfoMediator.TYPE_DISPLAY,
						onRemoved = arg_39_3
					}
				}))
			elseif arg_39_2.type == DROP_TYPE_SPWEAPON then
				arg_39_0:addSubLayers(Context.New({
					mediator = SpWeaponInfoMediator,
					viewComponent = SpWeaponInfoLayer,
					data = {
						spWeaponConfigId = arg_39_2:getConfig("id"),
						type = SpWeaponInfoLayer.TYPE_DISPLAY,
						onRemoved = arg_39_3
					}
				}))
			elseif arg_39_2.type == DROP_TYPE_EQUIPMENT_SKIN then
				arg_39_0:addSubLayers(Context.New({
					mediator = EquipmentSkinMediator,
					viewComponent = EquipmentSkinLayer,
					data = {
						skinId = arg_39_2:getConfig("id"),
						mode = EquipmentSkinLayer.DISPLAY
					}
				}))
			elseif arg_39_2.type == DROP_TYPE_EMOJI then
				arg_39_0:addSubLayers(Context.New({
					mediator = ContextMediator,
					viewComponent = EmojiInfoLayer,
					data = {
						id = arg_39_2.cfg.id
					}
				}))
			elseif arg_39_2.type == DROP_TYPE_COMBAT_UI_STYLE and not arg_39_2.notPlay then
				arg_39_0:addSubLayers(Context.New({
					mediator = CombatSkinInfoMediator,
					viewComponent = CombatSkinInfoLayer,
					data = {
						skinID = arg_39_2:getConfig("id")
					}
				}))
			else
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_SINGLE_ITEM,
					drop = arg_39_2,
					onNo = arg_39_3,
					onYes = arg_39_3
				})
			end

			return
		end,
		[BaseUI.ON_DROP_LIST] = function(arg_40_0, arg_40_1, arg_40_2)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				type = MSGBOX_TYPE_ITEM_BOX,
				items = arg_40_2.itemList,
				content = arg_40_2.content,
				item2Row = arg_40_2.item2Row,
				itemFunc = function(arg_41_0)
					arg_40_0.viewComponent:emit(BaseUI.ON_DROP, arg_41_0, function()
						arg_40_0.viewComponent:emit(BaseUI.ON_DROP_LIST, arg_40_2)

						return
					end)

					return
				end
			})

			return
		end,
		[BaseUI.ON_DROP_LIST_OWN] = function(arg_43_0, arg_43_1, arg_43_2)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				type = MSGBOX_TYPE_DROP_ITEM_ESKIN,
				items = arg_43_2.itemList,
				content = arg_43_2.content,
				item2Row = arg_43_2.item2Row,
				itemFunc = function(arg_44_0)
					arg_43_0.viewComponent:emit(BaseUI.ON_DROP, arg_44_0, function()
						arg_43_0.viewComponent:emit(BaseUI.ON_DROP_LIST, arg_43_2)

						return
					end)

					return
				end
			})

			return
		end,
		[BaseUI.ON_ITEM] = function(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
			arg_46_0:addSubLayers(Context.New({
				mediator = ItemInfoMediator,
				viewComponent = ItemInfoLayer,
				data = {
					drop = Drop.New({
						type = DROP_TYPE_ITEM,
						id = arg_46_2
					}),
					confirmCall = arg_46_3
				}
			}))

			return
		end,
		[BaseUI.ON_ITEM_EXTRA] = function(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
			arg_47_0:addSubLayers(Context.New({
				mediator = ItemInfoMediator,
				viewComponent = ItemInfoLayer,
				data = {
					drop = Drop.New({
						type = DROP_TYPE_ITEM,
						id = arg_47_2,
						extra = arg_47_3
					})
				}
			}))

			return
		end,
		[BaseUI.ON_SHIP] = function(arg_48_0, arg_48_1, arg_48_2)
			arg_48_0:addSubLayers(Context.New({
				mediator = ItemInfoMediator,
				viewComponent = ItemInfoLayer,
				data = {
					drop = Drop.New({
						type = DROP_TYPE_SHIP,
						id = arg_48_2
					})
				}
			}))

			return
		end,
		[BaseUI.ON_EQUIPMENT] = function(arg_49_0, arg_49_1, arg_49_2)
			arg_49_2.type = defaultValue(arg_49_2.type, EquipmentInfoMediator.TYPE_DEFAULT)

			local var_49_0 = arg_49_0
			local var_49_3 = {
				mediator = EquipmentInfoMediator,
				viewComponent = EquipmentInfoLayer,
				data = arg_49_2
			}

			if arg_49_2 then
				var_49_3.onRemoved = arg_49_2.onRemoved or nil

				var_49_1(var_49_0, var_49_2(var_49_3))

				return
			end
		end,
		[BaseUI.ON_NEW_DROP] = function(arg_50_0, arg_50_1, arg_50_2)
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_DROP, arg_50_2)

			return
		end,
		[BaseUI.ON_NEW_STYLE_DROP] = function(arg_51_0, arg_51_1, arg_51_2)
			if arg_51_2.useDeepShow then
				pg.NewStyleMsgboxMgr.GetInstance():DeepShow(pg.NewStyleMsgboxMgr.TYPE_COMMON_DROP, arg_51_2)
			else
				pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_DROP, arg_51_2)
			end

			return
		end,
		[BaseUI.ON_NEW_STYLE_ITEMS] = function(arg_52_0, arg_52_1, arg_52_2)
			local var_52_0 = setmetatable(arg_52_2, {
				__index = {
					btnList = {
						{
							type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.confirm,
							name = i18n("msgbox_text_confirm"),
							sound = SFX_CONFIRM
						}
					},
					items = arg_52_2.itemList,
					content = arg_52_2.content,
					itemFunc = function(arg_53_0)
						arg_52_0.viewComponent:emit(BaseUI.ON_NEW_STYLE_DROP, {
							useDeepShow = true,
							drop = arg_53_0
						})

						return
					end
				}
			})

			if arg_52_2.useDeepShow then
				pg.NewStyleMsgboxMgr.GetInstance():DeepShow(pg.NewStyleMsgboxMgr.TYPE_COMMON_ITEMS, var_52_0)
			else
				pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_ITEMS, var_52_0)
			end

			return
		end
	}

	for iter_38_0, iter_38_1 in pairs(var_0_0.CommonBindDic) do
		arg_38_0:bind(iter_38_0, function(...)
			return iter_38_1(arg_38_0, ...)
		end)
	end

	return
end

function var_0_0.register(arg_55_0)
	return
end

function var_0_0.onUIAvalible(arg_56_0)
	return
end

function var_0_0.setContextData(arg_57_0, arg_57_1)
	arg_57_0.contextData = arg_57_1

	return
end

function var_0_0.bind(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0.viewComponent.event:connect(arg_58_1, arg_58_2)
	table.insert(arg_58_0.event, {
		event = arg_58_1,
		callback = arg_58_2
	})

	return
end

function var_0_0.onRemove(arg_59_0)
	arg_59_0:remove()

	for iter_59_0, iter_59_1 in ipairs(arg_59_0.event) do
		arg_59_0.viewComponent.event:disconnect(iter_59_1.event, iter_59_1.callback)
	end

	arg_59_0.event = {}

	return
end

function var_0_0.remove(arg_60_0)
	return
end

function var_0_0.addSubLayers(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4)
	assert(isa(arg_61_1, Context), "should be an instance of Context")

	local var_61_0 = arg_61_0:GetContext()

	if arg_61_2 then
		while var_61_0.parent do
			var_61_0 = var_61_0.parent
		end
	end

	local var_61_1 = {
		parentContext = var_61_0,
		context = arg_61_1,
		callback = arg_61_3
	}

	var_61_1 = arg_61_4 and table.merge(var_61_1, arg_61_4) or var_61_1

	arg_61_0:sendNotification(GAME.LOAD_LAYERS, var_61_1)

	return
end

function var_0_0.GetContext(arg_62_0)
	return getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_62_0.class)
end

function var_0_0.blockEvents(arg_63_0)
	if arg_63_0.event then
		for iter_63_0, iter_63_1 in ipairs(arg_63_0.event) do
			arg_63_0.viewComponent.event:block(iter_63_1.event, iter_63_1.callback)
		end
	end

	return
end

function var_0_0.unblockEvents(arg_64_0)
	if arg_64_0.event then
		for iter_64_0, iter_64_1 in ipairs(arg_64_0.event) do
			arg_64_0.viewComponent.event:unblock(iter_64_1.event, iter_64_1.callback)
		end
	end

	return
end

function var_0_0.onBackPressed(arg_65_0, arg_65_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if arg_65_1 then
		local var_65_0 = getProxy(ContextProxy):getContextByMediator(arg_65_0.class).parent

		if var_65_0 then
			local var_65_1 = pg.m02:retrieveMediator(var_65_0.mediator.__cname)

			if var_65_1 and var_65_1.viewComponent then
				var_65_1.viewComponent:onBackPressed()
			end
		end
	else
		arg_65_0.viewComponent:closeView()
	end

	return
end

function var_0_0.removeSubLayers(arg_66_0, arg_66_1, arg_66_2)
	assert(isa(arg_66_1, var_0_0), "should be a ContextMediator Class")

	local var_66_0 = arg_66_0.class or arg_66_0
	local var_66_1 = getProxy(ContextProxy):getContextByMediator(var_66_0)

	if not var_66_1 then
		return
	end

	local var_66_2 = var_66_1:getContextByMediator(arg_66_1)

	if not var_66_2 then
		return
	end

	arg_66_0:sendNotification(GAME.REMOVE_LAYERS, {
		context = var_66_2,
		callback = arg_66_2
	})

	return
end

return var_0_0
