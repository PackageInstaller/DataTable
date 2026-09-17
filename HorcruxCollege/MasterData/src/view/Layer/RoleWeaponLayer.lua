RoleWeaponLayer = class("RoleWeaponLayer", function()
	return cc.Layer:create()
end)

local network = require("network.network")
local playermodel = require("model.playermodel")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local total_skill_data = require("data.total_skill_data")
local weapon_revolution_data = require("data.weapon_revolution_data")
local var_0_6
local var_0_7 = config._DEBUG and 0 or 1

function RoleWeaponLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = RoleWeaponLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function RoleWeaponLayer.getInstance()
	return var_0_6
end

function RoleWeaponLayer:init(arg_4_1, arg_4_2, arg_4_3)
	arg_4_1 = arg_4_1 or 1
	arg_4_2 = arg_4_2 or 1
	arg_4_3 = arg_4_3 or 1
	var_0_6 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "RoleWeapon.json" or "RoleWeapon.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:getChildByName("Button_back"):setVisible(false)
	self.rootLayer:getChildByName("Button_back"):addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_5_0:isBright() then
			return
		end

		arg_5_0:setBright(false)
		self:runAction(cc.RemoveSelf:create())
	end)

	self.titleLable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_title")
	self.sureBnt = self.rootLayer:getChildByName("Button_sure")
	self.retainBnt = self.rootLayer:getChildByName("Button_retain")
	self.replaceBnt = self.rootLayer:getChildByName("Button_replace")
	self.attrsPanel = self.rootLayer:getChildByName("Panel_attrs")
	self.AttrLabel = self.attrsPanel:getChildByName("Panel_label")

	self.AttrLabel:retain()
	self.AttrLabel:removeFromParent()

	self.soulid = arg_4_1
	self.placeid = arg_4_3
	self.clotheid = arg_4_2

	weapon_manager:init(arg_4_1, arg_4_2, arg_4_3)
	self:initAttrsPool()
	self:createNeededMaterials()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_6 = nil

			self.AttrLabel:release()
			weapon_manager:m_release()

			if self.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

				self.scheduler = nil
			end

			if SoulsLayer.getInstance() then
				TopcostLayer.getInstance():registeReturnEvent(SoulsLayer)
			end
		end
	end)
end

