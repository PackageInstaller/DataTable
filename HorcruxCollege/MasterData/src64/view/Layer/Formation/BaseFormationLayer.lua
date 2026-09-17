local BaseFormationLayer = class("BaseFormationLayer", (require("view.Layer.BaseUILayer")))
local HelpBattleLayer = require("view/Layer/HelpBattle/HelpBattleLayer")
local var_0_2 = global_trans_number
local TempWidget = require("view.Sprite.TempWidget")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = "BaseFormationLayer/"
local playermodel = require("model.playermodel")
local var_0_7 = {
	[0] = "BaseFormationLayer/" .. "null_horcrux.png",
	"BaseFormationLayer/" .. "r_horcrux.png",
	"BaseFormationLayer/" .. "sr_horcrux.png",
	"BaseFormationLayer/" .. "ur_horcrux.png",
	"BaseFormationLayer/" .. "mr_horcrux.png",
	"BaseFormationLayer/" .. "sp_horcrux.png",
	locked = "BaseFormationLayer/" .. "locked_horcrux.png"
}
local var_0_8 = FORMATION_SHOW_GIRL_NUM
local var_0_9 = -10
local var_0_10 = 50
local var_0_11 = 44
local var_0_12 = 230
local var_0_13 = 120
local var_0_14 = 30
local var_0_15 = 90
local var_0_16 = 130
local var_0_17 = 230 + 120 + 130
local var_0_18 = 50 + (230 + 120 + 130) + 44 + 30 + 90
local var_0_19 = 3.5
local var_0_20 = -0.15
local var_0_21 = 0.7
local var_0_22 = 1.2
local var_0_23 = 3
local weapon_data = require("data.weapon_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local item_data = require("data.item_data")
local role_false_level_manager = require("controller.role_false_level_manager")
local help_battle_manager = require("controller/help_battle/help_battle_manager")
local var_0_30 = help_battle_manager:getInstance()
local var_0_31 = require("controller/help_battle/help_battle_formation_manager").getInstance(help_battle_manager)
local weapon_manager = require("controller.weapon_manager")
local horcrux_devour_select_manager = require("controller/horcrux_devour/horcrux_devour_select_manager")
local var_0_34 = horcrux_devour_select_manager:getInstance()
local var_0_35 = require("controller/horcrux_devour/horcrux_devour_manager").getInstance(horcrux_devour_select_manager)

local function var_0_36(arg_1_0, arg_1_1)
	if arg_1_0 == nil then
		return false
	end

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if iter_1_1 == arg_1_1 then
			return true
		end
	end

	return false
end

function BaseFormationLayer:ctor()
	require("view.Sprite.GirlSprite")
	require("view.Sprite.HorcruxSprite")
	BaseFormationLayer.super.ctor(self)
	self:initManager()
	self:setAutoAdapt(true)

	self.bInit = false
	self.curFormationIndex = nil
	self.selectGirlType = nil
	self.selectHorcruxType = nil
	self.configType = nil
	self.girlOffsetScale = -0.15
	self.girlOffsetX = 3.5
	self.horcruxSpriteScale = var_0_22
	self.listViewHeight = var_0_17
	self.formationIndexListViewHeight = var_0_11
	self.partsNum = var_0_23
	self.majorWeaponData = {}

	for iter_2_0, iter_2_1 in pairs(weapon_data) do
		if iter_2_1.major then
			self.majorWeaponData[iter_2_1.major] = iter_2_1
		end
	end

	self._selectSwitchIndex = 1
end

function BaseFormationLayer:create(arg_3_1)
	local var_3_0 = BaseFormationLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function BaseFormationLayer:onEnter()
	BaseFormationLayer.super.onEnter(self)
	self:openAction()
end

function BaseFormationLayer:onExit()
	BaseFormationLayer.super.onExit(self)

	if self.configexitCallback then
		self.configexitCallback()
	end
end

function BaseFormationLayer:init(arg_6_1)
	self.configType = arg_6_1.configtype or self.configType
	self.configexitCallback = arg_6_1.exitcallback

	if arg_6_1.configcallback then
		self.configCallback = arg_6_1.configcallback
	elseif arg_6_1.configCallback then
		self.configCallback = arg_6_1.configCallback
	end

	self.is_hp_inherit = arg_6_1.is_hp_inherit
	self.initindex = arg_6_1.initindex

	self:initLayer()

	return true
end

function BaseFormationLayer:initLayer()
	self._root = TempWidget:CreateTempLayout(self)

	self._root:setScaleY(0.01)
	self._root:setContentSize(GameDisplay.getUiScreenSize())
	self._root:align(cc.p(0.5, 0.5), self._root:size().w / 2, self._root:size().h / 2)

	local var_7_0 = TempWidget:CreateTempImg("mainScenebg/base_formation_layer_bg.png", self._root, 0)

	var_7_0:setScale9Enabled(true)
	var_7_0:setCapInsets(cc.rect(0, 0, var_7_0:getContentSize().width / 2, var_7_0:getContentSize().height / 2))
	var_7_0:setContentSize(cc.size(self._root:size().w, 770))
	var_7_0:align(cc.p(0.5, 0.5), self._root:size().w / 2, self._root:size().h / 2 - 35)

	self._bg = var_7_0

	function var_7_0.afterLoadSuccess(arg_8_0)
		var_7_0:setContentSize(cc.size(self._root:size().w, 770))
		var_7_0:align(cc.p(0.5, 0.5), self._root:size().w / 2, self._root:size().h / 2)
		self._switchLayout:align(cc.p(0, 1), 0, var_7_0:size().h)
		self.helpBattleWidget:setPosition(cc.p(0, var_7_0:size().h))
	end

	self.formationLayout = TempWidget:CreateTempListView(var_7_0)

	self.formationLayout:setContentSize(cc.size(self._root:size().w, var_0_18))
	self.formationLayout:move(cc.p(0, 0))
	self.formationLayout:setVisible(self._selectSwitchIndex == 1)
	self:initSwitchLayout()
	self:initHelpBattleWidget()
end

function BaseFormationLayer:initSwitchLayout()
	local var_9_0 = TempWidget:CreateTempLayout(self._bg)

	var_9_0:setContentSize(cc.size(self._bg:size().w, self._bg:size().h - self.formationLayout:size().h))
	var_9_0:align(cc.p(0, 1), 0, self._bg:size().h)

	self._switchLayout = var_9_0

	local var_9_1 = TempWidget:CreateTempListView(var_9_0)

	var_9_1:setContentSize(cc.size(var_9_0:size().w, 70))
	var_9_1:setDirection(ccui.ListViewDirection.horizontal)
	var_9_1:align(cc.p(0.5, 1), var_9_0:size().w / 2, var_9_0:size().h)

	var_9_1._btns = {}

	local var_9_2 = {
		L_BASE_FORMATION[1],
		L_BASE_FORMATION[2]
	}

	for iter_9_0 = 1, 1 do
		local var_9_3 = TempWidget:CreateTempLayout()

		var_9_3:setContentSize(cc.size(127, 72))

		local var_9_4 = TempWidget:CreateTempImg(var_0_5 .. "switch_entrance.png", var_9_3)

		var_9_4:align(cc.p(0.5, 1), var_9_3:size().w / 2, var_9_3:size().h - 2)
		var_9_4:setVisible(iter_9_0 == self._selectSwitchIndex)

		var_9_3._selectImg = var_9_4

		TempWidget:CreateTempLabel(var_9_2[iter_9_0], FONT_NAME, 26, var_9_3):align(cc.p(0.5, 1), var_9_3:size().w / 2, var_9_3:size().h - 10)
		var_9_3:_addEvent(function()
			self._selectSwitchIndex = iter_9_0

			for iter_10_0 = 1, #var_9_1._btns do
				var_9_1._btns[iter_10_0]._selectImg:setVisible(iter_10_0 == self._selectSwitchIndex)
			end
		end)
		var_9_1:pushBackCustomItem(var_9_3)

		var_9_1._btns[iter_9_0] = var_9_3
	end
end

function BaseFormationLayer:initHelpBattleWidget()
	local var_11_0 = self:isShowHelpBattle()
	local var_11_1 = cc.Node:create()

	self._bg:addChild(var_11_1)
	var_11_1:setPosition(cc.p(0, self._bg:size().h))
	var_11_1:setVisible(var_11_0)

	self.helpBattleWidget = var_11_1

	if var_11_0 then
		var_0_30:setParam({
			formationIndex = self.curFormationIndex,
			configType = self.configType,
			mode = self.mode
		})

		local var_11_2 = TempWidget:CreateTempImg(var_0_5 .. "help_battle_line.png", var_11_1)

		var_11_2:align(cc.p(0, 0), 0, 0)
		var_11_2:_addEvent(function()
			return
		end)

		local var_11_3 = TempWidget:CreateTempImg(var_0_5 .. "help_battle_bg.png", var_11_1)

		var_11_3:align(cc.p(0, 0), 0, var_11_2:size().h)
		var_11_3:_addEvent(function()
			return
		end)

		local var_11_4 = TempWidget:CreateTempImg(var_0_5 .. "switch_entrance.png", var_11_3)

		var_11_4:align(cc.p(0, 1), 0, var_11_3:size().h - 2)

		var_11_3._selectImg = var_11_4

		local var_11_5 = TempWidget:CreateTempLabel(L_BASE_FORMATION[2], FONT_NAME, 26, var_11_3)

		var_11_5:setColor(cc.c3b(255, 165, 0))
		var_11_5:align(cc.p(0.5, 1), var_11_4:pos().x + var_11_4:size().w / 2, var_11_3:size().h - 10)

		local var_11_6 = TempWidget:CreateTempImg(var_0_5 .. "help_battle_tips.png", var_11_3)

		var_11_6:align(cc.p(0, 1), 10, var_11_4:pos().y - var_11_4:size().h + 25)

		local var_11_7 = TempWidget:CreateTempLabel(L_BASE_FORMATION[3], FONT_NAME, 17, var_11_6)

		var_11_7:_setColor("7dfaff")
		var_11_7:align(cc.p(0, 0.5), 10, var_11_6:size().h / 2)

		local var_11_8 = TempWidget:CreateTempImg(var_0_5 .. "career_add_bg.png", var_11_3)

		var_11_8:align(cc.p(0, 1), var_11_6:pos().x, var_11_6:pos().y - var_11_6:size().h - 5)

		local var_11_9 = {
			var_0_30.CAREER.SHOOTER,
			var_0_30.CAREER.ASSASSIN,
			var_0_30.CAREER.MASTER,
			var_0_30.CAREER.WARRIOR,
			var_0_30.CAREER.SUPPORT,
			var_0_30.CAREER.TANK
		}

		self._helpBattleAttrLayoutList = {}

		for iter_11_0 = 1, 2 do
			for iter_11_1 = 1, 3 do
				local var_11_10 = TempWidget:CreateTempLayout(var_11_8)

				var_11_10:setContentSize(cc.size(120, 60))
				var_11_10:align(cc.p(0, 1), (iter_11_1 - 1) * 230 + 90, var_11_8:size().h - (iter_11_0 - 1) * 60)

				local var_11_11 = (iter_11_0 - 1) * 3 + iter_11_1
				local var_11_12 = var_0_30:getBonus(var_11_9[(iter_11_0 - 1) * 3 + iter_11_1])
				local var_11_13 = TempWidget:CreateTempLabel(var_11_12.value.hp, FONT_NAME, 16, var_11_10)

				var_11_13:_setColor("ffffff")
				var_11_13:align(cc.p(0, 0.5), 0, var_11_10:size().h / 2 - 15)

				local var_11_14 = TempWidget:CreateTempLabel(var_11_12.value.damage, FONT_NAME, 16, var_11_10)

				var_11_14:_setColor("ffffff")
				var_11_14:align(cc.p(0, 0.5), 0, var_11_10:size().h / 2 + 15)

				function var_11_10._updateAttr()
					local var_14_0 = var_0_30:getBonus(var_11_9[var_11_11])

					var_11_13:setString("+" .. var_0_2(var_14_0.value.hp))
					var_11_14:setString("+" .. var_0_2(var_14_0.value.damage))
				end

				var_11_10._updateAttr()

				self._helpBattleAttrLayoutList[(iter_11_0 - 1) * 3 + iter_11_1] = var_11_10
			end
		end

		local var_11_15 = TempWidget:CreateTempBtn("public/button/public_button_blue.png", var_11_3)

		var_11_15:align(cc.p(1, 1), var_11_3:size().w + 5, var_11_3:size().h + 5)
		var_11_15:setScale(0.85, 0.85)
		var_11_15:_addEvent(function()
			LayerManager:pushInLayer("HelpBattleLayer", {
				formationIndex = self.curFormationIndex,
				configType = self.configType,
				mode = self.mode
			})
		end)

		local var_11_16 = TempWidget:CreateTempLabel(L_BASE_FORMATION_ADD[1], FONT_NAME, 26, var_11_15:getVirtualRenderer())

		var_11_16:_setColor("101010")
		var_11_16:center()

		local var_11_17 = TempWidget:CreateTempBtn(var_0_5 .. "auto_help_battle.png", var_11_3)

		var_11_17:_addEvent(function()
			require("controller/help_battle/help_battle_manager"):getInstance():autoHelpFormation()
		end, {
			touchDelay = 1
		})
		var_11_17:align(cc.p(1, 1), var_11_3:size().w - var_11_15:size().w + 45, var_11_3:size().h - 5)
		var_11_17:setVisible(self:isShowAutoHelpBattleBtn())

		self.autoHelpBattle = var_11_17

		if require("controller/help_battle/help_battle_manager"):getInstance():checkHelpFormationAlert(self.curFormationIndex) then
			global_add_alert_tag(var_11_17, cc.p(var_11_17:getContentSize().width + 10, var_11_17:getContentSize().height + 10))
		else
			global_remove_alert_tag(var_11_17)
		end
	end
end

function BaseFormationLayer:initListener()
	self._root:_addEvent(function()
		self:closeAction()
	end)
	self._bg:_addEvent(function()
		return
	end)

	if self:isRegisterTeamSkill() then
		self.headLayout._childData.teamSkillBg:_addEvent(function()
			local var_20_0 = {}

			var_20_0.key = "teamSkill"
			var_20_0.teamSkill = self:getTeamSkill()

			LayerManager:pushInLayer("PopActivityDetail", var_20_0)
		end)
	else
		self.headLayout._childData.teamSkillBg:setVisible(false)
	end

	self.sureBtn:_addEvent(function()
		self:sureButtonCallBack()
	end, {
		touchDelay = 1
	})
	self.manager:registerNotification("HelpBattleRoleChanged", handler(self, self.updateCareerAttr))
	self.manager:registerNotification("HelpBattleRoleFastChanged", handler(self, self.updateCareerAttr))
	self.manager:registerNotification("ReplaceRoleWeaponSucceeded", handler(self, self.replaceRoleWeaponSucceeded))
	self.manager:registerNotification("StrengthenWeaponSucceeded", handler(self, self.strengthenWeaponSucceeded))
	self.manager:registerNotification("UpgradeWeaponSucceeded", handler(self, self.upgradeWeaponSucceeded))
	self.manager:registerNotification("refreshHorcruxLayout", handler(self, self.updateHorcruxLayout))
end

function BaseFormationLayer:replaceRoleWeaponSucceeded(arg_22_1)
	self:updateWeaponShowLayout()

	for iter_22_0 = 1, self:getFormationShowGirlNum() do
		self:updateFightCapacityText(iter_22_0)
	end

	self:updateTeamFightCapacity()
end

function BaseFormationLayer:strengthenWeaponSucceeded(arg_23_1)
	for iter_23_0 = 1, self:getFormationShowGirlNum() do
		self:updateFightCapacityText(iter_23_0)
	end

	self:updateTeamFightCapacity()
end

function BaseFormationLayer:upgradeWeaponSucceeded(arg_24_1)
	self:updateWeaponShowLayout()

	for iter_24_0 = 1, self:getFormationShowGirlNum() do
		self:updateFightCapacityText(iter_24_0)
	end

	self:updateTeamFightCapacity()
end

function BaseFormationLayer:updateCareerAttr(arg_25_1)
	if self:isShowHelpBattle() then
		for iter_25_0 = 1, #self._helpBattleAttrLayoutList do
			self._helpBattleAttrLayoutList[iter_25_0]._updateAttr()
		end

		self:updateRed()
	end
end

function BaseFormationLayer:closeAction(arg_26_1)
	self._root:runAction(cc.Sequence:create(cc.ScaleTo:create(0.15, 1, 0.01), cc.CallFunc:create(function()
		LayerManager:removePopLayer()

		if arg_26_1 then
			arg_26_1()
		end
	end)))
end

function BaseFormationLayer:openAction(arg_28_1)
	self._root:setScaleY(0.01)
	self._root:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 1, 1), cc.CallFunc:create(function()
		if arg_28_1 then
			arg_28_1()
		end
	end)))
