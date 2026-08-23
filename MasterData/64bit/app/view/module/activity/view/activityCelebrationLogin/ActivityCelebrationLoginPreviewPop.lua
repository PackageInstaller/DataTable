local ActivityCelebrationLoginPreviewPop = class("ActivityCelebrationLoginPreviewPop", require("app.fairyGUI.activity.UI_ActivityCelebrationLoginPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityCelebrationLoginPreviewPop",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	}, ...)
end)

function ActivityCelebrationLoginPreviewPop:ctor(arg_2_1)
	self:showAtCenter()
	self:_updateView(arg_2_1)
end

function ActivityCelebrationLoginPreviewPop:_updateView(arg_3_1)
	self.m_previewComp:updateView(arg_3_1)
end

return ActivityCelebrationLoginPreviewPop
