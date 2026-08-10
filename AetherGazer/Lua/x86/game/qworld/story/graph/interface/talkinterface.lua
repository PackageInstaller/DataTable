return {
	Inject = function(arg_1_0, arg_1_1)
		local var_1_0 = QWorldMgr:GetQWorldStoryMgr():GetTalkView()
		local var_1_1 = QWorldMgr:GetQWorldStoryMgr():GetBlackFade()

		function arg_1_1.SetTalkContent(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
			local var_2_0 = SandplayStoryTalkCfg[arg_2_1]

			if var_2_0 then
				arg_2_0:RememberHistory(arg_2_1)
				var_1_0:RenderContent(arg_2_1, arg_2_2, arg_2_3)

				local var_2_1 = var_2_0.voice_actor or -1

				arg_2_0.blackboard:PlayTalkSheet(var_2_1, var_2_0.cue_sheet, var_2_0.cue_name)
			else
				Debug.LogError("不存在的对话Id: " .. arg_2_1)
			end
		end

		function arg_1_1.SetNeedSkip(arg_3_0, arg_3_1, arg_3_2)
			if not arg_3_1 then
				var_1_0:SetSkipCallback(arg_3_1, nil)
			else
				var_1_0:SetSkipCallback(arg_3_1, arg_3_2)
			end
		end

		function arg_1_1.SetNeedClick(arg_4_0, arg_4_1, arg_4_2)
			if not arg_4_1 then
				var_1_0:SetNeedClickCallback(arg_4_1, nil)
			else
				var_1_0:SetNeedClickCallback(arg_4_1, arg_4_2)
			end
		end

		function arg_1_1.ShowTalkView(arg_5_0)
			var_1_0:SetCanShow(true)
			var_1_0:OnAllBtnClick()
		end

		function arg_1_1.HideTalkView(arg_6_0)
			var_1_0:SetCanShow(false)
			var_1_0:OnHideBtnClick()
		end

		function arg_1_1.SetChoice(arg_7_0, arg_7_1, arg_7_2)
			var_1_0:SetNeedClickCallback(false, nil)
			var_1_0:SetSkipCallback(false, nil)
			var_1_0:OpenChoice(arg_7_1, arg_7_2)
		end

		function arg_1_1.CloseChoice(arg_8_0)
			var_1_0:CloseChoice()
		end

		function arg_1_1.OnBlackFade(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
			var_1_1:StartFade({
				showContent = arg_9_1,
				content = arg_9_2,
				contentTime = arg_9_3,
				showTimer = arg_9_4,
				outTimer = arg_9_5,
				action = arg_9_6,
				done = arg_9_7
			})
		end

		function arg_1_1.ContinueBlackFade(arg_10_0)
			var_1_1:ContinueFade()
		end
	end
}