end

function BaseFormationLayer:initFormationIndexListView()
	local var_30_0

	if not self.formationIndexListView then
		var_30_0 = TempWidget:CreateTempListView()

		var_30_0:setDirection(ccui.ListViewDirection.horizontal)
		var_30_0:setContentSize(cc.size(GameDisplay.width, var_0_11))
		self.formationLayout:pushBackCustomItem(var_30_0)

		self.formationIndexListView = var_30_0
	else
		var_30_0 = self.formationIndexListView
	end

	var_30_0:removeAllItems()

	local var_30_1 = self:getFormationInfo()

	for iter_30_0 = 1, #var_30_1 do
		local var_30_2 = TempWidget:CreateTempLayout()

		var_30_2:setContentSize(cc.size(150, var_30_0:size().h))
		var_30_2:_addEvent(function()
			self:selectIndex(iter_30_0)
		end)

		var_30_2._childData = {}

		local var_30_3 = TempWidget:CreateTempImg(nil, var_30_2)

		var_30_3:center()

		var_30_2._childData.selectBtn = var_30_3

		local var_30_4 = self:getSelectBtnTextInfo(iter_30_0)

		if #var_30_1 == 1 then
			var_30_4.str = L_FORMATIONM_ONE
		end

		local var_30_5 = TempWidget:CreateTempLabel(var_30_4.str, var_30_4.font, var_30_4.size, var_30_2)

		var_30_5:center()

		var_30_2._childData.text = var_30_5

		var_30_0:pushBackCustomItem(var_30_2)

		if iter_30_0 == #var_30_1 and self:isCanExtendFormation() then
			local var_30_6 = TempWidget:CreateTempLayout()

			var_30_6:setContentSize(cc.size(150, var_30_0:size().h))

			local var_30_7 = TempWidget:CreateTempBtn(var_0_5 .. "select_team_on.png", var_30_6)

			var_30_7:center()
			var_30_7:_addEvent(handler(self, self.extendArrayCallBack))

			local var_30_8 = TempWidget:CreateTempLabel(L_BASE_FORMATION[8], FONT_DES, 20, var_30_6)

			var_30_8:_setColor("102F10")
			var_30_8:center()
			var_30_0:pushBackCustomItem(var_30_6)
		end
	end

	var_30_0:doLayout()
	var_30_0:jumpToIndex(self.curFormationIndex)
	self:updateSelectTeamStatus()
end

function BaseFormationLayer:initHeadLayout()
	if not self.headLayout then
		local var_32_0 = TempWidget:CreateTempLayout()

		var_32_0:setContentSize(cc.size(self.formationLayout:size().w, var_0_10))

		self.headLayout = var_32_0

		self.formationLayout:pushBackCustomItem(self.headLayout)
	end

	local levelmode_data = require("data.levelmode_data")
	local var_32_2 = global_get_levelmode_ele_type(self.mode)

	if var_32_2 and not string.find(var_32_2, ",") and not var_32_2 == "all" then
		TempWidget:CreateTempImg("public/career_icon/restrain_tip_" .. ATTR_INDEX[var_32_2] .. ".png", self._bg):align(cc.p(1, 0), self.formationLayout:size().w - 430, 685)
	end

	self.headLayout:removeAllChildren()

	self.headLayout._childData = {}

	local var_32_3 = TempWidget:CreateTempLabel(L_BASE_FORMATION[5] .. self:getFightCapacitySum(), FONT_NAME, 24, self.headLayout)

	var_32_3:_setColor("7BF2F9")
	var_32_3:align(cc.p(0, 0.5), 10, self.headLayout:size().h / 2)

	self.headLayout._childData.teamFightCapacity = var_32_3

	local var_32_4 = TempWidget:CreateTempImg("public/rolebg/player_star.png", self.headLayout)

	var_32_4:setScale(0.6)
	var_32_4:align(cc.p(0, 0.5), 200, self.headLayout:size().h / 2)
	TempWidget:CreateTempLabel(require("controller.souls_manager"):get_total_contract_attr(), FONT_NAME, 24, self.headLayout):align(cc.p(0, 0.5), 235, self.headLayout:size().h / 2)

	local var_32_5 = TempWidget:CreateTempImg(var_0_5 .. "team_skill_bg.png", self.headLayout)

	var_32_5:align(cc.p(1, 0), self.headLayout:size().w - 10, 10)

	self.headLayout._childData.teamSkillBg = var_32_5

	local var_32_6 = TempWidget:CreateTempImg(var_0_5 .. "team_skill_tag.png", var_32_5)

	var_32_6:align(cc.p(1, 0.5), var_32_5:size().w - 10, var_32_5:size().h / 2)

	self.headLayout._childData.tagImg = var_32_6

	local var_32_7 = TempWidget:CreateTempLabel(L_BASE_FORMATION[9], FONT_NAME, 20, var_32_5)

	var_32_7:align(cc.p(0, 0.5), 10, var_32_5:size().h / 2)

	self.headLayout._childData.defaultText = var_32_7

	local var_32_8 = TempWidget:CreateTempLayout(var_32_5)

	var_32_8:setContentSize(var_32_5:size())

	self.headLayout._childData.showTeamSkillLayout = var_32_8

	local var_32_9 = TempWidget:CreateTempImg(nil, var_32_8)

	var_32_9:align(cc.p(0.5, 0.5), 20, var_32_8:size().h / 2)
	var_32_9:setScale(var_0_21)

	self.headLayout._childData.iconBackImg = var_32_9

	local var_32_10 = TempWidget:CreateTempImg(nil, var_32_8)

	var_32_10:align(cc.p(0.5, 0.5), var_32_9:pos().x, var_32_8:size().h / 2)
	var_32_10:setScale(var_0_21)

	self.headLayout._childData.iconImg = var_32_10

	local var_32_11 = TempWidget:CreateTempLayout(var_32_8)

	var_32_11:setContentSize(var_32_8:size())

	self.headLayout._childData.teamSkillTextLayout = var_32_11

	self:updateShowTeamSkillLayout()
end

function BaseFormationLayer:initTipsLayout()
	if not self.tipsLayout then
		local var_33_0 = TempWidget:CreateTempLayout()

		var_33_0:setContentSize(cc.size(self.formationLayout:size().w, var_0_14))

		self.tipsLayout = var_33_0

		self.formationLayout:pushBackCustomItem(self.tipsLayout)
	end

	self.tipsLayout:removeAllChildren()
	TempWidget:CreateTempImg(var_0_5 .. "tips.png", self.tipsLayout):align(cc.p(1, 0.5), self.tipsLayout:size().w - 10, self.tipsLayout:size().h / 2)
end

