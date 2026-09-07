local SixthAnniversaryIslandFlowerWindowLayer = class("SixthAnniversaryIslandFlowerWindowLayer", import("..base.BaseUI"))

function SixthAnniversaryIslandFlowerWindowLayer:getUIName()
	return "SixthAnniversaryIslandFlowerWindow"
end

function SixthAnniversaryIslandFlowerWindowLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setText(self._tf:Find("content/title/Text"), i18n("islandnode_tips7", self.contextData.name))

	local var_2_0 = self._tf:Find("content/main/content")

	self.itemList = UIItemList.New(var_2_0, var_2_0:Find("icon"))

	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			updateDrop(arg_3_2:Find("IconTpl"), self.contextData.awards[arg_3_1])
		end

		return
	end)
	self.itemList:align(#self.contextData.awards)
	onButton(self, self._tf:Find("content/bottom/btn"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function SixthAnniversaryIslandFlowerWindowLayer:didEnter()
	return
end

function SixthAnniversaryIslandFlowerWindowLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return SixthAnniversaryIslandFlowerWindowLayer
