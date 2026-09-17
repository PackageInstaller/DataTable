local armature_manager = require("controller.armature_manager")
local postcard_data = require("data.postcard_data")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local var_0_7 = "mainScenebg/panel_back_bg.jpg"
local var_0_8 = "PopPurchaseResultLayer/get_items.png"
local var_0_9 = "PopPurchaseResultLayer/recharge_success.png"
local var_0_10 = "effect/particle/purchaseResultLayer/particle_triangle.plist"
local var_0_11 = "effect/particle/purchaseResultLayer/particle_cylinder.plist"
local var_0_12 = "effect/particle/purchaseResultLayer/particle_triangle_static.plist"
local var_0_13 = 1
local var_0_14 = 2
local var_0_15 = 0.16666666666666666
local var_0_16 = 150
local var_0_18 = config._DEBUG and 0 or 1

PopPurchaseResultLayer = class("PopPurchaseResultLayer", function()
	return PopBaseLayer:create()
end)

function PopPurchaseResultLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopPurchaseResultLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopPurchaseResultLayer:init(arg_3_1)
	print("open poplayer : PopPurchaseResultLayer")

	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.openType = arg_3_1.openType or var_0_13
	self.initConfig = arg_3_1 or {}
	self.itemformat = arg_3_1.itemformat or {}

	self:playAudio()
	self:initUI()
	self:playEnterAnimation()
	self:playParticleEffect()
	self:showGoodsGeting()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:fireEvent(activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER)

			if arg_3_1.cancelcallback then
				arg_3_1.cancelcallback()
			end
		elseif arg_4_0 == "enter" and arg_3_1.intocallback then
			arg_3_1.intocallback({
				layer = self
			})
		end
	end)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("on_gain_item")))
end

function PopPurchaseResultLayer.playAudio(arg_5_0)
	audio_manager:playeffectMusic(GET_AWARDS)
end

function PopPurchaseResultLayer:initUI()
	self.rootpanel = ccui.ImageView:create(var_0_7)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootpanel:setName("bottom_bg")
	self.rootLayer:addChild(self.rootpanel)

	local var_6_0 = ccui.ImageView:create()

	if self.openType == var_0_13 then
		var_6_0:loadTexture(var_0_8, var_0_18)
	elseif self.openType == var_0_14 then
		var_6_0:loadTexture(var_0_9, var_0_18)
	end

	var_6_0:setPositionX(self.rootLayer:getContentSize().width / 2)
	var_6_0:setPositionY(self.rootLayer:getContentSize().height / 2 + var_0_16)
	var_6_0:setName("open_type_img")
	self.rootLayer:addChild(var_6_0)
	self:createFullScreenMask(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
		self.goodsLayer:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_15)))
		self.rootpanel:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_15), cc.CallFunc:create(function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end)
end

function PopPurchaseResultLayer:playEnterAnimation()
	self.rootLayer:addChild((armature_manager:createAndPlayArmature("purchaseResultEnter")))
	self.rootpanel:setOpacity(0)
	self.rootpanel:runAction(cc.Sequence:create(cc.FadeIn:create(var_0_15)))

	local var_9_0 = self.rootLayer:getChildByName("open_type_img")

	var_9_0:setOpacity(0)
	var_9_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.4166666666666667), cc.FadeIn:create(0.13333333333333333)))

	local var_9_1 = armature_manager:createAndPlayArmature("purchaseResultLoop")

	var_9_1:setAnchorPoint(cc.p(0.5, 0))
	var_9_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, (self.rootpanel:getContentSize().height - GameDisplay:getUiScreenSize().height) / 2))
	self.rootpanel:addChild(var_9_1)
end

function PopPurchaseResultLayer:playParticleEffect()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.25), cc.CallFunc:create(function()
		local var_11_0 = cc.ParticleSystemQuad:create(var_0_10)

		var_11_0:setAutoRemoveOnFinish(true)
		var_11_0:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, (self.rootpanel:getContentSize().height - GameDisplay:getUiScreenSize().height) / 2))
		self.rootpanel:addChild(var_11_0)

		local var_11_1 = cc.ParticleSystemQuad:create(var_0_12)

		var_11_1:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.rootpanel:getContentSize().height / 2))
		self.rootpanel:addChild(var_11_1)

		local var_11_2 = cc.ParticleSystemQuad:create(var_0_11)

		var_11_2:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.rootpanel:getContentSize().height / 2))
		self.rootpanel:addChild(var_11_2)
	end)))
