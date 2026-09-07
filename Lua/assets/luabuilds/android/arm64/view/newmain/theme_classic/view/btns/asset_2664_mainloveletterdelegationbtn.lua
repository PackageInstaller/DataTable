local MainLoveLetterDelegationBtn = class("MainLoveLetterDelegationBtn", import(".MainBaseSpcailActBtn"))

function MainLoveLetterDelegationBtn:GetContainer()
	return self.root.parent:Find("eventPanel")
end

function MainLoveLetterDelegationBtn:InShowTime()
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_UP)

	return var_2_0 and not var_2_0:isEnd()
end

function MainLoveLetterDelegationBtn:GetUIName()
	return "MainLoveLetterDelegationBtn"
end

function MainLoveLetterDelegationBtn:OnClick()
	self.event:emit(NewMainMediator.GO_SCENE, SCENE.LOVE_LETTER_ACTIVITY)

	return
end

function MainLoveLetterDelegationBtn:OnInit()
	return
end

function MainLoveLetterDelegationBtn:OnRegister()
	return
end

function MainLoveLetterDelegationBtn:OnClear()
	return
end

return MainLoveLetterDelegationBtn
