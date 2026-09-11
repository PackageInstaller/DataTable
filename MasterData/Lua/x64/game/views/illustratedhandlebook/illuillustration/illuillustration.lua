local IlluIllustration = class("IlluIllustration", ReduxView)
local var_0_1 = {
	BIRTHDAY = 4,
	ACTIVITY_STORY = 3,
	BG_PICTURE = 6,
	LOADING_PICTURE = 5,
	MAIN_STORY = 1,
	HEART = 2
}

IlluIllustration.ITEM_TYPE = {
	ITEM = 2,
	TITLE = 1
}
IlluIllustration.Sort_TYPE = {
	NONECHAPTER = 9999999,
	EDITOR_SELECTED = 1
}
IlluIllustration.headList = {
	10301,
	10302,
	10303,
	10304,
	10305
}

function IlluIllustration:UIName()
	return "Widget/System/IllustratedHandbook/IlluIllustrationUI"
end

function IlluIllustration:UIParent()
	return manager.ui.uiMain.transform
end

function IlluIllustration:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluIllustration:InitUI()
	self:BindCfgUI()

	self.loadingSet_ = {}

	for iter_4_0, iter_4_1 in ipairs(CollectPictureCfg.get_id_list_by_type) do
		self.loadingSet_[iter_4_0] = {}
	end

	self.editorCon_ = ControllerUtil.GetController(self.gameObject_.transform, "editor")
	self.btn1Controller = ControllerUtil.GetController(self.btn1trs_, "name")
	self.btn2Controller = ControllerUtil.GetController(self.btn2trs_, "name")
	self.btn3Controller = ControllerUtil.GetController(self.btn3trs_, "name")
	self.btn4Controller = ControllerUtil.GetController(self.btn4trs_, "name")
	self.btn5Controller = ControllerUtil.GetController(self.btn5trs_, "name")
	self.btn6Controller = ControllerUtil.GetController(self.btn6trs_, "name")
	self.showtitleController_ = self.controllerEx_:GetController("showTitle")
	self.showSubMenuController_ = self.controllerEx_:GetController("showSubMenu")
	self.loopScrollView_ = LoopScrollView.New(self, self.scrollRectEx_, self.gridTrs_, self.contentTf_, self.contentTf_.rect.height, self.gridTrs_:GetComponent("VerticalLayoutGroup").spacing)
	self.titleItemPool_ = {}
	self.illuItemPool_ = {}
	self.subMenuItemPool_ = {}
	self.subMenuList_ = {}
end

function IlluIllustration:AddUIListener()
	self:AddBtnListener(self.btn_1, nil, function()
		self:RefreshUI(1)

		self.params_.index = 1
	end)
	self:AddBtnListener(self.btn_2, nil, function()
		self:RefreshUI(2)

		self.params_.index = 2
	end)
	self:AddBtnListener(self.btn_3, nil, function()
		self:RefreshUI(3)

		self.params_.index = 3
	end)
	self:AddBtnListener(self.btn_4, nil, function()
		self:RefreshUI(4)

		self.params_.index = 4
	end)
	self:AddBtnListener(self.btn_5, nil, function()
		self:RefreshUI(5)

		self.params_.index = 5
	end)
	self:AddBtnListener(self.btn_6, nil, function()
		self:RefreshUI(6)

		self.params_.index = 6
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CONFIRM_RESET"),
			OkCallback = function()
				self.loadingSet_[self.params_.index] = {}

				self:RefreshUI(self.params_.index)
			end
		})
	end)
	self:AddBtnListener(self.saveBtn_, nil, function()
		IllustratedAction.SaveLoadingSet(self.loadingSet_)
	end)
	self:AddBtnListener(self.editorBtn_, nil, function()
		self.isEditor_ = true

		self:UpdateBar()

		for iter_15_0, iter_15_1 in ipairs(self.loadingSet_) do
			self.loadingSet_[iter_15_0] = deepClone(IllustratedData:GetLoadingSetByType(iter_15_0))
		end

		self.selectEditorChapter_ = self:GetDefaultEditorChapterID()

		if self.subMenuGo_.activeInHierarchy == true then
			self.selectEditorChapter_ = 0

			self.showSubMenuController_:SetSelectedState("false")
			SetActive(self.maskBtn_.gameObject, false)
			self:UpdateBar()
		end

		self:RefreshUI(self.params_.index)
	end)
	self:AddBtnListener(self.subMenuBtn_, nil, function()
		if self.subMenuGo_.activeInHierarchy == true then
			self.showSubMenuController_:SetSelectedState("false")
			self:UpdateBar()
			SetActive(self.maskBtn_.gameObject, false)
		else
			self.showSubMenuController_:SetSelectedState("true")
			self:RefreshSubMenu()
			manager.windowBar:HideBar()
			SetActive(self.maskBtn_.gameObject, true)
		end
	end)
	self.scrollRectEx_.onValueChanged:AddListener(function(arg_17_0)
		self:RefreshOnScroll(arg_17_0)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.subMenuGo_.activeInHierarchy == true then
			self.showSubMenuController_:SetSelectedState("false")
			self:UpdateBar()
		end

		SetActive(self.maskBtn_.gameObject, false)
	end)
