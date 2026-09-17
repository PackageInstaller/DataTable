ArenaLayer = class("ArenaLayer", (require("view.Layer.BaseUILayer")))

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local playermodel = require("model.playermodel")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local diamond_update_data = require("data.diamond_update_data")
local arena_manager = require("controller.arena_manager")
local arenaawards_data = require("data.arenaawards_data")
local core_manager = require("controller.core_manager")
local array_manager = require("controller.array_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local formation_grab_match_manager = require("controller.formation.formation_grab_match_manager")
local var_0_14 = formation_grab_match_manager:getInstance()
local var_0_15 = require("controller.formation.formation_manager").getInstance(formation_grab_match_manager)

require("view.Layer.PopLayer")
require("view.Sprite.GirlSprite")

local TempWidget = require("view.Sprite.TempWidget")
local var_0_17 = config._DEBUG and 0 or 1
local var_0_18 = "ArenaLayer/"
local var_0_19 = 280
local var_0_20 = 200
local var_0_21 = 350
local var_0_22 = 200
local var_0_23 = 50
local var_0_24 = 0.7
local var_0_25 = {
	AttAck = 1,
	Defend = 2
}
local var_0_26 = 10
local var_0_28
local var_0_29
local var_0_30
local var_0_31
local var_0_32 = {}
local var_0_33 = {}

function ArenaLayer.getInstance()
	return var_0_28
end

function ArenaLayer:ctor()
	ArenaLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.enemyData = {}
	self.myData = {}
	self.arenArray = {}
	self.attackArray = {}
	self.showType = var_0_25.AttAck
end

function ArenaLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ArenaLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function ArenaLayer.onEnter(arg_4_0)
	ArenaLayer.super.onEnter(arg_4_0)

	var_0_28 = arg_4_0
end

function ArenaLayer.onExit(arg_5_0)
	ArenaLayer.super.onExit(arg_5_0)

	var_0_28 = nil
end

function ArenaLayer:init(arg_6_1)
	self:initLayer()
	self:initListener()

	return true
end

function ArenaLayer:initLayer()
	local var_7_0 = TempWidget:CreateTempLayout(self)

	var_7_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_7_0

	local var_7_1 = TempWidget:CreateTempImg(var_0_18 .. "title.png", var_7_0)

	var_7_1:align(cc.p(0, 1), var_7_0:property().left_top)

	local var_7_2 = TempWidget:CreateTempBtn(var_0_18 .. "new_sahngchen.png", var_7_1)

	var_7_2:align(cc.p(1, 0.5), var_7_1:size().w - 5, var_7_1:size().h / 2)

	self.shopBtn = var_7_2

	local var_7_3 = TempWidget:CreateTempBtn(var_0_18 .. "new_paihang.png", var_7_1)

	var_7_3:align(cc.p(1, 0.5), var_7_2:pos().x - var_7_2:size().w - 10, var_7_2:pos().y)

	self.rankBtn = var_7_3

	local var_7_4 = TempWidget:CreateTempBtn(var_0_18 .. "new_detail.png", var_7_1)

	var_7_4:align(cc.p(1, 0.5), var_7_3:pos().x - var_7_3:size().w - 10, var_7_3:pos().y)

	self.detailBtn = var_7_4

	local var_7_5 = self:createEnemyShowLayout(1)

	var_7_5:move(self._root:size().w, self._root:size().h * 0.7)

	self.enemyShowLayout1 = var_7_5

	self._root:addChild(var_7_5)

	local var_7_6 = self:createEnemyShowLayout(2)

	var_7_6:move(self._root:size().w, self._root:size().h * 0.45)
	self._root:addChild(var_7_6)

	self.enemyShowLayout2 = var_7_6

	local var_7_7 = self:createRefreshLayout()

	var_7_7:move(0, self._root:size().h * 0.38)
	self._root:addChild(var_7_7)

	self.refreshLayout = var_7_7

	local var_7_8 = self:createMyShowLayout()

	var_7_8:move(self._root:size().w, self._root:size().h * 0.1)
	self._root:addChild(var_7_8)

	self.myShowLayout = var_7_8
	self.btn_element_restrain = ccui.Button:create("public/button/btn_element_restrain.png", "public/button/btn_element_restrain.png", "public/button/btn_element_restrain.png", var_0_17)

	self.btn_element_restrain:setName("btn_element_restrain")
	self.btn_element_restrain:setAnchorPoint(cc.p(1, 1))
	self.btn_element_restrain:setPosition(cc.p(630, 1070 + GameDisplay.fix_y * 1.9))
	self.btn_element_restrain:addTouchEventListener(function(arg_8_0, arg_8_1)
		local var_8_0

		if arg_8_1 ~= ccui.TouchEventType.ended then
			do return end

			var_8_0 = {}
		end

		var_8_0.tips = {
			"mainScenebg/guide/1.jpg",
			"mainScenebg/guide/2.jpg",
			"mainScenebg/guide/3.jpg",
			"mainScenebg/guide/4.jpg",
			"mainScenebg/guide/5.jpg"
		}

		LayerManager:pushInLayer("TipsLayer", var_8_0)
	end)
	self._root:addChild(self.btn_element_restrain, 99)
	self:initBottomLayout()
	self:initEnemyShowLayout()
	self:initMyShowLayout()
	self:initChangeTimes()
	self:showAction()
end

function ArenaLayer:initBottomLayout()
	local var_9_0 = TempWidget:CreateTempLayout(self._root)

	var_9_0:setContentSize(cc.size(self._root:size().w, 130))

	local var_9_1 = TempWidget:CreateTempImg(var_0_18 .. "down_line.png", var_9_0)

	var_9_1:align(cc.p(0, 0), 0, 0)

	local var_9_2 = TempWidget:CreateTempBtn(var_0_18 .. "btn_back.png", var_9_1)

	var_9_2:align(cc.p(0, 0.5), 5, var_9_1:size().h / 2)

	self.backBtn = var_9_2

	local var_9_3 = TempWidget:CreateTempImg(var_0_18 .. "new_add.png", var_9_0)

	var_9_3:align(cc.p(1, 1), var_9_0:size().w - 5, var_9_0:size().h - 5)

	self.timeBtn = var_9_3

	local var_9_4 = TempWidget:CreateTempLabel("", FONT_NAME, 24, var_9_3)

	var_9_4:align(cc.p(0, 0.5), 5, var_9_3:size().h / 2)

	self.timeText = var_9_4
end

function ArenaLayer.initChangeTimes(arg_10_0)
	arena_manager:get_arena_daily_times(function(arg_11_0)
		if not var_0_28 then
			return
		end

		arg_10_0.remainTimes = var_0_26 - arg_11_0.single
		arg_10_0.buyTimesCount = arg_11_0.single_times_buy_count

		arg_10_0:updateTimeText()
	end)
end

function ArenaLayer.initEnemyShowLayout(arg_12_0)
	arena_manager:get_otherplyers_data(function(arg_13_0)
		if var_0_28 then
			arg_12_0.enemyData = arg_13_0

			arg_12_0:updateEnemyShowLayout(1)
			arg_12_0:updateEnemyShowLayout(2)
		end
	end)
end

function ArenaLayer.initMyShowLayout(arg_14_0)
	arena_manager:getPlayerArenaArray(function()
		if var_0_28 then
			arg_14_0.arenArray, arg_14_0.attackArray = arena_manager:get_player_arena_array()

			arg_14_0:updateMyShowLayout()
			arg_14_0:updateShowTeamSkillLayout()
		end
	end)
	arena_manager:get_fight_data(function(arg_16_0)
		if var_0_28 then
			arg_14_0.myData = arg_16_0

			arg_14_0:updateMyShowLayout()

			var_0_29 = arg_16_0.rank or L_OFFER_SEARCH
		end
	end)
end

function ArenaLayer:showAction()
	self.enemyShowLayout1:stopAllActions()
	self.enemyShowLayout2:stopAllActions()
	self.myShowLayout:stopAllActions()
	self.enemyShowLayout1:setPositionX(self._root:size().w)
	self.enemyShowLayout2:setPositionX(self._root:size().w)
	self.myShowLayout:setPositionX(self._root:size().w)
	self.enemyShowLayout1:runAction(cc.MoveTo:create(0.2, cc.p(0, self.enemyShowLayout1:getPositionY())))
	self.enemyShowLayout2:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.MoveTo:create(0.2, cc.p(0, self.enemyShowLayout2:getPositionY()))))
	self.myShowLayout:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.MoveTo:create(0.2, cc.p(0, self.myShowLayout:getPositionY()))))
