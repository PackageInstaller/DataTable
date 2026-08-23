local var_0_0 = g.core.model.User.dailyTaskData
local DailyTaskProfileSubCell = class("DailyTaskProfileSubCell", require("app.fairyGUI.dailyTask.UI_DailyTaskProfileSubCell"))

function DailyTaskProfileSubCell:ctor(arg_1_1)
	self._id = 1

	self:addClickListener(handler(self, self._onClick))
end

function DailyTaskProfileSubCell:updateItem(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.m_lockStateController:setSelectedIndex(1)

	self._data = arg_2_1
	self._id = arg_2_1.id
	self._isNew = arg_2_1.isNew
	self._index = arg_2_4

	self:setTitle(arg_2_1.proflie or "")

	if arg_2_1.lockState == 1 then
		self:setTitle(g.core.lang:get(106502, {
			num = arg_2_1.id
		}))
	end

	if self._isNew then
		self:_updateContent(arg_2_1, arg_2_2)
	else
		self:_updateContent(arg_2_1, arg_2_2)
	end
end

function DailyTaskProfileSubCell:_updateContent(arg_3_1, arg_3_2)
	self.m_chooseStateController:setSelectedIndex(self._id == arg_3_2 and 0 or 1)
	self.m_isNewController:setSelectedIndex(arg_3_1.isNew and 1 or 0)
	self.m_hasGiftController:setSelectedIndex(arg_3_1.hasGift and 1 or 0)
	self.m_lockStateController:setSelectedIndex(arg_3_1.lockState)

	if arg_3_1.awardState then
		self.m_awardStateController:setSelectedIndex(arg_3_1.awardState)
	end
end

function DailyTaskProfileSubCell:_onClick()
	if self._data.lockState == 1 then
		if self._data.hasGift then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.dailyTask.view.DailyTaskProfileBoxAwardPop").new({
				isUnLock = false,
				profileId = self._id
			})))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(106502, {
				num = self._data.id
			}))
		end

		return
	end

	self.m_chooseStateController:setSelectedIndex(0)

	if self._isNew then
		var_0_0:setNewProfileClickRecord(self._id)
		self.m_isNewController:setSelectedIndex(0)
	end

	self:dispatchCompEvent("SubCellClick", {
		subId = self._id,
		index = self._index
	})
	self:_checkIsHasGift()
end

function DailyTaskProfileSubCell:setChooseState(arg_5_1)
	self.m_chooseStateController:setSelectedIndex(arg_5_1 and 0 or 1)
end

function DailyTaskProfileSubCell:_checkIsHasGift()
	if self._data.lockState == 0 and self._data.hasGift then
		if self._data.awardState == 0 then
			g.core.network.GameNetProxy:send_C2S_DailyTask_ProfileAward({
				id = self._id
			})
		else
			g.core.module.ModuleManager:pushPopup((require("app.view.module.dailyTask.view.DailyTaskProfileBoxAwardPop").new({
				isUnLock = true,
				profileId = self._id
			})))
		end
	end
end

function DailyTaskProfileSubCell:getId()
	return self._id
end

return DailyTaskProfileSubCell
