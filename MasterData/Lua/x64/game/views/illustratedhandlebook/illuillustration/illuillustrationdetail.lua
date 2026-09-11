local IlluIllustrationDetail = class("IlluIllustrationDetail", ReduxView)

function IlluIllustrationDetail:UIName()
	return "Widget/System/IllustratedHandbook/IlluIllustrationDetail"
end

function IlluIllustrationDetail:UIParent()
	return manager.ui.uiMain.transform
end

function IlluIllustrationDetail:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluIllustrationDetail:InitUI()
	self:BindCfgUI()

	self.imageImg_.cacheLimit = 3
	self.loadCon_ = ControllerUtil.GetController(self.gameObject_.transform, "loading")
	self.mutiTouchHelper_ = self.swipeBtn_.gameObject:GetComponent("MutiTouchHelper")
	self.downloadCon_ = self.conEx_:GetController("download")
	self.toggleController = self.toggleController_:GetController("default0")
	self.movieController_ = self.conEx_:GetController("movie")
	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player

	self.criplayer_:SetMaxPictureDataSize(300000)
	self.criMovie_:Stop()

	function self.criplayer_.statusChangeCallback(arg_5_0)
		self:CirMovieStatusChange(arg_5_0)
	end

	self.criLoopMovie_ = self.movieLoopGo_:GetComponent("CriManaMovieControllerForUI")
	self.criLoopPlayer_ = self.criLoopMovie_.player

	self.criLoopPlayer_:SetMaxPictureDataSize(300000)
	self.criLoopMovie_:Stop()

	function self.criLoopPlayer_.statusChangeCallback(arg_6_0)
		self:CirMovieStatusChange(arg_6_0)
	end

	self.moviePlaying = false
	self.isPlayMovie = false
end

function IlluIllustrationDetail:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			SetActive(self.shareGo_, false)
			SetActive(self.backGo_, false)
			SetActive(self.descGo_, false)
			SetActive(self.addBtn_.gameObject, false)
			SetActive(self.content_, false)
		end, function()
			SetActive(self.shareGo_, true)
			SetActive(self.backGo_, true)
			SetActive(self.descGo_, true)
			SetActive(self.addBtn_.gameObject, true)

			if #self.list_ > 1 then
				SetActive(self.content_, true)
			end
		end)
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		local var_12_0 = getData("illustrated", "loading")

		if not var_12_0 or var_12_0 == 0 then
			JumpTools.OpenPageByJump("illustratedPop", {
				ID = self.ID_,
				type_ = self.type_
			})
			saveData("illustrated", "loading", 1)
		elseif IllustratedData:IsInLoadingSet(self.ID_) then
			IllustratedAction.ChangeLoadingSet(false, self.ID_)
		else
			if #IllustratedData:GetAllLoadingSet() >= GameSetting.loading_pic_max.value[1] then
				ShowTips("SET_FAILED")

				return
			end

			IllustratedAction.ChangeLoadingSet(true, self.ID_)
			ShowTips("SET_CONFIRMED")
		end
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		self.ticker_ = 0

		if self.index_ > 1 then
			self:OnPageChange(self.index_ - 1)
		else
			return
		end
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		self.ticker_ = 0

		if self.index_ < #self.chapterList_ then
			self:OnPageChange(self.index_ + 1)
		else
			return
		end
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self.ticker_ = 0

		if #self.list_ > 1 then
			local var_15_0 = table.indexof(self.list_, self.ID_)

			self.ID_ = var_15_0 ~= #self.list_ and self.list_[var_15_0 + 1] or self.list_[1]

			self:RefreshUI()
		end
	end)

	function self.mutiTouchHelper_.OnClick(arg_16_0, arg_16_1)
		self.ticker_ = 0

		if #self.list_ > 1 then
			local var_16_0 = table.indexof(self.list_, self.ID_)

			self.ID_ = var_16_0 ~= #self.list_ and self.list_[var_16_0 + 1] or self.list_[1]

			self:RefreshUI()
		end
	end

	function self.mutiTouchHelper_.OnSingleDrag(arg_17_0, arg_17_1)
		self:TouchHelpSingleDrag(arg_17_0, arg_17_1)
	end

	function self.mutiTouchHelper_.OnMutiDrag(arg_18_0)
		self:TouchHelpMutiDrag(arg_18_0)
	end

	function self.mutiTouchHelper_.EndDrag()
		self.hasChangePaged = false
	end

	self:AddBtnListener(self.dynamicBtn_, nil, function()
		if self.toggleController:GetSelectedIndex() == 0 then
			self.toggleController:SetSelectedIndex(1)
			self.movieController_:SetSelectedIndex(0)

			self.movieGo_.transform.localPosition = Vector2(9999, 9999)
			self.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

			SetActive(self.addBtn_.gameObject, true)
			self:StopMovie()
		else
			self.toggleController:SetSelectedIndex(0)
			self.movieController_:SetSelectedIndex(1)

			self.movieGo_.transform.localPosition = Vector2(0, 0)
			self.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			SetActive(self.addBtn_.gameObject, false)
			self:StopMovie()
			self:PlayEnterAni()
		end
	end)
	self:AddBtnListener(self.staticBtn_, nil, function()
		if self.toggleController:GetSelectedIndex() == 0 then
			self.toggleController:SetSelectedIndex(1)
			self.movieController_:SetSelectedIndex(0)

			self.movieGo_.transform.localPosition = Vector2(9999, 9999)
			self.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

			SetActive(self.addBtn_.gameObject, true)
			self:StopMovie()
		else
			self.toggleController:SetSelectedIndex(0)
			self.movieController_:SetSelectedIndex(1)

			self.movieGo_.transform.localPosition = Vector2(0, 0)
			self.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			SetActive(self.addBtn_.gameObject, false)
			self:StopMovie()
			self:PlayEnterAni()
		end
	end)
