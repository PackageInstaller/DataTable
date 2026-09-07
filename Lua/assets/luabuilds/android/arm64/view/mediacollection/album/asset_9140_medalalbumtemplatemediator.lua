local MedalAlbumTemplateMediator = class("MedalAlbumTemplateMediator", import("view.base.ContextMediator"))

MedalAlbumTemplateMediator.ON_TASK_GO = "ON_TASK_GO"
MedalAlbumTemplateMediator.ON_TASK_SUBMIT = "ON_TASK_SUBMIT"

function MedalAlbumTemplateMediator:register()
	self:BindEvent()
	self.viewComponent:SetMedalGroupData((getProxy(PlayerProxy):getRawData():getActivityMedalGroup()))

	if self:GetContext().parent.mediator.__cname == "WorldMediaCollectionMediator" then
		self.viewComponent:ShowPageBtn(true)
	else
		self.viewComponent:ShowPageBtn(false)
	end

	return
end

function MedalAlbumTemplateMediator:BindEvent()
	self:bind(MedalAlbumTemplateMediator.ON_TASK_GO, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	self:bind(MedalAlbumTemplateMediator.ON_TASK_SUBMIT, function(arg_4_0, arg_4_1, arg_4_2)
		seriesAsync({
			function(arg_5_0)
				self.awardIndex = 0
				self.showAwards = {}

				self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
					act_id = arg_4_1:getActId(),
					task_ids = {
						arg_4_1.id
					},
					callback = arg_5_0
				})

				return
			end
		}, function()
			self.viewComponent:SetMedalGroupData((getProxy(PlayerProxy):getRawData():getActivityMedalGroup()))
			self.viewComponent:UpdateView()
			existCall(arg_4_2)

			return
		end)

		return
	end)

	return
end

function MedalAlbumTemplateMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function MedalAlbumTemplateMediator:handleNotification(arg_8_1)
	if arg_8_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if getProxy(ContextProxy):getCurrentContext().mediator.__cname == "WorldMediaCollectionMediator" then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_8_1:getBody().awards)
		end

		self.viewComponent:FlushTaskPanel()
	end

	return
end

return MedalAlbumTemplateMediator
