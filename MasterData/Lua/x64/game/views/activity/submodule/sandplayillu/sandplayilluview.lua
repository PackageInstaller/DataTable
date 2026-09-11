local SandPlayIlluView = class("SandPlayIlluView", ReduxView)
local var_0_1 = "QWWorld/Illu/Illu_background_01"
local var_0_2 = "QWWorld/Illu/Illu_background_02"

function SandPlayIlluView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_Book/SandPlay_Com_BookUI"
end

function SandPlayIlluView:UIParent()
	return manager.ui.uiMain.transform
end

function SandPlayIlluView:Init()
	self:InitUI()
	self:AddUIListener()
	self:InitData()
end

function SandPlayIlluView:InitUI()
	self:BindCfgUI()

	self.itemList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, SandPlayIlluItem)
	self.tabList_ = {}

	self:BindController()
end

function SandPlayIlluView:BindController()
	self.btnStateController_ = self.mainControllerEx_:GetController("btn")
	self.tabController_ = self.mainControllerEx_:GetController("tab")
	self.modelController_ = self.modelControllerEx_:GetController("lock")
end

function SandPlayIlluView:InitData()
	self.curGroupIndex_ = 0
	self.curItemID_ = 0
	self.curItemIDList_ = {}
	self.curGroupList_ = {}
	self.curModel_ = nil
	self.bg_ = nil
	self.board_ = nil
end

