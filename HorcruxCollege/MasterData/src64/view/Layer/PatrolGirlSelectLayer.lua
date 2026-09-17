PatrolGirlSelectLayer = class("PatrolGirlSelectLayer", function()
	return cc.Layer:create()
end)

local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local npc_data = require("data.npc_data")
local dorm_property_data = require("data.dorm_property_data")
local servant_data = require("data.servant_data")
local skillup_cos_data = require("data.skillup_cos_data")
local fitness_data = require("data.fitness_data")
local core_data = require("data.core_data")
local playermodel = require("model.playermodel")
local array_manager = require("controller.array_manager")
local model_manager = require("controller.model_manager")
local component_manager = require("controller.component_manager")
local weapon_manager = require("controller.weapon_manager")
local core_manager = require("controller.core_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local explore_manager = require("controller.explore_manager")
local item_manager = require("controller.item_manager")
local filter_config_manager = require("controller.filter_config_manager")
local audio_manager = require("controller.audio_manager")
local train_manager = require("controller.train_manager")
local patrol_manager = require("controller.patrol_manager")
local time_check_manager = require("controller.time_check_manager")
local marry_manager = require("controller.marry_manager")
local souls_manager = require("controller.souls_manager")
local json = require("json")

require("view.Sprite.FilterSprite")
require("view.Sprite.FilterListSprite")

local var_0_26
local var_0_29 = 1
local var_0_30 = 0
local var_0_31 = -58
local var_0_32 = "public/box/used_on.png"
local var_0_33 = config._DEBUG and 0 or 1

function PatrolGirlSelectLayer.getInstance()
	return var_0_26
end

function PatrolGirlSelectLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = PatrolGirlSelectLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function PatrolGirlSelectLayer:init(arg_5_1)
	var_0_26 = self
	self.initconfig = arg_5_1
	self.exitCallback = arg_5_1.exitCallback or nil
	self.sureCallback = arg_5_1.sureCallback or nil
	self.selectTblAni = true
	self.selectGirls = arg_5_1.servants and cloneconf(arg_5_1.servants) or {}
	self.curIndexs = {}
	self.curData = {}

	self:initGirlData()
	self:initUI()
	self:initButtomBtnList()
	self:initGirlListPanel()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.initconfig.exitcallback then
				self.initconfig.exitcallback()
			end

			var_0_26 = nil
		end
	end)
	self:initDisplay(self.rootLayer)

	self.selectTblAni = false
end

function PatrolGirlSelectLayer:initUI()
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 10)
	self:createTitleSprite()
end

function PatrolGirlSelectLayer:createTitleSprite()
	self.title = TitleSprite:create("GirlSelectLayer/title_rolelist.png", 2)

	self.title:setName("title")
	self.title:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.rootLayer:addChild(self.title, 5)

	local var_8_0 = cc.Label:createWithTTF(L_PATROL_SELECT_TIPS, FONT_DES, 18)

	var_8_0:setPosition(self.title:getContentSize().width / 2, self.title:getContentSize().height / 2)
	self.title:addChild(var_8_0)

	self.button_attribute = ccui.Button:create("public/filter/attr_icon_off.png", "public/filter/attr_icon_off.png", nil, var_0_33)

	self.button_attribute:setPositionX(600)
	self.button_attribute:setPositionY(self.title:getContentSize().height / 2)

	self.button_attribute.isClickOn = false

	self.title:addChild(self.button_attribute, 5)
	self.button_attribute:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.isShowAttrs = not self.isShowAttrs
		arg_9_0.isClickOn = not arg_9_0.isClickOn

		if arg_9_0.isClickOn == false then
			arg_9_0:loadTextures("public/filter/attr_icon_off.png", "public/filter/attr_icon_off.png", nil, var_0_33)
		else
			arg_9_0:loadTextures("public/filter/attr_icon_on.png", "public/filter/attr_icon_on.png", nil, var_0_33)
		end

		self:updateShowingCells()
	end)
	self.button_attribute:setVisible(self.selectType ~= SELECT_GIRL_HOME)
end

local function var_0_35(arg_10_0, arg_10_1)
	local var_10_0 = servant_data[arg_10_0].modelid

	if model_data[servant_data[arg_10_0].modelid].imaginary then
		return true
	end

	return model_data[var_10_0][arg_10_1] ~= nil
end