end

function IlluIllustrationDetail:PlayEnterAni()
	self.isPlayMovie = true

	if self.selectHeroID == 0 then
		return
	end

	SetFile(self.criLoopPlayer_, nil, "SofdecAsset/story/story_" .. (WeddingCfg[self.selectHeroID].wedding_plot[2] .. "_" .. ((self.selectHeroID == 1095 or nil) and table.indexof(self.list_, self.ID_) + 1)) .. ".usm", CriMana.Player.SetMode.New)
	self.criLoopPlayer_:Prepare()
	self:PlayMovie(self.criLoopPlayer_, self.criLoopMovie_)
end

function IlluIllustrationDetail:PlayMovie(arg_23_1, arg_23_2)
	arg_23_1:SetVolume((manager.audio:GetMusicVolume()))
	arg_23_2:Play()

	self.moviePlaying = true
end

function IlluIllustrationDetail:CirMovieStatusChange(arg_24_1)
	local var_24_0 = tostring(arg_24_1)

	if var_24_0 == "PlayEnd" then
		self.hasViewStart_ = true
		self.movieLoopGo_.transform.localPosition = Vector2(0, 0)

		self:PlayMovie(self.criLoopPlayer_, self.criLoopMovie_)

		self.movieGo_.transform.localPosition = Vector2(9999, 9999)
	elseif var_24_0 == "Stop" then
		self:PlayEnterAni()
	elseif var_24_0 == "Error" then
		self.criLoopPlayer_:Stop()
	end
end

function IlluIllustrationDetail:StopMovie()
	if self.criMovie_ then
		self.criMovie_:Stop()
	end

	if self.criLoopMovie_ then
		self.criLoopMovie_:Stop()
	end

	self.moviePlaying = false
end

function IlluIllustrationDetail:DisPoseMovie()
	if self.criMovie_ or self.criLoopMovie_ then
		self:StopMovie()

		if self.criPlayer_ then
			self.criPlayer_:Dispose()

			self.criplayer_.statusChangeCallback = nil
			self.criPlayer_ = nil
		end

		if self.criLoopPlayer_ then
			self.criLoopPlayer_:Dispose()

			self.criplayer_.statusChangeCallback = nil
			self.criLoopPlayer_ = nil
		end
	end
