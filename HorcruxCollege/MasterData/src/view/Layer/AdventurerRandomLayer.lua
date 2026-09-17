AdventurerRandomLayer = class("AdventurerRandomLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Sprite.ItemSprite")
require("view.Sprite.AvatarSprite")

local TempWidget = require("view.Sprite.TempWidget")
local monster_manager = require("controller.monster_manager")
local time_check_manager = require("controller.time_check_manager")
local levelmode_data = require("data.levelmode_data")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local adverture_random_manager = require("controller.adverture_random_manager")
local activity_conf_data = require("data.activity_conf_data")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local drop_data = require("data.drop_data")
local var_0_13 = 12
local var_0_14 = {
	title = "score_title.png",
	backbg = "ade_back_bg.png",
	fight_1 = "scoretitle.png",
	uptips = "inif_roleup.png",
	itembg = "inif_diban.png",
	back = "ade_back.png",
	bg = "randomade_bg.png",
	progress_bar = "progress_bar.png",
	fight_2 = "inif_title1.png",
	progress_di = "progress_di.png",
	awardbg = "inif_ward.png",
	img_row_on = "img_row_on.png",
	img_row_off = "img_row_off.png",
	namebg = "inif_bossdi.png",
	change_btn = "inif_change.png",
	rank_btn = "rank_btn.png"
}
local var_0_15 = {
	[511] = 1,
	[457] = 1,
	[500] = 1,
	[507] = 1,
	[304] = 1,
	[436] = 1,
	[285] = 1,
	[471] = 1,
	[405] = 1,
	[428] = 1,
	[330] = 1,
	[492] = 1,
	[462] = 1,
	[490] = 1,
	[230] = 1,
	[416] = 1,
	[264] = 1,
	[451] = 1,
	[481] = 1
}

local function var_0_16(arg_2_0, arg_2_1)
	if not arg_2_0 or not next(arg_2_0) then
		return 0
	end

	local var_2_0 = 1

	while arg_2_0[arg_2_1 .. var_2_0] do
		var_2_0 = var_2_0 + 1
	end

	return var_2_0
end

local var_0_17 = "adventure_random/inif_diban.png"
local var_0_18 = {
	[1] = "adventure_random/row_no.png",
	[2] = "adventure_random/row_get.png"
}
local var_0_19 = "adventure_random/inif_rank.png"
local var_0_20 = {
	off = "adventure_random/btn_award.png",
	on = "adventure_random/btn_award.png"
}
local var_0_21

local function var_0_22(arg_3_0)
	if not arg_3_0 then
		return
	end

	if arg_3_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_3_0 / 86400), math.floor(arg_3_0 % 86400 / 3600))
	elseif arg_3_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_3_0 / 3600), math.floor(arg_3_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_3_0 / 60))
	end
end

function AdventurerRandomLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = AdventurerRandomLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function AdventurerRandomLayer:init(arg_5_1)
	var_0_21 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventurerRandomLayer.json" or "AdventurerRandomLayer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundColorOpacity(0)

	self.title_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "img_title")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.items1 = ccui.Helper:seekWidgetByName(self.rootLayer, "items2")
	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_59")
	self.awardpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "img_award")
	self.info1 = ccui.Helper:seekWidgetByName(self.title_panel, "Button_24")
	self.score_label = ccui.Helper:seekWidgetByName(self.awardpanel, "Label_67")
	self.Listview1 = ccui.Helper:seekWidgetByName(self.awardpanel, "ListView_30")
	self.info2 = ccui.Helper:seekWidgetByName(self.title_panel, "Button_35")
	self.scorepanel = ccui.Helper:seekWidgetByName(self.title_panel, "Image_14")
	self.btn_rank = ccui.Helper:seekWidgetByName(self.title_panel, "btn_rank")

	ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setString("")
	self.score_label:setString("")
	self.items:getChildByName("Image_32"):setPositionY(self.items:getChildByName("Image_32"):getPositionY() + 6)

	self.modetype = arg_5_1 and arg_5_1.modetype

	self:initData()
	self.Listview:setBackGroundColor(cc.c4b(255, 205, 66, 255))
	self:initBottomList()
	self:initTileLayer()
	self:getListData()
	self:registerTimeCheckEvent()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_21 = nil

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
	self:replaceActivityUi()
end

function AdventurerRandomLayer:initData()
	self.index_srt = "awardmodetype_" .. self.modetype .. "_"
	self.awardData = require("data.adventure_score_awards.adventure_score_awards_" .. self.modetype .. ".lua")
	self.totalnum = var_0_16(self.awardData, self.index_srt)
	self.totalscore = 0
	self.gethaveaward = {}

	self:initAwardByintData()
end

function AdventurerRandomLayer:initAwardByintData()
	if adverture_random_manager:getFightTypeByModeType(self.modetype) == 1 then
		self.title_panel:loadTexture("adventure_random/score_title.png", var_0_0)
		self.info1:loadTextures("adventure_random/scoretitle.png", nil, "adventure_random/scoretitle.png", var_0_0)
		self:replaceActivityFightUI(1)

		if not adverture_random_manager:isStepAward(self.modetype) then
			self.awardtype = 1

			self.awardpanel:setVisible(false)

			self.score_label = ccui.Helper:seekWidgetByName(self.scorepanel, "Label_15")

			self.scorepanel:setVisible(true)
		else
			self.awardtype = 2

			self.awardpanel:setVisible(true)
			self.scorepanel:setVisible(false)
		end
	elseif adverture_random_manager:getFightTypeByModeType(self.modetype) == 2 then
		self.title_panel:loadTexture("adventure_random/inif_title.png", var_0_0)
		self.info1:loadTextures("adventure_random/inif_title1.png", nil, "adventure_random/inif_title1.png", var_0_0)
		self:replaceActivityFightUI(2)

		self.awardtype = 3

		self.awardpanel:setVisible(true)
		self.scorepanel:setVisible(false)
	end
end

function AdventurerRandomLayer.getTheModeByModetype(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return false
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(levelmode_data) do
		if iter_9_1.modetype == arg_9_1 then
			table.insert(var_9_0, iter_9_1)
		end
	end

	if next(var_9_0) and var_9_0[1].mode then
		return var_9_0[1].mode
	else
		return false
	end
end

function AdventurerRandomLayer:initTileLayer()
	local function var_10_0(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_11_0:getTouchBeganPosition().y - arg_11_0:getTouchEndPosition().y) > 50 then
			return
		end

		local var_11_0 = {
			callback = callback,
			key = adverture_random_manager:getRuleKeyByModeType(self.modetype)
		}

		if not require("data.detail_data")[var_11_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表：键值为：" .. var_11_0.key)
		else
			LayerManager:pushInLayer("PopActivityDetail", var_11_0)
		end
	end

	self.info1:addTouchEventListener(var_10_0)
	self.info2:addTouchEventListener(var_10_0)
	self:updateTimeLable()
end

function AdventurerRandomLayer:updateBtnStatus()
	if not self.awards or not next(self.awards) then
		return
	end

	if not self.selectindex then
		for iter_12_0, iter_12_1 in ipairs(self.awards) do
			ccui.Helper:seekWidgetByName(iter_12_1, "Image_34"):setVisible(false)
		end
	else
		for iter_12_2, iter_12_3 in ipairs(self.awards) do
			if iter_12_2 == self.selectindex then
				ccui.Helper:seekWidgetByName(iter_12_3, "Image_34"):setVisible(true)
			else
				ccui.Helper:seekWidgetByName(iter_12_3, "Image_34"):setVisible(false)
			end
		end
	end
end

function AdventurerRandomLayer.checkIsTime(arg_13_0, arg_13_1)
	local var_13_0 = true

	if not arg_13_1 then
		return var_13_0
	end

	if global_get_time_by_date(arg_13_1) > time_check_manager:getCurTime() then
		var_13_0 = false
	end

	return var_13_0
end

function AdventurerRandomLayer:updateTotalScore()
	self.score_label:setString((self.totalscore or nil) and "" .. global_trans_number(self.totalscore))
end

function AdventurerRandomLayer:updateTimeLable()
	local var_15_0 = ccui.Helper:seekWidgetByName(self.title_panel, "Label_27")

	var_15_0:setFontSize(22)

	local var_15_1, var_15_2 = adverture_random_manager:getOpenTimeByModeType(self.modetype)

	if not var_15_1 then
		var_15_0:setString(L_LAMIYA_CHAPTER.activity_no_open)

		return
	end

	local var_15_3 = global_get_time_by_date(var_15_2) - time_check_manager:getCurTime()

	local function var_15_4(arg_16_0)
		var_15_0:setString(L_ONE_LEFT_TIME_SPACE .. var_0_22(arg_16_0))

		if self.modetype == 2021 or self.modetype == 2010 then
			var_15_0:setVisible(false)
		end

		if arg_16_0 <= 0 and self.activityScheduler then
			var_15_0:setString(L_ACTIVITY_END)
		end
	end

	self.timeLbl = var_15_0

	self.timeLbl:setVisible(self.modetype == 2010 or self.modetype == 2641 or self.modetype == 3301 or self.modetype == 4511)

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_15_3, var_15_4)))
end

