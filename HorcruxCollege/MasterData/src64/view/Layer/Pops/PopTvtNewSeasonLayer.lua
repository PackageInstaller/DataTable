PopTvtNewSeasonLayer = class("PopTvtNewSeasonLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.TvTRankSprite")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ItemSprite")

local var_0_0 = config._DEBUG and 0 or 1
local armature_manager = require("controller.armature_manager")
local arenatft_manager = require("controller.arenatft_manager")
local drop_manager = require("controller.drop_manager")

function PopTvtNewSeasonLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTvtNewSeasonLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopTvtNewSeasonLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopTvtNewSeasonLayer.json" or "PopTvtNewSeasonLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI(arg_3_1)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopTvtNewSeasonLayer:initUI(arg_5_1)
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_6_0, arg_6_1)
		if self.isPlayEffect then
			return
		end

		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_6_0:isBright() then
			return
		end

		arg_6_0:setBright(false)
		self:exit()
	end)

	local var_5_0 = TvTRankSprite:create(arg_5_1.lastscore)

	var_5_0:setPosition(cc.p(150, 550))
	self.rootLayer:getChildByName("bg"):addChild(var_5_0)

	local var_5_1 = TvTRankSprite:create(arg_5_1.succscore)

	var_5_1:setPosition(cc.p(390, 550))
	self.rootLayer:getChildByName("bg"):addChild(var_5_1)
	self.rootLayer:getChildByName("bg"):getChildByName("lbl_rank"):setString(L_TVT_LAST_RANK .. arg_5_1.lastscore)

	local var_5_2 = ccui.ImageView:create("PopTvtRecordLayer/jian_2.png", var_0_0)

	var_5_2:setPosition(cc.p(330, 550))
	self.rootLayer:getChildByName("bg"):addChild(var_5_2)
	self.rootLayer:getChildByName("btn_back"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	for iter_5_0, iter_5_1 in pairs((drop_manager:getAllDrops(require("data.arenatft.arenatft_conf_data").new_season_show.value))) do
		local var_5_3 = ItemPurchaseSprite:createPurchaseItem(iter_5_1.dropid, iter_5_1.dropNum)

		var_5_3:setTouchEnabled(true)
		var_5_3:setPosition(cc.p(-40 + iter_5_0 * 180, 220))
		var_5_3:setSwallowTouches(false)
		var_5_3:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_5_3.itemid, var_5_3.entityid)
		end)
		self.rootLayer:getChildByName("bg"):addChild(var_5_3)
	end
end

function PopTvtNewSeasonLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopTvtNewSeasonLayer:initBg(arg_11_1)
	local var_11_0 = ccui.Layout:create()

	var_11_0:setTouchEnabled(true)
	var_11_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_11_0:setAnchorPoint(cc.p(0, 0))
	var_11_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_11_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_11_0:setName("layer")
	var_11_0:setOpacity(0)
	self:addChild(var_11_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_12_0)
		self:addChild(arg_12_0, -2)
		arg_12_0:setPositionY(arg_12_0:getPositionY() - GameDisplay.fix_y)

		local var_12_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_12_0:setAnchorPoint(cc.p(0, 0))
		var_12_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_12_0, -1)
		self:init(arg_11_1)
		var_11_0:setOpacity(102)
	end)
end

PopTvtNewSeasonMainLayer = class("PopTvtNewSeasonMainLayer", function()
	return PopBaseLayer:create()
end)

function PopTvtNewSeasonMainLayer.create(arg_14_0, arg_14_1)
	local var_14_0 = PopTvtNewSeasonMainLayer.new()

	var_14_0:initGaussBg(arg_14_1)

	return var_14_0
end

function PopTvtNewSeasonMainLayer:init(arg_15_1)
	self._exitcallback = arg_15_1.exitcallback
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer)

	self.rootpanel = ccui.ImageView:create("PopTvtNewSeasonLayer/bg.png", var_0_0)

	self.rootpanel:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.rootLayer:addChild(self.rootpanel)
	self:initUI()
	self.showActions.extendVertical(self)
	self.rootLayer:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self._exitcallback then
				self._exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopTvtNewSeasonMainLayer:initUI()
	local var_18_0 = ccui.Button:create("PopTvtNewSeasonLayer/btn_sure.png", "PopTvtNewSeasonLayer/btn_sure.png", "PopTvtNewSeasonLayer/btn_sure.png", var_0_0)

	var_18_0:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, -20 - var_18_0:getContentSize().height / 2))
	self.rootpanel:addChild(var_18_0, 1)
	var_18_0:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.goto_system_manager")

		local var_19_0 = {
			jump_to_system = 1701
		}

		var_19_0.config = system_jump_config.CompetitionLayer and system_jump_config.CompetitionLayer.config

		goto_complete_system(var_19_0)
	end)

	for iter_18_0, iter_18_1 in ipairs((drop_manager:getAllDrops(require("data.arenatft.arenatft_conf_data").new_season_show.value))) do
		local var_18_1 = ItemPurchaseSprite:createPurchaseItem(iter_18_1.dropid, iter_18_1.dropNum)

		var_18_1:setTouchEnabled(true)
		var_18_1:setScale(0.8)
		var_18_1:setPosition(cc.p(20 + iter_18_0 * 150, 120))
		var_18_1:setSwallowTouches(true)
		var_18_1:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_18_1.itemid, var_18_1.entityid)
		end)
		self.rootpanel:addChild(var_18_1, 1)
	end
end
