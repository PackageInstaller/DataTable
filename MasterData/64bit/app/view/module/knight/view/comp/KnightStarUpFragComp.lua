local KnightStarUpFragComp = class("KnightStarUpFragComp", require("app.fairyGUI.knight.UI_KnightStarUpFragComp"))
local var_0_1 = g.core.config.fragment_info
local var_0_2 = g.core.model.User.ableFragmentData
local var_0_3 = g.core.model.User.fragmentsData
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.common.Goods
local var_0_7 = g.core.config.dungeon_land_info
local AbleFragmentConvertPop = require("app.view.base.infoPop.AbleFragmentConvertPop")

function KnightStarUpFragComp:ctor()
	self._knight = nil
	self._canStarUp = nil
	self._nextStarNum = nil
	self._fragmentId = nil

	self.m_starUpBtn:addClickListener(handler(self, self._onStarUpBtnClick))
	self.m_gotoBtn:addClickListener(handler(self, self._onGotoBtnClick))
	self.m_fragBtn:addClickListener(handler(self, self._onFragBtnClick))
	self.m_sellBtn:addClickListener(handler(self, self._onSellBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
end

function KnightStarUpFragComp:_updateFragNum()
	if self._knight:isMaxStar() or self._knight:isMain() then
		return
	end

	local var_2_0, var_2_1, var_2_2 = self._knight:canStarUp()

	if var_2_1 and var_2_2 then
		var_2_1 = var_2_1 < var_2_2 and var_2_1 or var_2_2
	end

	self._canStarUp = var_2_0

	self.m_numText:setText(var_2_1 .. "/" .. var_2_2)
	self.m_fragProgBar:setPercent({
		init = 0,
		cur = var_2_1 or 0,
		max = var_2_2 or 0
	})
	self.m_isEnoughController:setSelectedIndex(var_2_0 and 1 or 0)
end

function KnightStarUpFragComp:updateComp(arg_3_1)
	self._knight = arg_3_1
	self._canStarUp = nil
	self._nextStarNum = nil
	self._fragmentId = nil

	if g.core.common.ModuleUnlock:isModuleUnlock(10054) or self._knight:getQuality() == 1 then
		self.m_isUnlockSellController:setSelectedIndex(1)
	else
		self.m_isUnlockSellController:setSelectedIndex(0)
	end

	if arg_3_1:isMaxStar() then
		local var_3_0 = arg_3_1:getBaseInfo()

		if var_3_0.type ~= 1 then
			self.m_fragIcon:updateIcon({
				type = g.core.common.Goods.TYPE_FRAGMENT,
				value = var_3_0.fragment_id,
				size = g.core.model.User.fragmentsData:getFragmentNumById(var_3_0.fragment_id)
			})
		else
			self.m_isUnlockSellController:setSelectedIndex(0)
		end

		self.m_isMaxController:setSelectedIndex(1)
	else
		self.m_isMaxController:setSelectedIndex(0)

		local var_3_1 = arg_3_1:getBaseInfo()

		if arg_3_1:isMain() then
			self.m_isMainController:setSelectedIndex(1)

			local var_3_2, var_3_3, var_3_4, var_3_5 = g.core.model.User.warriorsOfFateData:getInfoByFuncType(2)

			if var_3_5 > 0 then
				if var_3_1.next_star_id > 0 then
					local var_3_7 = g.core.config.knight_info.get(var_3_1.next_star_id).star
				end

				local var_3_8 = var_0_7.get(var_3_5)

				self.m_chapterNumText:setText(var_3_3 - var_3_2 .. "/" .. var_3_3)
				self.m_chapterProgBar:setPercent({
					init = 0,
					cur = var_3_3 - var_3_2 or 0,
					max = var_3_3 or 0
				})
				self.m_descText:setText(g.core.lang:get(201015, {
					name = var_3_8.name
				}))
			else
				self.m_isMaxController:setSelectedIndex(2)
			end
		else
			self.m_isMainController:setSelectedIndex(0)
			self.m_knightIcon:updateIcon({
				darkQuality = true,
				type = g.core.common.Goods.TYPE_KNIGHT,
				value = var_3_1.id
			})

			local var_3_9 = var_3_1.fragment_id

			self.m_name:setText(var_0_1.get(var_3_1.fragment_id).name)

			local var_3_10, var_3_11, var_3_12 = arg_3_1:canStarUp()

			if var_3_11 and var_3_12 then
				var_3_11 = var_3_11 < var_3_12 and var_3_11 or var_3_12
			end

			self.m_fragProgBar:setPercent({
				init = 0,
				cur = var_3_11 or 0,
				max = var_3_12 or 0
			})
			self.m_numText:setText(var_3_11 .. "/" .. var_3_12)
			self.m_isEnoughController:setSelectedIndex(var_3_10 and 1 or 0)

			self._canStarUp = var_3_10
			self._nextStarNum = var_3_12
			self._fragmentId = var_3_9
		end
	end
end

function KnightStarUpFragComp:_onFragBtnClick()
	if var_0_2:isHaveKnightAbleFragment(self._fragmentId) and not self._canStarUp then
		local var_4_1 = {
			id = self._fragmentId
		}

		var_4_1.type = 1
		var_4_1.num = self._nextStarNum - var_0_3:getFragmentNumById(self._fragmentId)

		self:addPopup((AbleFragmentConvertPop.new(var_4_1)))
	elseif self._canStarUp then
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

function KnightStarUpFragComp:_onStarUpBtnClick()
	if not self._canStarUp and self._fragmentId then
		local var_5_0, var_5_1, var_5_2 = self._knight:canStarUp()
		local var_5_3 = var_5_2 - var_5_1
		local var_5_4 = g.core.model.User.ableFragmentData:getAbleFragmentKnightList(g.core.config.fragment_info.get(self._fragmentId).quality)

		if next(var_5_4) then
			if (var_5_4[1].num or 0) < var_5_3 then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = var_0_5.TYPE_FRAGMENT,
					value = self._fragmentId,
					size = var_0_4:getOwnNum(var_0_5.TYPE_FRAGMENT, self._fragmentId)
				})

				goto label_5_0
			end
		end

		g.core.module.ModuleManager:pushPopup((AbleFragmentConvertPop.new({
			state = 2,
			type = 1,
			id = self._fragmentId,
			num = var_5_3,
			knight = self._knight
		})))
	else
		g.core.network.GameNetProxy:send_C2S_Knight_StarIncrease({
			all_purpose_frag_num = 0,
			id = self._knight:getServerId()
		})
		self:dispatchCompEvent("lock_switch", {
			isLock = true
		})
	end

	::label_5_0::
end

function KnightStarUpFragComp:_onGotoBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.KINGDOM_FATE) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.WARRIOR)
	end
end

function KnightStarUpFragComp:_onSellBtnClick()
	local var_7_0 = require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.knightsData:getCanSellKnightFragDataList(), {
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.KNIGHT]
	})

	self:addListen(var_7_0)
	g.core.module.ModuleManager:pushPopup(var_7_0)
end

function KnightStarUpFragComp:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "FragSellPopClose" then
		self:_updateCompBySelf()
	end

	return false
end

function KnightStarUpFragComp:_updateCompBySelf()
	self:updateComp(self._knight)
end

function KnightStarUpFragComp:_onShopBtnClick()
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

function KnightStarUpFragComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_TRANSFORM, handler(self, self._updateFragNum), self)
end

return KnightStarUpFragComp
