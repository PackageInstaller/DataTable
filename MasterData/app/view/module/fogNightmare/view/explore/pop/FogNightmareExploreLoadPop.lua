local var_0_0 = g.core.model.User.shopData
local var_0_1 = g.core.const.ConstMgr
local FogNightmareExploreLoadPop = class("FogNightmareExploreLoadPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreLoadPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreLoadPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareExploreLoadPop:ctor(arg_2_1)
	self:setSize(display.width, display.height)
	self:showAtCenter()
	self.m_loadBtn:addClickListener(handler(self, self._onLoadBtnClicked))
	self.m_quitBtn:addClickListener(handler(self, self._onQuitBtnClicked))
end

function FogNightmareExploreLoadPop:onLoad()
	self:_initPlayTimesComp()
end

function FogNightmareExploreLoadPop:_initPlayTimesComp()
	self.m_playTimesComp:initView({
		playNum = var_0_1.ShopConst.PLAY_TYPE.FOG_NIGHTMARE_RESET,
		getTimesFunc = function()
			return var_0_0:getLeftCount(var_0_1.ShopConst.PLAY_TYPE.FOG_NIGHTMARE_RESET)
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_RECOVER_STEP,
			g.core.event.enum.EVENT_FORCE_FRESH,
			g.core.event.enum.EVENT_NET_S2C_RFRESH_RESOURCE
		}
	})
end

function FogNightmareExploreLoadPop:_onLoadBtnClicked()
	local var_6_0 = g.core.model.User.fogNightmareData:getTowerData():getCurFloorStruct():getSelectedStage()
	local var_6_1

	if not var_6_0 or #var_6_0 < 1 then
		do return end

		var_6_1 = {
			type = 1,
			floor = g.core.model.User.fogNightmareData:getTowerData():getCurrentFloorNum()
		}
	end

	var_6_1.stage = var_6_0[1]:getStageId()

	g.core.network.GameNetProxy:send_C2S_Fog_Back(var_6_1)
	g.core.module.ModuleManager:popByDisplay(self)
end

function FogNightmareExploreLoadPop:_onQuitBtnClicked()
	local var_7_0 = fgui.UIPackage:createObject("fogNightmare", "FogNightmareAbandonComp")

	var_7_0:updateView(g.core.model.User.fogNightmareData:getTowerData():getCurrentFloorNum(), (g.core.model.User.fogNightmareData:getTowerData():getHistoryMaxFloorNum()))
	g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
		title = g.core.lang:get(500203),
		childComp = var_7_0,
		onConfirm = function(arg_8_0)
			g.core.network.GameNetProxy:send_C2S_Fog_GiveUp({})
			g.core.module.ModuleManager:popByDisplay(self)
		end
	})
end

return FogNightmareExploreLoadPop
