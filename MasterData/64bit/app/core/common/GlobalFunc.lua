local var_0_0 = {}
local CreateConst = require("app.view.module.create.const.CreateConst")
local UserConst = require("app.view.module.user.const.UserConst")

function var_0_0.getFormatSkillPromoteDes(arg_1_0)
	local var_1_0 = g.core.config.skill_info.get(arg_1_0)

	return (string.gsub(var_1_0.promote_description, "#num1#", var_1_0.formula_1_value_1 / 10))
end

function var_0_0.getFormatSkillPromoteDes2(arg_2_0)
	local var_2_0 = g.core.config.skill_info.get(arg_2_0)

	return (string.gsub(var_2_0.promote_description_2, "#num1#", var_2_0.formula_1_value_1 / 10))
end

function var_0_0.getFragBagEmptyCount(arg_3_0)
	if not arg_3_0 or type(arg_3_0) ~= "table" then
		return arg_3_0
	end

	for iter_3_0 = 1, #arg_3_0 < 20 and 20 - #arg_3_0 or 5 - #arg_3_0 % 5 do
		table.insert(arg_3_0, {})
	end

	return arg_3_0
end

function var_0_0:execPlatformRecharge(arg_4_1)
	if not self then
		return
	end

	if g.core.model.User.rechargeData:getRechargeStatus() then
		g.core.model.User.rechargeData:setRechargeStatus(false)
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.model.User.rechargeData:setRechargeStatus(true)
		end, 2)

		if device.isWindowsDebug() or config.CAN_RECHARGE == false then
			g.core.module.ModuleManager:tip(g.core.lang:get(1171))

			return
		end

		local var_4_0 = g.core.model.User.rechargeData:getPriceByNum(self.money_local, true)
		local var_4_1 = arg_4_1 or {}

		var_4_1.rechargeType = self.recharge_type
		var_4_1.stage = 1

		if 0 > 0 then
			var_4_1.original_price = var_4_0
			var_4_0 = math.ceil(var_4_0 * 0 / 100)
		end

		g.core.platform.PlatformProxy:pay(string.format("%.2f", var_4_0), self.product_id, self.name, self.des, 10, g.core.lang:get(1169), self.name, var_4_1, self.id)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1172))
	end
end