function PatrolGirlSelectLayer:initGirlData()
	self.allData = {}

	local var_11_0 = self.initconfig.patrol_conditions.rank
	local var_11_1 = self.initconfig.patrol_conditions.lv

	local function var_11_2(arg_12_0)
		if core_manager:getServantCoreRank(arg_12_0) >= var_11_0 and (playermodel.cores[arg_12_0].afk_lv or core_manager:getServantCoreOfhundred(arg_12_0)) >= var_11_1 then
			return true
		else
			return false
		end
	end

	local var_11_3 = {
		unlock = {},
		lock = {}
	}
	local var_11_4 = {
		unlock = {},
		lock = {}
	}

	for iter_11_0, iter_11_1 in pairs(servant_data) do
		if not patrol_manager:isServantPatrolNow(iter_11_1.id) and playermodel.haveServant[iter_11_1.id] and iter_11_1.classtype == 1 then
			if var_0_35(iter_11_1.id, "imaginary") then
				if var_11_2(iter_11_1.id) then
					table.insert(var_11_4.unlock, iter_11_1.id)
				else
					table.insert(var_11_4.lock, iter_11_1.id)
				end

				table.insert(self.allData, iter_11_1.id)
			elseif var_0_35(iter_11_1.id, self.initconfig.patrol_conditions.ele) then
				if var_11_2(iter_11_1.id) then
					table.insert(var_11_3.unlock, iter_11_1.id)
				else
					table.insert(var_11_3.lock, iter_11_1.id)
				end

				table.insert(self.allData, iter_11_1.id)
			end
		end
	end

	local function var_11_5(arg_13_0, arg_13_1)
		return core_manager:getServantCoreValue(arg_13_0) > core_manager:getServantCoreValue(arg_13_1)
	end

	table.sort(var_11_3.unlock, var_11_5)
	table.sort(var_11_3.lock, var_11_5)
	table.sort(var_11_4.unlock, var_11_5)
	table.sort(var_11_4.lock, var_11_5)

	local var_11_6 = {}

	for iter_11_2, iter_11_3 in pairs(self.selectGirls) do
		var_11_6[iter_11_3] = true
	end

	for iter_11_4, iter_11_5 in ipairs({
		var_11_3.unlock,
		var_11_4.unlock,
		var_11_3.lock,
		var_11_4.lock
	}) do
		for iter_11_6, iter_11_7 in ipairs(iter_11_5) do
			if not var_11_6[iter_11_7] then
				table.insert(self.curData, iter_11_7)
			end
		end
	end

	for iter_11_8, iter_11_9 in pairs(self.curData) do
		for iter_11_10, iter_11_11 in pairs(self.selectGirls) do
			if iter_11_11 == iter_11_9 then
				self.curIndexs[iter_11_8] = true
			end
		end
	end
end

function PatrolGirlSelectLayer.getGotoEquipLayerHandler(arg_14_0)
	return function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			cursoul = arg_14_0.selectGirl
		})
	end
end

function PatrolGirlSelectLayer:layerOutAni(arg_16_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME * 2), cc.CallFunc:create(arg_16_1)))
end