end

function ArenaLayer:showLeaveAction(arg_18_1)
	self.enemyShowLayout1:stopAllActions()
	self.enemyShowLayout2:stopAllActions()
	self.myShowLayout:stopAllActions()
	self.enemyShowLayout1:setPositionX(0)
	self.enemyShowLayout2:setPositionX(0)
	self.myShowLayout:setPositionX(0)
	self.enemyShowLayout1:runAction(cc.MoveTo:create(0.2, cc.p(self._root:size().w, self.enemyShowLayout1:getPositionY())))
	self.enemyShowLayout2:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.MoveTo:create(0.2, cc.p(self._root:size().w, self.enemyShowLayout2:getPositionY()))))
	self.myShowLayout:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.MoveTo:create(0.2, cc.p(self._root:size().w, self.myShowLayout:getPositionY())), cc.CallFunc:create(function()
		if arg_18_1 then
			arg_18_1()
		end
	end)))
end

function ArenaLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self.rankBtn:_addEvent(function()
		local var_22_0 = cc.EventCustom:new("switchShowLayer")

		var_22_0.layerName = "RankListLayer"

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_22_0)
	end)
	self.shopBtn:_addEvent(function()
		local var_23_0 = cc.EventCustom:new("switchShowLayer")

		var_23_0.layerName = "MarketLayer"
		var_23_0.initparam = {
			singleMarket = "1-9",
			returnLayer = "ArenaLayer"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_23_0)
	end)
	self.detailBtn:setVisible(require("controller.time_check_manager"):getCurTime() > global_get_time_by_date("2023-03-19 00:00:00"))
	self.detailBtn:_addEvent(function()
		self:popDetail()
	end)
	self.myShowLayout._childData.attackBtn:_addEvent(function()
		if self.showType ~= var_0_25.AttAck then
			self.showType = var_0_25.AttAck

			self:updateShowType()
			self:updateShowTeamSkillLayout()
		end
	end, {
		touchDelay = 1
	})
	self.myShowLayout._childData.defendBtn:_addEvent(function()
		if self.showType ~= var_0_25.Defend then
			self.showType = var_0_25.Defend

			self:updateShowType()
			self:updateShowTeamSkillLayout()
		end
	end, {
		touchDelay = 1
	})
	self.refreshBtn:_addEvent(function()
		arena_manager:get_otherplyers_data(function(arg_28_0)
			if not var_0_28 then
				return
			end

			self.enemyData = arg_28_0

			self:refreshEnemy()
		end)
	end, {
		touchDelay = 1
	})
	self.backBtn:_addEvent(function()
		self:showLeaveAction(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end, {
		touchDelay = 1
	})
	self.timeBtn:_addEvent(function()
		if not self.remainTimes or self.remainTimes >= 10 then
			self.remainTimes = self.remainTimes or 10

			global_ShowBlockWords(string.format(L_ARENA_MSG.Chance_Left, self.remainTimes))

			return
		end

		self:buyTime()
	end, {
		touchDelay = 1
	})
end

function ArenaLayer.initResultPopLayer(arg_32_0)
	arena_manager:setPvpNeedData({
		oldRank = var_0_29,
		enemyRank = var_0_31,
		playerName = playermodel.nickname,
		enemyName = var_0_30,
		playerArray = var_0_32,
		enemyArray = var_0_33
	})
end

function ArenaLayer:createEnemyShowLayout(arg_33_1)
	local var_33_0 = TempWidget:CreateTempLayout()

	var_33_0:setContentSize(cc.size(self._root:size().w, var_0_19))

	var_33_0._childData = {}

	local var_33_1 = TempWidget:CreateTempImg(var_0_18 .. "enemy_rank_bg.png", var_33_0)

	var_33_1:align(cc.p(0, 1), var_33_0:property().left_top)

	local var_33_2 = TempWidget:CreateTempLabel("", FONT_NAME, 24, var_33_1)

	var_33_2:align(cc.p(0, 1), 180, var_33_1:size().h - 10)

	var_33_0._childData.rankText = var_33_2

	local var_33_3 = TempWidget:CreateTempLabel("", FONT_NAME, 22, var_33_1)

	var_33_3:align(cc.p(0, 0), 10, 2.2)

	var_33_0._childData.nameText = var_33_3

	local var_33_4 = TempWidget:CreateTempImg("public/rolebg/player_star.png", var_33_1)

	var_33_4:setScale(0.6)
	var_33_4:align(cc.p(0, 0), 135, -0.5)

	local var_33_5 = TempWidget:CreateTempLabel("", FONT_NAME, 22, var_33_1)

	var_33_5:align(cc.p(0.5, 0), 200, 2)

	var_33_0._childData.starText = var_33_5

	local var_33_6 = TempWidget:CreateTempListView(var_33_0)

	var_33_6:setDirection(ccui.ListViewDirection.horizontal)
	var_33_6:setContentSize(cc.size(var_33_0:size().w, var_0_20))

	local var_33_7 = cc.size(var_33_0:size().w / FORMATION_SHOW_GIRL_NUM, var_0_20)

	var_33_0._childData.girlSpriteT = {}

	for iter_33_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_33_8 = TempWidget:CreateTempLayout()

		var_33_8:setContentSize(var_33_7)
		TempWidget:CreateTempImg(var_0_18 .. "null_bg.png", var_33_8):center()

		local var_33_9 = GirlSprite:create({
			initType = "enemyFormationStyle"
		})

		var_33_9:setAnchorPoint(cc.p(0.5, 0.5))
		var_33_9:setPosition(var_33_8:property().center)
		var_33_9:setScale(0.9)
		var_33_9:setVisible(false)
		var_33_8:addChild(var_33_9)

		var_33_0._childData.girlSpriteT[iter_33_0] = var_33_9

		var_33_6:pushBackCustomItem(var_33_8)
	end

	local var_33_10 = TempWidget:CreateTempLayout(var_33_0)

	var_33_10:setContentSize(var_33_0:size())
	var_33_10:_addEvent(function()
		self:challengeEnemy(arg_33_1)
	end)

	return var_33_0
end

function ArenaLayer:createMyShowLayout()
	local var_35_0 = TempWidget:CreateTempLayout()

	var_35_0:setContentSize(cc.size(self._root:size().w, var_0_21))

	var_35_0._childData = {}

	local var_35_1 = L2Skeleton:create("spine/quick_formation/flow3.json", "spine/quick_formation/flow3.atlas")

	var_35_1:refreshSkeleton()
	var_35_1:setPosition(cc.p(var_35_0:getContentSize().width / 2, var_35_0:getContentSize().height / 2))
	var_35_1:play("animation", true)
	var_35_0:addChild(var_35_1)

	local var_35_2 = TempWidget:CreateTempImg(var_0_18 .. "my_rank_bg.png", var_35_0)

	var_35_2:align(cc.p(0, 1), var_35_0:property().left, var_35_0:property().top + 40 + GameDisplay.fix_y * 0.55)

	local var_35_3 = TempWidget:CreateTempImg(var_0_18 .. "my_rank_bg2.png", var_35_0)

	var_35_3:align(cc.p(0, 1), var_35_0:property().left, var_35_0:property().top - 40)

	local var_35_4 = TempWidget:CreateTempLabel("", FONT_NAME, 24, var_35_2)

	var_35_4:align(cc.p(0, 1), 180, var_35_2:size().h - 10)

	var_35_0._childData.rankText = var_35_4

	local var_35_5 = TempWidget:CreateTempLabel("", FONT_NAME, 22, var_35_3)

	var_35_5:align(cc.p(0, 0), 10, 2.2)

	var_35_0._childData.nameText = var_35_5

	local var_35_6 = TempWidget:CreateTempImg("public/rolebg/player_star.png", var_35_3)

	var_35_6:setScale(0.6)
	var_35_6:align(cc.p(0, 0), 135, -0.5)

	local var_35_7 = TempWidget:CreateTempLabel("", FONT_NAME, 22, var_35_3)

	var_35_7:align(cc.p(0.5, 0), 200, 2)

	var_35_0._childData.starText = var_35_7

	local var_35_8 = TempWidget:CreateTempImg(var_0_18 .. "reward_bg.png", var_35_0)

	var_35_8:align(cc.p(0, 1), var_35_0:property().left, var_35_0:property().top - 4 + GameDisplay.fix_y * 0.55)
	TempWidget:CreateTempLabel(L_SCORE_AREAN_CUR_GIFT, FONT_NAME, 22, var_35_8):align(cc.p(0, 1), 8, var_35_8:size().h - 10)

	local var_35_9 = TempWidget:CreateTempImg("public/currency/888888.png", var_35_8)

	var_35_9:setScale(0.8)
	var_35_9:align(cc.p(0, 1), 138, var_35_8:size().h)

	local var_35_10 = TempWidget:CreateTempLabel("1000", FONT_NAME, 18, var_35_8)

	var_35_10:align(cc.p(0, 1), 175, var_35_8:size().h - 10)

	var_35_0._childData.diamondNum = var_35_10

	local var_35_11 = TempWidget:CreateTempImg("public/currency/arenascene_dot_1.png", var_35_8)

	var_35_11:setScale(0.6)
	var_35_11:align(cc.p(0, 1), 235, var_35_8:size().h - 5)

	local var_35_12 = TempWidget:CreateTempLabel("1000", FONT_NAME, 18, var_35_8)

	var_35_12:align(cc.p(0, 1), 266, var_35_8:size().h - 10)

	var_35_0._childData.arenasceneNum = var_35_12

	local var_35_13 = TempWidget:CreateTempImg("ArenaScene/first_head_bg.png", var_35_8)

	var_35_13:align(cc.p(0, 0), 328, -4)

	var_35_0._childData.headIconBG = var_35_13

	local var_35_14 = TempWidget:CreateTempImg("ArenaScene/first_head_img.png", var_35_13)

	var_35_14:setScale(0.3)
	var_35_14:align(cc.p(0, 0), 0, 0)

	local var_35_15 = TempWidget:CreateTempImg(var_0_18 .. "team_skill_bg.png", var_35_0)

	var_35_15:align(cc.p(1, 1), var_35_0:size().w - 10, var_35_0:size().h - 25)

	local var_35_16 = TempWidget:CreateTempImg(var_0_18 .. "team_skill_tag.png", var_35_15)

	var_35_16:align(cc.p(1, 0.5), var_35_15:size().w - 10, var_35_15:size().h / 2)

	var_35_0._childData.tagImg = var_35_16

	local var_35_17 = TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER[3], FONT_NAME, 20, var_35_15)

	var_35_17:align(cc.p(0, 0.5), 10, var_35_15:size().h / 2)

	var_35_0._childData.defaultText = var_35_17

	local var_35_18 = TempWidget:CreateTempLayout(var_35_15)

	var_35_18:setContentSize(var_35_15:size())

	var_35_0._childData.showTeamSkillLayout = var_35_18

	var_35_18:_addEvent(function()
		return
	end)

	local var_35_19 = TempWidget:CreateTempImg(nil, var_35_18)

	var_35_19:align(cc.p(0.5, 0.5), 20, var_35_18:size().h / 2)
	var_35_19:setScale(var_0_24)

	var_35_0._childData.iconBackImg = var_35_19

	local var_35_20 = TempWidget:CreateTempImg(nil, var_35_18)

	var_35_20:align(cc.p(0.5, 0.5), var_35_19:pos().x, var_35_18:size().h / 2)
	var_35_20:setScale(var_0_24)

	var_35_0._childData.iconImg = var_35_20

	local var_35_21 = TempWidget:CreateTempLayout(var_35_18)

	var_35_21:setContentSize(var_35_18:size())

	var_35_0._childData.teamSkillTextLayout = var_35_21

	local var_35_22 = TempWidget:CreateTempImg(var_0_18 .. "new_rongyudian.png", var_35_0)

	var_35_22:align(cc.p(0, 0.5), 5, 40)

	local var_35_23 = TempWidget:CreateTempImg(var_0_18 .. "new_paimingdi.png", var_35_0)

	var_35_23:align(cc.p(0, 0.5), var_35_22:pos().x + var_35_22:size().w + 5, var_35_22:pos().y - 3)
	TempWidget:CreateTempLabel(playermodel.honor, FONT_NAME, 16, var_35_23):align(cc.p(0, 0.5), 2, var_35_23:size().h / 2)

	local var_35_24 = TempWidget:CreateTempBtn(var_0_18 .. "new_jinggong1.png", var_35_0)

	var_35_24:align(cc.p(0, 0.5), var_35_0:size().w - 300, var_35_22:pos().y)

	var_35_0._childData.attackBtn = var_35_24

	local var_35_25 = TempWidget:CreateTempBtn(var_0_18 .. "new_fangshou2.png", var_35_0)

	var_35_25:align(cc.p(0, 0.5), var_35_24:pos().x + var_35_24:size().w + 20, var_35_24:pos().y)

	var_35_0._childData.defendBtn = var_35_25

	local var_35_26 = TempWidget:CreateTempListView(var_35_0)

	var_35_26:setDirection(ccui.ListViewDirection.horizontal)
	var_35_26:setContentSize(cc.size(var_35_0:size().w, var_0_22))
	var_35_26:align(cc.p(0, 0.5), 0, var_35_0:size().h / 2)

	var_35_0._childData.girlListView = var_35_26

	local var_35_27 = cc.size(var_35_0:size().w / FORMATION_SHOW_GIRL_NUM, var_0_22)

	var_35_0._childData.girlSpriteT = {}

	for iter_35_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_35_28 = TempWidget:CreateTempLayout()

		var_35_28:setContentSize(var_35_27)
		var_35_28:_addEvent(function()
			self:popFormationLayer()
		end, {
			touchDelay = 1
		})
		TempWidget:CreateTempImg(var_0_18 .. "my_null_bg.png", var_35_28):center()

		local var_35_29 = GirlSprite:create({
			initType = "formationStype"
		})

		var_35_29:setAnchorPoint(cc.p(0.5, 0.5))
		var_35_29:setPosition(var_35_28:property().center)
		var_35_29:setScale(0.9)
		var_35_29:setVisible(false)
		var_35_28:addChild(var_35_29)

		var_35_0._childData.girlSpriteT[iter_35_0] = var_35_29

		var_35_26:pushBackCustomItem(var_35_28)
	end

	return var_35_0
