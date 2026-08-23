local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactBreakThroughComp = class("ArtifactBreakThroughComp", require("app.fairyGUI.artifact.UI_ArtifactBreakThroughComp"))

function ArtifactBreakThroughComp:ctor()
	self.m_upgradeBtn:addClickListener(handler(self, self._onStarUpClick))
	self.m_universalBtn:addClickListener(handler(self, self._onFragmentClick))
	self.m_attrBg:addClickListener(handler(self, self._onStarUpAttrsClick))
	self.m_attrBg2:addClickListener(handler(self, self._onStarUpTalentClick))
	self.m_sellBtn:addClickListener(handler(self, self._onSellBtnClick))
	self.m_jumpBtn:addClickListener(handler(self, self.onJumpBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
end

function ArtifactBreakThroughComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, self.updateFragNum, self)
end

function ArtifactBreakThroughComp:updateFragNum()
	local var_3_0 = self._artifactStruct:getCfg()

	self.m_fragIcon:updateIcon({
		type = g.core.common.Goods.TYPE_FRAGMENT,
		value = var_3_0.fragment_id,
		size = g.core.model.User.fragmentsData:getFragmentNumById(var_3_0.fragment_id)
	})
end

function ArtifactBreakThroughComp:updateShow(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_1 then
		self._artifactStruct = arg_4_1
		self._knightPos = arg_4_2
		self._artifactInfo = self._artifactStruct:getCfg()
		self._star = self._artifactStruct:getStar()
		self._isFullStar = self._artifactStruct:isMaxStar()
		self._isCanStarUp = false
		self._needNum = 0
		self._hasNum = 0

		self.m_hasTalentController:setSelectedIndex(arg_4_1:isHasWeaponSpirit() and 1 or 0)

		if arg_4_1:isHasWeaponSpirit() then
			if self._isFullStar then
				self.m_talentDescTxt:setText(g.core.lang:get(205568))
			else
				local var_4_0 = arg_4_1:getStarCfg(self._star + 1)

				if var_4_0 then
					self.m_talentDescTxt:setText(g.core.lang:get(205558, {
						name = var_4_0.talent_name
					}))
				else
					self.m_talentDescTxt:setText(g.core.lang:get(205568))
				end
			end
		end

		self.m_stateController:setSelectedIndex(self._isFullStar and 1 or 0)
		self:_updateStarLevel()
		self:_updateSkillComp()
		self:_updateUpStarInfo()

		if self._isFullStar then
			if g.core.common.ModuleUnlock:isModuleUnlock(10054) then
				if arg_4_1:isHasWeaponSpirit() then
					if arg_4_1:isSpiritMaxStage() then
						self.m_stateController:setSelectedIndex(2)
					else
						self.m_stateController:setSelectedIndex(3)
					end
				else
					self.m_stateController:setSelectedIndex(2)
				end

				local var_4_1 = self._artifactStruct:getCfg()

				self.m_fragIcon:updateIcon({
					type = g.core.common.Goods.TYPE_FRAGMENT,
					value = var_4_1.fragment_id,
					size = g.core.model.User.fragmentsData:getFragmentNumById(var_4_1.fragment_id)
				})
			end

			self.m_exRewardTxt:setText("")
		end

		self.m_exRewardTxt:setText("")

		if not self._isFullStar and arg_4_1:isHasWeaponSpirit() and arg_4_1:getStarCfg(arg_4_1:getStar() + 1).token_num > 0 then
			self.m_exRewardTxt:setText(g.core.lang:get(205549, {
				num = arg_4_1:getStarCfg(arg_4_1:getStar() + 1).token_num
			}))
		end
	end

	if self.m_enterTransition and not arg_4_4 then
		self.m_enterTransition:play()
	end
end

function ArtifactBreakThroughComp:_updateStarLevel()
	if self._isFullStar then
		self.m_curMaxStarTxt:setText(self._star)
	else
		self.m_curStarTxt:setText(self._star)
		self.m_nextStarTxt:setText(self._star + 1)
	end
end

function ArtifactBreakThroughComp:_updateSkillComp()
	if self._isFullStar then
		self.m_maxSkillComp:updateIcon({
			artifact = self._artifactStruct,
			knightPos = self._knightPos
		})
	else
		self.m_curSkillComp:updateIcon({
			artifact = self._artifactStruct,
			knightPos = self._knightPos
		})
		self.m_nextSkillComp:updateIcon({
			isNextSkill = true,
			artifact = self._artifactStruct,
			knightPos = self._knightPos
		})
	end
end

function ArtifactBreakThroughComp:_updateUpStarInfo()
	if not self._isFullStar then
		self._fragmentId = self._artifactInfo.fragment_id

		local var_7_0 = g.core.config.fragment_info.fetch(self._artifactInfo.fragment_id)

		if not var_7_0 then
			g.core.module.ModuleManager:tip("no fragmentInfo: id is " .. self._artifactInfo.fragment_id)
		end

		self.m_itemIcon:updateIcon({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = self._artifactInfo.fragment_id
		})
		self.m_itemNameTxt:setText((var_7_0 or {}).name)

		local var_7_1, var_7_2, var_7_3 = self._artifactStruct:canStarUp()

		self._needNum = var_7_2
		self._isCanStarUp = var_7_1
		self._hasNum = var_7_3

		self.m_itemNumTxt:setText(var_7_3 .. "/" .. var_7_2)
		self.m_processBar:setMax(var_7_2)
		self.m_processBar:setValue(var_7_3)
		self.m_activeController:setSelectedIndex(self._isCanStarUp and 1 or 0)
	end
end

function ArtifactBreakThroughComp:_onStarUpClick()
	if not self._isFullStar and self._artifactStruct then
		if self._isCanStarUp then
			g.core.network.GameNetProxy:send_C2S_Artifact_Star({
				id = self._artifactStruct:getServerOnlyId(),
				tg_star = self._star + 1
			})
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = g.core.common.Goods.TYPE_FRAGMENT,
				value = self._fragmentId
			})
		end
	end
