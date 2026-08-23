local SuccubaMainInfoPop = class("SuccubaMainInfoPop", require("app.fairyGUI.succuba.UI_SuccubaMainInfoPop"), function()
	return fgui.GComponent:create({
		pkgName = "succuba",
		resName = "SuccubaMainInfoPop",
		pkgPath = "ui/succuba/succuba"
	}, ...)
end)

function SuccubaMainInfoPop:ctor(arg_2_1)
	self._succuba = arg_2_1

	local var_2_0 = self._succuba:getMineInteractionCfgList()

	self._interactionList = {}

	for iter_2_0 = 2, #var_2_0 do
		self._interactionList[#self._interactionList + 1] = var_2_0[iter_2_0]
	end

	self._interactionLevel = self._succuba:getInteractionLevel()

	self:_initPop()
	self:showAtCenter()
end

function SuccubaMainInfoPop:_initPop()
	self.m_textList:setVirtual(self)
	self.m_textList:setItemRenderer(handler(self, self._onRenderTextItem))
end

function SuccubaMainInfoPop:_onRenderTextItem(arg_4_1, arg_4_2)
	arg_4_2:updateTextUI(self._interactionList[arg_4_1 + 1], self._interactionLevel)
end

function SuccubaMainInfoPop:onLoad()
	self.m_titleComp:updateCompUI(self._succuba)
	self.m_textList:setNumItems(#self._interactionList)
end

function SuccubaMainInfoPop:onCancelCallback()
	self.m_backTransition:play(handler(self, function(arg_7_0)
		g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_7_0)
	end))
end

return SuccubaMainInfoPop
