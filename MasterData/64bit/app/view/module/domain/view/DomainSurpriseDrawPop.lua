local var_0_0 = g.core.model.User.domainData
local DomainSurpriseDrawPop = class("DomainSurpriseDrawPop", require("app.fairyGUI.domainDungeon.UI_DomainSurpriseDrawPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/domainDungeon/domainDungeon",
		resName = "DomainSurpriseDrawPop",
		pkgName = "domainDungeon"
	}, ...)
end)

function DomainSurpriseDrawPop:ctor(arg_2_1)
	self.m_touchArea:setSize(display.width, display.height)
	self:showAtCenter()

	self._isPlayEnd = false
	self._dungeonId = arg_2_1.dungeonId
	self._closeCallBack = arg_2_1.callback

	self:initMainViewUI()
	self:playEnterAnim()
	self.m_touchArea:addClickListener(handler(self, self._onClickClose))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_DoublePrz)
end

function DomainSurpriseDrawPop:initMainViewUI()
	self.m_bgLoader:setURL(var_0_0:getDungeonResource(self._dungeonId, "pic_mnly_jllmdi.png"))
	self.m_bgline1:setURL(var_0_0:getDungeonResource(self._dungeonId, "pic_mnly_jllmxian1.png"))
	self.m_bgline2:setURL(var_0_0:getDungeonResource(self._dungeonId, "pic_mnly_jllmxian2.png"))
	self.m_bgzs1:setURL(var_0_0:getDungeonResource(self._dungeonId, "pic_mnly_jllmzs.png"))
	self.m_bgzs2:setURL(var_0_0:getDungeonResource(self._dungeonId, "pic_mnly_jllmzs2.png"))
end

function DomainSurpriseDrawPop:playEnterAnim()
	self.m_eff:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_domainDungeon_curtainlight_" .. self._dungeonId
	})
	self.m_enterTransition:play(handler(self, self._playTransitionEnd))
end

function DomainSurpriseDrawPop:_playTransitionEnd()
	self._isPlayEnd = true

	self:_onClose()
end

function DomainSurpriseDrawPop:_onClickClose()
	if self._isPlayEnd then
		self:_onClose()
	end
end

function DomainSurpriseDrawPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

function DomainSurpriseDrawPop:onUnload()
	self._isPlayEnd = true
end

return DomainSurpriseDrawPop
