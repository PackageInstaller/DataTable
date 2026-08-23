local KnightSpSoulFragComp = class("KnightSpSoulFragComp", require("app.fairyGUI.knight.UI_KnightSpSoulFragComp"))
local var_0_1 = g.core.config.fragment_info
local var_0_2 = g.core.model.User.ableFragmentData
local var_0_3 = g.core.model.User.fragmentsData
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.common.Goods
local AbleFragmentConvertPop = require("app.view.base.infoPop.AbleFragmentConvertPop")

function KnightSpSoulFragComp:ctor()
	self._knight = nil
	self._canSoulUp = nil
	self._nextStarNum = nil
	self._fragmentId = nil

	self.m_starUpBtn:addClickListener(handler(self, self._onStarUpBtnClick))
	self.m_gotoBtn:addClickListener(handler(self, self._onGotoBtnClick))
	self.m_fragBtn:addClickListener(handler(self, self._onFragBtnClick))
	self.m_sellBtn:addClickListener(handler(self, self._onSellBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
end

function KnightSpSoulFragComp:_updateFragNum()
	local var_2_0, var_2_1, var_2_2 = self._knight:canSoulUpLevel()

	self._canSoulUp = var_2_0

	if var_2_2 > var_2_1.size and not var_2_1.size then
		-- block empty
	end

	local var_2_3 = {
		init = 0,
		cur = var_2_2 or 0
	}

	var_2_3.max = var_2_1.size or 0

	self.m_fragProgBar:setPercent(var_2_3)
	self.m_numText:setText(var_2_2 .. "/" .. var_2_1.size)
	self.m_isEnoughController:setSelectedIndex(var_2_0 and 1 or 0)
end

function KnightSpSoulFragComp:updateComp(arg_3_1)
	self._knight = arg_3_1
	self._canSoulUp = nil
	self._nextStarNum = nil
	self._fragmentId = nil

	if g.core.common.ModuleUnlock:isModuleUnlock(10054) or self._knight:getQuality() == 1 then
		self.m_isUnlockSellController:setSelectedIndex(1)
	else
		self.m_isUnlockSellController:setSelectedIndex(0)
	end

	if arg_3_1:isMaxSoulLevel() then
		local var_3_0 = arg_3_1:getBaseInfo()

		self.m_fragIcon:updateIcon({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = var_3_0.fragment_id,
			size = g.core.model.User.fragmentsData:getFragmentNumById(var_3_0.fragment_id)
		})
		self.m_isMaxController:setSelectedIndex(1)
	else
		self.m_isMaxController:setSelectedIndex(0)

		local var_3_1 = arg_3_1:getSpSoulCfg()
		local var_3_2 = {
			type = var_3_1.up_stage_type,
			value = var_3_1.up_stage_value,
			size = var_3_1.up_stage_size
		}

		if var_3_2.type == g.core.common.Goods.TYPE_FRAGMENT then
			self.m_isMainController:setSelectedIndex(0)
			self.m_knightIcon:updateIcon({
				darkQuality = true,
				type = g.core.common.Goods.TYPE_KNIGHT,
				value = arg_3_1:getBaseInfo().id
			})

			local var_3_3 = var_3_2.value

			self.m_name:setText(var_0_1.get(var_3_2.value).name)

			local var_3_4, var_3_5, var_3_6 = arg_3_1:canSoulUpLevel()

			if var_3_6 > var_3_5.size and not var_3_5.size then
				-- block empty
			end

			local var_3_7 = {
				init = 0,
				cur = var_3_6 or 0
			}

			var_3_7.max = var_3_5.size or 0

			self.m_fragProgBar:setPercent(var_3_7)
			self.m_numText:setText(var_3_6 .. "/" .. var_3_5.size)
			self.m_isEnoughController:setSelectedIndex(var_3_4 and 1 or 0)

			self._canSoulUp = var_3_4
			self._nextStarNum = var_3_5.size
			self._fragmentId = var_3_3
		end
	end
end

function KnightSpSoulFragComp:_onFragBtnClick()
	if var_0_2:isHaveKnightAbleFragment(self._fragmentId) and not self._canSoulUp then
		local var_4_1 = {
			id = self._fragmentId
		}

		var_4_1.type = 1
		var_4_1.num = self._nextStarNum - var_0_3:getFragmentNumById(self._fragmentId)

		self:addPopup((AbleFragmentConvertPop.new(var_4_1)))
	elseif self._canSoulUp then
		g.core.module.ModuleManager:tip(g.core.lang:get(201402))
	else
		local var_4_2 = var_0_2:getAbleFragmentId(self._fragmentId, 2)

		if var_4_2 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = g.core.common.Goods.TYPE_ITEM,
				value = var_4_2,
				size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, nil)
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(201403))
		end
	end
end

function KnightSpSoulFragComp:_onStarUpBtnClick()
	if not self._canSoulUp and self._fragmentId then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_0_5.TYPE_FRAGMENT,
			value = self._fragmentId,
			size = var_0_4:getOwnNum(var_0_5.TYPE_FRAGMENT, self._fragmentId)
		})
	else
		g.core.network.GameNetProxy:send_C2S_Knight_MR_SupportUp({
			knight_id = self._knight:getServerId()
		})
	end
end

function KnightSpSoulFragComp:_onGotoBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.KINGDOM_FATE) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.WARRIOR)
	end
end

function KnightSpSoulFragComp:_onSellBtnClick()
	local var_7_0 = require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.knightsData:getCanSellKnightFragDataList(), {
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.KNIGHT]
	})

	self:addListen(var_7_0)
	g.core.module.ModuleManager:pushPopup(var_7_0)
end

function KnightSpSoulFragComp:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "FragSellPopClose" then
		self:_updateCompBySelf()
	end

	return false
end

function KnightSpSoulFragComp:_updateCompBySelf()
	self:updateComp(self._knight)
end

function KnightSpSoulFragComp:_onShopBtnClick()
	local var_10_0 = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.CRYSTAL
	local var_10_1 = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE

	if self._knight:getQuality() == 1 then
		var_10_0 = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.SHOP
		var_10_1 = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_10_1,
		shopType = var_10_0
	})
end

function KnightSpSoulFragComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_TRANSFORM, handler(self, self._updateFragNum), self)
end

return KnightSpSoulFragComp