end

function ArenaLayer:createRefreshLayout()
	local var_38_0 = TempWidget:CreateTempLayout()

	var_38_0:setContentSize(cc.size(self._root:size().w, var_0_23))
	TempWidget:CreateTempImg(var_0_18 .. "line.png", var_38_0):move(var_38_0:property().center)

	local var_38_1 = TempWidget:CreateTempBtn(var_0_18 .. "refresh_btn.png", var_38_0)

	var_38_1:align(cc.p(1, 0), var_38_0:size().w - 10, var_38_0:size().h / 2)

	self.refreshBtn = var_38_1

	return var_38_0
end

function ArenaLayer.popDetail(arg_39_0)
	local var_39_0 = {}

	var_39_0.intx1 = 20
	var_39_0.labels = {}
	var_39_0.labels.des = {}
	var_39_0.labels.des.key = {}
	var_39_0.labels.des.value = {}

	for iter_39_0, iter_39_1 in ipairs(arenaawards_data) do
		if iter_39_1.min == iter_39_1.max then
			var_39_0.labels.des.key[iter_39_0] = string.format(L_ARENA_MSG.Rank_Detail[1], iter_39_1.min)
		else
			var_39_0.labels.des.key[iter_39_0] = string.format(L_ARENA_MSG.Rank_Detail[2], iter_39_1.max, iter_39_1.min)

			if iter_39_0 == #arenaawards_data then
				var_39_0.labels.des.key[iter_39_0] = string.format(L_ARENA_MSG.Rank_Detail[3], iter_39_1.max)
			end
		end

		var_39_0.labels.des.value[iter_39_0] = string.format(L_ARENA_MSG.Award_Detail, iter_39_1.diamond_daily, iter_39_1.honor_daily)
	end

	arena_manager:get_fight_data(function(arg_40_0)
		local var_40_0 = arena_manager:getArenaAwards(arg_40_0.rank)

		var_39_0.honor = var_40_0.honor
		var_39_0.diamond = var_40_0.diamond
		var_39_0.labels.title = L_ARENA_MSG.Addition_Tip.title
		var_39_0.labels.info = L_ARENA_MSG.Addition_Tip.info
		var_39_0.scroll = true

		print(dump(var_39_0))
		LayerManager:pushInLayer("PopShowArenaInfo", var_39_0)
	end)
