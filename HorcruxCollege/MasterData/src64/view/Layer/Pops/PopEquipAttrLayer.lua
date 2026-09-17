PopEquipAttrLayer = class("PopEquipAttrLayer", function()
	return PopBaseLayer:create()
end)

local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local var_0_2 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local core_manager = require("controller.core_manager")
local weapon_manager = require("controller.weapon_manager")
local model_manager = require("controller.model_manager")
local component_manager = require("controller.component_manager")
local FightUtils = require("fight.FightUtils")
local course_cultivate_manager = require("controller.course_cultivate_manager")
local var_0_10 = course_cultivate_manager:getInstance()
local var_0_11 = require("controller/horcrux_devour/horcrux_devour_manager").getInstance(course_cultivate_manager)
local l2utils = require("controller.l2utils")
local TempWidget = require("view.Sprite.TempWidget")

function PopEquipAttrLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopEquipAttrLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopEquipAttrLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Souls_attrinfo.json" or "Souls_attrinfo.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:loadTexture("mainScenebg/equip_attrinfo_inner_bg.png")
	self.rootLayer:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	self.nameNode = self.rootpanel:getChildByName("name")
	self.nameEnNode = self.rootpanel:getChildByName("name_en")

	self.showActions.extendVertical(self)

	self.showType = "attrNum"

	self:initData(arg_3_1)
	self:initUI()
	self:updateAttrDesPanelData()
	self:initAttrDesPanelUI()
	AnalyticManager.click_pop_equip_attr_layer({
		servantid = self.servantid
	})
	self:fullscreen()
end

function PopEquipAttrLayer:initData(arg_6_1)
	self.servantid = arg_6_1.servantid
	self.courseProperty = {}

	local var_6_0 = var_0_10:getEffectiveBuffs(servant_data[self.servantid].modelid)

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = FightUtils:getBuffInfo(var_6_0[iter_6_0])

		if var_6_1.attr and var_6_1.attrvalue then
			self.courseProperty[var_6_1.attr] = self.courseProperty[var_6_1.attr] or {
				value = 0
			}
			self.courseProperty[var_6_1.attr].value = self.courseProperty[var_6_1.attr].value + var_6_1.attrvalue
		end
	end

	self.model = model_manager.new()

	self.model:initPlayerAttribute(self.servantid)

	if playermodel.haveServant[self.servantid] and playermodel.weaponId[self.servantid] then
		self.model:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[self.servantid]], nil, self.servantid)))
	end

	self.model:updateComponentAttr((component_manager:getSoulComponentlist(self.servantid)))

	self.modelid = global_get_servant_skin(self.servantid)
	self.nameStr = model_data[self.modelid].name_Q
	self.nameEnStr = model_data[self.modelid].English_name
end

