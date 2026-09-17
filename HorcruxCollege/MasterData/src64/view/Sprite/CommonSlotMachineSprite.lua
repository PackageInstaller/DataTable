CommonSlotMachineSprite = class("CommonSlotMachineSprite", function()
	return ccui.Layout:create()
end)

local item_data = require("data.item_data")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = 4

function CommonSlotMachineSprite.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = CommonSlotMachineSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function CommonSlotMachineSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.rootLayer = arg_3_4

	self:initDrawParam(arg_3_1, arg_3_2, arg_3_3)
	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.schdule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schdule)

				self.schdule = nil
			end

			activity_manager:updateActivityAlert("roulette", arg_3_3, false)
			activity_manager:releaseEventListenerByName("SlotMachineSprite_" .. arg_3_3)
		end
	end)
end

function CommonSlotMachineSprite:registerActivityEventListener()
	activity_manager:registerEventListener("SlotMachineSprite_" .. self._activityId, activity_manager.activityEventId.ROULETTE_INFO_UPDATE, function(arg_6_0)
		self.dataList = activity_manager:getCommonRouletteItemData(self._activityId)

		self:updateCellItem()
		self:updateAlert()
	end)
	activity_manager:registerEventListener("SlotMachineSprite_" .. self._activityId, activity_manager.activityEventId.ROULETTE_FOR_ONE, function(arg_7_0)
		arg_7_0.originalItems = {
			{
				itemid = arg_7_0.originalItem,
				itemcount = arg_7_0.originalNum,
				item_attr = arg_7_0.originalItemAttr
			}
		}

		self:playToIndex((self:getItemIndex(arg_7_0.originalItem, arg_7_0.originalNum, arg_7_0.originalItemAttr)))
		self:updateRewardPanel(arg_7_0)

		if not self.isSkip then
			audio_manager:playeffectMusic("sound/roulette_1")
		else
			audio_manager:playeffectMusic("sound/roulette_get")
		end
	end)
	activity_manager:registerEventListener("SlotMachineSprite_" .. self._activityId, activity_manager.activityEventId.ROULETTE_FOR_FIVE, function(arg_8_0)
		self:updateRewardPanel(arg_8_0)

		self.originalItem = arg_8_0.originalItems

		local var_8_0 = table.remove(self.originalItem, 1)

		self:playToIndex((self:getItemIndex(var_8_0.itemid, var_8_0.itemcount, var_8_0.item_attr)))

		if not self.isSkip then
			audio_manager:playeffectMusic("sound/roulette_5")
		else
			audio_manager:playeffectMusic("sound/roulette_get")
		end
	end)
end

function CommonSlotMachineSprite:initDrawParam(arg_9_1, arg_9_2, arg_9_3)
	self._widthCount = arg_9_1
	self._heightCount = arg_9_2
	self._activityId = arg_9_3
	self.needPlayEffect = true
	self._cellBgPath = "ActivityRoulette_" .. arg_9_3 .. "/cell_bg_%s.png"
	self._cellUpPath = "ActivityRoulette_" .. arg_9_3 .. "/cell_up_%s.png"
	self._selectPath = "ActivityRoulette_" .. arg_9_3 .. "/cell_select.png"

	local var_9_0 = ccui.ImageView:create(string.format(self._cellBgPath, 1), var_0_4)

	self._cellWidth = var_9_0:getContentSize().width
	self._cellHeight = var_9_0:getContentSize().height
end

function CommonSlotMachineSprite:initUI()
	self.cells = {}

	local var_10_0 = self.rootLayer:getChildByName("bg")

	for iter_10_0 = 1, self._heightCount do
		for iter_10_1 = 1, self._widthCount do
			if iter_10_0 == 1 or iter_10_0 == self._heightCount or iter_10_1 == 1 or iter_10_1 == self._widthCount then
				local var_10_1 = self:getCellIndex(iter_10_1, iter_10_0)

				self.cells[var_10_1] = self:initSlotMachineCell(var_10_0:getChildByName("cell_" .. var_10_1))
			end
		end
	end

	self.cells[1]:getChildByName("img_select"):setVisible(true)

	self.selectCell = 1

	self:initBG()
	self:initRewardPanel()
end

function CommonSlotMachineSprite:initBG()
	self.modelTitle = self.rootLayer:getChildByName("model_title")
	self.btnShow = self.rootLayer:getChildByName("bg")
end

