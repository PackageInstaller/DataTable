BattleArrayLayerNew = class("BattleArrayLayer", function()
	return cc.Layer:create()
end)

function BattleArrayLayerNew.getClass()
	return BattleArrayLayerNew
end

require("view.Layer.EquipLayer")
require("view.Layer.HorcruxSelectLayer")
require("view.Layer.PopLayer")
require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Sprite.GirlSprite")
require("view.Sprite.HorcruxSprite")
require("view.Layer.SubstitutionArrayLayer")
require("view.Layer.BattleTvtArrayLayer")
require("view.Layer.ShowFrinendArrayLayer")

local playermodel = require("model.playermodel")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local horcrux_data = require("data.horcrux_data")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local component_effect_data = require("data.component_effect_data")
local horcrux_manager = require("controller.horcrux_manager")
local array_manager = require("controller.array_manager")
local arenatft_manager = require("controller.arenatft_manager")
local level_manager = require("controller.level_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local audio_manager = require("controller.audio_manager")
local core_manager = require("controller.core_manager")
local explore_manager = require("controller.explore_manager")
local arena_manager = require("controller.arena_manager")
local scorearena_manager = require("controller.scorearena_manager")
local alert_manager = require("controller.alert_manager")
local patrol_manager = require("controller.patrol_manager")
local team_skill_manager = require("controller.team_skill_manager")
local bond_manager = require("controller.bond_manager")
local component_manager = require("controller.component_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local var_0_26 = cc.rect(0, 5, 163, 274)
local var_0_29 = cc.p(135, -60)
local var_0_30 = config._DEBUG and 0 or 1
local var_0_32 = L_TEAM_TIPS.TIPS_DES

function BattleArrayLayerNew.create(arg_3_0, arg_3_1)
	local var_3_0 = BattleArrayLayerNew.new()

	var_3_0:initBg(arg_3_1)

	return var_3_0
end

function BattleArrayLayerNew.create_by_child(arg_4_0)
	return (BattleArrayLayerNew.new())
end

function BattleArrayLayerNew.createNode(arg_5_0, arg_5_1)
	return BattleArrayLayerNew.new()
end

local var_0_34

function BattleArrayLayerNew.getInstance()
	return var_0_34
end

function BattleArrayLayerNew:updateUI()
	local var_7_0 = {
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			return array_manager:getArenaDefenceArray()
		end,
		[CONFIG_TYPE_ARENA] = function()
			return array_manager:getArenaAttackArray()
		end,
		[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
			return arenatft_manager:getDefenceArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			return arenatft_manager:getAttackArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			return array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)
		end
	}

	self.fightCapacityLabel:setString(global_trans_bitmapnumber((fight_capacity_manager:getArrayFightCapacity(var_7_0[self.configType] and var_7_0[self.configType]() or array_manager:getBattleArrayData(self.curSelectArrayId)))))
	self:initArrayFightCapacity()
end

function BattleArrayLayerNew:updateArrayFightCapacity(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1

	if not arg_13_1 then
		local var_13_1 = {
			[CONFIG_TYPE_ARENA_DEFENCE] = function()
				return array_manager:getArenaDefenceArray()
			end,
			[CONFIG_TYPE_ARENA] = function()
				return array_manager:getArenaAttackArray()
			end,
			[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
				return arenatft_manager:getDefenceArrayData(self.curSelectArrayId)
			end,
			[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
				return arenatft_manager:getAttackArrayData(self.curSelectArrayId)
			end
		}

		var_13_0 = var_13_1[self.configType] and var_13_1[self.configType]() or array_manager:getBattleArrayData(self.curSelectArrayId)
	end

	local var_13_2 = fight_capacity_manager:getArrayFightCapacity(var_13_0)

	explore_manager:setCurFightCapacity(var_13_2)

	if self.oldFightCapacity then
		if arg_13_3 then
			arg_13_3()
		end

		self:showChangeRoleEffect(var_13_0, var_13_2)
		fight_capacity_manager:saveArrayFightCapacity(var_13_0)

		self.oldFightCapacity = var_13_2
		self.oldBattleInfo = var_13_0
	else
		fight_capacity_manager:saveArrayFightCapacity(var_13_0)

		self.oldFightCapacity = var_13_2
		self.oldBattleInfo = var_13_0

		self.fightCapacityLabel:setString(global_trans_bitmapnumber(var_13_2))
	end
end

function BattleArrayLayerNew:showChangeRoleEffect(arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(self.oldBattleInfo) do
		if iter_18_1.fight_girl ~= nil and iter_18_1.fight_girl == arg_18_1[iter_18_0].fight_girl then
			if iter_18_1.assist_girl ~= arg_18_1[iter_18_0].assist_girl then
				local var_18_2 = fight_capacity_manager:getAttr(arg_18_1[iter_18_0].fight_girl)
				local var_18_3

				if arg_18_1[iter_18_0].assist_girl then
					var_18_3 = fight_capacity_manager:getAttr(horcrux_manager:getHorcruxItemid(arg_18_1[iter_18_0].assist_girl))
				end

				if var_18_3 ~= nil then
					if var_18_2 == var_18_3 then
						var_18_0[iter_18_0] = true
					elseif var_18_2 == "imaginary" then
						var_18_0[iter_18_0] = nil
					else
						var_18_0[iter_18_0] = false
					end
				end

				table.insert(var_18_1, iter_18_1.pos)
			end
		elseif iter_18_1.fight_girl and arg_18_1[iter_18_0].fight_girl and iter_18_1.fight_girl ~= arg_18_1[iter_18_0].fight_girl then
			local var_18_4 = fight_capacity_manager:getAttr(arg_18_1[iter_18_0].fight_girl)
			local var_18_5

			if arg_18_1[iter_18_0].assist_girl then
				var_18_5 = fight_capacity_manager:getAttr(horcrux_manager:getHorcruxItemid(arg_18_1[iter_18_0].assist_girl))
			end

			if var_18_5 ~= nil then
				if var_18_4 == var_18_5 then
					var_18_0[iter_18_0] = true
				elseif var_18_4 == "imaginary" then
					var_18_0[iter_18_0] = nil
				else
					var_18_0[iter_18_0] = false
				end
			end

			table.insert(var_18_1, iter_18_1.pos)
		end

		if iter_18_1.fight_girl ~= arg_18_1[iter_18_0].fight_girl then
			table.insert(var_18_1, iter_18_1.pos)
		end
	end

	for iter_18_2, iter_18_3 in pairs(var_18_1) do
		local var_18_6 = self.slotList[iter_18_3]

		ccui.Helper:seekWidgetByName(self.slotList[iter_18_3], "Image_fightpowerbg"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_18_6, "Image_fightpowerbg"):setOpacity(255)
		ccui.Helper:seekWidgetByName(var_18_6, "Image_fightpowerbg"):setScale(1)
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setOpacity(255)
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setScale(1)
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setPositionY(21)
		ccui.Helper:seekWidgetByName(var_18_6, "Image_fightpowerbg"):setPositionY(21)
		ccui.Helper:seekWidgetByName(var_18_6, "Image_attrFlag"):stopAllActions()
		ccui.Helper:seekWidgetByName(var_18_6, "Image_fightpowerbg"):stopAllActions()
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):stopAllActions()
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityLabel"):stopAllActions()

		if var_18_0[iter_18_3] then
			ccui.Helper:seekWidgetByName(var_18_6, "Image_attrFlag"):setOpacity(255)
			ccui.Helper:seekWidgetByName(var_18_6, "Image_attrFlag"):setVisible(true)
			ccui.Helper:seekWidgetByName(var_18_6, "Image_attrFlag"):runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.FadeOut:create(0.1)))
		else
			ccui.Helper:seekWidgetByName(var_18_6, "Image_attrFlag"):setVisible(false)
		end

		local var_18_7 = ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityLabel").fightCapacityBefore
		local var_18_8 = ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityLabel").fightCapacity

		ccui.Helper:seekWidgetByName(var_18_6, "Image_fightpowerbg"):runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.Spawn:create(cc.FadeTo:create(0.25, 128), cc.ScaleTo:create(0.25, 0.7), cc.MoveBy:create(0.25, cc.p(0, -10))), cc.Spawn:create(cc.FadeTo:create(0.25, 0), cc.ScaleTo:create(0.25, 0.4), cc.MoveBy:create(0.25, cc.p(0, -10))), cc.Hide:create()))
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.Spawn:create(cc.FadeTo:create(0.25, 128), cc.ScaleTo:create(0.25, 0.7), cc.MoveBy:create(0.25, cc.p(0, -10))), cc.Spawn:create(cc.FadeTo:create(0.25, 0), cc.ScaleTo:create(0.25, 0.4), cc.MoveBy:create(0.25, cc.p(0, -10))), cc.Hide:create()))
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityLabel"):setString(var_18_7 and global_trans_number(var_18_7) or "")
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityLabel"):runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.FadeOut:create(0.1), cc.CallFunc:create(function(...)
			ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityLabel"):setString(var_18_8 and global_trans_number(var_18_8) or "")
		end), cc.FadeIn:create(0.1)))

		local var_18_10 = ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityLabel"):getPositionX()
		local var_18_11 = ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityLabel"):getContentSize().width / 2

		ccui.Helper:seekWidgetByName(var_18_6, "Image_fightpowerbg"):setPositionX(var_18_10 - var_18_11)
		ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setPositionX(var_18_10 - var_18_11)

		local var_18_12 = var_18_8 or 0
		local var_18_13 = var_18_7 or 0

		if (var_18_8 or 0) - (var_18_7 or 0) < 0 then
			ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setString(var_18_12 - var_18_13)
			ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setColor(cc.c3b(249, 118, 118))
			ccui.Helper:seekWidgetByName(var_18_6, "Image_fightpowerbg"):loadTexture("Array/fight_power_chage_light_down.png", var_0_30)
		else
			ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setString("+" .. var_18_12 - var_18_13)
			ccui.Helper:seekWidgetByName(var_18_6, "fightCapacityDeltaLabel"):setColor(cc.c3b(139, 255, 251))
			ccui.Helper:seekWidgetByName(var_18_6, "Image_fightpowerbg"):loadTexture("Array/fight_power_chage_light_up.png", var_0_30)
		end
	end
end

function BattleArrayLayerNew:initArrayFightCapacity()
	local var_20_0

	if not var_20_0 then
		local var_20_1 = {
			[CONFIG_TYPE_ARENA_DEFENCE] = function()
				return array_manager:getArenaDefenceArray()
			end,
			[CONFIG_TYPE_ARENA] = function()
				return array_manager:getArenaAttackArray()
			end,
			[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
				return arenatft_manager:getDefenceArrayData(self.curSelectArrayId)
			end,
			[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
				return arenatft_manager:getAttackArrayData(self.curSelectArrayId)
			end,
			[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
				return array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)
			end
		}

		var_20_0 = var_20_1[self.configType] and var_20_1[self.configType]() or array_manager:getBattleArrayData(self.curSelectArrayId)
	end

	local var_20_2 = fight_capacity_manager:getArrayFightCapacity(var_20_0)

	explore_manager:setCurFightCapacity(var_20_2)

	self.oldFightCapacity = var_20_2
	self.oldBattleInfo = var_20_0

	fight_capacity_manager:saveArrayFightCapacity(var_20_0)
	self.fightCapacityLabel:setString((global_trans_bitmapnumber(var_20_2)))

	if self.configType == CONFIG_TYPE_PATROL then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_fightCapacitySumIcon"):setPositionY(283)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_31"):setPositionY(283)
		self.fightCapacityLabel:setPositionY(283)

		self.patrol_need_fight_power = self.initconfig.patrol_need_fight_power

		if self.patrol_power_label then
			self.patrol_power_label:updatePosX(self.oldFightCapacity)
		else
			self.patrol_power_label = cc.Label:createWithTTF(string.format(L_FIGHT_CAPACITY_MSG.Required_Capacity_2 .. global_trans_number(self.patrol_need_fight_power)) .. ")", FONT_NAME, 22)

			self.patrol_power_label:setAnchorPoint(cc.p(0, 0.5))
			self.patrol_power_label:setPositionY(self.fightCapacityLabel:getPositionY() - 40)
			self.fightCapacityLabel:getParent():addChild(self.patrol_power_label)

			function self.patrol_power_label.updatePosX(arg_26_0, arg_26_1)
				self.patrol_power_label:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_31"):getPositionX() - ccui.Helper:seekWidgetByName(self.rootLayer, "Image_31"):getContentSize().width / 2 + 18)

				if arg_26_1 >= self.patrol_need_fight_power then
					self.patrol_power_label:setColor(cc.c3b(0, 255, 120))
				else
					self.patrol_power_label:setColor(cc.c3b(255, 24, 0))
				end
			end

			self.patrol_power_label:updatePosX(self.oldFightCapacity)
		end
	end
end

function BattleArrayLayerNew.displayTips(arg_27_0, arg_27_1)
	LayerManager:pushInLayer("TipsLayer", {
		tips = {
			"mainScenebg/guide/16.jpg",
			"mainScenebg/guide/23.jpg",
			"mainScenebg/guide/24.jpg",
			"mainScenebg/guide/25.jpg",
			"mainScenebg/guide/26.jpg",
			"mainScenebg/guide/27.jpg",
			"mainScenebg/guide/28.jpg",
			"mainScenebg/guide/29.jpg"
		}
	})
end

function BattleArrayLayerNew:initFilepath()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BattleArrayLayer.json" or "BattleArrayLayer.ExportJson")

	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)
end

function BattleArrayLayerNew:layerExit()
	self.rootLayer:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function BattleArrayLayerNew.createFullScreenMask(arg_31_0)
	LayerManager:createFullScreenMask(arg_31_0, 0, function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_31_0:exit()
	end)
end

function BattleArrayLayerNew:init(arg_33_1)
	var_0_34 = self
	self.active = true
	self.size = cc.Director:getInstance():getVisibleSize()
	self.enemyid = arg_33_1.enemyid
	self.initconfig = arg_33_1

	if arg_33_1 then
		self.configType = arg_33_1.configtype or CONFIG_TYPE_NORMAL
	end

	self.configCallback = arg_33_1 and arg_33_1.configcallback
	self.configMode = arg_33_1 and arg_33_1.initmode
	self.configexitCallback = arg_33_1 and arg_33_1.exitcallback
	self.isHpInherit = arg_33_1 and arg_33_1.is_hp_inherit

	if arg_33_1 then
		self.curSelectArrayId = arg_33_1.initindex or 1
	end

	if arg_33_1 then
		self.adverturemode = arg_33_1.mode or nil
	end

	if arg_33_1 then
		self.virtualcallbak = arg_33_1.virtualcallbak or nil
	end

	self:checkDefaultArrayIs()

	self.adventuretowercallback = arg_33_1.adventure5callback

	self:createFullScreenMask()
	self:initFilepath()

	local var_33_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")
	local var_33_1 = cc.Label:createWithTTF("", FONT_BUTTON, 30)

	var_33_1:setName("label_btn")
	var_33_1:setColor(cc.c3b(0, 0, 0))
	var_33_0:addChild(var_33_1, 999)

	self.timerLabel = cc.Label:createWithTTF("00:00:00", FONT_NAME, 24)

	self.timerLabel:setVisible(false)
	self.timerLabel:setPosition(320, 225)
	self.rootLayer:addChild(self.timerLabel)

	local var_33_2 = ccui.ImageView:create("Array/effect_fight_btn_get_award.png", var_0_30)

	var_33_2:setName("effect")
	var_33_2:setVisible(false)
	var_33_2:setContentSize(var_33_0:getContentSize().width, var_33_0:getContentSize().height)
	var_33_2:setPosition(var_33_0:getContentSize().width / 2, var_33_0:getContentSize().height / 2)
	var_33_0:addChild(var_33_2)
	var_33_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1), cc.FadeIn:create(1))))

	self.quick_patrol_bnt = ccui.Button:create("Array/finish_quick.png", nil, "Array/finish_quick.png", var_0_30)

	self.quick_patrol_bnt:setAnchorPoint(cc.p(0, 0.5))
	self.quick_patrol_bnt:setVisible(false)
	self.quick_patrol_bnt:setPositionX(self.timerLabel:getPositionX() + self.timerLabel:getContentSize().width / 2)
	self.quick_patrol_bnt:setPositionY(self.timerLabel:getPositionY())
	self.rootLayer:addChild(self.quick_patrol_bnt)

	self.auto_btn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_18")

	if self.auto_btn then
		self.auto_btn:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:dealAutoArray()
		end)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_35_0:isBright() then
			return
		end

		arg_35_0:setBright(false)
		self:btnSureEvent(function()
			arg_35_0:setBright(true)
		end)
	end)
	self.rootLayer:getChildByName("Panel_Pop"):setScaleY(0)
	self.rootLayer:getChildByName("Panel_Pop"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.05, 1, 1), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	self:layerExit()

	if self.configType ~= CONFIG_TYPE_ARENA_DEFENCE and self.configType ~= CONFIG_TYPE_ARENA and self.configType ~= CONFIG_TYPE_EXPLORE_HP_INHERIT then
		self:initArrayListPanel()
		self:updateArrayListPanel()
	end

	if self.configType == CONFIG_TYPE_HANGUP then
		self:initPatrolTimer()
		self:initQuickPatrolBnt()
	end

	self:saveInitArrayInfo()
	self:initUI()
	self:updateAllCell()
	self:initArrayFightCapacity()
	self:updateTeamSkill()
	self:registerScriptHandler(function(arg_38_0)
		if arg_38_0 == "exit" then
			var_0_34 = nil
		end
	end)
end

function BattleArrayLayerNew:checkDefaultArrayIs()
	if array_manager:isArrayPatrol(self.curSelectArrayId) then
		self.curSelectArrayId = array_manager:getLevelArray()
	end
end

function BattleArrayLayerNew.updateGuidesOnLayer(arg_40_0)
	GuideListener.cleanCurGuides()
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(arg_40_0)
end

function BattleArrayLayerNew:initPatrolTimer()
	local function var_41_0(arg_42_0)
		if arg_42_0 <= 0 then
			return " "
		else
			return string.format("%02d:%02d:%02d", math.floor(arg_42_0 / 3600), math.floor(arg_42_0 % 3600 / 60), arg_42_0 % 60)
		end
	end

	patrol_manager:reset()

	self.patrolingArrayTimer = patrol_manager:getPatrolingArray()
	self.patrolingArrayFlag = {}

	self:scheduleUpdateWithPriorityLua(function(arg_43_0)
		if self.patrolingArrayTimer and self.timerLabel and self.patrolingArrayTimer[self.curSelectArrayId] then
			local var_43_0 = patrol_manager:getPatrolInfo(self.patrolingArrayTimer[self.curSelectArrayId])

			if var_43_0 then
				self.timerLabel:setString(var_41_0(var_43_0.time))

				if var_43_0.time <= 0 and not self.patrolingArrayFlag[self.curSelectArrayId] then
					self.patrolingArrayFlag[self.curSelectArrayId] = true

					local var_43_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")

					var_43_1:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_30)
					var_43_1:getChildByName("effect"):setVisible(true)
					var_43_1:getChildByName("label_btn"):setString(L_BUTTON_TEXT.Battle_Array_Btn.GetResults)
					self.quick_patrol_bnt:setVisible(false)
				end
			else
				self:updateSureBtn()

				self.patrolingArrayTimer = patrol_manager:getPatrolingArray()
			end
		end
	end, 0)