local var_0_14 = {
	{
		name = "科技",
		key = "science_point",
		des = "学员数量,共振数会提升科技值，影响学员的攻击和生命属性。"
	},
	{
		name = "攻击",
		key = "damage",
		des = "受学员的科技值及攻击资质共同影响，具体为学员科技值*攻击资质"
	},
	{
		name = "血量",
		key = "hp",
		des = "受学员的科技值及血量资质共同影响，具体为学员科技值*血量资质"
	},
	{
		name = "攻速",
		key = "attackspeed",
		des = "学员每秒钟普攻次数"
	},
	{
		name = "射程",
		key = "range",
		des = "学员最大的攻击距离"
	}
}
local var_0_15 = {
	{
		key = "damage_type",
		name = "攻击类型",
		maxLen = 170,
		check0 = false,
		des = "这是描述"
	},
	{
		check0 = true,
		key = "damage_percent",
		name = "攻击",
		des = "受学员的科技值及攻击资质共同影响，具体为学员科技值*攻击资质"
	},
	{
		check0 = true,
		key = "hp_percent",
		name = "血量",
		des = "受学员的科技值及血量资质共同影响，具体为学员科技值*血量资质"
	},
	{
		key = "critical",
		name = "暴击率",
		maxLen = 195,
		check0 = false,
		des = "角色攻击发生暴击的几率，产生暴击时默认造成200%的伤害"
	},
	{
		checkKey = "critical",
		key = "cri_damage_add",
		name = "暴击伤害",
		des = "提升角色暴击时造成的伤害"
	},
	{
		checkKey = "strike",
		key = "strike_damage_add",
		name = "强击伤害",
		des = "提升角色强击时造成的伤害"
	},
	{
		key = "defence",
		name = "防御值",
		maxLen = 195,
		check0 = false,
		des = "减少受到的机械伤害"
	},
	{
		key = "energydefence",
		name = "能量防御",
		maxLen = 170,
		check0 = false,
		des = "减少受到的能量伤害"
	},
	{
		check0 = true,
		key = "hematophagy",
		name = "吸血",
		des = "造成伤害时恢复自身血量"
	},
	{
		key = "dodge",
		name = "闪避率",
		maxLen = 195,
		check0 = false,
		des = "被攻击时有一定的机率发生闪避，闪避时默认受到50%的伤害"
	},
	{
		key = "dodge_damage_add",
		name = "闪避减伤",
		checkKey = "dodge",
		maxLen = 170,
		des = "减少闪避时受到的伤害"
	},
	{
		key = "extra_attack",
		name = "额外伤害",
		maxLen = 170,
		check0 = false,
		des = "提高所有造成的伤害"
	},
	{
		check0 = true,
		key = "extra_attack_const",
		name = "额外固定值伤害",
		des = "额外造成一定量伤害"
	},
	{
		key = "extra_defence",
		name = "额外减伤",
		maxLen = 170,
		check0 = false,
		des = "减少所有受到的机械和能量伤害"
	},
	{
		check0 = true,
		key = "extra_defence_const",
		name = "额外固定值伤害减免",
		des = "抵消一定量的伤害"
	},
	{
		key = "force",
		name = "击退距离",
		maxLen = 170,
		check0 = false,
		des = "普攻时击退敌人的距离单位"
	},
	{
		key = "reforce",
		name = "击退抵抗",
		maxLen = 170,
		check0 = false,
		des = "实际击退距离=击退距离-击退抵抗"
	},
	{
		key = "movingspeed",
		name = "移速",
		maxLen = 220,
		check0 = false,
		des = "每秒钟移动距离"
	},
	{
		check0 = true,
		key = "healpoint",
		name = "每秒百分比恢复血量",
		des = "每秒百分比恢复血量"
	},
	{
		check0 = true,
		key = "extra_heal_const",
		name = "额外恢复固定生命值",
		des = "额外恢复的血量"
	},
	{
		check0 = true,
		key = "extra_rage",
		name = "额外充能速率",
		des = "提升充能速率"
	},
	{
		checkKey = true,
		key = "extra_rage_const",
		name = "额外充能值",
		des = "固定充能"
	},
	{
		check0 = false,
		key = "aaa",
		name = "这是名字",
		des = "这是描述"
	},
	{
		check0 = false,
		key = "aaa",
		name = "这是名字",
		des = "这是描述"
	},
	{
		check0 = false,
		key = "aaa",
		name = "这是名字",
		des = "这是描述"
	},
	{
		check0 = false,
		key = "aaa",
		name = "这是名字",
		des = "这是描述"
	}
}
local var_0_16 = {
	252,
	186,
	119,
	52,
	-11
}
local var_0_17 = 0
local var_0_18 = 310
local var_0_19 = 40