end

function ArenaLayer:popFormationLayer()
	if self.showType == var_0_25.AttAck then
		arena_manager:setLayerState(CONFIG_TYPE_ARENA)
		var_0_15:pushFormationLayer("FormationGrabMatchLayer", {
			layerType = -2,
			configtype = CONFIG_TYPE_ARENA,
			configcallback = function()
				if not var_0_28 then
					return
				end

				self.arenArray, self.attackArray = arena_manager:get_player_arena_array()

				self:updateMyShowLayout()
			end,
			exitcallback = function()
				if not var_0_28 then
					return
				end

				self.arenArray, self.attackArray = arena_manager:get_player_arena_array()

				self:updateMyShowLayout()
			end
		})
	elseif self.showType == var_0_25.Defend then
		arena_manager:setLayerState(CONFIG_TYPE_ARENA_DEFENCE)
		var_0_15:pushFormationLayer("FormationGrabMatchLayer", {
			layerType = -1,
			configtype = CONFIG_TYPE_ARENA_DEFENCE,
			configcallback = function()
				if not var_0_28 then
					return
				end

				self.arenArray, self.attackArray = arena_manager:get_player_arena_array()

				self:updateMyShowLayout()
			end,
			exitcallback = function()
				if not var_0_28 then
					return
				end

				self.arenArray, self.attackArray = arena_manager:get_player_arena_array()

				self:updateMyShowLayout()
			end
		})
	end
