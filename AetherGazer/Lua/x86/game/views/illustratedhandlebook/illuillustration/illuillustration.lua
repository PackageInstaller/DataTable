local var_0_0 = class("IlluIllustration", ReduxView)
local var_0_1 = {
	BIRTHDAY = 4,
	ACTIVITY_STORY = 3,
	BG_PICTURE = 6,
	LOADING_PICTURE = 5,
	MAIN_STORY = 1,
	HEART = 2
}

var_0_0.ITEM_TYPE = {
	ITEM = 2,
	TITLE = 1
}
var_0_0.Sort_TYPE = {
	NONECHAPTER = 9999999,
	EDITOR_SELECTED = 1
}
var_0_0.headList = {
	10301,
	10302,
	10303,
	10304,
	10305
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluIllustrationUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.loadingSet_ = {}

	for iter_4_0, iter_4_1 in ipairs(CollectPictureCfg.get_id_list_by_type) do
		arg_4_0.loadingSet_[iter_4_0] = {}
	end

	arg_4_0.editorCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "editor")
	arg_4_0.btn1Controller = ControllerUtil.GetController(arg_4_0.btn1trs_, "name")
	arg_4_0.btn2Controller = ControllerUtil.GetController(arg_4_0.btn2trs_, "name")
	arg_4_0.btn3Controller = ControllerUtil.GetController(arg_4_0.btn3trs_, "name")
	arg_4_0.btn4Controller = ControllerUtil.GetController(arg_4_0.btn4trs_, "name")
	arg_4_0.btn5Controller = ControllerUtil.GetController(arg_4_0.btn5trs_, "name")
	arg_4_0.btn6Controller = ControllerUtil.GetController(arg_4_0.btn6trs_, "name")
	arg_4_0.showtitleController_ = arg_4_0.controllerEx_:GetController("showTitle")
	arg_4_0.showSubMenuController_ = arg_4_0.controllerEx_:GetController("showSubMenu")

	local var_4_0 = arg_4_0.contentTf_.rect.height
	local var_4_1 = arg_4_0.gridTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_4_0.loopScrollView_ = LoopScrollView.New(arg_4_0, arg_4_0.scrollRectEx_, arg_4_0.gridTrs_, arg_4_0.contentTf_, var_4_0, var_4_1)
	arg_4_0.titleItemPool_ = {}
	arg_4_0.illuItemPool_ = {}
	arg_4_0.subMenuItemPool_ = {}
	arg_4_0.subMenuList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_1, nil, function()
		arg_5_0:RefreshUI(1)

		arg_5_0.params_.index = 1
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_2, nil, function()
		arg_5_0:RefreshUI(2)

		arg_5_0.params_.index = 2
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_3, nil, function()
		arg_5_0:RefreshUI(3)

		arg_5_0.params_.index = 3
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_4, nil, function()
		arg_5_0:RefreshUI(4)

		arg_5_0.params_.index = 4
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_5, nil, function()
		arg_5_0:RefreshUI(5)

		arg_5_0.params_.index = 5
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_6, nil, function()
		arg_5_0:RefreshUI(6)

		arg_5_0.params_.index = 6
	end)
	arg_5_0:AddBtnListener(arg_5_0.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CONFIRM_RESET"),
			OkCallback = function()
				arg_5_0.loadingSet_[arg_5_0.params_.index] = {}

				arg_5_0:RefreshUI(arg_5_0.params_.index)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.saveBtn_, nil, function()
		IllustratedAction.SaveLoadingSet(arg_5_0.loadingSet_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.editorBtn_, nil, function()
		arg_5_0.isEditor_ = true

		arg_5_0:UpdateBar()

		for iter_15_0, iter_15_1 in ipairs(arg_5_0.loadingSet_) do
			arg_5_0.loadingSet_[iter_15_0] = deepClone(IllustratedData:GetLoadingSetByType(iter_15_0))
		end

		arg_5_0.selectEditorChapter_ = arg_5_0:GetDefaultEditorChapterID()

		if arg_5_0.subMenuGo_.activeInHierarchy == true then
			arg_5_0.selectEditorChapter_ = 0

			arg_5_0.showSubMenuController_:SetSelectedState("false")
			SetActive(arg_5_0.maskBtn_.gameObject, false)
			arg_5_0:UpdateBar()
		end

		arg_5_0:RefreshUI(arg_5_0.params_.index)
	end)
	arg_5_0:AddBtnListener(arg_5_0.subMenuBtn_, nil, function()
		if arg_5_0.subMenuGo_.activeInHierarchy == true then
			arg_5_0.showSubMenuController_:SetSelectedState("false")
			arg_5_0:UpdateBar()
			SetActive(arg_5_0.maskBtn_.gameObject, false)
		else
			arg_5_0.showSubMenuController_:SetSelectedState("true")
			arg_5_0:RefreshSubMenu()
			manager.windowBar:HideBar()
			SetActive(arg_5_0.maskBtn_.gameObject, true)
		end
	end)
	arg_5_0.scrollRectEx_.onValueChanged:AddListener(function(arg_17_0)
		arg_5_0:RefreshOnScroll(arg_17_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		if arg_5_0.subMenuGo_.activeInHierarchy == true then
			arg_5_0.showSubMenuController_:SetSelectedState("false")
			arg_5_0:UpdateBar()
		end

		SetActive(arg_5_0.maskBtn_.gameObject, false)
	end)
end

function var_0_0.GetDefaultEditorChapterID(arg_19_0)
	return arg_19_0.nearestChapter_ and arg_19_0.nearestChapter_.id or 0
end

function var_0_0.UpdateData(arg_20_0, arg_20_1)
	arg_20_0.itemMap_ = {}
	arg_20_0.itemList_ = {}
	arg_20_0.layoutCache_ = nil
	arg_20_0.groupIDMap_ = {}

	for iter_20_0, iter_20_1 in ipairs(CollectPictureCfg.get_id_list_by_type[arg_20_1]) do
		local var_20_0 = CollectPictureCfg[iter_20_1]

		if not arg_20_0.itemMap_[var_20_0.chapter_id] then
			arg_20_0.itemMap_[var_20_0.chapter_id] = {}
		end

		local var_20_1 = IllustratedData:GetIllustrationInfo()[iter_20_1]
		local var_20_2 = var_20_0.group_id

		if (arg_20_1 == 3 and var_20_1 or arg_20_1 ~= 3) and (not arg_20_0.groupIDMap_[var_20_2] or arg_20_0.isEditor_) then
			if var_20_1 and var_20_1.is_receive == 0 or arg_20_0.isEditor_ and arg_20_0:IsSelected(iter_20_1) then
				if not arg_20_0.itemMap_[var_0_0.Sort_TYPE.EDITOR_SELECTED] then
					arg_20_0.itemMap_[var_0_0.Sort_TYPE.EDITOR_SELECTED] = {}
				end

				table.insert(arg_20_0.itemMap_[var_0_0.Sort_TYPE.EDITOR_SELECTED], iter_20_1)
			elseif var_20_0.chapter_id == 0 then
				if not arg_20_0.itemMap_[var_0_0.Sort_TYPE.NONECHAPTER] then
					arg_20_0.itemMap_[var_0_0.Sort_TYPE.NONECHAPTER] = {}
				end

				table.insert(arg_20_0.itemMap_[var_0_0.Sort_TYPE.NONECHAPTER], iter_20_1)
			else
				table.insert(arg_20_0.itemMap_[var_20_0.chapter_id], iter_20_1)
			end

			arg_20_0.groupIDMap_[var_20_2] = true
		end
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0.itemMap_) do
		table.sort(iter_20_3, function(arg_21_0, arg_21_1)
			local var_21_0 = CollectPictureCfg[arg_21_0].group_id
			local var_21_1 = CollectPictureCfg[arg_21_1].group_id
			local var_21_2 = IllustratedData:GetIllustrationInfo()[arg_21_0]
			local var_21_3 = IllustratedData:GetIllustrationInfo()[arg_21_1]

			if var_21_2 and not var_21_3 then
				return true
			end

			if not var_21_2 and var_21_3 then
				return false
			end

			if var_21_2 and var_21_3 then
				if arg_20_0.isEditor_ then
					local var_21_4 = arg_20_0:IsSelected(arg_21_0)

					if var_21_4 ~= arg_20_0:IsSelected(arg_21_1) then
						return var_21_4
					end
				end

				return var_21_0 < var_21_1
			else
				return var_21_0 < var_21_1
			end
		end)
	end

	local var_20_3 = arg_20_0.contentTf_.rect.width
	local var_20_4 = arg_20_0.itemTf_.rect.width
	local var_20_5 = math.floor(var_20_3 / var_20_4)
	local var_20_6 = 0
	local var_20_7 = 0

	for iter_20_4, iter_20_5 in pairs(arg_20_0.itemMap_) do
		if iter_20_4 ~= var_0_0.Sort_TYPE.EDITOR_SELECTED and iter_20_4 ~= var_0_0.Sort_TYPE.NONECHAPTER and #iter_20_5 > 0 then
			table.insert(arg_20_0.itemList_, {
				chapterID = iter_20_4,
				objectType = var_0_0.ITEM_TYPE.TITLE
			})

			var_20_6 = var_20_6 + 1
		end

		local var_20_8 = {}

		for iter_20_6, iter_20_7 in ipairs(iter_20_5) do
			local var_20_9 = math.floor((iter_20_6 - 1) / var_20_5) + 1

			var_20_8[var_20_9] = var_20_8[var_20_9] or {}

			table.insert(var_20_8[var_20_9], iter_20_7)
		end

		for iter_20_8, iter_20_9 in ipairs(var_20_8) do
			table.insert(arg_20_0.itemList_, {
				list = iter_20_9,
				chapterID = iter_20_4,
				objectType = var_0_0.ITEM_TYPE.ITEM
			})
		end

		var_20_7 = var_20_7 + 1
	end

	if var_20_6 > 0 then
		table.sort(arg_20_0.itemList_, function(arg_22_0, arg_22_1)
			if arg_22_0.chapterID ~= arg_22_1.chapterID then
				if arg_22_0.chapterID == 0 then
					return false
				end

				if arg_22_1.chapterID == 0 then
					return true
				end

				return arg_22_0.chapterID < arg_22_1.chapterID
			end

			if arg_22_0.objectType ~= arg_22_1.objectType then
				return arg_22_0.objectType < arg_22_1.objectType
			end

			if arg_22_0.objectType == var_0_0.ITEM_TYPE.ITEM and arg_22_1.objectType == var_0_0.ITEM_TYPE.ITEM then
				return CollectPictureCfg[arg_22_0.list[1]].group_id < CollectPictureCfg[arg_22_1.list[1]].group_id
			end
		end)
	end

	local var_20_10 = {}

	for iter_20_10, iter_20_11 in ipairs(arg_20_0.itemList_) do
		if iter_20_11.chapterID >= 10301 and iter_20_11.chapterID <= 10305 then
			table.insert(var_20_10, iter_20_11)
		end
	end

	table.sort(var_20_10, function(arg_23_0, arg_23_1)
		if arg_23_0.chapterID ~= arg_23_1.chapterID then
			if arg_23_0.chapterID == 0 then
				return false
			end

			if arg_23_1.chapterID == 0 then
				return true
			end

			return arg_23_0.chapterID < arg_23_1.chapterID
		end

		if arg_23_0.objectType ~= arg_23_1.objectType then
			return arg_23_0.objectType < arg_23_1.objectType
		end

		if arg_23_0.objectType == var_0_0.ITEM_TYPE.ITEM and arg_23_1.objectType == var_0_0.ITEM_TYPE.ITEM then
			return CollectPictureCfg[arg_23_0.list[1]].group_id < CollectPictureCfg[arg_23_1.list[1]].group_id
		end
	end)

	for iter_20_12 = 1, #arg_20_0.itemList_ do
		if arg_20_0.itemList_[iter_20_12].chapterID < 10301 or arg_20_0.itemList_[iter_20_12].chapterID > 10305 then
			table.insert(var_20_10, arg_20_0.itemList_[iter_20_12])
		end
	end

	arg_20_0.itemList_ = var_20_10
	arg_20_0.chapterList_ = {}

	for iter_20_13, iter_20_14 in ipairs(arg_20_0.itemList_) do
		if iter_20_14.objectType == var_0_0.ITEM_TYPE.ITEM then
			for iter_20_15, iter_20_16 in ipairs(iter_20_14.list) do
				if IllustratedData:GetIllustrationInfo()[iter_20_16] then
					table.insert(arg_20_0.chapterList_, iter_20_16)
				end
			end
		end
	end

	local var_20_11 = var_20_7 * arg_20_0.illuItemWidget_.transform.rect.height + var_20_6 * arg_20_0.titleItem_.transform.rect.height + arg_20_0.gridTrs_:GetComponent("VerticalLayoutGroup").spacing * (var_20_6 + var_20_7) + 200

	arg_20_0.loopScrollView_:SetContentHeight(var_20_11)
end

function var_0_0.ReceiveIllustrationReward(arg_24_0)
	local var_24_0 = IlluTools.GetIllustrationNotRewardList()

	if #var_24_0 == 0 then
		error("发生错误")
	end

	IllustratedAction.ReceiveIllustrationReward(var_24_0)
end

function var_0_0.RefreshSubMenu(arg_25_0)
	arg_25_0.subMenuList_ = {}

	local var_25_0 = CollectPictureCfg.get_id_list_by_chapter_id

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		if CollectPictureCfg[iter_25_1[1]].type == arg_25_0.params_.index and #arg_25_0.itemMap_[iter_25_0] > 0 then
			table.insert(arg_25_0.subMenuList_, iter_25_0)
		end
	end

	table.sort(arg_25_0.subMenuList_, function(arg_26_0, arg_26_1)
		return arg_26_0 < arg_26_1
	end)

	local var_25_1 = {}

	for iter_25_2 = 1, #var_0_0.headList do
		table.insert(var_25_1, var_0_0.headList[iter_25_2])
	end

	for iter_25_3 = 1, #arg_25_0.subMenuList_ - 5 do
		table.insert(var_25_1, arg_25_0.subMenuList_[iter_25_3])
	end

	arg_25_0.subMenuList_ = var_25_1

	for iter_25_4, iter_25_5 in ipairs(arg_25_0.subMenuList_) do
		if not arg_25_0.subMenuItemPool_[iter_25_4] then
			local var_25_2 = illuillustrationSubMenuItem.New(arg_25_0.subMenuItemGo_, arg_25_0.subMenuContent_)

			arg_25_0.subMenuItemPool_[iter_25_4] = var_25_2
		end

		arg_25_0.subMenuItemPool_[iter_25_4]:SetData(iter_25_5)
		arg_25_0.subMenuItemPool_[iter_25_4]:SetClickFunc(handler(arg_25_0, arg_25_0.SubMenuItemClickFunc))
		arg_25_0.subMenuItemPool_[iter_25_4]:SetSelect(iter_25_5 == arg_25_0.selectSubMenuChapterID_)

		if iter_25_5 == arg_25_0.selectSubMenuChapterID_ then
			FrameTimer.New(function()
				arg_25_0.subMenuContent_.anchoredPosition = Vector2(0, -arg_25_0.subMenuItemPool_[iter_25_4].transform_.anchoredPosition.y - arg_25_0.subMenuItemGo_.transform.rect.height / 2)
			end, 1, 1):Start()
		end

		arg_25_0.subMenuItemPool_[iter_25_4]:Show(true)
	end

	for iter_25_6 = #arg_25_0.subMenuList_ + 1, #arg_25_0.subMenuItemPool_ do
		arg_25_0.subMenuItemPool_[iter_25_6]:Show(false)
	end
end

function var_0_0.SubMenuItemClickFunc(arg_28_0, arg_28_1)
	arg_28_0.selectSubMenuChapterID_ = arg_28_1

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.subMenuItemPool_) do
		iter_28_1:SetSelect(iter_28_1.chapterID_ == arg_28_1)
	end

	if #arg_28_0.subMenuList_ > 0 and arg_28_0.titlePositions_[arg_28_1] then
		arg_28_0.loopScrollView_.rectGrid_.anchoredPosition = Vector2(0, -(arg_28_0.titlePositions_[arg_28_1] - arg_28_0.titleItem_.transform.rect.height / 2) - 20)
	end
