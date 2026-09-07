local ChapterRewardPanel = class("ChapterRewardPanel", BaseSubView)

function ChapterRewardPanel:getUIName()
	return "ChapterRewardPanel"
end

function ChapterRewardPanel:OnInit()
	setText(self._tf:Find("window/bg/text"), i18n("desc_defense_reward"))

	self.UIlist = UIItemList.New(self._tf:Find("window/bg/panel/list"), self._tf:Find("window/bg/panel/list/item"))
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.confirmBtn = self._tf:Find("window/btn_confirm")

	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

local var_0_1 = {
	"s",
	"a",
	"b"
}

local function var_0_2(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.UIlist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			setText(arg_7_2:Find("title/Text"), "PHASE " .. arg_7_1 + 1)

			local var_7_0 = tostring(arg_6_2[arg_7_1 + 1] - 1)

			if arg_6_2[arg_7_1 + 1] - 1 ~= arg_6_2[arg_7_1 + 2] then
				var_7_0 = tostring(arg_6_2[arg_7_1 + 2]) .. "-" .. var_7_0
			end

			setText(arg_7_2:Find("target/title"), i18n("text_rest_HP") .. "：")
			setText(arg_7_2:Find("target/Text"), var_7_0)

			local var_7_1 = arg_6_3[arg_7_1 + 1]

			updateDrop(arg_7_2:Find("award"), arg_6_3[arg_7_1 + 1], {
				hideName = true
			})
			onButton(arg_6_0, arg_7_2:Find("award"), function()
				arg_6_0:emit(BaseUI.ON_DROP, var_7_1)

				return
			end, SFX_PANEL)
			setActive(arg_7_2:Find("award/mask"), false)
		end

		return
	end)
	arg_6_0.UIlist:align(#arg_6_3)

	return
end

function ChapterRewardPanel:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	ChapterRewardPanel.super.Show(self)

	return
end

function ChapterRewardPanel:Hide()
	ChapterRewardPanel.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ChapterRewardPanel:Enter(arg_11_1)
	assert(pg.chapter_defense[arg_11_1.id], "Chapter Detail should only be Defense Type")

	local var_11_0 = Clone(pg.chapter_defense[arg_11_1.id].score)

	table.insert(var_11_0, 1, pg.chapter_defense[arg_11_1.id].port_hp + 1)

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(var_0_1) do
		if #pg.chapter_defense[arg_11_1.id]["evaluation_display_" .. iter_11_1] > 0 then
			table.insert(var_11_1, {
				type = pg.chapter_defense[arg_11_1.id]["evaluation_display_" .. iter_11_1][1],
				id = pg.chapter_defense[arg_11_1.id]["evaluation_display_" .. iter_11_1][2],
				count = pg.chapter_defense[arg_11_1.id]["evaluation_display_" .. iter_11_1][3]
			})
		end
	end

	var_0_2(self, pg.chapter_defense[arg_11_1.id], var_11_0, var_11_1)
	self:Show()
	Canvas.ForceUpdateCanvases()

	return
end

function ChapterRewardPanel:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

return ChapterRewardPanel