function CommonSlotMachineSprite:initRewardPanel()
	self.rootLayer:getChildByName("btn_one"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isplay then
			return
		end

		if not activity_manager:isHaveEnoughToRoulettes(self._activityId) then
			local var_13_0 = activity_manager:canBuyRouletteCurrency(self._activityId)

			if var_13_0 and var_13_0 < 0 then
				LayerManager:pushInLayer("PopActivityItemGainLayer", {
					activityId = self._activityId
				})

				return
			elseif var_13_0 then
				goto_complete_system({
					jump_to_system = var_13_0
				})

				return
			end

			LayerManager:pushInLayer("PopRouletteBuyLayer", {
				activityId = self._activityId
			})

			return
		end

		self:clearLastEffect()
		activity_manager:rouletteForOnce(self._activityId)
	end)
	self.rootLayer:getChildByName("btn_five"):addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isplay then
			return
		end

		if not activity_manager:isHaveEnoughToRoulettes(self._activityId, 5) then
			local var_14_0 = activity_manager:canBuyRouletteCurrency(self._activityId)

			if var_14_0 and var_14_0 < 0 then
				LayerManager:pushInLayer("PopActivityItemGainLayer", {
					activityId = self._activityId
				})

				return
			elseif var_14_0 then
				goto_complete_system({
					jump_to_system = var_14_0
				})

				return
			end

			LayerManager:pushInLayer("PopRouletteBuyLayer", {
				activityId = self._activityId
			})

			return
		end

		self.isone = false

		self:clearLastEffect()
		activity_manager:rouletteForFive(self._activityId)
	end)

	self.hasLbl = self.rootLayer:getChildByName("hasLbl")

	local var_12_0 = self.rootLayer:getChildByName("reward_bg")

	self.rewardSprites = {}

	for iter_12_0 = 1, 5 do
		local var_12_1 = var_12_0:getChildByName("sprite_" .. iter_12_0)

		self:initRewardSprite(var_12_1)

		self.rewardSprites[iter_12_0] = var_12_1
	end

	self.isSkip = RoleDefault:getInstance():getBoolForKey("roulette_skip", true)

	local var_12_2 = self.rootLayer:getChildByName("btn_skip")
	local var_12_3 = var_12_2:getChildByName("skip_img")

	var_12_2:setTouchEnabled(true)
	var_12_2:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.isSkip = not self.isSkip

		RoleDefault:getInstance():setBoolForKey("roulette_skip", self.isSkip)
		var_12_3:setVisible(self.isSkip)
	end)
	var_12_3:setVisible(self.isSkip)
end

local function var_0_6(arg_16_0)
	local var_16_0 = -1
	local var_16_1 = require("data.horcrux_data")[arg_16_0].horcruxt

	for iter_16_0, iter_16_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_16_0 == iter_16_1.item_id then
			var_16_0 = iter_16_0

			break
		end
	end

	if var_16_0 == -1 then
		print("did not find id")

		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_16_0,
		itemid = arg_16_0
	})
end

function CommonSlotMachineSprite.initRewardSprite(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getChildByName("clip")

	var_17_0:setClippingEnabled(true)
	var_17_0:setTouchEnabled(true)
	var_17_0:setCascadeOpacityEnabled(true)
	arg_17_1:setVisible(false)
	arg_17_1:setTouchEnabled(true)
	var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[arg_17_1.itemid].bag_item_type == kITEM_HORCRUX then
			var_0_6(arg_17_1.itemid)

			return
		end

		showItemDetails(arg_17_1.itemid)
	end)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("flop.ExportJson")

	local var_17_1 = ccs.Armature:create("flop")

	var_17_1:setPosition(arg_17_1:getContentSize().width / 2, arg_17_1:getContentSize().height / 2)
	var_17_1:getAnimation():play("Animation1")
	var_17_1:setScale(0.8)
	var_17_1:setVisible(false)
	var_17_1:setName("spriteani")
	arg_17_1:addChild(var_17_1)

	for iter_17_0 = 1, 5 do
		local var_17_2

		if config._DEBUG then
			var_17_2 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
		end

		local var_17_3 = 15

		var_17_2:setScale(0.45)
		var_17_2:setName("sp" .. iter_17_0)
		var_17_2:setVisible(false)
		var_17_2:setPosition(var_17_3, (iter_17_0 - 1) * 15 + 15)
		arg_17_1:addChild(var_17_2)
	end

	for iter_17_1 = 6, 10 do
		local var_17_4

		if config._DEBUG then
			var_17_4 = cc.Sprite:create("public/currency/pink_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/pink_star.png")
		end

		local var_17_5 = 15

		var_17_4:setScale(0.45)
		var_17_4:setName("sp" .. iter_17_1)
		var_17_4:setVisible(false)
		var_17_4:setPosition(var_17_5, (10 - iter_17_1) * 15 + 15)
		arg_17_1:addChild(var_17_4)
	end

	local var_17_6 = arg_17_1:getChildByName("clip"):getChildByName("num_lbl")

	var_17_6:setAnchorPoint(1, 0.5)
	var_17_6:setPositionX(arg_17_1:getChildByName("clip"):getContentSize().width - 15)

	return arg_17_1
