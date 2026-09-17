AssetsScene = class("AssetsScene", function()
	return cc.Scene:create()
end)

function AssetsScene:getBG()
	local assets_ui_manager = require("controller.assets_ui_manager")

	if #self.showBgT >= #(assets_ui_manager:getBirthDayBGList() or {
		"mainScenebg/updateload/1.jpg",
		"mainScenebg/updateload/3.jpg"
	}) then
		self.showBgIndex = self.showBgIndex >= #self.showBgT and 1 or self.showBgIndex + 1
	else
		local var_2_1 = assets_ui_manager:getBG()
		local var_2_2 = false

		for iter_2_0, iter_2_1 in pairs(self.showBgT) do
			if iter_2_1 == var_2_1 then
				var_2_2 = true
				self.showBgIndex = iter_2_0

				break
			end
		end

		if not var_2_2 then
			table.insert(self.showBgT, var_2_1)

			self.showBgIndex = #self.showBgT
		end
	end

	return self.showBgT[self.showBgIndex]
end

function AssetsScene.getTipsInfo(arg_3_0)
	return require("controller.assets_ui_manager"):getTipsInfo() or {
		{
			content = "",
			title = ""
		}
	}
end

function AssetsScene.createScene(arg_4_0)
	local var_4_0 = AssetsScene.new()

	var_4_0:init()
	var_4_0:setName("AssetsScene")

	return var_4_0
end

function AssetsScene.initKeyEvent(arg_5_0)
	return
end

function AssetsScene.onEnterForeground(arg_6_0, arg_6_1)
	return
end

function AssetsScene.onEnterBackground(arg_7_0)
	return
end

function AssetsScene.logout(arg_8_0)
	return
end

function AssetsScene:init()
	self.showBgT = {}
	self.showBgIndex = 0
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setPosition(cc.p(GameDisplay.fix_x, 0))
	self:addChild(self.rootLayer)

	local var_9_0 = self:getBG()
	local var_9_1 = ccui.ImageView:create(var_9_0, 0)

	var_9_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_9_1:setTouchEnabled(true)
	var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.changeBg:loadTexture((self:getBG()))
		self.changeBg:stopAllActions()
		self.changeBg:setVisible(true)
		self.changeBg:setTouchEnabled(false)
		self.changeBg:setOpacity(0)
		self.bg:stopAllActions()
		self.bg:setOpacity(255)
		self.bg:setTouchEnabled(false)
		self.bg:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.Hide:create()))
		self.changeBg:runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(function()
			self.changeBg:setTouchEnabled(true)
		end)))
		self:updateTipsLayout()
	end)

	self.bg = var_9_1

	self.rootLayer:addChild(var_9_1)

	local var_9_2 = ccui.ImageView:create(var_9_0, 0)

	var_9_2:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_9_2:setVisible(false)
	var_9_2:setTouchEnabled(true)
	var_9_2:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.bg:loadTexture((self:getBG()))
		self.bg:stopAllActions()
		self.bg:setVisible(true)
		self.bg:setTouchEnabled(false)
		self.bg:setOpacity(0)
		self.changeBg:stopAllActions()
		self.changeBg:setOpacity(255)
		self.changeBg:setTouchEnabled(false)
		self.changeBg:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.Hide:create()))
		self.bg:runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(function()
			self.bg:setTouchEnabled(true)
		end)))
		self:updateTipsLayout()
	end)

	self.changeBg = var_9_2

	self.rootLayer:addChild(var_9_2)

	local var_9_3 = cc.Label:createWithTTF(string.format("版本: %s", config.version), "fonts/number.ttf", 20)

	var_9_3:setAnchorPoint(cc.p(1, 1))
	var_9_3:setPosition(cc.p(config._DESIGN_WIDTH - 10, GameDisplay.height - 10))
	self.rootLayer:addChild(var_9_3, 2)

	local var_9_4 = 0
	local var_9_5 = ccui.ImageView:create("mainScenebg/login/logo.png")

	var_9_5:setPosition(cc.p(var_9_5:getContentSize().width / 2 + 10, GameDisplay.height - var_9_5:getContentSize().height / 2 - 10))
	var_9_5:setTouchEnabled(true)
	self:addChild(var_9_5, 2)
	var_9_5:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_9_4 = var_9_4 + 1

		if var_9_4 > 8 then
			LOGIN_DEBUG_URL = "http://192.168.9.252:50002"
		end

		print(var_9_4, LOGIN_DEBUG_URL)
	end)
	self:initTipsLayout()

	self.workLayer = nil

	self:checkPermissions()
end

function AssetsScene:checkPermissions()
	if config.packagechannel == "palmpi" then
		self:checkGameVersion()
	elseif DeviceManager.getPackageChannel() == "FY" then
		FeiyuManager.registerPrivacyHandler(function(arg_16_0, arg_16_1)
			print("Feiyu Privacy Callback: ", arg_16_0, arg_16_1)

			if arg_16_0 == 1 then
				self:checkGameVersion()
			elseif DeviceManager.getChannelID() == "270057" then
				cc.Director:getInstance():endToLua()
			else
				self:showPrivacyButton()
			end
		end)
		FeiyuManager.checkPrivacy()
	elseif cc.UserDefault:getInstance():getBoolForKey("agreeprivacy", false) then
		self:initSDK()
		self:initTapOaidSDK()
	else
		self:showPrivacyPanel()
	end