end

function IlluIllustration:GetDefaultEditorChapterID()
	return (self.nearestChapter_ or nil) and (self.nearestChapter_.id or 0)
end

function IlluIllustration:UpdateData(arg_20_1)
	self.itemMap_ = {}
	self.itemList_ = {}
	self.layoutCache_ = nil
	self.groupIDMap_ = {}

	for iter_20_0, iter_20_1 in ipairs(CollectPictureCfg.get_id_list_by_type[arg_20_1]) do
		local var_20_0 = CollectPictureCfg[iter_20_1]

		if not self.itemMap_[CollectPictureCfg[iter_20_1].chapter_id] then
			self.itemMap_[var_20_0.chapter_id] = {}
		end

		local var_20_1 = IllustratedData:GetIllustrationInfo()[iter_20_1]
		local var_20_2 = var_20_0.group_id

		if (arg_20_1 == 3 and var_20_1 or arg_20_1 ~= 3) and (not self.groupIDMap_[var_20_2] or self.isEditor_) then
			if var_20_1 and var_20_1.is_receive == 0 or self.isEditor_ and self:IsSelected(iter_20_1) then
				self.itemMap_[IlluIllustration.Sort_TYPE.EDITOR_SELECTED] = self.itemMap_[IlluIllustration.Sort_TYPE.EDITOR_SELECTED] or {}

				table.insert(self.itemMap_[IlluIllustration.Sort_TYPE.EDITOR_SELECTED], iter_20_1)
			elseif var_20_0.chapter_id == 0 then
				self.itemMap_[IlluIllustration.Sort_TYPE.NONECHAPTER] = self.itemMap_[IlluIllustration.Sort_TYPE.NONECHAPTER] or {}

				table.insert(self.itemMap_[IlluIllustration.Sort_TYPE.NONECHAPTER], iter_20_1)
			else
				table.insert(self.itemMap_[var_20_0.chapter_id], iter_20_1)
			end

			self.groupIDMap_[var_20_2] = true
		end
	end

	for iter_20_2, iter_20_3 in pairs(self.itemMap_) do
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
				if self.isEditor_ then
					local var_21_4 = self:IsSelected(arg_21_0)

					if var_21_4 ~= self:IsSelected(arg_21_1) then
						return var_21_4
					end
				end

				return var_21_0 < var_21_1
			else
				return var_21_0 < var_21_1
			end
		end)
	end

	local var_20_3 = math.floor(self.contentTf_.rect.width / self.itemTf_.rect.width)
	local var_20_4 = 0
	local var_20_5 = 0

	for iter_20_4, iter_20_5 in pairs(self.itemMap_) do
		if iter_20_4 ~= IlluIllustration.Sort_TYPE.EDITOR_SELECTED and iter_20_4 ~= IlluIllustration.Sort_TYPE.NONECHAPTER and #iter_20_5 > 0 then
			table.insert(self.itemList_, {
				chapterID = iter_20_4,
				objectType = IlluIllustration.ITEM_TYPE.TITLE
			})

			var_20_4 = var_20_4 + 1
		end

		local var_20_6 = {}

		for iter_20_6, iter_20_7 in ipairs(iter_20_5) do
			local var_20_7 = math.floor((iter_20_6 - 1) / var_20_3) + 1

			var_20_6[var_20_7] = var_20_6[var_20_7] or {}

			table.insert(var_20_6[var_20_7], iter_20_7)
		end

		for iter_20_8, iter_20_9 in ipairs(var_20_6) do
			table.insert(self.itemList_, {
				list = iter_20_9,
				chapterID = iter_20_4,
				objectType = IlluIllustration.ITEM_TYPE.ITEM
			})
		end

		var_20_5 = var_20_5 + 1
	end

	if var_20_4 > 0 then
		table.sort(self.itemList_, function(arg_22_0, arg_22_1)
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

			if arg_22_0.objectType == IlluIllustration.ITEM_TYPE.ITEM and arg_22_1.objectType == IlluIllustration.ITEM_TYPE.ITEM then
				return CollectPictureCfg[arg_22_0.list[1]].group_id < CollectPictureCfg[arg_22_1.list[1]].group_id
			end
		end)
	end

	local var_20_8 = {}

	for iter_20_10, iter_20_11 in ipairs(self.itemList_) do
		if iter_20_11.chapterID >= 10301 and iter_20_11.chapterID <= 10305 then
			table.insert(var_20_8, iter_20_11)
		end
	end

	table.sort(var_20_8, function(arg_23_0, arg_23_1)
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

		if arg_23_0.objectType == IlluIllustration.ITEM_TYPE.ITEM and arg_23_1.objectType == IlluIllustration.ITEM_TYPE.ITEM then
			return CollectPictureCfg[arg_23_0.list[1]].group_id < CollectPictureCfg[arg_23_1.list[1]].group_id
		end
	end)

	for iter_20_12 = 1, #self.itemList_ do
		if self.itemList_[iter_20_12].chapterID < 10301 or self.itemList_[iter_20_12].chapterID > 10305 then
			table.insert(var_20_8, self.itemList_[iter_20_12])
		end
	end

	self.itemList_ = var_20_8
	self.chapterList_ = {}

	for iter_20_13, iter_20_14 in ipairs(self.itemList_) do
		if iter_20_14.objectType == IlluIllustration.ITEM_TYPE.ITEM then
			for iter_20_15, iter_20_16 in ipairs(iter_20_14.list) do
				if IllustratedData:GetIllustrationInfo()[iter_20_16] then
					table.insert(self.chapterList_, iter_20_16)
				end
			end
		end
	end

	self.loopScrollView_:SetContentHeight(var_20_5 * self.illuItemWidget_.transform.rect.height + var_20_4 * self.titleItem_.transform.rect.height + self.gridTrs_:GetComponent("VerticalLayoutGroup").spacing * (var_20_4 + var_20_5) + 200)