end

function CommonSlotMachineSprite:is_sp_reward(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = self:getItemIndex(arg_19_1.itemid, arg_19_2, arg_19_3)

	if var_19_0 == 1 or var_19_0 == self._widthCount or var_19_0 == self._widthCount + self._heightCount - 1 or var_19_0 == (self._widthCount - 1) * 2 + self._heightCount then
		return true
	end

	return false
end

function CommonSlotMachineSprite:updateRewardSprite(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = self.rewardSprites[arg_20_1]:getChildByName("clip")

	var_20_0:getChildByName("item"):loadTexture("equipment/" .. item_data[arg_20_4].image_id .. ".png")
	var_20_0:getChildByName("num_lbl"):setString("X" .. arg_20_3)
	self.rewardSprites[arg_20_1]:getChildByName("spriteani"):setVisible(self:is_sp_reward(arg_20_2, arg_20_3, arg_20_5))

	self.rewardSprites[arg_20_1].itemid = arg_20_2.itemid

	local var_20_1 = self:getItemIndex(arg_20_4, arg_20_3, arg_20_5)

	if self.dataList[var_20_1].item_attr then
		for iter_20_0, iter_20_1 in self.dataList[var_20_1].item_attr:gmatch("([^&]+)=([^&]+)") do
			if iter_20_0 == "star" then
				for iter_20_2 = 1, tonumber(iter_20_1) do
					self.rewardSprites[arg_20_1]:getChildByName("sp" .. iter_20_2):setVisible(true)

					if iter_20_2 > 5 then
						self.rewardSprites[arg_20_1]:getChildByName("sp" .. 11 - iter_20_2):setVisible(false)
					end
				end
			end
		end
	else
		for iter_20_3 = 1, 10 do
			self.rewardSprites[arg_20_1]:getChildByName("sp" .. iter_20_3):setVisible(false)
		end
	end
end

function CommonSlotMachineSprite:getCellIndex(arg_21_1, arg_21_2)
	if arg_21_2 == 1 then
		return arg_21_1
	elseif arg_21_1 == self._widthCount then
		return self._widthCount + arg_21_2 - 1
	elseif arg_21_2 == self._heightCount then
		return self._heightCount + 2 * self._widthCount - arg_21_1 - 1
	else
		return 2 * (self._widthCount + self._heightCount - 1) - arg_21_2
	end
end

function CommonSlotMachineSprite:initSlotMachineCell(arg_22_1)
	local var_22_0 = ccui.ImageView:create(self._selectPath, var_0_4)

	var_22_0:setName("img_select")
	var_22_0:setVisible(false)
	var_22_0:setPosition(arg_22_1:getContentSize().width / 2, arg_22_1:getContentSize().height / 2)
	arg_22_1:addChild(var_22_0, -1)

	for iter_22_0 = 1, 5 do
		local var_22_1

		if config._DEBUG then
			var_22_1 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
		end

		local var_22_2 = 85

		var_22_1:setScale(0.55)
		var_22_1:setName("sp" .. iter_22_0)
		var_22_1:setVisible(false)
		var_22_1:setPosition(var_22_2, (iter_22_0 - 1) * 21 + 10)
		arg_22_1:addChild(var_22_1, 2)
	end

	for iter_22_1 = 6, 10 do
		local var_22_3

		if config._DEBUG then
			var_22_3 = cc.Sprite:create("public/currency/pink_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/pink_star.png")
		end

		local var_22_4 = 85

		var_22_3:setScale(0.55)
		var_22_3:setName("sp" .. iter_22_1)
		var_22_3:setVisible(false)
		var_22_3:setPosition(var_22_4, (10 - iter_22_1) * 21 + 10)
		arg_22_1:addChild(var_22_3, 2)
	end

	local var_22_5 = arg_22_1:getChildByName("lbl_num")

	var_22_5:setAnchorPoint(1, 0.5)
	var_22_5:setPositionX(arg_22_1:getContentSize().width - 15)

	return arg_22_1
end

function CommonSlotMachineSprite:updateCellItem()
	for iter_23_0 = 1, #self.cells do
		local var_23_0 = self.cells[iter_23_0]
		local var_23_1 = self.cells[iter_23_0]:getChildByName("clip")
		local var_23_2 = var_23_1:getChildByName("item_img")
		local var_23_3 = self.cells[iter_23_0]:getChildByName("lbl_num")
		local var_23_4 = self.cells[iter_23_0]:getChildByName("img_has")

		if self.dataList[iter_23_0].dropid then
			var_23_2:loadTexture("equipment/" .. item_data[self.dataList[iter_23_0].dropid].image_id .. ".png")
			var_23_2:setVisible(true)
			var_23_3:setString("X" .. self.dataList[iter_23_0].dropNum)
			self.cells[iter_23_0]:getChildByName("mask"):setVisible(self.dataList[iter_23_0].is_empty == true)

			if item_data[self.dataList[iter_23_0].dropid].bag_item_type == kITEM_HORCRUX then
				var_23_2:setScale(0.35)
			else
				var_23_2:setScale(0.65)
			end

			if self.needPlayEffect then
				var_23_2:setOpacity(0)
				var_23_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * iter_23_0), cc.FadeIn:create(0.2)))
			end

			var_23_0:loadTexture(string.format(self._cellBgPath, self.dataList[iter_23_0].quality), var_0_4)
			var_23_0:getChildByName("img_up"):loadTexture(string.format(self._cellUpPath, self.dataList[iter_23_0].quality), var_0_4)
			var_23_1:addTouchEventListener(function(arg_24_0, arg_24_1)
				if arg_24_1 ~= ccui.TouchEventType.ended then
					return
				end

				if item_data[self.dataList[iter_23_0].dropid].bag_item_type == kITEM_HORCRUX then
					var_0_6(self.dataList[iter_23_0].dropid)

					return
				end

				showItemDetails(self.dataList[iter_23_0].dropid)
			end)

			if self.dataList[iter_23_0].item_attr then
				for iter_23_1, iter_23_2 in self.dataList[iter_23_0].item_attr:gmatch("([^&]+)=([^&]+)") do
					if iter_23_1 == "star" then
						for iter_23_3 = 1, tonumber(iter_23_2) do
							var_23_0:getChildByName("sp" .. iter_23_3):setVisible(true)

							if iter_23_3 > 5 then
								var_23_0:getChildByName("sp" .. 11 - iter_23_3):setVisible(false)
							end
						end
					end
				end
			else
				for iter_23_4 = 1, 10 do
					var_23_0:getChildByName("sp" .. iter_23_4):setVisible(false)
				end
			end
		end

		local var_23_5 = activity_manager:getRouletteShowModel(self._activityId)

		self.modelTitle:setVisible(var_23_5 ~= nil)

		if var_23_5 then
			self.btnShow:addTouchEventListener(function(arg_25_0, arg_25_1)
				if arg_25_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
					modelid = var_23_5
				})
			end)
		end

		local var_23_6, var_23_7 = activity_manager:getRouletteNums(self._activityId)

		self.hasLbl:setString(string.format(L_ROULETTE_NUM, var_23_7))

		self.needPlayEffect = false
	end