function var_0_0:pushInfoPop()
	self = clone(self)

	local var_6_0 = self.type
	local var_6_1 = self.value

	if self.type == g.core.common.Goods.TYPE_GOLD then
		self.type = g.core.common.Goods.TYPE_RESOURCE
		var_6_0 = g.core.common.Goods.TYPE_RESOURCE
		self.value = 1000
		var_6_1 = self.value
		self.size = g.core.model.User:getFreeGold()
		self.isGold = true
	end

	if self.type == g.core.common.Goods.TYPE_FRAGMENT then
		if g.core.config.fragment_info.get(self.value).fragment_type ~= 3 and g.core.config.fragment_info.get(self.value).fragment_type ~= 20 then
			var_6_0 = g.core.config.fragment_info.get(self.value).fragment_type
			var_6_1 = g.core.config.fragment_info.get(self.value).fragment_value
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_6_0,
				value = var_6_1
			}, self)
		end
	end

	if var_6_0 == g.core.common.Goods.TYPE_RESOURCE and (self.value == 1000 or self.value == 1002) then
		self.isGold = true
	end

	if var_6_0 == g.core.common.Goods.TYPE_RESOURCE or var_6_0 == g.core.common.Goods.TYPE_ITEM or var_6_0 == g.core.common.Goods.TYPE_KNIGHT_ADVANCE or var_6_0 == g.core.common.Goods.TYPE_AVATAR_FRAME or var_6_0 == g.core.common.Goods.TYPE_AVATAR or var_6_0 == g.core.common.Goods.TYPE_FACE_GROUP or var_6_0 == g.core.common.Goods.TYPE_EXPIRABLE_ITEM then
		if var_6_0 == g.core.common.Goods.TYPE_ITEM then
			if self.isGetShow then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = self.type,
					value = var_6_1,
					size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, var_6_1)
				}, self)
			else
				local var_6_2 = g.core.config.item_info.get(var_6_1)

				if var_6_2.use_type == 2 or var_6_2.use_type == 3 then
					g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InfoItemsGiftBagPop").new({
						type = var_6_0,
						value = var_6_1,
						isGold = self.isGold
					}))
				else
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						type = self.type,
						value = var_6_1
					}, self)
				end
			end
		elseif var_6_0 == g.core.common.Goods.TYPE_EXPIRABLE_ITEM then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self.type,
				value = var_6_1,
				size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_EXPIRABLE_ITEM, var_6_1)
			}, self)
		elseif self.isGold then
			if self.value == 1000 then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource2({
					type = self.type,
					value = var_6_1,
					size = g.core.model.User:getFreeGold()
				}, self)
			elseif self.value == 1002 then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource2({
					type = self.type,
					value = var_6_1,
					size = g.core.model.User:getGold()
				}, self)
			end
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self.type,
				value = var_6_1
			}, self)
		end
	elseif var_6_0 == g.core.common.Goods.TYPE_KNIGHT then
		local var_6_3 = g.core.model.User.knightsData:getKnightByBaseId(self.value)
		local var_6_4

		if g.core.config.knight_info.get(var_6_1).put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			do return end

			var_6_4 = self.type == g.core.common.Goods.TYPE_FRAGMENT
		end

		if var_6_3:isOwn() and not self.isGetShow and not self.noDetail and not var_6_4 then
			if self.isFogNightPop then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
					knightStruct = self.struct,
					isOthers = self.isOthers
				}), {
					hideContinue = true,
					touchDisappear = true
				})
			else
				g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
					knightId = var_6_1
				}), {
					hideContinue = true,
					touchDisappear = true
				})
			end
		elseif self.isGetShow then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self.type,
				value = var_6_1,
				size = (g.core.model.User.knightsData:hasKnightByAdvanceId(var_6_1) or nil) and 1
			}, self)
		elseif self.isFogNightPop then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
				knightStruct = self.struct
			}), {
				hideContinue = true,
				touchDisappear = true
			})
		else
			g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
				knightId = var_6_1
			}), {
				hideContinue = true,
				touchDisappear = true
			})
		end
	elseif var_6_0 == g.core.common.Goods.TYPE_UNITETOKEN then
		if g.core.config.unite_token_info.get(var_6_1).put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		if self.isGetShow then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self.type,
				value = var_6_1,
				size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_UNITETOKEN, var_6_1)
			}, self)
		else
			g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.UniteTokenInfoPop").new((self.tokenData or nil) and {
				tokenData = self.tokenData
			}), {
				hideContinue = true,
				touchDisappear = true
			})
		end
	elseif var_6_0 == g.core.common.Goods.TYPE_EQUIP then
		if g.core.config.equipment_info.get(var_6_1).put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		if self.isGetShow then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self.type,
				value = var_6_1,
				size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_EQUIP, var_6_1)
			}, self)
		else
			local var_6_7

			if self.equip then
				var_6_7 = {
					state = 2,
					pos = self.equip.position,
					id = self.equip.id,
					baseId = var_6_1
				}
			else
				var_6_7 = {
					baseId = var_6_1
				}
				var_6_7.isEquipFrag = true
			end

			if var_6_7 then
				g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.InfoEquipDetailPop").new(var_6_7)))
			end
		end
	elseif var_6_0 == g.core.common.Goods.TYPE_TREASURE then
		if g.core.config.treasure_info.get(var_6_1).put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		if self.treasure then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.TreasureInfoPop").new({
				id = var_6_1,
				onlyId = self.treasure.onlyId
			}), {
				hideContinue = true,
				touchDisappear = true
			})

			return
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.TreasureInfoPop").new({
			id = var_6_1,
			onlyId = self.treasureOnlyId
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	elseif var_6_0 == g.core.common.Goods.TYPE_DRESS then
		-- block empty
	elseif var_6_0 == g.core.common.Goods.TYPE_REDPACKET then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_6_0,
			value = var_6_1
		}, self)
	elseif var_6_0 == g.core.common.Goods.TYPE_TITLE then
		local var_6_8 = g.core.config.title_info.get(var_6_1)

		if var_6_8.put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserTitleInfoNewPop").new({
			titleId = var_6_8.id
		}, {
			touchDisappear = true
		}))
	elseif var_6_0 == g.core.common.Goods.TYPE_BIO then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_6_0,
			value = var_6_1
		}, self)
	elseif var_6_0 == g.core.common.Goods.TYPE_ARTIFACT then
		if g.core.config.artifact_info.get(var_6_1).put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.artifact.view.ArtifactInfoPop").new({
			baseId = var_6_1
		}), {
			touchDisappear = true
		})
	elseif var_6_0 == g.core.common.Goods.TYPE_PET then
		local var_6_9 = g.core.config.pet_info.get(self.value)
		local var_6_10 = var_6_9.advance_id
		local var_6_11 = g.core.model.User.petsData:getPetByBaseId(var_6_9.advance_id)

		if var_6_9.put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		local var_6_12 = var_6_11:isOwn()
		local var_6_13 = self.type == g.core.common.Goods.TYPE_FRAGMENT

		if self.petData then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
				petStruct = self.petData
			}), {
				hideContinue = true,
				touchDisappear = true
			})

			return
		end

		if var_6_12 and not self.isGetShow and not self.noDetail and not var_6_13 then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
				petAdvId = var_6_10
			}), {
				hideContinue = true,
				touchDisappear = true
			})
		elseif self.isGetShow then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self.type,
				value = var_6_1,
				size = (var_6_11:isOwn() or nil) and 1
			}, self)
		else
			g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
				petAdvId = var_6_10
			}), {
				hideContinue = true,
				touchDisappear = true
			})
		end
	elseif var_6_0 == g.core.common.Goods.TYPE_SKIN then
		local var_6_15 = g.core.config.skin_info.get(var_6_1)
		local var_6_16 = var_6_15.put
		local var_6_17 = g.core.model.User.skinGoodsData:getShinGoodsBySkinId(var_6_15.id or 0)

		var_6_17 = var_6_17 or {}

		if tonumber(var_6_17.sale_value) ~= 3 and var_6_16 == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.KnightSkinShowTimePop").new({
			hideUI = true,
			skinId = var_6_15.id
		}))
	elseif var_6_0 == g.core.common.Goods.TYPE_INCARNATIIN then
		local var_6_18 = g.core.config.transformation_card_info.get(var_6_1)
	elseif var_6_0 == g.core.common.Goods.TYPE_WING then
		if g.core.config.wing_info.get(var_6_1).put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end
	elseif var_6_0 == g.core.common.Goods.TYPE_PET_EQUIP then
		local var_6_19 = g.core.config.pet_equipment_info.get(var_6_1)

		if not var_6_19 then
			return
		end

		if var_6_19.put == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end
	elseif var_6_0 == g.core.common.Goods.TYPE_KNIGHT_SOUL then
		if self.isGetShow then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self.type,
				value = var_6_1,
				size = self.size
			}, self)
		else
			g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InfoKnightSoulPop").new(self))
		end
	elseif var_6_0 == g.core.common.Goods.TYPE_KNIGHT_FAVORABILITY_ITEM then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_6_0,
			value = var_6_1
		}, self)
	elseif var_6_0 == g.core.common.Goods.TYPE_SILKBAG then
		-- block empty
	elseif var_6_0 == g.core.common.Goods.TYPE_FURNITURE then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self.type,
			value = var_6_1,
			size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_FURNITURE, var_6_1)
		}, self)
	elseif var_6_0 == g.core.common.Goods.TYPE_PRECIOUS then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.precious.view.PreciousInfoPop").new({
			preciousStruct = g.core.model.User.preciousData:getPreciousByAdvId(g.core.config.precious_info.get(var_6_1).advance_id)
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	elseif var_6_0 == g.core.common.Goods.TYPE_ROLE_SKIN then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.roleSkin.view.RoleSkinInfoPop").new({
			struct = g.core.model.User.roleSkinData:getPartItemByAdvanceId(g.core.config.role_skin_info.get(var_6_1).advance_id)
		}), {
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif var_6_0 == g.core.common.Goods.TYPE_SUCCUBA then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.succuba.view.SuccubaInfoPop").new({
			succubaStruct = g.core.model.User.succubaData:getSuccubaByAdvanceId(g.core.config.succuba_info.get(var_6_1).advance_id, true)
		}), {
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif var_6_0 == g.core.common.Goods.TYPE_OUTPOST_ITEM then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_6_0,
			value = var_6_1
		}, self)
	end
end

function var_0_0.isTodayRecord(arg_7_0)
	local var_7_0 = g.core.common.Storage:load("daily_record.json") or {}

	if not var_7_0[arg_7_0] or var_7_0[arg_7_0] == "" then
		return false
	end

	local var_7_1 = g.core.common.ServerTime:getDateObject()

	return var_7_0[arg_7_0] == string.format("%4d%2d%2d", var_7_1.year, var_7_1.month, var_7_1.day)