end

function IlluIllustration:ReceiveIllustrationReward()
	local var_24_0 = IlluTools.GetIllustrationNotRewardList()

	if #var_24_0 == 0 then
		error("发生错误")
	end

	IllustratedAction.ReceiveIllustrationReward(var_24_0)
end

function IlluIllustration:RefreshSubMenu()
	self.subMenuList_ = {}

	for iter_25_0, iter_25_1 in pairs(CollectPictureCfg.get_id_list_by_chapter_id) do
		if CollectPictureCfg[iter_25_1[1]].type == self.params_.index and #self.itemMap_[iter_25_0] > 0 then
			table.insert(self.subMenuList_, iter_25_0)
		end
	end

	table.sort(self.subMenuList_, function(arg_26_0, arg_26_1)
		return arg_26_0 < arg_26_1
	end)

	local var_25_0 = {}

	for iter_25_2 = 1, #IlluIllustration.headList do
		table.insert(var_25_0, IlluIllustration.headList[iter_25_2])
	end

	for iter_25_3 = 1, #self.subMenuList_ - 5 do
		table.insert(var_25_0, self.subMenuList_[iter_25_3])
	end

	self.subMenuList_ = var_25_0

	for iter_25_4, iter_25_5 in ipairs(self.subMenuList_) do
		self.subMenuItemPool_[iter_25_4] = self.subMenuItemPool_[iter_25_4] or illuillustrationSubMenuItem.New(self.subMenuItemGo_, self.subMenuContent_)

		self.subMenuItemPool_[iter_25_4]:SetData(iter_25_5)
		self.subMenuItemPool_[iter_25_4]:SetClickFunc(handler(self, self.SubMenuItemClickFunc))
		self.subMenuItemPool_[iter_25_4]:SetSelect(iter_25_5 == self.selectSubMenuChapterID_)

		if iter_25_5 == self.selectSubMenuChapterID_ then
			FrameTimer.New(function()
				self.subMenuContent_.anchoredPosition = Vector2(0, -self.subMenuItemPool_[iter_25_4].transform_.anchoredPosition.y - self.subMenuItemGo_.transform.rect.height / 2)
			end, 1, 1):Start()
		end

		self.subMenuItemPool_[iter_25_4]:Show(true)
	end

	for iter_25_6 = #self.subMenuList_ + 1, #self.subMenuItemPool_ do
		self.subMenuItemPool_[iter_25_6]:Show(false)
	end