end

function AssetsScene:showPrivacyPanel()
	local var_17_0 = require("view.Layer.PrivacyLayer"):create()

	var_17_0:registerAgreeHandler(function()
		self:initSDK()
		self:initTapOaidSDK()
	end)
	var_17_0:registerRefuseHandler(function()
		if DeviceManager.getChannelID() == "270057" or DeviceManager.getChannelID() == "270055" then
			cc.Director:getInstance():endToLua()
		else
			global_restart_game()
		end
	end)
	self:addChild(var_17_0, 999)
end

function AssetsScene:initTipsLayout()
	local var_20_0 = ccui.Layout:create()

	self.rootLayer:addChild(var_20_0)
	var_20_0:setLocalZOrder(5)
	var_20_0:setContentSize(cc.size(GameDisplay.width, 100))
	var_20_0:setAnchorPoint(cc.p(0, 1))
	var_20_0:setPosition(cc.p(0, 196))

	local var_20_1 = cc.Label:createWithTTF("", "fonts/W5.ttf", 26)

	var_20_0:addChild(var_20_1)
	var_20_1:setAnchorPoint(cc.p(0, 1))
	var_20_1:setPosition(cc.p(50, var_20_0:getContentSize().height - 20))

	self.tipsTitle = var_20_1

	local var_20_2 = cc.Label:createWithTTF("", "fonts/W5.ttf", 20)

	var_20_0:addChild(var_20_2)
	var_20_2:setAnchorPoint(cc.p(0, 1))
	var_20_2:setPosition(cc.p(75, var_20_0:getContentSize().height - 60))
	var_20_2:setMaxLineWidth(GameDisplay.width - var_20_2:getPositionX() * 2)

	self.tipsContent = var_20_2

	local var_20_3 = ccui.ImageView:create("update/exchange.png", 0)

	var_20_0:addChild(var_20_3)
	var_20_3:setAnchorPoint(cc.p(1, 0.5))
	var_20_3:setPosition(cc.p(var_20_0:getContentSize().width, var_20_0:getContentSize().height / 2 + 20))
	self:updateTipsLayout()
end

function AssetsScene:updateTipsLayout()
	local var_21_0 = self:getTipsInfo()

	self.tipsTitle:setString(var_21_0.title)
	self.tipsContent:setString(var_21_0.content)
end

function AssetsScene:initSDK()
	if umeng_initWhenConsentProtocol then
		umeng_initWhenConsentProtocol()
	end

	local var_22_0 = DeviceManager.getPackageChannel()

	print("packagechannel:", var_22_0)

	local function var_22_1(arg_23_0, arg_23_1)
		print("Init Callback: ", arg_23_0, arg_23_1)

		if arg_23_0 ~= 0 then
			return
		end

		if buglyInitCrashReport then
			buglyInitCrashReport()
		end

		self:checkGameVersion()
	end

	if var_22_0 == "FY" then
		self:checkGameVersion()
	else
		if SDKManager.registerInitHandler then
			SDKManager.registerInitHandler(var_22_1)
		end

		SDKManager.initSdk(var_22_1)
	end
end

function AssetsScene:checkGameVersion()
	self.workLayer = require("view.Layer.UpdateLayer"):create(function()
		self:loadGameResource()
	end)

	self.rootLayer:addChild(self.workLayer, 2)
	self.workLayer:setOpacity(0)
	self.workLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.1), cc.CallFunc:create(function()
		self.workLayer:checkGameAssets()
	end)))
end

function AssetsScene:loadGameResource()
	if self.workLayer then
		self.workLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
	end

	self.workLayer = require("view.Layer.AssetsLayer"):create(function()
		require("view.Scene.LoginScene")
		cc.Director:getInstance():replaceScene(LoginScene:createScene())
		require("controller.updatemodule.assets_manager"):pushThinkingDataCilent("finish_download")
	end)

	self.rootLayer:addChild(self.workLayer, 2)
	self.workLayer:setOpacity(0)
	self.workLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0.2), cc.CallFunc:create(function()
		self.workLayer:startLoading()
	end)))
end

function AssetsScene:showPrivacyButton()
	if not self.privacyBtn then
		self:createPrivacyButton()
	end

	self.privacyBtn:setVisible(true)
end

function AssetsScene:createPrivacyButton()
	local var_31_0 = ccui.Button:create("update/btn_privacy.png", "update/btn_privacy.png", "update/btn_privacy.png")

	var_31_0:setAnchorPoint(cc.p(1, 0.5))
	var_31_0:setPosition(cc.p(630, GameDisplay.height - 90))
	self:addChild(var_31_0, 10)
	var_31_0:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkPermissions()
	end)

	self.privacyBtn = var_31_0
end

function AssetsScene.initTapOaidSDK(arg_33_0)
	if DeviceManager.platform == "ios" then
		return
	end

	if DeviceManager.getChannelID() == "270049" and cc.Native.initTapOaidSDK then
		cc.Native:initTapOaidSDK()
	end
end
