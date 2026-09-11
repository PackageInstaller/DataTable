local ActivitySkinDrawRewardView = class("ActivitySkinDrawRewardView", ReduxView)

function ActivitySkinDrawRewardView:UIName()
	return ActivitySkinDrawTools.GetDrawRewardUIName(self.params_.mainActivityID)
end

function ActivitySkinDrawRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinDrawRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawRewardView:InitUI()
	self:BindCfgUI()

	self.soundEffect_ = ActivitySkinDrawTools.GetSoundEffect()
	self.typeGo_ = {}
	self.typeItem_ = {}
end

function ActivitySkinDrawRewardView:AddUIListeners()
	self:AddBtnListener(self.nextBtn_, nil, function()
		self:NextCode()
	end)
	self:AddBtnListener(self.skipBtn_, nil, function()
		self:GotoResult()
	end)
end

function ActivitySkinDrawRewardView:OnEnter()
	self.index_ = 0
	self.list_ = self.params_.list
	self.showList_ = self.params_.showList
	self.replaceList_ = self.params_.replaceList

	self:RefreshReplace()
	self:RefreshGoList()
	self:NextCode()
end

function ActivitySkinDrawRewardView:RefreshReplace()
	self.isReplaceFrame_ = false
	self.isReplaceSkin_ = false
	self.isReplaceScene_ = false
	self.isReplaceSticker_ = false

	for iter_9_0, iter_9_1 in ipairs(self.replaceList_) do
		if ItemCfg[ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]].type == ItemConst.ITEM_TYPE.FRAME then
			self.isReplaceFrame_ = true
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN or ActivitySkinDrawTools.GetIsSkinGift(ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]) then
			self.isReplaceSkin_ = true
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]].type == ItemConst.ITEM_TYPE.SCENE then
			self.isReplaceScene_ = true
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			self.isReplaceSticker_ = true
		end
	end
end

function ActivitySkinDrawRewardView:RefreshGoList()
	if self.activityID_ ~= self.params_.mainActivityID then
		self.typeGo_ = ActivitySkinDrawTools.GetTypeGo(self.params_.mainActivityID)
		self.activityID_ = self.params_.mainActivityID

		for iter_10_0, iter_10_1 in pairs(self.typeItem_) do
			iter_10_1:Dispose()
		end

		self.typeItem_ = {}
	end
end

function ActivitySkinDrawRewardView:NextCode()
	SetActive(self.tipGo_, false)

	if self.curItem_ then
		self.curItem_:Hide()
	end

	if self.index_ < #self.showList_ then
		self.index_ = self.index_ + 1

		local var_11_0 = self.showList_[self.index_]
		local var_11_1 = ActivityLimitedDrawPoolCfg[self.showList_[self.index_]].reward[1][1]
		local var_11_2 = ItemCfg[ActivityLimitedDrawPoolCfg[self.showList_[self.index_]].reward[1][1]]
		local var_11_3 = 1

		if ItemCfg[ActivityLimitedDrawPoolCfg[self.showList_[self.index_]].reward[1][1]].rare >= 5 then
			var_11_3 = 3
		elseif var_11_2.rare == 4 then
			var_11_3 = 2
		end

		if ActivitySkinDrawTools.GetIsSkinGift(var_11_1) then
			var_11_1 = var_11_2.param[1][1]
			var_11_2 = ItemCfg[var_11_2.param[1][1]]
		end

		if var_11_2.type == ItemConst.ITEM_TYPE.FRAME then
			self:ShowReward(var_11_3, var_11_0, self.isReplaceFrame_)
		elseif var_11_2.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			var_11_3 = 4

			manager.audio:StopEffect()
			manager.audio:PlayEffect("ui_system_search", self.soundEffect_[var_11_3], "")
			self:ShowAni(var_11_3, var_11_0, self.isReplaceSkin_)
		elseif var_11_2.type == ItemConst.ITEM_TYPE.SCENE then
			self.isScene_ = not self.isReplaceScene_
			self.sceneId_ = var_11_1
			var_11_3 = 4

			self:ShowReward(4, var_11_0, self.isReplaceScene_)
		elseif var_11_2.type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			self:ShowReward(var_11_3, var_11_0, self.isReplaceSticker_)
		else
			self:ShowReward(var_11_3, var_11_0)
		end
	else
		self:GotoResult()
	end