end

function IlluIllustration:SubMenuItemClickFunc(arg_28_1)
	self.selectSubMenuChapterID_ = arg_28_1

	for iter_28_0, iter_28_1 in ipairs(self.subMenuItemPool_) do
		iter_28_1:SetSelect(iter_28_1.chapterID_ == arg_28_1)
	end

	if #self.subMenuList_ > 0 and self.titlePositions_[arg_28_1] then
		self.loopScrollView_.rectGrid_.anchoredPosition = Vector2(0, -(self.titlePositions_[arg_28_1] - self.titleItem_.transform.rect.height / 2) - 20)
	end
end

function IlluIllustration:OnReceiveIllustrationReward(arg_29_1, arg_29_2)
	getReward((mergeReward(arg_29_1.item_list)))
	self:RefreshUI(self.params_.index)
end

function IlluIllustration:ItemClickFun(arg_30_1, arg_30_2)
	if self.isEditor_ then
		if self:IsSelected(arg_30_1) then
			table.remove(self.loadingSet_[CollectPictureCfg[arg_30_1].type], table.indexof(self.loadingSet_[CollectPictureCfg[arg_30_1].type], arg_30_1))
			self:RefreshEditorText()

			for iter_30_0, iter_30_1 in ipairs(self.loopScrollView_.itemList_) do
				if iter_30_1.itemView:GetObjectType() == IlluIllustration.ITEM_TYPE.ITEM then
					for iter_30_2, iter_30_3 in ipairs(iter_30_1.itemView.illuItemList_) do
						if self.isEditor_ then
							iter_30_3:SetSelect(self:IsSelected(iter_30_3.id_))
						else
							iter_30_3:SetSelect(false)
						end
					end
				end
			end
		else
			local var_30_0 = 0

			for iter_30_4, iter_30_5 in ipairs(self.loadingSet_) do
				var_30_0 = var_30_0 + #self.loadingSet_[iter_30_4]
			end

			if var_30_0 >= GameSetting.loading_pic_max.value[1] then
				ShowTips("SET_FAILED")
			else
				table.insert(self.loadingSet_[CollectPictureCfg[arg_30_1].type], arg_30_1)
				self:RefreshEditorText()

				for iter_30_6, iter_30_7 in ipairs(self.loopScrollView_.itemList_) do
					if iter_30_7.itemView:GetObjectType() == IlluIllustration.ITEM_TYPE.ITEM then
						for iter_30_8, iter_30_9 in ipairs(iter_30_7.itemView.illuItemList_) do
							if self.isEditor_ then
								iter_30_9:SetSelect(self:IsSelected(iter_30_9.id_))
							else
								iter_30_9:SetSelect(false)
							end
						end
					end
				end
			end
		end
	else
		local var_30_1 = {
			ID = arg_30_1,
			chapterList = self.chapterList_,
			index = table.indexof(self.chapterList_, arg_30_1)
		}

		var_30_1.heroID = CollectPictureCfg[arg_30_1].wedding_role_id

		self:Go("/illuIllustrationDetail", var_30_1)
	end
end