end

function var_0_0.changeTodayRecord(arg_8_0, arg_8_1)
	local var_8_0 = g.core.common.Storage:load("daily_record.json") or {}

	if arg_8_1 then
		local var_8_1 = g.core.common.ServerTime:getDateObject()

		var_8_0[arg_8_0] = string.format("%4d%2d%2d", var_8_1.year, var_8_1.month, var_8_1.day)
	else
		var_8_0[arg_8_0] = ""
	end

	g.core.common.Storage:save("daily_record.json", var_8_0)
end

function var_0_0.checkPetEquipBagBeforeBattle(arg_9_0)
	if g.core.model.User.petEquipData:getTotalCount() >= g.core.model.User.petEquipData:getBagLimit() then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
			text = g.core.lang:get(1161),
			text_ok = g.core.lang:get(1103),
			text_cancel = g.core.lang:get(1084),
			handler_ok = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.PETEQUIPBAG)
			end
		})))

		return
	end

	arg_9_0()
end

function var_0_0.checkBagBeforeBattle(arg_11_0)
	if g.core.config.role_info.get(g.core.model.User:getLevel()).equipment_bag_num_client <= g.core.model.User.equipmentData:countEquipmentNum() then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
			text = g.core.lang:get(1082),
			text_ok = g.core.lang:get(1102),
			text_cancel = g.core.lang:get(1084),
			handler_ok = function()
				g.core.module.ModuleManager:pushPopup(require("app.view.module.bagNew.view.equip.EquipSellPop").new(1), {
					touchDisappear = true
				})
			end
		})))

		return
	elseif g.core.config.role_info.get(g.core.model.User:getLevel()).treasure_bag_num_client <= g.core.model.User.treasureData:countTreasureNum() then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
			text = g.core.lang:get(1215),
			text_ok = g.core.lang:get(1103),
			text_cancel = g.core.lang:get(1084),
			handler_ok = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.LINE_UP)
			end
		})))

		return
	end

	arg_11_0()
end

function var_0_0.jumpToOpenPurchaseAndRecharge(arg_14_0)
	local var_14_0 = g.core.common.GlobalFunc.getOpenPurchaseRoute()

	if var_14_0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ACTIVITY, {
			route1 = var_14_0
		})
	elseif arg_14_0 then
		arg_14_0()
	end
end

function var_0_0.jumpToExchange(arg_15_0)
	local var_15_0 = g.core.common.GlobalFunc.getExchangeRoute(arg_15_0)

	if var_15_0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ACTIVITY, {
			route1 = var_15_0
		})
	end
end

function var_0_0.getExchangeRoute(arg_16_0)
	return nil
end

function var_0_0.getOpenPurchaseRoute()
	local var_17_0, var_17_1 = g.core.model.User.openPurchaseData:getLastCoundDownAndType()

	if var_17_1 then
		local var_17_2, var_17_3 = g.core.model.User.openPurchaseData:isAllProcess()

		if var_17_2 then
			return g.core.const.ConstMgr.FUNCTION_TYPE.OPEN_PURCHASE_ACT_START + var_17_3
		end
	elseif g.core.model.User.openPurchaseData:isCustomProcess() then
		local var_17_4 = g.core.model.User.openPurchaseData:getLastPurchaseData()

		if not var_17_4 then
			return
		end

		return 1000 + var_17_4.activityId
	end
end

function var_0_0.getStrToEmojiIdType(arg_18_0)
	return string.match(arg_18_0, "*(%d+).png")
end

function var_0_0.checkBagBeforeOpRecharge(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if not config.CAN_RECHARGE then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			singleButton = true,
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(300034)
		}), {
			touchDisappear = true
		})

		return
	end

	local var_19_0 = g.core.common.Goods:getItemRechargeTable()[arg_19_1.money]
	local var_19_1
	local var_19_2 = {}

	for iter_19_0 = 1, #(var_19_0 or {}) do
		var_19_2[var_19_0[iter_19_0]] = true

		if g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, var_19_0[iter_19_0]) > 0 then
			var_19_1 = var_19_0[iter_19_0]

			break
		end
	end

	if var_19_1 then
		local var_19_3 = json.encode({
			activityId = arg_19_2,
			taskId = arg_19_3,
			rechargeId = arg_19_1.id,
			rechargeType = arg_19_1.recharge_type
		})

		if not arg_19_4 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
				title = g.core.lang:get(1178),
				text = g.core.lang:get(1009, {
					name = g.core.common.Goods:convert({
						type = g.core.common.Goods.TYPE_ITEM,
						value = var_19_1
					}).name
				}),
				text_ok = g.core.lang:get(1153),
				text_cancel = g.core.lang:get(1147),
				info = arg_19_0,
				handler_ok = function()
					g.core.network.GameNetProxy:send_C2S_Item_Use({
						num = 1,
						id = var_19_1,
						extra = var_19_3
					})
				end
			}), {
				touchDisappear = true
			})
		else
			g.core.network.GameNetProxy:send_C2S_Item_Use({
				num = 1,
				id = var_19_1,
				extra = var_19_3
			})
		end
	else
		local var_19_4 = tonumber((g.core.platform.PlatformProxy:getGameId()))
		local var_19_5
		local var_19_6

		for iter_19_1, iter_19_2 in g.core.config.voucher_info.ipairs() do
			if var_19_4 == iter_19_2.country_id and var_19_2[iter_19_2.item_id] then
				var_19_5 = g.core.common.Goods:convert({
					type = g.core.common.Goods.TYPE_ITEM,
					value = iter_19_2.item_id
				})
				var_19_6 = iter_19_2

				break
			end
		end

		if var_19_5 and g.core.model.User.resourceData:getResourceById(({
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_VOUCHER_COIN_RESOURCE
		}).value) >= var_19_6.cost_value then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeVoucherPop").new({
				voucher = var_19_5,
				target = arg_19_1,
				recharge = {
					target = arg_19_0,
					rechargeInfo = arg_19_1,
					activityId = arg_19_2,
					taskId = arg_19_3
				}
			}), {
				touchDisappear = true
			})
		else
			g.core.service.ServiceManager:getServiceByName("CheckRechargeService"):addRechargeOrder({
				arg_19_1,
				{
					activityId = arg_19_2,
					taskId = arg_19_3
				}
			})
		end
	end
end

