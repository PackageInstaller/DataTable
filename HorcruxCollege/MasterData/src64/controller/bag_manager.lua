local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local weapon_data = require("data.weapon_data")
local major_factor_data = require("data.major_factor_data")
local furniture_data = require("data.furniture_data")
local horcrux_data = require("data.horcrux_data")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")
local dormitory_manager = require("controller.dormitory_manager")
local var_0_9 = require("data.horcrux_data")
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local horcrux_manager = require("controller.horcrux_manager")
local var_0_13 = require("data.item_data")
local arena_manager = require("controller.arena_manager")
local var_0_15 = 1
local var_0_16 = 2
local var_0_17 = 3
local var_0_18 = 4
local var_0_19 = 5
local var_0_20 = 6
local var_0_21 = 7
local var_0_22 = 8
local var_0_24 = 10
local var_0_25 = 11
local var_0_26 = 19
local var_0_27 = 23
local var_0_28 = -1
local var_0_29 = {
	[kITEM_BREAK_IN] = true,
	[kITEM_WEAPON_UPGRADE] = true,
	[kITEM_GEM] = true,
	[kITEM_GIFT_BAG] = true,
	[kITEM_HORCRUX_CHIP] = true,
	[kITEM_SUPPLY] = true,
	[kITEM_GIFT] = true,
	[kITEM_GOLD_BAG] = true,
	[KITEM_DREAM_BOX] = true,
	[kITEM_GEM_BAG] = true,
	[kITEM_HELPGIRL_BAG] = true,
	[kITEM_BOX] = true,
	[kITEM_COMPONENT_GIFT] = true,
	[kITEM_BOSS_TICKET] = true,
	[kITEM_AWARD_TICKET] = true,
	[kITEM_ACTIVITY] = true,
	[KITEM_EXP_TICKET] = true,
	[kITEM_FOOD] = true,
	[kITEM_BASIC_MATRIAL] = true,
	[kITEM_MATRIAL] = true,
	[kITEM_DRAWING] = true,
	[kITEM_HORCRUX_DRAWING] = true,
	[KITEM_SKILL_BOOK] = true,
	[KITEM_SWIN_TICKET] = true,
	[KITEM_EXPLORE_CONSUME] = true,
	[KITEM_PLOT] = true,
	[kITEM_FURNITURE_GIFT] = true,
	[KITEM_MARK_GIFT] = true,
	[KITEM_SERVANT_RESET_TICKET] = true,
	[KITEM_LAB_SPEEDUP_TICKTE] = true,
	[KITEM_ACTIVITY_GIFT] = true,
	[KITEM_ACTIVITY_GIFT_FREE] = true,
	[KITEM_COURSE_CARD] = true,
	[kITEM_SERVANT] = true,
	[kITEM_SERVANT_CHIP] = true,
	[KITEM_SHOP_PACKAGE] = true,
	[KITEM_COUPONS] = true,
	[KITEM_STUPID_GIFT] = true,
	[KITEM_ACTIVITY_RETURN_BUFF] = true,
	[kITEM_CHOOSE_GIFT] = true,
	[KITEM_MARK_GIFT_SLIDER] = true,
	[kITEM_HORCRUX_EXE] = true,
	[KITEM_WORD_COLLECT_ITEM] = true,
	[kITEM_TOWERDEFENCE] = true,
	[kITEM_RANDOM_GIFT] = true,
	[KITEM_HORCRUX_ITEM] = true
}
local var_0_30 = {
	[kITEM_GIFT_BAG] = true,
	[kITEM_WEAPON_UPGRADE] = true
}
local var_0_31 = {
	[kITEM_BASIC_MATRIAL] = true,
	[kITEM_MATRIAL] = true,
	[kITEM_DRAWING] = true,
	[kITEM_HORCRUX_EXE] = true,
	[KITEM_HORCRUX_ITEM] = true
}
local var_0_32 = {
	[kITEM_HORCRUX_CHIP] = true
}
local var_0_33 = {
	[kITEM_CHOOSE_GIFT] = true,
	[kITEM_GIFT] = true,
	[kITEM_GEM_BAG] = true,
	[kITEM_HELPGIRL_BAG] = true,
	[kITEM_COMPONENT_GIFT] = true,
	[kITEM_FURNITURE_GIFT] = true,
	[kITEM_SUPPLY] = true,
	[kITEM_SKIN_GIFT] = true,
	[KITEM_MARK_GIFT] = true,
	[KITEM_ACTIVITY_GIFT] = true,
	[KITEM_ACTIVITY_GIFT_FREE] = true,
	[KITEM_MARK_GIFT_SLIDER] = true,
	[KITEM_DREAM_BOX] = true,
	[KITEM_STUPID_GIFT] = true,
	[KITEM_EXP_TICKET] = true,
	[kITEM_GOLD_BAG] = true,
	[KITEM_ACTIVITY_RETURN_BUFF] = true,
	[kITEM_BOX] = true
}
local var_0_34 = {
	[kITEM_ACTIVITY] = true,
	[KITEM_COUPONS] = true
}
local var_0_35 = {
	[KITEM_SERVANT_RESET_TICKET] = true,
	[KITEM_EXPLORE_CONSUME] = true,
	[KITEM_PLOT] = true,
	[kITEM_BOSS_TICKET] = true,
	[KITEM_SWIN_TICKET] = true,
	[KITEM_LAB_SPEEDUP_TICKTE] = true,
	[KITEM_COURSE_CARD] = true,
	[kITEM_AWARD_TICKET] = true,
	[kITEM_AWARD_TICKET] = true
}
local var_0_37 = {
	[kITEM_FURNITURE] = true
}
local var_0_38 = {
	[kITEM_GIFT_FOR_FRIEND] = true,
	[KITEM_RING] = true,
	[kITEM_RING_MARRY] = true
}
local var_0_39 = {}
local var_0_40 = false

local function var_0_41(arg_1_0)
	if not var_0_40 then
		for iter_1_0, iter_1_1 in pairs((require("data.twist_config_data"))) do
			if iter_1_1.once_twist_ticket then
				var_0_39[iter_1_1.once_twist_ticket] = true
			end
		end

		var_0_40 = true
	end

	if var_0_39[arg_1_0] then
		return kITEM_ACTIVITY
	end
end

local var_0_42 = {
	[4100101] = kITEM_BASIC_MATRIAL
}

setmetatable(var_0_42, {
	__index = function(arg_2_0, arg_2_1)
		return var_0_41(arg_2_1)
	end
})

local BagManager = class("BagManager")

function BagManager:create()
	return (BagManager.new())
end

