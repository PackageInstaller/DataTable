local CooperationSelectHeroView = class("CooperationSelectHeroView", (import("game.views.sectionSelectHero.SelectHeroBaseView")))

function CooperationSelectHeroView:InitCallback()
	CooperationSelectHeroView.super.InitCallback(self)

	self.battleStartHandler_ = handler(self, self.BattleStart)
end

function CooperationSelectHeroView:AddEventListener()
	CooperationSelectHeroView.super.AddEventListener(self)
	self:RegistEventListener(START_COOPERATION_BATTLE, self.battleStartHandler_)
end

function CooperationSelectHeroView:BattleStart()
	for iter_3_0, iter_3_1 in ipairs(self.heroInfoItemList_) do
		iter_3_1:BattleStart()
	end
end

function CooperationSelectHeroView:Refresh()
	self.roomData_ = self.sectionProxy_:GetRoomData()
	self.playerIdList_ = self.sectionProxy_:GetPlayerIDList()

	CooperationSelectHeroView.super.Refresh(self)
end

function CooperationSelectHeroView:LoadHeroModels()
	self:LoadHeroModelsInOrder(1)
end

function CooperationSelectHeroView:LoadHeroModelsInOrder(arg_6_1)
	if arg_6_1 > 3 then
		for iter_6_0, iter_6_1 in pairs(self.heroModel_) do
			if iter_6_1 then
				SetActive(iter_6_1.model, true)
			end
		end

		return
	end

	local var_6_0

	if self.playerIdList_[arg_6_1] then
		local var_6_1 = self.roomData_:GetRoomPlayerData(self.playerIdList_[arg_6_1]).heroList[1]

		var_6_0 = var_6_1.skin == 0 and var_6_1.id or var_6_1.skin
	end

	if self.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(self.loadAsyncIndex)
	end

	if self.heroModel_[arg_6_1] then
		if var_6_0 == self.heroModel_[arg_6_1].id then
			self.heroModel_[arg_6_1].model.transform.localEulerAngles = SectionSelectHeroConst.HeroModelTransform[arg_6_1].rotation
			self.heroModel_[arg_6_1].model.transform.localPosition = SectionSelectHeroConst.HeroModelTransform[arg_6_1].position
			self.heroModel_[arg_6_1].model.transform.localScale = SectionSelectHeroConst.HeroModelTransform[arg_6_1].scale

			self:LoadHeroModelsInOrder(arg_6_1 + 1)

			return
		else
			manager.resourcePool:DestroyOrReturn(self.heroModel_[arg_6_1].model, ASSET_TYPE.TPOSE)

			self.heroModel_[arg_6_1] = nil
		end
	end

	if var_6_0 then
		self.loadAsyncIndex = manager.resourcePool:AsyncLoad("Char/" .. SkinCfg[var_6_0].ui_modelId, ASSET_TYPE.TPOSE, function(arg_7_0)
			self.heroModel_[arg_6_1] = {
				model = arg_7_0,
				id = var_6_0
			}
			arg_7_0.transform.localEulerAngles = SectionSelectHeroConst.HeroModelTransform[arg_6_1].rotation
			arg_7_0.transform.localPosition = SectionSelectHeroConst.HeroModelTransform[arg_6_1].position
			arg_7_0.transform.localScale = SectionSelectHeroConst.HeroModelTransform[arg_6_1].scale

			SetActive(arg_7_0, false)
			TimeTools.StartAfterSeconds(0.0333, function()
				self:LoadHeroModelsInOrder(arg_6_1 + 1)
			end, {})
		end)
	else
		self:LoadHeroModelsInOrder(arg_6_1 + 1)
	end
end

function CooperationSelectHeroView:DestroyHeroModels()
	if self.heroModel_ then
		for iter_9_0, iter_9_1 in pairs(self.heroModel_) do
			manager.resourcePool:DestroyOrReturn(iter_9_1.model, ASSET_TYPE.TPOSE)
		end
	end

	if self.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(self.loadAsyncIndex)
	end

	self.loadAsyncIndex = nil
	self.heroModel_ = {}
end

function CooperationSelectHeroView:RrocessClickHero(arg_10_1)
	manager.notify:CallUpdateFunc(SECTION_CLICK_HERO, arg_10_1, self.playerIdList_[arg_10_1])
end

function CooperationSelectHeroView:RefreshHeroInfoItem()
	for iter_11_0 = 1, 3 do
		self.heroInfoItemList_[iter_11_0]:Refresh(iter_11_0, self.playerIdList_[iter_11_0])
	end
end

function CooperationSelectHeroView:OnFriendsListChange()
	for iter_12_0 = 1, 3 do
		self.heroInfoItemList_[iter_12_0]:Refresh(iter_12_0, self.playerIdList_[iter_12_0])
	end
end

return CooperationSelectHeroView
