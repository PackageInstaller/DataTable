FightResultLayerNew = class("FightResultLayerNew", function()
	return ccui.Layout:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local dropcache_manager = require("controller.dropcache_manager")
local level_manager = require("controller.level_manager")
local var_0_5 = level_manager
local armature_manager = require("controller.armature_manager")
local activity_manager = require("controller.activity_manager")
local audio_manager = require("controller.audio_manager")
local activity_return_manager = require("controller.activity_return_manager")
local chapter_data = require("data.chapter_data")
local var_0_13 = 174
local var_0_14 = 228
local var_0_15
local novice_pass_level_data = require("data.novice_pass_level_data")
local drop_manager = require("controller.drop_manager")

function FightResultLayerNew.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = FightResultLayerNew.new()

	var_2_0:initBg(arg_2_1, arg_2_2)

	return var_2_0
end

function FightResultLayerNew:init(arg_4_1, arg_4_2)
	self._closing = false
	var_0_15 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "fight_result_new.json" or "fight_result_new.ExportJson")

	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColorOpacity(90)

	self.initInfo = arg_4_2

	self:addChild(self.rootLayer)

	self.ListView_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_Fsn_1")
	self.scrollView_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_Fsn_2")

	self.scrollView_2:setCascadeColorEnabled(false)

	self.title_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_fsn_1")
	self.title_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_fsn_2")
	self.getitem = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_8")
	self.quckstart = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_7")
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_fsn_1")
	self.bg1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_3")
	self.drop_button = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_5")
	self.surecallback = arg_4_1.surecallback
	self.listviewitem = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_23")
	self.hidepanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_2")
	self.hidepanel2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_3")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_22"):setString(L_QUICK_FIGHT.title)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_23"):setString(L_FIGHT_RESULT_TITLE.Drop_Title[2])

	self.awardUpBtn = ccui.Button:create("fightResultNew/awardup_btn.png", nil, "fightResultNew/awardup_btn.png", var_0_0)

	self.awardUpBtn:setPosition(cc.p(436, 714))
	self.awardUpBtn:setVisible(playermodel.award_up_info.quickfight and playermodel.award_up_info.quickfight.rate > 1 and global_is_in_time(playermodel.award_up_info.quickfight.starttime, playermodel.award_up_info.quickfight.finishtime) or false)
	self.bg1:addChild(self.awardUpBtn, 100)
	self.awardUpBtn:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "award_up"
		})
	end)

	arg_4_1.items = playermodel.dropcache

	local var_4_0, var_4_1 = playermodel.curLevel:match("(%d+)-(%d+)")

	self.mode = playermodel.curMode
	self.chapter = var_4_0
	self.data = arg_4_1
	self.allSp = {}

	global_window_open_action(self.bg1)
	self.drop_button:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_6_0:setTouchEnabled(false)

		local function var_6_0()
			arg_6_0:setTouchEnabled(true)
		end

		AnalyticManager.click_dropinfo_guji()
		level_manager:getChapterHangupDropInfo(self.mode, self.chapter, function(arg_8_0)
			LayerManager:pushInLayer("DropDetailsLayer", {
				callback = var_6_0,
				category = {
					type = 1
				},
				items_tbl = self:formatChartEndData(arg_8_0),
				words_tbl = {
					type_tbl = {}
				}
			})
		end)
	end)
	self.quckstart:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_12_0 = {}

		AnalyticManager.click_souxun_guji()
		LayerManager:pushInLayer("PopQuickGuaJiSure", var_12_0)
	end)
	self.getitem:addTouchEventListener((function(arg_9_0, arg_9_1)
		return function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_10_0:isBright() then
				return
			end

			arg_10_0:setBright(false)
			AnalyticManager.click_shouqu_guji()
			require("controller.dropcache_manager"):harvestCache(function(arg_11_0, arg_11_1, arg_11_2)
				if not var_0_15 then
					return
				end

				arg_9_0:harvestAction(arg_11_0, arg_11_1, arg_11_2)

				if arg_9_1.surecallback then
					arg_9_1.surecallback()
				end

				if FightLayer and FightLayer.getInstance() then
					ccui.Helper:seekWidgetByName(FightLayer.getInstance().rootLayer, "dropcache"):checkPlayerDropCache()
					AnalyticManager.collectDropcache()
				end
			end)
		end
	end)(self, arg_4_1))

	local function var_4_2(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._closing then
			return
		end

		self._closing = true

		global_window_close_action(self.bg1, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end

	self.bg:addTouchEventListener(var_4_2)
	self.hidepanel:addTouchEventListener(var_4_2)
	self.hidepanel2:addTouchEventListener(var_4_2)
	self:initPanelList_V(arg_4_1)
	self:initFreeQuickFightReddot()
	level_manager:getChapterHangupDropInfo(self.mode, self.chapter, function(arg_15_0)
		self:initPanelList_H(self:formatEndData(arg_15_0))
	end)
	self:initDropInfo()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_16_0)
		if arg_16_0 == "exit" then
			if self.initInfo and self.initInfo.exitCallback then
				self.initInfo.exitCallback()
			end

			if self.aud1 and not self.aud1:isFinished() then
				self.aud1:stop()
			end

			var_0_15 = false

			activity_manager:releaseEventListenerByName("FightResultLayerNew")
		end
	end)
end

function FightResultLayerNew:playItemsAni(arg_17_1)
	if arg_17_1 > self.num then
		return
	end

	local var_17_0 = self.allSp[arg_17_1]

	local function var_17_1()
		var_17_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			return
		end)))
	end

	;(function()
		local var_20_0 = armature_manager:createAndPlayArmature("cachePackGetAwardNew", nil, nil, {
			start = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
				if arg_17_1 > 5 and arg_17_1 % 5 == 1 then
					self:moveUpAni(var_0_14)
				end

				var_17_1()
				self:playItemsAni(arg_17_1 + 1)
			end,
			["end"] = function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
				var_17_0:removeFromParent()

				if arg_17_1 == self.num then
					self:playCreatImageAniNew()
				end
			end
		}, 1)

		var_20_0:setPosition(var_17_0:getPosition())
		self.scrollView_2:addChild(var_20_0, 1000)
	end)()
end

