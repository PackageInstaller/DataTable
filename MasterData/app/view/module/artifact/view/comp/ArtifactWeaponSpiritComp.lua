local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactWeaponSpiritComp = class("ArtifactWeaponSpiritComp", require("app.fairyGUI.artifact.UI_ArtifactWeaponSpiritComp"))

function ArtifactWeaponSpiritComp:ctor()
	self.m_attrBg2:addClickListener(handler(self, self._onSpiritLevelAttrDetailClick))
	self.m_attrBg1:addClickListener(handler(self, self._onSpiritTalentDetailClick))
	self.m_attrBg:addClickListener(handler(self, self._onSpiritStageAttrDetailClick))
	self.m_stageUpgradeBtn:addClickListener(handler(self, self._onStageUpgradeClick))
	self.m_lvUpBtn:addClickListener(handler(self, self._onLevelUpClick))
	self.m_fastBtn:addClickListener(handler(self, self._onFastBtnClick))
	self.m_maxTxt:enableRich()
	self.m_maxTxt:setText(g.core.lang:get(205567))
end

function ArtifactWeaponSpiritComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self._onGameTouchFinish, self)
end

function ArtifactWeaponSpiritComp:_onGameTouchFinish()
	self.m_progComp:gameTouchFinish()
end

function ArtifactWeaponSpiritComp:updateShow(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._artifactStruct = arg_4_1

	if arg_4_1:isHasWeaponSpirit() then
		self.m_progComp:setArtifactStruct(arg_4_1)

		local var_4_0 = arg_4_1:isSpiritMaxStage()

		self.m_isStageMaxController:setSelectedIndex(var_4_0 and 1 or 0)

		if var_4_0 then
			self.m_curSkillComp:updateSpiritSkillIcon({
				artifact = arg_4_1,
				knightPos = self._knightPos
			})
			self.m_hasSkillChangeController:setSelectedIndex(0)
			self.m_lvMaxDesc:setText(g.core.lang:get(205565))
		else
			self.m_lvMaxDesc:setText(g.core.lang:get(205566))

			if arg_4_1:isStageUpSpiritSkillChange() then
				self.m_curSkillComp:updateSpiritSkillIcon({
					artifact = arg_4_1,
					knightPos = self._knightPos
				})
				self.m_nextSkillComp:updateSpiritSkillIcon({
					isNextSkill = true,
					artifact = self._artifactStruct,
					knightPos = self._knightPos
				})
				self.m_hasSkillChangeController:setSelectedIndex(0)
			elseif arg_4_1:isStageUpSpiritSkillActive() then
				self.m_hasSkillChangeController:setSelectedIndex(2)
				self.m_activeSkillComp:updateSpiritSkillIcon({
					isNextSkill = true,
					artifact = arg_4_1,
					knightPos = self._knightPos
				})
			else
				self.m_hasSkillChangeController:setSelectedIndex(1)
			end
		end

		if arg_4_1:isSpiritMaxStage() then
			self.m_talentDescTxt:setText(g.core.lang:get(205546))
			self.m_stageUpgradeBtn:setGrayed(true)
		else
			self.m_stageUpgradeBtn:setGrayed(false)

			local var_4_1 = arg_4_1:getSpiritStageTalent(arg_4_1:getSpiritStage() + 1)

			if var_4_1[1] then
				self.m_talentDescTxt:setText(g.core.lang:get(205548, {
					name = g.core.config.talent_skill_info.get(var_4_1[1]).name
				}))
			else
				self.m_talentDescTxt:setText(g.core.lang:get(205546))
			end

			local var_4_2 = arg_4_1:getStageUpCost()

			self.m_costStageUpComp:updateByTVS({
				type = var_4_2.type,
				value = var_4_2.value,
				size = var_4_2.size
			})
		end

		if arg_4_1:isSpiritMaxLevel() then
			self.m_lvUpBtn:setGrayed(true)
			self.m_isMaxLevelController:setSelectedIndex(1)
		else
			self.m_isMaxLevelController:setSelectedIndex(0)
			self.m_lvUpBtn:setGrayed(false)

			local var_4_3 = arg_4_1:getLevelUpCost()

			self.m_costLevelUpComp:updateByTVS({
				type = var_4_3.type,
				value = var_4_3.value,
				size = var_4_3.size
			})
		end

		self.m_fastBtn:setVisible(self:_isShowFastLevelUp(10))

		if arg_4_1:isSpiritMaxStage() and arg_4_1:isSpiritMaxLevel() then
			self.m_allFullController:setSelectedIndex(1)
		else
			self.m_allFullController:setSelectedIndex(0)
		end
	end

	if self.m_enterTransition and not arg_4_4 then
		self.m_enterTransition:play()
	end
end

function ArtifactWeaponSpiritComp:_onSpiritLevelAttrDetailClick()
	if self._artifactStruct and self._artifactStruct:isHasWeaponSpirit() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.artifact.view.ArtifactSpiritLevelAttrPop").new(self._artifactStruct)))
	end
end

function ArtifactWeaponSpiritComp:_onSpiritStageAttrDetailClick()
	if self._artifactStruct and self._artifactStruct:isHasWeaponSpirit() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.artifact.view.ArtifactSpiritStageAttrPop").new(self._artifactStruct)))
	end
end

function ArtifactWeaponSpiritComp:_onSpiritTalentDetailClick()
	if self._artifactStruct and self._artifactStruct:isHasWeaponSpirit() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.artifact.view.ArtifactSpiritTalentTip").new(self._artifactStruct)))
	end
end

function ArtifactWeaponSpiritComp:_onStageUpgradeClick()
	if self._artifactStruct then
		local var_8_0, var_8_1 = self._artifactStruct:isEnoughStageUp()
		local var_8_2 = self._artifactStruct:getStageUpCost()

		if var_8_0 then
			if self._artifactStruct:isSpiritMaxStage() then
				g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.artifactData:getAllCanSellFrag(), {
					fragNameId = 205536,
					qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.ARTIFACT],
					title = g.core.lang:get(205535),
					emptyTitle = g.core.lang:get(205537)
				})))
			else
				g.core.network.GameNetProxy:send_C2S_Artifact_SpiritStageUp({
					id = self._artifactStruct:getServerOnlyId()
				})
			end
		elseif not self._artifactStruct:isSpiritMaxStage() then
			local var_8_3 = g.core.model.User.bagData:getOwnNum(var_8_2.type, var_8_2.value)
			local var_8_4 = 0

			if var_8_2.type == g.core.common.Goods.TYPE_FRAGMENT then
				var_8_4 = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, (g.core.model.User.ableFragmentData:getAbleFragmentId(var_8_2.value, ArtifactConst.ARTIFACT_ABLE_FRAGMENT_TYPE)))
			end

			local var_8_5 = var_8_2.size - var_8_3

			if self._artifactStruct:isHasWeaponSpirit() then
				if var_8_3 + var_8_4 < var_8_2.size then
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						type = var_8_1.type,
						value = var_8_1.value
					})
				elseif var_8_2.type == g.core.common.Goods.TYPE_FRAGMENT and var_8_5 > 0 then
					g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.AbleFragmentConvertPop").new({
						type = 3,
						id = var_8_2.value,
						num = var_8_5,
						name = g.core.lang:get(205573)
					})))
				end
			else
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = var_8_1.type,
					value = var_8_1.value
				})
			end
		else
			local var_8_6 = require("app.view.base.infoPop.FragSellPop").new
			local var_8_7 = g.core.model.User.artifactData:getAllCanSellFrag()
			local var_8_8 = {
				fragNameId = 205536
			}

			var_8_8.qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.ARTIFACT]
			var_8_8.title = g.core.lang:get(205535)
			var_8_8.emptyTitle = g.core.lang:get(205537)

			g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop"):new(var_8_8)))
		end
	end
