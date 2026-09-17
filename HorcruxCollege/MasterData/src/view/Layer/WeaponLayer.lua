WeaponLayer = class("WeaponLayer", function()
	return cc.Layer:create()
end)

local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local var_0_8
local var_0_9 = config._DEBUG and 0 or 1
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3
local var_0_13 = 4
local var_0_14 = 1
local var_0_15 = {
	[0] = {
		g = 212,
		b = 225,
		r = 206,
		quality = L_WEAPON_QUALITY_LIST[0]
	},
	{
		g = 212,
		b = 225,
		r = 206,
		quality = L_WEAPON_QUALITY_LIST[1]
	},
	{
		g = 255,
		b = 150,
		r = 150,
		quality = L_WEAPON_QUALITY_LIST[2]
	},
	{
		g = 181,
		b = 255,
		r = 49,
		quality = L_WEAPON_QUALITY_LIST[3]
	},
	{
		g = 104,
		b = 255,
		r = 221,
		quality = L_WEAPON_QUALITY_LIST[4]
	},
	{
		g = 121,
		b = 31,
		r = 255,
		quality = L_WEAPON_QUALITY_LIST[5]
	}
}

function WeaponLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = WeaponLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function WeaponLayer.getInstance()
	return var_0_8
end

function WeaponLayer:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	var_0_8 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Weapon_core.json" or "Weapon_core.ExportJson")

	self:addChild(self.rootLayer)

	self.MainPanel = self.rootLayer:getChildByName("Panel_main")

	self.MainPanel:retain()
	self.MainPanel:removeFromParent()

	self.StrengthenPanel = self.rootLayer:getChildByName("Panel_strengthen")

	self.StrengthenPanel:retain()
	self.StrengthenPanel:removeFromParent()

	self.BreakthroughPanel = self.rootLayer:getChildByName("Panel_breakthrough")

	self.BreakthroughPanel:retain()
	self.BreakthroughPanel:removeFromParent()

	self.itemEntityid = arg_4_1
	self.updateEquipLayerCallback = arg_4_3
	self.servantid = arg_4_4
	self.entrywayType = arg_4_5

	self:updateShowType(var_0_10)
	TopcostLayer.getInstance():hideTopcostLayer()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_8 = nil

			self.MainPanel:release()
			self.StrengthenPanel:release()
			self.BreakthroughPanel:release()

			if arg_4_2 then
				arg_4_2()
			end
		end
	end)
end

function WeaponLayer:changeWeapon()
	self:addChild(ItemsPanel:create(kITEM_WEAPON, {
		isFilterLocked = true,
		soulid = self.servantid
	}, {
		self.itemEntityid
	}, {
		unused = function(arg_7_0)
			fight_capacity_manager:saveSoulAttr(self.servantid)
			weapon_manager:replaceRoleWeapon(self.servantid, arg_7_0, function(arg_8_0)
				if arg_8_0 == 1 then
					fight_capacity_manager:displaySoulAttrChangeValue()

					self.itemEntityid = arg_7_0

					self:updateShowType(var_0_10)
					self.updateEquipLayerCallback()
				end
			end)
		end,
		used = function()
			fight_capacity_manager:saveSoulAttr(self.servantid)
			weapon_manager:replaceRoleWeapon(self.servantid, nil, function(arg_10_0)
				if arg_10_0 == 1 then
					fight_capacity_manager:displaySoulAttrChangeValue()
					self.updateEquipLayerCallback()
					LayerManager:removePopLayer()
				end
			end)
		end,
		cancelcallback = function()
			return
		end
	}, ITEMPANEL_TYPE_ROLE_WEAPON), 99)
end