function FightResultLayerNew:playCreatImageAniNew()
	local var_23_1 = self.num % 5 == 1 and 2 or self.num % 5 == 2 and 3 or self.num % 5 == 3 and 4 or self.num % 5 == 4 and 5 or 6

	if self.aud1 and not self.aud1:isFinished() then
		self.aud1:pause()
	end

	audio_manager:playeffectMusic("sound/new_shouqu2", false, nil, nil)

	local var_23_2 = armature_manager:createAndPlayArmature("cachePackGetAwardNew", nil, nil, {
		["end"] = function(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
			local var_24_0 = cc.Node:create()

			self:addChild(var_24_0)
			var_24_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				if self.nofalg then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_FIGHTNEW_MSG.Warning[1], nil, nil, 1)
				else
					self:updataCacheText()
				end
			end), cc.DelayTime:create(1), cc.CallFunc:create(function()
				if self.nofalg then
					self:playSortAni(self.nogetdata, 1)
				end
			end)))
		end
	}, var_23_1)

	self.rootLayer:addChild(var_23_2, 1000)
	var_23_2:runAction((cc.MoveTo:create(1, cc.p(220, 868 - GameDisplay.fix_y))))
	var_23_2:setScaleY(-1)

	local var_23_3 = {}

	for iter_23_0 = 1, #self.allSp - self.num do
		var_23_3[iter_23_0] = self.allSp[self.num + iter_23_0]
	end

	self.allSp = var_23_3
end

function FightResultLayerNew:playCreatImageAni(arg_27_1, arg_27_2)
	local var_27_0 = 2

	if self.num > 5 then
		var_27_0 = math.floor(self.num / 5) * 2
	end

	self.aniImage = {}

	for iter_27_0 = 1, var_27_0 do
		local var_27_1 = ccui.ImageView:create("fightResultNew/anim_getaward_1_4.png", var_0_0)

		var_27_1:setName("aniImage" .. "_" .. iter_27_0)
		var_27_1:setPosition(cc.p(arg_27_1, arg_27_2))
		self:addChild(var_27_1, 10000)

		self.aniImage[iter_27_0] = var_27_1
	end

	local var_27_2 = {
		cc.p(arg_27_1, arg_27_2),
		cc.p((arg_27_1 + 584) / 2 - 100, (arg_27_2 + 23) / 2 - 400),
		cc.p(584, 23)
	}
	local var_27_3 = {
		cc.p(arg_27_1, arg_27_2),
		cc.p((arg_27_1 + 584) / 2 + 400, (arg_27_2 + 23) / 2 + 400),
		cc.p(584, 23)
	}

	for iter_27_1, iter_27_2 in ipairs(self.aniImage) do
		self.aniImage[iter_27_1]:runAction(cc.Sequence:create(cc.DelayTime:create((iter_27_1 - 1) * 0.09), cc.BezierTo:create(0.5, (iter_27_1 % 2 == 0 or nil) and var_27_3), cc.CallFunc:create((iter_27_1 == var_27_0 or nil) and function()
			local var_29_0 = cc.Node:create()

			self:addChild(var_29_0)
			var_29_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				local var_30_0 = armature_manager:createAndPlayArmature("cachePackGetAwardNew", nil, nil, frameEventList, 3)

				self.rootLayer:addChild(var_30_0, 10000)
				var_30_0:setPosition(cc.p(var_30_0:getPositionX() + 60, var_30_0:getPositionY() - 120))
			end), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				if self.nofalg then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_FIGHTNEW_MSG.Warning[1])
				else
					self:updataCacheText()
				end
			end), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				if self.nofalg then
					self:playSortAni(self.nogetdata, 1)
				end
			end)))
		end), cc.CallFunc:create(function()
			self.aniImage[iter_27_1]:removeFromParent()
		end)))
	end

	local var_27_6 = {}

	for iter_27_3 = 1, #self.allSp - self.num do
		var_27_6[iter_27_3] = self.allSp[self.num + iter_27_3]
	end

	self.allSp = var_27_6
end

function FightResultLayerNew:playGetItemActNew(arg_34_1, arg_34_2)
	audio_manager:playeffectMusic2("sound/new_shouqu1", true, nil, function(arg_35_0)
		self.aud1 = arg_35_0
	end)

	if arg_34_1 == 2 then
		self:playItemsAni(1)

		self.nofalg = false
	else
		self.nogetdata = arg_34_2
		self.nofalg = true

		self:playSortAni(arg_34_2)
	end
end

function FightResultLayerNew:moveUpAni(arg_36_1)
	local var_36_0 = self.scrollView_2:getInnerContainer()

	var_36_0:setPositionY(var_36_0:getPositionY() + arg_36_1 / 2 + 40)
end

function FightResultLayerNew:playSortAni(arg_37_1, arg_37_2)
	if self.aud1 and not self.aud1:isFinished() then
		self.aud1:resume()
	end

	self.row = self.num % 5 == 0 and self.num / 5 - 1 or math.floor(self.num / 5)

	local var_37_1 = {}
	local var_37_2 = {}
	local var_37_3 = 0
	local var_37_4 = 0

	if not arg_37_2 then
		var_37_2 = self.cangetitems

		self:sortByQuality(self.cangetitems)
		self:sortByQuality(arg_37_1)

		local var_37_6 = global_deepCopy(var_37_2)

		for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
			table.insert(var_37_6, iter_37_1)
		end

		var_37_1.items = var_37_6
		var_37_1.createItemType = "itemid"
		var_37_1.type = 1
		var_37_3 = self.num

		if self.num > 15 then
			var_37_3 = 15
		end

		self.count = var_37_3
	else
		var_37_3 = #arg_37_1

		if #arg_37_1 > 15 then
			var_37_3 = 15
		end

		self.count = var_37_3
		var_37_1.items = arg_37_1
		var_37_1.createItemType = "itemid"
		var_37_1.type = 1
		var_37_4 = self.row * (var_0_14 / 2 + 40)
		self.isend = true
	end

	self.pos_y = 0
	self.pos_y = self.scrollheight == self.scrollView_2:getContentSize().height and self.scrollheight / 2 - var_37_4 or self.scrollheight - self.scrollView_2:getContentSize().height / 2 - var_37_4

	for iter_37_2 = 1, var_37_3 do
		self.allSp[iter_37_2]:runAction(cc.Sequence:create(cc.DelayTime:create((iter_37_2 - 1) * 0.04), cc.MoveTo:create(0.1, cc.p(self.scrollView_2:getContentSize().width / 2, self.pos_y)), cc.CallFunc:create(function()
			if iter_37_2 == var_37_3 then
				local var_38_0 = cc.Node:create()

				self:addChild(var_38_0)
				var_38_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
					self:initPanelList_V(var_37_1)

					self.num = not arg_37_2 and #var_37_2 or #arg_37_1
				end), cc.DelayTime:create(1), cc.CallFunc:create(function()
					if not arg_37_2 then
						self:playItemsAni(1)
					end
				end)))
			end
		end)))
	end