end

function BattleArrayLayerNew:initQuickPatrolBnt()
	self.quick_patrol_bnt:addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_45_0 = self.curSelectArrayId

		if array_manager:isArrayPatrol(self.curSelectArrayId) then
			local function var_45_1()
				require("controller.patrol_manager"):finishPatrolByArrayid(var_45_0, function(arg_47_0)
					if not self.active then
						return
					end

					if arg_47_0 == 1 then
						self:updateSureBtn()

						self.patrolingArrayTimer = patrol_manager:getPatrolingArray()

						alert_manager:check_weapon_update(false)
						alert_manager:check_component_update(false)
					end

					if setBrightCallback then
						setBrightCallback()
					end
				end)
			end

			local var_45_2, var_45_3 = patrol_manager:getCurArrayPatrolChpater(self.curSelectArrayId)
			local var_45_4 = patrol_manager:getPatrolInfo(self.patrolingArrayTimer[self.curSelectArrayId])

			if var_45_4.time <= 0 then
				var_45_1()
			else
				local var_45_5 = math.ceil(var_45_4.time / 360)

				LayerManager:pushInLayer("PopDoLayer", {
					costtype = "diamond",
					surecallback = var_45_1,
					cancelcallback = function()
						if setBrightCallback then
							setBrightCallback()
						end
					end,
					own = playermodel.diamond,
					cost = var_45_5,
					labels = {
						title = L_PATROL_QUICK_MSG.title,
						des = string.format(L_PATROL_QUICK_MSG.des, var_45_5),
						button = L_PATROL_QUICK_MSG.button
					}
				})
			end
		end
	end)
end

function BattleArrayLayerNew:updateTitle()
	if self.configType == CONFIG_TYPE_HANGUP then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_36"):loadTexture("Array/title.png", var_0_30)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_36"):loadTexture("Array/title_select_team.png", var_0_30)
	end
end

function BattleArrayLayerNew:updateSureBtn()
	local var_50_0 = {
		[CONFIG_TYPE_HANGUP] = function()
			local var_51_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")
			local var_51_1 = var_51_0:getChildByName("label_btn")

			if self.curSelectArrayId == array_manager:getLevelArray() then
				var_51_1:setString(L_BUTTON_TEXT.Battle_Array_Btn.Set_Now_Team)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_30)
				self.timerLabel:setVisible(false)
				self.quick_patrol_bnt:setVisible(false)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):getChildByName("effect"):setVisible(false)

				if not self:checkArrayInfo() and self.curSelectArrayId == self.initconfig.initindex then
					ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_30)
				end
			elseif array_manager:isArrayPatrol(self.curSelectArrayId) then
				local var_51_2 = "public/button/public_button_blue_long.png"

				var_51_1:setString(L_BUTTON_TEXT.Battle_Array_Btn.Retreat_Team)

				if patrol_manager:getPatrolInfo(self.patrolingArrayTimer[self.curSelectArrayId]).time <= 0 then
					var_51_2 = "public/button/public_button_orange_long.png"

					ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):getChildByName("effect"):setVisible(true)
					var_51_1:setString(L_BUTTON_TEXT.Battle_Array_Btn.GetResults)
					self.quick_patrol_bnt:setVisible(false)
				else
					var_51_2 = "public/button/public_button_blue_long.png"

					ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):getChildByName("effect"):setVisible(false)
					self.quick_patrol_bnt:setVisible(true)
				end

				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):loadTextures(var_51_2, nil, var_51_2, var_0_30)
				self.timerLabel:setVisible(true)
			else
				var_51_1:setString(L_BUTTON_TEXT.Battle_Array_Btn.Set_Now_Team)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_30)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):setBright(true)
				self.timerLabel:setVisible(false)
				self.quick_patrol_bnt:setVisible(false)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):getChildByName("effect"):setVisible(false)
			end

			var_51_1:setPosition(cc.p(var_51_0:getContentSize().width / 2, var_51_0:getContentSize().height / 2 - 5))
		end
	}

	if var_50_0[self.configType] then
		var_50_0[self.configType]()
	else
		local var_50_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")

		var_50_1:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_30)

		local var_50_2 = var_50_1:getChildByName("label_btn")

		var_50_2:setString(L_BUTTON_TEXT.Battle_Array_Btn.Sent_team)
		var_50_2:setColor(cc.c3b(12, 12, 12))
		var_50_2:setPosition(cc.p(var_50_1:getContentSize().width / 2, var_50_1:getContentSize().height / 2 - 5))
	end

	if self.configType == CONFIG_TYPE_ARENA_DEFENCE or self.configType == CONFIG_TYPE_ARENA then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString("")
	elseif self.configType == CONFIG_TYPE_PATROL or self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString("")
	elseif self.configType == CONFIG_TYPE_TVT_DEFENCE_FORM or self.configType == CONFIG_TYPE_TVT_ATTACK_FORM then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString("")
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString(L_TEAM_STATUS.Free)

		if array_manager:isArrayHangup(self.curSelectArrayId) then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString(L_TEAM_STATUS.Sent)
		end

		if array_manager:isArrayPatrol(self.curSelectArrayId) then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString(L_TEAM_STATUS.HangUP)
		end
	end
end

function BattleArrayLayerNew:initUI()
	self:updateTitle()
	self:updateSureBtn()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_33"):setString(var_0_32)

	local var_52_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attrTips")

	var_52_0:addTouchEventListener(function(arg_53_0, arg_53_1)
		if arg_53_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:displayTips()
	end)

	if level_manager:isCanOpenBond() == true then
		var_52_0:setPositionX(200)
	else
		var_52_0:setPositionX(280)
	end

	;(function()
		local var_54_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_fightCapacitySumIcon")

		self.fightCapacityLabel = ccui.TextBMFont:create(1, "fonts/array_fightcapacity_number.fnt")

		self.fightCapacityLabel:setPositionX(var_54_0:getPositionX() + var_54_0:getContentSize().width / 2)
		self.fightCapacityLabel:setPositionY(var_54_0:getPositionY())
		self.fightCapacityLabel:setAnchorPoint(cc.p(0, 0.5))
		self.fightCapacityLabel:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.fightCapacityLabel)
	end)()

	self.btn_bondBuff = ccui.Button:create("Array/btn_effect_bond.png", "Array/btn_effect_bond.png", "Array/btn_effect_bond.png", var_0_30)

	self.btn_bondBuff:setPosition(cc.p(280, 420))
	self.rootLayer:getChildByName("Panel_Pop"):addChild(self.btn_bondBuff)
	self.btn_bondBuff:addTouchEventListener(function(arg_55_0, arg_55_1)
		if arg_55_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("羁绊效果弹窗")
		LayerManager:pushInLayer("PopActivityDetail", {
			type = 0,
			key = "bond_detail"
		})
	end)

	local var_52_1 = ccui.ImageView:create("Array/btn_effect_bond.png", var_0_30)
	local var_52_2 = self.btn_bondBuff:getContentSize()

	var_52_1:setPosition(var_52_2.width / 2, var_52_2.height / 2)
	self.btn_bondBuff:addChild(var_52_1)
	self.btn_bondBuff:setVisible(level_manager:isCanOpenBond() == true)

	if bond_manager:isShowRemind() == true then
		var_52_1:setVisible(true)
		var_52_1:stopAllActions()
		var_52_1:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			var_52_1:setScale(1)
			var_52_1:setOpacity(255)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, 1.3), cc.FadeOut:create(0.5)), cc.DelayTime:create(0.6)))))
	else
		var_52_1:setVisible(false)
		var_52_1:stopAllActions()
		var_52_1:setOpacity(255)
		var_52_1:setScale(1)
	end

	self.slot1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot")

	self.slot1:setPositionX(-320)

	self.slot2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot2:setPositionX(-160)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot2)

	self.slot3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot3:setPositionX(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot3)

	self.slot4 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot4:setPositionX(160)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot4)
	ccui.Helper:seekWidgetByName(self.slot1, "Image_attrMatch"):setName("Image_attrMatch_1")
	ccui.Helper:seekWidgetByName(self.slot2, "Image_attrMatch"):setName("Image_attrMatch_2")
	ccui.Helper:seekWidgetByName(self.slot3, "Image_attrMatch"):setName("Image_attrMatch_3")
	ccui.Helper:seekWidgetByName(self.slot4, "Image_attrMatch"):setName("Image_attrMatch_4")

	self.slotList = {}
	self.slotList[1] = self.slot1
	self.slotList[2] = self.slot2
	self.slotList[3] = self.slot3
	self.slotList[4] = self.slot4

	local var_52_3 = {
		"Array/1st.png",
		"Array/2nd.png",
		"Array/3rd.png",
		"Array/4th.png"
	}
	local var_52_4 = 0

	for iter_52_0, iter_52_1 in pairs(self.slotList) do
		ccui.Helper:seekWidgetByName(self.slotList[iter_52_0], "Image_slotIndex"):loadTexture(var_52_3[iter_52_0], var_0_30)

		local var_52_5 = GirlSprite:create({
			initType = "arrayStyle",
			isHpInherit = self.isHpInherit
		})

		var_52_5:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant"):getContentSize().width / 2)
		var_52_5:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant"):getContentSize().height / 2)
		var_52_5:setName("girlSprite")
		var_52_5:setTouchEnabled(false)
		ccui.Helper:seekWidgetByName(self.slotList[iter_52_0], "Panel_servant"):addChild(var_52_5, 10)

		local var_52_6 = HorcruxSprite:create({
			initType = "arrayMemberStyle"
		})

		var_52_6:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcrux"):getContentSize().width / 2)
		var_52_6:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcrux"):getContentSize().height / 2)
		var_52_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_52_6:setName("horcruxSprite")
		var_52_6:setTouchEnabled(false)
		ccui.Helper:seekWidgetByName(self.slotList[iter_52_0], "Panel_horcrux"):addChild(var_52_6, 10)
		iter_52_1:getChildByName("Panel_servant"):getChildByName("Image_add"):setName("servant_add_img_" .. iter_52_0)
		iter_52_1:getChildByName("Panel_servant"):getChildByName("Image_bg"):setName("servant_bg_img_" .. iter_52_0)

		local var_52_7 = 1

		iter_52_1:getChildByName("Panel_servant"):getChildByName("servant_bg_img_" .. iter_52_0):addTouchEventListener(function(arg_57_0, arg_57_1)
			if arg_57_1 == ccui.TouchEventType.began then
				var_52_5:imgScaleTo(1.1, 0.1)

				local var_57_0 = self.configType == CONFIG_TYPE_ARENA_DEFENCE and array_manager:getArenaDefenceArray() or self.configType == CONFIG_TYPE_ARENA and array_manager:getArenaAttackArray() or self.configType == CONFIG_TYPE_TVT_DEFENCE_FORM and arenatft_manager:getDefenceArrayData(self.curSelectArrayId) or self.configType == CONFIG_TYPE_TVT_ATTACK_FORM and arenatft_manager:getAttackArrayData(self.curSelectArrayId) or self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT and array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId) or array_manager:getBattleArrayData(self.curSelectArrayId)

				if var_57_0[iter_52_0].fight_girl then
					iter_52_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_52_0):runAction(cc.ScaleTo:create(0.1, var_52_7 * 0.9, var_52_7 * 0.9))
					arg_57_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
						var_52_5:startPressBar(function()
							if var_57_0[iter_52_0].fight_girl then
								LayerManager:pushInLayer("SoulsLayer", {
									showtype = 6,
									cursoul = var_57_0[iter_52_0].fight_girl
								})

								var_52_4 = 0.2
							else
								var_52_4 = 0
							end

							var_52_5:endPressBar()
						end, function(arg_60_0)
							var_52_4 = var_52_4 + arg_60_0
						end)
					end)))
				end
			elseif arg_57_1 == ccui.TouchEventType.canceled then
				var_52_5:imgScaleTo(1, 0.1)
				iter_52_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_52_0):runAction(cc.ScaleTo:create(0.1, var_52_7 * 1, var_52_7 * 1))
				arg_57_0:stopAllActions()
				var_52_5:endPressBar()
			elseif arg_57_1 == ccui.TouchEventType.ended then
				arg_57_0:stopAllActions()

				if var_52_4 == 0 then
					self:changeRole(4 - iter_52_0)
				end

				var_52_4 = 0

				var_52_5:endPressBar()
				var_52_5:imgScaleTo(1, 0.1)
				iter_52_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_52_0):runAction(cc.ScaleTo:create(0.1, var_52_7 * 1, var_52_7 * 1))
			end
		end)
		iter_52_1:getChildByName("Panel_horcrux"):getChildByName("Image_bg"):setName("horcrux_bg_img_" .. iter_52_0)
		iter_52_1:getChildByName("Panel_horcrux"):getChildByName("horcrux_bg_img_" .. iter_52_0):addTouchEventListener(function(arg_61_0, arg_61_1)
			if arg_61_1 == ccui.TouchEventType.began then
				local var_61_0 = self.configType == CONFIG_TYPE_ARENA_DEFENCE and array_manager:getArenaDefenceArray() or self.configType == CONFIG_TYPE_ARENA and array_manager:getArenaAttackArray() or self.configType == CONFIG_TYPE_TVT_DEFENCE_FORM and arenatft_manager:getDefenceArrayData(self.curSelectArrayId) or self.configType == CONFIG_TYPE_TVT_ATTACK_FORM and arenatft_manager:getAttackArrayData(self.curSelectArrayId) or self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT and array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId) or array_manager:getBattleArrayData(self.curSelectArrayId)
				local var_61_1 = var_61_0[iter_52_0].assist_girl or nil

				if var_61_1 and explore_manager:queryHorcruxIsUsed(var_61_1) then
					global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Horcrux_Hp_Inherit)

					return false
				end

				if var_61_0[iter_52_0].fight_girl then
					var_52_6:imgScaleTo(1.1, 0.1)
					arg_61_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
						var_52_6:startPressBar(function()
							if var_61_0[iter_52_0].fight_girl and var_61_0[iter_52_0].assist_girl then
								LayerManager:pushInLayer("HorcruxInfoLayer", var_61_0[iter_52_0].assist_girl, nil, self.isHpInherit)

								var_52_4 = 0.2
							else
								var_52_4 = 0
							end

							var_52_6:endPressBar()
						end, function(arg_64_0)
							var_52_4 = var_52_4 + arg_64_0
						end)
					end)))
				end
			elseif arg_61_1 == ccui.TouchEventType.canceled then
				var_52_6:imgScaleTo(1, 0.1)
				arg_61_0:stopAllActions()
				var_52_6:endPressBar()
			elseif arg_61_1 == ccui.TouchEventType.ended then
				arg_61_0:stopAllActions()

				if var_52_4 == 0 then
					self:changeAssistGirl(iter_52_0, var_52_6)
				end

				var_52_4 = 0

				var_52_6:endPressBar()
				var_52_6:imgScaleTo(1, 0.1)
			end
		end)
		ccui.Helper:seekWidgetByName(iter_52_1, "Image_skill1"):addTouchEventListener(function(arg_65_0, arg_65_1)
			if arg_65_1 == ccui.TouchEventType.began then
				var_52_6:showSkillPanel(iter_52_1.skill1id)
			elseif arg_65_1 == ccui.TouchEventType.canceled then
				var_52_6:hideSkillPanel()
			elseif arg_65_1 == ccui.TouchEventType.ended then
				var_52_6:hideSkillPanel()
			end
		end)
		ccui.Helper:seekWidgetByName(iter_52_1, "Image_skill2"):addTouchEventListener(function(arg_66_0, arg_66_1)
			if arg_66_1 == ccui.TouchEventType.began then
				var_52_6:showSkillPanel(iter_52_1.skill2id)
			elseif arg_66_1 == ccui.TouchEventType.canceled then
				var_52_6:hideSkillPanel()
			elseif arg_66_1 == ccui.TouchEventType.ended then
				var_52_6:hideSkillPanel()
			end
		end)
	end

	self.eleBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_element")

	self:initTeamSkill()
end

