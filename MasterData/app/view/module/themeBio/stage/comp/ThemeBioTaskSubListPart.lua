local var_0_0 = g.core.common.Drops
local var_0_1 = g.core.model.User.themeData
local ThemeBioTaskSubListPart = class("ThemeBioTaskSubListPart")

function ThemeBioTaskSubListPart:ctor()
	self._ownerStage = nil
	self._tmpAwardArr = nil
	self._tmpMissionArr = nil
	self.m_subList = self:getChild("subList")
	self.m_awardList = self:getChild("awardList")

	self:_initDefaultData()
	self:_initRegisterUI()
end

function ThemeBioTaskSubListPart:onLoad()
	return
end

function ThemeBioTaskSubListPart:onUnload()
	self._ownerStage = nil
	self._tmpAwardArr = nil
	self._tmpMissionArr = nil
end

function ThemeBioTaskSubListPart:startUp(arg_4_1)
	self._ownerStage = arg_4_1
end

function ThemeBioTaskSubListPart:refreshTask(arg_5_1, arg_5_2, arg_5_3)
	self._tmpMissionArr = {}
	self._tmpAwardArr = {}
	self._activeThemeValue = arg_5_3
	self._themeBioData = var_0_1:getThemeData(self._activeThemeValue):getThemeBioData()

	local var_5_0

	for iter_5_0, iter_5_1 in pairs(arg_5_1.missions) do
		local var_5_1 = self._themeBioData:getMission(iter_5_1)

		if not var_5_1.isFirst and not var_5_1.isLast then
			table.insert(self._tmpMissionArr, var_5_1)
		end

		if var_5_1.isLast then
			var_5_0 = var_5_1
		end
	end

	self.m_subList:setNumItems(#self._tmpMissionArr)

	if var_5_0 and var_5_0.reward_first > 0 then
		self._tmpAwardArr = var_0_0:getGoodsArray(var_5_0.reward_first)
	end

	self.m_awardList:setNumItems(#self._tmpAwardArr)
end

function ThemeBioTaskSubListPart:_initDefaultData()
	return
end

function ThemeBioTaskSubListPart:_initRegisterUI()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_subList:setVirtual()
	self.m_subList:setItemRenderer(handler(self, self._onRenderSubTaskList))
end

function ThemeBioTaskSubListPart:_onRenderAwardList(arg_8_1, arg_8_2)
	self._tmpAwardArr[arg_8_1 + 1].hideNum = false

	arg_8_2:updateIcon(self._tmpAwardArr[arg_8_1 + 1])
end

function ThemeBioTaskSubListPart:_onRenderSubTaskList(arg_9_1, arg_9_2)
	arg_9_2:updateData(self._tmpMissionArr[arg_9_1 + 1])
end

return ThemeBioTaskSubListPart