end

function FightResultLayerNew:playGetItemAct(arg_41_1, arg_41_2)
	local var_41_0 = ccui.Layout:create()

	var_41_0:setTouchEnabled(false)
	var_41_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_41_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_41_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_41_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_41_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_41_0:setBackGroundColorOpacity(180)
	self.rootLayer:addChild(var_41_0, 1000)
	var_41_0:addChild((armature_manager:createAndPlayArmature("cachePackGetAward", nil, nil, {
		goods_disappear = function(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
			self:goodsDisappear()
		end,
		scene_disappear = function(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
			if arg_41_1 == 1 then
				var_41_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.RemoveSelf:create(), cc.CallFunc:create(function()
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_FIGHTNEW_MSG.Warning[2])
				end)))
				self:initPanelList_V(arg_41_2)
				self.getitem:isBright(true)
			else
				self.getitem:isBright(false)
				var_41_0:setTouchEnabled(false)
				var_41_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
				self:updataCacheText()
			end
		end
	})))
end

function FightResultLayerNew:goodsDisappear()
	if self.scrollView_2 then
		self.scrollView_2:removeAllChildren()
	end
end

function FightResultLayerNew:harvestAction(arg_46_1, arg_46_2, arg_46_3)
	if arg_46_2 and #arg_46_2 > 0 then
		self.cangetitems = arg_46_2

		self.scrollView_2:getInnerContainer():setPositionY(self.initposY)

		if arg_46_3 and #arg_46_3 > 0 then
			self:playGetItemActNew(1, arg_46_3)
		else
			self:playGetItemActNew(2)
		end
	else
		self.getitem:setBright(true)
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(L_FIGHTNEW_MSG.Warning[2])
	end
end

function FightResultLayerNew:updataCacheText()
	self.title_2:setString(L_FIGHTNEW_MSG.Cache_Title .. string.format("%d/%d", playermodel.dropcacheweight.weight, playermodel.dropcacheweight.limit))
end

function FightResultLayerNew:initPanelList_V(arg_48_1)
	if not arg_48_1 then
		return self.getitem:setBright(false)
	end

	self:updataCacheText()

	local var_48_0 = arg_48_1.items

	if #arg_48_1.items == 0 then
		self.getitem:setBright(false)
	else
		self.getitem:setBright(true)
	end

	local var_48_1 = 0
	local var_48_2 = 0
	local var_48_3 = self.scrollView_2:getContentSize()
	local var_48_4 = var_48_3.width / (10 + (var_0_13 + 20) * 5)
	local var_48_5 = (40 + math.ceil(#var_48_0 / 5) * (20 + var_0_14)) * (var_48_3.width / (10 + (var_0_13 + 20) * 5))

	if var_48_5 < var_48_3.height then
		var_48_5 = var_48_3.height
	end

	self.scrollheight = var_48_5

	self.scrollView_2:setContentSize(var_48_3)
	self.scrollView_2:setInnerContainerSize(cc.size(var_48_3.width, var_48_5))

	if arg_48_1.type and arg_48_1.type == 1 then
		self.scrollView_2:removeAllChildren()

		self.allSp = {}
	else
		self:sortByQuality(var_48_0)

		self.initposY = self.scrollView_2:getInnerContainer():getPositionY()
	end

	for iter_48_0, iter_48_1 in ipairs(var_48_0) do
		local var_48_6
		local var_48_7
		local var_48_8

		if arg_48_1.createItemType == "itemid" then
			local var_48_9

			if iter_48_1.component_attr then
				var_48_9 = iter_48_1.component_attr
			elseif iter_48_1.weapon_attr then
				var_48_9 = iter_48_1.weapon_attr
			elseif iter_48_1.horcrux_attr then
				var_48_9 = "star=" .. iter_48_1.horcrux_attr.star
			end

			var_48_6 = ItemSprite:createNewWithItemId(iter_48_1.itemid, iter_48_1.itemcount, nil, nil, var_48_9)
			var_48_7 = iter_48_1.itemid
			var_48_8 = var_48_9
		else
			var_48_6 = ItemSprite:createBigWithEntityId(iter_48_1.entityid, iter_48_1.dropNum)
			var_48_7 = iter_48_1.dropid
		end

		self:addListenerForSP(var_48_6, var_48_7, 1, var_48_8)
		var_48_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_48_6:setScale(var_48_4)

		if arg_48_1.type and arg_48_1.type == 1 and iter_48_0 <= self.count then
			var_48_6:setPosition(cc.p(self.scrollView_2:getContentSize().width / 2, self.pos_y))
			var_48_6:runAction(cc.Sequence:create(cc.DelayTime:create((iter_48_0 - 1) * 0.09), (cc.MoveTo:create(0.1, cc.p((var_0_13 / 2 + (var_0_13 + 20) * var_48_2) * var_48_4, var_48_5 - (20 + var_0_14 / 2 + (var_0_14 + 20) * var_48_1) * var_48_4)))))

			if iter_48_0 == self.count and self.isend and self.aud1 and not self.aud1:isFinished() then
				self.aud1:stop()
			end
		else
			var_48_6:setPosition(cc.p((var_0_13 / 2 + (var_0_13 + 20) * var_48_2) * var_48_4, var_48_5 - (20 + var_0_14 / 2 + (var_0_14 + 20) * var_48_1) * var_48_4))
		end

		self.scrollView_2:addChild(var_48_6)

		var_48_2 = var_48_2 + 1

		if var_48_2 >= 5 then
			var_48_1 = var_48_1 + 1
			var_48_2 = 0
		end

		var_48_6:setName("sp" .. "_" .. iter_48_0)
		table.insert(self.allSp, var_48_6)

		self.num = #var_48_0
	end
end

function FightResultLayerNew:initPanelList_H(arg_49_1)
	if not arg_49_1 then
		return
	end

	local var_49_0 = level_manager:getChapterName(self.mode, self.chapter)

	self.chaptername = var_49_0

	self.title_1:setString((string.format(L_FIGHT_RESULT_DROP_RARE, var_49_0)))
	self.drop_button:setPositionX(self.title_1:getContentSize().width - 25)
	self.ListView_1:setItemsMargin(0)
	self.listviewitem:retain()
	self.listviewitem:removeFromParent()

	for iter_49_0, iter_49_1 in pairs(arg_49_1) do
		local var_49_1 = self.listviewitem:clone()
		local var_49_2 = ItemPurchaseSprite:createPurchaseItem(iter_49_1.itemid, nil, true)

		var_49_2:setScale(0.742)
		var_49_2:setPosition(cc.p(var_49_1:getContentSize().width * 0.5, var_49_1:getContentSize().height * 0.5))
		var_49_1:addChild(var_49_2)

		var_49_1.item_type = "item"

		local var_49_3 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "", var_0_0)

		var_49_3:setContentSize(cc.size(174, 165))
		var_49_3:setSwallowTouches(false)
		var_49_3:setOpacity(0)
		var_49_3:setAnchorPoint(cc.p(0, 0))
		var_49_3:setColor(cc.c3b(255, 255, 255))
		var_49_3:setTouchEnabled(true)
		var_49_3:setPosition(cc.p(0, 0))
		var_49_2:addChild(var_49_3)
		var_49_3:addTouchEventListener(function(arg_50_0, arg_50_1)
			if arg_50_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_50_0:getTouchBeganPosition().y - arg_50_0:getTouchEndPosition().y) > 30 then
				return
			end

			var_49_2:setTouchEnabled(false)

			arg_50_0.itemid = iter_49_1.itemid

			self:showItemDeatil(arg_50_0)
		end)
		self.ListView_1:pushBackCustomItem(var_49_1)
	end
