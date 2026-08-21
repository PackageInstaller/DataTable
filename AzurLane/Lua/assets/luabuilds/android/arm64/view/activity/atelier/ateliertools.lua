return {
	IsUnlockAtelier = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_0:getConfig("config_client")[arg_1_1]
		local var_1_1 = tonumber(var_1_0.unlockStageID)
		local var_1_2 = true

		if var_1_1 then
			local var_1_3 = getProxy(ChapterProxy):getChapterById(var_1_1, true)

			var_1_2 = var_1_3 and var_1_3:isClear()
		end

		if var_1_0.unlockStoryID then
			var_1_2 = var_1_2 and pg.NewStoryMgr.GetInstance():IsPlayed(var_1_0.unlockStoryID)
		end

		return var_1_2
	end,
	UpdateYumiaItem = function(arg_2_0, arg_2_1)
		GetImageSpriteFromAtlasAsync("weaponframes", "bg" .. ItemRarity.Rarity2Print((arg_2_1:GetRarity())), arg_2_0:Find("IconTpl/icon_bg"))
		GetImageSpriteFromAtlasAsync(arg_2_1:GetIconPath(), "", arg_2_0:Find("IconTpl/icon_bg/icon"))

		local var_2_0 = arg_2_1:GetProps()
		local var_2_1 = arg_2_0:Find("List")

		for iter_2_0 = 0, 3 do
			local var_2_2 = var_2_1:GetChild(iter_2_0)
			local var_2_3 = table.contains(var_2_0, iter_2_0 + 1) and AtelierFormulaCircle.ELEMENT_NAME[iter_2_0 + 1] or AtelierFormulaCircle.ELEMENT_NAME[iter_2_0 + 1] .. "_2"

			GetImageSpriteFromAtlasAsync("ui/ateliercommonyumiaui_atlas", var_2_3, var_2_2)
		end

		local var_2_4 = arg_2_1:GetCategory()

		if var_2_4 ~= 0 then
			GetImageSpriteFromAtlasAsync("ui/ateliercommonyumiaui_atlas", "category" .. var_2_4, arg_2_0:Find("categoryBg/category"))
		end

		setActive(arg_2_0:Find("categoryBg"), var_2_4 ~= 0)
		setText(arg_2_0:Find("cntText"), arg_2_1.count)

		return
	end
}