end

function CommonSlotMachineSprite:playJoinEffect()
	math.randomseed(os.time())

	local var_26_0 = {}
	local var_26_1 = {}

	for iter_26_0 = 1, #self.cells do
		table.insert(var_26_0, iter_26_0)
	end

	for iter_26_1 = 1, #self.cells do
		table.insert(var_26_1, table.remove(var_26_0, (math.random(#var_26_0))))
	end

	for iter_26_2 = 1, #var_26_1 do
		self.cells[var_26_1[iter_26_2]]:getChildByName("clip"):getChildByName("item_img"):runAction(cc.Sequence:create(cc.DelayTime:create(0.15 * iter_26_2 - 0.2), cc.FadeIn:create(0.2)))
	end
end

function CommonSlotMachineSprite:playToIndex(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = (arg_27_3 or var_0_5) * #self.cells + arg_27_1
	local var_27_2 = {
		time = (self.selectCell ~= 1 or nil) and self.selectCell - #self.cells
	}

	if not self.isone and self.isSkip then
		arg_27_2 = 0.1
	end

	self.updatetween = require("fight.tween").new(arg_27_2 or 6.5, var_27_2, {
		time = (arg_27_3 or var_0_5) * #self.cells + arg_27_1
	}, arg_27_4 or "inOutQuad")
	self.isplay = true

	self:scheduleUpdateWithPriorityLua(function(arg_28_0)
		if self.updatetween:update(arg_28_0) then
			self:playToCell(var_27_0)
			self:unscheduleUpdate()
			self:showRewardByIndex(1)

			if self.originalItem and next(self.originalItem) then
				local var_28_0 = table.remove(self.originalItem, 1)

				self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
					self:shortPlayToIndex(self:getItemIndex(var_28_0.itemid, var_28_0.itemcount, var_28_0.item_attr))
				end)))
			else
				self.isplay = false
			end
		else
			self:playToCell(math.round(var_27_2.time))
		end
	end, 0)
end

function CommonSlotMachineSprite:shortPlayToIndex(arg_30_1)
	local var_30_0 = arg_30_1

	if arg_30_1 <= self.selectCell then
		var_30_0 = #self.cells + arg_30_1
	end

	if self.isSkip then
		audio_manager:playeffectMusic("sound/roulette_get")
	end

	local var_30_1 = {
		time = self.selectCell
	}
	local var_30_3 = require("fight.tween").new((not self.isone and self.isSkip or nil) and 0.1, var_30_1, {
		time = var_30_0
	}, "linear")

	self:scheduleUpdateWithPriorityLua(function(arg_31_0)
		if var_30_3:update(arg_31_0) then
			self:playToCell(var_30_0)
			self:unscheduleUpdate()
			self:showRewardByIndex(5 - #self.originalItem)

			if self.originalItem and next(self.originalItem) then
				local var_31_0 = table.remove(self.originalItem, 1)

				self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
					self:shortPlayToIndex(self:getItemIndex(var_31_0.itemid, var_31_0.itemcount, var_31_0.item_attr))
				end)))
			else
				self.isplay = false
			end
		else
			self:playToCell(math.round(var_30_1.time))
		end
	end, 0)
