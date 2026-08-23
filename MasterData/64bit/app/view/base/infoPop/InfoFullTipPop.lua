local var_0_0 = g.core.const.ConstMgr.InfoConst
local InfoFullTipPop = class("InfoFullTipPop", require("app.fairyGUI.infoPop.UI_InfoFullTipPop"), function()
	local var_1_0 = ({
		...
	})[1].typeValue or var_0_0.InfoTipPopType.BASE_TIP

	return fgui.GComponent:create({
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop",
		resName = var_0_0.InfoTipPopName[var_1_0]
	}, ...)
end)

function InfoFullTipPop:ctor(arg_2_1)
	self:showAtCenter()

	self._params = arg_2_1 or {}
	self._descCompHeightSize = self.m_descTxt:getSize().height
	self.m_text = self.m_descTxt:getChild("title")
end

function InfoFullTipPop:onLoad()
	self.m_descTxt:setText(self._params.desc or "")
	self:_setTitleName()
	self:_adjustPos()
end

function InfoFullTipPop:_setTitleName()
	if self._params.title and self._params.title ~= "" and self.m_popPanel then
		self.m_popPanel:setTitle(self._params.title)
	end
end

function InfoFullTipPop:_adjustPos()
	local var_5_0 = self.m_text:getSize().height

	if var_5_0 < self._descCompHeightSize then
		self.m_text:setY(self._descCompHeightSize / 2 - var_5_0 / 2)
	end
end

return InfoFullTipPop
