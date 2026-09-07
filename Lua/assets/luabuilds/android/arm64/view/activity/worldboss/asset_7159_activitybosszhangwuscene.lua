local ActivityBossZhangwuScene = class("ActivityBossZhangwuScene", import(".ActivityBossJianwuScene"))

function ActivityBossZhangwuScene:getUIName()
	return "ActivityBossZhangwuUI"
end

function ActivityBossZhangwuScene:init()
	ActivityBossZhangwuScene.super.init(self)
	setText(self.right:Find("1/Image"), i18n("word_easy"))
	setText(self.right:Find("2/Image"), i18n("word_normal_junhe"))
	setText(self.right:Find("3/Image"), i18n("word_hard"))
	setText(self.top:Find("ticket/Desc"), i18n("word_special_challenge_ticket"))
	setAnchoredPosition(self.left, {
		x = 0
	})
	setAnchoredPosition(self.right, {
		x = 0
	})

	return
end

return ActivityBossZhangwuScene
