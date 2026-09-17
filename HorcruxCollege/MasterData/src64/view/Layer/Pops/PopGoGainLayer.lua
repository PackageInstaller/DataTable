PopGoGainLayer = class("PopGoGainLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local component_manager = require("controller.component_manager")
local audio_manager = require("controller.audio_manager")
local sign_manager = require("controller.sign_manager")
local shop_currency_data = require("data.shop_currency_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local arenatft_manager = require("controller.arenatft_manager")
local community_system_manager = require("controller.community_system_manager")

function PopGoGainLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGoGainLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopGoGainLayer:init(arg_3_1)
	self.msg = arg_3_1 or {}
	self.msg.methods = self.msg.methods or {}

	self:initGoConfig()

	if self.msg.methods and next(self.msg.methods) ~= nil then
		self:initUI()
		self:registerExitEvent()
		self:initItem()
		self:initList()
	else
		global_ShowBlockWords(L_NO_WAY_GET)
		audio_manager:playeffectMusicTest("sound/invalid")
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))

		return
	end
end

function PopGoGainLayer:initGoConfig()
	local function var_5_0(arg_6_0, arg_6_1)
		if not item_data[arg_6_0]["targetactivity" .. arg_6_1] then
			if item_data[arg_6_0]["targetlayer_starttime_" .. arg_6_1] and time_check_manager:getCurTime() < os.time(parse_time(item_data[arg_6_0]["targetlayer_starttime_" .. arg_6_1])) then
				return false
			end

			if item_data[arg_6_0]["targetlayer_finishtime_" .. arg_6_1] and os.time(parse_time(item_data[arg_6_0]["targetlayer_finishtime_" .. arg_6_1])) < time_check_manager:getCurTime() then
				return false
			end

			return true
		else
			local var_6_0 = activity_manager:getActivityObj(tonumber(item_data[arg_6_0]["targetactivity" .. arg_6_1]))

			if not var_6_0 then
				return false
			elseif var_6_0:getStatus() ~= 2 then
				return false
			else
				return true
			end
		end

		return true
	end

	if self.msg.item == "gold" then
		self.msg.methods = {
			{
				systemid = 111,
				des = L_GO_CONFIG_DES.midas,
				callback = self.msg.callback
			},
			{
				systemid = 201,
				des = L_GO_CONFIG_DES.quick_find
			},
			{
				systemid = 154,
				des = L_GO_CONFIG_DES.recycle_shop
			},
			{
				systemid = 500,
				des = L_GO_CONFIG_DES.sell
			}
		}
		self.msg.itemName = L_GOLD
	elseif self.msg.item == "horcrux" then
		self.msg.methods = {
			{
				systemid = 180,
				des = L_GO_CONFIG_DES.twist
			},
			{
				systemid = 502,
				des = L_GO_CONFIG_DES.horcrux_compound
			}
		}
		self.msg.itemName = L_PLAYER_DATA_TYPE.Horcrux
	else
		local var_5_1 = 1

		while item_data[self.msg.item]["targetdes" .. var_5_1] do
			var_5_1 = var_5_1 + 1
		end

		for iter_5_0 = 1, var_5_1 - 1 do
			if var_5_0(self.msg.item, iter_5_0) then
				if type(item_data[self.msg.item]["targetlayer" .. iter_5_0]) == "string" and item_data[self.msg.item]["targetlayer" .. iter_5_0]:find("^http") then
					table.insert(self.msg.methods, {
						des = item_data[self.msg.item]["targetdes" .. iter_5_0],
						url = item_data[self.msg.item]["targetlayer" .. iter_5_0]
					})
				elseif SYSTEMID[item_data[self.msg.item]["targetlayer" .. iter_5_0]] == "InstanceLayer" or SYSTEMID[item_data[self.msg.item]["targetlayer" .. iter_5_0]] == "MarketLayer" then
					print("ITEMS_TARGETTYPE[materialType]", ITEMS_TARGETTYPE[materialType])
					table.insert(self.msg.methods, {
						des = item_data[self.msg.item]["targetdes" .. iter_5_0],
						targetlayer = SYSTEMID[item_data[self.msg.item]["targetlayer" .. iter_5_0]],
						targettype = ITEMS_TARGETTYPE[materialType],
						returnlayer = self.msg.returnlayer,
						systemid = item_data[self.msg.item]["targetlayer" .. iter_5_0]
					})
				elseif item_data[self.msg.item]["targetdes" .. iter_5_0] and item_data[self.msg.item]["targetlayer" .. iter_5_0] then
					table.insert(self.msg.methods, {
						des = item_data[self.msg.item]["targetdes" .. iter_5_0],
						targetlayer = SYSTEMID[item_data[self.msg.item]["targetlayer" .. iter_5_0]],
						systemid = item_data[self.msg.item]["targetlayer" .. iter_5_0]
					})
				end
			end
		end
	end
