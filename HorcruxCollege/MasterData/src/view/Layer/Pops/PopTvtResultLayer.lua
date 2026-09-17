PopTvtResultLayer = class("PopTvtResultLayer", function()
	return PopBaseLayer:create()
end)

require("view.Armature.L2Skeleton")
require("view.Sprite.AvatarSprite")
require("view.Sprite.TvTRankSprite")

local var_0_0 = config._DEBUG and 0 or 1
local arenatft_manager = require("controller.arenatft_manager")
local arenatft_rank_data = require("data.arenatft.arenatft_rank_data")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")

function PopTvtResultLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTvtResultLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopTvtResultLayer:init(arg_3_1)
	print(dump(arg_3_1))

	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopTvtResultLayer.json" or "PopTvtResultLayer.ExportJson")

	self:addChild(self.rootlayer)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.rootpanel:setLocalZOrder(999)
	self.showActions.extendVertical(self)

	self.fightResult = arg_3_1.fightResult
	self.exitcallback = arg_3_1.exitcallback
	self.restartcallback = arg_3_1.restartcallback

	self:initBg(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:initFightRecord()
end

function PopTvtResultLayer.initData(arg_4_0, arg_4_1)
	arg_4_0.playerData = arg_4_1.playerData or arenatft_manager:getPlayerInfo()
	arg_4_0.enemyData = arg_4_1.enemyData or arenatft_manager:getEnemyInfo()
	arg_4_0.fightData = arg_4_1.fightData or arenatft_manager:getFightData()
	arg_4_0.failsheildNum = arg_4_1.failsheild
	arg_4_0.isfirstwin = arg_4_1.isfirstwin
	arg_4_0.layerType = arg_4_1.layerType
end

function PopTvtResultLayer:initUI()
	local var_5_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "img_result")

	if self.fightResult == "fail" then
		var_5_0:loadTexture("PopTvtRecordLayer/result_fail.png", var_0_0)
	else
		var_5_0:loadTexture("PopTvtRecordLayer/result_succ.png", var_0_0)

		local activity_return_manager = require("controller.activity_return_manager")
		local var_5_2, var_5_3 = activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_TYPE_TFT_POINT)

		if var_5_2 then
			local var_5_4 = ccui.ImageView:create("public/panelbg/img_getup.png", var_0_0)

			var_5_4:setName("imgCatchUp")
			var_5_0:addChild(var_5_4, 5)

			local var_5_5 = ccui.Text:create("+" .. var_5_3.rate, "fonts/number.ttf", 30)

			var_5_5:setColor(cc.c3b(247, 245, 240))

			local var_5_6 = ccui.ImageView:create("PopTvtRecordLayer/rongyu.png", var_0_0)

			var_5_0:addChild(var_5_6, 5)
			var_5_0:addChild(var_5_5, 5)
			var_5_6:setPosition(var_5_0:getContentSize().width - 160, var_5_0:getContentSize().height / 2 - 60)
			var_5_5:setPosition(var_5_6:getPositionX() + 60, var_5_6:getPositionY())
			var_5_4:setPosition(var_5_5:getPositionX() + 70, var_5_5:getPositionY())
		end
	end

	self:initPlayerInfo()
	self:initEnemyInfo()
	self:initProgressBar()
	self:initBottomBtns()
	self:checkAutoFight()
end