function AdventurerRandomLayer:initBottomList()
	local var_17_0
	local var_17_1 = {}
	local var_17_2, var_17_3 = adverture_random_manager:isHaveNewUI(self.modetype)

	if var_17_2 and var_17_3 then
		if self:isFileExit(("mainScenebg/activity/branch" .. var_17_3 .. "/") .. var_0_14.backbg) then
			var_17_0 = ("mainScenebg/activity/branch" .. var_17_3 .. "/") .. var_0_14.backbg
		end

		if self:isFileExit(("mainScenebg/activity/branch" .. var_17_3 .. "/") .. var_0_14.back) then
			var_17_1 = {
				img = ("mainScenebg/activity/branch" .. var_17_3 .. "/") .. var_0_14.back
			}

			if var_17_3 == 173 then
				var_17_1.pos = cc.p(88, 38)
			elseif var_17_3 == 230 then
				var_17_1.pos = cc.p(88, 38)
			elseif var_17_3 == 264 then
				var_17_1.pos = cc.p(88, 30)
			elseif var_17_3 == 285 then
				var_17_1.pos = cc.p(72, 27)
			elseif var_17_3 == 304 then
				var_17_1.pos = cc.p(72, 27)
			elseif var_17_3 == 330 then
				var_17_1.pos = cc.p(35, 31)
			elseif var_17_3 == 416 then
				var_17_1.pos = cc.p(60, 31)
			elseif var_17_3 == 451 then
				var_17_1.pos = cc.p(100, 31)
			end

			var_17_1.isMainScenebg = true
		end
	end

	self.bottomList = BottomBtnList:create(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, nil, var_17_0, var_17_1)

	self:addChild(self.bottomList, 1000)

	self.rankbtn = ccui.Button:create(var_0_19, nil, var_0_19, var_0_0)

	self.rankbtn:setPosition(cc.p(self.bottomList:getContentSize().width - self.rankbtn:getContentSize().width / 2, self.bottomList:getContentSize().height / 2))
	self.bottomList:addChild(self.rankbtn)
	self.rankbtn:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AdventureInfiniteRankLayer", {
			modetype = self.modetype,
			score = self.totalscore,
			rank = self.rank
		})
	end)

	self.award = ccui.Button:create(var_0_20.on, nil, var_0_20.on, var_0_0)

	self.award:setVisible(not self.isStory and true or false)
	self.bottomList:addChild(self.award, 100)
	self.award:setPosition(self.bottomList:getContentSize().width - self.award:getContentSize().width / 2, self.bottomList:getContentSize().height / 2)

	local function var_17_4()
		local var_20_0 = cc.UserDefault:getInstance():getIntegerForKey("AdventurerVisualtime", 0)
		local var_20_1 = time_check_manager:getCurTime()

		if var_20_0 and var_20_1 < var_20_0 then
			return
		end

		local var_20_2 = os.date("*t", var_20_1)

		cc.UserDefault:getInstance():setIntegerForKey("AdventurerVisualtime", (os.time({
			hour = 23,
			min = 59,
			sec = 59,
			year = var_20_2.year,
			month = var_20_2.month,
			day = var_20_2.day
		})))
	end

	self.award:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if cc.UserDefault:getInstance():getBoolForKey("AdventurerVisualred", false) then
			var_17_4()
			cc.UserDefault:getInstance():setBoolForKey("AdventurerVisualred", false)
		end

		self:addRedot()
		LayerManager:pushInLayer("PopVisualAdventureChapter", {
			modetype = self.modetype,
			callback = function(arg_22_0)
				if var_0_21 then
					-- block empty
				end
			end
		})
	end)
	self.btn_rank:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AdventureInfiniteRankLayer", {
			modetype = self.modetype,
			score = self.totalscore,
			rank = self.rank
		})
	end)

	if self.awardtype == 1 then
		self.award:setVisible(true)
		self.rankbtn:setVisible(false)
	elseif self.awardtype == 2 then
		self.award:setVisible(false)
		self.rankbtn:setVisible(true)
	elseif self.awardtype == 3 then
		self.award:setVisible(false)
		self.rankbtn:setVisible(true)
	end

	if var_17_3 == 230 then
		self.rankbtn:setVisible(false)
	elseif var_17_3 == 285 then
		self.rankbtn:setVisible(false)
	elseif var_17_3 == 416 then
		self.rankbtn:setVisible(false)
	end
end

function AdventurerRandomLayer:initUILayer()
	self:initListView()
	self:updateTotalScore()
	self:initAwardPanel()
end

function AdventurerRandomLayer:initListView()
	self.Listview:removeAllChildren()
	self.Listview:setItemsMargin(var_0_13)

	local var_25_0, var_25_1 = adverture_random_manager:isHaveNewUI(self.modetype)

	if var_25_1 == 230 then
		local var_25_2 = TempWidget:CreateTempLayout()

		var_25_2:setContentSize(cc.size(self.Listview:getContentSize().width, 30))
		self.Listview:pushBackCustomItem(var_25_2)
		self.Listview:setItemsMargin(40)
	end

	if not self.data then
		print("error:----------------------------> no data can use！！！！！")
	end

	for iter_25_0, iter_25_1 in ipairs(self.data) do
		local var_25_3 = self.items:clone()

		self:updateNode(var_25_3, iter_25_0, iter_25_1)

		var_25_3.step = iter_25_0

		self.Listview:pushBackCustomItem(var_25_3)
	end
end

