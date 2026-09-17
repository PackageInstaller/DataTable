local FormationSpecialExploreLayer = class("FormationSpecialExploreLayer", (require("view.Layer.Formation.FormationExploreLayer")))
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = "BaseFormationLayer/"
local role_false_level_manager = require("controller.role_false_level_manager")
local var_0_6 = global_trans_number

function FormationSpecialExploreLayer:ctor()
	FormationSpecialExploreLayer.super.ctor(self)
end

function FormationSpecialExploreLayer:create(arg_2_1)
	local var_2_0 = FormationSpecialExploreLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function FormationSpecialExploreLayer:initManager()
	self.manager = require("controller.formation.formation_special_explore_manager"):getInstance()
end

function FormationSpecialExploreLayer:sureButtonCallBack()
	local array_manager = require("controller.array_manager")
	local audio_manager = require("controller.audio_manager")

	if CONFIG_TYPE_EXPLORE == self.configType then
		local var_4_2 = true

		for iter_4_0, iter_4_1 in pairs(self.specialArray) do
			if iter_4_1.npcid or iter_4_1.girlInfo then
				var_4_2 = false

				break
			end
		end

		if not var_4_2 then
			if self.configCallback then
				self.configCallback(self.specialArray)
			end

			self:closeAction()
		else
			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Team_Nil, RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		end

		if setBrightCallback then
			setBrightCallback()
		end
	elseif CONFIG_TYPE_EXPLORE_HP_INHERIT == self.configType then
		local var_4_3 = true

		for iter_4_2, iter_4_3 in pairs(self.specialArray) do
			if iter_4_3.npcid or iter_4_3.girlInfo then
				var_4_3 = false

				break
			end
		end

		if not var_4_3 then
			if self.configCallback then
				self.configCallback(self.specialArray)
			end

			self:closeAction()
		else
			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Team_Nil, RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end
end

function FormationSpecialExploreLayer:init(arg_5_1)
	self.fixArray = arg_5_1.fix_array

	self:initSpecialArray()

	if FormationSpecialExploreLayer.super.init(self, arg_5_1) then
		if CONFIG_TYPE_EXPLORE == self.configType then
			self.selectGirlType = SELECT_GIRL_SPECIAL
			self.selectHorcruxType = SELECT_HORCRUX_SPECIAL
		elseif CONFIG_TYPE_EXPLORE_HP_INHERIT == self.configType then
			self.selectGirlType = SELECT_GIRL_SPECIAL
			self.selectHorcruxType = SELECT_HORCRUX_SPECIAL
		end

		return true
	end

	return true
end