end

function PopGoGainLayer:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Go_Gain.json" or "Go_Gain.ExportJson")

	self:addChild(self.rootLayer)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_back")
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "title")
	self.item = ccui.Helper:seekWidgetByName(self.rootLayer, "img_item")
	self.item_name = ccui.Helper:seekWidgetByName(self.rootLayer, "label_name")
	self.listview = ccui.Helper:seekWidgetByName(self.rootLayer, "listview")
	self.button_go = ccui.Helper:seekWidgetByName(self.rootLayer, "button_go")

	self.button_go:retain()
	self.button_go:removeFromParent()
	self.listview:setPositionX(5)
	self.listview:setItemsMargin(18)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(GameDisplay.width / 2, GameDisplay.height / 2)
	self.showActions.extendVertical(self)
end

function PopGoGainLayer:registerExitEvent()
	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.msg.cancelcallback then
			self.msg.cancelcallback()
		end

		if self.button_go then
			self.button_go:release()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopGoGainLayer:initItem()
	local var_10_0 = self.item
	local var_10_1
	local var_10_2
	local var_10_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_back")

	if not self.msg.item and not config._DEBUG then
		self.msg.item = 1000000

		print("msg.item is nil")
	end

	if self.msg.item == "gold" then
		var_10_0:loadTexture("equipment/1000001.png")
		var_10_0:setScale(128 / var_10_0:getContentSize().width)
	elseif self.msg.item == "horcrux" then
		var_10_0:loadTexture("roleimage/role1/51305.png")
		var_10_0:setScale(220 / var_10_0:getContentSize().width)

		var_10_1 = cc.p(255, 255)
		var_10_2 = cc.p(0.5, 0)
	elseif item_data[self.msg.item].bag_item_type == kITEM_HORCRUX then
		var_10_0:loadTexture("roleimage/role1/" .. model_data[item_data[self.msg.item].model].cute_Q .. ".png")
		var_10_0:setScale(220 / var_10_0:getContentSize().width)

		var_10_1 = cc.p(255, 375)
		var_10_2 = cc.p(0.5, 0.5)
	elseif item_data[self.msg.item].bag_item_type == kITEM_SKIN then
		var_10_0:loadTexture("roleimage/role/wuji/" .. model_data[item_data[self.msg.item].model].head_image .. ".png")
		var_10_0:setScale(256 / var_10_0:getContentSize().width)
	elseif item_data[self.msg.item].bag_item_type == kITEM_HERO then
		var_10_0:loadTexture("roleimage/role/wuji/" .. model_data[servant_data[item_data[self.msg.item].servant].modelid].head_image .. ".png")
		var_10_0:setScale(256 / var_10_0:getContentSize().width)
	elseif item_data[self.msg.item].bag_item_type == kITEM_COMPONENT then
		var_10_0:setVisible(false)

		local var_10_4 = component_manager:create_component_icon(self.msg.item)

		var_10_4:setPosition(cc.p(var_10_0:getPositionX(), (var_10_0:getPositionY())))
		var_10_3:getChildByName("bg"):addChild(var_10_4)
	elseif item_data[self.msg.item].bag_item_type == 91 then
		local var_10_5 = ItemSprite:createNewWithItemId(self.msg.item, nil, "diamond")

		var_10_5:setScale(0.5)
		var_10_5:setPosition(cc.p(var_10_0:getPositionX(), var_10_0:getPositionY()))
		var_10_0:setVisible(false)
		var_10_3:getChildByName("bg"):addChild(var_10_5)
	elseif item_data[self.msg.item].bag_item_type == kITEM_WEAPON then
		print("itemData[msg.item].id =", self.msg.item)
		var_10_0:loadTexture("equipment/" .. item_data[self.msg.item].image_id .. ".png")
		var_10_0:setScale(156 / var_10_0:getContentSize().width)
	elseif item_data[self.msg.item].bag_item_type == kITEM_SCULTURE then
		var_10_0:loadTexture("roleimage/role/wuji/" .. item_data[self.msg.item].image_id .. ".png")
		var_10_0:setScale(256 / var_10_0:getContentSize().width)
	elseif item_data[self.msg.item].bag_item_type == KITEM_SPRING_FESTIVAL_WORD and item_data[self.msg.item].word_bg then
		local var_10_6 = ItemSprite:createNewWithItemId(self.msg.item, nil, "withoutBox")

		var_10_6:setPosition(cc.p(var_10_0:getPositionX(), var_10_0:getPositionY() - 20))
		var_10_0:setVisible(false)
		var_10_3:getChildByName("bg"):addChild(var_10_6)
	else
		print("itemData[msg.item].id =", self.msg.item)
		var_10_0:loadTexture("equipment/" .. item_data[self.msg.item].image_id .. ".png")
		var_10_0:setScale(128 / var_10_0:getContentSize().width)
	end

	if var_10_2 then
		var_10_0:setAnchorPoint(var_10_2)
	end

	if var_10_1 then
		var_10_0:setPosition(var_10_1)
	end

	self.item_name:setString(self.msg.itemName or item_data[self.msg.item].name)

	if self.msg.labels and self.msg.labels.title then
		title:setString(self.msg.labels.title)
	end