end

function FightResultLayerNew.formatChapterData(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in pairs((level_manager:getChapterDropItems(arg_51_1, arg_51_2))) do
		if iter_51_1.content then
			for iter_51_2, iter_51_3 in pairs(iter_51_1.content) do
				var_51_0[1] = iter_51_3
			end
		end
	end

	return var_51_0
end

function FightResultLayerNew:formatEndData(arg_52_1)
	if not arg_52_1 then
		return
	end

	local var_52_0 = {}

	for iter_52_0, iter_52_1 in ipairs(arg_52_1) do
		if iter_52_1.rare and iter_52_1.rare == 1 then
			table.insert(var_52_0, {
				itemid = iter_52_1.itemid
			})
		end
	end

	if #var_52_0 > 0 then
		self:sortByQuality(var_52_0)
	end

	return var_52_0
end

function FightResultLayerNew:formatChartEndData(arg_53_1)
	if not arg_53_1 then
		return
	end

	local var_53_0 = {}

	for iter_53_0, iter_53_1 in ipairs(arg_53_1) do
		local var_53_1 = true

		for iter_53_2 = 1, #var_53_0 do
			if iter_53_1.itemid == var_53_0[iter_53_2].itemid then
				var_53_1 = false

				break
			end
		end

		if var_53_1 then
			table.insert(var_53_0, iter_53_1)
		end
	end

	local var_53_2 = {
		attribute = 1,
		content = {}
	}
	local var_53_3 = {
		attribute = 2,
		content = {}
	}
	local var_53_4 = {
		attribute = 3,
		content = {}
	}
	local var_53_5 = {
		attribute = 4,
		content = {}
	}
	local var_53_6 = {}
	local var_53_7 = {}

	for iter_53_3, iter_53_4 in ipairs(var_53_0) do
		if iter_53_4.rare and iter_53_4.rare == 1 then
			table.insert(var_53_2.content, {
				itemid = iter_53_4.itemid
			})
		elseif item_data[iter_53_4.itemid].bag_item_type and item_data[iter_53_4.itemid].bag_item_type == kITEM_MATRIAL then
			table.insert(var_53_4.content, {
				itemid = iter_53_4.itemid
			})
		elseif item_data[iter_53_4.itemid].bag_item_type and item_data[iter_53_4.itemid].bag_item_type == kITEM_COMPONENT then
			table.insert(var_53_5.content, {
				itemid = iter_53_4.itemid
			})
		else
			table.insert(var_53_3.content, {
				itemid = iter_53_4.itemid
			})
		end
	end

	if #var_53_2.content > 0 then
		table.insert(var_53_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata)
		self:sortByQuality(var_53_2.content)
		table.insert(var_53_7, var_53_2)
	end

	if #var_53_3.content > 0 then
		table.insert(var_53_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.commondata)
		self:sortByQuality(var_53_3.content)
		table.insert(var_53_7, var_53_3)
	end

	if #var_53_4.content > 0 then
		table.insert(var_53_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.sciencedata)
		self:sortByQuality(var_53_4.content)
		table.insert(var_53_7, var_53_4)
	end

	if #var_53_5.content > 0 then
		table.insert(var_53_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.componentdata)

		var_53_5.content = self:formatComponentData(var_53_5.content)

		table.insert(var_53_7, var_53_5)
	end

	var_53_7.type_tbl = var_53_6

	return var_53_7
end

function FightResultLayerNew.formatComponentData(arg_54_0, arg_54_1)
	if not arg_54_1 then
		return
	end

	local var_54_2 = {}
	local var_54_3 = {}
	local var_54_4 = {}
	local var_54_5 = {}

	local function var_54_6(arg_55_0)
		if arg_55_0 and #arg_55_0 > 1 then
			table.sort(arg_55_0, function(arg_56_0, arg_56_1)
				return arg_56_0.itemid < arg_56_1.itemid
			end)
		end
	end

	for iter_54_0, iter_54_1 in ipairs(arg_54_1) do
		local var_54_7 = true

		for iter_54_2, iter_54_3 in ipairs(var_54_2) do
			if item_data[iter_54_1.itemid].equip_quality == iter_54_3 then
				var_54_7 = false

				break
			end
		end

		if var_54_7 then
			table.insert(var_54_2, item_data[iter_54_1.itemid].equip_quality)
		end

		local var_54_8 = true
		local var_54_9 = tostring(iter_54_1.itemid)
		local var_54_10 = string.len(var_54_9)
		local var_54_11 = tonumber(string.sub(var_54_9, var_54_10 - 1, var_54_10))

		for iter_54_4, iter_54_5 in ipairs(var_54_5) do
			if var_54_11 == iter_54_5 then
				var_54_8 = false

				break
			end
		end

		if var_54_8 then
			table.insert(var_54_5, var_54_11)
		end
	end

	table.sort(var_54_2, function(arg_57_0, arg_57_1)
		return arg_57_1 < arg_57_0
	end)
	table.sort(var_54_5, function(arg_58_0, arg_58_1)
		return arg_58_1 < arg_58_0
	end)

	for iter_54_6, iter_54_7 in ipairs(var_54_2) do
		local var_54_12 = {}

		for iter_54_8, iter_54_9 in ipairs(arg_54_1) do
			if item_data[iter_54_9.itemid].equip_quality == iter_54_7 then
				table.insert(var_54_12, iter_54_9)
			end
		end

		if #var_54_12 > 0 then
			local var_54_13 = {}

			for iter_54_10, iter_54_11 in ipairs(var_54_5) do
				local var_54_14 = {}

				for iter_54_12, iter_54_13 in ipairs(var_54_12) do
					local var_54_15 = tostring(iter_54_13.itemid)
					local var_54_16 = string.len(var_54_15)

					if tonumber(string.sub(var_54_15, var_54_16 - 1, var_54_16)) == iter_54_11 then
						table.insert(var_54_14, iter_54_13)
					end
				end

				var_54_6(var_54_14)

				var_54_13[iter_54_10] = var_54_14
			end

			var_54_3[iter_54_6] = var_54_13
		end
	end

	for iter_54_14, iter_54_15 in ipairs(var_54_3) do
		for iter_54_16, iter_54_17 in ipairs(iter_54_15) do
			for iter_54_18, iter_54_19 in ipairs(iter_54_17) do
				table.insert(var_54_4, iter_54_19)
			end
		end
	end

	return var_54_4
end

function FightResultLayerNew.formatChapterDataNew(arg_59_0, arg_59_1)
	local var_59_0 = {}
	local var_59_2 = 0

	for iter_59_0, iter_59_1 in pairs(chapter_data[arg_59_1]) do
		if iter_59_0 then
			var_59_2 = var_59_2 + 1
		end
	end

	for iter_59_2 = 1, var_59_2 do
		local var_59_3 = {}

		if chapter_data[arg_59_1]["rare_item" .. iter_59_2] then
			var_59_3.itemid = chapter_data[arg_59_1]["rare_item" .. iter_59_2]
			var_59_0[iter_59_2] = var_59_3
		end
	end

	return var_59_0
end

function FightResultLayerNew.sortByQuality(arg_60_0, arg_60_1)
	if arg_60_1 and #arg_60_1 > 1 then
		table.sort(arg_60_1, function(arg_61_0, arg_61_1)
			if item_data[arg_61_0.itemid].equip_quality == item_data[arg_61_1.itemid].equip_quality then
				return arg_61_0.itemid < arg_61_1.itemid
			else
				return item_data[arg_61_0.itemid].equip_quality > item_data[arg_61_1.itemid].equip_quality
			end
		end)
	end
end

function FightResultLayerNew.addListenerForSP(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4)
	arg_62_1:addSpriteTouchEventListener(function(arg_63_0, arg_63_1)
		if arg_63_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[arg_62_2].bag_item_type == kITEM_HORCRUX then
			return
		end

		if item_data[arg_62_2].bag_item_type == kITEM_HERO then
			return
		end

		local var_63_0 = {
			hideGainButton = true,
			itemid = arg_62_2
		}

		if arg_62_3 == 1 then
			if math.abs(arg_63_0:getLocation().y - arg_63_0:getStartLocation().y) >= 50 then
				return
			end

			var_63_0 = {
				hideGainButton = true,
				itemid = arg_62_2,
				item_attr = arg_62_4
			}
		elseif math.abs(arg_63_0:getLocation().x - arg_63_0:getStartLocation().x) >= 30 then
			return
		end

		if not arg_62_0:getChildByName("OTHER_LAYER") then
			local var_63_1 = PopLayer:Item(var_63_0)
		end
	end)
end

function FightResultLayerNew:showItemDeatil(arg_64_1)
	if item_data[arg_64_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_64_0 = -1
		local var_64_1 = require("data.horcrux_data")[arg_64_1.itemid].horcruxtype

		for iter_64_0, iter_64_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_64_1.itemid == iter_64_1.item_id then
				var_64_0 = iter_64_0

				break
			end
		end

		if var_64_0 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_64_0,
			itemid = arg_64_1.itemid
		})
	elseif item_data[arg_64_1.itemid].bag_item_type == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_64_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_64_2 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_64_1.itemid
		})
	end