function BaseFormationLayer:initBottomLayout()
	if not self.bottomLayout then
		local var_34_0 = TempWidget:CreateTempLayout()

		var_34_0:setContentSize(cc.size(self.formationLayout:size().w, var_0_15))

		self.bottomLayout = var_34_0

		self.formationLayout:pushBackCustomItem(self.bottomLayout)
	end

	self.bottomLayout:removeAllChildren()
	TempWidget:CreateTempImg(var_0_5 .. "split_img.png", self.bottomLayout):align(cc.p(0.5, 1), self.bottomLayout:size().w / 2, self.bottomLayout:size().h - 5)

	local var_34_1 = {}
	local var_34_2 = TempWidget:CreateTempBtn(var_0_5 .. "auto_advance_force.png", self.bottomLayout)

	var_34_2:_addEvent(function()
		self:getAutoAdvanceForcesCallBack()()
	end, {
		touchDelay = 1
	})
	var_34_2:setVisible(self:isShowAutoAdvanceForceBtn())

	self.autoAdvanceForceBtn = var_34_2

	if self:isShowAutoAdvanceForceBtn() then
		var_34_1[#var_34_1 + 1] = var_34_2
	end

	local var_34_3 = TempWidget:CreateTempBtn(var_0_5 .. "auto_dress.png", self.bottomLayout)

	var_34_3:setVisible(self:isShowFastEquipmentBtn())
	var_34_3:_addEvent(function()
		self:fastEquipment()
	end)

	self.fastEquipmentBtn = var_34_3

	if self:isShowFastEquipmentBtn() then
		var_34_1[#var_34_1 + 1] = var_34_3
	end

	local var_34_4 = TempWidget:CreateTempBtn(var_0_5 .. "auto_formation.png", self.bottomLayout)

	var_34_4:_addEvent(function()
		if self.selectGirlType == SELECT_GIRL_FIGHT_ELEMENTS then
			local levelmode_data = require("data.levelmode_data")
			local var_37_1 = global_get_levelmode_ele_type(self.mode) or "all"

			self:getAutoFormationCallBack()({
				type = var_37_1,
				mode = self.mode
			})
		else
			local var_37_2 = {
				surecallback = self:getAutoFormationCallBack()
			}

			if self.configType == CONFIG_TYPE_HANGUP then
				var_37_2.initindex = self.curFormationIndex
			end

			LayerManager:pushInLayer("PopAutoArrayLayer", var_37_2)
		end
	end, {
		touchDelay = 1
	})
	var_34_4:setVisible(self:isShowAutoFormationBtn())

	self.autoFormation = var_34_4

	if self:isShowAutoFormationBtn() then
		var_34_1[#var_34_1 + 1] = var_34_4
	end

	local var_34_5 = cc.p(self.bottomLayout:size().w, self.bottomLayout:size().h / 2)

	for iter_34_0 = 1, #var_34_1 do
		var_34_1[iter_34_0]:align(cc.p(1, 0.5), var_34_5.x, var_34_5.y)

		var_34_5.x = var_34_5.x - var_34_1[iter_34_0]:size().w + 15
	end

	local var_34_6 = TempWidget:CreateTempBtn(var_0_5 .. "btn_introduce_element.png", self.bottomLayout)

	var_34_6:_addEvent(function()
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
	end, {
		touchDelay = 1
	})
	var_34_6:align(cc.p(0, 0.5), 10, self.bottomLayout:size().h / 2)

	local var_34_7 = TempWidget:CreateTempBtn(var_0_5 .. "btn_effect_bond.png", self.bottomLayout)

	var_34_7:_addEvent(function()
		LayerManager:pushInLayer("PopActivityDetail", {
			type = 0,
			key = "bond_detail"
		})
	end, {
		touchDelay = 1
	})
	var_34_7:align(cc.p(0, 0.5), var_34_6:pos().x + var_34_6:size().w + 10, self.bottomLayout:size().h / 2)
	var_34_7:setVisible(self:isShowFetterBtn())
end

function BaseFormationLayer:initListView()
	local var_40_0 = self:getFormationInfo()
	local level_manager = require("controller.level_manager")
	local var_40_2 = TempWidget:CreateTempLayout()

	var_40_2:setContentSize(cc.size(self.formationLayout:size().w, var_0_17))

	local var_40_3 = TempWidget:CreateTempListView(var_40_2)

	var_40_3:setDirection(ccui.ListViewDirection.horizontal)
	var_40_3:setContentSize(cc.size(self.formationLayout:size().w, var_0_17))
	self.formationLayout:pushBackCustomItem(var_40_2)

	self.listView = var_40_3

	for iter_40_0 = 1, self:getFormationShowGirlNum() do
		local var_40_5 = TempWidget:CreateTempLayout()

		var_40_5:setContentSize(cc.size(var_40_3:size().w / self:getFormationShowGirlNum(), var_0_17))

		var_40_5._childData = {}

		local var_40_6 = TempWidget:CreateTempLayout(var_40_5)

		var_40_6:setContentSize(cc.size(var_40_5:size().w, var_0_12))
		var_40_6:align(cc.p(0, 1), 0, var_40_5:size().h)
		var_40_6:_addEvent(function()
			self:selectGirl(iter_40_0)
		end)

		var_40_5._childData.girlLayout = var_40_6

		local var_40_7 = TempWidget:CreateTempImg(var_0_5 .. "role_null_bg.png", var_40_6)

		var_40_7:setScaleX(1.1)
		var_40_7:align(cc.p(0.5, 0), var_40_6:size().w / 2, 0)
		var_40_7:setName("girlLayout" .. iter_40_0)

		local var_40_8 = TempWidget:CreateTempImg(var_0_5 .. "lock_girl.png", var_40_6)

		var_40_8:align(cc.p(0.5, 0), var_40_6:size().w / 2, 0)
		var_40_8:setScaleX(1.1)
		var_40_8:hide()

		var_40_5._childData.lockGirlBg = var_40_8

		local var_40_9 = TempWidget:CreateTempLabel(L_TEAM_TIPS.Lock, FONT_DES, 20, var_40_8)

		var_40_9:setScaleX(0.9090909090909091)
		var_40_9:align(cc.p(0.5, 0.5), var_40_6:size().w / 2 - 8, var_40_6:size().h / 2 - 55)
		var_40_9:setColor(cc.c3b(175, 191, 195))

		local var_40_10 = TempWidget:CreateTempLabel(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_SOUL_UNLOCK[iter_40_0], true), FONT_DES, 20, var_40_8)

		var_40_10:setScaleX(0.9090909090909091)
		var_40_10:align(cc.p(0.5, 0.5), var_40_6:size().w / 2 - 8, var_40_6:size().h / 2 - 85)
		var_40_10:setColor(cc.c3b(255, 211, 115))

		local var_40_11 = TempWidget:CreateTempLayout(var_40_5)

		var_40_11:setContentSize(cc.size(var_40_5:size().w, var_0_13))
		var_40_11:setClippingEnabled(true)
		var_40_11:align(cc.p(0, 1), 0, 250)

		var_40_5._childData.weaponLayout = var_40_11

		local var_40_12 = TempWidget:CreateTempImg(var_0_5 .. "horcrux_bg_left.png", var_40_11)

		var_40_12:setScale(var_0_22)
		var_40_12:align(cc.p(0, 0), 5, 0)

		local var_40_13 = TempWidget:CreateTempLayout(var_40_12)

		var_40_13:setContentSize(var_40_12:size())
		var_40_13:_addEvent(function()
			self:selectParts(iter_40_0)
		end)

		local var_40_14 = var_40_12:size().h

		var_40_5._childData.partsT = {}

		for iter_40_1 = 1, self.partsNum do
			local var_40_15 = TempWidget:CreateTempImg(var_0_5 .. "horcrux_bg_add_ing.png", var_40_12)

			var_40_15:align(cc.p(0.5, 0.5), var_40_12:size().w / 2, var_40_14 - var_40_14 / 3 / 2 - (iter_40_1 - 1) * var_40_14 / 3)

			var_40_15._initPos = var_40_15:pos()
			var_40_5._childData.partsT[iter_40_1] = var_40_15
		end

		local var_40_16 = TempWidget:CreateTempImg(var_0_5 .. "weapon_null_bg.png", var_40_11)

		var_40_16:setScale(var_0_22)
		var_40_16:align(cc.p(1, 0), var_40_11:size().w, 0)

		var_40_5._childData.weaponNullBg = var_40_16

		local var_40_17 = TempWidget:CreateTempLayout(var_40_16)

		var_40_17:setContentSize(var_40_16:size())
		var_40_17:_addEvent(function()
			self:selectWeapon(iter_40_0)
		end)

		local var_40_18 = TempWidget:CreateTempLayout(var_40_5)

		var_40_18:setContentSize(120, 120)
		var_40_18:align(cc.p(0, 0), 0, var_0_16)
		var_40_18:setPosition(0, 0)

		local var_40_19 = ccui.Button:create()

		var_40_18:_addEvent(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_44_0 = self:getFormationInfo()

			if not var_44_0 or not var_44_0[self.curFormationIndex] or not var_44_0[self.curFormationIndex][iter_40_0] then
				return
			end

			local var_44_1 = var_44_0[self.curFormationIndex][iter_40_0].fight_girl

			if not var_44_0[self.curFormationIndex][iter_40_0].fight_girl then
				return
			end

			local level_manager = require("controller.level_manager")

			if not level_manager:isPlayerPassLevel(UNLOCK_HORCRUX) then
				global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, (level_manager:formatSystemUnlockLevel(UNLOCK_HORCRUX))))

				return
			end

			if playermodel.haveServant[var_44_1] then
				LayerManager:pushInLayer("HorcruxDevourLayer", {
					servantId = var_44_1
				})
			end
		end)

		function var_40_18.update()
			local var_45_0 = self:getFormationInfo()

			if not var_45_0 or not var_45_0[self.curFormationIndex] or not var_45_0[self.curFormationIndex][iter_40_0] then
				return
			end

			local var_45_1 = var_45_0[self.curFormationIndex][iter_40_0].fight_girl

			for iter_45_0 = 1, 4 do
				local var_45_2 = var_40_18:getChildByName("devour_" .. iter_45_0)

				if not var_45_2 then
					var_45_2 = TempWidget:CreateTempLayout(var_40_18)

					var_45_2:setName("devour_" .. iter_45_0)
				end

				local var_45_3 = var_45_2:getChildByName("horcurxBg")

				if not var_45_3 then
					var_45_3 = TempWidget:CreateTempImg(var_0_5 .. "horcurx_bg.png", var_45_2)

					var_45_3:setName("horcurxBg")
				end

				if iter_45_0 <= 2 then
					var_45_3:align(cc.p(0, 0), 5 + 65 * (iter_45_0 - 1), 65)
				else
					var_45_3:align(cc.p(0, 0), 5 + 65 * (iter_45_0 - 3), 0)
				end

				local var_45_4 = var_45_3
				local var_45_5 = var_45_3:getChildByName("horcruxIcon")

				if not var_45_5 then
					var_45_5 = ccui.ImageView:create()

					var_45_5:setName("horcruxIcon")
					var_45_4:addChild(var_45_5)
					var_45_5:setPosition(28, 28)
				end

				local var_45_6 = var_45_4:getChildByName("null_img")

				if not var_45_6 then
					local var_45_7 = TempWidget:CreateTempImg("EquipLayer/null_img.png", var_45_4)

					var_45_7:setScale(0.95)
					var_45_7:align(cc.p(0.5, 0.5), var_45_4:getContentSize().width / 2, var_45_4:getContentSize().height / 2)
					var_45_7:setName("null_img")

					var_45_6 = var_45_7
				end

				var_45_6:setVisible(false)

				local var_45_8 = var_45_4:getChildByName("lock_img")

				if not var_45_8 then
					local var_45_9 = TempWidget:CreateTempImg("EquipLayer/lock_img.png", var_45_4)

					var_45_9:setScale(0.95)
					var_45_9:align(cc.p(0.5, 0.5), var_45_4:getContentSize().width / 2, var_45_4:getContentSize().height / 2)
					var_45_9:setName("lock_img")

					var_45_8 = var_45_9
				end

				var_45_8:hide()

				local var_45_10 = var_45_5:getChildByName("repeatImg")

				if not var_45_10 then
					local var_45_11 = TempWidget:CreateTempImg("EquipLayer/repeat.png", var_45_5)

					var_45_11:center()
					var_45_11:setScale(1.4)
					var_45_11:setName("repeatImg")

					var_45_10 = var_45_11
				end

				var_45_10:hide()
				var_45_5:setScale(0.33)
				var_45_5:setVisible(false)

				local var_45_12 = var_0_34:getLayerSkillInfo(var_45_1, iter_45_0)
				local var_45_13 = var_0_35:isUnlock(var_45_1, iter_45_0) and require("controller.level_manager"):isPlayerPassLevel(UNLOCK_HORCRUX)

				var_45_8:setVisible(not var_45_13)

				if var_45_12 then
					var_45_5:setVisible(true)
					var_45_5:loadTexture(var_45_12.horcruxPath)

					if var_45_12.disable then
						var_45_10:center()
						var_45_10:show()

						if var_45_13 then
							var_45_10:loadTexture("EquipLayer/repeat.png", var_0_4)
						else
							var_45_10:loadTexture("EquipLayer/hide.png", var_0_4)
						end
					end
				else
					var_45_5:setVisible(false)
					var_45_6:setVisible(true)
				end
			end
		end

		var_40_18.update()

		var_40_5._childData.horcruxLayout = var_40_18

		var_40_3:pushBackCustomItem(var_40_5)
	end

	if var_40_0 and var_40_0[self.curFormationIndex] then
		local var_40_20 = var_40_3:getItems()

		for iter_40_2 = 1, self:getFormationShowGirlNum() do
			if var_40_0[self.curFormationIndex][iter_40_2] then
				local var_40_21 = var_40_20[iter_40_2]
				local var_40_22 = var_40_20[iter_40_2]._childData.weaponLayout
				local var_40_23 = TempWidget:CreateTempImg(var_0_5 .. "career_icon_1.png", var_40_20[iter_40_2]._childData.girlLayout)

				var_40_23:align(cc.p(0, 1), 5, var_40_20[iter_40_2]._childData.girlLayout:size().h - 3)
				var_40_23:setScale(0.6)
				var_40_23:hide()

				var_40_21._childData.careerIcon = var_40_23

				if self:selectGirlConditionScreening(iter_40_2) then
					local var_40_25

					if var_40_0[self.curFormationIndex][iter_40_2].fight_girl then
						local var_40_24 = self:createGirlSprite(var_40_0[self.curFormationIndex][iter_40_2].fight_girl)

						var_40_24:setAnchorPoint(cc.p(0.5, 0))
						var_40_24:setPosition(cc.p(var_40_20[iter_40_2]._childData.girlLayout:size().w / 2 + var_0_19, 0))
						var_40_24:setScale(var_40_20[iter_40_2]._childData.girlLayout:size().w / var_40_24:getContentSize().width + var_0_20)
						var_40_20[iter_40_2]._childData.girlLayout:addChild(var_40_24)

						var_40_21._childData.girl = var_40_24

						var_40_23:show()
						var_40_23:loadTexture(var_0_5 .. "career_icon_" .. var_0_31.CAREER_STR_MAP[model_data[servant_data[var_40_0[self.curFormationIndex][iter_40_2].fight_girl].modelid].career] .. ".png", var_0_4)

						var_40_25 = TempWidget:CreateTempLabel(self:getGirlFightCapacitySum(iter_40_2), FONT_NAME, 16, var_40_20[iter_40_2]._childData.girlLayout)
					end

					var_40_25:_setColor("E3F3F9")
					var_40_25:align(cc.p(0, 1), 60, var_40_20[iter_40_2]._childData.girlLayout:size().h - 8)

					var_40_21._childData.fightCapacityText = var_40_25
				else
					-- block empty
				end

				local var_40_27 = self:createWeaponShowLayout(iter_40_2)

				var_40_22:addChild(var_40_27)
				var_40_27:align(cc.p(1, 0), var_40_22:size().w, 0)

				var_40_21._childData.weaponShowLayout = var_40_27
			end
		end
	end

	self:updateAllParts()