function PopTvtResultLayer:initPlayerInfo()
	local var_6_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "VS")
	local var_6_1 = cc.Label:createWithTTF(playermodel.nickname, FONT_NAME, 20)

	var_6_1:setPosition(cc.p(100, 31))
	var_6_1:setAnchorPoint(cc.p(0, 0.5))
	var_6_0:addChild(var_6_1)

	local var_6_2 = cc.Label:createWithTTF(L_SOULS_LEFTUP_ATTR_PANEL_STR[1] .. " " .. global_trans_number(self.playerData.fightPower), FONT_NAME, 18)

	var_6_2:setPosition(cc.p(100, 10))
	var_6_2:setAnchorPoint(cc.p(0, 0.5))
	var_6_0:addChild(var_6_2)

	local var_6_3 = AvatarSprite:create(playermodel.head_sculpture)

	var_6_3:setScale(0.4)
	var_6_3:setPosition(cc.p(12, -3))
	var_6_0:addChild(var_6_3)

	local var_6_4 = TvTRankSprite:create(self.playerData.succscore)

	var_6_4:setScale(0.35)
	var_6_4:setPosition(cc.p(100, 55))
	var_6_0:addChild(var_6_4, 999)

	local var_6_5 = cc.Label:createWithTTF("", FONT_DES, 18)

	var_6_5:setPosition(cc.p(170, 435))
	var_6_5:setAnchorPoint(cc.p(0, 0.5))
	self.rootpanel:addChild(var_6_5, 999)

	if self.playerData.delta >= 0 then
		var_6_5:setString(L_TVT_ADD .. "+" .. math.abs(self.playerData.delta))
		var_6_5:setColor(cc.c3b(173, 255, 169))
	else
		var_6_5:setString(L_TVT_ADD .. "-" .. math.abs(self.playerData.delta))
		var_6_5:setColor(cc.c3b(250, 113, 107))
	end

	local var_6_6
	local var_6_7

	if self.layerType == "PopTvtRecordLayer" then
		var_6_6 = self.failsheildNum
		var_6_7 = self.isfirstwin
	else
		var_6_6 = arenatft_manager:getFailsheildNum()
		var_6_7 = arenatft_manager:isToDayfirstWin()
	end

	if var_6_6 and var_6_6 > 0 then
		local var_6_8 = ccui.ImageView:create("PopTvtRecordLayer/failscore_" .. var_6_6 .. ".png", var_0_0)

		var_6_8:setPosition(cc.p(410, 420))

		if self.playerData.delta <= 0 then
			var_6_8:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeIn:create(0.4), cc.FadeOut:create(0.4))))
		end

		self.rootpanel:addChild(var_6_8, 999)
		arenatft_manager:resetFailsheildNum()
	end

	if var_6_7 then
		local var_6_9 = ccui.ImageView:create("PopTvtRecordLayer/first_win.png", var_0_0)

		var_6_9:setPosition(cc.p(316, 445))
		self.rootpanel:addChild(var_6_9, 999)
		arenatft_manager:resetFirstwin()
	end
end

function PopTvtResultLayer:initEnemyInfo()
	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "VS")
	local var_7_1 = cc.Label:createWithTTF(self.enemyData.name, FONT_NAME, 20)

	var_7_1:setPosition(cc.p(425, 31))
	var_7_1:setAnchorPoint(cc.p(1, 0.5))
	var_7_0:addChild(var_7_1)

	local var_7_2 = cc.Label:createWithTTF(global_trans_number(self.enemyData.fightPower) .. " " .. L_SOULS_LEFTUP_ATTR_PANEL_STR[1], FONT_NAME, 18)

	var_7_2:setPosition(cc.p(425, 10))
	var_7_2:setAnchorPoint(cc.p(1, 0.5))
	var_7_0:addChild(var_7_2)

	local var_7_3 = AvatarSprite:create(self.enemyData.head_sculpture)

	var_7_3:setScale(0.4)
	var_7_3:setPosition(cc.p(435, -3))
	var_7_0:addChild(var_7_3)

	local var_7_4 = TvTRankSprite:create(self.enemyData.score)

	var_7_4:setScale(0.35)
	var_7_4:setPosition(cc.p(400, 55))
	var_7_0:addChild(var_7_4, 999)
end

function PopTvtResultLayer:initProgressBar()
	self.slider = ccui.Slider:create()

	self.slider:loadProgressBarTexture("PopTvtRecordLayer/progress_bar.png", var_0_0)
	self.slider:loadBarTexture("PopTvtRecordLayer/empty_bar.png", var_0_0)
	self.slider:setPosition(cc.p(280, 415))
	self.rootpanel:addChild(self.slider)

	local var_8_0 = TvTRankSprite:create(self.playerData.succscore)
	local var_8_1 = 0.8

	if self.playerData.succscore + 100 > 1201 and self.playerData.succscore + 100 < 1500 then
		var_8_1 = 0.5
	end

	var_8_0:setName("old_rank")
	var_8_0:setScale(var_8_1)
	var_8_0:setPosition(cc.p(65, 424))
	self.rootpanel:addChild(var_8_0, 999)

	local var_8_2 = TvTRankSprite:create(self.playerData.succscore + 100)
	local var_8_3 = 0.8

	if self.playerData.succscore + 100 > 1201 and self.playerData.succscore + 100 < 1500 then
		var_8_3 = 0.5
	end

	var_8_2:setName("new_rank")
	var_8_2:setScale(var_8_3)
	var_8_2:setPosition(cc.p(435, 424))
	self.rootpanel:addChild(var_8_2, 999)

	local var_8_4, var_8_5 = var_8_0:getPlayerRankPercent(self.playerData.succscore)

	self.slider:setPercent(var_8_4)

	local var_8_6 = cc.Label:createWithTTF(var_8_5, FONT_NAME, 16)

	var_8_6:setPosition(cc.p(self.slider:getContentSize().width / 2, self.slider:getContentSize().height / 2))
	self.slider:addChild(var_8_6)
