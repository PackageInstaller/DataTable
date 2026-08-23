local var_0_0 = g.core.model.User.spiritHelpData
local SpiritHelpBattleSpeedPop = class("SpiritHelpBattleSpeedPop", require("app.fairyGUI.spiritHelp.UI_SpiritHelpBattleSpeedPop"), function()
	return fgui.GComponent:create({
		resName = "SpiritHelpBattleSpeedPop",
		pkgPath = "ui/spiritHelp/spiritHelp",
		isFullScreen = false,
		pkgName = "spiritHelp"
	}, ...)
end)

function SpiritHelpBattleSpeedPop:ctor()
	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", false)
	self:showAtCenter()
	self:initView()
	self.m_enterTransition:play()
	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.BATTLE_SPEED_ENTERED)
end

function SpiritHelpBattleSpeedPop:initView()
	self.m_speedBtn:addClickListener(handler(self, self._onClickSpeedCheck))
end

function SpiritHelpBattleSpeedPop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "slider_speed_change_ing" then
		self.m_speedBtn:setSelected(false)

		return true
	elseif arg_4_1 == "slider_speed_change_end" then
		self.m_speedBtn:setSelected(var_0_0:hasBattleSpeed())

		return true
	end
end

function SpiritHelpBattleSpeedPop:onLoad()
	var_0_0:updateBattleSpeed()
	self.m_battleSpeed:updateView()
	self.m_speedBtn:setSelected(var_0_0:hasBattleSpeed())
	self:updateSpeedBtnEffect()
end

function SpiritHelpBattleSpeedPop:_onClickSpeedCheck()
	self:updateSpeedBtnEffect()
	var_0_0:setHasBattleSpeed((self.m_speedBtn:isSelected()))
end

function SpiritHelpBattleSpeedPop:updateSpeedBtnEffect()
	if self.m_speedBtn:isSelected() then
		self.m_speedBtn:getChild("effectPlace"):removeAllEffect()
	else
		self.m_speedBtn:getChild("effectPlace"):addEffectSpine({
			anim = "start",
			name = "eff_ui_spiritHelp_mainLayer",
			isLoop = true
		})
	end
end

function SpiritHelpBattleSpeedPop:onRemoved()
	var_0_0:saveSpeedJsonData()
	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", true)
end

return SpiritHelpBattleSpeedPop
