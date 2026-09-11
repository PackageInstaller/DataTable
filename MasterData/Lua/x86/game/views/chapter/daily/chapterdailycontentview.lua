local ChapterDailyContentView = class("ChapterDailyContentView", import("..ChapterBaseContentView"))

function ChapterDailyContentView:RefreshMapItems()
	for iter_1_0 = #self.itemList_ + 1, #ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_] do
		local var_1_0 = self:CreateItem(ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_1_0])

		if var_1_0 then
			table.insert(self.itemList_, {
				virtualItem = ChapterBaseVirtualItemView.New(self.mapVirtualItem_, self.itemParent_),
				renderItem = var_1_0
			})
		end
	end
end

function ChapterDailyContentView:CreateItem(arg_2_1)
	return (ChapterDailyItemView.New(self.mapItem_, self.itemParent_, arg_2_1, self.chapterToggle_))
end

return ChapterDailyContentView
