local var_0_0 = g.core.model.User.mysteryBossData
local MysteryBossChoosePop = class("MysteryBossChoosePop", require("app.fairyGUI.mystery.UI_MysteryBossChoosePop"), function()
	return fgui.GComponent:create({
		resName = "MysteryBossChoosePop",
		pkgPath = "ui/mystery/mystery",
		pkgName = "mystery"
	}, ...)
end)

function MysteryBossChoosePop:ctor(arg_2_1)
	self:showAtCenter()

	self._bossData = arg_2_1 and arg_2_1.bossData

	if self._bossData then
		self._bossType = self._bossData:getBossType() or var_0_0:getDefaultBossType()
	end

	self._bossTypeDatas = {}
	self._selectIdx = 0

	self.m_tabController:setSelectedIndex(self._bossType - 1)
	self:_initRegisterUI()
	self:_sendMysteryBossInfo()
	self.m_enterTransition:play()
end

function MysteryBossChoosePop:_initRegisterUI()
	self.m_bossList:setVirtual()
	self.m_bossList:setItemRenderer(handler(self, self._onBossListItemRenderer))
	self.m_bossList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickBossList))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickTabChanged))
end

function MysteryBossChoosePop:_onBossListItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._bossTypeDatas[arg_4_1 + 1])
end

function MysteryBossChoosePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_GETINFO, handler(self, self._onS2CMysteryBossGetInfo), self)
end

function MysteryBossChoosePop:_isHaveUnGetBossResultAward()
	if var_0_0:getMysteryBossNotifyAwards() then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.mystery.view.mysteryBoss.MysteryBossResultPop").new(), {
			touchDisappear = false,
			ignoreTouch = true
		})
	end
end

function MysteryBossChoosePop:_updateBossInfo()
	self._bossTypeDatas = var_0_0:getBossDatasByType(self._bossType)

	if self._bossData then
		local var_7_0 = table.indexof(self._bossTypeDatas, self._bossData)

		if var_7_0 and var_7_0 > 0 then
			self._selectIdx = var_7_0 - 1
		end

		self._bossData = nil
	end

	self.m_bossList:setNumItems(#self._bossTypeDatas)

	if self._selectIdx ~= self.m_bossList:getSelectedIndex() then
		self.m_bossList:setSelectedIndex(self._selectIdx)
	end

	self.m_bossInfoComp:updateBossInfo(self._bossTypeDatas[self._selectIdx + 1])
end

function MysteryBossChoosePop:_onClickBossList()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shenshou_Tag1)

	local var_8_0 = self.m_bossList:getSelectedIndex()

	if self._selectIdx == var_8_0 then
		return
	end

	self._selectIdx = var_8_0

	self:_updateBossInfo()
end

function MysteryBossChoosePop:_onClickTabChanged()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shenshou_Tag2)

	self._bossType = self.m_tabController:getSelectedIndex() + 1
	self._selectIdx = 0

	self:_sendMysteryBossInfo()
end

function MysteryBossChoosePop:_sendMysteryBossInfo()
	g.core.network.GameNetProxy:send_C2S_MysteryBoss_GetInfo({})
end

function MysteryBossChoosePop:_onS2CMysteryBossGetInfo()
	self:_updateBossInfo()
end

return MysteryBossChoosePop