end

function ArenaLayer:buyTime(arg_46_1)
	if self.buyTimesCount then
		if not diamond_update_data[7000 + (self.buyTimesCount + 1)] then
			global_ShowBlockWords(L_ARENA_BUY_TIME.Fail)

			return
		end

		local var_46_0 = diamond_update_data[7000 + (self.buyTimesCount + 1)].costdiamond
		local var_46_1 = global_deepCopy(L_ADD_ARENA_TIMES)

		var_46_1.more = string.format(L_ARENA_BUY_TIME.Add, diamond_update_data[7000 + (self.buyTimesCount + 1)].costdiamond)

		local var_46_2 = {
			costtype = "diamond",
			surecallback = function()
				network:rpc("arena_buy_times", nil, function(arg_48_0)
					if arg_48_0.result == 1 then
						playermodel.diamond = playermodel.diamond - arg_48_0.cost

						global_update_gold_stone_diamond(nil, nil, arg_48_0.cost)

						self.buyTimesCount = self.buyTimesCount + 1
						self.remainTimes = self.remainTimes + 1

						self:updateTimeText()
						global_ShowBlockWords(L_ARENA_BUY_TIME.Success)
						AnalyticManager.area_buy_time({
							cost_diamond = arg_48_0.cost
						})
					elseif arg_48_0.result == 2 then
						LayerManager:pushInLayer("PopGoBuyDiamond", {
							is_need_pop_layer = 0
						})
					elseif arg_48_0.result == 3 then
						global_ShowBlockWords(L_ARENA_BUY_TIME.Fail)
					elseif arg_48_0.result == 4 then
						global_ShowBlockWords(L_ARENA_BUY_TIME.Common)
					else
						l2Log("arena_clear_time 清除时间失败！")
					end

					if arg_46_1 then
						arg_46_1()
					end
				end)
			end,
			cancelcallback = function()
				if arg_46_1 then
					arg_46_1()
				end
			end,
			cost = var_46_0,
			own = playermodel.diamond,
			labels = var_46_1
		}

		var_46_2.labels.titleImage = "title_arena_times_more.png"

		LayerManager:pushInLayer("PopDoLayer", var_46_2)
	else
		global_ShowBlockWords(L_ARENA_BUY_TIME.Fail)

		if arg_46_1 then
			arg_46_1()
		end
	end
