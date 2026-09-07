local MainActAtelierBtn = class("MainActAtelierBtn", import(".MainBaseActivityBtn"))

function MainActAtelierBtn:GetEventName()
	return "event_Atelier"
end

function MainActAtelierBtn:OnInit()
	setActive(self.tipTr.gameObject, false)

	return
end

return MainActAtelierBtn
