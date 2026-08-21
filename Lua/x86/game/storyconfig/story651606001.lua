return {
	Play651606001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 651606001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play651606002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.15

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_2 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_3 = arg_1_1:GetWordFromCfg(651606001)
				local var_4_4 = arg_1_1:FormatText(var_4_3.content)

				arg_1_1.text_.text = var_4_4

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_5 = 67
				local var_4_6 = utf8.len(var_4_4)
				local var_4_7 = var_4_5 <= 0 and var_4_1 or var_4_1 * (var_4_6 / var_4_5)

				if var_4_7 > 0 and var_4_1 < var_4_7 then
					arg_1_1.talkMaxDuration = var_4_7

					if var_4_7 + var_4_0 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_7 + var_4_0
					end
				end

				arg_1_1.text_.text = var_4_4
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_8 = math.max(var_4_1, arg_1_1.talkMaxDuration)

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_8 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_0) / var_4_8

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_0 + var_4_8 and arg_1_1.time_ < var_4_0 + var_4_8 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play651606002 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 651606002
		arg_5_1.duration_ = 1

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
			arg_5_1.auto_ = false
		end

		function arg_5_1.playNext_(arg_7_0)
			arg_5_1.onStoryFinished_()
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			local var_8_0 = 0
			local var_8_1 = 0.15

			if var_8_0 < arg_5_1.time_ and arg_5_1.time_ <= var_8_0 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, true)

				local var_8_2 = arg_5_1:FormatText(StoryNameCfg[6].name)

				arg_5_1.leftNameTxt_.text = var_8_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_1.leftNameTxt_.transform)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1.leftNameTxt_.text)
				SetActive(arg_5_1.iconTrs_.gameObject, false)
				arg_5_1.callingController_:SetSelectedState("normal")

				local var_8_3 = arg_5_1:GetWordFromCfg(651606002)
				local var_8_4 = arg_5_1:FormatText(var_8_3.content)

				arg_5_1.text_.text = var_8_4

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_5 = 0
				local var_8_6 = utf8.len(var_8_4)
				local var_8_7 = var_8_5 <= 0 and var_8_1 or var_8_1 * (var_8_6 / var_8_5)

				if var_8_7 > 0 and var_8_1 < var_8_7 then
					arg_5_1.talkMaxDuration = var_8_7

					if var_8_7 + var_8_0 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_7 + var_8_0
					end
				end

				arg_5_1.text_.text = var_8_4
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)
				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_8 = math.max(var_8_1, arg_5_1.talkMaxDuration)

			if var_8_0 <= arg_5_1.time_ and arg_5_1.time_ < var_8_0 + var_8_8 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - var_8_0) / var_8_8

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= var_8_0 + var_8_8 and arg_5_1.time_ < var_8_0 + var_8_8 + arg_8_0 then
				arg_5_1.typewritter.percent = 1

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(true)
			end
		end

		arg_5_1.nodeConfigList_ = {}

		arg_5_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {}
}
