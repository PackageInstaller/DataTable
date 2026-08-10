local var_0_0 = {
	[10002] = {
		[NewChessConst.TIMING_ALL] = function(arg_1_0, arg_1_1)
			local var_1_0 = manager.NewChessManager:GetExecutingChess()
			local var_1_1 = getRewardFromDropCfg(arg_1_1, true)

			getReward(var_1_1, nil, function()
				return manager.NewChessManager:DoNextEvent()
			end, true)
		end
	},
	[10004] = {
		[NewChessConst.TIMING_ALL] = function(arg_3_0, arg_3_1)
			local var_3_0 = manager.NewChessManager:GetExecutingChess()
			local var_3_1 = var_3_0.x
			local var_3_2 = var_3_0.z

			manager.NewChessManager:ChangeGridByExtentID(var_3_1, var_3_2, arg_3_1, false, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10005] = {
		[NewChessConst.TIMING_ALL] = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
			manager.NewChessManager:ChangeGridByExtentID(arg_5_1, arg_5_2, arg_5_3, false, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10006] = {
		[NewChessConst.TIMING_ALL] = function(arg_7_0, arg_7_1)
			NewWarChessAction.AddNewDice(arg_7_0)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10008] = {
		[NewChessConst.TIMING_ALL] = function(arg_8_0, arg_8_1)
			manager.NewChessManager:AddBuff(arg_8_1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10009] = {
		[NewChessConst.TIMING_START] = function(arg_9_0, arg_9_1)
			if NewWarChessData:AddNewHero(arg_9_1) then
				local var_9_0 = NewWarChessHeroCfg[arg_9_1]

				if var_9_0.effect_type == NewChessConst.HERO_EFFECT_TYPE.BUFF then
					if var_9_0.effect_id ~= 0 then
						manager.NewChessManager:AddBuff(var_9_0.effect_id)
					else
						print("lrq 当前英雄配置了效果类型没配置效果ID")
					end
				elseif var_9_0.effect_type == NewChessConst.HERO_EFFECT_TYPE.DICESKILL then
					if var_9_0.effect_id ~= 0 then
						NewWarChessData:AddNewSkill(var_9_0.effect_id)
						manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. var_9_0.effect_id, 1)
					else
						print("lrq 当前英雄配置了效果类型没配置效果ID")
					end
				end
			end

			return manager.NewChessManager:DoNextEvent()
		end,
		[NewChessConst.TIMING_ALL] = function(arg_10_0, arg_10_1)
			if NewWarChessData:AddNewHero(arg_10_1) then
				local var_10_0 = NewWarChessHeroCfg[arg_10_1]

				if var_10_0.effect_type == NewChessConst.HERO_EFFECT_TYPE.BUFF then
					if var_10_0.effect_id ~= 0 then
						manager.NewChessManager:AddBuff(var_10_0.effect_id)
					else
						print("lrq 当前英雄配置了效果类型没配置效果ID")
					end
				elseif var_10_0.effect_type == NewChessConst.HERO_EFFECT_TYPE.DICESKILL then
					if var_10_0.effect_id ~= 0 then
						NewWarChessData:AddNewSkill(var_10_0.effect_id)
						manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. var_10_0.effect_id, 1)
					else
						print("lrq 当前英雄配置了效果类型没配置效果ID")
					end
				end

				JumpTools.OpenPageByJump("newWarChessHeroPopView", {
					newChessHeroID = arg_10_1,
					callBack = function()
						return manager.NewChessManager:DoNextEvent()
					end
				})
			else
				return manager.NewChessManager:DoNextEvent()
			end
		end
	},
	[10010] = {
		[NewChessConst.TIMING_ALL] = function(arg_12_0, arg_12_1)
			NewWarChessData:AddNewSkill(arg_12_1)
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. arg_12_1, 1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10011] = {
		[NewChessConst.TIMING_ALL] = function(arg_13_0, arg_13_1)
			local var_13_0 = manager.NewChessManager:GetExecutingChess()
			local var_13_1 = var_13_0.x
			local var_13_2 = var_13_0.z

			manager.NewChessManager:ChangeObjectByExtentID(var_13_1, var_13_2, arg_13_1, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10012] = {
		[NewChessConst.TIMING_ALL] = function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
			manager.NewChessManager:ChangeObjectByExtentID(arg_15_1, arg_15_2, arg_15_3, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10013] = {
		[NewChessConst.TIMING_ALL] = function(arg_17_0)
			local var_17_0 = manager.NewChessManager:GetExecutingChess()
			local var_17_1 = var_17_0.x
			local var_17_2 = var_17_0.z

			manager.NewChessManager:DeleteObject(var_17_1, var_17_2, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10014] = {
		[NewChessConst.TIMING_ALL] = function(arg_19_0, arg_19_1, arg_19_2)
			manager.NewChessManager:DeleteObject(arg_19_1, arg_19_2, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10015] = {
		[NewChessConst.TIMING_ALL] = function(arg_21_0, arg_21_1)
			NewWarChessAction.AddNewDice(arg_21_1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10016] = {
		[NewChessConst.TIMING_ALL] = function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
			NewChessLuaBridge.OpenAreaFog(arg_22_1, arg_22_2, arg_22_3, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10017] = {
		[NewChessConst.TIMING_ALL] = function(arg_24_0, arg_24_1, arg_24_2)
			manager.NewChessManager:MoveToTarget(arg_24_1, arg_24_2, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10018] = {
		[NewChessConst.TIMING_ALL] = function(arg_26_0, arg_26_1)
			manager.NewChessManager.taskManager_:AddNewTask(arg_26_1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10019] = {
		[NewChessConst.TIMING_ALL] = function(arg_27_0, arg_27_1, arg_27_2)
			manager.NewChessManager.taskManager_:UpdateTask(arg_27_1, arg_27_2)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10020] = {
		[NewChessConst.TIMING_ALL] = function(arg_28_0, arg_28_1, arg_28_2)
			NewChessLuaBridge.LookAtPlayer()
			manager.NewChessManager:ClearInteractChess()
			NewChessLuaBridge.TelePortRoleToPosition(arg_28_1, arg_28_2, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10021] = {
		[NewChessConst.TIMING_ALL] = function(arg_30_0)
			NewWarChessData:AddAllSkillCount()

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10022] = {
		[NewChessConst.TIMING_ALL] = function(arg_31_0, arg_31_1)
			local var_31_0 = manager.NewChessManager:GetExecutingChess()
			local var_31_1 = var_31_0.x
			local var_31_2 = var_31_0.z

			NewChessLuaBridge.OpenAreaFog(var_31_1, var_31_2, arg_31_1, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10023] = {
		[NewChessConst.TIMING_ALL] = function(arg_33_0, arg_33_1)
			if arg_33_0[1] and arg_33_0[1] == 1 then
				local var_33_0 = manager.NewChessManager:GetExecutingChess()
				local var_33_1 = var_33_0.x
				local var_33_2 = var_33_0.z
				local var_33_3 = false

				if arg_33_1 == 1 then
					var_33_3 = true
				end

				manager.NewChessManager:ShowBlock()
				manager.NewChessManager:ClearInteractChess()
				NewChessLuaBridge.MoveConveyor(var_33_1, var_33_2, var_33_3, function()
					manager.NewChessManager:CloseBlock()

					return manager.NewChessManager:DoNextEvent()
				end)
			else
				return manager.NewChessManager:DoNextEvent()
			end
		end
	},
	[10024] = {
		[NewChessConst.TIMING_ALL] = function(arg_35_0, arg_35_1)
			local var_35_0 = manager.NewChessManager:GetExecutingChess()
			local var_35_1 = var_35_0.x
			local var_35_2 = var_35_0.z

			manager.NewChessManager:ClearInteractChess()
			manager.NewChessManager:JumpBoard(var_35_1, var_35_2, arg_35_1, arg_35_0[1], function()
				manager.NewChessManager:CloseBlock()

				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10026] = {
		[NewChessConst.TIMING_ALL] = function(arg_37_0, arg_37_1, arg_37_2)
			NewWarChessData:SubAttribute(arg_37_1, arg_37_2)

			if arg_37_1 == NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.id and arg_37_2 > 0 and manager.NewChessManager then
				local var_37_0 = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_MOVEPOINT"), arg_37_2)
				local var_37_1 = {
					tipsType = NewChessConst.TIPS_TYPE.NORMAL,
					tipsText = var_37_0
				}

				manager.NewChessManager:CreateTips(var_37_1)
			end

			if arg_37_1 == NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_FINISH.id and arg_37_2 > 0 then
				local var_37_2 = NewWarChessData:GetCurrentWarChessMapID()
				local var_37_3

				for iter_37_0, iter_37_1 in pairs(NewWarChessLevelCfg.all) do
					if NewWarChessLevelCfg[iter_37_1].front_level_id == var_37_2 then
						var_37_3 = NewWarChessLevelCfg[iter_37_1].name_level

						break
					end
				end

				local var_37_4

				if var_37_3 ~= nil then
					var_37_4 = string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK_NEW_LEVEL"), var_37_3)
				else
					var_37_4 = GetTips("ACTIVITY_NEW_WARCHESS_LEVEL_FINISH")
				end

				ShowMessageBox({
					ButtonType = "SingleBtn",
					content = var_37_4
				})
			end

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10027] = {
		[NewChessConst.TIMING_ALL] = function(arg_38_0, arg_38_1)
			manager.story:StartChessStoryLine(arg_38_1, function(arg_39_0)
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10028] = {
		[NewChessConst.TIMING_ALL] = function(arg_40_0, arg_40_1, arg_40_2)
			NewWarChessData:SetAttribute(arg_40_1, arg_40_2)

			if arg_40_1 == NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_FINISH.id and arg_40_2 > 0 then
				local var_40_0 = NewWarChessData:GetCurrentWarChessMapID()
				local var_40_1

				for iter_40_0, iter_40_1 in pairs(NewWarChessLevelCfg.all) do
					if NewWarChessLevelCfg[iter_40_1].front_level_id == var_40_0 then
						var_40_1 = NewWarChessLevelCfg[iter_40_1].name_level

						break
					end
				end

				local var_40_2

				if var_40_1 ~= nil then
					var_40_2 = string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK_NEW_LEVEL"), var_40_1)
				else
					var_40_2 = GetTips("ACTIVITY_NEW_WARCHESS_LEVEL_FINISH")
				end

				ShowMessageBox({
					ButtonType = "SingleBtn",
					content = var_40_2
				})
			end

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10029] = {
		[NewChessConst.TIMING_ALL] = function(arg_41_0, arg_41_1, arg_41_2)
			local var_41_0 = manager.NewChessManager:GetExecutingChess()
			local var_41_1 = var_41_0.x
			local var_41_2 = var_41_0.z

			manager.NewChessManager:PlayGridAnimation(var_41_1, var_41_2, arg_41_1, arg_41_2, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10030] = {
		[NewChessConst.TIMING_ALL] = function(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
			manager.NewChessManager:PlayGridAnimation(arg_43_1, arg_43_2, arg_43_3, arg_43_4, function()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	OperatorFunc = {
		function(arg_45_0, arg_45_1)
			return arg_45_0 + arg_45_1
		end,
		function(arg_46_0, arg_46_1)
			return math.abs(arg_46_0 - arg_46_1)
		end,
		function(arg_47_0, arg_47_1)
			return arg_47_0 * arg_47_1
		end,
		function(arg_48_0, arg_48_1)
			return math.floor(arg_48_0 / arg_48_1)
		end,
		sum = function(arg_49_0)
			local var_49_0 = 0

			for iter_49_0, iter_49_1 in pairs(arg_49_0) do
				var_49_0 = var_49_0 + iter_49_1
			end

			return var_49_0
		end
	}
}

var_0_0.DiceTypeFunc = {
	function(arg_50_0, arg_50_1)
		local var_50_0 = var_0_0.OperatorFunc.sum(arg_50_1)

		return {
			var_0_0.OperatorFunc[arg_50_0[2]](var_50_0, arg_50_0[3])
		}
	end,
	function(arg_51_0, arg_51_1)
		local var_51_0 = math.floor(arg_51_1[1] / arg_51_0[2])
		local var_51_1 = {}

		for iter_51_0 = 1, arg_51_0[2] do
			if iter_51_0 < arg_51_0[2] then
				table.insert(var_51_1, var_51_0)
			else
				table.insert(var_51_1, arg_51_1[1] - var_51_0)
			end
		end

		return {
			var_51_1
		}
	end,
	function(arg_52_0, arg_52_1)
		local var_52_0 = var_0_0.OperatorFunc.sum(arg_52_1)
		local var_52_1 = {}

		for iter_52_0 = 1, var_52_0 do
			table.insert(var_52_1, arg_52_0[2])
		end

		return {
			var_52_1
		}
	end,
	function(arg_53_0, arg_53_1)
		local var_53_0 = var_0_0.OperatorFunc.sum(arg_53_1)
		local var_53_1 = {}

		for iter_53_0 = 1, arg_53_0[2] do
			table.insert(var_53_1, var_53_0)
		end

		return {
			var_53_1
		}
	end,
	function(arg_54_0, arg_54_1)
		local var_54_0 = {}

		for iter_54_0 = 1, #arg_54_1 do
			table.insert(var_54_0, arg_54_0[2])
		end

		return {
			var_54_0
		}
	end,
	function(arg_55_0, arg_55_1)
		local var_55_0 = {}

		for iter_55_0 = 1, #arg_55_1 do
			table.insert(var_55_0, var_0_0.OperatorFunc[arg_55_0[2]](arg_55_1[iter_55_0], arg_55_0[3]))
		end

		return {
			var_55_0
		}
	end,
	function(arg_56_0, arg_56_1)
		if var_0_0.OperatorFunc.sum(arg_56_1) >= arg_56_0[2] then
			return {
				arg_56_0[3]
			}
		else
			return {
				arg_56_0[4]
			}
		end
	end,
	function(arg_57_0, arg_57_1)
		if arg_57_1[1] and arg_57_1[2] then
			local var_57_0 = var_0_0.OperatorFunc[arg_57_0[2]](arg_57_1[1], arg_57_1[2])

			return {
				var_57_0 * arg_57_0[3]
			}
		else
			return {}
		end
	end,
	function(arg_58_0, arg_58_1)
		return {}
	end
}
var_0_0[10031] = {
	[NewChessConst.TIMING_ALL] = function(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
		local var_59_0 = NewWarChessDiceEventTypeCfg[arg_59_1].param
		local var_59_1 = var_0_0.DiceTypeFunc[var_59_0[1]](var_59_0, arg_59_3)
		local var_59_2 = 1
		local var_59_3 = arg_59_2[1]
		local var_59_4 = {}

		for iter_59_0, iter_59_1 in pairs(arg_59_2) do
			if iter_59_0 > 1 then
				if type(iter_59_1) == "table" and iter_59_1[1] == -1 then
					table.insert(var_59_4, var_59_1[var_59_2])

					var_59_2 = var_59_2 + 1
				else
					table.insert(var_59_4, iter_59_1)
				end
			end
		end

		var_0_0[var_59_3][NewChessConst.TIMING_ALL](unpack(var_59_4))
	end
}
var_0_0[10032] = {
	[NewChessConst.TIMING_ALL] = function(arg_60_0, arg_60_1)
		local var_60_0 = arg_60_1 / 100 * NewChessConst.HERO_HP_RATE

		NewWarChessData:SubAllHeroHp(var_60_0)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10033] = {
	[NewChessConst.TIMING_ALL] = function(arg_61_0, arg_61_1)
		NewWarChessData:SubDiceListNum(arg_61_1)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10034] = {
	[NewChessConst.TIMING_ALL] = function(arg_62_0, arg_62_1, arg_62_2)
		local var_62_0 = manager.NewChessManager:GetExecutingChess()
		local var_62_1 = var_62_0.x
		local var_62_2 = var_62_0.z

		NewChessLuaBridge.OpenBarFog(var_62_1, var_62_2, arg_62_1, arg_62_2, function()
			return manager.NewChessManager:DoNextEvent()
		end)
	end
}
var_0_0[10035] = {
	[NewChessConst.TIMING_ALL] = function(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4)
		NewChessLuaBridge.OpenBarFog(arg_64_1, arg_64_2, arg_64_3, arg_64_4, function()
			return manager.NewChessManager:DoNextEvent()
		end)
	end
}
var_0_0[10036] = {
	[NewChessConst.TIMING_ALL] = function(arg_66_0, arg_66_1)
		NewWarChessAction.AddNewDice(arg_66_0)
		NewWarChessData:SubAttribute(arg_66_1, arg_66_0[1])

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10037] = {
	[NewChessConst.TIMING_ALL] = function(arg_67_0, arg_67_1)
		NewWarChessData:RemoveFrontDice(arg_67_1)

		local var_67_0 = string.format(GetTips("ACTIVITY_NEW_WARCHESS_LOST_DICE"), arg_67_1)
		local var_67_1 = {
			tipsType = NewChessConst.TIPS_TYPE.DANGEROUS,
			tipsText = var_67_0
		}

		manager.NewChessManager:CreateTips(var_67_1)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10038] = {
	[NewChessConst.TIMING_ALL] = function(arg_68_0)
		NewWarChessData:RemoveAllDice()
		NewWarChessAction.AddNewDice(arg_68_0)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10039] = {
	[NewChessConst.TIMING_ALL] = function(arg_69_0, arg_69_1)
		NewWarChessData:SetAllDice(arg_69_1)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10040] = {
	[NewChessConst.TIMING_ALL] = function(arg_70_0)
		NewWarChessAction.AddNewDice(arg_70_0)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10041] = {
	[NewChessConst.TIMING_ALL] = function(arg_71_0, arg_71_1, arg_71_2)
		NewChessLuaBridge.FixRoleY(arg_71_1, arg_71_2)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10042] = {
	[NewChessConst.TIMING_ALL] = function(arg_72_0)
		manager.NewChessManager:ClearEndPoint()
		NewChessLuaBridge.StopRoleMoving()

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10043] = {
	[NewChessConst.TIMING_ALL] = function(arg_73_0, arg_73_1)
		manager.NewChessManager:DeleteTask(arg_73_1)
		manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10044] = {
	[NewChessConst.TIMING_ALL] = function(arg_74_0)
		if arg_74_0[1] and arg_74_0[1] == 1 then
			local var_74_0 = manager.NewChessManager:GetExecutingChess()
			local var_74_1 = var_74_0.x
			local var_74_2 = var_74_0.z

			manager.NewChessManager:ShowBlock()
			manager.NewChessManager:ClearInteractChess()

			if arg_74_0[2] then
				NewChessLuaBridge.MoveByDir(var_74_1, var_74_2, arg_74_0[2], function()
					manager.NewChessManager:CloseBlock()

					return manager.NewChessManager:DoNextEvent()
				end)
			else
				error(var_74_1, " ", var_74_2, "格子服务器下发的数据中触发冰面滑动事件没有下发方向")
			end
		else
			return manager.NewChessManager:DoNextEvent()
		end
	end
}
NewWarChessEventIterator = class("NewWarChessEventIterator")

function NewWarChessEventIterator.Ctor(arg_76_0, arg_76_1, arg_76_2, arg_76_3, arg_76_4)
	arg_76_0.entityID_ = arg_76_1
	arg_76_0.chess_ = arg_76_2
	arg_76_0.eventList_ = arg_76_3
	arg_76_0.curEventIndex_ = 0
	arg_76_0.disposeFunc_ = arg_76_4
end

function NewWarChessEventIterator.MoveNext(arg_77_0)
	arg_77_0.curEventIndex_ = arg_77_0.curEventIndex_ + 1

	if arg_77_0.curEventIndex_ <= #arg_77_0.eventList_ then
		local var_77_0 = arg_77_0.eventList_[arg_77_0.curEventIndex_]
		local var_77_1 = var_77_0[1]

		if var_77_1 == 10004 then
			local var_77_2 = arg_77_0.chess_
			local var_77_3 = var_77_2.x
			local var_77_4 = var_77_2.z
			local var_77_5 = var_77_0[2]

			manager.NewChessManager:ChangeGridByExtentID(var_77_3, var_77_4, var_77_5, false, function()
				arg_77_0:MoveNext()
			end)
		elseif var_77_1 == 10029 then
			local var_77_6 = arg_77_0.chess_
			local var_77_7 = var_77_6.x
			local var_77_8 = var_77_6.z
			local var_77_9 = var_77_0[2]
			local var_77_10 = var_77_0[3]

			manager.NewChessManager:PlayGridAnimation(var_77_7, var_77_8, var_77_9, var_77_10, function()
				arg_77_0:MoveNext()
			end)
		elseif var_77_1 == 10041 then
			local var_77_11 = var_77_0[2]
			local var_77_12 = var_77_0[3]

			NewChessLuaBridge.FixRoleY(var_77_11, var_77_12)
			arg_77_0:MoveNext()
		elseif var_77_1 == 10046 then
			local var_77_13 = arg_77_0.chess_
			local var_77_14 = var_77_13.x
			local var_77_15 = var_77_13.z
			local var_77_16 = var_77_0[2]
			local var_77_17 = var_77_0[3]

			manager.NewChessManager:ChangeGridDirection(var_77_14, var_77_15, var_77_16, var_77_17, function()
				arg_77_0:MoveNext()
			end)
		elseif var_77_1 == 10052 then
			local var_77_18 = arg_77_0.chess_
			local var_77_19 = var_77_18.x
			local var_77_20 = var_77_18.z
			local var_77_21 = var_77_0[2]

			manager.NewChessManager:ChangeGridByExtentID(var_77_19, var_77_20, var_77_21, true, function()
				arg_77_0:MoveNext()
			end)
		end
	else
		arg_77_0:Dispose()
	end
end

function NewWarChessEventIterator.Dispose(arg_82_0)
	if arg_82_0.disposeFunc_ then
		arg_82_0.disposeFunc_(arg_82_0.entityID_)

		arg_82_0.entityID_ = nil
		arg_82_0.chess_ = nil
		arg_82_0.eventList_ = nil
		arg_82_0.curEventIndex_ = nil
		arg_82_0.disposeFunc_ = nil
	end
end

var_0_0[10045] = {
	[NewChessConst.TIMING_ALL] = function(arg_83_0, arg_83_1, arg_83_2)
		manager.NewChessManager:ShowBlock()

		local var_83_0 = manager.NewChessManager:GetExecutingChess()
		local var_83_1 = var_83_0.x
		local var_83_2 = var_83_0.z
		local var_83_3 = {}
		local var_83_4 = 0

		for iter_83_0 = -arg_83_1, arg_83_1 do
			for iter_83_1 = math.max(-arg_83_1, iter_83_0 - arg_83_1), math.min(arg_83_1, iter_83_0 + arg_83_1) do
				local var_83_5 = NewChessLuaBridge.GetNewGridData(var_83_1 + iter_83_0, var_83_2 + iter_83_1)

				for iter_83_2, iter_83_3 in pairs(arg_83_2) do
					if var_83_5.typeID == iter_83_3[1] then
						var_83_4 = var_83_4 + 1
						var_83_3[var_83_4] = NewWarChessEventIterator.New(var_83_4, var_83_5, iter_83_3[2], function(arg_84_0)
							var_83_3[arg_84_0] = nil
							var_83_4 = var_83_4 - 1

							if var_83_4 <= 0 then
								manager.NewChessManager:CloseBlock()

								var_83_3 = nil

								return manager.NewChessManager:DoNextEvent()
							end
						end)

						break
					end
				end
			end
		end

		if var_83_4 == 0 then
			return manager.NewChessManager:DoNextEvent()
		else
			for iter_83_4, iter_83_5 in pairs(var_83_3) do
				iter_83_5:MoveNext()
			end
		end
	end
}
var_0_0[10046] = {
	[NewChessConst.TIMING_ALL] = function(arg_85_0, arg_85_1, arg_85_2)
		local var_85_0 = manager.NewChessManager:GetExecutingChess()
		local var_85_1 = var_85_0.x
		local var_85_2 = var_85_0.z

		manager.NewChessManager:ChangeGridDirection(var_85_1, var_85_2, arg_85_1, arg_85_2, function()
			return manager.NewChessManager:DoNextEvent()
		end)
	end
}
var_0_0[10047] = {
	[NewChessConst.TIMING_ALL] = function(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4)
		local var_87_0 = NewChessLuaBridge.GetGridData(arg_87_1, arg_87_2)

		manager.NewChessManager:ChangeGridDirection(arg_87_1, arg_87_2, arg_87_3, arg_87_4, function()
			return manager.NewChessManager:DoNextEvent()
		end)
	end
}
NewWarChessCheckEventIterator = class("NewWarChessCheckEventIterator")

function NewWarChessCheckEventIterator.Ctor(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	arg_89_0.eventList_ = arg_89_2
	arg_89_0.curEventIndex_ = 0
	arg_89_0.params_ = arg_89_1
	arg_89_0.disposeFunc_ = arg_89_3
end

function NewWarChessCheckEventIterator.MoveNext(arg_90_0)
	arg_90_0.curEventIndex_ = arg_90_0.curEventIndex_ + 1

	if arg_90_0.curEventIndex_ <= #arg_90_0.eventList_ then
		local var_90_0 = arg_90_0.eventList_[arg_90_0.curEventIndex_]
		local var_90_1 = var_90_0[1]

		if var_90_1 == 10041 then
			local var_90_2 = var_90_0[2]
			local var_90_3 = var_90_0[3]

			NewChessLuaBridge.FixRoleY(var_90_2, var_90_3)
			arg_90_0:MoveNext()
		elseif var_90_1 == 10055 then
			manager.NewChessManager:ClearInteractChess()
			NewChessLuaBridge.TelePortRoleToPosition(arg_90_0.params_.x, arg_90_0.params_.z, function()
				arg_90_0:MoveNext()
			end)
		end
	else
		arg_90_0:Dispose()
	end
end

function NewWarChessCheckEventIterator.Dispose(arg_92_0)
	if arg_92_0.disposeFunc_ then
		arg_92_0.disposeFunc_()

		arg_92_0.eventList_ = nil
		arg_92_0.curEventIndex_ = nil
		arg_92_0.params_ = nil
		arg_92_0.disposeFunc_ = nil
	end
end

var_0_0[10048] = {
	[NewChessConst.TIMING_ALL] = function(arg_93_0, arg_93_1)
		if arg_93_0[1] == 1 then
			local var_93_0 = arg_93_0[2]
			local var_93_1

			for iter_93_0, iter_93_1 in pairs(arg_93_1) do
				for iter_93_2, iter_93_3 in pairs(iter_93_1[1]) do
					if iter_93_3 == var_93_0 then
						var_93_1 = iter_93_1[2]

						break
					end
				end
			end

			if var_93_1 then
				NewWarChessCheckEventIterator.New({
					x = arg_93_0[3],
					z = arg_93_0[4]
				}, var_93_1, function()
					return manager.NewChessManager:DoNextEvent()
				end):MoveNext()
			else
				return manager.NewChessManager:DoNextEvent()
			end
		else
			return manager.NewChessManager:DoNextEvent()
		end
	end
}
var_0_0[10049] = {
	[NewChessConst.TIMING_ALL] = function(arg_95_0, arg_95_1, arg_95_2)
		NewChessLuaBridge.LookAtPlayer()

		local var_95_0 = manager.NewChessManager:GetExecutingChess()

		NewChessLuaBridge.TelePortRoleToPosition(var_95_0.x + arg_95_1, var_95_0.z + arg_95_2, function()
			manager.NewChessManager:ClearInteractChess()

			return manager.NewChessManager:DoNextEvent()
		end)
	end
}
var_0_0[10050] = {
	[NewChessConst.TIMING_ALL] = function(arg_97_0, arg_97_1)
		JumpTools.OpenPageByJump("newWarChessTextPopView", {
			ID = arg_97_1,
			callBack = function()
				return manager.NewChessManager:DoNextEvent()
			end
		})
	end
}
var_0_0[10051] = {
	[NewChessConst.TIMING_ALL] = function(arg_99_0, arg_99_1)
		local var_99_0 = #arg_99_1

		for iter_99_0, iter_99_1 in pairs(arg_99_1) do
			local var_99_1 = iter_99_1[1]
			local var_99_2 = iter_99_1[2]
			local var_99_3 = iter_99_1[3]
			local var_99_4 = iter_99_1[4]

			manager.NewChessManager:PlayGridAnimation(var_99_1, var_99_2, var_99_3, var_99_4, function()
				var_99_0 = var_99_0 - 1

				if var_99_0 <= 0 then
					return manager.NewChessManager:DoNextEvent()
				end
			end)
		end
	end
}
var_0_0[10052] = {
	[NewChessConst.TIMING_ALL] = function(arg_101_0, arg_101_1)
		local var_101_0 = manager.NewChessManager:GetExecutingChess()
		local var_101_1 = var_101_0.x
		local var_101_2 = var_101_0.z

		manager.NewChessManager:ChangeGridByExtentID(var_101_1, var_101_2, arg_101_1, true, function()
			return manager.NewChessManager:DoNextEvent()
		end)
	end
}
var_0_0[10053] = {
	[NewChessConst.TIMING_ALL] = function(arg_103_0, arg_103_1, arg_103_2, arg_103_3)
		manager.NewChessManager:ChangeGridByExtentID(arg_103_1, arg_103_2, arg_103_3, true, function()
			return manager.NewChessManager:DoNextEvent()
		end)
	end
}
var_0_0[10054] = {
	[NewChessConst.TIMING_ALL] = function(arg_105_0, arg_105_1)
		manager.NewChessManager.globalManager_:InsertNextInitGlobalEvent(arg_105_1)

		return manager.NewChessManager:DoNextEvent()
	end
}
var_0_0[10055] = {
	[NewChessConst.TIMING_ALL] = function(arg_106_0)
		manager.NewChessManager:ClearInteractChess()
		NewChessLuaBridge.TelePortRoleToPosition(arg_106_0[1], arg_106_0[2], function()
			return manager.NewChessManager:DoNextEvent()
		end)
	end
}

return var_0_0
