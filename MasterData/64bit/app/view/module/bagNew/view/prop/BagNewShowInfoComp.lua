local var_0_0 = g.core.model.User.weddingData
local var_0_1 = g.core.model.User.knightsData
local BagNewShowInfoComp = class("BagNewShowInfoComp", require("app.fairyGUI.bagNew.UI_BagNewShowInfoComp"))
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.model.User
local var_0_5 = g.core.lang
local var_0_6 = g.core.common.Goods
local var_0_7 = g.core.config.item_info
local var_0_8 = g.core.config.expirable_item_info
local var_0_9 = g.core.module.ModuleManager
local var_0_10 = g.view.entrance.ModuleGotoProxy
local var_0_11 = g.core.model.User.bagData
local var_0_12 = g.core.const.ConstMgr
local var_0_13 = g.core.network.GameNetProxy
local var_0_14 = g.core.event.enum
local var_0_15 = g.core.event.EventManager
local BagNewPropCfg = require("app.view.module.bagNew.const.BagNewPropCfg")
local var_0_17 = g.core.common.Path
local var_0_18 = g.core.common.ServerTime
local var_0_19 = g.core.const.ConstMgr.BASE_CONST

function BagNewShowInfoComp:ctor()
	self.m_useBtn:addClickListener(handler(self, self._onUse))
	self.m_infoBtn:addClickListener(handler(self, self._onInfoClick))
end

function BagNewShowInfoComp:onLoad()
	var_0_15:addEventListener(var_0_14.EVENT_NET_S2C_ITEM_USE, handler(self, self._onUseRecvHandler), self)
end

