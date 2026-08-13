return {
	IsUnlockAtelier = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_0:getConfig("config_client")[arg_1_1]

		tonumber = var_1_10003

		local var_1_1 = var_1_10003(var_1_0.unlockStageID)
		local var_1_2 = var_1_0.unlockStoryID
		local var_1_3 = true

		if var_1_1 then
			getProxy = var_1_10006
			ChapterProxy = var_1_10008

			local var_1_4 = var_1_10006(var_1_10008)

			var_1_3 = var_1_10006.getChapterById(var_1_4, var_1_1, true) and var_7:isClear()
		end

		if var_1_2 and var_1_3 then
			pg = var_1_10006

			local var_1_5 = var_1_10006.NewStoryMgr.GetInstance()

			var_1_3 = var_6.IsPlayed(var_1_5, var_1_2)
		end

		return var_1_3
	end,
	UpdateYumiaItem = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1
		local var_2_1 = arg_2_1.GetRarity(var_2_0)

		ItemRarity = var_1_10003

		local var_2_2 = var_1_10003.Rarity2Print(var_2_1)

		GetImageSpriteFromAtlasAsync = var_2_0

		var_2_0("weaponframes", "bg" .. var_2_2, arg_2_0:Find("IconTpl/icon_bg"))

		GetImageSpriteFromAtlasAsync = var_2_0

		var_2_0(arg_2_1:GetIconPath(), "", arg_2_0:Find("IconTpl/icon_bg/icon"))

		local var_2_3 = arg_2_1:GetProps()
		local var_2_4 = arg_2_0:Find("List")

		for iter_2_0 = 0, 3 do
			local var_2_5 = var_2_4
			local var_2_6 = var_2_4.GetChild(var_2_5, iter_2_0)
			local var_2_7

			table = var_2_5

			if var_2_5.contains(var_2_3, iter_2_0 + 1) then
				AtelierFormulaCircle = var_12
				var_2_7 = var_12.ELEMENT_NAME[iter_2_0 + 1]
			else
				AtelierFormulaCircle = var_12
				var_2_7 = var_12.ELEMENT_NAME[iter_2_0 + 1] .. "_2"
			end

			GetImageSpriteFromAtlasAsync = var_12

			var_12("ui/ateliercommonyumiaui_atlas", var_2_7, var_2_6)
		end

		if arg_2_1:GetCategory() ~= 0 then
			GetImageSpriteFromAtlasAsync = var_7

			var_7("ui/ateliercommonyumiaui_atlas", "category" .. var_6, arg_2_0:Find("categoryBg/category"))
		end

		setActive = var_7

		var_7(arg_2_0:Find("categoryBg"), var_6 ~= 0)

		setText = var_7

		var_7(arg_2_0:Find("cntText"), arg_2_1.count)

		return
	end
}
