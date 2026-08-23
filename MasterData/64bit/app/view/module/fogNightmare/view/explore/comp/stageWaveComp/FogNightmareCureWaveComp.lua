local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.model.User.fogNightmareData
local FogNightmareCureWaveComp = class("FogNightmareCureWaveComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareCureWaveComp"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareCureWaveComp",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareCureWaveComp:ctor()
	self.m_injuredKnightBtn:addClickListener(handler(self, self._onInjuredBtnClick))
end

function FogNightmareCureWaveComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_RECOVER, self._onRecoverSucc, self)
end

function FogNightmareCureWaveComp:_onInjuredBtnClick()
	local var_4_0 = {
		title = g.core.lang:get(500146)
	}

	var_4_0.knightStruct = var_0_3:getFormationData():getAllKnightsByStates({
		[var_0_1.SPECIAL_KNIGHT_STATE.INJURED] = true
	})
	var_4_0.style = var_0_1.SPECIAL_KNIGHT_STATE.INJURED

	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightStatePop").new(var_4_0), {
		touchDisappear = true,
		blackOpacity = 0.7
	})
end

function FogNightmareCureWaveComp:updateComp(arg_5_1)
	self._effectStruct = arg_5_1

	self.m_tipText:setText(g.core.lang:get(500145, {
		hp = arg_5_1:getRecoverHp()
	}))
end

function FogNightmareCureWaveComp:_doClickAction(arg_6_1)
	g.core.network.GameNetProxy:send_C2S_Fog_Recover({
		floor = arg_6_1.floor:getFloorId(),
		stage = arg_6_1.stage:getStageId(),
		wave = arg_6_1.wave
	})
end

function FogNightmareCureWaveComp:_onRecoverSucc()
	if not self:isVisible() then
		return
	end

	local var_7_0 = self._effectStruct:getRecoverKnights()

	if var_7_0 then
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			table.insert(var_7_1, (var_0_3:getFormationData():getKnightFromPool(iter_7_1.id)))
		end

		local var_7_2 = {
			title = g.core.lang:get(500207),
			knightStruct = var_7_1,
			style = var_0_1.SPECIAL_KNIGHT_STATE.INJURED,
			callback = function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
			end
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "cure",
					func = function()
						return g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightStatePop").new(var_7_2), {
							touchDisappear = true
						})
					end
				}
			}
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(500178))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
	end
end

return FogNightmareCureWaveComp