function FormationSpecialExploreLayer:initListView()
	local var_6_0 = TempWidget:CreateTempListView()

	var_6_0:setDirection(ccui.ListViewDirection.horizontal)
	var_6_0:setContentSize(cc.size(self.formationLayout:size().w, self.listViewHeight))
	self.formationLayout:pushBackCustomItem(var_6_0)

	self.listView = var_6_0

	for iter_6_0 = 1, self:getFormationShowGirlNum() do
		local var_6_1 = TempWidget:CreateTempLayout()

		var_6_1:setContentSize(cc.size(GameDisplay.width / self:getFormationShowGirlNum(), self.listViewHeight))

		var_6_1._childData = {}

		local var_6_2 = TempWidget:CreateTempLayout(var_6_1)

		var_6_2:setContentSize(cc.size(var_6_1:size().w, var_6_1:size().h / 3 * 2))
		var_6_2:align(cc.p(0, 1), 0, var_6_1:size().h)
		var_6_2:_addEvent(function()
			if (self:getFormationInfo()[1] or {})[iter_6_0].pos_lock and not self.is_hp_inherit then
				global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Girls)
			else
				self:selectGirl(iter_6_0)
			end
		end)

		var_6_1._childData.girlLayout = var_6_2

		local var_6_3 = TempWidget:CreateTempImg(var_0_3 .. "role_null_bg.png", var_6_2)

		var_6_3:setScaleX(1.1)
		var_6_3:align(cc.p(0.5, 0), var_6_2:size().w / 2, 0)

		local var_6_4 = TempWidget:CreateTempLayout(var_6_1)

		var_6_4:setContentSize(cc.size(var_6_1:size().w, var_6_1:size().h / 3 * 1))
		var_6_4:_addEvent(function()
			if (self:getFormationInfo()[1] or {})[iter_6_0].pos_lock and not self.is_hp_inherit then
				global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Horcrux)
			else
				self:selectWeapon(iter_6_0)
			end
		end)

		var_6_1._childData.weaponLayout = var_6_4

		local var_6_5 = TempWidget:CreateTempImg(var_0_3 .. "horcrux_bg_left.png", var_6_4)

		var_6_5:setScale(self.horcruxSpriteScale)
		var_6_5:align(cc.p(0, 0), 5, 0)

		local var_6_6 = TempWidget:CreateTempLayout(var_6_5)

		var_6_6:setContentSize(var_6_5:size())
		var_6_6:_addEvent(function()
			self:selectParts(iter_6_0)
		end)

		local var_6_7 = var_6_5:size().h

		var_6_1._childData.partsT = {}

		for iter_6_1 = 1, self.partsNum do
			local var_6_8 = TempWidget:CreateTempImg(var_0_3 .. "horcrux_bg_add_ing.png", var_6_5)

			var_6_8:align(cc.p(0.5, 0.5), var_6_5:size().w / 2, var_6_7 - var_6_7 / 3 / 2 - (iter_6_1 - 1) * var_6_7 / 3)

			var_6_8._initPos = var_6_8:pos()
			var_6_1._childData.partsT[iter_6_1] = var_6_8
		end

		local var_6_9 = TempWidget:CreateTempImg(var_0_3 .. "weapon_null_bg.png", var_6_4)

		var_6_9:setScale(self.horcruxSpriteScale)
		var_6_9:align(cc.p(1, 0), var_6_2:size().w, 0)

		local var_6_10 = TempWidget:CreateTempLayout(var_6_9)

		var_6_10:setContentSize(var_6_9:size())
		var_6_10:_addEvent(function()
			self:selectWeapon(iter_6_0)
		end)
		var_6_0:pushBackCustomItem(var_6_1)
	end

	local var_6_11 = self:getFormationInfo()

	if var_6_11 and var_6_11[self.curFormationIndex] then
		local var_6_12 = var_6_0:getItems()

		for iter_6_2 = 1, self:getFormationShowGirlNum() do
			if var_6_11[self.curFormationIndex][iter_6_2] then
				if var_6_11[self.curFormationIndex][iter_6_2].girlInfo then
					local var_6_14 = self:createGirlSprite(var_6_11[self.curFormationIndex][iter_6_2])

					var_6_14:setAnchorPoint(cc.p(0.5, 0))
					var_6_14:setPosition(cc.p(var_6_12[iter_6_2]._childData.girlLayout:size().w / 2 + self.girlOffsetX, 0))
					var_6_14:setScale(var_6_12[iter_6_2]._childData.girlLayout:size().w / var_6_14:getContentSize().width + self.girlOffsetScale)
					var_6_12[iter_6_2]._childData.girlLayout:addChild(var_6_14)

					var_6_12[iter_6_2]._childData.girl = var_6_14
				end

				local var_6_15 = TempWidget:CreateTempImg(var_0_3 .. "pos_img.png", var_6_12[iter_6_2]._childData.girlLayout)

				var_6_15:align(cc.p(0, 1), 5, var_6_12[iter_6_2]._childData.girlLayout:size().h - 8)

				local var_6_16 = TempWidget:CreateTempLabel(iter_6_2, FONT_NAME, 18, var_6_12[iter_6_2]._childData.girlLayout)

				var_6_16:align(cc.p(0, 1), 15, var_6_15:pos().y)
				var_6_16:_setColor("E3F3F9")

				var_6_12[iter_6_2]._childData.posText = var_6_16

				local var_6_17 = TempWidget:CreateTempLabel(self:getGirlFightCapacitySum(iter_6_2), FONT_NAME, 16, var_6_12[iter_6_2]._childData.girlLayout)

				var_6_17:_setColor("E3F3F9")
				var_6_17:align(cc.p(0, 1), 60, var_6_16:pos().y)

				var_6_12[iter_6_2]._childData.fightCapacityText = var_6_17
			end
		end
	end

	self:updateAllParts()
