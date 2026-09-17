local FormationTestFightLayer = class("FormationTestFightLayer", (require("view.Layer.Formation.BaseFormationLayer")))
local TempWidget = require("view.Sprite.TempWidget")
local horcrux_manager = require("controller.horcrux_manager")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "BaseFormationLayer/"
local role_false_level_manager = require("controller.role_false_level_manager")
local activity_manager = require("controller.activity_manager")
local var_0_7 = 100

function FormationTestFightLayer:ctor()
	FormationTestFightLayer.super.ctor(self)
	self:setAutoAdapt(true)
	self.manager:setCurFormationIndex(1)

	self.girlOffsetX = 3.5
	self.girlOffsetScale = -0.15
	self.curFormationIndex = 1
	self.horcruxSpriteScale = 0.88
end

function FormationTestFightLayer:create(arg_2_1)
	local var_2_0 = FormationTestFightLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function FormationTestFightLayer:initManager()
	self.manager = require("controller.formation.formation_test_fight_manager"):getInstance()
end

function FormationTestFightLayer:init(arg_4_1)
	if FormationTestFightLayer.super.init(self, arg_4_1) then
		self:updateLayer()

		if FormationTestFightLayer.super.init(self, arg_4_1) then
			if CONFIG_TYPE_TEST_FIGHT_EMPTY == self.configType then
				self.selectGirlType = SELECT_GIRL_TEST_FIGHT_EMPTY
			elseif CONFIG_TYPE_TEST_FIGHT_PLAYER == self.configType then
				self.selectGirlType = SELECT_GIRL_TEST_FIGHT_PLAYER
			end

			self.manager:setConfigType(self.configType)

			return true
		end

		return true
	end

	return false
end

function FormationTestFightLayer:onEnter()
	FormationTestFightLayer.super.onEnter(self)
	self:openAction()
	activity_manager:registerEventListener("FormationTestFightLayer", activity_manager.activityEventId.CHANGE_TEST_E_FIGHT_ARRAY_SUCCESS, function(arg_6_0)
		self:updateGirl()
	end)
	activity_manager:registerEventListener("FormationTestFightLayer", activity_manager.activityEventId.CHANGE_TEST_P_FIGHT_ARRAY_SUCCESS, function(arg_7_0)
		self:updateGirl()
	end)
end

function FormationTestFightLayer:onExit()
	FormationTestFightLayer.super.onExit(self)

	if self.configexitCallback then
		self.configexitCallback()
	end

	activity_manager:releaseEventListenerByName("FormationTestFightLayer")
end