end

function BaseFormationLayer:initSureButton()
	local var_46_0 = TempWidget:CreateTempLayout(self._root)

	var_46_0:setContentSize(cc.size(150, 50))
	var_46_0:align(cc.p(0.5, 0.5), GameDisplay.cx, 110)
	var_46_0:_addEvent(function()
		return
	end)

	local var_46_1 = self:getSureBtnTextInfo()
	local var_46_2 = TempWidget:CreateTempBtn(var_46_1.path, var_46_0, var_46_1.configTextureType)

	var_46_2:center()
	var_46_2:setName("sureBtn")
	var_46_2:setVisible(self:isShowSureBtn())

	self.sureBtn = var_46_2

	local var_46_3 = TempWidget:CreateTempLabel(var_46_1.str, var_46_1.strFont, var_46_1.strSize, var_46_2)

	var_46_3:_setColor(var_46_1.strColor)
	var_46_3:align(cc.p(0.5, 0.5), var_46_2:size().w / 2, var_46_2:size().h / 2 - 5)

	self.sureBtnText = var_46_3

	local var_46_4 = self:getSureBtnExtendTextInfo()
	local var_46_5 = TempWidget:CreateTempLabel(var_46_4.str, var_46_4.strFont, var_46_4.strSize, var_46_0)

	var_46_5:_setColor(var_46_4.strColor)
	var_46_5:align(cc.p(0.5, 1), var_46_0:size().w / 2, -30)
	var_46_5:setVisible(var_46_4.visible)

	self.sureBtnExtendText = var_46_5
end

function BaseFormationLayer:createGirlSprite(arg_48_1)
	arg_48_1 = tonumber(arg_48_1)

	if arg_48_1 then
		local var_48_0 = GirlSprite:create({
			initType = self:getGirlSpriteType(),
			isHpInherit = self.is_hp_inherit
		})

		var_48_0:update(arg_48_1)
		var_48_0:setAnchorPoint(cc.p(0, 0))
		var_48_0:setPosition(cc.p(0, 0))

		var_48_0._childData = {}

		local var_48_1 = TempWidget:CreateTempLayout(var_48_0)

		var_48_1:setContentSize((var_48_0:getContentSize()))
		var_48_1:setTouchEnabled(true)

		var_48_0._childData.layout = var_48_1

		self:resetGirlSpriteListener(var_48_0, arg_48_1)

		local var_48_2 = self.fighttype or FORMATION_TYPE_TO_FIGHT_TYPE[self.configType]

		if role_false_level_manager:isRoleFalseLevelMember(arg_48_1, var_48_2, self.adverturemode or self.mode) then
			local var_48_4, var_48_5, var_48_6 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(arg_48_1, var_48_2, self.adverturemode or self.mode)

			var_48_0:updateByFalseLevel(arg_48_1, var_48_4, var_48_5)
		else
			var_48_0:stopFalseLevelAni()
		end

		self:createElementsIcon(var_48_0, arg_48_1)

		return var_48_0
	end

	return nil
end

function BaseFormationLayer:resetGirlSpriteListener(arg_49_1, arg_49_2)
	local var_49_0 = 0

	arg_49_1._childData.layout:addTouchEventListener(function(arg_50_0, arg_50_1)
		if arg_50_1 == ccui.TouchEventType.began then
			arg_49_1:imgScaleTo(1.1, 0.1)
			arg_50_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				arg_49_1:startPressBar(function()
					if arg_49_2 then
						LayerManager:pushInLayer("SoulsLayer", {
							showtype = 6,
							cursoul = arg_49_2
						})

						var_49_0 = 0.2
					else
						var_49_0 = 0
					end

					arg_49_1:endPressBar()
				end, function(arg_53_0)
					var_49_0 = var_49_0 + arg_53_0
				end)
			end)))
		elseif arg_50_1 == ccui.TouchEventType.canceled then
			arg_49_1:imgScaleTo(1, 0.1)
			arg_50_0:stopAllActions()
			arg_49_1:endPressBar()
		elseif arg_50_1 == ccui.TouchEventType.ended then
			arg_50_0:stopAllActions()

			if var_49_0 == 0 then
				local var_50_0 = self:getFormationInfo()

				if var_50_0 and var_50_0[self.curFormationIndex] then
					for iter_50_0, iter_50_1 in pairs(var_50_0[self.curFormationIndex]) do
						if tonumber(iter_50_1.fight_girl) == tonumber(arg_49_2) then
							self:selectGirl(iter_50_1.pos)

							break
						end
					end
				end
			end

			var_49_0 = 0

			arg_49_1:endPressBar()
			arg_49_1:imgScaleTo(1, 0.1)
		end
	end)
end

function BaseFormationLayer:createWeaponShowLayout(arg_54_1)
	local var_54_0 = TempWidget:CreateTempLayout()

	var_54_0:setContentSize(cc.size(67 * var_0_22, 76 * var_0_22))

	var_54_0._childData = {}

	local var_54_1 = TempWidget:CreateTempImg("weaponIcon/2200051.png", var_54_0, 0)

	var_54_1:setScale(0.2)
	var_54_1:center()

	var_54_0._childData.weaponImg = var_54_1

	local var_54_2 = TempWidget:CreateTempImg(var_0_5 .. "goto_gain_weapon.png", var_54_0)

	var_54_2:setScale(0.7)
	var_54_2:center()

	local var_54_3 = TempWidget:CreateTempImg(var_0_5 .. "weapon_unlocked.png", var_54_0)

	var_54_3:setScale(0.7)
	var_54_3:center()

	local var_54_4 = TempWidget:CreateTempLayout(var_54_0)

	var_54_4:setContentSize(cc.size(20, var_54_0:size().h))
	var_54_4:align(cc.p(1, 0), var_54_0:size().w, 0)

	for iter_54_0 = 1, 5 do
		local var_54_5 = TempWidget:CreateTempImg("public/currency/weapon_star.png", var_54_4)

		var_54_5:align(cc.p(0.5, 1), var_54_4:size().w / 2, var_54_4:size().h - 5 - (iter_54_0 - 1) * 15)
		var_54_5:setScale(0.5)
		var_54_5:setName("starImg" .. iter_54_0)
	end

	function var_54_0.update()
		var_54_1:hide()
		var_54_2:hide()
		var_54_3:hide()
		var_54_4:hide()

		local var_55_0 = self:getFormationInfo()

		if var_55_0 and var_55_0[self.curFormationIndex] and var_55_0[self.curFormationIndex][arg_54_1] then
			if var_55_0[self.curFormationIndex][arg_54_1].fight_girl then
				local var_55_1 = playermodel.items[playermodel.weaponId[var_55_0[self.curFormationIndex][arg_54_1].fight_girl]]

				if playermodel.items[playermodel.weaponId[var_55_0[self.curFormationIndex][arg_54_1].fight_girl]] then
					var_54_1:loadTexture("weaponIcon/" .. item_data[var_55_1.itemid].image_id .. ".png")
					var_54_1:setScale(0.2)
					var_54_4:show()

					for iter_55_0 = 1, 5 do
						local var_55_2 = var_54_4:getChildByName("starImg" .. iter_55_0)

						if item_data[var_55_1.itemid].max_star < iter_55_0 then
							var_55_2:hide()
						else
							var_55_2:show()
							var_55_2:loadTexture(var_55_1.weapon_attr.nowStars > 5 and (iter_55_0 > var_55_1.weapon_attr.nowStars - 5 and "public/currency/weapon_star_empty.png" or "public/currency/pink_star.png") or iter_55_0 <= var_55_1.weapon_attr.nowStars and "public/currency/weapon_star.png" or "public/currency/weapon_star_empty.png", var_0_4)
						end
					end
				else
					local var_55_4 = item_data[servant_data[var_55_0[self.curFormationIndex][arg_54_1].fight_girl].recommend_weapon2]

					if weapon_manager:checkIsCanReplaceBetter(var_55_0[self.curFormationIndex][arg_54_1].fight_girl) then
						var_54_1:loadTexture("weaponIcon/" .. var_55_4.image_id .. ".png")
						var_54_1:setScale(0.2)
						var_54_3:show()
					else
						var_54_1:loadTexture("weaponIcon/weapon_blue_shadow/" .. var_55_4.image_id .. ".png")
						var_54_1:setScale(0.45)
						var_54_2:show()
					end
				end

				var_54_1:show()
			end
		end
	end

	var_54_0.update()

	return var_54_0
end

function BaseFormationLayer:getFightCapacitySum()
	local var_56_0 = self:getFormationInfo()

	if var_56_0 and var_56_0[self.curFormationIndex] then
		return (var_0_2((require("controller.fight_capacity_manager"):getArrayFightCapacity(var_56_0[self.curFormationIndex], nil, nil, FORMATION_TYPE_TO_FIGHT_TYPE[self.configType], self.adverturemode or self.mode))))
	end

	return 0
end

function BaseFormationLayer:getGirlFightCapacitySum(arg_57_1)
	local var_57_0 = self:getFormationInfo()

	if var_57_0 and var_57_0[self.curFormationIndex] and var_57_0[self.curFormationIndex][arg_57_1] then
		if var_57_0[self.curFormationIndex][arg_57_1].fight_girl then
			return (var_0_2((require("controller.fight_capacity_manager"):getSoulFightCapacity(var_57_0[self.curFormationIndex][arg_57_1].fight_girl, "number", nil, var_57_0[self.curFormationIndex][arg_57_1].assist_girl, nil, nil, FORMATION_TYPE_TO_FIGHT_TYPE[self.configType], self.adverturemode or self.mode))))
		end
	end

	return 0
end

function BaseFormationLayer:getTeamSkill()
	local var_58_0 = self:getFormationInfo()

	if var_58_0 and var_58_0[self.curFormationIndex] then
		local team_skill_manager = require("controller.team_skill_manager")

		return (team_skill_manager:getSkillDes((team_skill_manager:getTeamskillByArrayTbl(var_58_0[self.curFormationIndex]))))
	end

	return {}
end

function BaseFormationLayer:selectIndex(arg_59_1)
	if self.curFormationIndex ~= arg_59_1 and self.manager and self.manager.setCurFormationIndex then
		self.manager:setCurFormationIndex(arg_59_1)

		self.curFormationIndex = arg_59_1

		self:updateGirl()
		self:updateSelectTeamStatus()
		self:updateSureBtnInfo()
		require("controller/help_battle/help_battle_manager"):getInstance():setFormationIndex(arg_59_1)
		self:updateCareerAttr()
		self:updateRed()
	end
end

function BaseFormationLayer:updateLayer()
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_61_0)
		self:captureScreenCallBack(arg_61_0)
	end)
end

function BaseFormationLayer:updateRed()
	self:updateHelpBattleAlert()
end