end

function FormationSpecialExploreLayer:createGirlSprite(arg_11_1)
	if arg_11_1 then
		local var_11_0 = GirlSprite:create({
			initType = self:getGirlSpriteType(),
			isHpInherit = self.is_hp_inherit
		})

		var_11_0._childData = {}

		local var_11_1 = TempWidget:CreateTempLayout(var_11_0)

		var_11_1:setContentSize((var_11_0:getContentSize()))
		var_11_1:setTouchEnabled(true)

		var_11_0._childData.layout = var_11_1

		self:resetGirlSpriteListener(var_11_0, arg_11_1)

		if arg_11_1.girlInfo then
			var_11_0:update(arg_11_1.girlInfo, arg_11_1.npcid)
			var_11_0:setAnchorPoint(cc.p(0, 0))
			var_11_0:setPosition(cc.p(0, 0))

			if not arg_11_1.npcid and role_false_level_manager:isRoleFalseLevelMember(arg_11_1.girlInfo.servantId, FIGHTTYPE_EXPLORE) then
				local var_11_2, var_11_3, var_11_4 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(arg_11_1.girlInfo.servantId, FIGHTTYPE_EXPLORE)

				var_11_0:updateByFalseLevel(arg_11_1.girlInfo.servantId, var_11_2, var_11_3)
			else
				var_11_0:stopFalseLevelAni()
			end
		end

		return var_11_0
	end

	return nil
end

function FormationSpecialExploreLayer:resetGirlSpriteListener(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2.girlInfo.servantId

	if arg_12_2.npcid then
		arg_12_1._childData.layout:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Forbid_Change_Role)
		end)
	else
		local var_12_1 = 0

		arg_12_1._childData.layout:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 == ccui.TouchEventType.began then
				arg_12_1:imgScaleTo(1.1, 0.1)
				arg_14_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					arg_12_1:startPressBar(function()
						if var_12_0 then
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = 6,
								cursoul = var_12_0
							})

							var_12_1 = 0.2
						else
							var_12_1 = 0
						end

						arg_12_1:endPressBar()
					end, function(arg_17_0)
						var_12_1 = var_12_1 + arg_17_0
					end)
				end)))
			elseif arg_14_1 == ccui.TouchEventType.canceled then
				arg_12_1:imgScaleTo(1, 0.1)
				arg_14_0:stopAllActions()
				arg_12_1:endPressBar()
			elseif arg_14_1 == ccui.TouchEventType.ended then
				arg_14_0:stopAllActions()

				if var_12_1 == 0 then
					self:selectGirl(arg_12_2.pos)
				end

				var_12_1 = 0

				arg_12_1:endPressBar()
				arg_12_1:imgScaleTo(1, 0.1)
			end
		end)
	end
end

function FormationSpecialExploreLayer:resetHorcruxSpriteListener(arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2.horcruxInfo.itemid

	if arg_18_2.npcid then
		arg_18_1._childData.layout:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Pos_Lock_Horcrux)
		end)
	else
		local var_18_1 = 0

		arg_18_1._childData.layout:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 == ccui.TouchEventType.began then
				arg_18_1:imgScaleTo(1.1, 0.1)
				arg_20_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					arg_18_1:startPressBar(function()
						if var_18_0 then
							LayerManager:pushInLayer("HorcruxInfoLayer", var_18_0, nil, nil)

							var_18_1 = 0.2
						else
							var_18_1 = 0
						end

						arg_18_1:endPressBar()
					end, function(arg_23_0)
						var_18_1 = var_18_1 + arg_23_0
					end)
				end)))
			elseif arg_20_1 == ccui.TouchEventType.canceled then
				arg_18_1:imgScaleTo(1, 0.1)
				arg_20_0:stopAllActions()
				arg_18_1:endPressBar()
			elseif arg_20_1 == ccui.TouchEventType.ended then
				arg_20_0:stopAllActions()

				if var_18_1 == 0 then
					local var_20_0 = self:getFormationInfo()

					if var_20_0 and var_20_0[self.curFormationIndex] then
						for iter_20_0, iter_20_1 in pairs(var_20_0[self.curFormationIndex]) do
							if iter_20_1.horcruxInfo and iter_20_1.horcruxInfo.itemid and iter_20_1.horcruxInfo.itemid == var_18_0 then
								self:selectWeapon(iter_20_1.pos)

								break
							end
						end
					end
				end

				var_18_1 = 0

				arg_18_1:endPressBar()
				arg_18_1:imgScaleTo(1, 0.1)
			end
		end)
	end