function BattleArrayLayerNew:initTeamSkill(arg_67_1)
	local var_67_0 = {
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			return array_manager:getArenaDefenceArray()
		end,
		[CONFIG_TYPE_ARENA] = function()
			return array_manager:getArenaAttackArray()
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			return arenatft_manager:getAttackArrayData(self.curSelectArrayId)
		end
	}
	local var_67_1 = var_67_0[self.configType] and var_67_0[self.configType]() or array_manager:getBattleArrayData(self.curSelectArrayId)
	local var_67_2 = {}

	for iter_67_0 = 1, 4 do
		var_67_2[#var_67_2 + 1] = var_67_1[iter_67_0].fight_girl
	end

	self.isTeamSkill = false

	self.eleBtn:loadTextures("Array/btn_element_on.png", "Array/btn_element_on.png", "Array/btn_element_on.png", var_0_30)
	self.eleBtn:addTouchEventListener(function(arg_71_0, arg_71_1)
		if arg_71_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_71_0:isBright() then
			return
		end

		arg_71_0:setBright(false)

		local var_71_0 = {
			callback = function()
				arg_71_0:setBright(true)
			end
		}

		var_71_0.key = "teamSkill"

		if arg_71_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", var_71_0)
	end)

	local var_67_3 = ccui.Layout:create()

	var_67_3:setTouchEnabled(false)
	var_67_3:setContentSize(cc.size(self.eleBtn:getContentSize().width, self.eleBtn:getContentSize().height))
	var_67_3:setAnchorPoint(cc.p(0, 0))
	var_67_3:setPosition(cc.p(0, 0))
	var_67_3:setName("elePanel")
	self.eleBtn:addChild(var_67_3, 5)
	var_67_3:setVisible(false)

	local var_67_4 = ccui.ImageView:create("Array/icon_wind.png")

	var_67_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_67_4:setPosition(cc.p(35, 33))
	var_67_4:setName("eleIcon")
	var_67_3:addChild(var_67_4, 5)

	local var_67_5 = ccui.ImageView:create("Array/icon_wind.png")

	var_67_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_67_5:setPosition(cc.p(37, 33))
	var_67_5:setName("eleIconBack")
	var_67_3:addChild(var_67_5, 3)

	local var_67_6 = team_skill_manager:getTeamskillByArrayTbl(var_67_1)
	local var_67_7 = team_skill_manager:getSkillDes(var_67_6)

	self.teamSkillDes = {}

	for iter_67_1, iter_67_2 in pairs(var_67_7) do
		local var_67_8 = cc.Label:createWithTTF(iter_67_2.des, FONT_DES, 20)

		var_67_8:setAnchorPoint(cc.p(0, 0.5))
		var_67_8:setPosition(cc.p(70, self.eleBtn:getContentSize().height / 2 - 5))
		var_67_8:setOpacity(0)
		var_67_8:setName("skill_des_" .. iter_67_1)
		var_67_3:addChild(var_67_8)
		table.insert(self.teamSkillDes, var_67_8)
	end

	if next(self.teamSkillDes) then
		self.isTeamSkill = true

		var_67_4:loadTexture("Array/icon_" .. var_67_6[1].eleIcon .. ".png", var_0_30)
		var_67_5:loadTexture("Array/icon_" .. var_67_6[1].eleIcon .. ".png", var_0_30)
		var_67_5:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			var_67_5:setScale(1)
			var_67_5:setOpacity(255)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, 2), cc.FadeOut:create(0.5)), cc.DelayTime:create(0.6))))
		self.teamSkillDes[1]:setOpacity(255)

		if #self.teamSkillDes > 1 then
			for iter_67_3, iter_67_4 in pairs(self.teamSkillDes) do
				iter_67_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_67_3 - 1) * 3), cc.CallFunc:create(function()
					var_67_4:loadTexture("Array/icon_" .. var_67_7[iter_67_3].icon .. ".png", var_0_30)
					var_67_5:loadTexture("Array/icon_" .. var_67_7[iter_67_3].icon .. ".png", var_0_30)
				end), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(2.6), cc.FadeTo:create(0.2, 0), cc.DelayTime:create((#self.teamSkillDes - 1) * 3 - (iter_67_3 - 1) * 3))))
			end
		end

		var_67_3:setVisible(true)

		return
	end

	self.isTeamSkill = false

	self.eleBtn:loadTextures("Array/btn_element_none.png", "Array/btn_element_none.png", "Array/btn_element_none.png", var_0_30)
	print("self.elmtQueue===", dump(self.elmtQueue))
end

function BattleArrayLayerNew:updateTeamSkill(arg_75_1, arg_75_2)
	local var_75_0 = self.eleBtn:getChildByName("elePanel")
	local var_75_1 = var_75_0:getChildByName("eleIcon")
	local var_75_2 = var_75_0:getChildByName("eleIconBack")

	var_75_2:stopAllActions()

	for iter_75_0, iter_75_1 in pairs(self.teamSkillDes) do
		iter_75_1:removeFromParent()
	end

	self.teamSkillDes = {}

	local var_75_3 = {
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			return array_manager:getArenaDefenceArray()
		end,
		[CONFIG_TYPE_ARENA] = function()
			return array_manager:getArenaAttackArray()
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			return arenatft_manager:getAttackArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			return array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)
		end
	}
	local var_75_4 = var_75_3[self.configType] and var_75_3[self.configType]() or array_manager:getBattleArrayData(self.curSelectArrayId)
	local var_75_5 = {}

	for iter_75_2 = 1, 4 do
		var_75_5[#var_75_5 + 1] = var_75_4[iter_75_2].fight_girl
	end

	local var_75_6 = team_skill_manager:getTeamskillByArrayTbl(var_75_4)
	local var_75_7 = team_skill_manager:getSkillDes(var_75_6)

	print("teamSkillTbl =====", dump(var_75_7))

	self.teamSkillDes = {}

	for iter_75_3, iter_75_4 in pairs(var_75_7) do
		local var_75_8 = cc.Label:createWithTTF(iter_75_4.des, FONT_DES, 20)

		var_75_8:setAnchorPoint(cc.p(0, 0.5))
		var_75_8:setPosition(cc.p(70, self.eleBtn:getContentSize().height / 2 - 5))
		var_75_8:setOpacity(0)
		var_75_8:setName("skill_des_" .. iter_75_3)
		var_75_0:addChild(var_75_8)
		table.insert(self.teamSkillDes, var_75_8)

		if var_75_8:getContentSize().width > 200 then
			var_75_8:setScale(200 / var_75_8:getContentSize().width)
		else
			var_75_8:setScale(1)
		end
	end

	if next(self.teamSkillDes) then
		self.eleBtn:loadTextures("Array/btn_element_on.png", "Array/btn_element_on.png", "Array/btn_element_on.png", var_0_30)

		self.isTeamSkill = true

		var_75_1:loadTexture("Array/icon_" .. var_75_6[1].eleIcon .. ".png", var_0_30)
		var_75_2:loadTexture("Array/icon_" .. var_75_6[1].eleIcon .. ".png", var_0_30)
		var_75_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			var_75_2:setScale(1)
			var_75_2:setOpacity(255)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, 2), cc.FadeOut:create(0.5)), cc.DelayTime:create(0.6))))
		self.teamSkillDes[1]:setOpacity(255)

		if #self.teamSkillDes > 1 then
			for iter_75_5, iter_75_6 in pairs(self.teamSkillDes) do
				iter_75_6:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_75_5 - 1) * 3), cc.CallFunc:create(function()
					var_75_1:loadTexture("Array/icon_" .. var_75_7[iter_75_5].icon .. ".png", var_0_30)
					var_75_2:loadTexture("Array/icon_" .. var_75_7[iter_75_5].icon .. ".png", var_0_30)
				end), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(2.6), cc.FadeTo:create(0.2, 0), cc.DelayTime:create((#self.teamSkillDes - 1) * 3 - (iter_75_5 - 1) * 3))))
			end
		end

		var_75_0:setVisible(true)

		return
	end

	self.isTeamSkill = false

	var_75_0:setVisible(false)
	self.eleBtn:loadTextures("Array/btn_element_none.png", "Array/btn_element_none.png", "Array/btn_element_none.png", var_0_30)
end

function BattleArrayLayerNew:updateAllCell()
	local var_82_0 = {
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			return array_manager:getArenaDefenceArray()
		end,
		[CONFIG_TYPE_ARENA] = function()
			return array_manager:getArenaAttackArray()
		end,
		[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
			return arenatft_manager:getDefenceArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			return arenatft_manager:getAttackArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			return array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId or 1)
		end
	}
	local var_82_1 = var_82_0[self.configType] and var_82_0[self.configType]() or array_manager:getBattleArrayData(self.curSelectArrayId or 1)

	print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM", dump(var_82_1))

	for iter_82_0 = 1, 4 do
		self:updateSlot(var_82_1, iter_82_0)
	end
end

function BattleArrayLayerNew:showFightPowerChange(arg_88_1)
	if not arg_88_1 then
		return
	end

	local var_88_0

	for iter_88_0, iter_88_1 in pairs(self.oldBattleInfo) do
		if iter_88_1.assist_girl == arg_88_1 then
			var_88_0 = iter_88_1.pos
		end
	end

	self:updateAllCell()

	if var_88_0 then
		local var_88_1 = self.slotList[var_88_0]
		local var_88_2 = ccui.Helper:seekWidgetByName(self.slotList[var_88_0], "fightCapacityLabel").fightCapacityBefore
		local var_88_3 = ccui.Helper:seekWidgetByName(self.slotList[var_88_0], "fightCapacityLabel").fightCapacity

		if var_88_2 == var_88_3 then
			return
		end

		ccui.Helper:seekWidgetByName(var_88_1, "Image_fightpowerbg"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_88_1, "Image_fightpowerbg"):setOpacity(255)
		ccui.Helper:seekWidgetByName(var_88_1, "Image_fightpowerbg"):setScale(1)
		ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setOpacity(255)
		ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setScale(1)
		ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setPositionY(21)
		ccui.Helper:seekWidgetByName(var_88_1, "Image_fightpowerbg"):setPositionY(21)
		ccui.Helper:seekWidgetByName(var_88_1, "Image_fightpowerbg"):runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.Spawn:create(cc.FadeTo:create(0.25, 128), cc.ScaleTo:create(0.25, 0.7), cc.MoveBy:create(0.25, cc.p(0, -10))), cc.Spawn:create(cc.FadeTo:create(0.25, 0), cc.ScaleTo:create(0.25, 0.4), cc.MoveBy:create(0.25, cc.p(0, -10))), cc.Hide:create()))
		ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.Spawn:create(cc.FadeTo:create(0.25, 128), cc.ScaleTo:create(0.25, 0.7), cc.MoveBy:create(0.25, cc.p(0, -10))), cc.Spawn:create(cc.FadeTo:create(0.25, 0), cc.ScaleTo:create(0.25, 0.4), cc.MoveBy:create(0.25, cc.p(0, -10))), cc.Hide:create()))
		ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityLabel"):setString(var_88_2 and global_trans_number(var_88_2) or "")
		ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityLabel"):runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.FadeOut:create(0.1), cc.CallFunc:create(function(...)
			ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityLabel"):setString(var_88_3 and global_trans_number(var_88_3) or "")
		end), cc.FadeIn:create(0.1)))

		local var_88_5 = ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityLabel"):getPositionX()
		local var_88_6 = ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityLabel"):getContentSize().width / 2

		ccui.Helper:seekWidgetByName(var_88_1, "Image_fightpowerbg"):setPositionX(var_88_5 - var_88_6)
		ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setPositionX(var_88_5 - var_88_6)

		local var_88_7 = var_88_3 or 0
		local var_88_8 = var_88_2 or 0

		if (var_88_3 or 0) - (var_88_2 or 0) < 0 then
			ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setString(var_88_7 - var_88_8)
			ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setColor(cc.c3b(249, 118, 118))
			ccui.Helper:seekWidgetByName(var_88_1, "Image_fightpowerbg"):loadTexture("Array/fight_power_chage_light_down.png", var_0_30)
		else
			ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setString("+" .. var_88_7 - var_88_8)
			ccui.Helper:seekWidgetByName(var_88_1, "fightCapacityDeltaLabel"):setColor(cc.c3b(139, 255, 251))
			ccui.Helper:seekWidgetByName(var_88_1, "Image_fightpowerbg"):loadTexture("Array/fight_power_chage_light_up.png", var_0_30)
		end
	end
end

function BattleArrayLayerNew:updateSlot(arg_90_1, arg_90_2)
	local var_90_0 = self.slotList[arg_90_2]
	local var_90_1 = arg_90_1[arg_90_2].fight_girl
	local var_90_2 = arg_90_1[arg_90_2].assist_girl

	var_90_0.servantid = arg_90_1[arg_90_2].fight_girl
	var_90_0.horcruxid = var_90_2
	var_90_0.skill1id = nil
	var_90_0.skill2id = nil

	local var_90_3 = ccui.Helper:seekWidgetByName(var_90_0, "girlSprite")

	if var_90_1 then
		var_90_3:update(var_90_1)
		var_90_3:setVisible(true)

		if role_false_level_manager:isRoleFalseLevelMember(var_90_1, self.configType, self.adverturemode) then
			local var_90_4, var_90_5, var_90_6 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_90_1, self.configType, self.adverturemode)

			var_90_3:updateByFalseLevel(var_90_1, var_90_4, var_90_5)
		else
			var_90_3:stopFalseLevelAni()
		end
	else
		var_90_3:setVisible(false)
	end

	local var_90_7 = ccui.Helper:seekWidgetByName(var_90_0, "horcruxSprite")

	if var_90_2 then
		var_90_7:update(var_90_2)
		var_90_7:setVisible(true)
	else
		var_90_7:setVisible(false)
	end

	if var_90_2 then
		local var_90_8 = self:getAttrIconPath(var_90_1)
		local var_90_9 = self:getAttrIconPath(playermodel.items[var_90_2].itemid)
		local var_90_10 = horcrux_manager:getHorcruxAssistConfigWithServant(var_90_2, (core_manager:getServantCoreRank(var_90_1)))

		var_90_0.skill1id = var_90_10.skills[1]
		var_90_0.skill2id = var_90_10.skills[2]

		if var_90_8 == var_90_9 then
			ccui.Helper:seekWidgetByName(var_90_0, "Image_attrMatch_" .. arg_90_2):loadTexture("Array/attr_" .. var_90_8 .. ".png", var_0_30)
		elseif var_90_8 == "imaginary" then
			ccui.Helper:seekWidgetByName(var_90_0, "Image_attrMatch_" .. arg_90_2):loadTexture("Array/frame_add_attribute_half.png", var_0_30)
		else
			ccui.Helper:seekWidgetByName(var_90_0, "Image_attrMatch_" .. arg_90_2):loadTexture("Array/frame_add_attribute_half.png", var_0_30)
		end

		local var_90_11 = horcrux_manager:getServantAttrAddPercent(var_90_9, global_get_all_servant_attrs(var_90_1))

		ccui.Helper:seekWidgetByName(var_90_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(math.floor(var_90_10.damage * var_90_11.damage)))
		ccui.Helper:seekWidgetByName(var_90_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(math.floor(var_90_10.hp * var_90_11.hp)))
	else
		ccui.Helper:seekWidgetByName(var_90_0, "Image_attrMatch_" .. arg_90_2):loadTexture("Array/attr_non.png", var_0_30)
	end

	local var_90_12 = 0

	if var_90_0.skill1id then
		var_90_12 = var_90_12 + 1

		ccui.Helper:seekWidgetByName(var_90_0, "Image_skill1"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[var_90_0.skill1id].icon .. ".png", var_0_30)
	end

	if var_90_0.skill2id then
		var_90_12 = var_90_12 + 1

		ccui.Helper:seekWidgetByName(var_90_0, "Image_skill2"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[var_90_0.skill2id].icon .. ".png", var_0_30)
	end

	;(function()
		({
			[0] = function()
				return
			end,
			function()
				return
			end,
			function()
				return
			end
		})[var_90_12]()
	end)()
	ccui.Helper:seekWidgetByName(var_90_0, "Image_skill1"):setVisible(var_90_0.skill1id ~= nil)
	ccui.Helper:seekWidgetByName(var_90_0, "Image_skill2"):setVisible(var_90_0.skill2id ~= nil)
	ccui.Helper:seekWidgetByName(var_90_0, "Image_skill1"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_90_0, "Image_skill2"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_90_0, "Label_damageAdd"):setVisible(var_90_2 ~= nil)
	ccui.Helper:seekWidgetByName(var_90_0, "Label_hpAdd"):setVisible(var_90_2 ~= nil)
	ccui.Helper:seekWidgetByName(var_90_0, "fightCapacityLabel"):setVisible(var_90_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_90_0, "Image_fightCapacityIcon"):setVisible(var_90_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_90_0, "Panel_component"):setVisible(var_90_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_90_0, "Panel_fightpower"):setVisible(var_90_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_90_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_90_2):setVisible(var_90_1 == nil)
	ccui.Helper:seekWidgetByName(var_90_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_90_2):setOpacity(var_90_1 == nil and 255 or 0)
	ccui.Helper:seekWidgetByName(var_90_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_90_2):setOpacity(var_90_2 == nil and 255 or 0)

	local var_90_13 = {
		arg_90_1[arg_90_2]
	}

	ccui.Helper:seekWidgetByName(var_90_0, "fightCapacityLabel").fightCapacityBefore = ccui.Helper:seekWidgetByName(var_90_0, "fightCapacityLabel").fightCapacity

	ccui.Helper:seekWidgetByName(var_90_0, "fightCapacityLabel"):setString(global_trans_number(fight_capacity_manager:getArrayFightCapacity(var_90_13, nil, arg_90_1)))

	ccui.Helper:seekWidgetByName(var_90_0, "fightCapacityLabel").fightCapacity = fight_capacity_manager:getArrayFightCapacity(var_90_13)

	local var_90_14 = ccui.Helper:seekWidgetByName(var_90_0, "Image_fightCapacityIcon")

	var_90_14:setPositionX(ccui.Helper:seekWidgetByName(var_90_0, "fightCapacityLabel"):getPositionX() - ccui.Helper:seekWidgetByName(var_90_0, "fightCapacityLabel"):getContentSize().width - var_90_14:getContentSize().width / 2)

	if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_90_2]) then
		ccui.Helper:seekWidgetByName(var_90_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_90_2):loadTexture("Array/servant_lock.png", var_0_30)
		ccui.Helper:seekWidgetByName(var_90_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_90_2):setVisible(false)
		ccui.Helper:seekWidgetByName(var_90_0, "Image_attrMatch_" .. arg_90_2):loadTexture("Array/attr_non.png", var_0_30)

		local var_90_15 = ccui.Helper:seekWidgetByName(var_90_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_90_2)

		if not var_90_15:getChildByName("label1") then
			local var_90_16 = cc.Label:createWithTTF(L_TEAM_TIPS.Lock, FONT_DES, 20)

			var_90_16:setPosition(cc.p(var_90_15:getContentSize().width / 2, 60))
			var_90_16:setAnchorPoint(cc.p(0.5, 0.5))
			var_90_16:setColor(cc.c3b(175, 191, 195))
			var_90_16:setName("label1")
			var_90_15:addChild(var_90_16)

			local var_90_17 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_SOUL_UNLOCK[arg_90_2]), FONT_DES, 20)

			var_90_17:setAnchorPoint(cc.p(0.5, 0.5))
			var_90_17:setPosition(cc.p(var_90_16:getPositionX(), var_90_16:getPositionY() - var_90_17:getContentSize().height))
			var_90_17:setColor(cc.c3b(255, 211, 115))
			var_90_15:addChild(var_90_17)
		end
	end

	if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_90_2]) then
		ccui.Helper:seekWidgetByName(var_90_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_90_2):loadTexture("Array/horcrux_lock.png", var_0_30)
		ccui.Helper:seekWidgetByName(var_90_0, "Image_attrMatch_" .. arg_90_2):loadTexture("Array/attr_non.png", var_0_30)

		local var_90_18 = ccui.Helper:seekWidgetByName(var_90_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_90_2)

		if not var_90_18:getChildByName("label1") then
			local var_90_19 = cc.Label:createWithTTF(L_TEAM_TIPS.Lock, FONT_DES, 20)

			var_90_19:setPosition(cc.p(var_90_18:getContentSize().width / 2, 60))
			var_90_19:setAnchorPoint(cc.p(0.5, 0.5))
			var_90_19:setColor(cc.c3b(175, 191, 195))
			var_90_19:setName("label1")
			var_90_18:addChild(var_90_19)

			local var_90_20 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_90_2]), FONT_DES, 20)

			var_90_20:setAnchorPoint(cc.p(0.5, 0.5))
			var_90_20:setPosition(cc.p(var_90_19:getPositionX(), var_90_19:getPositionY() - var_90_20:getContentSize().height))
			var_90_20:setColor(cc.c3b(255, 211, 115))
			var_90_18:addChild(var_90_20)
		end
	end

	local var_90_21 = component_manager:getSoulComponentlist(var_90_1)
	local var_90_22 = {
		68,
		50,
		32
	}

	for iter_90_0 = 1, 3 do
		if not playermodel.component[var_90_1] or not playermodel.component[var_90_1][iter_90_0] then
			ccui.Helper:seekWidgetByName(var_90_0, "Panel_component"):getChildByName("Image_add_" .. iter_90_0):setVisible(true)
			ccui.Helper:seekWidgetByName(var_90_0, "Panel_component"):getChildByName("Image_component_" .. iter_90_0):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(var_90_0, "Panel_component"):getChildByName("Image_add_" .. iter_90_0):setVisible(false)
			ccui.Helper:seekWidgetByName(var_90_0, "Panel_component"):getChildByName("Image_component_" .. iter_90_0):setVisible(true)
			ccui.Helper:seekWidgetByName(var_90_0, "Panel_component"):getChildByName("Image_component_" .. iter_90_0):loadTexture(item_data[playermodel.items[playermodel.component[var_90_1][iter_90_0].id].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_90_1][iter_90_0].id].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[playermodel.component[var_90_1][iter_90_0].id].itemid].main_attr .. "_" .. iter_90_0 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_90_1][iter_90_0].id].component_attr.effect].image_id .. "_" .. playermodel.items[playermodel.component[var_90_1][iter_90_0].id].component_attr.attr1 .. "_" .. iter_90_0 .. ".png")

			if var_90_21.effect then
				ccui.Helper:seekWidgetByName(var_90_0, "Panel_component"):getChildByName("Image_component_" .. iter_90_0):setPositionY(var_90_22[2])
			else
				ccui.Helper:seekWidgetByName(var_90_0, "Panel_component"):getChildByName("Image_component_" .. iter_90_0):setPositionY(var_90_22[iter_90_0])
			end
		end
	end

	ccui.Helper:seekWidgetByName(var_90_0, "Image_component_bg"):addTouchEventListener(function(arg_95_0, arg_95_1)
		if arg_95_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_90_1 then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			cursoul = var_90_1,
			exitCallback = function(...)
				if self.updateAllCell then
					self:updateAllCell()
				end
			end
		})
	end)
