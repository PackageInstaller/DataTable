local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.model.User.fogNightmareData
local FogNightmareRevivalWaveComp = class("FogNightmareRevivalWaveComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareRevivalWaveComp"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareRevivalWaveComp",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareRevivalWaveComp:ctor()
	self.m_deadKnightBtn:addClickListener(handler(self, self._onDeadBtnClick))
end

function FogNightmareRevivalWaveComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_RECOVER, self._onRevivalSucc, self)
end

function FogNightmareRevivalWaveComp:_onDeadBtnClick()
	local var_4_0 = {
		title = g.core.lang:get(500144)
	}

	var_4_0.knightStruct = var_0_2:getFormationData():getAllKnightsByStates({
		[var_0_0.SPECIAL_KNIGHT_STATE.DEFEATED] = true
	})
	var_4_0.style = var_0_0.SPECIAL_KNIGHT_STATE.DEFEATED

	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightStatePop").new(var_4_0), {
		touchDisappear = true,
		blackOpacity = 0.7
	})
end

function FogNightmareRevivalWaveComp:updateComp(arg_5_1)
	self._effectStruct = arg_5_1

	self.m_tipText:setText(g.core.lang:get(500143, {
		num = arg_5_1:getRevivalNum(),
		hp = arg_5_1:getRecoverHp()
	}))
end

function FogNightmareRevivalWaveComp:_doClickAction(arg_6_1)
	g.core.network.GameNetProxy:send_C2S_Fog_Recover({
		floor = arg_6_1.floor:getFloorId(),
		stage = arg_6_1.stage:getStageId(),
		wave = arg_6_1.wave
	})
end

function FogNightmareRevivalWaveComp:_onRevivalSucc()
	if not self:isVisible() then
		return
	end

	local var_7_0 = self._effectStruct:getRevivalKnights()

	if var_7_0 then
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			table.insert(var_7_1, (var_0_2:getFormationData():getKnightFromPool(iter_7_1.id)))
		end

		local var_7_2 = {
			title = g.core.lang:get(500208),
			knightStruct = var_7_1,
			style = var_0_0.SPECIAL_KNIGHT_STATE.REVIVAL,
			callback = function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
			end
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "revival",
					func = function()
						return g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightStatePop").new(var_7_2), {
							touchDisappear = true,
							blackOpacity = 0.7
						})
					end
				}
			}
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(500180))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
	end
end

return FogNightmareRevivalWaveComp