end

function ArenaLayer:challengeEnemy(arg_50_1)
	local function var_50_0()
		if self.open then
			return
		end

		self.open = true
		self.enemyfightdata = self.enemyData[arg_50_1]

		if not playermodel.arenaAttackArray then
			-- block empty
		end

		var_0_30 = self.enemyfightdata.nickname
		var_0_31 = self.enemyfightdata.rank
		var_0_33 = {}

		for iter_51_0, iter_51_1 in pairs(self.enemyfightdata.battle_array) do
			var_0_33[#var_0_33 + 1] = {}
			var_0_33[#var_0_33].model = iter_51_1.model
		end

		var_0_32 = {}

		for iter_51_2, iter_51_3 in pairs((array_manager:getArenaAttackArray())) do
			if iter_51_3.fight_girl then
				var_0_32[#var_0_32 + 1] = {}
				var_0_32[#var_0_32].model = global_get_servant_skin(iter_51_3.fight_girl)
			end
		end

		arena_manager:beginArenaFight(1, self.enemyfightdata.playerid, function(arg_52_0)
			if arg_52_0 == 1 then
				LayerManager:switchShowLayer("FightLayer", {
					is_hide_topcost = true,
					is_hide_listbutton = true
				})
				self:initResultPopLayer()
			elseif arg_52_0 == 2 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[2], RISE_WORDS_WARNING)
			elseif arg_52_0 == 3 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[3], RISE_WORDS_WARNING)
			elseif arg_52_0 == 4 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[4], RISE_WORDS_WARNING)
			elseif arg_52_0 == 5 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[5], RISE_WORDS_WARNING)
			elseif arg_52_0 == 6 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[6], RISE_WORDS_WARNING)
			elseif arg_52_0 == 7 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[6], RISE_WORDS_WARNING)
			elseif arg_52_0 == 8 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[8], RISE_WORDS_WARNING)
			end

			if not var_0_28 then
				return
			end

			self.open = false
		end)
	end

	if not self.remainTimes then
		return
	end

	if self.remainTimes <= 0 then
		self:buyTime(var_50_0)

		return
	end

	var_50_0()
