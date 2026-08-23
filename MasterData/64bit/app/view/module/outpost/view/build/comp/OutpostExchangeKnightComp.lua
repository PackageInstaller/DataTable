local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostExchangeKnightComp = class("OutpostExchangeKnightComp", require("app.fairyGUI.outpost.UI_OutpostExchangeKnightComp"))

function OutpostExchangeKnightComp:ctor()
	self._buildType = var_0_0.BuildType.None
	self._pos = -1
	self._knight = nil
	self._equipList = nil

	self:_initComp()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function OutpostExchangeKnightComp:_initComp()
	self.m_itemList:setVirtual(self)
	self.m_itemList:doFairyBatching(false)
	self.m_itemList:setItemRenderer(handler(self, self._onItemRender))
	self.m_callBtn:addClickListener(handler(self, self._onCallBtnClicked))
end

function OutpostExchangeKnightComp:setBuildType(arg_3_1)
	self._buildType = arg_3_1
end

function OutpostExchangeKnightComp:updateKnightComp(arg_4_1, arg_4_2)
	self._pos = arg_4_2
	self._knight = arg_4_1.knight

	self.m_knightComp:updateKnightWithStruct(arg_4_1.knight)

	self._itemList = arg_4_1.itemList

	self.m_itemList:setNumItems(math.max(8, #self._itemList))
end

function OutpostExchangeKnightComp:_onItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateItemComp(self._itemList[arg_5_1 + 1])
end

function OutpostExchangeKnightComp:_onCallBtnClicked()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_CALL_KNIGHT_TO_BUILD, false, 0, {
		knightId = self._knight:getServerId(),
		buildType = self._buildType
	})

	local var_6_0, var_6_1 = g.core.model.User.outpostData:getBuildData():isInConsumptionBuilding(self._knight:getServerId())

	if var_6_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432646, {
			kName = self._knight:getCfg().name,
			bName = var_6_1:getBuildCfg().name
		}))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432647))
	end

	self:dispatchCompEvent("callKnight", {
		sid = self._knight:getServerId(),
		pos = self._pos
	})
end

function OutpostExchangeKnightComp:playUpEffect()
	self.m_upTransition:play()
end

return OutpostExchangeKnightComp
