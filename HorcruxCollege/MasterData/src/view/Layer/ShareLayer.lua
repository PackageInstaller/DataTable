local playermodel = require("model.playermodel")
local network = require("network.network")

ShareLayer = class("ShareLayer", function()
	return cc.Layer:create()
end)

local var_0_2

function ShareLayer.create(arg_2_0)
	local var_2_0 = ShareLayer.new()

	var_2_0:init()

	return var_2_0
end

function ShareLayer:init()
	var_0_2 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Share.json" or "Share.ExportJson")

	self:addChild(self.rootLayer)

	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_back")

	self.panel:getChildByName("describe"):getChildByName("des1"):setVisible(false)
	self.panel:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())
	end)

	self.getCoin = 0

	self:showlable()
	self:share()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			TextureManager:unregisterTexture("ShareLayer")

			var_0_2 = nil
		end
	end)
end

function ShareLayer:showlable()
	self.mylink = self.panel:getChildByName("mylink")
	self.userurl = "http://h-college.com/share" .. string.sub(tostring(playermodel.playerid), -1, -1) .. "/" .. tostring(playermodel.playerid)

	self.mylink:getChildByName("label_num"):setString(self.userurl)
	network:rpc("get_gameshare_times", nil, function(arg_7_0)
		if not var_0_2 then
			return
		end

		if arg_7_0.result == 1 then
			self.panel:getChildByName("label_num_all"):getChildByName("label_num"):setString(arg_7_0.time)
		else
			self.panel:getChildByName("label_num_all"):getChildByName("label_num"):setString(0)
		end
	end)
end

function ShareLayer:share()
	local function var_8_0(arg_9_0, arg_9_1)
		if arg_9_0 == ShareResultCode.kShareSuccess then
			global_ShowBlockWords(L_SHARE_MSG[1], cc.c3b(255, 0, 0), nil, 3, 0.3, 2)
		elseif arg_9_0 == ShareResultCode.kShareFail then
			global_ShowBlockWords(L_SHARE_MSG[2], cc.c3b(255, 0, 0), nil, 3, 0.3, 2)
		elseif arg_9_0 == ShareResultCode.kShareCancel then
			global_ShowBlockWords(L_SHARE_MSG[3], cc.c3b(255, 0, 0), nil, 3, 0.3, 2)
		elseif arg_9_0 == ShareResultCode.kShareNetworkError then
			global_ShowBlockWords(L_SHARE_MSG[4], cc.c3b(255, 0, 0), nil, 3, 0.3, 2)
		end

		self.rootLayer:runAction(cc.RemoveSelf:create())
	end

	self.panel:getChildByName("button_share"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if DeviceManager.platform == "windows" then
			return
		end

		if DeviceManager.platform == "android" then
			local var_10_0 = TextureManager:createSprite("ShareLayer", "HelloWorld.png")

			var_10_0:setName("Share")

			local var_10_1 = var_10_0:getContentSize()

			var_10_0:setPosition(var_10_1.height / 2, var_10_1.width / 2)

			local var_10_2 = cc.RenderTexture:create(var_10_1.width, var_10_1.height)

			var_10_2:setName("Render")
			var_10_2:setPosition(0, 0)
			var_10_2:beginWithClear(0, 0, 0, 0)
			var_10_0:visit()
			var_10_2:endToLua()
			self:addChild(var_10_0)
			self:addChild(var_10_2)

			local var_10_3 = var_10_2:saveToFile("share.png", cc.IMAGE_FORMAT_PNG)

			self:getChildByName("Share"):runAction(cc.RemoveSelf:create())
			self:getChildByName("Render"):runAction(cc.RemoveSelf:create())

			share_Plugin = AgentManager:getInstance():getSharePlugin()

			share_Plugin:setResultListener(var_8_0)

			local var_10_4 = {
				mediaType = "2",
				shareTo = "1",
				title = L_SHARE_INFO.Title,
				titleUrl = self.userurl,
				site = L_SHARE_INFO.Site,
				siteUrl = self.userurl
			}

			var_10_4.imagePath = cc.FileUtils:getInstance():getWritablePath() .. "/share.png"
			var_10_4.url = self.userurl
			var_10_4.text = L_SHARE_INFO.Text
			var_10_4.comment = L_SHARE_INFO.Comment

			share_Plugin:share(var_10_4)
		end
	end)
end