end

function FormationSpecialExploreLayer:updateGirlSuccess(arg_24_1)
	if self.bInit then
		local var_24_0 = self.listView:getItems()

		if var_24_0[arg_24_1] then
			local var_24_1 = self:getFormationInfo()
			local var_24_2 = var_24_0[arg_24_1]._childData.girl

			if var_24_1 and var_24_1[self.curFormationIndex] then
				local var_24_3

				if var_24_1[self.curFormationIndex][arg_24_1].girlInfo and var_24_1[self.curFormationIndex][arg_24_1].girlInfo.servantId then
					var_24_3 = var_24_1[self.curFormationIndex][arg_24_1].girlInfo.servantId
				end

				if var_24_3 then
					if var_24_2 then
						var_24_2:update(var_24_1[self.curFormationIndex][arg_24_1].girlInfo, var_24_1[self.curFormationIndex][arg_24_1].npcid)
						self:resetGirlSpriteListener(var_24_2, var_24_1[self.curFormationIndex][arg_24_1])
					else
						var_24_2 = self:createGirlSprite(var_24_1[self.curFormationIndex][arg_24_1])

						var_24_2:setAnchorPoint(cc.p(0.5, 0))
						var_24_2:setPosition(cc.p(var_24_0[arg_24_1]._childData.girlLayout:size().w / 2 + self.girlOffsetX, 0))
						var_24_2:setScale(var_24_0[arg_24_1]._childData.girlLayout:size().w / var_24_2:getContentSize().width + self.girlOffsetScale)
						var_24_0[arg_24_1]._childData.girlLayout:addChild(var_24_2)

						var_24_0[arg_24_1]._childData.girl = var_24_2
					end

					if not var_24_1[self.curFormationIndex][arg_24_1].npcid and role_false_level_manager:isRoleFalseLevelMember(var_24_3, FIGHTTYPE_EXPLORE) then
						local var_24_4, var_24_5, var_24_6 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_24_3, FIGHTTYPE_EXPLORE)

						var_24_2:updateByFalseLevel(var_24_3, var_24_4, var_24_5)
					else
						var_24_2:stopFalseLevelAni()
					end
				elseif var_24_2 then
					var_24_2:removeFromParent()

					var_24_0[arg_24_1]._childData.girl = nil
				end

				self:updateFightCapacityText(arg_24_1)
				self:updateTeamFightCapacity()
				self:updateShowTeamSkillLayout()
				self:updateParts(arg_24_1)
			end
		end
	end
end

