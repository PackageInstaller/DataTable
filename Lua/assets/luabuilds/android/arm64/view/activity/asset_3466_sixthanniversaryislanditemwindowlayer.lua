local SixthAnniversaryIslandItemWindowLayer = class("SixthAnniversaryIslandItemWindowLayer", import("..base.BaseUI"))

function SixthAnniversaryIslandItemWindowLayer:getUIName()
	return "SixthAnniversaryIslandItemWindow"
end

function SixthAnniversaryIslandItemWindowLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setText(self._tf:Find("content/bottom/Text"), self.contextData.text)
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function SixthAnniversaryIslandItemWindowLayer:didEnter()
	local var_4_0 = self.contextData.drop
	local var_4_1 = self._tf:Find("content/main")
	local var_4_2, var_4_3 = unpack(self.contextData.drop.count and {
		var_4_0.count,
		true
	} or {
		var_4_0:getOwnedCount()
	})

	setActive(var_4_1:Find("owner"), var_4_3)

	if var_4_3 then
		setText(var_4_1:Find("owner"), i18n("word_own1") .. var_4_2)
	end

	var_4_0.count = nil

	updateDrop(var_4_1:Find("icon/IconTpl"), var_4_0)
	setText(var_4_1:Find("line/name"), var_4_0:getConfig("name"))
	setText(var_4_1:Find("line/content/Text"), var_4_0.desc or var_4_0:getConfig("desc"))

	return
end

function SixthAnniversaryIslandItemWindowLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return SixthAnniversaryIslandItemWindowLayer
