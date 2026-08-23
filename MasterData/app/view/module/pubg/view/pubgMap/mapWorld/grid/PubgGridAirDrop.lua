local PubgGirdAirDrop = class("PubgGirdAirDrop", require("app.fairyGUI.pubg.UI_PubgGridAirDrop"))

function PubgGirdAirDrop:ctor()
	self._airDrop = nil
	self._leftTimeTxt = self.m_leftProgress:getChild("leftTimeTxt")
	self._myId = g.core.model.User:getId()
end

function PubgGirdAirDrop:resetComp()
	self.m_resetTransition:play()
	self.m_effRefresh:removeChildren()
	self.m_effGet:removeChildren()
end

function PubgGirdAirDrop:setAirDrop(arg_3_1)
	if not self._airDrop or self._airDrop:getUid() ~= arg_3_1:getUid() then
		self._airDrop = arg_3_1

		self.m_leftProgress:setMax(self._airDrop:getAirCfg().time)
	end

	self:updateUserLeftTime()
end

function PubgGirdAirDrop:updateUserLeftTime()
	if not self._airDrop then
		return
	end

	local var_4_1 = (self._airDrop:getUserDict()[self._myId] or 0) + self._airDrop:getAirCfg().time - g.core.common.ServerTime:getTime()

	if var_4_1 > 0 then
		self.m_showProgressController:setSelectedIndex(1)
		self._leftTimeTxt:setText(g.core.lang:get(405802, {
			time = var_4_1
		}))
		self.m_leftProgress:setValue(var_4_1)
	else
		self.m_showProgressController:setSelectedIndex(0)
	end
end

function PubgGirdAirDrop:playRefreshEventEff(arg_5_1)
	self.m_airDropTransition:play(function()
		if arg_5_1 then
			arg_5_1()
		end
	end)
	self.m_effAirDrop:addEffectSpine({
		anim = "play",
		name = "eff_ui_pubg_airdrop",
		remove = true,
		isLoop = false
	})
end

function PubgGirdAirDrop:playGetAirDropEff(arg_7_1)
	self.m_getTransition:play(function()
		if arg_7_1 then
			arg_7_1()
		end
	end)
	self.m_effGet:addEffectSpine({
		anim = "play",
		name = "eff_ui_pubg_airdropfade",
		remove = true,
		isLoop = false
	})
end

return PubgGirdAirDrop
