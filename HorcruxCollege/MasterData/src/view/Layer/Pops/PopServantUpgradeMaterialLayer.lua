PopServantUpgradeMaterialLayer = class("PopServantUpgradeMaterialLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local autopop_manager = require("controller.autopop_manager")
local armature_manager = require("controller.armature_manager")
local core_manager = require("controller.core_manager")
local item_manager = require("controller.item_manager")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")

function PopServantUpgradeMaterialLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopServantUpgradeMaterialLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopServantUpgradeMaterialLayer:init(arg_3_1)
	self.msg = arg_3_1
	self.cancelcallback = arg_3_1 and arg_3_1.cancelcallback
	self.surecallback = arg_3_1 and arg_3_1.surecallback
	self.labels = arg_3_1 and arg_3_1.labels

	self:onLoad()
	self:initData(arg_3_1)
	self:initPanel()
	self:fullScreen()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.scheduler ~= nil then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
			end

			if self.extraScheduler ~= nil then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.extraScheduler)
			end

			if self.touchScheduler ~= nil then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.touchScheduler)
			end
		end
	end)
end

function PopServantUpgradeMaterialLayer:onLoad()
	local var_5_0 = ccui.Layout:create()

	var_5_0:setTouchEnabled(true)
	var_5_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_5_0:setAnchorPoint(cc.p(0, 0))
	var_5_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_5_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_5_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_5_0:setOpacity(0)
	self:addChild(var_5_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_6_0)
		self:addChild(arg_6_0, -2)
		arg_6_0:setPositionY(arg_6_0:getPositionY() - GameDisplay.fix_y)
		var_5_0:setOpacity(102)
		var_5_0:setTouchEnabled(false)
	end)

	local function var_5_1()
		if tolua.isnull(self.rootpanel) then
			return
		end

		self.rootpanel:setTouchEnabled(false)
		global_window_close_action(self.rootpanel, function()
			if type(self.cancelcallback) == "function" then
				self.cancelcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopServantUpgradeMaterialLayer.json" or "PopServantUpgradeMaterialLayer.ExportJson")

	self:addChild(self.rootLayer, 2)

	self.backPanelNode = self.rootLayer:getChildByName("panel_back")

	self.backPanelNode:setVisible(false)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_upgrade")

	self.rootpanel:addTouchEventListener(var_5_1)

	self.bgNode = self.rootLayer:getChildByName("material_bg")

	self.bgNode:setTouchEnabled(true)
	self.bgNode:setAnchorPoint(cc.p(0.5, 0.5))
	self.bgNode:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.bgNode:setPositionY(self.rootLayer:getContentSize().height / 2 + 100)

	self.equipNode = self.bgNode:getChildByName("equip_4")

	self.equipNode:setVisible(false)

	self.panelNode = self.bgNode:getChildByName("Panel_28")
	self.btn_sure = self.bgNode:getChildByName("button_sure")
	self.btn_sureLabel = self.btn_sure:getChildByName("Label_21")

	self.btn_sureLabel:setString(L_BUTTON_TEXT.Up_Grade)
	self.btn_sure:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.info.isHaveEnoughCard == true then
			if not arg_9_0:isBright() then
				return
			end

			arg_9_0:setBright(false)

			local function var_9_0()
				self.rootpanel:setVisible(false)

				if self.info.isOcOpen == false then
					self:StartUpgrade(var_5_1, self.info)
				else
					self:StartOCUpgrade(self.msg, var_5_1, self.info)
				end
			end

			if self:isNeedExtraMaterial() then
				LayerManager:pushInLayer("PopDoLayer", {
					surecallback = var_9_0,
					cancelcallback = function()
						arg_9_0:setBright(true)
					end,
					labels = {
						title = L_ACTIVITY_SIGN_REMEDY_DIALOG.Title,
						des = self:getMaterialString()
					}
				})
			else
				var_9_0()
			end
		else
			global_ShowBlockWords(L_CONDITON_NO_ENOUGH)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
	self:createFullScreenMask(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	self.diNode = ccui.Layout:create()

	self.diNode:setContentSize(cc.size(640, 280))
	self.diNode:setPosition(cc.p(GameDisplay.width / 2, 140))

	self.diBgNode = ccui.ImageView:create("PopServantUpgradeLayer/material_bg2.png", var_0_0)

	self.diBgNode:setTouchEnabled(true)
	self.diNode:addChild(self.diBgNode)
	self.diNode:setVisible(false)
	self.rootLayer:addChild(self.diNode)
end

function PopServantUpgradeMaterialLayer:isNeedExtraMaterial()
	local var_14_0 = false

	for iter_14_0, iter_14_1 in pairs(self.info.material) do
		if iter_14_1.isCanEdit == true then
			var_14_0 = true

			break
		end
	end

	return var_14_0
end

function PopServantUpgradeMaterialLayer:initData(arg_15_1)
	self.servant = arg_15_1.curSoul
	self.studentCard = servant_data[self.servant].studentCard
	self.studentCardRate = servant_data[self.servant].studentCardRate
	self.rarityCard = core_manager:getServantRarityCard(self.servant)
	self.rarityCardRate = core_manager:getServantRarityCardRate(self.servant)
	self.eleCard = core_manager:getServantElementCard(self.servant)
	self.eleCardRate = core_manager:getServantElementCardRate(self.servant)
	self.info = {
		needNum = 0,
		isHaveEnoughCard = false,
		ownNum = 0,
		isOcOpen = false,
		backSystemId = 0,
		studentId = 0,
		material = {},
		extraMaterials = {}
	}
	self.info.isOcOpen = arg_15_1.isOcOpen or false
	self.info.studentId = arg_15_1.curSoul

	local var_15_0 = true
	local var_15_1 = arg_15_1.materials[1]
	local var_15_2 = arg_15_1.materials[2]
	local var_15_3 = arg_15_1.materials[1].ownnum
	local var_15_4 = arg_15_1.materials[1].neednum
	local var_15_5 = not not (arg_15_1.materials[2] and var_15_2.neednum <= var_15_2.ownnum)

	if self.info.isOcOpen == true then
		var_15_4 = var_15_4 + 1

		if var_15_4 > var_15_3 + ((var_15_5 or nil) and 1) then
			var_15_0 = false
		end
	elseif var_15_3 < var_15_4 then
		var_15_0 = false
	end

	self.info.isHaveEnoughCard = var_15_0
	self.info.needNum = var_15_4
	self.info.ownNum = var_15_3
	self.info.isHaveEnoughCpu = var_15_5

	local var_15_7 = {}

	for iter_15_0 = 1, var_15_4 do
		if self.info.isOcOpen == false then
			local var_15_8 = false
			local var_15_9 = false

			if iter_15_0 <= var_15_3 then
				var_15_8 = true
			else
				var_15_9 = true

				if self.info.curSelectIndex == nil then
					self.info.curSelectIndex = iter_15_0
				end
			end

			var_15_7[iter_15_0] = {
				needNum = 1,
				isOc = false,
				ownNum = 0,
				isFilled = false,
				index = iter_15_0,
				id = var_15_1.id,
				isCanEdit = var_15_9,
				isOk = var_15_8
			}
		elseif iter_15_0 ~= 1 then
			local var_15_10 = false
			local var_15_11 = false

			if iter_15_0 <= var_15_3 + 1 then
				var_15_10 = true
			else
				var_15_11 = true

				if self.info.curSelectIndex == nil then
					self.info.curSelectIndex = iter_15_0
				end
			end

			var_15_7[iter_15_0] = {
				needNum = 1,
				isOc = false,
				ownNum = 0,
				isFilled = false,
				index = iter_15_0,
				id = var_15_1.id,
				isCanEdit = var_15_11,
				isOk = var_15_10
			}
		else
			var_15_7[iter_15_0] = {
				isOc = true,
				isCanEdit = false,
				isFilled = false,
				index = iter_15_0,
				id = var_15_2.id,
				needNum = var_15_2.neednum,
				ownNum = var_15_2.ownnum,
				isOk = var_15_5
			}
		end
	end

	self.info.material = var_15_7
	self.info.backSystemId = arg_15_1.goto_back_system_id
	self.studentCard = servant_data[self.servant].studentCard
	self.studentCardRate = servant_data[self.servant].studentCardRate or 1
	self.rarityCard = core_manager:getServantRarityCard(self.servant)
	self.rarityCardRate = core_manager:getServantRarityCardRate(self.servant)
	self.eleCard = core_manager:getServantElementCard(self.servant)
	self.eleCardRate = core_manager:getServantElementCardRate(self.servant)

	local var_15_12 = {}

	for iter_15_1 = 1, 3 do
		local var_15_13
		local var_15_14

		if iter_15_1 == 1 then
			var_15_13 = self.studentCard
			var_15_14 = self.studentCardRate
		elseif iter_15_1 == 2 then
			var_15_13 = self.rarityCard
			var_15_14 = self.rarityCardRate
		elseif iter_15_1 == 3 then
			-- block empty
		end

		if var_15_13 ~= nil then
			local var_15_16 = item_manager:getItemNumber(var_15_13)
			local var_15_17 = math.floor(var_15_16 / var_15_14) > 0

			table.insert(var_15_12, {
				index = #var_15_12 + 1,
				id = var_15_13,
				rate = var_15_14,
				totalNum = var_15_16,
				isCanUse = var_15_17
			})
		end
	end

	local var_15_18 = core_manager:getUpgradeCostMaterial(self.servant, playermodel.soulContract[self.servant] + 1)

	if var_15_18 then
		local var_15_19 = core_manager:getUpgradeCostMaterialNum(self.servant, playermodel.soulContract[self.servant] + 1)

		table.insert(var_15_12, {
			rate = 1,
			index = #var_15_12 + 1,
			id = var_15_18,
			totalNum = item_manager:getItemNumber(var_15_18),
			isCanUse = item_manager:getItemNumber(var_15_18) >= 1
		})
	end

	self.info.extraMaterials = var_15_12
end

function PopServantUpgradeMaterialLayer:getMaterialInfo()
	print(dump(self.info.material))

	return self.info.material
end

function PopServantUpgradeMaterialLayer:getExtraMaterialInfo()
	return self.info.extraMaterials
end

function PopServantUpgradeMaterialLayer:isCanClickBtnSure()
	local var_18_0 = true

	for iter_18_0, iter_18_1 in pairs(self.info.material) do
		if iter_18_1.isOk == false then
			var_18_0 = false

			break
		end
	end

	return var_18_0
end

function PopServantUpgradeMaterialLayer:initExtraMaterialViewList()
	if self.info.material[self.info.curSelectIndex].isCanEdit == false then
		self.diNode:setVisible(false)

		return
	else
		self.diNode:setVisible(true)
	end

	local var_19_0 = self:getExtraMaterialInfo()

	if var_19_0 == nil then
		return
	end

	local var_19_1 = cc.size(174, 228)

	if self.extraMaterialPanelNode ~= nil then
		self.extraMaterialPanelNode:removeFromParent()

		self.extraMaterialPanelNode = nil
	end

	self.extraMaterialPanelNode = self:getTableView(var_19_0, #var_19_0, var_19_1, cc.size(640, 228), function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_20_2[arg_20_1 + 1]
		local var_20_1 = arg_20_0:dequeueCell()

		if var_20_1 == nil then
			var_20_1 = cc.TableViewCell:new()
		end

		local var_20_2 = var_20_1:getChildByName("item")

		if not var_20_2 then
			var_20_2 = ItemSprite:createNewWithItemId(var_20_0.id, var_20_0.totalNum)

			var_20_1:addChild(var_20_2)
			var_20_2:setName("item")
			var_20_2:setPosition(cc.p(87, 114))
			var_20_2:setScale(0.8)
		else
			var_20_2:getChildByName("number"):setString("X" .. var_20_0.totalNum)
		end

		local var_20_3 = var_20_2:getChildByName("mask")

		if var_20_3 == nil then
			var_20_3 = ccui.ImageView:create("PopServantUpgradeLayer/item_mask.png", var_0_0)

			var_20_3:setName("mask")
			var_20_3:setPosition(cc.p(var_20_2:getContentSize().width / 2, var_20_2:getContentSize().height / 2 + 3))
			var_20_3:setScale(1.25)
			var_20_2:addChild(var_20_3)
		end

		var_20_2.index = arg_20_1 + 1

		local var_20_4 = ccui.Button:create("public/box/UI_touming.png", "public/box/UI_touming.png", "public/box/UI_touming.png", var_0_0)

		var_20_4:setScale9Enabled(true)
		var_20_4:setContentSize(cc.size(174, 228))
		var_20_4:setPosition(cc.p(var_20_2:getContentSize().width / 2, var_20_2:getContentSize().height / 2 + 3))
		var_20_4:setSwallowTouches(false)
		var_20_2:addChild(var_20_4)
		var_20_4:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 == ccui.TouchEventType.began then
				arg_21_0.timeValue = 0

				if self.touchScheduler ~= nil then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.touchScheduler)
				end

				self.touchScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
					if arg_21_0.timeValue >= 1 then
						LayerManager:pushInLayer("PopItemLayer", {
							itemid = var_20_0.id,
							goto_back_system_id = self.info.backSystemId,
							layer = cc.Layer:create()
						})

						arg_21_0.timeValue = 0

						cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.touchScheduler)
					end

					arg_21_0.timeValue = arg_21_0.timeValue + 0.2
				end, 0.1, false)
			elseif arg_21_1 == ccui.TouchEventType.ended then
				arg_21_0.timeValue = 0

				if self.touchScheduler ~= nil then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.touchScheduler)
				end
			elseif arg_21_1 == ccui.TouchEventType.canceled then
				arg_21_0.timeValue = 0

				if self.touchScheduler ~= nil then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.touchScheduler)
				end
			end
		end)

		if var_20_0.isCanUse == false then
			var_20_3:setVisible(true)
			var_20_4:setVisible(false)
		else
			var_20_3:setVisible(false)
			var_20_4:setVisible(true)
		end

		return var_20_1
	end, function(arg_23_0, arg_23_1)
		print("click ")

		local var_23_0 = arg_23_1:getChildByName("item").index

		if var_19_0[var_23_0].isCanUse == true then
			self:useExtraMaterial(var_23_0)
		else
			local var_23_1 = {
				itemid = var_19_0[var_23_0].id,
				goto_back_system_id = self.info.backSystemId
			}

			var_23_1.layer = cc.Layer:create()

			LayerManager:pushInLayer("PopItemLayer", var_23_1)
		end
	end)

	self.extraMaterialPanelNode:setPosition(cc.p(math.max(0, GameDisplay.width / 2 - self.extraMaterialPanelNode:getContentSize().width / 2), 0))
	self.diBgNode:addChild(self.extraMaterialPanelNode)
	self.btn_sure:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_0)
