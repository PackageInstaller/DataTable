local MedalCollectionTemplateView = class("MedalCollectionTemplateView", import("view.base.BaseUI"))

MedalCollectionTemplateView.MEDAL_STATUS_UNACTIVATED = 1
MedalCollectionTemplateView.MEDAL_STATUS_ACTIVATED = 2
MedalCollectionTemplateView.MEDAL_STATUS_ACTIVATABLE = 3

function MedalCollectionTemplateView:UpdateActivity(arg_1_1)
	self.activityData = arg_1_1
	self.allIDList = self.activityData:GetPicturePuzzleIds()
	self.activatableIDList = self.activityData.data1_list
	self.activeIDList = self.activityData.data2_list

	return
end

function MedalCollectionTemplateView:didEnter()
	self:CheckAward()

	return
end

function MedalCollectionTemplateView:UpdateAfterSubmit(arg_3_1)
	self:CheckAward()

	return
end

function MedalCollectionTemplateView:UpdateAfterFinalMedal()
	return
end

function MedalCollectionTemplateView:CheckAward()
	if #self.activeIDList == #self.allIDList and self.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = self.activityData.id
		})
	end

	return
end

return MedalCollectionTemplateView
