local UpdateLayer = class("UpdateLayer", function()
	return cc.Layer:create()
end)
local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = string.format
local assets_manager = require("controller.updatemodule.assets_manager")
local assets_ui_manager = require("controller.assets_ui_manager")
local var_0_5 = 1048576
local var_0_6 = {
	bar = "update/upgrade.png",
	dialogbox = "update/box.png",
	loadsp = "update/sp.png",
	surebtnoff = "update/button_off.png",
	bg = "mainScenebg/loginBG.jpg",
	loadingbg = "update/load.png",
	surebtnpressed = "update/button_on.png",
	surebtnnormal = "update/button.png",
	barbg = "update/upgrade_background.png"
}

function UpdateLayer:create(arg_2_1)
	local var_2_0 = UpdateLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function UpdateLayer:init(arg_3_1)
	assets_manager:onEnter(self)

	self.updatehandler = arg_3_1

	self:initUpdateBar()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			assets_manager:onExit()
		end
	end)
end

function UpdateLayer:initUpdateBar()
	local var_5_0 = cc.Sprite:create(var_0_6.loadingbg)

	var_5_0:setAnchorPoint(cc.p(0.5, 0))
	var_5_0:setPosition(cc.p(320, 0))
	self:addChild(var_5_0, 1)

	self.barbg = TempWidget:CreateTempLayout()

	self.barbg:setAnchorPoint(cc.p(0.5, 0))
	self.barbg:setContentSize(cc.size(GameDisplay.width, 14))
	self.barbg:setPosition(cc.p(var_5_0:getContentSize().width / 2, var_5_0:getContentSize().height - 5))
	var_5_0:addChild(self.barbg, 1)

	self.bar = cc.ProgressTimer:create(cc.Sprite:create(var_0_6.bar))

	self.bar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar:setBarChangeRate(cc.p(1, 0))
	self.bar:setMidpoint(cc.p(0, 0))
	self.bar:setAnchorPoint(cc.p(0.5, 0.5))
	self.bar:setPosition(cc.p(self.barbg:getContentSize().width / 2, self.barbg:getContentSize().height / 2))
	self.barbg:addChild(self.bar, 2)
	self.bar:setPercentage(0)

	self.loadSp = cc.Sprite:create(var_0_6.loadsp)

	self.loadSp:setPosition(cc.p(self.barbg:getContentSize().width * 0 / 100, self.barbg:getContentSize().height / 2))
	self.barbg:addChild(self.loadSp, 3)

	self.updateInfo = cc.Label:createWithTTF("正在检查游戏版本...", "fonts/number.ttf", 18)

	self.updateInfo:setAnchorPoint(cc.p(0.5, 0))
	self.updateInfo:setPosition(cc.p(var_5_0:getContentSize().width / 2, 18))
	var_5_0:addChild(self.updateInfo, 3)

	local var_5_1 = assets_ui_manager:getLoadAni()

	self.ani = sp.SkeletonAnimation:create(var_5_1 .. ".json", var_5_1 .. ".atlas", 1)

	self.ani:setPosition(cc.p(self.barbg:getContentSize().width * 0 / 100, self.barbg:getContentSize().height))
	self.barbg:addChild(self.ani, 4)
	self.ani:setAnimation(0, "run", true)
end

function UpdateLayer:checkGameAssets()
	assets_manager:checkUpdate()
end

function UpdateLayer:onNoNewVersion()
	self.updateInfo:setString("游戏已是最新版本")
	self.bar:setPercentage(100)
	self.updatehandler()
end

function UpdateLayer:onNeedUpdate(arg_8_1)
	arg_8_1 = arg_8_1 or 0

	assets_manager:initDownload()

	if arg_8_1 <= 10 * var_0_5 then
		assets_manager:update()
	else
		local var_8_0 = 1

		if DeviceManager.platform ~= "windows" then
			var_8_0 = DeviceManager.getInternetConnectionStatus()
		end

		local var_8_1 = cc.Layer:create()

		self:addChild(var_8_1, 5)

		local var_8_2 = cc.Sprite:create(var_0_6.dialogbox)

		var_8_2:setPosition(cc.p(320, 635))
		var_8_1:addChild(var_8_2)

		local var_8_3 = cc.Label:createWithTTF("下载更新", "fonts/name.ttf", 28)

		var_8_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_3:setPosition(cc.p(320, 680))
		var_8_3:setColor(cc.c3b(182, 189, 203))
		var_8_1:addChild(var_8_3, 1)

		local var_8_4 = cc.Label:createWithTTF("", "fonts/number.ttf", 24)

		var_8_4:setString(string.format("有更新可下载(共计%dMB), %s", math.floor(arg_8_1 / var_0_5), ({
			[cc.kCCNetworkStatusNotReachable] = "当前无网络连接",
			[cc.kCCNetworkStatusReachableViaWiFi] = "当前使用WIFI连接",
			[cc.kCCNetworkStatusReachableViaWWAN] = "当前使用移动数据网络"
		})[var_8_0]))
		var_8_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_4:setPosition(cc.p(320, 630))
		var_8_4:setColor(cc.c3b(18, 19, 26))
		var_8_4:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_8_1:addChild(var_8_4, 5)

		local var_8_5 = ccui.Button:create(var_0_6.surebtnnormal, nil, var_0_6.surebtnoff)

		var_8_5:setPosition(cc.p(320, 520))
		var_8_1:addChild(var_8_5, 6)
		var_8_5:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_9_0:isBright() then
				return
			end

			arg_9_0:setBright(false)
			var_8_1:runAction(cc.RemoveSelf:create())
			assets_manager:update()
			assets_manager:pushThinkingDataCilent("start_game_download", {})
		end)
	end
