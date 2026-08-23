local var_0_0 = g.core.model.User.richmanData
local RichmanMonsterListComp = class("RichmanMonsterListComp", require("app.fairyGUI.richman.UI_RichmanMonsterListComp"))

function RichmanMonsterListComp:ctor()
	self.m_monsterList:setVirtual()
	self.m_monsterList:setItemRenderer(handler(self, self._renderMonsterItem))
	self:addClickListener(handler(self, self.onClickMonster))
end

function RichmanMonsterListComp:updateMonsterList()
	self._monsterList = var_0_0:getMonsterEventList()

	if #self._monsterList > 0 then
		if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RICH_MAN_FIRST_MONSTER) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
				tickType = 6,
				enum = g.core.const.ConstMgr.GuideConst.ENUM_TICK.RICH_MAN_MONSTER
			})
			g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RICH_MAN_FIRST_MONSTER)
		end

		if var_0_0:isNeedMonsterAnim() then
			self.m_monsterList:scrollToView(0)
		end

		self.m_monsterList:setNumItems(#self._monsterList)
		self:setVisible(true)
	else
		self:setVisible(false)
	end
end

function RichmanMonsterListComp:_renderMonsterItem(arg_3_1, arg_3_2)
	if arg_3_1 == 0 and var_0_0:isNeedMonsterAnim() then
		var_0_0:setNeedMonsterAnim(false)
		arg_3_2.m_eff:addEffectSpine({
			remove = true,
			name = "eff_ui_richman_newBoss",
			isLoop = false
		})
		arg_3_2.m_enterTransition:play()
	end

	arg_3_2:onRichManMonsterRenderer(self._monsterList[arg_3_1 + 1])
end

function RichmanMonsterListComp:onClickMonster()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.richman.view.pop.RichmanMonsterPop").new(), {
		touchDisappear = true
	})
end

return RichmanMonsterListComp
