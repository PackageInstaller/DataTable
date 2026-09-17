FlashScene = class("FlashScene", function()
	return cc.Scene:create()
end)

local var_0_0 = {
	["4399"] = "mainScenebg/flash_4399.jpg",
	xiaoqi = "mainScenebg/flash_xiaoqi.jpg"
}
local var_0_1 = "mainScenebg/flash.jpg"
local var_0_2 = "mainScenebg/flashlogo.png"
local var_0_3 = "mainScenebg/flashword.png"

function FlashScene.createScene(arg_2_0)
	local var_2_0 = FlashScene.new()

	var_2_0:init()

	return var_2_0
end

function FlashScene:init()
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	local var_3_0 = tostring(DeviceManager.getPackageChannel())
	local var_3_1 = cc.Sprite:create(var_0_0[var_3_0] or var_0_1)

	var_3_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self:addChild(var_3_1, 1)

	local var_3_2 = cc.Sprite:create(var_0_2)

	var_3_2:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self:addChild(var_3_2, 2)

	local var_3_3 = ccui.ImageView:create(var_0_3)

	var_3_3:setAnchorPoint(cc.p(0.5, 0))
	var_3_3:setTouchEnabled(true)
	var_3_3:setPosition(cc.p(GameDisplay.cx, 20))
	self:addChild(var_3_3, 2)

	local var_3_4 = 1

	if var_0_0[var_3_0] then
		var_3_2:setVisible(false)
		var_3_3:setVisible(false)
		self:runAction(cc.Sequence:create(cc.DelayTime:create(1.5), cc.CallFunc:create(function()
			var_3_2:setVisible(true)
			var_3_3:setVisible(true)
			var_3_1:setTexture(var_0_1)
		end)))

		var_3_4 = var_3_4 + 1.5

		var_3_3:addTouchEventListener(function(arg_5_0, arg_5_1)
			if arg_5_1 ~= ccui.TouchEventType.ended then
				return
			end

			DeviceManager.openURL("https://beian.miit.gov.cn/#/Integrated/index")
		end)
	end

	self:createStatusBarCover()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(var_3_4), cc.CallFunc:create(function()
		self:transtoNextScene()
	end)))
end

function FlashScene:createStatusBarCover()
	if not GameDisplay.hasNotchInScreen() then
		return
	end

	local var_7_0 = ccui.Layout:create()

	var_7_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.statusbar_height + 10))
	var_7_0:setPosition(cc.p(0, GameDisplay.height))
	var_7_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_7_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_0:setBackGroundColorOpacity(255)
	var_7_0:setTouchEnabled(true)
	self:addChild(var_7_0, 20000)
end

function FlashScene.transtoNextScene(arg_8_0)
	require("view.Scene.AssetsScene")
	cc.Director:getInstance():replaceScene(cc.TransitionFade:create(0.5, AssetsScene:createScene(), cc.c3b(0, 0, 0)))
end