function WeaponLayer.updateShowType(arg_12_0, arg_12_1)
	arg_12_0.showType = arg_12_1

	;({
		[var_0_10] = function()
			arg_12_0.mainPanel = arg_12_0.MainPanel:clone()

			arg_12_0.mainPanel:setVisible(true)
			arg_12_0.mainPanel:setBackGroundImage("mainScenebg/levelBg.jpg")
			arg_12_0:addChild(arg_12_0.mainPanel)

			local var_13_0 = playermodel.items[arg_12_0.itemEntityid]
			local var_13_1 = item_data[playermodel.items[arg_12_0.itemEntityid].itemid]
			local var_13_2 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_0.itemEntityid])
			local var_13_3 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Image_weapon")
			local var_13_4 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Image_w_type")
			local var_13_5 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Image_lock")
			local var_13_6 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Panel_stars")
			local var_13_7 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_lv")
			local var_13_8 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_attr")
			local var_13_9 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_name")
			local var_13_10 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_weapon_quality")
			local var_13_11 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_des")

			var_13_11:setVisible(false)

			local var_13_12 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Breakthrough")

			var_13_12:setVisible(false)

			local var_13_13 = arg_12_0.mainPanel:getChildByName("info_bg")
			local var_13_14 = var_13_13:getChildByName("Image_skill")
			local var_13_15 = var_13_14:getChildByName("skill_name")
			local var_13_16 = var_13_14:getChildByName("skill_des")
			local var_13_17 = var_13_14:getChildByName("skill_cd")
			local var_13_18 = var_13_13:getChildByName("Label_passiveDes")
			local var_13_19 = var_13_13:getChildByName("Label_passiveName")
			local var_13_20 = var_13_13:getChildByName("Panel_passive")

			var_13_20:setVisible(false)

			local var_13_21 = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("bar_bg")
			local var_13_22 = var_13_21:getChildByName("Label_exp")
			local var_13_23 = var_13_21:getChildByName("ProgressBar_yellow")
			local var_13_24 = var_13_21:getChildByName("ProgressBar_blue")

			arg_12_0.mainPanel.returnBtn = arg_12_0.mainPanel:getChildByName("Bottom_bg"):getChildByName("Button_return")
			arg_12_0.mainPanel.strengthenBnt = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Button_strengthen")
			arg_12_0.mainPanel.upgradeBnt = arg_12_0.mainPanel:getChildByName("weapon_bg"):getChildByName("Button_upgrade")
			arg_12_0.mainPanel.changeWeaponBtn = arg_12_0.mainPanel:getChildByName("Bottom_bg"):getChildByName("Button_changeWeapon")
			arg_12_0.mainPanel.unloadBtn = arg_12_0.mainPanel:getChildByName("Bottom_bg"):getChildByName("Button_unload")

			if arg_12_0.entrywayType == var_0_14 then
				arg_12_0.mainPanel.changeWeaponBtn:setVisible(false)
				arg_12_0.mainPanel.strengthenBnt:retain()
				arg_12_0.mainPanel.strengthenBnt:removeFromParent()
				arg_12_0.mainPanel:getChildByName("Bottom_bg"):addChild(arg_12_0.mainPanel.strengthenBnt)
				arg_12_0.mainPanel.strengthenBnt:release()
				arg_12_0.mainPanel.strengthenBnt:setPosition(cc.p(547, 32))
				arg_12_0.mainPanel.strengthenBnt:setScale(1)
				arg_12_0.mainPanel.strengthenBnt:getChildByName("Label"):setPosition(cc.p(90, 30))
				arg_12_0.mainPanel.strengthenBnt:loadTextures("public/public/bottom_bntBg1.png", "public/public/bottom_bntBg1.png", "public/public/bottom_bntBg1.png", var_0_9)
				arg_12_0.mainPanel.upgradeBnt:setVisible(false)

				if playermodel.items[arg_12_0.itemEntityid].weapon_attr.nowStars == TOTAL_WEAPON_MAXSTARS then
					arg_12_0.mainPanel.unloadBtn:getChildByName("Label"):setString(L_WEAPON_STAR.Star_Full)
					arg_12_0.mainPanel.unloadBtn:addTouchEventListener(function(arg_16_0, arg_16_1)
						if arg_16_1 ~= ccui.TouchEventType.ended then
							return
						end

						global_ShowBlockWords(L_WEAPON_STAR.Weapon_Full)
					end)
				else
					arg_12_0.mainPanel.unloadBtn:getChildByName("Label"):setString(L_BUTTON_TEXT.Up_Star)
					arg_12_0.mainPanel.unloadBtn:addTouchEventListener(function(arg_17_0, arg_17_1)
						if arg_17_1 ~= ccui.TouchEventType.ended then
							return
						end

						arg_12_0:updateShowType(var_0_12)
					end)
				end
			else
				arg_12_0.mainPanel.unloadBtn:addTouchEventListener(function(arg_14_0, arg_14_1)
					if arg_14_1 ~= ccui.TouchEventType.ended then
						return
					end

					fight_capacity_manager:saveSoulAttr(arg_12_0.servantid)
					weapon_manager:replaceRoleWeapon(arg_12_0.servantid, nil, function(arg_15_0)
						if arg_15_0 == 1 then
							fight_capacity_manager:displaySoulAttrChangeValue()
							arg_12_0.updateEquipLayerCallback()
							LayerManager:removePopLayer()
						end
					end)
				end)
			end

			arg_12_0.mainPanel.changeWeaponBtn:addTouchEventListener(function(arg_18_0, arg_18_1)
				if arg_18_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_12_0:changeWeapon()
			end)
			arg_12_0.mainPanel.returnBtn:addTouchEventListener(function(arg_19_0, arg_19_1)
				if arg_19_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:removePopLayer()
			end)

			function arg_12_0.mainPanel.updateInfo(arg_20_0)
				if var_13_0.weapon_attr.level == 10 then
					var_13_12:setVisible(true)
					var_13_12:setString("MAX")
					var_13_21:setVisible(false)
					arg_12_0.mainPanel.strengthenBnt:getChildByName("Label"):setString(L_WEAPON_LEVEL.LEVEL_MAX)
					arg_12_0.mainPanel.strengthenBnt:addTouchEventListener(function(arg_21_0, arg_21_1)
						if arg_21_1 ~= ccui.TouchEventType.ended then
							return
						end

						global_ShowBlockWords(L_WEAPON_LEVEL.Weapon_Lv_Max)
					end)
				elseif weapon_manager:isNeedBreakthrough(arg_12_0.itemEntityid) then
					arg_12_0.mainPanel.strengthenBnt:setVisible(true)
					arg_12_0.mainPanel.strengthenBnt:getChildByName("Label"):setString(L_WEAPON_RANGE_UP.Up)
					var_13_12:setVisible(true)
					var_13_12:setString(L_WEAPON_RANGE_UP.Waiting_Up)
					var_13_21:setVisible(false)
					arg_12_0.mainPanel.strengthenBnt:addTouchEventListener(function(arg_22_0, arg_22_1)
						if arg_22_1 ~= ccui.TouchEventType.ended then
							return
						end

						arg_12_0:updateShowType(var_0_13)
					end)
				else
					arg_12_0.mainPanel.strengthenBnt:setVisible(true)
					arg_12_0.mainPanel.strengthenBnt:getChildByName("Label"):setString(L_WEAPON_STRENGTHEN.Strengthen)
					var_13_12:setVisible(false)
					var_13_21:setVisible(true)
					arg_12_0.mainPanel.strengthenBnt:addTouchEventListener(function(arg_23_0, arg_23_1)
						if arg_23_1 ~= ccui.TouchEventType.ended then
							return
						end

						arg_12_0:updateShowType(var_0_11)
					end)
				end

				if var_13_0.weapon_attr.nowStars == TOTAL_WEAPON_MAXSTARS then
					arg_12_0.mainPanel.upgradeBnt:getChildByName("Label"):setString(L_WEAPON_STAR.Star_Full)
					arg_12_0.mainPanel.upgradeBnt:addTouchEventListener(function(arg_24_0, arg_24_1)
						if arg_24_1 ~= ccui.TouchEventType.ended then
							return
						end

						global_ShowBlockWords(L_WEAPON_STAR.Weapon_Full)
					end)
				else
					arg_12_0.mainPanel.upgradeBnt:getChildByName("Label"):setString(L_BUTTON_TEXT.Up_Star)
					arg_12_0.mainPanel.upgradeBnt:addTouchEventListener(function(arg_25_0, arg_25_1)
						if arg_25_1 ~= ccui.TouchEventType.ended then
							return
						end

						arg_12_0:updateShowType(var_0_12)
					end)
				end

				local var_20_0 = playermodel.items[arg_12_0.itemEntityid]
				local var_20_1 = item_data[playermodel.items[arg_12_0.itemEntityid].itemid]
				local var_20_2 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_0.itemEntityid])

				var_13_7:setString("LV." .. playermodel.items[arg_12_0.itemEntityid].weapon_attr.level)
				var_13_8:setString(FIGHT_ATTR_INFO[var_20_2.main_attr.attrtype] .. "+" .. FIGHT_ATTR_FORMAT(var_20_2.main_attr.attrtype, var_20_2.main_attr.value))
				var_13_6:removeAllChildren()

				for iter_20_0 = 1, TOTAL_WEAPON_MAXSTARS do
					local var_20_6

					if config._DEBUG then
						var_20_6 = cc.Sprite:create(var_20_4) or cc.Sprite:createWithSpriteFrameName(var_20_4)
					end

					var_20_6:setScale(1.2)
					var_20_6:setPosition(24, 200 + (iter_20_0 - 1) * 36)
					var_13_6:addChild(var_20_6)
				end

				for iter_20_1 = 1, 5 do
					if iter_20_1 <= TOTAL_WEAPON_MAXSTARS then
						var_13_20:getChildByName("Label_starsNum" .. iter_20_1):setVisible(true)
						var_13_20:getChildByName("Label_stars" .. iter_20_1):setVisible(true)
						var_13_20:getChildByName("Label_starsNum" .. iter_20_1):setString("")

						if iter_20_1 == var_20_0.weapon_attr.nowStars then
							var_13_20:getChildByName("Label_starsNum" .. iter_20_1):setColor(cc.c3b(254, 173, 77))
						else
							var_13_20:getChildByName("Label_starsNum" .. iter_20_1):setColor(cc.c3b(112, 161, 214))
						end
					else
						var_13_20:getChildByName("Label_starsNum" .. iter_20_1):setVisible(false)
						var_13_20:getChildByName("Label_stars" .. iter_20_1):setVisible(false)
					end
				end

				local var_20_7 = {}

				string.gsub("", "[^#]+", function(arg_26_0)
					var_20_7[#var_20_7 + 1] = arg_26_0
				end)

				var_20_7[1] = var_20_7[1] or " "
				var_20_7[2] = var_20_7[2] or " "

				local var_20_8
				local var_20_9

				if var_13_13:getChildByName("m_passiveSkillDes") then
					var_20_8 = var_13_13:getChildByName("m_passiveSkillDes")
					var_20_9 = var_13_13:getChildByName("des1")

					var_20_9:setString("(" .. "" .. ")")
					var_20_9:setVisible(false)
				end

				local var_20_10

				do
					var_20_8 = cc.Label:createWithTTF("", "fonts/new1.ttf", 20)

					var_20_8:setColor(cc.c3b(182, 189, 203))
					var_20_8:setAnchorPoint(cc.p(0, 1))
					var_20_8:setMaxLineWidth(480)
					var_20_8:setPosition(var_13_18:getPositionX(), var_13_18:getPositionY())
					var_20_8:setName("m_passiveSkillDes")
					var_13_13:addChild(var_20_8)

					var_20_9 = cc.Label:createWithTTF("(" .. "" .. ")", "fonts/new1.ttf", 20)

					var_20_9:setAnchorPoint(cc.p(0, 0.5))
					var_20_9:setColor(cc.c3b(236, 185, 67))
					var_20_9:setPosition(var_20_8:getContentSize().width, var_20_8:getContentSize().height / 2)
					var_20_9:setName("des1")
					var_20_9:setVisible(false)
					var_13_13:addChild(var_20_9, 1)

					var_20_10 = ""
				end

				for iter_20_2 = 1, math.ceil(var_20_9:getContentSize().width / 5) do
					var_20_10 = var_20_10 .. " "
				end

				var_20_8:setString(var_20_7[1])
				var_20_8:setString(var_20_7[1] .. var_20_10 .. var_20_7[2])
				var_20_9:setPosition(var_20_8:getPositionX() + var_20_8:getContentSize().width, var_20_8:getPositionY() - var_20_8:getContentSize().height / 2)

				local var_20_11 = require("data.weapon_strengthen" .. var_20_1.equip_quality .. "_data")[var_20_0.weapon_attr.level].exp
				local var_20_12 = math.abs(var_20_0.weapon_attr.exp)

				var_13_22:setString(var_20_12 .. "/" .. var_20_11)
				var_13_23:setPercent(0)
				var_13_24:setPercent(100 * tonumber(var_20_12) / tonumber(var_20_11) > 100 and 100 or math.floor(100 * tonumber(var_20_12) / tonumber(var_20_11)))
			end

			;(function()
				var_13_9:setString(var_13_1.name)
				var_13_11:setString(var_13_1.intro)
				var_13_10:setString(var_0_15[var_13_1.id % 10].quality)
				var_13_10:setColor(cc.c3b(var_0_15[var_13_1.id % 10].r, var_0_15[var_13_1.id % 10].g, var_0_15[var_13_1.id % 10].b))

				local var_27_0 = {
					"arms_icon1",
					"arms_icon2",
					"arms_icon3"
				}

				var_13_4:loadTexture("Weapon/" .. ((arg_12_0.servantid or nil) and (var_27_0[major_factor_data[servant_data[arg_12_0.servantid].major].role_type] or var_27_0[1])) .. ".png", var_0_9)
				var_13_3:loadTexture("weaponIcon/" .. var_13_1.image_id .. ".png")

				if var_13_0.weapon_attr.lock then
					var_13_5:loadTexture("Weapon/arms_lock_bg1.png", var_0_9)
				else
					var_13_5:loadTexture("Weapon/arms_lock_bg2.png", var_0_9)
				end

				print(dump(var_13_1))
				var_13_15:setString("")
				var_13_16:setString(var_13_1.intro)
				var_13_17:setString("")

				if var_13_1.skill then
					var_13_19:setVisible(true)
					var_13_18:setVisible(true)
					var_13_19:setString(total_skill_data[var_13_1.skill].name)
					var_13_18:setString(total_skill_data[var_13_1.skill].description)
				else
					var_13_19:setVisible(false)
					var_13_18:setVisible(false)
				end

				var_13_20:getChildByName("Label_shuzhi"):setString("")
				var_13_5:setTouchEnabled(true)

				if var_13_0.weapon_attr.lock then
					var_13_5:loadTexture("Weapon/arms_lock_bg1.png", var_0_9)
				else
					var_13_5:loadTexture("Weapon/arms_lock_bg2.png", var_0_9)
				end

				var_13_5:addTouchEventListener(function(arg_28_0, arg_28_1)
					if arg_28_1 ~= ccui.TouchEventType.ended then
						return
					end

					var_13_5:setTouchEnabled(false)
					weapon_manager:lockWeapon(arg_12_0.itemEntityid, function(arg_29_0)
						if arg_29_0 then
							var_13_5:loadTexture("Weapon/arms_lock_bg1.png", var_0_9)
						else
							var_13_5:loadTexture("Weapon/arms_lock_bg2.png", var_0_9)
						end

						var_13_5:setTouchEnabled(true)
					end)
				end)
				arg_12_0.mainPanel:updateInfo(arg_12_0.itemEntityid)
			end)()
		end,
		[var_0_11] = function()
			arg_12_0.strengthenPanel = arg_12_0.StrengthenPanel:clone()

			arg_12_0.strengthenPanel:setVisible(true)
			arg_12_0.strengthenPanel:setBackGroundImage("mainScenebg/levelBg.jpg")
			arg_12_0:addChild(arg_12_0.strengthenPanel)

			local var_30_1 = playermodel.items[arg_12_0.itemEntityid]
			local var_30_2 = item_data[playermodel.items[arg_12_0.itemEntityid].itemid]
			local var_30_3 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_0.itemEntityid])
			local var_30_4 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Image_weapon")
			local var_30_5 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Image_w_type")
			local var_30_6 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Panel_stars")
			local var_30_7 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Label_lv")
			local var_30_8 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Label_new_lv")
			local var_30_9 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Label_attr")
			local var_30_10 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Label_new_attr")
			local var_30_11 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Label_name")
			local var_30_12 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Label_weapon_quality")
			local var_30_13 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("Label_des")

			var_30_13:setVisible(false)

			local var_30_14 = arg_12_0.strengthenPanel:getChildByName("item_bg")
			local var_30_15 = var_30_14:getChildByName("gain_exp"):getChildByName("Label_num")
			local var_30_16 = var_30_14:getChildByName("cost_gold"):getChildByName("Label_num")
			local var_30_17 = arg_12_0.strengthenPanel:getChildByName("weapon_bg"):getChildByName("bar_bg")
			local var_30_18 = var_30_17:getChildByName("Label_exp")
			local var_30_19 = var_30_17:getChildByName("ProgressBar_yellow")
			local var_30_20 = var_30_17:getChildByName("ProgressBar_blue")

			arg_12_0.strengthenPanel.returnBnt = arg_12_0.strengthenPanel:getChildByName("Bottom_bg"):getChildByName("Button_return")
			arg_12_0.strengthenPanel.sureBnt = arg_12_0.strengthenPanel:getChildByName("Bottom_bg"):getChildByName("Button_sure")
			arg_12_0.strengthenPanel.selectBnt = arg_12_0.strengthenPanel:getChildByName("Bottom_bg"):getChildByName("Button_select")

			arg_12_0.strengthenPanel.returnBnt:addTouchEventListener(function(arg_31_0, arg_31_1)
				if arg_31_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_12_0.strengthenPanel:runAction(cc.RemoveSelf:create())

				arg_12_0.strengthenPanel = nil
			end)
			arg_12_0.strengthenPanel.sureBnt:addTouchEventListener(function(arg_32_0, arg_32_1)
				if arg_32_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_32_0:isBright() then
					return
				end

				arg_32_0:setBright(false)

				local var_32_0 = {}

				for iter_32_0, iter_32_1 in pairs(arg_12_0.selectedItems) do
					if iter_32_1 > 0 then
						table.insert(var_32_0, {
							itemid = iter_32_0,
							num = iter_32_1
						})
					end
				end

				local var_32_1 = {
					level = playermodel.items[arg_12_0.itemEntityid].weapon_attr.level,
					attrValue = var_30_3.main_attr.value,
					percent = math.floor(100 * tonumber(playermodel.items[arg_12_0.itemEntityid].weapon_attr.exp) / tonumber(require("data.weapon_strengthen" .. item_data[playermodel.items[arg_12_0.itemEntityid].itemid].equip_quality .. "_data")[playermodel.items[arg_12_0.itemEntityid].weapon_attr.level].exp))
				}

				if next(var_32_0) == nil then
					global_ShowBlockWords(L_WEAPON_LEVEL.Level_Up_Fail)
					arg_32_0:setBright(true)
				else
					weapon_manager:strengthenWeapon(arg_12_0.itemEntityid, var_32_0, function(arg_33_0)
						arg_32_0:setBright(true)

						if arg_33_0 == 1 then
							if arg_12_0.mainPanel then
								arg_12_0.mainPanel:updateInfo()
							end

							if playermodel.items[arg_12_0.itemEntityid].weapon_attr.level == 10 then
								arg_12_0.strengthenPanel:showStrengthenEffect(var_32_1, function()
									arg_12_0.strengthenPanel:runAction(cc.RemoveSelf:create())

									arg_12_0.strengthenPanel = nil
								end)
							else
								arg_12_0.selectedItems = {}

								arg_12_0.strengthenPanel:showStrengthenEffect(var_32_1, arg_12_0.strengthenPanel.updateInfo)
							end
						elseif arg_33_0 == 2 then
							global_ShowBlockWords(L_WEAPON_STRENGTHEN.Fail[2])
						elseif arg_33_0 == 4 then
							global_ShowBlockWords(L_GOLD_LACK)
						elseif arg_33_0 == 5 then
							global_ShowBlockWords(L_WEAPON_STRENGTHEN.Fail[5])
						end
					end)
				end
			end)

			local function var_30_21()
				local var_35_0 = {
					gainExp = 0,
					newAttr = 0,
					costGold = 0,
					newLv = var_30_1.weapon_attr.level
				}

				for iter_35_0, iter_35_1 in pairs(arg_12_0.selectedItems) do
					if item_data[iter_35_0] and iter_35_1 > 0 then
						var_35_0.gainExp = var_35_0.gainExp + item_data[iter_35_0].gain_exp * iter_35_1
					end
				end

				var_35_0.costGold = math.floor(var_35_0.gainExp * WEAPON_STRENGTHEN_C)

				local var_35_1 = require("data.weapon_strengthen" .. var_30_2.equip_quality .. "_data")
				local var_35_2 = var_30_1.weapon_attr.level

				while var_35_1[var_30_1.weapon_attr.level].all_exp - var_35_1[var_30_1.weapon_attr.level].exp + var_30_1.weapon_attr.exp + var_35_0.gainExp >= var_35_1[var_35_2].all_exp do
					if var_35_2 % 10 == 0 and var_35_2 ~= var_30_1.weapon_attr.level then
						break
					end

					var_35_2 = var_35_2 + 1
					var_35_0.newLv = var_35_2
				end

				var_35_0.newAttr = (var_35_1[var_35_0.newLv].all_value + var_30_2.value) * FIGHT_ATTR_TRANS_FAC[var_30_2.main_attr]

				return var_35_0
			end

			arg_12_0.strengthenPanel.selectBnt:addTouchEventListener(function(arg_36_0, arg_36_1)
				if arg_36_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_12_0:oneClickSelect()
			end)

			arg_12_0.selectedItems = {}

			for iter_30_0 = 1, 6 do
				local var_30_22 = var_30_14:getChildByName("item" .. iter_30_0)

				var_30_22:setTouchEnabled(true)
				var_30_22:addTouchEventListener(function(arg_37_0, arg_37_1)
					local var_37_0

					if arg_37_1 ~= ccui.TouchEventType.ended then
						do return end

						var_37_0 = {}
					end

					function var_37_0.sure(arg_38_0)
						arg_12_0.selectedItems = arg_38_0

						arg_12_0.strengthenPanel:updateInfo((var_30_21()))
					end

					arg_12_0:addChild(ItemsPanel:create(kITEM_WEAPON_EXP, {
						weaponEntityid = arg_12_0.itemEntityid
					}, arg_12_0.selectedItems, var_37_0, ITEMPANEL_TYPE_WEAPON_STRENGTHEN), 99)
				end)

				arg_12_0.strengthenPanel["add" .. iter_30_0] = var_30_22
			end

			function arg_12_0.strengthenPanel.updateInfo(arg_39_0, arg_39_1)
				local var_39_0 = playermodel.items[arg_12_0.itemEntityid]
				local var_39_1 = item_data[playermodel.items[arg_12_0.itemEntityid].itemid]
				local var_39_2 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_0.itemEntityid])

				arg_39_1 = arg_39_1 or {
					gainExp = 0,
					newAttr = 0,
					costGold = 0,
					newLv = 0
				}

				local var_39_3

				if arg_39_1.newLv == 0 then
					var_39_3 = "LV." .. var_39_0.weapon_attr.level or "LV." .. arg_39_1.newLv

					local var_39_4

					if arg_39_1.newAttr == 0 then
						var_39_4 = var_39_2.main_attr.value or arg_39_1.newAttr
					end
				end

				var_30_8:setString(var_39_3)
				var_30_10:setString(FIGHT_ATTR_INFO[var_39_1.main_attr] .. "+" .. FIGHT_ATTR_FORMAT(var_39_1.main_attr, var_39_4))
				var_30_7:setString("LV." .. var_39_0.weapon_attr.level)
				var_30_9:setString(FIGHT_ATTR_INFO[var_39_1.main_attr] .. "+" .. FIGHT_ATTR_FORMAT(var_39_2.main_attr.attrtype, var_39_2.main_attr.value))
				var_30_9:setScale(1)
				var_30_15:setString(arg_39_1.gainExp)
				var_30_16:setString(arg_39_1.costGold)
				var_30_15:getParent():setPositionX(429 - var_30_15:getContentSize().width)

				local var_39_5 = var_30_9:getParent():getChildByName("Image_92")

				var_39_5:setPositionX(var_30_9:getPositionX() + var_30_9:getContentSize().width + var_39_5:getContentSize().width / 2)
				var_30_10:setPositionX(var_39_5:getPositionX() + var_39_5:getContentSize().width / 2)

				local var_39_6 = require("data.weapon_strengthen" .. var_39_1.equip_quality .. "_data")[var_39_0.weapon_attr.level].exp

				var_30_18:setString(var_39_0.weapon_attr.exp .. "/" .. var_39_6)
				var_30_19:setPercent(100 * tonumber(var_39_0.weapon_attr.exp + arg_39_1.gainExp) / tonumber(var_39_6) > 100 and 100 or math.floor(100 * tonumber(var_39_0.weapon_attr.exp + arg_39_1.gainExp) / tonumber(var_39_6)))
				var_30_20:setPercent(100 * tonumber(var_39_0.weapon_attr.exp) / tonumber(var_39_6) > 100 and 100 or math.floor(100 * tonumber(var_39_0.weapon_attr.exp) / tonumber(var_39_6)))

				for iter_39_0 = 1, 6 do
					var_30_14:getChildByName("item" .. iter_39_0):removeAllChildren()
				end

				for iter_39_1, iter_39_2 in pairs(arg_12_0.selectedItems) do
					if iter_39_2 > 0 then
						local var_39_7 = ItemSprite:create(iter_39_1, iter_39_2)

						var_39_7:setName("icon")
						var_39_7:setPosition(var_30_14:getChildByName("item" .. 1):getContentSize().width / 2, var_30_14:getChildByName("item" .. 1):getContentSize().height / 2)
						var_30_14:getChildByName("item" .. 1):addChild(var_39_7)

						local var_39_10 = ccui.Button:create("public/box/new_item_bg_cancle.png", "public/box/new_item_bg_cancle.png", "public/box/new_item_bg_cancle.png", var_0_9)

						var_39_10:setPosition(var_39_10:getContentSize().width / 2, var_39_7:getContentSize().width - var_39_10:getContentSize().height / 2)
						var_39_7:addChild(var_39_10)
						var_39_10:addTouchEventListener(function(arg_40_0, arg_40_1)
							if arg_40_1 ~= ccui.TouchEventType.ended then
								return
							end

							var_39_10:setTouchEnabled(false)

							arg_12_0.selectedItems[iter_39_1] = nil

							local var_40_0 = var_30_21()

							arg_12_0.strengthenPanel:runAction(cc.CallFunc:create(function()
								if arg_12_0.strengthenPanel then
									arg_12_0.strengthenPanel:updateInfo(var_40_0)
								end
							end))
						end)
					end
				end
			end

			function arg_12_0.strengthenPanel.showStrengthenEffect(arg_42_0, arg_42_1, arg_42_2)
				local var_42_0 = ccui.Layout:create()

				var_42_0:setTouchEnabled(true)
				var_42_0:setContentSize(cc.size(640, 1136))
				var_42_0:setAnchorPoint(cc.p(0, 0))
				arg_12_0.strengthenPanel:addChild(var_42_0, 9)

				local var_42_1 = item_data[playermodel.items[arg_12_0.itemEntityid].itemid]
				local var_42_2 = math.floor(100 * (playermodel.items[arg_12_0.itemEntityid].weapon_attr.exp / require("data.weapon_strengthen" .. item_data[playermodel.items[arg_12_0.itemEntityid].itemid].equip_quality .. "_data")[playermodel.items[arg_12_0.itemEntityid].weapon_attr.level].exp))
				local var_42_3 = playermodel.items[arg_12_0.itemEntityid].weapon_attr.level - arg_42_1.level
				local var_42_4 = (playermodel.items[arg_12_0.itemEntityid].weapon_attr.level - arg_42_1.level) / 5 < 1 and 1 or math.ceil(var_42_3 / 5)
				local var_42_5 = (weapon_manager:getWeaponConfig(playermodel.items[arg_12_0.itemEntityid]).main_attr.value - arg_42_1.attrValue) / var_42_4
				local var_42_6 = playermodel.items[arg_12_0.itemEntityid].weapon_attr.level - arg_42_1.level >= 2 and (100 - arg_42_1.percent + var_42_2 + (var_42_3 - 1) * 100) / var_42_4 or var_42_3 == 1 and (100 - arg_42_1.percent + var_42_2) / var_42_4 or (var_42_2 - arg_42_1.percent) / var_42_4
				local var_42_7 = arg_42_1.attrValue
				local var_42_8 = arg_42_1.percent

				local function var_42_9()
					var_42_8 = var_42_8 + var_42_6 / 60

					local var_43_2 = var_42_8 == 100 and 100 or math.floor(var_42_8 % 100)

					var_30_19:setPercent(var_42_3 == 0 and var_42_2 or math.floor(var_42_8 / 100) == var_42_3 and var_42_2 or 100)
					var_30_20:setPercent(var_43_2)
				end

				for iter_42_0 = 1, 6 do
					var_30_14:getChildByName("item" .. iter_42_0):removeAllChildren()
				end

				arg_12_0.strengthenPanel:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					var_42_4 = var_42_4 - 0.016666666666666666

					if var_42_4 <= 0 then
						if arg_42_2 then
							arg_42_2()
						end

						var_42_0:runAction(cc.RemoveSelf:create())

						if arg_12_0.strengthenPanel then
							arg_12_0.strengthenPanel:stopAllActions()
							var_30_4:stopAllActions()
						end
					else
						var_42_7 = var_42_7 + var_42_5 / 60

						var_30_9:setString(FIGHT_ATTR_INFO[var_42_1.main_attr] .. "+" .. FIGHT_ATTR_FORMAT(var_42_1.main_attr, var_42_7))

						local var_44_0 = var_30_9:getParent():getChildByName("Image_92")

						var_44_0:setPositionX(var_30_9:getPositionX() + var_30_9:getContentSize().width + var_44_0:getContentSize().width / 2)
						var_30_10:setPositionX(var_44_0:getPositionX() + var_44_0:getContentSize().width / 2)
						var_42_9()
					end
				end))))
				var_30_4:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.EaseInOut:create(cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(0, 6)), cc.ScaleBy:create(0.5, 1.007)), 2), cc.EaseInOut:create(cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(0, -6)), cc.ScaleBy:create(0.5, 0.99304865938431)), 2)))))
			end

			;(function()
				var_30_11:setString(var_30_2.name)
				var_30_13:setString(var_30_2.intro)
				var_30_12:setString(var_0_15[var_30_2.id % 10].quality)
				var_30_12:setColor(cc.c3b(var_0_15[var_30_2.id % 10].r, var_0_15[var_30_2.id % 10].g, var_0_15[var_30_2.id % 10].b))

				local var_45_0 = {
					"arms_icon1",
					"arms_icon2",
					"arms_icon3"
				}

				var_30_5:loadTexture("Weapon/" .. ((arg_12_0.servantid or nil) and (var_45_0[major_factor_data[servant_data[arg_12_0.servantid].major].role_type] or var_45_0[1])) .. ".png", var_0_9)
				var_30_4:loadTexture("weaponIcon/" .. var_30_2.image_id .. ".png")
				var_30_6:removeAllChildren()

				for iter_45_0 = 1, TOTAL_WEAPON_MAXSTARS do
					local var_45_3

					if config._DEBUG then
						var_45_3 = cc.Sprite:create(var_45_1) or cc.Sprite:createWithSpriteFrameName(var_45_1)
					end

					var_45_3:setScale(1.2)
					var_45_3:setPosition(24, 200 + (iter_45_0 - 1) * 36)
					var_30_6:addChild(var_45_3)
				end

				arg_12_0.strengthenPanel:updateInfo()
			end)()
		end,
		[var_0_13] = function()
			arg_12_0.breakthroughPanel = arg_12_0.BreakthroughPanel:clone()

			arg_12_0.breakthroughPanel:setVisible(true)
			arg_12_0.breakthroughPanel:setBackGroundImage("mainScenebg/levelBg.jpg")
			arg_12_0:addChild(arg_12_0.breakthroughPanel)

			local var_46_0 = playermodel.items[arg_12_0.itemEntityid]
			local var_46_1 = item_data[playermodel.items[arg_12_0.itemEntityid].itemid]
			local var_46_2 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_0.itemEntityid])
			local var_46_3 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Image_weapon")
			local var_46_4 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Image_w_type")
			local var_46_5 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Image_lock")
			local var_46_6 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Panel_stars")
			local var_46_7 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Label_lv")
			local var_46_8 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Label_attr")
			local var_46_9 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Label_name")
			local var_46_10 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Label_weapon_quality")
			local var_46_11 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("Label_des")

			var_46_11:setVisible(false)

			local var_46_12 = arg_12_0.breakthroughPanel:getChildByName("item_bg")
			local var_46_13 = var_46_12:getChildByName("cost_gold"):getChildByName("Label_num")
			local var_46_14 = var_46_12:getChildByName("Label_num_lv")
			local var_46_15 = var_46_12:getChildByName("Label_num_attr")
			local var_46_16 = arg_12_0.breakthroughPanel:getChildByName("weapon_bg"):getChildByName("bar_bg")

			var_46_16:setVisible(false)

			local var_46_17 = var_46_16:getChildByName("Label_exp")
			local var_46_18 = var_46_16:getChildByName("ProgressBar_yellow")
			local var_46_19 = var_46_16:getChildByName("ProgressBar_blue")

			arg_12_0.breakthroughPanel.returnBtn = arg_12_0.breakthroughPanel:getChildByName("Bottom_bg"):getChildByName("Button_return")
			arg_12_0.breakthroughPanel.sureBnt = arg_12_0.breakthroughPanel:getChildByName("Bottom_bg"):getChildByName("Button_sure")

			arg_12_0.breakthroughPanel.returnBtn:addTouchEventListener(function(arg_47_0, arg_47_1)
				if arg_47_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_12_0.breakthroughPanel:runAction(cc.RemoveSelf:create())
			end)
			arg_12_0.breakthroughPanel.sureBnt:addTouchEventListener(function(arg_48_0, arg_48_1)
				if arg_48_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_48_0:isBright() then
					return
				end

				arg_48_0:setBright(false)
				weapon_manager:BreakthroughWeapon(arg_12_0.itemEntityid, function(arg_49_0)
					if arg_49_0 == 1 then
						if arg_12_0.mainPanel then
							arg_12_0.mainPanel:updateInfo()
						end

						arg_12_0.breakthroughPanel:runAction(cc.RemoveSelf:create())

						arg_12_0.breakthroughPanel = nil
					end
				end)
			end)
			;(function()
				var_46_9:setString(var_46_1.name)
				var_46_11:setString(var_46_1.intro)
				var_46_10:setString(var_0_15[var_46_1.id % 10].quality)
				var_46_10:setColor(cc.c3b(var_0_15[var_46_1.id % 10].r, var_0_15[var_46_1.id % 10].g, var_0_15[var_46_1.id % 10].b))
				var_46_4:loadTexture("Weapon/" .. ({
					"arms_icon1",
					"arms_icon2",
					"arms_icon3"
				})[major_factor_data[servant_data[arg_12_0.servantid].major].role_type] .. ".png", var_0_9)
				var_46_3:loadTexture("weaponIcon/" .. var_46_1.image_id .. ".png")
				var_46_7:setString("LV." .. var_46_0.weapon_attr.level)
				var_46_8:setString(FIGHT_ATTR_INFO[var_46_1.main_attr] .. "+" .. FIGHT_ATTR_FORMAT(var_46_2.main_attr.attrtype, var_46_2.main_attr.value))

				local var_50_1 = require("data.weapon_strengthen" .. var_46_1.equip_quality .. "_data")[var_46_0.weapon_attr.level].exp
				local var_50_2 = math.abs(var_46_0.weapon_attr.exp)

				var_46_17:setString(var_50_2 .. "/" .. var_50_1)
				var_46_18:setPercent(0)
				var_46_19:setPercent(100 * tonumber(var_50_2) / tonumber(var_50_1) > 100 and 100 or math.floor(100 * tonumber(var_50_2) / tonumber(var_50_1)))
				var_46_6:removeAllChildren()

				for iter_50_0 = 1, TOTAL_WEAPON_MAXSTARS do
					local var_50_5

					if config._DEBUG then
						var_50_5 = cc.Sprite:create(var_50_3) or cc.Sprite:createWithSpriteFrameName(var_50_3)
					end

					var_50_5:setScale(1.2)
					var_50_5:setPosition(24, 200 + (iter_50_0 - 1) * 36)
					var_46_6:addChild(var_50_5)
				end

				local var_50_6 = {}

				while var_46_1["upgrade" .. var_46_0.weapon_attr.level / 10 .. "_item" .. 1] do
					table.insert(var_50_6, {
						itemid = var_46_1["upgrade" .. var_46_0.weapon_attr.level / 10 .. "_item" .. 1],
						num = var_46_1["upgrade" .. var_46_0.weapon_attr.level / 10 .. "_num" .. 1]
					})
				end

				for iter_50_1, iter_50_2 in pairs(var_50_6) do
					local var_50_8 = ccui.Button:create("public/box/UI_touming.png", "public/box/UI_touming.png", "public/box/UI_touming.png", var_0_9)

					var_50_8:setPosition(((#var_50_6 + 1) / 2 - iter_50_1) * 110 + var_46_12:getContentSize().width / 2, var_46_12:getContentSize().height / 2 - 250)
					var_50_8:setName("itemBnt" .. iter_50_1)
					var_46_12:addChild(var_50_8)

					local var_50_9 = ItemSprite:createWithItemId(iter_50_2.itemid, iter_50_2.num, true)

					var_50_9:setPosition(var_50_8:getContentSize().width / 2, var_50_8:getContentSize().height / 2)
					var_50_9:setName("icon")

					if item_manager:isHaveEnoughItem(iter_50_2.itemid, iter_50_2.num) then
						var_50_9:setOpacity(255)
						var_50_8:addTouchEventListener(function(arg_51_0, arg_51_1)
							if arg_51_1 ~= ccui.TouchEventType.ended then
								return
							end
						end)
					else
						var_50_8:addTouchEventListener(function(arg_52_0, arg_52_1)
							if arg_52_1 ~= ccui.TouchEventType.ended then
								return
							end

							if config._DEBUG then
								if not playermodel.items[iter_50_2.itemid] or not (iter_50_2.num - playermodel.items[iter_50_2.itemid].number) then
									-- block empty
								end

								require("network.network"):rpc("get_items", {
									gold = 0,
									diamond = 0,
									itemtype = iter_50_2.itemid,
									num = gain_num
								}, function(arg_53_0)
									if arg_53_0.result == 1 then
										print_lua_table(arg_53_0.items)
										item_manager:setItemByServerItem(arg_53_0.items[1])
										var_50_9:setOpacity(255)
										var_50_8:getChildByName("num"):setString(iter_50_2.num .. "/" .. playermodel.items[iter_50_2.itemid].number)
									end
								end)
							else
								LayerManager:pushInLayer("PopGoGainLayer", {
									item = iter_50_2.itemid
								})
							end
						end)
						var_50_9:setOpacity(120)
					end

					var_50_8:addChild(var_50_9)

					local var_50_10 = cc.Label:createWithTTF((playermodel.items[iter_50_2.itemid] or nil) and (iter_50_2.num .. "/" .. playermodel.items[iter_50_2.itemid].number or iter_50_2.num .. "/0"), "fonts/new1.ttf", 18)

					var_50_10:setName("num")
					var_50_10:enableOutline(cc.c4b(0, 0, 0, 255), 1)
					var_50_10:setPosition(var_50_8:getContentSize().width - var_50_10:getContentSize().width / 2, var_50_10:getContentSize().height / 2)
					var_50_8:addChild(var_50_10)
				end

				var_46_13:setString(var_46_1["upgrade" .. var_46_0.weapon_attr.level / 10 .. "_gold"])
				var_46_14:setString("LV." .. tostring(var_46_0.weapon_attr.level + 10))
				var_46_15:setString(FIGHT_ATTR_INFO[var_46_1.main_attr] .. "+" .. require("data.weapon_strengthen" .. var_46_1.equip_quality .. "_data")[var_46_0.weapon_attr.level + 10].all_value + var_46_1.value)
				arg_12_0.breakthroughPanel.sureBnt:addTouchEventListener(function(arg_54_0, arg_54_1)
					if arg_54_1 ~= ccui.TouchEventType.ended then
						return
					end

					weapon_manager:BreakthroughWeapon(arg_12_0.itemEntityid, function(arg_55_0)
						if arg_55_0 == 1 then
							if arg_12_0.mainPanel then
								arg_12_0.mainPanel:updateInfo()
							end

							arg_12_0.breakthroughPanel:runAction(cc.RemoveSelf:create())

							arg_12_0.breakthroughPanel = nil
						elseif arg_55_0 == 3 then
							global_ShowBlockWords(L_WEAPON_BREAK_THROUGH_FAIL[3])
						elseif arg_55_0 == 4 then
							global_ShowBlockWords(L_WEAPON_BREAK_THROUGH_FAIL[4])
						elseif arg_55_0 == 5 then
							global_ShowBlockWords(L_GOLD_LACK)
						elseif arg_55_0 == 6 then
							global_ShowBlockWords(L_WEAPON_BREAK_THROUGH_FAIL[6])
						end
					end)
				end)
			end)()
		end,
		[var_0_12] = function()
			local var_56_1 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_0.itemEntityid])

			arg_12_0:addChild(ItemsPanel:create(kITEM_WEAPON, {
				isFilterUsed = false,
				isFilterLocked = true,
				itemid = playermodel.items[arg_12_0.itemEntityid].itemid,
				selected = {
					arg_12_0.itemEntityid
				}
			}, nil, {
				sure = function(arg_57_0)
					weapon_manager:UpgradeWeapon(arg_12_0.itemEntityid, arg_57_0, function(arg_58_0)
						if arg_58_0 == 1 then
							if arg_12_0.mainPanel then
								arg_12_0.mainPanel:updateInfo()
							end
						elseif arg_58_0 == 2 then
							global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[2])
						elseif arg_58_0 == 3 then
							global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[3])
						elseif arg_58_0 == 4 then
							global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[4])
						elseif arg_58_0 == 5 then
							global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[5])
						end
					end)
				end
			}, ITEMPANEL_TYPE_UPGRADE_WEAPON), 99)
		end
	})[arg_12_1]()