end

function PopServantUpgradeMaterialLayer:useExtraMaterial(arg_24_1)
	local var_24_0 = self.info.curSelectIndex
	local var_24_1 = self.info.material[self.info.curSelectIndex]
	local var_24_2 = self.info.extraMaterials[arg_24_1]
	local var_24_3 = false

	if self.info.material[self.info.curSelectIndex].id ~= self.info.extraMaterials[arg_24_1].id then
		var_24_2.totalNum = var_24_2.totalNum - var_24_2.rate

		for iter_24_0, iter_24_1 in pairs(self.info.extraMaterials) do
			print(iter_24_1.id, var_24_1.id)

			if iter_24_1.id == var_24_1.id then
				iter_24_1.totalNum = iter_24_1.totalNum + iter_24_1.rate
				iter_24_1.isCanUse = math.floor(iter_24_1.totalNum / iter_24_1.rate) > 0

				local var_24_4 = self.extraMaterialPanelNode:cellAtIndex(iter_24_0 - 1)

				if var_24_4 then
					local var_24_5 = var_24_4:getChildByName("item")

					var_24_5:getChildByName("number"):setString("X" .. iter_24_1.totalNum)
					var_24_5:getChildByName("mask"):setVisible(iter_24_1.isCanUse == false)
				end

				var_24_3 = true

				break
			end
		end
	else
		return
	end

	var_24_2.isCanUse = math.floor(var_24_2.totalNum / var_24_2.rate) > 0

	local var_24_6 = self.extraMaterialPanelNode:cellAtIndex(arg_24_1 - 1)

	if var_24_6 then
		local var_24_7 = var_24_6:getChildByName("item")

		var_24_7:getChildByName("number"):setString("X" .. var_24_2.totalNum)
		var_24_7:getChildByName("mask"):setVisible(var_24_2.isCanUse == false)
	end

	var_24_1.isFilled = true
	var_24_1.id = var_24_2.id
	var_24_1.needNum = var_24_2.rate
	var_24_1.isOk = true

	local var_24_8 = self.materialPanelNode:cellAtIndex(var_24_0 - 1)

	if var_24_8 then
		local var_24_9 = var_24_8:getChildByName("item")

		if var_24_9 then
			var_24_9:removeFromParent()

			var_24_9 = nil
			var_24_9 = var_24_1.entityid and var_24_1.entityid > 0 and ItemSprite:createBigWithEntityId(var_24_1.entityid) or var_24_1.isOk == true and ItemSprite:createNewWithItemId(var_24_1.id, var_24_1.needNum) or ItemSprite:createNewWithItemId(var_24_1.id, var_24_1.ownNum, nil, nil, nil, nil, var_24_1.needNum)

			var_24_8:addChild(var_24_9)
			var_24_9:setName("item")
			var_24_9:setPosition(cc.p(87, 114))
			var_24_9:setScale(0.8)
		end

		local var_24_10 = var_24_9:getChildByName("layout"):getChildByName("icon")
		local var_24_11 = var_24_9:getChildByName("number")
		local var_24_12 = var_24_9:getChildByName("mask")

		if var_24_12 == nil then
			var_24_12 = ccui.ImageView:create("PopServantUpgradeLayer/item_mask.png", var_0_0)

			var_24_12:setName("mask")
			var_24_12:setPosition(cc.p(var_24_9:getContentSize().width / 2, var_24_9:getContentSize().height / 2 + 3))
			var_24_12:setScale(1.25)
			var_24_9:addChild(var_24_12)

			local var_24_13 = ccui.ImageView:create("PopServantUpgradeLayer/add.png", var_0_0)

			var_24_13:setPosition(cc.p(70, 92))
			var_24_13:setScale(1.25)
			var_24_12:addChild(var_24_13)

			local var_24_14 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_24_14:setPosition(cc.p(140, 180))
			var_24_14:setScale(1.25)
			var_24_14:setName("redDot")
			var_24_14:setVisible(self:isShowRedDot() == true)
			var_24_12:addChild(var_24_14)
		end

		if var_24_9:getChildByName("select") == nil then
			local var_24_15 = ccui.ImageView:create("PopServantUpgradeLayer/item_select.png", var_0_0)

			var_24_15:setName("select")
			var_24_15:setScale(1.25)
			var_24_15:setVisible(false)
			var_24_15:setPosition(cc.p(var_24_9:getContentSize().width / 2, var_24_9:getContentSize().height / 2 + 3))
			var_24_9:addChild(var_24_15)
		end

		if var_24_1.isOk == true then
			var_24_11:setColor(cc.c3b(255, 255, 255))
			var_24_12:setVisible(false)
		else
			var_24_11:setColor(cc.c3b(255, 0, 0))
			var_24_12:setVisible(true)
		end

		var_24_9.index = var_24_0
	end

	if var_24_3 == false then
		self.info.ownNum = self.info.ownNum + 1
	end

	local var_24_16 = true

	if self.info.isOcOpen == true and self.info.needNum > self.info.ownNum + ((self.info.isHaveEnoughCpu == true or nil) and 1) then
		var_24_16 = false
	elseif self.info.isOcOpen == false and self.info.needNum > self.info.ownNum then
		var_24_16 = false
	end

	self.info.isHaveEnoughCard = var_24_16

	if var_24_16 == true then
		self.btn_sure:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", var_0_0)
		self.diNode:setVisible(false)
	else
		self.btn_sure:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_0)
		self.diNode:setVisible(true)

		for iter_24_2, iter_24_3 in pairs(self.info.material) do
			if iter_24_3.isOk == false and iter_24_3.isOc == false then
				self.info.curSelectIndex = iter_24_2

				break
			end
		end

		for iter_24_4 = 1, #self.info.material do
			local var_24_18 = self.materialPanelNode:cellAtIndex(iter_24_4 - 1)

			if var_24_18 then
				local var_24_19 = var_24_18:getChildByName("item"):getChildByName("select")

				if iter_24_4 ~= self.info.curSelectIndex then
					var_24_19:setVisible(false)
				else
					var_24_19:setVisible(true)
				end
			end
		end

		self:updateAllItemRedDotStatus()

		if self.info.curSelectIndex > 4 then
			self.materialPanelNode:scrollToPercent(math.floor(100 * self.info.curSelectIndex / #self.info.material), nil, false)
		end
	end
end

function PopServantUpgradeMaterialLayer:selectIndexForMaterial(arg_25_1, arg_25_2)
	if arg_25_1 == nil or arg_25_2 == nil or self.info.material[arg_25_2] == nil then
		return
	end

	local var_25_0 = self.info.material[arg_25_2]

	self.info.curSelectIndex = arg_25_2

	if var_25_0.isFilled == true then
		for iter_25_0, iter_25_1 in pairs(self.info.extraMaterials) do
			if var_25_0.id == iter_25_1.id then
				var_25_0.isOk = false
				var_25_0.id = self.msg.materials[1].id
				var_25_0.isFilled = false
				iter_25_1.totalNum = iter_25_1.totalNum + iter_25_1.rate
				iter_25_1.isCanUse = math.floor(iter_25_1.totalNum / iter_25_1.rate) > 0
				self.info.ownNum = self.info.ownNum - 1
				self.info.isHaveEnoughCard = false

				break
			end
		end
	end

	for iter_25_2 = 1, #self.info.material do
		local var_25_1 = arg_25_1:cellAtIndex(iter_25_2 - 1)

		if var_25_1 then
			if iter_25_2 ~= arg_25_2 then
				var_25_1:getChildByName("item"):getChildByName("select"):setVisible(false)
			else
				self:initMaterialItem(var_25_1, arg_25_2 - 1)
				var_25_1:getChildByName("item"):getChildByName("select"):setVisible(true)
			end
		end
	end

	self:updateAllItemRedDotStatus()
	self.diNode:setVisible(false)

	if self.extraScheduler ~= nil then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.extraScheduler)
	end

	self.extraScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.extraScheduler)
		self:initExtraMaterialViewList()
	end, 0.2, false)