function BagNewShowInfoComp:updateView(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = var_0_6:convert(arg_3_1)

	self._goodInfo = var_3_0

	self.m_scrollTxtComp:setTitle(var_3_0.desc)

	local var_3_1 = arg_3_1.time or 0

	self.m_haveTxt:setText(arg_3_1.size or 0)
	self.m_useBtn:setVisible(true)
	self.m_tipTxt:setVisible(false)

	self._limitedTime = -1

	if var_3_0.type == var_0_6.TYPE_ITEM then
		local var_3_2 = var_0_7.get(var_3_0.value)

		var_3_0.loaderUrl = var_0_17:getBagNewQualityBgPath(var_3_2.quality)
		var_3_0.iconScale = 1

		self.m_infoBaseComp:setData(var_3_0)

		if var_3_2 and var_3_2.button_text then
			self.m_useBtn:setTitle(var_3_2.button_text)

			if var_3_2.use_level > var_0_4:getLevel() then
				self.m_useBtn:setVisible(false)
				self.m_tipTxt:setVisible(true)
				self.m_tipTxt:setText(string.format(var_0_5:get(400001), var_3_2.use_level))
			else
				self.m_useBtn:setVisible(true)
				self.m_tipTxt:setVisible(false)
			end
		end

		if var_3_2.use_type == 0 then
			self.m_useBtn:setVisible(false)
			self.m_tipTxt:setVisible(false)
		end

		if var_3_2.limited_time ~= 0 or var_3_1 ~= 0 then
			if var_3_2.limited_time ~= 0 then
				self._limitedTime = var_3_2.limited_time or var_3_1
			end

			self:onScheduleUpdate()
		end
	elseif var_3_0.type == var_0_6.TYPE_EXPIRABLE_ITEM then
		local var_3_3 = var_0_8.get(var_3_0.value)

		var_3_0.loaderUrl = var_0_17:getBagNewQualityBgPath(var_3_3.quality)
		var_3_0.iconScale = 1

		self.m_infoBaseComp:setData(var_3_0)

		if var_3_3 and var_3_3.button_text then
			self.m_useBtn:setTitle(var_3_3.button_text)

			if var_3_3.use_level > var_0_4:getLevel() then
				self.m_useBtn:setVisible(false)
				self.m_tipTxt:setVisible(true)
				self.m_tipTxt:setText(string.format(var_0_5:get(400001), var_3_3.use_level))
			else
				self.m_useBtn:setVisible(true)
				self.m_tipTxt:setVisible(false)
			end
		end

		if var_3_3.use_type == 0 then
			self.m_useBtn:setVisible(false)
			self.m_tipTxt:setVisible(false)
		end

		if var_3_3.limited_time ~= 0 or var_3_1 ~= 0 then
			self._limitedTime = var_3_1

			self:onScheduleUpdate()
		end
	end

	local var_3_4 = self._limitedTime > 0

	self.m_limitedTimeTxt:setVisible(self._limitedTime > 0)
	self.m_limitTimeIcon:setVisible(var_3_4)

	self._data = arg_3_1
end

function BagNewShowInfoComp:onScheduleUpdate()
	if self._limitedTime > 0 then
		local var_4_0 = var_0_18:getLeftSeconds(self._limitedTime)

		if var_4_0 >= 0 then
			if var_4_0 > var_0_19.ITEM_LIMITIED_TIME then
				self.m_limitedTimeTxt:setText(var_0_5:get(400007, {
					time = var_0_18:getDateYMDHFormat(self._limitedTime)
				}))
			else
				self.m_limitedTimeTxt:setText(var_0_5:get(400007, {
					time = var_0_18:getLeftDHMFormat(self._limitedTime)
				}))
			end
		else
			self.m_limitedTimeTxt:setText(var_0_5:get(400008))
		end
	end
end

function BagNewShowInfoComp:playEnterAnim()
	self.m_enterTransition:play()
end

function BagNewShowInfoComp:_onUse()
	if not self._data then
		return
	end

	if self._data.type == var_0_12.BAG_TYPE.ITEM then
		local var_6_0 = var_0_7.get(self._data.value)

		if var_6_0.use_type == BagNewPropCfg.USE_TYPE.OTHER then
			self.m_useBtn:setVisible(false)
		elseif var_6_0.use_type == BagNewPropCfg.USE_TYPE.USE or var_6_0.use_type == BagNewPropCfg.USE_TYPE.DROP then
			local var_6_1 = var_0_11:getOwnNum(var_0_12.BAG_TYPE.ITEM, var_6_0.id)

			if var_6_0.item_type == 27 then
				local var_6_2 = g.core.config.voucher_info.match(function(arg_7_0)
					if arg_7_0.item_id == var_6_0.id then
						return true
					end

					return false
				end)

				if var_6_2 and #var_6_2 > 0 then
					g.core.module.ModuleManager:pushPopup(require("app.view.module.bagNew.view.popup.BagNewVoucherPop").new({
						size = 1,
						value = var_6_0.id,
						type = g.core.common.Goods.TYPE_ITEM,
						callback = handler(self, self._onVoucherPopClosed)
					}), {
						touchDisappear = true
					})
				else
					var_0_9:tip(var_0_5:get(200528))
				end

				return
			elseif var_6_0.item_type == var_0_12.ITEM_CONST.ITEM_TYPE.WORLD_RED_PACKET then
				if not var_0_3:isModuleUnlock(var_0_12.FUNCTION_TYPE.WORLD_RED_PACKET) then
					var_0_9:tip((var_0_3:getUnlockTxt(var_0_12.FUNCTION_TYPE.WORLD_RED_PACKET)))

					return
				end

				g.core.module.ModuleManager:pushPopup(require("app.view.module.worldRedPacket.view.WorldRedPacketUsePop").new({
					itemInfo = var_6_0,
					callback = handler(self, self._onVoucherPopClosed)
				}), {
					touchDisappear = true
				})

				return
			elseif var_6_0.item_type == var_0_12.ITEM_CONST.ITEM_TYPE.DAILY_BOX_GAME then
				require("app.view.module.goldSaving.const.GoldSavingGameHelper").openGame((g.core.config.gold_saving_game_info.get(var_6_0.item_value)))

				return
			end

			dump(var_6_0.id)

			if var_6_1 > 1 then
				require("app.view.base.infoPop.BaseUsePop").createUse(self._data.value, handler(self, self._onUseOkHandler))
			else
				var_0_13:send_C2S_Item_Use({
					num = 1,
					id = var_6_0.id
				})
			end
		elseif var_6_0.use_type == BagNewPropCfg.USE_TYPE.SELECT then
			require("app.view.module.bagNew.view.popup.BagNewSelectPop").createUse(self._data.value, handler(self, self._onUseOkHandler))
		elseif var_6_0.use_type == BagNewPropCfg.USE_TYPE.MATERIAL then
			if var_6_0.source_id == 23 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_COMMON_CHANGE_TAB, false, {
					type = require("app.view.module.bagNew.const.BagNewFuncCfg").FUNC_TYPE.EQUIPMENT
				})
			elseif var_6_0.source_id == 25 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_COMMON_CHANGE_TAB, false, {
					type = require("app.view.module.bagNew.const.BagNewFuncCfg").FUNC_TYPE.TREASURE
				})
			else
				local var_6_3 = var_0_0:getWeddingSpRingAdvId(self._data.value)

				if var_6_3 > 0 then
					if var_0_3:checkModuleUnlockStatus(var_0_12.FUNCTION_TYPE.WEDDING_VOW) then
						local var_6_4 = var_0_1:getKnight({
							advance_id = var_6_3
						})

						if var_6_4:isOwn() then
							if var_0_0:isWeddingVowByKnightId(var_6_3) then
								var_0_13:send_C2S_Item_Use({
									num = 1,
									id = var_6_0.id
								})
							else
								var_0_9:pushModule(g.view.entrance.KNIGHT_DEVELOP, {
									popWeddingPop = true,
									group = 0,
									knightSid = var_6_4:getServerId()
								})
							end
						else
							g.core.module.ModuleManager:tip(g.core.lang:get(412027))
						end
					end
				elseif var_6_0.source_id > 0 then
					var_0_10:gotoModule(var_6_0.source_id)
				end
			end
		end
	elseif self._data.type == var_0_12.BAG_TYPE.ADVANCE_EQUIPMENT then
		-- block empty
	elseif self._data.type == var_0_12.BAG_TYPE.EXPIRABLE_ITEM then
		local var_6_5 = var_0_8.get(self._data.value)

		if var_6_5.source_id > 0 then
			var_0_10:gotoModule(var_6_5.source_id)
		elseif var_6_5.item_type == 1 then
			if g.core.common.ServerTime:getLeftSeconds(self._data.time) > 0 then
				if g.core.guide.GuideProxy:isGuideRunning() then
					return
				elseif g.core.utils.Tools.checkSilentFull() ~= 0 then
					require("upgrade.UpgradeSilent").showUpgradeTip()

					return
				end

				g.core.module.ModuleManager:pushPopup(require("app.view.module.discountCoupon.DiscountCouponPop").new({
					value = self._data.value,
					type = g.core.common.Goods.TYPE_EXPIRABLE_ITEM,
					size = self._data.size,
					endTime = self._data.time,
					onlyId = self._data.onlyId,
					callback = handler(self, self._onVoucherPopClosed)
				}), {
					touchDisappear = true
				})
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(410202))
			end
		end
	end