function FormationSpecialExploreLayer:initSpecialArray(arg_25_1)
	local npc_fightconfig_data = require("data.npc_fightconfig_data")
	local explore_manager = require("controller.explore_manager")
	local core_manager = require("controller.core_manager")
	local playermodel = require("model.playermodel")
	local horcrux_manager = require("controller.horcrux_manager")

	self.specialArray = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_1 or self.fixArray) do
		local var_25_5 = npc_fightconfig_data[iter_25_1.npcid]
		local var_25_6

		if npc_fightconfig_data[iter_25_1.npcid] then
			if explore_manager:getHpInherit(iter_25_1.npcid) <= 0 then
				self.specialArray[iter_25_0] = {
					pos_lock = iter_25_1.pos_lock and true or false
				}
			else
				var_25_6 = 0 + 1

				local var_25_7 = {
					pos_lock = true,
					npcid = iter_25_1.npcid
				}
				local var_25_8 = {
					npcsoulid = var_25_5.npcsoulid,
					servantId = var_25_5.servantid
				}

				var_25_8.servantskin = var_25_5.servantskin or -1
				var_25_8.rank = var_25_5.rank or 0

				if var_25_5.level then
					var_25_8.level = var_25_5.rank * 100 + var_25_5.level or 1
				end

				var_25_8.contract = var_25_5.contract
				var_25_7.girlInfo = var_25_8
				var_25_7.horcruxInfo = var_25_5.horcrux
				var_25_7.isMainCharacter = not not iter_25_1.isMainCharacter
				self.specialArray[iter_25_0] = var_25_7
			end
		else
			self.specialArray[iter_25_0] = {
				pos_lock = iter_25_1.pos_lock and true or false
			}

			if not iter_25_1.fight_girl then
				self.specialArray[iter_25_0].girlInfo = nil
				self.specialArray[iter_25_0].horcruxInfo = nil
			else
				self.specialArray[iter_25_0].girlInfo = self.specialArray[iter_25_0].girlInfo or {}
				self.specialArray[iter_25_0].girlInfo.servantId = iter_25_1.fight_girl
				self.specialArray[iter_25_0].girlInfo.rank = core_manager:getServantCoreRank(iter_25_1.fight_girl)
				self.specialArray[iter_25_0].girlInfo.level = playermodel.cores[iter_25_1.fight_girl].extra
				self.specialArray[iter_25_0].girlInfo.contract = playermodel.soulContract[iter_25_1.fight_girl]
				self.specialArray[iter_25_0].girlInfo.servantskin = playermodel.servantUsedskin[iter_25_1.fight_girl]
				self.specialArray[iter_25_0].girlInfo.soulOC = playermodel.soulOverClock[iter_25_1.fight_girl] or 0

				if iter_25_1.assist_girl then
					self.specialArray[iter_25_0].horcruxInfo = self.specialArray[iter_25_0].horcruxInfo or {}
					self.specialArray[iter_25_0].horcruxInfo.entityid = iter_25_1.assist_girl
					self.specialArray[iter_25_0].horcruxInfo.itemid = playermodel.items[iter_25_1.assist_girl].itemid
					self.specialArray[iter_25_0].horcruxInfo.star = horcrux_manager:getHorcruxStarLevel(iter_25_1.assist_girl)
					self.specialArray[iter_25_0].horcruxInfo.hlv = horcrux_manager:getHorcruxHLV(iter_25_1.assist_girl)
					self.specialArray[iter_25_0].horcruxInfo.hclass = horcrux_manager:getHorcruxHClass(iter_25_1.assist_girl)
					self.specialArray[iter_25_0].horcruxInfo.hbreak = horcrux_manager:getHorcruxBreakLv(iter_25_1.assist_girl)
					self.specialArray[iter_25_0].horcruxInfo.dfac = horcrux_manager:getHorcruxDamageFac(iter_25_1.assist_girl)
					self.specialArray[iter_25_0].horcruxInfo.hfac = horcrux_manager:getHorcruxHpFac(iter_25_1.assist_girl)
				end
			end
		end

		self.specialArray[iter_25_0].pos = iter_25_0
	end
end

function FormationSpecialExploreLayer:getFormationInfo()
	return {
		self.specialArray
	}
end

function FormationSpecialExploreLayer:getHorcruxSpriteType()
	return "enemyArrayMemberFormationStyle"
end