end

function BattleArrayLayerNew:initArrayListPanel()
	self.arrayListView = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_arrayList")
	self.btnList = {}

	local var_97_2 = (function()
		local var_98_0 = {}

		if self.configType == CONFIG_TYPE_HANGUP then
			for iter_98_0 = 1, #playermodel.arrays do
				table.insert(var_98_0, iter_98_0)
			end
		elseif self.configType == CONFIG_TYPE_PATROL then
			for iter_98_1 = 1, #playermodel.arrays do
				if playermodel.arrays[iter_98_1].stat == ARRAY_STAT_FREE then
					table.insert(var_98_0, iter_98_1)
				end
			end
		elseif self.configType == CONFIG_TYPE_TVT_DEFENCE_FORM or self.configType == CONFIG_TYPE_TVT_ATTACK_FORM then
			for iter_98_2 = 1, 3 do
				table.insert(var_98_0, iter_98_2)
			end
		else
			for iter_98_3 = 1, #playermodel.arrays do
				if playermodel.arrays[iter_98_3].stat ~= ARRAY_STAT_PATROL then
					table.insert(var_98_0, iter_98_3)
				end
			end
		end

		return var_98_0
	end)()
	local var_97_3 = #nil

	if self.configType ~= CONFIG_TYPE_TVT_DEFENCE_FORM and self.configType ~= CONFIG_TYPE_TVT_ATTACK_FORM then
		if var_97_3 < MAX_ARRAY_COUNT then
			self.leftBtnListCount = var_97_3 + 1 or MAX_ARRAY_COUNT
		end
	else
		self.leftBtnListCount = var_97_3
	end

	local var_97_4 = {}

	for iter_97_0 = 1, self.leftBtnListCount do
		var_97_4[iter_97_0] = L_TEAM_TIPS.Team .. (var_97_2[iter_97_0] or "+")
	end

	if var_97_3 ~= MAX_ARRAY_COUNT then
		var_97_4[#var_97_4] = L_TEAM_TIPS.Team .. "+"
	end

	for iter_97_1, iter_97_2 in pairs(var_97_4) do
		local var_97_7 = self:createArrayIndexBtn(var_97_2[iter_97_1] or "+")

		var_97_7:setName("array_index_" .. (var_97_2[iter_97_1] or "+"))
		table.insert(self.btnList, var_97_7)
		self.arrayListView:pushBackCustomItem(var_97_7)
	end
end

function BattleArrayLayerNew.createArrayIndexBtn(arg_99_0, arg_99_1)
	local var_99_0 = arg_99_1 == "+" and ccui.ImageView:create("public/button/array_inde_btn_add.png", var_0_30) or ccui.ImageView:create("public/button/array_index_btn.png", var_0_30)

	var_99_0:setTouchEnabled(true)

	var_99_0.index = arg_99_1

	var_99_0:addTouchEventListener(function(arg_100_0, arg_100_1)
		if arg_100_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_100_0.index == "+" then
			arg_99_0:addArray()

			return
		end

		arg_99_0.curSelectArrayId = arg_100_0.index

		;(function(...)
			for iter_101_0, iter_101_1 in pairs(arg_99_0.slotList) do
				ccui.Helper:seekWidgetByName(iter_101_1, "Image_fightpowerbg"):setVisible(false)
				ccui.Helper:seekWidgetByName(iter_101_1, "fightCapacityDeltaLabel"):setVisible(false)
				ccui.Helper:seekWidgetByName(iter_101_1, "Image_fightpowerbg"):setOpacity(255)
				ccui.Helper:seekWidgetByName(iter_101_1, "Image_fightpowerbg"):setScale(1)
				ccui.Helper:seekWidgetByName(iter_101_1, "fightCapacityDeltaLabel"):setOpacity(255)
				ccui.Helper:seekWidgetByName(iter_101_1, "fightCapacityDeltaLabel"):setScale(1)
				ccui.Helper:seekWidgetByName(iter_101_1, "fightCapacityDeltaLabel"):setPositionY(21)
				ccui.Helper:seekWidgetByName(iter_101_1, "Image_fightpowerbg"):setPositionY(21)
				ccui.Helper:seekWidgetByName(iter_101_1, "Image_attrFlag"):stopAllActions()
				ccui.Helper:seekWidgetByName(iter_101_1, "Image_fightpowerbg"):stopAllActions()
				ccui.Helper:seekWidgetByName(iter_101_1, "fightCapacityDeltaLabel"):stopAllActions()
				ccui.Helper:seekWidgetByName(iter_101_1, "fightCapacityLabel"):stopAllActions()
			end
		end)()
		arg_99_0:updateAllCell()
		arg_99_0:updateTeamSkill()
		arg_99_0:initArrayFightCapacity()
		arg_99_0:updateArrayListPanel()
		arg_99_0:updateSureBtn()
	end)

	local var_99_1 = cc.Label:createWithTTF(arg_99_1, FONT_NAME, 28)

	var_99_1:setColor(cc.c3b(208, 233, 247))
	var_99_1:setName("label")
	var_99_1:setPositionX(var_99_0:getContentSize().width / 2)
	var_99_1:setPositionY(var_99_0:getContentSize().height / 2)
	var_99_0:addChild(var_99_1)

	return var_99_0
end

function BattleArrayLayerNew.addArray(arg_102_0)
	local function var_102_0(arg_103_0)
		if not arg_102_0.active then
			return
		end

		if arg_103_0 == 1 then
			arg_102_0.btnList[#arg_102_0.btnList].index = #playermodel.arrays

			if #playermodel.arrays < MAX_ARRAY_COUNT then
				local var_103_0 = arg_102_0:createArrayIndexBtn("+")

				table.insert(arg_102_0.btnList, var_103_0)
				arg_102_0.arrayListView:pushBackCustomItem(var_103_0)
			end

			arg_102_0.curSelectArrayId = arg_102_0.btnList[#arg_102_0.btnList].index

			arg_102_0:updateAllCell()
			arg_102_0:updateArrayListPanel()
			arg_102_0:updateArrayFightCapacity()
			arg_102_0:updateTeamSkill()
		elseif arg_103_0 == 2 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Team_Add[2])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_103_0 == 3 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Team_Add[3])
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end

	L_TEAM_TIPS.Expansion_Labels.titleNewImage = "public/title/title_add_teams.png"

	LayerManager:pushInLayer("PopDoLayer", {
		cost = 100,
		costtype = "diamond",
		labels = L_TEAM_TIPS.Expansion_Labels,
		own = playermodel.diamond,
		surecallback = function()
			array_manager:addArray(var_102_0)
		end,
		cancelcallback = cancelCallback
	})
end

function BattleArrayLayerNew:updateArrayListPanel()
	for iter_106_0, iter_106_1 in pairs(self.btnList) do
		if self.curSelectArrayId == iter_106_1.index then
			self.btnList[iter_106_0]:loadTexture("public/button/array_inde_btn_on.png", var_0_30)
			self.btnList[iter_106_0]:getChildByName("label"):setPositionY(self.btnList[iter_106_0]:getContentSize().height / 2 + 5)
			self.btnList[iter_106_0]:getChildByName("label"):setColor(cc.c3b(208, 233, 247))
		elseif iter_106_1.index ~= "+" then
			self.btnList[iter_106_0]:loadTexture("public/button/array_index_btn.png", var_0_30)
			self.btnList[iter_106_0]:getChildByName("label"):setPositionY(self.btnList[iter_106_0]:getContentSize().height / 2)
			self.btnList[iter_106_0]:getChildByName("label"):setColor(cc.c3b(208, 233, 247))
		else
			self.btnList[iter_106_0]:getChildByName("label"):setColor(cc.c3b(248, 244, 231))
		end

		self.btnList[iter_106_0]:getChildByName("label"):setString(L_TEAM_TIPS.Team .. iter_106_1.index)
	end
end

function BattleArrayLayerNew:exit()
	if self.configexitCallback then
		self.configexitCallback()
	end

	local var_107_0 = {
		[CONFIG_TYPE_NORMAL] = function()
			LayerManager:switchReturnLayer("FightLayer")
		end,
		[CONFIG_TYPE_HANGUP] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_ADVENTURE] = function()
			if self.adventuretowercallback then
				self.adventuretowercallback()
			end

			if self.virtualcallbak then
				self.virtualcallbak()
			end

			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_ARENA] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_EXPLORE] = function()
			if self.virtualcallbak then
				self.virtualcallbak(self.curSelectArrayId)
			end

			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_SWITCHMODE] = function()
			var_0_34:runAction(cc.RemoveSelf:create())
		end,
		[CONFIG_TYPE_PATROL] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_SCOREARENA] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_REFIGHT] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_FRIEND_FIGHT] = function()
			LayerManager:removePopLayer()
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			if self.virtualcallbak then
				self.virtualcallbak(self.curSelectArrayId)
			end

			LayerManager:removePopLayer()
		end
	}

	setmetatable(var_107_0, {
		__index = function(arg_122_0, arg_122_1)
			if arg_122_1 == CONFIG_TYPE_ADVENTURE_TOWER then
				return var_107_0[CONFIG_TYPE_ADVENTURE]
			end
		end
	})
	self.rootLayer:getChildByName("Panel_Pop"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
		var_107_0[self.configType]()
		array_manager:executeHangupArrayChange()

		self.active = false
	end)))
end