end

function FightResultLayerNew:fullScreen(arg_65_1)
	local var_65_0 = GameDisplay.getScreenSize()

	arg_65_1:setContentSize(var_65_0)
	arg_65_1:setPositionY(arg_65_1:getPositionY() - GameDisplay.fix_y)
	self.bg:setContentSize(var_65_0)
	self.hidepanel:setContentSize(cc.size(640, 250 + GameDisplay.fix_y))
	self.hidepanel2:setContentSize(cc.size(640, 250 + GameDisplay.fix_y))
	self.hidepanel:setPositionY(self.hidepanel:getPositionY() - GameDisplay.fix_y)
end

function FightResultLayerNew:initBg(arg_66_1, arg_66_2)
	local var_66_0 = ccui.Layout:create()

	var_66_0:setTouchEnabled(true)
	var_66_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_66_0:setAnchorPoint(cc.p(0, 0))
	var_66_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_66_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_66_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_66_0:setOpacity(0)
	var_66_0:setCascadeOpacityEnabled(false)
	self:addChild(var_66_0, -1)

	local var_66_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_66_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_66_1:setPositionX(var_66_0:getContentSize().width / 2)
	var_66_1:setPositionY(var_66_0:getContentSize().height / 2)
	var_66_0:addChild(var_66_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_67_0)
		self:addChild(arg_67_0, -2)
		arg_67_0:setPositionY(arg_67_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_66_1, arg_66_2)
		self:movePasslevelAward()
		var_66_0:setOpacity(102)
		var_66_0:setTouchEnabled(false)
	end)
end

function FightResultLayerNew:exit()
	if self._closing then
		return
	end

	self._closing = true

	global_window_close_action(self.bg1, function()
		LayerManager:removePopLayer(self.__queueindex)

		if self.initInfo and self.initInfo.exitCallback then
			self.initInfo.exitCallback()
		end
	end)
end

function FightResultLayerNew:initFreeQuickFightReddot()
	local var_70_0 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_70_0:setPosition(cc.p(200, 80))
	self.quckstart:addChild(var_70_0)

	function var_70_0:update()
		self:setVisible(var_0_5:isDailyFreeFightTime())
	end

	var_70_0:update()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("onQuickFight", function(arg_72_0)
		var_70_0:update()
	end), self)
end