function var_0_0.doRechargeById(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = g.core.model.User.rechargeData:getRechargeInfoById(arg_21_1)
	local var_21_1 = g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE
	local var_21_2 = var_21_0.recharge_type
	local var_21_3 = var_21_0.recharge_type == g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.GOLD

	if var_21_0.recharge_type == g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.CARD or var_21_2 == var_21_1.SUBSCRIPTION then
		local var_21_4 = g.core.model.User.activityMonthCardData

		var_21_3 = g.core.model.User.activityMonthCardData:isExpireById(arg_21_1)

		if not var_21_3 then
			if var_21_4:canGetRewardById(arg_21_1) then
				if var_21_2 == var_21_1.CARD then
					g.core.network.GameNetProxy:send_C2S_Recharge_UseMonthCard({
						id = arg_21_1
					})
				else
					g.core.network.GameNetProxy:send_C2S_Recharge_UseSubRecharge({
						id = arg_21_1
					})
				end
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(1144))
			end

			return
		end
	end

	arg_21_3 = arg_21_3 or 0
	arg_21_4 = arg_21_4 or 0

	if var_21_3 and arg_21_2 ~= false then
		g.core.common.GlobalFunc.checkBagBeforeOpRecharge(arg_21_0, var_21_0, arg_21_3, arg_21_4)
	end
end

function var_0_0.checkFrameId()
	local var_22_0 = g.core.model.User:getFrameId()

	if var_22_0 ~= 0 then
		local var_22_1 = g.core.config.avatar_frame_info.get(var_22_0)

		if var_22_1 and var_22_1.time_type == 2 then
			local var_22_2 = g.core.model.User:getPropFrameById(var_22_0)

			if not var_22_2 or var_22_2.expired_time > 0 and var_22_2.expired_time < g.core.common.ServerTime:getTime() then
				g.core.network.GameNetProxy:send_C2S_ModifyUserInfo({
					type = 1,
					frame = 0
				})
			end
		end
	end
end

function var_0_0.checkAvatarId()
	local var_23_0 = g.core.model.User:getAvataId()

	if var_23_0 ~= 0 then
		local var_23_1 = g.core.config.avata_info.get(var_23_0)

		if var_23_1 and var_23_1.time_type == 2 then
			local var_23_2 = g.core.model.User:getPropHeadById(var_23_0)

			if not var_23_2 or var_23_2.expired_time > 0 and var_23_2.expired_time < g.core.common.ServerTime:getTime() then
				g.core.network.GameNetProxy:send_C2S_ModifyUserInfo({
					type = 3,
					frame = 0
				})
			end
		end
	end
end

function var_0_0.checkUserLimitTitle()
	local var_24_0 = {}
	local var_24_1 = 0

	for iter_24_0, iter_24_1 in pairs((clone(g.core.model.User:getAllWearingTitleIds()))) do
		if g.core.model.User.UserTitleData:isOwnTitle(iter_24_1) then
			table.insert(var_24_0, iter_24_1)
		end

		if iter_24_1 > 0 then
			var_24_1 = var_24_1 + 1
		end
	end

	if var_24_1 ~= #var_24_0 then
		for iter_24_2 = 1, require("app.view.module.user.const.UserConst").MAX_TITLE_SLOT do
			var_24_0[iter_24_2] = var_24_0[iter_24_2] or 0
		end

		g.core.network.GameNetProxy:send_C2S_Title_Wear({
			title_ids = var_24_0
		})
	end
end

function var_0_0.checkOwnItemBuy(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = g.core.common.Goods:checkGoodsIsOnly(arg_25_0, arg_25_1)

	if var_25_0 and g.core.model.User.bagData:getOwnNum(arg_25_0, arg_25_1) > 0 then
		local var_25_2 = g.core.common.Goods.CFG[arg_25_0].get(arg_25_1)

		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
			text = g.core.lang:get(1132, {
				name = string.format("[color=#%s]%s[/color]", g.core.common.Color.darkQualityEx[var_25_2.quality], var_25_2.name),
				icon = string.format("[color=#%s]%s[/color]", g.core.common.Color.darkQualityEx[var_25_1.quality], var_25_1.name),
				number = table.concat({
					"*",
					var_25_1.size
				})
			}),
			text_ok = g.core.lang:get(1160),
			text_cancel = g.core.lang:get(1037),
			handler_ok = function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SHOP_NEED_SHOW_CONVERT, false, {
					needConvert = true
				})

				if arg_25_2 then
					arg_25_2()
				end
			end
		})))
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SHOP_NEED_SHOW_CONVERT, false, {
			needConvert = false
		})

		if arg_25_2 then
			arg_25_2()
		end
	end
end

function var_0_0.isAlwaysShowEffect(arg_27_0)
	local var_27_0 = false

	for iter_27_0, iter_27_1 in ipairs({
		"effect_scene_guild_v2_jian",
		"effect_scene_guild_night_bg_jian"
	}) do
		if arg_27_0 == iter_27_1 then
			var_27_0 = true

			break
		end
	end

	return var_27_0
end

var_0_0.hotCall = nil

function var_0_0:setHotStatue()
	if not self then
		return
	end

	local var_28_0 = self.btn
	local var_28_1 = self.actInfo
	local var_28_2 = false

	if self.btn and var_28_1 and self.node then
		var_28_0:setVisible(var_28_1.hot_id and var_28_1.hot_id ~= 0)

		if var_28_1.hot_id and var_28_1.hot_id ~= 0 then
			function var_0_0.hotCall()
				return
			end

			var_28_0:addClickListener(var_0_0.hotCall)

			var_28_2 = true
		else
			var_0_0.hotCall = nil
			var_28_2 = false
		end

		local var_28_4 = var_28_0:getChild("Txt_des")
		local var_28_5 = var_28_0:getChild("Comp_icon")

		if var_28_4 then
			var_28_4:setText(var_28_1.toObject().hot_dsc or "not find hot_dsc")
		end

		if var_28_5 then
			local var_28_6 = {}

			for iter_28_0, iter_28_1 in g.core.config.activity_hot_info.ipairs() do
				if iter_28_1.hot_id == var_28_1.hot_id then
					table.insert(var_28_6, iter_28_1.toObject())
				end
			end

			if next(var_28_6) then
				var_28_5:updateIcon({
					overrideClick = true,
					effect = true,
					type = var_28_6[1].type,
					value = var_28_6[1].value,
					clickCall = var_0_0.hotCall
				})
			end
		end
	end

	return var_28_2
end

