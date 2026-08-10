local var_0_0 = class("AbyssRankItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rankController_ = arg_3_0.conExCollection_:GetController("rank")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.viewBtn_, nil, function()
		local var_5_0 = {
			userId = arg_4_0.data_.user_id,
			layer = arg_4_0.data_.difficulty,
			stageInfos = {}
		}

		for iter_5_0, iter_5_1 in pairs(arg_4_0.data_.stage_team_list) do
			local var_5_1 = {
				stage_id = iter_5_0,
				heroList = {}
			}

			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				table.insertto(var_5_1.heroList, iter_5_3)
			end

			table.insert(var_5_0.stageInfos, var_5_1)
		end

		table.sort(var_5_0.stageInfos, function(arg_6_0, arg_6_1)
			return arg_6_0.stage_id < arg_6_1.stage_id
		end)
		JumpTools.OpenPageByJump("abyssTeamCheck", {
			layerInfo = var_5_0
		})
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	return
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index_ = arg_8_1
	arg_8_0.data_ = arg_8_2
	arg_8_0.isGuild_ = arg_8_3

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.commonPortrait_:RenderHead(arg_9_0.data_.portrait)
	arg_9_0.commonPortrait_:RenderFrame(arg_9_0.data_.frame)

	if arg_9_0.data_.rank < 4 then
		arg_9_0.rankController_:SetSelectedIndex(arg_9_0.data_.rank)
	else
		arg_9_0.rankController_:SetSelectedIndex(0)
	end

	arg_9_0.rankText_.text = GetI18NText(arg_9_0.data_.rank)
	arg_9_0.nickText_.text = GetI18NText(arg_9_0.data_.nick)
	arg_9_0.scoreText_.text = GetI18NText(arg_9_0.data_.score)
	arg_9_0.layerText_.text = GetI18NText(arg_9_0.data_.difficulty)
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
	arg_13_0.commonPortrait_:Dispose()

	arg_13_0.data_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