function PatrolGirlSelectLayer:initButtomBtnList(arg_17_1)
	if self.rootLayer:getChildByName("bottomlist") then
		self.rootLayer:getChildByName("bottomlist"):removeFromParent()
	end

	local function var_17_0(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_26 = nil

		self:layerOutAni(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end

	self.bottomList = next(self.allData) and BottomBtnList:create(var_17_0, {
		{
			name = "select",
			word = L_GIRL_SELECT_WORD.SELECT_GIRL_DATABASE,
			handler = self:initButtonSure()
		}
	}) or BottomBtnList:create(var_17_0)

	self.bottomList:setName("bottomlist")

	if self.bottomList:getChildByName("select") then
		self.bottomList:getChildByName("select"):loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_33)
		self.bottomList:getChildByName("select"):setVisible(false)
	end

	self.rootLayer:addChild(self.bottomList, 10)

	self.conditionPanel = ccui.Layout:create()

	self.conditionPanel:setName("conditionPanel")
	self.bottomList:addChild(self.conditionPanel)

	local var_17_1 = cc.Label:createWithTTF("000", FONT_NAME, 30)

	var_17_1:setAnchorPoint(cc.p(0, 0.5))
	var_17_1:setPosition(120, self.bottomList:getContentSize().height / 2)
	var_17_1:setColor(cc.c3b(255, 255, 255))
	var_17_1:setName("lv_label")
	self.conditionPanel:addChild(var_17_1, 10)

	local var_17_2 = ccui.ImageView:create("public/rolebg/breakout_0.png", var_0_33)

	var_17_2:setName("rank_icon")
	var_17_2:setPosition(260, self.bottomList:getContentSize().height / 2)
	self.conditionPanel:addChild(var_17_2)

	local var_17_3 = cc.Label:createWithTTF("0/0", FONT_NAME, 30)

	var_17_3:setAnchorPoint(cc.p(0, 0.5))
	var_17_3:setPosition(350, self.bottomList:getContentSize().height / 2)
	var_17_3:setColor(cc.c3b(255, 255, 255))
	var_17_3:setName("total_num")
	self.conditionPanel:addChild(var_17_3, 10)
	self:updateButtomBtnList()
end

function PatrolGirlSelectLayer:updateButtomBtnList()
	if next(self.allData) then
		self.bottomList:getChildByName("select"):setVisible(next(self.selectGirls) ~= nil)
		self.bottomList:getChildByName("select"):setVisible(false)
	end

	local var_20_0 = self.conditionPanel:getChildByName("lv_label")
	local var_20_1 = self.conditionPanel:getChildByName("rank_icon")
	local var_20_2 = self.conditionPanel:getChildByName("total_num")

	var_20_0:setString("Lv:" .. self.initconfig.patrol_conditions.lv)

	local var_20_3 = 0

	for iter_20_0, iter_20_1 in pairs(self.selectGirls) do
		var_20_3 = var_20_3 + 1
	end

	var_20_2:setString(var_20_3 .. "/" .. self.initconfig.patrol_conditions.total_num)
	var_20_1:loadTexture("public/rolebg/breakout_" .. self.initconfig.patrol_conditions.rank .. ".png", var_0_33)
	var_20_1:setPositionX(var_20_0:getPositionX() + var_20_0:getContentSize().width + var_20_1:getContentSize().width / 2)

	if self.initconfig.patrol_conditions.total_num <= var_20_3 then
		var_20_2:setColor(cc.c3b(166, 226, 45))
	else
		var_20_2:setColor(cc.c3b(248, 51, 51))
	end
end

function PatrolGirlSelectLayer.initButtonSure(arg_21_0)
	return function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(arg_21_0.__queueindex)
	end
end

function PatrolGirlSelectLayer:createCell(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = cc.size(180, 254)
	local var_23_1 = global_get_servant_skin(arg_23_2)

	arg_23_1.modelid = var_23_1

	arg_23_1:loadTextures("public/rolebg/rarity_4_bg.png", "public/rolebg/rarity_4_bg.png", "public/rolebg/rarity_4_bg.png", var_0_33)

	local var_23_3 = ccui.Layout:create()

	var_23_3:setBackGroundImageColor(cc.c3b(255, 0, 0))
	var_23_3:setContentSize(var_23_0)
	var_23_3:setAnchorPoint(cc.p(0, 0))
	var_23_3:setPosition((cc.p(8, 8)))
	var_23_3:setClippingEnabled(true)
	var_23_3:setBackGroundColor(cc.c3b(0, 0, 0))
	var_23_3:setName("clipLayer")
	arg_23_1:addChild(var_23_3, 2)

	local var_23_4 = ccui.Layout:create()

	var_23_4:setContentSize(var_23_0)
	var_23_4:setAnchorPoint(cc.p(0, 0))
	var_23_4:setPosition(0, 0)
	var_23_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_23_4:setBackGroundColor(cc.c3b(0, 0, 0))
	var_23_4:setBackGroundColorOpacity(180)
	var_23_4:setName("maskLayer")
	var_23_4:setTouchEnabled(false)
	var_23_3:addChild(var_23_4, 999)

	local var_23_5 = ccui.ImageView:create(PANEL_ROLE_IMAGE_PATH .. model_data[var_23_1].role_image .. ".png")

	var_23_5:setScale(var_0_29)
	var_23_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_5:setPosition(cc.p(var_23_3:getContentSize().width / 2 + var_0_30, var_23_3:getContentSize().height / 2 + var_0_31))
	var_23_5:setName("photo")
	var_23_3:addChild(var_23_5)

	local var_23_6 = cc.Label:createWithTTF(L_GIRL_SELECT_CELL.Name_Label, FONT_NAME, 20)

	var_23_6:setPosition(cc.p(130, 10))
	var_23_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_6:setName("nameLabel")
	var_23_6:setVisible(false)
	arg_23_1:addChild(var_23_6, 4)

	local var_23_7 = cc.Label:createWithTTF("000", FONT_NAME, 30)

	var_23_7:setPosition(cc.p(arg_23_1:getContentSize().width - 15, -10))
	var_23_7:setAnchorPoint(cc.p(1, 0))
	var_23_7:setColor(cc.c3b(255, 255, 255))
	var_23_7:setName("levelLabel1")
	arg_23_1:addChild(var_23_7, 10)

	local var_23_8 = ccui.ImageView:create("public/rolebg/break_limit_num_bg.png", var_0_33)

	var_23_8:setPosition(cc.p(0, 0))
	var_23_8:setAnchorPoint(cc.p(0, 0))
	var_23_8:setScale(var_23_3:getContentSize().width / var_23_8:getContentSize().width)
	var_23_8:setName("soulBreakNumBg")
	var_23_3:addChild(var_23_8, 4)

	local var_23_9 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_33)

	var_23_9:setPositionX(var_23_7:getPositionX() - var_23_7:getContentSize().width - 8)
	var_23_9:setPositionY(15)
	var_23_9:setName("lvIcon")
	arg_23_1:addChild(var_23_9, 6)

	local var_23_11 = ccui.ImageView:create("public/rolebg/+0.png", var_0_33)

	var_23_11:setPosition(cc.p(5, var_23_3:getPositionY() + var_23_3:getContentSize().height - var_23_11:getContentSize().height / 2))
	var_23_11:setAnchorPoint(cc.p(0, 0.5))
	var_23_11:setName("soulBreakNum")
	arg_23_1:addChild(var_23_11, 8)

	local var_23_12 = ccui.ImageView:create(CAREER_ICON[servant_data[arg_23_2].career .. "_" .. self:getAttrIconPath(arg_23_2)], var_0_33)

	var_23_12:setPosition(cc.p(6, 6))
	var_23_12:setAnchorPoint(cc.p(0, 0))
	var_23_12:setScale(0.56)
	var_23_12:setName("careerIcon")
	arg_23_1:addChild(var_23_12, 8)

	local var_23_13 = ccui.ImageView:create(SHOT_RARITY_CION[0], var_0_33)

	var_23_13:setAnchorPoint(cc.p(1, 1))
	var_23_13:setPosition(cc.p(var_23_3:getPositionX() + var_23_3:getContentSize().width + 5, var_23_3:getPositionY() + var_23_3:getContentSize().height + 5))
	var_23_13:setName("rarityIcon")
	arg_23_1:addChild(var_23_13, 8)

	local var_23_14 = ccui.ImageView:create("public/rolebg/breakout_0.png", var_0_33)

	var_23_14:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_14:setPosition(cc.p(arg_23_1:getContentSize().width - var_23_14:getContentSize().width / 2, 50))
	var_23_14:setName("breakoutIcon")
	arg_23_1:addChild(var_23_14, 8)
	self:updateGirlInfo(arg_23_1, arg_23_2)

	local var_23_15 = ccui.ImageView:create(var_0_32, var_0_33)

	var_23_15:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_15:setScale9Enabled(true)
	var_23_15:setCapInsets(cc.rect(50, 20, 1, 1))
	var_23_15:setContentSize(cc.size(arg_23_1:getContentSize().width - 8, var_23_15:getContentSize().height))
	var_23_15:setPosition(cc.p(arg_23_1:getContentSize().width / 2, 70))
	var_23_15:setName("fightingtag")

	local var_23_16 = ccui.Text:create("点", "fonts/number.ttf", 26)

	var_23_16:setPosition(cc.p(var_23_15:getContentSize().width / 2, var_23_15:getContentSize().height / 2))
	var_23_16:setName("fightlabel")
	var_23_15:addChild(var_23_16)
	arg_23_1:addChild(var_23_15, 2000)

	pressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

	pressBar:setScale(0.8)
	pressBar:setName("pressBar")
	pressBar:setAnchorPoint(cc.p(0.5, 0.5))
	pressBar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	pressBar:setPositionX(arg_23_1:getContentSize().width / 2)
	pressBar:setPositionY(arg_23_1:getContentSize().height / 2)
	pressBar:setReverseDirection(true)
	pressBar:setVisible(false)
	arg_23_1:addChild(pressBar, 2999)

	function pressBar:startPressBar(arg_24_1, arg_24_2)
		local var_24_0 = 0.3
		local var_24_1 = 0

		self:setVisible(true)
		self:setPercentage(0)
		self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
			self:setPercentage(var_24_1 / var_24_0 * 100)

			if var_24_1 > var_24_0 then
				self:stopAllActions()

				if arg_24_1 then
					arg_24_1()
				end
			end

			var_24_1 = var_24_1 + 0.016666666666666666

			if arg_24_2 then
				arg_24_2(0.016666666666666666)
			end
		end))))
	end

	function pressBar:endPressBar()
		self:setVisible(false)
		self:stopAllActions()
	end

	self:updateCell(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
end

function PatrolGirlSelectLayer:updateCell(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = global_get_servant_skin(arg_27_2)

	arg_27_1.modelid = var_27_0

	arg_27_1:getChildByName("clipLayer"):getChildByName("photo"):loadTexture(PANEL_ROLE_IMAGE_PATH .. model_data[var_27_0].role_image .. ".png")
	arg_27_1:getChildByName("nameLabel"):setString(servant_data[arg_27_2].name)
	arg_27_1:getChildByName("info_page"):setVisible(self.isShowAttrs)

	local var_27_1 = arg_27_1:getChildByName("fightingtag")
	local var_27_2 = var_27_1:getChildByName("fightlabel")
	local var_27_3 = arg_27_1:getChildByName("levelLabel1")
	local var_27_4 = arg_27_1:getChildByName("lvIcon")

	arg_27_1:getChildByName("nameLabel"):setVisible(self.isShowAttrs)
	arg_27_1:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_27_2].career .. "_" .. self:getAttrIconPath(arg_27_2)], var_0_33)

	local var_27_5 = core_manager:getServantCoreRank(arg_27_2)
	local var_27_6 = playermodel.cores[arg_27_2].afk_lv or core_manager:getCoreLv(arg_27_2)

	var_27_3:setString(var_27_6)
	var_27_4:setPositionX(var_27_3:getPositionX() - var_27_3:getContentSize().width - 8)
	var_27_3:setVisible(true)
	var_27_4:setVisible(true)
	var_27_4:setVisible(not self.isShowAttrs)
	arg_27_1:getChildByName("levelLabel1"):setVisible(not self.isShowAttrs)

	local var_27_7 = playermodel.soulContract[arg_27_2] or 0
	local var_27_8 = playermodel.soulOverClock[arg_27_2] or 0

	if var_27_7 > 0 and var_27_8 == 0 then
		arg_27_1:getChildByName("soulBreakNum"):setVisible(true)
		arg_27_1:getChildByName("soulBreakNum"):loadTexture("public/rolebg/+" .. var_27_7 .. ".png", var_0_33)
	elseif var_27_8 > 0 then
		arg_27_1:getChildByName("soulBreakNum"):setVisible(true)
		arg_27_1:getChildByName("soulBreakNum"):loadTexture("public/rolebg/oc.png", var_0_33)
	else
		arg_27_1:getChildByName("soulBreakNum"):setVisible(false)
	end

	local var_27_9 = souls_manager:get_servant_cur_roll_rarity(arg_27_2)
	local var_27_10 = core_manager:getServantCoreRank(arg_27_2)

	arg_27_1:getChildByName("rarityIcon"):loadTexture(SHOT_RARITY_CION[var_27_9], var_0_33)
	arg_27_1:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_27_10 .. ".png", var_0_33)
	arg_27_1:getChildByName("breakoutIcon"):setVisible(var_27_10 ~= 0)
	arg_27_1:loadTextures("public/rolebg/rarity_" .. var_27_9 .. "_bg.png", "public/rolebg/rarity_" .. var_27_9 .. "_bg.png", "public/rolebg/rarity_" .. var_27_9 .. "_bg.png", var_0_33)
	var_27_2:setString("已选中")
	self:updateGirlInfo(arg_27_1, arg_27_2)

	if self.curIndexs[arg_27_3] then
		var_27_1:setVisible(true)

		if not arg_27_1:getChildByName("heightLight") then
			self:createItemHightLight(arg_27_1)
		end
	else
		var_27_1:setVisible(false)

		if arg_27_1:getChildByName("heightLight") then
			arg_27_1:removeChildByName("heightLight")
		end
	end

	if (function()
		if var_27_10 >= self.initconfig.patrol_conditions.rank and var_27_6 >= self.initconfig.patrol_conditions.lv then
			return true
		else
			return false
		end
	end)() then
		arg_27_1:getChildByName("clipLayer"):getChildByName("maskLayer"):setVisible(false)
	else
		arg_27_1:getChildByName("clipLayer"):getChildByName("maskLayer"):setVisible(true)
	end