function BattleArrayLayerNew:saveInitArrayInfo()
	self.initArrayInfo = {}

	local var_124_0 = {
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			return array_manager:getArenaDefenceArray()
		end,
		[CONFIG_TYPE_ARENA] = function()
			return array_manager:getArenaAttackArray()
		end,
		[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
			return arenatft_manager:getDefenceArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			return arenatft_manager:getAttackArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			return array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)
		end
	}
	local var_124_1 = var_124_0[self.configType] and var_124_0[self.configType]() or array_manager:getBattleArrayData(self.curSelectArrayId)

	for iter_124_0 = 1, 4 do
		self.initArrayInfo[#self.initArrayInfo + 1] = var_124_1[iter_124_0].fight_girl
		self.initArrayInfo[#self.initArrayInfo + 1] = var_124_1[iter_124_0].assist_girl
	end
end

function BattleArrayLayerNew:checkArrayInfo()
	local var_130_0 = {
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			return array_manager:getArenaDefenceArray()
		end,
		[CONFIG_TYPE_ARENA] = function()
			return array_manager:getArenaAttackArray()
		end,
		[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
			return arenatft_manager:getDefenceArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			return arenatft_manager:getAttackArrayData(self.curSelectArrayId)
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			return array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)
		end
	}
	local var_130_1 = var_130_0[self.configType] and var_130_0[self.configType]() or array_manager:getBattleArrayData(self.curSelectArrayId)
	local var_130_2 = {}

	for iter_130_0 = 1, 4 do
		var_130_2[#var_130_2 + 1] = var_130_1[iter_130_0].fight_girl
		var_130_2[#var_130_2 + 1] = var_130_1[iter_130_0].assist_girl
	end

	for iter_130_1 = 1, (#self.initArrayInfo > #var_130_2 or nil) and (#self.initArrayInfo or #var_130_2) do
		if self.initArrayInfo[iter_130_1] ~= var_130_2[iter_130_1] then
			return false
		end
	end

	return true
end

function BattleArrayLayerNew:btnSureEvent(arg_136_1)
	if self:checkArrayInfo() and self.configType == CONFIG_TYPE_CONFIG_TYPE_HANGUP then
		self:exit()
	elseif self.configType == CONFIG_TYPE_NORMAL then
		-- block empty
	elseif self.configType == CONFIG_TYPE_FRIEND_FIGHT then
		array_manager:executeHangupArrayChange()

		if arg_136_1 then
			arg_136_1()
		end

		self.configCallback(self.curSelectArrayId)
		self:exit()
	else
		local var_136_0 = self.curSelectArrayId
		local var_136_1 = {
			[CONFIG_TYPE_ADVENTURE] = function()
				local var_137_0, var_137_1 = array_manager:checkAdventureArray(var_136_0)

				if not self.active then
					return
				end

				if var_137_0 then
					array_manager:executeHangupArrayChange()

					if self.configCallback and array_manager:checkIsSameColorTeam(var_136_0, self.adverturemode) then
						self.configCallback(var_136_0)
					end
				elseif var_137_1 == 0 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[0], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_137_1 == 1 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[1], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
					self.configCallback(var_136_0)
				end

				if arg_136_1 then
					arg_136_1()
				end

				self:exit()
			end,
			[CONFIG_TYPE_EXPLORE] = function()
				local var_138_0, var_138_1 = array_manager:checkExploreArray(var_136_0)

				if not self.active then
					return
				end

				if var_138_0 then
					if self.configCallback then
						self.configCallback(var_136_0)
					end

					array_manager:executeHangupArrayChange()
					self:exit()
				elseif var_138_1 == 0 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[0], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_138_1 == 1 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[1], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_138_1 == 2 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[2], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				end

				if arg_136_1 then
					arg_136_1()
				end
			end,
			[CONFIG_TYPE_HANGUP] = function()
				if array_manager:isArrayPatrol(var_136_0) then
					local function var_139_0(arg_141_0)
						if not self.active then
							return
						end

						if arg_141_0 == 1 then
							self:updateSureBtn()

							self.patrolingArrayTimer = patrol_manager:getPatrolingArray()

							alert_manager:check_weapon_update(false)
							alert_manager:check_component_update(false)
						end

						if arg_136_1 then
							arg_136_1()
						end
					end

					local var_139_1, var_139_2 = patrol_manager:getCurArrayPatrolChpater(self.curSelectArrayId)
					local patrol_manager = require("controller.patrol_manager")

					if patrol_manager:getPatrolInfo(self.patrolingArrayTimer[self.curSelectArrayId]).time <= 0 then
						patrol_manager:finishPatrolByArrayid(var_136_0, var_139_0)
					else
						LayerManager:pushInLayer("PopDoLayer", {
							surecallback = function()
								patrol_manager:cancelPatrolByArrayid(var_136_0, var_139_0)
							end,
							cancelcallback = function()
								if arg_136_1 then
									arg_136_1()
								end
							end,
							labels = L_TEAM_Array_WARNING.Type_HangUp[0]
						})
					end
				else
					array_manager:setHangupArray(self.configMode, var_136_0, function(arg_143_0)
						if not self.active then
							return
						end

						if arg_143_0 == 1 then
							if self.configCallback then
								self.configCallback()
							end

							array_manager:executeHangupArrayChange()
							self:exit()
						elseif arg_143_0 == 2 then
							global_ShowBlockWords(L_TEAM_Array_WARNING.Type_HangUp[2], RISE_WORDS_FAIL)
							audio_manager:playeffectMusicTest("sound/invalid")
						elseif arg_143_0 == 3 then
							global_ShowBlockWords(L_TEAM_Array_WARNING.Type_HangUp[3], RISE_WORDS_FAIL)
							audio_manager:playeffectMusicTest("sound/invalid")
						end

						if arg_136_1 then
							arg_136_1()
						end
					end)
				end
			end,
			[CONFIG_TYPE_SWITCHMODE] = function()
				if var_136_0 == playermodel.curArray then
					if self.configCallback then
						self.configCallback()
					end

					array_manager:executeHangupArrayChange()

					if arg_136_1 then
						arg_136_1()
					end

					self:exit()
				else
					array_manager:setHangupArray(self.configMode, var_136_0, function(arg_145_0)
						if not self.active then
							return
						end

						if arg_145_0 == 1 then
							if self.configCallback then
								self.configCallback()
							end

							self:runAction(cc.RemoveSelf:create())
						elseif arg_145_0 == 2 then
							global_ShowBlockWords(L_TEAM_Array_WARNING.Type_SwitchMode[2], RISE_WORDS_FAIL)
							audio_manager:playeffectMusicTest("sound/invalid")
						elseif arg_145_0 == 3 then
							global_ShowBlockWords(L_TEAM_Array_WARNING.Type_SwitchMode[3], RISE_WORDS_FAIL)
							audio_manager:playeffectMusicTest("sound/invalid")
						end

						if arg_136_1 then
							arg_136_1()
						end
					end)
				end
			end,
			[CONFIG_TYPE_ARENA] = function()
				if self.configCallback then
					self.configCallback()
				end

				array_manager:executeHangupArrayChange()
				self:exit()
			end,
			[CONFIG_TYPE_SCOREARENA] = function()
				local var_147_0, var_147_1 = array_manager:setArenaArray(var_136_0)

				if not self.active then
					return
				end

				if var_147_0 then
					if self.configCallback then
						self.configCallback(var_136_0)
					end

					array_manager:executeHangupArrayChange()
				elseif var_147_1 == 0 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[0], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_147_1 == 1 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[1], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_147_1 == 2 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[2])
					audio_manager:playeffectMusicTest("sound/invalid")
				end

				if arg_136_1 then
					arg_136_1()
				end
			end,
			[CONFIG_TYPE_ARENA_DEFENCE] = function()
				if self.configCallback then
					self.configCallback()
				end

				array_manager:executeHangupArrayChange()
				self:exit()
			end,
			[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
				for iter_149_0 = 1, 3 do
					local var_149_0 = iter_149_0

					for iter_149_1, iter_149_2 in pairs((arenatft_manager:getDefenceArrayData(iter_149_0))) do
						if iter_149_2.fight_girl then
							var_149_0 = false

							break
						end
					end

					if var_149_0 ~= false then
						if arg_136_1 then
							arg_136_1()
						end

						global_ShowBlockWords(string.format(L_TVT_DEFENCE_ARRAY_NIL, var_149_0))

						return
					end
				end

				if self.configCallback then
					self.configCallback()
				end

				if arg_136_1 then
					arg_136_1()
				end

				array_manager:executeHangupArrayChange()
				self:exit()
			end,
			[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
				for iter_150_0 = 1, 3 do
					local var_150_0 = iter_150_0

					for iter_150_1, iter_150_2 in pairs((arenatft_manager:getAttackArrayData(iter_150_0))) do
						if iter_150_2.fight_girl then
							var_150_0 = false

							break
						end
					end

					if var_150_0 ~= false then
						if arg_136_1 then
							arg_136_1()
						end

						global_ShowBlockWords(string.format(L_TVT_DEFENCE_ARRAY_NIL, var_150_0))

						return
					end
				end

				if self.configCallback then
					self.configCallback()
				end

				if arg_136_1 then
					arg_136_1()
				end

				array_manager:executeHangupArrayChange()
				self:exit()
			end,
			[CONFIG_TYPE_PATROL] = function()
				local var_151_0, var_151_1 = array_manager:checkPatrolArray(var_136_0, self.patrol_need_fight_power)

				if not self.active then
					return
				end

				if var_151_0 then
					if self.configCallback then
						self.configCallback(var_136_0)
					end

					self:exit()
				elseif var_151_1 == 0 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Patrol[0], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_151_1 == 1 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Patrol[1], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_151_1 == 2 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Patrol[2], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_151_1 == 3 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Patrol[3], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_151_1 == 4 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Patrol[4], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_151_1 == 5 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Patrol[5], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				end

				if arg_136_1 then
					arg_136_1()
				end
			end,
			[CONFIG_TYPE_REFIGHT] = function()
				local var_152_0, var_152_1 = array_manager:setRefightArray(var_136_0)

				if not self.active then
					return
				end

				if var_152_0 then
					if self.configCallback then
						self.configCallback(var_136_0)
					end

					array_manager:executeHangupArrayChange()
					self:exit()
				elseif var_152_1 == 0 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[0], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_152_1 == 1 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[1], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_152_1 == 2 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_ScoreArena[2])
					audio_manager:playeffectMusicTest("sound/invalid")
				end

				if arg_136_1 then
					arg_136_1()
				end
			end,
			[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
				local var_153_0, var_153_1 = array_manager:checkExploreArrayHpInherit(var_136_0)

				if not self.active then
					return
				end

				if var_153_0 then
					if self.configCallback then
						self.configCallback(var_136_0)
					end

					array_manager:executeHangupArrayChange()
					self:exit()
				elseif var_153_1 == 0 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[0], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_153_1 == 1 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[1], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif var_153_1 == 2 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[2], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
				end

				if arg_136_1 then
					arg_136_1()
				end
			end
		}

		setmetatable(var_136_1, {
			__index = function(arg_154_0, arg_154_1)
				if arg_154_1 == CONFIG_TYPE_ADVENTURE_TOWER then
					return var_136_1[CONFIG_TYPE_ADVENTURE]
				end
			end
		})
		var_136_1[self.configType]()
	end
end

function BattleArrayLayerNew:changeRole(arg_155_1)
	local var_155_0 = {
		[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
			LayerManager:pushInLayer("GirlSelectLayer", {
				selectType = SELECT_GIRL_TVT_DEFENCE,
				cursoul = arenatft_manager:getDefenceArrayData(self.curSelectArrayId)[4 - arg_155_1].fight_girl,
				arrayinfo = {
					index = self.curSelectArrayId,
					pos = 4 - arg_155_1
				},
				sureCallBack = function(arg_157_0)
					self:playChangeRoleSound(4 - arg_155_1, cursoul)
					self:updateAllCell()
					self:updateTeamSkill()
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()

					if arenatft_manager:getDefenceArrayData(self.curSelectArrayId)[4 - arg_155_1].fight_girl then
						audio_manager:playeffectMusicTest("sound/dispatch")
					end
				end
			})
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			LayerManager:pushInLayer("GirlSelectLayer", {
				selectType = SELECT_GIRL_TVT_ATTACK,
				cursoul = arenatft_manager:getAttackArrayData(self.curSelectArrayId)[4 - arg_155_1].fight_girl,
				arrayinfo = {
					index = self.curSelectArrayId,
					pos = 4 - arg_155_1
				},
				sureCallBack = function(arg_159_0)
					self:playChangeRoleSound(4 - arg_155_1, cursoul)
					self:updateAllCell()
					self:updateTeamSkill()
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()

					if arenatft_manager:getAttackArrayData(self.curSelectArrayId)[4 - arg_155_1].fight_girl then
						audio_manager:playeffectMusicTest("sound/dispatch")
					end
				end
			})
		end,
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[4 - arg_155_1]) then
				global_ShowBlockWords(L_Change_ARRAY_WARNING.Unlock)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			local var_160_0 = array_manager:getArenaDefenceArray()

			LayerManager:pushInLayer("GirlSelectLayer", {
				selectType = SELECT_GIRL_ARENA_DEFENCE,
				cursoul = var_160_0[4 - arg_155_1].fight_girl,
				arrayinfo = {
					pos = 4 - arg_155_1
				},
				jump_index = self:elementTowerAtrr(),
				adverturemode = self.adverturemode,
				sureCallBack = function(arg_161_0)
					self:playChangeRoleSound(4 - arg_155_1, cursoul)
					self:updateAllCell()
					self:updateTeamSkill(arg_161_0)
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()

					if array_manager:getArenaDefenceArray()[4 - arg_155_1].fight_girl then
						audio_manager:playeffectMusicTest("sound/dispatch")
					end
				end
			})
		end,
		[CONFIG_TYPE_ARENA] = function()
			if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[4 - arg_155_1]) then
				global_ShowBlockWords(L_Change_ARRAY_WARNING.Unlock)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			local var_162_0 = array_manager:getArenaAttackArray()

			LayerManager:pushInLayer("GirlSelectLayer", {
				selectType = SELECT_GIRL_ARENA_ATTACK,
				cursoul = var_162_0[4 - arg_155_1].fight_girl,
				arrayinfo = {
					pos = 4 - arg_155_1
				},
				jump_index = self:elementTowerAtrr(),
				adverturemode = self.adverturemode,
				sureCallBack = function(arg_163_0)
					self:playChangeRoleSound(4 - arg_155_1, cursoul)
					self:updateAllCell()
					self:updateTeamSkill(arg_163_0)
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()

					if array_manager:getArenaAttackArray()[4 - arg_155_1].fight_girl then
						audio_manager:playeffectMusicTest("sound/dispatch")
					end
				end
			})
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[4 - arg_155_1]) then
				global_ShowBlockWords(L_Change_ARRAY_WARNING.Unlock)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			if array_manager:isArrayPatrol(self.curSelectArrayId) then
				global_ShowBlockWords(L_Change_ARRAY_WARNING.Forbid_Change_Role)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			local var_164_0 = array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)[4 - arg_155_1].fight_girl

			self.selectGirl = array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)[4 - arg_155_1].fight_girl

			local var_164_1 = {
				selectType = SELECT_GIRL_EXPLORE_HP_INHERIT
			}

			var_164_1.exploringSouls = self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT and explore_manager:getExploringSouls() or nil
			var_164_1.cursoul = var_164_0
			var_164_1.is_hp_inherit = self.isHpInherit
			var_164_1.arrayinfo = {
				index = self.curSelectArrayId,
				pos = 4 - arg_155_1
			}
			var_164_1.jump_index = self:elementTowerAtrr()
			var_164_1.adverturemode = self.adverturemode

			function var_164_1.sureCallBack(arg_165_0)
				self.patrolingArrayTimer = patrol_manager:getPatrolingArray()

				self:playChangeRoleSound(4 - arg_155_1, var_164_0)
				self:updateAllCell()
				self:updateTeamSkill(arg_165_0)
				self:updateSureBtn()
				self:updateArrayFightCapacity()
				self:initArrayFightCapacity()

				if array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)[4 - arg_155_1].fight_girl then
					audio_manager:playeffectMusicTest("sound/dispatch")
				end
			end

			LayerManager:pushInLayer("GirlSelectLayer", var_164_1)
		end
	}

	if var_155_0[self.configType] then
		var_155_0[self.configType]()
	else
		if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[4 - arg_155_1]) then
			global_ShowBlockWords(L_Change_ARRAY_WARNING.Unlock)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		if array_manager:isArrayPatrol(self.curSelectArrayId) then
			global_ShowBlockWords(L_Change_ARRAY_WARNING.Forbid_Change_Role)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		local var_155_1 = array_manager:getBattleArrayData(self.curSelectArrayId)[4 - arg_155_1].fight_girl

		self.selectGirl = array_manager:getBattleArrayData(self.curSelectArrayId)[4 - arg_155_1].fight_girl

		local var_155_2 = {
			selectType = SELECT_GIRL_FIGHT
		}

		var_155_2.exploringSouls = self.configType == CONFIG_TYPE_EXPLORE and explore_manager:getExploringSouls() or nil
		var_155_2.cursoul = var_155_1
		var_155_2.is_hp_inherit = self.isHpInherit
		var_155_2.arrayinfo = {
			index = self.curSelectArrayId,
			pos = 4 - arg_155_1
		}
		var_155_2.jump_index = self:elementTowerAtrr()
		var_155_2.adverturemode = self.adverturemode

		function var_155_2.sureCallBack(arg_166_0)
			self.patrolingArrayTimer = patrol_manager:getPatrolingArray()

			self:playChangeRoleSound(4 - arg_155_1, cursoul)
			self:updateAllCell()
			self:updateTeamSkill(arg_166_0)
			self:updateSureBtn()
			self:updateArrayFightCapacity()
			self:initArrayFightCapacity()

			if array_manager:getBattleArrayData(self.curSelectArrayId)[4 - arg_155_1].fight_girl then
				audio_manager:playeffectMusicTest("sound/dispatch")
			end
		end

		LayerManager:pushInLayer("GirlSelectLayer", var_155_2)
	end
end

function BattleArrayLayerNew:changeAssistGirl(arg_167_1, arg_167_2)
	if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_167_1]) then
		global_ShowBlockWords(L_Change_ARRAY_WARNING.Unlock)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	local var_167_0
	local var_167_1
	local var_167_2 = {
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			var_167_0 = array_manager:getArenaDefenceArray()
			var_167_1 = SELECT_HORCRUX_ARENA_DEFENCE
		end,
		[CONFIG_TYPE_ARENA] = function()
			var_167_0 = array_manager:getArenaAttackArray()
			var_167_1 = SELECT_HORCRUX_ARENA_ATTACK
		end,
		[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
			var_167_0 = arenatft_manager:getDefenceArrayData(self.curSelectArrayId)
			var_167_1 = SELECT_HORCRUX_TVT_DEFENCE
		end,
		[CONFIG_TYPE_TVT_ATTACK_FORM] = function()
			var_167_0 = arenatft_manager:getAttackArrayData(self.curSelectArrayId)
			var_167_1 = SELECT_HORCRUX_TVT_ATTACK
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			var_167_0 = array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)
			var_167_1 = SELECT_HORCRUX_EXPLORE_HP_INHERIT
		end
	}

	if var_167_2[self.configType] then
		var_167_2[self.configType]()
	else
		var_167_0 = array_manager:getBattleArrayData(self.curSelectArrayId)
		var_167_1 = SELECT_HORCRUX_FIGHT

		if array_manager:isArrayPatrol(self.curSelectArrayId) then
			global_ShowBlockWords(L_Change_ARRAY_WARNING.Forbid_Change_Horcrux)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end
	end

	if not var_167_0[arg_167_1].fight_girl then
		global_ShowBlockWords(L_Change_ARRAY_WARNING.Role_Nil)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	local var_167_3 = {}

	for iter_167_0 = 1, 4 do
		if var_167_0[iter_167_0].assist_girl then
			table.insert(var_167_3, var_167_0[iter_167_0].assist_girl)
		end
	end

	local var_167_4 = var_167_0[arg_167_1].assist_girl and self:getAttrIconPath(playermodel.items[var_167_0[arg_167_1].assist_girl].itemid) or self:getAttrIconPath(var_167_0[arg_167_1].fight_girl)

	local function var_167_5()
		local var_173_0 = ccui.Helper:seekWidgetByName(arg_167_2, "scale_layer")

		if not var_173_0 then
			return
		end

		local var_173_1 = var_173_0:clone()

		var_173_0:setVisible(false)
		var_173_1:setOpacity(0)
		var_173_1:setPosition(cc.p(var_173_0:getPositionX(), var_173_0:getPositionY() + 100))
		var_173_0:getParent():addChild(var_173_1)
		var_173_1:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.3), (cc.EaseIn:create(cc.MoveBy:create(0.3, cc.p(0, -100)), 2.5))), cc.CallFunc:create(function()
			var_173_0:setVisible(true)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, var_173_0:getScale() * 2), cc.FadeOut:create(0.5)), (cc.CallFunc:create(function()
			var_173_1:removeFromParent()
		end))))
	end

	if var_167_0[arg_167_1].assist_girl and explore_manager:queryHorcruxIsUsed(var_167_0[arg_167_1].assist_girl) then
		global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Horcrux_Hp_Inherit)

		return
	end

	LayerManager:pushInLayer("HorcruxSelectLayer", {
		selectType = var_167_1,
		isHpInherit = self.isHpInherit,
		selectParam = {
			outSide = var_167_3
		},
		arrayIndex = self.curSelectArrayId,
		arrayPos = arg_167_1,
		curHorcrux = var_167_0[arg_167_1].assist_girl,
		defaultAttr = var_167_4,
		selectCallback = function()
			self.patrolingArrayTimer = patrol_manager:getPatrolingArray()

			self:updateAllCell()
			self:updateArrayFightCapacity(nil, 1, var_167_5)
			self:initArrayFightCapacity()

			local var_176_0
			local var_176_1 = {
				[CONFIG_TYPE_ARENA_DEFENCE] = function()
					var_176_0 = array_manager:getArenaDefenceArray()
				end,
				[CONFIG_TYPE_ARENA] = function()
					var_176_0 = array_manager:getArenaAttackArray()
				end,
				[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
					var_176_0 = arenatft_manager:getDefenceArrayData(self.curSelectArrayId)
				end,
				[SELECT_GIRL_TVT_ATTACK] = function()
					var_176_0 = arenatft_manager:getAttackArrayData(self.curSelectArrayId)
				end,
				[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
					var_176_0 = array_manager:getBattleArrayDataHpInherit(self.curSelectArrayId)
				end
			}

			if var_176_1[self.configType] then
				var_176_1[self.configType]()
			else
				var_176_0 = array_manager:getBattleArrayData(self.curSelectArrayId)

				self:updateSureBtn()
			end

			if var_176_0[arg_167_1].fight_girl and var_176_0[arg_167_1].assist_girl then
				audio_manager:playeffectMusicTest("sound/dispatch")
			end
		end,
		onTouchReturnBtnCallback = function(...)
			self:showFightPowerChange(var_167_0[arg_167_1].assist_girl)
		end
	})
end

function BattleArrayLayerNew:playChangeRoleSound(arg_183_1, arg_183_2)
	local var_183_0 = {
		[CONFIG_TYPE_ARENA_DEFENCE] = function()
			local var_184_0 = array_manager:getArenaDefenceArray()[arg_183_1].fight_girl

			if not var_184_0 then
				return
			end

			GlobalPlayRoleSound(global_get_servant_skin(var_184_0), ROLE_SOUND_TYPE.fight)
		end,
		[CONFIG_TYPE_ARENA] = function()
			local var_185_0 = array_manager:getArenaAttackArray()[arg_183_1].fight_girl

			if not var_185_0 then
				return
			end

			GlobalPlayRoleSound(global_get_servant_skin(var_185_0), ROLE_SOUND_TYPE.fight)
		end,
		[CONFIG_TYPE_TVT_DEFENCE_FORM] = function()
			local var_186_0 = arenatft_manager:getDefenceArrayData(self.curSelectArrayId)[arg_183_1].fight_girl

			if not var_186_0 then
				return
			end

			GlobalPlayRoleSound(global_get_servant_skin(var_186_0), ROLE_SOUND_TYPE.fight)
		end,
		[SELECT_GIRL_TVT_ATTACK] = function()
			local var_187_0 = arenatft_manager:getAttackArrayData(self.curSelectArrayId)[arg_183_1].fight_girl

			if not var_187_0 then
				return
			end

			GlobalPlayRoleSound(global_get_servant_skin(var_187_0), ROLE_SOUND_TYPE.fight)
		end
	}

	if var_183_0[self.configType] then
		var_183_0[self.configType]()
	else
		local var_183_1 = array_manager:getBattleArrayData(self.curSelectArrayId)

		if not var_183_1[arg_183_1].fight_girl then
			return
		end

		if var_183_1[arg_183_1].fight_girl == arg_183_2 then
			return
		end

		GlobalPlayRoleSound(global_get_servant_skin(var_183_1[arg_183_1].fight_girl), ROLE_SOUND_TYPE.fight)
	end
end

function BattleArrayLayerNew.getAttrIconPath(arg_188_0, arg_188_1)
	if servant_data[arg_188_1] then
		return (global_get_model_attr(servant_data[arg_188_1].modelid))
	else
		return (global_get_model_attr(horcrux_data[arg_188_1].model))
	end
end

function BattleArrayLayerNew:initBg(arg_189_1)
	local var_189_0 = ccui.Layout:create()

	var_189_0:setTouchEnabled(true)
	var_189_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_189_0:setAnchorPoint(cc.p(0, 0))
	var_189_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_189_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_189_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_189_0:setOpacity(0)
	self:addChild(var_189_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_190_0)
		self:addChild(arg_190_0, -2)
		arg_190_0:setPositionY(arg_190_0:getPositionY() - GameDisplay.fix_y)

		local var_190_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_190_0:setAnchorPoint(cc.p(0, 0))
		var_190_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_190_0, -1)
		self:init(arg_189_1)
		var_189_0:setOpacity(102)
		var_189_0:setTouchEnabled(false)
	end)
end

SpecialArrayLayer = class("SpecialArrayLayer", BattleArrayLayerNew.getClass("SpecialArrayLayer"))