function AdventurerRandomLayer:updateNode(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = ccui.Helper:seekWidgetByName(arg_26_1, "bossface")
	local var_26_1 = ccui.Helper:seekWidgetByName(arg_26_1, "ceshu")
	local var_26_2 = ccui.Helper:seekWidgetByName(arg_26_1, "bossname")
	local var_26_3 = ccui.Helper:seekWidgetByName(arg_26_1, "change_btn")
	local var_26_4 = ccui.Helper:seekWidgetByName(arg_26_1, "info")
	local var_26_5 = ccui.Helper:seekWidgetByName(arg_26_1, "Image_32")
	local var_26_6 = ccui.Helper:seekWidgetByName(var_26_5, "Label_34")
	local var_26_7 = ccui.Helper:seekWidgetByName(arg_26_1, "upbtn")
	local var_26_8, var_26_9 = adverture_random_manager:isHaveNewUI(self.modetype)

	var_26_0:setTouchEnabled(false)
	ccui.Helper:seekWidgetByName(arg_26_1, "detail_btn"):setTouchEnabled(false)
	var_26_0:setPositionY(119)
	var_26_4:setFontSize(23)
	var_26_4:getVirtualRenderer():setMaxLineWidth(260)
	arg_26_1:setBackGroundImage(var_0_17, var_0_0)
	ccui.Helper:seekWidgetByName(arg_26_1, "Label_58"):setString(arg_26_3.name)

	if var_26_9 == 330 or var_26_9 == 451 then
		var_26_1:setFontSize(24)

		if arg_26_3.score then
			var_26_1:setString(L_MAX_SCORE .. arg_26_3.score)
		else
			var_26_1:setString(L_MAX_SCORE)
		end
	elseif arg_26_3.score then
		var_26_1:setString(arg_26_3.score)
	else
		var_26_1:setString("")
	end

	if arg_26_3.bossinfo then
		var_26_4:setString(arg_26_3.bossinfo)
	else
		var_26_4:setString("")
	end

	if self.awardtype ~= 3 then
		for iter_26_0 = 1, 3 do
			local var_26_10 = arg_26_1:getChildByName("img_" .. iter_26_0)

			var_26_10:setCascadeOpacityEnabled(false)

			if var_26_10:getChildByName("awarditem") then
				var_26_10:getChildByName("awarditem"):removeFromParent()
			end
		end

		local var_26_11 = 1
		local var_26_12 = 0

		while arg_26_3["show_item" .. var_26_11] do
			local var_26_13 = arg_26_1:getChildByName("img_" .. var_26_11)
			local var_26_14 = arg_26_3["show_item" .. var_26_11]
			local var_26_16 = type(arg_26_3["show_item" .. var_26_11]) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_0) or ccui.Button:create("public/box/" .. item_data[var_26_14].equip_quality .. ".png", "public/box/" .. item_data[var_26_14].equip_quality .. ".png", nil, var_0_0)

			var_26_16:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_16:setPosition(cc.p(0, 0))
			var_26_16:setTouchEnabled(false)
			var_26_16:setSwallowTouches(false)
			var_26_16:setPosition(cc.p(var_26_13:getContentSize().width / 2, var_26_13:getContentSize().height / 2 + 4))
			var_26_16:setName("awarditem")
			var_26_13:addChild(var_26_16, 1)

			local var_26_17
			local var_26_18

			if item_data[var_26_14].bag_item_type == kITEM_SCULTURE then
				var_26_18 = AvatarSprite:create(var_26_14)
			elseif item_data[var_26_14].bag_item_type == kITEM_MEDAL then
				var_26_18 = ItemSprite:create_medal_icon(var_26_14)
			elseif item_data[var_26_14].bag_item_type == kITEM_COMPONENT then
				var_26_18 = componentManager:create_component_icon(var_26_14, nil, nil)
			elseif item_data[var_26_14].image_id then
				var_26_17 = "equipment/" .. item_data[var_26_14].image_id .. ".png"
			end

			var_26_18 = var_26_18 or ccui.ImageView:create(var_26_17)

			var_26_18:setPosition(cc.p(var_26_16:getContentSize().width / 2, var_26_16:getContentSize().height / 2))
			var_26_18:setName("ItemSprite")

			local var_26_19 = math.min(var_26_18:getContentSize().width, var_26_18:getContentSize().height)
			local var_26_20 = 80 / var_26_19

			if var_26_14 and item_data[var_26_14] and item_data[var_26_14].bag_item_type == kITEM_SCULTURE then
				var_26_20 = 130 / var_26_19

				var_26_18:setPosition(cc.p(0, 10))
			end

			var_26_18:setScale(var_26_20)
			var_26_16:addChild(var_26_18)

			var_26_11 = var_26_11 + 1
			var_26_12 = var_26_12 + 1
		end

		if var_26_12 == 1 then
			arg_26_1:getChildByName("img_" .. 1):setPositionX(321)
		elseif var_26_12 == 2 then
			arg_26_1:getChildByName("img_" .. 1):setPositionX(270)
			arg_26_1:getChildByName("img_" .. 2):setPositionX(372)
		else
			arg_26_1:getChildByName("img_" .. 1):setPositionX(220)
			arg_26_1:getChildByName("img_" .. 2):setPositionX(321)
			arg_26_1:getChildByName("img_" .. 3):setPositionX(423)
		end

		if var_26_9 == 230 then
			if var_26_12 == 1 then
				arg_26_1:getChildByName("img_" .. 1):setPositionX(321 + 20)
			elseif var_26_12 == 2 then
				arg_26_1:getChildByName("img_" .. 1):setPositionX(270 + 20)
				arg_26_1:getChildByName("img_" .. 2):setPositionX(372 + 20)
			else
				arg_26_1:getChildByName("img_" .. 1):setPositionX(220 + 20)
				arg_26_1:getChildByName("img_" .. 2):setPositionX(321 + 20)
				arg_26_1:getChildByName("img_" .. 3):setPositionX(423 + 20)
			end
		elseif var_26_9 == 285 then
			if var_26_12 == 1 then
				arg_26_1:getChildByName("img_" .. 1):setPositionX(321 + 35)
			elseif var_26_12 == 2 then
				arg_26_1:getChildByName("img_" .. 1):setPositionX(270 + 35)
				arg_26_1:getChildByName("img_" .. 2):setPositionX(372 + 35)
			else
				arg_26_1:getChildByName("img_" .. 1):setPositionX(220 + 35)
				arg_26_1:getChildByName("img_" .. 2):setPositionX(321 + 35)
				arg_26_1:getChildByName("img_" .. 3):setPositionX(423 + 35)
			end
		elseif var_26_9 == 304 then
			if var_26_12 == 1 then
				arg_26_1:getChildByName("img_" .. 1):setPositionX(321 + 35)
			elseif var_26_12 == 2 then
				arg_26_1:getChildByName("img_" .. 1):setPositionX(270 + 35)
				arg_26_1:getChildByName("img_" .. 2):setPositionX(372 + 35)
			else
				arg_26_1:getChildByName("img_" .. 1):setPositionX(220 + 35)
				arg_26_1:getChildByName("img_" .. 2):setPositionX(321 + 35)
				arg_26_1:getChildByName("img_" .. 3):setPositionX(423 + 35)
			end
		elseif var_26_9 == 330 then
			if var_26_12 == 1 then
				arg_26_1:getChildByName("img_" .. 1):setPosition(321 + 35, 60)
			elseif var_26_12 == 2 then
				arg_26_1:getChildByName("img_" .. 1):setPosition(270 + 35, 60)
				arg_26_1:getChildByName("img_" .. 2):setPosition(372 + 35, 60)
			else
				arg_26_1:getChildByName("img_" .. 1):setPosition(220 + 35, 60)
				arg_26_1:getChildByName("img_" .. 2):setPosition(321 + 35, 60)
				arg_26_1:getChildByName("img_" .. 3):setPosition(423 + 35, 60)
			end
		elseif var_26_9 == 416 then
			if var_26_12 == 1 then
				arg_26_1:getChildByName("img_" .. 1):setPosition(321 + 35, 60)
			elseif var_26_12 == 2 then
				arg_26_1:getChildByName("img_" .. 1):setPosition(270 + 35, 60)
				arg_26_1:getChildByName("img_" .. 2):setPosition(372 + 35, 60)
			else
				arg_26_1:getChildByName("img_" .. 1):setPosition(220 + 35, 60)
				arg_26_1:getChildByName("img_" .. 2):setPosition(321 + 35, 60)
				arg_26_1:getChildByName("img_" .. 3):setPosition(423 + 35, 60)
			end
		end
	end

	var_26_3:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.modetype)

		local var_27_0

		if self.awardtype == 1 then
			var_27_0 = {
				isvisual = 1,
				data = levelmode_data[arg_26_3.mode],
				score = arg_26_3.score
			}
		elseif self.awardtype == 2 then
			var_27_0 = arg_26_3["show_item" .. 1] and {
				isvisual = 1,
				data = levelmode_data[arg_26_3.mode],
				score = arg_26_3.score
			} or {
				isvisual = 1,
				issummeradverture = 1,
				data = levelmode_data[arg_26_3.mode],
				score = arg_26_3.score
			}
		elseif self.awardtype == 3 then
			var_27_0 = {
				isinfinite = 1,
				data = levelmode_data[arg_26_3.mode],
				score = arg_26_3.score
			}
		end

		LayerManager:pushInLayer("AdventureNewDetailLayer", var_27_0)
	end)

	if arg_26_3.show_boss then
		var_26_0:loadTextures(CUTE_ROLE_IMAGE_PATH .. model_data[arg_26_3.show_boss].cute_role .. ".png", nil, CUTE_ROLE_IMAGE_PATH .. model_data[arg_26_3.show_boss].cute_role .. ".png")
		var_26_0:setVisible(true)
		var_26_0:setScale(0.46)
		var_26_2:setString(model_data[arg_26_3.show_boss].name)
	else
		var_26_0:setVisible(false)
		var_26_2:setString("")
	end

	if self:checkIsTime(arg_26_3.starttime) then
		var_26_5:setVisible(false)
	else
		var_26_5:setVisible(true)
		var_26_5:setTouchEnabled(true)

		local var_26_21 = self:dealString(arg_26_3.starttime)

		var_26_6:setString(var_26_21)
		var_26_5:addTouchEventListener(function(arg_28_0, arg_28_1)
			if arg_28_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(var_26_21)
		end)

		if var_26_9 == 230 then
			var_26_6:setPosition(200, 90)
		elseif var_26_9 == 330 then
			var_26_6:setString(string.sub(var_26_21, 8, string.len(var_26_21)))
		end
	end

	var_26_7:setVisible(false)
	var_26_7:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_26_3.mode then
			level_manager:get_infinite_score_up_list(arg_26_3.mode, function(arg_30_0, arg_30_1)
				if arg_30_0 == 1 then
					LayerManager:pushInLayer("PopAdventureInfiniteUpLayer", {
						uplist = arg_30_1
					})
				end
			end)
		else
			print("error..error....error..error:-------> no data  找策划填表！！！！！！！！！！！")
		end
	end)

	if arg_26_3.mode then
		level_manager:get_infinite_score_up_list(arg_26_3.mode, function(arg_31_0, arg_31_1)
			var_26_7:setVisible(arg_31_0 == 1)
		end)
	end

	self:replaceActivityItemUI(arg_26_1)
