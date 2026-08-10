local var_0_0 = class("NewHeroArchiveStoryItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockController_ = ControllerUtil.GetController(arg_3_0.transform_, "btn")

	arg_3_0:AddUIListener()
	arg_3_0:RegistEventListener(UPDATE_ANDOTE, function()
		arg_3_0:RefreshUI()
	end)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if not arg_5_0.isUnlock then
			local var_6_0 = GetI18NText(HeroCfg[arg_5_0.data_.id].name)
			local var_6_1 = GetTips("HERO_TRUST_LEVEL_DES_" .. arg_5_0.all)

			ShowTips(string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), var_6_0, var_6_1))
		else
			if not arg_5_0.isViewed then
				arg_5_0.callBackHandler = handler(arg_5_0, function()
					arg_5_0:RefreshUI()
				end)
			end

			JumpTools.GoToSystem("newHeroStory", {
				data = arg_5_0.data_,
				callback = arg_5_0.callBackHandler,
				archiveID = arg_5_0.archiveID_
			})
		end

		manager.redPoint:setTip(RedPointConst.HERO_ANEDOTE_ID .. arg_5_0.data_.id, 0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.heroPieceBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			tonumber("1" .. arg_5_0.data_.id)
		})
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.data_ = arg_9_1
	arg_9_0.archiveID_ = arg_9_2

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = HeroCfg[arg_10_0.data_.id]

	arg_10_0.title_.text = string.format(GetTips("HERO_ANECDOTE_TITLE"), GetI18NText(var_10_0.name))
	arg_10_0.rewardText_.text = "x" .. arg_10_0.data_.reward[1][2]
	arg_10_0.rewardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Piece/" .. arg_10_0.data_.id)

	local var_10_1 = GameSetting.hero_anecdote_unlock_condition.value[1]
	local var_10_2
	local var_10_3
	local var_10_4, var_10_5

	arg_10_0.isUnlock, var_10_4, var_10_5 = IsConditionAchieved(var_10_1, {
		heroId = arg_10_0.data_.id
	})
	arg_10_0.all = var_10_5
	arg_10_0.isViewed = ArchiveData:IsArchiveStoryRead(arg_10_0.archiveID_, arg_10_0.data_.id)

	if arg_10_0.isUnlock then
		arg_10_0.lockController_:SetSelectedState("yes")

		if arg_10_0.isViewed then
			arg_10_0.lockController_:SetSelectedState("get")
		end
	else
		local var_10_6 = GetTips("HERO_TRUST_LEVEL_DES_" .. arg_10_0.all)

		arg_10_0.lockText_.text = string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), GetI18NText(var_10_0.name), var_10_6)

		arg_10_0.lockController_:SetSelectedState("no")
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