function PopEquipAttrLayer:initAttrNumPanel()
	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_shopImage")

	var_7_0:loadTexture(PANEL_ROLE_IMAGE_PATH .. model_data[self.modelid].role_image .. ".png")
	var_7_0:setPosition(cc.p(175, 660))
	var_7_0:setRotation(4.5)

	self.bigAttrCloneNode = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrBig")
	self.smallAttrCloneNode = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrSmall")
	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_attr")

	self.scrollView:setPositionX(25)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrBig"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrSmall"):setVisible(false)

	local var_7_1 = var_0_11:getAttrBonus(self.servantid)

	for iter_7_0, iter_7_1 in pairs(var_0_14) do
		local var_7_2 = iter_7_1.key
		local var_7_3 = self.bigAttrCloneNode:clone()

		var_7_3:setVisible(true)

		local var_7_4 = ccui.Helper:seekWidgetByName(var_7_3, "Label_attr1")
		local var_7_5 = ccui.Helper:seekWidgetByName(var_7_3, "Label_attr2")

		var_7_4:setString(string.sub(FIGHT_ATTR_INFO[var_7_2], 1, 3))
		var_7_5:setString(string.sub(FIGHT_ATTR_INFO[var_7_2], 4, 6))
		var_7_4:setTouchEnabled(true)
		var_7_4:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_8_0 = arg_8_0:getTouchEndPosition()

			self:showPropertyDetailPanel(iter_7_1, cc.p(var_8_0.x, var_8_0.y + 100))
		end)
		var_7_5:setTouchEnabled(true)
		var_7_5:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_9_0 = arg_9_0:getTouchEndPosition()

			self:showPropertyDetailPanel(iter_7_1, cc.p(var_9_0.x, var_9_0.y + 100))
		end)

		if var_7_2 == "damage" then
			if L_DAMAGE_TYPE[model_data[servant_data[self.servantid].modelid].damage_type] then
				-- block empty
			end

			ccui.Helper:seekWidgetByName(var_7_3, "Label_attrNum"):setString(FIGHT_ATTR_FORMAT(var_7_2, self.model:getAttribute(var_7_2) + var_7_1[var_7_2]))
		else
			ccui.Helper:seekWidgetByName(var_7_3, "Label_attrNum"):setString(FIGHT_ATTR_FORMAT(var_7_2, self.model:getAttribute(var_7_2) + var_7_1[var_7_2]))
		end

		if self.courseProperty[iter_7_1.key] then
			local var_7_8 = ccui.Helper:seekWidgetByName(var_7_3, "Label_attrNum")
			local var_7_9 = TempWidget:CreateTempLabel("+" .. self.courseProperty[iter_7_1.key].value, FONT_NAME, 20, var_7_8)

			var_7_9:_setColor("00FFA3")
			var_7_9:align(cc.p(0, 0.5), var_7_8:getContentSize().width, var_7_8:getContentSize().height / 2)
		end

		if var_7_2 == "damage" then
			ccui.Helper:seekWidgetByName(var_7_3, "Label_attrDes"):setString("(" .. L_HORCRUX_BREAK_LIMIT.Aptitude_Str[2] .. self.model:getFactorAttribute("damageFactor") .. ")")
		elseif var_7_2 == "hp" then
			ccui.Helper:seekWidgetByName(var_7_3, "Label_attrDes"):setString("(" .. L_HORCRUX_BREAK_LIMIT.Aptitude_Str[3] .. self.model:getFactorAttribute("hpFactor") .. ")")
		else
			ccui.Helper:seekWidgetByName(var_7_3, "Label_attrDes"):setString("(" .. FIGHT_ATTR_DES[var_7_2] .. ")")
		end

		var_7_3:setPosition(cc.p(350, var_0_16[iter_7_0] + 320))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrNum"):addChild(var_7_3)
	end

	local var_7_10 = 0
	local var_7_11 = 0

	for iter_7_2, iter_7_3 in pairs(var_0_15) do
		if iter_7_3.check0 and self.model:getAttribute(iter_7_3.key) and self.model:getAttribute(iter_7_3.key) ~= 0 then
			var_7_11 = var_7_11 + 1

			if var_7_11 % 2 == 0 then
				var_7_10 = var_7_10 + self.smallAttrCloneNode:getContentSize().height
			end
		elseif iter_7_3.checkKey and self.model:getAttribute(iter_7_3.checkKey) and self.model:getAttribute(iter_7_3.checkKey) ~= 0 then
			var_7_11 = var_7_11 + 1

			if var_7_11 % 2 == 0 then
				var_7_10 = var_7_10 + self.smallAttrCloneNode:getContentSize().height
			end
		elseif not iter_7_3.check0 and not iter_7_3.checkKey then
			var_7_11 = var_7_11 + 1

			if var_7_11 % 2 == 0 then
				var_7_10 = var_7_10 + self.smallAttrCloneNode:getContentSize().height
			end
		end
	end

	if var_7_10 < self.scrollView:getContentSize().height then
		var_7_10 = self.scrollView:getContentSize().height
	end

	self.scrollView:setInnerContainerSize(cc.size(548, var_7_10))

	local var_7_12 = 1

	for iter_7_4, iter_7_5 in pairs(var_0_15) do
		if iter_7_5.key == "defence" then
			print(self.model:getAttribute(iter_7_5.key))
		end

		if iter_7_5.key == "aaa" then
			local var_7_13 = self.smallAttrCloneNode:clone()

			var_7_13:setVisible(true)
			var_7_13:setPositionY(var_7_10 - var_0_19)
			ccui.Helper:seekWidgetByName(var_7_13, "Label_attr"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_7_13, "Label_attrNum"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_7_13, "Image_noneLine"):setVisible(true)
			self.scrollView:addChild(var_7_13)

			if var_7_12 % 2 == 0 then
				var_7_10 = var_7_10 - var_0_19

				var_7_13:setPositionX(var_0_18)
			else
				var_7_13:setPositionX(var_0_17)
			end

			var_7_12 = var_7_12 + 1
		elseif iter_7_5.key == "damage_type" then
			local var_7_14 = self.smallAttrCloneNode:clone()

			var_7_14:setVisible(true)
			ccui.Helper:seekWidgetByName(var_7_14, "Image_noneLine"):setVisible(false)

			local var_7_15 = ccui.Helper:seekWidgetByName(var_7_14, "Label_attr")

			var_7_15:setString("攻击类型")
			var_7_15:setTouchEnabled(true)
			var_7_15:addTouchEventListener(function(arg_10_0, arg_10_1)
				if arg_10_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_10_0 = arg_10_0:getTouchEndPosition()

				self:showPropertyDetailPanel(iter_7_5, cc.p(var_10_0.x, var_10_0.y + 100))
			end)
			ccui.Helper:seekWidgetByName(var_7_14, "Label_attrNum"):setString((L_DAMAGE_TYPE[model_data[servant_data[self.servantid].modelid].damage_type] or nil) and "(" .. L_DAMAGE_TYPE[model_data[servant_data[self.servantid].modelid].damage_type] .. ")")

			iter_7_5.AttrNum = 0

			var_7_14:setPositionY(var_7_10 - var_0_19)
			self.scrollView:addChild(var_7_14)

			if var_7_12 % 2 == 0 then
				var_7_10 = var_7_10 - var_0_19

				var_7_14:setPositionX(var_0_18)
			else
				var_7_14:setPositionX(var_0_17)
			end

			var_7_12 = var_7_12 + 1
		elseif iter_7_5.check0 and self.model:getAttribute(iter_7_5.key) and self.model:getAttribute(iter_7_5.key) ~= 0 then
			local var_7_17 = self.smallAttrCloneNode:clone()

			var_7_17:setVisible(true)
			ccui.Helper:seekWidgetByName(var_7_17, "Image_noneLine"):setVisible(false)

			local var_7_18 = ccui.Helper:seekWidgetByName(var_7_17, "Label_attr")

			var_7_18:setString(FIGHT_ATTR_INFO[iter_7_5.key])
			var_7_18:setTouchEnabled(true)
			var_7_18:addTouchEventListener(function(arg_11_0, arg_11_1)
				if arg_11_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_11_0 = arg_11_0:getTouchEndPosition()

				self:showPropertyDetailPanel(iter_7_5, cc.p(var_11_0.x, var_11_0.y + 100))
			end)

			if iter_7_5.key == "defence" then
				ccui.Helper:seekWidgetByName(var_7_17, "Label_attrNum"):setString(self.model:getAttribute(iter_7_5.key) .. "(" .. string.format("%.1f%%", 100 * self.model:getAttribute(iter_7_5.key) / (self.model:getAttribute(iter_7_5.key) + DEFENCE_CONSTANT)) .. ")")

				iter_7_5.AttrNum = self.model:getAttribute(iter_7_5.key) .. "(" .. string.format("%.1f%%", 100 * self.model:getAttribute(iter_7_5.key) / (self.model:getAttribute(iter_7_5.key) + DEFENCE_CONSTANT)) .. ")"
			else
				ccui.Helper:seekWidgetByName(var_7_17, "Label_attrNum"):setString(FIGHT_ATTR_FORMAT(iter_7_5.key, self.model:getAttribute(iter_7_5.key)))

				iter_7_5.AttrNum = FIGHT_ATTR_FORMAT(iter_7_5.key, self.model:getAttribute(iter_7_5.key))
			end

			var_7_17:setPositionY(var_7_10 - var_0_19)
			self.scrollView:addChild(var_7_17)

			if var_7_12 % 2 == 0 then
				var_7_10 = var_7_10 - var_0_19

				var_7_17:setPositionX(var_0_18)
			else
				var_7_17:setPositionX(var_0_17)
			end

			var_7_12 = var_7_12 + 1
		elseif iter_7_5.checkKey and self.model:getAttribute(iter_7_5.checkKey) and self.model:getAttribute(iter_7_5.checkKey) ~= 0 then
			local var_7_19 = self.smallAttrCloneNode:clone()

			var_7_19:setVisible(true)
			ccui.Helper:seekWidgetByName(var_7_19, "Image_noneLine"):setVisible(false)

			local var_7_20 = ccui.Helper:seekWidgetByName(var_7_19, "Label_attr")

			var_7_20:setString(FIGHT_ATTR_INFO[iter_7_5.key])
			var_7_20:setTouchEnabled(true)
			var_7_20:addTouchEventListener(function(arg_12_0, arg_12_1)
				if arg_12_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_12_0 = arg_12_0:getTouchEndPosition()

				self:showPropertyDetailPanel(iter_7_5, cc.p(var_12_0.x, var_12_0.y + 100))
			end)

			if iter_7_5.key == "defence" or iter_7_5.key == "energydefence" then
				ccui.Helper:seekWidgetByName(var_7_19, "Label_attrNum"):setString(self.model:getAttribute(iter_7_5.key) .. "(" .. string.format("%.1f%%", 100 * self.model:getAttribute(iter_7_5.key) / (self.model:getAttribute(iter_7_5.key) + DEFENCE_CONSTANT)) .. ")")

				iter_7_5.AttrNum = self.model:getAttribute(iter_7_5.key) .. "(" .. string.format("%.1f%%", 100 * self.model:getAttribute(iter_7_5.key) / (self.model:getAttribute(iter_7_5.key) + DEFENCE_CONSTANT)) .. ")"
			else
				ccui.Helper:seekWidgetByName(var_7_19, "Label_attrNum"):setString(FIGHT_ATTR_FORMAT(iter_7_5.key, self.model:getAttribute(iter_7_5.key)))

				iter_7_5.AttrNum = FIGHT_ATTR_FORMAT(iter_7_5.key, self.model:getAttribute(iter_7_5.key))
			end

			var_7_19:setPositionY(var_7_10 - var_0_19)
			self.scrollView:addChild(var_7_19)

			if var_7_12 % 2 == 0 then
				var_7_10 = var_7_10 - var_0_19

				var_7_19:setPositionX(var_0_18)
			else
				var_7_19:setPositionX(var_0_17)
			end

			var_7_12 = var_7_12 + 1
		elseif not iter_7_5.check0 and not iter_7_5.checkKey then
			local var_7_21 = self.smallAttrCloneNode:clone()

			var_7_21:setVisible(true)
			ccui.Helper:seekWidgetByName(var_7_21, "Image_noneLine"):setVisible(false)

			local var_7_22 = ccui.Helper:seekWidgetByName(var_7_21, "Label_attr")

			var_7_22:setString(FIGHT_ATTR_INFO[iter_7_5.key])
			var_7_22:setTouchEnabled(true)
			var_7_22:addTouchEventListener(function(arg_13_0, arg_13_1)
				if arg_13_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_13_0 = arg_13_0:getTouchEndPosition()

				self:showPropertyDetailPanel(iter_7_5, cc.p(var_13_0.x, var_13_0.y + 100))
			end)

			if iter_7_5.key == "defence" or iter_7_5.key == "energydefence" then
				ccui.Helper:seekWidgetByName(var_7_21, "Label_attrNum"):setString(self.model:getAttribute(iter_7_5.key) .. "(" .. string.format("%.1f%%", 100 * self.model:getAttribute(iter_7_5.key) / (self.model:getAttribute(iter_7_5.key) + DEFENCE_CONSTANT)) .. ")")

				iter_7_5.AttrNum = self.model:getAttribute(iter_7_5.key) .. "(" .. string.format("%.1f%%", 100 * self.model:getAttribute(iter_7_5.key) / (self.model:getAttribute(iter_7_5.key) + DEFENCE_CONSTANT)) .. ")"
			else
				ccui.Helper:seekWidgetByName(var_7_21, "Label_attrNum"):setString(FIGHT_ATTR_FORMAT(iter_7_5.key, self.model:getAttribute(iter_7_5.key)))

				iter_7_5.AttrNum = FIGHT_ATTR_FORMAT(iter_7_5.key, self.model:getAttribute(iter_7_5.key))
			end

			if self.courseProperty[iter_7_5.key] then
				local var_7_23 = ccui.Helper:seekWidgetByName(var_7_21, "Label_attrNum")
				local var_7_24 = TempWidget:CreateTempLabel("+" .. self.courseProperty[iter_7_5.key].value, FONT_NAME, 20, var_7_23)

				var_7_24:_setColor("00FFA3")
				var_7_24:align(cc.p(0, 0.5), var_7_23:getContentSize().width, var_7_23:getContentSize().height / 2)

				local var_7_25 = var_7_24:getContentSize().width
				local var_7_26 = var_7_23:getPositionX()

				var_7_23:setPositionX(var_7_26 - var_7_25)

				local var_7_27 = var_7_23:getContentSize().width + var_7_24:getContentSize().width
				local var_7_28 = iter_7_5.maxLen or 170

				if var_7_28 <= var_7_27 then
					local var_7_29 = (var_7_28 - var_7_23:getContentSize().width) / (var_7_27 - var_7_23:getContentSize().width)

					var_7_24:setScale(var_7_29)
					var_7_23:setPositionX(var_7_26 - var_7_25 * var_7_29)
				end
			end

			var_7_21:setPositionY(var_7_10 - var_0_19)
			self.scrollView:addChild(var_7_21)

			if var_7_12 % 2 == 0 then
				var_7_10 = var_7_10 - var_0_19

				var_7_21:setPositionX(var_0_18)
			else
				var_7_21:setPositionX(var_0_17)
			end

			var_7_12 = var_7_12 + 1
		end
	end

	local var_7_30 = TempWidget:CreateTempLabel("绿色数值为课程系统加成", FONT_NAME, 20, self.rootpanel)

	var_7_30:_setColor("137E64")
	var_7_30:align(cc.p(1, 0), self.rootpanel:getContentSize().width - 10, 15)