function IlluIllustration:RefreshUI(arg_31_1, arg_31_2)
	self.editorCon_:SetSelectedState(self.isEditor_ and "true" or "false")
	self.showtitleController_:SetSelectedState("false")
	SetActive(self.btn3trs_.gameObject, self:IsShowToggleByType(var_0_1.ACTIVITY_STORY))
	SetActive(self.btn4trs_.gameObject, self:IsShowToggleByType(var_0_1.BIRTHDAY))
	self:UpdateData(arg_31_1)

	if arg_31_2 then
		if self.params_.scrollPos_ then
			self.loopScrollView_:NavigateIndex(1, self.params_.scrollPos_, true)
		else
			self.loopScrollView_:NavigateIndex(1)
		end
	else
		self.loopScrollView_:NavigateIndex(1)
	end

	if self.timer_ then
		self.timer_:Stop()
	end

	self.timer_ = FrameTimer.New(function()
		self:UpdateTitileData()
		self:RefreshOnScroll(self.scrollRectEx_.normalizedPosition)
	end, 1, 1):Start()

	if self.isEditor_ then
		self:RefreshEditorText()
	else
		self:RefreshText(arg_31_1)
	end

	self.btn1Controller:SetSelectedIndex(arg_31_1 == 1 and 0 or 1)
	self.btn2Controller:SetSelectedIndex(arg_31_1 == 2 and 0 or 1)
	self.btn3Controller:SetSelectedIndex(arg_31_1 == 3 and 0 or 1)
	self.btn4Controller:SetSelectedIndex(arg_31_1 == 4 and 0 or 1)
	self.btn5Controller:SetSelectedIndex(arg_31_1 == 5 and 0 or 1)
	self.btn6Controller:SetSelectedIndex(arg_31_1 == 6 and 0 or 1)
end

function IlluIllustration:UpdateTitileData()
	local var_33_0 = false

	self.titleIndex_ = {}
	self.titlePositions_ = {}

	for iter_33_0, iter_33_1 in ipairs(self.loopScrollView_.itemList_) do
		if iter_33_1.itemView.objectType_ == IlluIllustration.ITEM_TYPE.TITLE then
			self.titleIndex_[iter_33_1.itemView.chapterID_] = iter_33_1.itemView.index_
			self.titlePositions_[iter_33_1.itemView.chapterID_] = iter_33_1.itemView.transform_.localPosition.y
			var_33_0 = true
		end
	end

	self.layoutCache_ = nil

	SetActive(self.subMenuBtn_, var_33_0)
end

function IlluIllustration:RefreshEditorText()
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in ipairs(self.loadingSet_) do
		var_34_0 = var_34_0 + #self.loadingSet_[iter_34_0]
	end

	self.limitText_.text = var_34_0 .. "/" .. GameSetting.loading_pic_max.value[1]
end

function IlluIllustration:RefreshText(arg_35_1)
	local var_35_0 = 0

	for iter_35_0, iter_35_1 in ipairs(CollectPictureCfg.get_id_list_by_type[arg_35_1]) do
		if IllustratedData:GetIllustrationInfo()[iter_35_1] then
			var_35_0 = var_35_0 + 1
		end
	end

	self.numText_.text = arg_35_1 == 3 and var_35_0 .. "/" .. var_35_0 or var_35_0 .. "/" .. #CollectPictureCfg.get_id_list_by_type[arg_35_1]
end