end

function PopTvtResultLayer:initExpFailBar()
	local var_9_0 = self.rootpanel:getChildByName("exp_bar")
	local var_9_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_32")
	local var_9_2 = L2Skeleton:create("spine/ui/tvt_progress_bar/fushi.json", "spine/ui/tvt_progress_bar/fushi.atlas")

	var_9_2:refreshSkeleton()
	var_9_2:setPosition(cc.p(var_9_0:getContentSize().width / 2, var_9_0:getContentSize().height / 2 + 3))

	local var_9_3 = cc.ClippingNode:create()

	var_9_3:setName("clipNode")
	var_9_3:setInverted(false)
	var_9_3:setAlphaThreshold(0.5)
	var_9_3:setStencil((config._DEBUG or nil) and (cc.Sprite:create("PopTvtRecordLayer/progress_bar.png") or cc.Sprite:createWithSpriteFrameName("PopTvtRecordLayer/progress_bar.png")))
	var_9_3:setPosition(cc.p(var_9_1:getPositionX(), var_9_1:getPositionY()))

	local var_9_4 = ccui.ImageView:create("PopTvtRecordLayer/progress_bar.png", var_0_0)

	var_9_4:setPosition(cc.p(-var_9_4:getContentSize().width, 0))
	var_9_4:setOpacity(0)
	var_9_4:setName("imageExp")
	var_9_3:addChild(var_9_4, 99)
	var_9_4:addChild(var_9_2, 1000)
	self.rootpanel:addChild(var_9_3, 1000)
	var_9_2:play("fushi")
	var_9_2:setVisible(false)
end

function PopTvtResultLayer:initFightRecord()
	local var_10_0 = {
		[0] = "fail",
		"win"
	}

	self.fightRecordTable = {}

	for iter_10_0 = 1, 3 do
		self.fightRecordTable[#self.fightRecordTable + 1] = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_site_" .. iter_10_0)
	end

	for iter_10_1 = 1, #self.fightData do
		local var_10_1 = self.fightRecordTable[iter_10_1]:getChildByName("Label_site")
		local var_10_2 = self.fightRecordTable[iter_10_1]:getChildByName("Image_status")
		local var_10_3 = self.fightRecordTable[iter_10_1]:getChildByName("Button_review")

		var_10_1:setString("第" .. iter_10_1 .. "场")

		if self.fightData[iter_10_1].fightresult == 0 then
			var_10_2:loadTexture("PopTvtRecordLayer/lose_label.png", var_0_0)
		else
			var_10_2:loadTexture("PopTvtRecordLayer/win_label.png", var_0_0)
		end

		self.fightRecordTable[iter_10_1]:setVisible(true)
		var_10_3:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PvpResultLayer", {
				arenatype = "aenatft",
				isTimeVisible = false,
				fightData = self.fightData[iter_10_1].fightData,
				rankChange = {
					RankIsVisable = true,
					enemyName = self.enemyData.name,
					playerArray = self.fightData[iter_10_1].playerarray,
					enemyArray = self.fightData[iter_10_1].enemyarray
				},
				fightResult = var_10_0[self.fightData[iter_10_1].fightresult]
			})
		end)
	end
end