end

function PopServantUpgradeMaterialLayer.selectIndexForExtraMaterial(arg_27_0)
	return
end

function PopServantUpgradeMaterialLayer:isShowRedDot()
	local var_28_0 = false

	for iter_28_0, iter_28_1 in pairs(self.info.extraMaterials) do
		if iter_28_1.isCanUse == true then
			var_28_0 = true

			break
		end
	end

	return var_28_0
end

function PopServantUpgradeMaterialLayer:updateAllItemRedDotStatus()
	for iter_29_0 = 1, #self.info.material do
		local var_29_0 = self.materialPanelNode:cellAtIndex(iter_29_0 - 1)

		if var_29_0 then
			var_29_0:getChildByName("item"):getChildByName("mask"):getChildByName("redDot"):setVisible(self:isShowRedDot() == true)
		end
	end
end

function PopServantUpgradeMaterialLayer:initMaterialItem(arg_30_1, arg_30_2)
	if arg_30_1 == nil or arg_30_2 + 1 == nil or self.info.material[arg_30_2 + 1] == nil then
		return
	end

	local var_30_0 = self.info.material[arg_30_2 + 1]
	local var_30_1 = arg_30_1:getChildByName("item")

	if var_30_1 then
		var_30_1:removeFromParent()

		var_30_1 = nil
	end

	var_30_1 = var_30_0.entityid and var_30_0.entityid > 0 and ItemSprite:createBigWithEntityId(var_30_0.entityid) or var_30_0.isOk == true and var_30_0.isOc == false and ItemSprite:createNewWithItemId(var_30_0.id, var_30_0.needNum) or ItemSprite:createNewWithItemId(var_30_0.id, var_30_0.ownNum, nil, nil, nil, nil, var_30_0.needNum)

	arg_30_1:addChild(var_30_1)
	var_30_1:setName("item")
	var_30_1:setPosition(cc.p(87, 114))
	var_30_1:setScale(0.8)

	local var_30_2 = var_30_1:getChildByName("layout"):getChildByName("icon")
	local var_30_3 = var_30_1:getChildByName("number")
	local var_30_4 = var_30_1:getChildByName("mask")

	if var_30_4 == nil then
		var_30_4 = ccui.ImageView:create("PopServantUpgradeLayer/item_mask.png", var_0_0)

		var_30_4:setName("mask")
		var_30_4:setPosition(cc.p(var_30_1:getContentSize().width / 2, var_30_1:getContentSize().height / 2 + 3))
		var_30_4:setScale(1.25)
		var_30_1:addChild(var_30_4)

		local var_30_5 = ccui.ImageView:create("PopServantUpgradeLayer/add.png", var_0_0)

		var_30_5:setPosition(cc.p(70, 92))
		var_30_5:setScale(1.25)
		var_30_4:addChild(var_30_5)

		local var_30_6 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

		var_30_6:setPosition(cc.p(140, 180))
		var_30_6:setScale(1.25)
		var_30_6:setName("redDot")
		var_30_6:setVisible(self:isShowRedDot() == true)
		var_30_4:addChild(var_30_6)
	end

	if var_30_1:getChildByName("select") == nil then
		local var_30_7 = ccui.ImageView:create("PopServantUpgradeLayer/item_select.png", var_0_0)

		var_30_7:setName("select")
		var_30_7:setScale(1.25)
		var_30_7:setVisible(false)
		var_30_7:setPosition(cc.p(var_30_1:getContentSize().width / 2, var_30_1:getContentSize().height / 2 + 3))
		var_30_1:addChild(var_30_7)
	end

	if var_30_1:getChildByName("get") == nil then
		local var_30_8 = ccui.Button:create("PopServantUpgradeLayer/item_get.png", "PopServantUpgradeLayer/item_get.png", "PopServantUpgradeLayer/item_get.png", var_0_0)

		var_30_8:setName("get")
		var_30_8:setPosition(cc.p(var_30_1:getContentSize().width / 2, var_30_1:getContentSize().height + 22))
		var_30_1:addChild(var_30_8)
		var_30_8:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopGoGainLayer", {
				item = var_30_0.id,
				goto_back_system_id = self.info.backSystemId
			})
		end)
	end

	if var_30_0.isOk == true and var_30_0.isOc == false then
		var_30_3:setColor(cc.c3b(255, 255, 255))
		var_30_4:setVisible(false)
	elseif var_30_0.isOk == false and var_30_0.isOc == false then
		var_30_3:setColor(cc.c3b(255, 0, 0))
		var_30_4:setVisible(true)
	elseif var_30_0.isOk == true and var_30_0.isOc == true then
		var_30_3:setColor(cc.c3b(255, 255, 255))
		var_30_4:setVisible(false)
	elseif var_30_0.isOk == false and var_30_0.isOc == true then
		var_30_3:setColor(cc.c3b(255, 0, 0))
		var_30_4:setVisible(false)
	end

	var_30_1.index = arg_30_2 + 1