function RoleWeaponLayer:initAttrsPool()
	local var_7_0 = 9
	local var_7_1 = #weapon_manager.attrsData
	local var_7_2 = self.attrsPanel:getContentSize().height / 2
	local var_7_3 = 46
	local var_7_4 = 2

	if weapon_manager.curRoleWeaponSkill and weapon_manager.curRoleWeaponSkill ~= 0 then
		self.titleLable:setString(total_skill_data[weapon_manager.curRoleWeaponSkill].description)
	else
		self.titleLable:setString("~~~~~")
	end

	if weapon_manager.weaponInfo.coin then
		ccui.Helper:seekWidgetByName(self.sureBnt, "Label_cost"):setString(weapon_manager.weaponInfo.coin)
	else
		ccui.Helper:seekWidgetByName(self.sureBnt, "Image_gold"):setVisible(false)
	end

	local function var_7_5()
		self.attrLabels = {}

		for iter_8_0 = 1, var_7_0 do
			local var_8_0 = self.AttrLabel:clone()

			var_8_0.attrId = iter_8_0

			var_8_0:getChildByName("Label"):setString(weapon_manager.attrsData[iter_8_0] and total_skill_data[weapon_manager.attrsData[iter_8_0]].description or total_skill_data[weapon_manager.attrsData[math.random(var_7_1)]].description)
			var_8_0:getChildByName("bg"):setVisible(false)
			var_8_0:getChildByName("bg"):setOpacity(125)
			var_8_0:setPositionY(((var_7_0 + 1) / 2 - iter_8_0) * var_7_3 + var_7_2)
			var_8_0:setName("attrLabel" .. iter_8_0)
			self.attrsPanel:addChild(var_8_0)

			self.attrLabels[iter_8_0] = var_8_0
		end
	end

	local function var_7_6()
		self.attrsPanel.rollSpeed = 0
		self.attrsPanel.roll_a = -600
		self.attrsPanel.rollTime = 0
		self.attrsPanel.rollResult = nil
		self.attrsPanel.targetId = nil
	end

	local var_7_7 = 0

	function self.attrsPanel:updateRoll(arg_10_1)
		local function var_10_0(arg_12_0)
			for iter_12_0, iter_12_1 in ipairs(self.attrLabels) do
				local var_12_0 = self.rollSpeed * arg_12_0
				local var_12_1 = iter_12_1:getPositionY() + self.rollSpeed * arg_12_0
				local var_12_2

				if iter_12_0 - 1 > 0 then
					var_12_2 = iter_12_0 - 1 or var_7_0
				end

				local var_12_3 = iter_12_0 % var_7_0 + 1

				if var_12_1 >= ((var_7_0 + 1) / 2 - 1) * var_7_3 + var_7_2 and var_12_0 > 0 then
					var_12_1 = self.attrLabels[var_12_2]:getPositionY() - var_7_3
					var_12_1 = var_12_2 < iter_12_0 and var_12_1 or var_12_1 + math.abs(var_12_0)
					iter_12_1.attrId = self.attrLabels[var_12_2].attrId % var_7_1 + 1

					iter_12_1:getChildByName("Label"):setString(total_skill_data[weapon_manager.attrsData[iter_12_1.attrId]].description)
				elseif var_12_1 <= ((var_7_0 + 1) / 2 - 9) * var_7_3 + var_7_2 and var_12_0 < 0 then
					var_12_1 = self.attrLabels[var_12_3]:getPositionY() + var_7_3
					var_12_1 = var_12_3 < iter_12_0 and var_12_1 or var_12_1 - math.abs(var_12_0)

					if self.attrLabels[var_12_3].attrId - 1 > 0 then
						iter_12_1.attrId = self.attrLabels[var_12_3].attrId - 1 or var_7_1
					end

					iter_12_1:getChildByName("Label"):setString(total_skill_data[weapon_manager.attrsData[iter_12_1.attrId]].description)
				end

				iter_12_1:setPositionY(var_12_1)
			end
		end

		if self.rollTime > var_7_4 and self.rollResult then
			(function(arg_11_0)
				local var_11_0 = -10

				if self.targetId then
					var_7_7 = var_7_7 + arg_11_0

					local var_11_1 = 200 * math.exp(-2 * var_7_7) * math.cos(12 * var_7_7)

					var_11_0 = var_7_2 + var_11_1 - self.attrLabels[self.targetId]:getPositionY()

					if math.abs(var_11_1) < 0.01 then
						self:updateUI(1)

						var_7_7 = 0

						if self.scheduler then
							cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

							self.scheduler = nil
						end
					end
				end

				for iter_11_0, iter_11_1 in ipairs(self.attrLabels) do
					local var_11_3 = iter_11_1:getPositionY() + var_11_0
					local var_11_4

					if iter_11_0 - 1 > 0 then
						var_11_4 = iter_11_0 - 1 or var_7_0
					end

					local var_11_5 = iter_11_0 % var_7_0 + 1

					if var_11_3 >= ((var_7_0 + 1) / 2 - 1) * var_7_3 + var_7_2 and var_11_0 > 0 then
						var_11_3 = self.attrLabels[var_11_4]:getPositionY() - var_7_3
						var_11_3 = var_11_4 < iter_11_0 and var_11_3 or var_11_3 + math.abs(var_11_0)
						iter_11_1.attrId = self.attrLabels[var_11_4].attrId % var_7_1 + 1

						iter_11_1:getChildByName("Label"):setString(total_skill_data[weapon_manager.attrsData[iter_11_1.attrId]].description)
					elseif var_11_3 <= ((var_7_0 + 1) / 2 - 9) * var_7_3 + var_7_2 and var_11_0 < 0 then
						var_11_3 = self.attrLabels[var_11_5]:getPositionY() + var_7_3
						var_11_3 = var_11_5 < iter_11_0 and var_11_3 or var_11_3 - math.abs(var_11_0)

						if self.attrLabels[var_11_5].attrId - 1 > 0 then
							iter_11_1.attrId = self.attrLabels[var_11_5].attrId - 1 or var_7_1
						end

						if not self.targetId then
							iter_11_1:getChildByName("Label"):setString(total_skill_data[self.rollResult].description)

							self.targetId = iter_11_0
						else
							iter_11_1:getChildByName("Label"):setString(total_skill_data[weapon_manager.attrsData[iter_11_1.attrId]].description)
						end
					end

					iter_11_1:setPositionY(var_11_3)
				end
			end)(arg_10_1)
		elseif self.rollTime <= 2 then
			self.rollSpeed = self.rollSpeed + self.roll_a * arg_10_1

			var_10_0(arg_10_1)
		else
			self.rollSpeed = self.roll_a * 2

			var_10_0(arg_10_1)
		end

		self.rollTime = self.rollTime + arg_10_1
	end

	self.sureBnt:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		arg_13_0:setBright(false)
		weapon_manager:random_weapon_skill(function(arg_14_0)
			if arg_14_0.result == 1 then
				self.attrsPanel.rollResult = arg_14_0.skillid

				self.sureBnt:setVisible(false)

				self.scheduler = self.scheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_15_0)
					self.attrsPanel:updateRoll(arg_15_0)
				end, 0, false)

				self.materialsPanel:setVisible(false)
				self.rootLayer:getChildByName("Label_needwhat"):setVisible(false)
			end

			arg_13_0:setBright(true)
		end)
	end)
	self.retainBnt:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_0:isBright() then
			return
		end

		arg_16_0:setBright(false)
		self.materialsPanel:setVisible(true)
		self.rootLayer:getChildByName("Label_needwhat"):setVisible(true)
		weapon_manager:choose_weapon_skill(false, function(arg_17_0)
			arg_16_0:setBright(true)
			self:updateUI(2)
			var_7_6()
			print("@@PlayerModel", playermodel.weaponSkills[self.soulid][ATTR_ID[self.clotheid]])
			self.materialsPanel:setVisible(true)
			self.rootLayer:getChildByName("Label_needwhat"):setVisible(true)
		end)
	end)
	self.replaceBnt:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_18_0:isBright() then
			return
		end

		arg_18_0:setBright(false)
		weapon_manager:choose_weapon_skill(true, function(arg_19_0)
			self.titleLable:setString(total_skill_data[self.attrsPanel.rollResult].description)

			if SoulsLayer.getInstance() then
				SoulsLayer.getInstance().weponBnts[self.placeid]:getChildByName("Label_skill"):setString(total_skill_data[self.attrsPanel.rollResult].description)
			end

			self:updateUI(2)
			var_7_6()
			print("@@PlayerModel", playermodel.weaponSkills[self.soulid][ATTR_ID[self.clotheid]])
			arg_18_0:setBright(true)
			self.materialsPanel:setVisible(true)
			self.rootLayer:getChildByName("Label_needwhat"):setVisible(true)
		end)
	end)
	var_7_6()
	var_7_5()
