local WindowsDebugNode = class("WindowsDebugNode", function()
	return cc.Node:create()
end)
local var_0_1 = g.core.battle.BattleProxy

function WindowsDebugNode:ctor()
	self:setAnchorPoint(0, 0)
	self:setName("WindowsDebugNode")

	local var_2_0 = cc.EventListenerKeyboard:create()

	var_2_0:registerScriptHandler(function()
		self:onKeyPressed(...)
	end, cc.Handler.EVENT_KEYBOARD_PRESSED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_2_0, self)
end

function WindowsDebugNode:_createParabola(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	return cc.EaseElasticInOut:create(cc.BezierTo:create(arg_4_1, {
		cc.p(arg_4_2.x + (arg_4_3.x - arg_4_2.x) / 4, arg_4_4 + arg_4_2.y + math.cos(arg_4_5 * math.pi / 180) * (arg_4_2.x + (arg_4_3.x - arg_4_2.x) / 4)),
		cc.p(arg_4_2.x + (arg_4_2.x + (arg_4_3.x - arg_4_2.x) / 4) * 2, arg_4_4 + arg_4_2.y + math.cos(arg_4_5 * math.pi / 180) * (arg_4_2.x + (arg_4_2.x + (arg_4_3.x - arg_4_2.x) / 4) * 2)),
		arg_4_3
	}))
end

function WindowsDebugNode:_parabolaTest()
	local var_5_0 = cc.Director:getInstance()
	local var_5_1 = var_5_0:getWinSize()
	local var_5_2 = display.newLayer(cc.c4b(255, 0, 0), cc.size(100, 100))

	var_5_2.setVisible(var_5_0, true)
	self:addChild(var_5_2, 1000)

	local var_5_3 = self:_createParabola(0.4, cc.p(0, 0), cc.p(400, 0), 100, 30)
	local var_5_4 = cc.MoveTo:create(0.5, cc.p(0, 100))

	var_5_2:runAction((cc.MoveBy:create(0.5, cc.p(0, 100))))
end

function WindowsDebugNode:_getScoreByRank(arg_6_1)
	local var_6_0 = g.core.config.wrest_city_info.get(self._cityId).integral_group
end

function WindowsDebugNode:_upgradeTest()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		type = 1,
		text = g.core.lang:get(1155, {
			broken = g.core.lang:getRet(168)
		}),
		text_cancel = g.core.lang:get(1154),
		handler_cancel = function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_VERISON, false, g.core.network.proto.RET_VERSION)
			device.restartGame()
		end
	}), {
		system = true
	})
end