function FormationSpecialExploreLayer:getSelectGirlConfig(arg_28_1)
	local core_manager = require("controller.core_manager")
	local var_28_1 = self:getFormationInfo()
	local var_28_2

	if var_28_1[self.curFormationIndex][arg_28_1].girlInfo and var_28_1[self.curFormationIndex][arg_28_1].girlInfo.servantId then
		var_28_2 = var_28_1[self.curFormationIndex][arg_28_1].girlInfo.servantId
	end

	local var_28_3 = {}

	for iter_28_0, iter_28_1 in pairs(self.specialArray) do
		if iter_28_1.girlInfo and not iter_28_1.npcid then
			var_28_3[iter_28_1.girlInfo.servantId] = true
		end
	end

	return {
		fightType = FORMATION_TYPE_TO_FIGHT_TYPE[self.configType],
		selectType = self.selectGirlType,
		cursoul = var_28_2,
		usedServants = var_28_3,
		is_hp_inherit = self.is_hp_inherit,
		sureCallBack = function(arg_29_0)
			require("controller.array_manager"):updateArrayFightgirlHpInherit(self.curFormationIndex, arg_28_1, arg_29_0)

			if self.specialArray[arg_28_1].npcid then
				return
			end

			if not arg_29_0 then
				self.specialArray[arg_28_1].girlInfo = nil
				self.specialArray[arg_28_1].horcruxInfo = nil
			else
				self.specialArray[arg_28_1].girlInfo = self.specialArray[arg_28_1].girlInfo or {}

				local core_manager = require("controller.core_manager")
				local playermodel = require("model.playermodel")
				local explore_manager = require("controller.explore_manager")

				self.specialArray[arg_28_1].girlInfo.servantId = arg_29_0
				self.specialArray[arg_28_1].girlInfo.rank = core_manager:getServantCoreRank(arg_29_0)
				self.specialArray[arg_28_1].girlInfo.level = core_manager:getCoreLv(arg_29_0)
				self.specialArray[arg_28_1].girlInfo.contract = playermodel.soulContract[arg_29_0]
				self.specialArray[arg_28_1].girlInfo.servantskin = playermodel.servantUsedskin[arg_29_0]
				self.specialArray[arg_28_1].girlInfo.soulOC = playermodel.soulOverClock[arg_29_0] or 0

				if self.specialArray[arg_28_1].horcruxInfo and explore_manager:queryHorcruxIsUsed(self.specialArray[arg_28_1].horcruxInfo.entityid) then
					self.specialArray[arg_28_1].horcruxInfo = nil
				end

				local var_29_3 = explore_manager:getHorcruxByServantId(arg_29_0)

				if var_29_3 then
					self.specialArray[arg_28_1].horcruxInfo = self:getHorcruxInfoById(var_29_3)
				end
			end

			if arg_29_0 then
				require("controller.audio_manager"):playeffectMusicTest("sound/dispatch")
			end

			self:updateGirlSuccess(arg_28_1)
		end
	}
end

function FormationSpecialExploreLayer:getSelectHorcruxConfig(arg_30_1)
	local var_30_0 = self:getFormationInfo()[self.curFormationIndex]
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if iter_30_1.horcruxInfo and iter_30_1.horcruxInfo.itemid then
			var_30_1[#var_30_1 + 1] = iter_30_1.horcruxInfo.itemid
		end
	end

	local var_30_3 = {
		selectType = SELECT_HORCRUX_SPECIAL,
		isHpInherit = self.is_hp_inherit,
		selectParam = {
			outSide = var_30_1
		},
		battleInfo = var_30_0,
		arrayPos = arg_30_1
	}

	if var_30_0[arg_30_1].horcruxInfo then
		var_30_3.curHorcrux = var_30_0[arg_30_1].horcruxInfo.entityid or nil
	end

	var_30_3.defaultAttr = var_30_0[arg_30_1].horcruxInfo and var_30_0[arg_30_1].horcruxInfo.entityid and self:getAttrIconPath(require("model.playermodel").items[var_30_0[arg_30_1].horcruxInfo.entityid].itemid) or self:getAttrIconPath(var_30_0[arg_30_1].girlInfo.servantId)

	function var_30_3.selectCallback(arg_31_0)
		if not self.specialArray[arg_30_1].girlInfo then
			return
		end

		if arg_31_0 then
			for iter_31_0, iter_31_1 in pairs(self.specialArray) do
				if not iter_31_1.npcid and iter_31_1.horcruxInfo and iter_31_1.horcruxInfo.entityid == arg_31_0 then
					self.specialArray[iter_31_0].horcruxInfo = nil

					break
				end
			end

			self.specialArray[arg_30_1].horcruxInfo = self:getHorcruxInfoById(arg_31_0)
		else
			self.specialArray[arg_30_1].horcruxInfo = nil
		end

		if var_30_0[arg_30_1].girlInfo and arg_31_0 then
			require("controller.audio_manager"):playeffectMusicTest("sound/dispatch")
		end
	end

	return var_30_3
end

function FormationSpecialExploreLayer:getAttrIconPath(arg_32_1)
	local servant_data = require("data.servant_data")

	if servant_data[arg_32_1] then
		return (global_get_model_attr(servant_data[arg_32_1].modelid))
	else
		return (global_get_model_attr(require("data.horcrux_data")[arg_32_1].model))
	end
end

function FormationSpecialExploreLayer:selectWeapon(arg_33_1)
	local var_33_0 = self:getFormationInfo()

	if var_33_0[self.curFormationIndex][arg_33_1].npcid then
		global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Lock_Weapon)

		return
	end

	if var_33_0 and var_33_0[self.curFormationIndex] then
		if var_33_0[self.curFormationIndex][arg_33_1].girlInfo and var_33_0[self.curFormationIndex][arg_33_1].girlInfo.servantId then
			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Lock_Weapon)
		else
			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Assist_Girl_Nil)
			require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
		end
	end