end

function var_0_0.OnReceiveIllustrationReward(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = mergeReward(arg_29_1.item_list)

	getReward(var_29_0)
	arg_29_0:RefreshUI(arg_29_0.params_.index)
end

function var_0_0.ItemClickFun(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.isEditor_ then
		local var_30_0 = CollectPictureCfg[arg_30_1].type

		if arg_30_0:IsSelected(arg_30_1) then
			table.remove(arg_30_0.loadingSet_[var_30_0], table.indexof(arg_30_0.loadingSet_[var_30_0], arg_30_1))
			arg_30_0:RefreshEditorText()

			for iter_30_0, iter_30_1 in ipairs(arg_30_0.loopScrollView_.itemList_) do
				if iter_30_1.itemView:GetObjectType() == var_0_0.ITEM_TYPE.ITEM then
					for iter_30_2, iter_30_3 in ipairs(iter_30_1.itemView.illuItemList_) do
						if arg_30_0.isEditor_ then
							iter_30_3:SetSelect(arg_30_0:IsSelected(iter_30_3.id_))
						else
							iter_30_3:SetSelect(false)
						end
					end
				end
			end
		else
			local var_30_1 = 0

			for iter_30_4, iter_30_5 in ipairs(arg_30_0.loadingSet_) do
				var_30_1 = var_30_1 + #arg_30_0.loadingSet_[iter_30_4]
			end

			if var_30_1 >= GameSetting.loading_pic_max.value[1] then
				ShowTips("SET_FAILED")
			else
				table.insert(arg_30_0.loadingSet_[var_30_0], arg_30_1)
				arg_30_0:RefreshEditorText()

				for iter_30_6, iter_30_7 in ipairs(arg_30_0.loopScrollView_.itemList_) do
					if iter_30_7.itemView:GetObjectType() == var_0_0.ITEM_TYPE.ITEM then
						for iter_30_8, iter_30_9 in ipairs(iter_30_7.itemView.illuItemList_) do
							if arg_30_0.isEditor_ then
								iter_30_9:SetSelect(arg_30_0:IsSelected(iter_30_9.id_))
							else
								iter_30_9:SetSelect(false)
							end
						end
					end
				end
			end
		end
	else
		local var_30_2 = CollectPictureCfg[arg_30_1].wedding_role_id

		arg_30_0:Go("/illuIllustrationDetail", {
			ID = arg_30_1,
			chapterList = arg_30_0.chapterList_,
			index = table.indexof(arg_30_0.chapterList_, arg_30_1),
			heroID = var_30_2
		})
	end
end

function var_0_0.RefreshUI(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.editorCon_:SetSelectedState(arg_31_0.isEditor_ and "true" or "false")
	arg_31_0.showtitleController_:SetSelectedState("false")
	SetActive(arg_31_0.btn3trs_.gameObject, arg_31_0:IsShowToggleByType(var_0_1.ACTIVITY_STORY))
	SetActive(arg_31_0.btn4trs_.gameObject, arg_31_0:IsShowToggleByType(var_0_1.BIRTHDAY))
	arg_31_0:UpdateData(arg_31_1)

	if arg_31_2 then
		if arg_31_0.params_.scrollPos_ then
			arg_31_0.loopScrollView_:NavigateIndex(1, arg_31_0.params_.scrollPos_, true)
		else
			arg_31_0.loopScrollView_:NavigateIndex(1)
		end
	else
		arg_31_0.loopScrollView_:NavigateIndex(1)
	end

	if arg_31_0.timer_ then
		arg_31_0.timer_:Stop()
	end

	arg_31_0.timer_ = FrameTimer.New(function()
		arg_31_0:UpdateTitileData()
		arg_31_0:RefreshOnScroll(arg_31_0.scrollRectEx_.normalizedPosition)
	end, 1, 1):Start()

	if arg_31_0.isEditor_ then
		arg_31_0:RefreshEditorText()
	else
		arg_31_0:RefreshText(arg_31_1)
	end

	arg_31_0.btn1Controller:SetSelectedIndex(arg_31_1 == 1 and 0 or 1)
	arg_31_0.btn2Controller:SetSelectedIndex(arg_31_1 == 2 and 0 or 1)
	arg_31_0.btn3Controller:SetSelectedIndex(arg_31_1 == 3 and 0 or 1)
	arg_31_0.btn4Controller:SetSelectedIndex(arg_31_1 == 4 and 0 or 1)
	arg_31_0.btn5Controller:SetSelectedIndex(arg_31_1 == 5 and 0 or 1)
	arg_31_0.btn6Controller:SetSelectedIndex(arg_31_1 == 6 and 0 or 1)
end

function var_0_0.UpdateTitileData(arg_33_0)
	local var_33_0 = false

	arg_33_0.titleIndex_ = {}
	arg_33_0.titlePositions_ = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.loopScrollView_.itemList_) do
		if iter_33_1.itemView.objectType_ == var_0_0.ITEM_TYPE.TITLE then
			arg_33_0.titleIndex_[iter_33_1.itemView.chapterID_] = iter_33_1.itemView.index_
			arg_33_0.titlePositions_[iter_33_1.itemView.chapterID_] = iter_33_1.itemView.transform_.localPosition.y
			var_33_0 = true
		end
	end

	arg_33_0.layoutCache_ = nil

	SetActive(arg_33_0.subMenuBtn_, var_33_0)
end

function var_0_0.RefreshEditorText(arg_34_0)
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.loadingSet_) do
		var_34_0 = var_34_0 + #arg_34_0.loadingSet_[iter_34_0]
	end

	arg_34_0.limitText_.text = var_34_0 .. "/" .. GameSetting.loading_pic_max.value[1]
end

function var_0_0.RefreshText(arg_35_0, arg_35_1)
	local var_35_0 = 0

	for iter_35_0, iter_35_1 in ipairs(CollectPictureCfg.get_id_list_by_type[arg_35_1]) do
		if IllustratedData:GetIllustrationInfo()[iter_35_1] then
			var_35_0 = var_35_0 + 1
		end
	end

	if arg_35_1 == 3 then
		arg_35_0.numText_.text = var_35_0 .. "/" .. var_35_0
	else
		local var_35_1 = #CollectPictureCfg.get_id_list_by_type[arg_35_1]

		arg_35_0.numText_.text = var_35_0 .. "/" .. var_35_1
	end
end

function var_0_0.IsShowToggleByType(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(CollectPictureCfg.get_id_list_by_type[arg_36_1] or {}) do
		if IllustratedData:GetIllustrationInfo()[iter_36_1] then
			return true
		end
	end

	return false
end

function var_0_0.OnEnter(arg_37_0)
	arg_37_0.isEditor_ = false

	arg_37_0:UpdateBar()

	arg_37_0.params_.index = arg_37_0.params_.index or 1

	arg_37_0:RefreshUI(arg_37_0.params_.index, true)

	arg_37_0.selectSubMenuChapterID_ = arg_37_0.params_.selectSubMenuChapterID

	if arg_37_0.selectSubMenuChapterID_ then
		if arg_37_0.subMenuSelectTimer_ then
			arg_37_0.subMenuSelectTimer_:Stop()
		end

		arg_37_0.subMenuSelectTimer_ = FrameTimer.New(function()
			arg_37_0:RefreshSubMenu()

			if arg_37_0.params_.index == 1 or arg_37_0.params_.index == 3 then
				arg_37_0:SubMenuItemClickFunc(arg_37_0.params_.selectSubMenuChapterID)
			end
		end, 1.3, 1):Start()
	end

	manager.redPoint:bindUIandKey(arg_37_0.btn1trs_, RedPointConst.ILLU_ILLUSTRATION1)
	manager.redPoint:bindUIandKey(arg_37_0.btn2trs_, RedPointConst.ILLU_ILLUSTRATION2)
	manager.redPoint:bindUIandKey(arg_37_0.btn3trs_, RedPointConst.ILLU_ILLUSTRATION3)
	manager.redPoint:bindUIandKey(arg_37_0.btn4trs_, RedPointConst.ILLU_ILLUSTRATION4)
	manager.redPoint:bindUIandKey(arg_37_0.btn5trs_, RedPointConst.ILLU_ILLUSTRATION5)
	manager.redPoint:bindUIandKey(arg_37_0.btn6trs_, RedPointConst.ILLU_ILLUSTRATION6)
end

function var_0_0.UpdateBar(arg_39_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_39_0.isEditor_ and arg_39_0:IsChanged() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_SETTING_CHANGE"),
				OkCallback = function()
					IllustratedAction.SaveLoadingSet(arg_39_0.loadingSet_)
				end,
				CancelCallback = function()
					arg_39_0.isEditor_ = false

					arg_39_0:RefreshUI(arg_39_0.params_.index)
				end
			})
		else
			arg_39_0:Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if arg_39_0.isEditor_ and arg_39_0:IsChanged() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_SETTING_CHANGE"),
				OkCallback = function()
					IllustratedAction.SaveLoadingSet(arg_39_0.loadingSet_)
					arg_39_0:Go("/home")
				end,
				CancelCallback = function()
					arg_39_0:Go("/home")
				end
			})
		else
			arg_39_0:Go("/home")
		end
	end)
