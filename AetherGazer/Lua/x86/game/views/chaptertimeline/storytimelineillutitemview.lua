local var_0_0 = import("game.views.chapterTimeLine.StoryTimeLineItemBaseView")
local var_0_1 = class("StoryTimeLineIllutItemView", var_0_0)

function var_0_1.RefreshData(arg_1_0)
	arg_1_0.isIllu_ = true
end

function var_0_1.RefreshItem(arg_2_0)
	arg_2_0.categoryController_:SetSelectedState("main")

	cfg = StoryCfg
	arg_2_0.nameText_.text = GetI18NText(StoryCfg[arg_2_0.id_].name)
	arg_2_0.illCollectNumText_.text = "1/1"

	SetSpriteWithoutAtlasAsync(arg_2_0.img_, SpritePathCfg.CollectPlotSmall.path .. CollectStoryCfg[arg_2_0.id_].picture)
end

function var_0_1.SetClickCallBack(arg_3_0, arg_3_1)
	arg_3_0.clickCallBack_ = arg_3_1
end

function var_0_1.SetInfo(arg_4_0, arg_4_1)
	arg_4_0.info_ = arg_4_1
end

function var_0_1.SetUnlockNum(arg_5_0, arg_5_1)
	arg_5_0.unlockNum_ = arg_5_1
end

return var_0_1