end

function FormationSpecialExploreLayer:getHorcruxInfoById(arg_34_1)
	local horcrux_manager = require("controller.horcrux_manager")

	return {
		entityid = arg_34_1,
		itemid = require("model.playermodel").items[arg_34_1].itemid,
		star = horcrux_manager:getHorcruxStarLevel(arg_34_1),
		hlv = horcrux_manager:getHorcruxHLV(arg_34_1),
		hclass = horcrux_manager:getHorcruxHClass(arg_34_1),
		hbreak = horcrux_manager:getHorcruxBreakLv(arg_34_1),
		dfac = horcrux_manager:getHorcruxDamageFac(arg_34_1),
		hfac = horcrux_manager:getHorcruxHpFac(arg_34_1)
	}
end

function FormationSpecialExploreLayer:selectParts(arg_35_1)
	local var_35_0 = self:getFormationInfo()

	if var_35_0 and var_35_0[self.curFormationIndex] then
		if var_35_0[self.curFormationIndex][arg_35_1].npcid then
			global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Lock_Parts)
		elseif var_35_0[self.curFormationIndex][arg_35_1].girlInfo and var_35_0[self.curFormationIndex][arg_35_1].girlInfo.servantId then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				cursoul = var_35_0[self.curFormationIndex][arg_35_1].girlInfo.servantId,
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

function FormationSpecialExploreLayer:isShowAutoFormationBtn()
	return false
end

function FormationSpecialExploreLayer:getGirlSpriteType()
	return "enemyFormationStyle"
end

function FormationSpecialExploreLayer:getFightCapacitySum()
	local var_39_0 = self:getFormationInfo()

	if var_39_0 and var_39_0[self.curFormationIndex] then
		local var_39_1 = require("controller.fight_capacity_manager"):getNpcArrayFightCapacity(var_39_0[self.curFormationIndex])

		require("controller.explore_manager"):setCurFightCapacity(var_39_1)

		return (var_0_6(var_39_1))
	end

	return 0
end

function FormationSpecialExploreLayer:getGirlFightCapacitySum(arg_40_1)
	local var_40_0 = self:getFormationInfo()

	if var_40_0 and var_40_0[self.curFormationIndex] and var_40_0[self.curFormationIndex][arg_40_1] then
		return (var_0_6((var_0_6(require("controller.fight_capacity_manager"):getNpcArrayFightCapacity({
			var_40_0[self.curFormationIndex][arg_40_1]
		}, var_40_0[self.curFormationIndex])))))
	end

	return 0
end

function FormationSpecialExploreLayer:isShowFetterBtn()
	return false
end

function FormationSpecialExploreLayer:isRegisterTeamSkill()
	return true
end

