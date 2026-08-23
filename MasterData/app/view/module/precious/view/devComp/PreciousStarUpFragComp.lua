local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User.fragmentsData
local PreciousStarUpFragComp = class("PreciousStarUpFragComp", require("app.fairyGUI.precious.UI_PreciousStarUpFragComp"))

function PreciousStarUpFragComp:ctor()
	self._precious = nil
	self._canStarUp = false

	self.m_fragBtn:addClickListener(handler(self, self._onFragBtnClick))
	self.m_starUpBtn:addClickListener(handler(self, self._onStarUpBtnClick))
	self.m_sellBtn:addClickListener(handler(self, self._onSellBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
end

function PreciousStarUpFragComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_TRANSFORM, handler(self, self._updateFragNum), self)
end

function PreciousStarUpFragComp:receiveCompEvent(arg_3_1)
	if arg_3_1 == "FragSellPopClose" then
		self:updateComp(self._precious)
	end
end

function PreciousStarUpFragComp:updateComp(arg_4_1)
	self._precious = arg_4_1
	self._canStarUp = arg_4_1:isCanStarUp()

	local var_4_0 = arg_4_1:getCfg().fragment_id
	local var_4_1 = var_0_3:getFragmentNumById(var_4_0)

	if self:_isFullStar() then
		self.m_fullFragItemIcon:updateIcon({
			type = var_0_2.TYPE_FRAGMENT,
			value = var_4_0,
			size = var_4_1
		})
	else
		self.m_fragItemIcon:updateIcon({
			type = var_0_2.TYPE_FRAGMENT,
			value = var_4_0,
			size = var_4_1
		})
		self.m_name:setText(g.core.config.fragment_info.get(var_4_0).name)
		self:_updateFragNum()
	end
end

function PreciousStarUpFragComp:_onFragBtnClick()
	if self._canStarUp then
		var_0_1:tip(g.core.lang:get(421231))

		return
	end

	local var_5_0 = self._precious:getCfg()
	local var_5_1 = g.core.config.fragment_info.get(var_5_0.fragment_id)

	if #g.core.model.User.ableFragmentData:getAbleFragmentPreciousList(var_5_1.quality, var_5_1.rare) > 0 then
		local AbleFragmentConvertPop = require("app.view.base.infoPop.AbleFragmentConvertPop")

		var_0_1:pushPopup((AbleFragmentConvertPop.new({
			id = var_5_0.fragment_id,
			type = AbleFragmentConvertPop.PRECIOUS,
			num = var_5_0.next_star_num - var_0_3:getFragmentNumById(var_5_0.fragment_id)
		})))
	else
		local var_5_3 = g.core.model.User.ableFragmentData:getAbleFragmentId(var_5_0.fragment_id, var_0_0.PreciousConst.PRECIOUS_ABLE_FRAGMENT_TYPE)

		if var_5_3 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_0_2.TYPE_ITEM,
				value = var_5_3,
				size = g.core.model.User.bagData:getOwnNum(var_0_2.TYPE_ITEM, var_5_3)
			})
		else
			var_0_1:tip(g.core.lang:get(421232))
		end
	end
end

function PreciousStarUpFragComp:_onStarUpBtnClick()
	if self._canStarUp then
		g.core.network.GameNetProxy:send_C2S_Precious_StarUp({
			advance_id = self._precious:getAdvId()
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ZC_Upgrade_Result)
	else
		local var_6_0 = self._precious:getCfg()
		local var_6_1 = {
			type = var_0_2.TYPE_FRAGMENT,
			value = var_6_0.fragment_id
		}

		var_6_1.size = g.core.model.User.bagData:getOwnNum(var_0_2.TYPE_FRAGMENT, var_6_0.fragment_id)

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource(var_6_1)
	end
end

function PreciousStarUpFragComp:_onSellBtnClick()
	local var_7_0 = require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.preciousData:getCanSellPreciousFragDataList(), {
		fragNameId = 421228,
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.PRECIOUS],
		title = g.core.lang:get(421230)
	})

	self:addListen(var_7_0)
	g.core.module.ModuleManager:pushPopup(var_7_0)
end

function PreciousStarUpFragComp:_onShopBtnClick()
	var_0_1:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_0.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_0.ShopConst.SHOP_TYPE.PRECIOUS
	})
end

function PreciousStarUpFragComp:_updateFragNum()
	if self:_isFullStar() then
		return
	end

	self._canStarUp = self._precious:isCanStarUp()

	local var_9_0 = self._precious:getCfg()
	local var_9_1 = math.min(var_0_3:getFragmentNumById(var_9_0.fragment_id), var_9_0.next_star_num)

	self.m_numText:setText(var_9_1 .. "/" .. var_9_0.next_star_num)
	self.m_fragProgBar:setPercent({
		init = 0,
		cur = var_9_1,
		max = var_9_0.next_star_num
	})
	self.m_enoughController:setSelectedIndex(self._canStarUp and 1 or 0)
end

function PreciousStarUpFragComp:_isFullStar()
	local var_10_0 = self.m_fullStarController:getSelectedIndex()

	return var_10_0 == 1 or var_10_0 == 2
end

return PreciousStarUpFragComp