function FightResultLayerNew:initDropInfo()
	local var_73_0 = {
		gold = 100,
		exp = 100,
		sp = 100
	}

	self.hangupbuffs = {}

	local var_73_1 = ccui.ImageView:create("TopcostLayer/dropinfobg.png", var_0_0)
	local var_73_2 = var_73_1

	var_73_1:setAnchorPoint(cc.p(0, 0.5))
	var_73_1:setPosition(cc.p(420, 780))
	var_73_1:setName("dropinfoPanel")

	local var_73_3 = ccui.ImageView:create("TopcostLayer/new_money.png", var_0_0)

	var_73_3:setAnchorPoint(cc.p(0, 0.5))
	var_73_3:setPosition(cc.p(20, var_73_1:getContentSize().height / 2 - 25))
	var_73_3:setScale(0.8)
	var_73_1:addChild(var_73_3)

	local var_73_4 = cc.Label:createWithTTF("", "fonts/name.ttf", 20)

	var_73_4:setAnchorPoint(cc.p(0, 0.5))
	var_73_4:setColor(cc.c3b(248, 250, 254))
	var_73_4:setPosition(cc.p(var_73_3:getPositionX() + var_73_3:getContentSize().width, var_73_3:getPositionY()))
	var_73_4:setName("goldadd")
	var_73_1:addChild(var_73_4)

	local var_73_5 = ccui.ImageView:create("TopcostLayer/up_money.png", var_0_0)

	var_73_5:setAnchorPoint(cc.p(0, 0.5))
	var_73_5:setPosition(cc.p(20, var_73_1:getContentSize().height / 2 + 10))
	var_73_5:setScale(0.8)
	var_73_1:addChild(var_73_5)

	local var_73_6 = cc.Label:createWithTTF("", "fonts/name.ttf", 20)

	var_73_6:setAnchorPoint(cc.p(0, 0.5))
	var_73_6:setColor(cc.c3b(248, 250, 254))
	var_73_6:setPosition(cc.p(var_73_5:getPositionX() + var_73_5:getContentSize().width, var_73_5:getPositionY()))
	var_73_6:setName("spadd")
	var_73_1:addChild(var_73_6)
	self.bg1:addChild(var_73_1, 1111)

	local function var_73_7(arg_74_0, arg_74_1)
		if not var_73_2 then
			return
		end

		local var_74_0 = arg_74_0 or hangup_gold
		local var_74_1 = arg_74_1 or hangup_sp
		local var_74_2 = var_73_0.sp or 100
		local var_74_3 = var_73_0.gold or 100
		local var_74_4, var_74_5 = activity_return_manager:get_money_or_science_up(2)
		local var_74_6, var_74_7 = activity_return_manager:get_money_or_science_up(3)
		local var_74_8 = var_74_2 + (var_74_5 - 1) * 100 + GetPrivilegeSpDropMarkup()
		local var_74_9 = var_74_3 + (var_74_7 - 1) * 100 + GetPrivilegeGoldDropMarkup()

		var_73_2:getChildByName("goldadd"):setString(string.format(L_ADD_FEN, math.floor(var_74_0 * var_74_9 / 100)))
		var_73_2:getChildByName("spadd"):setString(string.format(L_ADD_FEN, math.floor(var_74_1 * var_74_8 / 100)))

		if var_74_9 > 100 then
			var_73_2:getChildByName("goldadd"):setColor(cc.c3b(0, 208, 255))
		else
			var_73_2:getChildByName("goldadd"):setColor(cc.c3b(255, 255, 255))
		end

		if var_74_8 > 100 then
			var_73_2:getChildByName("spadd"):setColor(cc.c3b(0, 208, 255))
		else
			var_73_2:getChildByName("spadd"):setColor(cc.c3b(255, 255, 255))
		end
	end

	local function var_73_8(...)
		if not var_73_2:getChildByName("buff_panel") then
			local var_75_0 = ccui.Layout:create()

			var_75_0:setContentSize(cc.size(180, 100))
			var_75_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
			var_75_0:setAnchorPoint(0, 0)
			var_75_0:setPosition(cc.p(0, 0))
			var_75_0:setBackGroundColor(cc.c3b(0, 0, 0))
			var_75_0:setTouchEnabled(true)
			var_75_0:setName("buff_panel")
			var_73_2:addChild(var_75_0)
			var_75_0:addTouchEventListener(function(arg_76_0, arg_76_1)
				if arg_76_1 ~= ccui.TouchEventType.ended then
					return
				end

				local level_manager = require("controller.level_manager")

				self.hangupbuffs.base_sp = level_manager:getSpDropSpeed() * 6 * var_73_0.sp / 100
				self.hangupbuffs.base_gold = level_manager:getGoldDropSpeed() * 6 * var_73_0.gold / 100
				self.hangupbuffs.base_exp = level_manager:getExpDropSpeed() * 6 * var_73_0.exp / 100

				LayerManager:pushInLayer("PopReturnBuffLayer", {
					hangupbuffs = self.hangupbuffs
				})
			end)
		end

		local var_75_1 = var_73_2:getChildByName("buff_panel")

		if var_75_1:getChildByName("image_returnbuffs") then
			var_75_1:getChildByName("image_returnbuffs"):setVisible(false)
		end

		if var_75_1:getChildByName("image_hangupbuffs") then
			var_75_1:getChildByName("image_hangupbuffs"):setVisible(false)
		end

		local var_75_2 = 1

		while var_75_1:getChildByName("image_hangupbuffs_" .. var_75_2) do
			var_75_1:getChildByName("image_hangupbuffs_" .. var_75_2):setVisible(false)

			var_75_2 = var_75_2 + 1
		end

		local var_75_3 = 1
		local var_75_4 = 120

		if self.hangupbuffs then
			for iter_75_0, iter_75_1 in pairs(self.hangupbuffs.hangup_info) do
				if not iter_75_1.topcost_img[1] then
					if iter_75_1.equips and iter_75_1.equips[1] and iter_75_1.equips[1].dropid then
						local var_75_5 = "TopcostLayer/" .. item_data[iter_75_1.equips[1].dropid].image_id .. ".png"
						local var_75_6

						if var_75_1:getChildByName("image_hangupbuffs_1") then
							var_75_6 = var_75_1:getChildByName("image_hangupbuffs_1")
						else
							var_75_6 = ccui.ImageView:create(var_75_5, var_0_0)

							var_75_6:setTouchEnabled(false)
							var_75_6:setVisible(true)
							var_75_6:setName("image_hangupbuffs_1")
							var_75_1:addChild(var_75_6)
						end

						var_75_6:loadTexture(var_75_5, var_0_0)
						var_75_6:setPosition(cc.p(var_75_4, 87))
						var_75_6:setVisible(true)

						var_75_4 = var_75_4 + 30
					end
				else
					local var_75_7 = 1

					while iter_75_1.topcost_img[var_75_7] do
						local var_75_8 = "TopcostLayer/" .. iter_75_1.topcost_img[var_75_7] .. ".png"
						local var_75_9

						if not var_75_1:getChildByName("image_hangupbuffs_" .. var_75_3) then
							var_75_9 = ccui.ImageView:create(var_75_8, var_0_0)

							var_75_9:setTouchEnabled(false)
							var_75_9:setVisible(true)
							var_75_9:setName("image_hangupbuffs_" .. var_75_3)
							var_75_1:addChild(var_75_9)
						else
							var_75_9 = var_75_1:getChildByName("image_hangupbuffs_" .. var_75_3)
						end

						var_75_9:loadTexture(var_75_8, var_0_0)
						var_75_9:setVisible(true)
						var_75_9:setPosition(cc.p(var_75_4, 87))

						var_75_4 = var_75_4 + 30
						var_75_7 = var_75_7 + 1
						var_75_3 = var_75_3 + 1
					end
				end
			end
		end

		activity_return_manager:get_game_buffs(callback)
	end

	local function var_73_9(arg_77_0)
		function self:eventCallback()
			self.param.type = "hangup_buff"
			self.hangupbuffs = self.param

			local var_78_0 = 100
			local var_78_1 = 100
			local var_78_2 = 100

			for iter_78_0, iter_78_1 in pairs(self.hangupbuffs.hangup_info) do
				if type(iter_78_1) == "table" then
					if iter_78_1.gold > 100 then
						var_78_0 = var_78_0 + iter_78_1.gold - 100
					end

					if iter_78_1.exp > 100 then
						var_78_1 = var_78_1 + iter_78_1.exp - 100
					end

					if iter_78_1.sp > 100 then
						var_78_2 = var_78_2 + iter_78_1.sp - 100
					end
				end
			end

			var_73_0.gold = var_78_0
			var_73_0.exp = var_78_1
			var_73_0.sp = var_78_2

			var_73_8()
			var_73_7(var_0_5:getGoldDropSpeed() * 6, var_0_5:getSpDropSpeed() * 6)
		end

		if arg_77_0 and arg_77_0.result and arg_77_0.result == 1 then
			self.eventCallback({
				param = arg_77_0
			})
		end
	end

	local function var_73_10(arg_79_0)
		local var_79_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_lvBottom")

		if var_73_2 and var_73_2:getChildByName("buff_panel_card") then
			var_73_2:getChildByName("buff_panel_card"):removeFromParent()
		end

		if not arg_79_0 then
			return
		end

		local var_79_1 = ccui.Layout:create()

		var_79_1:setContentSize(cc.size(46, 30))
		var_79_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_79_1:setAnchorPoint(0.5, 0.5)
		var_79_1:setPosition(cc.p(120, 92))
		var_79_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_79_1:setCascadeOpacityEnabled(false)
		var_79_1:setBackGroundColorOpacity(0)
		var_79_1:setTouchEnabled(false)
		var_79_1:setName("buff_panel_card")
		var_73_2:addChild(var_79_1, 100)

		local var_79_2 = ccui.Button:create("TopcostLayer/test.png", nil, "TopcostLayer/test.png", var_0_0)

		if self.hangupbuffs and next(self.hangupbuffs) and self.hangupbuffs.hangup_info and next(self.hangupbuffs.hangup_info) then
			var_79_1:setPosition(cc.p(170, 87))
		else
			var_79_1:setPosition(cc.p(120, 87))
		end

		var_79_2:setTouchEnabled(falg)
		var_79_2:setPosition(cc.p(var_79_1:getContentSize().width / 2, var_79_1:getContentSize().height / 2))
		var_79_2:addTouchEventListener(function(arg_80_0, arg_80_1)
			if arg_80_1 ~= ccui.TouchEventType.ended then
				return
			end
		end)
		var_79_1:addChild(var_79_2)

		local var_79_3 = {
			specical = cc.c3b(0, 208, 255),
			common = cc.c3b(255, 255, 255)
		}
		local var_79_4 = var_73_2:getChildByName("goldadd")
		local var_79_5 = var_73_2:getChildByName("spadd")

		if activity_return_manager:get_money_or_science_up(3) then
			if var_79_4 then
				var_79_4:setColor(var_79_3.specical)
			end
		elseif var_79_4 then
			var_79_4:setColor(var_79_3.common)
		end

		if activity_return_manager:get_money_or_science_up(2) then
			if var_79_5 then
				var_79_5:setColor(var_79_3.specical)
			end
		elseif var_79_5 then
			var_79_5:setColor(var_79_3.common)
		end
	end

	activity_manager:registerEventListener("FightResultLayerNew", activity_manager.activityEventId.ACTIVITY_RETURN_BUFF_UPDATE, function(arg_81_0)
		var_73_10(activity_return_manager:get_buffs())
	end)
	var_0_5:get_cur_activity_hangup_conf_client(self.mode, self.chapter, function(arg_82_0)
		if self._closing then
			return
		end

		var_73_9(arg_82_0)
	end)
