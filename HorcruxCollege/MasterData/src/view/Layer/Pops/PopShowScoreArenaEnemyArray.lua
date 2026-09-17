PopShowScoreArenaEnemyArray = class("PopShowScoreArenaEnemyArray", (require("view.Layer.BaseUILayer")))

require("view.Layer.EquipLayer")
require("view.Layer.HorcruxSelectLayer")
require("view.Layer.PopLayer")
require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Sprite.GirlSprite")
require("view.Sprite.HorcruxSprite")

local playermodel = require("model.playermodel")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local horcrux_data = require("data.horcrux_data")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local horcrux_manager = require("controller.horcrux_manager")
local array_manager = require("controller.array_manager")
local level_manager = require("controller.level_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local audio_manager = require("controller.audio_manager")
local core_manager = require("controller.core_manager")
local explore_manager = require("controller.explore_manager")
local scorearena_manager = require("controller.scorearena_manager")
local friend_system_manager = require("controller.friend_system_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_18 = FORMATION_SHOW_GIRL_NUM
local var_0_19 = config._DEBUG and 0 or 1
local var_0_20 = "PopShowScoreArenaEnemyArray/"
local var_0_21 = 200
local var_0_22 = 92

function PopShowScoreArenaEnemyArray:ctor()
	PopShowScoreArenaEnemyArray.super.ctor(self)
	self:setAutoAdapt(true)
end

function PopShowScoreArenaEnemyArray.create(arg_2_0, arg_2_1)
	local var_2_0 = PopShowScoreArenaEnemyArray.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function PopShowScoreArenaEnemyArray:onEnter()
	PopShowScoreArenaEnemyArray.super.onEnter(self)
	self:openAction()
end

function PopShowScoreArenaEnemyArray.onExit(arg_4_0)
	PopShowScoreArenaEnemyArray.super.onExit(arg_4_0)
end

function PopShowScoreArenaEnemyArray:init(arg_5_1)
	self:initLayer(arg_5_1)
	self:initListener()

	return true
end

function PopShowScoreArenaEnemyArray:initLayer(arg_6_1)
	self.data = arg_6_1 or {}

	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())
	var_6_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(150)

	local var_6_1 = TempWidget:CreateTempLayout(self)

	var_6_1:setContentSize(GameDisplay.getUiScreenSize())
	var_6_1:align(cc.p(0.5, 0.5), var_6_1:property().center)

	self._root = var_6_1

	local var_6_2 = TempWidget:CreateTempImg(var_0_20 .. "bg.png", self._root)

	var_6_2:center()

	self.bg = var_6_2

	local var_6_3 = TempWidget:CreateTempImg(var_0_20 .. "title.png", var_6_2)

	var_6_3:align(cc.p(0, 1), var_6_2:property().left_top)
	TempWidget:CreateTempLabel(L_POPSHOWAEA[1] .. global_trans_number(self.data.fightpoint) or 0, FONT_NAME, 24, var_6_3):align(cc.p(0, 0), 10, 1)

	local var_6_4 = TempWidget:CreateTempBtn(var_0_20 .. "chang_diren.png", var_6_1)

	var_6_4:setName("changeBtn")
	var_6_4:align(cc.p(0.5, 0.5), var_6_1:size().w / 2, var_6_1:size().h * 0.25)

	self.changeBtn = var_6_4
	self.btn_element_restrain = ccui.Button:create("public/button/btn_element_restrain.png", "public/button/btn_element_restrain.png", "public/button/btn_element_restrain.png", var_0_19)

	self.btn_element_restrain:setName("btn_element_restrain")
	self.btn_element_restrain:setAnchorPoint(cc.p(1, 1))
	self.btn_element_restrain:setPosition(cc.p(self._root:size().w / 2 + 310, self._root:size().h / 2 + 145))
	self.btn_element_restrain:addTouchEventListener(function(arg_7_0, arg_7_1)
		local var_7_0

		if arg_7_1 ~= ccui.TouchEventType.ended then
			do return end

			var_7_0 = {}
		end

		var_7_0.tips = {
			"mainScenebg/guide/1.jpg",
			"mainScenebg/guide/2.jpg",
			"mainScenebg/guide/3.jpg",
			"mainScenebg/guide/4.jpg",
			"mainScenebg/guide/5.jpg"
		}

		LayerManager:pushInLayer("TipsLayer", var_7_0)
	end)
	self._root:addChild(self.btn_element_restrain, 99)
	self:initGirlList()
end

function PopShowScoreArenaEnemyArray:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.bg:_addEvent(function()
		return
	end)
	self.changeBtn:_addEvent(function()
		self:startFight()
	end)
	self:checkAutoFight()
end

function PopShowScoreArenaEnemyArray:startFight()
	local var_12_0 = self.data.friendfight or CONFIG_TYPE_SCOREARENA

	if var_12_0 == CONFIG_TYPE_SCOREARENA then
		LayerManager:removePopLayer()
		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationPointsMatchLayer", {
			initindex = 1,
			enemyId = self.data.playerid,
			configtype = var_12_0
		})
	elseif var_12_0 == CONFIG_TYPE_FRIEND_FIGHT then
		local var_12_2 = self.data.friendname or ""
		local var_12_3 = {
			configtype = CONFIG_TYPE_ARENA,
			configcallback = function()
				friend_system_manager:setPvpNeedData(var_12_2)
				friend_system_manager:start_fight(function(arg_14_0)
					if arg_14_0 == 1 then
						LayerManager:switchShowLayer("FightLayer")
					elseif arg_14_0 == 2 then
						global_ShowBlockWords(L_POPSHOWAEA[2], RISE_WORDS_WARNING)
					end
				end)
			end,
			layerType = require("controller.formation.formation_grab_match_manager"):getInstance().Type.Attack
		}

		LayerManager:removePopLayer()
		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationFriendFightLayer", var_12_3)
	end