function var_0_0:autoOpenHotPop()
	local var_30_0 = self.actType or 0
	local var_30_1 = self.actId or 0
	local var_30_2 = self.subId or 0
	local var_30_3 = self.actName or ""
	local var_30_4 = g.core.common.Storage:load("hotpop.json") or {}
	local var_30_5 = table.concat({
		var_30_3,
		var_30_0,
		var_30_1,
		var_30_2
	})

	if not var_30_4[tostring(var_30_5)] then
		if var_0_0.hotCall then
			var_0_0.hotCall()
		end

		var_30_4[tostring(var_30_5)] = 1
	end

	g.core.common.Storage:save("hotpop.json", var_30_4)
end

function var_0_0.getDropAward(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs((g.core.config.drop_info.match(function(arg_32_0)
		return arg_32_0.id == arg_31_0
	end))) do
		for iter_31_2 = 1, 5 do
			-- block empty
		end
	end

	local var_31_0 = {}

	for iter_31_3, iter_31_4 in ipairs({}) do
		var_31_0[iter_31_4.type] = var_31_0[iter_31_4.type] or {}

		if not var_31_0[iter_31_4.type][iter_31_4.value] then
			var_31_0[iter_31_4.type][iter_31_4.value] = iter_31_4
		else
			var_31_0[iter_31_4.type][iter_31_4.value].size = var_31_0[iter_31_4.type][iter_31_4.value].size + iter_31_4.size
			var_31_0[iter_31_4.type][iter_31_4.value].max_size = var_31_0[iter_31_4.type][iter_31_4.value].max_size + iter_31_4.max_size
		end
	end

	local var_31_1 = {}

	for iter_31_5, iter_31_6 in pairs(var_31_0) do
		for iter_31_7, iter_31_8 in pairs(var_31_0[iter_31_5]) do
			iter_31_8.quality = g.core.common.Goods:convert(iter_31_8).quality

			table.insert(var_31_1, iter_31_8)
		end
	end

	table.sort(var_31_1, function(arg_33_0, arg_33_1)
		if arg_33_0.quality ~= arg_33_1.quality then
			return arg_33_0.quality > arg_33_1.quality
		end

		return false
	end)

	return var_31_1
end

function var_0_0:isOverflowIfAdd(arg_34_1)
	if arg_34_1 <= 0 then
		return false
	end

	local var_34_0 = self.type
	local var_34_1 = self.value
	local var_34_2 = 0

	for iter_34_0, iter_34_1 in g.core.config.basic_figure_info:ipairs() do
		if iter_34_1.type == var_34_0 and iter_34_1.value == var_34_1 then
			var_34_2 = iter_34_1.max_limit

			break
		end
	end

	if var_34_2 > 0 then
		return var_34_2 < g.core.model.User.resourceData:getResourceById(var_34_1) + arg_34_1
	end

	return false
end

function var_0_0.sortGridObjZOder(arg_35_0)
	local var_35_0 = {}
	local var_35_1 = {}

	if #arg_35_0 > 0 then
		var_35_0 = arg_35_0
	end

	for iter_35_0 = 1, #var_35_0 do
		table.insert(var_35_1, var_35_0[iter_35_0]:getPosList())
	end

	local function var_35_2(arg_36_0, arg_36_1)
		for iter_36_0 = 1, #arg_36_0 do
			for iter_36_1 = 1, #arg_36_1 do
				if arg_36_0[iter_36_0].x == arg_36_1[iter_36_1].x or arg_36_0[iter_36_0].y == arg_36_1[iter_36_1].y then
					if arg_36_0[iter_36_0].x + arg_36_0[iter_36_0].y > arg_36_1[iter_36_1].x + arg_36_1[iter_36_1].y then
						return 1
					elseif arg_36_0[iter_36_0].x + arg_36_0[iter_36_0].y < arg_36_1[iter_36_1].x + arg_36_1[iter_36_1].y then
						return 2
					end
				end
			end
		end

		return 0
	end

	local function var_35_3(arg_37_0, arg_37_1)
		local var_37_0 = var_35_2(arg_37_0, arg_37_1)

		if var_37_0 == 1 then
			return true
		elseif var_37_0 == 2 then
			return false
		end

		return false
	end

	local var_35_4 = {}

	for iter_35_1 = 1, #var_35_1 do
		for iter_35_2 = 1, #var_35_1 do
			var_35_4[iter_35_2] = var_35_4[iter_35_2] or {
				num = iter_35_2,
				cover = {}
			}

			if var_35_3(var_35_1[iter_35_1], var_35_1[iter_35_2]) then
				table.insert(var_35_4[iter_35_2].cover, iter_35_1)
			end
		end
	end

	local function var_35_5(arg_38_0)
		local var_38_0 = 0
		local var_38_1 = 0

		for iter_38_0 = 1, #arg_38_0 do
			var_38_0 = math.max(var_38_0, arg_38_0[iter_38_0].x)
			var_38_1 = math.max(var_38_1, arg_38_0[iter_38_0].y)
		end

		return var_38_0 + var_38_1
	end

	local function var_35_6(arg_39_0, arg_39_1)
		if arg_39_0.maxXY > arg_39_1.maxXY then
			return true
		end

		return false
	end

	local var_35_7 = {}

	local function var_35_9()
		local var_40_0 = 0
		local var_40_1 = {}

		for iter_40_0 = 1, #var_35_4 do
			if #var_35_4[iter_40_0].cover == 0 then
				var_40_0 = var_35_4[iter_40_0].num

				table.insert(var_40_1, {
					index = iter_40_0,
					num = var_35_4[iter_40_0].num,
					maxXY = var_35_5(var_35_1[var_35_4[iter_40_0].num])
				})
			end
		end

		table.sort(var_40_1, var_35_6)

		if #var_40_1 > 0 then
			var_40_0 = var_40_1[1].num

			table.insert(var_35_7, var_40_1[1].num)
			table.remove(var_35_4, var_40_1[1].index)
		end

		for iter_40_1 = 1, #var_35_4 do
			for iter_40_2 = 1, #var_35_4[iter_40_1].cover do
				if var_35_4[iter_40_1].cover[iter_40_2] == var_40_0 then
					table.remove(var_35_4[iter_40_1].cover, iter_40_2)
				end
			end
		end

		if #var_35_4 > 0 then
			if var_40_0 == 0 then
				return
			else
				var_35_9()
			end
		end
	end

	;(nil)()

	for iter_35_3 = 1, #var_35_7 do
		var_35_0[var_35_7[iter_35_3]]:setSortingOrder(1000 - iter_35_3 * 10)
	end
end

function var_0_0:checkAndGetRobotData()
	if not self then
		return false, {}
	end

	local function var_41_0(arg_42_0, arg_42_1, arg_42_2)
		local var_42_0 = {}

		while g.core.config[arg_42_0].hasKey(table.concat({
			arg_42_2,
			1
		})) do
			local var_42_2 = arg_42_1[table.concat({
				arg_42_2,
				1
			})]

			if var_42_2 > 0 then
				table.insert(var_42_0, var_42_2)
			end
		end

		return var_42_0
	end

	local var_41_1
	local var_41_2
	local var_41_3 = ""
	local var_41_4

	if self.robot_type and self.robot_type ~= 0 then
		if self.robot_type == 999 then
			local var_41_5 = g.core.config.arena_robot_info.get(self.base_id)

			var_41_2 = var_41_5.seen_knight
			var_41_3 = var_41_5.name
			var_41_1 = var_41_0("arena_robot_info", var_41_5, "knight_id_")
		elseif self.robot_type == 1000 then
			local var_41_6 = g.core.config.peakarena_robot_info.get(self.base_id)

			var_41_2 = var_41_6.seen_knight
			var_41_3 = var_41_6.name
			var_41_1 = var_41_0("peakarena_robot_info", var_41_6, "knight_id_")
		else
			local var_41_7 = g.core.config.robot_info.get(self.base_id)

			var_41_1 = var_41_0("monster_team_info", g.core.config.monster_team_info.get(var_41_7.monster_team_id, self.wave or 1), "monster_")
			var_41_3 = var_41_7.name
			var_41_2 = var_41_1[1]
			var_41_4 = var_41_7.res_id
		end
	end

	if var_41_2 == nil or var_41_1 == nil then
		return false, {}
	else
		return true, {
			robotKnights = var_41_1,
			robotName = var_41_3,
			showId = var_41_2,
			resId = var_41_4
		}
	end
end

function var_0_0.addCommonLoadingComp()
	local var_43_0 = fgui.UIPackage:createObject("base_new", "BaseCommonLoadingComp")

	var_43_0:setSize(display.width, display.height)
	var_43_0:setPivot(0.5, 0.5, true)
	var_43_0:setPosition(display.width / 2, display.height / 2)
	g.core.layer.LayerManager:getTopLayer():addChild(var_43_0)

	local var_43_1 = g.core.utils.Time.isNight()

	var_43_0:getController("isNight"):setSelectedIndex(var_43_1 and 1 or 0)
	var_43_0:getChild("bgImg"):setURL(g.core.common.Path:getLoadingDayAndNightBg(var_43_1))
	var_43_0:getChild("bgImg"):setScale(math.max(1, (math.max(display.width / 1638, display.height / 998))))

	local var_43_2 = require("app.view.module.loading.common.LoadingCommon").getCommonLoadingTextList()
	local var_43_3 = math.random(#var_43_2)

	var_43_0:getChild("title"):setText(var_43_2[var_43_3].title)
	var_43_0:getChild("descText"):setText(var_43_2[var_43_3].desc)
	var_43_0:getChild("iconImg"):setURL(var_43_2[var_43_3].groupIcon)

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		var_43_0:getChild("loadingText"):setVisible(false)
		var_43_0:getChild("loadingTextCN"):setVisible(true)
	end

	local var_43_4 = var_43_1 and 1 or 0

	var_43_0:getChild("effComp"):addEffectSpine({
		isLoop = true,
		name = "eff_ui_common_loading",
		anim = table.concat({
			"play_",
			var_43_1 and 1 or 0
		})
	})

	return var_43_0, (var_43_0:getTransition(table.concat({
		"enter_",
		var_43_4
	})))
end

function var_0_0.pushMatchServerPop(arg_44_0)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.MatchServerPop").new(arg_44_0), {
		ignoreTouch = false,
		touchDisappear = true
	})
