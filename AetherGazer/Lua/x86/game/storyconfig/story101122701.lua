return {
	Play112271001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112271001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112271002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1.1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_2 = arg_1_1:GetWordFromCfg(112271001)
				local var_4_3 = arg_1_1:FormatText(var_4_2.content)

				arg_1_1.text_.text = var_4_3

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_4 = 44
				local var_4_5 = utf8.len(var_4_3)
				local var_4_6 = var_4_4 <= 0 and var_4_1 or var_4_1 * (var_4_5 / var_4_4)

				if var_4_6 > 0 and var_4_1 < var_4_6 then
					arg_1_1.talkMaxDuration = var_4_6

					if var_4_6 + var_4_0 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_6 + var_4_0
					end
				end

				arg_1_1.text_.text = var_4_3
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_7 = math.max(var_4_1, arg_1_1.talkMaxDuration)

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_7 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_0) / var_4_7

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_0 + var_4_7 and arg_1_1.time_ < var_4_0 + var_4_7 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112271002 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 112271002
		arg_5_1.duration_ = 5

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play112271003(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			local var_8_0 = 0
			local var_8_1 = 0.875

			if var_8_0 < arg_5_1.time_ and arg_5_1.time_ <= var_8_0 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, false)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_5_1.iconTrs_.gameObject, false)
				arg_5_1.callingController_:SetSelectedState("normal")

				local var_8_2 = arg_5_1:GetWordFromCfg(112271002)
				local var_8_3 = arg_5_1:FormatText(var_8_2.content)

				arg_5_1.text_.text = var_8_3

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_4 = 35
				local var_8_5 = utf8.len(var_8_3)
				local var_8_6 = var_8_4 <= 0 and var_8_1 or var_8_1 * (var_8_5 / var_8_4)

				if var_8_6 > 0 and var_8_1 < var_8_6 then
					arg_5_1.talkMaxDuration = var_8_6

					if var_8_6 + var_8_0 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_6 + var_8_0
					end
				end

				arg_5_1.text_.text = var_8_3
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)
				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_7 = math.max(var_8_1, arg_5_1.talkMaxDuration)

			if var_8_0 <= arg_5_1.time_ and arg_5_1.time_ < var_8_0 + var_8_7 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - var_8_0) / var_8_7

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= var_8_0 + var_8_7 and arg_5_1.time_ < var_8_0 + var_8_7 + arg_8_0 then
				arg_5_1.typewritter.percent = 1

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(true)
			end
		end

		arg_5_1.nodeConfigList_ = {}

		arg_5_1:InitPlayNodeList()
	end,
	Play112271003 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 112271003
		arg_9_1.duration_ = 7.4

		local var_9_0 = {
			ja = 6.9,
			ko = 6.333,
			zh = 7.4,
			en = 4.6
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play112271004(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1084"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Object.Instantiate(arg_9_1.imageGo_, arg_9_1.canvasGo_.transform)

				var_12_1.transform:SetSiblingIndex(1)

				var_12_1.name = var_12_0

				local var_12_2 = var_12_1:GetComponent(typeof(Image))

				var_12_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1084")

				var_12_2:SetNativeSize()

				var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_9_1.actors_[var_12_0] = var_12_1
			end

			local var_12_3 = arg_9_1.actors_["1084"].transform
			local var_12_4 = 0

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084 = var_12_3.localPosition
				var_12_3.localScale = Vector3.New(1, 1, 1)
			end

			local var_12_5 = 0.001

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_5 then
				local var_12_6 = (arg_9_1.time_ - var_12_4) / var_12_5
				local var_12_7 = Vector3.New(0, -450, 0)

				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084, var_12_7, var_12_6)
			end

			if arg_9_1.time_ >= var_12_4 + var_12_5 and arg_9_1.time_ < var_12_4 + var_12_5 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -450, 0)
			end

			local var_12_8 = arg_9_1.actors_["1084"]
			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 and not isNil(var_12_8) then
				local var_12_10 = var_12_8:GetComponent("Image")

				if var_12_10 then
					arg_9_1.var_.highlightMatValue1084 = var_12_10
				end
			end

			local var_12_11 = 0.2

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_11 and not isNil(var_12_8) then
				local var_12_12 = (arg_9_1.time_ - var_12_9) / var_12_11

				if arg_9_1.var_.highlightMatValue1084 then
					local var_12_13 = Mathf.Lerp(0.5, 1, var_12_12)
					local var_12_14 = arg_9_1.var_.highlightMatValue1084
					local var_12_15 = var_12_14.color

					var_12_15.r = var_12_13
					var_12_15.g = var_12_13
					var_12_15.b = var_12_13
					var_12_14.color = var_12_15
				end
			end

			if arg_9_1.time_ >= var_12_9 + var_12_11 and arg_9_1.time_ < var_12_9 + var_12_11 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.highlightMatValue1084 then
				local var_12_16 = 1

				var_12_8.transform:SetSiblingIndex(1)

				local var_12_17 = arg_9_1.var_.highlightMatValue1084
				local var_12_18 = var_12_17.color

				var_12_18.r = var_12_16
				var_12_18.g = var_12_16
				var_12_18.b = var_12_16
				var_12_17.color = var_12_18
			end

			local var_12_19 = 0
			local var_12_20 = 0.475

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_21 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_22 = arg_9_1:GetWordFromCfg(112271003)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_24 = 19
				local var_12_25 = utf8.len(var_12_23)
				local var_12_26 = var_12_24 <= 0 and var_12_20 or var_12_20 * (var_12_25 / var_12_24)

				if var_12_26 > 0 and var_12_20 < var_12_26 then
					arg_9_1.talkMaxDuration = var_12_26

					if var_12_26 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_19
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271003", "story_v_out_112271.awb") ~= 0 then
					local var_12_27 = manager.audio:GetVoiceLength("story_v_out_112271", "112271003", "story_v_out_112271.awb") / 1000

					if var_12_27 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_19
					end

					if var_12_22.prefab_name ~= "" and arg_9_1.actors_[var_12_22.prefab_name] ~= nil then
						local var_12_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_22.prefab_name].transform, "story_v_out_112271", "112271003", "story_v_out_112271.awb")

						arg_9_1:RecordAudio("112271003", var_12_28)
						arg_9_1:RecordAudio("112271003", var_12_28)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_112271", "112271003", "story_v_out_112271.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_112271", "112271003", "story_v_out_112271.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_29 = math.max(var_12_20, arg_9_1.talkMaxDuration)

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_29 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_19) / var_12_29

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_19 + var_12_29 and arg_9_1.time_ < var_12_19 + var_12_29 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play112271004 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 112271004
		arg_13_1.duration_ = 6.9

		local var_13_0 = {
			ja = 6.9,
			ko = 5.5,
			zh = 5.666,
			en = 6.066
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play112271005(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1084"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1084 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -2000, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1084, var_16_4, var_16_3)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_16_5 = "1027"

			if arg_13_1.actors_[var_16_5] == nil then
				local var_16_6 = Object.Instantiate(arg_13_1.imageGo_, arg_13_1.canvasGo_.transform)

				var_16_6.transform:SetSiblingIndex(1)

				var_16_6.name = var_16_5

				local var_16_7 = var_16_6:GetComponent(typeof(Image))

				var_16_7.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1027")

				var_16_7:SetNativeSize()

				var_16_6.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_13_1.actors_[var_16_5] = var_16_6
			end

			local var_16_8 = arg_13_1.actors_["1027"].transform
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.var_.moveOldPos1027 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)
			end

			local var_16_10 = 0.001

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_10 then
				local var_16_11 = (arg_13_1.time_ - var_16_9) / var_16_10
				local var_16_12 = Vector3.New(0, -450, 0)

				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1027, var_16_12, var_16_11)
			end

			if arg_13_1.time_ >= var_16_9 + var_16_10 and arg_13_1.time_ < var_16_9 + var_16_10 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, -450, 0)
			end

			local var_16_13 = arg_13_1.actors_["1027"]
			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 and not isNil(var_16_13) then
				local var_16_15 = var_16_13:GetComponent("Image")

				if var_16_15 then
					arg_13_1.var_.highlightMatValue1027 = var_16_15
				end
			end

			local var_16_16 = 0.2

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_16 and not isNil(var_16_13) then
				local var_16_17 = (arg_13_1.time_ - var_16_14) / var_16_16

				if arg_13_1.var_.highlightMatValue1027 then
					local var_16_18 = Mathf.Lerp(0.5, 1, var_16_17)
					local var_16_19 = arg_13_1.var_.highlightMatValue1027
					local var_16_20 = var_16_19.color

					var_16_20.r = var_16_18
					var_16_20.g = var_16_18
					var_16_20.b = var_16_18
					var_16_19.color = var_16_20
				end
			end

			if arg_13_1.time_ >= var_16_14 + var_16_16 and arg_13_1.time_ < var_16_14 + var_16_16 + arg_16_0 and not isNil(var_16_13) and arg_13_1.var_.highlightMatValue1027 then
				local var_16_21 = 1

				var_16_13.transform:SetSiblingIndex(1)

				local var_16_22 = arg_13_1.var_.highlightMatValue1027
				local var_16_23 = var_16_22.color

				var_16_23.r = var_16_21
				var_16_23.g = var_16_21
				var_16_23.b = var_16_21
				var_16_22.color = var_16_23
			end

			local var_16_24 = 0
			local var_16_25 = 0.625

			if var_16_24 < arg_13_1.time_ and arg_13_1.time_ <= var_16_24 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_26 = arg_13_1:FormatText(StoryNameCfg[56].name)

				arg_13_1.leftNameTxt_.text = var_16_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_27 = arg_13_1:GetWordFromCfg(112271004)
				local var_16_28 = arg_13_1:FormatText(var_16_27.content)

				arg_13_1.text_.text = var_16_28

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_29 = 25
				local var_16_30 = utf8.len(var_16_28)
				local var_16_31 = var_16_29 <= 0 and var_16_25 or var_16_25 * (var_16_30 / var_16_29)

				if var_16_31 > 0 and var_16_25 < var_16_31 then
					arg_13_1.talkMaxDuration = var_16_31

					if var_16_31 + var_16_24 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_31 + var_16_24
					end
				end

				arg_13_1.text_.text = var_16_28
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271004", "story_v_out_112271.awb") ~= 0 then
					local var_16_32 = manager.audio:GetVoiceLength("story_v_out_112271", "112271004", "story_v_out_112271.awb") / 1000

					if var_16_32 + var_16_24 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_32 + var_16_24
					end

					if var_16_27.prefab_name ~= "" and arg_13_1.actors_[var_16_27.prefab_name] ~= nil then
						local var_16_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_27.prefab_name].transform, "story_v_out_112271", "112271004", "story_v_out_112271.awb")

						arg_13_1:RecordAudio("112271004", var_16_33)
						arg_13_1:RecordAudio("112271004", var_16_33)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_112271", "112271004", "story_v_out_112271.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_112271", "112271004", "story_v_out_112271.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_34 = math.max(var_16_25, arg_13_1.talkMaxDuration)

			if var_16_24 <= arg_13_1.time_ and arg_13_1.time_ < var_16_24 + var_16_34 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_24) / var_16_34

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_24 + var_16_34 and arg_13_1.time_ < var_16_24 + var_16_34 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "1027",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play112271005 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 112271005
		arg_17_1.duration_ = 9.1

		local var_17_0 = {
			ja = 9.1,
			ko = 7.866,
			zh = 7.133,
			en = 7.4
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play112271006(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1027"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1027 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -2000, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1027, var_20_4, var_20_3)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_5 = "1148"

			if arg_17_1.actors_[var_20_5] == nil then
				local var_20_6 = Object.Instantiate(arg_17_1.imageGo_, arg_17_1.canvasGo_.transform)

				var_20_6.transform:SetSiblingIndex(1)

				var_20_6.name = var_20_5

				local var_20_7 = var_20_6:GetComponent(typeof(Image))

				var_20_7.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1148")

				var_20_7:SetNativeSize()

				var_20_6.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_17_1.actors_[var_20_5] = var_20_6
			end

			local var_20_8 = arg_17_1.actors_["1148"].transform
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.var_.moveOldPos1148 = var_20_8.localPosition
				var_20_8.localScale = Vector3.New(1, 1, 1)
			end

			local var_20_10 = 0.001

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10
				local var_20_12 = Vector3.New(0, -500, 0)

				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1148, var_20_12, var_20_11)
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(0, -500, 0)
			end

			local var_20_13 = arg_17_1.actors_["1148"]
			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 and not isNil(var_20_13) then
				local var_20_15 = var_20_13:GetComponent("Image")

				if var_20_15 then
					arg_17_1.var_.highlightMatValue1148 = var_20_15
				end
			end

			local var_20_16 = 0.2

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_16 and not isNil(var_20_13) then
				local var_20_17 = (arg_17_1.time_ - var_20_14) / var_20_16

				if arg_17_1.var_.highlightMatValue1148 then
					local var_20_18 = Mathf.Lerp(0.5, 1, var_20_17)
					local var_20_19 = arg_17_1.var_.highlightMatValue1148
					local var_20_20 = var_20_19.color

					var_20_20.r = var_20_18
					var_20_20.g = var_20_18
					var_20_20.b = var_20_18
					var_20_19.color = var_20_20
				end
			end

			if arg_17_1.time_ >= var_20_14 + var_20_16 and arg_17_1.time_ < var_20_14 + var_20_16 + arg_20_0 and not isNil(var_20_13) and arg_17_1.var_.highlightMatValue1148 then
				local var_20_21 = 1

				var_20_13.transform:SetSiblingIndex(1)

				local var_20_22 = arg_17_1.var_.highlightMatValue1148
				local var_20_23 = var_20_22.color

				var_20_23.r = var_20_21
				var_20_23.g = var_20_21
				var_20_23.b = var_20_21
				var_20_22.color = var_20_23
			end

			local var_20_24 = 0
			local var_20_25 = 1.025

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_26 = arg_17_1:FormatText(StoryNameCfg[8].name)

				arg_17_1.leftNameTxt_.text = var_20_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_27 = arg_17_1:GetWordFromCfg(112271005)
				local var_20_28 = arg_17_1:FormatText(var_20_27.content)

				arg_17_1.text_.text = var_20_28

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_29 = 41
				local var_20_30 = utf8.len(var_20_28)
				local var_20_31 = var_20_29 <= 0 and var_20_25 or var_20_25 * (var_20_30 / var_20_29)

				if var_20_31 > 0 and var_20_25 < var_20_31 then
					arg_17_1.talkMaxDuration = var_20_31

					if var_20_31 + var_20_24 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_24
					end
				end

				arg_17_1.text_.text = var_20_28
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271005", "story_v_out_112271.awb") ~= 0 then
					local var_20_32 = manager.audio:GetVoiceLength("story_v_out_112271", "112271005", "story_v_out_112271.awb") / 1000

					if var_20_32 + var_20_24 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_32 + var_20_24
					end

					if var_20_27.prefab_name ~= "" and arg_17_1.actors_[var_20_27.prefab_name] ~= nil then
						local var_20_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_27.prefab_name].transform, "story_v_out_112271", "112271005", "story_v_out_112271.awb")

						arg_17_1:RecordAudio("112271005", var_20_33)
						arg_17_1:RecordAudio("112271005", var_20_33)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_112271", "112271005", "story_v_out_112271.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_112271", "112271005", "story_v_out_112271.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_34 = math.max(var_20_25, arg_17_1.talkMaxDuration)

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_34 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_24) / var_20_34

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_24 + var_20_34 and arg_17_1.time_ < var_20_24 + var_20_34 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play112271006 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 112271006
		arg_21_1.duration_ = 5.27

		local var_21_0 = {
			ja = 4.866,
			ko = 4.233,
			zh = 3,
			en = 5.266
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play112271007(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.45

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(112271006)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 18
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271006", "story_v_out_112271.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_112271", "112271006", "story_v_out_112271.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_112271", "112271006", "story_v_out_112271.awb")

						arg_21_1:RecordAudio("112271006", var_24_9)
						arg_21_1:RecordAudio("112271006", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_112271", "112271006", "story_v_out_112271.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_112271", "112271006", "story_v_out_112271.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play112271007 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 112271007
		arg_25_1.duration_ = 5.9

		local var_25_0 = {
			ja = 5.9,
			ko = 2.566,
			zh = 2.833,
			en = 3.8
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play112271008(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1148"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, -2000, -5)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, var_28_4, var_28_3)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -2000, -5)
			end

			local var_28_5 = "1081_1"

			if arg_25_1.actors_[var_28_5] == nil then
				local var_28_6 = Object.Instantiate(arg_25_1.imageGo_, arg_25_1.canvasGo_.transform)

				var_28_6.transform:SetSiblingIndex(1)

				var_28_6.name = var_28_5

				local var_28_7 = var_28_6:GetComponent(typeof(Image))

				var_28_7.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081_1")

				var_28_7:SetNativeSize()

				var_28_6.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_25_1.actors_[var_28_5] = var_28_6
			end

			local var_28_8 = arg_25_1.actors_["1081_1"].transform
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.var_.moveOldPos1081_1 = var_28_8.localPosition
				var_28_8.localScale = Vector3.New(1, 1, 1)
			end

			local var_28_10 = 0.001

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10
				local var_28_12 = Vector3.New(-500, -300, 0)

				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1081_1, var_28_12, var_28_11)
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_28_13 = "1081"

			if arg_25_1.actors_[var_28_13] == nil then
				local var_28_14 = Object.Instantiate(arg_25_1.imageGo_, arg_25_1.canvasGo_.transform)

				var_28_14.transform:SetSiblingIndex(1)

				var_28_14.name = var_28_13

				local var_28_15 = var_28_14:GetComponent(typeof(Image))

				var_28_15.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081")

				var_28_15:SetNativeSize()

				var_28_14.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_25_1.actors_[var_28_13] = var_28_14
			end

			local var_28_16 = arg_25_1.actors_["1081"]
			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 and not isNil(var_28_16) then
				local var_28_18 = var_28_16:GetComponent("Image")

				if var_28_18 then
					arg_25_1.var_.highlightMatValue1081 = var_28_18
				end
			end

			local var_28_19 = 0.2

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_19 and not isNil(var_28_16) then
				local var_28_20 = (arg_25_1.time_ - var_28_17) / var_28_19

				if arg_25_1.var_.highlightMatValue1081 then
					local var_28_21 = Mathf.Lerp(0.5, 1, var_28_20)
					local var_28_22 = arg_25_1.var_.highlightMatValue1081
					local var_28_23 = var_28_22.color

					var_28_23.r = var_28_21
					var_28_23.g = var_28_21
					var_28_23.b = var_28_21
					var_28_22.color = var_28_23
				end
			end

			if arg_25_1.time_ >= var_28_17 + var_28_19 and arg_25_1.time_ < var_28_17 + var_28_19 + arg_28_0 and not isNil(var_28_16) and arg_25_1.var_.highlightMatValue1081 then
				local var_28_24 = 1

				var_28_16.transform:SetSiblingIndex(1)

				local var_28_25 = arg_25_1.var_.highlightMatValue1081
				local var_28_26 = var_28_25.color

				var_28_26.r = var_28_24
				var_28_26.g = var_28_24
				var_28_26.b = var_28_24
				var_28_25.color = var_28_26
			end

			local var_28_27 = 0
			local var_28_28 = 0.375

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_29 = arg_25_1:FormatText(StoryNameCfg[202].name)

				arg_25_1.leftNameTxt_.text = var_28_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_30 = arg_25_1:GetWordFromCfg(112271007)
				local var_28_31 = arg_25_1:FormatText(var_28_30.content)

				arg_25_1.text_.text = var_28_31

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_32 = 15
				local var_28_33 = utf8.len(var_28_31)
				local var_28_34 = var_28_32 <= 0 and var_28_28 or var_28_28 * (var_28_33 / var_28_32)

				if var_28_34 > 0 and var_28_28 < var_28_34 then
					arg_25_1.talkMaxDuration = var_28_34

					if var_28_34 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_34 + var_28_27
					end
				end

				arg_25_1.text_.text = var_28_31
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271007", "story_v_out_112271.awb") ~= 0 then
					local var_28_35 = manager.audio:GetVoiceLength("story_v_out_112271", "112271007", "story_v_out_112271.awb") / 1000

					if var_28_35 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_35 + var_28_27
					end

					if var_28_30.prefab_name ~= "" and arg_25_1.actors_[var_28_30.prefab_name] ~= nil then
						local var_28_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_30.prefab_name].transform, "story_v_out_112271", "112271007", "story_v_out_112271.awb")

						arg_25_1:RecordAudio("112271007", var_28_36)
						arg_25_1:RecordAudio("112271007", var_28_36)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_112271", "112271007", "story_v_out_112271.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_112271", "112271007", "story_v_out_112271.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_37 = math.max(var_28_28, arg_25_1.talkMaxDuration)

			if var_28_27 <= arg_25_1.time_ and arg_25_1.time_ < var_28_27 + var_28_37 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_27) / var_28_37

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_27 + var_28_37 and arg_25_1.time_ < var_28_27 + var_28_37 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "1081_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play112271008 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 112271008
		arg_29_1.duration_ = 7.03

		local var_29_0 = {
			ja = 7.033,
			ko = 5.133,
			zh = 4.666,
			en = 5.033
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play112271009(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.625

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[202].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(112271008)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 25
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271008", "story_v_out_112271.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_112271", "112271008", "story_v_out_112271.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_112271", "112271008", "story_v_out_112271.awb")

						arg_29_1:RecordAudio("112271008", var_32_9)
						arg_29_1:RecordAudio("112271008", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_112271", "112271008", "story_v_out_112271.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_112271", "112271008", "story_v_out_112271.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play112271009 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 112271009
		arg_33_1.duration_ = 14.63

		local var_33_0 = {
			ja = 14.633,
			ko = 8.9,
			zh = 8.4,
			en = 9.833
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play112271010(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.125

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[202].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(112271009)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 45
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271009", "story_v_out_112271.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_112271", "112271009", "story_v_out_112271.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_112271", "112271009", "story_v_out_112271.awb")

						arg_33_1:RecordAudio("112271009", var_36_9)
						arg_33_1:RecordAudio("112271009", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_112271", "112271009", "story_v_out_112271.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_112271", "112271009", "story_v_out_112271.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play112271010 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 112271010
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play112271011(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1081"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) then
				local var_40_2 = var_40_0:GetComponent("Image")

				if var_40_2 then
					arg_37_1.var_.highlightMatValue1081 = var_40_2
				end
			end

			local var_40_3 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_3 and not isNil(var_40_0) then
				local var_40_4 = (arg_37_1.time_ - var_40_1) / var_40_3

				if arg_37_1.var_.highlightMatValue1081 then
					local var_40_5 = Mathf.Lerp(1, 0.5, var_40_4)
					local var_40_6 = arg_37_1.var_.highlightMatValue1081
					local var_40_7 = var_40_6.color

					var_40_7.r = var_40_5
					var_40_7.g = var_40_5
					var_40_7.b = var_40_5
					var_40_6.color = var_40_7
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_3 and arg_37_1.time_ < var_40_1 + var_40_3 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.highlightMatValue1081 then
				local var_40_8 = 0.5
				local var_40_9 = arg_37_1.var_.highlightMatValue1081
				local var_40_10 = var_40_9.color

				var_40_10.r = var_40_8
				var_40_10.g = var_40_8
				var_40_10.b = var_40_8
				var_40_9.color = var_40_10
			end

			local var_40_11 = 0
			local var_40_12 = 0.375

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_14 = arg_37_1:GetWordFromCfg(112271010)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 15
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_19 and arg_37_1.time_ < var_40_11 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play112271011 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 112271011
		arg_41_1.duration_ = 5.8

		local var_41_0 = {
			ja = 4.9,
			ko = 5.2,
			zh = 5.666,
			en = 5.8
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play112271012(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1081"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) then
				local var_44_2 = var_44_0:GetComponent("Image")

				if var_44_2 then
					arg_41_1.var_.highlightMatValue1081 = var_44_2
				end
			end

			local var_44_3 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_3 and not isNil(var_44_0) then
				local var_44_4 = (arg_41_1.time_ - var_44_1) / var_44_3

				if arg_41_1.var_.highlightMatValue1081 then
					local var_44_5 = Mathf.Lerp(0.5, 1, var_44_4)
					local var_44_6 = arg_41_1.var_.highlightMatValue1081
					local var_44_7 = var_44_6.color

					var_44_7.r = var_44_5
					var_44_7.g = var_44_5
					var_44_7.b = var_44_5
					var_44_6.color = var_44_7
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_3 and arg_41_1.time_ < var_44_1 + var_44_3 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.highlightMatValue1081 then
				local var_44_8 = 1

				var_44_0.transform:SetSiblingIndex(1)

				local var_44_9 = arg_41_1.var_.highlightMatValue1081
				local var_44_10 = var_44_9.color

				var_44_10.r = var_44_8
				var_44_10.g = var_44_8
				var_44_10.b = var_44_8
				var_44_9.color = var_44_10
			end

			local var_44_11 = 0
			local var_44_12 = 0.75

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_13 = arg_41_1:FormatText(StoryNameCfg[202].name)

				arg_41_1.leftNameTxt_.text = var_44_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(112271011)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 30
				local var_44_17 = utf8.len(var_44_15)
				local var_44_18 = var_44_16 <= 0 and var_44_12 or var_44_12 * (var_44_17 / var_44_16)

				if var_44_18 > 0 and var_44_12 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271011", "story_v_out_112271.awb") ~= 0 then
					local var_44_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271011", "story_v_out_112271.awb") / 1000

					if var_44_19 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_11
					end

					if var_44_14.prefab_name ~= "" and arg_41_1.actors_[var_44_14.prefab_name] ~= nil then
						local var_44_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_14.prefab_name].transform, "story_v_out_112271", "112271011", "story_v_out_112271.awb")

						arg_41_1:RecordAudio("112271011", var_44_20)
						arg_41_1:RecordAudio("112271011", var_44_20)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_112271", "112271011", "story_v_out_112271.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_112271", "112271011", "story_v_out_112271.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_21 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_21 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_21

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_21 and arg_41_1.time_ < var_44_11 + var_44_21 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play112271012 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 112271012
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play112271013(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1081"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) then
				local var_48_2 = var_48_0:GetComponent("Image")

				if var_48_2 then
					arg_45_1.var_.highlightMatValue1081 = var_48_2
				end
			end

			local var_48_3 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_3 and not isNil(var_48_0) then
				local var_48_4 = (arg_45_1.time_ - var_48_1) / var_48_3

				if arg_45_1.var_.highlightMatValue1081 then
					local var_48_5 = Mathf.Lerp(1, 0.5, var_48_4)
					local var_48_6 = arg_45_1.var_.highlightMatValue1081
					local var_48_7 = var_48_6.color

					var_48_7.r = var_48_5
					var_48_7.g = var_48_5
					var_48_7.b = var_48_5
					var_48_6.color = var_48_7
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_3 and arg_45_1.time_ < var_48_1 + var_48_3 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.highlightMatValue1081 then
				local var_48_8 = 0.5
				local var_48_9 = arg_45_1.var_.highlightMatValue1081
				local var_48_10 = var_48_9.color

				var_48_10.r = var_48_8
				var_48_10.g = var_48_8
				var_48_10.b = var_48_8
				var_48_9.color = var_48_10
			end

			local var_48_11 = 0
			local var_48_12 = 0.1

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_13 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_14 = arg_45_1:GetWordFromCfg(112271012)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 4
				local var_48_17 = utf8.len(var_48_15)
				local var_48_18 = var_48_16 <= 0 and var_48_12 or var_48_12 * (var_48_17 / var_48_16)

				if var_48_18 > 0 and var_48_12 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18

					if var_48_18 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_19 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_19 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_19

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_19 and arg_45_1.time_ < var_48_11 + var_48_19 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play112271013 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 112271013
		arg_49_1.duration_ = 12.17

		local var_49_0 = {
			ja = 12.166,
			ko = 6.7,
			zh = 5.9,
			en = 6.433
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play112271014(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1081"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) then
				local var_52_2 = var_52_0:GetComponent("Image")

				if var_52_2 then
					arg_49_1.var_.highlightMatValue1081 = var_52_2
				end
			end

			local var_52_3 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_3 and not isNil(var_52_0) then
				local var_52_4 = (arg_49_1.time_ - var_52_1) / var_52_3

				if arg_49_1.var_.highlightMatValue1081 then
					local var_52_5 = Mathf.Lerp(0.5, 1, var_52_4)
					local var_52_6 = arg_49_1.var_.highlightMatValue1081
					local var_52_7 = var_52_6.color

					var_52_7.r = var_52_5
					var_52_7.g = var_52_5
					var_52_7.b = var_52_5
					var_52_6.color = var_52_7
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_3 and arg_49_1.time_ < var_52_1 + var_52_3 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.highlightMatValue1081 then
				local var_52_8 = 1

				var_52_0.transform:SetSiblingIndex(1)

				local var_52_9 = arg_49_1.var_.highlightMatValue1081
				local var_52_10 = var_52_9.color

				var_52_10.r = var_52_8
				var_52_10.g = var_52_8
				var_52_10.b = var_52_8
				var_52_9.color = var_52_10
			end

			local var_52_11 = 0
			local var_52_12 = 0.775

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_13 = arg_49_1:FormatText(StoryNameCfg[202].name)

				arg_49_1.leftNameTxt_.text = var_52_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_14 = arg_49_1:GetWordFromCfg(112271013)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 31
				local var_52_17 = utf8.len(var_52_15)
				local var_52_18 = var_52_16 <= 0 and var_52_12 or var_52_12 * (var_52_17 / var_52_16)

				if var_52_18 > 0 and var_52_12 < var_52_18 then
					arg_49_1.talkMaxDuration = var_52_18

					if var_52_18 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_15
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271013", "story_v_out_112271.awb") ~= 0 then
					local var_52_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271013", "story_v_out_112271.awb") / 1000

					if var_52_19 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_11
					end

					if var_52_14.prefab_name ~= "" and arg_49_1.actors_[var_52_14.prefab_name] ~= nil then
						local var_52_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_14.prefab_name].transform, "story_v_out_112271", "112271013", "story_v_out_112271.awb")

						arg_49_1:RecordAudio("112271013", var_52_20)
						arg_49_1:RecordAudio("112271013", var_52_20)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_112271", "112271013", "story_v_out_112271.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_112271", "112271013", "story_v_out_112271.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_21 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_21 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_21

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_21 and arg_49_1.time_ < var_52_11 + var_52_21 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play112271014 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 112271014
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play112271015(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1081"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) then
				local var_56_2 = var_56_0:GetComponent("Image")

				if var_56_2 then
					arg_53_1.var_.highlightMatValue1081 = var_56_2
				end
			end

			local var_56_3 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_3 and not isNil(var_56_0) then
				local var_56_4 = (arg_53_1.time_ - var_56_1) / var_56_3

				if arg_53_1.var_.highlightMatValue1081 then
					local var_56_5 = Mathf.Lerp(1, 0.5, var_56_4)
					local var_56_6 = arg_53_1.var_.highlightMatValue1081
					local var_56_7 = var_56_6.color

					var_56_7.r = var_56_5
					var_56_7.g = var_56_5
					var_56_7.b = var_56_5
					var_56_6.color = var_56_7
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_3 and arg_53_1.time_ < var_56_1 + var_56_3 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.highlightMatValue1081 then
				local var_56_8 = 0.5
				local var_56_9 = arg_53_1.var_.highlightMatValue1081
				local var_56_10 = var_56_9.color

				var_56_10.r = var_56_8
				var_56_10.g = var_56_8
				var_56_10.b = var_56_8
				var_56_9.color = var_56_10
			end

			local var_56_11 = 0
			local var_56_12 = 0.35

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_13 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_14 = arg_53_1:GetWordFromCfg(112271014)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 14
				local var_56_17 = utf8.len(var_56_15)
				local var_56_18 = var_56_16 <= 0 and var_56_12 or var_56_12 * (var_56_17 / var_56_16)

				if var_56_18 > 0 and var_56_12 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_19 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_19 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_19

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_19 and arg_53_1.time_ < var_56_11 + var_56_19 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play112271015 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 112271015
		arg_57_1.duration_ = 8.2

		local var_57_0 = {
			ja = 8.2,
			ko = 3.166,
			zh = 3.533,
			en = 5.433
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play112271016(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1081"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) then
				local var_60_2 = var_60_0:GetComponent("Image")

				if var_60_2 then
					arg_57_1.var_.highlightMatValue1081 = var_60_2
				end
			end

			local var_60_3 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_3 and not isNil(var_60_0) then
				local var_60_4 = (arg_57_1.time_ - var_60_1) / var_60_3

				if arg_57_1.var_.highlightMatValue1081 then
					local var_60_5 = Mathf.Lerp(0.5, 1, var_60_4)
					local var_60_6 = arg_57_1.var_.highlightMatValue1081
					local var_60_7 = var_60_6.color

					var_60_7.r = var_60_5
					var_60_7.g = var_60_5
					var_60_7.b = var_60_5
					var_60_6.color = var_60_7
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_3 and arg_57_1.time_ < var_60_1 + var_60_3 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.highlightMatValue1081 then
				local var_60_8 = 1

				var_60_0.transform:SetSiblingIndex(1)

				local var_60_9 = arg_57_1.var_.highlightMatValue1081
				local var_60_10 = var_60_9.color

				var_60_10.r = var_60_8
				var_60_10.g = var_60_8
				var_60_10.b = var_60_8
				var_60_9.color = var_60_10
			end

			local var_60_11 = 0
			local var_60_12 = 0.275

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_13 = arg_57_1:FormatText(StoryNameCfg[202].name)

				arg_57_1.leftNameTxt_.text = var_60_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(112271015)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 11
				local var_60_17 = utf8.len(var_60_15)
				local var_60_18 = var_60_16 <= 0 and var_60_12 or var_60_12 * (var_60_17 / var_60_16)

				if var_60_18 > 0 and var_60_12 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18

					if var_60_18 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271015", "story_v_out_112271.awb") ~= 0 then
					local var_60_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271015", "story_v_out_112271.awb") / 1000

					if var_60_19 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_11
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_112271", "112271015", "story_v_out_112271.awb")

						arg_57_1:RecordAudio("112271015", var_60_20)
						arg_57_1:RecordAudio("112271015", var_60_20)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_112271", "112271015", "story_v_out_112271.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_112271", "112271015", "story_v_out_112271.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_21 and arg_57_1.time_ < var_60_11 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play112271016 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 112271016
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play112271017(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1081"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) then
				local var_64_2 = var_64_0:GetComponent("Image")

				if var_64_2 then
					arg_61_1.var_.highlightMatValue1081 = var_64_2
				end
			end

			local var_64_3 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 and not isNil(var_64_0) then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3

				if arg_61_1.var_.highlightMatValue1081 then
					local var_64_5 = Mathf.Lerp(1, 0.5, var_64_4)
					local var_64_6 = arg_61_1.var_.highlightMatValue1081
					local var_64_7 = var_64_6.color

					var_64_7.r = var_64_5
					var_64_7.g = var_64_5
					var_64_7.b = var_64_5
					var_64_6.color = var_64_7
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.highlightMatValue1081 then
				local var_64_8 = 0.5
				local var_64_9 = arg_61_1.var_.highlightMatValue1081
				local var_64_10 = var_64_9.color

				var_64_10.r = var_64_8
				var_64_10.g = var_64_8
				var_64_10.b = var_64_8
				var_64_9.color = var_64_10
			end

			local var_64_11 = 0
			local var_64_12 = 0.25

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_13 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_14 = arg_61_1:GetWordFromCfg(112271016)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 10
				local var_64_17 = utf8.len(var_64_15)
				local var_64_18 = var_64_16 <= 0 and var_64_12 or var_64_12 * (var_64_17 / var_64_16)

				if var_64_18 > 0 and var_64_12 < var_64_18 then
					arg_61_1.talkMaxDuration = var_64_18

					if var_64_18 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_15
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_19 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_19 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_19

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_19 and arg_61_1.time_ < var_64_11 + var_64_19 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play112271017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 112271017
		arg_65_1.duration_ = 9.1

		local var_65_0 = {
			ja = 9.1,
			ko = 6.966,
			zh = 6.3,
			en = 8.933
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play112271018(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1081"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) then
				local var_68_2 = var_68_0:GetComponent("Image")

				if var_68_2 then
					arg_65_1.var_.highlightMatValue1081 = var_68_2
				end
			end

			local var_68_3 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 and not isNil(var_68_0) then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3

				if arg_65_1.var_.highlightMatValue1081 then
					local var_68_5 = Mathf.Lerp(0.5, 1, var_68_4)
					local var_68_6 = arg_65_1.var_.highlightMatValue1081
					local var_68_7 = var_68_6.color

					var_68_7.r = var_68_5
					var_68_7.g = var_68_5
					var_68_7.b = var_68_5
					var_68_6.color = var_68_7
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.highlightMatValue1081 then
				local var_68_8 = 1

				var_68_0.transform:SetSiblingIndex(1)

				local var_68_9 = arg_65_1.var_.highlightMatValue1081
				local var_68_10 = var_68_9.color

				var_68_10.r = var_68_8
				var_68_10.g = var_68_8
				var_68_10.b = var_68_8
				var_68_9.color = var_68_10
			end

			local var_68_11 = 0
			local var_68_12 = 0.75

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_13 = arg_65_1:FormatText(StoryNameCfg[202].name)

				arg_65_1.leftNameTxt_.text = var_68_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_14 = arg_65_1:GetWordFromCfg(112271017)
				local var_68_15 = arg_65_1:FormatText(var_68_14.content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 30
				local var_68_17 = utf8.len(var_68_15)
				local var_68_18 = var_68_16 <= 0 and var_68_12 or var_68_12 * (var_68_17 / var_68_16)

				if var_68_18 > 0 and var_68_12 < var_68_18 then
					arg_65_1.talkMaxDuration = var_68_18

					if var_68_18 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271017", "story_v_out_112271.awb") ~= 0 then
					local var_68_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271017", "story_v_out_112271.awb") / 1000

					if var_68_19 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_11
					end

					if var_68_14.prefab_name ~= "" and arg_65_1.actors_[var_68_14.prefab_name] ~= nil then
						local var_68_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_14.prefab_name].transform, "story_v_out_112271", "112271017", "story_v_out_112271.awb")

						arg_65_1:RecordAudio("112271017", var_68_20)
						arg_65_1:RecordAudio("112271017", var_68_20)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_112271", "112271017", "story_v_out_112271.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_112271", "112271017", "story_v_out_112271.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_21 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_21

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_21 and arg_65_1.time_ < var_68_11 + var_68_21 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play112271018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 112271018
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play112271019(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1081"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) then
				local var_72_2 = var_72_0:GetComponent("Image")

				if var_72_2 then
					arg_69_1.var_.highlightMatValue1081 = var_72_2
				end
			end

			local var_72_3 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_3 and not isNil(var_72_0) then
				local var_72_4 = (arg_69_1.time_ - var_72_1) / var_72_3

				if arg_69_1.var_.highlightMatValue1081 then
					local var_72_5 = Mathf.Lerp(1, 0.5, var_72_4)
					local var_72_6 = arg_69_1.var_.highlightMatValue1081
					local var_72_7 = var_72_6.color

					var_72_7.r = var_72_5
					var_72_7.g = var_72_5
					var_72_7.b = var_72_5
					var_72_6.color = var_72_7
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_3 and arg_69_1.time_ < var_72_1 + var_72_3 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.highlightMatValue1081 then
				local var_72_8 = 0.5
				local var_72_9 = arg_69_1.var_.highlightMatValue1081
				local var_72_10 = var_72_9.color

				var_72_10.r = var_72_8
				var_72_10.g = var_72_8
				var_72_10.b = var_72_8
				var_72_9.color = var_72_10
			end

			local var_72_11 = 0
			local var_72_12 = 0.075

			if var_72_11 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_13 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_14 = arg_69_1:GetWordFromCfg(112271018)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 3
				local var_72_17 = utf8.len(var_72_15)
				local var_72_18 = var_72_16 <= 0 and var_72_12 or var_72_12 * (var_72_17 / var_72_16)

				if var_72_18 > 0 and var_72_12 < var_72_18 then
					arg_69_1.talkMaxDuration = var_72_18

					if var_72_18 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_19 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_11) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_11 + var_72_19 and arg_69_1.time_ < var_72_11 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play112271019 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 112271019
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play112271020(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.15

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(112271019)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 46
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play112271020 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 112271020
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play112271021(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.675

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(112271020)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 27
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play112271021 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 112271021
		arg_81_1.duration_ = 4.53

		local var_81_0 = {
			ja = 4.533,
			ko = 3.733,
			zh = 3.433,
			en = 2.933
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play112271022(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1081"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) then
				local var_84_2 = var_84_0:GetComponent("Image")

				if var_84_2 then
					arg_81_1.var_.highlightMatValue1081 = var_84_2
				end
			end

			local var_84_3 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_3 and not isNil(var_84_0) then
				local var_84_4 = (arg_81_1.time_ - var_84_1) / var_84_3

				if arg_81_1.var_.highlightMatValue1081 then
					local var_84_5 = Mathf.Lerp(0.5, 1, var_84_4)
					local var_84_6 = arg_81_1.var_.highlightMatValue1081
					local var_84_7 = var_84_6.color

					var_84_7.r = var_84_5
					var_84_7.g = var_84_5
					var_84_7.b = var_84_5
					var_84_6.color = var_84_7
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_3 and arg_81_1.time_ < var_84_1 + var_84_3 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.highlightMatValue1081 then
				local var_84_8 = 1

				var_84_0.transform:SetSiblingIndex(1)

				local var_84_9 = arg_81_1.var_.highlightMatValue1081
				local var_84_10 = var_84_9.color

				var_84_10.r = var_84_8
				var_84_10.g = var_84_8
				var_84_10.b = var_84_8
				var_84_9.color = var_84_10
			end

			local var_84_11 = 0
			local var_84_12 = 0.375

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_13 = arg_81_1:FormatText(StoryNameCfg[202].name)

				arg_81_1.leftNameTxt_.text = var_84_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(112271021)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 15
				local var_84_17 = utf8.len(var_84_15)
				local var_84_18 = var_84_16 <= 0 and var_84_12 or var_84_12 * (var_84_17 / var_84_16)

				if var_84_18 > 0 and var_84_12 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18

					if var_84_18 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271021", "story_v_out_112271.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271021", "story_v_out_112271.awb") / 1000

					if var_84_19 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_11
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_112271", "112271021", "story_v_out_112271.awb")

						arg_81_1:RecordAudio("112271021", var_84_20)
						arg_81_1:RecordAudio("112271021", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_112271", "112271021", "story_v_out_112271.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_112271", "112271021", "story_v_out_112271.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_21 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_21 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_11) / var_84_21

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_11 + var_84_21 and arg_81_1.time_ < var_84_11 + var_84_21 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play112271022 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 112271022
		arg_85_1.duration_ = 8.7

		local var_85_0 = {
			ja = 5.5,
			ko = 8.033,
			zh = 6.333,
			en = 8.7
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play112271023(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.675

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[202].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(112271022)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 27
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271022", "story_v_out_112271.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_112271", "112271022", "story_v_out_112271.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_112271", "112271022", "story_v_out_112271.awb")

						arg_85_1:RecordAudio("112271022", var_88_9)
						arg_85_1:RecordAudio("112271022", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_112271", "112271022", "story_v_out_112271.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_112271", "112271022", "story_v_out_112271.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play112271023 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 112271023
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play112271024(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1081"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) then
				local var_92_2 = var_92_0:GetComponent("Image")

				if var_92_2 then
					arg_89_1.var_.highlightMatValue1081 = var_92_2
				end
			end

			local var_92_3 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_3 and not isNil(var_92_0) then
				local var_92_4 = (arg_89_1.time_ - var_92_1) / var_92_3

				if arg_89_1.var_.highlightMatValue1081 then
					local var_92_5 = Mathf.Lerp(1, 0.5, var_92_4)
					local var_92_6 = arg_89_1.var_.highlightMatValue1081
					local var_92_7 = var_92_6.color

					var_92_7.r = var_92_5
					var_92_7.g = var_92_5
					var_92_7.b = var_92_5
					var_92_6.color = var_92_7
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_3 and arg_89_1.time_ < var_92_1 + var_92_3 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.highlightMatValue1081 then
				local var_92_8 = 0.5
				local var_92_9 = arg_89_1.var_.highlightMatValue1081
				local var_92_10 = var_92_9.color

				var_92_10.r = var_92_8
				var_92_10.g = var_92_8
				var_92_10.b = var_92_8
				var_92_9.color = var_92_10
			end

			local var_92_11 = 0
			local var_92_12 = 0.125

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_13 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_14 = arg_89_1:GetWordFromCfg(112271023)
				local var_92_15 = arg_89_1:FormatText(var_92_14.content)

				arg_89_1.text_.text = var_92_15

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 5
				local var_92_17 = utf8.len(var_92_15)
				local var_92_18 = var_92_16 <= 0 and var_92_12 or var_92_12 * (var_92_17 / var_92_16)

				if var_92_18 > 0 and var_92_12 < var_92_18 then
					arg_89_1.talkMaxDuration = var_92_18

					if var_92_18 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_15
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_19 and arg_89_1.time_ < var_92_11 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play112271024 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 112271024
		arg_93_1.duration_ = 3.17

		local var_93_0 = {
			ja = 3.166,
			ko = 1.9,
			zh = 1.7,
			en = 2.566
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play112271025(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1081"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) then
				local var_96_2 = var_96_0:GetComponent("Image")

				if var_96_2 then
					arg_93_1.var_.highlightMatValue1081 = var_96_2
				end
			end

			local var_96_3 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_3 and not isNil(var_96_0) then
				local var_96_4 = (arg_93_1.time_ - var_96_1) / var_96_3

				if arg_93_1.var_.highlightMatValue1081 then
					local var_96_5 = Mathf.Lerp(0.5, 1, var_96_4)
					local var_96_6 = arg_93_1.var_.highlightMatValue1081
					local var_96_7 = var_96_6.color

					var_96_7.r = var_96_5
					var_96_7.g = var_96_5
					var_96_7.b = var_96_5
					var_96_6.color = var_96_7
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_3 and arg_93_1.time_ < var_96_1 + var_96_3 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.highlightMatValue1081 then
				local var_96_8 = 1

				var_96_0.transform:SetSiblingIndex(1)

				local var_96_9 = arg_93_1.var_.highlightMatValue1081
				local var_96_10 = var_96_9.color

				var_96_10.r = var_96_8
				var_96_10.g = var_96_8
				var_96_10.b = var_96_8
				var_96_9.color = var_96_10
			end

			local var_96_11 = 0
			local var_96_12 = 0.15

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_13 = arg_93_1:FormatText(StoryNameCfg[202].name)

				arg_93_1.leftNameTxt_.text = var_96_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_14 = arg_93_1:GetWordFromCfg(112271024)
				local var_96_15 = arg_93_1:FormatText(var_96_14.content)

				arg_93_1.text_.text = var_96_15

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 6
				local var_96_17 = utf8.len(var_96_15)
				local var_96_18 = var_96_16 <= 0 and var_96_12 or var_96_12 * (var_96_17 / var_96_16)

				if var_96_18 > 0 and var_96_12 < var_96_18 then
					arg_93_1.talkMaxDuration = var_96_18

					if var_96_18 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_15
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271024", "story_v_out_112271.awb") ~= 0 then
					local var_96_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271024", "story_v_out_112271.awb") / 1000

					if var_96_19 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_11
					end

					if var_96_14.prefab_name ~= "" and arg_93_1.actors_[var_96_14.prefab_name] ~= nil then
						local var_96_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_14.prefab_name].transform, "story_v_out_112271", "112271024", "story_v_out_112271.awb")

						arg_93_1:RecordAudio("112271024", var_96_20)
						arg_93_1:RecordAudio("112271024", var_96_20)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_112271", "112271024", "story_v_out_112271.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_112271", "112271024", "story_v_out_112271.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_21 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_21 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_21

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_21 and arg_93_1.time_ < var_96_11 + var_96_21 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play112271025 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 112271025
		arg_97_1.duration_ = 8.9

		local var_97_0 = {
			ja = 6.766,
			ko = 8.9,
			zh = 6.6,
			en = 6.7
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play112271026(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.875

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[202].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(112271025)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 35
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271025", "story_v_out_112271.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_112271", "112271025", "story_v_out_112271.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_112271", "112271025", "story_v_out_112271.awb")

						arg_97_1:RecordAudio("112271025", var_100_9)
						arg_97_1:RecordAudio("112271025", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_112271", "112271025", "story_v_out_112271.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_112271", "112271025", "story_v_out_112271.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play112271026 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 112271026
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play112271027(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1081"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) then
				local var_104_2 = var_104_0:GetComponent("Image")

				if var_104_2 then
					arg_101_1.var_.highlightMatValue1081 = var_104_2
				end
			end

			local var_104_3 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_3 and not isNil(var_104_0) then
				local var_104_4 = (arg_101_1.time_ - var_104_1) / var_104_3

				if arg_101_1.var_.highlightMatValue1081 then
					local var_104_5 = Mathf.Lerp(1, 0.5, var_104_4)
					local var_104_6 = arg_101_1.var_.highlightMatValue1081
					local var_104_7 = var_104_6.color

					var_104_7.r = var_104_5
					var_104_7.g = var_104_5
					var_104_7.b = var_104_5
					var_104_6.color = var_104_7
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_3 and arg_101_1.time_ < var_104_1 + var_104_3 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.highlightMatValue1081 then
				local var_104_8 = 0.5
				local var_104_9 = arg_101_1.var_.highlightMatValue1081
				local var_104_10 = var_104_9.color

				var_104_10.r = var_104_8
				var_104_10.g = var_104_8
				var_104_10.b = var_104_8
				var_104_9.color = var_104_10
			end

			local var_104_11 = 0
			local var_104_12 = 0.45

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_13 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_14 = arg_101_1:GetWordFromCfg(112271026)
				local var_104_15 = arg_101_1:FormatText(var_104_14.content)

				arg_101_1.text_.text = var_104_15

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_16 = 18
				local var_104_17 = utf8.len(var_104_15)
				local var_104_18 = var_104_16 <= 0 and var_104_12 or var_104_12 * (var_104_17 / var_104_16)

				if var_104_18 > 0 and var_104_12 < var_104_18 then
					arg_101_1.talkMaxDuration = var_104_18

					if var_104_18 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_18 + var_104_11
					end
				end

				arg_101_1.text_.text = var_104_15
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_19 = math.max(var_104_12, arg_101_1.talkMaxDuration)

			if var_104_11 <= arg_101_1.time_ and arg_101_1.time_ < var_104_11 + var_104_19 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_11) / var_104_19

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_11 + var_104_19 and arg_101_1.time_ < var_104_11 + var_104_19 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play112271027 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 112271027
		arg_105_1.duration_ = 13.7

		local var_105_0 = {
			ja = 13.7,
			ko = 8.733,
			zh = 8.266,
			en = 9.8
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play112271028(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1081"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) then
				local var_108_2 = var_108_0:GetComponent("Image")

				if var_108_2 then
					arg_105_1.var_.highlightMatValue1081 = var_108_2
				end
			end

			local var_108_3 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 and not isNil(var_108_0) then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3

				if arg_105_1.var_.highlightMatValue1081 then
					local var_108_5 = Mathf.Lerp(0.5, 1, var_108_4)
					local var_108_6 = arg_105_1.var_.highlightMatValue1081
					local var_108_7 = var_108_6.color

					var_108_7.r = var_108_5
					var_108_7.g = var_108_5
					var_108_7.b = var_108_5
					var_108_6.color = var_108_7
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.highlightMatValue1081 then
				local var_108_8 = 1

				var_108_0.transform:SetSiblingIndex(1)

				local var_108_9 = arg_105_1.var_.highlightMatValue1081
				local var_108_10 = var_108_9.color

				var_108_10.r = var_108_8
				var_108_10.g = var_108_8
				var_108_10.b = var_108_8
				var_108_9.color = var_108_10
			end

			local var_108_11 = 0
			local var_108_12 = 1.225

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_13 = arg_105_1:FormatText(StoryNameCfg[202].name)

				arg_105_1.leftNameTxt_.text = var_108_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_14 = arg_105_1:GetWordFromCfg(112271027)
				local var_108_15 = arg_105_1:FormatText(var_108_14.content)

				arg_105_1.text_.text = var_108_15

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_16 = 49
				local var_108_17 = utf8.len(var_108_15)
				local var_108_18 = var_108_16 <= 0 and var_108_12 or var_108_12 * (var_108_17 / var_108_16)

				if var_108_18 > 0 and var_108_12 < var_108_18 then
					arg_105_1.talkMaxDuration = var_108_18

					if var_108_18 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_11
					end
				end

				arg_105_1.text_.text = var_108_15
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271027", "story_v_out_112271.awb") ~= 0 then
					local var_108_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271027", "story_v_out_112271.awb") / 1000

					if var_108_19 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_11
					end

					if var_108_14.prefab_name ~= "" and arg_105_1.actors_[var_108_14.prefab_name] ~= nil then
						local var_108_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_14.prefab_name].transform, "story_v_out_112271", "112271027", "story_v_out_112271.awb")

						arg_105_1:RecordAudio("112271027", var_108_20)
						arg_105_1:RecordAudio("112271027", var_108_20)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_112271", "112271027", "story_v_out_112271.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_112271", "112271027", "story_v_out_112271.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_21 = math.max(var_108_12, arg_105_1.talkMaxDuration)

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_21 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_11) / var_108_21

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_11 + var_108_21 and arg_105_1.time_ < var_108_11 + var_108_21 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play112271028 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 112271028
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play112271029(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1081"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) then
				local var_112_2 = var_112_0:GetComponent("Image")

				if var_112_2 then
					arg_109_1.var_.highlightMatValue1081 = var_112_2
				end
			end

			local var_112_3 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_3 and not isNil(var_112_0) then
				local var_112_4 = (arg_109_1.time_ - var_112_1) / var_112_3

				if arg_109_1.var_.highlightMatValue1081 then
					local var_112_5 = Mathf.Lerp(1, 0.5, var_112_4)
					local var_112_6 = arg_109_1.var_.highlightMatValue1081
					local var_112_7 = var_112_6.color

					var_112_7.r = var_112_5
					var_112_7.g = var_112_5
					var_112_7.b = var_112_5
					var_112_6.color = var_112_7
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_3 and arg_109_1.time_ < var_112_1 + var_112_3 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.highlightMatValue1081 then
				local var_112_8 = 0.5
				local var_112_9 = arg_109_1.var_.highlightMatValue1081
				local var_112_10 = var_112_9.color

				var_112_10.r = var_112_8
				var_112_10.g = var_112_8
				var_112_10.b = var_112_8
				var_112_9.color = var_112_10
			end

			local var_112_11 = 0
			local var_112_12 = 0.425

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_13 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_14 = arg_109_1:GetWordFromCfg(112271028)
				local var_112_15 = arg_109_1:FormatText(var_112_14.content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_16 = 17
				local var_112_17 = utf8.len(var_112_15)
				local var_112_18 = var_112_16 <= 0 and var_112_12 or var_112_12 * (var_112_17 / var_112_16)

				if var_112_18 > 0 and var_112_12 < var_112_18 then
					arg_109_1.talkMaxDuration = var_112_18

					if var_112_18 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_15
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_19 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_19 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_19

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_19 and arg_109_1.time_ < var_112_11 + var_112_19 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play112271029 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 112271029
		arg_113_1.duration_ = 5.53

		local var_113_0 = {
			ja = 5.133,
			ko = 4.366,
			zh = 5.533,
			en = 3.2
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play112271030(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1081"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) then
				local var_116_2 = var_116_0:GetComponent("Image")

				if var_116_2 then
					arg_113_1.var_.highlightMatValue1081 = var_116_2
				end
			end

			local var_116_3 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 and not isNil(var_116_0) then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3

				if arg_113_1.var_.highlightMatValue1081 then
					local var_116_5 = Mathf.Lerp(0.5, 1, var_116_4)
					local var_116_6 = arg_113_1.var_.highlightMatValue1081
					local var_116_7 = var_116_6.color

					var_116_7.r = var_116_5
					var_116_7.g = var_116_5
					var_116_7.b = var_116_5
					var_116_6.color = var_116_7
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.highlightMatValue1081 then
				local var_116_8 = 1

				var_116_0.transform:SetSiblingIndex(1)

				local var_116_9 = arg_113_1.var_.highlightMatValue1081
				local var_116_10 = var_116_9.color

				var_116_10.r = var_116_8
				var_116_10.g = var_116_8
				var_116_10.b = var_116_8
				var_116_9.color = var_116_10
			end

			local var_116_11 = 0
			local var_116_12 = 0.525

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_13 = arg_113_1:FormatText(StoryNameCfg[202].name)

				arg_113_1.leftNameTxt_.text = var_116_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_14 = arg_113_1:GetWordFromCfg(112271029)
				local var_116_15 = arg_113_1:FormatText(var_116_14.content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_16 = 21
				local var_116_17 = utf8.len(var_116_15)
				local var_116_18 = var_116_16 <= 0 and var_116_12 or var_116_12 * (var_116_17 / var_116_16)

				if var_116_18 > 0 and var_116_12 < var_116_18 then
					arg_113_1.talkMaxDuration = var_116_18

					if var_116_18 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_11
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271029", "story_v_out_112271.awb") ~= 0 then
					local var_116_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271029", "story_v_out_112271.awb") / 1000

					if var_116_19 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_11
					end

					if var_116_14.prefab_name ~= "" and arg_113_1.actors_[var_116_14.prefab_name] ~= nil then
						local var_116_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_14.prefab_name].transform, "story_v_out_112271", "112271029", "story_v_out_112271.awb")

						arg_113_1:RecordAudio("112271029", var_116_20)
						arg_113_1:RecordAudio("112271029", var_116_20)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_112271", "112271029", "story_v_out_112271.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_112271", "112271029", "story_v_out_112271.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_21 = math.max(var_116_12, arg_113_1.talkMaxDuration)

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_21 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_11) / var_116_21

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_11 + var_116_21 and arg_113_1.time_ < var_116_11 + var_116_21 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play112271030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 112271030
		arg_117_1.duration_ = 4.7

		local var_117_0 = {
			ja = 4.233,
			ko = 4.7,
			zh = 4,
			en = 3.633
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
			arg_117_1.auto_ = false
		end

		function arg_117_1.playNext_(arg_119_0)
			arg_117_1.onStoryFinished_()
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.35

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[202].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(112271030)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 14
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271030", "story_v_out_112271.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_112271", "112271030", "story_v_out_112271.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_112271", "112271030", "story_v_out_112271.awb")

						arg_117_1:RecordAudio("112271030", var_120_9)
						arg_117_1:RecordAudio("112271030", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_112271", "112271030", "story_v_out_112271.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_112271", "112271030", "story_v_out_112271.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_112271.awb"
	}
}