end

function WeaponLayer.createWithItemId(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = WeaponLayer.new()

	var_59_0:initWithItemId(arg_59_1, arg_59_2)

	return var_59_0
end

function WeaponLayer:initWithItemId(arg_60_1, arg_60_2)
	var_0_8 = selfs
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Weapon_core.json" or "Weapon_core.ExportJson")

	self:addChild(self.rootLayer)

	self.MainPanel = self.rootLayer:getChildByName("Panel_main")

	self.MainPanel:retain()
	self.MainPanel:removeFromParent()

	self.StrengthenPanel = self.rootLayer:getChildByName("Panel_strengthen")

	self.StrengthenPanel:retain()
	self.StrengthenPanel:removeFromParent()

	self.BreakthroughPanel = self.rootLayer:getChildByName("Panel_breakthrough")

	self.BreakthroughPanel:retain()
	self.BreakthroughPanel:removeFromParent()
	self.MainPanel:getChildByName("Bottom_bg"):getChildByName("Button_changeWeapon"):setVisible(false)

	self.parms = arg_60_1
	self.itemid = arg_60_1.itemid
	self.showGetWays = arg_60_1.showGetWays or false
	self.photoPage = arg_60_1.photoSelectIndex

	self:initShowPanel()
	self:registerScriptHandler(function(arg_61_0)
		if arg_61_0 == "exit" then
			if arg_60_2 then
				arg_60_2()
			end

			var_0_8 = nil

			self.MainPanel:release()
			self.StrengthenPanel:release()
			self.BreakthroughPanel:release()
		end
	end)
end

function WeaponLayer:initShowPanel()
	self.mainPanel = self.MainPanel:clone()

	self.mainPanel:setVisible(true)
	self.mainPanel:setBackGroundImage("mainScenebg/levelBg.jpg")
	self:addChild(self.mainPanel)

	local var_62_0 = {
		itemid = self.itemid,
		weapon_attr = {
			nowStars = 5,
			level = 10
		}
	}
	local var_62_1 = item_data[var_62_0.itemid]

	var_62_0.weapon_attr.exp = require("data.weapon_strengthen" .. item_data[var_62_0.itemid].equip_quality .. "_data")[100].exp

	local var_62_2 = weapon_manager:getWeaponConfig(var_62_0)
	local var_62_3 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Image_weapon")
	local var_62_4 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Image_w_type")
	local var_62_5 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Image_lock")
	local var_62_6 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Panel_stars")
	local var_62_7 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_lv")
	local var_62_8 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_attr")
	local var_62_9 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_name")
	local var_62_10 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_weapon_quality")
	local var_62_11 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Label_des")

	var_62_11:setVisible(false)
	self.mainPanel:getChildByName("weapon_bg"):getChildByName("Breakthrough"):setVisible(false)

	local var_62_12 = self.mainPanel:getChildByName("info_bg")
	local var_62_13 = var_62_12:getChildByName("Image_skill")
	local var_62_14 = var_62_13:getChildByName("skill_name")
	local var_62_15 = var_62_13:getChildByName("skill_des")
	local var_62_16 = var_62_13:getChildByName("skill_cd")
	local var_62_17 = var_62_12:getChildByName("Label_passiveDes")
	local var_62_18 = var_62_12:getChildByName("Label_passiveName")
	local var_62_19 = var_62_12:getChildByName("Panel_passive")

	var_62_19:setVisible(false)

	local var_62_20 = self.mainPanel:getChildByName("weapon_bg"):getChildByName("bar_bg")
	local var_62_21 = var_62_20:getChildByName("Label_exp")
	local var_62_22 = var_62_20:getChildByName("ProgressBar_yellow")
	local var_62_23 = var_62_20:getChildByName("ProgressBar_blue")

	self.mainPanel.returnBtn = self.mainPanel:getChildByName("Bottom_bg"):getChildByName("Button_return")

	self.mainPanel:getChildByName("weapon_bg"):getChildByName("Button_strengthen"):setVisible(false)
	self.mainPanel:getChildByName("Bottom_bg"):getChildByName("Button_unload"):setVisible(false)

	self.mainPanel.unloadBtn = self.mainPanel:getChildByName("weapon_bg"):getChildByName("Button_upgrade"):setVisible(false)
	self.getWaysBtn = self.mainPanel:getChildByName("Bottom_bg"):getChildByName("Button_changeWeapon")

	self.mainPanel.returnBtn:addTouchEventListener(function(arg_63_0, arg_63_1)
		if arg_63_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:getParent():getName() ~= "DropDetailsLayer" then
			if self:getParent():getName() ~= "TwisteggLayer" then
				if self:getParent():getName() ~= "SignLayer" then
					if self:getParent():getName() == "ActivitySignLayer" then
						self:runAction(cc.RemoveSelf:create())

						goto label_63_0
					end
				end
			end
		end

		LayerManager:removePopLayer()

		::label_63_0::
	end)

	if not self.showGetWays then
		self.getWaysBtn:setVisible(false)
	end

	self.getWaysBtn:getChildByName("Label"):setString(L_WEAPON_SHOW_GET_WAYS)
	self.getWaysBtn:addTouchEventListener(function(arg_64_0, arg_64_1)
		if arg_64_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 172,
			item = self.itemid,
			goto_back_system_config = {
				initPage = self.photoPage
			},
			surecallback = function()
				if require("controller.layerconfig.pop_layer_infos")[layerName] then
					-- block empty
				end
			end
		})
	end)

	function self.mainPanel.updateInfo(arg_66_0)
		var_62_7:setString("LV." .. var_62_0.weapon_attr.level)
		var_62_8:setString(FIGHT_ATTR_INFO[var_62_1.main_attr] .. "+" .. math.floor(var_62_2.main_attr.value))
		var_62_6:removeAllChildren()

		for iter_66_0 = 1, TOTAL_WEAPON_MAXSTARS do
			local var_66_3

			if config._DEBUG then
				var_66_3 = cc.Sprite:create(var_66_1) or cc.Sprite:createWithSpriteFrameName(var_66_1)
			end

			var_66_3:setScale(1.2)
			var_66_3:setPosition(24, 200 + (iter_66_0 - 1) * 36)
			var_62_6:addChild(var_66_3)
		end

		for iter_66_1 = 1, 5 do
			if iter_66_1 <= TOTAL_WEAPON_MAXSTARS then
				var_62_19:getChildByName("Label_starsNum" .. iter_66_1):setVisible(true)
				var_62_19:getChildByName("Label_stars" .. iter_66_1):setVisible(true)
				var_62_19:getChildByName("Label_starsNum" .. iter_66_1):setString(10 * iter_66_1)

				if iter_66_1 == var_62_0.weapon_attr.nowStars then
					var_62_19:getChildByName("Label_starsNum" .. iter_66_1):setColor(cc.c3b(254, 173, 77))
				else
					var_62_19:getChildByName("Label_starsNum" .. iter_66_1):setColor(cc.c3b(112, 161, 214))
				end
			else
				var_62_19:getChildByName("Label_starsNum" .. iter_66_1):setVisible(false)
				var_62_19:getChildByName("Label_stars" .. iter_66_1):setVisible(false)
			end
		end

		local var_66_4 = {}

		string.gsub(" ", "[^#]+", function(arg_67_0)
			var_66_4[#var_66_4 + 1] = arg_67_0
		end)

		var_66_4[1] = var_66_4[1] or " "
		var_66_4[2] = var_66_4[2] or " "

		local var_66_5
		local var_66_6

		if var_62_12:getChildByName("m_passiveSkillDes") then
			var_66_5 = var_62_12:getChildByName("m_passiveSkillDes")
			var_66_6 = var_62_12:getChildByName("des1")

			var_66_6:setString("(" .. "+10%" .. ")")
			var_66_6:setVisible(false)
		end

		local var_66_7

		do
			var_66_5 = cc.Label:createWithTTF("", "fonts/new1.ttf", 20)

			var_66_5:setColor(cc.c3b(182, 189, 203))
			var_66_5:setAnchorPoint(cc.p(0, 1))
			var_66_5:setMaxLineWidth(480)
			var_66_5:setPosition(var_62_17:getPositionX(), var_62_17:getPositionY())
			var_66_5:setName("m_passiveSkillDes")
			var_62_12:addChild(var_66_5)

			var_66_6 = cc.Label:createWithTTF("(" .. "+10%" .. ")", "fonts/new1.ttf", 20)

			var_66_6:setAnchorPoint(cc.p(0, 0.5))
			var_66_6:setColor(cc.c3b(236, 185, 67))
			var_66_6:setPosition(var_66_5:getContentSize().width, var_66_5:getContentSize().height / 2)
			var_66_6:setName("des1")
			var_66_6:setVisible(false)
			var_62_12:addChild(var_66_6, 1)

			var_66_7 = ""
		end

		for iter_66_2 = 1, math.ceil(var_66_6:getContentSize().width / 5) do
			var_66_7 = var_66_7 .. " "
		end

		var_66_5:setString(var_66_4[1])
		var_66_5:setString(var_66_4[1] .. var_66_7 .. var_66_4[2])
		var_66_6:setPosition(var_66_5:getPositionX() + var_66_5:getContentSize().width, var_66_5:getPositionY() - var_66_5:getContentSize().height / 2)

		local var_66_8 = require("data.weapon_strengthen" .. var_62_1.equip_quality .. "_data")[var_62_0.weapon_attr.level].exp

		var_62_21:setString(var_62_0.weapon_attr.exp .. "/" .. var_66_8)
		var_62_22:setPercent(0)
		var_62_23:setPercent(100 * tonumber(var_62_0.weapon_attr.exp) / tonumber(var_66_8) > 100 and 100 or math.floor(100 * tonumber(var_62_0.weapon_attr.exp) / tonumber(var_66_8)))
	end

	;(function()
		var_62_9:setString(var_62_1.name)
		var_62_11:setString(var_62_1.intro)
		var_62_10:setString(var_0_15[var_62_1.id % 10].quality)
		var_62_10:setColor(cc.c3b(var_0_15[var_62_1.id % 10].r, var_0_15[var_62_1.id % 10].g, var_0_15[var_62_1.id % 10].b))

		local var_68_0 = {
			"arms_icon1",
			"arms_icon2",
			"arms_icon3"
		}

		var_62_4:loadTexture("Weapon/" .. ((var_62_1.major or nil) and (var_68_0[major_factor_data[var_62_1.major].role_type] or var_68_0[1])) .. ".png", var_0_9)
		var_62_3:loadTexture("weaponIcon/" .. var_62_1.image_id .. ".png")
		var_62_5:setVisible(false)
		print(dump(var_62_1))
		var_62_14:setString("")
		var_62_15:setString(var_62_1.intro)
		var_62_16:setString("")

		if var_62_1.skill then
			var_62_18:setVisible(true)
			var_62_17:setVisible(true)
			var_62_18:setString(total_skill_data[var_62_1.skill].name)
			var_62_17:setString(total_skill_data[var_62_1.skill].description)
		else
			var_62_18:setVisible(false)
			var_62_17:setVisible(false)
		end

		var_62_19:getChildByName("Label_shuzhi"):setString("")
		self.mainPanel:updateInfo(self.itemEntityid)
	end)()
end

function WeaponLayer:oneClickSelect()
	local var_69_0 = item_data[playermodel.items[self.itemEntityid].itemid]
	local var_69_1 = weapon_manager:getWeaponConfig(playermodel.items[self.itemEntityid])
	local var_69_2 = require("data.weapon_strengthen" .. item_data[playermodel.items[self.itemEntityid].itemid].equip_quality .. "_data")
	local var_69_3 = var_69_2[10].all_exp - var_69_2[10].exp - (var_69_2[playermodel.items[self.itemEntityid].weapon_attr.level].all_exp - var_69_2[playermodel.items[self.itemEntityid].weapon_attr.level].exp + playermodel.items[self.itemEntityid].weapon_attr.exp)

	if var_69_3 <= 0 then
		global_ShowBlockWords(L_WEAPON_LEVEL[Select_Lv_Max])

		return
	end

	self.selectedItems = (function()
		local var_70_0 = {}
		local var_70_1 = {}
		local var_70_2 = 0
		local var_70_3 = item_manager:filterSortItems(kITEM_WEAPON_EXP, {
			sortType = "number",
			orderType = 0,
			hurtType = {
				0,
				var_69_0.mechanical_or_energy
			}
		})

		if next(var_70_3) == nil then
			return
		end

		for iter_70_0, iter_70_1 in pairs(var_70_3) do
			var_70_2 = var_70_2 + playermodel.items[iter_70_1].number * item_data[iter_70_1].gain_exp
			var_70_1[#var_70_1 + 1] = {
				id = iter_70_1,
				num = playermodel.items[iter_70_1].number,
				exp = item_data[iter_70_1].gain_exp,
				needNum = var_69_3 / item_data[iter_70_1].gain_exp
			}
		end

		table.sort(var_70_1, function(arg_71_0, arg_71_1)
			return arg_71_0.exp > arg_71_1.exp
		end)

		if var_70_2 <= var_69_3 then
			for iter_70_2, iter_70_3 in ipairs(var_70_3) do
				var_70_0[iter_70_3] = playermodel.items[iter_70_3].number
			end
		else
			local var_70_4 = 0
			local var_70_5

			for iter_70_4, iter_70_5 in ipairs(var_70_1) do
				if iter_70_5.needNum >= 1 then
					var_70_4 = var_70_4 + iter_70_5.exp * iter_70_5.num
				else
					var_70_5 = iter_70_4
				end
			end

			if var_70_4 == 0 then
				var_70_0[var_70_1[#var_70_1].id] = 1
			elseif var_70_4 >= var_69_3 then
				var_70_5 = var_70_5 or 0

				if var_70_5 + 1 == #var_70_1 then
					var_70_0[var_70_1[var_70_5 + 1].id] = var_70_1[var_70_5 + 1].num >= math.ceil(var_70_1[var_70_5 + 1].needNum) and math.ceil(var_70_1[var_70_5 + 1].needNum) or var_70_1[var_70_5 + 1].num
				else
					local var_70_6 = var_70_1[var_70_5 + 1].num >= math.floor(var_70_1[var_70_5 + 1].needNum) and math.floor(var_70_1[var_70_5 + 1].needNum) or var_70_1[var_70_5 + 1].num

					var_70_0[var_70_1[var_70_5 + 1].id] = var_70_6

					local var_70_7 = var_70_1[var_70_5 + 1].needNum - var_70_6

					if var_70_1[var_70_5 + 1].needNum - var_70_6 > 0 then
						local var_70_8 = var_70_5 + 2

						while var_70_8 <= #var_70_1 and var_70_7 > 0 do
							local var_70_9 = var_70_1[var_70_8].num >= math.ceil(var_70_7 * (var_70_1[var_70_5 + 1].exp / var_70_1[var_70_8].exp)) and math.ceil(var_70_7 * (var_70_1[var_70_5 + 1].exp / var_70_1[var_70_8].exp)) or var_70_1[var_70_8].num

							var_70_0[var_70_1[var_70_8].id] = var_70_9
							var_70_7 = var_70_7 - var_70_9 / (var_70_1[var_70_5 + 1].exp / var_70_1[var_70_8].exp)
							var_70_8 = var_70_8 + 1
						end
					end
				end
			else
				var_70_0[var_70_1[var_70_5].id] = 1
			end
		end

		return var_70_0
	end)() or {}

	if next(self.selectedItems) == nil then
		global_ShowBlockWords(L_WEAPON_STRENGTHEN.Material_Lack)

		return
	end

	local var_69_4 = {
		gainExp = 0,
		newAttr = 0,
		costGold = 0,
		newLv = playermodel.items[self.itemEntityid].weapon_attr.level
	}

	for iter_69_0, iter_69_1 in pairs(self.selectedItems) do
		if item_data[iter_69_0] and iter_69_1 > 0 then
			var_69_4.gainExp = var_69_4.gainExp + item_data[iter_69_0].gain_exp * iter_69_1
		end
	end

	var_69_4.costGold = math.floor(var_69_4.gainExp * WEAPON_STRENGTHEN_C)

	local var_69_5 = require("data.weapon_strengthen" .. item_data[playermodel.items[self.itemEntityid].itemid].equip_quality .. "_data")
	local var_69_6 = playermodel.items[self.itemEntityid].weapon_attr.level

	while var_69_5[playermodel.items[self.itemEntityid].weapon_attr.level].all_exp - var_69_5[playermodel.items[self.itemEntityid].weapon_attr.level].exp + playermodel.items[self.itemEntityid].weapon_attr.exp + var_69_4.gainExp >= var_69_5[var_69_6].all_exp do
		if var_69_6 % 10 == 0 and var_69_6 ~= playermodel.items[self.itemEntityid].weapon_attr.level then
			break
		end

		var_69_6 = var_69_6 + 1
		var_69_4.newLv = var_69_6
	end

	var_69_4.newAttr = (var_69_5[var_69_4.newLv].all_value + item_data[playermodel.items[self.itemEntityid].itemid].value) * FIGHT_ATTR_TRANS_FAC[item_data[playermodel.items[self.itemEntityid].itemid].main_attr]

	self.strengthenPanel:updateInfo(var_69_4)
end

function WeaponLayer.exit(arg_72_0)
	LayerManager:removePopLayer()
end
