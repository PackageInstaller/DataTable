local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local account_manager = require("controller.account_manager")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local level_manager = require("controller.level_manager")

var_0_0.curchapter = nil
var_0_0.originstartindex = nil
var_0_0.startindex = nil
var_0_0.uiref = nil

function var_0_0.registerRef(arg_1_0, arg_1_1)
	arg_1_0.uiref = arg_1_1
end

function var_0_0.unregisterRef(arg_2_0)
	arg_2_0.uiref = nil
end

function var_0_0:reset(arg_3_1)
	self.curchapter = arg_3_1
	self.originstartindex = nil
	self.startindex = nil
	self.cacheItems = nil

	if self.uiref then
		self.uiref:onChangeChapter(arg_3_1)
	end

	self.batchcolorQueue = {}

	self:get_next_salute_award_time()
end

function var_0_0:start()
	if not self.curchapter then
		return
	end

	if not self.uiref then
		return
	end

	self:getBarrageData()
end

function var_0_0:getBarrageData()
	network:rpc("get_barrage", {
		chapter = self.curchapter,
		startindex = self.startindex
	}, function(arg_6_0)
		self.originstartindex = self.originstartindex or arg_6_0.nextindex - 10
		self.startindex = arg_6_0.isfinish and 1 or arg_6_0.nextindex

		self.uiref:pushBarrageData(arg_6_0.data, self.startindex >= self.originstartindex and self.startindex < self.originstartindex + 10)
	end)
end

function var_0_0:resume()
	if self.uiref then
		self.uiref:resumeBarrage()
	end
end

function var_0_0:stop()
	if self.uiref then
		self.uiref:stopBarrage()
	end
end

function var_0_0:syncBarrageToServer(arg_9_1)
	network:rpc("send_barrage", {
		chapter = self.curchapter,
		text = arg_9_1
	})
end

function var_0_0:checkmsg(arg_10_1)
	if SensitiveChecker then
		if self:getNumberCount(arg_10_1) >= 7 then
			return false
		end

		return SensitiveChecker.censorStr(arg_10_1) ~= nil
	else
		return global_is_words_pass_against(arg_10_1)
	end
end

local var_0_8 = {
	刘 = true,
	Ⅱ = true,
	Ⅰ = true,
	⑷ = true,
	⒋ = true,
	["3"] = true,
	o = true,
	⑹ = true,
	⑺ = true,
	⑶ = true,
	["0"] = true,
	一 = true,
	０ = true,
	["1"] = true,
	五 = true,
	九 = true,
	Ⅲ = true,
	㈠ = true,
	㈨ = true,
	⑼ = true,
	㈥ = true,
	⒍ = true,
	巴 = true,
	["2"] = true,
	二 = true,
	["5"] = true,
	Ⅴ = true,
	⁰ = true,
	¹ = true,
	³ = true,
	⒎ = true,
	９ = true,
	⁹ = true,
	㈦ = true,
	Ⅵ = true,
	⑵ = true,
	六 = true,
	⒌ = true,
	１ = true,
	２ = true,
	３ = true,
	扒 = true,
	Ⅻ = true,
	６ = true,
	〇 = true,
	⒉ = true,
	⁸ = true,
	旧 = true,
	８ = true,
	③ = true,
	三 = true,
	７ = true,
	Ⅸ = true,
	⑴ = true,
	② = true,
	㈧ = true,
	七 = true,
	④ = true,
	Ⅳ = true,
	四 = true,
	⑤ = true,
	⁶ = true,
	⑥ = true,
	㈣ = true,
	Ⅺ = true,
	⑦ = true,
	⑧ = true,
	⑻ = true,
	⑨ = true,
	八 = true,
	Ⅷ = true,
	⒏ = true,
	４ = true,
	㈤ = true,
	弋 = true,
	① = true,
	⁷ = true,
	Ⅶ = true,
	⒊ = true,
	５ = true,
	Ⅹ = true,
	㈡ = true,
	㈩ = true,
	⁴ = true,
	["6"] = true,
	["9"] = true,
	² = true,
	["8"] = true,
	㈢ = true,
	["7"] = true,
	⑸ = true,
	⁵ = true,
	⒈ = true,
	⒐ = true,
	零 = true,
	死 = true,
	["4"] = true
}