function BaseFormationLayer:updateWeaponShowLayout()
	if self.bInit then
		local var_63_0 = self.listView:getItems()

		for iter_63_0 = 1, #var_63_0 do
			var_63_0[iter_63_0]._childData.weaponShowLayout.update()
		end
	end
end

function BaseFormationLayer:updateHorcruxLayout()
	if self.bInit then
		local var_64_0 = self.listView:getItems()

		for iter_64_0 = 1, #var_64_0 do
			var_64_0[iter_64_0]._childData.horcruxLayout.update()
		end
	end
end

function BaseFormationLayer:updateGirlSuccess(arg_65_1)
	if self.bInit then
		local var_65_0 = self.listView:getItems()

		if var_65_0[arg_65_1] then
			var_65_0[arg_65_1]._childData.weaponShowLayout.update()
			var_65_0[arg_65_1]._childData.horcruxLayout.update()

			local var_65_1 = self:getFormationInfo()
			local var_65_2 = var_65_0[arg_65_1]._childData.careerIcon
			local var_65_3 = var_65_0[arg_65_1]._childData.girl

			if var_65_1 and var_65_1[self.curFormationIndex] then
				local var_65_4 = var_65_1[self.curFormationIndex][arg_65_1].fight_girl

				if var_65_1[self.curFormationIndex][arg_65_1].fight_girl then
					if var_65_3 then
						var_65_3:update(var_65_4)
						self:resetGirlSpriteListener(var_65_3, var_65_4)
					else
						var_65_3 = self:createGirlSprite(var_65_4)

						var_65_3:setAnchorPoint(cc.p(0.5, 0))
						var_65_3:setPosition(cc.p(var_65_0[arg_65_1]._childData.girlLayout:size().w / 2 + var_0_19, 0))
						var_65_3:setScale(var_65_0[arg_65_1]._childData.girlLayout:size().w / var_65_3:getContentSize().width + var_0_20)
						var_65_0[arg_65_1]._childData.girlLayout:addChild(var_65_3)

						var_65_0[arg_65_1]._childData.girl = var_65_3
					end

					local var_65_5 = var_0_31.CAREER_STR_MAP[model_data[servant_data[var_65_4].modelid].career]

					var_65_2:show()
					var_65_2:loadTexture(var_0_5 .. "career_icon_" .. var_65_5 .. ".png", var_0_4)

					local var_65_6 = self.fighttype or FORMATION_TYPE_TO_FIGHT_TYPE[self.configType]

					if role_false_level_manager:isRoleFalseLevelMember(var_65_4, var_65_6, self.adverturemode or self.mode) then
						local var_65_8, var_65_9, var_65_10 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_65_4, var_65_6, self.adverturemode or self.mode)

						var_65_3:updateByFalseLevel(var_65_4, var_65_8, var_65_9)
					else
						var_65_3:stopFalseLevelAni()
					end

					self:updateElementsIcon(var_65_3, var_65_4)
				elseif var_65_3 then
					var_65_3:removeFromParent()

					var_65_0[arg_65_1]._childData.girl = nil

					var_65_2:hide()
				end
			end

			self:updateFightCapacityText(arg_65_1)
			self:updateTeamFightCapacity()
			self:updateShowTeamSkillLayout()
			self:updateParts(arg_65_1)
		end
	end
end

function BaseFormationLayer:updateGirl()
	if self.bInit then
		for iter_66_0 = 1, self:getFormationShowGirlNum() do
			self:updateGirlSuccess(iter_66_0)
		end
	end
end

function BaseFormationLayer:updateFightCapacityText(arg_67_1)
	if self.bInit then
		local var_67_0 = self.listView:getItems()

		if var_67_0[arg_67_1] then
			if var_67_0[arg_67_1]._childData.fightCapacityText then
				var_67_0[arg_67_1]._childData.fightCapacityText:setString(self:getGirlFightCapacitySum(arg_67_1))
			end
		end
	end
end

function BaseFormationLayer:updateSelectTeamStatus()
	if self.bInit then
		local var_68_0 = self.formationIndexListView:getItems()

		for iter_68_0 = 1, #var_68_0 do
			if var_68_0[iter_68_0]._childData then
				var_68_0[iter_68_0]._childData.selectBtn:loadTextureEx((iter_68_0 == self.curFormationIndex or nil) and var_0_5 .. "select_team_on.png")
				var_68_0[iter_68_0]._childData.text:_setColor(self:getSelectBtnTextInfo(iter_68_0).color)
			end
		end
	end
end

function BaseFormationLayer:updateShowTeamSkillLayout()
	if self.bInit then
		local var_69_0 = self:getTeamSkill()
		local var_69_1 = self.headLayout._childData.iconBackImg
		local var_69_2 = self.headLayout._childData.iconImg

		self.headLayout._childData.teamSkillTextLayout:removeAllChildren()
		self.headLayout._childData.iconBackImg:stopAllActions()
		self.headLayout._childData.iconImg:stopAllActions()

		if #var_69_0 == 0 then
			self.headLayout._childData.defaultText:show()
			self.headLayout._childData.showTeamSkillLayout:hide()
			self.headLayout._childData.tagImg:show()
		else
			self.headLayout._childData.defaultText:hide()
			self.headLayout._childData.showTeamSkillLayout:show()
			self.headLayout._childData.tagImg:hide()
			self.headLayout._childData.iconBackImg:loadTextureEx(var_0_5 .. "icon_" .. var_69_0[1].icon .. ".png")
			self.headLayout._childData.iconImg:loadTextureEx(var_0_5 .. "icon_" .. var_69_0[1].icon .. ".png")

			local var_69_3 = var_0_21

			self.headLayout._childData.iconBackImg:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(var_0_21 / 5), cc.CallFunc:create(function()
				var_69_1:setScale(var_69_3)
				var_69_1:setOpacity(255)
			end), cc.Spawn:create(cc.ScaleTo:create(0.5, var_0_21 * 2), cc.FadeOut:create(0.5)), cc.DelayTime:create(0.6))))

			local var_69_4 = {}

			for iter_69_0 = 1, #var_69_0 do
				local var_69_5 = TempWidget:CreateTempLabel(var_69_0[iter_69_0].des, FONT_NAME, 18, self.headLayout._childData.teamSkillTextLayout)

				var_69_5:setAnchorPoint(cc.p(0, 0.5))
				var_69_5:align(cc.p(0, 0.5), 35, self.headLayout._childData.teamSkillTextLayout:size().h / 2)
				var_69_5:setOpacity(0)
				table.insert(var_69_4, var_69_5)
			end

			var_69_4[1]:setOpacity(255)

			if #var_69_4 > 1 then
				for iter_69_1 = 1, #var_69_4 do
					var_69_4[iter_69_1]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_69_1 - 1) * 3), cc.CallFunc:create(function()
						var_69_2:loadTextureEx(var_0_5 .. "icon_" .. var_69_0[iter_69_1].icon .. ".png")
						var_69_1:loadTextureEx(var_0_5 .. "icon_" .. var_69_0[iter_69_1].icon .. ".png")
					end), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(2.6), cc.FadeTo:create(0.2, 0), cc.DelayTime:create((#var_69_4 - 1) * 3 - (iter_69_1 - 1) * 3))))
				end
			end
		end
	end
end

function BaseFormationLayer:updateAllParts()
	if self.bInit then
		for iter_72_0 = 1, var_0_8 do
			self:updateParts(iter_72_0)
		end
	end
end

function BaseFormationLayer:updateParts(arg_73_1)
	if self.bInit then
		local component_effect_data = require("data.component_effect_data")
		local var_73_1 = self.listView:getItems()

		if var_73_1[arg_73_1] then
			local var_73_2 = var_73_1[arg_73_1]._childData.partsT
			local var_73_3 = self:getFormationInfo()
			local var_73_4

			if var_73_3 and var_73_3[self.curFormationIndex] and var_73_3[self.curFormationIndex][arg_73_1] then
				var_73_4 = var_73_3[self.curFormationIndex][arg_73_1].fight_girl
			end

			if not var_73_4 then
				for iter_73_0 = 1, #var_73_2 do
					var_73_2[iter_73_0]:setScale(1)
					var_73_2[iter_73_0]:loadTextureEx(var_0_5 .. "horcrux_bg_add_ing.png")
					var_73_2[iter_73_0]:setPositionY(var_73_2[iter_73_0]._initPos.y)
				end
			elseif playermodel.component[var_73_4] then
				local var_73_5 = require("controller.component_manager"):getSoulComponentlist(var_73_4)

				for iter_73_1 = 1, #var_73_2 do
					var_73_2[iter_73_1]:setPositionY(var_73_2[iter_73_1]._initPos.y)
				end

				for iter_73_2 = 1, self.partsNum do
					if playermodel.component[var_73_4][iter_73_2] then
						local var_73_6 = item_data[playermodel.items[playermodel.component[var_73_4][iter_73_2].id].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_73_4][iter_73_2].id].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[playermodel.component[var_73_4][iter_73_2].id].itemid].main_attr .. "_" .. iter_73_2 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_73_4][iter_73_2].id].component_attr.effect].image_id .. "_" .. playermodel.items[playermodel.component[var_73_4][iter_73_2].id].component_attr.attr1 .. "_" .. iter_73_2 .. ".png"

						var_73_2[iter_73_2]:setScale(0.6)
						var_73_2[iter_73_2]:loadTextureEx(var_73_6, 0)

						local var_73_7 = var_73_2[iter_73_2]._initPos.y
						local var_73_8 = 18

						if var_73_5.effect then
							var_73_8 = 25
						end

						if iter_73_2 == 1 then
							var_73_7 = var_73_7 - var_73_8
						elseif iter_73_2 == 3 then
							var_73_7 = var_73_7 + var_73_8
						end

						var_73_2[iter_73_2]:setPositionY(var_73_7)
					else
						var_73_2[iter_73_2]:loadTextureEx(var_0_5 .. "horcrux_bg_add_ing.png")
						var_73_2[iter_73_2]:setPositionY(var_73_2[iter_73_2]._initPos.y)
					end
				end
			else
				for iter_73_3 = 1, #var_73_2 do
					var_73_2[iter_73_3]:setScale(1)
					var_73_2[iter_73_3]:loadTextureEx(var_0_5 .. "horcrux_bg_add_ing.png")
					var_73_2[iter_73_3]:setPositionY(var_73_2[iter_73_3]._initPos.y)
				end
			end
		end
	end
end

function BaseFormationLayer:updateSureBtnInfo()
	if self.bInit then
		local var_74_0 = self:getSureBtnTextInfo()

		self.sureBtn:loadTextureNormal(var_74_0.path, var_74_0.configTextureType)
		self.sureBtnText:setString(var_74_0.str)
		self.sureBtnText:_setColor(var_74_0.strColor)

		local var_74_1 = self:getSureBtnExtendTextInfo()

		self.sureBtnExtendText:setString(var_74_1.str)
		self.sureBtnExtendText:_setColor(var_74_1.strColor)
		self.sureBtnExtendText:setVisible(var_74_1.visible)
	end
end

function BaseFormationLayer:oneTimeUpdateSuccess()
	if self.bInit then
		self:updateGirl()
		self:updateRed()
	end
end

function BaseFormationLayer:extendArraySuccess()
	if self.bInit then
		self.curFormationIndex = #(playermodel.arrays or {}) or 1

		self:updateFormationIndexListView()
		self:updateListView()
		self:moveFormationIndexListViewLast()
	end
end

function BaseFormationLayer:moveFormationIndexListViewLast()
	self.formationIndexListView:jumpToRight()
end

function BaseFormationLayer:updateFormationIndexListView()
	if self.bInit then
		self:initFormationIndexListView()
	end
end

function BaseFormationLayer:updateListView()
	if self.bInit then
		self:updateGirl()
		self:updateRed()
	end
end

function BaseFormationLayer:updateTeamFightCapacity()
	if self.bInit then
		self.headLayout._childData.teamFightCapacity:setString(L_BASE_FORMATION[5] .. self:getFightCapacitySum())
	end
end

function BaseFormationLayer:updateElementsIcon()
	return
end

function BaseFormationLayer:createElementsIcon()
	return
end

function BaseFormationLayer:isCanExtendFormation()
	return false
end

function BaseFormationLayer:getFormationShowGirlNum()
	return var_0_8
end

function BaseFormationLayer:selectGirl(arg_85_1)
	if self:selectGirlConditionScreening(arg_85_1, {
		bAutoTips = true
	}) then
		local var_85_0 = self:getFormationInfo()

		if var_85_0 and var_85_0[self.curFormationIndex] then
			LayerManager:pushInLayer("GirlSelectLayer", (self:getSelectGirlConfig(arg_85_1)))
		end
	end