end

function PopEquipAttrLayer:showPropertyDetailPanel(arg_14_1, arg_14_2)
	local var_14_0 = ccui.Layout:create()

	var_14_0:setTouchEnabled(true)
	var_14_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_14_0:setAnchorPoint(cc.p(0, 0))
	var_14_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_14_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_0:setBackGroundColorOpacity(140)
	var_14_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_14_0:setTouchEnabled(true)
	self:addChild(var_14_0, 100)
	var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_14_0:runAction(cc.RemoveSelf:create())
	end)

	local var_14_1 = ccui.ImageView:create("equip_layer_servant_info_layer/popup_buff_details.png", var_0_2)

	var_14_1:setPosition(cc.p(320, arg_14_2.y))
	var_14_1:setScale9Enabled(true)
	var_14_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_14_0:addChild(var_14_1)

	local var_14_2 = arg_14_1.des
	local var_14_3 = 370
	local var_14_4 = var_14_1:getContentSize().height
	local var_14_5 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_14_5:setMaxLineWidth(370)
	var_14_5:setVisible(false)
	var_14_0:addChild(var_14_5)
	var_14_5:setString(var_14_2)

	local var_14_6 = 0 + 26 + var_14_5:getContentSize().height + 6

	if var_14_4 < var_14_6 then
		var_14_1:setContentSize(cc.size(var_14_1:getContentSize().width, var_14_6))
	else
		var_14_6 = var_14_4
	end

	local var_14_8 = cc.Label:createWithTTF(arg_14_1.name, FONT_DES, 24)

	var_14_8:setAnchorPoint(cc.p(0, 1))
	var_14_8:setColor(cc.c3b(64, 240, 95))
	var_14_8:setPosition(cc.p(20, var_14_6 - 10))
	var_14_1:addChild(var_14_8)

	local var_14_9 = cc.Label:createWithTTF(var_14_2, FONT_DES, 24)

	var_14_9:setColor(cc.c3b(220, 235, 241))
	var_14_9:setAnchorPoint(cc.p(0, 1))
	var_14_9:setMaxLineWidth(var_14_3)
	var_14_9:setPosition(cc.p(4, var_14_6 - 26))
	var_14_9:setVisible(false)
	var_14_1:addChild(var_14_9)

	local var_14_10 = RichTextPro:create()

	var_14_10:setMaxWidth(var_14_3)
	var_14_10:setSize(24)
	var_14_10:setColor(cc.c3b(220, 251, 241))
	var_14_10:setLineSpace(0)
	var_14_10:setText((transSkillDesToRichText(var_14_2)))
	var_14_10:setPosition(cc.p(20, var_14_6 - 26 - 15))
	var_14_1:addChild(var_14_10)
