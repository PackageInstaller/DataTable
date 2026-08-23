local RebornConst = require("app.view.module.reborn.const.RebornConst")
local var_0_2 = g.core.const.ConstMgr.BAG_TYPE
local KnightSoulUnloadPop = class("KnightSoulUnloadPop", require("app.fairyGUI.knightSoul.UI_KnightSoulUnloadPop"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulUnloadPop",
		pkgPath = "ui/knightSoul/knightSoul",
		pkgName = "knightSoul"
	}, ...)
end)

function KnightSoulUnloadPop:ctor(arg_2_1)
	self:showAtCenter()

	self._bookStruct = arg_2_1.bookStruct
	self._cfg = nil
	self._needKnightList = self._bookStruct:getNeedKnightSoulList()

	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
	self.m_needKnightList:setVirtual()
	self.m_needKnightList:setItemRenderer(handler(self, self._onRenderKsoulList))
	self:_updateView()
end

function KnightSoulUnloadPop:_updateView()
	self.m_needKnightList:setNumItems(#self._needKnightList)

	local var_3_0 = self._bookStruct:getCfg()

	self._cfg = var_3_0

	self.m_numComp:updateByTVS({
		type = var_3_0.reset_type,
		value = var_3_0.reset_value,
		size = var_3_0.reset_size
	})
end

function KnightSoulUnloadPop:_onClickConfirmBtn()
	if self._cfg then
		if self._cfg.reset_size <= g.core.model.User:getFreeGold() then
			g.core.network.GameNetProxy:send_C2S_Reborn_Execute({
				sys_type = RebornConst.TYPE_KNIGHT_SOUL,
				op_type = RebornConst.OP_TYPE_REBORN,
				ids = {
					self._bookStruct:getId()
				}
			})
			self:_onClose()
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				value = 0,
				type = 999,
				size = self._cfg.reset_size
			})
		end
	end
end

function KnightSoulUnloadPop:_onClickCancelBtn()
	self:_onClose()
end

function KnightSoulUnloadPop:_onRenderKsoulList(arg_6_1, arg_6_2)
	arg_6_2:updateIcon({
		overrideClick = true,
		type = var_0_2.KSOUL,
		value = self._needKnightList[arg_6_1 + 1],
		size = self._bookStruct:getStarNum()
	})
end

function KnightSoulUnloadPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function KnightSoulUnloadPop:_onRefreshDiamond()
	self.m_numComp:updateByTVS({
		type = self._cfg.reset_type,
		value = self._cfg.reset_value,
		size = self._cfg.reset_size
	})
end

function KnightSoulUnloadPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, self._onRefreshDiamond, self)
end

return KnightSoulUnloadPop
