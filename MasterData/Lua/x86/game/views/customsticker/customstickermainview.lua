local CustomStickerMainView = class("CustomStickerMainView", ReduxView)

function CustomStickerMainView:UIName()
	return "Widget/System/UserInfor/sticker_new/StickerMainUI_new"
end

function CustomStickerMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CustomStickerMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomStickerMainView:InitUI()
	self:BindCfgUI()

	self.MaxScaleNum = GameSetting.sticker_scaling.value[2]
	self.curPageNum_ = 1
	self.maxPageNum_ = 1
	self.stickerTrsPool_ = {}
	self.bgEditing_ = false
	self.curDynamicFg_ = nil
	self.curDynamicBg_ = nil
	self.curDynamicTopBg_ = nil
	self.pageData_ = {}
	self.bgData_ = {}
	self.bgList_ = LuaList.New(handler(self, self.IndexItem), self.bgUIList_, CustomStickerListItem)
	self.snapPanel_ = CustomStickerSnapPanel.New(self.snapGo_)
	self.sharePanel_ = CustomStickerSharePanel.New(self.shareGo_, function()
		self:RefreshBar()
	end)
	self.editBgController_ = self.mainControllerEx_:GetController("editBg")
	self.favoriteController_ = self.mainControllerEx_:GetController("favorite")
	self.foreignController_ = self.mainControllerEx_:GetController("foreign")
end

function CustomStickerMainView:AddUIListeners()
	self:AddBtnListener(self.changeBgBtn_, nil, function()
		if not self.bgEditing_ then
			self.bgEditing_ = true

			self.editBgController_:SetSelectedState("true")
			self.bgList_:StartScroll(#self.bgData_)
		end
	end)
	self:AddBtnListener(self.bgRetBtn_, nil, function()
		if self.bgEditing_ then
			self.bgEditing_ = false

			self.editBgController_:SetSelectedState("false")
		end
	end)
	self:AddBtnListener(self.prePageBtn_, nil, function()
		if self.curPageNum_ > 1 then
			self.curPageNum_ = self.curPageNum_ - 1

			self:UpdateView()
		end
	end)
	self:AddBtnListener(self.nextPageBtn_, nil, function()
		if self.curPageNum_ < self.maxPageNum_ then
			self.curPageNum_ = self.curPageNum_ + 1

			self:UpdateView()
		end
	end)
	self:AddBtnListener(self.bookletBtn_, nil, function()
		JumpTools.OpenPageByJump("/customStickerCollect")
	end)
	self:AddBtnListener(self.editBtn_, nil, function()
		JumpTools.OpenPageByJump("/customStickerEdit", {
			page = self.curPageNum_
		})
	end)
	self:AddBtnListener(self.favoriteBtn_, nil, function()
		if PlayerData:GetStickerShowID() ~= self.bgData_[self.curPageNum_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("STICKER_EXHIBITION_CONFIRM"),
				OkCallback = function()
					PlayerAction.SyncStickerShowToServer(self.bgData_[self.curPageNum_])
					self.favoriteController_:SetSelectedState("star")
				end,
				CancelCallback = function()
					return
				end
			})
		else
			ShowTips(GetTips("STICKER_EXHIBITION_ALREADY"))
		end
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		self.foreignController_:SetSelectedState("true")
		manager.windowBar:HideBar()
		self.snapPanel_:Snap(function()
			self.foreignController_:SetSelectedState("false")
			self.sharePanel_:OnSnape()
		end)
	end)
end

function CustomStickerMainView:IndexItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(ProfileDecorateItemCfg[self.bgData_[arg_18_1]], self.curPageNum_ == arg_18_1, PlayerData:GetStickerShowID() == self.bgData_[arg_18_1], true, false, false, function()
		local var_19_0 = self.bgList_:GetItemByIndex(self.curPageNum_)

		if var_19_0 then
			var_19_0:Select(false)
		end

		arg_18_2:Select(true)

		self.curPageNum_ = arg_18_1

		self:UpdateView()
	end)
