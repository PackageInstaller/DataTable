return {
	[10001] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_1_0, arg_1_1)
			manager.ChessBoardManager.blockerManager_:ForceCloseBlocker()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)
			manager.story:StartChessStoryWithBackground(arg_1_1, function(arg_2_0)
				manager.ChessBoardManager.blockerManager_:CheckBlockerGo()

				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10002] = {
		[ChessBoardConst.TIMING.FIRST_ENTER_MAP] = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
			if arg_3_0[1] == 0 then
				-- block empty
			else
				local var_3_0 = ChessBoardNPCPoolCfg[arg_3_1]
				local var_3_1 = {
					id = arg_3_0[1],
					typeID = arg_3_1,
					pos = {}
				}

				var_3_1.pos.x = arg_3_2
				var_3_1.pos.z = arg_3_3
				var_3_1.dir = arg_3_4
				var_3_1.attribute = {}

				for iter_3_0, iter_3_1 in pairs(var_3_0.init_attribute_list) do
					var_3_1.attribute[iter_3_1[1]] = iter_3_1[2]
				end

				var_3_1.buffList = {}

				manager.ChessBoardManager:AddNPC(var_3_1)
			end

			return manager.ChessBoardManager:DoNextEvent()
		end,
		[ChessBoardConst.TIMING.ALL] = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
			if arg_4_0[1] == 0 then
				ShowTips("CHESSBOARD_DUCK_MAX")
			else
				local var_4_0 = ChessBoardNPCPoolCfg[arg_4_1]
				local var_4_1 = {
					id = arg_4_0[1],
					typeID = arg_4_1,
					pos = {}
				}

				var_4_1.pos.x = arg_4_2
				var_4_1.pos.z = arg_4_3
				var_4_1.dir = arg_4_4
				var_4_1.attribute = {}

				for iter_4_0, iter_4_1 in pairs(var_4_0.init_attribute_list) do
					var_4_1.attribute[iter_4_1[1]] = iter_4_1[2]
				end

				var_4_1.buffList = {}

				manager.ChessBoardManager:AddNPC(var_4_1)
				ShowTips("CHESSBOARD_NEW_DUCK")
				manager.ChessBoardManager:PlayPortHeroEffect(arg_4_2, arg_4_3)
			end

			manager.ChessBoardManager:AddDelayTimer(1, function()
				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10003] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
			manager.ChessBoardManager:ChangeGridByExtentID(arg_6_1, arg_6_2, arg_6_3, false, function()
				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10004] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
			manager.ChessBoardManager:ChangeThingByExtentID(arg_8_1, arg_8_2, arg_8_3, function()
				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10005] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_10_0, arg_10_1)
			local var_10_0 = manager.ChessBoardManager:GetExecutingChess()
			local var_10_1 = var_10_0.x
			local var_10_2 = var_10_0.z

			manager.ChessBoardManager:ChangeGridByExtentID(var_10_1, var_10_2, arg_10_1, false, function()
				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10006] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_12_0, arg_12_1)
			local var_12_0 = manager.ChessBoardManager:GetExecutingChess()
			local var_12_1 = var_12_0.x
			local var_12_2 = var_12_0.z

			manager.ChessBoardManager:ChangeThingByExtentID(var_12_1, var_12_2, arg_12_1, function()
				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10007] = {
		[ChessBoardConst.TIMING.HERO_STAY_NPC] = function(arg_14_0)
			local var_14_0 = manager.ChessBoardManager:GetExecutingChess()
			local var_14_1 = var_14_0.x
			local var_14_2 = var_14_0.z
			local var_14_3 = manager.ChessBoardManager.NPCManager_:FindNPCWithPos(var_14_1, var_14_2)

			if var_14_3 then
				manager.ChessBoardManager:DeleteNPC(var_14_3)
			end

			return manager.ChessBoardManager:DoNextEvent()
		end,
		[ChessBoardConst.TIMING.ALL] = function(arg_15_0)
			local var_15_0 = manager.ChessBoardManager:GetExecutingChess()
			local var_15_1 = var_15_0.x
			local var_15_2 = var_15_0.z
			local var_15_3 = manager.ChessBoardManager.NPCManager_:FindNPCWithPos(var_15_1, var_15_2)

			if var_15_3 then
				ChessBoardLuaBridge.ShowNPCDestoryEffectActive(var_15_1, var_15_2)
				manager.ChessBoardManager:AddDelayTimer(0.5, function()
					ChessBoardLuaBridge.ClearNPCDestoryEffect()

					return manager.ChessBoardManager:DoNextEvent()
				end)
				manager.ChessBoardManager:DeleteNPC(var_15_3)
			else
				return manager.ChessBoardManager:DoNextEvent()
			end
		end
	},
	[10008] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_17_0, arg_17_1)
			local var_17_0 = manager.ChessBoardManager:GetExecutingChess()
			local var_17_1 = var_17_0.x
			local var_17_2 = var_17_0.z

			if arg_17_0[1] == arg_17_0.playerA then
				manager.ChessBoardManager:DeleteNPC(arg_17_0.playerB)

				return manager.ChessBoardManager:DoNextEvent()
			elseif arg_17_0[1] == arg_17_0.playerB then
				manager.ChessBoardManager:DeleteNPC(arg_17_0.playerA)

				return manager.ChessBoardManager:DoNextEvent()
			else
				manager.ChessBoardManager:DeleteNPC(arg_17_0.playerA)
				manager.ChessBoardManager:DeleteNPC(arg_17_0.playerB)

				local var_17_3 = ChessBoardNPCPoolCfg[arg_17_1]
				local var_17_4 = arg_17_0[2]
				local var_17_5 = {
					id = arg_17_0[1],
					typeID = arg_17_1,
					pos = {}
				}

				var_17_5.pos.x = var_17_1
				var_17_5.pos.z = var_17_2
				var_17_5.dir = var_17_4
				var_17_5.attribute = {}
				var_17_5.actionType = ChessBoardConst.ACTIONTYPE.GROW

				for iter_17_0, iter_17_1 in pairs(var_17_3.init_attribute_list) do
					var_17_5.attribute[iter_17_1[1]] = iter_17_1[2]
				end

				var_17_5.buffList = {}

				ShowTips("CHESSBOARD_NEW_BIG_DUCK")
				manager.ChessBoardManager:AddNPC(var_17_5)
				ChessBoardLuaBridge.SetNPCToCameraTarget(var_17_5.id)
				ChessBoardLuaBridge.ChangeCameraToCloseCamera()
				manager.ChessBoardManager:AddDelayTimer(1, function()
					manager.ChessBoardManager:DoNextEvent()
				end)
			end
		end
	},
	[10009] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_19_0, arg_19_1, arg_19_2)
			local var_19_0 = manager.ChessBoardManager:GetExecutingChess()
			local var_19_1 = var_19_0.x
			local var_19_2 = var_19_0.z

			manager.ChessBoardManager:PlayGridAnimation(var_19_1, var_19_2, arg_19_1, arg_19_2, function()
				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10010] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
			manager.ChessBoardManager:PlayGridAnimation(arg_21_1, arg_21_2, arg_21_3, arg_21_4, function()
				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10011] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_23_0)
			print("ltodo 传递炸弹事件")

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[10012] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_24_0, arg_24_1)
			manager.ChessBoardManager.taskManager_:AddNewTask(arg_24_1)

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[10013] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_25_0, arg_25_1, arg_25_2)
			manager.ChessBoardManager.taskManager_:UpdateTask(arg_25_1, arg_25_2)

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[10014] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_26_0, arg_26_1)
			manager.ChessBoardManager.blockerManager_:ForceCloseBlocker()
			JumpTools.OpenPageByJump("/chessBoardTipsWindowView", {
				tipsWindowID = arg_26_1,
				callBack = function()
					manager.ChessBoardManager.blockerManager_:CheckBlockerGo()
					JumpTools.Back()
					manager.ChessBoardManager:DoNextEvent()
				end
			})
		end
	},
	[10015] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_28_0, arg_28_1, arg_28_2)
			manager.ChessBoardManager:MoveToTarget(arg_28_1, arg_28_2, function()
				return manager.ChessBoardManager:DoNextEvent()
			end)
		end
	},
	[10016] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
			if arg_30_0[1] == 0 then
				return manager.ChessBoardManager:DoNextEvent()
			else
				local var_30_0 = manager.ChessBoardManager.NPCManager_:FindPosAllNPC(arg_30_1, arg_30_2)

				if var_30_0 ~= 2 then
					error("指定位置合成NPC事件，当前格子NPC数量不是两个！")

					return
				end

				if arg_30_0[1] == var_30_0[1] then
					manager.ChessBoardManager:DeleteNPC(var_30_0[2])

					return manager.ChessBoardManager:DoNextEvent()
				elseif arg_30_0[1] == var_30_0[2] then
					manager.ChessBoardManager:DeleteNPC(var_30_0[1])

					return manager.ChessBoardManager:DoNextEvent()
				else
					manager.ChessBoardManager:DeleteNPC(var_30_0[1])
					manager.ChessBoardManager:DeleteNPC(var_30_0[2])

					local var_30_1 = ChessBoardNPCPoolCfg[arg_30_3]
					local var_30_2 = {
						id = arg_30_0[1],
						typeID = arg_30_3,
						pos = {}
					}

					var_30_2.pos.x = arg_30_1
					var_30_2.pos.z = arg_30_2
					var_30_2.dir = arg_30_4
					var_30_2.attribute = {}
					var_30_2.actionType = ChessBoardConst.ACTIONTYPE.GROW

					for iter_30_0, iter_30_1 in pairs(var_30_1.init_attribute_list) do
						var_30_2.attribute[iter_30_1[1]] = iter_30_1[2]
					end

					var_30_2.buffList = {}

					ShowTips("CHESSBOARD_NEW_BIG_DUCK")
					manager.ChessBoardManager:AddNPC(var_30_2)
					ChessBoardLuaBridge.SetNPCToCameraTarget(var_30_2.id)
					ChessBoardLuaBridge.ChangeCameraToCloseCamera()
					manager.ChessBoardManager:AddDelayTimer(1, function()
						manager.ChessBoardManager:DoNextEvent()
					end)
				end
			end
		end
	},
	[10017] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_32_0, arg_32_1, arg_32_2)
			local var_32_0 = manager.ChessBoardManager.NPCManager_:FindNPCWithPos(arg_32_1, arg_32_2)

			if var_32_0 then
				ChessBoardLuaBridge.ShowNPCDestoryEffectActive(arg_32_1, arg_32_2)
				manager.ChessBoardManager:AddDelayTimer(0.5, function()
					ChessBoardLuaBridge.ClearNPCDestoryEffect()
				end)
				manager.ChessBoardManager:DeleteNPC(var_32_0)
			end

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[10018] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[10019] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_35_0, arg_35_1, arg_35_2)
			if ChessBoardLuaBridge.GetGridData(arg_35_1, arg_35_2).thingTypeID > 0 then
				manager.ChessBoardManager:DeleteThing(arg_35_1, arg_35_2, function()
					return manager.ChessBoardManager:DoNextEvent()
				end)
			else
				return manager.ChessBoardManager:DoNextEvent()
			end
		end
	},
	[10020] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_37_0, arg_37_1, arg_37_2)
			local var_37_0 = manager.ChessBoardManager:GetExecutingChess()
			local var_37_1 = var_37_0.x
			local var_37_2 = var_37_0.z

			if var_37_0.thingTypeID > 0 then
				manager.ChessBoardManager:DeleteThing(var_37_1, var_37_2, function()
					return manager.ChessBoardManager:DoNextEvent()
				end)
			else
				return manager.ChessBoardManager:DoNextEvent()
			end
		end
	},
	[10021] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_39_0, arg_39_1)
			local var_39_0 = #arg_39_1

			for iter_39_0, iter_39_1 in pairs(arg_39_1) do
				local var_39_1 = iter_39_1[1]
				local var_39_2 = iter_39_1[2]
				local var_39_3 = iter_39_1[3]
				local var_39_4 = iter_39_1[4]

				manager.ChessBoardManager:PlayGridAnimation(var_39_1, var_39_2, var_39_3, var_39_4, function()
					var_39_0 = var_39_0 - 1

					if var_39_0 <= 0 then
						return manager.ChessBoardManager:DoNextEvent()
					end
				end)
			end
		end
	},
	[20001] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
			if arg_41_1 == 1 then
				if arg_41_0.playerA == 0 then
					manager.ChessBoardManager:TelePortHeroToPosition(arg_41_2, arg_41_3, arg_41_4, function()
						return manager.ChessBoardManager:DoNextEvent()
					end)
				elseif arg_41_0.playerA > 0 then
					manager.ChessBoardManager:TelePortNPCToPosition(arg_41_0.playerA, arg_41_2, arg_41_3, arg_41_4, function()
						return manager.ChessBoardManager:DoNextEvent()
					end)
				elseif arg_41_0.playerA == -1 then
					error("传送对象事件未传入角色对象！")
				end
			elseif arg_41_0.playerB == 0 then
				manager.ChessBoardManager:TelePortHeroToPosition(arg_41_2, arg_41_3, arg_41_4, function()
					return manager.ChessBoardManager:DoNextEvent()
				end)
			elseif arg_41_0.playerB > 0 then
				manager.ChessBoardManager:TelePortNPCToPosition(arg_41_0.playerB, arg_41_2, arg_41_3, arg_41_4, function()
					return manager.ChessBoardManager:DoNextEvent()
				end)
			elseif arg_41_0.playerB == -1 then
				error("传送对象事件未传入角色对象！")
			end
		end
	},
	[20002] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
			if arg_46_1 == 1 then
				if arg_46_0.playerA == 0 then
					manager.ChessBoardManager:SubHeroAttribute(arg_46_2, arg_46_3)
				elseif arg_46_0.playerA > 0 then
					manager.ChessBoardManager:SubNPCAttribute(arg_46_0.playerA, arg_46_2, arg_46_3)
				elseif arg_46_0.playerA == -1 then
					error("触发修改角色属性事件未传入角色对象！")
				end
			elseif arg_46_0.playerB == 0 then
				manager.ChessBoardManager:SubHeroAttribute(arg_46_2, arg_46_3)
			elseif arg_46_0.playerB > 0 then
				manager.ChessBoardManager:SubNPCAttribute(arg_46_0.playerB, arg_46_2, arg_46_3)
			elseif arg_46_0.playerB == -1 then
				error("触发修改角色属性事件未传入角色对象！")
			end

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[20003] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_47_0, arg_47_1, arg_47_2)
			if arg_47_1 == 1 then
				if arg_47_0.playerA == 0 then
					manager.ChessBoardManager:AddHeroProp(arg_47_2)
				elseif arg_47_0.playerA > 0 then
					-- block empty
				elseif arg_47_0.playerA == -1 then
					error("触发修改道具事件未传入角色对象！")
				end
			elseif arg_47_0.playerB == 0 then
				manager.ChessBoardManager:AddHeroProp(arg_47_2)
			elseif arg_47_0.playerB > 0 then
				-- block empty
			elseif arg_47_0.playerB == -1 then
				error("触发修改道具事件未传入角色对象！")
			end

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[20004] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_48_0, arg_48_1)
			if arg_48_1 == 1 then
				if arg_48_0.playerA == 0 then
					manager.ChessBoardManager.heroEntity_.buffManager_:ClearDebuff()
				elseif arg_48_0.playerA > 0 then
					manager.ChessBoardManager.NPCManager_:ClearNPCDebuff(arg_48_0.playerA)
				elseif arg_48_0.playerA == -1 then
					error("触发清空负面效果未传入角色对象！")
				end
			elseif arg_48_0.playerB == 0 then
				manager.ChessBoardManager.heroEntity_.buffManager_:ClearDebuff()
			elseif arg_48_0.playerB > 0 then
				manager.ChessBoardManager.NPCManager_:ClearNPCDebuff(arg_48_0.playerB)
			elseif arg_48_0.playerB == -1 then
				error("触发清空负面效果未传入角色对象！")
			end

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[20005] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_49_0, arg_49_1, arg_49_2)
			if arg_49_1 == 1 then
				if arg_49_0.playerA >= 0 then
					manager.ChessBoardManager:AddBuff(arg_49_0.playerA, arg_49_2)
				elseif arg_49_0.playerA == -1 then
					error("触发添加buff事件未传入角色对象！")
				end
			elseif arg_49_0.playerB >= 0 then
				manager.ChessBoardManager:AddBuff(arg_49_0.playerB, arg_49_2)
			elseif arg_49_0.playerB == -1 then
				error("触发添加buff事件未传入角色对象！")
			end

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[20006] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_50_0, arg_50_1, arg_50_2)
			if arg_50_1 == 1 then
				if arg_50_0.playerA >= 0 then
					manager.ChessBoardManager:RemoveBuff(arg_50_0.playerA, arg_50_2)
				elseif arg_50_0.playerA == -1 then
					error("触发删除buff事件未传入角色对象！")
				end
			elseif arg_50_0.playerB >= 0 then
				manager.ChessBoardManager:RemoveBuff(arg_50_0.playerB, arg_50_2)
			elseif arg_50_0.playerB == -1 then
				error("触发删除buff事件未传入角色对象！")
			end

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[20007] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
			if arg_51_1 == 1 then
				if arg_51_0.playerA == 0 then
					local var_51_0 = arg_51_0[1] - manager.ChessBoardManager:GetHeroAttribute(arg_51_2)

					manager.ChessBoardManager:SubHeroAttribute(arg_51_2, var_51_0)
				elseif arg_51_0.playerA > 0 then
					manager.ChessBoardManager:SetNPCAttribute(arg_51_0.playerA, arg_51_2, arg_51_0[1])
				elseif arg_51_0.playerA == -1 then
					error("触发修改角色属性事件未传入角色对象！")
				end
			elseif arg_51_0.playerB == 0 then
				local var_51_1 = arg_51_0[1] - manager.ChessBoardManager:GetHeroAttribute(arg_51_2)

				manager.ChessBoardManager:SubHeroAttribute(arg_51_2, var_51_1)
			elseif arg_51_0.playerB > 0 then
				manager.ChessBoardManager:SetNPCAttribute(arg_51_0.playerB, arg_51_2, arg_51_0[1])
			elseif arg_51_0.playerB == -1 then
				error("触发修改角色属性事件未传入角色对象！")
			end

			return manager.ChessBoardManager:DoNextEvent()
		end
	},
	[20008] = {
		[ChessBoardConst.TIMING.ALL] = function(arg_52_0, arg_52_1)
			if playerType == 1 then
				if arg_52_0.playerA == 0 then
					local var_52_0 = arg_52_0[1] - manager.ChessBoardManager:GetHeroAttribute(attributeID)

					manager.ChessBoardManager:SubHeroAttribute(attributeID, var_52_0)
				elseif arg_52_0.playerA > 0 then
					manager.ChessBoardManager:SetNPCAttribute(arg_52_0.playerA, attributeID, arg_52_0[1])
				elseif arg_52_0.playerA == -1 then
					error("触发修改角色属性事件未传入角色对象！")
				end
			elseif arg_52_0.playerB == 0 then
				local var_52_1 = arg_52_0[1] - manager.ChessBoardManager:GetHeroAttribute(attributeID)

				manager.ChessBoardManager:SubHeroAttribute(attributeID, var_52_1)
			elseif arg_52_0.playerB > 0 then
				manager.ChessBoardManager:SetNPCAttribute(arg_52_0.playerB, attributeID, arg_52_0[1])
			elseif arg_52_0.playerB == -1 then
				error("触发修改角色属性事件未传入角色对象！")
			end

			return manager.ChessBoardManager:DoNextEvent()
		end
	}
}