end

function AdventurerRandomLayer.dealString(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return ""
	end

	local var_32_0 = os.date("*t", math.floor((global_get_time_by_date(arg_32_1))))

	return (string.format(L_AVAON_VISUAL.tips_3, var_32_0.year, var_32_0.month, var_32_0.day))
end

function AdventurerRandomLayer:initAwardPanel()
	self.Listview1:setClippingEnabled(true)
	self.Listview1:removeAllChildren()
	self.Listview1:setItemsMargin(0)

	self.awards = {}

	if not self.awardData or not next(self.awardData) then
		return
	end

	local var_33_0 = 1

	while self.awardData[self.index_srt .. var_33_0] do
		local var_33_1 = self.items1:clone()

		self:replaceActivityProgressBarUI(var_33_1)
		self:updateAwardNode(var_33_1, var_33_0, self.awardData[self.index_srt .. var_33_0])
		self.Listview1:pushBackCustomItem(var_33_1)
		table.insert(self.awards, var_33_1)

		var_33_1.step = var_33_0
		var_33_0 = var_33_0 + 1
	end

	self:updateBtnStatus()

	local var_33_2 = self:getCurScoreIndex()

	if var_33_2 <= 3 then
		-- block empty
	else
		local var_33_3 = (var_33_2 - 1) * (100 / (self.totalnum - self.Listview1:getContentSize().width / 107))

		if var_33_3 < 0 then
			var_33_3 = 0
		elseif var_33_3 > 100 then
			var_33_3 = 100
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self.Listview1:scrollToPercentHorizontal(var_33_3, 0.5, false)
		end)))
	end
end

function AdventurerRandomLayer:updateAwardNode(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = ccui.Helper:seekWidgetByName(arg_35_1, "ProgressBar_61")
	local var_35_1 = ccui.Helper:seekWidgetByName(arg_35_1, "img_row")
	local var_35_2 = ccui.Helper:seekWidgetByName(arg_35_1, "need_img_di")
	local var_35_3 = ccui.Helper:seekWidgetByName(var_35_2, "Label_64")
	local var_35_4 = ccui.Helper:seekWidgetByName(arg_35_1, "img_canget")
	local var_35_5 = ccui.Helper:seekWidgetByName(arg_35_1, "Image_65")
	local var_35_6 = ccui.Helper:seekWidgetByName(arg_35_1, "Image_68")
	local var_35_7 = ccui.Helper:seekWidgetByName(var_35_6, "Label_69")

	if not arg_35_1:getChildByName("satrLayout") then
		local var_35_8 = self:createStarLayout()

		var_35_8:setScale(0.6)
		var_35_8:hide()
		arg_35_1:addChild(var_35_8)
		var_35_8:setLocalZOrder(999)
		var_35_8:align(cc.p(0, 0.5), 10, arg_35_1:getContentSize().height / 2 + 15)
	end

	local var_35_9 = arg_35_1:getChildByName("satrLayout")

	var_35_7:setPositionX(30)
	var_35_6:setVisible(false)
	var_35_1:setVisible(false)

	local var_35_10, var_35_11 = adverture_random_manager:isHaveNewUI(self.modetype)
	local var_35_12 = 0
	local var_35_13 = self:getCurScoreIndex()

	if arg_35_2 < var_35_13 then
		var_35_12 = 100
	elseif arg_35_2 == var_35_13 then
		var_35_12 = 100 * (self.totalscore / arg_35_3.score)
	elseif var_35_13 < arg_35_2 then
		var_35_12 = 0
	end

	var_35_0:setPercent(var_35_12)

	if var_35_12 == 100 then
		if var_0_15[var_35_11] then
			if self:isFileExit(("mainScenebg/activity/branch" .. var_35_11 .. "/") .. var_0_14.img_row_on) then
				var_35_1:setVisible(true)
				var_35_1:loadTexture(("mainScenebg/activity/branch" .. var_35_11 .. "/") .. var_0_14.img_row_on)
			end
		else
			var_35_1:loadTexture(var_0_18[2], var_0_0)
		end

		var_35_2:setVisible(false)
		var_35_3:setString("")
		var_35_4:setVisible(true)

		if self:isAwardHaveGet(arg_35_2) then
			var_35_3:setString(L_AVAON_VISUAL.have_get)
			var_35_4:setVisible(false)
			var_35_2:setVisible(true)
			var_35_5:setVisible(true)
		else
			var_35_5:setVisible(false)
		end
	else
		if var_0_15[var_35_11] then
			if self:isFileExit(("mainScenebg/activity/branch" .. var_35_11 .. "/") .. var_0_14.img_row_off) then
				var_35_1:setVisible(true)
				var_35_1:loadTexture(("mainScenebg/activity/branch" .. var_35_11 .. "/") .. var_0_14.img_row_off)
			end
		else
			var_35_1:loadTexture(var_0_18[1], var_0_0)
		end

		var_35_2:setVisible(true)
		var_35_4:setVisible(false)
		var_35_3:setString(string.format(L_AVAON_VISUAL.fen_lock, arg_35_3.score))
		var_35_5:setVisible(false)
	end

	local var_35_14 = self:getDropData(arg_35_3.dropid)
	local var_35_15
	local var_35_16 = 0

	if var_35_14.items and next(var_35_14.items) then
		var_35_15 = var_35_14.items[1].itemid
		var_35_16 = var_35_14.items[1].num
	elseif var_35_14.diamond and var_35_14.diamond > 0 then
		var_35_15 = "diamond"
		var_35_16 = var_35_14.diamond
	elseif var_35_14.gold then
		var_35_15 = "gold"
		var_35_16 = var_35_14.gold
	end

	local var_35_18

	if var_35_15 and var_35_16 then
		if type(var_35_15) == "string" then
			var_35_18 = ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_0)
		else
			local var_35_19 = item_data[var_35_15]

			if item_data[var_35_15].bag_item_type == kITEM_HORCRUX then
				local var_35_20 = drop_data[arg_35_3.dropid] or {}

				if var_35_20.drop_extra1 and string.sub(var_35_20.drop_extra1, 1, 5) == "star=" then
					local var_35_21 = tonumber(string.sub(var_35_20.drop_extra1, 6, 6))

					if var_35_21 >= 1 and var_35_21 <= 7 then
						var_35_9:show()
						var_35_9:setStarLevel(var_35_21)
					end
				end
			end

			var_35_18 = ccui.Button:create("public/box/" .. var_35_19.equip_quality .. ".png", "public/box/" .. var_35_19.equip_quality .. ".png", nil, var_0_0)
		end

		var_35_18:setAnchorPoint(cc.p(0.5, 0.5))
		var_35_18:setPosition(cc.p(0, 0))
		var_35_18:setTouchEnabled(true)
		var_35_18:setSwallowTouches(true)
		var_35_18:setPosition(cc.p(arg_35_1:getContentSize().width / 2, arg_35_1:getContentSize().height / 2 + 8))
		var_35_18:setName("awarditem")
		arg_35_1:addChild(var_35_18, 2)
		var_35_6:setLocalZOrder(3)
		var_35_18:setScale9Enabled(true)
		var_35_18:setContentSize(cc.size(94, 124))

		local var_35_22
		local var_35_23

		if var_35_15 == "gold" then
			var_35_22 = "equipment/1000001.png"
		elseif var_35_15 == "diamond" then
			var_35_22 = "equipment/1000000.png"
		elseif item_data[var_35_15].bag_item_type == kITEM_MEDAL then
			var_35_23 = ItemSprite:create_medal_icon(var_35_15)
		elseif item_data[var_35_15].bag_item_type == kITEM_COMPONENT then
			var_35_23 = componentManager:create_component_icon(var_35_15, nil, nil)
		elseif item_data[var_35_15].bag_item_type == kITEM_SCULTURE then
			var_35_23 = AvatarSprite:create(var_35_15)
		elseif item_data[var_35_15].image_id then
			var_35_22 = "equipment/" .. item_data[var_35_15].image_id .. ".png"
		end

		var_35_23 = var_35_23 or ccui.ImageView:create(var_35_22)

		var_35_23:setPosition(cc.p(var_35_18:getContentSize().width / 2, var_35_18:getContentSize().height / 2 + 3))
		var_35_23:setName("ItemSprite")

		local var_35_24 = math.min(var_35_23:getContentSize().width, var_35_23:getContentSize().height)
		local var_35_25 = 90 / var_35_24

		if var_35_15 and item_data[var_35_15] and item_data[var_35_15].bag_item_type == kITEM_SCULTURE then
			var_35_25 = 140 / var_35_24

			var_35_23:setPosition(cc.p(0, 20))
		end

		var_35_23:setScale(var_35_25)
		var_35_18:addChild(var_35_23)

		var_35_18.step = arg_35_2
		var_35_18.itemid = var_35_15

		var_35_7:setString("x" .. var_35_16)
		var_35_6:setVisible(true)
		var_35_18:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectindex = arg_36_0.step

			self:updateBtnStatus()

			if self.totalscore and self.totalscore >= arg_35_3.score and not self:isAwardHaveGet(arg_36_0.step) then
				self:dealGetAward(arg_36_0.step)
			else
				self:showItemDeatil(arg_36_0)
			end
		end)
	end