end

function ArtifactBreakThroughComp:_onFragmentClick()
	if self._fragmentId == 0 or self._isFullStar or not self._artifactStruct then
		return
	end

	if g.core.model.User.ableFragmentData:isHaveArtifactAbleFragment(self._fragmentId) and self._needNum - self._hasNum > 0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.AbleFragmentConvertPop").new({
			type = 3,
			id = self._fragmentId,
			num = self._needNum - self._hasNum
		})))
	elseif self._needNum - self._hasNum <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(205505))
	else
		local var_9_0 = g.core.model.User.ableFragmentData:getAbleFragmentId(self._fragmentId, ArtifactConst.ARTIFACT_ABLE_FRAGMENT_TYPE)

		if var_9_0 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = g.core.common.Goods.TYPE_ITEM,
				value = var_9_0
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(205506))
		end
	end
end

function ArtifactBreakThroughComp:_onStarUpAttrsClick()
	if self._artifactStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.artifact.view.ArtifactStarUpAttrPop").new({
			starUpShowAttrs = self._artifactStruct:getPopShowStarAttrs(),
			isFullStar = self._isFullStar,
			isExclutive = self._artifactStruct:isNonExclusive()
		}), {
			touchDisappear = true
		})
	end
end

function ArtifactBreakThroughComp:_onStarUpTalentClick()
	if self._artifactStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.artifact.view.ArtifactStarUpTalentPop").new(self._artifactStruct), {
			touchDisappear = true
		})
	end
end

function ArtifactBreakThroughComp:_onShopBtnClick()
	local var_12_0 = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE
	local var_12_1 = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.CRYSTAL

	if self._artifactStruct:getQuality() ~= 3 then
		var_12_1 = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.SHOP
		var_12_0 = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_12_0,
		shopType = var_12_1
	})
end

function ArtifactBreakThroughComp:_onSellBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.artifactData:getAllCanSellFrag(), {
		fragNameId = 205536,
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.ARTIFACT],
		title = g.core.lang:get(205535),
		emptyTitle = g.core.lang:get(205537)
	})))
end

function ArtifactBreakThroughComp:onJumpBtnClick()
	if self._artifactStruct:isHasWeaponSpirit() and not self._artifactStruct:isSpiritMaxStage() then
		self:dispatchCompEvent("SWITCH_TAB_TO_SPIRIT")

		return
	end
end

return ArtifactBreakThroughComp