end

function ActivitySkinDrawRewardView:ShowAni(arg_12_1, arg_12_2, arg_12_3)
	SetActive(self.skipBtn_, false)

	self.nextBtn_.interactable = false

	manager.audio:PlayEffect("ui_system_search", "search_scene_musicdown", "")

	self.typeItem_.movie = self.typeItem_.movie or ActivitySkinDrawMovieView.New((Object.Instantiate(Asset.Load(self.typeGo_[5]), self.content_)))

	self.typeItem_.movie:SetData(arg_12_2, function()
		print("测试回放")
		SetActive(self.skipBtn_, true)

		self.nextBtn_.interactable = true

		manager.audio:PlayEffect("ui_system_search", "search_scene_musicup", "")
		self:ShowReward(arg_12_1, arg_12_2, arg_12_3)
	end)
end

function ActivitySkinDrawRewardView:ShowReward(arg_14_1, arg_14_2, arg_14_3)
	self.typeItem_[arg_14_1] = self.typeItem_[arg_14_1] or ActivitySkinDrawShowView.New((Object.Instantiate(Asset.Load(self.typeGo_[arg_14_1]), self.content_)))

	self.typeItem_[arg_14_1]:SetData(arg_14_2)

	self.curItem_ = self.typeItem_[arg_14_1]

	manager.audio:StopEffect()
	manager.audio:PlayEffect("ui_system_search", self.soundEffect_[arg_14_1], "")

	if arg_14_3 and ItemCfg[ActivityLimitedDrawPoolCfg[arg_14_2].reward[1][1]].num_exchange_item then
		if ItemCfg[ActivityLimitedDrawPoolCfg[arg_14_2].reward[1][1]].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER and not table.indexof(self.replaceList_, arg_14_2) then
			return
		end

		local var_14_0 = ItemCfg[ActivityLimitedDrawPoolCfg[arg_14_2].reward[1][1]].num_exchange_item[1]

		self.tipText_.text = "x" .. GetI18NText(ItemCfg[ActivityLimitedDrawPoolCfg[arg_14_2].reward[1][1]].num_exchange_item[1][2])
		self.tipIcon_.sprite = ItemTools.getItemSprite(var_14_0[1])
		self.nameText_.text = ItemTools.getItemName(var_14_0[1])

		SetActive(self.tipGo_, true)
	end
end

function ActivitySkinDrawRewardView:GotoResult()
	if #self.list_ > 1 then
		JumpTools.OpenPageByJump("/activitySkinResultReward", {
			showList = self.showList_,
			list = self.list_,
			replaceList = self.replaceList_,
			activityID = self.params_.poolActivityID,
			mainActivityID = self.params_.mainActivityID
		})
	else
		JumpTools.OpenPageByJump("/activityskinDraw", {
			activityID = self.params_.mainActivityID,
			isSceneDrawed = self.isScene_,
			sceneDrawedId = self.sceneId_
		})
	end
end

function ActivitySkinDrawRewardView:OnTop()
	manager.windowBar:HideBar()
end

function ActivitySkinDrawRewardView:OnExit()
	SetActive(self.skipBtn_, true)

	self.nextBtn_.interactable = true
	self.isScene_ = false
	self.sceneId_ = 0

	if self.curItem_ then
		self.curItem_:Hide()

		self.curItem_ = nil
	end

	for iter_17_0, iter_17_1 in pairs(self.typeItem_) do
		iter_17_1:OnExit()
	end

	manager.audio:StopEffect()
end

function ActivitySkinDrawRewardView:Dispose()
	self:RemoveAllListeners()

	for iter_18_0, iter_18_1 in pairs(self.typeItem_) do
		iter_18_1:Dispose()
	end

	self.super.Dispose(self)
end

return ActivitySkinDrawRewardView
