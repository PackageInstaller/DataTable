local ChallengeRogueTeamIllustratedMechanismView = class("ChallengeRogueTeamIllustratedMechanismView", ReduxView)

function ChallengeRogueTeamIllustratedMechanismView:UIName()
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedMechanismUI"
end

function ChallengeRogueTeamIllustratedMechanismView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamIllustratedMechanismView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = self.controller_:GetController("lock")
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.itemList_, ChallengeRogueTeamIllustratedMechanismItem)
end

function ChallengeRogueTeamIllustratedMechanismView:OnEnter(arg_4_1)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.templateID_ = self.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	self.itemTemplate_ = RogueTeamCfg[self.templateID_].item_temp

	self:RefreshUI()
	self:ShowItemInfo(self.dataList_[1])

	for iter_4_0, iter_4_1 in ipairs(self.list_:GetItemList()) do
		iter_4_1:RefreshSelect(self.dataList_[1])
	end
end

function ChallengeRogueTeamIllustratedMechanismView:RefreshUI()
	self.dataList_ = ChallengeRogueTeamData:GetAllItemIDByTempAndType(self.itemTemplate_, ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM)
	self.unlockList_ = ChallengeRogueTeamData:GetIllustratedDataByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.SEASON)

	table.sort(self.dataList_, function(arg_6_0, arg_6_1)
		if self.unlockList_[arg_6_0] and not self.unlockList_[arg_6_1] then
			return arg_6_0
		elseif self.unlockList_[arg_6_1] and self.unlockList_[arg_6_1] then
			return arg_6_1
		else
			return arg_6_0 < arg_6_1
		end
	end)
	self.list_:StartScroll(#self.dataList_)

	self.taskProgressText_.text = #self.unlockList_ .. "/" .. #self.dataList_
end

function ChallengeRogueTeamIllustratedMechanismView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, self.dataList_[arg_7_1])
	arg_7_2:SetClickCallBack(function(arg_8_0)
		self:ShowItemInfo(arg_8_0)

		for iter_8_0, iter_8_1 in ipairs(self.list_:GetItemList()) do
			iter_8_1:RefreshSelect(arg_8_0)
		end
	end)
end

function ChallengeRogueTeamIllustratedMechanismView:ShowItemInfo(arg_9_1)
	if not arg_9_1 then
		SetActive(self.infoGo_, false)
	else
		local var_9_0 = RogueTeamItemCfg[arg_9_1]

		SetActive(self.infoGo_, true)

		self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_9_1))
		self.text_.text = var_9_0.name
		self.itemDesc_.text = var_9_0.desc
		self.effectDesc_.text = var_9_0.story_desc

		local var_9_1 = not ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.SEASON, arg_9_1)

		if var_9_1 then
			self.text_.text = "???"
		end

		self.lockController_:SetSelectedState(tostring(var_9_1))
	end
end

function ChallengeRogueTeamIllustratedMechanismView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
end

function ChallengeRogueTeamIllustratedMechanismView:Dispose()
	ChallengeRogueTeamIllustratedMechanismView.super.Dispose(self)
	self.list_:Dispose()

	self.list_ = nil
end

function ChallengeRogueTeamIllustratedMechanismView:AddListeners()
	return
end

return ChallengeRogueTeamIllustratedMechanismView
