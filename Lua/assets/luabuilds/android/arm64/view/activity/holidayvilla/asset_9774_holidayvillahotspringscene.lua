local HolidayVillaHotSpringScene = class("HolidayVillaHotSpringScene", import("view.activity.BackHills.NewYearFestival.NewYearHotSpringScene"))

function HolidayVillaHotSpringScene:getUIName()
	return "HolidayVillaHotSpringUI"
end

function HolidayVillaHotSpringScene:init()
	HolidayVillaHotSpringScene.super.init(self)

	return
end

function HolidayVillaHotSpringScene:didEnter()
	HolidayVillaHotSpringScene.super.didEnter(self)
	onButton(self, self._tf:Find("Top/Help"), function()
		MsgboxMediator.ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.holiday_tip_spring.tip,
			contextSprites = {
				{
					path = "props/wenquanshoupai",
					name = "wenquanshoupai"
				}
			}
		})

		return
	end, SFX_PANEL)
	setImageSprite(self.top:Find("Ticket/Icon"), LoadSprite("props/wenquanshoupai", "wenquanshoupai"))

	return
end

function HolidayVillaHotSpringScene:willExit()
	HolidayVillaHotSpringScene.super.willExit(self)

	return
end

return HolidayVillaHotSpringScene
