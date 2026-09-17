require("view.Layer.Pops.PopBaseLayer")

PopWeixinActivityLayer = class("PopWeixinActivityLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

function PopWeixinActivityLayer.create(arg_2_0)
	local var_2_0 = PopWeixinActivityLayer.new()

	var_2_0:initGaussBg()

	return var_2_0
end

function PopWeixinActivityLayer:init()
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(true)
	self:addChild(self.rootLayer)

	self.rootpanel = ccui.ImageView:create("PopWeixinActivityLayer/bg.png", var_0_0)

	self.rootpanel:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + 100))
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	self:initUI()
end

function PopWeixinActivityLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopWeixinActivityLayer:initUI()
	self.btnGo = ccui.Button:create("PopWeixinActivityLayer/btn_goto.png", nil, "PopWeixinActivityLayer/btn_goto.png", var_0_0)

	self.btnGo:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, -100))
	self.rootpanel:addChild(self.btnGo)
	self.btnGo:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_8_0 = cc.FileUtils:getInstance():fullPathForFilename("mainScenebg/image_weixin_activity.png")

		if DeviceManager.platform == "android" then
			cc.Native:imageWriteToPhotosAlbum(var_8_0, "hcollege_weixin.png")
		elseif DeviceManager.platform == "ios" then
			cc.Native.imageWriteToPhotosAlbum(var_8_0)
		end
	end)

	if not cc.Native.imageWriteToPhotosAlbum then
		self.btnGo:setVisible(false)
	end
end
