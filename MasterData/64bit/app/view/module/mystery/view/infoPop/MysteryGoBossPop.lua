local var_0_0 = g.core.model.User.mysteryData
local MysteryGoBossPop = class("MysteryGoBossPop", require("app.fairyGUI.mystery.UI_MysteryGoBossPop"), function()
	return fgui.GComponent:create({
		pkgName = "mystery",
		resName = "MysteryGoBossPop",
		pkgPath = "ui/mystery/mystery"
	}, ...)
end)

function MysteryGoBossPop:ctor()
	self:showAtCenter()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
	self.m_goBattleBtn:addClickListener(handler(self, self._onClickGoBossPos))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
	self.m_touchArea:addClickListener(handler(self, self._onClickClose))
	self.m_enterTransition:play()
end

function MysteryGoBossPop:onLoad()
	self._chapterData = var_0_0:getChapterDataById((var_0_0:getCurChapterId()))

	local var_3_0 = self._chapterData:getEliteMonsterCfg()

	self._eliteInfo = var_3_0

	self.m_knightPicComp:updateKnight({
		resId = tonumber(g.core.config.knight_base_info.get(var_3_0.knight_base).fight_id)
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)
	self.m_bossNameTxt:setText(var_3_0.stage_name)

	self._awards = var_0_0:getStageDataById(var_3_0.id):getDropAwards()

	self.m_awardList:setNumItems(#self._awards)
end

function MysteryGoBossPop:_onAwardItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._awards[arg_4_1 + 1])
end

function MysteryGoBossPop:_onClickCancelBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function MysteryGoBossPop:_onClickGoBossPos()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_GOTO_TERMINUS, true, {
		self._eliteInfo.number
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function MysteryGoBossPop:_onClickClose()
	self.m_backTransition:play(handler(self, self._onClose))
end

function MysteryGoBossPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return MysteryGoBossPop
