local var_0_0 = class("ChapterPartBtnView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.partBtnItemList_ = {}

	for iter_1_0 = 1, arg_1_0.transform_.childCount do
		local var_1_0 = arg_1_0[string.format("chapterPart%sGo_", iter_1_0)]

		if var_1_0 then
			arg_1_0.partBtnItemList_[iter_1_0] = ChapterPartBtnItem.New(var_1_0, iter_1_0)
		end
	end
end

function var_0_0.OnEnter(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.partBtnItemList_) do
		iter_2_1:OnEnter()
	end
end

function var_0_0.OnExit(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.partBtnItemList_) do
		iter_3_1:OnExit()
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.partBtnItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.partBtnItemList_ = nil
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	local var_6_0 = getChapterClientCfgByChapterID(arg_6_1)

	if #var_6_0.chapter_list > 1 and (var_6_0.id == ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 or var_6_0.id == ChapterConst.CHAPTER_CLIENT_LUWU_ZHIMING or var_6_0.id == ChapterConst.CHAPTER_CLIENT_OUMOFEISI or var_6_0.id == ChapterConst.CHAPTER_CLIENT_BAICHAO or var_6_0.id == ChapterConst.CHAPTER_CLIENT_KEERGAI or var_6_0.id == ChapterConst.CHAPTER_CLIENT_21) then
		arg_6_0:Show(true)

		local var_6_1 = var_6_0.chapter_list

		for iter_6_0 = 1, arg_6_0.transform_.childCount do
			if arg_6_0.partBtnItemList_[iter_6_0] then
				if not var_6_1[iter_6_0] then
					arg_6_0.partBtnItemList_[iter_6_0]:SetActive(false)
				else
					arg_6_0.partBtnItemList_[iter_6_0]:SetActive(true)
					arg_6_0.partBtnItemList_[iter_6_0]:SetChapterID(var_6_1[iter_6_0], arg_6_1)
				end
			end
		end
	else
		arg_6_0:Show(false)
	end
end

return var_0_0