end

function var_0_0.getChaosCode(arg_45_0)
	local var_45_1 = 0
	local var_45_3 = {
		string.char(0 + 90)
	}

	for iter_45_0 = 1, #arg_45_0 do
		var_45_1 = tonumber((string.sub(arg_45_0, iter_45_0, iter_45_0)))

		if -1 >= 0 then
			local var_45_4 = -1 - var_45_1

			if -1 - var_45_1 < 0 then
				var_45_4 = math.abs(var_45_4) + 16
			end

			var_45_3[#var_45_3 + 1] = string.char(var_45_4 + 90)
		end
	end

	return string.char(90 + var_45_1) .. table.concat(var_45_3, "")
end

function var_0_0.getIdStrByChaosCode(arg_46_0)
	local var_46_0 = string.byte((string.sub(arg_46_0, 1, 1))) - 90
	local var_46_1 = {
		var_46_0
	}
	local KsMath = require("app.core.utils.KsMath")

	for iter_46_0 = #arg_46_0, 3, -1 do
		local var_46_4 = string.byte((string.sub(arg_46_0, iter_46_0, iter_46_0))) - 90

		if KsMath.mathBitSignCheck(var_46_4, 4) then
			var_46_4 = -(var_46_4 - 16)
		end

		var_46_0 = var_46_0 + var_46_4

		table.insert(var_46_1, 1, var_46_0)
	end

	return (table.concat(var_46_1, ""))
end

function var_0_0.isGuildNameValid(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 ~= false and (g.core.utils.Black:isMatchText(arg_47_0) or string.find(arg_47_0, "*")) then
		g.core.module.ModuleManager:tip(g.core.lang:get(100201))

		return false
	end

	local var_47_1 = 0

	if arg_47_2 ~= false then
		local var_47_2

		var_47_2, var_47_1 = g.core.utils.String.checkChannelStr(arg_47_0)

		if var_47_2 then
			g.core.module.ModuleManager:tip(var_47_2)

			return
		end
	end

	if string.find(arg_47_0, "^%s+$") or arg_47_0 == "" or string.find(arg_47_0, "　") then
		g.core.module.ModuleManager:tip(g.core.lang:get(109520))

		return false
	end

	local var_47_3 = #string.gsub(arg_47_0, "[\x80-\xBF]", "") - var_47_1

	if var_47_3 < 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109521))

		return false
	elseif var_47_3 > 6 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109516))

		return false
	end

	return true
end

