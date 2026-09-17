MarryPopLayer = class("MarryPopLayer", function()
	return cc.Layer:create()
end)

local var_0_0
local var_0_1 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local dormitory_manager = require("controller.dormitory_manager")
local marry_manager = require("controller.marry_manager")
local item_manager = require("controller.item_manager")
local l2utils = require("controller.l2utils")
local discount_manager = require("controller.discount_manager")
local shop_manager = require("controller.shop_manager")
local audio_manager = require("controller.audio_manager")
local major_factor_data = require("data.major_factor_data")
local marry_data = require("data.marry_data")
local favor_data = require("data.favor_data")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local var_0_15 = 107103000
local var_0_16 = 0
local var_0_17 = 1
local var_0_18 = 2
local var_0_19 = 3
local var_0_21 = 100

function MarryPopLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = MarryPopLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function MarryPopLayer.getInstance()
	return var_0_0
end

function MarryPopLayer:init(arg_4_1)
	var_0_0 = self
	self.initConfig = arg_4_1
	self.majorid = arg_4_1.majorid
	self.haveGotoDorm = arg_4_1.have_goto_dorm
	self.exitCallback = arg_4_1.exitCallback

	LayerManager:createFullScreenMask(self, 200, function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.global_touch_lock then
			return
		end

		if self.exitCallback then
			self.exitCallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "marry_pop.json" or "marry_pop.ExportJson")

	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_tips"):setString("注:誓约后可突破好感等级上限")
	marry_manager:get_ring_shop_list()
	self:initData()
	self:initUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function MarryPopLayer.initData(arg_8_0)
	(function()
		local var_9_0, var_9_1 = marry_manager:checkIsMarried(arg_8_0.majorid)
		local var_9_2 = {
			name = major_factor_data[arg_8_0.majorid].easy_name,
			favorlevel = playermodel.favor[arg_8_0.majorid].favorlevel
		}

		var_9_2.pinkdes = favor_data[playermodel.favor[arg_8_0.majorid].favorlevel].marry_des or "向你表达了爱慕之情"
		var_9_2.talkid = marry_data[arg_8_0.majorid].talk or 10000001
		var_9_2.isMarried = var_9_0
		var_9_2.marriedTime = var_9_1
		arg_8_0.majorInfo = var_9_2
	end)()
	;(function()
		local var_10_1, var_10_2 = string.match(marry_data[arg_8_0.majorid].skin_pos or "", "([^,]+),(.+)")

		var_10_1 = var_10_1 or 299

		local var_10_3

		if not var_10_2 then
			var_10_2 = 357
			var_10_3 = {
				itemid = marry_data[arg_8_0.majorid].skin,
				modelid = item_data[marry_data[arg_8_0.majorid].skin].model,
				skin_hide = item_data[marry_data[arg_8_0.majorid].skin].skin_hide
			}
		end

		var_10_3.img = model_data[item_data[marry_data[arg_8_0.majorid].skin].model].role_image
		var_10_3.scale = marry_data[arg_8_0.majorid].skin_scale or 0.7
		var_10_3.pos = {
			x = var_10_1,
			y = var_10_2
		}
		arg_8_0.skinInfo = var_10_3
	end)()
	;(function()
		local var_11_0

		var_11_0 = marry_data[arg_8_0.majorid].ring and (item_manager:haveItem(var_11_0) and marry_data[arg_8_0.majorid].ring or item_manager:haveItem(var_0_15) and var_0_15 or marry_data[arg_8_0.majorid].ring) or var_0_15
		arg_8_0.ringInfo = {
			itemid = var_11_0,
			image = item_data[var_11_0].image_id,
			name = item_data[var_11_0].name
		}
	end)()
	;(function()
		local var_12_0 = "marry/label_no.png"

		arg_8_0.flagInfo = {
			marry_manager:check_marry_flag(arg_8_0.majorid, 1) and "marry/label_yes.png" or var_12_0,
			marry_manager:check_marry_flag(arg_8_0.majorid, 2) and "marry/label_yes.png" or var_12_0
		}
	end)()