function BagManager:init(arg_4_1, arg_4_2)
	self.allData = {}

	for iter_4_0, iter_4_1 in pairs(playermodel.items) do
		local var_4_0 = var_0_42[iter_4_1.itemid] or iter_4_1.itemtype

		if item_data[iter_4_1.itemid].is_hide_bag ~= 1 then
			if (arg_4_1 == var_0_19 or arg_4_1 == var_0_27) and var_4_0 == kITEM_HORCRUX then
				if not iter_4_1.horcrux_attr.owner or iter_4_1.horcrux_attr.owner <= 0 then
					local var_4_1 = {}

					var_4_1.horcruxtype = horcrux_data[iter_4_1.itemid].horcruxtype
					var_4_1.attr = horcrux_manager:getHorcruxFilterAttr(iter_4_1.itemid)
					var_4_1.stars = iter_4_1.horcrux_attr.star
					var_4_1.rarity = horcrux_data[iter_4_1.itemid].rarity
					var_4_1.level = iter_4_1.horcrux_attr.hlv
					var_4_1.grade = horcrux_manager:getHorcruxHClass(iter_4_1.entityid)
					var_4_1.hfac = horcrux_manager:getHorcruxHpFac(iter_4_1.entityid)
					var_4_1.dfac = horcrux_manager:getHorcruxDamageFac(iter_4_1.entityid)
					var_4_1.type = horcrux_data[iter_4_1.itemid].select_type
					var_4_1.id = iter_4_1.entityid
					var_4_1.itemid = iter_4_1.itemid

					local var_4_2 = horcrux_manager:getHorcruxAssistConfig(iter_4_1.entityid)

					var_4_1.damage = var_4_2.damage
					var_4_1.hp = var_4_2.hp
					var_4_1.hasOwner = playermodel.horcruxServants[iter_4_1.entityid] and 1 or 2

					if self.calculateHorcruxScore then
						var_4_1.recommendScore = horcrux_manager:calculateHorcruxScore(iter_4_1.entityid, self.needRecommendServant)
					end

					table.insert(self.allData, var_4_1)
				end

				table.insert(self.allData, tbl)
			end

			if arg_4_1 == var_0_15 and (var_4_0 == kITEM_COMPONENT or var_4_0 == kITEM_COMPONENT_BOX or var_4_0 == kITEM_COMPONENT_CHIP or var_4_0 == Kitem_component_BOX_B) then
				local var_4_3 = {
					soulid = item_data[iter_4_1.itemid].equip_condition
				}

				var_4_3.component_attr_effect = iter_4_1.component_attr and iter_4_1.component_attr.effect
				var_4_3.lock = iter_4_1.component_attr and iter_4_1.component_attr.lock
				var_4_3.use = iter_4_1.component_attr and iter_4_1.component_attr.use
				var_4_3.component_quality = item_data[iter_4_1.itemid].equip_quality
				var_4_3.main_attr = item_data[iter_4_1.itemid].main_attr

				if not var_4_3.main_attr and playermodel.items[iter_4_1.entityid] and playermodel.items[iter_4_1.entityid].component_attr and playermodel.items[iter_4_1.entityid].component_attr.attr2 then
					var_4_3.main_attr = playermodel.items[iter_4_1.entityid].component_attr.attr1
				end

				if item_data[iter_4_1.itemid].main_attr == 7 or item_data[iter_4_1.itemid].main_attr == 10 then
					var_4_3.main_attr = "defence"
				end

				if item_data[iter_4_1.itemid].equip_quality == 6 then
					var_4_3.main_attr = "sp"
				end

				var_4_3.extra = iter_4_1.component_attr and iter_4_1.component_attr.extra
				var_4_3.entityid = iter_4_1.entityid
				var_4_3.equip_quality = item_data[iter_4_1.itemid].equip_quality
				var_4_3.level = item_data[iter_4_1.itemid].level
				var_4_3.pos = item_data[iter_4_1.itemid].pos
				var_4_3.score = var_4_0 == kITEM_COMPONENT and component_manager:getPotential(iter_4_1.entityid) or 0
				var_4_3.order = ({
					[kITEM_COMPONENT] = 1,
					[kITEM_COMPONENT_CHIP] = 2,
					[kITEM_COMPONENT_BOX] = 3,
					[Kitem_component_BOX_B] = 4
				})[var_4_0] or 0
				var_4_3.id = iter_4_1.entityid

				if not self.hideItems or not self.hideItems[iter_4_1.entityid] then
					table.insert(self.allData, var_4_3)
				end
			end

			if arg_4_1 == var_0_25 and var_4_0 == kITEM_COMPONENT then
				local var_4_4 = {
					soulid = item_data[iter_4_1.itemid].equip_condition
				}

				var_4_4.component_attr_effect = iter_4_1.component_attr and iter_4_1.component_attr.effect
				var_4_4.lock = iter_4_1.component_attr and iter_4_1.component_attr.lock
				var_4_4.use = iter_4_1.component_attr and iter_4_1.component_attr.use
				var_4_4.component_quality = item_data[iter_4_1.itemid].equip_quality
				var_4_4.main_attr = var_0_13[iter_4_1.itemid] and var_0_13[iter_4_1.itemid].main_attr

				if not var_4_4.main_attr and playermodel.items[iter_4_1.entityid] and playermodel.items[iter_4_1.entityid].component_attr and playermodel.items[iter_4_1.entityid].component_attr.attr2 then
					var_4_4.main_attr = playermodel.items[iter_4_1.entityid].component_attr.attr1
				end

				if not ({
					nil,
					true,
					true,
					true,
					true,
					true,
					true,
					nil,
					nil,
					true,
					nil,
					nil,
					true
				})[(not item_data[iter_4_1.itemid].main_attr and playermodel.items[iter_4_1.entityid] and playermodel.items[iter_4_1.entityid].component_attr and playermodel.items[iter_4_1.entityid].component_attr.attr2 or nil) and playermodel.items[iter_4_1.entityid].component_attr.attr1] then
					var_4_4.main_attr = "other"
				end

				var_4_4.extra = iter_4_1.component_attr and iter_4_1.component_attr.extra
				var_4_4.entityid = iter_4_1.entityid
				var_4_4.equip_quality = item_data[iter_4_1.itemid].equip_quality
				var_4_4.level = item_data[iter_4_1.itemid].level
				var_4_4.pos = item_data[iter_4_1.itemid].pos
				var_4_4.score = var_4_0 == kITEM_COMPONENT and component_manager:getPotential(iter_4_1.entityid) or 0
				var_4_4.order = ({
					[kITEM_COMPONENT] = 1,
					[kITEM_COMPONENT_CHIP] = 2,
					[kITEM_COMPONENT_BOX] = 3
				})[var_4_0] or 0
				var_4_4.id = iter_4_1.entityid

				if arg_4_1 == var_0_25 then
					table.insert(self.allData, var_4_4)
				else
					table.insert(self.allData, var_4_4)
				end
			end

			if arg_4_1 == var_0_16 then
				if var_0_29[var_4_0] then
					if var_0_30[var_4_0] then
						local var_4_6 = {
							number = iter_4_1.number,
							equip_quality = item_data[iter_4_1.itemid].equip_quality
						}

						var_4_6.sale_price = item_data[iter_4_1.itemid].sale_price or nil
						var_4_6.type = "breakout_item"
						var_4_6.is_sale = not not item_data[iter_4_1.itemid].sale_price
						var_4_6.id = iter_4_1.itemid

						if arg_4_2 == 1 then
							table.insert(self.allData, var_4_6)
						end

						local var_4_7 = true
					end

					if var_0_33[var_4_0] then
						local var_4_8 = {
							number = iter_4_1.number,
							equip_quality = item_data[iter_4_1.itemid].equip_quality
						}

						var_4_8.sale_price = item_data[iter_4_1.itemid].sale_price or nil
						var_4_8.type = "consume"
						var_4_8.is_sale = not not item_data[iter_4_1.itemid].sale_price
						var_4_8.id = iter_4_1.itemid

						if arg_4_2 == 1 then
							table.insert(self.allData, var_4_8)
						end

						var_4_7 = true
					end

					if var_0_34[var_4_0] then
						local var_4_9 = {
							number = iter_4_1.number,
							equip_quality = item_data[iter_4_1.itemid].equip_quality
						}

						var_4_9.sale_price = item_data[iter_4_1.itemid].sale_price or nil
						var_4_9.type = "activity_item"
						var_4_9.is_sale = not not item_data[iter_4_1.itemid].sale_price
						var_4_9.id = iter_4_1.itemid

						if arg_4_2 == 1 then
							table.insert(self.allData, var_4_9)
						end

						var_4_7 = true
					end

					if var_0_35[var_4_0] then
						local var_4_10 = {
							number = iter_4_1.number,
							equip_quality = item_data[iter_4_1.itemid].equip_quality
						}

						var_4_10.sale_price = item_data[iter_4_1.itemid].sale_price or nil
						var_4_10.type = "special_supply"
						var_4_10.is_sale = not not item_data[iter_4_1.itemid].sale_price
						var_4_10.id = iter_4_1.itemid

						if arg_4_2 == 1 then
							table.insert(self.allData, var_4_10)
						end

						var_4_7 = true
					end

					if var_0_32[var_4_0] then
						local var_4_11 = {
							number = iter_4_1.number,
							equip_quality = item_data[iter_4_1.itemid].equip_quality
						}

						var_4_11.sale_price = item_data[iter_4_1.itemid].sale_price or nil
						var_4_11.type = "piece"
						var_4_11.is_sale = not not item_data[iter_4_1.itemid].sale_price
						var_4_11.id = iter_4_1.itemid

						if arg_4_2 == 2 then
							table.insert(self.allData, var_4_11)
						end

						var_4_7 = true
					end

					if var_0_31[var_4_0] then
						local var_4_12 = {
							number = iter_4_1.number,
							equip_quality = item_data[iter_4_1.itemid].equip_quality
						}

						var_4_12.sale_price = item_data[iter_4_1.itemid].sale_price or nil
						var_4_12.type = "lab_matrial"
						var_4_12.is_sale = not not item_data[iter_4_1.itemid].sale_price
						var_4_12.id = iter_4_1.itemid

						if arg_4_2 == 2 then
							table.insert(self.allData, var_4_12)
						end

						var_4_7 = true
					end

					if not false and var_4_0 ~= kITEM_ACTIVITY then
						local var_4_13 = {
							number = iter_4_1.number,
							equip_quality = item_data[iter_4_1.itemid].equip_quality
						}

						var_4_13.sale_price = item_data[iter_4_1.itemid].sale_price or nil
						var_4_13.type = "other"
						var_4_13.id = iter_4_1.itemid
						var_4_13.is_sale = not not item_data[iter_4_1.itemid].sale_price

						if arg_4_2 == 1 then
							table.insert(self.allData, var_4_13)
						end
					end
				end
			end

			if arg_4_1 == var_0_26 and var_4_0 == KITEM_AI_MONSTER then
				local var_4_14 = {
					number = iter_4_1.number,
					equip_quality = item_data[iter_4_1.itemid].equip_quality
				}

				var_4_14.sale_price = item_data[iter_4_1.itemid].sale_price or nil
				var_4_14.group = item_data[iter_4_1.itemid].group or 1
				var_4_14.is_sale = not not item_data[iter_4_1.itemid].sale_price
				var_4_14.id = iter_4_1.itemid

				table.insert(self.allData, var_4_14)
			end

			if arg_4_1 == var_0_17 then
				if var_0_37[var_4_0] and dormitory_manager:getLeftoverFurniture(iter_4_1.itemid) > 0 then
					local var_4_15 = {
						sale_price = item_data[iter_4_1.itemid].sale_price,
						number = dormitory_manager:getLeftoverFurniture(iter_4_1.itemid),
						equip_quality = item_data[iter_4_1.itemid].equip_quality,
						is_sale = item_data[iter_4_1.itemid].sale_price and true or false
					}

					var_4_15.type = "furniture"
					var_4_15.id = iter_4_1.itemid

					table.insert(self.allData, var_4_15)
				end

				if var_0_38[var_4_0] then
					local var_4_16 = {
						sale_price = item_data[iter_4_1.itemid].sale_price,
						number = iter_4_1.number,
						equip_quality = item_data[iter_4_1.itemid].equip_quality,
						is_sale = item_data[iter_4_1.itemid].sale_price and true or false
					}

					var_4_16.type = "gift"
					var_4_16.id = iter_4_1.itemid

					table.insert(self.allData, var_4_16)
				end

				if var_4_0 == kITEM_SKIN and not item_data[iter_4_1.itemid].skin_hide then
					local var_4_17 = {
						sale_price = item_data[iter_4_1.itemid].sale_price,
						number = iter_4_1.number,
						equip_quality = item_data[iter_4_1.itemid].equip_quality,
						is_sale = item_data[iter_4_1.itemid].sale_price and true or false
					}

					var_4_17.type = "skin"
					var_4_17.id = iter_4_1.itemid

					table.insert(self.allData, var_4_17)
				end
			end

			if arg_4_1 == var_0_18 and var_4_0 == kITEM_WEAPON then
				local var_4_18 = {
					equip_quality = item_data[iter_4_1.itemid].equip_quality,
					level = iter_4_1.weapon_attr.level,
					nowStars = iter_4_1.weapon_attr.nowStars,
					lock = iter_4_1.weapon_attr.lock,
					use = iter_4_1.weapon_attr.use,
					servantid = item_data[iter_4_1.itemid].servant,
					itemid = iter_4_1.itemid,
					preserves = item_data[iter_4_1.itemid].servant and "special" or "all"
				}

				var_4_18.career = var_4_18.preserves == "special" and servant_data[item_data[iter_4_1.itemid].servant].career or "all"
				var_4_18.id = iter_4_1.entityid

				table.insert(self.allData, var_4_18)
			end

			if arg_4_1 == var_0_20 and var_4_0 == kITEM_WEAPON_EXP then
				table.insert(self.allData, {
					number = iter_4_1.number,
					equip_quality = item_data[iter_4_1.itemid].equip_quality,
					weaponType = item_data[iter_4_1.itemid].mechanical_or_energy,
					id = iter_4_1.itemid
				})
			end

			if arg_4_1 == var_0_21 and var_4_0 == kITEM_FURNITURE then
				local var_4_19 = require("controller.dormitory_manager"):getUsedFurniture()

				if var_4_19[iter_4_1.itemid] then
					if var_4_19[iter_4_1.itemid] < iter_4_1.number then
						table.insert(self.allData, {
							sale_price = item_data[iter_4_1.itemid].sale_price,
							number = dormitory_manager:getLeftoverFurniture(iter_4_1.itemid),
							equip_quality = item_data[iter_4_1.itemid].equip_quality,
							type = item_data[iter_4_1.itemid].furniture_type,
							id = iter_4_1.itemid
						})
					end

					if arg_4_1 == var_0_22 and var_4_0 == kITEM_MEDAL then
						local var_4_20 = {}

						var_4_20.number = 1
						var_4_20.equip_quality = item_data[iter_4_1.itemid].equip_quality
						var_4_20.id = iter_4_1.itemid

						local var_4_22 = false

						for iter_4_2, iter_4_3 in pairs(playermodel.cur_medal) do
							if iter_4_1.itemid == iter_4_3 then
								var_4_20.pos = iter_4_2
								var_4_22 = true

								break
							end
						end

						if not var_4_22 then
							var_4_20.pos = "all"
						end

						table.insert(self.allData, var_4_20)
					end

					if arg_4_1 == var_0_24 and (var_4_0 == kITEM_DRAWING or var_4_0 == kITEM_HORCRUX_DRAWING) then
						local var_4_23 = {
							number = iter_4_1.number,
							equip_quality = item_data[iter_4_1.itemid].equip_quality
						}

						var_4_23.type = "drawing"
						var_4_23.id = iter_4_1.itemid

						table.insert(self.allData, var_4_23)
					end
				end
			end
		end
	end

	local time_check_manager = require("controller.time_check_manager")

	for iter_4_4, iter_4_5 in pairs(self.allData) do
		if item_data[iter_4_5.itemid].overdue_time and time_check_manager:getCurTime() > os.time(parse_time(item_data[iter_4_5.itemid].overdue_time)) then
			table.remove(self.allData, iter_4_4)
		end
	end