end

function IlluIllustrationDetail:TouchHelpSingleDrag(arg_27_1, arg_27_2)
	if self.hasChangePaged then
		return
	end

	self.ticker_ = 0

	if arg_27_1 < -1 * 3 then
		if self.index_ >= #self.chapterList_ then
			return
		end

		self.hasChangePaged = true

		self:OnPageChange(self.index_ + 1)
	elseif 3 < arg_27_1 then
		if self.index_ <= 1 then
			return
		end

		self.hasChangePaged = true

		self:OnPageChange(self.index_ - 1)
	end
end

function IlluIllustrationDetail:TouchHelpMutiDrag(arg_28_1)
	if self.hasChangePaged then
		return
	end

	self.ticker_ = 0

	if GameSetting.delta_to_zoom then
		local var_28_0 = GameSetting.delta_to_zoom.value[1] or 10

		if var_28_0 < arg_28_1 then
			if self.index_ == self.maxDishIndex_ then
				return
			end

			self.hasChangePaged = true

			self:OnPageChange(self.index_ + 1)
		elseif arg_28_1 < -1 * var_28_0 then
			if self.index_ == 1 then
				return
			end

			self.hasChangePaged = true

			self:OnPageChange(self.index_ - 1)
		end
	end
end

function IlluIllustrationDetail:OnPageChange(arg_29_1)
	self.index_ = arg_29_1
	self.ID_ = self.chapterList_[self.index_]
	self.selectHeroID = CollectPictureCfg[self.ID_].wedding_role_id

	self:RefreshData()
	self:RefreshLiner()
	self:RefreshUI()
	SetActive(self.leftBtn_.gameObject, self.index_ > 1 and self.toggleController:GetSelectedIndex() == 1)
	SetActive(self.rightBtn_.gameObject, self.index_ < #self.chapterList_ and self.toggleController:GetSelectedIndex() == 1)
end

function IlluIllustrationDetail:OnEnter()
	self.ID_ = self.params_.ID
	self.chapterList_ = self.params_.chapterList
	self.index_ = self.params_.index or 1
	self.selectHeroID = self.params_.heroID or 0

	if self.selectHeroID == 0 then
		self.toggleController:SetSelectedIndex(1)
		self.movieController_:SetSelectedIndex(0)

		self.movieGo_.transform.localPosition = Vector2(9999, 9999)
		self.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

		self:StopMovie()
	end

	SetActive(self.toggleGo_, self.selectHeroID ~= 0)
	self:RefreshData()
	self:RefreshLiner()
	self:RefreshUI()
	SetActive(self.leftBtn_.gameObject, self.index_ > 1 and self.toggleController:GetSelectedIndex() == 1)
	SetActive(self.rightBtn_.gameObject, self.index_ < #self.chapterList_ and self.toggleController:GetSelectedIndex() == 1)

	self.ticker_ = 0
	self.btnTimer_ = Timer.New(function()
		self.ticker_ = self.ticker_ + 1

		if self.ticker_ >= 5 then
			SetActive(self.leftBtn_.gameObject, false)
			SetActive(self.rightBtn_.gameObject, false)
		else
			SetActive(self.leftBtn_.gameObject, self.index_ > 1 and self.toggleController:GetSelectedIndex() == 1)
			SetActive(self.rightBtn_.gameObject, self.index_ < #self.chapterList_ and self.toggleController:GetSelectedIndex() == 1)
		end
	end, 1, -1)

	self.btnTimer_:Start()
end

function IlluIllustrationDetail:RefreshData()
	self.type_ = CollectPictureCfg[self.ID_].type
	self.list_ = {}

	for iter_32_0, iter_32_1 in pairs(CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[self.ID_].group_id] or {}) do
		local var_32_0 = IllustratedData:GetIllustrationInfo()[iter_32_1]

		if var_32_0 ~= nil and var_32_0.is_receive == 1 then
			table.insert(self.list_, iter_32_1)
		end
	end

	table.sort(self.list_, function(arg_33_0, arg_33_1)
		return CollectPictureCfg[arg_33_0].group_display_order < CollectPictureCfg[arg_33_1].group_display_order
	end)
	SetActive(self.content_, #self.list_ > 1)

	self.bgBtn_.interactable = #self.list_ > 1
end

function IlluIllustrationDetail:RefreshLiner()
	self:SetBarPosition(0)

	local var_34_0 = self.sliderBg_.transform.childCount
	local var_34_1 = #self.list_

	for iter_34_0 = 1, #self.list_ < self.sliderBg_.transform.childCount and var_34_0 or var_34_1 do
		if iter_34_0 <= var_34_0 then
			local var_34_2 = self.sliderBg_.transform:GetChild(iter_34_0 - 1)

			if iter_34_0 <= var_34_1 then
				SetActive(var_34_2.gameObject, true)
			else
				SetActive(var_34_2.gameObject, false)
			end
		else
			SetActive(Object.Instantiate(self.barTemp_, self.sliderBg_.transform), true)
		end
	end
end

function IlluIllustrationDetail:SetBarPosition(arg_35_1)
	self.selectItem_.transform:SetSiblingIndex(arg_35_1)
end

function IlluIllustrationDetail:RefreshUI()
	SetActive(self.shareBtn_.gameObject, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	SetActive(self.toggleGo_, self.selectHeroID ~= 0)

	function _RefreshUI()
		self.downloadCon_:SetSelectedState("downloaded")

		self.imageImg_.spriteSync = self.type_ == 5 and "TextureConfig/Loading/" .. CollectPictureCfg[self.ID_].picture or "TextureConfig/Background/" .. CollectPictureCfg[self.ID_].picture
		self.titleText_.text = GetI18NText(CollectPictureCfg[self.ID_].name)
		self.descText_.text = GetI18NText(CollectPictureCfg[self.ID_].desc)

		self:RefreshLoading()
		self:SetBarPosition((table.indexof(self.list_, self.ID_) or 1) - 1)
	end

	self:CheckNeedDownloadAssets(_RefreshUI)

	if self.toggleController:GetSelectedIndex() == 0 then
		SetActive(self.addBtn_.gameObject, false)

		if self.selectHeroID == 1095 then
			self:StopMovie()
		else
			self:PlayEnterAni()
		end
	else
		SetActive(self.addBtn_.gameObject, true)
	end
end

function IlluIllustrationDetail:CheckNeedDownloadAssets(arg_38_1)
	local var_38_0 = self.type_ == 5 and "TextureConfig/Loading/" .. CollectPictureCfg[self.ID_].picture or "TextureConfig/Background/" .. CollectPictureCfg[self.ID_].picture

	if AssetDownloadManager.CheckResourcesNeedDownload({
		var_38_0
	}) then
		self.downloadCon_:SetSelectedState("downloading")

		self.imageImg_.spriteSync = SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[self.ID_].picture

		SetForceShowQuanquan(true)
		manager.assetPend:StartDownloadAsset(var_38_0, function()
			arg_38_1()
			SetForceShowQuanquan(false)
		end, function()
			SetForceShowQuanquan(false)
		end)
	else
		arg_38_1()
	end
end

function IlluIllustrationDetail:RefreshLoading()
	self.loadCon_:SetSelectedState(IllustratedData:IsInLoadingSet(self.ID_) and "true" or "false")
end

function IlluIllustrationDetail:OnSaveLoadingSet()
	self:RefreshLoading()
end

function IlluIllustrationDetail:OnExitInput()
	JumpTools.Back()

	return true
end

function IlluIllustrationDetail:OnExit()
	if self.btnTimer_ then
		self.btnTimer_:Stop()

		self.btnTimer_ = nil
	end

	if self.isPlayMovie then
		self:StopMovie()

		self.isPlayMovie = false
	end
end

function IlluIllustrationDetail:Dispose()
	self:DisPoseMovie()
	IlluIllustrationDetail.super.Dispose(self)
end

return IlluIllustrationDetail