end

function UpdateLayer:onNewClient(arg_10_1)
	arg_10_1 = arg_10_1 and string.urldecode(arg_10_1) or config.downloadurl

	local var_10_0 = cc.Layer:create()

	self:addChild(var_10_0, 5)

	local var_10_1 = cc.Sprite:create(var_0_6.dialogbox)

	var_10_1:setPosition(cc.p(320, 635))
	var_10_0:addChild(var_10_1)

	local var_10_2 = cc.Label:createWithTTF("下载新客户端", "fonts/name.ttf", 28)

	var_10_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_2:setPosition(cc.p(320, 680))
	var_10_2:setColor(cc.c3b(182, 189, 203))
	var_10_0:addChild(var_10_2, 1)

	local var_10_3 = cc.Label:createWithTTF("有新客户端可用，是否前往下载？", "fonts/number.ttf", 24)

	var_10_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_3:setPosition(cc.p(320, 630))
	var_10_3:setColor(cc.c3b(18, 19, 26))
	var_10_3:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_10_0:addChild(var_10_3, 5)

	local var_10_4 = ccui.Button:create(var_0_6.surebtnnormal, nil, var_0_6.surebtnnormal)

	var_10_4:setPosition(cc.p(320, 520))
	var_10_0:addChild(var_10_4, 6)
	var_10_4:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		if DeviceManager.getChannelID() == "270049" and cc.Native:hasInstalledTapTap() then
			DeviceManager.openURL("taptap://taptap.com/app?app_id=42949&source=outer|update")
		else
			DeviceManager.openURL(arg_10_1)
		end
	end)
end

function UpdateLayer:onUpdateError(arg_12_1)
	if arg_12_1 == cc.ASSETSMANAGER_NETWORK then
		self.updateInfo:setString("网络错误")
	elseif arg_12_1 == cc.ASSETSMANAGER_CREATE_FILE then
		self.updateInfo:setString("更新失败")
	elseif arg_12_1 == cc.ASSETSMANAGER_UNCOMPRESS then
		self.updateInfo:setString("解压失败")
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self.updatehandler()
	end)))
end

function UpdateLayer:onUpdateProgress(arg_14_1)
	self.updateInfo:setString(var_0_2("正在下载更新包(%d%%)", arg_14_1))
	self.bar:setPercentage(arg_14_1)
	self.loadSp:setPosition(cc.p(self.barbg:getContentSize().width * arg_14_1 / 100, self.barbg:getContentSize().height / 2))
	self.ani:setPositionX(self.barbg:getContentSize().width * arg_14_1 / 100)
end

function UpdateLayer:onUpdateSuccess()
	self.updateInfo:setString("更新成功!!!")
	self.bar:setPercentage(100)
	self.loadSp:setPosition(cc.p(self.barbg:getContentSize().width, self.barbg:getContentSize().height / 2))

	package.loaded.config = nil
	package.loaded["view.Sprite.TempWidget"] = nil
	package.loaded["controller.GlobalConstantsManager"] = nil
	package.loaded["view.Sprite.NodeEx"] = nil
	package.loaded["data.global_constants_data"] = nil
	package.loaded["controller.base_manager"] = nil

	require("config")
	self.updatehandler()
end

function UpdateLayer:onSystemClose(arg_16_1)
	if arg_16_1.errcode == 1 then
		local var_16_0 = ccui.ImageView:create("update/bg_pop_small.png")

		var_16_0:setPosition(320, GameDisplay.height / 2)
		self:addChild(var_16_0, 999)

		local var_16_1 = cc.Label:createWithTTF(arg_16_1.errmsg, "fonts/number.ttf", 27)

		var_16_1:setPosition(var_16_0:getContentSize().width / 2, var_16_0:getContentSize().height / 2)
		var_16_0:addChild(var_16_1)

		local var_16_2 = ccui.Button:create("update/public_button_orange_long.png", nil, "update/public_button_orange_long.png")

		var_16_2:setPosition(var_16_0:getContentSize().width / 2, -var_16_2:getContentSize().height / 2 - 10)
		var_16_0:addChild(var_16_2)
		var_16_2:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return false
			end

			if DeviceManager.platform ~= "ios" then
				cc.Director:getInstance():endToLua()
			end
		end)

		local var_16_3 = cc.Label:createWithTTF("确 认", "fonts/newkj.ttf", 28)

		var_16_3:setColor(cc.c3b(0, 0, 0))
		var_16_3:setPosition(var_16_2:getContentSize().width / 2 - 5, var_16_2:getContentSize().height / 2 - 5)
		var_16_2:addChild(var_16_3)
	elseif arg_16_1.errcode == 2 then
		local var_16_4 = string.urldecode(arg_16_1.errmsg)

		if DeviceManager.platform == "windows" then
			DeviceManager.openURL(var_16_4)

			return
		end

		local var_16_5 = ccexp.WebView:create()

		var_16_5:setVisible(false)
		var_16_5:setScalesPageToFit(true)
		var_16_5:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_16_5:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
		self:addChild(var_16_5, 999)
		var_16_5:loadURL(var_16_4)
		var_16_5:setName("webLayer")
		var_16_5:setOnDidFinishLoading(function(arg_18_0, arg_18_1)
			arg_18_0:setVisible(true)
		end)

		local var_16_6 = ccui.Layout:create()

		var_16_6:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_16_6:setTouchEnabled(true)
		self:addChild(var_16_6, 998)
	end
end

return UpdateLayer