end

local var_0_20 = {
	Panel_damageTitle = {
		"damage",
		"attackspeed",
		"extra_attack",
		"extra_attack_const",
		"critical",
		"cri_damage_add",
		"strike",
		"strike_damage_add"
	},
	Panel_defenceTitle = {
		"hp",
		"defence",
		"extra_defence",
		"extra_defence_const",
		"dodge",
		"dodge_damage_add",
		"hematophagy",
		"healpoint",
		"extra_heal_const"
	},
	Panel_otherTitle = {
		"science_point",
		"force",
		"reforce",
		"movingspeed",
		"range",
		"extra_rage",
		"extra_rage_const"
	}
}
local var_0_21 = 40

function PopEquipAttrLayer.initAttrDesPanelData(arg_16_0)
	arg_16_0.attrDesPos = {
		Panel_damageTitle = {
			posY = 637,
			desHeight = 0
		},
		Panel_defenceTitle = {
			desHeight = 0,
			posY = 637 - var_0_21
		},
		Panel_otherTitle = {
			desHeight = 0,
			posY = 637 - var_0_21 - var_0_21
		}
	}
	arg_16_0.moveTime = 0.1
	arg_16_0.selectTitlePanel = "Panel_damageTitle"
end

function PopEquipAttrLayer.resetAttrDesPanel(arg_17_0)
	arg_17_0.attrDesPos = {
		Panel_damageTitle = {
			posY = 637,
			desHeight = 0
		},
		Panel_defenceTitle = {
			desHeight = 0,
			posY = 637 - var_0_21
		},
		Panel_otherTitle = {
			desHeight = 0,
			posY = 637 - var_0_21 - var_0_21
		}
	}
