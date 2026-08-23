local var_0_0 = g.core.model.User.newYearWishData
local var_0_1 = g.core.common.Drops
local NewYearWishResultComp = class("NewYearWishResultComp", require("app.fairyGUI.newYearWish.UI_NewYearWishResultComp"))

function NewYearWishResultComp:ctor()
	self._info = var_0_0:getCurInfo()
	self._showIndex = 0
	self._awardList = {}
	self._giftList = {}

	self:_initView()
end

function NewYearWishResultComp:_initView()
	self.m_numTxt:setText(g.core.lang:get(408001, {
		num = var_0_0:getDrawDays()
	}))
	self.m_titleTxt:setText(self._info.type)
	self.m_descComp1:setTitle(self._info.des_1)
	self.m_descComp2:setTitle(self._info.des_2)
	self.m_descShareComp1:setTitle(self._info.des_1)
	self.m_descShareComp2:setTitle(self._info.des_2)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
	self.m_giftList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCell))
end

function NewYearWishResultComp:_onClickCell(arg_3_1)
	local var_3_0 = self._giftList[arg_3_1:getDataValue() + 1]

	if not var_3_0 then
		return
	end

	if var_3_0.times > var_3_0.buyTimes then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.recharge.view.RechargeGiftPop"):new(true)))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(408003))
	end
end

function NewYearWishResultComp:_onRenderAwardList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._awardList[arg_4_1 + 1], (var_0_0:isGetReward()))
end

function NewYearWishResultComp:_onRenderGiftList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._giftList[arg_5_1 + 1])
end

function NewYearWishResultComp:updateView()
	self._awardList = self._info.drop > 0 and var_0_1:getGoodsArray(self._info.drop) or {}

	self.m_awardList:setNumItems(#self._awardList)

	self._giftList = var_0_0:getGiftArr()

	self.m_giftList:setNumItems(#self._giftList)
end

return NewYearWishResultComp