function WindowsDebugNode:onKeyPressed(arg_9_1, arg_9_2)
	if arg_9_1 == cc.KeyCode.KEY_ESCAPE then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_KEY_PAD, false, nil, cc.KeyCode.KEY_ESCAPE)
	elseif arg_9_1 == cc.KeyCode.KEY_SPACE then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_KEY_PAD, false, nil, cc.KeyCode.KEY_SPACE)
	elseif arg_9_1 == cc.KeyCode.KEY_F1 then
		if g.core.battle.BattleProxy:isInBattle() then
			g.core.module.ModuleManager:tip("战斗中不能使用F1")
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.DEBUG)
		end
	elseif arg_9_1 == cc.KeyCode.KEY_F2 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SILENT_UPGRADE)
	elseif arg_9_1 == cc.KeyCode.KEY_F3 then
		local var_9_1 = io.open("localPatch/patch.lua")
		local var_9_2, var_9_3 = require("app.core.patch.PatchProxy"):createPatch((var_9_1 or nil) and var_9_1:read("*a"), g.core.platform.PlatformProxy:getCurrentVersion())

		if var_9_2 then
			var_9_2:applyPatch()

			if not var_9_2:onFetchConfigFinish() then
				return
			end
		elseif var_9_3 then
			g.core.module.ModuleManager:tip("patch错误")
		end
	elseif arg_9_1 == cc.KeyCode.KEY_F4 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = 2254
		})
	elseif arg_9_1 == cc.KeyCode.KEY_F6 then
		if var_0_1:isInBattle() then
			var_0_1:skipBattle()
		end
	elseif arg_9_1 == cc.KeyCode.KEY_F7 then
		g.core.module.ModuleManager:popModule()
	elseif arg_9_1 == cc.KeyCode.KEY_F8 then
		if not g.core.model.User.waitGameData:isGetNewDownLoadAward() then
			g.core.network.GameNetProxy:send_C2S_NewDownload_Award({})
		end
	elseif arg_9_1 == cc.KeyCode.KEY_F9 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.gvg.view.GvgLayer").new()))
	elseif arg_9_1 == cc.KeyCode.KEY_F10 then
		cc.Director:getInstance():getEventDispatcher():dispatchCustomEvent("DEBUG_INSPECTOR_OPEN")
	elseif arg_9_1 == cc.KeyCode.KEY_F11 then
		local var_9_4 = {}

		var_9_4.id = 10000
		var_9_4.is_first = false
		var_9_4.is_win = true
		var_9_4.knight_exp = 50
		var_9_4.ret = 1
		var_9_4.result = {}
		var_9_4.result.drops = {
			{
				value = 7,
				size = 1,
				type = 3
			},
			{
				value = 7,
				size = 1,
				type = 3
			},
			{
				value = 7,
				size = 1,
				type = 3
			},
			{
				value = 7,
				size = 1,
				type = 3
			},
			{
				value = 7,
				size = 1,
				type = 3
			}
		}
		var_9_4.result.index = 1
		var_9_4.result.role_exp = 30
		var_9_4.result.silver = 500
		var_9_4.stage = {}
		var_9_4.stage.challenge_count = 3
		var_9_4.stage.id = 10000
		var_9_4.stage.reset_count = 0
		var_9_4.stage.star = 3

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEFINISH, false, nil, var_9_4)
	elseif arg_9_1 == cc.KeyCode.KEY_F12 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.activity.view.ActivityCelebrationLogin.ActivityCelebrationLoginPreviewPop").new(), {
			touchDisappear = true
		})
	elseif arg_9_1 == cc.KeyCode.KEY_Q then
		g.core.battle.BattleProxy:testBattle(nil, nil, nil, true)
	elseif arg_9_1 == cc.KeyCode.KEY_W then
		g.core.battle.BattleProxy:battleAndCheckResult()
	elseif arg_9_1 == cc.KeyCode.KEY_R then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_KEY_R, false, nil, cc.KeyCode.KEY_R)
	elseif arg_9_1 == cc.KeyCode.KEY_BACKSPACE then
		os.execute("cls")
	elseif arg_9_1 == cc.KeyCode.KEY_T then
		g.core.module.ModuleManager:pushPopup((require("debug.guide.DebugGuideSetStepPop").new()))
	elseif arg_9_1 == cc.KeyCode.KEY_P then
		g.core.service.ServiceManager:getServiceByName("GuideService"):dumpDebugLog()
	elseif arg_9_1 == cc.KeyCode.KEY_B then
		g.core.battle.BattleProxy:playTestTeamBattle((g.core.config.knight_info.get((g.core.model.User:getBaseId())).sex == 0 or nil) and 299061, 299041, true)
	elseif arg_9_1 == cc.KeyCode.KEY_G then
		print("===============getTable----->", g.core.model.User.hlTrainData)
	elseif arg_9_1 == cc.KeyCode.KEY_E then
		cc.FileUtils:getInstance():addSearchPath("res_en/", true)
		cc.FileUtils:getInstance():addSearchPath("res_en/common/", true)

		g.core.const.ConstMgr.BASE_CONST.USE_REMOTE_ID_LIST = {}

		g.core.module.ModuleManager:tip("优先使用res_en路径")
	end
end

return WindowsDebugNode