function FormationTestFightLayer:initListView()
	local level_manager = require("controller.level_manager")
	local var_9_1 = TempWidget:CreateTempListView()

	var_9_1:setDirection(ccui.ListViewDirection.horizontal)
	var_9_1:setContentSize(cc.size(self.formationLayout:size().w, self.listViewHeight))
	self.formationLayout:pushBackCustomItem(var_9_1)

	self.listView = var_9_1

	for iter_9_0 = 1, self:getFormationShowGirlNum() do
		local var_9_2 = TempWidget:CreateTempLayout()

		var_9_2:setContentSize(cc.size(var_9_1:size().w / self:getFormationShowGirlNum(), self.listViewHeight))

		var_9_2._childData = {}

		local var_9_3 = TempWidget:CreateTempLayout(var_9_2)

		var_9_3:setContentSize(cc.size(var_9_2:size().w, var_9_2:size().h / 3 * 2))
		var_9_3:align(cc.p(0, 1), 0, var_9_2:size().h)
		var_9_3:_addEvent(function()
			self:selectGirl(iter_9_0)
		end)

		var_9_2._childData.girlLayout = var_9_3

		local var_9_4 = TempWidget:CreateTempImg(var_0_4 .. "role_null_bg.png", var_9_3)

		var_9_4:setScaleX(1.1)
		var_9_4:align(cc.p(0.5, 0), var_9_3:size().w / 2, 0)
		var_9_4:setName("girlLayout" .. iter_9_0)

		local var_9_5 = TempWidget:CreateTempImg(var_0_4 .. "lock_girl.png", var_9_3)

		var_9_5:align(cc.p(0.5, 0), var_9_3:size().w / 2, 0)
		var_9_5:setScaleX(1.1)
		var_9_5:hide()

		var_9_2._childData.lockGirlBg = var_9_5

		local var_9_6 = TempWidget:CreateTempLabel(L_TEAM_TIPS.Lock, FONT_DES, 20, var_9_5)

		var_9_6:setScaleX(0.9090909090909091)
		var_9_6:align(cc.p(0.5, 0.5), var_9_3:size().w / 2 - 8, var_9_3:size().h / 2 - 55)
		var_9_6:setColor(cc.c3b(175, 191, 195))

		local var_9_7 = TempWidget:CreateTempLabel(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_SOUL_UNLOCK[iter_9_0]), FONT_DES, 20, var_9_5)

		var_9_7:setScaleX(0.9090909090909091)
		var_9_7:align(cc.p(0.5, 0.5), var_9_3:size().w / 2 - 8, var_9_3:size().h / 2 - 85)
		var_9_7:setColor(cc.c3b(255, 211, 115))

		local var_9_8 = TempWidget:CreateTempLayout(var_9_2)

		var_9_8:setContentSize(cc.size(var_9_2:size().w, 120))
		var_9_8:setClippingEnabled(true)

		var_9_2._childData.assistGirlLayout = var_9_8

		local var_9_9 = TempWidget:CreateTempImg(var_0_4 .. "horcrux_bg_left.png", var_9_8)

		var_9_9:setScale(self.horcruxSpriteScale)
		var_9_9:align(cc.p(0, 0), 5, 0)

		local var_9_10 = var_9_9:size().h

		var_9_2._childData.partsT = {}

		for iter_9_1 = 1, self.partsNum do
			local var_9_11 = TempWidget:CreateTempImg(var_0_4 .. "horcrux_bg_add_ing.png", var_9_9)

			var_9_11:align(cc.p(0.5, 0.5), var_9_9:size().w / 2, var_9_10 - var_9_10 / 3 / 2 - (iter_9_1 - 1) * var_9_10 / 3)

			var_9_11._initPos = var_9_11:pos()
			var_9_2._childData.partsT[iter_9_1] = var_9_11
		end

		local var_9_12 = TempWidget:CreateTempImg(var_0_4 .. "assistGirl_null_bg.png", var_9_8)

		var_9_12:setScale(self.horcruxSpriteScale)
		var_9_12:align(cc.p(1, 0), var_9_8:size().w, 0)
		var_9_12:setName("horcruxLayout" .. iter_9_0)

		local var_9_13 = TempWidget:CreateTempLayout(var_9_12)

		var_9_13:setContentSize(var_9_12:size())
		var_9_13:_addEvent(function()
			self:selectHorcrux(iter_9_0)
		end)

		local var_9_14 = TempWidget:CreateTempImg(var_0_4 .. "lock_horcrux.png", var_9_8)

		var_9_14:align(cc.p(0.5, 0), var_9_8:size().w / 2, 0)
		var_9_14:setScale(1.2)
		var_9_14:hide()

		var_9_2._childData.lockHorcruxBg = var_9_14

		local var_9_15 = TempWidget:CreateTempLabel(L_TEAM_TIPS.Lock, FONT_DES, 20, var_9_14)

		var_9_15:setScale(0.8333333333333334)
		var_9_15:align(cc.p(0.5, 0.5), var_9_14:size().w / 2 + 3, var_9_14:size().h / 2 + 12)
		var_9_15:setColor(cc.c3b(175, 191, 195))

		local var_9_16 = TempWidget:CreateTempLabel(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_HORCRUX_UNLOCK[iter_9_0]), FONT_DES, 20, var_9_14)

		var_9_16:setScale(0.8333333333333334)
		var_9_16:align(cc.p(0.5, 0.5), var_9_14:size().w / 2 + 3, var_9_14:size().h / 2 - 12)
		var_9_16:setColor(cc.c3b(255, 211, 115))
		var_9_1:pushBackCustomItem(var_9_2)
	end

	local var_9_17 = self:getFormationInfo()

	if var_9_17 and var_9_17[self.curFormationIndex] then
		local var_9_18 = var_9_1:getItems()

		for iter_9_2 = 1, self:getFormationShowGirlNum() do
			if var_9_17[self.curFormationIndex][iter_9_2] then
				if self:selectGirlConditionScreening(iter_9_2) then
					if var_9_17[self.curFormationIndex][iter_9_2].fight_girl then
						local var_9_21 = self:createGirlSprite(var_9_17[self.curFormationIndex][iter_9_2].fight_girl, var_9_17[self.curFormationIndex][iter_9_2].modelid)

						var_9_21:setAnchorPoint(cc.p(0.5, 0))
						var_9_21:setPosition(cc.p(var_9_18[iter_9_2]._childData.girlLayout:size().w / 2 + self.girlOffsetX, 0))
						var_9_21:setScale(var_9_18[iter_9_2]._childData.girlLayout:size().w / var_9_21:getContentSize().width + self.girlOffsetScale)
						var_9_18[iter_9_2]._childData.girlLayout:addChild(var_9_21)

						var_9_18[iter_9_2]._childData.girl = var_9_21
					end
				else
					var_9_18[iter_9_2]._childData.lockGirlBg:show()
				end
			end
		end
	end

	self:updateAllParts()
