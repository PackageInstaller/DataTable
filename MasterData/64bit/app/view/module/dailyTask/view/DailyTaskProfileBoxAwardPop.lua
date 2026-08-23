local var_0_0 = g.core.model.User.dailyTaskData
local DailyTaskProfileBoxAwardPop = class("DailyTaskProfileBoxAwardPop", require("app.fairyGUI.dailyTask.UI_DailyTaskProfileBoxAwardPop"), function()
	return fgui.GComponent:create({
		pkgName = "dailyTask",
		resName = "DailyTaskProfileBoxAwardPop",
		pkgPath = "ui/dailyTask/dailyTask"
	}, ...)
end)

function DailyTaskProfileBoxAwardPop:ctor(arg_2_1)
	self:showAtCenter()

	self._profileId = arg_2_1.profileId
	self._isUnLock = arg_2_1.isUnLock
	self._awardData = {}

	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onItemRenderer))
end

function DailyTaskProfileBoxAwardPop:onLoad()
	self.m_boxStateController:setSelectedIndex(self._isUnLock and 1 or 0)

	if not self._isUnLock then
		self.m_desc:setText(g.core.lang:get(106504, {
			num = self._profileId
		}))
	end

	self:_updateAward()
end

function DailyTaskProfileBoxAwardPop:_updateAward()
	local var_4_0 = var_0_0:getProfileLevelInfo()[self._profileId].drop_id

	if var_4_0 > 0 then
		self._awardData = var_0_0:getProfileAwardInfo(var_4_0)
	end

	self.m_awardList:setNumItems(#self._awardData)
end

function DailyTaskProfileBoxAwardPop:_onItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._awardData[arg_5_1 + 1])
end

return DailyTaskProfileBoxAwardPop
