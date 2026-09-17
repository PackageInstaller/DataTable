GetRoleAnimationLayer = class("GetRoleAnimationLayer", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local npc_data = require("data.npc_data")
local favor_data = require("data.favor_data")
local dormitory_manager = require("controller.dormitory_manager")
local playermodel = require("model.playermodel")

require("view.Layer.BackGroundLayer")

local network = require("network.network")
local weapon_manager = require("controller.weapon_manager")
local audio_manager = require("controller.audio_manager")

require("data.constants")

local var_0_11 = {
	Star1 = {
		scale = 1,
		x = 14,
		y = 10
	},
	Star2 = {
		scale = 0.4,
		x = 37,
		y = 14
	},
	Star3 = {
		scale = 0.5,
		x = 23,
		y = 142
	},
	Star4 = {
		scale = 1,
		x = 610,
		y = 144
	},
	Star5 = {
		scale = 0.4,
		x = 580,
		y = 146
	},
	Star6 = {
		scale = 0.5,
		x = 610,
		y = 7
	}
}
local var_0_12 = config._DEBUG and 0 or 1
local var_0_13

function GetRoleAnimationLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	require("controller.texture_manager"):loadPopLayerTextures({
		"showNewRole"
	})

	local var_2_0 = GetRoleAnimationLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function GetRoleAnimationLayer.getInstance()
	return var_0_13
end

function GetRoleAnimationLayer:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	var_0_13 = self
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setPosition(GameDisplay.fix_x, GameDisplay.fix_y)
	self.rootLayer:setCascadeOpacityEnabled(true)
	self:addChild(self.rootLayer)

	self.other_des = arg_4_4
	self.bg = ccui.Button:create(ROLEBG, ROLEBG, ROLEBG)

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setPosition(cc.p(GameDisplay.width / 2 - GameDisplay.fix_x, GameDisplay.height / 2 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.bg, 0)

	self.touchLayer = ccui.Layout:create()

	self.touchLayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.touchLayer:setPositionY(-GameDisplay.fix_y)
	self.touchLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:addChild(self.touchLayer, 1)

	if not arg_4_3 then
		self.touchLayer:setTouchEnabled(true)
		self.bg:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
			self.touchLayer:addTouchEventListener(function(arg_6_0, arg_6_1)
				if arg_6_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_4_3 = true

				self:runAction(cc.RemoveSelf:create())
			end)
		end)))
	else
		self.bg:setTouchEnabled(false)
		self.touchLayer:setTouchEnabled(false)
	end

	self._touchlimit = arg_4_3

	self:showRole(arg_4_1)
	self:showInfo(arg_4_1)
	self:showEffect()
	self:showFormatDetial(arg_4_5)
	self:addOneKeyBtn(arg_4_1)
	audio_manager:playeffectMusic(GAIN_NEW_ROLE_EFFECT)

	if not item_data[arg_4_1].servant then
		hx_print("item_data id " .. arg_4_1 .. " .servant is nil")
	end

	if item_data[arg_4_1].servant then
		if (servant_data[item_data[arg_4_1].servant].roll_rarity or 1) >= 4 then
			local var_4_1 = ccui.ImageView:create("public/rolebg/million_rare_img.png", var_0_12)

			var_4_1:setPosition(cc.p(var_4_1:getContentSize().width / 2, 1060 + GameDisplay.fix_y))
			self.rootLayer:addChild(var_4_1, 10)
		end
	end

	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_13 = nil

			if arg_4_2 then
				arg_4_2()
			end

			self.showgirlLayer:resetCurTalkConfig()
		end
	end)
end

