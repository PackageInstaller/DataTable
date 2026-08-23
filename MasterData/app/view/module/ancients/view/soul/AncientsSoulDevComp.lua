local AncientsSoulDevComp = class("AncientsSoulDevComp", require("app.fairyGUI.ancients.UI_AncientsSoulDevComp"))

function var_0_0.ctor(arg_1_0)
	arg_1_0._levelUpEffect = nil
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_TEAMTASKNTF, handler(self, self._onRcvAncientTeamTaskNtf), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ACTIVEAWARD, handler(self, self._onRcvAncientActiveAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_TASKAWARD, handler(self, self._onRcvAncientTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_TASKNTF, handler(self, self._onRcvAncientTaskNtf), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYTEAMCHANGE, handler(self, self._onRcvAncientTeamChange), self)
end

function var_0_0:updateView()
	self:_updatePetSpine()
	self.m_Comp_petInfo:updateView()
	self.m_Comp_task:updateView()
	self.m_Comp_activeAwards:updateView()
end

function var_0_0:_updatePetSpine()
	local var_4_0 = g.core.config.ancients_pet_info.get((g.core.model.User.ancientsData:getPetBaseId())).advance_id
	local var_4_1 = self.m_Comp_PetSpine:getChild("DrawPet")

	if var_4_1 and var_4_0 == var_4_1:getAdvId() then
		return
	end

	local var_4_2 = require("app.view.common.DrawPet").new({
		isShowBg = false,
		scale = 1,
		advId = var_4_0
	})

	self.m_Comp_PetSpine:removeChildren()
	self.m_Comp_PetSpine:addChild(var_4_2)

	local var_4_3 = self.m_Comp_PetSpine:getSize()

	var_4_2:setPosition(var_4_3.width / 2 + 100, var_4_3.height / 2 + 80)
end

function var_0_0:_onRcvAncientTeamChange(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:updateView()
end

function var_0_0:_onRcvAncientTeamTaskNtf(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:updateView()
end

function var_0_0:_onRcvAncientActiveAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_7_4.awards)
	end

	self:updateView()
end

function var_0_0:_onRcvAncientTaskAward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_8_4.awards)
	end

	self:updateView()
end

function var_0_0:_onRcvAncientTaskNtf(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:updateView()
end

function var_0_0:receiveCompEvent(arg_10_1)
	if arg_10_1 == "AncientSoulPetLevelup" then
		self.m_levelUpEffect:addEffectSpine({
			anim = "play",
			name = "eff_ui_ancients_petupgradelight",
			remove = true,
			isLoop = false
		})
	end
end

return var_0_0