end

function PopShowScoreArenaEnemyArray:openAction(arg_15_1)
	self._root:setScaleY(0.01)
	self._root:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
		if arg_15_1 then
			arg_15_1()
		end
	end)))
end

function PopShowScoreArenaEnemyArray:initGirlList()
	local var_17_0 = TempWidget:CreateTempListView(self.bg)

	var_17_0:setDirection(ccui.ListViewDirection.horizontal)
	var_17_0:setContentSize(cc.size(self._root:size().w, var_0_21))
	var_17_0:align(cc.p(0.5, 0.5), self.bg:size().w / 2, self.bg:size().h / 2 - 30)

	local var_17_1 = cc.size(var_17_0:size().w / var_0_18, var_17_0:size().h)

	for iter_17_0 = 1, var_0_18 do
		local var_17_2 = TempWidget:CreateTempLayout()

		var_17_2:setContentSize(var_17_1)

		local var_17_3 = TempWidget:CreateTempImg(var_0_20 .. "girl_null_bg.png", var_17_2)

		var_17_3:center()

		if self.data.enemysData[iter_17_0] then
			local var_17_4 = {
				servantId = self.data.enemysData[iter_17_0].servantid,
				contract = self.data.enemysData[iter_17_0].contract
			}

			var_17_4.level = self.data.enemysData[iter_17_0].servantlevel or 100
			var_17_4.rank = self.data.enemysData[iter_17_0].servantrank or 0
			var_17_4.overclock = self.data.enemysData[iter_17_0].overclock
			var_17_4.servantskin = self.data.enemysData[iter_17_0].servantskin

			local var_17_5 = GirlSprite:create({
				initType = "enemyFormationStyle"
			})

			var_17_5:update(var_17_4)
			var_17_5:setScale(0.9)
			var_17_5:setAnchorPoint(cc.p(0, 0.5))
			var_17_5:setPosition(cc.p(12, var_17_2:size().h / 2))
			var_17_2:addChild(var_17_5)
			var_17_3:hide()
		end

		var_17_0:pushBackCustomItem(var_17_2)
	end
end