end

local var_0_36 = 640
local var_0_37 = 1030
local var_0_38 = 0
local var_0_39 = 60
local var_0_40 = 640
local var_0_41 = 280
local var_0_42 = {
	cc.p(100, 140),
	cc.p(320, 140),
	(cc.p(540, 140))
}

function PatrolGirlSelectLayer:initGirlListPanel()
	local var_29_0 = GameDisplay.getUiScreenSize().height - self.title:getContentSize().height - self.bottomList:getContentSize().height

	self.listPanel = cc.TableView:create(cc.size(var_0_36, var_29_0))
	self.listPanel.displayheight = var_29_0

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_38, var_0_39))
	self.listPanel:setDelegate()
	self.listPanel:setName("listPanel")

	self.listPanel.anchorPoint = cc.p(0, 0)

	self.rootLayer:addChild(self.listPanel, 2)
	self.listPanel:registerScriptHandler(function(arg_30_0, arg_30_1)
		return var_0_40, var_0_41
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_29_1(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0:getChildByName("clipLayer") then
			self:updateCell(arg_31_0, arg_31_1, arg_31_2)
		else
			self:createCell(arg_31_0, arg_31_1, arg_31_2)
		end
	end

	local var_29_2 = 0

	local function var_29_3(arg_32_0, arg_32_1)
		local var_32_0 = arg_32_0:getChildByName("clipLayer"):getChildByName("photo")
		local var_32_1 = arg_32_0:getChildByName("pressBar")

		if arg_32_1 == ccui.TouchEventType.began then
			var_32_0:runAction(cc.ScaleTo:create(0.1, 1.1))

			local function var_32_2()
				LayerManager:pushInLayer("SoulsLayer", {
					showtype = 6,
					cursoul = self.curData[arg_32_0:getTag()],
					exitCallback = function()
						self:updateShowingCells()
					end
				})

				var_29_2 = 0.4

				var_32_1:endPressBar()
			end

			local function var_32_3(arg_36_0)
				var_29_2 = var_29_2 + arg_36_0
			end

			arg_32_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
				var_32_1:startPressBar(var_32_2, var_32_3)
			end)))
		elseif arg_32_1 == ccui.TouchEventType.canceled then
			var_32_0:runAction(cc.ScaleTo:create(0.1, 1))
			arg_32_0:stopAllActions()
			var_32_1:endPressBar()
		elseif arg_32_1 == ccui.TouchEventType.ended then
			arg_32_0:stopAllActions()

			if var_29_2 == 0 then
				(function()
					if arg_32_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_32_0:getTouchBeganPosition().y - arg_32_0:getTouchEndPosition().y) > 50 then
						return
					end

					if self.sureCallback then
						self.sureCallback(self.curData[arg_32_0:getTag()])
						LayerManager:removePopLayer()
					end
				end)()
			end

			var_29_2 = 0

			var_32_1:endPressBar()
			var_32_0:runAction(cc.ScaleTo:create(0.1, 1))
		end
	end

	self.listPanel:registerScriptHandler(function(arg_39_0, arg_39_1)
		local var_39_0 = arg_39_0:dequeueCell()

		if var_39_0 == nil then
			var_39_0 = cc.TableViewCell:create()

			var_39_0:setName("cell_" .. arg_39_1)

			for iter_39_0 = 1, 3 do
				local var_39_1 = ccui.Button:create("public/rolebg/rarity_4_bg.png", "public/rolebg/rarity_4_bg.png", "public/rolebg/rarity_4_bg.png", var_0_33)

				var_39_1:setName("sp_" .. iter_39_0)
				var_39_1:setCascadeOpacityEnabled(true)
				var_39_1:setTag(3 * arg_39_1 + iter_39_0)
				var_39_1:setPosition(var_0_42[iter_39_0])
				var_39_1:setScale(0.94)
				var_39_1:setSwallowTouches(false)
				var_39_1:addTouchEventListener(var_29_3)
				var_39_0:addChild(var_39_1)

				if 3 * arg_39_1 + iter_39_0 <= #self.curData then
					var_29_1(var_39_1, self.curData[3 * arg_39_1 + iter_39_0], 3 * arg_39_1 + iter_39_0)
				else
					var_39_1:setVisible(false)
				end
			end
		else
			for iter_39_1 = 1, 3 do
				local var_39_2 = var_39_0:getChildByName("sp_" .. iter_39_1)

				var_39_2:setTag(3 * arg_39_1 + iter_39_1)

				if 3 * arg_39_1 + iter_39_1 <= #self.curData then
					var_29_1(var_39_2, self.curData[3 * arg_39_1 + iter_39_1], 3 * arg_39_1 + iter_39_1)
					var_39_2:setVisible(true)
				else
					var_39_2:setVisible(false)
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_39_1

			local var_39_3 = LAYER_OUT_TIME / math.ceil(var_29_0 / var_0_41)

			for iter_39_2 = 1, 3 do
				if var_39_0:getChildByName("sp_" .. iter_39_2) then
					if ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_2), "favoriteLabel") then
						ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_2), "favoriteLabel"):setVisible(false)
					end

					if ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_2), "fightlabel") then
						ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_2), "fightlabel"):setVisible(false)
					end

					var_39_0:getChildByName("sp_" .. iter_39_2):runAction(cc.Sequence:create(cc.DelayTime:create((arg_39_1 - self.startIndex) * var_39_3), cc.FadeOut:create(var_39_3)))
				end
			end
		end

		if self.selectTblAni then
			local var_39_4 = LAYER_OUT_TIME / math.ceil(var_29_0 / var_0_41) * 1.5

			for iter_39_3 = 1, 3 do
				if var_39_0:getChildByName("sp_" .. iter_39_3) then
					if ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "favoriteLabel") then
						ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "favoriteLabel"):setVisible(false)
					end

					if ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "fightlabel") then
						ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "fightlabel"):setVisible(false)
					end

					var_39_0:getChildByName("sp_" .. iter_39_3):setOpacity(0)
					var_39_0:getChildByName("sp_" .. iter_39_3):runAction(cc.Sequence:create(cc.DelayTime:create(arg_39_1 * var_39_4), cc.FadeIn:create(var_39_4), cc.CallFunc:create(function()
						if ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "favoriteLabel") then
							ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "favoriteLabel"):setVisible(ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "favoriteLabel").visible or false)
						end

						if ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "fightlabel") then
							ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_3), "fightlabel"):setVisible(true)
						end
					end)))
				end
			end
		elseif not self.startRunOutAni then
			for iter_39_4 = 1, 3 do
				if var_39_0:getChildByName("sp_" .. iter_39_4) then
					var_39_0:getChildByName("sp_" .. iter_39_4):setOpacity(255)

					if ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_4), "favoriteLabel") then
						ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_4), "favoriteLabel"):setVisible(ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_4), "favoriteLabel").visible or false)
					end

					if ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_4), "fightlabel") then
						ccui.Helper:seekWidgetByName(var_39_0:getChildByName("sp_" .. iter_39_4), "fightlabel"):setVisible(true)
					end
				end
			end
		end

		return var_39_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_41_0, arg_41_1)
		return (math.ceil(#self.curData / 3))
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
end

function PatrolGirlSelectLayer.createItemHightLight(arg_42_0, arg_42_1)
	local var_42_2 = ccui.Layout:create()
	local var_42_3

	if config._DEBUG then
		var_42_3 = cc.Sprite:create("public/rolebg/new_item_bg_on1.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on1.png")
	end

	var_42_3:setPosition(arg_42_1:getContentSize().width / 2 - 3, arg_42_1:getContentSize().height / 2)
	var_42_2:addChild(var_42_3)

	local var_42_4 = {}

	for iter_42_0 = 1, 2 do
		if iter_42_0 == 1 then
			if config._DEBUG then
				var_42_4[iter_42_0] = cc.Sprite:create("public/rolebg/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on2.png")
			end

			var_42_4[iter_42_0]:setScale(1.1)
			var_42_4[iter_42_0]:setOpacity(0)
			var_42_4[iter_42_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
		else
			if config._DEBUG then
				var_42_4[iter_42_0] = cc.Sprite:create("public/rolebg/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on2.png")
			end

			var_42_4[iter_42_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
		end

		var_42_4[iter_42_0]:setPosition(arg_42_1:getContentSize().width / 2 - 3, arg_42_1:getContentSize().height / 2)
		var_42_2:addChild(var_42_4[iter_42_0])
	end

	var_42_2:setName("heightLight")
	arg_42_1:addChild(var_42_2, 9)
end

function PatrolGirlSelectLayer.updateGirlInfo(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_1:getChildByName("info_page") then
		local var_43_0 = ccui.ImageView:create("public/rolebg/black_rolelist.png", var_0_33)

		var_43_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_43_0:setPosition(cc.p(arg_43_1:getContentSize().width / 2, arg_43_1:getContentSize().height / 2))
		var_43_0:setName("info_page")
		arg_43_1:addChild(var_43_0, 3)

		local var_43_1 = 20
		local var_43_2 = 192
		local var_43_3 = {
			{
				L_GIRL_INFO_TABLE[1],
				[2] = "careerLabel"
			},
			{
				L_GIRL_INFO_TABLE[2],
				[2] = "lvLabel"
			},
			{
				L_GIRL_INFO_TABLE[3],
				[2] = "fightCapacityLabel"
			},
			{
				L_GIRL_INFO_TABLE[4],
				[2] = "attackLabel"
			},
			{
				L_GIRL_INFO_TABLE[5],
				[2] = "hpLabel"
			}
		}

		for iter_43_0 = 1, 5 do
			local var_43_4 = 20
			local var_43_6

			if var_43_3[iter_43_0][2] == "careerLabel" then
				var_43_4 = 26
				var_43_6 = 5
			else
				var_43_4 = 20
				var_43_6 = 0
			end

			local var_43_7 = cc.Label:createWithTTF(var_43_3[iter_43_0][1], FONT_DES, var_43_4)

			var_43_7:setPosition(cc.p(var_43_1, var_43_2 + var_43_6))
			var_43_7:setAnchorPoint(cc.p(0, 1))
			var_43_7:setColor(cc.c3b(255, 255, 255))
			var_43_7:setName("label1_" .. iter_43_0)
			var_43_0:addChild(var_43_7)

			local var_43_8 = cc.Label:createWithTTF("", FONT_DES, var_43_4)

			var_43_8:setPosition(cc.p(var_43_7:getContentSize().width + var_43_1, var_43_2 + var_43_6))
			var_43_8:setAnchorPoint(cc.p(0, 1))
			var_43_8:setName(var_43_3[iter_43_0][2])
			var_43_8:setColor(cc.c3b(255, 255, 255))
			var_43_0:addChild(var_43_8)

			var_43_2 = var_43_2 - var_43_4
		end
	end

	local var_43_9 = arg_43_1:getChildByName("info_page")
	local var_43_10 = model_manager.new()

	var_43_10:initPlayerAttribute(arg_43_2)

	if playermodel.haveServant[arg_43_2] and playermodel.weaponId[arg_43_2] then
		weaponOthers = weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_43_2]])

		var_43_10:updateWeaponAttr(weaponOthers)
	end

	local var_43_11, var_43_12 = component_manager:getSoulComponentlist(arg_43_2)

	var_43_10:updateComponentAttr(var_43_11)

	local var_43_13 = var_43_9:getChildByName("lvLabel")
	local var_43_14 = var_43_9:getChildByName("attackLabel")
	local var_43_15 = var_43_9:getChildByName("hpLabel")
	local var_43_16 = var_43_9:getChildByName("careerLabel")
	local var_43_17 = var_43_9:getChildByName("fightCapacityLabel")

	if playermodel.haveServant[arg_43_2] then
		local var_43_18 = core_manager:getServantCoreRank(arg_43_2)

		var_43_13:setString(playermodel.cores[cursoul].afk_lv or core_manager:getCoreLv(arg_43_2))
		var_43_14:setString(var_43_10:getAttribute("damage"))
		var_43_15:setString(var_43_10:getAttribute("hp"))
		var_43_16:setString(L_CAREER[SERVANT_CAREE_TBL[var_43_10:getAttribute("career")]])
		var_43_17:setString(fight_capacity_manager:getSoulFightCapacity(arg_43_2))
		var_43_9:getChildByName("label1_1"):setVisible(true)
		var_43_9:getChildByName("label1_2"):setVisible(true)
		var_43_9:getChildByName("label1_3"):setVisible(true)
		var_43_9:getChildByName("label1_4"):setVisible(true)
		var_43_9:getChildByName("label1_5"):setVisible(true)
		var_43_13:setVisible(true)
		var_43_14:setVisible(true)
		var_43_15:setVisible(true)
		var_43_16:setVisible(true)
		var_43_17:setVisible(true)
	else
		var_43_9:getChildByName("label1_1"):setVisible(false)
		var_43_9:getChildByName("label1_2"):setVisible(false)
		var_43_9:getChildByName("label1_3"):setVisible(false)
		var_43_9:getChildByName("label1_4"):setVisible(false)
		var_43_9:getChildByName("label1_5"):setVisible(false)
		var_43_13:setVisible(false)
		var_43_14:setVisible(false)
		var_43_15:setVisible(false)
		var_43_16:setVisible(false)
		var_43_17:setVisible(false)
	end
end

function PatrolGirlSelectLayer.getAttrIconPath(arg_44_0, arg_44_1)
	return global_get_model_attr(servant_data[arg_44_1].modelid)
end

function PatrolGirlSelectLayer:updateShowingCells()
	local var_45_0 = {
		cellsize = cc.size(var_0_40, var_0_41),
		maxcount = math.ceil(#self.curData / 3)
	}

	if var_45_0.maxcount < math.ceil(var_0_37 / var_0_41) then
		var_45_0.maxcount = math.ceil(var_0_37 / var_0_41)
	end

	local var_45_1, var_45_2 = GetTableViewShowCellIdx(self.listPanel, var_45_0)

	for iter_45_0 = var_45_1, var_45_2 do
		self.listPanel:updateCellAtIndex(iter_45_0)
	end
end

function PatrolGirlSelectLayer:initDisplay(arg_46_1)
	self.displayPos = global_get_node_display_posy(arg_46_1, {
		listPanel = {
			focusName = "listPanel",
			reference = TRANSFORM_REFERENCE.DOWN,
			posY = var_0_39,
			unit = TRANSFORM_UNIT.PX
		},
		title = {
			posY = 56,
			focusName = "title",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_46_0, iter_46_1 in pairs(self.displayPos) do
		local var_46_0 = ccui.Helper:seekWidgetByName(arg_46_1, iter_46_0) or arg_46_1:getChildByName(iter_46_0)

		if var_46_0 then
			var_46_0:setPositionY(iter_46_1)
		end
	end
end

function PatrolGirlSelectLayer:exit()
	TextureManager:unregisterTexture("HorcruxLayer")

	var_0_26 = nil

	self:layerOutAni(function()
		if self.exithandler then
			self.exithandler()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
