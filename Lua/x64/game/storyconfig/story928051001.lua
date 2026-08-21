return {
	Play928051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 928051001
		arg_1_1.duration_ = 21.05

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
			arg_1_1.auto_ = false
		end

		function arg_1_1.playNext_(arg_3_0)
			arg_1_1.onStoryFinished_()
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)
				arg_1_1:PlayOnlyBgm()
				manager.video:Play("SofdecAsset/story/story_9280501.usm", function(arg_5_0)
					arg_1_1:Skip(arg_5_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_6_0)
					if arg_6_0 then
						arg_1_1.state_ = "pause"
					else
						arg_1_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_1 = 21.0333333333333

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				-- block empty
			end

			local var_4_2 = 21.0333333333333

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_3 = 0.0166666666666667

			if var_4_2 <= arg_1_1.time_ and arg_1_1.time_ < var_4_2 + var_4_3 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_2 + var_4_3 and arg_1_1.time_ < var_4_2 + var_4_3 + arg_4_0 then
				-- block empty
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	assets = {
		"SofdecAsset/story/story_9280501.usm"
	},
	voices = {}
}