function PopShowScoreArenaEnemyArray:initHorcruxList()
	local var_18_0 = TempWidget:CreateTempListView(self.bg)

	var_18_0:setDirection(ccui.ListViewDirection.horizontal)
	var_18_0:setContentSize(cc.size(self._root:size().w, var_0_22))
	var_18_0:align(cc.p(0.5, 0), self.bg:size().w / 2, 15)

	local var_18_1 = cc.size(var_18_0:size().w / var_0_18, var_18_0:size().h)

	for iter_18_0 = 1, var_0_18 do
		local var_18_2 = TempWidget:CreateTempLayout()

		var_18_2:setContentSize(var_18_1)

		local var_18_3 = TempWidget:CreateTempImg(var_0_20 .. "girl_null_bg.png", var_18_2)

		var_18_3:center()

		if self.data.enemysData[iter_18_0] and self.data.enemysData[iter_18_0].horcrux then
			local var_18_4 = {
				horcrux = self.data.enemysData[iter_18_0].horcrux
			}
			local var_18_5 = HorcruxSprite:create({
				initType = "enemyArrayMemberFormationStyle"
			})

			var_18_5:update(var_18_4)
			var_18_5:setScale(1.2)
			var_18_5:setAnchorPoint(cc.p(0, 0))
			var_18_5:setPosition(cc.p(5, 0))
			var_18_2:addChild(var_18_5)

			local var_18_6 = cc.Node:create()

			var_18_6:setPosition(cc.p(var_18_5:getContentSize().width * var_18_5:getScale() + 7, 0))
			var_18_2:addChild(var_18_6)

			local var_18_7 = cc.Node:create()

			var_18_7:setPosition(cc.p(var_18_6:getPositionX(), 32))
			var_18_2:addChild(var_18_7)

			local var_18_8 = {
				servantId = self.data.enemysData[iter_18_0].servantid,
				contract = self.data.enemysData[iter_18_0].contract
			}

			var_18_8.level = self.data.enemysData[iter_18_0].servantlevel or 100
			var_18_8.rank = self.data.enemysData[iter_18_0].servantrank or 0
			var_18_8.overclock = self.data.enemysData[iter_18_0].overclock
			var_18_8.servantskin = self.data.enemysData[iter_18_0].servantskin

			local var_18_9 = self:getAttrIconPath(var_18_8.servantId)
			local var_18_10 = self:getAttrIconPath(var_18_4.horcrux.itemid)
			local var_18_11 = {
				skills = {}
			}

			while horcrux_data[var_18_4.horcrux.itemid]["skill" .. 1] do
				table.insert(var_18_11.skills, horcrux_data[var_18_4.horcrux.itemid]["skill" .. 1])
			end

			if var_18_11.skills[1] then
				local var_18_13 = TempWidget:CreateTempImg("skill_new/skill/" .. total_skill_data[var_18_11.skills[1]].icon .. ".png", var_18_6)

				var_18_13:setScale(0.3)
				var_18_13:align(cc.p(0, 0), 0, 0)
			end

			if var_18_11.skills[2] then
				local var_18_14 = TempWidget:CreateTempImg("skill_new/skill/" .. total_skill_data[var_18_11.skills[2]].icon .. ".png", var_18_7)

				var_18_14:setScale(0.3)
				var_18_14:align(cc.p(0, 0), 0, 0)
			end

			var_18_3:hide()
		end

		var_18_0:pushBackCustomItem(var_18_2)
	end
end

function PopShowScoreArenaEnemyArray.getAttrIconPath(arg_19_0, arg_19_1)
	if servant_data[arg_19_1] then
		return global_get_model_attr(servant_data[arg_19_1].modelid)
	else
		return global_get_model_attr(horcrux_data[arg_19_1].model)
	end
end

function PopShowScoreArenaEnemyArray:checkAutoFight()
	if self.data.friendfight then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("ScoreAutoFight", false) then
		global_count_down_layer(4, function()
			self:startFight()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("score_cancel_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("ScoreAutoFight", false)
		end)
	end
end

function PopShowScoreArenaEnemyArray.updateLayer(arg_23_0)
	return
end

function PopShowScoreArenaEnemyArray.updateRed(arg_24_0)
	return
end

return PopShowScoreArenaEnemyArray