function var_0_0.getNumberCount(arg_11_0, arg_11_1)
	local var_11_0 = 0

	while arg_11_1 ~= "" do
		local var_11_1 = subStringGetByteCount(arg_11_1)

		if var_0_8[string.sub(arg_11_1, 0, var_11_1)] then
			var_11_0 = var_11_0 + 1
		end

		arg_11_1 = string.sub(arg_11_1, var_11_1 + 1, -1)
	end

	return var_11_0
end

function var_0_0:send_firework_item(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	network:rpc("send_firework_item", {
		chapter = arg_12_4 or self.curchapter,
		itemid = arg_12_1,
		count = arg_12_2
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			require("controller.item_manager"):deleteItem(arg_12_1, arg_12_2)

			if arg_13_0.items and next(arg_13_0.items) then
				local var_13_0, var_13_1, var_13_2, var_13_3, var_13_4, var_13_5, var_13_6, var_13_7 = global_get({
					items = arg_13_0.items
				})

				for iter_13_0, iter_13_1 in pairs(var_13_4) do
					require("controller.tips_manager"):pushBackTipsEventWithClient({
						tipsid = E_TIPS_GET_BARRAGE_GIFT_RESULT,
						itemid = iter_13_1.entityid,
						num = iter_13_1.dropNum
					})
				end
			end

			if arg_12_3 then
				arg_12_3(arg_13_0, self.curchapter)
			end
		elseif arg_13_0.result == 3 then
			global_ShowBlockWords(L_BARRAGE_GIFT_NOT_START)

			if arg_12_3 then
				arg_12_3(arg_13_0, self.curchapter)
			end
		elseif arg_13_0.result == 4 then
			global_ShowBlockWords(L_BARRAGE_GIFT_END)

			if arg_12_3 then
				arg_12_3(arg_13_0, self.curchapter)
			end
		else
			global_ShowBlockWords(L_BARRAGE_GIFT_LACK)

			if arg_12_3 then
				arg_12_3(arg_13_0, self.curchapter)
			end
		end
	end)
end

function var_0_0.get_salute_awards_dailytime(arg_14_0, ...)
	return
end

function var_0_0:showBarrageGiftEffect(arg_15_1)
	if not self.curchapter then
		return
	end

	if not self.uiref then
		return
	end

	local var_15_0 = arg_15_1.playerid .. "-" .. arg_15_1.itemid

	self.showingBarrageGift = self.showingBarrageGift or {}
	self.showingBarrageGift[var_15_0] = self.showingBarrageGift[var_15_0] or 0
	self.showingBarrageGift[var_15_0] = self.showingBarrageGift[var_15_0] + (arg_15_1.num or 1)

	self.uiref:showBarrageGiftEffect(var_15_0, arg_15_1.itemid, arg_15_1.name, arg_15_1.head_sculpture, self.showingBarrageGift[var_15_0], arg_15_1.playerid, arg_15_1.chapter, function()
		self.showingBarrageGift[var_15_0] = nil
	end)
end

function var_0_0:isShowSpinEffect(arg_17_1)
	return arg_17_1 == self.curchapter
end

function var_0_0:pushSaluteAwardEvent(arg_18_1)
	if not self.uiref then
		return
	end

	local var_18_0, var_18_1, var_18_2, var_18_3, var_18_4, var_18_5, var_18_6, var_18_7 = global_get(arg_18_1)

	self.cacheItems = {
		gold = var_18_0,
		diamond = var_18_1,
		honor = var_18_2,
		sp = var_18_3,
		energy = var_18_5,
		items = var_18_4,
		surecallback = var_18_6,
		cancelcallback = var_18_7
	}
end

function var_0_0:pushBarrageGiftEvent(arg_19_1)
	if not self.uiref then
		return
	end

	local var_19_0 = {
		itemid = tonumber(arg_19_1.itemid),
		num = tonumber(arg_19_1.count),
		playerid = tonumber(arg_19_1.playerid),
		head_sculpture = tonumber(arg_19_1.head_sculpture),
		name = arg_19_1.name,
		chapter = arg_19_1.chapter
	}

	self:playRunHourseEffect(var_19_0.itemid, var_19_0.name, var_19_0.chapter, var_19_0.playerid)
	self:pushBarrageGiftEffect(var_19_0)

	if var_19_0.chapter ~= self.curchapter then
		return
	end

	self:playBatchColorfulBarrage(var_19_0)
end

function var_0_0:showGetItems()
	if not self.cacheItems then
		return
	end

	LayerManager:pushInLayer("PopPurchaseResultLayer", self.cacheItems)

	self.cacheItems = nil

	self:get_next_salute_award_time()
end

function var_0_0:pushBarrageGiftEffect(arg_21_1)
	self.barrageGiftEffectQueue = self.barrageGiftEffectQueue or {}

	if arg_21_1.playerid ~= playermodel.playerid then
		table.insert(self.barrageGiftEffectQueue, arg_21_1)
	end

	if #self.barrageGiftEffectQueue == 1 then
		self.timesum = 6
	end

	if not self.register then
		self:registerTimer()
	end
end

function var_0_0:popBarrageGiftEffect()
	if not self.barrageGiftEffectQueue[1] then
		return
	end

	table.remove(self.barrageGiftEffectQueue, 1)
	self:showBarrageGiftEffect(self.barrageGiftEffectQueue[1])
end

function var_0_0.clearBarrageGiftEffect(arg_23_0)
	arg_23_0.barrageGiftEffectQueue = {}
end

function var_0_0.registerTimer(arg_24_0)
	arg_24_0.timesum = 0

	local var_24_0 = 5

	time_check_manager:addUpdatePool(function(arg_25_0, arg_25_1)
		arg_24_0.timesum = arg_24_0.timesum + arg_25_1

		if arg_24_0.timesum > var_24_0 then
			arg_24_0.timesum = 0

			if #arg_24_0.barrageGiftEffectQueue > 0 and arg_24_0.barrageGiftEffectQueue and arg_24_0:isShowMoreEffect() then
				arg_24_0:popBarrageGiftEffect()
			end
		end
	end)
end

function var_0_0:isShowMoreEffect()
	local var_26_0 = 0

	if not self.showingBarrageGift then
		return true
	end

	for iter_26_0, iter_26_1 in pairs(self.showingBarrageGift) do
		var_26_0 = var_26_0 + 1
	end

	return var_26_0 < 4
end

function var_0_0:puahSelfBarrageEffect(arg_27_1)
	self:pushSelfBarrageGiftEffect(arg_27_1)
	self:popBarrageGiftEffect()
end

function var_0_0:get_next_salute_award_time()
	if not self.curchapter then
		return
	end

	if not self.uiref then
		return
	end

	network:rpc("get_next_salute_award_time", {
		chapter = self.curchapter
	}, function(arg_29_0)
		if arg_29_0.result == 1 and self.curchapter == arg_29_0.chapter then
			self.uiref:setSalutePanelVisible(true)
			self.uiref:updateSaluteAwardTime(arg_29_0.chapter, arg_29_0.time)

			if arg_29_0.itemid then
				self:updateBatchColorQueue(arg_29_0.itemid, arg_29_0.time)
			end
		else
			self.uiref:setSalutePanelVisible(false)
		end
	end)
end

function var_0_0:pushSelfBarrageGiftEffect(arg_30_1)
	self.barrageGiftEffectQueue = self.barrageGiftEffectQueue or {}

	table.insert(self.barrageGiftEffectQueue, 1, arg_30_1)

	if #self.barrageGiftEffectQueue == 1 then
		self.timesum = 6
	end

	if not self.register then
		self:registerTimer()
	end
end

function var_0_0:pushRunHourseQueue(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	self.runHourseQueue = self.runHourseQueue or {}

	table.insert(self.runHourseQueue, {
		itemId = arg_31_1,
		palyerName = arg_31_2,
		level = arg_31_3,
		playerid = arg_31_4
	})
end

function var_0_0:playRunHourseQueueEffect()
	if not self.runHourseQueue or not next(self.runHourseQueue) then
		return
	end

	local var_32_0 = self.runHourseQueue[1]

	table.remove(self.runHourseQueue, 1)
	self:playRunHourseEffect(var_32_0.itemId, var_32_0.palyerName, var_32_0.level, var_32_0.playerid)
end

function var_0_0:playRunHourseEffect(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	if item_data[arg_33_1].needrunhourse ~= 1 then
		return
	end

	arg_33_3 = arg_33_3 or self.curchapter

	local var_33_1 = string.format(item_data[arg_33_1].run_words or L_GIFT_RUN_HOURSE_LIGHT[2], arg_33_2, item_data[arg_33_1].name, arg_33_3 == "birthday" and "生日会" or level_manager:getShowNameByChapter(arg_33_3))

	color = color or cc.c3b(0, 0, 0)

	if not global_basic_scene then
		return
	end

	if not arg_33_5 and tonumber(arg_33_4) == account_manager:getUserPlayerid() then
		return
	end

	if global_basic_scene:getChildByName("alert_node") and not arg_33_5 then
		self:pushRunHourseQueue(arg_33_1, arg_33_2, arg_33_3, arg_33_4)

		return
	end

	local var_33_2 = ccui.Layout:create()

	var_33_2:setName("alert_node")

	local var_33_3 = GameDisplay.height * 0.85 - GameDisplay.fix_y

	if arg_33_5 then
		var_33_3 = var_33_3 - 70
	end

	var_33_2:setContentSize(cc.p(600, 60))
	var_33_2:setPosition(640, var_33_3)
	global_basic_scene:addChild(var_33_2, 10000)

	local var_33_4 = {
		"public/button/offline_alert_btn_bg.png",
		"public/button/" .. arg_33_1 .. ".png"
	}
	local var_33_5 = ccui.ImageView:create(var_33_4[1], config._DEBUG and 0 or 1)

	var_33_5:setAnchorPoint(cc.p(0, 0.5))
	var_33_5:setPosition(cc.p(0, 0))
	var_33_2:addChild(var_33_5)

	local var_33_6 = cc.Label:createWithTTF(var_33_1, "fonts/new1.ttf", 18)
	local var_33_7 = (var_33_6:getContentSize().width + 80) / var_33_5:getContentSize().width

	var_33_6:setColor(color)
	var_33_6:setName("label")
	var_33_6:setAnchorPoint(cc.p(0, 0.5))
	var_33_6:setPosition(cc.p(55, var_33_2:getContentSize().height / 2))
	var_33_5:setScaleX(var_33_7)
	var_33_2:addChild(var_33_6)

	local var_33_8 = ccui.ImageView:create(var_33_4[2], config._DEBUG and 0 or 1)

	var_33_8:setAnchorPoint(cc.p(0.5, 0.5))
	var_33_8:setPosition(cc.p(0, var_33_2:getContentSize().height / 2))
	var_33_2:addChild(var_33_8)
	var_33_2:runAction(cc.Sequence:create(cc.MoveTo:create(6, cc.p(-var_33_5:getContentSize().width * var_33_7, var_33_2:getPositionY())), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		self:playRunHourseQueueEffect()
	end)))
	var_33_5:setTouchEnabled(true)
	var_33_5:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if (arg_33_1 == 101100001 or arg_33_1 == 101100002) and LayerManager:getCurrentLayerName() == "BirthdayPartyLayer" then
			global_ShowBlockWords(L_JUMP_TO_SUCCESS)

			return
		elseif arg_33_1 == 101100001 or arg_33_1 == 101100002 then
			return
		end

		local var_35_0, var_35_1 = arg_33_3:match("(%d+)-(%d+)")

		if LayerManager:getCurrentLayerName() == "ExploreMapLayer" then
			return
		end

		if not FightManager.isNormalFight() then
			return
		end

		if FightManager.isBigBossFight() then
			return
		end

		arg_35_0:setTouchEnabled(false)
		level_manager:selectChapter(tonumber(var_35_0), tonumber(var_35_1), function(arg_36_0)
			if arg_36_0 == 1 then
				audio_manager:playeffectMusicTest("sound/switch_chapter")
				LayerManager:switchShowLayer("FightLayer")
				FightManager.changeChapter()
			elseif arg_36_0 == 2 then
				global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.UNLOCK)
			elseif arg_36_0 == 3 then
				global_ShowBlockWords(L_JUMP_TO_SUCCESS)
			elseif arg_36_0 == 5 then
				global_ShowBlockWords(L_CHAPTER_UN_LOCK)
			else
				global_ShowBlockWords(L_JUMP_TO_FAIL)
			end
		end)
		self:get_next_salute_award_time()
	end)
end

var_0_0.batchcolorQueue = {}

local var_0_9 = {
	cc.c3b(230, 219, 90),
	cc.c3b(174, 129, 255),
	cc.c3b(58, 255, 81),
	cc.c3b(34, 221, 255),
	cc.c3b(255, 48, 204)
}

function var_0_0:playBatchColorfulBarrage(arg_37_1)
	if arg_37_1.chapter ~= self.curchapter then
		return
	end

	if not item_data[arg_37_1.itemid].batchcolortext then
		return
	end

	self:updateBatchColorQueue(arg_37_1.itemid, 60)
end

function var_0_0:updateBatchColorQueue(arg_38_1, arg_38_2)
	if not item_data[arg_38_1].batchcolortext then
		return
	end

	self.batchcolorQueue.remaintime = arg_38_2
	self.batchcolorQueue.texts = self.batchcolorQueue.texts or {}
	self.batchcolorQueue.texts[item_data[arg_38_1].batchcolortext or "魂器学院赛高"] = arg_38_2

	print("updateBatchColorQueue: ", dump(self.batchcolorQueue))
	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("playbatchcolorbarrage")))
