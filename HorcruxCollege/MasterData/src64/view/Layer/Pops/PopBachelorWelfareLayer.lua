local audio_manager = require("controller.audio_manager")
local activity_manager = require("controller.activity_manager")
local var_0_2 = 3
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = {
	{
		x = 320,
		y = GameDisplay.height * 0.65 - 100
	},
	{
		x = 160,
		y = GameDisplay.height * 0.35 - 100
	},
	{
		x = 480,
		y = GameDisplay.height * 0.35 - 100
	}
}

PopBachelorWelfareLayer = class("PopBachelorWelfareLayer", function()
	return PopBaseLayer:create(initPara)
end)

function PopBachelorWelfareLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBachelorWelfareLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopBachelorWelfareLayer:initBg(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	self:addChild(var_3_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)

		local var_4_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_4_0:setAnchorPoint(cc.p(0, 0))
		var_4_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_4_0, -1)
		self:init(arg_3_1, initInfo)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function PopBachelorWelfareLayer:init(arg_5_1)
	print("open poplayer : PopBachelorWelfareLayer")

	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 1)

	self.openNum = 0
	self.stat = arg_5_1.stat or 1
	self.id = arg_5_1.id
	self.maxOpenNum = activity_manager:getRedPacketMaxPackNum(self.id)

	self:initUI()
	self:registerActivityEventListener()

	if self.stat == 2 then
		activity_manager:getRedPacketInfo(self.id)
	end

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.skeletonData then
				self.skeletonData:release()
			end

			self.skeletonData = nil

			activity_manager:releaseEventListenerByName("PopBachelorWelfareLayer")

			if arg_5_1 and arg_5_1.exitcallback then
				arg_5_1.exitcallback()
			end
		end
	end)
end

function PopBachelorWelfareLayer:initUI()
	local var_7_0 = ccui.ImageView:create("PopBachelorWelfareLayer/tip_img.png", var_0_3)

	var_7_0:setName("tip_img")
	var_7_0:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height * 0.8))
	self.rootLayer:addChild(var_7_0)

	local var_7_1 = ccui.ImageView:create("PopBachelorWelfareLayer/buttom_img.png", var_0_3)

	var_7_1:setName("buttom_img")
	var_7_1:setAnchorPoint(cc.p(0.5, 0))
	var_7_1:setPosition(cc.p(GameDisplay.width / 2, 0))
	self.rootLayer:addChild(var_7_1)

	for iter_7_0 = 1, var_0_2 do
		local var_7_2 = ccui.Button:create("PopBachelorWelfareLayer/red_pack.png", nil, "PopBachelorWelfareLayer/red_pack.png", var_0_3)

		var_7_2:setTag(iter_7_0)
		var_7_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_7_2:setPositionX(var_0_4[iter_7_0].x)
		var_7_2:setPositionY(var_0_4[iter_7_0].y)
		var_7_2:setTouchEnabled(true)
		var_7_2:setName("red_pack_btn" .. iter_7_0)
		self.rootLayer:addChild(var_7_2)
		var_7_2:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_8_0.isGetted then
				return false
			end

			activity_manager:getRedPacketInfo(self.id, iter_7_0, self.openNum)

			arg_8_0.isTouched = true

			if self.openNum >= self.maxOpenNum then
				self:whenOpenMaxRedPack()

				return
			end
		end)
	end

	LayerManager:createFullScreenMask(self, 0, function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_9_0:isBright() then
			return
		end

		arg_9_0:setBright(false)
		self:exit()
	end)
end

function PopBachelorWelfareLayer.registerActivityEventListener(arg_10_0)
	activity_manager:registerEventListener("PopBachelorWelfareLayer", activity_manager.activityEventId.OPEN_RED_PACK_SUCCESS, function(arg_11_0)
		arg_10_0:whenOpenRedPackSuccess(arg_11_0.list, arg_11_0.id)
	end)
end