end

function RoleWeaponLayer:createNeededMaterials()
	self.materialsPanel = ccui.Layout:create()

	self:addChild(self.materialsPanel)

	for iter_20_0, iter_20_1 in ipairs(weapon_manager.neededMaterials) do
		local var_20_0 = ccui.ImageView:create(ITEM_BUTTON_DEFAULT_IMAGE, var_0_7)

		var_20_0:setPosition(cc.p(320 + (iter_20_0 - (#weapon_manager.neededMaterials + 1) / 2) * 130, 300))
		var_20_0:setName("materialBnt" .. iter_20_0)
		self.materialsPanel:addChild(var_20_0)

		local var_20_1 = ItemSprite:createWithItemId(iter_20_1.id, iter_20_1.num, true)

		var_20_1:setName("sp")
		var_20_1:setAnchorPoint(cc.p(0, 0))
		var_20_0:addChild(var_20_1)

		if item_manager:isHaveEnoughItem(iter_20_1.id, iter_20_1.num) then
			var_20_1:setOpacity(255)
		else
			var_20_1:setOpacity(100)
		end

		if config._DEBUG then
			var_20_0:setTouchEnabled(true)
			var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
				if arg_21_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_21_0:setTouchEnabled(false)
				network:rpc("get_items", {
					itemtype = iter_20_1.id,
					num = iter_20_1.num
				}, function(arg_22_0)
					if arg_22_0.result == 1 then
						global_riseWord(L_ROLE_WEAPON_SUCCESS)
						print_lua_table(arg_22_0.items)
						item_manager:setItemByServerItem(arg_22_0.items[1])
						arg_21_0:setTouchEnabled(true)
						arg_21_0:getChildByName("sp"):setOpacity(255)
					end
				end)
			end)
		end
	end
end

function RoleWeaponLayer:updateUI(arg_23_1)
	if arg_23_1 == 1 then
		self.sureBnt:setVisible(false)
		self.retainBnt:setVisible(true)
		self.replaceBnt:setVisible(true)
	elseif arg_23_1 == 2 then
		self.sureBnt:setVisible(true)
		self.retainBnt:setVisible(false)
		self.replaceBnt:setVisible(false)
	end
end