end

function CustomStickerMainView:RefreshBar()
	if self.params_.foreign then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})

		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.bgEditing_ then
			self.bgEditing_ = false

			self.editBgController_:SetSelectedState("false")
		else
			JumpTools.Back()
		end
	end)

	if #GameSetting.custom_sticker_info_describe.value > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = GameSetting.custom_sticker_info_describe.value
			}
		})
	end
end

function CustomStickerMainView:OnEnter()
	SetActive(self.shareBtn_.gameObject, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	self:RefreshBar()

	if self.params_.foreign then
		self.bgData_ = {}
		self.pageData_ = self.params_.foreign

		for iter_22_0, iter_22_1 in pairs(self.pageData_) do
			self.bgData_[1] = iter_22_0

			break
		end

		if not self.bgData_[1] then
			self.bgData_[1] = GameSetting.sticker_background_default.value[1]
			self.pageData_[self.bgData_[1]] = {
				foreground = 0,
				sticker = {},
				hierarchy = {}
			}
		end

		self.maxPageNum_ = 1
		self.curPageNum_ = 1

		self.foreignController_:SetSelectedState("true")
	else
		self.bgData_ = PlayerData:GetStickerBgList()

		local var_22_0 = GameSetting.sticker_background_default.value[1]

		table.sort(self.bgData_, function(arg_23_0, arg_23_1)
			if arg_23_0 == var_22_0 then
				return true
			end

			if arg_23_1 == var_22_0 then
				return false
			end

			return arg_23_0 < arg_23_1
		end)

		self.pageData_ = PlayerData:GetStickerEditData()
		self.maxPageNum_ = #self.bgData_
		self.curPageNum_ = getData("PlayerCustomStickerTriggered", "LastEditStickerPageNum") or 1
		self.curPageNum_ = math.min(self.maxPageNum_, self.curPageNum_)

		self.foreignController_:SetSelectedState("false")
	end

	self:UpdateView()
	self.sharePanel_:OnEnter()
	manager.redPoint:bindUIandKey(self.bookletBtn_.transform, RedPointConst.CUSTOM_STICKER_ROOT)
end

function CustomStickerMainView:UpdateView()
	SetActive(self.prePageBtn_.gameObject, self.curPageNum_ > 1)
	SetActive(self.nextPageBtn_.gameObject, self.curPageNum_ < self.maxPageNum_)

	self.bgNameText_.text = ItemTools.getItemName(self.bgData_[self.curPageNum_])
	self.pageNumText_.text = self.curPageNum_ .. "/" .. self.maxPageNum_

	if PlayerData:GetStickerShowID() == self.bgData_[self.curPageNum_] then
		self.favoriteController_:SetSelectedState("star")
	else
		self.favoriteController_:SetSelectedState("none")
	end

	local var_24_0 = manager.ui:GetCanvasSize()

	self:DestroyDynamicGo()

	self.bgStaticImg_.enabled = false

	if self.pageData_[self.bgData_[self.curPageNum_]] then
		if ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]] then
			if ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]].type == 1 then
				self.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_" .. ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]].resource
				self.bgStaticImg_.enabled = true
			elseif ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]].type == 2 then
				self.curDynamicBg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Bg/Bgitem_" .. ProfileDecorateItemCfg[self.bgData_[self.curPageNum_]].resource), self.bgDynamicTrs_)
				self.bgStaticImg_.enabled = false
				self.curDynamicTopBg_ = self.curDynamicBg_.transform:Find("TopPart")

				if self.curDynamicTopBg_ then
					self.curDynamicTopBg_:SetParent(self.topBgTrs_)

					self.curDynamicTopBg_ = self.curDynamicTopBg_.gameObject
				end
			end
		end
	end

	self.fgStaticImg_.enabled = false

	if self.pageData_[self.bgData_[self.curPageNum_]].foreground ~= 0 then
		if ProfileDecorateItemCfg[self.pageData_[self.bgData_[self.curPageNum_]].foreground] then
			if ProfileDecorateItemCfg[self.pageData_[self.bgData_[self.curPageNum_]].foreground].type == 1 then
				self.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. ProfileDecorateItemCfg[self.pageData_[self.bgData_[self.curPageNum_]].foreground].resource
				self.fgStaticImg_.enabled = true
			elseif ProfileDecorateItemCfg[self.pageData_[self.bgData_[self.curPageNum_]].foreground].type == 2 then
				self.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. ProfileDecorateItemCfg[self.pageData_[self.bgData_[self.curPageNum_]].foreground].resource), self.fgDynamicTrs_)
				self.fgStaticImg_.enabled = false
			end
		end
	end

	local var_24_1 = 1

	for iter_24_0, iter_24_1 in pairs(self.pageData_[self.bgData_[self.curPageNum_]].hierarchy) do
		if ProfileDecorateItemCfg[iter_24_1] then
			self.stickerTrsPool_[var_24_1] = self.stickerTrsPool_[var_24_1] or CustomStickerMoveItem.New((Object.Instantiate(self.stMoveGo_, self.customPanelTrs_)))

			SetActive(self.stickerTrsPool_[var_24_1].gameObject_, true)
			self.stickerTrsPool_[var_24_1]:SetData(ProfileDecorateItemCfg[iter_24_1])
			self.stickerTrsPool_[var_24_1].rectTransform_:SetAnchoredPositionEx(self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_24_1].positionX / 10000 * var_24_0.x, self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_24_1].positionY / 10000 * var_24_0.y)
			self.stickerTrsPool_[var_24_1].rectTransform_:SetLocalEulerAngleZ(self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_24_1].rotation / 10000 * 360)
			self.stickerTrsPool_[var_24_1].rectTransform_:SetLocalScaleVal(self.pageData_[self.bgData_[self.curPageNum_]].sticker[iter_24_1].scale / 10000 * self.MaxScaleNum)
			self.stickerTrsPool_[var_24_1].rectTransform_:SetAsLastSibling()

			var_24_1 = var_24_1 + 1
		end
	end

	while var_24_1 <= #self.stickerTrsPool_ do
		if self.stickerTrsPool_[var_24_1] then
			SetActive(self.stickerTrsPool_[var_24_1].gameObject_, false)
		end

		var_24_1 = var_24_1 + 1
	end