end

function PopPurchaseResultLayer.initGoodsData(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = 1

	if arg_12_1.gold then
		local var_12_2 = tonumber(arg_12_1.gold)

		if var_12_2 and var_12_2 > 0 then
			var_12_1 = var_12_1 + 1

			table.insert(var_12_0, {
				itemtype = "gold",
				entityid = "gold",
				addNumber = var_12_2,
				name = L_GOLD
			})
		end
	end

	if arg_12_1.diamond and arg_12_1.diamond > 0 then
		var_12_1 = var_12_1 + 1

		table.insert(var_12_0, {
			itemtype = "diamond",
			entityid = "diamond",
			addNumber = arg_12_1.diamond,
			name = L_DIAMOND
		})
	end

	if arg_12_1.extradiamond and arg_12_1.extradiamond > 0 then
		var_12_1 = var_12_1 + 1

		table.insert(var_12_0, {
			itemtype = "diamond",
			entityid = "diamond",
			addNumber = arg_12_1.extradiamond,
			name = L_RECHARGE_DATA_EXTRA .. L_DIAMOND
		})
	end

	if arg_12_1.honor and arg_12_1.honor > 0 then
		var_12_1 = var_12_1 + 1

		table.insert(var_12_0, {
			itemtype = "honor",
			entityid = "honor",
			addNumber = arg_12_1.honor,
			name = L_PLAYER_DATA_TYPE.Honor
		})
	end

	if arg_12_1.explorecoin and arg_12_1.explorecoin > 0 then
		var_12_1 = var_12_1 + 1

		table.insert(var_12_0, {
			itemtype = "explorecoin",
			entityid = "explorecoin",
			addNumber = arg_12_1.explorecoin,
			name = L_PLAYER_DATA_TYPE.Explorecoin
		})
	end

	if arg_12_1.sp and arg_12_1.sp > 0 then
		var_12_1 = var_12_1 + 1

		table.insert(var_12_0, {
			itemtype = "strengthpoint",
			entityid = "strengthpoint",
			addNumber = arg_12_1.sp,
			name = L_PLAYER_DATA_TYPE.Tech
		})
	end

	if arg_12_1.energy and arg_12_1.energy > 0 then
		var_12_1 = var_12_1 + 1

		table.insert(var_12_0, {
			itemtype = "energy",
			entityid = "energy",
			addNumber = arg_12_1.energy,
			name = L_PLAYER_DATA_TYPE.Energy
		})
	end

	if arg_12_1.active and arg_12_1.active > 0 then
		var_12_1 = var_12_1 + 1

		table.insert(var_12_0, {
			itemtype = "active",
			entityid = "active",
			addNumber = arg_12_1.active,
			name = L_PLAYER_DATA_TYPE.Active
		})
	end

	if arg_12_1.postcard and arg_12_1.postcard ~= -1 then
		var_12_1 = var_12_1 + 1

		table.insert(var_12_0, {
			itemtype = "postcard",
			addNumber = 1,
			entityid = arg_12_1.postcard,
			name = L_PLAYER_DATA_TYPE.Postcard
		})
	end

	if arg_12_1.items then
		for iter_12_0, iter_12_1 in pairs(arg_12_1.items) do
			var_12_1 = var_12_1 + 1

			local var_12_3
			local var_12_4

			if iter_12_1.itemid then
				var_12_3 = item_data[iter_12_1.itemid].equip_quality
				var_12_4 = item_data[iter_12_1.itemid].name
			elseif iter_12_1.entityid then
				local var_12_5 = playermodel.items[iter_12_1.entityid] and playermodel.items[iter_12_1.entityid].itemid

				var_12_3 = item_data[var_12_5].equip_quality
				var_12_4 = item_data[var_12_5].name
			end

			local var_12_6 = iter_12_1.itemid
			local var_12_7 = iter_12_1.dropNum
			local var_12_8 = var_12_4

			if iter_12_1.dropid and item_data[iter_12_1.dropid] and item_data[iter_12_1.dropid].bag_item_type == kITEM_POSTCARD then
				var_12_6 = "postcard"
				var_12_7 = 1
				var_12_8 = L_PLAYER_DATA_TYPE.Postcard
			end

			table.insert(var_12_0, {
				itemid = iter_12_1.itemid,
				itemtype = var_12_6,
				entityid = iter_12_1.entityid,
				horcrux_attr = iter_12_1.horcrux_attr,
				addNumber = var_12_7,
				name = var_12_8,
				quality = var_12_3
			})
		end
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		if not arg_13_0.quality then
			return false
		end

		if not arg_13_1.quality then
			return false
		end

		return arg_13_0.quality > arg_13_1.quality
	end)

	return var_12_0, var_12_1