function SpecialArrayLayer.create(arg_191_0, arg_191_1)
	local var_191_0 = SpecialArrayLayer.new()

	var_191_0:initBg(arg_191_1)

	return var_191_0
end

function SpecialArrayLayer:init(arg_192_1)
	var_0_34 = self
	self.active = true
	self.size = cc.Director:getInstance():getVisibleSize()
	self.initconfig = arg_192_1

	if arg_192_1 then
		self.configType = arg_192_1.configtype or CONFIG_TYPE_NORMAL
	end

	self.configCallback = arg_192_1 and arg_192_1.configcallback
	self.configexitCallback = arg_192_1 and arg_192_1.exitcallback
	self.isHpInherit = arg_192_1 and arg_192_1.is_hp_inherit

	LayerManager:createFullScreenMask(self, 0, function(arg_193_0, arg_193_1)
		if arg_193_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BattleArrayLayer.json" or "BattleArrayLayer.ExportJson")

	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	local var_192_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")
	local var_192_1 = cc.Label:createWithTTF("", FONT_BUTTON, 30)

	var_192_1:setName("label_btn")
	var_192_1:setColor(cc.c3b(0, 0, 0))
	var_192_0:addChild(var_192_1, 999)

	self.auto_btn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_18")

	self.auto_btn:setVisible(false)

	if self.auto_btn then
		self.auto_btn:addTouchEventListener(function(arg_194_0, arg_194_1)
			if arg_194_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:dealAutoArray()
		end)
	end

	var_192_0:addTouchEventListener(function(arg_195_0, arg_195_1)
		if arg_195_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_195_0:isBright() then
			return
		end

		arg_195_0:setBright(false)
		self:btnSureEvent(function()
			arg_195_0:setBright(true)
		end)
	end)
	self.rootLayer:addTouchEventListener(function(arg_197_0, arg_197_1)
		if arg_197_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	self:initSpecialArray()
	self:initUI()
	self:updateAllCell()
	self:initArrayFightCapacity()
	self:initArrayListPanel()
	self:updateTeamSkill()
	self:registerScriptHandler(function(arg_198_0)
		if arg_198_0 == "exit" then
			var_0_34 = nil

			if self.adventuretowercallback then
				self.adventuretowercallback()
			end
		end
	end)
end

function SpecialArrayLayer:initArrayListPanel()
	self.arrayListView = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_arrayList")
	self.btnList = {}

	local var_199_0 = ccui.ImageView:create("public/button/array_inde_btn_add.png", var_0_30)

	var_199_0:setName("array_index_special")
	table.insert(self.btnList, var_199_0)
	self.arrayListView:pushBackCustomItem(var_199_0)

	local var_199_1 = cc.Label:createWithTTF(L_SPECIAL_TEAM_TIP.Team, FONT_NAME, 28)

	var_199_1:setColor(cc.c3b(0, 0, 0))
	var_199_1:setName("label")
	var_199_1:setPositionX(var_199_0:getContentSize().width / 2)
	var_199_1:setPositionY(var_199_0:getContentSize().height / 2)
	var_199_0:addChild(var_199_1)
end

function SpecialArrayLayer:btnSureEvent(arg_200_1)
	({
		[CONFIG_TYPE_EXPLORE] = function()
			if not self.active then
				return
			end

			local var_201_0 = true

			for iter_201_0, iter_201_1 in pairs(self.specialArray) do
				if iter_201_1.npcid or iter_201_1.girlInfo then
					var_201_0 = false

					break
				end
			end

			if not var_201_0 then
				if self.configCallback then
					self.configCallback(self.specialArray)
				end

				self:exit()
			else
				global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Team_Nil, RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
			end

			if arg_200_1 then
				arg_200_1()
			end
		end,
		[CONFIG_TYPE_EXPLORE_HP_INHERIT] = function()
			if not self.active then
				return
			end

			local var_202_0 = true

			for iter_202_0, iter_202_1 in pairs(self.specialArray) do
				if iter_202_1.npcid or iter_202_1.girlInfo then
					var_202_0 = false

					break
				end
			end

			if not var_202_0 then
				if self.configCallback then
					self.configCallback(self.specialArray)
				end

				self:exit()
			else
				global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Team_Nil, RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
			end

			if arg_200_1 then
				arg_200_1()
			end
		end
	})[self.configType]()
end

function SpecialArrayLayer:initSpecialArray(arg_203_1)
	self.specialArray = {}

	local var_203_0 = 0

	for iter_203_0, iter_203_1 in ipairs(arg_203_1 or self.initconfig.fix_array) do
		local var_203_1 = npc_fightconfig_data[iter_203_1.npcid]

		if npc_fightconfig_data[iter_203_1.npcid] then
			if explore_manager:getHpInherit(iter_203_1.npcid) <= 0 then
				self.specialArray[iter_203_0] = {
					pos_lock = iter_203_1.pos_lock and true or false
				}
			else
				var_203_0 = var_203_0 + 1

				local var_203_2 = {
					pos_lock = true,
					npcid = iter_203_1.npcid
				}
				local var_203_3 = {
					npcsoulid = var_203_1.npcsoulid,
					servantId = var_203_1.servantid
				}

				var_203_3.servantskin = var_203_1.servantskin or -1
				var_203_3.rank = var_203_1.rank or 0

				if var_203_1.level then
					var_203_3.level = var_203_1.rank * 100 + var_203_1.level or 1
				end

				var_203_3.contract = var_203_1.contract
				var_203_2.girlInfo = var_203_3
				var_203_2.horcruxInfo = var_203_1.horcrux
				var_203_2.isMainCharacter = not not iter_203_1.isMainCharacter
				self.specialArray[iter_203_0] = var_203_2
			end
		else
			self.specialArray[iter_203_0] = {
				pos_lock = iter_203_1.pos_lock and true or false
			}

			if not iter_203_1.fight_girl then
				self.specialArray[iter_203_0].girlInfo = nil
				self.specialArray[iter_203_0].horcruxInfo = nil
			else
				self.specialArray[iter_203_0].girlInfo = self.specialArray[iter_203_0].girlInfo or {}
				self.specialArray[iter_203_0].girlInfo.servantId = iter_203_1.fight_girl
				self.specialArray[iter_203_0].girlInfo.rank = core_manager:getServantCoreRank(iter_203_1.fight_girl)
				self.specialArray[iter_203_0].girlInfo.level = core_manager:getCoreLv(fight_girl)
				self.specialArray[iter_203_0].girlInfo.contract = playermodel.soulContract[iter_203_1.fight_girl]
				self.specialArray[iter_203_0].girlInfo.servantskin = playermodel.servantUsedskin[iter_203_1.fight_girl]
				self.specialArray[iter_203_0].girlInfo.soulOC = playermodel.soulOverClock[iter_203_1.fight_girl] or 0

				if iter_203_1.assist_girl then
					self.specialArray[iter_203_0].horcruxInfo = self.specialArray[iter_203_0].horcruxInfo or {}
					self.specialArray[iter_203_0].horcruxInfo.entityid = iter_203_1.assist_girl
					self.specialArray[iter_203_0].horcruxInfo.itemid = playermodel.items[iter_203_1.assist_girl].itemid
					self.specialArray[iter_203_0].horcruxInfo.star = horcrux_manager:getHorcruxStarLevel(iter_203_1.assist_girl)
					self.specialArray[iter_203_0].horcruxInfo.hlv = horcrux_manager:getHorcruxHLV(iter_203_1.assist_girl)
					self.specialArray[iter_203_0].horcruxInfo.hclass = horcrux_manager:getHorcruxHClass(iter_203_1.assist_girl)
					self.specialArray[iter_203_0].horcruxInfo.hbreak = horcrux_manager:getHorcruxBreakLv(iter_203_1.assist_girl)
					self.specialArray[iter_203_0].horcruxInfo.dfac = horcrux_manager:getHorcruxDamageFac(iter_203_1.assist_girl)
					self.specialArray[iter_203_0].horcruxInfo.hfac = horcrux_manager:getHorcruxHpFac(iter_203_1.assist_girl)
				end
			end
		end
	end

	if var_203_0 == 0 and self.isHpInherit then
		self.auto_btn:setVisible(true)
	end
end

function SpecialArrayLayer:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_36"):loadTexture("Array/title_select_team.png", var_0_30)

	local var_204_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")

	var_204_0:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_30)

	local var_204_1 = var_204_0:getChildByName("label_btn")

	var_204_1:setString(L_BUTTON_TEXT.Battle_Array_Btn.Sent_team)
	var_204_1:setColor(cc.c3b(12, 12, 12))
	var_204_1:setPosition(cc.p(var_204_0:getContentSize().width / 2, var_204_0:getContentSize().height / 2 - 5))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_33"):setString(var_0_32)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attrTips"):addTouchEventListener(function(arg_205_0, arg_205_1)
		if arg_205_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:displayTips()
	end)

	local var_204_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_fightCapacitySumIcon")

	self.fightCapacityLabel = ccui.TextBMFont:create(1, "fonts/array_fightcapacity_number.fnt")

	self.fightCapacityLabel:setPositionX(var_204_2:getPositionX() + var_204_2:getContentSize().width / 2)
	self.fightCapacityLabel:setPositionY(var_204_2:getPositionY())
	self.fightCapacityLabel:setAnchorPoint(cc.p(0, 0.5))
	self.fightCapacityLabel:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.fightCapacityLabel)

	self.slot1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot")

	self.slot1:setPositionX(-320)

	self.slot2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot2:setPositionX(-160)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot2)

	self.slot3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot3:setPositionX(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot3)

	self.slot4 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot4:setPositionX(160)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot4)
	ccui.Helper:seekWidgetByName(self.slot1, "Image_attrMatch"):setName("Image_attrMatch_1")
	ccui.Helper:seekWidgetByName(self.slot2, "Image_attrMatch"):setName("Image_attrMatch_2")
	ccui.Helper:seekWidgetByName(self.slot3, "Image_attrMatch"):setName("Image_attrMatch_3")
	ccui.Helper:seekWidgetByName(self.slot4, "Image_attrMatch"):setName("Image_attrMatch_4")

	self.slotList = {}
	self.slotList[1] = self.slot1
	self.slotList[2] = self.slot2
	self.slotList[3] = self.slot3
	self.slotList[4] = self.slot4

	local var_204_3 = {
		"Array/1st.png",
		"Array/2nd.png",
		"Array/3rd.png",
		"Array/4th.png"
	}
	local var_204_4 = 0

	for iter_204_0, iter_204_1 in pairs(self.slotList) do
		ccui.Helper:seekWidgetByName(self.slotList[iter_204_0], "Image_slotIndex"):loadTexture(var_204_3[iter_204_0], var_0_30)

		local var_204_5 = GirlSprite:create({
			initType = "enemyStyle",
			isHpInherit = self.isHpInherit
		})

		var_204_5:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant"):getContentSize().width / 2)
		var_204_5:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant"):getContentSize().height / 2)
		var_204_5:setName("girlSprite")
		var_204_5:setTouchEnabled(false)
		ccui.Helper:seekWidgetByName(self.slotList[iter_204_0], "Panel_servant"):addChild(var_204_5, 10)

		local var_204_6 = HorcruxSprite:create({
			initType = "enemyArrayMemberStyle"
		})

		var_204_6:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcrux"):getContentSize().width / 2)
		var_204_6:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcrux"):getContentSize().height / 2)
		var_204_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_204_6:setName("horcruxSprite")
		var_204_6:setTouchEnabled(false)
		ccui.Helper:seekWidgetByName(self.slotList[iter_204_0], "Panel_horcrux"):addChild(var_204_6, 10)
		iter_204_1:getChildByName("Panel_servant"):getChildByName("Image_add"):setName("servant_add_img_" .. iter_204_0)
		iter_204_1:getChildByName("Panel_servant"):getChildByName("Image_bg"):setName("servant_bg_img_" .. iter_204_0)

		local var_204_7 = 1

		iter_204_1:getChildByName("Panel_servant"):getChildByName("servant_bg_img_" .. iter_204_0):addTouchEventListener(function(arg_206_0, arg_206_1)
			if arg_206_1 == ccui.TouchEventType.began then
				var_204_5:imgScaleTo(1.1, 0.1)
				iter_204_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_204_0):runAction(cc.ScaleTo:create(0.1, var_204_7 * 0.9, var_204_7 * 0.9))
				arg_206_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					var_204_5:startPressBar(function()
						if self.specialArray[iter_204_0].girlInfo and not self.specialArray[iter_204_0].npcid then
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = 6,
								cursoul = self.specialArray[iter_204_0].girlInfo.servantId
							})

							var_204_4 = 0.2
						else
							var_204_4 = 0
						end

						var_204_5:endPressBar()
					end, function(arg_209_0)
						var_204_4 = var_204_4 + arg_209_0
					end)
				end)))
			elseif arg_206_1 == ccui.TouchEventType.canceled then
				var_204_5:imgScaleTo(1, 0.1)
				iter_204_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_204_0):runAction(cc.ScaleTo:create(0.1, var_204_7 * 1, var_204_7 * 1))
				arg_206_0:stopAllActions()
				var_204_5:endPressBar()
			elseif arg_206_1 == ccui.TouchEventType.ended then
				arg_206_0:stopAllActions()

				if var_204_4 == 0 then
					self:changeRole(4 - iter_204_0)
				end

				var_204_4 = 0

				var_204_5:endPressBar()
				var_204_5:imgScaleTo(1, 0.1)
				iter_204_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_204_0):runAction(cc.ScaleTo:create(0.1, var_204_7 * 1, var_204_7 * 1))
			end
		end)
		iter_204_1:getChildByName("Panel_horcrux"):getChildByName("Image_bg"):setName("horcrux_bg_img_" .. iter_204_0)
		iter_204_1:getChildByName("Panel_horcrux"):getChildByName("horcrux_bg_img_" .. iter_204_0):addTouchEventListener(function(arg_210_0, arg_210_1)
			if arg_210_1 == ccui.TouchEventType.began then
				var_204_6:imgScaleTo(1.1, 0.1)

				if self.specialArray[iter_204_0].horcruxInfo then
					local var_210_0 = self.specialArray[iter_204_0].horcruxInfo.entityid or nil

					if var_210_0 and explore_manager:queryHorcruxIsUsed(var_210_0) then
						global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Horcrux_Hp_Inherit)

						return false
					end
				end

				arg_210_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					var_204_6:startPressBar(function()
						if self.specialArray[iter_204_0].girlInfo and self.specialArray[iter_204_0].horcruxInfo and self.specialArray[iter_204_0].horcruxInfo.entityid and not self.specialArray[iter_204_0].npcid then
							LayerManager:pushInLayer("HorcruxInfoLayer", self.specialArray[iter_204_0].horcruxInfo.entityid, nil, self.isHpInherit)

							var_204_4 = 0.2
						else
							var_204_4 = 0
						end

						var_204_6:endPressBar()
					end, function(arg_213_0)
						var_204_4 = var_204_4 + arg_213_0
					end)
				end)))
			elseif arg_210_1 == ccui.TouchEventType.canceled then
				var_204_6:imgScaleTo(1, 0.1)
				arg_210_0:stopAllActions()
				var_204_6:endPressBar()
			elseif arg_210_1 == ccui.TouchEventType.ended then
				arg_210_0:stopAllActions()

				if var_204_4 == 0 then
					self:changeAssistGirl(iter_204_0, var_204_6)
				end

				var_204_4 = 0

				var_204_6:endPressBar()
				var_204_6:imgScaleTo(1, 0.1)
			end
		end)
		ccui.Helper:seekWidgetByName(iter_204_1, "Image_skill1"):addTouchEventListener(function(arg_214_0, arg_214_1)
			if arg_214_1 == ccui.TouchEventType.began then
				var_204_6:showSkillPanel(iter_204_1.skill1id)
			elseif arg_214_1 == ccui.TouchEventType.canceled then
				var_204_6:hideSkillPanel()
			elseif arg_214_1 == ccui.TouchEventType.ended then
				var_204_6:hideSkillPanel()
			end
		end)
		ccui.Helper:seekWidgetByName(iter_204_1, "Image_skill2"):addTouchEventListener(function(arg_215_0, arg_215_1)
			if arg_215_1 == ccui.TouchEventType.began then
				var_204_6:showSkillPanel(iter_204_1.skill2id)
			elseif arg_215_1 == ccui.TouchEventType.canceled then
				var_204_6:hideSkillPanel()
			elseif arg_215_1 == ccui.TouchEventType.ended then
				var_204_6:hideSkillPanel()
			end
		end)
	end
end

function SpecialArrayLayer:initTeamSkill()
	local var_216_0 = {}

	for iter_216_0, iter_216_1 in ipairs(self.specialArray) do
		if npc_fightconfig_data[iter_216_1.npcid] and npc_fightconfig_data[iter_216_1.npcid].npcsoulid then
			table.insert(var_216_0, {
				fight_girl = npcData[npc_fightconfig_data[iter_216_1.npcid].npcsoulid].model,
				pos = iter_216_0,
				npcid = npcid
			})
		elseif npc_fightconfig_data[iter_216_1.npcid] then
			table.insert(var_216_0, {
				fight_girl = npc_fightconfig_data[iter_216_1.npcid].servantid,
				pos = iter_216_0,
				npcid = npcid
			})
		end
	end

	self.super.initTeamSkill(self, var_216_0)
end

function SpecialArrayLayer:updateTeamSkill(arg_217_1)
	if not self.eleBtn then
		return
	end

	local var_217_0 = self.eleBtn:getChildByName("eleIcon")

	self.eleBtn:getChildByName("eleIconBack"):stopAllActions()

	local var_217_1 = {}

	for iter_217_0, iter_217_1 in ipairs(self.specialArray) do
		if npc_fightconfig_data[iter_217_1.npcid] and npc_fightconfig_data[iter_217_1.npcid].npcsoulid then
			fight_girl = npcData[npc_fightconfig_data[iter_217_1.npcid].npcsoulid].model

			table.insert(var_217_1, {
				fight_girl = fight_girl,
				pos = iter_217_0,
				npcid = iter_217_1.npcid
			})
		elseif npc_fightconfig_data[iter_217_1.npcid] then
			fight_girl = npc_fightconfig_data[iter_217_1.npcid].servantid

			table.insert(var_217_1, {
				fight_girl = fight_girl,
				pos = iter_217_0,
				npcid = iter_217_1.npcid
			})
		elseif iter_217_1.girlInfo then
			fight_girl = iter_217_1.girlInfo.servantId

			table.insert(var_217_1, {
				fight_girl = fight_girl,
				pos = iter_217_0,
				npcid = iter_217_1.npcid
			})
		end
	end

	self.super.updateTeamSkill(self, arg_217_1, var_217_1)
end

function SpecialArrayLayer:updateUI()
	self.fightCapacityLabel:setString(global_trans_bitmapnumber((fight_capacity_manager:getNpcArrayFightCapacity(self.specialArray))))
	self:initArrayFightCapacity()
