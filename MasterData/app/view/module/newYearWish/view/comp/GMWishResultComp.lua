local var_0_0 = g.core.model.User.newYearWishData
local NewYearWishConst = require("app.view.module.newYearWish.const.NewYearWishConst")
local var_0_2 = g.core.common.Drops
local var_0_3 = g.core.common.Path
local GMWishResultComp = class("GMWishResultComp", require("app.fairyGUI.newYearWish.UI_GMWishResultComp"))

function GMWishResultComp:ctor()
	self._info = var_0_0:getCurInfo()
	self._showIndex = 0
	self._awardList = {}
	self._giftList = {}

	self:_initGMUI()
	self:_initView()
end

function GMWishResultComp:_initView()
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

function GMWishResultComp:_initGMUI()
	local var_3_0 = var_0_0:getResId()
	local var_3_1 = var_0_3:getGMWishResultPopRes(var_3_0) .. NewYearWishConst.GM_COLOR_TYPE[var_3_0]

	for iter_3_0 = 1, 2 do
		self["m_diban" .. iter_3_0]:setURL(var_3_1 .. NewYearWishConst.GM_RES_NAME.BG .. iter_3_0 .. ".png")
	end

	for iter_3_1 = 1, 2 do
		self["m_zidi" .. iter_3_1]:setURL(var_3_1 .. NewYearWishConst.GM_RES_NAME.ZIDI .. iter_3_1 .. ".png")
	end

	self.m_ribbon:setURL(var_3_1 .. NewYearWishConst.GM_RES_NAME.RIBBON .. "1.png")
	self.m_titleTxt:setColor(cc.c3b(NewYearWishConst.GM_TEXT_COLOR[var_3_0][1], NewYearWishConst.GM_TEXT_COLOR[var_3_0][2], NewYearWishConst.GM_TEXT_COLOR[var_3_0][3]))
end

function GMWishResultComp:_onClickCell(arg_4_1)
	local var_4_0 = arg_4_1:getDataValue()

	if not self._giftList[var_4_0 + 1] then
		return
	end

	if self._giftList[var_4_0 + 1].times > self._giftList[var_4_0 + 1].buyTimes then
		self._giftList[var_4_0 + 1].icon = string.format("icon_%s_libao%d_2", NewYearWishConst.GM_COLOR_TYPE[var_0_0:getResId()], var_4_0 + 1)

		g.core.module.ModuleManager:pushPopup((require("app.view.module.recharge.view.RechargeGiftPop").new(self._giftList[var_4_0 + 1], true)))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(408003))
	end
end

function GMWishResultComp:_onRenderAwardList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._awardList[arg_5_1 + 1], (var_0_0:isGetReward()))
end

function GMWishResultComp:_onRenderGiftList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._giftList[arg_6_1 + 1], arg_6_1)
end

function GMWishResultComp:updateView()
	self._awardList = self._info.drop > 0 and var_0_2:getGoodsArray(self._info.drop) or {}

	self.m_awardList:setNumItems(#self._awardList)

	self._giftList = var_0_0:getGiftArr()

	self.m_giftList:setNumItems(#self._giftList)
end

return GMWishResultComp