end

function CustomStickerMainView:DestroyDynamicGo()
	if self.curDynamicFg_ then
		Object.Destroy(self.curDynamicFg_)

		self.curDynamicFg_ = nil
	end

	if self.curDynamicBg_ then
		Object.Destroy(self.curDynamicBg_)

		self.curDynamicBg_ = nil
	end

	if self.curDynamicTopBg_ then
		Object.Destroy(self.curDynamicTopBg_)

		self.curDynamicTopBg_ = nil
	end
end

function CustomStickerMainView:OnExit()
	manager.windowBar:HideBar()
	saveData("PlayerCustomStickerTriggered", "LastEditStickerPageNum", self.curPageNum_)
	self.sharePanel_:OnExit()
	manager.redPoint:unbindUIandKey(self.bookletBtn_.transform, RedPointConst.CUSTOM_STICKER_ROOT)
end

function CustomStickerMainView:Dispose()
	self:RemoveAllListeners()
	self:DestroyDynamicGo()

	if self.bgList_ then
		self.bgList_:Dispose()

		self.bgList_ = nil
	end

	if self.snapPanel_ then
		self.snapPanel_:Dispose()

		self.snapPanel_ = nil
	end

	if self.sharePanel_ then
		self.sharePanel_:Dispose()

		self.sharePanel_ = nil
	end

	for iter_27_0 = 1, #self.stickerTrsPool_ do
		if self.stickerTrsPool_[iter_27_0] then
			self.stickerTrsPool_[iter_27_0]:Dispose()

			self.stickerTrsPool_[iter_27_0] = nil
		end
	end

	CustomStickerMainView.super.Dispose(self)
end

return CustomStickerMainView
