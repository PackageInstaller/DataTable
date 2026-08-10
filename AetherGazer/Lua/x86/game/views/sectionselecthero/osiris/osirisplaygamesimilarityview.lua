local var_0_0 = class("OsirisPlayGameSimilarityView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Show(true)
	arg_1_0:Init()
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.heroItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.heroItemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitController()
	arg_4_0:InitCallback()

	arg_4_0.heroItemList_ = {}
end

function var_0_0.InitController(arg_5_0)
	return
end

function var_0_0.InitCallback(arg_6_0)
	return
end

function var_0_0.AddListener(arg_7_0)
	return
end

function var_0_0.SetProxy(arg_8_0, arg_8_1)
	arg_8_0.sectionProxy_ = arg_8_1
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:AddEventListener()
end

function var_0_0.AddEventListener(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.Refresh(arg_12_0)
	local var_12_0 = arg_12_0.sectionProxy_.heroInfoList
	local var_12_1 = arg_12_0.sectionProxy_.stageID
	local var_12_2 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[var_12_1][1]
	local var_12_3 = ActivityGeneralityStageCfg[var_12_2].generality

	arg_12_0.skillIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_12_3)
	arg_12_0.descText_.text = GetI18NText(ActivityGeneralityTagCfg[var_12_3].desc)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_4 = iter_12_1.heroID
		local var_12_5 = 0

		if var_12_4 and var_12_4 > 0 then
			local var_12_6 = HeroData:GetHeroData(var_12_4)

			var_12_5 = var_12_6.using_skin > 0 and var_12_6.using_skin or var_12_4
		end

		if not arg_12_0.heroItemList_[iter_12_0] then
			local var_12_7 = Object.Instantiate(arg_12_0.itemgGo_, arg_12_0.contentTrs_)

			arg_12_0.heroItemList_[iter_12_0] = SectionSmallHeroItem.New(var_12_7)
		end

		arg_12_0.heroItemList_[iter_12_0]:SetData(var_12_5)

		if var_12_4 and var_12_4 ~= 0 then
			local var_12_8 = arg_12_0:GetValid(var_12_4, var_12_3)

			arg_12_0.heroItemList_[iter_12_0]:RefreshValid(var_12_8)
		else
			arg_12_0.heroItemList_[iter_12_0]:RefreshValid(true)
		end
	end

	for iter_12_2 = #var_12_0 + 1, 3 do
		if arg_12_0.heroItemList_[iter_12_2] then
			arg_12_0.heroItemList_[iter_12_2]:Show(false)
		end
	end
end

function var_0_0.GetValid(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ActivityGeneralityCharactorCfg[arg_13_1].generality

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if arg_13_2 == iter_13_1 then
			return true
		end
	end

	return false
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

return var_0_0
