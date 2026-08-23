local var_0_0 = g.core.model.User.dailyTaskData
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local DailyTaskProfilePop = class("DailyTaskProfilePop", require("app.fairyGUI.dailyTask.UI_DailyTaskProfilePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/dailyTask/dailyTask",
		resName = "DailyTaskProfilePop",
		pkgName = "dailyTask"
	}, ...)
end)

function DailyTaskProfilePop:ctor(arg_2_1)
	self:addListen(self.m_profileList)

	self._profileListData = {}
	self._profileLevel = 0
	self._firstSelectIndex = 1
	self._secondSelectIndex = 2
	self._subChooseId = nil
	self._isFirstEnter = true
	self._expand = true
	self._curSubItem = nil

	self:showAtCenter()
	self.m_profileList:setVirtual()
	self.m_profileList:setItemProvider(handler(self, self._setProfileItemProvider))
	self.m_profileList:setItemRenderer(handler(self, self._onProfileItemRenderer))
end

function DailyTaskProfilePop:onLoad()
	if self._isFirstEnter then
		self._firstSelectIndex, self._secondSelectIndex, self._subChooseId, self._curMainType = var_0_0:getCurItemIndexWhenFirstEnter()

		self.m_rightInfoComp:updateInfo(self._subChooseId)
	end

	self:_updateView()
	self:_updateCurSubItem()

	if self._isFirstEnter and not var_0_0:isProfileCellCanGetAward(self._subChooseId) then
		var_0_0:setNewProfileClickRecord(self._subChooseId)
	end

	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_DAILY_TASK_PROFILEAWARD, self._onRecGetProfileAward, self)

	self._isFirstEnter = false
end

function DailyTaskProfilePop:_updateView()
	self:_updateProfileProgress()
	self:_updateProfileList()
end

function DailyTaskProfilePop:_updateProfileProgress()
	local var_5_0 = var_0_0:getDailyTaskBasicInfo()
	local var_5_1, var_5_2 = var_0_0:getDailyTaskProfileValueByExp()

	self.m_levelTxt:setText(var_5_1)
	self.m_profileValue:setText(var_5_0.profileExp .. "/" .. var_5_2)
	self.m_profileProgress:setPercent({
		cur = var_5_0.profileExp,
		max = var_5_2
	})
end

function DailyTaskProfilePop:_updateProfileList()
	self._profileListData = var_0_0:updateProfileListDataByType(self._curMainType, self._expand)

	self.m_profileList:setNumItems(#self._profileListData)
end

function DailyTaskProfilePop:_updateListChooseStateWhenMainClick()
	self._firstSelectIndex = var_0_0:getCurItemIndexWhenMainClick(self._curMainType)

	self.m_profileList:setSelectedIndex(self._firstSelectIndex - 1)

	self._secondSelectIndex = self._expand and self._firstSelectIndex + 1 or nil
	self._subChooseId = var_0_0:getAllProfileCfgInfo()[self._curMainType][1].id

	self.m_rightInfoComp:updateInfo(self._subChooseId)
end

function DailyTaskProfilePop:_setProfileItemProvider(arg_8_1)
	if self._profileListData[arg_8_1 + 1] then
		if self._profileListData[arg_8_1 + 1].isMain then
			return "ui://dailyTask/DailyTaskProfileMainCell"
		else
			return "ui://dailyTask/DailyTaskProfileSubCell"
		end
	end
end

function DailyTaskProfilePop:_onProfileItemRenderer(arg_9_1, arg_9_2)
	local var_9_0 = clone(self._profileListData[arg_9_1 + 1])

	if var_9_0 then
		arg_9_2:updateItem(var_9_0, clone(self._subChooseId), clone(self._curMainType), arg_9_1)
	end
end

function DailyTaskProfilePop:_onRecGetProfileAward(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 and arg_10_3.awards then
		for iter_10_0, iter_10_1 in ipairs(arg_10_3.awards) do
			iter_10_1.changeControllers = true
			iter_10_1.nameRow = 2
		end

		require("app.view.module.show.ShowFactory"):awardSummary(arg_10_3.awards)
	end

	self:_updateProfileList()
end

function DailyTaskProfilePop:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "MainCellClick" then
		self._curMainType = arg_11_2.type
		self._expand = arg_11_2.isExpand
		self._profileListData = var_0_0:updateProfileListDataByType(self._curMainType, self._expand)

		self:_updateListChooseStateWhenMainClick()
		self:_updateProfileList()
		self:_updateCurSubItem()

		if not var_0_0:isProfileCellCanGetAward(self._subChooseId) then
			var_0_0:setNewProfileClickRecord(self._subChooseId)
		end
	elseif arg_11_1 == "SubCellClick" then
		var_0_0:setPreSubItemNewState(self._subChooseId)

		if self._subChooseId ~= arg_11_2.subId then
			self._subChooseId = arg_11_2.subId
			self._secondSelectIndex = arg_11_2.index + 1

			self:_updateProfileList()
			self.m_rightInfoComp:updateInfo(self._subChooseId)

			if self._curSubItem and self._curSubItem.setChooseState then
				self._curSubItem:setChooseState(false)
				self:_updateCurSubItem()
			end
		end
	end
end

function DailyTaskProfilePop:_updateCurSubItem()
	local var_12_0 = self.m_profileList:numChildren()

	if self._secondSelectIndex then
		if var_12_0 < self._secondSelectIndex then
			self._secondSelectIndex = var_12_0
		end

		local var_12_1 = self.m_profileList:getChildAt(self._secondSelectIndex - 1)

		if var_12_1 then
			self._curSubItem = var_12_1
		end
	else
		self._curSubItem = nil
	end
end

function DailyTaskProfilePop:_judgeIsHasDialogPlay()
	if not self._subChooseId then
		return
	end

	local var_13_0 = var_0_0:getProfileLevelInfo()[self._subChooseId]

	if not var_13_0 then
		return
	end

	if not var_0_0:judgeProfileHasClick(self._subChooseId) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = var_13_0.talk_num
		})
	end
end

return DailyTaskProfilePop
