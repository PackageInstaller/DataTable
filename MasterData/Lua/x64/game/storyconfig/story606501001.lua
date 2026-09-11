return {
	Play606501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 606501001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play606501002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["2590003"] == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.imageGo_, arg_1_1.canvasGo_.transform)

				var_4_0.transform:SetSiblingIndex(1)

				var_4_0.name = "2590003"

				local var_4_1 = var_4_0:GetComponent(typeof(Image))

				var_4_1.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. "2590003")

				var_4_1:SetNativeSize()

				var_4_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_["2590003"] = var_4_0
			end

			local var_4_2 = arg_1_1.actors_["2590003"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos2590003 = var_4_2.localPosition
				var_4_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_4_3 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_3 then
				var_4_2.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2590003, Vector3.New(0, 0, 0), (arg_1_1.time_ - 0) / var_4_3)
			end

			if arg_1_1.time_ >= 0 + var_4_3 and arg_1_1.time_ < 0 + var_4_3 + arg_4_0 then
				var_4_2.localPosition = Vector3.New(0, 0, 0)
			end

			local var_4_4 = 0
			local var_4_5 = 1

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[417].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_6 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(606501001).content)

				arg_1_1.text_.text = var_4_6

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_8 = 27 <= 0 and var_4_5 or var_4_5 * (utf8.len(var_4_6) / 27)

				if (27 <= 0 and var_4_5 or var_4_5 * (utf8.len(var_4_6) / 27)) > 0 and var_4_5 < var_4_8 then
					arg_1_1.talkMaxDuration = var_4_8

					if var_4_8 + var_4_4 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_8 + var_4_4
					end
				end

				arg_1_1.text_.text = var_4_6
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_9 = math.max(var_4_5, arg_1_1.talkMaxDuration)

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_9 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_4) / var_4_9

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_4 + var_4_9 and arg_1_1.time_ < var_4_4 + var_4_9 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2590003",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play606501002 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 606501002
		arg_5_1.duration_ = 5

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
			local var_8_0 = 1

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, true)

				arg_5_1.leftNameTxt_.text = arg_5_1:FormatText(StoryNameCfg[417].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_1.leftNameTxt_.transform)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1.leftNameTxt_.text)
				SetActive(arg_5_1.iconTrs_.gameObject, false)
				arg_5_1.callingController_:SetSelectedState("normal")

				local var_8_1 = arg_5_1:FormatText(arg_5_1:GetWordFromCfg(606501002).content)

				arg_5_1.text_.text = var_8_1

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_3 = 30 <= 0 and var_8_0 or var_8_0 * (utf8.len(var_8_1) / 30)

				if (30 <= 0 and var_8_0 or var_8_0 * (utf8.len(var_8_1) / 30)) > 0 and var_8_0 < var_8_3 then
					arg_5_1.talkMaxDuration = var_8_3

					if var_8_3 + 0 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_3 + 0
					end
				end

				arg_5_1.text_.text = var_8_1
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)
				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_4 = math.max(var_8_0, arg_5_1.talkMaxDuration)

			if 0 <= arg_5_1.time_ and arg_5_1.time_ < 0 + var_8_4 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - 0) / var_8_4

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= 0 + var_8_4 and arg_5_1.time_ < 0 + var_8_4 + arg_8_0 then
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