end

function MarryPopLayer:initUI()
	local var_13_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_left")

	self.myname = var_13_0:getChildByName("my_name")
	self.girlname = var_13_0:getChildByName("girl_name")
	self.pinkname = var_13_0:getChildByName("pink_name")
	self.pinkdes = var_13_0:getChildByName("pink_des")
	self.adddes = var_13_0:getChildByName("add_des")

	self.adddes:setContentSize(cc.size(320, 240))
	self.adddes:setTextAreaSize(cc.size(320, 240))
	self.adddes:setPositionY(self.adddes:getPositionY() + 18)
	var_13_0:setLocalZOrder(5)

	self.roleImg = ccui.Helper:seekWidgetByName(self.rootLayer, "role_img")
	self.roleDes = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_des")

	local var_13_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bottom")
	local var_13_2 = var_13_1:getChildByName("Panel_marry_flag")

	self.ringIcon = var_13_2:getChildByName("icon1")
	self.ringLabel = var_13_2:getChildByName("Label1")
	self.flagImg1 = var_13_2:getChildByName("img1")
	self.heartIcon = var_13_2:getChildByName("icon2")
	self.heartlevel = self.heartIcon:getChildByName("heart_level")
	self.heartLabel = var_13_2:getChildByName("Label2")
	self.flagImg2 = var_13_2:getChildByName("img2")
	self.marriedImg = var_13_1:getChildByName("Image_married")
	self.marriedDateLabel = self.marriedImg:getChildByName("Label_marry_date")
	self.sureBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")
	self.gotoDormBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_dorm")

	;(function()
		self.myname:setString(L_MONITOR .. ": " .. playermodel.nickname)
		self.girlname:setString(L_PLAYER_DATA_TYPE.Girls .. ": " .. self.majorInfo.name)
		self.pinkname:setString(self.majorInfo.name)
		self.pinkdes:setString(self.majorInfo.pinkdes)

		local var_14_0 = (favor_data[playermodel.favor[self.majorid].favorlevel].add_hp or 0) * 100
		local var_14_1 = (favor_data[playermodel.favor[self.majorid].favorlevel].add_damage or 0) * 100

		if (favor_data[playermodel.favor[self.majorid].favorlevel].add_science_point or 0) == 0 then
			self.adddes:setString(L_MARRY_SCIENCE[3])
		else
			local var_14_2 = L_MARRY_SCIENCE[4] .. "+" .. var_14_0 .. "% " .. L_MARRY_SCIENCE[5] .. "+" .. var_14_1 .. "%"

			if not favor_data[playermodel.favor[self.majorid].favorlevel + 1] then
				self.adddes:setString(var_14_2)
			else
				if not favor_data[playermodel.favor[self.majorid].favorlevel + 1].add_science_point then
					-- block empty
				end

				self.adddes:setString(var_14_2 .. "\n下一级:\n" .. L_MARRY_SCIENCE[4] .. "+" .. (favor_data[playermodel.favor[self.majorid].favorlevel + 1].add_hp or 0) * 100 .. "% " .. L_MARRY_SCIENCE[5] .. "+" .. (favor_data[playermodel.favor[self.majorid].favorlevel + 1].add_damage or 0) * 100 .. "%")
			end
		end
	end)()
	;(function()
		self.roleImg:loadTexture(ROLE_IMAGE_PATH .. self.skinInfo.img .. ".png")
		self.roleImg:setPosition(self.skinInfo.pos)
		self.roleImg:setScale(self.skinInfo.scale)

		if self.majorInfo.isMarried then
			if self.skinInfo.skin_hide == 1 then
				self.roleDes:loadTexture("marry/label_no_skin_des.png", var_0_1)
			elseif self.skinInfo.skin_hide == 2 then
				self.roleDes:setVisible(false)
			else
				self.roleDes:setVisible(false)
				self.roleDes:loadTexture("marry/label_des.png", var_0_1)
			end
		else
			self.roleDes:setVisible(true)

			if self.skinInfo.skin_hide == 1 then
				self.roleDes:loadTexture("marry/label_no_skin_des.png", var_0_1)
			elseif self.skinInfo.skin_hide == 2 then
				self.roleDes:setVisible(false)
			else
				self.roleDes:loadTexture("marry/label_des.png", var_0_1)
			end
		end
	end)()
	;(function()
		if self.majorInfo.isMarried then
			var_13_1:getChildByName("Panel_marry_flag"):setVisible(false)
			var_13_1:getChildByName("Image_married"):setVisible(true)

			local var_16_0 = os.date("*t", self.majorInfo.marriedTime)

			self.marriedDateLabel:setString((string.format("%d.%d.%d", var_16_0.year, var_16_0.month, var_16_0.day)))
		else
			var_13_1:getChildByName("Panel_marry_flag"):setVisible(true)
			var_13_1:getChildByName("Image_married"):setVisible(false)
			self.ringLabel:setString(L_MARRY_DES.RING .. self.ringInfo.name)
			self.flagImg1:loadTexture(self.flagInfo[1], var_0_1)
			self.heartlevel:setString(self.majorInfo.favorlevel)
			self.heartLabel:setString(string.format(L_MARRY_DES.FAVOR1, MARRY_LEVEL))
			self.flagImg2:loadTexture(self.flagInfo[2], var_0_1)
		end
	end)()
	;(function()
		self.sureBnt:loadTextures(nil, nil, marry_manager:checkIsMarried(self.majorid) and "marry/review_bnt.png" or "marry/sure_bnt.png", var_0_1)
		self.sureBnt:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:registerSureBntEvent(arg_18_0)
		end)

		if not marry_manager:checkIsMarried(self.majorid) and not marry_manager:check_marry_flag(self.majorid) then
			l2utils:shaderDarkNode(self.sureBnt:getVirtualRenderer())
		end
	end)()
	;(function()
		if self.haveGotoDorm then
			self.gotoDormBtn:setVisible(true)
			self.gotoDormBtn:setPositionX(460)
			self.sureBnt:setPositionX(250)
			self.gotoDormBtn:addTouchEventListener(function(arg_20_0, arg_20_1)
				if arg_20_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("DormRoomPopLayer", {
					soulid = self.majorid
				})
				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
					LayerManager:removePopLayer(self.__queueindex)
				end)))
			end)
		else
			self.gotoDormBtn:setVisible(false)
		end
	end)()