end

function FightResultLayerNew:movePasslevelAward()
	self:updateLevelPassDate()

	if not self.pass_level_data[1].state then
		self:adjustUI()
		self:updatePassLevelUI()
	end
end

function FightResultLayerNew:adjustUI()
	self.oldFsn_1_node = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_fsn_1_old")
	self.passLevel_award_laebl = ccui.ImageView:create("fightResultNew/title_passlevel_award.png", var_0_0)
	self.level_Label = cc.Label:createWithTTF("5" .. "/" .. "5", FONT_BUBBLE, 22)
	self.passAwardBtn = ccui.Button:create("fightResultNew/btn_pass_getaward.png", nil, "fightResultNew/btn_pass_getaward.png", var_0_0)
	self.passListPanel = ccui.ListView:create()

	self.passAwardBtn:setName("passAwardBtn")
	self.passAwardBtn:addTouchEventListener(function(arg_85_0, arg_85_1)
		if arg_85_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_85_0:isBright() then
			return
		end

		if self.pass_level_data[1].state then
			global_ShowBlockWords(L_BUTTON_TEXT.Got)

			return
		end

		local var_85_0 = novice_pass_level_data[self.pass_level_data[1].id].limit_level

		if novice_pass_level_data[self.pass_level_data[1].id].limit_level and not var_0_5:isPlayerPassLevel(var_85_0) then
			global_ShowBlockWords(L_CLEAR_CHAPTER .. var_0_5:formatSystemUnlockLevel(var_85_0))

			return
		end

		playermodel:get_novice_pass_level_award(self.pass_level_data[1].id, function(arg_86_0)
			if arg_86_0.result == 1 then
				self:updateLevelPassDate()

				if self.pass_level_data[1].state then
					self.passAwardBtn:setVisible(false)

					return
				end

				self:updatePassLevelUI()

				local var_86_0 = cc.EventCustom:new("getPassLevelAward")

				var_86_0.test = "领取奖励刷新宝箱测试"

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_86_0)
			elseif arg_86_0.result == 4 then
				print(L_NOVICE_PASSLEVEL_AWARD[1])
			elseif arg_86_0.result == 3 then
				print(L_NOVICE_PASSLEVEL_AWARD[2])
			end
		end)
	end)
	self.bg1:addChild(self.passLevel_award_laebl)
	self.bg1:addChild(self.level_Label)
	self.bg1:addChild(self.passAwardBtn, 100)
	self.bg1:addChild(self.passListPanel, 100)
	self.rootLayer:setTouchEnabled(true)
	self.passLevel_award_laebl:setPosition(self.oldFsn_1_node:getPositionX() + 40, self.oldFsn_1_node:getPositionY() - 65)
	self.level_Label:setPosition(self.passLevel_award_laebl:getPositionX() + 150, self.passLevel_award_laebl:getPositionY())
	self.passAwardBtn:setPosition(self.level_Label:getPositionX() + 170, self.passLevel_award_laebl:getPositionY())

	local var_84_0 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_84_0:setPosition(self.passAwardBtn:getContentSize().width - 15, self.passAwardBtn:getContentSize().height)
	var_84_0:setScale(0.8, 0.8)
	self.passAwardBtn:addChild(var_84_0)
	self.passListPanel:setPosition(self.passLevel_award_laebl:getPositionX() - 40, self.passLevel_award_laebl:getPositionY() - 170)
	self.oldFsn_1_node:setPositionY(self.oldFsn_1_node:getPositionY() - 200)
	self.title_2:setPositionY(self.title_2:getPositionY() - 200)
	self.bg1:loadTexture("fightResultNew/bg_getaward_new.png", var_0_0)
	self.scrollView_2:setContentSize(600, 180)
	self.scrollView_2:setPositionY(self.scrollView_2:getPositionY() + 195)
	self.passListPanel:setDirection(ccui.ScrollViewDir.horizontal)
	self.passListPanel:setBounceEnabled(true)
	self.passListPanel:setContentSize(800, 140)