end

function var_0_0:dequeueBatchColorBarrage(arg_39_1)
	if not self.batchcolorQueue or not self.batchcolorQueue.remaintime then
		return false
	end

	self.batchcolorQueue.remaintime = self.batchcolorQueue.remaintime - arg_39_1

	for iter_39_0, iter_39_1 in pairs(self.batchcolorQueue.texts) do
		self.batchcolorQueue.texts[iter_39_0] = self.batchcolorQueue.texts[iter_39_0] - arg_39_1
	end

	local var_39_0 = {}

	for iter_39_2, iter_39_3 in pairs(self.batchcolorQueue.texts) do
		table.insert(var_39_0, iter_39_2)
	end

	local function var_39_1()
		if #var_39_0 == 1 then
			return var_39_0[1]
		else
			return var_39_0[math.random(1, #var_39_0)]
		end
	end

	local var_39_2 = {
		{
			var_39_1(),
			var_0_9[math.random(1, #var_0_9)]
		},
		{
			var_39_1(),
			var_0_9[math.random(1, #var_0_9)]
		},
		{
			var_39_1(),
			var_0_9[math.random(1, #var_0_9)]
		},
		{
			var_39_1(),
			var_0_9[math.random(1, #var_0_9)]
		},
		{
			var_39_1(),
			var_0_9[math.random(1, #var_0_9)]
		},
		{
			var_39_1(),
			var_0_9[math.random(1, #var_0_9)]
		},
		{
			var_39_1(),
			var_0_9[math.random(1, #var_0_9)]
		},
		{
			var_39_1(),
			var_0_9[math.random(1, #var_0_9)]
		}
	}

	if self.batchcolorQueue.remaintime <= 0 then
		self.batchcolorQueue = {}
	else
		for iter_39_4, iter_39_5 in pairs(self.batchcolorQueue.texts) do
			if iter_39_5 <= 0 then
				self.batchcolorQueue.texts[iter_39_4] = nil
			end
		end
	end

	return true, var_39_2
end

function var_0_0.get_popularity_ranklist(arg_41_0, arg_41_1, arg_41_2)
	network:rpc("get_popularity_ranklist", {
		start = 1,
		stop = 50,
		chapter = arg_41_1
	}, function(arg_42_0)
		if arg_41_2 then
			arg_41_2(arg_42_0)
		end
	end)
end

function var_0_0.get_player_popularity(arg_43_0, arg_43_1, arg_43_2)
	network:rpc("get_player_popularity", {
		chapter = arg_43_1
	}, function(arg_44_0)
		if arg_43_2 then
			arg_43_2(arg_44_0)
		end
	end)
end

return var_0_0
