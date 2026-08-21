return {
	Init = function(arg_1_0)
		_GRAPH_API = {}

		function _GRAPH_API.QuestGetProg(arg_2_0)
			return QWorldQuestTool.GetQuestProgress(arg_2_0)
		end

		function _GRAPH_API.QuestSetParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
			QWorldMgr:GetQWorldQuestMgr():QuestSetParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		end

		function _GRAPH_API.QuestSetFinish(arg_4_0, arg_4_1, arg_4_2)
			_GRAPH_API.QuestSetParam(arg_4_0, arg_4_1, 1, arg_4_2)
		end

		function _GRAPH_API.QuestIncLocalProgress(arg_5_0, arg_5_1)
			QWorldQuestGraph:IncreaseQuestLocalProgress(arg_5_0, arg_5_1)
		end

		function _GRAPH_API.ThingCreate(arg_6_0)
			QWorldSpawnPrefabByEntityId(arg_6_0)
		end

		function _GRAPH_API.ThingDestroy(arg_7_0)
			QWorldRemovePrefabByEntityId(arg_7_0)
		end

		function _GRAPH_API.CreateDrop(arg_8_0, arg_8_1, arg_8_2)
			_GRAPH_API.ThingCreate(arg_8_0)
			_GRAPH_API.EntityInteractEnable(arg_8_0)

			local var_8_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_8_0)

			if not var_8_0 then
				printf("无法找到实体id = %d", arg_8_0)
				Debug.LogError(string.format("无法找到实体id = %d", arg_8_0))

				return
			end

			if arg_8_1 and var_8_0.InitDropEffect then
				var_8_0:InitDropEffect()
			end

			function var_8_0.performCallback()
				_GRAPH_API.ThingDestroy(arg_8_0)
				arg_8_2()

				var_8_0.performCallback = nil
			end
		end

		function _GRAPH_API.PlayStory(arg_10_0, arg_10_1, arg_10_2)
			local var_10_0

			if arg_10_2 then
				var_10_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_10_2)
			end

			QWorldMgr:GetQWorldQuestMgr():SetStoryEndCallback(arg_10_0, function()
				QWorldMgr:GetQWorldQuestMgr():SetStoryEndCallback(arg_10_0, nil)
				arg_10_1()
			end)
			QWorldMgr:GetQWorldStoryMgr():StartStory(arg_10_0, var_10_0)
		end

		function _GRAPH_API.PlayTalk(arg_12_0, arg_12_1)
			QWorldStartTalkList(QWStoryConst.TalkViewType.SimpleTalk, {
				arg_12_0
			}, function()
				QWorldCloseTalk(QWStoryConst.TalkViewType.SimpleTalk)
				arg_12_1()
			end)
		end

		function _GRAPH_API.PlayTalkList(arg_14_0, arg_14_1)
			QWorldStartTalkList(QWStoryConst.TalkViewType.SimpleTalk, arg_14_0, function()
				QWorldCloseTalk(QWStoryConst.TalkViewType.SimpleTalk)
				arg_14_1()
			end)
		end

		function _GRAPH_API.PlayCommonStory(arg_16_0, arg_16_1)
			local var_16_0 = QWorldData:GetCurSceneName()
			local var_16_1

			if var_16_0 then
				var_16_1 = manager.ui:GetSceneSettingBySceneName(var_16_0)
			end

			if var_16_1 then
				var_16_1.enabled = false
			end

			manager.story:StartStoryById(arg_16_0, function()
				if var_16_1 then
					var_16_1.enabled = true
				end

				PlayQWorldBgm()
				QWorldUIShow()

				local var_17_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_17_0 then
					var_17_0.shadowRotationImmediately = true
				end

				arg_16_1()
			end)
			manager.ui:UIEventEnabledByUI(true)
		end

		function _GRAPH_API.PlayCommonStoryLoading(arg_18_0)
			local function var_18_0()
				LuaExchangeHelper.LoadEmpty(LuaHelper.VoidAction(function()
					CheckManagers()
					manager.story:StartStoryById(arg_18_0, function()
						local var_21_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

						if var_21_0 then
							var_21_0.shadowRotationImmediately = true
						end

						LaunchQWorld(true)
					end)
				end))
			end

			if QWorldMgr:GetQWorldQuestMgr():IsSendingQuestFinish() then
				_GRAPH_API.Delay(0.1, function()
					_GRAPH_API.PlayCommonStoryLoading(arg_18_0)
				end)
			else
				var_18_0()
			end
		end

		local function var_1_0(arg_23_0)
			local var_23_0 = gameContext:GetLastOpenPage()

			if var_23_0 == "qworldMainHome" then
				gameContext:GetOpenPageHandler(var_23_0):EnableInteraction(arg_23_0)
			else
				local var_23_1 = ReduxFactory.GetInstance().reduxViewDic_.qworldMainHome

				if var_23_1 then
					var_23_1:EnableInteraction(arg_23_0)
				else
					print("未找到箱庭主界面")
				end
			end
		end

		function _GRAPH_API.UIInteractEnable()
			var_1_0(true)
		end

		function _GRAPH_API.UIInteractDisable()
			var_1_0(false)
		end

		local function var_1_1(arg_26_0, arg_26_1, arg_26_2)
			local var_26_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_26_0)

			if not var_26_0 then
				if not arg_26_2 then
					Debug.LogError(string.format("无法找到实体id = %d", arg_26_0))
				else
					printf("无法找到实体id = %d", arg_26_0)
				end

				return
			end

			if var_26_0.ChangeInteractive then
				var_26_0:ChangeInteractive(arg_26_1)
			end
		end

		function _GRAPH_API.EntityInteractEnable(arg_27_0, arg_27_1)
			var_1_1(arg_27_0, true, arg_27_1)
		end

		function _GRAPH_API.EntityInteractDisable(arg_28_0, arg_28_1)
			var_1_1(arg_28_0, false, arg_28_1)
		end

		function _GRAPH_API.BubbleOptionAdd(arg_29_0, arg_29_1, arg_29_2)
			local var_29_0 = arg_29_0
			local var_29_1 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_29_1)

			if not var_29_1 then
				printf("无法为实体%d添加气泡, 实体不存在!", arg_29_1)
				Debug.LogError(string.format("无法为实体%d添加气泡, 实体不存在!", arg_29_1))

				return
			end

			local var_29_2 = SandplayTaskCfg[arg_29_0]

			var_29_1:AddQuestTag(var_29_0, var_29_2.task_tag, function()
				arg_29_2()
			end)
		end

		function _GRAPH_API.BubbleOptionRemove(arg_31_0, arg_31_1)
			local var_31_0 = arg_31_0
			local var_31_1 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_31_1)

			if not var_31_1 then
				printf("无法为实体%d删除气泡, 实体不存在!", arg_31_1)
				Debug.LogError(string.format("无法为实体%d删除气泡, 实体不存在!", arg_31_1))

				return
			end

			var_31_1:RemoveQuestTag(var_31_0)
		end

		function _GRAPH_API.ZoneEnable(arg_32_0)
			QWorldSpawnPrefabByEntityId(arg_32_0)
		end

		function _GRAPH_API.ZoneDisable(arg_33_0)
			QWorldRemovePrefabByEntityId(arg_33_0)
		end

		function _GRAPH_API.PlayerTeleport(arg_34_0, arg_34_1)
			QWorldTeleport(arg_34_0, arg_34_1)
		end

		function _GRAPH_API.NpcMove(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
			local var_35_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_35_0)

			if not var_35_0 then
				printf("无法移动%d, 实体不存在!", arg_35_0)
				Debug.LogError(string.format("无法移动%d, 实体不存在!", arg_35_0))

				return
			end

			local var_35_1 = QWorldLuaBridge.GetPatrolPath(arg_35_1)

			if var_35_1 == nil then
				printf("无法找到路径! id = %d", arg_35_1)
				Debug.LogError(string.format("无法找到路径! id = %d", arg_35_1))

				return
			end

			if var_35_0.StartSeeker then
				var_35_0:StartSeeker(var_35_1, 99999, arg_35_3, nil, nil, 0.01, arg_35_2 == 1)
			else
				printf("实体%d没有跟随功能!", arg_35_0)
			end
		end

		function _GRAPH_API.FollowNpc(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6)
			local var_36_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_36_0)

			if not var_36_0 then
				printf("无法跟随%d, 实体不存在!", arg_36_0)
				Debug.LogError(string.format("无法跟随%d, 实体不存在!", arg_36_0))

				return
			end

			local var_36_1 = QWorldLuaBridge.GetPatrolPath(arg_36_1)

			if var_36_1 == nil then
				printf("无法找到路径! id = %d", arg_36_1)
				Debug.LogError(string.format("无法找到路径! id = %d", arg_36_1))

				return
			end

			if var_36_0.StartSeeker then
				if not arg_36_6 then
					var_36_0:StartSeeker(var_36_1, arg_36_3, arg_36_5, nil, arg_36_4, 0.01, arg_36_2 == 1)
				else
					var_36_0:StartSeeker(var_36_1, arg_36_3, arg_36_5, nil, arg_36_4, 0.01, arg_36_2 == 1, {
						enableInteraction = arg_36_6.enableInteraction or false,
						mode = arg_36_6.mode
					})
				end
			else
				printf("实体%d没有跟随功能!", arg_36_0)
			end
		end

		function _GRAPH_API.EnterScene(arg_37_0)
			print(string.format("蓝图调用进入场景%s", arg_37_0))
			QWorldLuaBridge.Restart(arg_37_0)
		end

		function _GRAPH_API.EnterBattle(arg_38_0, arg_38_1)
			arg_38_1 = arg_38_1 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT

			local var_38_0 = BattleStageTools.GetStageCfg(arg_38_1, arg_38_0)

			gameContext:Go("/sectionSelectHero", {
				section = arg_38_0,
				sectionType = arg_38_1
			})
		end

		function _GRAPH_API.GotoTag(arg_39_0, arg_39_1)
			QWorldMgr:GetQWorldTagMgr():GotoTag(arg_39_0, arg_39_1)
		end

		function _GRAPH_API.AddTag(arg_40_0, arg_40_1)
			local var_40_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_40_1)

			if not var_40_0 then
				printf("无法为实体%d添加Tag, 实体不存在!", arg_40_1)
				Debug.LogError(string.format("无法为实体%d添加Tag, 实体不存在!", arg_40_1))

				return
			end

			var_40_0:AddTagFromTagSystem(arg_40_0)
		end

		function _GRAPH_API.RemoveTag(arg_41_0, arg_41_1)
			local var_41_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_41_1)

			if not var_41_0 then
				printf("无法为实体%d添加Tag, 实体不存在!", arg_41_1)
				Debug.LogError(string.format("无法为实体%d添加Tag, 实体不存在!", arg_41_1))

				return
			end

			var_41_0:RemoveTagFromTagSystem(arg_41_0)
		end

		function _GRAPH_API.OpenUIPredefined(arg_42_0)
			if arg_42_0 == 1 then
				JumpTools.JumpToPage2({
					518
				})
			else
				print("未找到预定义页面")
			end
		end

		function _GRAPH_API.Delay(arg_43_0, arg_43_1)
			local var_43_0 = Timer.New(arg_43_1, arg_43_0, 0)

			QWorldQuestGraph:StartTimer(var_43_0)
		end
	end,
	Clear = function(arg_44_0)
		_GRAPH_API = nil
	end
}
