local var_0_0 = g.core.model.User.doubleElevenData
local DoubleElevenPop = class("DoubleElevenPop", require("app.fairyGUI.doubleEleven.UI_DoubleElevenPop"), function()
	return fgui.GComponent:create({
		resName = "DoubleElevenPop",
		pkgPath = "ui/doubleEleven/doubleEleven",
		pkgName = "doubleEleven"
	}, ...)
end)

function DoubleElevenPop:ctor()
	self._productList = nil

	self:showAtCenter()
	self.m_goodsList:setVirtual()
	self.m_goodsList:doFairyBatching(false)
	self.m_goodsList:setItemRenderer(handler(self, self._onGoodsListRender))
	self.m_closeBtn:addClickListener(handler(self, self._closePop))
	self:updateView()

	local var_2_0 = var_0_0:getCurActivityType()

	self.m_displayTypeController:setSelectedIndex(var_2_0)

	if var_2_0 == 1 or var_2_0 == 14 then
		self.m_enterEffect:addEffectSpine({
			remove = true,
			name = "eff_ui_newYear_enter",
			isLoop = false
		})
		self.m_idleEffect:addEffectSpine({
			anim = "idle",
			name = "eff_ui_doubleEleven_enter",
			isLoop = true
		})
	elseif var_2_0 == 2 or var_2_0 == 3 then
		self.m_enterNYEffect:addEffectSpine({
			remove = true,
			name = "eff_ui_newYear_enter",
			isLoop = false
		})
		self.m_idleNYEffect:addEffectSpine({
			anim = "idle",
			name = "eff_ui_newYear_enter",
			isLoop = true
		})
	end

	if var_2_0 == 6 or var_2_0 == 7 then
		self.m_enter6Transition:play()
	else
		self.m_enterTransition:play()
	end

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.DOUBLE_ELEVEN)
end

function DoubleElevenPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self.updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_AWARD, handler(self, self._onRechargeAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
end

function DoubleElevenPop:_onGoodsListRender(arg_4_1, arg_4_2)
	if self._productList and self._productList[arg_4_1 + 1] then
		arg_4_2:updateCell(self._productList[arg_4_1 + 1], true)
	end
end

function DoubleElevenPop:updateView()
	self._productList = var_0_0:getGiftArr()

	self.m_goodsList:setNumItems(#self._productList)
	self.m_goodsList:transitionShowCells("listCardAUiLeftIn", 0.03, 1)
end

function DoubleElevenPop:_closePop()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function DoubleElevenPop:_onRechargeAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = {}

	if arg_7_4.awards and next(arg_7_4.awards) then
		for iter_7_0, iter_7_1 in ipairs(arg_7_4.awards) do
			if iter_7_1.size ~= 0 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		g.core.module.ModuleManager:awardSummary(var_7_0)
	end
end

function DoubleElevenPop:_onCrossDayUpdate()
	if not var_0_0:checkActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(410311))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end
end

return DoubleElevenPop
