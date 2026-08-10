local var_0_0 = import("game.views.sectionSelectHero.SelectHeroBaseView")
local var_0_1 = class("CooperationSelectHeroView", var_0_0)

function var_0_1.InitCallback(arg_1_0)
	var_0_1.super.InitCallback(arg_1_0)

	arg_1_0.battleStartHandler_ = handler(arg_1_0, arg_1_0.BattleStart)
end

function var_0_1.AddEventListener(arg_2_0)
	var_0_1.super.AddEventListener(arg_2_0)
	arg_2_0:RegistEventListener(START_COOPERATION_BATTLE, arg_2_0.battleStartHandler_)
end

function var_0_1.BattleStart(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.heroInfoItemList_) do
		iter_3_1:BattleStart()
	end
end

function var_0_1.Refresh(arg_4_0)
	arg_4_0.roomData_ = arg_4_0.sectionProxy_:GetRoomData()
	arg_4_0.playerIdList_ = arg_4_0.sectionProxy_:GetPlayerIDList()

	var_0_1.super.Refresh(arg_4_0)
end

function var_0_1.LoadHeroModels(arg_5_0)
	arg_5_0:LoadHeroModelsInOrder(1)
end

function var_0_1.LoadHeroModelsInOrder(arg_6_0, arg_6_1)
	if arg_6_1 > 3 then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.heroModel_) do
			if iter_6_1 then
				SetActive(iter_6_1.model, true)
			end
		end

		return
	end

	local var_6_0

	if arg_6_0.playerIdList_[arg_6_1] then
		local var_6_1 = arg_6_0.roomData_:GetRoomPlayerData(arg_6_0.playerIdList_[arg_6_1]).heroList[1]

		var_6_0 = var_6_1.skin == 0 and var_6_1.id or var_6_1.skin
	end

	if arg_6_0.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(arg_6_0.loadAsyncIndex)
	end

	if arg_6_0.heroModel_[arg_6_1] then
		if var_6_0 == arg_6_0.heroModel_[arg_6_1].id then
			local var_6_2 = arg_6_0.heroModel_[arg_6_1].model
			local var_6_3 = arg_6_1

			var_6_2.transform.localEulerAngles = SectionSelectHeroConst.HeroModelTransform[var_6_3].rotation
			var_6_2.transform.localPosition = SectionSelectHeroConst.HeroModelTransform[var_6_3].position
			var_6_2.transform.localScale = SectionSelectHeroConst.HeroModelTransform[var_6_3].scale

			arg_6_0:LoadHeroModelsInOrder(arg_6_1 + 1)

			return
		else
			manager.resourcePool:DestroyOrReturn(arg_6_0.heroModel_[arg_6_1].model, ASSET_TYPE.TPOSE)

			arg_6_0.heroModel_[arg_6_1] = nil
		end
	end

	if var_6_0 then
		local var_6_4 = SkinCfg[var_6_0]

		arg_6_0.loadAsyncIndex = manager.resourcePool:AsyncLoad("Char/" .. var_6_4.ui_modelId, ASSET_TYPE.TPOSE, function(arg_7_0)
			arg_6_0.heroModel_[arg_6_1] = {
				model = arg_7_0,
				id = var_6_0
			}

			local var_7_0 = arg_6_1

			arg_7_0.transform.localEulerAngles = SectionSelectHeroConst.HeroModelTransform[var_7_0].rotation
			arg_7_0.transform.localPosition = SectionSelectHeroConst.HeroModelTransform[var_7_0].position
			arg_7_0.transform.localScale = SectionSelectHeroConst.HeroModelTransform[var_7_0].scale

			SetActive(arg_7_0, false)
			TimeTools.StartAfterSeconds(0.0333, function()
				arg_6_0:LoadHeroModelsInOrder(arg_6_1 + 1)
			end, {})
		end)
	else
		arg_6_0:LoadHeroModelsInOrder(arg_6_1 + 1)
	end
end

function var_0_1.DestroyHeroModels(arg_9_0)
	if arg_9_0.heroModel_ then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.heroModel_) do
			manager.resourcePool:DestroyOrReturn(iter_9_1.model, ASSET_TYPE.TPOSE)
		end
	end

	if arg_9_0.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(arg_9_0.loadAsyncIndex)
	end

	arg_9_0.loadAsyncIndex = nil
	arg_9_0.heroModel_ = {}
end

function var_0_1.RrocessClickHero(arg_10_0, arg_10_1)
	manager.notify:CallUpdateFunc(SECTION_CLICK_HERO, arg_10_1, arg_10_0.playerIdList_[arg_10_1])
end

function var_0_1.RefreshHeroInfoItem(arg_11_0)
	for iter_11_0 = 1, 3 do
		arg_11_0.heroInfoItemList_[iter_11_0]:Refresh(iter_11_0, arg_11_0.playerIdList_[iter_11_0])
	end
end

function var_0_1.OnFriendsListChange(arg_12_0)
	for iter_12_0 = 1, 3 do
		arg_12_0.heroInfoItemList_[iter_12_0]:Refresh(iter_12_0, arg_12_0.playerIdList_[iter_12_0])
	end
end

return var_0_1
