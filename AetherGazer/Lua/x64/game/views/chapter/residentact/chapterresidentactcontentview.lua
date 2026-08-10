local var_0_0 = class("ChapterResidentActContentView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterToggle_ = arg_1_2
	arg_1_0.actItemList = {}
	arg_1_0.viewList = {}

	arg_1_0:InitUI()

	arg_1_0.changeSelectHandler_ = handler(arg_1_0, arg_1_0.ScrollAndClickItemByActivityID)
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.params_ = arg_2_1

	arg_2_0:RefreshUI()
	manager.notify:RegistListener(CHAPTER_RESIDENT_ACT_SWITCH_VIEW, arg_2_0.changeSelectHandler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(CHAPTER_RESIDENT_ACT_SWITCH_VIEW, arg_3_0.changeSelectHandler_)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.actItemList or {}) do
		if iter_3_1 then
			iter_3_1:OnExit()

			iter_3_1 = nil
		end
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0.viewList or {}) do
		if iter_3_3 then
			iter_3_3:OnExit()

			iter_3_3 = nil
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.actItemList or {}) do
		if iter_4_1 then
			iter_4_1:Dispose()

			iter_4_1 = nil
		end
	end

	arg_4_0.actItemList = nil

	for iter_4_2, iter_4_3 in pairs(arg_4_0.viewList or {}) do
		if iter_4_3 then
			iter_4_3:Dispose()

			iter_4_3 = nil
		end
	end

	arg_4_0.viewList = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.OnClickSelect(arg_7_0, arg_7_1)
	local var_7_0 = -1

	if arg_7_0.selectActItem and arg_7_0.selectActItem:GetChapterID() == arg_7_1:GetChapterID() then
		return false
	end

	if arg_7_0.selectActItem then
		arg_7_0.selectActItem:UpdateSelectState(false)

		local var_7_1 = arg_7_0.selectActItem:GetChapterID()

		if arg_7_0.viewList[var_7_1] then
			arg_7_0.viewList[var_7_1]:RefreshUI()
			arg_7_0.viewList[var_7_1]:SetActive(false)
		end
	end

	arg_7_0.selectActItem = arg_7_1

	arg_7_0.selectActItem:UpdateSelectState(true)

	local var_7_2 = arg_7_0.selectActItem:GetChapterID()

	if not arg_7_0.viewList[var_7_2] then
		arg_7_0.viewList[var_7_2] = ChapterResidentTools.GetResidentActViewClass(arg_7_0.selectActItem:GetActID()).New(var_7_2, arg_7_0.contentNode_)
	end

	arg_7_0.viewList[var_7_2]:RefreshUI()
	arg_7_0.viewList[var_7_2]:SetActive(true)
	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.RESIDENT_ACT, var_7_2)
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshUIActItemList()
	arg_8_0:DefaultSelectIndex()
end

function var_0_0.GetCacheActivityID(arg_9_0)
	local var_9_0 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.RESIDENT_ACT)

	if var_9_0 then
		return ChapterClientCfg[var_9_0].activity_id
	end
end

function var_0_0.DefaultSelectIndex(arg_10_0)
	local var_10_0 = arg_10_0.params_ and arg_10_0.params_.activityID or arg_10_0:GetCacheActivityID()

	if var_10_0 then
		if (arg_10_0.selectActItem and arg_10_0.selectActItem:GetActID() or nil) == var_10_0 then
			local var_10_1 = arg_10_0.selectActItem:GetChapterID()

			if arg_10_0.viewList[var_10_1] then
				arg_10_0.viewList[var_10_1]:RefreshUI()
				arg_10_0:ScrollToIndex(var_10_0)

				return
			end
		end

		for iter_10_0, iter_10_1 in pairs(arg_10_0.actItemList) do
			if iter_10_1:GetActID() == var_10_0 then
				arg_10_0:OnClickSelect(iter_10_1)

				return
			end
		end
	end

	if not arg_10_0.selectActItem then
		local var_10_2 = arg_10_0.actItemList[1]

		arg_10_0:OnClickSelect(var_10_2)
	else
		local var_10_3 = arg_10_0.selectActItem:GetChapterID()

		if arg_10_0.viewList[var_10_3] then
			arg_10_0.viewList[var_10_3]:RefreshUI()
		end
	end
end

function var_0_0.RefreshUIActItemList(arg_11_0)
	arg_11_0.actDataList = ChapterResidentTools.GetResidentChapterOpenList()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.actDataList or {}) do
		if not arg_11_0.actItemList[iter_11_0] then
			arg_11_0.actItemList[iter_11_0] = arg_11_0:CreateActItem()
		end

		arg_11_0.actItemList[iter_11_0]:SetData(iter_11_1)
	end
end

function var_0_0.CreateActItem(arg_12_0)
	local var_12_0 = Object.Instantiate(arg_12_0.actItemGo_, arg_12_0.listContent_)
	local var_12_1 = ChapterResidentActItem.New(var_12_0)

	SetActive(var_12_0, true)
	var_12_1:SetClickCallback(handler(arg_12_0, arg_12_0.OnClickSelect))

	return var_12_1
end

function var_0_0.ScrollToIndex(arg_13_0, arg_13_1)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(arg_13_0.actItemList) do
		if iter_13_1:GetActID() == arg_13_1 then
			var_13_0 = iter_13_0
		end
	end

	local var_13_1 = (var_13_0 - 1) * 132

	arg_13_0.scrollView_.content.anchoredPosition = Vector2.New(0, var_13_1)
end

function var_0_0.ScrollAndClickItemByActivityID(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.actItemList) do
		if iter_14_1:GetActID() == arg_14_1 then
			arg_14_0:OnClickSelect(iter_14_1)

			break
		end
	end

	arg_14_0:ScrollToIndex(arg_14_1)
end

return var_0_0