end

function PopGoGainLayer:initList()
	local var_11_0 = self.msg
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(self.msg.methods) do
		var_11_1[iter_11_0] = self.button_go:clone()

		self.listview:pushBackCustomItem(var_11_1[iter_11_0])
		var_11_1[iter_11_0]:getChildByName("label_method"):setString(iter_11_1.des)
		var_11_1[iter_11_0]:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_12_0:getTouchBeganPosition().y - arg_12_0:getTouchEndPosition().y) > 50 then
				return
			end

			arg_12_0:setTouchEnabled(false)

			if arenatft_manager:getLayerBtnLock() then
				global_ShowBlockWords(L_TVT_FIGHT_BTN_LOCK)

				return
			end

			LayerManager:removePopLayer(self.__queueindex)

			if var_11_0.surecallback then
				var_11_0.surecallback(iter_11_1.targetlayer)
			end

			if iter_11_1.url then
				DeviceManager.openURL(iter_11_1.url)
			elseif iter_11_1.shopPopFunc then
				LayerManager:removePopLayer(self.__queueindex)
				iter_11_1.shopPopFunc()

				return
			elseif iter_11_1.targetlayer == "ShareLayer" then
				global_ShowBlockWords(L_POPGOGAIN_SYSTEM_CLOSE.ShareLayer)
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				local var_12_0 = cc.EventCustom:new("switchShowLayer")

				if iter_11_1.targetlayer == "CommandLayer" or iter_11_1.targetlayer == "SmeltLayer" or iter_11_1.targetlayer == "CompoundLabLayer" then
					var_12_0.layerName = "LabLayer"

					require("view.Layer.LabLayer")
					LabLayer:setSwitchLabType(iter_11_1.targetlayer)
				else
					var_12_0.layerName = iter_11_1.targetlayer
				end

				if iter_11_1.targettype then
					local var_12_1

					if iter_11_1.targetlayer == "MarketLayer" then
						var_12_1 = {
							shoptype = iter_11_1.targettype,
							returnLayer = iter_11_1.returnlayer
						}
					elseif iter_11_1.targetlayer == "InstanceLayer" then
						global_ShowBlockWords(L_POPGOGAIN_SYSTEM_CLOSE.InstanceLayer)
						audio_manager:playeffectMusicTest("sound/invalid")

						return
					end

					var_12_0.initparam = var_12_1
				end

				require("controller.goto_system_manager")

				systemId = type(iter_11_1.systemid) == "string" and (iter_11_1.systemid:find("@") and iter_11_1.systemid or tonumber(iter_11_1.systemid)) or iter_11_1.systemid

				if systemId == 130 then
					LayerManager:pushInLayer("SignLayerNew")
				elseif systemId == 111 then
					LayerManager:pushInLayer("HandOfMidasLayer", {
						callback = iter_11_1.callback
					})
				elseif systemId == 123000 then
					if community_system_manager:getCurfamilyid() then
						local var_12_2 = cc.EventCustom:new("switchShowLayer")

						var_12_2.layerName = "MarketLayer"
						var_12_2.initparam = {
							returnLayer = "MainLayer",
							singleMarket = {
								"1-123000"
							}
						}

						cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_12_2)
					else
						global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
					end
				elseif systemId == 3051 then
					if community_system_manager:getCurfamilyid() then
						LayerManager:switchShowLayer("CommunityTaskShowLayer")
					else
						global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
					end
				else
					local var_12_3 = {
						jump_to_system = systemId,
						cur_system_id = var_11_0.goto_back_system_id
					}

					var_12_3.config = system_jump_config[SYSTEMID[systemId]] and system_jump_config[SYSTEMID[systemId]].config

					if var_12_0.initparam then
						var_12_3.config = var_12_0.initparam
					end

					if var_11_0.goto_back_system_id and var_12_3.config and (not system_jump_config[SYSTEMID[var_11_0.goto_back_system_id]] or not system_jump_config[SYSTEMID[var_11_0.goto_back_system_id]].popLayer) then
						if var_12_3.config.exitCallbackType == "function" then
							var_12_3.config.exitCallback = createExitCallback({
								jump_to_system = var_11_0.goto_back_system_id,
								cur_system_id = var_11_0.goto_back_system_id,
								config = var_11_0.goto_back_system_config
							})
						end

						if var_12_3.config.exitCallbackType == "string" then
							var_12_3.config = SYSTEMID[var_11_0.goto_back_system_id]
						end
					end

					if system_jump_config[SYSTEMID[systemId]] and system_jump_config[SYSTEMID[systemId]].layerName == "MarketLayer" then
						local var_12_4 = cc.EventCustom:new("switchShowLayer")

						var_12_4.layerName = "MarketLayer"
						var_12_4.initparam = {
							singleMarket = system_jump_config[SYSTEMID[systemId]].config.singleMarket,
							itemid = var_11_0.item
						}

						cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_12_4)
					else
						print(dump(var_12_3))
						goto_complete_system(var_12_3)
					end

					if type(systemId) == "number" and systemId >= 1500 and systemId <= 1599 then
						local var_12_5 = cc.EventCustom:new("switchLeftBtn")

						var_12_5.name = shop_currency_data[systemId % 1500].shop_type

						cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_12_5)
					end
				end
			end
		end)
	end
end

function PopGoGainLayer:exit()
	if self.msg.cancelcallback then
		self.msg.cancelcallback()
	end

	if self.button_go then
		self.button_go:release()
	end

	LayerManager:removePopLayer(self.__queueindex)
end