end

function SpecialArrayLayer:updateAllCell()
	print(dump(self.specialArray))

	for iter_219_0 = 1, 4 do
		self:update_special_slot(self.specialArray[iter_219_0], iter_219_0)
	end
end

function SpecialArrayLayer:update_special_slot(arg_220_1, arg_220_2)
	local var_220_0 = self.slotList[arg_220_2]
	local var_220_1 = arg_220_1.girlInfo
	local var_220_2 = arg_220_1.horcruxInfo
	local var_220_3

	if arg_220_1.girlInfo then
		var_220_3 = var_220_1.servantId or nil

		local var_220_4

		if var_220_2 then
			var_220_4 = var_220_2.itemid or nil
		end
	end

	var_220_0.pos_lock = arg_220_1.pos_lock
	var_220_0.servantid = var_220_3
	var_220_0.horcruxid = var_220_4
	var_220_0.skill1id = nil
	var_220_0.skill2id = nil

	while item_data[var_220_4] and item_data[var_220_4]["skill" .. 1] do
		var_220_0["skill" .. 1 .. "id"] = item_data[var_220_4]["skill" .. 1]
	end

	ccui.Helper:seekWidgetByName(var_220_0, "Image_skill1"):setVisible(var_220_0.skill1id ~= nil)
	ccui.Helper:seekWidgetByName(var_220_0, "Image_skill2"):setVisible(var_220_0.skill2id ~= nil)
	ccui.Helper:seekWidgetByName(var_220_0, "Image_skill1"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_220_0, "Image_skill2"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_220_0, "Label_damageAdd"):setVisible(var_220_4 ~= nil)
	ccui.Helper:seekWidgetByName(var_220_0, "Label_hpAdd"):setVisible(var_220_4 ~= nil)
	ccui.Helper:seekWidgetByName(var_220_0, "fightCapacityLabel"):setVisible(var_220_3 ~= nil)
	ccui.Helper:seekWidgetByName(var_220_0, "Image_fightCapacityIcon"):setVisible(var_220_3 ~= nil)
	ccui.Helper:seekWidgetByName(var_220_0, "Panel_fightpower"):setVisible(var_220_3 ~= nil)
	ccui.Helper:seekWidgetByName(var_220_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_220_2):setVisible(var_220_3 == nil)
	ccui.Helper:seekWidgetByName(var_220_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_220_2):setOpacity(var_220_3 == nil and 255 or 0)
	ccui.Helper:seekWidgetByName(var_220_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_220_2):setOpacity(var_220_4 == nil and 255 or 0)

	local var_220_6 = ccui.Helper:seekWidgetByName(var_220_0, "girlSprite")

	if var_220_1 then
		var_220_6:update(var_220_1, arg_220_1.npcid)
		var_220_6:setVisible(true)

		if arg_220_1.npcid then
			ccui.Helper:seekWidgetByName(var_220_0, "Image_slotIndex"):loadTexture("Array/array_locked.png", var_0_30)
			var_220_0:getChildByName("Panel_servant"):getChildByName("servant_bg_img_" .. arg_220_2):addTouchEventListener(function(arg_221_0, arg_221_1)
				if arg_221_1 ~= ccui.TouchEventType.ended then
					return
				end

				global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Forbid_Change_Role)
			end)
		end

		if not arg_220_1.npcid and role_false_level_manager:isRoleFalseLevelMember(var_220_3, self.configType, self.adverturemode) then
			local var_220_7, var_220_8 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_220_3, self.configType, self.adverturemode)

			var_220_6:updateByFalseLevel(var_220_3, var_220_7, var_220_8)
		else
			var_220_6:stopFalseLevelAni()
		end
	elseif arg_220_1.pos_lock and not self.isHpInherit then
		var_220_6:setVisible(false)
		ccui.Helper:seekWidgetByName(var_220_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_220_2):loadTexture("Array/servant_lock.png", var_0_30)
		ccui.Helper:seekWidgetByName(var_220_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_220_2):setVisible(false)
		ccui.Helper:seekWidgetByName(var_220_0, "Image_attrMatch_" .. arg_220_2):loadTexture("Array/attr_non.png", var_0_30)
		var_220_0:getChildByName("Panel_servant"):getChildByName("servant_bg_img_" .. arg_220_2):addTouchEventListener(function(arg_222_0, arg_222_1)
			if arg_222_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Girls)
		end)
	else
		var_220_6:setVisible(false)
	end

	local var_220_9 = ccui.Helper:seekWidgetByName(var_220_0, "horcruxSprite")

	if var_220_2 then
		var_220_9:update({
			horcrux = var_220_2
		})
		var_220_9:setVisible(true)

		if arg_220_1.npcid then
			var_220_0:getChildByName("Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_220_2):addTouchEventListener(function(arg_223_0, arg_223_1)
				if arg_223_1 ~= ccui.TouchEventType.ended then
					return
				end

				global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Horcrux)
			end)
		end
	elseif arg_220_1.pos_lock and not self.isHpInherit then
		var_220_9:setVisible(false)
		ccui.Helper:seekWidgetByName(var_220_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_220_2):loadTexture("Array/horcrux_lock.png", var_0_30)
		ccui.Helper:seekWidgetByName(var_220_0, "Image_attrMatch_" .. arg_220_2):loadTexture("Array/attr_non.png", var_0_30)
		var_220_0:getChildByName("Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_220_2):addTouchEventListener(function(arg_224_0, arg_224_1)
			if arg_224_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Horcrux)
		end)
	else
		var_220_9:setVisible(false)
	end

	if var_220_2 then
		local var_220_10 = self:getAttrIconPath(var_220_1.servantId)
		local var_220_11 = self:getAttrIconPath(var_220_2.itemid)
		local var_220_12 = horcrux_manager:getArenaHorcruxAssistConfigWithServant(var_220_2, math.floor((var_220_1.level or 1) / 100))

		var_220_0.skill1id = var_220_12.skills[1]
		var_220_0.skill2id = var_220_12.skills[2]

		if var_220_10 == var_220_11 then
			ccui.Helper:seekWidgetByName(var_220_0, "Image_attrMatch_" .. arg_220_2):loadTexture("Array/attr_" .. var_220_10 .. ".png", var_0_30)
		elseif var_220_10 == "imaginary" then
			ccui.Helper:seekWidgetByName(var_220_0, "Image_attrMatch_" .. arg_220_2):loadTexture("Array/frame_add_attribute_half.png", var_0_30)
		else
			ccui.Helper:seekWidgetByName(var_220_0, "Image_attrMatch_" .. arg_220_2):loadTexture("Array/frame_add_attribute_half.png", var_0_30)
		end

		local var_220_13 = horcrux_manager:getServantAttrAddPercent(var_220_11, global_get_all_servant_attrs(var_220_1.servantId))

		ccui.Helper:seekWidgetByName(var_220_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(math.floor(var_220_12.damage * var_220_13.damage)))
		ccui.Helper:seekWidgetByName(var_220_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(math.floor(var_220_12.hp * var_220_13.hp)))
	else
		ccui.Helper:seekWidgetByName(var_220_0, "Image_attrMatch_" .. arg_220_2):loadTexture("Array/attr_non.png", var_0_30)
	end

	if var_220_0.skill1id then
		var_220_14 = 0 + 1

		ccui.Helper:seekWidgetByName(var_220_0, "Image_skill1"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[var_220_0.skill1id].icon .. ".png", var_0_30)
	end

	if var_220_0.skill2id then
		ccui.Helper:seekWidgetByName(var_220_0, "Image_skill2"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[var_220_0.skill2id].icon .. ".png", var_0_30)
	end

	local var_220_16 = {
		arg_220_1
	}

	ccui.Helper:seekWidgetByName(var_220_0, "fightCapacityLabel").fightCapacityBefore = ccui.Helper:seekWidgetByName(var_220_0, "fightCapacityLabel").fightCapacity

	ccui.Helper:seekWidgetByName(var_220_0, "fightCapacityLabel"):setString(global_trans_number(fight_capacity_manager:getNpcArrayFightCapacity(var_220_16, self.specialArray)))

	ccui.Helper:seekWidgetByName(var_220_0, "fightCapacityLabel").fightCapacity = fight_capacity_manager:getNpcArrayFightCapacity(var_220_16)

	local var_220_17 = ccui.Helper:seekWidgetByName(var_220_0, "Image_fightCapacityIcon")

	var_220_17:setPositionX(ccui.Helper:seekWidgetByName(var_220_0, "fightCapacityLabel"):getPositionX() - ccui.Helper:seekWidgetByName(var_220_0, "fightCapacityLabel"):getContentSize().width - var_220_17:getContentSize().width / 2)

	local var_220_18 = component_manager:getSoulComponentlist(var_220_3)
	local var_220_19 = {
		82,
		62,
		42
	}

	for iter_220_0 = 1, 3 do
		if not playermodel.component[var_220_3] or not playermodel.component[var_220_3][iter_220_0] then
			ccui.Helper:seekWidgetByName(var_220_0, "Panel_component"):getChildByName("Image_add_" .. iter_220_0):setVisible(true)
			ccui.Helper:seekWidgetByName(var_220_0, "Panel_component"):getChildByName("Image_component_" .. iter_220_0):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(var_220_0, "Panel_component"):getChildByName("Image_add_" .. iter_220_0):setVisible(false)
			ccui.Helper:seekWidgetByName(var_220_0, "Panel_component"):getChildByName("Image_component_" .. iter_220_0):setVisible(true)
			ccui.Helper:seekWidgetByName(var_220_0, "Panel_component"):getChildByName("Image_component_" .. iter_220_0):loadTexture(item_data[playermodel.items[playermodel.component[var_220_3][iter_220_0].id].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_220_3][iter_220_0].id].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[playermodel.component[var_220_3][iter_220_0].id].itemid].main_attr .. "_" .. iter_220_0 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_220_3][iter_220_0].id].component_attr.effect].image_id .. "_" .. playermodel.items[playermodel.component[var_220_3][iter_220_0].id].component_attr.attr1 .. "_" .. iter_220_0 .. ".png")

			if var_220_18.effect then
				ccui.Helper:seekWidgetByName(var_220_0, "Panel_component"):getChildByName("Image_component_" .. iter_220_0):setPositionY(var_220_19[2])
			else
				ccui.Helper:seekWidgetByName(var_220_0, "Panel_component"):getChildByName("Image_component_" .. iter_220_0):setPositionY(var_220_19[iter_220_0])
			end
		end
	end

	ccui.Helper:seekWidgetByName(var_220_0, "Image_component_bg"):addTouchEventListener(function(arg_225_0, arg_225_1)
		if arg_225_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_220_0.pos_lock then
			return
		end

		if not var_220_3 then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			cursoul = var_220_3,
			exitCallback = function(...)
				self:updateAllCell()
			end
		})
	end)
end

function SpecialArrayLayer:initArrayFightCapacity()
	local var_227_0 = fight_capacity_manager:getNpcArrayFightCapacity(self.specialArray)

	explore_manager:setCurFightCapacity(var_227_0)

	self.oldFightCapacity = var_227_0
	self.oldBattleInfo = self.specialArray
	self.oldArray = global_deepCopy(self.specialArray)

	self.fightCapacityLabel:setString((global_trans_bitmapnumber(var_227_0)))
end

function SpecialArrayLayer:updateArrayFightCapacity(arg_228_1)
	local var_228_0 = fight_capacity_manager:getNpcArrayFightCapacity(self.specialArray)

	if self.oldFightCapacity then
		fight_capacity_manager:displayNpcArrayChangeValue(self.specialArray, self.oldArray, self.oldFightCapacity, arg_228_1)
	end

	self.oldFightCapacity = var_228_0
	self.oldBattleInfo = self.specialArray
	self.oldArray = global_deepCopy(self.specialArray)

	self.fightCapacityLabel:setString(global_trans_bitmapnumber(var_228_0))
	explore_manager:setCurFightCapacity(var_228_0)
	self.fightCapacityLabel:setString((global_trans_bitmapnumber(var_228_0)))
end

function SpecialArrayLayer:updateSureBtn()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString("")
end

function SpecialArrayLayer:changeRole(arg_230_1)
	local var_230_0 = {}

	if var_230_0[self.configType] then
		var_230_0[self.configType]()
	else
		local var_230_1

		if self.specialArray[4 - arg_230_1].girlInfo then
			var_230_1 = self.specialArray[4 - arg_230_1].girlInfo.servantId or nil
		end

		local var_230_2 = {}

		for iter_230_0, iter_230_1 in pairs(self.specialArray) do
			if iter_230_1.girlInfo and not iter_230_1.npcid then
				var_230_2[iter_230_1.girlInfo.servantId] = true
			end
		end

		LayerManager:pushInLayer("GirlSelectLayer", {
			selectType = SELECT_GIRL_SPECIAL,
			cursoul = var_230_1,
			is_hp_inherit = self.isHpInherit,
			usedServants = var_230_2,
			sureCallBack = function(arg_231_0)
				if self.specialArray[4 - arg_230_1].npcid then
					return
				end

				if not arg_231_0 then
					self.specialArray[4 - arg_230_1].girlInfo = nil
					self.specialArray[4 - arg_230_1].horcruxInfo = nil
				else
					self.specialArray[4 - arg_230_1].girlInfo = self.specialArray[4 - arg_230_1].girlInfo or {}
					self.specialArray[4 - arg_230_1].girlInfo.servantId = arg_231_0
					self.specialArray[4 - arg_230_1].girlInfo.rank = core_manager:getServantCoreRank(arg_231_0)
					self.specialArray[4 - arg_230_1].girlInfo.level = core_manager:getCoreLv(arg_231_0)
					self.specialArray[4 - arg_230_1].girlInfo.contract = playermodel.soulContract[arg_231_0]
					self.specialArray[4 - arg_230_1].girlInfo.servantskin = playermodel.servantUsedskin[arg_231_0]
					self.specialArray[4 - arg_230_1].girlInfo.soulOC = playermodel.soulOverClock[arg_231_0] or 0

					if self.specialArray[4 - arg_230_1].horcruxInfo and explore_manager:queryHorcruxIsUsed(self.specialArray[4 - arg_230_1].horcruxInfo.entityid) then
						self.specialArray[4 - arg_230_1].horcruxInfo = nil
					end

					local var_231_0 = explore_manager:getHorcruxByServantId(arg_231_0)

					if var_231_0 then
						self.specialArray[4 - arg_230_1].horcruxInfo = self:getHorcruxInfoById(var_231_0)
					end
				end

				self:playChangeRoleSound(4 - arg_230_1, var_230_1)
				self:updateAllCell()
				self:updateSureBtn()
				self:updateArrayFightCapacity()
				self:initArrayFightCapacity()

				if arg_231_0 then
					audio_manager:playeffectMusicTest("sound/dispatch")
				end
			end
		})
	end
end

function SpecialArrayLayer:playChangeRoleSound(arg_232_1, arg_232_2)
	if self.specialArray[arg_232_1].npcid then
		return
	end

	if not self.specialArray[arg_232_1].girlInfo then
		return
	end

	local var_232_0

	if self.specialArray[arg_232_1].girlInfo then
		var_232_0 = self.specialArray[arg_232_1].girlInfo.servantId or nil

		if var_232_0 == arg_232_2 then
			return
		end
	end

	GlobalPlayRoleSound(global_get_servant_skin(var_232_0), ROLE_SOUND_TYPE.fight)
end

function SpecialArrayLayer:changeAssistGirl(arg_233_1, arg_233_2)
	local var_233_0
	local var_233_2 = {}

	if var_233_2[self.configType] then
		var_233_2[self.configType]()
	else
		var_233_0 = self.specialArray
	end

	if not var_233_0[arg_233_1].girlInfo then
		global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Assist_Girl_Nil)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	local var_233_3 = {}

	for iter_233_0 = 1, 4 do
		if var_233_0[iter_233_0].horcruxInfo and not var_233_0[iter_233_0].npcid then
			table.insert(var_233_3, var_233_0[iter_233_0].horcruxInfo.entityid)
		end
	end

	local var_233_4 = var_233_0[arg_233_1].horcruxInfo and var_233_0[arg_233_1].horcruxInfo.entityid and self:getAttrIconPath(playermodel.items[var_233_0[arg_233_1].horcruxInfo.entityid].itemid) or self:getAttrIconPath(var_233_0[arg_233_1].girlInfo.servantId)

	local function var_233_5()
		local var_234_0 = ccui.Helper:seekWidgetByName(arg_233_2, "scale_layer")

		if not var_234_0 then
			return
		end

		local var_234_1 = var_234_0:clone()

		var_234_0:setVisible(false)
		var_234_1:setOpacity(0)
		var_234_1:setPosition(cc.p(var_234_0:getPositionX(), var_234_0:getPositionY() + 100))
		var_234_0:getParent():addChild(var_234_1)
		var_234_1:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.3), (cc.EaseIn:create(cc.MoveBy:create(0.3, cc.p(0, -100)), 2.5))), cc.CallFunc:create(function()
			var_234_0:setVisible(true)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, var_234_0:getScale() * 2), cc.FadeOut:create(0.5)), (cc.CallFunc:create(function()
			var_234_1:removeFromParent()
		end))))
	end

	if var_233_0[arg_233_1].horcruxInfo then
		local var_233_6 = var_233_0[arg_233_1].horcruxInfo.entityid or nil

		if var_233_6 and explore_manager:queryHorcruxIsUsed(var_233_6) then
			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Horcrux_Hp_Inherit)

			return
		end
	end

	local var_233_7 = {
		selectType = SELECT_HORCRUX_SPECIAL,
		isHpInherit = self.isHpInherit,
		selectParam = {
			outSide = var_233_3
		},
		battleInfo = var_233_0,
		arrayPos = arg_233_1
	}

	if var_233_0[arg_233_1].horcruxInfo then
		var_233_7.curHorcrux = var_233_0[arg_233_1].horcruxInfo.entityid or nil
	end

	var_233_7.defaultAttr = var_233_4

	function var_233_7.selectCallback(arg_237_0)
		if not self.specialArray[arg_233_1].girlInfo then
			return
		end

		if arg_237_0 then
			for iter_237_0, iter_237_1 in pairs(self.specialArray) do
				if not iter_237_1.npcid and iter_237_1.horcruxInfo and iter_237_1.horcruxInfo.entityid == arg_237_0 then
					self.specialArray[iter_237_0].horcruxInfo = nil

					break
				end
			end

			self.specialArray[arg_233_1].horcruxInfo = self:getHorcruxInfoById(arg_237_0)
		else
			self.specialArray[arg_233_1].horcruxInfo = nil
		end

		self:updateAllCell()
		self:updateArrayFightCapacity(var_233_5)
		self:initArrayFightCapacity()
		self:updateSureBtn()

		if var_233_0[arg_233_1].girlInfo and arg_237_0 then
			audio_manager:playeffectMusicTest("sound/dispatch")
		end
	end

	LayerManager:pushInLayer("HorcruxSelectLayer", var_233_7)
