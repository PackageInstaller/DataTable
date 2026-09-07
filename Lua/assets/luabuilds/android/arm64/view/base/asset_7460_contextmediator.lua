local ContextMediator = class("ContextMediator", pm.Mediator)

function ContextMediator:Ctor(arg_1_1)
	self:initNotificationHandleDic()
	ContextMediator.super.Ctor(self, nil, arg_1_1)

	return
end

function ContextMediator:initNotificationHandleDic()
	self.handleDic, self.handleElse = nil

	return
end

function ContextMediator:listNotificationInterests()
	if self.handleDic then
		return underscore.keys(self.handleDic)
	else
		return ContextMediator.super.listNotificationInterests(self)
	end

	return
end

function ContextMediator:handleNotification(arg_4_1)
	if self.handleDic then
		switch(arg_4_1:getName(), self.handleDic, self.handleElse, self, arg_4_1)
	else
		ContextMediator.super.handleNotification(self, arg_4_1)
	end

	return
end

function ContextMediator:onRegister()
	self.event = {}

	self:bind(BaseUI.ON_BACK_PRESSED, function(arg_6_0, arg_6_1)
		self:onBackPressed(arg_6_1)

		return
	end)
	self:bind(BaseUI.AVALIBLE, function(arg_7_0, arg_7_1)
		self:onUIAvalible()

		return
	end)
	self:bind(BaseUI.ON_BACK, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_2 and arg_8_2 > 0 then
			pg.UIMgr.GetInstance():LoadingOn(false)
			LeanTween.delayedCall(arg_8_2, System.Action(function()
				pg.UIMgr.GetInstance():LoadingOff()
				self:sendNotification(GAME.GO_BACK, nil, arg_8_1)

				return
			end))
		else
			self:sendNotification(GAME.GO_BACK, nil, arg_8_1)
		end

		return
	end)
	self:bind(BaseUI.ON_RETURN, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.GO_BACK, arg_10_1)

		return
	end)
	self:bind(BaseUI.ON_HOME, function(arg_11_0)
		local var_11_0 = getProxy(ContextProxy):getCurrentContext()

		if var_11_0.mediator == NewMainMediator then
			for iter_11_0 = #var_11_0.children, 1, -1 do
				self:sendNotification(GAME.REMOVE_LAYERS, {
					context = var_11_0.children[iter_11_0]
				})
			end

			return
		end

		local var_11_1 = var_11_0:retriveLastChild()

		if var_11_1 and var_11_1 ~= var_11_0 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				onHome = true,
				context = var_11_1
			})
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.MAINUI)

		return
	end)
	self:bind(BaseUI.ON_CLOSE, function(arg_12_0)
		local var_12_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(self.class)

		if var_12_0 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_12_0
			})
		end

		return
	end)
	self:bind(BaseUI.ON_AWARD, function(arg_13_0, arg_13_1)
		local var_13_0 = {}

		if _.all(arg_13_1.items, function(arg_14_0)
			return arg_14_0.type == DROP_TYPE_ICON_FRAME or arg_14_0.type == DROP_TYPE_CHAT_FRAME or arg_14_0.type == DROP_TYPE_LIVINGAREA_COVER
		end) then
			table.insert(var_13_0, function(arg_15_0)
				onNextTick(arg_15_0)

				return
			end)
		else
			table.insert(var_13_0, function(arg_16_0)
				self:addSubLayers(Context.New({
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

		seriesAsync(var_13_0, arg_13_1.removeFunc)

		return
	end)

	local function var_5_0(arg_17_0, arg_17_1)
		local var_17_0 = getProxy(BayProxy)
		local var_17_1 = var_17_0:getNewShip(true)
		local var_17_2 = {}

		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			if iter_17_1:isMetaShip() then
				table.insert(var_17_2, iter_17_1.configId)
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
			if (pg.gameset.award_ship_limit.key_value or 20) >= #var_17_1 then
				for iter_17_2, iter_17_3 in ipairs(var_17_1) do
					table.insert(arg_17_1, function(arg_19_0)
						self:addSubLayers(Context.New({
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
		end

		return
	end

	local function var_5_1(arg_20_0, arg_20_1)
		for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
			if iter_20_1.type == DROP_TYPE_SKIN and pg.ship_skin_template[iter_20_1.id].skin_type ~= ShipSkin.SKIN_TYPE_REMAKE then
				table.insert(arg_20_1, function(arg_21_0)
					self:addSubLayers(Context.New({
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
					if not getProxy(ShipSkinProxy):hasNonLimitSkin(iter_20_1.id) then
						table.insert(arg_20_1, function(arg_22_0)
							self:addSubLayers(Context.New({
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

		for iter_24_2, iter_24_3 in ipairs((getProxy(CommanderProxy):GetNewestCommander(var_24_0))) do
			table.insert(arg_24_1, function(arg_25_0)
				self:addSubLayers(Context.New({
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

	self:bind(BaseUI.ON_ACHIEVE, function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = {}

		if #arg_26_1 > 0 then
			table.insert(var_26_0, function(arg_27_0)
				self.viewComponent:emit(BaseUI.ON_AWARD, {
					items = arg_26_1,
					removeFunc = arg_27_0
				})

				return
			end)
			table.insert(var_26_0, function(arg_28_0)
				var_5_0(arg_26_1, var_26_0)
				var_5_1(arg_26_1, var_26_0)
				var_5_2(arg_26_1, var_26_0)
				arg_28_0()

				return
			end)
		end

		seriesAsyncExtend(var_26_0, arg_26_2)

		return
	end)
	self:bind(BaseUI.ON_ACHIEVE_AUTO, function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		local var_29_0 = {}

		if #arg_29_1 > 0 then
			table.insert(var_29_0, function(arg_30_0)
				local var_30_0 = {
					items = arg_29_1,
					removeFunc = arg_30_0
				}

				var_30_0.auto = arg_29_2 or 2

				self.viewComponent:emit(BaseUI.ON_AWARD, var_30_0)

				return
			end)
			table.insert(var_29_0, function(arg_31_0)
				var_5_0(arg_29_1, var_29_0)
				var_5_1(arg_29_1, var_29_0)
				var_5_2(arg_29_1, var_29_0)
				arg_31_0()

				return
			end)
		end

		seriesAsyncExtend(var_29_0, arg_29_3)

		return
	end)
	self:bind(BaseUI.ON_WORLD_ACHIEVE, function(arg_32_0, arg_32_1)
		local var_32_0 = {}
		local var_32_1 = arg_32_1.items

		if #arg_32_1.items > 0 then
			table.insert(var_32_0, function(arg_33_0)
				self.viewComponent:emit(BaseUI.ON_AWARD, setmetatable({
					removeFunc = arg_33_0
				}, {
					__index = arg_32_1
				}))

				return
			end)
			table.insert(var_32_0, function(arg_34_0)
				var_5_0(var_32_1, var_32_0)
				var_5_1(var_32_1, var_32_0)
				var_5_2(var_32_1, var_32_0)
				arg_34_0()

				return
			end)
		end

		seriesAsyncExtend(var_32_0, arg_32_1.removeFunc)

		return
	end)
	self:bind(BaseUI.ON_SHIP_EXP, function(arg_35_0, arg_35_1, arg_35_2)
		self:addSubLayers(Context.New({
			mediator = ShipExpMediator,
			viewComponent = ShipExpLayer,
			data = arg_35_1,
			onRemoved = arg_35_2
		}))

		return
	end)
	self:bind(BaseUI.ON_SPWEAPON, function(arg_36_0, arg_36_1)
		arg_36_1.type = defaultValue(arg_36_1.type, SpWeaponInfoLayer.TYPE_DEFAULT)

		local var_36_0 = {
			mediator = SpWeaponInfoMediator,
			viewComponent = SpWeaponInfoLayer,
			data = arg_36_1
		}

		if arg_36_1 then
			var_36_0.onRemoved = arg_36_1.onRemoved or nil
		end

		self:addSubLayers(Context.New(var_36_0))

		return
	end)
	self:bind(BaseUI.ON_ADD_SUBLAYER, function(arg_37_0, arg_37_1)
		self:addSubLayers(arg_37_1)

		return
	end)
	self:commonBind()
	self:register()

	return
end

function ContextMediator:commonBind()
	ContextMediator.CommonBindDic = ContextMediator.CommonBindDic or {
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

			local var_49_0 = {
				mediator = EquipmentInfoMediator,
				viewComponent = EquipmentInfoLayer,
				data = arg_49_2
			}

			if arg_49_2 then
				var_49_0.onRemoved = arg_49_2.onRemoved or nil
			end

			arg_49_0:addSubLayers(Context.New(var_49_0))

			return
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

	for iter_38_0, iter_38_1 in pairs(ContextMediator.CommonBindDic) do
		self:bind(iter_38_0, function(...)
			return iter_38_1(self, ...)
		end)
	end

	return
end

function ContextMediator:register()
	return
end

function ContextMediator:onUIAvalible()
	return
end

function ContextMediator:setContextData(arg_57_1)
	self.contextData = arg_57_1

	return
end

function ContextMediator:bind(arg_58_1, arg_58_2)
	self.viewComponent.event:connect(arg_58_1, arg_58_2)
	table.insert(self.event, {
		event = arg_58_1,
		callback = arg_58_2
	})

	return
end

function ContextMediator:onRemove()
	self:remove()

	for iter_59_0, iter_59_1 in ipairs(self.event) do
		self.viewComponent.event:disconnect(iter_59_1.event, iter_59_1.callback)
	end

	self.event = {}

	return
end

function ContextMediator:remove()
	return
end

function ContextMediator:addSubLayers(arg_61_1, arg_61_2, arg_61_3, arg_61_4)
	assert(isa(arg_61_1, Context), "should be an instance of Context")

	local var_61_0 = self:GetContext()

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

	self:sendNotification(GAME.LOAD_LAYERS, var_61_1)

	return
end

function ContextMediator:GetContext()
	return getProxy(ContextProxy):getCurrentContext():getContextByMediator(self.class)
end

function ContextMediator:blockEvents()
	if self.event then
		for iter_63_0, iter_63_1 in ipairs(self.event) do
			self.viewComponent.event:block(iter_63_1.event, iter_63_1.callback)
		end
	end

	return
end

function ContextMediator:unblockEvents()
	if self.event then
		for iter_64_0, iter_64_1 in ipairs(self.event) do
			self.viewComponent.event:unblock(iter_64_1.event, iter_64_1.callback)
		end
	end

	return
end

function ContextMediator:onBackPressed(arg_65_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if arg_65_1 then
		local var_65_0 = getProxy(ContextProxy):getContextByMediator(self.class).parent

		if var_65_0 then
			local var_65_1 = pg.m02:retrieveMediator(var_65_0.mediator.__cname)

			if var_65_1 and var_65_1.viewComponent then
				var_65_1.viewComponent:onBackPressed()
			end
		end
	else
		self.viewComponent:closeView()
	end

	return
end

function ContextMediator:removeSubLayers(arg_66_1, arg_66_2)
	assert(isa(arg_66_1, ContextMediator), "should be a ContextMediator Class")

	local var_66_0 = getProxy(ContextProxy):getContextByMediator(self.class or self)

	if not var_66_0 then
		return
	end

	local var_66_1 = var_66_0:getContextByMediator(arg_66_1)

	if not var_66_1 then
		return
	end

	self:sendNotification(GAME.REMOVE_LAYERS, {
		context = var_66_1,
		callback = arg_66_2
	})

	return
end

return ContextMediator