end

function AdventurerRandomLayer:showItemDeatil(arg_37_1)
	if type(arg_37_1.itemid) == "string" then
		return
	end

	local var_37_0 = item_data[arg_37_1.itemid].bag_item_type

	if item_data[arg_37_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_37_1 = -1
		local var_37_2 = require("data.item_data")[arg_37_1.itemid].horcruxtype

		for iter_37_0, iter_37_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_37_1.itemid == iter_37_1.item_id then
				var_37_1 = iter_37_0

				break
			end
		end

		if var_37_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_37_1,
			itemid = arg_37_1.itemid
		})
	elseif var_37_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_37_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_37_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_37_1.itemid
		})
	end
end

function AdventurerRandomLayer:isAwardHaveGet(arg_38_1)
	if not arg_38_1 or not self.gethaveaward or not next(self.gethaveaward) then
		return false
	end

	local var_38_0 = false

	for iter_38_0, iter_38_1 in pairs(self.gethaveaward) do
		if iter_38_1.rank == arg_38_1 and iter_38_1.havereceived then
			var_38_0 = true

			break
		end
	end

	return var_38_0
end

function AdventurerRandomLayer:getCurScoreIndex()
	if not self.awardData or not next(self.awardData) then
		return 1
	end

	local var_39_0 = self.totalnum

	while self.awardData[self.index_srt .. 1] do
		if self.totalscore <= self.awardData[self.index_srt .. 1].score then
			var_39_0 = 1

			break
		end
	end

	return var_39_0
end

function AdventurerRandomLayer:updateAwardData(arg_40_1)
	if not arg_40_1 or not self.gethaveaward then
		return
	end

	if not self:isAwardHaveGet(arg_40_1) then
		table.insert(self.gethaveaward, {
			havereceived = true,
			rank = arg_40_1
		})
	else
		for iter_40_0, iter_40_1 in pairs(self.gethaveaward) do
			if iter_40_1.rank == arg_40_1 then
				iter_40_1.havereceived = true
			end
		end
	end
end

function AdventurerRandomLayer:dealGetAward(arg_41_1)
	level_manager:get_adventure_score_awards(nil, self.modetype, arg_41_1, function(arg_42_0)
		if arg_42_0.result == 1 then
			self:updateAwardData(arg_41_1)
			self:updateAwardNode(self.awards[arg_41_1], arg_41_1, self.awardData[self.index_srt .. arg_41_1])
		else
			global_ShowBlockWords(L_AVAON_VISUAL.no_award)
		end
	end)
end

function AdventurerRandomLayer:getListData()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in pairs(levelmode_data) do
		if iter_43_1.modetype == self.modetype then
			table.insert(var_43_0, iter_43_1)
		end
	end

	if next(var_43_0) then
		table.sort(var_43_0, function(arg_44_0, arg_44_1)
			return arg_44_0.order < arg_44_1.order
		end)
	end

	self:updateListData(var_43_0)
	level_manager:is_have_adventure_awards(nil, self.modetype, function(arg_45_0)
		if not var_0_21 then
			return
		end

		if arg_45_0.result == 1 then
			self.gethaveaward = arg_45_0.awardlist

			self:addRedot()
		else
			self.gethaveaward = arg_45_0.awardlist

			self:addRedot()
		end

		if adverture_random_manager:isStepAward(self.modetype) then
			self:initAwardPanel()
		end
	end)
end