end

function ArtifactWeaponSpiritComp:_onLevelUpClick()
	if self._artifactStruct then
		local var_9_0, var_9_1 = self._artifactStruct:isEnoughStageLevelUp()

		if var_9_0 then
			if self._artifactStruct:isSpiritMaxLevel() then
				g.core.module.ModuleManager:tip(g.core.lang:get(205555))
			else
				g.core.network.GameNetProxy:send_C2S_Artifact_SpiritLevelUp({
					id = self._artifactStruct:getServerOnlyId(),
					target_level = self._artifactStruct:getSpiritLevel() + 1
				})
			end
		elseif not self._artifactStruct:isSpiritMaxLevel() then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_9_1.type,
				value = var_9_1.value
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(205555))
		end
	end
end

function ArtifactWeaponSpiritComp:_onFastBtnClick()
	g.core.network.GameNetProxy:send_C2S_Artifact_SpiritLevelUp({
		id = self._artifactStruct:getServerOnlyId(),
		target_level = self._artifactStruct:getSpiritLevel() + 10
	})
end

function ArtifactWeaponSpiritComp:_isShowFastLevelUp(arg_11_1)
	local var_11_0 = self._artifactStruct:getSpiritLevel()

	if arg_11_1 > self._artifactStruct:getSpiritStageMaxLevel(self._artifactStruct:getSpiritStage()) - var_11_0 then
		return false
	end

	for iter_11_0, iter_11_1 in pairs((self._artifactStruct:getCostToTargetLevel(var_11_0 + arg_11_1 - 1))) do
		local var_11_1 = string.split(iter_11_0, "_")

		if iter_11_1 > g.core.model.User.bagData:getCountById(tonumber(var_11_1[1]), tonumber(var_11_1[2])) then
			return false
		end
	end

	return true
end

return ArtifactWeaponSpiritComp
