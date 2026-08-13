local var_0_0 = {}

GalleryConst = GalleryConst
var_0.Version = 3
var_0.AutoScrollIndex = 41
var_0.NewCount = 15
var_0.CardStates = {
	Unlocked = 1
}
var_0.Sort_Order_Up = 0
var_0.Sort_Order_Down = 1
var_0.Filte_Normal_Value = 0
var_0.Filte_Like_Value = 1
var_0.Filte_Set_Normal_Value = 0
var_0.Filte_Set_Value = 1
var_0.CARD_PATH_PREFIX = "gallerypic/"
var_0.PIC_PATH_PREFIX = "gallerypic/"

function var_0.GetGalleryPicPathByID(arg_1_0)
	pg = var_1_10001

	if not var_1_10001.gallery_config[arg_1_0] then
		return nil
	end

	local var_1_0 = var_1.illustration

	return var_0.PIC_PATH_PREFIX .. var_1_0
end

function var_0.GetGalleryPreviewPicPathByID(arg_2_0)
	pg = var_1_10001

	if not var_1_10001.gallery_config[arg_2_0] then
		return nil
	end

	local var_2_0 = var_1.illustration .. "_t"

	return var_0.CARD_PATH_PREFIX .. var_2_0
end

function var_0.isGalleryLikeByID(arg_3_0)
	getProxy = var_1_10001
	AppreciateProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getGalleryLikeIDList(var_3_0)

	table = var_3_0

	return var_3_0.contains(var_3_1, arg_3_0)
end

return var_0