function GetRoleAnimationLayer:showRole(arg_9_1)
	local var_9_0

	if item_data[arg_9_1] then
		if item_data[arg_9_1].bag_item_type == kITEM_HERO then
			var_9_0 = servant_data[item_data[arg_9_1].servant].modelid

			GlobalPlayRoleSound(servant_data[item_data[arg_9_1].servant].modelid, ROLE_SOUND_TYPE.home)
		elseif item_data[arg_9_1].bag_item_type == kITEM_SKIN then
			var_9_0 = item_data[arg_9_1].model

			GlobalPlayRoleSound(item_data[arg_9_1].model, ROLE_SOUND_TYPE.home)
		end
	else
		var_9_0 = servant_data[arg_9_1].modelid

		GlobalPlayRoleSound(servant_data[arg_9_1].modelid, ROLE_SOUND_TYPE.home)
	end

	local var_9_2 = 1

	if model_data[var_9_0] and model_data[var_9_0].is_own_full_screen_background == 1 then
		var_9_2 = 2
	end

	local var_9_3

	if model_data[var_9_0] then
		var_9_3 = model_data[var_9_0].backgroundid or 6300001

		if self.backGroundLayer ~= nil then
			self.backGroundLayer:update(var_9_3, var_9_2)

			goto label_9_0
		end
	end

	self.backGroundLayer = BackGroundLayer:create(var_9_3, var_9_2)

	self.bg:getParent():addChild(self.backGroundLayer)

	::label_9_0::

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_9_0, 3)

	self.showgirlLayer:setTalkEnabled(true)
	self.showgirlLayer:setTalkEnabledNew(false)
	self.rootLayer:addChild(self.showgirlLayer, 0)

	if self._touchlimit then
		self.showgirlLayer:setSwallowTouches(false)
	end
end

function GetRoleAnimationLayer:showInfo(arg_10_1)
	self.infoGrid = cc.NodeGrid:create()

	self.rootLayer:addChild(self.infoGrid, 1)
	self.infoGrid:runAction(cc.Sequence:create((cc.TurnOffTiles:create(1, cc.size(120, 120), 2):reverse())))

	self.infoBG = ccui.ImageView:create("showNewRole/huode_bg.png", var_0_12)

	self.infoBG:setScale9Enabled(true)
	self.infoBG:setAnchorPoint(cc.p(0.5, 0))
	self.infoBG:setCapInsets(cc.rect(75, 50, 1, 1))
	self.infoBG:setPosition(cc.p(SCREEN_WIDTH / 2, 50))
	self.infoGrid:addChild(self.infoBG)

	local var_10_1

	if item_data[arg_10_1] then
		if item_data[arg_10_1].bag_item_type == kITEM_HERO then
			var_10_1 = GlobalShowRoleSaying(servant_data[item_data[arg_10_1].servant].modelid, ROLE_SOUND_TYPE.home) or major_factor_data[item_data[arg_10_1].major].descrip
		elseif item_data[arg_10_1].bag_item_type == kITEM_SKIN then
			var_10_1 = GlobalShowRoleSaying(item_data[arg_10_1].model, ROLE_SOUND_TYPE.home) or item_data[arg_10_1].intro
		end
	else
		var_10_1 = major_factor_data[arg_10_1].descrip
	end

	local var_10_4 = item_data[arg_10_1].major
	local var_10_5

	if major_factor_data[item_data[arg_10_1].major] then
		var_10_5 = major_factor_data[var_10_4].easy_name or npc_data[var_10_4].easy_name

		if not major_factor_data[var_10_4] or not major_factor_data[var_10_4].role_type then
			-- block empty
		end
	end

	self.descLabel = cc.Label:createWithTTF("", FONT_DES, 32)

	self.descLabel:setString("    " .. var_10_1)
	self.descLabel:setAnchorPoint(cc.p(0, 0))

	self.nameLabel = cc.Label:createWithTTF("", FONT_DES, 48)

	self.nameLabel:setString(var_10_5)
	self.nameLabel:setAnchorPoint(cc.p(0, 0))

	local var_10_7 = self.nameLabel:getContentSize().width + 50
	local var_10_8 = self.nameLabel:getContentSize().height

	self.descLabel:setMaxLineWidth(570)
	self.descLabel:setPosition(cc.p(50, 10))
	self.descLabel:setColor(cc.c3b(37, 29, 59))
	self.infoBG:addChild(self.descLabel, 2)

	local var_10_9 = self.descLabel:getContentSize().height

	self.nameLabel:setPosition(cc.p(50, var_10_9 + 10))
	self.nameLabel:setColor(cc.c3b(54, 43, 76))
	self.infoBG:addChild(self.nameLabel, 2)

	if var_10_8 + var_10_9 + 20 > 96 then
		self.infoBG:setContentSize(cc.size(642, var_10_8 + var_10_9 + 20))
	end

	if self.other_des then
		local var_10_10 = cc.Label:createWithTTF(self.other_des, "fonts/new1.ttf", 22)

		var_10_10:setAnchorPoint(0, 0.5)
		var_10_10:setPosition(cc.p(4, var_10_10:getContentSize().height / 2))
		var_10_10:setColor(cc.c3b(47, 47, 47))
		self:addChild(var_10_10, 2)
	end

	local var_10_11

	if config._DEBUG then
		var_10_11 = cc.Sprite:create("showNewRole/bg_1.png") or cc.Sprite:createWithSpriteFrameName("showNewRole/bg_1.png")
	end

	var_10_11:setAnchorPoint(cc.p(1, 0.5))
	var_10_11:setPosition(cc.p(620, GameDisplay.height - 50))
	self:addChild(var_10_11, 2)

	if playermodel.soulContract[item_data[arg_10_1].servant] < 1 and playermodel.servantNum[item_data[arg_10_1].servant] < 1 then
		local var_10_12

		if config._DEBUG then
			var_10_12 = cc.Sprite:create("showNewRole/bg_new.png") or cc.Sprite:createWithSpriteFrameName("showNewRole/bg_new.png")
		end

		var_10_12:setAnchorPoint(cc.p(0.5, 0.5))
		var_10_12:setPosition(cc.p(var_10_11:getContentSize().width / 2, var_10_11:getContentSize().height / 2))
		var_10_11:addChild(var_10_12)
	else
		var_10_11:setVisible(false)
	end

	local var_10_13 = ccui.Button:create("mainScenebg/weiboshare.png", "mainScenebg/weiboshare.png", "")

	var_10_13:setAnchorPoint(cc.p(0, 0.5))
	var_10_13:setPosition(cc.p(10, GameDisplay.height - 50))
	self:addChild(var_10_13, 2)
	var_10_13:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:shareMyGoodLuck()
	end)

	if item_data[arg_10_1] and item_data[arg_10_1].bag_item_type == kITEM_SKIN and ({})[DeviceManager.getChannelID()] then
		var_10_13:setVisible(true)
	else
		var_10_13:setVisible(false)
	end

	if not self._touchlimit then
		local var_10_14 = cc.Label:createWithTTF(L_CLICK_CONTINUE, FONT_DES, 28)

		var_10_14:setAnchorPoint(cc.p(1, 0))
		var_10_14:setPosition(cc.p(600, 10))
		self:addChild(var_10_14, 2)
		var_10_14:setOpacity(150)
		var_10_14:runAction(cc.RepeatForever:create((cc.Sequence:create(cc.FadeTo:create(1, 255), cc.FadeTo:create(1, 5)))))
	end