function SandPlayIlluView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not SandplayIlluGroupCfg[self.curGroupList_[self.curGroupIndex_]] then
			return
		end

		SandplayIlluAction.GetReward(self.curItemID_)
	end)
	self:AddDragListener(self.backGo_, function()
		self.startRot_ = self.curModel_ and self.curModel_.transform.localEulerAngles or Vector3.zero
		self.lastRotateY_ = nil
		self.lastDeltaX_ = 0
	end, function(arg_10_0, arg_10_1)
		if self.curModel_ then
			local var_10_0 = self.lastRotateY_ or self.curModel_.transform.localEulerAngles.y
			local var_10_1 = var_10_0 + (arg_10_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_10_0

			if var_10_0 + (arg_10_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_10_0 < -HeroConst.MAX_RORATE_ANGLE then
				var_10_1 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_10_0 + (arg_10_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_10_0 > HeroConst.MAX_RORATE_ANGLE then
				var_10_1 = HeroConst.MAX_RORATE_ANGLE
			end

			self.lastRotateY_ = var_10_0 + var_10_1
			self.lastDeltaX_ = arg_10_0
			self.curModel_.transform.localRotation = Quaternion.RotateTowards(self.curModel_.transform.localRotation, Quaternion.Euler(self.startRot_.x, var_10_0 + var_10_1, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function SandPlayIlluView:indexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, self.curItemIDList_[arg_11_1], function(arg_12_0, arg_12_1)
		self:ChangeItemID(arg_12_0, arg_12_1)
	end)
	arg_11_2:SetSelectedState(self.curItemID_)
end

function SandPlayIlluView:OnEnter()
	self:LoadBg()
	self:RefreshData(false)

	self.sceneSetting_ = manager.ui:GetSceneSettingBySceneName((QWorldData:GetCurSceneName()))
	self.sceneSetting_.enabled = false

	SandPlayIlluTool.OnEnterSandPlayIllu()
end

function SandPlayIlluView:RefreshData(arg_14_1)
	self:RefreshGroupList()

	if self.params_.itemID then
		if SandplayIlluCfg[self.params_.itemID] and SandplayIlluCfg[self.params_.itemID].type then
			self:ChangeGroupIndex(SandplayIlluCfg[self.params_.itemID].type, self.params_.itemID, arg_14_1)

			return
		end
	end

	self:ChangeGroupIndex(1, nil, arg_14_1)
end

function SandPlayIlluView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function SandPlayIlluView:OnBehind()
	manager.windowBar:HideBar()
end

function SandPlayIlluView:ChangeGroupIndex(arg_17_1, arg_17_2, arg_17_3)
	if self.curGroupIndex_ == arg_17_1 and not arg_17_3 then
		return
	end

	self.curGroupIndex_ = arg_17_1

	self:RefreshChooseGroupState(arg_17_1)
	self:RefreshItemList()

	if arg_17_2 then
		for iter_17_0, iter_17_1 in ipairs(self.curItemIDList_) do
			if iter_17_1 == arg_17_2 then
				self:ChangeItemID(arg_17_2, iter_17_0)

				return
			end
		end
	end

	self:ChangeItemID(self.curItemIDList_[1], 1)
end

function SandPlayIlluView:ChangeItemID(arg_18_1, arg_18_2)
	if not arg_18_1 or self.curItemID_ == arg_18_1 then
		return
	end

	self.curItemID_ = arg_18_1

	if SandplayIlluData:IsUnlock(arg_18_1) and not SandplayIlluData:IsSaw(self.curItemID_) and SandplayIlluGroupCfg[self.curGroupList_[self.curGroupIndex_]] then
		SandplayIlluAction.ViewItem(self.curItemID_)
	end

	self:RefreshButtonState()
	self:RefreshChooseItemState(arg_18_1)
	self:RefreshItemView()
end

function SandPlayIlluView:RefreshGroupList()
	local var_19_0 = SandplayIlluData:GetGroupNum()

	self.curGroupList_ = SandplayIlluGroupCfg.all

	if var_19_0 <= 1 then
		self.tabController_:SetSelectedState("hide")

		return
	end

	self.tabController_:SetSelectedState("show")

	for iter_19_0, iter_19_1 in ipairs(self.curGroupList_) do
		self.tabList_[iter_19_0] = self.tabList_[iter_19_0] or SandPlayIlluTabItem.New((Object.Instantiate(self.tabItemGo_, self.tabTrans_)))

		self.tabList_[iter_19_0]:SetData(iter_19_0, iter_19_1, function(arg_20_0)
			self:ChangeGroupIndex(arg_20_0)
		end)
		self.tabList_[iter_19_0]:Show(true)
	end

	for iter_19_2 = var_19_0 + 1, #self.tabList_ do
		self.tabList_[iter_19_2]:Show(false)
	end
end

function SandPlayIlluView:RefreshItemList()
	if not SandplayIlluCfg.get_id_list_by_type[self.curGroupList_[self.curGroupIndex_]] then
		return
	end

	CommonTools.UniversalSortEx(SandplayIlluCfg.get_id_list_by_type[self.curGroupList_[self.curGroupIndex_]], {
		map = function(arg_22_0)
			if SandplayIlluData:IsUnlock(arg_22_0) and not SandplayIlluData:IsSaw(arg_22_0) then
				return 2
			elseif SandplayIlluData:IsUnlock(arg_22_0) then
				return 1
			else
				return 0
			end
		end
	}, {
		map = function(arg_23_0)
			return -arg_23_0
		end
	})

	self.curItemIDList_ = SandplayIlluCfg.get_id_list_by_type[self.curGroupList_[self.curGroupIndex_]]

	self.itemList_:StartScroll(#self.curItemIDList_)

	if SandplayIlluGroupCfg[self.curGroupList_[self.curGroupIndex_]] then
		self.groupText_.text = SandplayIlluGroupCfg[self.curGroupList_[self.curGroupIndex_]].name
	end

	self.progressText_.text = SandplayIlluData:GetItemNum(self.curGroupList_[self.curGroupIndex_]) .. "/" .. #self.curItemIDList_
end

function SandPlayIlluView:RefreshButtonState()
	if not SandplayIlluData:IsUnlock(self.curItemID_) then
		self.btnStateController_:SetSelectedState("lock")
	elseif SandplayIlluData:IsReceive(self.curItemID_) then
		self.btnStateController_:SetSelectedState("rewarded")
	else
		self.btnStateController_:SetSelectedState("complete")
	end
end

function SandPlayIlluView:RefreshChooseGroupState(arg_25_1)
	if #self.tabList_ < 1 then
		return
	end

	for iter_25_0, iter_25_1 in pairs(self.tabList_) do
		iter_25_1:SetSelectedState(arg_25_1)
	end
end

function SandPlayIlluView:RefreshChooseItemState(arg_26_1)
	for iter_26_0, iter_26_1 in pairs((self.itemList_:GetItemList())) do
		iter_26_1:SetSelectedState(arg_26_1)
	end
end

function SandPlayIlluView:RefreshItemView()
	self:OnRefreshItem()

	self.titleText_.text = SandplayIlluCfg[self.curItemID_].name
	self.descText_.text = SandplayIlluCfg[self.curItemID_].desc
	self.lockDescText_.text = SandplayIlluCfg[self.curItemID_].simple_desc
	self.scroll_.verticalNormalizedPosition = 1

	self.textAnimator_:Play("itemDetails", 0, 0)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, self.curItemID_))
end

function SandPlayIlluView:OnExit()
	self.curGroupIndex_ = 0
	self.curItemID_ = 0
	self.curItemIDList_ = {}
	self.curGroupList_ = {}

	self:UnBindRedPoint()
	self:UnloadBg()
	self:UnloadModel()
	SandPlayIlluTool.ExitSandPlayIllu()

	if self.sceneSetting_ then
		self.sceneSetting_.enabled = true
	end
end

function SandPlayIlluView:OnSandPlayIlluItemDataChange(arg_29_1)
	if arg_29_1 then
		self:RefreshData(true)
	else
		self:RefreshButtonState()
	end
end

function SandPlayIlluView:OnRefreshItem()
	self:UnloadModel()

	if not SandplayIlluData:IsUnlock(self.curItemID_) then
		self.modelController_:SetSelectedState("true")

		return
	end

	self.modelController_:SetSelectedState("false")
	self:LoadModel()
end

function SandPlayIlluView:LoadBg()
	self:UnloadBg()

	self.bg_ = Asset.Instantiate(var_0_1)
	self.bg_.transform.localPosition = Vector3.New(SandPlayIlluConst.BG_POS[1], SandPlayIlluConst.BG_POS[2], SandPlayIlluConst.BG_POS[3]) + Vector3.New(SandPlayIlluConst.CAMERA_POS[1], SandPlayIlluConst.CAMERA_POS[2], SandPlayIlluConst.CAMERA_POS[3])
	self.board_ = Asset.Instantiate(var_0_2)

	self:AdaptBg()
end

function SandPlayIlluView:UnloadBg()
	if self.bg_ then
		Object.Destroy(self.bg_)
	end

	self.bg_ = nil

	if self.board_ then
		Object.Destroy(self.board_)
	end

	self.board_ = nil
end

function SandPlayIlluView:LoadModel()
	if self.curModel_ ~= nil then
		self:UnloadModel()
	end

	if SandplayIlluCfg[self.curItemID_] then
		self.curModel_ = Asset.Instantiate(SandplayIlluCfg[self.curItemID_].model_path)
	end
end

function SandPlayIlluView:UnloadModel()
	if self.curModel_ == nil then
		return
	end

	Object.Destroy(self.curModel_)

	if isNil(self.curModel_) then
		self.curModel_ = nil
	end
end

function SandPlayIlluView:UnBindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, self.curItemID_))
end

function SandPlayIlluView:AdaptBg()
	local var_36_0 = self.bg_.transform:GetComponentInChildren(typeof(SpriteRenderer))

	if var_36_0 then
		local var_36_1 = Vector3.New(SandPlayIlluConst.CAMERA_POS[1], SandPlayIlluConst.CAMERA_POS[2], SandPlayIlluConst.CAMERA_POS[3])
		local var_36_2 = 2 * (self.bg_.transform.localPosition - var_36_1).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

		self.bg_.transform.localScale = Vector3.New(var_36_2 / var_36_0.sprite.bounds.size.y < var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_0.sprite.bounds.size.x and var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_0.sprite.bounds.size.x or var_36_2 / var_36_0.sprite.bounds.size.y, var_36_2 / var_36_0.sprite.bounds.size.y < var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_0.sprite.bounds.size.x and var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_0.sprite.bounds.size.x or var_36_2 / var_36_0.sprite.bounds.size.y, var_36_2 / var_36_0.sprite.bounds.size.y < var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_0.sprite.bounds.size.x and var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_0.sprite.bounds.size.x or var_36_2 / var_36_0.sprite.bounds.size.y)

		local var_36_3 = math.min((Screen.width / 1920 + Screen.height / 1080) / 2, 1)

		self.board_.transform.localScale = Vector3.New(SandPlayIlluConst.BOARD_SCALE, SandPlayIlluConst.BOARD_SCALE, SandPlayIlluConst.BOARD_SCALE)
		self.board_.transform.localPosition = Vector3.New(SandPlayIlluConst.BOARD_POS[1] * math.min(1, Screen.width / Screen.height / 1.7777777777777777), SandPlayIlluConst.BOARD_POS[2], SandPlayIlluConst.BOARD_POS[3]) + var_36_1
	end
end

function SandPlayIlluView:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	for iter_37_0, iter_37_1 in ipairs(self.tabList_) do
		if iter_37_1 and iter_37_1.Dispose then
			iter_37_1:Dispose()
		end
	end

	SandPlayIlluView.super.Dispose(self)
end

return SandPlayIlluView