end

function CommonSlotMachineSprite:playToCell(arg_33_1)
	if arg_33_1 < 0 then
		arg_33_1 = #self.cells + arg_33_1
	end

	arg_33_1 = arg_33_1 and arg_33_1 % #self.cells

	if arg_33_1 == 0 then
		arg_33_1 = #self.cells
	end

	if arg_33_1 and self.selectCell == arg_33_1 then
		return
	end

	self.cells[self.selectCell]:getChildByName("img_select"):setVisible(false)

	self.selectCell = arg_33_1 or self.selectCell + 1

	if self.selectCell > #self.cells then
		self.selectCell = 1
	end

	self.cells[self.selectCell]:getChildByName("img_select"):setVisible(true)
end

function CommonSlotMachineSprite:getItemIndex(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(self.dataList) do
		if iter_34_1.dropid == arg_34_1 then
			if arg_34_2 and iter_34_1.dropNum == arg_34_2 then
				if arg_34_3 and arg_34_3 ~= iter_34_1.item_attr then
					-- block empty
				else
					table.insert(var_34_0, iter_34_0)
				end
			elseif not arg_34_2 then
				return iter_34_0
			end
		end
	end

	if #var_34_0 == 1 then
		return var_34_0[1]
	end

	math.randomseed(os.time())

	return var_34_0[math.random(#var_34_0)]
end

function CommonSlotMachineSprite:updateRewardPanel(arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_1.items) do
		if iter_35_0 > #arg_35_1.originalItems then
			return
		end

		self:updateRewardSprite(iter_35_0, iter_35_1, arg_35_1.originalItems[iter_35_0].itemcount, arg_35_1.originalItems[iter_35_0].itemid, arg_35_1.originalItems[iter_35_0].item_attr)
	end
end

function CommonSlotMachineSprite:showRewardByIndex(arg_36_1)
	self.rewardSprites[arg_36_1]:setOpacity(0)
	self.rewardSprites[arg_36_1]:setVisible(true)
	self.rewardSprites[arg_36_1]:runAction(cc.FadeIn:create(0.2))
end

function CommonSlotMachineSprite:clearLastEffect()
	for iter_37_0, iter_37_1 in pairs(self.rewardSprites) do
		iter_37_1:setVisible(false)
	end

	self.originalItem = nil
end

function CommonSlotMachineSprite.updateAlert(arg_38_0)
	return
end

function CommonSlotMachineSprite:skip()
	self.updatetween:update(6.45)
end
