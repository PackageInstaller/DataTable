local FogNightmareKeepsakeLevelUpPop = class("FogNightmareKeepsakeLevelUpPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeLevelUpPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareKeepsakeLevelUpPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		pkgName = "fogNightmare"
	}, ...)
end)
local var_0_1 = g.core.model.User.fogNightmareData

function FogNightmareKeepsakeLevelUpPop:ctor(arg_2_1)
	self:showAtCenter()

	self._curId = arg_2_1.curId
	self._nextId = arg_2_1.nextId
	self._curStruct = arg_2_1.curStruct or var_0_1:getKeepsakeData():getKeepsakeStructById(self._curId)
	self._nextStruct = arg_2_1.nextStruct or var_0_1:getKeepsakeData():getKeepsakeStructById(self._nextId)

	self:_initView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_SEAL_UP)
end

function FogNightmareKeepsakeLevelUpPop:_initView()
	local var_3_0 = self._curStruct:getCfg()

	self.m_txtCurLv:setText(var_3_0.level)
	self.m_curIcon:updateIconBySealId(var_3_0.seal_id)
	self.m_curIcon:setSealLv(var_3_0.level)

	local var_3_1 = self._nextStruct:getCfg()

	self.m_txtNextLv:setText(var_3_1.level)
	self.m_nextIcon:updateIconBySealId(var_3_1.seal_id)
	self.m_nextIcon:setSealLv(var_3_1.level)
	self.m_powerUp:setText(g.core.lang:get(500223, {
		power = var_3_1.power - var_3_0.power
	}))
end

function FogNightmareKeepsakeLevelUpPop:onLoad()
	self.m_enterTransition:setHook("iconPlayEnter_1", handler(self, function()
		self.m_curIcon:getChild("effIcon"):addEffectSpine({
			isLoop = false,
			name = "eff_ui_FogNightmare_icon",
			anim = "play"
		})
	end))
	self.m_enterTransition:setHook("iconPlayEnter_2", handler(self, function()
		self.m_nextIcon:getChild("effIcon"):addEffectSpine({
			isLoop = false,
			name = "eff_ui_FogNightmare_icon",
			anim = "play"
		})
	end))
	self.m_enterTransition:play()
	self.m_effPopTitle:addEffectSpine({
		isLoop = false,
		name = "eff_ui_FogNightmare_popTitle",
		anim = "play"
	})
	self.m_effPopbg:addEffectSpine({
		isLoop = false,
		name = "eff_ui_FogNightmare_popbg",
		anim = "play"
	})
	self.m_effLevelUp:addEffectSpine({
		isLoop = false,
		name = "eff_ui_FogNightmare_ksLevelUp",
		anim = "play"
	})
end

function FogNightmareKeepsakeLevelUpPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
end

return FogNightmareKeepsakeLevelUpPop
