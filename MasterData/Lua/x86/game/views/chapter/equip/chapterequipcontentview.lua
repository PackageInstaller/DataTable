local ChapterEquipContentView = class("ChapterEquipContentView", import("..ChapterBaseContentView"))

function ChapterEquipContentView:RefreshMapItems()
	for iter_1_0 = #self.itemList_ + 1, #ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_] do
		local var_1_0 = ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_1_0] == 203 and ChapterEquipEnchantmentItemView.New(self.mapItem_, self.itemParent_, ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_1_0], self.chapterToggle_) or ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_1_0] == 204 and ChapterEquipExperienceItemView.New(self.mapItem_, self.itemParent_, ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_1_0], self.chapterToggle_) or ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_1_0] == 205 and ChapterEquipSeizureItemView.New(self.mapItem_, self.itemParent_, ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_1_0], self.chapterToggle_) or ChapterEquipItemView.New(self.mapItem_, self.itemParent_, ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_1_0], self.chapterToggle_)

		if var_1_0 then
			table.insert(self.itemList_, {
				virtualItem = ChapterBaseVirtualItemView.New(self.mapVirtualItem_, self.itemParent_),
				renderItem = var_1_0
			})
		end
	end
end

return ChapterEquipContentView