function IlluIllustration:IsShowToggleByType(arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(CollectPictureCfg.get_id_list_by_type[arg_36_1] or {}) do
		if IllustratedData:GetIllustrationInfo()[iter_36_1] then
			return true
		end
	end

	return false
end

function IlluIllustration:OnEnter()
	self.isEditor_ = false

	self:UpdateBar()

	self.params_.index = self.params_.index or 1

	self:RefreshUI(self.params_.index, true)

	self.selectSubMenuChapterID_ = self.params_.selectSubMenuChapterID

	if self.selectSubMenuChapterID_ then
		if self.subMenuSelectTimer_ then
			self.subMenuSelectTimer_:Stop()
		end

		self.subMenuSelectTimer_ = FrameTimer.New(function()
			self:RefreshSubMenu()

			if self.params_.index == 1 or self.params_.index == 3 then
				self:SubMenuItemClickFunc(self.params_.selectSubMenuChapterID)
			end
		end, 1.3, 1):Start()
	end

	manager.redPoint:bindUIandKey(self.btn1trs_, RedPointConst.ILLU_ILLUSTRATION1)
	manager.redPoint:bindUIandKey(self.btn2trs_, RedPointConst.ILLU_ILLUSTRATION2)
	manager.redPoint:bindUIandKey(self.btn3trs_, RedPointConst.ILLU_ILLUSTRATION3)
	manager.redPoint:bindUIandKey(self.btn4trs_, RedPointConst.ILLU_ILLUSTRATION4)
	manager.redPoint:bindUIandKey(self.btn5trs_, RedPointConst.ILLU_ILLUSTRATION5)
	manager.redPoint:bindUIandKey(self.btn6trs_, RedPointConst.ILLU_ILLUSTRATION6)
end

function IlluIllustration:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.isEditor_ and self:IsChanged() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_SETTING_CHANGE"),
				OkCallback = function()
					IllustratedAction.SaveLoadingSet(self.loadingSet_)
				end,
				CancelCallback = function()
					self.isEditor_ = false

					self:RefreshUI(self.params_.index)
				end
			})
		else
			self:Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if self.isEditor_ and self:IsChanged() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_SETTING_CHANGE"),
				OkCallback = function()
					IllustratedAction.SaveLoadingSet(self.loadingSet_)
					self:Go("/home")
				end,
				CancelCallback = function()
					self:Go("/home")
				end
			})
		else
			self:Go("/home")
		end
	end)
end

function IlluIllustration:IsSelected(arg_46_1)
	if not arg_46_1 then
		return false
	end

	return table.indexof(self.loadingSet_[CollectPictureCfg[arg_46_1].type], arg_46_1) ~= false
end

function IlluIllustration:IsChanged()
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(self.loadingSet_) do
		table.insertto(var_47_0, self.loadingSet_[iter_47_0])
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

function IlluIllustration:OnSaveLoadingSet()
	self.isEditor_ = false

	self:RefreshUI(self.params_.index)
	ShowTips("SET_CONFIRMED")
end

function IlluIllustration:LsAddItem(arg_49_1, arg_49_2)
	local var_49_0

	if arg_49_1.objectType == IlluIllustration.ITEM_TYPE.TITLE then
		var_49_0 = self:GetFreeTitleItem(self.titleItemPool_, function()
			return IlluIllustrationTitleItem.New(self.titleItem_, self.gridTrs_)
		end)
		var_49_0.itemView.gameObject_.name = arg_49_2 .. "title"
	else
		var_49_0 = self:GetFreeTitleItem(self.illuItemPool_, function()
			return IlluIllustrationWidget.New(self.illuItemWidget_, self.gridTrs_)
		end)
		var_49_0.itemView.gameObject_.name = arg_49_2 .. "Widget"
	end

	var_49_0.itemView:SetData(arg_49_1, arg_49_2, self.isEditor_)

	if var_49_0.itemView:GetObjectType() == IlluIllustration.ITEM_TYPE.ITEM then
		for iter_49_0, iter_49_1 in ipairs(var_49_0.itemView.illuItemList_) do
			iter_49_1:RegisterGiftFunc(handler(self, self.ReceiveIllustrationReward))
			iter_49_1:RegisterItemFunc(handler(self, self.ItemClickFun))

			if self.isEditor_ then
				iter_49_1:SetSelect(self:IsSelected(iter_49_1.id_))
			else
				iter_49_1:SetSelect(false)
			end
		end
	end

	return var_49_0
end

function IlluIllustration:LsRemoveItem(arg_52_1, arg_52_2)
	arg_52_1.itemView:Show(false)

	arg_52_1.isFree = true
end

function IlluIllustration:LsGetItemData()
	return self.itemList_
end

