local var_0_0 = class("CoreVerificationChallengeTeamCheckView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_verification_DetailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.roleList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.roleListGo_, CoreVerificationChallengeTeamInfoItem)
	arg_3_0.affixList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem1), arg_3_0.affixListGo_, CoreVerificationChallengeRankAffixItem)

	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.list[1].hero_list[arg_7_1], arg_7_1)
end

function var_0_0.IndexItem1(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.list[1].affix_list[arg_8_1], arg_8_1)
end

local function var_0_1(arg_9_0)
	return
end

local function var_0_2(arg_10_0, arg_10_1)
	local var_10_0 = {}

	print("ProcessData", arg_10_1)

	if arg_10_0 then
		local var_10_1 = 1
		local var_10_2 = {}

		for iter_10_0, iter_10_1 in pairs(arg_10_0.stage_team_list) do
			var_10_2[var_10_1] = {}

			for iter_10_2, iter_10_3 in pairs(iter_10_1[1]) do
				if iter_10_3.hero_id then
					table.insert(var_10_2[var_10_1], iter_10_3.hero_id)
				end
			end

			var_10_1 = var_10_1 + 1
		end

		local var_10_3 = {}

		if arg_10_0.extraInfo then
			if arg_10_1 == 1 then
				for iter_10_4 = 1, #arg_10_0.extraInfo, 2 do
					local var_10_4 = {
						id = arg_10_0.extraInfo[iter_10_4],
						lv = arg_10_0.extraInfo[iter_10_4 + 1]
					}

					table.insert(var_10_3, var_10_4)
				end
			elseif arg_10_1 == 2 then
				for iter_10_5 = 1, #arg_10_0.extraInfo do
					local var_10_5 = 0

					for iter_10_6, iter_10_7 in ipairs(CoreVerificationClMode2Cfg.get_id_list_by_stage_type[2]) do
						for iter_10_8, iter_10_9 in ipairs(CoreVerificationClMode2Cfg[iter_10_7].stage_affix_debuff) do
							if iter_10_9 == arg_10_0.extraInfo[iter_10_5] then
								var_10_5 = 0

								break
							else
								var_10_5 = -1
							end
						end
					end

					local var_10_6 = {
						id = arg_10_0.extraInfo[iter_10_5],
						lv = var_10_5
					}

					table.insert(var_10_3, var_10_6)
				end
			end
		end

		var_10_0[1] = {
			hero_list = var_10_2[1],
			affix_list = var_10_3
		}
	end

	return var_10_0
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.coreVerificationModeIndex = arg_11_0.params_.coreVerificationModeIndex or CoreVerificationChallengeTools.GetModeIndex()

	if arg_11_0.params_.notCoreCl then
		arg_11_0.list = arg_11_0.params_.dataList or {}
	else
		arg_11_0.list = var_0_2(arg_11_0.params_.data, arg_11_0.coreVerificationModeIndex)
	end

	arg_11_0.roleList_:StartScroll(#arg_11_0.list[1].hero_list)

	if arg_11_0.list[1].affix_list and #arg_11_0.list[1].affix_list > 0 then
		arg_11_0.affixList_:StartScroll(#arg_11_0.list[1].affix_list)
	else
		arg_11_0.affixList_:StartScroll(0)
	end
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)

	if arg_13_0.roleList_ then
		arg_13_0.roleList_:Dispose()

		arg_13_0.roleList_ = nil
	end

	if arg_13_0.affixList_ then
		arg_13_0.affixList_:Dispose()

		arg_13_0.affixList_ = nil
	end
end

return var_0_0
