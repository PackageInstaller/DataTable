local MainActCompensatBtn = class("MainActCompensatBtn", import(".MainBaseSpcailActBtn"))

function MainActCompensatBtn:GetContainer()
	return self.root.parent:Find("link_top/layout")
end

function MainActCompensatBtn:InShowTime()
	return getProxy(CompensateProxy):hasRewardCount()
end

function MainActCompensatBtn:GetUIName()
	return "MainActCompensatBtn"
end

function MainActCompensatBtn:OnClick()
	self.event:emit(NewMainMediator.OPEN_Compensate)

	return
end

function MainActCompensatBtn:OnRegister()
	return
end

function MainActCompensatBtn:OnClear()
	return
end

return MainActCompensatBtn