function PopBachelorWelfareLayer:whenOpenRedPackSuccess(arg_12_1, arg_12_2)
	local function var_12_0()
		self:showHideRedPacks(true)

		if not arg_12_1 or not next(arg_12_1) then
			return
		end

		require("view.Sprite.ItemSprite")

		for iter_13_0 = 1, #arg_12_1 do
			local var_13_1 = self.rootLayer:getChildByName("red_pack_btn" .. (arg_12_2 or iter_13_0))

			if var_13_1.isGetted ~= true then
				local var_13_2 = ItemPurchaseSprite:createPurchaseItem(tonumber(arg_12_1[iter_13_0].dropid) or arg_12_1[iter_13_0].dropid, nil, true)

				var_13_2:getChildByName("wordBg"):setScaleX(1.2)
				var_13_2:setPosition(cc.p(126, 112))
				var_13_2:setName("item_sprite")
				var_13_1:addChild(var_13_2)

				var_13_1.isGetted = true

				if arg_12_1[iter_13_0].pos > 0 then
					var_13_2:getChildByName("numLabel"):setString(L_BUTTON_TEXT.Got)
				end
			end
		end

		self.openNum = self.openNum + #arg_12_1

		if #arg_12_1 == 1 and self.openNum >= self.maxOpenNum then
			self:whenOpenMaxRedPack()
		end
	end

	if self.stat == 2 then
		var_12_0()
	else
		self:showHideRedPacks(false)
		self:playGetSpineEffect(var_12_0)
	end
end

function PopBachelorWelfareLayer:showHideRedPacks(arg_14_1, arg_14_2)
	if not arg_14_2 then
		for iter_14_0 = 1, var_0_2 do
			self.rootLayer:getChildByName("red_pack_btn" .. iter_14_0):setVisible(arg_14_1)
		end
	else
		self.rootLayer:getChildByName("red_pack_btn" .. arg_14_2):setVisible(arg_14_1)
	end
end

function PopBachelorWelfareLayer:playGetSpineEffect(arg_15_1)
	audio_manager:playeffectMusicTest("sound/bachelor_open_package")

	if not self.skeletonData then
		self.skeletonData = SpineCacheManager:addSpineData(UI_SPINE_PATH .. "hongbao.json", UI_SPINE_PATH .. "hongbao.atlas")

		self.skeletonData:retain()
	end

	local var_15_0 = ccui.Layout:create()

	var_15_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_15_0:setAnchorPoint(cc.p(0, 0))
	var_15_0:setPosition(cc.p(0, 0))
	var_15_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_15_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_15_0:setBackGroundColorOpacity(0)
	cc.Director:getInstance():getRunningScene():addChild(var_15_0, 1000)
	var_15_0:runAction(cc.Sequence:create(cc.DelayTime:create(4.6), cc.CallFunc:create(function(...)
		if arg_15_1 then
			arg_15_1()
		end
	end), cc.RemoveSelf:create()))
	var_15_0:setTouchEnabled(true)
	var_15_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_15_0:runAction(cc.RemoveSelf:create())

		if arg_15_1 then
			arg_15_1()
		end
	end)

	local var_15_1 = sp.SkeletonAnimation:create(self.skeletonData:getData())

	var_15_1:setPositionX(GameDisplay.width / 2)
	var_15_1:setPositionY(GameDisplay.height / 2)
	var_15_0:addChild(var_15_1)
	var_15_1:setAnimation(0, "animation", false)
end

function PopBachelorWelfareLayer:playExitEffectAndExit()
	self.rootLayer:setCascadeOpacityEnabled(true)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopBachelorWelfareLayer:whenOpenMaxRedPack()
	for iter_20_0 = 1, var_0_2 do
		local var_20_0 = self.rootLayer:getChildByName("red_pack_btn" .. iter_20_0)

		if not var_20_0.isTouched then
			var_20_0:setVisible(false)
		end
	end
end

function PopBachelorWelfareLayer:exit()
	if self.openNum >= self.maxOpenNum then
		self:playExitEffectAndExit()

		return
	end

	local var_21_0 = self:getChildByName("fullScreenMask")

	if var_21_0 and not var_21_0:isBright() then
		var_21_0:setBright(true)
	end

	activity_manager:getRedPacketInfo(self.id)
end
