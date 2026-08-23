local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.BAG_TYPE
local KnightSoulInfoComp = class("KnightSoulInfoComp", require("app.fairyGUI.knightSoul.UI_KnightSoulInfoComp"))

function KnightSoulInfoComp:ctor()
	self.m_bgDiLoader:setURL("pic/base_new/bg_yht_hz_right.png")
	self.m_lookBtn:addClickListener(handler(self, self._onClickLookBtn))
end

function KnightSoulInfoComp:updateInfoComp(arg_2_1)
	self._itemData = arg_2_1
	self._ksoulInfo = arg_2_1.info

	self.m_titleTxt:setText(self._ksoulInfo.name)
	self.m_picBgLoader:setURL(var_0_0:getBagNewQualityBgPath(self._ksoulInfo.quality))
	self.m_haveTxt:setText(arg_2_1.size)
	self.m_descTxt:setText(self._ksoulInfo.description)
	self.m_iconLoader:updateCard({
		kSoulId = self._ksoulInfo.id,
		num = self._itemData.size
	})
end

function KnightSoulInfoComp:_onClickLookBtn()
	if self._ksoulInfo.id > 0 then
		g.core.common.GlobalFunc.pushInfoPop({
			type = var_0_1.KSOUL,
			value = self._ksoulInfo.id,
			size = self._itemData.size
		})
	end
end

return KnightSoulInfoComp
