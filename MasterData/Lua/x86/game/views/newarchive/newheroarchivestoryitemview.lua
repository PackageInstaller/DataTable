local NewHeroArchiveStoryItemView = class("NewHeroArchiveStoryItemView", ReduxView)

function NewHeroArchiveStoryItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function NewHeroArchiveStoryItemView:Init()
	self:InitUI()
end

function NewHeroArchiveStoryItemView:InitUI()
	self:BindCfgUI()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "btn")

	self:AddUIListener()
	self:RegistEventListener(UPDATE_ANDOTE, function()
		self:RefreshUI()
	end)
end

function NewHeroArchiveStoryItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.isUnlock then
			ShowTips(string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), GetI18NText(HeroCfg[self.data_.id].name), (GetTips("HERO_TRUST_LEVEL_DES_" .. self.all))))
		else
			if not self.isViewed then
				self.callBackHandler = handler(self, function()
					self:RefreshUI()
				end)
			end

			JumpTools.GoToSystem("newHeroStory", {
				data = self.data_,
				callback = self.callBackHandler,
				archiveID = self.archiveID_
			})
		end

		manager.redPoint:setTip(RedPointConst.HERO_ANEDOTE_ID .. self.data_.id, 0)
	end)
	self:AddBtnListener(self.heroPieceBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			tonumber("1" .. self.data_.id)
		})
	end)
end

function NewHeroArchiveStoryItemView:SetData(arg_9_1, arg_9_2)
	self.data_ = arg_9_1
	self.archiveID_ = arg_9_2

	self:RefreshUI()
end

function NewHeroArchiveStoryItemView:RefreshUI()
	self.title_.text = string.format(GetTips("HERO_ANECDOTE_TITLE"), GetI18NText(HeroCfg[self.data_.id].name))
	self.rewardText_.text = "x" .. self.data_.reward[1][2]
	self.rewardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Piece/" .. self.data_.id)

	local var_10_1, var_10_2

	self.isUnlock, var_10_1, var_10_2 = IsConditionAchieved(GameSetting.hero_anecdote_unlock_condition.value[1], {
		heroId = self.data_.id
	})
	self.all = nil
	self.isViewed = ArchiveData:IsArchiveStoryRead(self.archiveID_, self.data_.id)

	if self.isUnlock then
		self.lockController_:SetSelectedState("yes")

		if self.isViewed then
			self.lockController_:SetSelectedState("get")
		end
	else
		self.lockText_.text = string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), GetI18NText(HeroCfg[self.data_.id].name), (GetTips("HERO_TRUST_LEVEL_DES_" .. self.all)))

		self.lockController_:SetSelectedState("no")
	end
end

function NewHeroArchiveStoryItemView:Dispose()
	self:RemoveAllEventListener()
	NewHeroArchiveStoryItemView.super.Dispose(self)
end

return NewHeroArchiveStoryItemView