end

function BaseFormationLayer:selectGirlConditionScreening(arg_86_1, arg_86_2)
	arg_86_2 = arg_86_2 or {}

	if not require("controller.level_manager"):isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_86_1]) then
		if arg_86_2.bAutoTips or false then
			global_ShowBlockWords(L_Change_ARRAY_WARNING.Unlock)
			require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
		end

		return false
	end

	return true
end

function BaseFormationLayer:getSelectGirlConfig(arg_87_1)
	local var_87_0 = {}

	var_87_0.fightType = self.fighttype or FORMATION_TYPE_TO_FIGHT_TYPE[self.configType]
	var_87_0.selectType = self.selectGirlType
	var_87_0.cursoul = self:getFormationInfo()[self.curFormationIndex][arg_87_1].fight_girl
	var_87_0.arrayinfo = {
		index = self.curFormationIndex,
		pos = arg_87_1
	}
	var_87_0.is_hp_inherit = self.is_hp_inherit

	function var_87_0.sureCallBack(arg_88_0)
		return
	end

	return var_87_0
end

function BaseFormationLayer:getGirlSpriteType()
	return "formationStype"
end

function BaseFormationLayer:getHorcruxSpriteType()
	return "arrayMemberMainStyle"
end

function BaseFormationLayer:selectWeapon(arg_91_1)
	self.manager:selectWeapon(arg_91_1)
end

function BaseFormationLayer:getSelectHorcruxConfig(arg_92_1)
	local var_92_0 = self:getFormationInfo()
	local var_92_1 = {}

	for iter_92_0, iter_92_1 in pairs(var_92_0[self.curFormationIndex]) do
		if iter_92_1.assist_girl then
			var_92_1[#var_92_1 + 1] = iter_92_1.assist_girl
		end
	end

	return {
		selectType = self.selectHorcruxType,
		curHorcrux = var_92_0[self.curFormationIndex][arg_92_1].assist_girl,
		arrayIndex = self.curFormationIndex,
		arrayPos = arg_92_1,
		outSide = var_92_1,
		selectGirlServantId = var_92_0[self.curFormationIndex][arg_92_1].fight_girl,
		selectCallback = function(arg_93_0)
			return
		end
	}
end

function BaseFormationLayer:selectParts(arg_94_1)
	local var_94_0 = self:getFormationInfo()

	if var_94_0 and var_94_0[self.curFormationIndex] then
		if var_94_0[self.curFormationIndex][arg_94_1].fight_girl then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				cursoul = var_94_0[self.curFormationIndex][arg_94_1].fight_girl,
				exitCallback = function()
					if self.manager and self.manager.layer then
						self:updateAllParts()
					end
				end
			})
		else
			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Assist_Girl_Nil)
			require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
		end
	end
end

function BaseFormationLayer:getFormationInfo()
	if self.manager and self.manager.getFormationInfo then
		return self.manager:getFormationInfo()
	end

	return {}
end

function BaseFormationLayer:getAutoFormationCallBack()
	local var_97_1 = self.curFormationIndex

	return function(arg_98_0)
		local var_98_0 = {}
		local var_98_1 = {}

		for iter_98_0, iter_98_1 in pairs(ATTR_ID) do
			var_98_1[iter_98_1] = {}
		end

		local var_98_2 = {}
		local var_98_3 = {}

		if self.configType == CONFIG_TYPE_TVT_ATTACK_FORM then
			local var_98_4 = self:getFormationInfo()

			for iter_98_2 = 1, #var_98_4 do
				if iter_98_2 ~= var_97_1 then
					for iter_98_3 = 1, #var_98_4[iter_98_2] do
						if var_98_4[iter_98_2][iter_98_3].fight_girl then
							var_98_2[var_98_4[iter_98_2][iter_98_3].fight_girl] = true
						end

						if var_98_4[iter_98_2][iter_98_3].assist_girl then
							var_98_3[var_98_4[iter_98_2][iter_98_3].assist_girl] = true
						end
					end
				end
			end
		elseif self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
			local explore_manager = require("controller.explore_manager")

			var_98_2 = explore_manager:getDeadGirls()

			local var_98_6 = explore_manager:getUsedHorcruxs()
		elseif self.configType == CONFIG_TYPE_HANGUP or self.configType ~= CONFIG_TYPE_ARENA_DEFENCE and self.configType ~= CONFIG_TYPE_ARENA then
			var_98_2 = {}
		end

		local fight_capacity_manager = require("controller.fight_capacity_manager")
		local var_98_8 = require("controller.level_manager"):getDropUpServants(arg_98_0.mode)

		if arg_98_0.type == "all" or string.find(arg_98_0.type, "other") then
			for iter_98_4, iter_98_5 in pairs(playermodel.haveServant) do
				if not var_98_2[iter_98_4] then
					table.insert(var_98_0, {
						id = iter_98_4,
						capacity = fight_capacity_manager:getSoulFightCapacity(iter_98_4, "number"),
						drop_up = (var_0_36(var_98_8, iter_98_4) or nil) and 1
					})
				end
			end

			table.sort(var_98_0, function(arg_99_0, arg_99_1)
				if arg_99_0.drop_up == arg_99_1.drop_up then
					return arg_99_0.capacity > arg_99_1.capacity
				else
					return arg_99_0.drop_up > arg_99_1.drop_up
				end
			end)
		elseif string.find(arg_98_0.type, ",") then
			for iter_98_6, iter_98_7 in pairs(playermodel.haveServant) do
				if not var_98_2[iter_98_6] then
					local var_98_10 = global_get_all_model_attrs(servant_data[iter_98_6].modelid)
					local var_98_11 = fight_capacity_manager:getSoulFightCapacity(iter_98_6, "number")
					local var_98_12 = 0

					if var_0_36(var_98_8, iter_98_6) then
						var_98_12 = 1
					end

					table.insert(var_98_1[var_98_10.main], {
						id = iter_98_6,
						capacity = var_98_11,
						drop_up = var_98_12
					})

					for iter_98_8, iter_98_9 in ipairs(var_98_10.sub or {}) do
						table.insert(var_98_1[iter_98_9], {
							id = iter_98_6,
							capacity = var_98_11,
							drop_up = var_98_12
						})
					end
				end
			end

			for iter_98_10, iter_98_11 in ipairs({
				"wind",
				"fire",
				"water",
				"light",
				"dark"
			}) do
				for iter_98_12, iter_98_13 in ipairs(var_98_1.imaginary) do
					table.insert(var_98_1[iter_98_11], iter_98_13)
				end
			end

			for iter_98_14, iter_98_15 in ipairs((string.split(arg_98_0.type, ","))) do
				for iter_98_16, iter_98_17 in ipairs(var_98_1[iter_98_15]) do
					if not var_0_36(var_98_0, iter_98_17) then
						table.insert(var_98_0, iter_98_17)
					end
				end
			end

			table.sort(var_98_0, function(arg_100_0, arg_100_1)
				if arg_100_0.drop_up == arg_100_1.drop_up then
					return arg_100_0.capacity > arg_100_1.capacity
				else
					return arg_100_0.drop_up > arg_100_1.drop_up
				end
			end)
		else
			for iter_98_18, iter_98_19 in pairs(playermodel.haveServant) do
				if not var_98_2[iter_98_18] then
					local var_98_13 = global_get_all_model_attrs(servant_data[iter_98_18].modelid)
					local var_98_14 = fight_capacity_manager:getSoulFightCapacity(iter_98_18, "number")

					table.insert(var_98_1[var_98_13.main], {
						id = iter_98_18,
						capacity = var_98_14
					})

					for iter_98_20, iter_98_21 in ipairs(var_98_13.sub or {}) do
						table.insert(var_98_1[iter_98_21], {
							id = iter_98_18,
							capacity = var_98_14
						})
					end
				end
			end

			for iter_98_22, iter_98_23 in ipairs({
				"wind",
				"fire",
				"water",
				"light",
				"dark"
			}) do
				for iter_98_24, iter_98_25 in ipairs(var_98_1.imaginary) do
					table.insert(var_98_1[iter_98_23], iter_98_25)
				end
			end

			for iter_98_26, iter_98_27 in pairs(var_98_1) do
				table.sort(iter_98_27, function(arg_101_0, arg_101_1)
					return arg_101_0.capacity > arg_101_1.capacity
				end)
			end
		end

		local var_98_15, var_98_16 = self:chooseTheTeam(var_97_1, arg_98_0.type, var_98_1, var_98_0)

		if var_98_15 and next(var_98_15) then
			if not var_98_16 then
				LayerManager:pushInLayer("PopDoLayer", {
					labels = {
						title = L_GO_CONFIG_DES.twist,
						des = L_BASE_FORMATION[10],
						button = L_BATTLEPASS_BUY.button
					},
					surecallback = function()
						LayerManager:switchShowLayer("TwisteggLayer")
					end
				})

				return false
			end
		end

		self:getRequestUpdateArrayCallBack()(var_97_1, var_98_15)

		return true
	end
end

function BaseFormationLayer:fastEquipment()
	local servant_data = require("data.servant_data")
	local var_103_2 = self.curFormationIndex
	local var_103_3 = {}

	for iter_103_0, iter_103_1 in pairs(ATTR_ID) do
		var_103_3[iter_103_1] = {}
	end

	local var_103_4 = {}

	if self.configType == CONFIG_TYPE_TVT_ATTACK_FORM then
		local var_103_5 = self:getFormationInfo()

		for iter_103_2 = 1, #var_103_5 do
			for iter_103_3 = 1, #var_103_5[iter_103_2] do
				if var_103_5[iter_103_2][iter_103_3].assist_girl then
					var_103_4[var_103_5[iter_103_2][iter_103_3].assist_girl] = true
				end
			end
		end
	elseif self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
		var_103_4 = require("controller.explore_manager"):getUsedHorcruxs()
	elseif self.configType == CONFIG_TYPE_HANGUP or self.configType ~= CONFIG_TYPE_ARENA_DEFENCE and self.configType ~= CONFIG_TYPE_ARENA then
		local var_103_6 = self:getFormationInfo()

		for iter_103_4 = 1, #var_103_6 do
			if iter_103_4 == var_103_2 then
				for iter_103_5 = 1, #var_103_6[iter_103_4] do
					if var_103_6[iter_103_4][iter_103_5].assist_girl then
						var_103_4[var_103_6[iter_103_4][iter_103_5].assist_girl] = true
					end
				end
			end
		end
	end

	for iter_103_6, iter_103_7 in pairs(playermodel.items) do
		if item_data[iter_103_7.itemid] and item_data[iter_103_7.itemid].bag_item_type and item_data[iter_103_7.itemid].bag_item_type == 30 and not var_103_4[iter_103_6] then
			table.insert(var_103_3[global_get_model_attr(item_data[iter_103_7.itemid].model)], iter_103_6)
		end
	end

	local var_103_7, var_103_8 = self:chooseTheTeamHorcrux(var_103_2, var_103_3)

	self:getRequestUpdateArrayCallBack()(var_103_2, var_103_7)

	if not next((self:fastEquipmentParts(var_103_7))) then
		local var_103_9 = true

		for iter_103_8, iter_103_9 in pairs(var_103_3) do
			if next(iter_103_9) then
				var_103_9 = false

				break
			end
		end

		if var_103_9 then
			global_ShowBlockWords(L_BASE_FORMATION[11])
		end

		return
	end
end

function BaseFormationLayer:chooseTheTeamHorcrux(arg_104_1, arg_104_2)
	local var_104_0 = false
	local var_104_1 = {}
	local servant_data = require("data.servant_data")
	local fight_capacity_manager = require("controller.fight_capacity_manager")
	local var_104_5 = self:getFormationInfo()[arg_104_1]

	for iter_104_0 = 1, var_0_8 do
		if var_104_5[iter_104_0] and var_104_5[iter_104_0].fight_girl then
			var_104_0 = true
			var_104_1["pos_" .. iter_104_0] = {
				pos = iter_104_0,
				fight_girl = var_104_5[iter_104_0].fight_girl
			}
		else
			var_104_1["pos_" .. iter_104_0] = {
				pos = iter_104_0
			}
		end
	end

	return var_104_1, var_104_0
end

function BaseFormationLayer:fastEquipmentPartsSuccess()
	self:updateAllParts()
	self:updateTeamFightCapacity()
end

