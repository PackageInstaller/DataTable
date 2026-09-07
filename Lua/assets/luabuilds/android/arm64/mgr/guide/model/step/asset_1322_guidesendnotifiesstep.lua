local GuideSendNotifiesStep = class("GuideSendNotifiesStep", import(".GuideStep"))

function GuideSendNotifiesStep:Ctor(arg_1_1)
	GuideSendNotifiesStep.super.Ctor(self, arg_1_1)

	self.notifies = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.notifies) do
		table.insert(self.notifies, {
			notify = iter_1_1.notify,
			body = iter_1_1.body
		})
	end

	return
end

function GuideSendNotifiesStep:GetType()
	return GuideStep.TYPE_SENDNOTIFIES
end

function GuideSendNotifiesStep:GetNotifies()
	return self.notifies
end

function GuideSendNotifiesStep:ExistTrigger()
	return true
end

return GuideSendNotifiesStep