end

function FormationTestFightLayer:initHeadLayout()
	if not self.headLayout then
		local var_12_0 = TempWidget:CreateTempLayout()

		var_12_0:setContentSize(cc.size(self.formationLayout:size().w, var_0_7))

		self.headLayout = var_12_0

		self.formationLayout:pushBackCustomItem(self.headLayout)
	end

	self.headLayout:removeAllChildren()

	self.headLayout._childData = {}

	local var_12_1 = TempWidget:CreateTempImg(var_0_4 .. "title.png", self.headLayout)

	var_12_1:align(cc.p(0, 0.5), 10, self.headLayout:size().h / 2)

	local var_12_3 = TempWidget:CreateTempLabel((CONFIG_TYPE_TEST_FIGHT_PLAYER == self.configType or nil) and "选择我方队伍学员", FONT_NAME, 24, var_12_1)

	var_12_3:_setColor("7BF2F9")
	var_12_3:align(cc.p(0, 0), 10, 0)

	self.headLayout._childData.teamFightCapacity = var_12_3

	local var_12_4 = TempWidget:CreateTempImg(var_0_4 .. "team_skill_bg.png", self.headLayout)

	var_12_4:align(cc.p(1, 0), self.headLayout:size().w - 10, -20)

	self.headLayout._childData.teamSkillBg = var_12_4

	local var_12_5 = TempWidget:CreateTempImg(var_0_4 .. "team_skill_tag.png", var_12_4)

	var_12_5:align(cc.p(1, 0.5), var_12_4:size().w - 10, var_12_4:size().h / 2)

	self.headLayout._childData.tagImg = var_12_5

	local var_12_6 = TempWidget:CreateTempLabel("全队天赋相同时获得加成", FONT_NAME, 20, var_12_4)

	var_12_6:align(cc.p(0, 0.5), 10, var_12_4:size().h / 2)

	self.headLayout._childData.defaultText = var_12_6

	local var_12_7 = TempWidget:CreateTempLayout(var_12_4)

	var_12_7:setContentSize(var_12_4:size())

	self.headLayout._childData.showTeamSkillLayout = var_12_7

	local var_12_8 = TempWidget:CreateTempImg(nil, var_12_7)

	var_12_8:align(cc.p(0.5, 0.5), 20, var_12_7:size().h / 2)
	var_12_8:setScale(0.7)

	self.headLayout._childData.iconBackImg = var_12_8

	local var_12_9 = TempWidget:CreateTempImg(nil, var_12_7)

	var_12_9:align(cc.p(0.5, 0.5), var_12_8:pos().x, var_12_7:size().h / 2)
	var_12_9:setScale(0.7)

	self.headLayout._childData.iconImg = var_12_9

	local var_12_10 = TempWidget:CreateTempLayout(var_12_7)

	var_12_10:setContentSize(var_12_7:size())

	self.headLayout._childData.teamSkillTextLayout = var_12_10

	self:updateShowTeamSkillLayout()
end