end

local var_0_22 = 38

function PopEquipAttrLayer:updateAttrDesPanelData()
	for iter_18_0, iter_18_1 in pairs(self.attrDesPos) do
		iter_18_1.desHeight = self.selectTitlePanel == iter_18_0 and #var_0_20[iter_18_0] * var_0_22 or 0
	end

	self.attrDesPos.Panel_defenceTitle.posY = self.attrDesPos.Panel_damageTitle.posY - self.attrDesPos.Panel_damageTitle.desHeight - var_0_21
	self.attrDesPos.Panel_otherTitle.posY = self.attrDesPos.Panel_defenceTitle.posY - self.attrDesPos.Panel_defenceTitle.desHeight - var_0_21
end

function PopEquipAttrLayer:initUI()
	self.bigAttrPanel = "attrNum"

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_attrInfo"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_attrNum"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_attrInfo"):runAction(self:getBtnActionObj(1))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_attrInfo"):addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:chagneBigAttrPanel("attrInfo")
		arg_20_0:runAction((self:getBtnTouchActionObj(1, function()
			arg_20_0:stopAllActions()
			arg_20_0:setPositionX(568)
			arg_20_0:runAction(self:getBtnActionObj(1))
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_attrNum"):runAction(self:getBtnActionObj(-1))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_attrNum"):addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:chagneBigAttrPanel("attrNum")
		arg_22_0:runAction((self:getBtnTouchActionObj(-1, function()
			arg_22_0:stopAllActions()
			arg_22_0:setPositionX(6)
			arg_22_0:runAction(self:getBtnActionObj(-1))
		end)))
	end)

	if self.bigAttrPanel == "attrNum" then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrNum"):setPositionX(0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrInfo"):setPositionX(592)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrNum"):setPositionX(-592)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrInfo"):setPositionX(0)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrInfo"):setVisible(false)
	self.nameNode:setString(self.nameStr)
	self.nameEnNode:setString(self.nameEnStr)
	self:initAttrNumPanel()
	self:initAttrDesPanelData()
