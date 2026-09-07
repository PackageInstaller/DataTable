local SixthAnniversaryJPHotSpringScene = class("SixthAnniversaryJPHotSpringScene", import("view.activity.BackHills.NewYearFestival.NewYearHotSpringScene"))

function SixthAnniversaryJPHotSpringScene:getUIName()
	return "SixthAnniversaryJPHotSpringUI"
end

function SixthAnniversaryJPHotSpringScene:init()
	SixthAnniversaryJPHotSpringScene.super.init(self)

	return
end

function SixthAnniversaryJPHotSpringScene:didEnter()
	SixthAnniversaryJPHotSpringScene.super.didEnter(self)
	onButton(self, self._tf:Find("Top/Help"), function()
		MsgboxMediator.ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hotspring_help.tip,
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

function SixthAnniversaryJPHotSpringScene:willExit()
	SixthAnniversaryJPHotSpringScene.super.willExit(self)

	return
end

return SixthAnniversaryJPHotSpringScene
