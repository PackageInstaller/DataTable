local var_0_0 = g.core.const.ConstMgr.PreciousConst
local var_0_1 = g.core.model.User.preciousData
local var_0_2 = g.core.const.ConstMgr.QUALITY_TYPE
local PreciousMainCell = class("PreciousMainCell", require("app.fairyGUI.precious.UI_PreciousMainCell"))

function PreciousMainCell:ctor()
	self._preciousSuit = {}

	for iter_1_0 = 1, var_0_0.PRECIOUS_INSUIT_MAXNUM do
		self["m_subComp" .. iter_1_0]:addClickListener(handler(self, self._onClickSubComp))
	end

	self.m_suitNameComp:addClickListener(handler(self, self._onClickPreciousNameComp))
end

function PreciousMainCell:updateMainCell(arg_2_1, arg_2_2)
	if arg_2_2 then
		self._ignoreTouch = arg_2_2.ignoreTouch
		self._ignoreRedPoint = arg_2_2.ignoreRedPoint
		self._clickOpenInfoPop = arg_2_2.clickOpenInfoPop
	end

	self._preciousSuit = arg_2_1

	for iter_2_0 = 1, var_0_0.PRECIOUS_INSUIT_MAXNUM do
		self["m_subComp" .. iter_2_0]:updateMainComp(var_0_1:getPreciousByAdvId(arg_2_1:getCfg()["precious_id_" .. iter_2_0]), arg_2_2)
	end

	self.m_suitNameComp:updateSuitName(arg_2_1)

	local var_2_0 = self._preciousSuit:getQuality()

	if var_2_0 > var_0_2.SSR then
		self.m_qualityBg:setURL("ui://base_new/pic_gzp_wupinyuandi" .. var_2_0 + 1)
	else
		self.m_qualityBg:setURL("ui://base_new/pic_gzp_wupinyuandi4")
	end

	if self._ignoreRedPoint then
		self.m_redPointComp:setVisible(false)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				group = self._preciousSuit:getSuitGroup()
			}
		})
	end
end

function PreciousMainCell:_onClickSubComp(arg_3_1)
	if self._ignoreTouch then
		return
	end

	local var_3_0 = arg_3_1:getSender():getName()
	local var_3_1 = self._preciousSuit:getCfg()["precious_id_" .. tonumber(string.sub(var_3_0, #var_3_0))]

	if var_3_1 ~= 0 then
		local var_3_2 = var_0_1:getPreciousByAdvId(var_3_1)

		if not var_3_2 then
			return
		end

		if self._clickOpenInfoPop then
			self:_clickOpenPreciousInfoPop(var_3_2)

			return
		end

		local var_3_3 = var_3_2:getPreciousStatus()

		if var_3_3 == var_0_0.PRECIOUS_STATUS.CANCOMPOSE then
			g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
				num = 1,
				id = var_3_2:getCfg().fragment_id
			})
		elseif var_3_3 == var_0_0.PRECIOUS_STATUS.NOGET then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.precious.view.PreciousInfoPop").new({
				preciousStruct = var_3_2
			}), {
				touchDisappear = true,
				hideContinue = true
			})
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.PRECIOUS_DEV, {
				suit = self._preciousSuit,
				advanceId = var_3_1,
				devType = (var_3_3 == var_0_0.PRECIOUS_STATUS.STARUP or nil) and (var_0_0.DevType.STAR_UP or var_0_0.DevType.ADVANCE)
			})
		end
	end
end

function PreciousMainCell:_clickOpenPreciousInfoPop(arg_4_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.precious.view.PreciousInfoPop").new({
		preciousStruct = arg_4_1
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

function PreciousMainCell:_onClickPreciousNameComp()
	if self._ignoreTouch then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.PRECIOUS_SUIT_DEV, {
		group = self._preciousSuit:getSuitGroup()
	})
end

function PreciousMainCell:showEffect()
	if not self._preciousSuit then
		return
	end

	local var_6_0 = self._preciousSuit:getQuality()

	self.m_effBg:addEffectSpine({
		name = "eff_ui_precious_success",
		isLoop = true,
		anim = "loop_" .. var_6_0 + 1
	})
	self.m_effSuccess:addEffectSpine({
		name = "eff_ui_precious_success",
		remove = true,
		isLoop = false,
		anim = "play_" .. var_6_0 + 1
	})
end

return PreciousMainCell