end

function GetRoleAnimationLayer:showEffect()
	for iter_12_0 = 1, 6 do
		self.starSprite = ccui.ImageView:create("showNewRole/star.png", var_0_12)

		self.starSprite:setScale(var_0_11["Star" .. iter_12_0].scale)
		self.starSprite:setPosition(var_0_11["Star" .. iter_12_0].x, var_0_11["Star" .. iter_12_0].y)
		self.infoBG:addChild(self.starSprite, 2)
	end
end

function GetRoleAnimationLayer:showFormatDetial(arg_13_1)
	if not arg_13_1 then
		return
	end

	if not arg_13_1.itemid then
		return
	end

	local var_13_0 = ccui.ImageView:create((string.format("mainScenebg/other/format_%d_%d.png", arg_13_1.itemid, arg_13_1.itemNum)))

	var_13_0:setAnchorPoint(cc.p(1, 0.5))
	var_13_0:setPosition(640, 450)
	self:addChild(var_13_0)
end

function GetRoleAnimationLayer:addOneKeyBtn(arg_14_1)
	local var_14_0 = item_data[arg_14_1].major

	if item_data[arg_14_1].bag_item_type ~= kITEM_SKIN then
		return
	end

	if major_factor_data[item_data[arg_14_1].major].item_oc == arg_14_1 then
		return
	end

	local var_14_1 = ccui.Button:create("public/button/clothes_one_key.png", nil, "public/button/clothes_one_key.png", var_0_12)

	var_14_1:setPosition(cc.p(570, 450 - GameDisplay.fix_y))
	self:addChild(var_14_1)

	local activity_manager = require("controller.activity_manager")

	var_14_1.canChange = 0

	var_14_1:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_14_1.canChange == 1 then
			global_ShowBlockWords(L_USE_CLOTHES_ONE_KEY3)

			return
		elseif var_14_1.canChange == 2 then
			global_ShowBlockWords(L_USE_CLOTHES_ONE_KEY2)

			return
		end

		network:rpc("chenge_skin_one_key", {
			servantid = servantid,
			itemid = arg_14_1
		}, function(arg_16_0)
			if arg_16_0.result == 1 then
				var_14_1.canChange = 1

				global_ShowBlockWords(L_USE_CLOTHES_ONE_KEY1)

				local var_16_0 = {}

				for iter_16_0, iter_16_1 in pairs(servant_data) do
					if iter_16_1.major == var_14_0 then
						table.insert(var_16_0, iter_16_1.id)
					end
				end

				for iter_16_2, iter_16_3 in pairs(var_16_0) do
					playermodel.servantUsedskin[iter_16_3] = arg_14_1
				end

				local array_manager = require("controller.array_manager")

				array_manager:registerHangupArrayChange()
				array_manager:executeHangupArrayChange()

				if arg_16_0.favorlevel then
					if not playermodel.favor[var_14_0] or arg_16_0.favorlevel > playermodel.favor[var_14_0].favorlevel then
						self:triggerFavorUpTalk(var_14_0, playermodel.favor[var_14_0].favorlevel, arg_16_0.plotinfo)
					end

					if playermodel.favor[var_14_0] then
						playermodel.favor[var_14_0].favorlevel = arg_16_0.favorlevel
						playermodel.favor[var_14_0].favordegree = arg_16_0.favordegree
					end
				end

				playermodel.dress[var_14_0] = arg_14_1

				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_DRESS_ONE_KEY, {
					soulid = var_14_0,
					itemid = arg_14_1
				})

				if arg_16_0.plotinfo then
					PlotManager:trigger_plot_by_server({
						arg_16_0.plotinfo
					})
				end

				if arg_16_0.back_gift then
					global_gain({
						gold = arg_16_0.back_gift.gold,
						diamond = arg_16_0.back_gift.diamond,
						items = arg_16_0.back_gift.items
					})
				end

				if arg_16_0.items and next(arg_16_0.items) then
					global_gain(arg_16_0.items)
				end
			else
				var_14_1.canChange = 2

				global_ShowBlockWords(L_USE_CLOTHES_ONE_KEY2)
			end
		end)
	end)
