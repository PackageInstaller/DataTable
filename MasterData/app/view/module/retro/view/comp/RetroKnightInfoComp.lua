local RetroKnightInfoComp = class("RetroKnightInfoComp", require("app.fairyGUI.retro.UI_RetroKnightInfoComp"))

function RetroKnightInfoComp:ctor()
	self.m_nameComp:addClickListener(handler(self, self._onClickNameComp))
end

function RetroKnightInfoComp:updateInfo(arg_2_1, arg_2_2)
	self._knightInfo = g.core.config.knight_info.get(arg_2_1["role_" .. arg_2_2])

	self.m_knightIcon:setIcon((g.core.common.Path:getKnightBookPicRes(self._knightInfo.res_id)))
	self.m_nameComp:updateName(self._knightInfo)
end

function RetroKnightInfoComp:_onClickNameComp()
	g.core.common.GlobalFunc.pushInfoPop({
		type = g.core.common.Goods.TYPE_KNIGHT,
		value = self._knightInfo.id
	})
end

return RetroKnightInfoComp