function BaseFormationLayer:fastEquipmentParts(arg_106_1)
	local servant_data = require("data.servant_data")
	local component_manager = require("controller.component_manager")
	local var_106_2 = require("controller.GlobalConstantsManager"):getInstance()
	local var_106_4 = {}

	if self.configType == CONFIG_TYPE_TVT_ATTACK_FORM then
		local var_106_5 = self:getFormationInfo()

		for iter_106_0 = 1, #var_106_5 do
			if iter_106_0 == self.curFormationIndex then
				for iter_106_1, iter_106_2 in pairs(arg_106_1) do
					if playermodel.component[iter_106_2.fight_girl] then
						for iter_106_3, iter_106_4 in pairs(playermodel.component[iter_106_2.fight_girl]) do
							var_106_4[iter_106_4.id] = true
						end
					end
				end
			else
				for iter_106_5 = 1, #var_106_5[iter_106_0] do
					if playermodel.component[var_106_5[iter_106_0][iter_106_5].fight_girl] then
						for iter_106_6, iter_106_7 in pairs(playermodel.component[var_106_5[iter_106_0][iter_106_5].fight_girl]) do
							var_106_4[iter_106_7.id] = true
						end
					end
				end
			end
		end
	elseif self.configType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
		-- block empty
	elseif self.configType == CONFIG_TYPE_HANGUP or self.configType ~= CONFIG_TYPE_ARENA_DEFENCE and self.configType ~= CONFIG_TYPE_ARENA then
		for iter_106_8, iter_106_9 in pairs(playermodel.haveServant) do
			if iter_106_9 and playermodel.component[iter_106_8] and next(playermodel.component[iter_106_8]) then
				for iter_106_10, iter_106_11 in pairs(playermodel.component[iter_106_8]) do
					var_106_4[iter_106_11.id] = true
				end
			end
		end
	end

	local var_106_6 = {}
	local var_106_7 = {}

	for iter_106_12, iter_106_13 in pairs(playermodel.items) do
		if item_data[iter_106_13.itemid] and item_data[iter_106_13.itemid].bag_item_type and item_data[iter_106_13.itemid].bag_item_type == kITEM_COMPONENT and not var_106_4[iter_106_12] then
			local var_106_8 = component_manager:getComponentAttrsInfo(iter_106_13.entityid)

			var_106_8.entityid = iter_106_13.entityid
			var_106_6[iter_106_13.entityid] = {
				suitId = iter_106_13.component_attr.effect,
				mainAttrId = var_106_8.main_attr_num
			}
			var_106_7[iter_106_13.component_attr.effect] = var_106_7[iter_106_13.component_attr.effect] or {}
			var_106_7[iter_106_13.component_attr.effect][var_106_8.main_attr_num] = var_106_7[iter_106_13.component_attr.effect][var_106_8.main_attr_num] or {}

			table.insert(var_106_7[iter_106_13.component_attr.effect][var_106_8.main_attr_num], var_106_8)
		end
	end

	local var_106_9 = string.split(var_106_2:getValueById(8), "|")
	local var_106_10 = {}

	for iter_106_14 = 1, #var_106_9 do
		local var_106_11 = string.split(var_106_9[iter_106_14], "&")
		local var_106_12 = string.split(var_106_11[2], "#")
		local var_106_13 = string.split(var_106_11[3], "#")
		local var_106_14 = string.split(var_106_11[4], "#")

		var_106_10[var_106_11[1]] = {}
		var_106_10[var_106_11[1]].suits = {}
		var_106_10[var_106_11[1]].damageType = {
			{},
			{}
		}

		for iter_106_15 = 1, #var_106_12 do
			var_106_10[var_106_11[1]].suits[#var_106_10[var_106_11[1]].suits + 1] = tonumber(var_106_12[iter_106_15])
		end

		for iter_106_16 = 1, #var_106_13 do
			var_106_10[var_106_11[1]].damageType[1][#var_106_10[var_106_11[1]].damageType[1] + 1] = tonumber(var_106_13[iter_106_16])
		end

		for iter_106_17 = 1, #var_106_14 do
			var_106_10[var_106_11[1]].damageType[2][#var_106_10[var_106_11[1]].damageType[2] + 1] = tonumber(var_106_14[iter_106_17])
		end
	end

	local var_106_15 = {}

	for iter_106_18, iter_106_19 in pairs(arg_106_1) do
		local var_106_16 = iter_106_19.fight_girl

		if iter_106_19.fight_girl then
			var_106_15[var_106_16] = var_106_15[var_106_16] or {}
			var_106_15[var_106_16].servantid = var_106_16

			local var_106_17 = {}

			if playermodel.component[var_106_16] then
				for iter_106_20, iter_106_21 in pairs(playermodel.component[var_106_16]) do
					var_106_17[iter_106_21.pos] = true
				end
			end

			for iter_106_22 = 1, var_0_23 do
				if not var_106_17[iter_106_22] and var_106_10[model_data[servant_data[var_106_16].modelid].career] then
					var_106_15[var_106_16].componentList = var_106_15[var_106_16].componentList or {}

					local var_106_18 = var_106_10[model_data[servant_data[var_106_16].modelid].career].damageType[model_data[servant_data[var_106_16].modelid].damage_type] or var_106_10[model_data[servant_data[var_106_16].modelid].career].damageType[1]
					local var_106_19 = false

					for iter_106_23 = 1, #var_106_10[model_data[servant_data[var_106_16].modelid].career].suits do
						if var_106_19 then
							break
						end

						for iter_106_24 = 1, #var_106_18 do
							if var_106_19 then
								break
							end

							if var_106_7[var_106_10[model_data[servant_data[var_106_16].modelid].career].suits[iter_106_23]] and var_106_7[var_106_10[model_data[servant_data[var_106_16].modelid].career].suits[iter_106_23]][var_106_18[iter_106_24]] then
								local var_106_20 = 0
								local var_106_21 = false

								for iter_106_25, iter_106_26 in pairs(var_106_7[var_106_10[model_data[servant_data[var_106_16].modelid].career].suits[iter_106_23]][var_106_18[iter_106_24]]) do
									if not iter_106_26.value or not iter_106_26.pos then
										-- block empty
									end

									if not var_106_4[iter_106_26.entityid] and var_106_20 < iter_106_26.value and iter_106_26.pos == iter_106_22 then
										var_106_20 = iter_106_26.value
										var_106_15[var_106_16].componentList[iter_106_22] = {
											entityid = iter_106_26.entityid,
											pos = iter_106_22
										}
										var_106_21 = true
									end
								end

								if var_106_21 then
									var_106_4[var_106_15[var_106_16].componentList[iter_106_22].entityid] = true
									var_106_19 = true
								end
							end
						end
					end
				end
			end
		end
	end

	if self.manager and self.manager.fastEquipmentParts then
		self.manager:fastEquipmentParts(var_106_15)
	end

	local var_106_23 = {}

	for iter_106_27, iter_106_28 in pairs(var_106_6) do
		if not var_106_4[iter_106_27] then
			var_106_23[iter_106_27] = true
		end
	end

	return var_106_23
end

function BaseFormationLayer:getAutoAdvanceForcesCallBack()
	return function()
		local var_108_0 = self.manager:getAdvanceForcesOneTimeArray()
		local var_108_1 = false

		for iter_108_0, iter_108_1 in pairs(self.manager:getFormationInfo()[self.curFormationIndex]) do
			if iter_108_1.assist_girl ~= var_108_0["pos_" .. iter_108_1.pos].assist_girl then
				var_108_1 = true

				break
			end

			if iter_108_1.fight_girl ~= var_108_0["pos_" .. iter_108_1.pos].fight_girl then
				var_108_1 = true

				break
			end
		end

		if var_108_1 then
			self.manager:requestOneTimeUpdateArray(nil, var_108_0)
		else
			global_ShowBlockWords(L_BASE_FORMATION[12])
		end
	end
end

function BaseFormationLayer:getRequestUpdateArrayCallBack()
	return function(arg_110_0, arg_110_1)
		if self.manager and self.manager.requestOneTimeUpdateArray then
			self.manager:requestOneTimeUpdateArray(arg_110_0, arg_110_1)
		end
	end
end

function BaseFormationLayer:chooseTheTeam(arg_111_1, arg_111_2, arg_111_3, arg_111_4)
	local var_111_0 = false

	if not arg_111_2 then
		return
	end

	local var_111_1 = {}
	local servant_data = require("data.servant_data")
	local fight_capacity_manager = require("controller.fight_capacity_manager")

	if arg_111_2 == "all" or string.find(arg_111_2, ",") then
		for iter_111_0 = 1, var_0_8 do
			if arg_111_4[iter_111_0] then
				var_111_0 = true
				var_111_1["pos_" .. iter_111_0] = {
					pos = iter_111_0,
					fight_girl = arg_111_4[iter_111_0].id
				}
			else
				var_111_1["pos_" .. iter_111_0] = {
					pos = iter_111_0
				}
			end
		end
	elseif string.find(arg_111_2, "other") then
		local var_111_6 = {}

		for iter_111_1, iter_111_2 in pairs((string.split(string.split(arg_111_2, "|")[2], "#"))) do
			var_111_6[iter_111_2] = 1
		end

		local var_111_7 = 1

		for iter_111_3 = 1, var_0_8 do
			local var_111_9 = false

			while arg_111_4[var_111_7] do
				if var_111_6[global_get_model_attr(servant_data[arg_111_4[var_111_7].id].modelid)] then
					var_111_9 = true

					break
				else
					var_111_7 = var_111_7 + 1
				end
			end

			if var_111_9 then
				var_111_0 = true
				var_111_1["pos_" .. iter_111_3] = {
					pos = iter_111_3,
					fight_girl = arg_111_4[var_111_7].id
				}
				var_111_7 = var_111_7 + 1
			else
				var_111_1["pos_" .. iter_111_3] = {
					pos = iter_111_3
				}
			end
		end
	else
		for iter_111_4 = 1, var_0_8 do
			if arg_111_3[arg_111_2][iter_111_4] then
				var_111_0 = true
				var_111_1["pos_" .. iter_111_4] = {
					pos = iter_111_4,
					fight_girl = arg_111_3[arg_111_2][iter_111_4].id
				}
			else
				var_111_1["pos_" .. iter_111_4] = {
					pos = iter_111_4
				}
			end
		end
	end

	return var_111_1, var_111_0
end

function BaseFormationLayer:isShowAutoFormationBtn()
	return require("controller.level_manager"):isPlayerPassLevel(UNLOCK_AUTO_FORMATION) == true
end

function BaseFormationLayer:isShowAutoHelpBattleBtn()
	return false
end

function BaseFormationLayer:isShowAutoAdvanceForceBtn()
	return false
end

function BaseFormationLayer:isShowFastEquipmentBtn()
	return self.configType == CONFIG_TYPE_HANGUP
end

function BaseFormationLayer:isShowSureBtn()
	return true
end

function BaseFormationLayer:getSelectBtnTextInfo(arg_117_1)
	local var_117_0 = {
		str = L_BASE_FORMATION[6] .. arg_117_1,
		font = FONT_NAME
	}

	var_117_0.size = 24
	var_117_0.color = "6B7090"

	if arg_117_1 == self.curFormationIndex then
		var_117_0.color = "47404E"
	end

	return var_117_0
end

function BaseFormationLayer:getSureBtnTextInfo()
	local var_118_0 = {}

	var_118_0.path = "public/button/public_button_orange_long.png"
	var_118_0.configTextureType = var_0_4
	var_118_0.str = L_BASE_FORMATION[7]
	var_118_0.strColor = "242C3A"
	var_118_0.strSize = 30
	var_118_0.strFont = FONT_BUTTON

	return var_118_0
end

function BaseFormationLayer:getSureBtnExtendTextInfo()
	local var_119_0 = {
		str = L_BASE_FORMATION[13]
	}

	var_119_0.strColor = "FFD102"
	var_119_0.strSize = 24
	var_119_0.strFont = FONT_BUTTON
	var_119_0.visible = false

	return var_119_0
end

function BaseFormationLayer:isShowFetterBtn()
	return true
end

function BaseFormationLayer:isRegisterTeamSkill()
	return true
end

function BaseFormationLayer:isShowHelpBattle()
	return false
end

function BaseFormationLayer:captureScreenCallBack(arg_123_1)
	self.bInit = true

	self:addChild(arg_123_1)
	arg_123_1:setLocalZOrder(var_0_9)
	self:initHeadLayout()
	self:initListView()
	self:initTipsLayout()
	self:initFormationIndexListView()
	self:initBottomLayout()
	self:initSureButton()
	self:initListener()
end

function BaseFormationLayer:sureButtonCallBack()
	self:closeAction()
end

function BaseFormationLayer:initManager()
	return
end

function BaseFormationLayer:extendArrayCallBack()
	return
end

function BaseFormationLayer:updateHelpBattleAlert()
	if require("controller/help_battle/help_battle_manager"):getInstance():checkHelpFormationAlert(self.curFormationIndex) then
		global_add_alert_tag(self.autoHelpBattle, cc.p(self.autoHelpBattle:getContentSize().width + 10, self.autoHelpBattle:getContentSize().height + 10))
	else
		global_remove_alert_tag(self.autoHelpBattle)
	end
end

function BaseFormationLayer:createNewHorcruxLayout(arg_128_1, arg_128_2)
	local var_128_0 = TempWidget:CreateTempLayout(arg_128_1)

	var_128_0:setContentSize(120, 60)
	var_128_0:align(cc.p(0, 0), 0, var_0_16)
	var_128_0:setPosition(6, 0)

	function var_128_0.update()
		local var_129_0 = self:getFormationInfo()

		if not var_129_0 or not var_129_0[self.curFormationIndex] or not var_129_0[self.curFormationIndex][arg_128_2] then
			return
		end

		local var_129_1 = var_129_0[self.curFormationIndex][arg_128_2].fight_girl
		local var_129_2 = 0

		var_128_0:setTouchEnabled(true)
		var_128_0:addTouchEventListener(function(arg_130_0, arg_130_1)
			if arg_130_1 == ccui.TouchEventType.began then
				arg_130_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
					var_129_2 = var_129_2 + 1

					local var_131_0 = self:getFormationInfo()

					if not var_131_0 or not var_131_0[self.curFormationIndex] or not var_131_0[self.curFormationIndex][arg_128_2] then
						return
					end

					local var_131_1 = var_131_0[self.curFormationIndex][arg_128_2].fight_girl

					if not var_131_0[self.curFormationIndex][arg_128_2].fight_girl then
						return
					end

					local level_manager = require("controller.level_manager")

					if not level_manager:isPlayerPassLevel(UNLOCK_HORCRUX) then
						global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, (level_manager:formatSystemUnlockLevel(UNLOCK_HORCRUX))))

						return
					end

					if playermodel.haveServant[var_131_1] then
						LayerManager:pushInLayer("HorcruxDevourLayer", {
							servantId = var_131_1
						})
					end
				end)))
			elseif arg_130_1 == ccui.TouchEventType.canceled then
				arg_130_0:stopAllActions()
			elseif arg_130_1 == ccui.TouchEventType.ended then
				arg_130_0:stopAllActions()

				if var_129_2 == 0 then
					self:showGirlsHorcurxLayout(arg_128_2)
				end

				var_129_2 = 0
			end
		end)

		local var_129_3 = var_128_0:getChildByName("horcurx_bg") or TempWidget:CreateTempImg(var_0_5 .. "horcurx_bg_new.png", var_128_0)

		var_129_3:align(cc.p(0, 0), 0, 10)

		for iter_129_0 = 1, 4 do
			local var_129_4 = var_129_3:getChildByName("horcurxIcon" .. iter_129_0)

			if not var_129_4 then
				var_129_4 = TempWidget:CreateTempImg(var_0_7.locked, var_129_3)

				var_129_4:setName("horcurxIcon" .. iter_129_0)
			end

			var_129_4:align(cc.p(0, 0), 22 + 21 * (iter_129_0 - 1), 12)

			local var_129_5 = var_0_34:getLayerSkillInfo(var_129_1, iter_129_0)
			local var_129_6 = var_0_35:isUnlock(var_129_1, iter_129_0) and require("controller.level_manager"):isPlayerPassLevel(UNLOCK_HORCRUX)

			if var_129_5 then
				var_129_4:loadTexture(var_0_7[item_data[var_129_5.itemid].rarity], var_0_4)
			elseif not var_129_6 then
				var_129_4:loadTexture(var_0_7.locked, var_0_4)
			else
				var_129_4:loadTexture(var_0_7[0], var_0_4)
			end

			local level_manager = require("controller.level_manager")

			if not level_manager:isPlayerPassLevel(UNLOCK_HORCRUX) then
				local var_129_8 = level_manager:formatSystemUnlockLevel(UNLOCK_HORCRUX)

				var_129_4:loadTexture(var_0_7.locked, var_0_4)
			end
		end
	end

	return var_128_0
