local var_0_0 = g.core.model.User.activityLevelUpData
local var_0_2 = g.core.const.ConstMgr.SpineConst
local ActivityLevelUpDialogComp = class("ActivityLevelUpDialogComp", require("app.fairyGUI.activity.UI_ActivityLevelUpDialogComp"))

function ActivityLevelUpDialogComp:ctor()
	self._spineId = nil
	self._nextLevelData = nil
end

function ActivityLevelUpDialogComp:updateComp()
	self._nextLevelData = var_0_0:getNextLevelUpTaskData()

	self:_updateNpc()
end

function ActivityLevelUpDialogComp:_updateNpc()
	local var_3_0 = self:_getShowNpc()

	if self._spineId ~= var_3_0 then
		self._spineId = var_3_0

		local var_3_1 = {
			scale = 0.9,
			resId = self._spineId
		}

		if self._spineId == 510030 and config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
			var_3_1.knightUrl = table.concat({
				"icon/knight_big/",
				510030,
				".png"
			})
		end

		self.m_knightPicComp:updateKnight(var_3_1)
		self.m_knightPicComp:setAlphaRect(var_0_2.MASK_TYPE.HORIZON, cc.rect(-200, 0, 250, 0), 200)
	end
end

function ActivityLevelUpDialogComp:_getShowNpc()
	return 510030
end

return ActivityLevelUpDialogComp