function AdventurerRandomLayer:updateListData(arg_46_1)
	level_manager:get_adventure_score(nil, self.modetype, function(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		if arg_47_0 == 1 then
			self.totalscore = arg_47_1
			self.rank = arg_47_3

			for iter_47_0, iter_47_1 in pairs(arg_47_2) do
				for iter_47_2, iter_47_3 in pairs(arg_46_1) do
					if iter_47_3.mode == iter_47_1.mode then
						iter_47_3.score = iter_47_1.score

						break
					end
				end
			end

			self.data = arg_46_1

			level_manager:setinfiniteScoreInfo(arg_47_2)
			self:initUILayer()
		end
	end)
end

function AdventurerRandomLayer.addRedot(arg_48_0, arg_48_1)
	return
end

function AdventurerRandomLayer.getDropData(arg_49_0, arg_49_1)
	local var_49_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_49_1 = drop_data[arg_49_1] or {}

	if var_49_1.gold then
		var_49_0.gold = var_49_0.gold + var_49_1.gold
	end

	if var_49_1.diamond then
		var_49_0.diamond = var_49_0.diamond + var_49_1.diamond
	end

	local var_49_2 = 1

	if var_49_1["drop_id" .. 1] then
		local var_49_3 = 1

		while var_49_1["drop_id" .. var_49_3] do
			var_49_0.items[var_49_2] = {
				itemid = var_49_1["drop_id" .. var_49_3],
				num = var_49_1["drop_num" .. var_49_3],
				rate = var_49_1["drop_rate" .. var_49_3]
			}
			var_49_3 = var_49_3 + 1
			var_49_2 = var_49_2 + 1
		end
	end

	if var_49_1["dropmodel_id" .. 1] then
		local var_49_4 = 1

		while var_49_1["dropmodel_id" .. var_49_4] do
			if drop_data[var_49_1["dropmodel_id" .. var_49_4]].gold then
				var_49_0.gold = var_49_0.gold + drop_data[var_49_1["dropmodel_id" .. var_49_4]].gold
			end

			if drop_data[var_49_1["dropmodel_id" .. var_49_4]].diamond then
				var_49_0.diamond = var_49_0.diamond + drop_data[var_49_1["dropmodel_id" .. var_49_4]].diamond
			end

			if drop_data[var_49_1["dropmodel_id" .. var_49_4]]["drop_id" .. 1] then
				local var_49_5 = 1

				while drop_data[var_49_1["dropmodel_id" .. var_49_4]]["drop_id" .. var_49_5] do
					var_49_0.items[var_49_2] = {
						itemid = drop_data[var_49_1["dropmodel_id" .. var_49_4]]["drop_id" .. var_49_5],
						num = drop_data[var_49_1["dropmodel_id" .. var_49_4]]["drop_num" .. var_49_5]
					}
					var_49_5 = var_49_5 + 1
					var_49_2 = var_49_2 + 1
				end
			end

			if drop_data[var_49_1["dropmodel_id" .. var_49_4]]["rd_drop_id" .. 1] then
				local var_49_6 = 1

				while drop_data[var_49_1["dropmodel_id" .. var_49_4]]["rd_drop_id" .. var_49_6] do
					var_49_0.items[var_49_2] = {
						itemid = drop_data[var_49_1["dropmodel_id" .. var_49_4]]["rd_drop_id" .. var_49_6],
						num = drop_data[var_49_1["dropmodel_id" .. var_49_4]]["rd_drop_num" .. var_49_6]
					}
					var_49_6 = var_49_6 + 1
					var_49_2 = var_49_2 + 1
				end
			end

			var_49_4 = var_49_4 + 1
		end
	end

	if var_49_1["rd_drop_id" .. 1] then
		local var_49_7 = 1

		while var_49_1["rd_drop_id" .. var_49_7] do
			var_49_0.items[var_49_2] = {
				itemid = var_49_1["rd_drop_id" .. var_49_7],
				num = var_49_1["rd_drop_num" .. var_49_7]
			}
			var_49_7 = var_49_7 + 1
			var_49_2 = var_49_2 + 1
		end
	end

	if var_49_1["rd_dropmodel_id" .. 1] then
		local var_49_8 = 1

		while var_49_1["rd_dropmodel_id" .. var_49_8] do
			if drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]].gold then
				var_49_0.gold = var_49_0.gold + drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]].gold
			end

			if drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]].diamond then
				var_49_0.diamond = var_49_0.diamond + drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]].diamond
			end

			if drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]]["drop_id" .. 1] then
				local var_49_9 = 1

				while drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]]["drop_id" .. var_49_9] do
					var_49_0.items[var_49_2] = {
						itemid = drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]]["drop_id" .. var_49_9],
						num = drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]]["drop_num" .. var_49_9]
					}
					var_49_9 = var_49_9 + 1
					var_49_2 = var_49_2 + 1
				end
			end

			if drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]]["rd_drop_id" .. 1] then
				local var_49_10 = 1

				while drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]]["rd_drop_id" .. var_49_10] do
					var_49_0.items[var_49_2] = {
						itemid = drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]]["rd_drop_id" .. var_49_10],
						num = drop_data[var_49_1["rd_dropmodel_id" .. var_49_8]]["rd_drop_num" .. var_49_10]
					}
					var_49_10 = var_49_10 + 1
					var_49_2 = var_49_2 + 1
				end
			end

			var_49_8 = var_49_8 + 1
		end
	end

	return var_49_0
end

function AdventurerRandomLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_51_0)
		if arg_51_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:initListView()
			end)
		end
	end), self)
end