end

function ArenaLayer.getTeamSkill(arg_53_0)
	local var_53_0 = arena_manager:get_arena_battlefield_status()

	if not var_53_0 or not next(var_53_0) then
		return {}
	end

	local var_53_1 = arena_manager:get_arena_battlefield_status_info()

	if not var_53_1[1] then
		-- block empty
	end

	local var_53_3 = string.find(arena_manager:get_arena_battlefield_status_icon(var_53_0[1]), "/%a+.png$")
	local var_53_4 = {}

	for iter_53_0 = 1, #var_53_1 do
		var_53_4[iter_53_0] = {}
		var_53_4[iter_53_0].des = var_53_1[iter_53_0]
		var_53_4[iter_53_0].icon = arena_manager:get_arena_battlefield_status_icon(var_53_0[1])
		var_53_4[iter_53_0].icon = string.sub(var_53_4[iter_53_0].icon, string.find(var_53_4[iter_53_0].icon, "/%a+.png$") + 1, -5)
	end

	return var_53_4
end

function ArenaLayer.updateLayer(arg_54_0)
	return
end

function ArenaLayer.updateRed(arg_55_0)
	return
end

function ArenaLayer:updateEnemyShowLayout(arg_56_1)
	self["enemyShowLayout" .. arg_56_1]._childData.rankText:setString(self.enemyData[arg_56_1].rank)
	self["enemyShowLayout" .. arg_56_1]._childData.nameText:setString(self.enemyData[arg_56_1].nickname)
	self["enemyShowLayout" .. arg_56_1]._childData.starText:setString(self.enemyData[arg_56_1].star)

	for iter_56_0 = 1, FORMATION_SHOW_GIRL_NUM do
		self["enemyShowLayout" .. arg_56_1]._childData.girlSpriteT[iter_56_0]:setVisible(false)

		if self.enemyData[arg_56_1].battle_array[iter_56_0].servantid ~= -1 then
			self["enemyShowLayout" .. arg_56_1]._childData.girlSpriteT[iter_56_0]:setVisible(true)

			local var_56_0 = {
				servantId = self.enemyData[arg_56_1].battle_array[iter_56_0].servantid,
				contract = self.enemyData[arg_56_1].battle_array[iter_56_0].contract
			}

			var_56_0.level = self.enemyData[arg_56_1].battle_array[iter_56_0].servantlevel or 100
			var_56_0.rank = self.enemyData[arg_56_1].battle_array[iter_56_0].servantrank or 0
			var_56_0.overclock = self.enemyData[arg_56_1].battle_array[iter_56_0].overclock
			var_56_0.servantskin = self.enemyData[arg_56_1].battle_array[iter_56_0].servantskin
			var_56_0.addRollRarity = self.enemyData[arg_56_1].battle_array[iter_56_0].addRollRarity

			self["enemyShowLayout" .. arg_56_1]._childData.girlSpriteT[iter_56_0]:update(var_56_0)
		end
	end
end

function ArenaLayer:updateMyShowLayout()
	local var_57_0

	if self.showType == var_0_25.AttAck then
		var_57_0 = self.attackArray
	elseif self.showType == var_0_25.Defend then
		var_57_0 = self.arenArray
	end

	local var_57_1 = self.myData

	self.myShowLayout._childData.rankText:setString((self.myData.rank and var_57_1.rank ~= -1 or nil) and var_57_1.rank)
	self.myShowLayout._childData.starText:setString(var_57_1.star)
	self.myShowLayout._childData.nameText:setString(L_SCORE_AREAN_MINE_ARRAY)

	if not var_57_1.rank or var_57_1.rank <= 0 then
		self.myShowLayout._childData.diamondNum:setString(0)
		self.myShowLayout._childData.arenasceneNum:setString(0)
	else
		local var_57_4 = arena_manager:getArenaAwards(var_57_1.rank)

		self.myShowLayout._childData.diamondNum:setString(var_57_4.diamond)
		self.myShowLayout._childData.arenasceneNum:setString(var_57_4.honor)
	end

	self.myShowLayout._childData.headIconBG:setVisible(var_57_1.rank == 1)

	for iter_57_0 = 1, FORMATION_SHOW_GIRL_NUM do
		self.myShowLayout._childData.girlSpriteT[iter_57_0]:setVisible(false)

		if var_57_0[iter_57_0].fight_girl then
			self.myShowLayout._childData.girlSpriteT[iter_57_0]:setVisible(true)
			self.myShowLayout._childData.girlSpriteT[iter_57_0]:update(var_57_0[iter_57_0].fight_girl)

			if role_false_level_manager:isRoleFalseLevelMember(var_57_0[iter_57_0].fight_girl, FIGHTTYPE_ARENA) then
				local var_57_5, var_57_6, var_57_7, var_57_8 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_57_0[iter_57_0].fight_girl, FIGHTTYPE_ARENA)

				self.myShowLayout._childData.girlSpriteT[iter_57_0]:updateByFalseLevel(var_57_0[iter_57_0].fight_girl, var_57_5, var_57_6)
			else
				self.myShowLayout._childData.girlSpriteT[iter_57_0]:stopFalseLevelAni()
			end
		end
	end
