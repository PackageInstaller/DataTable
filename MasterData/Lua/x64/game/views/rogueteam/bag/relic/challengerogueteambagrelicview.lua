ChallengeRogueTeamRelicPanelBaseView = import("game.views.rogueTeam.bag.relic.base.ChallengeRogueTeamRelicPanelBaseView")

local ChallengeRogueTeamBagRelicView = class("ChallengeRogueTeamBagRelicView", ChallengeRogueTeamRelicPanelBaseView)

function ChallengeRogueTeamBagRelicView:InitCustomUI()
	self.hasRelicController_ = self.controllerEx_:GetController("hasRelic")
end

function ChallengeRogueTeamBagRelicView:GetAllRelicData()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC)) do
		var_2_0[RogueTeamItemCfg[iter_2_1.id].sub_type] = var_2_0[RogueTeamItemCfg[iter_2_1.id].sub_type] or {}

		table.insert(var_2_0[RogueTeamItemCfg[iter_2_1.id].sub_type], iter_2_1.id)
	end

	return var_2_0
end

function ChallengeRogueTeamBagRelicView:ShowItemInfo(arg_3_1)
	if not arg_3_1 then
		SetActive(self.infoGo_, false)
	else
		local var_3_0 = RogueTeamItemCfg[arg_3_1]

		SetActive(self.infoGo_, true)

		self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_3_1))
		self.relicName_.text = GetI18NText(var_3_0.name)
		self.itemDesc_.text = ChallengeRogueTeamTools.GetItemEffectDesc(arg_3_1)
		self.effectDesc_.text = GetI18NText(var_3_0.story_desc)
		self.effectData = ChallengeRogueTeamData:GetEffectDataByEffectID(var_3_0.show_effect[1])

		SetActive(self.leftTimesGo_, self.effectData.leftTime and self.effectData.leftTime ~= 9999)

		self.leftTimeText_.text = self.effectData.leftTime

		SetActive(self.triggerCDGo_, self.effectData.triggerCd and self.effectData.triggerCd ~= 0)

		self.triggerCDText_.text = self.effectData.triggerCd
	end

	for iter_3_0, iter_3_1 in ipairs(self.loopScrollView_:GetItemList()) do
		iter_3_1.itemView:SetSelectID(arg_3_1)
	end
end

function ChallengeRogueTeamBagRelicView:RefreshUI()
	local var_4_0 = math.floor(self.contentTf_.rect.width / self.itemTf_.rect.width)

	self.uiDataList_ = {}

	for iter_4_0, iter_4_1 in pairs((self:GetAllRelicData())) do
		table.insert(self.uiDataList_, {
			objectType = ChallengeRogueTeamBagRelicView.OBJECT_TYPE.TITLE,
			data = iter_4_0
		})

		local var_4_1 = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			local var_4_2 = math.floor((iter_4_2 - 1) / var_4_0) + 1

			var_4_1[var_4_2] = var_4_1[var_4_2] or {}

			table.insert(var_4_1[var_4_2], iter_4_3)
		end

		for iter_4_4, iter_4_5 in ipairs(var_4_1) do
			table.insert(self.uiDataList_, {
				objectType = ChallengeRogueTeamBagRelicView.OBJECT_TYPE.ITEM,
				data = iter_4_5
			})
		end
	end

	if table.length(self.uiDataList_) <= 0 then
		self.hasRelicController_:SetSelectedState("false")

		self.selectRelicID_ = nil
	else
		self.hasRelicController_:SetSelectedState("true")
		self.loopScrollView_:NavigateIndex(1)

		for iter_4_6, iter_4_7 in pairs(self.uiDataList_) do
			if iter_4_7.objectType == ChallengeRogueTeamBagRelicView.OBJECT_TYPE.ITEM then
				self.selectRelicID_ = iter_4_7.data[1]

				break
			end
		end
	end

	self:OnSelectRelic(self.selectRelicID_)
end

return ChallengeRogueTeamBagRelicView