function AdventurerRandomLayer:fullScreen(arg_53_1)
	arg_53_1:setContentSize((GameDisplay.getScreenSize()))
	arg_53_1:setPositionY(arg_53_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.title_panel:setPositionY(self.title_panel:getPositionY() + 2 * GameDisplay.fix_y)

	if self.awardtype == 1 then
		self.Listview:setContentSize(cc.size(640, 690 + 2 * GameDisplay.fix_y))
		self.Listview:setPositionY(self.Listview:getPositionY() - 230)
	elseif self.awardtype == 2 then
		self.Listview:setContentSize(cc.size(640, 560 + 2 * GameDisplay.fix_y))
		self.Listview:setPositionY(self.Listview:getPositionY() - 45)
	elseif self.awardtype == 3 then
		self.Listview:setContentSize(cc.size(640, 510 + 2 * GameDisplay.fix_y))
	end
end

function AdventurerRandomLayer:replaceActivityUi()
	local var_54_0, var_54_1 = adverture_random_manager:isHaveNewUI(self.modetype)

	if var_54_0 and var_54_1 then
		local var_54_2 = "mainScenebg/activity/branch" .. var_54_1 .. "/"

		self:loadTextures(self.awardpanel, ("mainScenebg/activity/branch" .. var_54_1 .. "/") .. var_0_14.awardbg, 1)

		if self:isFileExit(("mainScenebg/activity/branch" .. var_54_1 .. "/") .. var_0_14.bg) then
			local var_54_3 = ccui.ImageView:create(("mainScenebg/activity/branch" .. var_54_1 .. "/") .. var_0_14.bg)

			var_54_3:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
			self:addChild(var_54_3, -1)
		end

		local var_54_4 = {
			[154] = function()
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(178)
				self.score_label:setPositionY(155)
				self.score_label:setColor(cc.c3b(255, 255, 255))
				self.info2:setPosition(cc.p(self.info2:getPositionX() - 4, self.info2:getPositionY() - 80))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 24)
				self.info1:setPositionY(self.info1:getPositionY() - 80)
				self.info1:setPositionX(self.info1:getPositionX() - 40)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() - 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[173] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() - 70, self.info1:getPositionY() + 150)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 40)
				self.score_label:setPositionY(130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 5)
				self.Listview:setPositionY(self.Listview:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[230] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() - 20, self.info1:getPositionY() + 50)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 110)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 15)
				self.Listview:setPositionY(self.Listview:getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[264] = function()
				self.info2:setVisible(false)
				self.info1:setPosition(cc.p(150, 280))
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 70)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 50)
			end,
			[285] = function()
				self.info2:setVisible(false)
				self.info1:setPosition(cc.p(180, 165))
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 5)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 70)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 50)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setScale(1.1)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Image_32"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setPosition(320, 100)
			end,
			[304] = function()
				self:loadTextures(self.rankbtn, var_54_2 .. var_0_14.rank_btn, 2)
				self.info2:setVisible(false)
				self.info1:setPosition(cc.p(420, 240))

				if var_0_0 == 0 then
					self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 60)
				else
					self.awardpanel:setPositionY(self.awardpanel:getPositionY())
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 80)
				end

				local var_60_0 = ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 8

				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(var_60_0)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(var_60_0)
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(var_60_0)
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 5)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 70)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 50)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setScale(1.1)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Image_32"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setPosition(320, 100)
			end,
			[330] = function()
				self:loadTextures(self.rankbtn, var_54_2 .. var_0_14.rank_btn, 2)
				self.info2:setVisible(false)
				self.info1:setPosition(cc.p(165, 250))

				if var_0_0 == 0 then
					self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 60)
				else
					self.awardpanel:setPositionY(self.awardpanel:getPositionY())
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 80)
				end

				local var_61_0 = ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 8

				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(var_61_0)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(var_61_0)
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(var_61_0)
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 5)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 40)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 70)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setScale(1.1)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Image_32"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setPosition(510, 110)
			end,
			[405] = function()
				self:loadTextures(self.rankbtn, var_54_2 .. var_0_14.rank_btn, 2)
				self.info2:setVisible(false)
				self.info1:setPosition(cc.p(165, 250))

				if var_0_0 == 0 then
					self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 60)
				else
					self.awardpanel:setPositionY(self.awardpanel:getPositionY())
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 80)
				end

				self.score_label:setPosition(cc.p(60, 55))
				self.score_label:setColor(cc.c3b(255, 255, 255))

				local var_62_0 = ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 8

				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(var_62_0)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(var_62_0)
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(var_62_0)
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 5)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 40)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 70)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setScale(1.1)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Image_32"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setPosition(510, 110)
			end,
			[416] = function()
				self.info2:setVisible(false)
				self.info1:setPosition(cc.p(180, 160))

				if var_0_0 == 0 then
					self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 10)
				else
					self.awardpanel:setPositionY(self.awardpanel:getPositionY())
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 30)
				end

				self.score_label:setPosition(cc.p(60, 125))
				self.score_label:setColor(cc.c3b(0, 0, 0))

				local var_63_0 = ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 8

				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(var_63_0)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(var_63_0)
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(var_63_0)
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 5)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() - 100)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 50)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setScale(1.1)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Image_32"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setPosition(510, 110)
			end,
			[428] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() - 20, self.info1:getPositionY() + 50)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY())
				self.Listview:setPositionY(self.Listview:getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[436] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() - 20, self.info1:getPositionY() + 50)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(cc.p(90, 100 + GameDisplay.fix_y * 0.01))
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY())
				self.Listview:setPositionY(self.Listview:getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[451] = function()
				self:loadTextures(self.rankbtn, var_54_2 .. var_0_14.rank_btn, 2)
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 10)

				if var_0_0 == 0 then
					self.info1:setPosition(self.info1:getPositionX() + 30, self.info1:getPositionY() + 100)
					self.score_label:setPosition(cc.p(90, 120))
				else
					self.score_label:setPosition(cc.p(90, 92 + GameDisplay.fix_y * 0.14))
					self.info1:setPosition(self.info1:getPositionX() - 30, self.info1:getPositionY() + 30)
				end

				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 35)
				self.Listview:setPositionY(self.Listview:getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 10)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() - 95)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 60)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setFontSize(20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setVisible(false)
			end,
			[457] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() + 50, self.info1:getPositionY() + 50)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				self.Listview:setPositionY(self.Listview:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[462] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() + 50, self.info1:getPositionY() + 100)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				self.Listview:setPositionY(self.Listview:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[471] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() + 35, self.info1:getPositionY() + 10)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				self.Listview:setPositionY(self.Listview:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[481] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() + 50, self.info1:getPositionY() + 100)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				self.Listview:setPositionY(self.Listview:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[490] = function()
				self:loadTextures(self.rankbtn, var_54_2 .. var_0_14.rank_btn, 2)
				self.info2:setVisible(false)
				self.info1:setPosition(cc.p(420, 240))

				if var_0_0 == 0 then
					self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 60)
				else
					self.awardpanel:setPositionY(self.awardpanel:getPositionY())
					self.Listview1:setPositionY(self.Listview1:getPositionY() - 80)
				end

				local var_71_0 = ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 8

				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(var_71_0)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(var_71_0)
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(var_71_0)
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 5)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 70)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 50)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setScale(1.1)
				ccui.Helper:seekWidgetByName(self.items, "Image_32"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Image_32"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(self.items, "Label_34"):setPosition(320, 100)
			end,
			[492] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() + 50, self.info1:getPositionY() + 100)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				self.Listview:setPositionY(self.Listview:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[500] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() + 50, self.info1:getPositionY() + 100)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				self.Listview:setPositionY(self.Listview:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end,
			[507] = function()
				self.info2:setVisible(false)
				self.info1:setAnchorPoint(cc.p(0.5, 1))
				self.info1:setPosition(self.info1:getPositionX() + 50, self.info1:getPositionY() + 100)
				self.awardpanel:setPositionY(self.awardpanel:getPositionY() - 20)
				self.score_label:setPosition(85, 130)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				self.Listview1:setPositionY(self.Listview1:getPositionY() - 20)
				self.Listview:setPositionY(self.Listview:getPositionY() - 20)
				ccui.Helper:seekWidgetByName(self.items, "img_1"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.items, "img_2"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "img_3"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "img_1"):getPositionY())
				ccui.Helper:seekWidgetByName(self.items, "Label_58"):setPositionY(ccui.Helper:seekWidgetByName(self.items, "Label_58"):getPositionY() + 20)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionY(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionY() + 80)
				ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setPositionX(ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):getPositionX() - 40)
			end
		}

		if var_54_4[var_54_1] then
			var_54_4[var_54_1]()
		end
	end

	if var_54_1 == 333 then
		ccui.Helper:seekWidgetByName(self.items, "Label_34"):setAnchorPoint(cc.p(1, 0.5))
		ccui.Helper:seekWidgetByName(self.items, "Label_34"):setPosition(600, 120)
	end

	local var_54_5 = adverture_random_manager:getActivityBgm(self.modetype)

	if var_54_5 then
		audio_manager:switchLayerBGM(var_54_5, true)
	else
		audio_manager:switchLayerBGM(MAIN_BGM, true)
	end
end

function AdventurerRandomLayer:replaceActivityFightUI(arg_75_1)
	local var_75_0, var_75_1 = adverture_random_manager:isHaveNewUI(self.modetype)

	if var_75_0 and var_75_1 then
		self:loadTextures(self.info1, ("mainScenebg/activity/branch" .. var_75_1 .. "/") .. var_0_14["fight_" .. arg_75_1], 2)
		self:loadTextures(self.title_panel, ("mainScenebg/activity/branch" .. var_75_1 .. "/") .. var_0_14.title, 1)
	end
end

function AdventurerRandomLayer:replaceActivityProgressBarUI(arg_76_1)
	local var_76_0, var_76_1 = adverture_random_manager:isHaveNewUI(self.modetype)

	if var_76_0 and var_76_1 and var_0_15[var_76_1] then
		self:loadTextures(ccui.Helper:seekWidgetByName(arg_76_1, "ProgressBar_61"), ("mainScenebg/activity/branch" .. var_76_1 .. "/") .. var_0_14.progress_bar, 1)
		self:loadTextures(ccui.Helper:seekWidgetByName(arg_76_1, "progress_di"), ("mainScenebg/activity/branch" .. var_76_1 .. "/") .. var_0_14.progress_di, 1)
	end
end