function FormationTestFightLayer:updateGirlSuccess(arg_13_1)
	if self.bInit then
		local var_13_0 = self.listView:getItems()

		if var_13_0[arg_13_1] then
			local var_13_1 = self:getFormationInfo()
			local var_13_2 = var_13_0[arg_13_1]._childData.girl

			if var_13_1 and var_13_1[self.curFormationIndex] then
				local var_13_3 = var_13_1[self.curFormationIndex][arg_13_1] and var_13_1[self.curFormationIndex][arg_13_1].fight_girl
				local var_13_4 = var_13_1[self.curFormationIndex][arg_13_1] and var_13_1[self.curFormationIndex][arg_13_1].modelid

				if var_13_3 then
					if var_13_2 then
						var_13_2:update({
							rank = 5,
							contract = 5,
							level = 300,
							servantId = tonumber(var_13_3),
							modelid = var_13_4
						})
						self:resetGirlSpriteListener(var_13_2, var_13_3)
					else
						var_13_2 = self:createGirlSprite(var_13_3)

						var_13_2:setAnchorPoint(cc.p(0.5, 0))
						var_13_2:setPosition(cc.p(var_13_0[arg_13_1]._childData.girlLayout:size().w / 2 + self.girlOffsetX, 0))
						var_13_2:setScale(var_13_0[arg_13_1]._childData.girlLayout:size().w / var_13_2:getContentSize().width + self.girlOffsetScale)
						var_13_0[arg_13_1]._childData.girlLayout:addChild(var_13_2)

						var_13_0[arg_13_1]._childData.girl = var_13_2
					end

					if role_false_level_manager:isRoleFalseLevelMember(var_13_3, SELECT_GIRL_TEST_FIGHT_EMPTY) then
						local var_13_5, var_13_6, var_13_7 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_13_3, SELECT_GIRL_TEST_FIGHT_EMPTY)

						var_13_2:updateByFalseLevel(var_13_3, var_13_5, var_13_6)
					else
						var_13_2:stopFalseLevelAni()
					end
				elseif var_13_2 then
					var_13_2:removeFromParent()

					var_13_0[arg_13_1]._childData.girl = nil
				end

				self:updateFightCapacityText(arg_13_1)
				self:updateTeamFightCapacity()
				self:updateShowTeamSkillLayout()
				self:updateParts(arg_13_1)
			end
		end
	end
end

function FormationTestFightLayer:updateParts(arg_14_1)
	if self.bInit then
		local component_effect_data = require("data.component_effect_data")
		local item_data = require("data.item_data")
		local var_14_2 = self.listView:getItems()

		if var_14_2[arg_14_1] then
			local var_14_3 = var_14_2[arg_14_1]._childData.partsT
			local playermodel = require("model.playermodel")
			local var_14_5 = self:getFormationInfo()
			local var_14_6 = var_14_5[self.curFormationIndex][arg_14_1] and var_14_5[self.curFormationIndex][arg_14_1].fight_girl

			if not var_14_6 then
				for iter_14_0 = 1, #var_14_3 do
					var_14_3[iter_14_0]:setScale(1)
					var_14_3[iter_14_0]:loadTexture(var_0_4 .. "horcrux_bg_add_ing.png", var_0_3)
					var_14_3[iter_14_0]:setPositionY(var_14_3[iter_14_0]._initPos.y)
				end
			else
				local var_14_7 = require("controller.component_manager"):createMaxComponentData(var_14_6)

				for iter_14_1 = 1, #var_14_3 do
					var_14_3[iter_14_1]:setPositionY(var_14_3[iter_14_1]._initPos.y)
				end

				for iter_14_2 = 1, self.partsNum do
					local var_14_8 = item_data[var_14_7[iter_14_2].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[var_14_7[iter_14_2].effect].image_id .. "_" .. item_data[var_14_7[iter_14_2].itemid].main_attr .. "_" .. iter_14_2 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[var_14_7[iter_14_2].effect].image_id .. "_" .. var_14_7[iter_14_2].component_attr.attr1 .. "_" .. iter_14_2 .. ".png"

					var_14_3[iter_14_2]:setScale(0.6)
					var_14_3[iter_14_2]:loadTexture(var_14_8)

					local var_14_9 = var_14_3[iter_14_2]._initPos.y
					local var_14_10 = 18

					if var_14_7[iter_14_2].effect then
						var_14_10 = 25
					end

					if iter_14_2 == 1 then
						var_14_9 = var_14_9 - var_14_10
					elseif iter_14_2 == 3 then
						var_14_9 = var_14_9 + var_14_10
					end

					var_14_3[iter_14_2]:setPositionY(var_14_9)
				end
			end
		end
	end
end

function FormationTestFightLayer:resetHorcruxSpriteListener(arg_15_1, arg_15_2)
	arg_15_1._childData.layout:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 == ccui.TouchEventType.ended then
			local var_16_0 = self:getFormationInfo()

			if var_16_0 and var_16_0[self.curFormationIndex] then
				for iter_16_0, iter_16_1 in pairs(var_16_0[self.curFormationIndex]) do
					if iter_16_1.assist_girl == arg_15_2 then
						self:selectHorcrux(iter_16_1.pos)

						break
					end
				end
			end
		end
	end)