end

function BaseFormationLayer:showGirlsHorcurxLayout()
	if not self.girlsHorcurxLayout then
		self.girlsHorcurxLayout = ccui.Layout:create()

		self.girlsHorcurxLayout:setContentSize(cc.size(640, 1600))
		self.girlsHorcurxLayout:setAnchorPoint(0.5, 0.5)
		self.girlsHorcurxLayout:setPosition(GameDisplay.cx, GameDisplay.cy)
		self.girlsHorcurxLayout:setTouchEnabled(true)
		self.girlsHorcurxLayout:setLocalZOrder(1000)
		self.girlsHorcurxLayout:setVisible(true)
		self.girlsHorcurxLayout:addTouchEventListener(function(arg_133_0, arg_133_1)
			if arg_133_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.girlsHorcurxLayout:setVisible(false)
		end)
		self:addChild(self.girlsHorcurxLayout)

		local var_132_0 = self.listView:getItems()[2]._childData.girlLayout
		local var_132_1 = self.girlsHorcurxLayout:convertToNodeSpace((var_132_0:getParent():convertToWorldSpace(cc.p(var_132_0:getPosition()))))
		local var_132_2 = TempWidget:CreateTempLayout(self.girlsHorcurxLayout)

		var_132_2:setContentSize(640, var_132_0:size().h)
		var_132_2:align(cc.p(0, 1), 0, var_132_1.y)

		local var_132_3 = TempWidget:CreateTempLayout(self.girlsHorcurxLayout)

		var_132_3:setContentSize(640, 1600 - var_132_1.y)
		var_132_3:align(cc.p(0, 0), 0, var_132_1.y)
		var_132_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_132_3:setCascadeOpacityEnabled(false)
		var_132_3:setBackGroundColorOpacity(190)
		var_132_3:setBackGroundColor(cc.c3b(0, 0, 0))

		local var_132_4 = TempWidget:CreateTempLayout(self.girlsHorcurxLayout)

		var_132_4:setContentSize(640, var_132_1.y - var_132_0:size().h)
		var_132_4:align(cc.p(0, 0), 0, 0)
		var_132_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_132_4:setCascadeOpacityEnabled(false)
		var_132_4:setBackGroundColorOpacity(190)
		var_132_4:setBackGroundColor(cc.c3b(0, 0, 0))
	end

	local var_132_5 = self.girlsHorcurxLayout:getChildByName("horcruxLayout_bg")

	if not var_132_5 then
		var_132_5 = TempWidget:CreateTempImg(var_0_5 .. "horcruxLayout_bg.png", self.girlsHorcurxLayout)

		var_132_5:align(cc.p(0, 0), 0, 470)
		var_132_5:setName("horcruxLayout_bg")
	end

	if not var_132_5:getChildByName("title") then
		local var_132_6 = TempWidget:CreateTempImg(var_0_5 .. "title1.png", var_132_5)

		var_132_6:align(cc.p(0, 0), -10, var_132_5:getContentSize().height - 10)
		var_132_6:setName("title")
	end

	local function var_132_7(arg_134_0, arg_134_1)
		local var_134_0 = not require("controller.level_manager"):isPlayerPassLevel(UNLOCK_HORCRUX)
		local var_134_1 = self:getFormationInfo()

		if not var_134_1 or not var_134_1[self.curFormationIndex] or not var_134_1[self.curFormationIndex][arg_134_1] then
			return
		end

		local var_134_2 = var_134_1[self.curFormationIndex][arg_134_1].fight_girl

		for iter_134_0 = 1, 4 do
			local var_134_3 = arg_134_0:getChildByName("devour_" .. iter_134_0)

			if not var_134_3 then
				var_134_3 = TempWidget:CreateTempLayout(arg_134_0)

				var_134_3:setName("devour_" .. iter_134_0)
			end

			var_134_3:setPosition(0, 0)

			local var_134_4 = var_134_3:getChildByName("horcurxBg")

			if not var_134_4 then
				var_134_4 = TempWidget:CreateTempImg(var_0_5 .. "horcurx_bg1.png", var_134_3)

				var_134_4:setName("horcurxBg")
			end

			if iter_134_0 <= 2 then
				var_134_4:align(cc.p(0, 0), 59 * (iter_134_0 - 1) + 2, 70)
			else
				var_134_4:align(cc.p(0, 0), 59 * (iter_134_0 - 3) + 2, 0)
			end

			local var_134_5 = var_134_4
			local var_134_6 = var_134_4:getChildByName("horcruxIcon")

			if not var_134_6 then
				var_134_6 = ccui.ImageView:create()

				var_134_6:setName("horcruxIcon")
				var_134_5:addChild(var_134_6)
				var_134_6:setPosition(var_134_5:getContentSize().width / 2, var_134_5:getContentSize().height / 2)
			end

			local var_134_7 = var_134_5:getChildByName("null_img")

			if not var_134_7 then
				local var_134_8 = TempWidget:CreateTempImg(var_0_5 .. "null_img.png", var_134_5)

				var_134_8:setScale(0.95)
				var_134_8:align(cc.p(0.5, 0.5), var_134_5:getContentSize().width / 2, var_134_5:getContentSize().height / 2)
				var_134_8:setName("null_img")

				var_134_7 = var_134_8
			end

			var_134_7:setVisible(false)

			local var_134_9 = var_134_5:getChildByName("lock_img")

			if not var_134_9 then
				local var_134_10 = TempWidget:CreateTempImg("EquipLayer/lock_img.png", var_134_5)

				var_134_10:setScale(0.95)
				var_134_10:align(cc.p(0.5, 0.5), var_134_5:getContentSize().width / 2, var_134_5:getContentSize().height / 2)
				var_134_10:setName("lock_img")

				var_134_9 = var_134_10
			end

			var_134_9:hide()

			local var_134_11 = var_134_6:getChildByName("repeatImg")

			if not var_134_11 then
				local var_134_12 = TempWidget:CreateTempImg("EquipLayer/repeat.png", var_134_6)

				var_134_12:center()
				var_134_12:setScale(1.4)
				var_134_12:setName("repeatImg")

				var_134_11 = var_134_12
			end

			var_134_11:hide()
			var_134_6:setScale(0.33)
			var_134_6:setVisible(false)

			local var_134_13 = var_0_34:getLayerSkillInfo(var_134_2, iter_134_0)
			local var_134_14 = var_0_35:isUnlock(var_134_2, iter_134_0) and require("controller.level_manager"):isPlayerPassLevel(UNLOCK_HORCRUX)

			var_134_9:setVisible(not var_134_14)

			if var_134_0 then
				var_134_9:setVisible(true)
			end

			if var_134_13 then
				var_134_6:setVisible(true)
				var_134_6:loadTexture(var_134_13.horcruxPath)

				if var_134_13.disable then
					var_134_11:center()
					var_134_11:show()

					if var_134_14 then
						var_134_11:loadTexture("EquipLayer/repeat.png", var_0_4)
					else
						var_134_11:loadTexture("EquipLayer/hide.png", var_0_4)
					end
				end
			else
				var_134_6:setVisible(false)
				var_134_7:setVisible(true)
			end
		end
	end

	for iter_132_0 = 1, self:getFormationShowGirlNum() do
		local var_132_8 = var_132_5:getChildByName("horcruxLayout_" .. iter_132_0)

		if not var_132_8 then
			var_132_8 = TempWidget:CreateTempLayout(var_132_5)

			var_132_8:setContentSize(110, 130)
			var_132_8:align(cc.p(0, 0), 128 * iter_132_0 - 118, 40)
			var_132_8:_addEvent(function(arg_135_0, arg_135_1)
				if arg_135_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_135_0 = self:getFormationInfo()

				if not var_135_0 or not var_135_0[self.curFormationIndex] or not var_135_0[self.curFormationIndex][iter_132_0] then
					return
				end

				local var_135_1 = var_135_0[self.curFormationIndex][iter_132_0].fight_girl

				if not var_135_0[self.curFormationIndex][iter_132_0].fight_girl then
					return
				end

				local level_manager = require("controller.level_manager")

				if not level_manager:isPlayerPassLevel(UNLOCK_HORCRUX) then
					global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, (level_manager:formatSystemUnlockLevel(UNLOCK_HORCRUX))))

					return
				end

				if playermodel.haveServant[var_135_1] then
					LayerManager:pushInLayer("HorcruxDevourLayer", {
						servantId = var_135_1
					})
				end
			end)
			var_132_8:setName("horcruxLayout" .. iter_132_0)
		end

		var_132_7(var_132_8, iter_132_0)
	end

	self.girlsHorcurxLayout:setVisible(true)
end

return BaseFormationLayer