function var_0_0.getEmbryoByTypeAndValue(arg_48_0, arg_48_1)
	local var_48_0
	local var_48_1 = 0

	if arg_48_0 == g.core.common.Goods.TYPE_KNIGHT then
		local var_48_2 = g.core.model.User.knightsData:getKnightByAdvanceId(arg_48_1)

		if not var_48_2 then
			var_48_2 = require("app.view.module.knight.model.KnightStruct").new(arg_48_1)

			var_48_2:addCfgInfo((g.core.config.knight_info.get(arg_48_1)))
		end

		var_48_1 = var_48_2:getBaseId()
		var_48_0 = var_48_2
	elseif arg_48_0 == g.core.common.Goods.TYPE_ARTIFACT then
		local var_48_3 = g.core.model.User.artifactData:getArtifactByAdvacnceId(arg_48_1)

		if not var_48_3 then
			var_48_3 = require("app.view.module.artifact.model.ArtifactStruct").new(arg_48_1)

			var_48_3:setCfg((g.core.config.artifact_info.get(arg_48_1)))
		end

		var_48_1 = var_48_3:getArtifactBaseId()
		var_48_0 = var_48_3
	elseif arg_48_0 == g.core.common.Goods.TYPE_UNITETOKEN then
		local var_48_4 = g.core.model.User.uniteTokenData:getTokenByAdvId(arg_48_1) or require("app.view.module.uniteToken.model.UniteTokenStructData").new(arg_48_1)

		var_48_1 = var_48_4:getBaseId()
		var_48_0 = var_48_4
	elseif arg_48_0 == g.core.common.Goods.TYPE_PET then
		local var_48_5 = g.core.model.User.petsData:getPetByAdvanceId(arg_48_1)

		var_48_1 = var_48_5:getCfg().id
		var_48_0 = var_48_5
	elseif arg_48_0 == g.core.common.Goods.TYPE_SUCCUBA then
		local var_48_6 = g.core.model.User.succubaData:getSuccubaByAdvanceId(arg_48_1, true)

		var_48_1 = var_48_6:getCurStarCfg().id
		var_48_0 = var_48_6
	end

	return {
		embryoId = var_48_1,
		struct = var_48_0
	}
end

function var_0_0.getEmbryoNameByType(arg_49_0)
	local var_49_0 = 0

	if arg_49_0 == g.core.common.Goods.TYPE_KNIGHT then
		var_49_0 = 201
	elseif arg_49_0 == g.core.common.Goods.TYPE_ARTIFACT then
		var_49_0 = 202
	elseif arg_49_0 == g.core.common.Goods.TYPE_UNITETOKEN then
		var_49_0 = 203
	elseif arg_49_0 == g.core.common.Goods.TYPE_PET then
		var_49_0 = 204
	elseif arg_49_0 == g.core.common.Goods.TYPE_EQUIP then
		var_49_0 = 205
	elseif arg_49_0 == g.core.common.Goods.TYPE_TREASURE then
		var_49_0 = 206
	elseif arg_49_0 == g.core.common.Goods.TYPE_KNIGHT_SOUL then
		var_49_0 = 207
	elseif arg_49_0 == g.core.common.Goods.TYPE_SUCCUBA then
		var_49_0 = 208
	end

	return var_49_0 > 0 and g.core.lang:get(var_49_0) or ""
end

function var_0_0.getItemAdvIdByInfo(arg_50_0, arg_50_1)
	return (arg_50_0 == g.core.common.Goods.TYPE_ARTIFACT or nil) and (arg_50_1.advance_code or arg_50_1.advance_id)
end

function var_0_0.getSerIdByTypeAndStruct(arg_51_0, arg_51_1)
	local var_51_0

	if arg_51_0 == g.core.common.Goods.TYPE_UNITETOKEN then
		var_51_0 = arg_51_1:getServerId()
	elseif arg_51_0 == g.core.common.Goods.TYPE_KNIGHT then
		var_51_0 = arg_51_1:getServerId()
	elseif arg_51_0 == g.core.common.Goods.TYPE_PET then
		var_51_0 = arg_51_1:getSid()
	elseif arg_51_0 == g.core.common.Goods.TYPE_ARTIFACT then
		var_51_0 = arg_51_1:getServerOnlyId()
	elseif arg_51_0 == g.core.common.Goods.TYPE_SUCCUBA then
		var_51_0 = arg_51_1:getSid()
	end

	return var_51_0
end

function var_0_0.getStructByTypeAndValue(arg_52_0, arg_52_1)
	local var_52_0

	if arg_52_0 == g.core.common.Goods.TYPE_UNITETOKEN then
		var_52_0 = g.core.model.User.uniteTokenData:getTokenByAdvId(arg_52_1)
	elseif arg_52_0 == g.core.common.Goods.TYPE_KNIGHT then
		var_52_0 = g.core.model.User.knightsData:getKnightByAdvanceId(arg_52_1)
	elseif arg_52_0 == g.core.common.Goods.TYPE_PET then
		var_52_0 = g.core.model.User.petsData:getPetByAdvanceId(arg_52_1)
	elseif arg_52_0 == g.core.common.Goods.TYPE_ARTIFACT then
		var_52_0 = g.core.model.User.artifactData:getArtifactByAdvId(arg_52_1)
	elseif arg_52_0 == g.core.common.Goods.TYPE_SUCCUBA then
		var_52_0 = g.core.model.User.succubaData:getSuccubaByAdvanceId(arg_52_1)
	end

	return var_52_0
end

function var_0_0.getStructByTypeAndSerId(arg_53_0, arg_53_1)
	local var_53_0

	if arg_53_0 == g.core.common.Goods.TYPE_KNIGHT then
		var_53_0 = g.core.model.User.knightsData:getKnightById(arg_53_1)
	elseif arg_53_0 == g.core.common.Goods.TYPE_PET then
		var_53_0 = g.core.model.User.petsData:getPetBySid(arg_53_1)
	elseif arg_53_0 == g.core.common.Goods.TYPE_ARTIFACT then
		var_53_0 = g.core.model.User.artifactData:getArtifactBySid(arg_53_1)
	elseif arg_53_0 == g.core.common.Goods.TYPE_UNITETOKEN then
		var_53_0 = g.core.model.User.uniteTokenData:getTokenByRealServerId(arg_53_1)
	elseif arg_53_0 == g.core.common.Goods.TYPE_SUCCUBA then
		var_53_0 = g.core.model.User.succubaData:getSuccubaBySid(arg_53_1)
	end

	return var_53_0
end

function var_0_0.createCircleProgressBar(arg_54_0)
	local var_54_0 = cc.ProgressTimer:create((display.newSprite(arg_54_0)))

	var_54_0:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	var_54_0:setRotation(360)

	return var_54_0
end

function var_0_0.getRandomName()
	local rand2_surname_info = require("app.core.config.cfg.rand2_surname_info")
	local rand3_name_info = require("app.core.config.cfg.rand3_name_info")

	return (g.core.utils.String.subStringByShow(rand2_surname_info.indexOf(math.random((rand2_surname_info.getLength()))).surname .. rand3_name_info.indexOf(math.random((rand3_name_info.getLength())))[math.random(0, 2) < 1 and "name_boy" or "name_girl"], UserConst.MAX_NAME_SHOW_LEN))