end

function FormationTestFightLayer:createGirlSprite(arg_17_1, arg_17_2)
	arg_17_1 = tonumber(arg_17_1)

	if arg_17_1 then
		local var_17_0 = GirlSprite:create({
			initType = self:getGirlSpriteType(),
			isHpInherit = self.is_hp_inherit
		})

		var_17_0:getChildByName("testImg"):setVisible(true)
		var_17_0:update({
			rank = 5,
			contract = 5,
			level = 300,
			servantId = arg_17_1,
			modelid = arg_17_2
		})
		var_17_0:setAnchorPoint(cc.p(0, 0))
		var_17_0:setPosition(cc.p(0, 0))

		var_17_0._childData = {}

		local var_17_1 = TempWidget:CreateTempLayout(var_17_0)

		var_17_1:setContentSize((var_17_0:getContentSize()))
		var_17_1:setTouchEnabled(true)

		var_17_0._childData.layout = var_17_1

		self:resetGirlSpriteListener(var_17_0, arg_17_1)

		if role_false_level_manager:isRoleFalseLevelMember(arg_17_1, SELECT_GIRL_TEST_FIGHT_EMPTY) then
			local var_17_2, var_17_3, var_17_4 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(arg_17_1, SELECT_GIRL_TEST_FIGHT_EMPTY)

			var_17_0:updateByFalseLevel(arg_17_1, var_17_2, var_17_3)
		else
			var_17_0:stopFalseLevelAni()
		end

		return var_17_0
	end

	return nil
end

function FormationTestFightLayer:sureButtonCallBack()
	LayerManager:removePopLayer(self.__queueindex)

	if FightManager.refreshFightToType(FIGHTTYPE_STAKE_PVP) then
		LayerManager:switchShowLayer("FightLayer", {
			is_hide_topcost = true,
			is_hide_listbutton = true
		})
	end
end

function FormationTestFightLayer:isShowAutoFormationBtn()
	return false
end

function FormationTestFightLayer:getGirlSpriteType()
	return "enemyFormationStyle"
end

function FormationTestFightLayer:getHorcruxSpriteType()
	return "enemyArrayMemberStyle"
end

function FormationTestFightLayer:getFightCapacitySum()
	return 0
end

function FormationTestFightLayer:getGirlFightCapacitySum()
	return 0
end

function FormationTestFightLayer:updateTeamFightCapacity()
	self.headLayout._childData.teamFightCapacity:hide()
end

function FormationTestFightLayer:updateFightCapacityText(arg_25_1)
	return
end

function FormationTestFightLayer:selectHorcrux(arg_26_1)
	return
end

function FormationTestFightLayer:getSelectGirlConfig(arg_27_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		formationIndex = self.curFormationIndex,
		sureCallBack = function(arg_28_0)
			return
		end
	}
end

function FormationTestFightLayer:selectGirl(arg_29_1)
	if self:selectGirlConditionScreening(arg_29_1, {
		bAutoTips = true
	}) then
		local var_29_0 = self:getFormationInfo()

		if var_29_0 and var_29_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_29_1)))
		end
	end
end

return FormationTestFightLayer
