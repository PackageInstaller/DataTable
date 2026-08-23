local SpireDeepDetailPop = class("SpireDeepDetailPop", require("app.fairyGUI.spire.UI_SpireDeepDetailPop"), function()
	return fgui.GComponent:create({
		resName = "SpireDeepDetailPop",
		pkgPath = "ui/spire/spire",
		pkgName = "spire"
	}, ...)
end)

function SpireDeepDetailPop:ctor(arg_2_1)
	self._buffList = arg_2_1

	self:initView()
	self:showAtCenter()
end

function SpireDeepDetailPop:initView()
	self.m_buffList:setVirtual()
	self.m_buffList:setItemRenderer(handler(self, self._onRenderList))
	self.m_buffList:setNumItems(#self._buffList)
end

function SpireDeepDetailPop:_onRenderList(arg_4_1, arg_4_2)
	arg_4_2:getChild("title"):enableRich()

	local var_4_0, var_4_1 = g.core.utils.String.formatPassiveSkillDesc(self._buffList[arg_4_1 + 1])

	arg_4_2:setTitle(g.core.lang:get(432023, {
		index = arg_4_1 + 1,
		des = var_4_0
	}))
end

return SpireDeepDetailPop
