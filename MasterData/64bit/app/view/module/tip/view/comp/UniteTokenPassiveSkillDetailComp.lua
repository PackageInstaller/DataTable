local var_0_0 = g.core.model.User.uniteTokenData
local UniteTokenPassiveSkillDetailComp = class("UniteTokenPassiveSkillDetailComp", require("app.fairyGUI.tip.UI_UniteTokenPassiveSkillDetailComp"))

function UniteTokenPassiveSkillDetailComp:ctor()
	self.m_starUpList:setIniter()
	self.m_starUpList:setItemRenderer(handler(self, self._onStarUpListRenderer))
end

function UniteTokenPassiveSkillDetailComp:_onItemIniter(arg_2_1, arg_2_2)
	arg_2_2:bindLua("app.view.module.uniteToken.view.component.UniteTokenSkillItemCell")
end

function UniteTokenPassiveSkillDetailComp:updateView(arg_3_1, arg_3_2, arg_3_3)
	self._skillData = arg_3_1
	self._passiveList = var_0_0:getTokenPassiveSkillList(arg_3_2:getAdvanceId(), arg_3_3 or arg_3_2:getStarLevel())

	self.m_starUpList:setNumItems(#self._passiveList)
	self.m_starUpList:resizeToFit(#self._passiveList)
	self.m_skillDescTxt:setText(self._skillData.desc)

	local var_3_0 = -1

	for iter_3_0, iter_3_1 in ipairs(self._passiveList) do
		if not iter_3_1.isActive then
			var_3_0 = iter_3_0 - 1

			break
		end
	end

	if var_3_0 < 0 then
		var_3_0 = #self._passiveList
	end

	self:getScrollPane():setPosY((math.max(0, self.m_starUpList:getPosition().y + self.m_starUpList:getSize().height * (var_3_0 / (#self._passiveList - 1)) - self:getSize().height)))
end

function UniteTokenPassiveSkillDetailComp:_onStarUpListRenderer(arg_4_1, arg_4_2)
	arg_4_2:setView(self._passiveList[arg_4_1 + 1])
end

return UniteTokenPassiveSkillDetailComp