end

function FightResultLayerNew:updateLevelPassDate()
	self.pass_level_data = {}

	local var_87_0 = {}

	for iter_87_0, iter_87_1 in pairs(playermodel.novice_pass_level_award) do
		print(iter_87_1)

		var_87_0[iter_87_1] = true
	end

	for iter_87_2, iter_87_3 in pairs(novice_pass_level_data) do
		table.insert(self.pass_level_data, {
			id = iter_87_3.id,
			dropid = iter_87_3.dropid,
			state = var_87_0[iter_87_3.id]
		})
	end

	table.sort(self.pass_level_data, function(arg_88_0, arg_88_1)
		local var_88_0 = arg_88_0.state and 1 or 0
		local var_88_1 = arg_88_1.state and 1 or 0

		if (arg_88_0.state and 1 or 0) == (arg_88_1.state and 1 or 0) then
			return arg_88_0.id < arg_88_1.id
		else
			return var_88_0 < var_88_1
		end
	end)
end

function FightResultLayerNew:updatePassLevelUI()
	self.passListPanel:removeAllChildren()

	local var_89_0 = ccui.Layout:create()

	var_89_0:setPosition(0, 0)

	local var_89_1 = drop_manager:getDropMsg(self.pass_level_data[1].dropid)
	local var_89_2 = {}

	if var_89_1.diamond > 0 then
		table.insert(var_89_2, {
			itemid = "diamond",
			num = var_89_1.diamond,
			name = L_DIAMOND
		})
	end

	if var_89_1.gold > 0 then
		table.insert(var_89_2, {
			itemid = "gold",
			num = var_89_1.gold,
			name = L_GOLD
		})
	end

	local var_89_3 = {}

	for iter_89_0, iter_89_1 in pairs(var_89_1.equips) do
		table.insert(var_89_3, {
			itemid = iter_89_1.dropid,
			num = iter_89_1.dropNum,
			name = item_data[iter_89_1.dropid].name,
			order = iter_89_0
		})
	end

	table.sort(var_89_3, function(arg_90_0, arg_90_1)
		return arg_90_0.order < arg_90_1.order
	end)

	for iter_89_2, iter_89_3 in pairs(var_89_3) do
		table.insert(var_89_2, iter_89_3)
	end

	local var_89_4 = {}

	var_89_4[1] = cc.p(50, -0)
	var_89_4[2] = cc.p(160, -0)
	var_89_4[3] = cc.p(270, -0)
	var_89_4[4] = cc.p(380, -0)
	var_89_4[5] = cc.p(490, -0)
	var_89_4[6] = cc.p(600, -0)

	for iter_89_4, iter_89_5 in pairs(var_89_2) do
		local var_89_5 = ccui.Button:create("public/box/new_item_bg1.png", "public/box/new_item_bg1.png", "public/box/new_item_bg1.png", var_0_0)

		var_89_5:setScale(0.6)
		var_89_5:setSwallowTouches(false)
		var_89_5:setName("itemSp_" .. iter_89_4)
		var_89_5:setPosition(var_89_4[iter_89_4])

		var_89_5.itemid = iter_89_5.itemid

		var_89_0:addChild(var_89_5)

		if type(iter_89_5.itemid) == "number" then
			var_89_5:addTouchEventListener(function(arg_91_0, arg_91_1)
				if math.abs(arg_91_0:getTouchBeganPosition().y - arg_91_0:getTouchEndPosition().y) > 50 then
					return
				end

				if arg_91_1 ~= ccui.TouchEventType.ended then
					return
				end

				PopLayer:Item({
					hideGainButton = true,
					itemid = arg_91_0.itemid
				})
			end)
		end

		local var_89_6 = ItemSprite:createNewWithItemId(iter_89_5.itemid, iter_89_5.num)

		var_89_6:setName("itemSp")
		var_89_6:setAnchorPoint(cc.p(0, 0))
		var_89_5:addChild(var_89_6)
		print(var_89_5)
	end

	self.level_Label:setString(var_0_5:formatSystemUnlockLevel(novice_pass_level_data[self.pass_level_data[1].id].limit_level))
	self.passListPanel:pushBackCustomItem(var_89_0)

	if novice_pass_level_data[self.pass_level_data[1].id].limit_level and not var_0_5:isPlayerPassLevel(novice_pass_level_data[self.pass_level_data[1].id].limit_level) then
		self.passAwardBtn:setVisible(false)

		return
	end
end

return FightResultLayerNew
