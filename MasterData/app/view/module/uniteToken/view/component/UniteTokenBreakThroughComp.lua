local var_0_0 = g.core.model.User.uniteTokenData
local var_0_1 = g.core.config.unite_token_info
local var_0_2 = g.core.config.fragment_info
local UniteTokenCommon = require("app.view.module.uniteToken.common.UniteTokenCommon")
local var_0_4 = g.core.const.ConstMgr.UniteTokenConst
local UniteTokenBreakThroughComp = class("UniteTokenBreakThroughComp", require("app.fairyGUI.uniteToken.UI_UniteTokenBreakThroughComp"))

function UniteTokenBreakThroughComp:ctor()
	self._showData = nil

	self.m_curSkillComp1:addClickListener(handler(self, self._onSkillClick))
	self.m_nextSkillComp1:addClickListener(handler(self, self._onNextSkillClick))
	self.m_maxSkillComp1:addClickListener(handler(self, self._onSkillClick))
	self.m_curSkillComp2:addClickListener(handler(self, self._onSkillClick2))
	self.m_nextSkillComp2:addClickListener(handler(self, self._onNextSkillClick2))
	self.m_maxSkillComp2:addClickListener(handler(self, self._onSkillClick2))

	self._curSkillInfo = nil
	self._nextSkillInfo = nil

	self.m_upgradeBtn:addClickListener(handler(self, self._onStarUpClick))
	self.m_tipsBtn:addClickListener(handler(self, self._onTipsClick))
	self.m_universalBtn:addClickListener(handler(self, self._onComPieceClick))
	self.m_attrBg:addClickListener(handler(self, self._onTipsClick))
	self.m_sellBtn:addClickListener(handler(self, self._onClickSellBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
end

function UniteTokenBreakThroughComp:updateShow(arg_2_1)
	self._showData = arg_2_1
	self._baseId = self._showData:getBaseId()

	local var_2_0 = self._showData:getAdvanceId()
	local var_2_1 = g.core.config.unite_token_info.get(self._baseId)
	local var_2_2 = var_0_0:getTokenStarInfo(var_2_0, var_2_1)

	self._skillInfo = var_2_2.skillInfo
	self._curSkillInfo = var_0_0:getTokenBaseInfo(self._baseId).skillInfo

	local var_2_3 = var_2_2.starNum

	if var_2_1.next_star_id ~= 0 then
		self._nextSkillInfo = var_0_0:getTokenStarInfo(var_2_0, (var_0_1.get(var_2_1.next_star_id))).skillInfo
	end

	if var_2_2.maxStarNum <= var_2_3 then
		self._nextSkillInfo = nil

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FRAGMENT_RECOVERY, nil, true) then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(2)
		end

		self.m_curMaxStarTxt:setText(var_2_3)
		self.m_maxSkillComp1:updateIcon(var_2_2.skillInfo)
		self.m_fragIcon:updateIcon({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = var_2_1.fragment_id,
			size = g.core.model.User.fragmentsData:getFragmentNumById(var_2_1.fragment_id)
		})
	else
		self.m_curSkillComp1:updateIcon(var_2_2.skillInfo)
		self.m_stateController:setSelectedIndex(0)
		self.m_curStarTxt:setText(var_2_3)
		self.m_nextStarTxt:setText(var_2_3 + 1)
		self.m_nextSkillComp1:updateIcon(var_0_0:getTokenStarInfo(var_2_0, (var_0_1.get((self._showData:getNextStarId())))).skillInfo)

		self._fragmentId = var_2_1.fragment_id

		self.m_itemNameTxt:setText(var_0_2.get(var_2_1.fragment_id).name)
		self.m_itemIcon:updateIcon({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = var_2_1.fragment_id
		})

		local var_2_4, var_2_5 = self._showData:getStarUpFragmentNum()

		self._isCanStar = var_2_5 <= var_2_4

		self.m_itemNumTxt:setText(var_2_4 .. "/" .. var_2_5)
		self.m_processBar:setMax(var_2_5)
		self.m_processBar:setValue(var_2_4)

		if self._isCanStar then
			self.m_activeController:setSelectedIndex(1)
		else
			self.m_activeController:setSelectedIndex(0)
		end
	end

	self:_updatePassiveShow(var_2_1)
end

function UniteTokenBreakThroughComp:_updatePassiveShow(arg_3_1)
	self._passiveData = var_0_0:getTokenPassiveInfo(arg_3_1.advance_id, arg_3_1.star)

	if self._passiveData then
		self.m_curSkillComp2:updateIcon(self._passiveData)
		self.m_maxSkillComp2:updateIcon(self._passiveData)

		self._nextPassiveInfo = var_0_0:getTokenPassiveInfo(arg_3_1.advance_id, arg_3_1.star + 1)

		if self._nextPassiveInfo and self._nextPassiveInfo.skillId ~= self._passiveData.skillId then
			self.m_showSkillNumController:setSelectedIndex(1)
			self.m_nextSkillComp2:updateIcon(self._nextPassiveInfo)
		elseif arg_3_1.next_star_id == 0 then
			self.m_showSkillNumController:setSelectedIndex(1)
		else
			self.m_showSkillNumController:setSelectedIndex(0)
		end
	else
		self.m_showSkillNumController:setSelectedIndex(0)
	end
end

function UniteTokenBreakThroughComp:playEnterAnim(arg_4_1)
	if arg_4_1 then
		self.m_enterTransition:play(arg_4_1)
	else
		self.m_enterTransition:play()
	end
end

function UniteTokenBreakThroughComp:playExitAnim(arg_5_1)
	if arg_5_1 then
		self.m_backTransition:play(arg_5_1)
	else
		self.m_backTransition:play()
	end
end

function UniteTokenBreakThroughComp:_onClickSellBtn()
	local var_6_0 = require("app.view.base.infoPop.FragSellPop").new(var_0_0:getCanSellUniteTokenFragDataArr(), {
		fragNameId = 202534,
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.UNITETOKEN],
		title = g.core.lang:get(103036),
		emptyTitle = g.core.lang:get(103037)
	})

	self:addListen(var_6_0)
	g.core.module.ModuleManager:pushPopup(var_6_0)
