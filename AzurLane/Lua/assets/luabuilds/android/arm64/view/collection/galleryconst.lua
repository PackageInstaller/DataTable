GalleryConst = {}

local var_0_0 = GalleryConst

GalleryConst.Version = 3
GalleryConst.AutoScrollIndex = 41
GalleryConst.NewCount = 15
GalleryConst.CardStates = {
	Unlocked = 1
}
GalleryConst.Sort_Order_Up = 0
GalleryConst.Sort_Order_Down = 1
GalleryConst.Filte_Normal_Value = 0
GalleryConst.Filte_Like_Value = 1
GalleryConst.Filte_Set_Normal_Value = 0
GalleryConst.Filte_Set_Value = 1
GalleryConst.CARD_PATH_PREFIX = "gallerypic/"
GalleryConst.PIC_PATH_PREFIX = "gallerypic/"

function GalleryConst.GetGalleryPicPathByID(arg_1_0)
	if not pg.gallery_config[arg_1_0] then
		return nil
	end

	return var_0_0.PIC_PATH_PREFIX .. pg.gallery_config[arg_1_0].illustration
end

function GalleryConst.GetGalleryPreviewPicPathByID(arg_2_0)
	if not pg.gallery_config[arg_2_0] then
		return nil
	end

	return var_0_0.CARD_PATH_PREFIX .. pg.gallery_config[arg_2_0].illustration .. "_t"
end

function GalleryConst.isGalleryLikeByID(arg_3_0)
	return table.contains(getProxy(AppreciateProxy):getGalleryLikeIDList(), arg_3_0)
end

return GalleryConst
