local RhythmGameAffixDescriptionView = class("RhythmGameAffixDescriptionView", (import("game.views.setting.AffixDescriptionView")))

function RhythmGameAffixDescriptionView:CreatItems()
	for iter_1_0, iter_1_1 in ipairs(self.data) do
		if not self.items[1] then
			local var_1_0 = Object.Instantiate(self.m_item, self.m_content)
			local var_1_1 = {
				go = var_1_0
			}

			var_1_1.desc = var_1_0.transform:Find("text"):GetComponent("Text")
			var_1_1.name = var_1_0.transform:Find("title/name"):GetComponent("Text")
			var_1_1.icon = var_1_0.transform:Find("title/icon"):GetComponent("Image")
			self.items[1] = var_1_1
		end

		self:RenderItme(self.items[1], iter_1_1)
	end

	self.emptyController:SetSelectedIndex(4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)
end

return RhythmGameAffixDescriptionView