end

function PopEquipAttrLayer:chagneBigAttrPanel(arg_24_1)
	if self.bigAttrPanel ~= arg_24_1 then
		self.bigAttrPanel = arg_24_1

		self:chagneBigAttrPanelAct()
	end
end

function PopEquipAttrLayer:chagneBigAttrPanelAct()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_attrInfo"):setVisible(self.bigAttrPanel ~= "attrInfo")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_attrNum"):setVisible(self.bigAttrPanel == "attrInfo")

	if self.bigAttrPanel == "attrNum" then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrNum"):setPositionX(-592)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrInfo"):setPositionX(0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrNum"):runAction(cc.MoveTo:create(self.moveTime, cc.p(0, 0)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrInfo"):runAction(cc.MoveTo:create(self.moveTime, cc.p(-592, 0)))
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrNum"):setPositionX(0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrInfo"):setPositionX(592)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrNum"):runAction(cc.MoveTo:create(self.moveTime, cc.p(-592, 0)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attrInfo"):runAction(cc.MoveTo:create(self.moveTime, cc.p(0, 0)))
	end
end

function PopEquipAttrLayer:initAttrDesPanelUI()
	for iter_26_0, iter_26_1 in pairs(var_0_20) do
		local var_26_0 = ccui.Helper:seekWidgetByName(self.rootLayer, iter_26_0)

		var_26_0:setPositionY(self.attrDesPos[iter_26_0].posY)

		local var_26_1 = ccui.Helper:seekWidgetByName(var_26_0, "Panel_attrDes"):getContentSize().width

		for iter_26_2, iter_26_3 in pairs(iter_26_1) do
			local var_26_2 = ccui.ImageView:create("equip_layer_servant_info_layer/point_attr.png", var_0_2)

			var_26_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_2:setPosition(cc.p(40, #iter_26_1 * var_0_22 - iter_26_2 * var_0_22 + var_0_22 / 2))
			ccui.Helper:seekWidgetByName(var_26_0, "Panel_attrDes"):addChild(var_26_2)

			local var_26_3 = cc.Label:createWithTTF(FIGHT_ATTR_INFO[iter_26_3] .. "--" .. FIGHT_ATTR_DES[iter_26_3], FONT_DES, 30)

			var_26_3:setColor(cc.c3b(211, 237, 247))
			var_26_3:setAnchorPoint(cc.p(0, 0))
			var_26_3:setPosition(cc.p(50, #iter_26_1 * var_0_22 - iter_26_2 * var_0_22))
			ccui.Helper:seekWidgetByName(var_26_0, "Panel_attrDes"):addChild(var_26_3)
		end

		if self.selectTitlePanel == iter_26_0 then
			ccui.Helper:seekWidgetByName(var_26_0, "Panel_clip"):setPositionY(-(#iter_26_1 * var_0_22))
			ccui.Helper:seekWidgetByName(var_26_0, "Panel_attrDes"):setContentSize(cc.size(var_26_1, #iter_26_1 * var_0_22))
			ccui.Helper:seekWidgetByName(var_26_0, "Panel_clip"):setContentSize(cc.size(var_26_1, #iter_26_1 * var_0_22))
		else
			ccui.Helper:seekWidgetByName(var_26_0, "Panel_attrDes"):setContentSize(cc.size(var_26_1, 0))
			ccui.Helper:seekWidgetByName(var_26_0, "Panel_clip"):setContentSize(cc.size(var_26_1, 0))
		end

		var_26_0:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectTitlePanel ~= iter_26_0 then
				self:resetAttrDesPanel()
				self:attrDesPanelMoveClost()

				self.selectTitlePanel = iter_26_0

				if self.selectTitlePanel == "Panel_defenceTitle" then
					AnalyticManager.click_pop_equip_attr_layer_defence({
						servantid = self.servantid
					})
				end

				self.rootpanel:runAction(cc.Sequence:create(cc.DelayTime:create(self.moveTime), cc.CallFunc:create(function()
					self:updateAttrDesPanelData()
					self:resetAttrDesPanelContentSize()
					self:attrDesPanelMoveOpen()
				end)))
			end
		end)
	end
end

function PopEquipAttrLayer:attrDesPanelMoveClost()
	for iter_29_0, iter_29_1 in pairs(var_0_20) do
		local var_29_0 = ccui.Helper:seekWidgetByName(self.rootLayer, iter_29_0)

		var_29_0:runAction(cc.MoveTo:create(self.moveTime, cc.p(var_29_0:getPositionX(), self.attrDesPos[iter_29_0].posY)))

		if iter_29_0 == self.selectTitlePanel then
			local var_29_1 = ccui.Helper:seekWidgetByName(var_29_0, "Panel_clip")

			ccui.Helper:seekWidgetByName(var_29_0, "Panel_attrDes").runAction(var_29_1, cc.MoveTo:create(self.moveTime, cc.p(ccui.Helper:seekWidgetByName(var_29_0, "Panel_attrDes"):getPositionX(), var_29_1:getContentSize().height)))
		end
	end
end

function PopEquipAttrLayer:attrDesPanelMoveOpen()
	for iter_30_0, iter_30_1 in pairs(var_0_20) do
		local var_30_0 = ccui.Helper:seekWidgetByName(self.rootLayer, iter_30_0)
		local var_30_1 = ccui.Helper:seekWidgetByName(var_30_0, "Panel_attrDes"):getPositionX()

		var_30_0:runAction(cc.MoveTo:create(self.moveTime, cc.p(var_30_1, self.attrDesPos[iter_30_0].posY)))
		ccui.Helper:seekWidgetByName(var_30_0, "Panel_attrDes"):setPositionY(self.attrDesPos[iter_30_0].desHeight)
		ccui.Helper:seekWidgetByName(var_30_0, "Panel_attrDes"):runAction(cc.MoveTo:create(self.moveTime, cc.p(var_30_1, 0)))
	end
end

function PopEquipAttrLayer:resetAttrDesPanelContentSize()
	for iter_31_0, iter_31_1 in pairs(var_0_20) do
		local var_31_0 = ccui.Helper:seekWidgetByName(self.rootLayer, iter_31_0)
		local var_31_1 = ccui.Helper:seekWidgetByName(var_31_0, "Panel_attrDes"):getContentSize().width

		ccui.Helper:seekWidgetByName(var_31_0, "Panel_attrDes"):setContentSize(cc.size(var_31_1, self.attrDesPos[iter_31_0].desHeight))
		ccui.Helper:seekWidgetByName(var_31_0, "Panel_clip"):setContentSize(cc.size(var_31_1, self.attrDesPos[iter_31_0].desHeight))
		ccui.Helper:seekWidgetByName(var_31_0, "Panel_clip"):setPositionY(-self.attrDesPos[iter_31_0].desHeight)
	end
end

function PopEquipAttrLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopEquipAttrLayer:initBg(arg_34_1)
	local var_34_0 = ccui.Layout:create()

	var_34_0:setTouchEnabled(true)
	var_34_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_34_0:setAnchorPoint(cc.p(0, 0))
	var_34_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_34_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_34_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_34_0:setOpacity(0)
	self:addChild(var_34_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_35_0)
		self:addChild(arg_35_0, -2)
		arg_35_0:setPositionY(arg_35_0:getPositionY() - GameDisplay.fix_y)

		local var_35_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_35_0:setAnchorPoint(cc.p(0, 0))
		var_35_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_35_0, -1)
		self:init(arg_34_1)
		var_34_0:setOpacity(102)
		var_34_0:setTouchEnabled(false)
	end)
end

function PopEquipAttrLayer.getBtnActionObj(arg_36_0, arg_36_1)
	return (cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(16 * arg_36_1, 0)), cc.MoveBy:create(0.3, cc.p(-24 * arg_36_1, 0)), cc.MoveBy:create(0.1, cc.p(8 * arg_36_1, 0)), cc.DelayTime:create(0.8))))
end

function PopEquipAttrLayer.getBtnTouchActionObj(arg_37_0, arg_37_1, arg_37_2)
	return (cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(32 * arg_37_1, 0)), cc.MoveBy:create(0.3, cc.p(-48 * arg_37_1, 0)), cc.MoveBy:create(0.1, cc.p(16 * arg_37_1, 0)), cc.CallFunc:create(arg_37_2)))
end

function PopEquipAttrLayer:fullscreen()
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(cc.p(GameDisplay.width / 2, (GameDisplay.height + GameDisplay.fix_y) / 2))
end