end

function GetRoleAnimationLayer.triggerFavorUpTalk(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if favor_data[arg_17_2]["favor_up_talk" .. arg_17_1] then
		global_basic_scene:addChild(TalkLayer:create(favor_data[arg_17_2]["favor_up_talk" .. arg_17_1], nil, TALK_TYPE_FAVOR, ""), ZORDER_TALKLAYER)
	end
end

function GetRoleAnimationLayer.shareMyGoodLuck(arg_18_0)
	DeviceManager.openURL(DeviceManager.platform == "windows" and "http://www.sina.com.cn" or "sinaweibo://sendweibo?content=%e8%a7%a3%e9%94%81%e6%96%b0%e7%9a%ae%e8%82%a4%e5%95%a6%ef%bc%81%e4%b8%ba%e5%90%8c%e5%ad%a6%e4%bb%ac%e5%87%86%e5%a4%87%e6%96%b0%e8%a1%a3%e6%9c%8d%e6%98%af%e7%8f%ad%e9%95%bf%e5%a4%a7%e4%ba%ba%e6%88%91%e4%b8%8d%e5%8f%af%e6%8e%a8%e5%8d%b8%e7%9a%84%e8%b4%a3%e4%bb%bb%7e%23%e9%ad%82%e5%99%a8%e5%ad%a6%e9%99%a2%23&lfid=OP_1972298725&launchid=10000360-OP_1972298725&wm=90069_90001")
end
