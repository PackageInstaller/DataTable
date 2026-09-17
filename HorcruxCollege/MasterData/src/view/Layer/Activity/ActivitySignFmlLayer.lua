require("view.Layer.Pops.PopBaseLayer")

ActivitySignFmlLayer = class("ActivitySignFmlLayer", function()
	return PopBaseLayer:create()
end)

local var_0_1
local TempWidget = require("view/Sprite/TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local activity_sign_data = require("data.activity_sign_data")
local component_manager = require("controller.component_manager")

require("view.Sprite.ItemSprite")

function ActivitySignFmlLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivitySignFmlLayer.new()

	var_2_0:initGaussBg(arg_2_1)

	return var_2_0
end

function ActivitySignFmlLayer:init(arg_3_1)
	self._id = arg_3_1.activityid
	self._exitcallback = arg_3_1.exitcallback
	self._cansign = false

	TextureManager:loadLayerTextures({
		"ActivitySignFmlLayer"
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivitySignFmlLayer.json" or "ActivitySignFmlLayer.ExportJson")

	self.rootLayer:setPositionY(-100)
	self:addChild(self.rootLayer)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.rootpanel:setLocalZOrder(999)
	self:initUI()
	self:initData()

	var_0_1 = self

	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_1 = nil

			TextureManager:removeLayerTextures({
				"ActivitySignFmlLayer"
			})
		elseif arg_4_0 == "enter" then
			-- block empty
		end
	end)
end

function ActivitySignFmlLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self._exitcallback then
			self._exitcallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function ActivitySignFmlLayer:initUI()
	self.rootLayer:setTouchEnabled(true)
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	self.rootpanel:getChildByName("btn_gril"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			cursoul = 203220,
			showtype = 6
		})
	end)
	self.rootpanel:getChildByName("btn_exit"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	self.btnSign = self.rootpanel:getChildByName("btn_sign")

	self.btnSign:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self._cansign then
			if self._signcount == 1 then
				global_ShowBlockWords(L_ACTIVITY_SIGN_FML)
			else
				global_ShowBlockWords(L_BUTTON_TEXT.Got)
			end

			return
		end

		activity_manager:activitySign(self._id, function(arg_12_0)
			if var_0_1 then
				self._cansign = false
				self._signcount = self._signcount + 1

				activity_manager:updateActivityAlert("sign", self._id, false)

				if self._signcount >= 7 then
					activity_manager:update_module_stat(self._id, "sign", true)
				end

				self:updateUI()
			end
		end)
	end)
	self.showActions.extendVertical(self)
end

function ActivitySignFmlLayer:initData()
	activity_manager:getActivitySign(self._id, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		if var_0_1 then
			if arg_14_0 ~= 1 then
				return
			end

			self._cansign = arg_14_2
			self._signcount = arg_14_4

			self:updateUI()
		end
	end)
end

function ActivitySignFmlLayer:updateUI()
	if self._cansign then
		self.btnSign:loadTextures("ActivitySignFmlLayer/btn_sign_on.png", nil, "ActivitySignFmlLayer/btn_sign_on.png", var_0_3)
	else
		self.btnSign:loadTextures("ActivitySignFmlLayer/btn_sign_off.png", nil, "ActivitySignFmlLayer/btn_sign_off.png", var_0_3)
	end

	self:updateListView()
end

function ActivitySignFmlLayer:updateListView()
	for iter_16_0 = 1, 7 do
		local var_16_0 = self.rootpanel:getChildByName("items_bg_" .. iter_16_0)

		var_16_0:getChildByName("got"):setVisible(iter_16_0 <= self._signcount)

		local var_16_1 = drop_manager:getAllDrops(activity_sign_data["2-" .. iter_16_0].dropid)

		for iter_16_1 = 1, #var_16_1 do
			local var_16_2 = var_16_0:getChildByName("item_" .. iter_16_1)

			if var_16_2 then
				local var_16_3 = var_16_2:getChildByName("clip")
				local var_16_4 = var_16_3:getChildByName("item")
				local var_16_5 = var_16_2:getChildByName("num")
				local var_16_6 = var_16_2:getChildByName("quality")

				var_16_6:setLocalZOrder(100)
				var_16_6:setScale(1.7)
				var_16_6:loadTexture("public/rarity/sp_font.png", var_0_3)
				var_16_2:loadTexture("public/box/new_item_bg" .. item_data[var_16_1[iter_16_1].dropid].equip_quality .. ".png", var_0_3)
				var_16_4:setScale(1)
				var_16_5:setString("X" .. var_16_1[iter_16_1].dropNum)

				if item_data[var_16_1[iter_16_1].dropid].bag_item_type == kITEM_HORCRUX then
					var_16_4:loadTexture("equipment/" .. (item_data[var_16_1[iter_16_1].dropid].image_id or "") .. ".png")
					var_16_4:setScale(0.8)
					var_16_6:setVisible(true)

					for iter_16_2, iter_16_3 in var_16_1[iter_16_1].item_attr:gmatch("([^&]+)=([^&]+)") do
						if iter_16_2 == "star" then
							for iter_16_4 = 1, tonumber(iter_16_3) do
								local var_16_7

								if config._DEBUG then
									var_16_7 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
								end

								local var_16_8 = 16

								var_16_7:setScale(0.8)
								var_16_7:setPosition(var_16_8, (iter_16_4 - 1) * 21 + 20)
								var_16_3:addChild(var_16_7)
							end
						end
					end
				elseif item_data[var_16_1[iter_16_1].dropid].bag_item_type == kITEM_COMPONENT then
					local var_16_9 = component_manager:create_component_icon(var_16_1[iter_16_1].dropid)

					var_16_9:setPosition(cc.p(90, 150))
					var_16_2:addChild(var_16_9)
					var_16_4:setVisible(false)
					var_16_4:setScale(0.8)
				elseif item_data[var_16_1[iter_16_1].dropid].bag_item_type == kITEM_EQUIPMENT then
					var_16_4:setScale(0.8)
					var_16_4:loadTexture("equipment/" .. (item_data[var_16_1[iter_16_1].dropid].image_id or "") .. ".png")
				elseif item_data[var_16_1[iter_16_1].dropid].bag_item_type == kITEM_HERO then
					var_16_6:setVisible(true)
					var_16_4:loadTexture("equipment/" .. (item_data[var_16_1[iter_16_1].dropid].image_id or "") .. ".png")
				else
					var_16_4:loadTexture("equipment/" .. (item_data[var_16_1[iter_16_1].dropid].image_id or "") .. ".png")
				end

				var_16_3:addTouchEventListener(function(arg_17_0, arg_17_1)
					if arg_17_1 ~= ccui.TouchEventType.ended then
						return
					end

					LayerManager:pushInLayer("PopItemLayer", {
						itemid = var_16_1[iter_16_1].dropid
					})
				end)
			end
		end
	end
end