function PopTvtResultLayer:initBottomBtns()
	local var_12_0 = ccui.Button:create("public/button/public_button_big_blue_y.png", nil, "public/button/public_button_big_blue_y.png", var_0_0)

	var_12_0:setPosition(cc.p(134, -60))
	self.rootpanel:addChild(var_12_0)

	local var_12_1 = cc.Label:createWithTTF(L_TVT_FIGHT_AGAIN, FONT_NAME, 26)

	var_12_1:setPosition(cc.p(var_12_0:getContentSize().width / 2, var_12_0:getContentSize().height / 2))
	var_12_0:addChild(var_12_1)
	var_12_1:setColor(cc.c3b(0, 0, 0))
	var_12_0:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:fightAgain()
	end)

	local var_12_2 = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_0)

	var_12_2:setPosition(cc.p(434, -60))
	self.rootpanel:addChild(var_12_2)

	local var_12_3 = cc.Label:createWithTTF(L_TVT_GOTO_SHOP, FONT_NAME, 26)

	var_12_3:setPosition(cc.p(var_12_2:getContentSize().width / 2, var_12_2:getContentSize().height / 2))
	var_12_2:addChild(var_12_3)
	var_12_3:setColor(cc.c3b(0, 0, 0))
	var_12_2:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function PopTvtResultLayer:fightAgain()
	if arenatft_manager:isSeasonSleep() then
		global_ShowBlockWords(L_TVT_SEASON_END)

		return
	end

	if arenatft_manager:is_attack_array_empty() then
		global_ShowBlockWords(L_TVT_ATTACK_ARRAY)

		return
	end

	if arenatft_manager:getPlayerRemainTime() <= 0 then
		self:showBuyPop()

		return
	end

	if self.finishCallback then
		self.finishCallback()
	end

	if self.restartcallback then
		self.restartcallback()
	end

	LayerManager:removePopLayer(self.__queueindex)
	LayerManager:pushInLayer("PopTvtMatchLayer", msg)
end

function PopTvtResultLayer.showBuyPop(arg_16_0)
	if arenatft_manager:isSeasonSleep() then
		global_ShowBlockWords(L_TVT_SEASON_END)

		return
	end

	local var_16_0 = arenatft_manager:getPlayerRefreshCost()
	local var_16_1

	if not var_16_0 then
		global_ShowBlockWords(L_TVT_CAN_NOT_REFUSE)

		do return end

		var_16_1 = {}
	end

	function var_16_1.surecallback()
		if playermodel.diamond < var_16_0 then
			LayerManager:pushInLayer("PopDoLayer", {
				surecallback = function()
					LayerManager:switchShowLayer("SupermarketLayer")
				end,
				labels = {
					button = L_BUTTON_TEXT.Sure,
					title = L_TOWER_DEFENCE_COST_ERROR[6],
					des = L_TVT_GO_BUG
				}
			})

			return
		end

		arenatft_manager:refresh_arenatft_dailytime(function()
			if arg_16_0.finishCallback then
				arg_16_0.finishCallback()
			end

			LayerManager:removePopLayer(arg_16_0.__queueindex)
			LayerManager:pushInLayer("PopTvtMatchLayer", msg)
		end)
	end

	var_16_1.labels = {
		title = L_TVT_REFUSE_TITLE,
		des = string.format(L_TVT_REFUSE_DESC, arenatft_manager:getRefuseNum(), var_16_0)
	}

	LayerManager:pushInLayer("PopDoLayer", var_16_1)
end

function PopTvtResultLayer:initBg()
	local var_20_0 = ccui.Layout:create()

	var_20_0:setTouchEnabled(true)
	var_20_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_20_0:setAnchorPoint(cc.p(0, 0))
	var_20_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_20_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_20_0:setOpacity(0)
	self:addChild(var_20_0, -1)
	var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.finishCallback then
			self.finishCallback()
		end

		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		self.mask = ccui.ImageView:create("mainScenebg/blur_mask.png")

		self.mask:setAnchorPoint(cc.p(0, 0))
		self.mask:setPositionY(-GameDisplay.fix_y)
		self.mask:setOpacity(0)
		self.mask:runAction(cc.FadeIn:create(1))
		self:addChild(self.mask, -1)
		var_20_0:setOpacity(102)
		var_20_0:setTouchEnabled(true)
	end)
end

function PopTvtResultLayer:checkAutoFight()
	if self.layerType == "PopTvtRecordLayer" then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("TvtAutoFight", false) then
		global_count_down_layer(4, function()
			self:fightAgain()
		end, function()
			RoleDefault:getInstance():setBoolForKey("TvtAutoFight", false)
		end)
	end
end

function PopTvtResultLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.finishCallback then
			self.finishCallback()
		end

		if self.exitcallback then
			self.exitcallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