function IlluIllustration:LsUpdateItem(arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	arg_54_1.itemView:SetData(arg_54_2, arg_54_3, arg_54_4)
end

function IlluIllustration:GetFreeTitleItem(arg_55_1, arg_55_2)
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

function IlluIllustration:OnExit()
	manager.windowBar:HideBar()
	self.showSubMenuController_:SetSelectedState("false")
	SetActive(self.maskBtn_.gameObject, false)
	manager.redPoint:unbindUIandKey(self.btn1trs_, RedPointConst.ILLU_ILLUSTRATION1)
	manager.redPoint:unbindUIandKey(self.btn2trs_, RedPointConst.ILLU_ILLUSTRATION2)
	manager.redPoint:unbindUIandKey(self.btn3trs_, RedPointConst.ILLU_ILLUSTRATION3)
	manager.redPoint:unbindUIandKey(self.btn4trs_, RedPointConst.ILLU_ILLUSTRATION4)
	manager.redPoint:unbindUIandKey(self.btn5trs_, RedPointConst.ILLU_ILLUSTRATION5)
	manager.redPoint:unbindUIandKey(self.btn6trs_, RedPointConst.ILLU_ILLUSTRATION6)

	self.params_.scrollPos_ = self.gridTrs_.localPosition.y
	self.params_.selectSubMenuChapterID = nil
end

function IlluIllustration:Dispose()
	for iter_57_0, iter_57_1 in ipairs(self.titleItemPool_) do
		iter_57_1.itemView:Dispose()
	end

	self.titleItemPool_ = nil

	for iter_57_2, iter_57_3 in ipairs(self.illuItemPool_) do
		iter_57_3.itemView:Dispose()
	end

	self.illuItemPool_ = nil

	for iter_57_4, iter_57_5 in ipairs(self.subMenuItemPool_) do
		iter_57_5:Dispose()
	end

	self.subMenuItemPool_ = nil

	if self.timer_ then
		self.timer_:Stop()
	end

	if self.subMenuSelectTimer_ then
		self.subMenuSelectTimer_:Stop()
	end

	IlluIllustration.super.Dispose(self)
	self.loopScrollView_:Dispose()

	self.loopScrollView_ = nil
end

function IlluIllustration:RefreshOnScroll(arg_58_1)
	if not self.titlePositions_ or table.isEmpty(self.titlePositions_) then
		self.layoutCache_ = {}

		self.showtitleController_:SetSelectedState("false")

		return
	end

	if not self.layoutCache_ then
		self.layoutCache_ = {
			contentHeight = self.scrollRectEx_.content.rect.height,
			viewportHeight = self.scrollRectEx_.viewport.rect.height,
			normalizedPositions = {}
		}

		local var_58_0 = {}

		for iter_58_0, iter_58_1 in pairs(self.titlePositions_) do
			table.insert(var_58_0, {
				id = iter_58_0,
				pos = -iter_58_1
			})
		end

		table.sort(var_58_0, function(arg_59_0, arg_59_1)
			return arg_59_0.pos < arg_59_1.pos
		end)

		self.layoutCache_.sortedChapters = var_58_0
	end

	if not self.layoutCache_ or not self.layoutCache_.sortedChapters[1] then
		return
	end

	local var_58_1 = self.scrollRectEx_.content.anchoredPosition.y
	local var_58_2 = 1
	local var_58_3 = #self.layoutCache_.sortedChapters

	while var_58_2 <= var_58_3 do
		local var_58_4 = math.floor((var_58_2 + var_58_3) / 2)

		if var_58_1 > self.layoutCache_.sortedChapters[var_58_4].pos then
			var_58_2 = var_58_4 + 1
		else
			var_58_3 = var_58_4 - 1
		end
	end

	self.nearestIndex_ = math.max(1, math.min(var_58_2 - 1, #self.layoutCache_.sortedChapters))
	self.nearestChapter_ = self.layoutCache_.sortedChapters[self.nearestIndex_]

	if self.nearestChapter_ and self.selectSubMenuChapterID_ ~= self.nearestChapter_.id then
		self.selectSubMenuChapterID_ = self.nearestChapter_.id

		for iter_58_2, iter_58_3 in ipairs(self.subMenuItemPool_) do
			iter_58_3:SetSelect(iter_58_3.chapterID_ == self.nearestChapter_.id)
		end
	end

	if var_58_1 > self.layoutCache_.sortedChapters[self.nearestIndex_].pos then
		self.showtitleController_:SetSelectedState("true")

		self.topTitleText_.text = ChapterClientCfg[self.nearestChapter_.id].name
	else
		self.showtitleController_:SetSelectedState("false")
	end
end

return IlluIllustration