function AdventurerRandomLayer:replaceActivityItemUI(arg_77_1)
	arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(255, 255, 255))
	arg_77_1:getChildByName("ceshu"):setPositionY(154)

	local var_77_0, var_77_1 = adverture_random_manager:isHaveNewUI(self.modetype)

	if arg_77_1 and var_77_0 and var_77_1 then
		local var_77_2 = "mainScenebg/activity/branch" .. var_77_1 .. "/"

		self:loadTextures(arg_77_1, ("mainScenebg/activity/branch" .. var_77_1 .. "/") .. var_0_14.itembg, 3)
		self:loadTextures(arg_77_1:getChildByName("name_di"), ("mainScenebg/activity/branch" .. var_77_1 .. "/") .. var_0_14.namebg, 1)

		local var_77_3 = {
			[154] = function()
				arg_77_1:getChildByName("bossface"):setScale(0.32)
				arg_77_1:getChildByName("bossface"):setPositionY(106)
			end,
			[173] = function()
				arg_77_1:getChildByName("bossface"):setScale(0.32)
				arg_77_1:getChildByName("bossface"):setPositionY(106)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(520, 50)
				end)))

				local var_79_0 = ccui.ImageView:create("mainScenebg/activity/branch173/randomade_bg.jpg")

				var_79_0:setPosition(cc.p(320, GameDisplay.height / 2))
				self.rootLayer:addChild(var_79_0, -1)
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(39, 31, 30))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(39, 31, 30))
				arg_77_1:getChildByName("img_" .. 1):setPositionY(60)
				arg_77_1:getChildByName("img_" .. 2):setPositionY(60)
			end,
			[230] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 134)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("ceshu"):setPosition(550, 162)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(157, 39, 33))
				self.score_label:setColor(cc.c3b(157, 39, 33))
				self.score_label:setFontSize(37)
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(88, 51, 15))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPositionX(106)
				arg_77_1:getChildByName("img_" .. 1):setPositionY(72)
				arg_77_1:getChildByName("img_" .. 2):setPositionY(72)
				arg_77_1:getChildByName("img_" .. 3):setPositionY(72)
			end,
			[264] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 134)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPositionX(arg_77_1:getChildByName("change_btn"):getPositionX() - 20)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(550, 152)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(255, 255, 255))
				self.score_label:setFontSize(20)
				self.score_label:setColor(cc.c3b(39, 31, 30))

				if var_0_0 == 0 then
					self.score_label:setPosition(120, 150)
				else
					self.score_label:setPosition(120, 130)
				end

				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(88, 51, 15))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(140, 40))
				arg_77_1:getChildByName("img_" .. 1):setPositionY(70)
				arg_77_1:getChildByName("img_" .. 2):setPositionY(70)
				arg_77_1:getChildByName("img_" .. 3):setPositionY(70)
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(39, 31, 30))
			end,
			[285] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 119)
				arg_77_1:getChildByName("bossface"):setScale(0.35)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPositionX(arg_77_1:getChildByName("change_btn"):getPositionX() + 12)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(520, 160)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				self.score_label:setFontSize(20)
				self.score_label:setColor(cc.c3b(39, 31, 30))

				if var_0_0 == 0 then
					self.score_label:setPosition(50, 125)
				else
					self.score_label:setPosition(50, 105)
				end

				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(88, 51, 15))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("img_" .. 1):setPositionY(65)
				arg_77_1:getChildByName("img_" .. 2):setPositionY(65)
				arg_77_1:getChildByName("img_" .. 3):setPositionY(65)
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(255, 242, 221))
			end,
			[304] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 119)
				arg_77_1:getChildByName("bossface"):setScale(0.35)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(560, 60)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(520, 160)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(255, 255, 255))
				self.score_label:setFontSize(20)
				self.score_label:setColor(cc.c3b(255, 255, 255))

				if var_0_0 == 0 then
					self.score_label:setPosition(50, 67)
				else
					self.score_label:setPosition(50, 47)
				end

				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(226, 22, 94))
			end,
			[330] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 119)
				arg_77_1:getChildByName("bossface"):setScale(0.35)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(560, 60)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 155)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(255, 255, 255))
				self.score_label:setFontSize(30)
				self.score_label:setColor(cc.c3b(255, 255, 255))

				if var_0_0 == 0 then
					self.score_label:setPosition(50, 57)
				else
					self.score_label:setPosition(50, 47)
				end

				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(255, 247, 164))
			end,
			[416] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 110)
				arg_77_1:getChildByName("bossface"):setScale(0.35)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(565, 60)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(520, 160)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(77, 56, 51))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(255, 247, 164))
			end,
			[433] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 134)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPositionX(arg_77_1:getChildByName("change_btn"):getPositionX() - 20)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(550, 152)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(255, 255, 255))
				self.score_label:setFontSize(20)
				self.score_label:setColor(cc.c3b(39, 31, 30))

				if var_0_0 == 0 then
					self.score_label:setPosition(120, 150)
				else
					self.score_label:setPosition(120, 130)
				end

				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(88, 51, 15))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(140, 40))
				arg_77_1:getChildByName("img_" .. 1):setPositionY(70)
				arg_77_1:getChildByName("img_" .. 2):setPositionY(70)
				arg_77_1:getChildByName("img_" .. 3):setPositionY(70)
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(39, 31, 30))
			end,
			[428] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 110)
				arg_77_1:getChildByName("bossface"):setScale(0.35)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(565, 60)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(560, 162)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(77, 56, 51))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(255, 247, 164))
			end,
			[451] = function()
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(540, 80)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 150)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(0, 0, 0))
			end,
			[457] = function()
				self.score_label:setColor(cc.c3b(255, 255, 255))
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(540, 80)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 150)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(0, 0, 0))
			end,
			[462] = function()
				self.score_label:setPositionY(100)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(540, 80)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 150)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(255, 255, 255))
			end,
			[471] = function()
				self.score_label:setPositionY(100)
				self.score_label:setColor(cc.c3b(255, 255, 255))
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(540, 80)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 150)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(0, 0, 0))
			end,
			[481] = function()
				self.score_label:setPositionY(110)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(540, 80)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 160)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(255, 255, 255))
			end,
			[490] = function()
				arg_77_1:getChildByName("bossface"):setPosition(91, 119)
				arg_77_1:getChildByName("bossface"):setScale(0.35)
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(560, 60)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(520, 160)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(255, 255, 255))
				self.score_label:setFontSize(20)
				self.score_label:setColor(cc.c3b(255, 255, 255))

				if var_0_0 == 0 then
					self.score_label:setPosition(50, 67)
				else
					self.score_label:setPosition(50, 47)
				end

				self.score_label:setAnchorPoint(cc.p(0.5, 0.5))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(226, 22, 94))
			end,
			[492] = function()
				self.score_label:setPositionY(107)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(540, 80)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 150)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(0, 0, 0))
			end,
			[500] = function()
				self.score_label:setPositionY(107)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(540, 80)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 150)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(0, 0, 0))
			end,
			[507] = function()
				self.score_label:setPositionY(107)
				self.score_label:setColor(cc.c3b(0, 0, 0))
				arg_77_1:getChildByName("change_btn"):loadTextures(var_77_2 .. var_0_14.change_btn, nil, var_77_2 .. var_0_14.change_btn)
				arg_77_1:getChildByName("change_btn"):setVisible(false)
				arg_77_1:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					arg_77_1:getChildByName("change_btn"):setVisible(true)
					arg_77_1:getChildByName("change_btn"):setPosition(540, 80)
				end)))
				arg_77_1:getChildByName("ceshu"):setPosition(420, 150)
				arg_77_1:getChildByName("ceshu"):setColor(cc.c3b(0, 0, 0))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setColor(cc.c3b(255, 255, 255))
				ccui.Helper:seekWidgetByName(arg_77_1, "bossname"):setFontSize(20)
				arg_77_1:getChildByName("name_di"):setPosition(cc.p(87, 31))
				arg_77_1:getChildByName("Label_58"):setColor(cc.c3b(0, 0, 0))
			end
		}

		if var_77_3[var_77_1] then
			var_77_3[var_77_1]()
		end
	end
end

function AdventurerRandomLayer.isFileExit(arg_114_0, arg_114_1)
	return true
end

function AdventurerRandomLayer:loadTextures(arg_115_1, arg_115_2, arg_115_3)
	if not arg_115_1 or not arg_115_2 or not arg_115_3 then
		return
	end

	if self:isFileExit(arg_115_2) then
		if arg_115_3 == 1 then
			arg_115_1:loadTexture(arg_115_2)
		elseif arg_115_3 == 2 then
			arg_115_1:loadTextures(arg_115_2, nil, arg_115_2)
		elseif arg_115_3 == 3 then
			arg_115_1:setBackGroundImage(arg_115_2)
		end
	end
end

function AdventurerRandomLayer.createStarLayout(arg_116_0)
	local var_116_0 = TempWidget:CreateTempLayout()

	var_116_0:setContentSize(cc.size(40, 30 * 5))
	var_116_0:setName("satrLayout")

	for iter_116_0 = 1, 5 do
		local var_116_1 = TempWidget:CreateTempImg("public/currency/weapon_star.png", var_116_0)

		var_116_1:align(cc.p(0.5, 1), var_116_0:size().w / 2, var_116_0:size().h - (iter_116_0 - 1) * 30)
		var_116_1:setName("star" .. iter_116_0)
	end

	function var_116_0:setStarLevel(arg_117_1)
		for iter_117_0 = 1, 5 do
			local var_117_0 = self:getChildByName("star" .. iter_117_0)

			var_117_0:setVisible(iter_117_0 <= arg_117_1)

			if iter_117_0 == 1 or iter_117_0 == 2 then
				if arg_117_1 - iter_117_0 >= 5 then
					var_117_0:loadTextureEx("public/currency/pink_star.png")
				else
					var_117_0:loadTextureEx("public/currency/weapon_star.png")
				end
			end
		end
	end

	return var_116_0
end