end

function BagManager:update()
	if self.bagType then
		self:init(self.bagType, self.bagType_partition)
		self:sortData(self.allData, self.sortType, self.sortOrder)
	end
end

function BagManager:getDataOfId(arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		var_6_0[iter_6_1] = iter_6_1
	end

	for iter_6_2, iter_6_3 in pairs(self.allData) do
		if var_6_0[iter_6_3.id] then
			arg_6_2[#arg_6_2 + 1] = global_deepCopy(iter_6_3)
		end
	end
end

function BagManager:clear()
	self = nil
end

function BagManager:getBagData(arg_8_1, arg_8_2)
	self.sortOrder = arg_8_1.sortOrder or 0
	self.bagType = self.bagType or nil
	self.servantid = arg_8_1.servantid

	if self.bagType ~= arg_8_1.bag_type or self.bagType_partition ~= arg_8_1.bagType_partition then
		self.bagType_partition = arg_8_1.bagType_partition
		self.bagType = arg_8_1.bag_type

		self:init(self.bagType, self.bagType_partition)

		self.sortType = arg_8_1.sortType

		if self.calculateHorcruxScore then
			self:calculateRecommendHorcruxs(self.allData, arg_8_1.outSide)
		end

		if next(self.allData) then
			self:sortData(self.allData, self.sortType, self.sortOrder)
		end
	elseif self.sortType ~= arg_8_1.sortType or self.sortOrder ~= self.oldSortOrder then
		self.sortType = arg_8_1.sortType

		if next(self.allData) then
			self:sortData(self.allData, self.sortType, self.sortOrder)
		end
	end

	self.oldSortOrder = self.sortOrder
	self.outSide = {}

	if arg_8_1.outSide then
		for iter_8_0, iter_8_1 in pairs(arg_8_1.outSide) do
			self.outSide[iter_8_1] = iter_8_1
		end
	end

	local function var_8_0(arg_9_0, arg_9_1)
		for iter_9_0, iter_9_1 in pairs(arg_9_0) do
			if iter_9_1 == arg_9_1 then
				return iter_9_0
			end
		end

		return false
	end

	local var_8_1 = true

	for iter_8_2, iter_8_3 in pairs(arg_8_1.filterConfig) do
		if next(iter_8_3) then
			var_8_1 = false
		end
	end

	self.resultData = {}

	local function var_8_2(arg_10_0)
		local var_10_0 = {
			s = 0.75,
			a = 0.5,
			s_plus = 0.95,
			b_minus = 0.1,
			b_plus = 0.3,
			a_minus = 0.4,
			b = 0.2,
			c = 0,
			a_puls = 0.65
		}
		local var_10_1 = 0

		if arg_8_1.hfac then
			local var_10_2 = horcrux_manager:getHorcruxHpFacSectionGrade(arg_10_0)

			for iter_10_0, iter_10_1 in ipairs(arg_8_1.hfac) do
				if iter_10_1 >= var_10_0[var_10_2] then
					var_10_1 = var_10_1 + 1

					break
				end
			end

			if var_10_1 == 0 then
				return false
			end
		end

		local var_10_3 = 0

		if arg_8_1.dfac then
			local var_10_4 = horcrux_manager:getHorcruxDamageFacSectionGrade(arg_10_0)

			for iter_10_2, iter_10_3 in ipairs(arg_8_1.dfac) do
				if iter_10_3 >= var_10_0[var_10_4] then
					var_10_3 = var_10_3 + 1

					break
				end
			end

			if var_10_3 == 0 then
				return false
			end
		end

		return true
	end

	local var_8_3 = {}

	for iter_8_4, iter_8_5 in ipairs(self.allData) do
		local var_8_4 = true
		local var_8_5 = true

		if arg_8_1.insertHandel and arg_8_1.insertHandel(iter_8_5.id) then
			var_8_4 = true
			var_8_5 = true
		else
			if not var_8_2(iter_8_5.id) then
				var_8_4 = false
				var_8_5 = false
			end

			for iter_8_6, iter_8_7 in pairs(iter_8_5) do
				if not var_8_4 then
					break
				end

				if not arg_8_1.filterConfig[iter_8_6] then
					var_8_4 = true
					var_8_5 = true
				end

				if self.outSide[iter_8_5.id] then
					var_8_4 = false
					var_8_5 = false

					break
				end

				if not arg_8_1.filterConfig or arg_8_1.filterConfig and arg_8_1.filterConfig[iter_8_6] and var_8_1 then
					break
				end

				if arg_8_1.filterConfig and arg_8_1.filterConfig[iter_8_6] and next(arg_8_1.filterConfig[iter_8_6]) and var_8_4 and not var_8_1 and iter_8_6 ~= "pos" then
					var_8_4 = var_8_0(arg_8_1.filterConfig[iter_8_6], iter_8_7)
					var_8_5 = var_8_0(arg_8_1.filterConfig[iter_8_6], iter_8_7)
				elseif arg_8_1.filterConfig and arg_8_1.filterConfig[iter_8_6] and next(arg_8_1.filterConfig[iter_8_6]) and var_8_4 and not var_8_1 and iter_8_6 == "pos" then
					var_8_4 = var_8_0(arg_8_1.filterConfig[iter_8_6], iter_8_7)
				end
			end
		end

		if var_8_4 then
			table.insert(self.resultData, iter_8_5.id)
		end

		if var_8_5 then
			table.insert(var_8_3, iter_8_5.id)
		end
	end

	self.resultData = self:get__hold_array_data(arg_8_2, self.resultData)

	return self.resultData, var_8_3
end

function BagManager:dealWithSelectData(arg_11_1)
	local var_11_0 = {}
	local var_11_1

	for iter_11_0, iter_11_1 in pairs(self.allData) do
		if iter_11_1.id == arg_11_1 then
			var_11_1 = iter_11_1

			break
		end
	end

	if var_11_1 == nil then
		return
	end

	local var_11_2 = var_11_1.stars

	for iter_11_2, iter_11_3 in pairs(self.resultData) do
		local var_11_3

		for iter_11_4, iter_11_5 in pairs(self.allData) do
			if iter_11_5.id == iter_11_3 then
				var_11_3 = iter_11_5

				break
			end
		end

		if var_11_3 and var_11_2 >= var_11_3.stars then
			table.insert(var_11_0, iter_11_3)
		end
	end

	self.resultData = var_11_0
	self.filterData = self.resultData
end

function BagManager:removeValue(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		var_12_0[iter_12_1] = true
	end

	while 1 <= #self.resultData do
		local var_12_1

		if var_12_0[self.resultData[1]] then
			table.remove(self.resultData, 1)
		else
			var_12_1 = 1 + 1
		end
	end
end

function BagManager:sortData(arg_13_1, arg_13_2, arg_13_3)
	({
		[var_0_15] = BagManager.sortComponentsByType,
		[var_0_25] = BagManager.sortComponentsByType,
		[var_0_16] = BagManager.sortResourceByType,
		[var_0_26] = BagManager.sortResourceByType,
		[var_0_17] = BagManager.sortFumitureByType,
		[var_0_18] = BagManager.sortWeapon,
		[var_0_19] = BagManager.sortHorcrux,
		[var_0_20] = BagManager.sortResourceByType,
		[var_0_21] = BagManager.sortFumitureByType,
		[var_0_22] = BagManager.sortResourceByType,
		[var_0_24] = BagManager.sortResourceByType,
		[var_0_27] = BagManager.sortHorcruxUpstar
	})[self.bagType](arg_13_1, arg_13_2, arg_13_3, self)
end

function BagManager:sortComponentsByType(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}

	var_14_0.all = 0

	for iter_14_0 = 1, TOTAL_SOUL_COUNT do
		var_14_0["soul_" .. iter_14_0] = iter_14_0
	end

	local var_14_1 = {
		[6] = {
			weight = 1,
			func = function(self, arg_15_1)
				if arg_14_2 == 0 then
					return playermodel.items[self.id].itemid < playermodel.items[arg_15_1.id].itemid
				else
					return playermodel.items[self.id].itemid > playermodel.items[arg_15_1.id].itemid
				end
			end
		},
		[5] = {
			weight = 4,
			func = function(self, arg_19_1)
				if not self.soulid or not arg_19_1.soulid then
					return "=="
				end

				if self.soulid == arg_19_1.soulid then
					return "=="
				elseif arg_14_2 == 0 then
					return var_14_0[self.soulid] < var_14_0[arg_19_1.soulid]
				else
					return var_14_0[self.soulid] > var_14_0[arg_19_1.soulid]
				end
			end
		},
		[4] = {
			weight = 2,
			func = function(self, arg_18_1)
				if not self.pos or not arg_18_1.pos then
					return "=="
				end

				if self.pos == arg_18_1.pos then
					return "=="
				elseif arg_14_2 == 0 then
					return self.pos < arg_18_1.pos
				else
					return self.pos > arg_18_1.pos
				end
			end
		},
		[3] = {
			weight = 3,
			func = function(self, arg_16_1)
				if not self.extra or not arg_16_1.extra then
					return "=="
				end

				if self.extra == arg_16_1.extra then
					return "=="
				elseif arg_14_2 == 0 then
					return self.extra < arg_16_1.extra
				else
					return self.extra > arg_16_1.extra
				end
			end
		},
		{
			weight = 6,
			func = function(self, arg_17_1)
				if not self.equip_quality or not arg_17_1.equip_quality then
					return "=="
				end

				if self.equip_quality == arg_17_1.equip_quality then
					return "=="
				elseif arg_14_2 == 0 then
					return self.equip_quality < arg_17_1.equip_quality
				else
					return self.equip_quality > arg_17_1.equip_quality
				end
			end
		},
		{
			weight = 5,
			func = function(self, arg_20_1)
				if not self.score or not arg_20_1.score then
					return "=="
				end

				if self.score == arg_20_1.score then
					return "=="
				elseif arg_14_2 == 0 then
					return self.score < arg_20_1.score
				else
					return self.score > arg_20_1.score
				end
			end
		},
		[7] = {
			weight = 1000,
			func = function(self, arg_21_1)
				if not self.order or not arg_21_1.order then
					return "=="
				end

				if self.order == arg_21_1.order then
					return "=="
				elseif arg_14_2 == 0 then
					return self.order < arg_21_1.order
				else
					return self.order > arg_21_1.order
				end
			end
		},
		[8] = {
			weight = 10000,
			func = function(self, arg_22_1)
				if arg_14_3.bagType == var_0_25 then
					local var_22_0 = self.use and 0 or 1
					local var_22_1 = arg_22_1.use and 0 or 1

					if (self.use and 0 or 1) == (arg_22_1.use and 0 or 1) then
						return "=="
					end

					if arg_14_2 == 0 then
						return var_22_1 < var_22_0
					else
						return var_22_1 < var_22_0
					end
				else
					return "=="
				end
			end
		},
		[9] = {
			weight = 100,
			func = function(self, arg_23_1)
				if arg_14_3.bagType == var_0_25 then
					local var_23_0 = playermodel.items[self.entityid].component_attr.attr2 and 0 or 1
					local var_23_1 = playermodel.items[self.entityid].component_attr.attr2 and 0 or 1

					if (playermodel.items[self.entityid].component_attr.attr2 and 0 or 1) == (playermodel.items[self.entityid].component_attr.attr2 and 0 or 1) then
						return "=="
					end

					return var_23_1 < var_23_0
				else
					return "=="
				end
			end
		}
	}

	var_14_1[arg_14_1].weight = var_14_1[arg_14_1].weight + 10

	table.sort(var_14_1, function(arg_24_0, arg_24_1)
		return arg_24_0.weight > arg_24_1.weight
	end)
	table.sort(self, function(arg_25_0, arg_25_1)
		for iter_25_0 = 1, #var_14_1 do
			local var_25_0 = var_14_1[iter_25_0].func(arg_25_0, arg_25_1)

			if var_25_0 ~= "==" then
				return var_25_0
			end
		end
	end)

	return self
end

function BagManager:sortResourceByType(arg_26_1, arg_26_2)
	local var_26_0 = {
		[5] = {
			weight = 4,
			func = function(self, arg_30_1)
				local var_30_0 = item_data[self.id].bag_item_type_ext or 10000
				local var_30_1 = item_data[arg_30_1.id].bag_item_type_ext or 10000

				if var_30_0 == var_30_1 then
					return "=="
				elseif arg_26_2 == 0 then
					return var_30_0 < var_30_1
				else
					return var_30_1 < var_30_0
				end
			end
		},
		[4] = {
			weight = 2,
			func = function(self, arg_27_1)
				if arg_26_2 == 0 then
					return self.id < arg_27_1.id
				else
					return self.id > arg_27_1.id
				end
			end
		},
		[3] = {
			weight = 1,
			func = function(self, arg_28_1)
				if self.number == arg_28_1.number then
					return "=="
				elseif arg_26_2 == 0 then
					return self.number < arg_28_1.number
				else
					return self.number > arg_28_1.number
				end
			end
		},
		[2] = {
			weight = 3,
			func = function(self, arg_29_1)
				if self.equip_quality == arg_29_1.equip_quality then
					return "=="
				elseif arg_26_2 == 0 then
					return self.equip_quality < arg_29_1.equip_quality
				else
					return self.equip_quality > arg_29_1.equip_quality
				end
			end
		},
		{
			weight = 5,
			func = function(self, arg_31_1)
				local var_31_0 = 0
				local var_31_1 = 0
				local var_31_2 = var_0_42[self.id] or item_data[self.id].bag_item_type
				local var_31_3 = var_0_42[arg_31_1.id] or item_data[arg_31_1.id].bag_item_type

				if var_0_33[var_31_2] then
					var_31_0 = 4
				elseif var_0_30[var_31_2] then
					var_31_0 = 3
				elseif var_0_35[var_31_2] then
					var_31_0 = 2
				elseif var_0_34[var_31_2] then
					var_31_0 = 1
				end

				if var_0_33[var_31_3] then
					var_31_1 = 4
				elseif var_0_30[var_31_3] then
					var_31_1 = 3
				elseif var_0_35[var_31_3] then
					var_31_1 = 2
				elseif var_0_34[var_31_3] then
					var_31_1 = 1
				end

				if var_31_0 == var_31_1 then
					return "=="
				elseif arg_26_2 == 0 then
					return var_31_0 < var_31_1
				else
					return var_31_1 < var_31_0
				end
			end
		}
	}

	var_26_0[arg_26_1].weight = var_26_0[arg_26_1].weight + 10

	table.sort(var_26_0, function(arg_32_0, arg_32_1)
		return arg_32_0.weight > arg_32_1.weight
	end)
	table.sort(self, function(arg_33_0, arg_33_1)
		for iter_33_0 = 1, #var_26_0 do
			if var_26_0[iter_33_0].func(arg_33_0, arg_33_1) ~= "==" then
				return var_26_0[iter_33_0].func(arg_33_0, arg_33_1)
			end
		end
	end)
end

function BagManager:sortFumitureByType(arg_34_1, arg_34_2)
	local var_34_3 = {
		{
			weight = 5,
			func = function(self, arg_42_1)
				local var_42_0 = 0
				local var_42_1 = 0

				if var_0_38[item_data[self.id].bag_item_type] then
					var_42_0 = 2
				elseif var_0_37[item_data[self.id].bag_item_type] then
					var_42_0 = 1
				end

				if var_0_38[item_data[arg_42_1.id].bag_item_type] then
					var_42_1 = 2
				elseif var_0_37[item_data[arg_42_1.id].bag_item_type] then
					var_42_1 = 1
				end

				if var_42_0 == var_42_1 then
					return "=="
				elseif arg_34_2 == 0 then
					return var_42_0 < var_42_1
				else
					return var_42_1 < var_42_0
				end
			end
		},
		{
			weight = 4,
			func = function(self, arg_37_1)
				if self.equip_quality == arg_37_1.equip_quality then
					return "=="
				elseif arg_34_2 == 0 then
					return self.equip_quality < arg_37_1.equip_quality
				else
					return self.equip_quality > arg_37_1.equip_quality
				end
			end
		},
		{
			weight = 2,
			func = function(self, arg_36_1)
				if self.number == arg_36_1.number then
					return "=="
				elseif arg_34_2 == 0 then
					return self.number < arg_36_1.number
				else
					return self.number > arg_36_1.number
				end
			end
		},
		{
			weight = 1,
			func = function(self, arg_38_1)
				if self.sale_price == arg_38_1.sale_price then
					return "=="
				else
					if not self.sale_price or not arg_38_1.sale_price then
						return "=="
					end

					if arg_34_2 == 0 then
						return self.sale_price < arg_38_1.sale_price
					else
						return self.sale_price > arg_38_1.sale_price
					end
				end
			end
		},
		{
			weight = 3,
			func = function(self, arg_35_1)
				if arg_34_2 == 0 then
					return self.id < arg_35_1.id
				else
					return self.id > arg_35_1.id
				end
			end
		}
	}

	var_34_3[arg_34_1].weight = var_34_3[arg_34_1].weight + 10

	table.sort(var_34_3, function(arg_43_0, arg_43_1)
		return arg_43_0.weight > arg_43_1.weight
	end)
	table.sort(self, function(arg_44_0, arg_44_1)
		for iter_44_0 = 1, #var_34_3 do
			if var_34_3[iter_44_0].func(arg_44_0, arg_44_1) ~= "==" then
				return var_34_3[iter_44_0].func(arg_44_0, arg_44_1)
			end
		end
	end)

	return self
end

function BagManager:sortWeapon(arg_45_1, arg_45_2)
	local var_45_0 = {
		[6] = {
			weight = 10,
			func = function(self, arg_50_1)
				if self.servantid == arg_50_1.servantid then
					return "=="
				else
					if not self.servantid then
						if arg_45_2 == 0 then
							return true
						else
							return false
						end
					end

					if not arg_50_1.servantid then
						if arg_45_2 == 0 then
							return false
						else
							return true
						end
					end

					if arg_45_2 == 0 then
						return self.servantid > arg_50_1.servantid
					else
						return self.servantid < arg_50_1.servantid
					end
				end
			end
		},
		[5] = {
			weight = 1,
			func = function(self, arg_46_1)
				if arg_45_2 == 0 then
					return playermodel.items[self.id].itemid < playermodel.items[arg_46_1.id].itemid
				else
					return playermodel.items[self.id].itemid > playermodel.items[arg_46_1.id].itemid
				end
			end
		},
		[4] = {
			weight = 9,
			func = function(self, arg_51_1)
				if self.major == arg_51_1.major then
					return "=="
				else
					if self.major == "all" then
						if arg_45_2 == 0 then
							return true
						else
							return false
						end
					end

					if arg_51_1.major == "all" then
						if arg_45_2 == 0 then
							return false
						else
							return true
						end
					end

					if arg_45_2 == 0 then
						return self.major > arg_51_1.major
					else
						return self.major < arg_51_1.major
					end
				end
			end
		},
		[3] = {
			weight = 3,
			func = function(self, arg_49_1)
				if self.nowStars == arg_49_1.nowStars then
					return "=="
				elseif arg_45_2 == 0 then
					return self.nowStars < arg_49_1.nowStars
				else
					return self.nowStars > arg_49_1.nowStars
				end
			end
		},
		[2] = {
			weight = 5,
			func = function(self, arg_48_1)
				if self.level == arg_48_1.level then
					return "=="
				elseif arg_45_2 == 0 then
					return self.level < arg_48_1.level
				else
					return self.level > arg_48_1.level
				end
			end
		},
		{
			weight = 4,
			func = function(self, arg_47_1)
				if self.equip_quality == arg_47_1.equip_quality then
					return "=="
				elseif arg_45_2 == 0 then
					return self.equip_quality < arg_47_1.equip_quality
				else
					return self.equip_quality > arg_47_1.equip_quality
				end
			end
		}
	}

	var_45_0[arg_45_1].weight = var_45_0[arg_45_1].weight + 10

	table.sort(var_45_0, function(arg_52_0, arg_52_1)
		return arg_52_0.weight > arg_52_1.weight
	end)
	table.sort(self, function(arg_53_0, arg_53_1)
		for iter_53_0 = 1, #var_45_0 do
			if var_45_0[iter_53_0].func(arg_53_0, arg_53_1) ~= "==" then
				return var_45_0[iter_53_0].func(arg_53_0, arg_53_1)
			end
		end
	end)

	return self
end

function BagManager:sortHorcrux(arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = {
		[12] = {
			weight = 10000,
			func = function(self, arg_55_1)
				if not arg_54_3.recommendHorcruxs or not next(arg_54_3.recommendHorcruxs) then
					return var_0_28
				end

				if arg_54_3.recommendHorcruxs[self.id] and arg_54_3.recommendHorcruxs[arg_55_1.id] then
					return arg_54_3.recommendHorcruxs[self.id] > arg_54_3.recommendHorcruxs[arg_55_1.id]
				elseif arg_54_3.recommendHorcruxs[self.id] then
					return false
				elseif arg_54_3.recommendHorcruxs[arg_55_1.id] then
					return true
				else
					return var_0_28
				end
			end
		},
		[11] = {
			weight = 1000,
			func = function(self, arg_66_1)
				if playermodel.horcruxServants[self.id] and playermodel.horcruxServants[arg_66_1.id] then
					return var_0_28
				elseif not playermodel.horcruxServants[self.id] and not playermodel.horcruxServants[arg_66_1.id] then
					return var_0_28
				else
					return playermodel.horcruxServants[self.id]
				end
			end
		},
		[10] = {
			weight = 5,
			func = function(self, arg_61_1)
				if self.grade == arg_61_1.grade then
					return var_0_28
				elseif arg_54_2 == 0 then
					return self.grade < arg_61_1.grade
				else
					return self.grade > arg_61_1.grade
				end
			end
		},
		[9] = {
			weight = 4,
			func = function(self, arg_60_1)
				if self.horcruxtype == arg_60_1.horcruxtype then
					return var_0_28
				elseif arg_54_2 == 0 then
					return self.horcruxtype < arg_60_1.horcruxtype
				else
					return self.horcruxtype > arg_60_1.horcruxtype
				end
			end
		},
		[8] = {
			weight = 9,
			func = function(self, arg_59_1)
				if self.rarity == arg_59_1.rarity then
					return var_0_28
				else
					local var_59_0 = self.rarity
					local var_59_1 = arg_59_1.rarity

					if arg_54_2 == 0 then
						return var_59_0 < var_59_1
					else
						return var_59_1 < var_59_0
					end
				end
			end
		},
		[7] = {
			weight = 1,
			func = function(self, arg_56_1)
				if arg_54_2 == 0 then
					return self.id < arg_56_1.id
				else
					return self.id > arg_56_1.id
				end
			end
		},
		[6] = {
			weight = 8,
			func = function(self, arg_65_1)
				if self.hp == arg_65_1.hp then
					return var_0_28
				elseif arg_54_2 == 0 then
					return self.hp < arg_65_1.hp
				else
					return self.hp > arg_65_1.hp
				end
			end
		},
		[5] = {
			weight = 7,
			func = function(self, arg_64_1)
				if self.damage == arg_64_1.damage then
					return var_0_28
				elseif arg_54_2 == 0 then
					return self.damage < arg_64_1.damage
				else
					return self.damage > arg_64_1.damage
				end
			end
		},
		[4] = {
			weight = 2,
			func = function(self, arg_63_1)
				if not self.hfac then
					return var_0_28
				end

				if self.hfac == arg_63_1.hfac then
					return var_0_28
				elseif arg_54_2 == 0 then
					return self.hfac < arg_63_1.hfac
				else
					return self.hfac > arg_63_1.hfac
				end
			end
		},
		[3] = {
			weight = 3,
			func = function(self, arg_62_1)
				if not self.dfac then
					return var_0_28
				end

				if self.dfac == arg_62_1.dfac then
					return var_0_28
				elseif arg_54_2 == 0 then
					return self.dfac < arg_62_1.dfac
				else
					return self.dfac > arg_62_1.dfac
				end
			end
		},
		[2] = {
			weight = 6,
			func = function(self, arg_57_1)
				if self.stars == arg_57_1.stars then
					return var_0_28
				elseif arg_54_2 == 0 then
					return self.stars < arg_57_1.stars
				else
					return self.stars > arg_57_1.stars
				end
			end
		},
		{
			weight = 10,
			func = function(self, arg_58_1)
				if self.level == arg_58_1.level then
					return var_0_28
				elseif arg_54_2 == 0 then
					return self.level < arg_58_1.level
				else
					return self.level > arg_58_1.level
				end
			end
		}
	}

	var_54_0[arg_54_1].weight = var_54_0[arg_54_1].weight + 100

	table.sort(var_54_0, function(arg_67_0, arg_67_1)
		return arg_67_0.weight > arg_67_1.weight
	end)
	table.sort(self, function(arg_68_0, arg_68_1)
		for iter_68_0 = 1, #var_54_0 do
			local var_68_0 = var_54_0[iter_68_0].func(arg_68_0, arg_68_1)

			if var_68_0 ~= var_0_28 then
				return var_68_0
			end
		end
	end)

	return self
end

function BagManager:sortHorcruxUpstar(arg_69_1, arg_69_2)
	local var_69_0 = {
		[8] = {
			weight = 6,
			func = function(self, arg_75_1)
				if self.grade == arg_75_1.grade then
					return "=="
				elseif arg_69_2 == 0 then
					return self.grade > arg_75_1.grade
				else
					return self.grade < arg_75_1.grade
				end
			end
		},
		[7] = {
			weight = 4,
			func = function(self, arg_74_1)
				if self.horcruxtype == arg_74_1.horcruxtype then
					return "=="
				elseif arg_69_2 == 0 then
					return self.horcruxtype < arg_74_1.horcruxtype
				else
					return self.horcruxtype > arg_74_1.horcruxtype
				end
			end
		},
		[6] = {
			weight = 7,
			func = function(self, arg_73_1)
				if self.rarity == arg_73_1.rarity then
					return "=="
				else
					local var_73_0 = self.rarity
					local var_73_1 = arg_73_1.rarity

					if arg_69_2 == 0 then
						return var_73_1 < var_73_0
					else
						return var_73_0 < var_73_1
					end
				end
			end
		},
		[5] = {
			weight = 1,
			func = function(self, arg_70_1)
				if arg_69_2 == 0 then
					return self.id < arg_70_1.id
				else
					return self.id > arg_70_1.id
				end
			end
		},
		[4] = {
			weight = 2,
			func = function(self, arg_77_1)
				if not self.hfac then
					return "=="
				end

				if self.hfac == arg_77_1.hfac then
					return "=="
				elseif arg_69_2 == 0 then
					return self.hfac > arg_77_1.hfac
				else
					return self.hfac < arg_77_1.hfac
				end
			end
		},
		[3] = {
			weight = 3,
			func = function(self, arg_76_1)
				if not self.dfac then
					return "=="
				end

				if self.dfac == arg_76_1.dfac then
					return "=="
				elseif arg_69_2 == 0 then
					return self.dfac > arg_76_1.dfac
				else
					return self.dfac < arg_76_1.dfac
				end
			end
		},
		[2] = {
			weight = 8,
			func = function(self, arg_71_1)
				if self.stars == arg_71_1.stars then
					return "=="
				elseif arg_69_2 == 0 then
					return self.stars > arg_71_1.stars
				else
					return self.stars < arg_71_1.stars
				end
			end
		},
		{
			weight = 5,
			func = function(self, arg_72_1)
				if self.level == arg_72_1.level then
					return "=="
				elseif arg_69_2 == 0 then
					return self.level > arg_72_1.level
				else
					return self.level < arg_72_1.level
				end
			end
		}
	}

	var_69_0[arg_69_1].weight = var_69_0[arg_69_1].weight + 0

	table.sort(var_69_0, function(arg_78_0, arg_78_1)
		return arg_78_0.weight > arg_78_1.weight
	end)
	table.sort(self, function(arg_79_0, arg_79_1)
		for iter_79_0 = 1, #var_69_0 do
			local var_79_0 = var_69_0[iter_79_0].func(arg_79_0, arg_79_1)

			if var_79_0 ~= "==" then
				return var_79_0
			end
		end
	end)

	return self
end

function BagManager:generate_bag_data(arg_80_1, arg_80_2)
	self.filterData = self:getBagData(arg_80_1, arg_80_2)
end

function BagManager:getFilterData(arg_81_1, arg_81_2)
	return self:getBagData(arg_81_1, arg_81_2)
end

function BagManager:insertIntoFilterData(arg_82_1, arg_82_2)
	table.insert(self.filterData, arg_82_2, arg_82_1)
end

function BagManager:removeIntoFilterData(arg_83_1)
	local var_83_0 = {}

	for iter_83_0, iter_83_1 in pairs(arg_83_1) do
		var_83_0[iter_83_1] = iter_83_1
	end

	while 1 <= #self.filterData do
		local var_83_1

		if var_83_0[self.filterData[1]] then
			table.remove(self.filterData, 1)
		else
			var_83_1 = 1 + 1
		end
	end
end

function BagManager:dequeueItem(arg_84_1)
	return self.filterData[arg_84_1]
end

function BagManager:getDataCount()
	return #self.filterData
end

function BagManager:deleteItems(arg_86_1)
	local var_86_0 = {}

	if type(arg_86_1) ~= "table" then
		var_86_0[arg_86_1] = true
	else
		for iter_86_0, iter_86_1 in pairs(arg_86_1) do
			var_86_0[iter_86_1] = true
		end
	end

	local var_86_1 = 1

	while self.allData[var_86_1] do
		if var_86_0[self.allData[var_86_1].id] then
			table.remove(self.allData, var_86_1)
		else
			var_86_1 = var_86_1 + 1
		end
	end

	local var_86_2 = 1

	while self.filterData[var_86_2] do
		if var_86_0[self.filterData[var_86_2]] then
			table.remove(self.filterData, var_86_2)
		else
			var_86_2 = var_86_2 + 1
		end
	end
end

function BagManager:deleteFilterDataItems(arg_87_1)
	local var_87_0 = {}

	if type(arg_87_1) ~= "table" then
		var_87_0[arg_87_1] = true
	else
		for iter_87_0, iter_87_1 in pairs(arg_87_1) do
			var_87_0[iter_87_1] = true
		end
	end

	local var_87_1 = 1

	while self.filterData[var_87_1] do
		if var_87_0[self.filterData[var_87_1]] then
			table.remove(self.filterData, var_87_1)
		else
			var_87_1 = var_87_1 + 1
		end
	end
end

function BagManager:updateItemAttr(arg_88_1, arg_88_2)
	for iter_88_0, iter_88_1 in ipairs(self.allData) do
		if iter_88_1.id == arg_88_1 then
			iter_88_1[arg_88_2.key] = arg_88_2.value

			return
		end
	end
end

function BagManager:reverseOrder(arg_89_1)
	if not arg_89_1 then
		return
	end

	local var_89_0 = 1
	local var_89_1 = #arg_89_1

	while var_89_0 < #arg_89_1 do
		arg_89_1[var_89_1], arg_89_1[var_89_0] = arg_89_1[var_89_0], arg_89_1[#arg_89_1]
		var_89_0 = var_89_0 + 1
		var_89_1 = #arg_89_1 - 1
	end
end

function BagManager:get__hold_array_data(arg_90_1)
	if arg_90_1 then
		local var_90_0 = {}
		local var_90_1 = {}

		while playermodel.arrays[1] do
			while playermodel.arrays[1]["pos_" .. 1] and playermodel.arrays[1]["pos_" .. 1].assist_girl do
				var_90_1[playermodel.arrays[1]["pos_" .. 1].assist_girl] = true
			end
		end

		for iter_90_0, iter_90_1 in ipairs(self.resultData) do
			if not var_90_1[iter_90_1] then
				table.insert(var_90_0, iter_90_1)
			end
		end

		return var_90_0
	else
		return self.resultData
	end
end

function BagManager:servantChipCompound(arg_91_1, arg_91_2, arg_91_3)
	if not arg_91_1 then
		if arg_91_3 then
			arg_91_3(0)
		end

		return
	end

	if item_data[arg_91_1].bag_item_type ~= kITEM_SERVANT_CHIP then
		if arg_91_3 then
			arg_91_3(0)
		end

		return
	end

	local var_91_0 = item_data[arg_91_1].studentcard_consume

	if not item_manager:isHaveEnoughItem(arg_91_1, arg_91_2) then
		if arg_91_3 then
			arg_91_3(2)
		end

		return
	end

	if arg_91_2 < var_91_0 and arg_91_3 then
		arg_91_3(2)
	end

	arg_91_2 = math.floor(arg_91_2 / var_91_0) * var_91_0

	net:rpc("horcruxchip_compound", {
		horcruxchip = arg_91_1,
		num = arg_91_2
	}, function(arg_92_0)
		if arg_92_0.result == 1 then
			item_manager:deleteItem(arg_91_1, arg_91_2)

			if arg_91_3 then
				arg_91_3(1, arg_92_0.items)
			end
		elseif arg_91_3 then
			arg_91_3(arg_92_0.result)
		end
	end)
end

function BagManager:getServantChipInfo(arg_93_1)
	if item_data[arg_93_1].bag_item_type ~= kITEM_SERVANT_CHIP then
		return ""
	end

	return (string.format(L_SERVANT_COMPOSE, item_data[arg_93_1].studentcard_consume))
end

function BagManager:setHideItem(arg_94_1)
	self.hideItems = arg_94_1
end

function BagManager:setCalculateHorcruxScore(arg_95_1)
	self.calculateHorcruxScore = true
	self.needRecommendServant = arg_95_1
end

function BagManager:calculateRecommendHorcruxs(arg_96_1, arg_96_2)
	self.recommendHorcruxs = {}

	local var_96_0 = {}
	local var_96_1 = {}

	if arg_96_2 then
		for iter_96_0, iter_96_1 in pairs(arg_96_2) do
			var_96_1[iter_96_1] = true
		end
	end

	for iter_96_2, iter_96_3 in pairs(arg_96_1) do
		if iter_96_3.recommendScore and not var_96_1[iter_96_3.id] and not playermodel.horcruxServants[iter_96_3.id] then
			if #var_96_0 < HORCRUX_RECOMMEND_NUM then
				table.insert(var_96_0, iter_96_3)
				table.sort(var_96_0, function(arg_97_0, arg_97_1)
					return arg_97_0.recommendScore > arg_97_1.recommendScore
				end)
			elseif iter_96_3.recommendScore > var_96_0[HORCRUX_RECOMMEND_NUM].recommendScore then
				var_96_0[HORCRUX_RECOMMEND_NUM] = iter_96_3

				table.sort(var_96_0, function(arg_98_0, arg_98_1)
					return arg_98_0.recommendScore > arg_98_1.recommendScore
				end)
			end
		end
	end

	for iter_96_4, iter_96_5 in ipairs(var_96_0) do
		self.recommendHorcruxs[iter_96_5.id] = iter_96_4
	end
end

function BagManager:getRecommendHorcruxs()
	return self.recommendHorcruxs
end

return BagManager
