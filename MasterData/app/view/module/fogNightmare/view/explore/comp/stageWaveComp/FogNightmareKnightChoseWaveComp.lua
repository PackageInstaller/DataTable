local FogNightmareKnightChoseWaveComp = class("FogNightmareKnightChoseWaveComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareKnightChoseWaveComp"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareKnightChoseWaveComp",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = false,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareKnightChoseWaveComp:ctor()
	self._effectStrcut = nil
	self._knights = nil

	self:_initView()
end

function FogNightmareKnightChoseWaveComp:_initView()
	self.m_knightList:setVirtual(self)
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightItemRender))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onKnightItemSelected))
end

function FogNightmareKnightChoseWaveComp:_onKnightItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateComp(self._knights[arg_4_1 + 1])
end

function FogNightmareKnightChoseWaveComp:_onKnightItemSelected()
	self._effectStrcut:setUpKnight(self._knights[self.m_knightList:getSelectedIndex() + 1])
end

function FogNightmareKnightChoseWaveComp:updateComp(arg_6_1)
	self._effectStrcut = arg_6_1:getRealEffect()
	self._knights = self._effectStrcut:getCanUpKnights()

	self.m_knightList:setNumItems(#self._knights)
end

function FogNightmareKnightChoseWaveComp:_updateEmptyComp()
	self.m_hasKnightController:setSelectedIndex(0)
	self.m_leftQualityLoader:setURL("ui://base_new/pic_wjmy_bz_yht_l_4")
end

return FogNightmareKnightChoseWaveComp
