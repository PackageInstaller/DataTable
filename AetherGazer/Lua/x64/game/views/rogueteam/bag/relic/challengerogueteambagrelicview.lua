ChallengeRogueTeamRelicPanelBaseView = import("game.views.rogueTeam.bag.relic.base.ChallengeRogueTeamRelicPanelBaseView")

local var_0_0 = class("ChallengeRogueTeamBagRelicView", ChallengeRogueTeamRelicPanelBaseView)

function var_0_0.InitCustomUI(arg_1_0)
	arg_1_0.hasRelicController_ = arg_1_0.controllerEx_:GetController("hasRelic")
end

function var_0_0.GetAllRelicData(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC)) do
		local var_2_1 = RogueTeamItemCfg[iter_2_1.id].sub_type

		if not var_2_0[var_2_1] then
			var_2_0[var_2_1] = {}
		end

		table.insert(var_2_0[var_2_1], iter_2_1.id)
	end

	return var_2_0
end

function var_0_0.ShowItemInfo(arg_3_0, arg_3_1)
	if not arg_3_1 then
		SetActive(arg_3_0.infoGo_, false)
	else
		local var_3_0 = RogueTeamItemCfg[arg_3_1]

		SetActive(arg_3_0.infoGo_, true)

		arg_3_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_3_1))
		arg_3_0.relicName_.text = GetI18NText(var_3_0.name)
		arg_3_0.itemDesc_.text = ChallengeRogueTeamTools.GetItemEffectDesc(arg_3_1)
		arg_3_0.effectDesc_.text = GetI18NText(var_3_0.story_desc)
		arg_3_0.effectData = ChallengeRogueTeamData:GetEffectDataByEffectID(var_3_0.show_effect[1])

		SetActive(arg_3_0.leftTimesGo_, arg_3_0.effectData.leftTime and arg_3_0.effectData.leftTime ~= 9999)

		arg_3_0.leftTimeText_.text = arg_3_0.effectData.leftTime

		SetActive(arg_3_0.triggerCDGo_, arg_3_0.effectData.triggerCd and arg_3_0.effectData.triggerCd ~= 0)

		arg_3_0.triggerCDText_.text = arg_3_0.effectData.triggerCd
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.loopScrollView_:GetItemList()) do
		iter_3_1.itemView:SetSelectID(arg_3_1)
	end
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = arg_4_0.contentTf_.rect.width
	local var_4_1 = arg_4_0.itemTf_.rect.width
	local var_4_2 = math.floor(var_4_0 / var_4_1)

	arg_4_0.uiDataList_ = {}

	local var_4_3 = arg_4_0:GetAllRelicData()

	for iter_4_0, iter_4_1 in pairs(var_4_3) do
		table.insert(arg_4_0.uiDataList_, {
			objectType = var_0_0.OBJECT_TYPE.TITLE,
			data = iter_4_0
		})

		local var_4_4 = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			local var_4_5 = math.floor((iter_4_2 - 1) / var_4_2) + 1

			var_4_4[var_4_5] = var_4_4[var_4_5] or {}

			table.insert(var_4_4[var_4_5], iter_4_3)
		end

		for iter_4_4, iter_4_5 in ipairs(var_4_4) do
			table.insert(arg_4_0.uiDataList_, {
				objectType = var_0_0.OBJECT_TYPE.ITEM,
				data = iter_4_5
			})
		end
	end

	if table.length(arg_4_0.uiDataList_) <= 0 then
		arg_4_0.hasRelicController_:SetSelectedState("false")

		arg_4_0.selectRelicID_ = nil
	else
		arg_4_0.hasRelicController_:SetSelectedState("true")
		arg_4_0.loopScrollView_:NavigateIndex(1)

		for iter_4_6, iter_4_7 in pairs(arg_4_0.uiDataList_) do
			if iter_4_7.objectType == var_0_0.OBJECT_TYPE.ITEM then
				arg_4_0.selectRelicID_ = iter_4_7.data[1]

				break
			end
		end
	end

	arg_4_0:OnSelectRelic(arg_4_0.selectRelicID_)
end

return var_0_0
