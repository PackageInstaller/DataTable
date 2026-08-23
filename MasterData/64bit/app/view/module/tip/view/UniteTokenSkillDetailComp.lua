local var_0_0 = g.core.model.User.uniteTokenData
local UniteTokenSkillDetailComp = class("UniteTokenSkillDetailComp", require("app.fairyGUI.tip.UI_UniteTokenSkillDetailComp"))

function UniteTokenSkillDetailComp:ctor()
	self.m_starUpList:setIniter()
	self.m_starUpList:setItemRenderer(handler(self, self._onStarUpListRenderer))
end

function UniteTokenSkillDetailComp:_onItemIniter(arg_2_1, arg_2_2)
	arg_2_2:bindLua("app.view.module.uniteToken.view.component.UniteTokenSkillItemCell")
end

function UniteTokenSkillDetailComp:updateView(arg_3_1, arg_3_2)
	self._skillData = arg_3_1
	self._tokenData = arg_3_2
	self._skillList = var_0_0:getTokenSkillList(self._skillData.cfg.id, self._skillData.cfg.level)

	self.m_starUpList:setNumItems(#self._skillList)
	self.m_starUpList:resizeToFit(#self._skillList)
	self.m_skillDescTxt:setText(self._skillData.desc)

	local var_3_0 = -1

	for iter_3_0, iter_3_1 in ipairs(self._skillList) do
		if not iter_3_1.isActive then
			var_3_0 = iter_3_0 - 1

			break
		end
	end

	if var_3_0 < 0 then
		var_3_0 = #self._skillList
	end

	self:getScrollPane():setPosY((math.max(0, self.m_starUpList:getPosition().y + self.m_starUpList:getSize().height * (var_3_0 / (#self._skillList - 1)) - self:getSize().height)))
end

function UniteTokenSkillDetailComp:_onStarUpListRenderer(arg_4_1, arg_4_2)
	arg_4_2:setView(self._skillList[arg_4_1 + 1])
end

function UniteTokenSkillDetailComp:_onClickUnload()
	if self._pos > 0 then
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			pos = 0,
			tp = 2,
			id = self._tokenData:getAdvanceId()
		})
		g.core.module.ModuleManager:popComponent()
	end
end

return UniteTokenSkillDetailComp