end

function BagNewShowInfoComp:_onInfoClick()
	if self._goodInfo then
		g.core.common.GlobalFunc.pushInfoPop(self._goodInfo)
	end
end

function BagNewShowInfoComp:_onUseOkHandler(arg_9_1)
	local var_9_0 = var_0_7.get(arg_9_1.id)

	if arg_9_1.count <= 0 then
		return
	end

	if var_9_0.use_type == 1 then
		var_0_13:send_C2S_Item_Use({
			id = arg_9_1.id,
			num = arg_9_1.count
		})
	end

	if var_9_0.use_type == 2 then
		var_0_13:send_C2S_Item_Use({
			id = arg_9_1.id,
			num = arg_9_1.count
		})
	end

	if var_9_0.use_type == 3 then
		var_0_13:send_C2S_Item_Use({
			id = arg_9_1.id,
			num = arg_9_1.count,
			index = arg_9_1.selectedIndex
		})
	end
end

function BagNewShowInfoComp:_onUseRecvHandler(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_4.num or 0
	local var_10_1 = var_0_7.get(arg_10_4.id)
	local var_10_3 = var_0_5:get(300001)

	if var_10_0 > 0 then
		if var_10_1.use_type == 1 then
			var_0_9:tip(var_10_1.use_text)
		end

		if var_10_1.use_type == 3 and arg_10_4.awards then
			var_0_9:awardSummary(arg_10_4.awards, false, nil, var_10_3)
		end

		if var_10_1.use_type == 2 then
			if arg_10_4.awards then
				var_0_9:awardSummary(arg_10_4.awards, false, nil, var_10_3)
			else
				var_0_9:tip(var_0_5:get(1013))
			end
		end

		if var_10_1.use_type == 4 and arg_10_4.awards then
			var_0_9:awardSummary(arg_10_4.awards, false, nil, var_10_3)
		end

		self:dispatchCompEvent(BagNewPropCfg.EVENT.REFRESH_BAG_DATA)

		if var_10_1.item_type == g.core.common.Goods.ITEM.TYPE_USER_FRAME then
			g.core.network.GameNetProxy:send_C2S_FrameInfo({})
		end
	end
end

function BagNewShowInfoComp:_onVoucherPopClosed()
	self:dispatchCompEvent(BagNewPropCfg.EVENT.REFRESH_BAG_DATA)
end

return BagNewShowInfoComp