end

function PopPurchaseResultLayer:showGoodsGeting()
	local var_14_0, var_14_1 = self:initGoodsData(self.initConfig)

	self.goodsData = var_14_0
	self.goodsLayer = ccui.ScrollView:create()

	self.goodsLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.goodsLayer:setPositionX(GameDisplay:getScreenSize().width / 2)
	self.goodsLayer:setPositionY(GameDisplay:getScreenSize().height / 2 + 15)
	self.rootLayer:addChild(self.goodsLayer, 999)
	self.goodsLayer:setName("goods_layer")

	local var_14_2 = 400
	local var_14_3 = 200
	local var_14_4 = 200
	local var_14_5 = 200
	local var_14_6 = 0
	local var_14_7 = {}

	self.goodsLayer:setContentSize(cc.size(400, 200))

	for iter_14_0, iter_14_1 in pairs(self.itemformat) do
		if #iter_14_1 > 0 then
			require("view.Layer.GetRoleAnimationLayer")
			cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(iter_14_1.origina_itemid, nil, nil, nil, {
				itemid = iter_14_1.final_itemid,
				itemNum = iter_14_1.final_itemNum
			}), 500)
		end
	end

	for iter_14_2 = 1, var_14_1 - 1 do
		local var_14_8
		local var_14_9 = self.goodsData[iter_14_2].itemid or playermodel.items[self.goodsData[iter_14_2].entityid] and playermodel.items[self.goodsData[iter_14_2].entityid].itemid

		if var_14_9 and item_data[var_14_9] then
			var_14_8 = item_data[var_14_9].bag_item_type
		end

		if var_14_8 and var_14_8 == kITEM_HERO or var_14_8 and var_14_8 == kITEM_SKIN then
			require("view.Layer.GetRoleAnimationLayer")
			cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(self.goodsData[iter_14_2].itemid or self.goodsData[iter_14_2].entityid), 500)

			var_14_7[var_14_9] = true
			var_14_6 = var_14_6 + 1
		else
			local var_14_11

			if self.goodsData[iter_14_2].entityid then
				if self.goodsData[iter_14_2].itemtype == "postcard" then
					var_14_11 = ccui.ImageView:create("mainScenebg/postcard/" .. postcard_data[self.goodsData[iter_14_2].entityid].image .. ".png")
					var_14_11.postcard = true

					var_14_11:setScale(150 / var_14_11:getContentSize().height)
				else
					var_14_11 = ItemPurchaseSprite:createPurchaseItemByEntityid(self.goodsData[iter_14_2].entityid, self.goodsData[iter_14_2].addNumber, nil, self.goodsData[iter_14_2].horcrux_attr)
					var_14_11.itemid = playermodel.items[self.goodsData[iter_14_2].entityid] and playermodel.items[self.goodsData[iter_14_2].entityid].itemid
					var_14_11.entityid = self.goodsData[iter_14_2].entityid
				end
			elseif self.goodsData[iter_14_2].itemid then
				if self.goodsData[iter_14_2].itemtype == "postcard" then
					var_14_11 = ccui.ImageView:create("mainScenebg/postcard/" .. postcard_data[postcardId].image .. ".png")
					var_14_11.postcard = true

					var_14_11:setScale(150 / p_img:getContentSize().height)
				else
					var_14_11 = ItemPurchaseSprite:createPurchaseItem(self.goodsData[iter_14_2].itemid, self.goodsData[iter_14_2].addNumber, nil, nil, self.goodsData[iter_14_2].horcrux_attr)
					var_14_11.itemid = self.goodsData[iter_14_2].itemid
				end
			end

			var_14_11:setName("item_sp_" .. iter_14_2 - var_14_6)
			self.goodsLayer:addChild(var_14_11)

			local var_14_12 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_18)

			var_14_12:setContentSize(cc.size(150, 150))
			var_14_12:setPosition(cc.p(var_14_11:getContentSize().width / 2, var_14_11:getContentSize().height / 2))
			var_14_12:setAnchorPoint(cc.p(0.5, 0.5))
			var_14_12:setTouchEnabled(true)
			var_14_11:addChild(var_14_12)
			var_14_12:addTouchEventListener(function(arg_15_0, arg_15_1)
				if arg_15_1 ~= ccui.TouchEventType.ended then
					return
				end

				if item_data[var_14_11.itemid].bag_item_type == kITEM_HORCRUX then
					if arg_15_1 ~= ccui.TouchEventType.ended then
						return
					end

					local var_15_0 = -1

					for iter_15_0, iter_15_1 in pairs((require("data.photofile_HelpGirl_data"))) do
						if var_14_11.itemid == iter_15_1.item_id then
							var_15_0 = iter_15_0

							break
						end
					end

					if var_15_0 == -1 then
						print("did not find id")

						return
					end

					require("view.Layer.DetailsofHelpGirlLayer")
					LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
						id = var_15_0,
						itemid = var_14_11.itemid,
						callback = callback
					})
				else
					if item_manager:getItemNumber(var_14_11.itemid) < 1 then
						return
					end

					if item_data[var_14_11.itemid].bag_item_type == kITEM_CHOOSE_GIFT then
						LayerManager:pushInLayer("PopOpenChoosegiftLayer", {
							itemid = var_14_11.itemid
						})
					elseif item_data[var_14_11.itemid].bag_item_type ~= CHAT_EMOTION_VALUE then
						showItemDetails(var_14_11.itemid, var_14_11.entityid)
					end
				end
			end)
		end
	end

	local var_14_13 = 1

	while self.goodsData[var_14_13] do
		local var_14_14 = self.goodsData[var_14_13].itemid

		if item_data[self.goodsData[var_14_13].entityid] then
			var_14_14 = self.goodsData[var_14_13].entityid
		end

		if var_14_14 then
			if var_14_7[var_14_14] then
				table.remove(self.goodsData, var_14_13)
			else
				var_14_13 = var_14_13 + 1
			end
		else
			var_14_13 = var_14_13 + 1
		end
	end

	if not self.goodsData or not next(self.goodsData) then
		self:ifGetGoodsDataNothing()
	end

	local var_14_15 = var_14_1 - var_14_6 - 1
	local var_14_16 = math.ceil((var_14_1 - var_14_6 - 1) / 2)

	if var_14_1 - var_14_6 - 1 <= 6 then
		self.goodsLayer:setBounceEnabled(false)
		self.goodsLayer:setContentSize(cc.size(var_14_2, var_14_3 * var_14_16))

		local var_14_17 = self.goodsLayer:getContentSize().width
		local var_14_18 = self.goodsLayer:getContentSize().height

		for iter_14_3 = 1, var_14_15 do
			local var_14_19 = self.goodsLayer:getChildByName("item_sp_" .. iter_14_3)

			if var_14_15 % 2 ~= 0 then
				if iter_14_3 == 1 then
					var_14_19:setPositionX(var_14_17 / 2)
				else
					var_14_19:setPositionX(var_14_17 / 2 + ((iter_14_3 - var_14_15 % 2) % 2 - 0.5) * var_14_4)
				end
			else
				var_14_19:setPositionX(var_14_17 / 2 + ((iter_14_3 - var_14_15 % 2) % 2 - 0.5) * var_14_4)
			end

			if var_14_16 % 2 ~= 0 then
				var_14_19:setPositionY(var_14_18 / 2 - (math.ceil((iter_14_3 + var_14_15 % 2) / 2) - math.ceil(var_14_16 / 2)) * var_14_5)
			else
				var_14_19:setPositionY(100 + var_14_18 / 2 - var_14_16 % 2 * 100 - (math.ceil((iter_14_3 + var_14_15 % 2) / 2) - math.ceil(var_14_16 / 2)) * var_14_5)
			end
		end
	else
		local var_14_20 = 123.6 * GameDisplay:getRelativeScale()

		if var_14_3 * var_14_16 > GameDisplay.height * 0.7 then
			var_14_20 = (GameDisplay.height - var_14_3 * 3) / 2

			self.goodsLayer:setAnchorPoint(cc.p(0.5, 0))
			self.goodsLayer:setPositionY(15)
		end

		self.goodsLayer:setBounceEnabled(true)
		self.goodsLayer:setInnerContainerSize(cc.size(var_14_2, var_14_3 * var_14_16))
		self.goodsLayer:setContentSize(cc.size(var_14_2, var_14_3 * 3 + var_14_20))

		local var_14_21 = self.goodsLayer:getContentSize().width
		local var_14_22 = self.goodsLayer:getContentSize().height

		for iter_14_4 = 1, var_14_15 do
			local var_14_23 = self.goodsLayer:getChildByName("item_sp_" .. iter_14_4)

			if var_14_15 % 2 ~= 0 then
				if iter_14_4 == 1 then
					var_14_23:setPositionX(var_14_21 / 2)
				else
					var_14_23:setPositionX(var_14_21 / 2 + ((iter_14_4 - var_14_15 % 2) % 2 - 0.5) * var_14_4)
				end
			else
				var_14_23:setPositionX(var_14_21 / 2 + ((iter_14_4 - var_14_15 % 2) % 2 - 0.5) * var_14_4)
			end

			var_14_23:setPositionY(self.goodsLayer:getInnerContainerSize().height - 100 - (math.ceil((iter_14_4 + var_14_15 % 2) / 2) - 1) * 200)
		end
	end

	self:upDateUIPosition(var_14_3 * var_14_16)
	self.goodsLayer:setOpacity(0)
	self.goodsLayer:setScaleX(0.1)
	self.goodsLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.25), cc.ScaleTo:create(var_0_15, 1, 1)))
	self.goodsLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.25), cc.FadeIn:create(var_0_15)))

	for iter_14_5, iter_14_6 in pairs(self.goodsData) do
		if type(iter_14_6.itemtype) == "number" and item_data[iter_14_6.itemtype] and item_data[iter_14_6.itemtype].bag_item_type == kITEM_CHOOSE_GIFT and item_data[iter_14_6.itemtype].is_auto_usechoosegiftlayer == 1 or iter_14_6.entityid and item_data[iter_14_6.entityid] and item_data[iter_14_6.entityid].bag_item_type == kITEM_CHOOSE_GIFT and item_data[iter_14_6.entityid].is_auto_usechoosegiftlayer == 1 then
			local var_14_24 = cc.Node:create()

			var_14_24:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function(...)
				local var_16_0 = {}

				var_16_0.itemid = iter_14_6.itemtype or iter_14_6.entityid

				LayerManager:pushInLayer("PopOpenChoosegiftLayer", var_16_0)
			end)))
			self:addChild(var_14_24)

			break
		end
	end

	if self.goodsData and not next(self.goodsData) then
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
			self:exit()
		end)))
	end
end

function PopPurchaseResultLayer:upDateUIPosition(arg_18_1)
	local var_18_0 = self.rootLayer:getChildByName("open_type_img")

	if self.goodsLayer:getChildByName("item_sp_1") then
		if arg_18_1 <= GameDisplay.height * 0.7 then
			var_18_0:setPositionY(self.rootLayer:getContentSize().height / 2 + self.goodsLayer:getContentSize().height / 2 + 70)
		else
			var_18_0:setPositionY(self.goodsLayer:getContentSize().height + 70)
		end
	end
end

function PopPurchaseResultLayer:ifGetGoodsDataNothing()
	if not self.initConfig and not next(self.initConfig) then
		return
	end

	if self.initConfig.id == 1 then
		global_ShowBlockWords(L_RECHARGE_MONTH_CARD_ADD)
		self:runAction(cc.Sequence:create(cc.DelayTime:create(1.8), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	else
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end
end

function PopPurchaseResultLayer:exit()
	self.goodsLayer:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_15)))
	self.rootpanel:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_15), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

return PopPurchaseResultLayer
