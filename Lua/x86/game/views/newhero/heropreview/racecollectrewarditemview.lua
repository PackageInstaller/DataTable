local var_0_0 = class("RaceCollectRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.taskItems_ = {}
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.raceId_ = arg_6_2
	arg_6_0.raceCfg_ = RaceEffectCfg[arg_6_0.raceId_]

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.nameLabel.text = GetI18NText(arg_7_0.raceCfg_.name)
	arg_7_0.raceIcon_.sprite = getSprite("Atlas/CampItemAtlas", arg_7_0.raceCfg_.icon)

	for iter_7_0 = 1, HeroRaceCollectData.GetHeroCollectoMaxTier(arg_7_0.raceId_) do
		if arg_7_0.taskItems_[iter_7_0] == nil then
			arg_7_0.taskItems_[iter_7_0] = RaceCollectRewardConditionItemView.New(arg_7_0.itemGo_, arg_7_0.itemParent_)
		end

		arg_7_0.taskItems_[iter_7_0]:SetData(iter_7_0, arg_7_0.raceId_)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:AddEventListeners()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.data_ = nil

	for iter_11_0, iter_11_1 in pairs(arg_11_0.taskItems_) do
		iter_11_1:Dispose()
	end

	arg_11_0.taskItems_ = {}

	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

return var_0_0