end

function PopServantUpgradeMaterialLayer:initPanel()
	local var_32_0 = self:getMaterialInfo()

	if var_32_0 == nil then
		return
	end

	local var_32_1 = cc.size(174, 260)

	local function var_32_2(arg_34_0, arg_34_1)
		print("click ")

		local var_34_0 = arg_34_1:getChildByName("item").index

		if var_32_0[var_34_0].isCanEdit == false then
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_32_0[var_34_0].id,
				entityid = var_32_0[var_34_0].entityid,
				goto_back_system_id = self.info.backSystemId,
				layer = cc.Layer:create(),
				removeParentCallback = function()
					cb_ExitNotice()
				end
			})
		else
			self:selectIndexForMaterial(arg_34_0, var_34_0)
		end
	end

	if self.materialPanelNode ~= nil then
		self.materialPanelNode:removeFromParent()

		self.materialPanelNode = nil
	end

	self.materialPanelNode = self:getTableView(var_32_0, #var_32_0, var_32_1, cc.size(640, 260), function(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = arg_33_0:cellAtIndex(arg_33_1 + 1 - 1)

		if var_33_0 == nil then
			var_33_0 = arg_33_0:dequeueCell()
		end

		if var_33_0 == nil then
			var_33_0 = cc.TableViewCell:new()
		end

		self:initMaterialItem(var_33_0, arg_33_1)

		return var_33_0
	end, var_32_2)

	self.materialPanelNode:setPosition(math.max(0, GameDisplay.width / 2 - self.materialPanelNode:getContentSize().width / 2), 30)
	self.bgNode:addChild(self.materialPanelNode)
	self.btn_sure:loadTextures("", "", self:isCanClickBtnSure() == true and "public/button/public_button_orange_long.png" or "public/button/public_button_gray_long.png", var_0_0)

	if self.info.isOcOpen == false then
		self.bgNode:loadTexture("PopServantUpgradeLayer/material_bg.png", var_0_0)
		self.diBgNode:loadTexture("PopServantUpgradeLayer/material_bg2.png", var_0_0)
		self.btn_sureLabel:setString(L_BUTTON_TEXT.Up_Grade)
	else
		self.bgNode:loadTexture("PopServantUpgradeLayer/oc_bg.png", var_0_0)
		self.diBgNode:loadTexture("PopServantUpgradeLayer/oc_bg2.png", var_0_0)
		self.btn_sureLabel:setString(self.msg.bntstr)
	end

	if self.scheduler ~= nil then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
	end

	self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

		if self.info.curSelectIndex ~= nil then
			var_32_2(self.materialPanelNode, (self.materialPanelNode:cellAtIndex(self.info.curSelectIndex - 1)))
		end
	end, 0, false)
