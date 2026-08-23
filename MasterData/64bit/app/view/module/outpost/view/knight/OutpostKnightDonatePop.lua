local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.outpostConst
local OutpostKnightDonatePop = class("OutpostKnightDonatePop", require("app.fairyGUI.outpost.UI_OutpostKnightDonatePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostKnightDonatePop",
		pkgName = "outpost",
		isFullScreen = false
	}, ...)
end)

function OutpostKnightDonatePop:ctor(arg_2_1)
	self._struct = arg_2_1.struct
	self._ownCoinNum = 0
	self._knightCoinNum = 0
	self._exchangeNum = 0
	self._isNotInit = true
	self._onceMaxNum = g.core.config.outpost_parameter_info.get(var_0_2.ParameterID.MAX_DONATE_NUM).parameter

	self.m_selNumTxt:disableAutoChange()
	self:showAtCenter()
	self:updateInitShow()
end

function OutpostKnightDonatePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_DONATEKNIGHT, handler(self, self._onKnightDonateSucc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onUpdateOwnNum), self)
end

function OutpostKnightDonatePop:_onKnightDonateSucc()
	self:updateInitShow()
	g.core.module.ModuleManager:tip(g.core.lang:get(432651))
end

function OutpostKnightDonatePop:_onUpdateOwnNum()
	self._ownCoinNum = var_0_1:getBagData():getOwnNum(var_0_2.KNIGHT_COIN_ID)

	self:updateDonateShow()
end

function OutpostKnightDonatePop:updateInitShow()
	self._exchangeNum = 0

	self.m_selNumTxt:setText(self._exchangeNum)

	local var_6_0 = g.core.common.Path:getOutpostItemIcon(g.core.config.outpost_item_info.get(var_0_2.KNIGHT_COIN_ID).icon, true)

	self.m_coinIcon:setIcon(var_6_0)
	self.m_coinIcon1:setIcon(var_6_0)
	self.m_coinIcon2:setIcon(var_6_0)

	self._ownCoinNum = var_0_1:getBagData():getOwnNum(var_0_2.KNIGHT_COIN_ID)
	self._knightCoinNum = self._struct:getOwnCoinNum()

	if not self._spine then
		self._spine = BattleKnight.new({
			resId = self._struct:getCfg().advance_id
		})

		self.m_knightHolder:addNode(self._spine)
	end

	if self._isNotInit then
		for iter_6_0, iter_6_1 in ipairs({
			"1",
			"2",
			"3",
			"4",
			"5",
			"6",
			"7",
			"8",
			"9",
			"0",
			"00",
			"000"
		}) do
			self["m_num" .. iter_6_1]:addClickListener(handler(self, self.onNumberClick))
		end

		self.m_changeBtn:addClickListener(handler(self, self._onChangeClick))
		self.m_confirmBtn:addClickListener(handler(self, self.onDonateClick))

		self._isNotInit = false
	end

	self:updateDonateShow()
end

function OutpostKnightDonatePop:updateDonateShow()
	self.m_coinOwnNum:setText(self._ownCoinNum - self._exchangeNum)
	self.m_coinKnightNum:setText(self._knightCoinNum + self._exchangeNum)
end

function OutpostKnightDonatePop:onNumberClick(arg_8_1)
	local var_8_0 = arg_8_1:getSender()
	local var_8_1 = self.m_selNumTxt:getText()
	local var_8_2 = (var_8_1 == "0" and "" or var_8_1) .. string.match(var_8_0:getName(), "num(%d+)")

	if tonumber(var_8_2) > self._ownCoinNum then
		var_8_2 = self._ownCoinNum
	end

	self._exchangeNum = tonumber(var_8_2)

	if self._exchangeNum > self._onceMaxNum then
		self._exchangeNum = self._onceMaxNum

		g.core.module.ModuleManager:tip(g.core.lang:get(432665))
	end

	self.m_selNumTxt:setText(self._exchangeNum)
	self:updateDonateShow()
end

function OutpostKnightDonatePop:_onChangeClick()
	self._exchangeNum = 0

	self.m_selNumTxt:setText(self._exchangeNum)
	self:updateDonateShow()
end

function OutpostKnightDonatePop:onDonateClick()
	if self._exchangeNum > 0 then
		g.core.network.GameNetProxy:send_C2S_Outpost_DonateKnight({
			knight_id = self._struct:getServerId(),
			coin_num = self._exchangeNum
		})
	end
end

return OutpostKnightDonatePop
