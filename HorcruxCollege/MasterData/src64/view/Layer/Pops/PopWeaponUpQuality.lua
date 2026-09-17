PopWeaponUpQuality = class("PopWeaponUpQuality", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local armature_manager = require("controller.armature_manager")
local audio_manager = require("controller.audio_manager")
local l2utils = require("controller.l2utils")
local item_data = require("data.item_data")
local unique_weapon_data = require("data.unique_weapon_data")

function PopWeaponUpQuality.create(arg_2_0, arg_2_1)
	local var_2_0 = PopWeaponUpQuality.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

local var_0_9 = {
	"public/box/word_white_bg.png",
	"public/box/word_green_bg.png",
	"public/box/word_blue_bg.png",
	"public/box/word_purple_bg.png",
	"public/box/word_orange_bg.png",
	"public/box/word_red_bg.png"
}
local var_0_10 = {
	"public/box/weapon_bg_white.png",
	"public/box/weapon_bg_green.png",
	"public/box/weapon_bg_blue.png",
	"public/box/weapon_bg_purple.png",
	"public/box/weapon_bg_orange.png",
	"public/box/weapon_bg_red.png"
}

function PopWeaponUpQuality:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "WeaponUpQualityPop.json" or "WeaponUpQualityPop.ExportJson")

	self:addChild(self.rootLayer)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_pop")

	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)

	self.entityid = arg_3_1.entityid
	self.exitcallback = arg_3_1.exitcallback
	self.goto_back_system_id = arg_3_1.goto_back_system_id

	self:initData()
	self:initUI()
	self:updateUI()
end

function PopWeaponUpQuality:initData()
	if weapon_manager:nextQualityWeaponIsUnique(self.entityid) then
		self.uniqueWeapons = weapon_manager:getNextQualityUniqueWeapons(self.entityid)
		self.selectWeapon = self.uniqueWeapons[1]
	else
		self.selectWeapon = weapon_manager:getNextQualityWeaponId(self.entityid)
	end

	self:updateMaterialList()
end

function PopWeaponUpQuality:updateMaterialList()
	self.material = weapon_manager:getUpWeaponQualityMaterial(self.selectWeapon)
end

function PopWeaponUpQuality.updateSelectNextWeapon(arg_8_0)
	return
end

function PopWeaponUpQuality:initUI()
	self:initMaterialListPanel()

	self.sureBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")

	self.sureBtn:addTouchEventListener(self:getSureHandle())

	if weapon_manager:checkUpWeaponQuality(self.entityid, self.selectWeapon) == 1 then
		self.sureBtn:loadTextures("Weapon/upQualityPop/sure.png", nil, "Weapon/upQualityPop/sure_off.png", var_0_0)
	else
		self.sureBtn:loadTextures("Weapon/upQualityPop/sure_off.png", nil, "Weapon/upQualityPop/sure_off.png", var_0_0)
	end
end

function PopWeaponUpQuality.getSureHandle(arg_10_0)
	return function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0.sureBtn:isBright() then
			return
		end

		arg_10_0.sureBtn:setBright(false)

		local var_11_0 = weapon_manager:checkUpWeaponQuality(arg_10_0.entityid, arg_10_0.selectWeapon)

		if var_11_0 == 1 then
			weapon_manager:up_weapon_quality(arg_10_0.entityid, arg_10_0.selectWeapon, function(arg_12_0)
				if arg_12_0 == 1 then
					arg_10_0:playQualityUpEffect(arg_10_0.entityid)

					if arg_10_0.exitcallback then
						arg_10_0.exitcallback(1)
					end

					LayerManager:removePopLayer(arg_10_0.__queueindex)
				end
			end)
		elseif var_11_0 == 5 then
			global_ShowBlockWords(L_WEAPON_UP_QUALITY_WARNING[5])
		elseif var_11_0 == 6 then
			global_ShowBlockWords(L_WEAPON_UP_QUALITY_WARNING[6])
		elseif var_11_0 == 7 then
			global_ShowBlockWords(L_WEAPON_UP_QUALITY_WARNING[7])
		elseif var_11_0 == 8 then
			global_ShowBlockWords(L_WEAPON_UP_QUALITY_WARNING[8])
		end

		arg_10_0.sureBtn:setBright(true)
	end
end

function PopWeaponUpQuality:updateData()
	if weapon_manager:nextQualityWeaponIsUnique(self.entityid) then
		self.uniqueWeapons = weapon_manager:getNextQualityUniqueWeapons(self.entityid)
		self.selectWeapon = self.uniqueWeapons[1]
	else
		self.selectWeapon = weapon_manager:getNextQualityWeaponId(self.entityid)
	end

	self:updateMaterialList()