end

function PopServantUpgradeMaterialLayer.getTableView(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5, arg_37_6)
	local var_37_0 = arg_37_3.width
	local var_37_1 = arg_37_3.height
	local var_37_2 = cc.TableView:create(arg_37_4)

	var_37_2:setVisible(true)
	var_37_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_37_2:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	var_37_2:setDelegate()
	var_37_2:registerScriptHandler(function(arg_38_0)
		return arg_37_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_37_2:registerScriptHandler(function(arg_39_0)
		arg_37_0:scrollViewDidScroll(arg_39_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_37_2:registerScriptHandler(function(arg_40_0, arg_40_1)
		arg_37_6(arg_40_0, arg_40_1)
	end, cc.TABLECELL_TOUCHED)
	var_37_2:registerScriptHandler(function(arg_41_0, arg_41_1)
		return var_37_0, var_37_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_37_2:registerScriptHandler(function(arg_42_0, arg_42_1)
		return arg_37_5(arg_42_0, arg_42_1, arg_37_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_37_2:reloadData()
	var_37_2:setAnchorPoint(cc.p(0, 0))

	return var_37_2
end

function PopServantUpgradeMaterialLayer.scrollViewDidScroll(arg_43_0, arg_43_1)
	print("scrollViewDidScroll")
end

function PopServantUpgradeMaterialLayer:StartUpgrade(arg_44_1, arg_44_2)
	local var_44_0 = playermodel.soulContract[self.info.studentId]

	autopop_manager:pauseAchievementPop()
	playermodel:servantBreakOut(self.info.studentId, self:getMaterialList(arg_44_2), function(arg_45_0, arg_45_1)
		if arg_45_0 == 1 then
			AnalyticManager.servant_break_out({
				servant = self.info.studentId,
				old_contract = var_44_0,
				new_contract = var_44_0 + 1
			})
			arg_44_1()

			if self.surecallback then
				self.surecallback({
					msg = {
						{
							L_SOULS_BREAK_LIMIT.Science,
							L_SOULS_BREAK_LIMIT.Aptitude[1],
							L_SOULS_BREAK_LIMIT.Aptitude[2],
							L_SOULS_BREAK_LIMIT.Point
						},
						{
							self.labels[3].newvalue,
							self.labels[2].newvalue,
							self.labels[1].newvalue,
							self.labels[4].newvalue
						},
						{
							{
								g = 243,
								b = 225,
								r = 220
							},
							{
								g = 243,
								b = 225,
								r = 220
							},
							{
								g = 243,
								b = 225,
								r = 220
							},
							[3] = {
								g = 243,
								b = 225,
								r = 220
							}
						}
					},
					breakTbl = {
						text = L_SOULS_BREAK_LIMIT.Now_Level,
						oldBreakNum = var_44_0,
						curBreakNum = var_44_0 + 1
					}
				})
			end
		elseif arg_45_0 == 2 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_SOULS_BREAK_LIMIT.Warning[2])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_45_0 == 3 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_SOULS_BREAK_LIMIT.Warning[3])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_45_0 == 4 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_SOULS_BREAK_LIMIT.Warning[4])
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function PopServantUpgradeMaterialLayer:StartOCUpgrade(arg_46_1, arg_46_2, arg_46_3)
	autopop_manager:pauseAchievementPop()
	playermodel:servantOverclock(self.info.studentId, self:getMaterialList(arg_46_3), function(arg_47_0, arg_47_1)
		if arg_47_0 == 1 then
			if self.surecallback then
				self.surecallback()
			end

			self:showOCUpGradeAni(arg_46_1, arg_46_2, (arg_47_1 and next(arg_47_1) or nil) and arg_47_1, {
				{
					L_SOULS_BREAK_LIMIT.Aptitude[1],
					L_SOULS_BREAK_LIMIT.Aptitude[2]
				},
				{
					self.labels[2].newvalue,
					self.labels[1].newvalue
				},
				{
					{
						g = 255,
						b = 255,
						r = 255
					},
					{
						g = 107,
						b = 225,
						r = 236
					}
				}
			})
		elseif arg_47_0 == 2 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_OC_LIMIT[2])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_47_0 == 3 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_OC_LIMIT[3])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_47_0 == 4 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_OC_LIMIT[4])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_47_0 == 5 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_OC_LIMIT[5])
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function PopServantUpgradeMaterialLayer.showOCUpGradeAni(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	audio_manager:playeffectMusicTest("sound/upgrade_rank")

	local var_48_0 = ccui.Layout:create()

	var_48_0:setTouchEnabled(true)
	var_48_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_48_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_48_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_48_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_48_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_48_0:setBackGroundColorOpacity(0)
	global_basic_scene:addChild(var_48_0, 999)

	local var_48_1 = L2Skeleton:create("spine/ui/chaopin.json", "spine/ui/chaopin.atlas")

	var_48_1:refreshSkeleton()
	var_48_1:setPosition(cc.p(320, 500))
	var_48_1:setVisible(true)
	var_48_1:play("animation", false)
	var_48_1:registerListener(SP_ANIMATION_COMPLETE, function(arg_49_0)
		var_48_1:runAction(cc.RemoveSelf:create())
	end)
	var_48_0:addChild(var_48_1)

	local var_48_2 = false

	var_48_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		var_48_2 = true
	end), cc.CallFunc:create(function()
		local var_50_0 = {}
		local var_50_1 = {}
		local var_50_2 = {}

		while #arg_48_4[1] > 0 do
			var_50_0[#var_50_0 + 1] = arg_48_4[1][#arg_48_4[1]]
			var_50_2[#var_50_2 + 1] = arg_48_4[2][#arg_48_4[1]]
			var_50_1[#var_50_1 + 1] = arg_48_4[3][#arg_48_4[1]]
		end

		local var_50_4 = 0
		local var_50_5 = ccui.ImageView:create("PopServantUpgradeLayer/oc_success_bg.png", var_0_0)

		var_50_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_50_5:setPositionX(320)
		var_50_5:setPositionY(660)
		var_50_5:setOpacity(0)
		var_50_5:runAction(cc.Sequence:create(cc.DelayTime:create(var_50_4 * 0.2), cc.FadeIn:create(0.3)))
		var_48_0:addChild(var_50_5, 2)

		local var_50_6 = ccui.ImageView:create("PopServantUpgradeLayer/oc_upgrade1.png", var_0_0)

		var_50_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_50_6:setPositionX(320)
		var_50_6:setPositionY(250)
		var_50_6:setOpacity(0)
		var_50_6:runAction(cc.Sequence:create(cc.DelayTime:create((var_50_4 + 1) * 0.2), cc.FadeIn:create(0.3)))
		var_50_5:addChild(var_50_6, 2)

		local var_50_7 = 250 - var_50_6:getContentSize().height / 2 - 30
		local var_50_8 = 80

		for iter_50_0, iter_50_1 in pairs(var_50_0) do
			local var_50_9 = ccui.Text:create(iter_50_1 .. ":", FONT_DES, 18)

			var_50_9:setAnchorPoint(cc.p(0, 0.5))
			var_50_9:setColor(var_50_1[2])
			var_50_9:setPositionX(var_50_8)
			var_50_9:setPositionY(var_50_7)
			var_50_9:setOpacity(0)
			var_50_9:runAction(cc.Sequence:create(cc.DelayTime:create((var_50_4 + 1 + 1) * 0.2), cc.Spawn:create(cc.FadeIn:create(0.3))))
			var_50_5:addChild(var_50_9, 2)

			var_50_8 = var_50_8 + var_50_9:getContentSize().width + 5

			local var_50_10 = ccui.Text:create(var_50_2[iter_50_0][1], FONT_DES, 18)

			var_50_10:setAnchorPoint(cc.p(0, 0.5))
			var_50_10:setColor(var_50_1[2])
			var_50_10:setPositionX(var_50_8)
			var_50_10:setPositionY(var_50_7)
			var_50_10:setOpacity(0)
			var_50_10:runAction(cc.Sequence:create(cc.DelayTime:create((var_50_4 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
			var_50_5:addChild(var_50_10, 2)

			var_50_8 = var_50_8 + var_50_10:getContentSize().width + 5

			local var_50_11 = ccui.ImageView:create("public/panelbg/strengen_arrow2.png", var_0_0)

			var_50_11:setAnchorPoint(cc.p(0, 0.5))
			var_50_11:setPositionX(var_50_8)
			var_50_11:setPositionY(var_50_7)
			var_50_11:setOpacity(0)
			var_50_11:runAction(cc.Sequence:create(cc.DelayTime:create((var_50_4 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
			var_50_5:addChild(var_50_11, 2)

			var_50_8 = var_50_8 + var_50_11:getContentSize().width + 5

			local var_50_12 = ccui.Text:create(var_50_2[iter_50_0][2], FONT_DES, 18)

			var_50_12:setAnchorPoint(cc.p(0, 0.5))
			var_50_12:setColor(var_50_1[1])
			var_50_12:setPositionX(var_50_8)
			var_50_12:setPositionY(var_50_7)
			var_50_12:setOpacity(0)
			var_50_12:runAction(cc.Sequence:create(cc.DelayTime:create((var_50_4 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
			var_50_5:addChild(var_50_12, 2)

			var_50_8 = var_50_8 + var_50_12:getContentSize().width + 50
		end

		local var_50_13 = ccui.ImageView:create("PopServantUpgradeLayer/skill_bg.png", var_0_0)

		var_50_13:setAnchorPoint(cc.p(0.5, 0.5))
		var_50_13:setScale(2)
		var_50_13:setPositionX(320)
		var_50_13:setPositionY(var_50_7 - 25 - 65)
		var_50_13:setOpacity(0)
		var_50_13:runAction(cc.Sequence:create(cc.DelayTime:create((var_50_4 + 1 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
		var_50_5:addChild(var_50_13, 2)

		arg_48_1.skillpath = arg_48_1.skillpath or "skill_new/skill/" .. total_skill_data[model_data[servant_data[arg_48_1.curSoul].modelid].over_clocking_skill].icon .. ".png"

		local var_50_14 = ccui.ImageView:create(arg_48_1.skillpath, var_0_0)

		var_50_14:setAnchorPoint(cc.p(0.5, 0.5))
		var_50_14:setPositionX(320)
		var_50_14:setPositionY(var_50_7 - 25 - 65)
		var_50_14:setOpacity(0)
		var_50_14:runAction(cc.Sequence:create(cc.DelayTime:create((var_50_4 + 1 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
		var_50_5:addChild(var_50_14, 1)

		arg_48_1.skillName = arg_48_1.skillName or total_skill_data[model_data[servant_data[arg_48_1.curSoul].modelid].over_clocking_skill].name

		local var_50_15 = ccui.Text:create(L_GET_NEW_SKILL .. arg_48_1.skillName, FONT_DES, 24)

		var_50_15:setAnchorPoint(cc.p(0.5, 0.5))
		var_50_15:setPositionX(320)
		var_50_15:setPositionY(var_50_7 - 25 - 65 - var_50_14:getContentSize().height / 2 - 30)
		var_50_15:setOpacity(0)
		var_50_15:runAction(cc.Sequence:create(cc.DelayTime:create((var_50_4 + 1 + 1 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
		var_50_5:addChild(var_50_15, 2)
	end), cc.DelayTime:create(10), cc.CallFunc:create(function()
		if arg_48_3 and next(arg_48_3) then
			global_gain({
				items = arg_48_3
			})

			for iter_52_0, iter_52_1 in pairs(arg_48_3) do
				if item_data[iter_52_1.itemid].bag_item_type == kITEM_HERO or item_data[iter_52_1.itemid].bag_item_type == kITEM_SKIN then
					require("view.Layer.GetRoleAnimationLayer")

					local var_52_0 = GetRoleAnimationLayer:create(iter_52_1.itemid, autopop_manager:resumeAchievementPop())

					if not var_52_0:getParent() then
						global_basic_scene:addChild(var_52_0, 99)
					end
				end
			end
		end

		arg_48_2()
	end), cc.RemoveSelf:create()))
	var_48_0:addTouchEventListener(function(arg_53_0, arg_53_1)
		if arg_53_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_48_2 then
			return
		end

		if arg_48_3 and next(arg_48_3) then
			global_gain({
				items = arg_48_3
			})

			for iter_53_0, iter_53_1 in pairs(arg_48_3) do
				if item_data[iter_53_1.itemid].bag_item_type == kITEM_HERO or item_data[iter_53_1.itemid].bag_item_type == kITEM_SKIN then
					require("view.Layer.GetRoleAnimationLayer")

					local var_53_0 = GetRoleAnimationLayer:create(iter_53_1.itemid, autopop_manager:resumeAchievementPop())

					if not var_53_0:getParent() then
						global_basic_scene:addChild(var_53_0, 99)
					end
				end
			end
		end

		arg_48_2()
		var_48_0:runAction(cc.RemoveSelf:create())
	end)
end

function PopServantUpgradeMaterialLayer.ActionofAccess(arg_54_0, arg_54_1)
	arg_54_1:setOpacity(0)
	arg_54_1:setScale(1, 0.001)
	arg_54_1:runAction((cc.Sequence:create(cc.Blink:create(0.15, 1), cc.Spawn:create(cc.FadeIn:create(0.1), cc.ScaleTo:create(0.1, 1, 1)))))
end

function PopServantUpgradeMaterialLayer:getMaterialString()
	local var_55_0 = "确定额外消耗"
	local var_55_1 = {}

	for iter_55_0, iter_55_1 in ipairs(self.info.material) do
		if iter_55_1.isCanEdit == true then
			var_55_1[iter_55_1.id] = var_55_1[iter_55_1.id] == nil and 1 or var_55_1[iter_55_1.id] + 1
		end
	end

	for iter_55_2, iter_55_3 in pairs(var_55_1) do
		if 0 >= 1 then
			var_55_0 = var_55_0 .. "，"
		end

		var_55_0 = var_55_0 .. string.format("%d个%s", iter_55_3, item_data[iter_55_2].name)
	end

	return var_55_0
end

function PopServantUpgradeMaterialLayer.getMaterialList(arg_56_0, arg_56_1)
	local var_56_2 = {}

	for iter_56_0, iter_56_1 in pairs(arg_56_1.material) do
		if not iter_56_1.isCanEdit then
			if item_data[iter_56_1.id].bag_item_type == kITEM_HERO then
				var_56_2[iter_56_1.id] = (var_56_2[iter_56_1.id] or 0) + (iter_56_1.needNum or 1)
			end
		elseif iter_56_1.isFilled then
			var_56_2[iter_56_1.id] = (var_56_2[iter_56_1.id] or 0) + (iter_56_1.needNum or 1)
		end
	end

	local var_56_5 = {}

	for iter_56_2, iter_56_3 in pairs(var_56_2) do
		table.insert(var_56_5, {
			itemid = iter_56_2,
			itemcount = iter_56_3
		})
	end

	return var_56_5
end

function PopServantUpgradeMaterialLayer:fullScreen()
	self.rootLayer:setContentSize((GameDisplay.getScreenSize()))
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y)
end