function FormationSpecialExploreLayer:updateParts(arg_43_1)
	if self.bInit then
		local component_effect_data = require("data.component_effect_data")
		local item_data = require("data.item_data")
		local var_43_2 = self.listView:getItems()

		if var_43_2[arg_43_1] then
			local var_43_3 = var_43_2[arg_43_1]._childData.partsT
			local playermodel = require("model.playermodel")
			local var_43_5 = self:getFormationInfo()
			local var_43_6

			if var_43_5[self.curFormationIndex][arg_43_1].girlInfo and var_43_5[self.curFormationIndex][arg_43_1].girlInfo.servantId then
				var_43_6 = var_43_5[self.curFormationIndex][arg_43_1].girlInfo.servantId
			end

			if not var_43_6 then
				for iter_43_0 = 1, #var_43_3 do
					var_43_3[iter_43_0]:setScale(1)
					var_43_3[iter_43_0]:loadTextureEx(var_0_3 .. "horcrux_bg_add_ing.png")
					var_43_3[iter_43_0]:setPositionY(var_43_3[iter_43_0]._initPos.y)
				end
			elseif playermodel.component[var_43_6] then
				local var_43_7 = require("controller.component_manager"):getSoulComponentlist(var_43_6)

				for iter_43_1 = 1, #var_43_3 do
					var_43_3[iter_43_1]:setPositionY(var_43_3[iter_43_1]._initPos.y)
				end

				for iter_43_2 = 1, self.partsNum do
					if playermodel.component[var_43_6][iter_43_2] then
						local var_43_8 = item_data[playermodel.items[playermodel.component[var_43_6][iter_43_2].id].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_43_6][iter_43_2].id].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[playermodel.component[var_43_6][iter_43_2].id].itemid].main_attr .. "_" .. iter_43_2 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_43_6][iter_43_2].id].component_attr.effect].image_id .. "_" .. playermodel.items[playermodel.component[var_43_6][iter_43_2].id].component_attr.attr1 .. "_" .. iter_43_2 .. ".png"

						var_43_3[iter_43_2]:setScale(0.6)
						var_43_3[iter_43_2]:loadTextureEx(var_43_8, 0)

						local var_43_9 = var_43_3[iter_43_2]._initPos.y
						local var_43_10 = 18

						if var_43_7.effect then
							var_43_10 = 25
						end

						if iter_43_2 == 1 then
							var_43_9 = var_43_9 - var_43_10
						elseif iter_43_2 == 3 then
							var_43_9 = var_43_9 + var_43_10
						end

						var_43_3[iter_43_2]:setPositionY(var_43_9)
					else
						var_43_3[iter_43_2]:loadTextureEx(var_0_3 .. "horcrux_bg_add_ing.png")
						var_43_3[iter_43_2]:setPositionY(var_43_3[iter_43_2]._initPos.y)
					end
				end
			else
				for iter_43_3 = 1, #var_43_3 do
					var_43_3[iter_43_3]:setScale(1)
					var_43_3[iter_43_3]:loadTextureEx(var_0_3 .. "horcrux_bg_add_ing.png")
					var_43_3[iter_43_3]:setPositionY(var_43_3[iter_43_3]._initPos.y)
				end
			end
		end
	end
end

function FormationSpecialExploreLayer:getSelectBtnTextInfo(arg_44_1)
	local var_44_0 = {}

	var_44_0.str = "α别动队"
	var_44_0.font = FONT_NAME
	var_44_0.size = 24
	var_44_0.color = "6B7090"

	if arg_44_1 == self.curFormationIndex then
		var_44_0.color = "47404E"
	end

	return var_44_0
end

function FormationSpecialExploreLayer:selectGirl(arg_45_1)
	if self:selectGirlConditionScreening(arg_45_1, {
		bAutoTips = true
	}) then
		local var_45_0 = self:getFormationInfo()

		if var_45_0 and var_45_0[self.curFormationIndex] then
			LayerManager:pushInLayer("GirlSelectLayer", (self:getSelectGirlConfig(arg_45_1)))
		end
	end
end

return FormationSpecialExploreLayer
