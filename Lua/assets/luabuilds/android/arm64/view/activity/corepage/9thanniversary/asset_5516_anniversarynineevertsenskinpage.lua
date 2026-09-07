local AnniversaryNineEvertsenSkinPage = class("AnniversaryNineEvertsenSkinPage", import("view.activity.CorePage.9thAnniversary.AnniversaryNineHwahJahSkinPage"))

function AnniversaryNineEvertsenSkinPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.dayTF = self.bg:Find("total_progress/day")
	self.maxDayTF = self.bg:Find("total_progress/max_day")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.btnDetail = self.bg:Find("btn_detail")
	self.txtDetail = self.btnDetail:Find("detail")
	self.btnStory = self.bg:Find("btn_story")
	self.taskWindow = AnniversaryNineEvertsenTaskWindow.New(self._tf, self.event)

	setActive(self.item, false)

	self.progressLabel = self.bg:Find("total_progress/label_1")

	setText(self.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(self.txtDetail, i18n("Outpost_20260514_Detail"))

	return
end

return AnniversaryNineEvertsenSkinPage
