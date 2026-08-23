local TreeModuleComp = class("TreeModuleComp", require("app.fairyGUI.tree.UI_TreeModuleComp"))
local var_0_1 = {
	[0] = "play2",
	"play4",
	"play1",
	"play3"
}

function TreeModuleComp:ctor()
	self._isPlayEff = false

	self:initView()
end

function TreeModuleComp:initView()
	self:addClickListener(handler(self, self._onClickComp))
end

function TreeModuleComp:_onClickComp()
	if not self._isPlayEff then
		self:playEff()
	end
end

function TreeModuleComp:playEff()
	self._isPlayEff = true

	self.m_eff:addEffectSpine({
		name = "eff_ui_tree_arrow",
		isLoop = false,
		remove = true,
		anim = var_0_1[self.m_moduleController:getSelectedIndex()],
		eventHandler = handler(self, self._onAnimEnd)
	})
end

function TreeModuleComp:_onAnimEnd(arg_5_1)
	if arg_5_1.type == "complete" then
		self._isPlayEff = false
	end
end

return TreeModuleComp