end

function UniteTokenBreakThroughComp:receiveCompEvent(arg_7_1)
	if arg_7_1 == "FragSellPopClose" then
		self:updateShow(self._showData)
	end
end

function UniteTokenBreakThroughComp:_onClickShopBtn()
	local var_8_0 = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.CRYSTAL
	local var_8_1 = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE

	if self._showData:getQuality() == 1 then
		var_8_0 = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.SHOP
		var_8_1 = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_8_1,
		shopType = var_8_0
	})
end

function UniteTokenBreakThroughComp:_onSkillClick()
	if self._curSkillInfo then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenSkillPop").new(self._skillInfo), {
			touchDisappear = true
		})
	end
end

function UniteTokenBreakThroughComp:_onNextSkillClick()
	if self._nextSkillInfo then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenSkillPop").new(self._nextSkillInfo), {
			touchDisappear = true
		})
	end
end

function UniteTokenBreakThroughComp:_onSkillClick2()
	if self._curSkillInfo then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenPassiveSkillPop").new({
			skillData = self._passiveData,
			tokenData = self._showData
		}), {
			touchDisappear = true
		})
	end
end

function UniteTokenBreakThroughComp:_onNextSkillClick2()
	if self._nextSkillInfo then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenPassiveSkillPop").new({
			skillData = self._nextPassiveInfo,
			tokenData = self._showData,
			showStar = self._showData:getStarLevel() + 1
		}), {
			touchDisappear = true
		})
	end
end

function UniteTokenBreakThroughComp:_onTipsClick()
	self._baseId = self._showData:getBaseId()

	local var_13_0 = self._showData:getAdvanceId()
	local var_13_1 = g.core.config.unite_token_info.get(self._baseId)
	local var_13_2 = var_0_0:getTokenStarInfo(var_13_0, var_13_1)
	local var_13_3

	if not var_13_2.isMax then
		var_13_3 = var_0_0:getTokenStarInfo(var_13_0, g.core.config.unite_token_info.get(var_13_1.next_star_id), true)
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.pop.UniteTokenAttrPop").new(var_13_2.attrList, var_13_2.isMax, var_13_3 and var_13_3.attrList), {
		touchDisappear = true
	})
end

function UniteTokenBreakThroughComp:_onStarUpClick()
	if self._isCanStar then
		local var_14_0 = self._showData:getServerId()

		if var_14_0 > 0 then
			g.core.network.GameNetProxy:send_C2S_UniteToken_StarIncrease({
				id = var_14_0
			})
		end
	else
		UniteTokenCommon.openPieceGetPop(self._showData)
	end
end

function UniteTokenBreakThroughComp:_onComPieceClick()
	if self._fragmentId == 0 or not self._showData then
		return
	end

	local var_15_0 = g.core.model.User.ableFragmentData:isHaveUniteTokenAbleFragment(self._fragmentId)
	local var_15_1, var_15_2 = self._showData:getStarUpFragmentNum()

	if var_15_0 and var_15_2 - var_15_1 > 0 then
		self:addPopup((require("app.view.base.infoPop.AbleFragmentConvertPop").new({
			type = 2,
			id = self._fragmentId,
			num = var_15_2 - var_15_1
		})))
	elseif var_15_2 - var_15_1 <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(202516))
	else
		local var_15_3 = g.core.model.User.ableFragmentData:getAbleFragmentId(self._fragmentId, var_0_4.COMMON_TOKEN_PICEC_ID)

		if var_15_3 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = g.core.common.Goods.TYPE_ITEM,
				value = var_15_3
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(202520))
		end
	end
end

return UniteTokenBreakThroughComp