end

local var_0_12 = {
	Panel_topPanel = cc.p(0, 0),
	Panel_bottomPanel = cc.p(0, -250),
	Panel_uniqueWeaponPanel = cc.p(1000, 0)
}
local var_0_13 = {
	Panel_topPanel = cc.p(0, 90),
	Panel_bottomPanel = cc.p(0, -340),
	Panel_uniqueWeaponPanel = cc.p(0, -142)
}

function PopWeaponUpQuality:updateUniqueWeaponList()
	local function var_14_0()
		for iter_15_0, iter_15_1 in pairs(self.uniqueWeaponObjList) do
			iter_15_1:getChildByName("Image_selected"):setVisible(iter_15_1.itemid == self.selectWeapon)
		end
	end

	local function var_14_1(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectWeapon = arg_16_0.itemid

		self:updateWeaponInfo()
		var_14_0()
	end

	self.uniqueWeaponListView = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_uniqueWeapon")

	self.uniqueWeaponListView:removeAllChildren()

	self.uniqueWeaponObjList = {}

	for iter_14_0, iter_14_1 in pairs(self.uniqueWeapons) do
		local var_14_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_uniqueWeapon"):clone()

		var_14_2:getChildByName("Image_weaponImg"):loadTexture("equipment/" .. item_data[iter_14_1].image_id .. ".png")
		var_14_2:getChildByName("Image_weaponBg"):loadTexture(var_0_10[item_data[iter_14_1].equip_quality], var_0_0)
		var_14_2:addTouchEventListener(var_14_1)

		var_14_2.itemid = iter_14_1

		self.uniqueWeaponListView:pushBackCustomItem(var_14_2)
		table.insert(self.uniqueWeaponObjList, var_14_2)
	end

	var_14_0()
end

function PopWeaponUpQuality:updateUI()
	if weapon_manager:nextQualityWeaponIsUnique(self.entityid) then
		self:updateUniqueWeaponList()
		self.rootpanel:loadTexture("Weapon/upQualityPop/weapon_up_to_unique_bg.png", var_0_0)
	else
		self.rootpanel:loadTexture("Weapon/upQualityPop/weapon_up_quality_bg.png", var_0_0)
	end

	;(function()
		for iter_18_0, iter_18_1 in pairs(weapon_manager:nextQualityWeaponIsUnique(self.entityid) and var_0_13 or var_0_12) do
			ccui.Helper:seekWidgetByName(self.rootLayer, iter_18_0):setPositionX(iter_18_1.x + self.rootpanel:getContentSize().width / 2)
			ccui.Helper:seekWidgetByName(self.rootLayer, iter_18_0):setPositionY(iter_18_1.y + self.rootpanel:getContentSize().height / 2)
		end
	end)()
	self:updateWeaponInfo()
end

function PopWeaponUpQuality:updateWeaponInfo()
	local function var_19_0(arg_20_0, arg_20_1)
		arg_20_0:getChildByName("Image_weaponBg"):loadTexture(var_0_10[item_data[arg_20_1.itemid].equip_quality], var_0_0)
		arg_20_0:getChildByName("Image_weaponIcon"):loadTexture("equipment/" .. item_data[arg_20_1.itemid].image_id .. ".png")

		for iter_20_0 = 1, 5 do
			if item_data[arg_20_1.itemid].max_star < iter_20_0 then
				arg_20_0:getChildByName("PanelstarPanel"):getChildByName("Image_star_" .. iter_20_0):setVisible(false)
			elseif iter_20_0 <= arg_20_1.nowStars then
				arg_20_0:getChildByName("PanelstarPanel"):getChildByName("Image_star_" .. iter_20_0):loadTexture("public/currency/weapon_star.png", var_0_0)
			else
				arg_20_0:getChildByName("PanelstarPanel"):getChildByName("Image_star_" .. iter_20_0):loadTexture("public/currency/weapon_star_empty.png", var_0_0)
			end
		end

		arg_20_0:getChildByName("Image_lvBg"):loadTexture(var_0_9[item_data[arg_20_1.itemid].equip_quality], var_0_0)
		arg_20_0:getChildByName("Image_lvBg"):getChildByName("Label_level"):setString("LV." .. arg_20_1.level)
	end

	local var_19_1 = {
		itemid = playermodel.items[self.entityid].itemid,
		nowStars = playermodel.items[self.entityid].weapon_attr.nowStars,
		level = playermodel.items[self.entityid].weapon_attr.level
	}
	local var_19_2 = {
		nowStars = 0,
		itemid = self.selectWeapon,
		level = playermodel.items[self.entityid].weapon_attr.level
	}

	var_19_0(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_curWeaponSp"), var_19_1)
	var_19_0(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_nextWeaponSp"), var_19_2)

	local var_19_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_maxLevel")
	local var_19_4 = var_19_3:getChildByName("Label_1")

	var_19_4:setString(L_WEAPON_UP_QUALITY_INFO.Level .. weapon_manager:getWeaponMaxLevelByItemid(var_19_1.itemid))

	local var_19_5 = var_19_3:getChildByName("Image_arrow")

	var_19_5:setPositionX(var_19_4:getPositionX() + var_19_4:getContentSize().width)

	local var_19_6 = var_19_3:getChildByName("Label_2")

	var_19_6:setString(weapon_manager:getWeaponMaxLevelByItemid(var_19_2.itemid))
	var_19_6:setPositionX(var_19_5:getPositionX() + var_19_5:getContentSize().width)

	local var_19_7 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_maxStar")
	local var_19_8 = var_19_7:getChildByName("Label_1")

	var_19_8:setString(L_WEAPON_UP_QUALITY_INFO.Star .. item_data[var_19_1.itemid].max_star)

	local var_19_9 = var_19_7:getChildByName("Image_arrow")

	var_19_9:setPositionX(var_19_8:getPositionX() + var_19_8:getContentSize().width)

	local var_19_10 = var_19_7:getChildByName("Label_2")

	var_19_10:setString(item_data[var_19_2.itemid].max_star)
	var_19_10:setPositionX(var_19_9:getPositionX() + var_19_9:getContentSize().width)

	local var_19_11 = weapon_manager:getWeaponConfig(playermodel.items[self.entityid])
	local var_19_12 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_subAttrAdd")
	local var_19_13 = var_19_12:getChildByName("Label_1")

	var_19_13:setString(FIGHT_ATTR_INFO[item_data[var_19_1.itemid].sub_attr] .. ":" .. FIGHT_ATTR_FORMAT(var_19_11.sub_attr.attrtype, var_19_11.sub_attr.value))

	local var_19_14 = var_19_12:getChildByName("Image_arrow")

	var_19_14:setPositionX(var_19_13:getPositionX() + var_19_13:getContentSize().width)

	local var_19_15 = var_19_12:getChildByName("Label_2")

	var_19_15:setString(FIGHT_ATTR_INFO[item_data[var_19_2.itemid].sub_attr] .. ":" .. FIGHT_ATTR_FORMAT(item_data[var_19_2.itemid].sub_attr, FIGHT_ATTR_TRANS_FAC[item_data[var_19_2.itemid].sub_attr] * item_data[var_19_2.itemid].sub_value0))
	var_19_15:setPositionX(var_19_14:getPositionX() + var_19_14:getContentSize().width)
	var_19_12:setPositionX(-(var_19_13:getContentSize().width + var_19_15:getContentSize().width + var_19_14:getContentSize().width) / 2)
end

function PopWeaponUpQuality:initMaterialListPanel()
	local var_21_0 = #self.material
	local var_21_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_materialPanel"):getContentSize().width
	local var_21_2 = #self.material * var_21_1

	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_materialList")

	self.scrollView:removeAllChildren()

	if var_21_2 < self.scrollView:getContentSize().width then
		var_21_2 = self.scrollView:getContentSize().width
	end

	self.scrollView:setInnerContainerSize(cc.size(var_21_2, 120))

	local function var_21_3(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_22_0.ownNum >= arg_22_0.needNum then
			PopLayer:Item({
				itemid = arg_22_0.itemid,
				goto_back_system_id = self.goto_back_system_id,
				layer = cc.Layer:create(),
				removeParentCallback = function()
					self:removeSelf(panel)
				end
			})
		else
			local var_22_0 = PopLayer.new()
			local var_22_1 = PopLayer:Go_Gain_Layer({
				item = arg_22_0.itemid,
				surecallback = function()
					LayerManager:removePopLayer(self.__queueindex)
				end,
				goto_back_system_id = self.goto_back_system_id
			})

			if var_22_1 then
				self:addChild(var_22_1, 999)
			end
		end
	end

	local var_21_4 = var_21_2 / 2
	local var_21_5 = 0

	for iter_21_0, iter_21_1 in pairs(self.material) do
		local var_21_6 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_materialPanel"):clone()

		var_21_6:getChildByName("Image_itemIcon"):loadTexture("equipment/" .. item_data[iter_21_1.itemid].image_id .. ".png")
		var_21_6:getChildByName("Image_numBg"):loadTexture(var_0_9[item_data[iter_21_1.itemid].equip_quality], var_0_0)
		var_21_6:getChildByName("Button_itemBg"):loadTextures(var_0_10[item_data[iter_21_1.itemid].equip_quality], var_0_10[item_data[iter_21_1.itemid].equip_quality], nil, var_0_0)

		local var_21_7 = var_21_6:getChildByName("Label_ownNum")

		var_21_7:setString(iter_21_1.ownNum)

		local var_21_8 = var_21_6:getChildByName("Label_needNum")

		var_21_8:setString("/" .. iter_21_1.needNum)
		var_21_7:setPositionX(var_21_6:getContentSize().width / 2 - (var_21_7:getContentSize().width + var_21_8:getContentSize().width) / 2)
		var_21_8:setPositionX(var_21_7:getPositionX() + var_21_7:getContentSize().width)

		if iter_21_1.ownNum < iter_21_1.needNum then
			var_21_7:setColor(cc.c3b(197, 61, 236))
		else
			var_21_7:setColor(cc.c3b(255, 255, 255))
		end

		local var_21_9 = var_21_6:getChildByName("Button_itemBg")

		var_21_9:addTouchEventListener(var_21_3)

		var_21_9.itemid = iter_21_1.itemid
		var_21_9.ownNum = iter_21_1.ownNum
		var_21_9.needNum = iter_21_1.needNum

		var_21_6:setPosition(cc.p((iter_21_0 - var_21_0 / 2 - 1) * var_21_1 + var_21_4, var_21_5))
		self.scrollView:addChild(var_21_6)
	end
end

function PopWeaponUpQuality.playQualityUpEffect(arg_25_0, arg_25_1)
	audio_manager:playeffectMusic("weapon_starup")

	local var_25_0 = ccui.Layout:create()

	var_25_0:setTouchEnabled(true)
	var_25_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_25_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_25_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_25_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_25_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_25_0:setBackGroundColorOpacity(220)
	global_basic_scene:addChild(var_25_0, 999)

	local var_25_1 = playermodel.items[arg_25_1].itemid

	local function var_25_2()
		local var_26_0 = {}

		for iter_26_0 = 1, item_data[var_25_1].max_star do
			local var_26_1 = ccui.ImageView:create("public/currency/weapon_star_empty.png", var_0_0)

			var_26_1:setPosition(cc.p(320 + (iter_26_0 - (item_data[var_25_1].max_star + 1) / 2) * (var_26_1:getContentSize().width - 10), 545))
			table.insert(var_26_0, var_26_1)
			var_26_1:setVisible(false)
			var_25_0:addChild(var_26_1)
		end

		for iter_26_1, iter_26_2 in pairs(var_26_0) do
			var_26_0[iter_26_1]:setScale(8)
			var_26_0[iter_26_1]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_26_1 / 30), cc.CallFunc:create(function()
				var_26_0[iter_26_1]:setVisible(true)
			end), cc.Spawn:create(cc.RotateBy:create(0.55, 72), cc.Sequence:create(cc.ScaleTo:create(0.15, 1, 1), cc.ScaleTo:create(0.25, 2, 2), cc.ScaleTo:create(0.15, 1, 1)))))
		end
	end

	local var_25_3 = L2Skeleton:create("spine/ui/weapon_up_quality/weapon_up.json", "spine/ui/weapon_up_quality/weapon_up.atlas")

	var_25_3:refreshSkeleton()
	var_25_3:setSlotTexture("wuqi", "diergewuqi", "equipment/" .. item_data[playermodel.items[arg_25_1].itemid].image_id .. ".png")
	var_25_3:setSlotTexture("wuqi", "wuqishengjiewuqi", "equipment/" .. item_data[playermodel.items[arg_25_1].itemid].image_id .. ".png")
	var_25_3:setSlotTexture("wuqikuang", "wuqishengjiewuqikuang", ({
		"weaponIcon/weapon_bg_white.png",
		"weaponIcon/weapon_bg_green.png",
		"weaponIcon/weapon_bg_blue.png",
		"weaponIcon/weapon_bg_purple.png",
		"weaponIcon/weapon_bg_orange.png",
		"weaponIcon/weapon_bg_red.png"
	})[item_data[playermodel.items[arg_25_1].itemid].equip_quality])
	var_25_3.skeletonAnimation:setPosition(cc.p(320, 600))
	var_25_3:play("weapon_up", false)
	var_25_0:addChild(var_25_3)

	local var_25_4 = false

	var_25_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_25_2()
		var_25_3:play("weapon_up_stay", true)

		var_25_4 = true
	end), cc.DelayTime:create(8), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		if callback then
			callback()
		end
	end)))
	var_25_0:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_25_4 then
			return
		end

		if callback then
			callback()
		end

		var_25_0:runAction(cc.RemoveSelf:create())
	end)
end

function PopWeaponUpQuality:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
