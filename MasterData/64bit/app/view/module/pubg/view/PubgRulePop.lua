local var_0_0 = g.core.common.Path
local var_0_1 = g.core.config.pubg_help_info
local PubgRulePop = class("PubgRulePop", require("app.fairyGUI.pubg.UI_PubgRulePop"), function()
	return fgui.GComponent:create({
		pkgName = "pubg",
		resName = "PubgRulePop"
	}, ...)
end)

function PubgRulePop:ctor(arg_2_1)
	self._curIdx = 1

	self:_initBtn()
	self:_updateView()
	self:showAtCenter()
	self.m_enterTransition:play()
end

function PubgRulePop:_initBtn()
	self.m_leftArrow:addClickListener(handler(self, self._onLeftArrowClick))
	self.m_rightArrow:addClickListener(handler(self, self._onRightArrowClick))
end

function PubgRulePop:_updateView()
	local var_4_0 = var_0_1.fetch(self._curIdx)

	if var_4_0 then
		self.m_descPic:setURL(var_0_0:getPubgRulePic(var_4_0.pic))
		self.m_title:setText(var_4_0.title)
		self.m_descComp:setTitle(var_4_0.text)
	end

	self.m_leftArrow:setVisible(self._curIdx > 1)
	self.m_rightArrow:setVisible(self._curIdx < var_0_1.getLength())
end

function PubgRulePop:_onLeftArrowClick()
	self._curIdx = math.max(1, self._curIdx - 1)

	self:_updateView()
end

function PubgRulePop:_onRightArrowClick()
	self._curIdx = math.min(self._curIdx + 1, var_0_1.getLength())

	self:_updateView()
end

function PubgRulePop:popSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function PubgRulePop:_onClickClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.popSelf))
end

return PubgRulePop