end

function MarryPopLayer:registerSureBntEvent(arg_22_1)
	if self.global_touch_lock then
		return
	end

	if arg_22_1.isLock then
		return
	end

	arg_22_1.isLock = true

	if marry_manager:checkIsMarried(self.majorid) then
		self:marryTalk(function()
			arg_22_1.isLock = false
		end)
	else
		marry_manager:marry_with_major(self.majorid, function(arg_24_0, arg_24_1)
			if arg_24_0 == 1 then
				self:initData()
				self:initUI()
				self:marryTalk(function()
					if self.exitCallback then
						self.exitCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)

					if next(arg_24_1) then
						LayerManager:pushInLayer("PopPurchaseResultLayer", {
							items = arg_24_1
						})
					end
				end)

				arg_22_1.isLock = false
			elseif arg_24_0 == 3 then
				self:popBuyRing(function()
					arg_22_1.isLock = false
				end)
			else
				arg_22_1.isLock = false
			end
		end)
	end
end

function MarryPopLayer:marryTalk(arg_27_1)
	LayerManager:pushInLayer("MarryTalkLayer", {
		classification = self.majorInfo.talkid,
		finishCallback = function()
			if arg_27_1 then
				arg_27_1()
			end
		end
	})
end

function MarryPopLayer:popBuyRing(arg_29_1)
	if not marry_manager.ringshops or not marry_manager.ringshops[self.majorid] then
		global_ShowBlockWords(L_MARRY_ERR[3])

		if arg_29_1 then
			arg_29_1()
		end

		return
	end

	local var_29_0 = marry_manager.ringshops[self.majorid].shopinfo
	local var_29_1 = marry_manager.ringshops[self.majorid].shoptype
	local var_29_2 = {
		[var_0_17] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[var_0_16] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		[var_0_18] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[var_0_19] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[GIFT_TICKET] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer",
				callback = updateCoinLabel
			})
		end
	}

	setmetatable(var_29_2, {
		__index = function(arg_35_0, arg_35_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_35_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_29_3 = {
		[var_0_17] = function()
			return playermodel.gold
		end,
		[var_0_16] = function()
			return playermodel.diamond
		end,
		[var_0_18] = function()
			return playermodel.honor
		end,
		[var_0_19] = function()
			return playermodel.explorecoin
		end,
		[var_0_21] = function()
			return 0
		end
	}

	setmetatable(var_29_3, {
		__index = function(arg_48_0, arg_48_1)
			return function()
				return item_manager:getItemNumber(arg_48_1)
			end
		end
	})

	local var_29_4 = {
		[var_0_17] = "gold",
		[var_0_16] = "diamond"
	}

	setmetatable(var_29_4, {
		__index = function(arg_50_0, arg_50_1)
			return arg_50_1
		end
	})

	local var_29_5 = {
		surecallback = function()
			self.global_touch_lock = true

			local function var_37_0()
				marry_manager:marry_with_major(self.majorid, function(arg_39_0)
					if arg_39_0 == 1 then
						self:initData()
						self:initUI()
						self:marryTalk(function()
							if self.exitCallback then
								self.exitCallback()
							end

							LayerManager:removePopLayer(self.__queueindex)
						end)
					end

					if arg_29_1 then
						arg_29_1()
					end

					self.global_touch_lock = false
				end)
			end

			shop_manager:shop_buy(var_29_1, var_29_0.shopid, function(arg_41_0)
				if arg_41_0 == 1 then
					var_37_0()
				elseif arg_41_0 == 4 then
					var_29_2[var_29_0.currency]()

					if arg_29_1 then
						arg_29_1()
					end

					self.global_touch_lock = false
				else
					if arg_29_1 then
						arg_29_1()
					end

					self.global_touch_lock = false
				end
			end, 1, nil, true)
		end,
		cancelcallback = arg_29_1,
		labels = {
			title = L_MARRY_BUY.title,
			button = L_MARRY_BUY.button
		}
	}

	if (function(arg_42_0)
		if not arg_42_0.currency2 or discount_manager:getLastPriceByItem(arg_42_0.itemid, arg_42_0.currency2, arg_42_0.discount2) < arg_42_0.discount2 then
			return true
		end

		return false
	end)(var_29_0) then
		var_29_5.costtype = var_29_4[var_29_0.currency]
		var_29_5.own = var_29_3[var_29_0.currency]()
		var_29_5.cost = var_29_0.discount

		if var_29_0.discount < var_29_0.price then
			var_29_5.cost_old = var_29_0.price or nil
		end
	else
		var_29_5.costtype = var_29_4[var_29_0.currency2]
		var_29_5.own = var_29_3[var_29_0.currency2]()
		var_29_5.cost = var_29_0.discount2

		if var_29_0.discount2 < var_29_0.price2 then
			var_29_5.cost_old = var_29_0.price2 or nil
		end
	end

	var_29_5.labels.des = L_MARRY_BUY.des1 .. (var_29_5.cost .. item_data[var_29_5.costtype].name) .. L_MARRY_BUY.des2

	LayerManager:pushInLayer("PopDoLayer", var_29_5)
end