end

function ArenaLayer:updateShowType()
	self.myShowLayout._childData.attackBtn:loadTextureNormal((self.showType ~= var_0_25.AttAck or nil) and var_0_18 .. "new_jinggong2.png", var_0_17)
	self.myShowLayout._childData.defendBtn:loadTextureNormal((self.showType ~= var_0_25.Defend or nil) and var_0_18 .. "new_fangshou2.png", var_0_17)

	local var_58_2 = self.myShowLayout._childData.girlListView

	self.myShowLayout._childData.girlListView:setPositionX(0)
	self.myShowLayout._childData.girlListView:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(-self.myShowLayout._childData.girlListView:size().w, 0)), cc.CallFunc:create(function()
		if not var_0_28 then
			return
		end

		self:updateMyShowLayout()
		var_58_2:setPositionX(var_58_2:size().w)
	end), cc.MoveBy:create(0.2, cc.p(-self.myShowLayout._childData.girlListView:size().w, 0))))
end

function ArenaLayer:refreshEnemy()
	self.enemyShowLayout1:stopAllActions()
	self.enemyShowLayout2:stopAllActions()
	self.enemyShowLayout1:setPositionX(0)
	self.enemyShowLayout2:setPositionX(0)
	self.enemyShowLayout1:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(-self.enemyShowLayout1:size().w, 0)), cc.CallFunc:create(function()
		self:updateEnemyShowLayout(1)
		self.enemyShowLayout1:setPositionX(self.enemyShowLayout1:size().w)
	end), cc.MoveBy:create(0.2, cc.p(-self.enemyShowLayout1:size().w, 0))))
	self.enemyShowLayout2:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.MoveBy:create(0.2, cc.p(-self.enemyShowLayout2:size().w, 0)), cc.CallFunc:create(function()
		self:updateEnemyShowLayout(2)
		self.enemyShowLayout2:setPositionX(self.enemyShowLayout2:size().w)
	end), cc.MoveBy:create(0.2, cc.p(-self.enemyShowLayout2:size().w, 0))))
end

function ArenaLayer:updateTimeText()
	self.timeText:setString(L_SCORE_AREAN_CUR_COUNT .. self.remainTimes)
end

function ArenaLayer:updateShowTeamSkillLayout()
	local var_64_0 = self:getTeamSkill()
	local var_64_1 = self.myShowLayout._childData.iconBackImg
	local var_64_2 = self.myShowLayout._childData.iconImg
	local var_64_3 = self.myShowLayout._childData.teamSkillTextLayout

	self.myShowLayout._childData.teamSkillTextLayout:removeAllChildren()
	self.myShowLayout._childData.iconBackImg:stopAllActions()
	self.myShowLayout._childData.iconImg:stopAllActions()

	if #var_64_0 == 0 then
		self.myShowLayout._childData.tagImg:show()
		self.myShowLayout._childData.defaultText:show()
		self.myShowLayout._childData.showTeamSkillLayout:hide()
	else
		self.myShowLayout._childData.tagImg:hide()
		self.myShowLayout._childData.defaultText:hide()
		self.myShowLayout._childData.showTeamSkillLayout:show()
		self.myShowLayout._childData.iconBackImg:loadTextureEx(var_0_18 .. "icon_" .. var_64_0[1].icon .. ".png")
		self.myShowLayout._childData.iconImg:loadTextureEx(var_0_18 .. "icon_" .. var_64_0[1].icon .. ".png")

		local var_64_4 = var_0_24

		self.myShowLayout._childData.iconBackImg:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(var_0_24 / 5), cc.CallFunc:create(function()
			var_64_1:setScale(var_64_4)
			var_64_1:setOpacity(255)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, var_0_24 * 2), cc.FadeOut:create(0.5)), cc.DelayTime:create(0.6))))

		local var_64_5 = {}

		for iter_64_0 = 1, #var_64_0 do
			local var_64_6 = TempWidget:CreateTempLabel(var_64_0[iter_64_0].des, FONT_NAME, 18, var_64_3)

			var_64_6:setAnchorPoint(cc.p(0, 0.5))
			var_64_6:align(cc.p(0, 0.5), 35, var_64_3:size().h / 2)
			var_64_6:setOpacity(0)
			table.insert(var_64_5, var_64_6)
		end

		var_64_5[1]:setOpacity(255)

		if #var_64_5 > 1 then
			for iter_64_1 = 1, #var_64_5 do
				var_64_5[iter_64_1]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_64_1 - 1) * 3), cc.CallFunc:create(function()
					var_64_2:loadTextureEx(var_0_18 .. "icon_" .. var_64_0[iter_64_1].icon .. ".png")
					var_64_1:loadTextureEx(var_0_18 .. "icon_" .. var_64_0[iter_64_1].icon .. ".png")
				end), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(2.6), cc.FadeTo:create(0.2, 0), cc.DelayTime:create((#var_64_5 - 1) * 3 - (iter_64_1 - 1) * 3))))
			end
		end
	end

	var_64_3:setTouchEnabled(true)
	var_64_3:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "arena_status"
		})
	end)
end

return ArenaLayer