end

function SpecialArrayLayer.getHorcruxInfoById(arg_238_0, arg_238_1)
	return {
		entityid = arg_238_1,
		itemid = playermodel.items[arg_238_1].itemid,
		star = horcrux_manager:getHorcruxStarLevel(arg_238_1),
		hlv = horcrux_manager:getHorcruxHLV(arg_238_1),
		hclass = horcrux_manager:getHorcruxHClass(arg_238_1),
		hbreak = horcrux_manager:getHorcruxBreakLv(arg_238_1),
		dfac = horcrux_manager:getHorcruxDamageFac(arg_238_1),
		hfac = horcrux_manager:getHorcruxHpFac(arg_238_1)
	}
end

function BattleArrayLayerNew:dealAutoArray()
	LayerManager:pushInLayer("PopAutoArrayLayer", {
		surecallback = self:initAutoBtn()
	})
end

function BattleArrayLayerNew:initAutoBtn()
	if self.curSelectArrayId then
		local var_240_1 = self.curSelectArrayId or 1
	end

	return function(arg_241_0)
		local var_241_0 = {}
		local var_241_1 = {}
		local var_241_2 = {}

		for iter_241_0, iter_241_1 in pairs(ATTR_ID) do
			var_241_1[iter_241_1] = {}
			var_241_2[iter_241_1] = {}
		end

		local var_241_3 = {}
		local var_241_4 = {}

		if self.configType == CONFIG_TYPE_TVT_ATTACK_FORM then
			local var_241_5 = 1

			while arenatft_manager.attackArray and arenatft_manager.attackArray[var_241_5] do
				if var_241_5 ~= var_240_1 then
					local var_241_6 = 1
					local var_241_7 = 1

					while arenatft_manager.attackArray[var_241_5]["pos_" .. var_241_6] and arenatft_manager.attackArray[var_241_5]["pos_" .. var_241_6].fight_girl do
						var_241_3[arenatft_manager.attackArray[var_241_5]["pos_" .. var_241_6].fight_girl] = true
						var_241_6 = var_241_6 + 1
					end

					while arenatft_manager.attackArray[var_241_5]["pos_" .. var_241_7] and arenatft_manager.attackArray[var_241_5]["pos_" .. var_241_7].assist_girl do
						var_241_3[arenatft_manager.attackArray[var_241_5]["pos_" .. var_241_7].assist_girl] = true
						var_241_7 = var_241_7 + 1
					end
				end

				var_241_5 = var_241_5 + 1
			end
		elseif self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
			var_241_3 = explore_manager:getDeadGirls()
			var_241_4 = explore_manager:getUsedHorcruxs()
		elseif self.configType ~= CONFIG_TYPE_ARENA_DEFENCE and self.configType ~= CONFIG_TYPE_ARENA then
			local var_241_8 = 1

			while playermodel.arrays[var_241_8] do
				if var_241_8 ~= var_240_1 then
					local var_241_9 = 1
					local var_241_10 = 1

					while playermodel.arrays[var_241_8]["pos_" .. var_241_9] and playermodel.arrays[var_241_8]["pos_" .. var_241_9].fight_girl do
						var_241_3[playermodel.arrays[var_241_8]["pos_" .. var_241_9].fight_girl] = true
						var_241_9 = var_241_9 + 1
					end

					while playermodel.arrays[var_241_8]["pos_" .. var_241_10] and playermodel.arrays[var_241_8]["pos_" .. var_241_10].assist_girl do
						var_241_3[playermodel.arrays[var_241_8]["pos_" .. var_241_10].assist_girl] = true
						var_241_10 = var_241_10 + 1
					end
				end

				var_241_8 = var_241_8 + 1
			end
		end

		for iter_241_2, iter_241_3 in pairs(playermodel.items) do
			if item_data[iter_241_3.itemid] and item_data[iter_241_3.itemid].bag_item_type and item_data[iter_241_3.itemid].bag_item_type == 30 and not var_241_4[iter_241_2] then
				table.insert(var_241_2[global_get_model_attr(item_data[iter_241_3.itemid].model)], iter_241_2)
			end
		end

		for iter_241_4, iter_241_5 in pairs(playermodel.haveServant) do
			if not var_241_3[iter_241_4] then
				table.insert(var_241_1[global_get_model_attr(servant_data[iter_241_4].modelid)], iter_241_4)
			end
		end

		for iter_241_6, iter_241_7 in pairs(playermodel.haveServant) do
			if not var_241_3[iter_241_6] then
				table.insert(var_241_0, iter_241_6)
			end
		end

		table.sort(var_241_0, function(arg_242_0, arg_242_1)
			return fight_capacity_manager:getSoulFightCapacity(arg_242_0, "number") > fight_capacity_manager:getSoulFightCapacity(arg_242_1, "number")
		end)

		for iter_241_8, iter_241_9 in pairs(var_241_1) do
			table.sort(iter_241_9, function(arg_243_0, arg_243_1)
				return fight_capacity_manager:getSoulFightCapacity(arg_243_0, "number") > fight_capacity_manager:getSoulFightCapacity(arg_243_1, "number")
			end)
		end

		local var_241_11, var_241_12 = self:chooseTheTeam(var_240_1, arg_241_0.type, var_241_1, var_241_0, var_241_2)

		if not var_241_11 or not next(var_241_11) or not var_241_12 then
			global_ShowBlockWords("没有更多符合的学员（魂器）啦~")

			return
		end

		if self.configType == CONFIG_TYPE_ARENA_DEFENCE then
			array_manager:updateArenaDefenceArrayOneKey(var_241_11, function(arg_244_0)
				if arg_244_0 == 1 then
					self:updateAllCell()
					self:updateSureBtn()
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()
					self:updateTeamSkill()
				elseif arg_244_0 == 2 then
					global_ShowBlockWords("角色未解锁")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_244_0 == 3 then
					global_ShowBlockWords("无效魂器")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_244_0 == 4 then
					global_ShowBlockWords("魂器对应位置未设置角色")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_244_0 == 5 then
					global_ShowBlockWords("设置了重复角色和魂器")
					audio_manager:playeffectMusicTest("sound/invalid")
				end
			end)
		elseif self.configType == CONFIG_TYPE_ARENA then
			array_manager:updateArenaAttackArrayOneKey(var_241_11, function(arg_245_0)
				if arg_245_0 == 1 then
					self:updateAllCell()
					self:updateSureBtn()
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()
					self:updateTeamSkill()
				elseif arg_245_0 == 2 then
					global_ShowBlockWords("角色未解锁")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_245_0 == 3 then
					global_ShowBlockWords("无效魂器")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_245_0 == 4 then
					global_ShowBlockWords("魂器对应位置未设置角色")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_245_0 == 5 then
					global_ShowBlockWords("设置了重复角色和魂器")
					audio_manager:playeffectMusicTest("sound/invalid")
				end
			end)
		elseif self.configType == CONFIG_TYPE_TVT_ATTACK_FORM then
			arenatft_manager:update_arenatft_attack_array_one_key(var_240_1, var_241_11, function(arg_246_0)
				if arg_246_0 == 1 then
					self:updateAllCell()
					self:updateSureBtn()
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()
					self:updateTeamSkill()
				elseif arg_246_0 == 2 then
					global_ShowBlockWords("角色未解锁")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_246_0 == 3 then
					global_ShowBlockWords("无效魂器")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_246_0 == 4 then
					global_ShowBlockWords("魂器对应位置未设置角色")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_246_0 == 5 then
					global_ShowBlockWords("设置了重复角色和魂器")
					audio_manager:playeffectMusicTest("sound/invalid")
				end
			end)
		elseif self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
			array_manager:updateArrayOneKeyHpInherit(var_240_1, var_241_11, function(arg_247_0)
				if arg_247_0 == 1 then
					self:updateAllCell()
					self:updateSureBtn()
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()
					self:updateTeamSkill()
				else
					global_ShowBlockWords("自动编队失败")
					audio_manager:playeffectMusicTest("sound/invalid")
				end
			end)
		else
			array_manager:updateArrayOneKey(var_240_1, var_241_11, function(arg_248_0)
				if arg_248_0 == 1 then
					self:updateAllCell()
					self:updateSureBtn()
					self:updateArrayFightCapacity()
					self:initArrayFightCapacity()
					self:updateTeamSkill()
				elseif arg_248_0 == 2 then
					global_ShowBlockWords("角色未解锁")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_248_0 == 3 then
					global_ShowBlockWords("无效魂器")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_248_0 == 4 then
					global_ShowBlockWords("魂器对应位置未设置角色")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_248_0 == 5 then
					global_ShowBlockWords("设置了重复角色和魂器")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_248_0 == 6 then
					global_ShowBlockWords("挂机阵容不能为空")
					audio_manager:playeffectMusicTest("sound/invalid")
				end
			end)
		end
	end
end

function BattleArrayLayerNew.chooseTheTeam(arg_249_0, arg_249_1, arg_249_2, arg_249_3, arg_249_4, arg_249_5)
	local var_249_0 = false

	if not arg_249_2 then
		return
	end

	local var_249_1 = {}
	local var_249_2 = {}

	if arg_249_2 == "all" then
		for iter_249_0 = 1, 4 do
			if arg_249_4[iter_249_0] then
				var_249_0 = true

				local var_249_4 = 0
				local var_249_5 = global_get_model_attr(servant_data[arg_249_4[iter_249_0]].modelid)
				local var_249_6 = 0

				for iter_249_1, iter_249_2 in pairs(arg_249_5[var_249_5]) do
					if not var_249_2[iter_249_2] then
						local var_249_7 = fight_capacity_manager:getSoulFightCapacity(arg_249_4[iter_249_0], "number", nil, iter_249_2)

						if var_249_4 < var_249_7 then
							var_249_4 = var_249_7
							var_249_6 = iter_249_1
						end
					end
				end

				if var_249_5 and var_249_6 > 0 then
					var_249_1["pos_" .. iter_249_0] = {
						pos = iter_249_0,
						fight_girl = arg_249_4[iter_249_0],
						assist_girl = arg_249_5[var_249_5][var_249_6]
					}
					var_249_2[arg_249_5[var_249_5][var_249_6]] = true
				else
					var_249_1["pos_" .. iter_249_0] = {
						pos = iter_249_0,
						fight_girl = arg_249_4[iter_249_0]
					}
				end
			else
				var_249_1["pos_" .. iter_249_0] = {
					pos = iter_249_0
				}
			end
		end
	else
		for iter_249_3 = 1, 4 do
			if arg_249_3[arg_249_2][iter_249_3] then
				var_249_0 = true

				local var_249_9 = 0
				local var_249_10 = global_get_model_attr(servant_data[arg_249_3[arg_249_2][iter_249_3]].modelid)
				local var_249_11 = 0

				for iter_249_4, iter_249_5 in pairs(arg_249_5[var_249_10]) do
					if not var_249_2[iter_249_5] then
						local var_249_12 = fight_capacity_manager:getSoulFightCapacity(arg_249_3[arg_249_2][iter_249_3], "number", nil, iter_249_5)

						if var_249_9 < var_249_12 then
							var_249_9 = var_249_12
							var_249_11 = iter_249_4
						end
					end
				end

				if var_249_11 > 0 then
					var_249_1["pos_" .. iter_249_3] = {
						pos = iter_249_3,
						fight_girl = arg_249_3[arg_249_2][iter_249_3],
						assist_girl = arg_249_5[var_249_10][var_249_11]
					}
					var_249_2[arg_249_5[var_249_10][var_249_11]] = true
				else
					var_249_1["pos_" .. iter_249_3] = {
						pos = iter_249_3,
						fight_girl = arg_249_3[arg_249_2][iter_249_3]
					}
				end
			else
				var_249_1["pos_" .. iter_249_3] = {
					pos = iter_249_3
				}
			end
		end
	end

	return var_249_1, var_249_0
end

function BattleArrayLayerNew:elementTowerAtrr()
	local var_250_0 = {
		all = 1,
		water = 4,
		wind = 2,
		fire = 3,
		light = 5,
		dark = 6
	}

	if not self.adverturemode then
		return var_250_0.all
	end

	local levelmode_data = require("data.levelmode_data")

	if levelmode_data[self.adverturemode] and levelmode_data[self.adverturemode].ele_type then
		local var_250_2 = levelmode_data[self.adverturemode].ele_type

		if levelmode_data[self.adverturemode].ele_type_show then
			var_250_2 = levelmode_data[self.adverturemode].ele_type_show .. ",imaginary"
		end

		local var_250_3 = {}

		for iter_250_0 in var_250_2:gmatch("([^,]+)") do
			table.insert(var_250_3, iter_250_0)
		end
	end

	return var_250_0.all
end

function SpecialArrayLayer:dealAutoArray()
	LayerManager:pushInLayer("PopAutoArrayLayer", {
		surecallback = self:initAutoBtn()
	})
end

function SpecialArrayLayer:initAutoBtn()
	if self.curSelectArrayId then
		local var_252_1 = self.curSelectArrayId or 1
	end

	return function(arg_253_0)
		local var_253_0 = {}
		local var_253_1 = {}
		local var_253_2 = {}

		for iter_253_0, iter_253_1 in pairs(ATTR_ID) do
			var_253_1[iter_253_1] = {}
			var_253_2[iter_253_1] = {}
		end

		local var_253_3 = {}
		local var_253_4 = {}

		if self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
			var_253_3 = explore_manager:getDeadGirls()
			var_253_4 = explore_manager:getUsedHorcruxs()
		end

		for iter_253_2, iter_253_3 in pairs(playermodel.items) do
			if item_data[iter_253_3.itemid] and item_data[iter_253_3.itemid].bag_item_type and item_data[iter_253_3.itemid].bag_item_type == 30 and not var_253_4[iter_253_2] then
				table.insert(var_253_2[global_get_model_attr(item_data[iter_253_3.itemid].model)], iter_253_2)
			end
		end

		for iter_253_4, iter_253_5 in pairs(playermodel.haveServant) do
			if not var_253_3[iter_253_4] then
				table.insert(var_253_1[global_get_model_attr(servant_data[iter_253_4].modelid)], iter_253_4)
			end
		end

		for iter_253_6, iter_253_7 in pairs(playermodel.haveServant) do
			if not var_253_3[iter_253_6] then
				table.insert(var_253_0, iter_253_6)
			end
		end

		table.sort(var_253_0, function(arg_254_0, arg_254_1)
			return fight_capacity_manager:getSoulFightCapacity(arg_254_0, "number") > fight_capacity_manager:getSoulFightCapacity(arg_254_1, "number")
		end)

		for iter_253_8, iter_253_9 in pairs(var_253_1) do
			table.sort(iter_253_9, function(arg_255_0, arg_255_1)
				return fight_capacity_manager:getSoulFightCapacity(arg_255_0, "number") > fight_capacity_manager:getSoulFightCapacity(arg_255_1, "number")
			end)
		end

		local var_253_5, var_253_6 = self:chooseTheTeam(var_252_1, arg_253_0.type, var_253_1, var_253_0, var_253_2)

		if not var_253_5 or not next(var_253_5) or not var_253_6 then
			global_ShowBlockWords("没有更多符合的学员（魂器）啦~")

			return
		end

		self:updateSpecialArray(var_253_5)

		if self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
			self:updateAllCell()
			self:updateSureBtn()
			self:updateArrayFightCapacity()
			self:initArrayFightCapacity()
			self:updateTeamSkill()
		end
	end
end

function SpecialArrayLayer:updateSpecialArray(arg_256_1)
	local var_256_0 = {}

	for iter_256_0 = 1, 4 do
		var_256_0[iter_256_0] = arg_256_1["pos_" .. iter_256_0] and arg_256_1["pos_" .. iter_256_0] or {
			pos_lock = false
		}
	end

	self:initSpecialArray(var_256_0)
end

function SpecialArrayLayer.chooseTheTeam(arg_257_0, arg_257_1, arg_257_2, arg_257_3, arg_257_4, arg_257_5)
	local var_257_0 = false

	if not arg_257_2 then
		return
	end

	local var_257_1 = {}
	local var_257_2 = {}

	if arg_257_2 == "all" then
		for iter_257_0 = 1, 4 do
			if arg_257_4[iter_257_0] then
				var_257_0 = true

				local var_257_4 = 0
				local var_257_5 = global_get_model_attr(servant_data[arg_257_4[iter_257_0]].modelid)
				local var_257_6 = 0

				for iter_257_1, iter_257_2 in pairs(arg_257_5[var_257_5]) do
					if not var_257_2[iter_257_2] then
						local var_257_7 = fight_capacity_manager:getSoulFightCapacity(arg_257_4[iter_257_0], "number", nil, iter_257_2)

						if var_257_4 < var_257_7 then
							var_257_4 = var_257_7
							var_257_6 = iter_257_1
						end
					end
				end

				if var_257_5 and var_257_6 > 0 then
					var_257_1["pos_" .. iter_257_0] = {
						pos = iter_257_0,
						fight_girl = arg_257_4[iter_257_0],
						assist_girl = arg_257_5[var_257_5][var_257_6]
					}
					var_257_2[arg_257_5[var_257_5][var_257_6]] = true
				else
					var_257_1["pos_" .. iter_257_0] = {
						pos = iter_257_0,
						fight_girl = arg_257_4[iter_257_0]
					}
				end
			else
				var_257_1["pos_" .. iter_257_0] = {
					pos = iter_257_0
				}
			end
		end
	else
		for iter_257_3 = 1, 4 do
			if arg_257_3[arg_257_2][iter_257_3] then
				var_257_0 = true

				local var_257_9 = 0
				local var_257_10 = global_get_model_attr(servant_data[arg_257_3[arg_257_2][iter_257_3]].modelid)
				local var_257_11 = 0

				for iter_257_4, iter_257_5 in pairs(arg_257_5[var_257_10]) do
					if not var_257_2[iter_257_5] then
						local var_257_12 = fight_capacity_manager:getSoulFightCapacity(arg_257_3[arg_257_2][iter_257_3], "number", nil, iter_257_5)

						if var_257_9 < var_257_12 then
							var_257_9 = var_257_12
							var_257_11 = iter_257_4
						end
					end
				end

				if var_257_11 > 0 then
					var_257_1["pos_" .. iter_257_3] = {
						pos = iter_257_3,
						fight_girl = arg_257_3[arg_257_2][iter_257_3],
						assist_girl = arg_257_5[var_257_10][var_257_11]
					}
					var_257_2[arg_257_5[var_257_10][var_257_11]] = true
				else
					var_257_1["pos_" .. iter_257_3] = {
						pos = iter_257_3,
						fight_girl = arg_257_3[arg_257_2][iter_257_3]
					}
				end
			else
				var_257_1["pos_" .. iter_257_3] = {
					pos = iter_257_3
				}
			end
		end
	end

	return var_257_1, var_257_0
end
