local var_0_0 = class("GuildBossDifficultyItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.indexController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "index")
	arg_3_0.currentController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "current")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.chooseBtn_, nil, function()
		local var_5_0, var_5_1 = GuildData:GetLastTime()

		if var_5_0 ~= "prepose" then
			ShowTips("CLUB_BOSS_DIFFICULTY_EXPIRED_TIP")

			return
		end

		GuildAction.GuildBossChangeDifficulty(arg_4_0.cfg_.boss_level)
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index_ = arg_7_1
	arg_7_0.data_ = arg_7_2
	arg_7_0.cfg_ = ClubBossCfg[arg_7_2]
	arg_7_0.rewardDataList_ = arg_7_0.cfg_.preview_reward

	if not arg_7_0.uiList_ then
		arg_7_0.uiList_ = {}

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.rewardDataList_) do
			local var_7_0 = GameObject.Instantiate(arg_7_0.commonGo, arg_7_0.contentTrs)

			arg_7_0.uiList_[iter_7_0] = CommonItemView.New(var_7_0)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.contentTrs)
	end

	arg_7_0:UpdateView()
end

local var_0_1 = {
	"CLUB_BOSS_DIFFICULTY_1",
	"CLUB_BOSS_DIFFICULTY_2",
	"CLUB_BOSS_DIFFICULTY_3",
	"CLUB_BOSS_DIFFICULTY_4"
}
local var_0_2 = {
	"CLUB_BOSS_TIPS_1",
	"CLUB_BOSS_TIPS_2",
	"CLUB_BOSS_TIPS_3",
	"CLUB_BOSS_TIPS_4"
}

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.indexController_:SetSelectedIndex(arg_8_0.index_)

	arg_8_0.conditionLabel_.text = ""

	if arg_8_0.index_ > 1 then
		arg_8_0.conditionLabel_.text = GetTips(var_0_2[arg_8_0.index_ - 1])
	end

	arg_8_0.difficult_.text = GetTips(var_0_1[arg_8_0.index_])
	arg_8_0.bloodLabel_.text = arg_8_0.cfg_.boss_hp

	if arg_8_0.uiList_ then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.uiList_) do
			iter_8_1:SetData({
				id = arg_8_0.rewardDataList_[iter_8_0][1],
				number = arg_8_0.rewardDataList_[iter_8_0][2],
				clickFun = function(arg_9_0)
					ShowPopItem(POP_ITEM, {
						arg_9_0.id
					})
				end
			})
		end
	end

	if not GuildData:IsPassBossDifficulty(arg_8_0.index_) then
		arg_8_0.currentController_:SetSelectedState("locked")
	elseif GuildData:GetBossDifficulty() == arg_8_0.index_ then
		arg_8_0.currentController_:SetSelectedState("true")
	else
		arg_8_0.currentController_:SetSelectedState("false")
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.data_ = nil

	if arg_13_0.uiList_ then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.uiList_) do
			iter_13_1:Dispose()
		end

		arg_13_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