end

function var_0_0.IsSelected(arg_46_0, arg_46_1)
	if not arg_46_1 then
		return false
	end

	local var_46_0 = CollectPictureCfg[arg_46_1].type

	return table.indexof(arg_46_0.loadingSet_[var_46_0], arg_46_1) ~= false
end

function var_0_0.IsChanged(arg_47_0)
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.loadingSet_) do
		table.insertto(var_47_0, arg_47_0.loadingSet_[iter_47_0])
	end

	local var_47_1 = IllustratedData:GetAllLoadingSet()

	if #var_47_0 ~= #var_47_1 then
		return true
	end

	for iter_47_2, iter_47_3 in ipairs(var_47_0) do
		if not table.indexof(var_47_1, iter_47_3) then
			return true
		end
	end

	return false
end

function var_0_0.OnSaveLoadingSet(arg_48_0)
	arg_48_0.isEditor_ = false

	arg_48_0:RefreshUI(arg_48_0.params_.index)
	ShowTips("SET_CONFIRMED")
end

function var_0_0.LsAddItem(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_1.objectType
	local var_49_1

	if var_49_0 == var_0_0.ITEM_TYPE.TITLE then
		var_49_1 = arg_49_0:GetFreeTitleItem(arg_49_0.titleItemPool_, function()
			return IlluIllustrationTitleItem.New(arg_49_0.titleItem_, arg_49_0.gridTrs_)
		end)
		var_49_1.itemView.gameObject_.name = arg_49_2 .. "title"
	else
		var_49_1 = arg_49_0:GetFreeTitleItem(arg_49_0.illuItemPool_, function()
			return IlluIllustrationWidget.New(arg_49_0.illuItemWidget_, arg_49_0.gridTrs_)
		end)
		var_49_1.itemView.gameObject_.name = arg_49_2 .. "Widget"
	end

	var_49_1.itemView:SetData(arg_49_1, arg_49_2, arg_49_0.isEditor_)

	if var_49_1.itemView:GetObjectType() == var_0_0.ITEM_TYPE.ITEM then
		for iter_49_0, iter_49_1 in ipairs(var_49_1.itemView.illuItemList_) do
			iter_49_1:RegisterGiftFunc(handler(arg_49_0, arg_49_0.ReceiveIllustrationReward))
			iter_49_1:RegisterItemFunc(handler(arg_49_0, arg_49_0.ItemClickFun))

			if arg_49_0.isEditor_ then
				iter_49_1:SetSelect(arg_49_0:IsSelected(iter_49_1.id_))
			else
				iter_49_1:SetSelect(false)
			end
		end
	end

	return var_49_1
end

function var_0_0.LsRemoveItem(arg_52_0, arg_52_1, arg_52_2)
	arg_52_1.itemView:Show(false)

	arg_52_1.isFree = true
end

function var_0_0.LsGetItemData(arg_53_0)
	return arg_53_0.itemList_
end

function var_0_0.LsUpdateItem(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	arg_54_1.itemView:SetData(arg_54_2, arg_54_3, arg_54_4)
end

function var_0_0.GetFreeTitleItem(arg_55_0, arg_55_1, arg_55_2)
	for iter_55_0, iter_55_1 in pairs(arg_55_1) do
		if iter_55_1.isFree == true then
			iter_55_1.isFree = false

			return iter_55_1
		end
	end

	local var_55_0 = {
		isFree = false,
		itemView = arg_55_2()
	}

	table.insert(arg_55_1, var_55_0)

	return var_55_0
end

function var_0_0.OnExit(arg_56_0)
	manager.windowBar:HideBar()
	arg_56_0.showSubMenuController_:SetSelectedState("false")
	SetActive(arg_56_0.maskBtn_.gameObject, false)
	manager.redPoint:unbindUIandKey(arg_56_0.btn1trs_, RedPointConst.ILLU_ILLUSTRATION1)
	manager.redPoint:unbindUIandKey(arg_56_0.btn2trs_, RedPointConst.ILLU_ILLUSTRATION2)
	manager.redPoint:unbindUIandKey(arg_56_0.btn3trs_, RedPointConst.ILLU_ILLUSTRATION3)
	manager.redPoint:unbindUIandKey(arg_56_0.btn4trs_, RedPointConst.ILLU_ILLUSTRATION4)
	manager.redPoint:unbindUIandKey(arg_56_0.btn5trs_, RedPointConst.ILLU_ILLUSTRATION5)
	manager.redPoint:unbindUIandKey(arg_56_0.btn6trs_, RedPointConst.ILLU_ILLUSTRATION6)

	arg_56_0.params_.scrollPos_ = arg_56_0.gridTrs_.localPosition.y
	arg_56_0.params_.selectSubMenuChapterID = nil
end

function var_0_0.Dispose(arg_57_0)
	for iter_57_0, iter_57_1 in ipairs(arg_57_0.titleItemPool_) do
		iter_57_1.itemView:Dispose()
	end

	arg_57_0.titleItemPool_ = nil

	for iter_57_2, iter_57_3 in ipairs(arg_57_0.illuItemPool_) do
		iter_57_3.itemView:Dispose()
	end

	arg_57_0.illuItemPool_ = nil

	for iter_57_4, iter_57_5 in ipairs(arg_57_0.subMenuItemPool_) do
		iter_57_5:Dispose()
	end

	arg_57_0.subMenuItemPool_ = nil

	if arg_57_0.timer_ then
		arg_57_0.timer_:Stop()
	end

	if arg_57_0.subMenuSelectTimer_ then
		arg_57_0.subMenuSelectTimer_:Stop()
	end

	var_0_0.super.Dispose(arg_57_0)
	arg_57_0.loopScrollView_:Dispose()

	arg_57_0.loopScrollView_ = nil
end

function var_0_0.RefreshOnScroll(arg_58_0, arg_58_1)
	if not arg_58_0.titlePositions_ or table.isEmpty(arg_58_0.titlePositions_) then
		arg_58_0.layoutCache_ = {}

		arg_58_0.showtitleController_:SetSelectedState("false")

		return
	end

	if not arg_58_0.layoutCache_ then
		local var_58_0 = arg_58_0.scrollRectEx_.content.rect.height
		local var_58_1 = arg_58_0.scrollRectEx_.viewport.rect.height

		arg_58_0.layoutCache_ = {
			contentHeight = var_58_0,
			viewportHeight = var_58_1,
			normalizedPositions = {}
		}

		local var_58_2 = {}

		for iter_58_0, iter_58_1 in pairs(arg_58_0.titlePositions_) do
			table.insert(var_58_2, {
				id = iter_58_0,
				pos = -iter_58_1
			})
		end

		table.sort(var_58_2, function(arg_59_0, arg_59_1)
			return arg_59_0.pos < arg_59_1.pos
		end)

		arg_58_0.layoutCache_.sortedChapters = var_58_2
	end

	if not arg_58_0.layoutCache_ or not arg_58_0.layoutCache_.sortedChapters[1] then
		return
	end

	local var_58_3 = arg_58_0.scrollRectEx_.content.anchoredPosition.y
	local var_58_4 = 1
	local var_58_5 = #arg_58_0.layoutCache_.sortedChapters

	while var_58_4 <= var_58_5 do
		local var_58_6 = math.floor((var_58_4 + var_58_5) / 2)

		if var_58_3 > arg_58_0.layoutCache_.sortedChapters[var_58_6].pos then
			var_58_4 = var_58_6 + 1
		else
			var_58_5 = var_58_6 - 1
		end
	end

	arg_58_0.nearestIndex_ = math.max(1, math.min(var_58_4 - 1, #arg_58_0.layoutCache_.sortedChapters))
	arg_58_0.nearestChapter_ = arg_58_0.layoutCache_.sortedChapters[arg_58_0.nearestIndex_]

	if arg_58_0.nearestChapter_ and arg_58_0.selectSubMenuChapterID_ ~= arg_58_0.nearestChapter_.id then
		arg_58_0.selectSubMenuChapterID_ = arg_58_0.nearestChapter_.id

		for iter_58_2, iter_58_3 in ipairs(arg_58_0.subMenuItemPool_) do
			iter_58_3:SetSelect(iter_58_3.chapterID_ == arg_58_0.nearestChapter_.id)
		end
	end

	if var_58_3 > arg_58_0.layoutCache_.sortedChapters[arg_58_0.nearestIndex_].pos then
		arg_58_0.showtitleController_:SetSelectedState("true")

		arg_58_0.topTitleText_.text = ChapterClientCfg[arg_58_0.nearestChapter_.id].name
	else
		arg_58_0.showtitleController_:SetSelectedState("false")
	end
end

return var_0_0
