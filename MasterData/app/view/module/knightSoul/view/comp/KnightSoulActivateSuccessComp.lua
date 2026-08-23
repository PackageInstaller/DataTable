local var_0_0 = g.core.model.User.knightSoulData
local var_0_1 = g.core.const.ConstMgr.KnightSoulConst
local var_0_2 = g.core.const.ConstMgr.BAG_TYPE
local KnightSoulActivateSuccessComp = class("KnightSoulActivateSuccessComp", require("app.fairyGUI.knightSoul.UI_KnightSoulActivateSuccessComp"))

function KnightSoulActivateSuccessComp:ctor()
	self._bookStruct = nil
	self._needList = {}

	self.m_starComp:initStar({
		index = 3,
		style = 2,
		num = 0,
		max = var_0_1.MAX_STAR_NUM
	})
	self.m_needKnightList:setVirtual()
	self.m_needKnightList:doFairyBatching(false)
	self.m_needKnightList:setItemRenderer(handler(self, self._onRenderNeedList))
end

function KnightSoulActivateSuccessComp:update(arg_2_1)
	self._bookStruct = arg_2_1.bookStruct

	local var_2_0 = arg_2_1.popType or 0

	self.m_typeController:setSelectedIndex(var_2_0)

	if not self._bookStruct then
		return
	end

	if var_2_0 == 0 then
		self.m_honorNum:setText(var_0_0:getCurHonorNum())
	else
		self.m_nameTxt:setText(g.core.lang:get(410615, {
			name = self._bookStruct:getName()
		}))
		self.m_starComp:setStarNum(self._bookStruct:getStarNum())
	end

	self.m_attributes:updateAttributes(self._bookStruct)

	self._needList = self._bookStruct:getNeedKnightSoulList()

	self.m_needKnightList:setNumItems(#self._needList)
end

function KnightSoulActivateSuccessComp:_onRenderNeedList(arg_3_1, arg_3_2)
	arg_3_2:updateIcon({
		overrideClick = true,
		type = var_0_2.KSOUL,
		value = self._needList[arg_3_1 + 1]
	})
end

return KnightSoulActivateSuccessComp
