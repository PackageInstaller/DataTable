local var_0_0 = g.core.model.User.dailyDungeonData
local DailyDungeonMainLayer = class("DailyDungeonMainLayer", require("app.fairyGUI.dailyDungeon.UI_DailyDungeonMainLayer"), function()
	return fgui.GComponent:create({
		resName = "DailyDungeonMainLayer",
		pkgPath = "ui/dailyDungeon/dailyDungeon",
		isFullScreen = true,
		pkgName = "dailyDungeon"
	}, ...)
end)

function DailyDungeonMainLayer:ctor()
	self:_reset()

	self._params = {
		...
	}

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_DUNGEON)
end

function DailyDungeonMainLayer:_reset()
	self:_resetOther()
	self:_resetUI()
end

function DailyDungeonMainLayer:_resetUI()
	self:addBg("ui://dailyDungeon/bg_rcfb_fuben")
	self.m_enterTransition:setHook("play2Loop", handler(self, self._playItemAction))
end

function DailyDungeonMainLayer:_resetOther()
	self._dungeonInfos = nil
end

function DailyDungeonMainLayer:_addCustomListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_INFO, handler(self, self._updateListItem), self)
end

function DailyDungeonMainLayer:onLoad()
	self:_addCustomListeners()
	self:_updateListItem()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function DailyDungeonMainLayer:_updateListItem()
	local var_8_0 = var_0_0:getAllDailyDungeon()

	if not var_8_0 then
		g.core.network.GameNetProxy:send_C2S_DailyDungeon_Info({})

		return
	end

	local var_8_1 = self._dungeonInfos == nil

	self._dungeonInfos = var_8_0

	for iter_8_0 = 1, 4 do
		self["m_enterItem" .. iter_8_0]:updateItem(self._dungeonInfos[iter_8_0])
	end

	if var_8_1 then
		self.m_enterTransition:play()
		self.m_effBgEnter:addEffectSpine({
			name = "eff_ui_dailyDungeon_bgEnter",
			scale = 1,
			isLoop = false
		})
	end
end

function DailyDungeonMainLayer:_playItemAction()
	self.m_effBgEnter:addEffectSpine({
		anim = "play2",
		name = "eff_ui_dailyDungeon_bgEnter",
		scale = 1,
		isLoop = true
	})
end

function DailyDungeonMainLayer:receiveCompEvent(arg_10_1)
	if arg_10_1 == "enterDetailDungeon" then
		g.core.module.ModuleManager:pushModule(g.view.entrance.DAILY_DUNGEON_DETAIL, ...)
	end
end

return DailyDungeonMainLayer