end

function var_0_0.getHasItemAndStarNumByTypeAndValue(arg_56_0, arg_56_1)
	local var_56_0 = var_0_0.getStructByTypeAndValue(arg_56_0, arg_56_1)
	local var_56_1 = false
	local var_56_2 = 0

	if var_56_0 then
		var_56_1 = var_56_0:isOwn()

		if var_56_1 then
			if arg_56_0 == g.core.common.Goods.TYPE_KNIGHT then
				var_56_2 = var_56_0:getStarLv()
			elseif arg_56_0 == g.core.common.Goods.TYPE_ARTIFACT then
				var_56_2 = var_56_0:getStar()
			elseif arg_56_0 == g.core.common.Goods.TYPE_PET then
				var_56_2 = var_56_0:getStarNum()
			elseif arg_56_0 == g.core.common.Goods.TYPE_UNITETOKEN then
				var_56_2 = var_56_0:getStarLevel()
			elseif arg_56_0 == g.core.common.Goods.TYPE_SUCCUBA then
				var_56_2 = var_56_0:getStar()
			end
		end
	end

	return var_56_1, var_56_2
end

function var_0_0.getSlgSharePosContent(arg_57_0, arg_57_1, arg_57_2)
	return string.format("`%06d`%06d`%s`", arg_57_0, arg_57_1, arg_57_2)
end

function var_0_0.rankUnit_param(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_0 then
		return (require("app.core.network.ProtoBuilder"):decodeByMsgName(arg_58_1 or "RankParam", arg_58_2 and arg_58_0 or from_base64(arg_58_0)))
	end

	return {}
end

function var_0_0.mergeAwards(arg_59_0)
	local var_59_0 = {}
	local var_59_1 = {}

	for iter_59_0, iter_59_1 in ipairs(arg_59_0 or {}) do
		local var_59_2 = g.core.common.Goods:convert(iter_59_1)

		var_59_1[var_59_2.type .. var_59_2.value] = var_59_1[var_59_2.type .. var_59_2.value] or {
			size = 0,
			type = var_59_2.type,
			value = var_59_2.value
		}
		var_59_1[var_59_2.type .. var_59_2.value].size = var_59_1[var_59_2.type .. var_59_2.value].size + var_59_2.size
	end

	for iter_59_2, iter_59_3 in pairs(var_59_1) do
		table.insert(var_59_0, iter_59_3)
	end

	return var_59_0
end

function var_0_0:getRoleSkinParamsBySnapShot()
	local var_60_0 = {
		isMainRole = true
	}
	local var_60_1 = self.skin_part or {}

	for iter_60_0 = 1, g.core.const.ConstMgr.RoleSkinConst.MAX_PART_INDEX do
		local var_60_2 = var_60_1[iter_60_0] or 0

		if iter_60_0 == g.core.const.ConstMgr.RoleSkinConst.PART.CLOTH then
			if var_60_2 > 0 then
				var_60_0.resId = tonumber(g.core.config.role_skin_info.get(var_60_2).spine)
			else
				local var_60_3 = self.skin or 0

				var_60_0.resId = var_60_3 > 0 and g.core.config.knight_base_info.get(g.core.config.skin_info.get(var_60_3).res).fight_id or g.core.config.knight_info.get(self.base_id).advance_id
			end
		elseif iter_60_0 == g.core.const.ConstMgr.RoleSkinConst.PART.WEAPON then
			var_60_0.skinName = var_60_2 > 0 and g.core.config.role_skin_info.get(var_60_2).skin_name or "yuanpi_0"
		elseif iter_60_0 == g.core.const.ConstMgr.RoleSkinConst.PART.BACK then
			var_60_0.isShowBack = true

			if var_60_2 > 0 then
				local var_60_4 = g.core.config.role_skin_info.get(var_60_2)

				if var_60_4.spine ~= "0" then
					var_60_0.backName = var_60_4.spine or ""
				end

				var_60_0.backSkin = var_60_4.skin_name
			else
				var_60_0.backName = ""
				var_60_0.backSkin = ""
			end
		end
	end

	return var_60_0
end

function var_0_0.contactParamByString()
	return table.concat({
		...
	})
end

function var_0_0:showFloatCustomPanel(arg_62_1, arg_62_2, arg_62_3)
	local var_62_0 = g.core.layer.LayerManager:getSysTipLayer()
	local var_62_1 = var_62_0:getChild(arg_62_1)

	if var_62_1 then
		return var_62_0:removeChild(var_62_1)
	end

	arg_62_2:setName(arg_62_1)

	local var_62_2 = arg_62_2:getView()

	if arg_62_3 then
		var_62_2 = arg_62_2
	end

	local var_62_3 = self:localToGlobal(cc.p(0, 0))
	local var_62_4 = var_62_2:getWidth()
	local var_62_5 = var_62_2:getHeight()
	local var_62_6 = var_62_3.x + self:getWidth()

	if var_62_6 > display.cx then
		var_62_6 = var_62_3.x - var_62_4
	end

	local var_62_7 = var_62_3.y

	if var_62_3.y + var_62_5 > display.height then
		var_62_7 = var_62_3.y - var_62_5
	end

	if var_62_7 < 0 then
		var_62_7 = 0
	end

	var_62_2:setPosition(var_62_6, var_62_7)

	local var_62_8 = cc.rect(var_62_6, var_62_7, var_62_4, var_62_5)
	local var_62_9 = fgui.GComponent:create()

	var_62_9:setSize(display.width * 2, display.height * 2)
	var_62_9:setOpaque(true)
	var_62_9:setPivot(0.5, 0.5, true)
	var_62_9:setPosition(0, 0)

	local var_62_10 = cc.EventListenerKeyboard:create()

	var_62_10:registerScriptHandler(function()
		var_62_0:removeChild(arg_62_2)
	end, cc.Handler.EVENT_KEYBOARD_PRESSED)
	var_62_9:displayObject():getEventDispatcher():addEventListenerWithSceneGraphPriority(var_62_10, var_62_9:displayObject())
	var_62_9:addEventListener(fgui.UIEventType.TouchBegin, function(arg_64_0)
		if not cc.rectContainsPoint(var_62_8, (arg_64_0:getInput():getPosition())) then
			var_62_0:removeChild(arg_62_2)
		end
	end)
	arg_62_2:addChildAt(var_62_9, 0)

	return var_62_0:addChild(arg_62_2)
end

return var_0_0
