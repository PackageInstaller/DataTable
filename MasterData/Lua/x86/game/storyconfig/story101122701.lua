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
			local var_4_0 = 1.1

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_1 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112271001).content)

				arg_1_1.text_.text = var_4_1

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_3 = 44 <= 0 and var_4_0 or var_4_0 * (utf8.len(var_4_1) / 44)

				if (44 <= 0 and var_4_0 or var_4_0 * (utf8.len(var_4_1) / 44)) > 0 and var_4_0 < var_4_3 then
					arg_1_1.talkMaxDuration = var_4_3

					if var_4_3 + 0 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_3 + 0
					end
				end

				arg_1_1.text_.text = var_4_1
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_4 = math.max(var_4_0, arg_1_1.talkMaxDuration)

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_4 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - 0) / var_4_4

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= 0 + var_4_4 and arg_1_1.time_ < 0 + var_4_4 + arg_4_0 then
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
			local var_8_0 = 0.875

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, false)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_5_1.iconTrs_.gameObject, false)
				arg_5_1.callingController_:SetSelectedState("normal")

				local var_8_1 = arg_5_1:FormatText(arg_5_1:GetWordFromCfg(112271002).content)

				arg_5_1.text_.text = var_8_1

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_3 = 35 <= 0 and var_8_0 or var_8_0 * (utf8.len(var_8_1) / 35)

				if (35 <= 0 and var_8_0 or var_8_0 * (utf8.len(var_8_1) / 35)) > 0 and var_8_0 < var_8_3 then
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
			if arg_9_1.actors_["1084"] == nil then
				local var_12_0 = Object.Instantiate(arg_9_1.imageGo_, arg_9_1.canvasGo_.transform)

				var_12_0.transform:SetSiblingIndex(1)

				var_12_0.name = "1084"

				local var_12_1 = var_12_0:GetComponent(typeof(Image))

				var_12_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1084")

				var_12_1:SetNativeSize()

				var_12_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_9_1.actors_["1084"] = var_12_0
			end

			local var_12_2 = arg_9_1.actors_["1084"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_12_3 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084, Vector3.New(0, -450, 0), (arg_9_1.time_ - 0) / var_12_3)
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -450, 0)
			end

			local var_12_4 = arg_9_1.actors_["1084"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_4) then
				local var_12_5 = var_12_4:GetComponent("Image")

				if var_12_5 then
					arg_9_1.var_.highlightMatValue1084 = var_12_5
				end
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_4) then
				if arg_9_1.var_.highlightMatValue1084 then
					local var_12_7 = Mathf.Lerp(0.5, 1, (arg_9_1.time_ - 0) / var_12_6)

					arg_9_1.var_.highlightMatValue1084.color.r = var_12_7
					arg_9_1.var_.highlightMatValue1084.color.g = var_12_7
					arg_9_1.var_.highlightMatValue1084.color.b = var_12_7
					arg_9_1.var_.highlightMatValue1084.color = arg_9_1.var_.highlightMatValue1084.color
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.highlightMatValue1084 then
				var_12_4.transform:SetSiblingIndex(1)

				arg_9_1.var_.highlightMatValue1084.color.r = 1
				arg_9_1.var_.highlightMatValue1084.color.g = 1
				arg_9_1.var_.highlightMatValue1084.color.b = 1
				arg_9_1.var_.highlightMatValue1084.color = arg_9_1.var_.highlightMatValue1084.color
			end

			local var_12_8 = 0
			local var_12_9 = 0.475

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(112271003)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 19 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 19)

				if (19 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 19)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271003", "story_v_out_112271.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_112271", "112271003", "story_v_out_112271.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_112271", "112271003", "story_v_out_112271.awb")

						arg_9_1:RecordAudio("112271003", var_12_15)
						arg_9_1:RecordAudio("112271003", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_112271", "112271003", "story_v_out_112271.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_112271", "112271003", "story_v_out_112271.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
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
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1084 = arg_13_1.actors_["1084"].transform.localPosition
				arg_13_1.actors_["1084"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1084"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1084, Vector3.New(0, -2000, 0), (arg_13_1.time_ - 0) / var_16_0)
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1084"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_16_1 = "1027"

			if arg_13_1.actors_["1027"] == nil then
				local var_16_2 = Object.Instantiate(arg_13_1.imageGo_, arg_13_1.canvasGo_.transform)

				var_16_2.transform:SetSiblingIndex(1)

				var_16_2.name = var_16_1

				local var_16_3 = var_16_2:GetComponent(typeof(Image))

				var_16_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1027")

				var_16_3:SetNativeSize()

				var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_13_1.actors_[var_16_1] = var_16_2
			end

			local var_16_4 = arg_13_1.actors_["1027"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1027 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_16_5 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 then
				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1027, Vector3.New(0, -450, 0), (arg_13_1.time_ - 0) / var_16_5)
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(0, -450, 0)
			end

			local var_16_6 = arg_13_1.actors_["1027"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_6) then
				local var_16_7 = var_16_6:GetComponent("Image")

				if var_16_7 then
					arg_13_1.var_.highlightMatValue1027 = var_16_7
				end
			end

			local var_16_8 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_6) then
				if arg_13_1.var_.highlightMatValue1027 then
					local var_16_9 = Mathf.Lerp(0.5, 1, (arg_13_1.time_ - 0) / var_16_8)

					arg_13_1.var_.highlightMatValue1027.color.r = var_16_9
					arg_13_1.var_.highlightMatValue1027.color.g = var_16_9
					arg_13_1.var_.highlightMatValue1027.color.b = var_16_9
					arg_13_1.var_.highlightMatValue1027.color = arg_13_1.var_.highlightMatValue1027.color
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.highlightMatValue1027 then
				var_16_6.transform:SetSiblingIndex(1)

				arg_13_1.var_.highlightMatValue1027.color.r = 1
				arg_13_1.var_.highlightMatValue1027.color.g = 1
				arg_13_1.var_.highlightMatValue1027.color.b = 1
				arg_13_1.var_.highlightMatValue1027.color = arg_13_1.var_.highlightMatValue1027.color
			end

			local var_16_10 = 0
			local var_16_11 = 0.625

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(112271004)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 25 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 25)

				if (25 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 25)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271004", "story_v_out_112271.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_112271", "112271004", "story_v_out_112271.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_112271", "112271004", "story_v_out_112271.awb")

						arg_13_1:RecordAudio("112271004", var_16_17)
						arg_13_1:RecordAudio("112271004", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_112271", "112271004", "story_v_out_112271.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_112271", "112271004", "story_v_out_112271.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
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
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1027 = arg_17_1.actors_["1027"].transform.localPosition
				arg_17_1.actors_["1027"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1027"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1027, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_0)
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1027"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_1 = "1148"

			if arg_17_1.actors_["1148"] == nil then
				local var_20_2 = Object.Instantiate(arg_17_1.imageGo_, arg_17_1.canvasGo_.transform)

				var_20_2.transform:SetSiblingIndex(1)

				var_20_2.name = var_20_1

				local var_20_3 = var_20_2:GetComponent(typeof(Image))

				var_20_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1148")

				var_20_3:SetNativeSize()

				var_20_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_17_1.actors_[var_20_1] = var_20_2
			end

			local var_20_4 = arg_17_1.actors_["1148"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1148 = var_20_4.localPosition
				var_20_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_20_5 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 then
				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1148, Vector3.New(0, -500, 0), (arg_17_1.time_ - 0) / var_20_5)
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(0, -500, 0)
			end

			local var_20_6 = arg_17_1.actors_["1148"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_6) then
				local var_20_7 = var_20_6:GetComponent("Image")

				if var_20_7 then
					arg_17_1.var_.highlightMatValue1148 = var_20_7
				end
			end

			local var_20_8 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_6) then
				if arg_17_1.var_.highlightMatValue1148 then
					local var_20_9 = Mathf.Lerp(0.5, 1, (arg_17_1.time_ - 0) / var_20_8)

					arg_17_1.var_.highlightMatValue1148.color.r = var_20_9
					arg_17_1.var_.highlightMatValue1148.color.g = var_20_9
					arg_17_1.var_.highlightMatValue1148.color.b = var_20_9
					arg_17_1.var_.highlightMatValue1148.color = arg_17_1.var_.highlightMatValue1148.color
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.highlightMatValue1148 then
				var_20_6.transform:SetSiblingIndex(1)

				arg_17_1.var_.highlightMatValue1148.color.r = 1
				arg_17_1.var_.highlightMatValue1148.color.g = 1
				arg_17_1.var_.highlightMatValue1148.color.b = 1
				arg_17_1.var_.highlightMatValue1148.color = arg_17_1.var_.highlightMatValue1148.color
			end

			local var_20_10 = 0
			local var_20_11 = 1.025

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(112271005)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 41 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 41)

				if (41 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 41)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271005", "story_v_out_112271.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_112271", "112271005", "story_v_out_112271.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_112271", "112271005", "story_v_out_112271.awb")

						arg_17_1:RecordAudio("112271005", var_20_17)
						arg_17_1:RecordAudio("112271005", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_112271", "112271005", "story_v_out_112271.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_112271", "112271005", "story_v_out_112271.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_18 and arg_17_1.time_ < var_20_10 + var_20_18 + arg_20_0 then
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
			local var_24_0 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(112271006)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 18 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 18)

				if (18 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 18)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271006", "story_v_out_112271.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_112271", "112271006", "story_v_out_112271.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_112271", "112271006", "story_v_out_112271.awb")

						arg_21_1:RecordAudio("112271006", var_24_6)
						arg_21_1:RecordAudio("112271006", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_112271", "112271006", "story_v_out_112271.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_112271", "112271006", "story_v_out_112271.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
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
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = arg_25_1.actors_["1148"].transform.localPosition
				arg_25_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, Vector3.New(0, -2000, -5), (arg_25_1.time_ - 0) / var_28_0)
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, -5)
			end

			local var_28_1 = "1081_1"

			if arg_25_1.actors_["1081_1"] == nil then
				local var_28_2 = Object.Instantiate(arg_25_1.imageGo_, arg_25_1.canvasGo_.transform)

				var_28_2.transform:SetSiblingIndex(1)

				var_28_2.name = var_28_1

				local var_28_3 = var_28_2:GetComponent(typeof(Image))

				var_28_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081_1")

				var_28_3:SetNativeSize()

				var_28_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_25_1.actors_[var_28_1] = var_28_2
			end

			local var_28_4 = arg_25_1.actors_["1081_1"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1081_1 = var_28_4.localPosition
				var_28_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_28_5 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 then
				var_28_4.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_25_1.time_ - 0) / var_28_5)
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 then
				var_28_4.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_28_6 = "1081"

			if arg_25_1.actors_["1081"] == nil then
				local var_28_7 = Object.Instantiate(arg_25_1.imageGo_, arg_25_1.canvasGo_.transform)

				var_28_7.transform:SetSiblingIndex(1)

				var_28_7.name = var_28_6

				local var_28_8 = var_28_7:GetComponent(typeof(Image))

				var_28_8.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081")

				var_28_8:SetNativeSize()

				var_28_7.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_25_1.actors_[var_28_6] = var_28_7
			end

			local var_28_9 = arg_25_1.actors_["1081"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_9) then
				local var_28_10 = var_28_9:GetComponent("Image")

				if var_28_10 then
					arg_25_1.var_.highlightMatValue1081 = var_28_10
				end
			end

			local var_28_11 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_11 and not isNil(var_28_9) then
				if arg_25_1.var_.highlightMatValue1081 then
					local var_28_12 = Mathf.Lerp(0.5, 1, (arg_25_1.time_ - 0) / var_28_11)

					arg_25_1.var_.highlightMatValue1081.color.r = var_28_12
					arg_25_1.var_.highlightMatValue1081.color.g = var_28_12
					arg_25_1.var_.highlightMatValue1081.color.b = var_28_12
					arg_25_1.var_.highlightMatValue1081.color = arg_25_1.var_.highlightMatValue1081.color
				end
			end

			if arg_25_1.time_ >= 0 + var_28_11 and arg_25_1.time_ < 0 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.highlightMatValue1081 then
				var_28_9.transform:SetSiblingIndex(1)

				arg_25_1.var_.highlightMatValue1081.color.r = 1
				arg_25_1.var_.highlightMatValue1081.color.g = 1
				arg_25_1.var_.highlightMatValue1081.color.b = 1
				arg_25_1.var_.highlightMatValue1081.color = arg_25_1.var_.highlightMatValue1081.color
			end

			local var_28_13 = 0
			local var_28_14 = 0.375

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_15 = arg_25_1:GetWordFromCfg(112271007)
				local var_28_16 = arg_25_1:FormatText(var_28_15.content)

				arg_25_1.text_.text = var_28_16

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_18 = 15 <= 0 and var_28_14 or var_28_14 * (utf8.len(var_28_16) / 15)

				if (15 <= 0 and var_28_14 or var_28_14 * (utf8.len(var_28_16) / 15)) > 0 and var_28_14 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_13 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_13
					end
				end

				arg_25_1.text_.text = var_28_16
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271007", "story_v_out_112271.awb") ~= 0 then
					local var_28_19 = manager.audio:GetVoiceLength("story_v_out_112271", "112271007", "story_v_out_112271.awb") / 1000

					if var_28_19 + var_28_13 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_13
					end

					if var_28_15.prefab_name ~= "" and arg_25_1.actors_[var_28_15.prefab_name] ~= nil then
						local var_28_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_15.prefab_name].transform, "story_v_out_112271", "112271007", "story_v_out_112271.awb")

						arg_25_1:RecordAudio("112271007", var_28_20)
						arg_25_1:RecordAudio("112271007", var_28_20)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_112271", "112271007", "story_v_out_112271.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_112271", "112271007", "story_v_out_112271.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_14, arg_25_1.talkMaxDuration)

			if var_28_13 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_13) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_13 + var_28_21 and arg_25_1.time_ < var_28_13 + var_28_21 + arg_28_0 then
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
			local var_32_0 = 0.625

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(112271008)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 25 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 25)

				if (25 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 25)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271008", "story_v_out_112271.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_112271", "112271008", "story_v_out_112271.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_112271", "112271008", "story_v_out_112271.awb")

						arg_29_1:RecordAudio("112271008", var_32_6)
						arg_29_1:RecordAudio("112271008", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_112271", "112271008", "story_v_out_112271.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_112271", "112271008", "story_v_out_112271.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
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
			local var_36_0 = 1.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(112271009)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 45 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 45)

				if (45 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 45)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271009", "story_v_out_112271.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_112271", "112271009", "story_v_out_112271.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_112271", "112271009", "story_v_out_112271.awb")

						arg_33_1:RecordAudio("112271009", var_36_6)
						arg_33_1:RecordAudio("112271009", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_112271", "112271009", "story_v_out_112271.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_112271", "112271009", "story_v_out_112271.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
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
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1081"]) then
				local var_40_0 = arg_37_1.actors_["1081"]:GetComponent("Image")

				if var_40_0 then
					arg_37_1.var_.highlightMatValue1081 = var_40_0
				end
			end

			local var_40_1 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(arg_37_1.actors_["1081"]) then
				if arg_37_1.var_.highlightMatValue1081 then
					local var_40_2 = Mathf.Lerp(1, 0.5, (arg_37_1.time_ - 0) / var_40_1)

					arg_37_1.var_.highlightMatValue1081.color.r = var_40_2
					arg_37_1.var_.highlightMatValue1081.color.g = var_40_2
					arg_37_1.var_.highlightMatValue1081.color.b = var_40_2
					arg_37_1.var_.highlightMatValue1081.color = arg_37_1.var_.highlightMatValue1081.color
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(arg_37_1.actors_["1081"]) and arg_37_1.var_.highlightMatValue1081 then
				arg_37_1.var_.highlightMatValue1081.color.r = 0.5
				arg_37_1.var_.highlightMatValue1081.color.g = 0.5
				arg_37_1.var_.highlightMatValue1081.color.b = 0.5
				arg_37_1.var_.highlightMatValue1081.color = arg_37_1.var_.highlightMatValue1081.color
			end

			local var_40_3 = 0
			local var_40_4 = 0.375

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

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

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(112271010).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 15 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 15)

				if (15 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 15)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
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
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1081"]) then
				local var_44_0 = arg_41_1.actors_["1081"]:GetComponent("Image")

				if var_44_0 then
					arg_41_1.var_.highlightMatValue1081 = var_44_0
				end
			end

			local var_44_1 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 and not isNil(arg_41_1.actors_["1081"]) then
				if arg_41_1.var_.highlightMatValue1081 then
					local var_44_2 = Mathf.Lerp(0.5, 1, (arg_41_1.time_ - 0) / var_44_1)

					arg_41_1.var_.highlightMatValue1081.color.r = var_44_2
					arg_41_1.var_.highlightMatValue1081.color.g = var_44_2
					arg_41_1.var_.highlightMatValue1081.color.b = var_44_2
					arg_41_1.var_.highlightMatValue1081.color = arg_41_1.var_.highlightMatValue1081.color
				end
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 and not isNil(arg_41_1.actors_["1081"]) and arg_41_1.var_.highlightMatValue1081 then
				arg_41_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_41_1.var_.highlightMatValue1081.color.r = 1
				arg_41_1.var_.highlightMatValue1081.color.g = 1
				arg_41_1.var_.highlightMatValue1081.color.b = 1
				arg_41_1.var_.highlightMatValue1081.color = arg_41_1.var_.highlightMatValue1081.color
			end

			local var_44_3 = 0
			local var_44_4 = 0.75

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:GetWordFromCfg(112271011)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 30 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 30)

				if (30 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 30)) > 0 and var_44_4 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271011", "story_v_out_112271.awb") ~= 0 then
					local var_44_9 = manager.audio:GetVoiceLength("story_v_out_112271", "112271011", "story_v_out_112271.awb") / 1000

					if var_44_9 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_3
					end

					if var_44_5.prefab_name ~= "" and arg_41_1.actors_[var_44_5.prefab_name] ~= nil then
						local var_44_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_5.prefab_name].transform, "story_v_out_112271", "112271011", "story_v_out_112271.awb")

						arg_41_1:RecordAudio("112271011", var_44_10)
						arg_41_1:RecordAudio("112271011", var_44_10)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_112271", "112271011", "story_v_out_112271.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_112271", "112271011", "story_v_out_112271.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_11 and arg_41_1.time_ < var_44_3 + var_44_11 + arg_44_0 then
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
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1081"]) then
				local var_48_0 = arg_45_1.actors_["1081"]:GetComponent("Image")

				if var_48_0 then
					arg_45_1.var_.highlightMatValue1081 = var_48_0
				end
			end

			local var_48_1 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 and not isNil(arg_45_1.actors_["1081"]) then
				if arg_45_1.var_.highlightMatValue1081 then
					local var_48_2 = Mathf.Lerp(1, 0.5, (arg_45_1.time_ - 0) / var_48_1)

					arg_45_1.var_.highlightMatValue1081.color.r = var_48_2
					arg_45_1.var_.highlightMatValue1081.color.g = var_48_2
					arg_45_1.var_.highlightMatValue1081.color.b = var_48_2
					arg_45_1.var_.highlightMatValue1081.color = arg_45_1.var_.highlightMatValue1081.color
				end
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 and not isNil(arg_45_1.actors_["1081"]) and arg_45_1.var_.highlightMatValue1081 then
				arg_45_1.var_.highlightMatValue1081.color.r = 0.5
				arg_45_1.var_.highlightMatValue1081.color.g = 0.5
				arg_45_1.var_.highlightMatValue1081.color.b = 0.5
				arg_45_1.var_.highlightMatValue1081.color = arg_45_1.var_.highlightMatValue1081.color
			end

			local var_48_3 = 0
			local var_48_4 = 0.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

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

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(112271012).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 4 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 4)

				if (4 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 4)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
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
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1081"]) then
				local var_52_0 = arg_49_1.actors_["1081"]:GetComponent("Image")

				if var_52_0 then
					arg_49_1.var_.highlightMatValue1081 = var_52_0
				end
			end

			local var_52_1 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 and not isNil(arg_49_1.actors_["1081"]) then
				if arg_49_1.var_.highlightMatValue1081 then
					local var_52_2 = Mathf.Lerp(0.5, 1, (arg_49_1.time_ - 0) / var_52_1)

					arg_49_1.var_.highlightMatValue1081.color.r = var_52_2
					arg_49_1.var_.highlightMatValue1081.color.g = var_52_2
					arg_49_1.var_.highlightMatValue1081.color.b = var_52_2
					arg_49_1.var_.highlightMatValue1081.color = arg_49_1.var_.highlightMatValue1081.color
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 and not isNil(arg_49_1.actors_["1081"]) and arg_49_1.var_.highlightMatValue1081 then
				arg_49_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_49_1.var_.highlightMatValue1081.color.r = 1
				arg_49_1.var_.highlightMatValue1081.color.g = 1
				arg_49_1.var_.highlightMatValue1081.color.b = 1
				arg_49_1.var_.highlightMatValue1081.color = arg_49_1.var_.highlightMatValue1081.color
			end

			local var_52_3 = 0
			local var_52_4 = 0.775

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(112271013)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 31 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 31)

				if (31 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 31)) > 0 and var_52_4 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271013", "story_v_out_112271.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_out_112271", "112271013", "story_v_out_112271.awb") / 1000

					if var_52_9 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_3
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_112271", "112271013", "story_v_out_112271.awb")

						arg_49_1:RecordAudio("112271013", var_52_10)
						arg_49_1:RecordAudio("112271013", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_112271", "112271013", "story_v_out_112271.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_112271", "112271013", "story_v_out_112271.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_11 and arg_49_1.time_ < var_52_3 + var_52_11 + arg_52_0 then
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
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1081"]) then
				local var_56_0 = arg_53_1.actors_["1081"]:GetComponent("Image")

				if var_56_0 then
					arg_53_1.var_.highlightMatValue1081 = var_56_0
				end
			end

			local var_56_1 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 and not isNil(arg_53_1.actors_["1081"]) then
				if arg_53_1.var_.highlightMatValue1081 then
					local var_56_2 = Mathf.Lerp(1, 0.5, (arg_53_1.time_ - 0) / var_56_1)

					arg_53_1.var_.highlightMatValue1081.color.r = var_56_2
					arg_53_1.var_.highlightMatValue1081.color.g = var_56_2
					arg_53_1.var_.highlightMatValue1081.color.b = var_56_2
					arg_53_1.var_.highlightMatValue1081.color = arg_53_1.var_.highlightMatValue1081.color
				end
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 and not isNil(arg_53_1.actors_["1081"]) and arg_53_1.var_.highlightMatValue1081 then
				arg_53_1.var_.highlightMatValue1081.color.r = 0.5
				arg_53_1.var_.highlightMatValue1081.color.g = 0.5
				arg_53_1.var_.highlightMatValue1081.color.b = 0.5
				arg_53_1.var_.highlightMatValue1081.color = arg_53_1.var_.highlightMatValue1081.color
			end

			local var_56_3 = 0
			local var_56_4 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

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

				local var_56_5 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(112271014).content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 14 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 14)

				if (14 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 14)) > 0 and var_56_4 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_8 and arg_53_1.time_ < var_56_3 + var_56_8 + arg_56_0 then
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
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1081"]) then
				local var_60_0 = arg_57_1.actors_["1081"]:GetComponent("Image")

				if var_60_0 then
					arg_57_1.var_.highlightMatValue1081 = var_60_0
				end
			end

			local var_60_1 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 and not isNil(arg_57_1.actors_["1081"]) then
				if arg_57_1.var_.highlightMatValue1081 then
					local var_60_2 = Mathf.Lerp(0.5, 1, (arg_57_1.time_ - 0) / var_60_1)

					arg_57_1.var_.highlightMatValue1081.color.r = var_60_2
					arg_57_1.var_.highlightMatValue1081.color.g = var_60_2
					arg_57_1.var_.highlightMatValue1081.color.b = var_60_2
					arg_57_1.var_.highlightMatValue1081.color = arg_57_1.var_.highlightMatValue1081.color
				end
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 and not isNil(arg_57_1.actors_["1081"]) and arg_57_1.var_.highlightMatValue1081 then
				arg_57_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_57_1.var_.highlightMatValue1081.color.r = 1
				arg_57_1.var_.highlightMatValue1081.color.g = 1
				arg_57_1.var_.highlightMatValue1081.color.b = 1
				arg_57_1.var_.highlightMatValue1081.color = arg_57_1.var_.highlightMatValue1081.color
			end

			local var_60_3 = 0
			local var_60_4 = 0.275

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:GetWordFromCfg(112271015)
				local var_60_6 = arg_57_1:FormatText(var_60_5.content)

				arg_57_1.text_.text = var_60_6

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_8 = 11 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_6) / 11)

				if (11 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_6) / 11)) > 0 and var_60_4 < var_60_8 then
					arg_57_1.talkMaxDuration = var_60_8

					if var_60_8 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_6
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271015", "story_v_out_112271.awb") ~= 0 then
					local var_60_9 = manager.audio:GetVoiceLength("story_v_out_112271", "112271015", "story_v_out_112271.awb") / 1000

					if var_60_9 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_3
					end

					if var_60_5.prefab_name ~= "" and arg_57_1.actors_[var_60_5.prefab_name] ~= nil then
						local var_60_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_5.prefab_name].transform, "story_v_out_112271", "112271015", "story_v_out_112271.awb")

						arg_57_1:RecordAudio("112271015", var_60_10)
						arg_57_1:RecordAudio("112271015", var_60_10)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_112271", "112271015", "story_v_out_112271.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_112271", "112271015", "story_v_out_112271.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_11 and arg_57_1.time_ < var_60_3 + var_60_11 + arg_60_0 then
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
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1081"]) then
				local var_64_0 = arg_61_1.actors_["1081"]:GetComponent("Image")

				if var_64_0 then
					arg_61_1.var_.highlightMatValue1081 = var_64_0
				end
			end

			local var_64_1 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 and not isNil(arg_61_1.actors_["1081"]) then
				if arg_61_1.var_.highlightMatValue1081 then
					local var_64_2 = Mathf.Lerp(1, 0.5, (arg_61_1.time_ - 0) / var_64_1)

					arg_61_1.var_.highlightMatValue1081.color.r = var_64_2
					arg_61_1.var_.highlightMatValue1081.color.g = var_64_2
					arg_61_1.var_.highlightMatValue1081.color.b = var_64_2
					arg_61_1.var_.highlightMatValue1081.color = arg_61_1.var_.highlightMatValue1081.color
				end
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 and not isNil(arg_61_1.actors_["1081"]) and arg_61_1.var_.highlightMatValue1081 then
				arg_61_1.var_.highlightMatValue1081.color.r = 0.5
				arg_61_1.var_.highlightMatValue1081.color.g = 0.5
				arg_61_1.var_.highlightMatValue1081.color.b = 0.5
				arg_61_1.var_.highlightMatValue1081.color = arg_61_1.var_.highlightMatValue1081.color
			end

			local var_64_3 = 0
			local var_64_4 = 0.25

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

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

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(112271016).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 10 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 10)

				if (10 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 10)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
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
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1081"]) then
				local var_68_0 = arg_65_1.actors_["1081"]:GetComponent("Image")

				if var_68_0 then
					arg_65_1.var_.highlightMatValue1081 = var_68_0
				end
			end

			local var_68_1 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 and not isNil(arg_65_1.actors_["1081"]) then
				if arg_65_1.var_.highlightMatValue1081 then
					local var_68_2 = Mathf.Lerp(0.5, 1, (arg_65_1.time_ - 0) / var_68_1)

					arg_65_1.var_.highlightMatValue1081.color.r = var_68_2
					arg_65_1.var_.highlightMatValue1081.color.g = var_68_2
					arg_65_1.var_.highlightMatValue1081.color.b = var_68_2
					arg_65_1.var_.highlightMatValue1081.color = arg_65_1.var_.highlightMatValue1081.color
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and not isNil(arg_65_1.actors_["1081"]) and arg_65_1.var_.highlightMatValue1081 then
				arg_65_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_65_1.var_.highlightMatValue1081.color.r = 1
				arg_65_1.var_.highlightMatValue1081.color.g = 1
				arg_65_1.var_.highlightMatValue1081.color.b = 1
				arg_65_1.var_.highlightMatValue1081.color = arg_65_1.var_.highlightMatValue1081.color
			end

			local var_68_3 = 0
			local var_68_4 = 0.75

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:GetWordFromCfg(112271017)
				local var_68_6 = arg_65_1:FormatText(var_68_5.content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 30 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_6) / 30)

				if (30 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_6) / 30)) > 0 and var_68_4 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_3
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271017", "story_v_out_112271.awb") ~= 0 then
					local var_68_9 = manager.audio:GetVoiceLength("story_v_out_112271", "112271017", "story_v_out_112271.awb") / 1000

					if var_68_9 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_3
					end

					if var_68_5.prefab_name ~= "" and arg_65_1.actors_[var_68_5.prefab_name] ~= nil then
						local var_68_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_5.prefab_name].transform, "story_v_out_112271", "112271017", "story_v_out_112271.awb")

						arg_65_1:RecordAudio("112271017", var_68_10)
						arg_65_1:RecordAudio("112271017", var_68_10)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_112271", "112271017", "story_v_out_112271.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_112271", "112271017", "story_v_out_112271.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_11 = math.max(var_68_4, arg_65_1.talkMaxDuration)

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_11 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_3) / var_68_11

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_3 + var_68_11 and arg_65_1.time_ < var_68_3 + var_68_11 + arg_68_0 then
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
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1081"]) then
				local var_72_0 = arg_69_1.actors_["1081"]:GetComponent("Image")

				if var_72_0 then
					arg_69_1.var_.highlightMatValue1081 = var_72_0
				end
			end

			local var_72_1 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 and not isNil(arg_69_1.actors_["1081"]) then
				if arg_69_1.var_.highlightMatValue1081 then
					local var_72_2 = Mathf.Lerp(1, 0.5, (arg_69_1.time_ - 0) / var_72_1)

					arg_69_1.var_.highlightMatValue1081.color.r = var_72_2
					arg_69_1.var_.highlightMatValue1081.color.g = var_72_2
					arg_69_1.var_.highlightMatValue1081.color.b = var_72_2
					arg_69_1.var_.highlightMatValue1081.color = arg_69_1.var_.highlightMatValue1081.color
				end
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 and not isNil(arg_69_1.actors_["1081"]) and arg_69_1.var_.highlightMatValue1081 then
				arg_69_1.var_.highlightMatValue1081.color.r = 0.5
				arg_69_1.var_.highlightMatValue1081.color.g = 0.5
				arg_69_1.var_.highlightMatValue1081.color.b = 0.5
				arg_69_1.var_.highlightMatValue1081.color = arg_69_1.var_.highlightMatValue1081.color
			end

			local var_72_3 = 0
			local var_72_4 = 0.075

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

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

				local var_72_5 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(112271018).content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 3 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_5) / 3)

				if (3 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_5) / 3)) > 0 and var_72_4 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_3) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_3 + var_72_8 and arg_69_1.time_ < var_72_3 + var_72_8 + arg_72_0 then
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
			local var_76_0 = 1.15

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(112271019).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 46 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 46)

				if (46 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 46)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
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
			local var_80_0 = 0.675

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(112271020).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 27 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 27)

				if (27 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 27)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
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
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1081"]) then
				local var_84_0 = arg_81_1.actors_["1081"]:GetComponent("Image")

				if var_84_0 then
					arg_81_1.var_.highlightMatValue1081 = var_84_0
				end
			end

			local var_84_1 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 and not isNil(arg_81_1.actors_["1081"]) then
				if arg_81_1.var_.highlightMatValue1081 then
					local var_84_2 = Mathf.Lerp(0.5, 1, (arg_81_1.time_ - 0) / var_84_1)

					arg_81_1.var_.highlightMatValue1081.color.r = var_84_2
					arg_81_1.var_.highlightMatValue1081.color.g = var_84_2
					arg_81_1.var_.highlightMatValue1081.color.b = var_84_2
					arg_81_1.var_.highlightMatValue1081.color = arg_81_1.var_.highlightMatValue1081.color
				end
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 and not isNil(arg_81_1.actors_["1081"]) and arg_81_1.var_.highlightMatValue1081 then
				arg_81_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_81_1.var_.highlightMatValue1081.color.r = 1
				arg_81_1.var_.highlightMatValue1081.color.g = 1
				arg_81_1.var_.highlightMatValue1081.color.b = 1
				arg_81_1.var_.highlightMatValue1081.color = arg_81_1.var_.highlightMatValue1081.color
			end

			local var_84_3 = 0
			local var_84_4 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:GetWordFromCfg(112271021)
				local var_84_6 = arg_81_1:FormatText(var_84_5.content)

				arg_81_1.text_.text = var_84_6

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_8 = 15 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_6) / 15)

				if (15 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_6) / 15)) > 0 and var_84_4 < var_84_8 then
					arg_81_1.talkMaxDuration = var_84_8

					if var_84_8 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_6
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271021", "story_v_out_112271.awb") ~= 0 then
					local var_84_9 = manager.audio:GetVoiceLength("story_v_out_112271", "112271021", "story_v_out_112271.awb") / 1000

					if var_84_9 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_3
					end

					if var_84_5.prefab_name ~= "" and arg_81_1.actors_[var_84_5.prefab_name] ~= nil then
						local var_84_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_5.prefab_name].transform, "story_v_out_112271", "112271021", "story_v_out_112271.awb")

						arg_81_1:RecordAudio("112271021", var_84_10)
						arg_81_1:RecordAudio("112271021", var_84_10)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_112271", "112271021", "story_v_out_112271.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_112271", "112271021", "story_v_out_112271.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_11 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_11 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_11

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_11 and arg_81_1.time_ < var_84_3 + var_84_11 + arg_84_0 then
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
			local var_88_0 = 0.675

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(112271022)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 27 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 27)

				if (27 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 27)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271022", "story_v_out_112271.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_112271", "112271022", "story_v_out_112271.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_112271", "112271022", "story_v_out_112271.awb")

						arg_85_1:RecordAudio("112271022", var_88_6)
						arg_85_1:RecordAudio("112271022", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_112271", "112271022", "story_v_out_112271.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_112271", "112271022", "story_v_out_112271.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
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
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1081"]) then
				local var_92_0 = arg_89_1.actors_["1081"]:GetComponent("Image")

				if var_92_0 then
					arg_89_1.var_.highlightMatValue1081 = var_92_0
				end
			end

			local var_92_1 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 and not isNil(arg_89_1.actors_["1081"]) then
				if arg_89_1.var_.highlightMatValue1081 then
					local var_92_2 = Mathf.Lerp(1, 0.5, (arg_89_1.time_ - 0) / var_92_1)

					arg_89_1.var_.highlightMatValue1081.color.r = var_92_2
					arg_89_1.var_.highlightMatValue1081.color.g = var_92_2
					arg_89_1.var_.highlightMatValue1081.color.b = var_92_2
					arg_89_1.var_.highlightMatValue1081.color = arg_89_1.var_.highlightMatValue1081.color
				end
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 and not isNil(arg_89_1.actors_["1081"]) and arg_89_1.var_.highlightMatValue1081 then
				arg_89_1.var_.highlightMatValue1081.color.r = 0.5
				arg_89_1.var_.highlightMatValue1081.color.g = 0.5
				arg_89_1.var_.highlightMatValue1081.color.b = 0.5
				arg_89_1.var_.highlightMatValue1081.color = arg_89_1.var_.highlightMatValue1081.color
			end

			local var_92_3 = 0
			local var_92_4 = 0.125

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

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

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(112271023).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 5 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 5)

				if (5 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 5)) > 0 and var_92_4 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_8 and arg_89_1.time_ < var_92_3 + var_92_8 + arg_92_0 then
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
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1081"]) then
				local var_96_0 = arg_93_1.actors_["1081"]:GetComponent("Image")

				if var_96_0 then
					arg_93_1.var_.highlightMatValue1081 = var_96_0
				end
			end

			local var_96_1 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 and not isNil(arg_93_1.actors_["1081"]) then
				if arg_93_1.var_.highlightMatValue1081 then
					local var_96_2 = Mathf.Lerp(0.5, 1, (arg_93_1.time_ - 0) / var_96_1)

					arg_93_1.var_.highlightMatValue1081.color.r = var_96_2
					arg_93_1.var_.highlightMatValue1081.color.g = var_96_2
					arg_93_1.var_.highlightMatValue1081.color.b = var_96_2
					arg_93_1.var_.highlightMatValue1081.color = arg_93_1.var_.highlightMatValue1081.color
				end
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 and not isNil(arg_93_1.actors_["1081"]) and arg_93_1.var_.highlightMatValue1081 then
				arg_93_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_93_1.var_.highlightMatValue1081.color.r = 1
				arg_93_1.var_.highlightMatValue1081.color.g = 1
				arg_93_1.var_.highlightMatValue1081.color.b = 1
				arg_93_1.var_.highlightMatValue1081.color = arg_93_1.var_.highlightMatValue1081.color
			end

			local var_96_3 = 0
			local var_96_4 = 0.15

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:GetWordFromCfg(112271024)
				local var_96_6 = arg_93_1:FormatText(var_96_5.content)

				arg_93_1.text_.text = var_96_6

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_8 = 6 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 6)

				if (6 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 6)) > 0 and var_96_4 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_6
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271024", "story_v_out_112271.awb") ~= 0 then
					local var_96_9 = manager.audio:GetVoiceLength("story_v_out_112271", "112271024", "story_v_out_112271.awb") / 1000

					if var_96_9 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_3
					end

					if var_96_5.prefab_name ~= "" and arg_93_1.actors_[var_96_5.prefab_name] ~= nil then
						local var_96_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_5.prefab_name].transform, "story_v_out_112271", "112271024", "story_v_out_112271.awb")

						arg_93_1:RecordAudio("112271024", var_96_10)
						arg_93_1:RecordAudio("112271024", var_96_10)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_112271", "112271024", "story_v_out_112271.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_112271", "112271024", "story_v_out_112271.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_11 and arg_93_1.time_ < var_96_3 + var_96_11 + arg_96_0 then
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
			local var_100_0 = 0.875

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(112271025)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 35 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 35)

				if (35 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 35)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271025", "story_v_out_112271.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_112271", "112271025", "story_v_out_112271.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_112271", "112271025", "story_v_out_112271.awb")

						arg_97_1:RecordAudio("112271025", var_100_6)
						arg_97_1:RecordAudio("112271025", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_112271", "112271025", "story_v_out_112271.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_112271", "112271025", "story_v_out_112271.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
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
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1081"]) then
				local var_104_0 = arg_101_1.actors_["1081"]:GetComponent("Image")

				if var_104_0 then
					arg_101_1.var_.highlightMatValue1081 = var_104_0
				end
			end

			local var_104_1 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 and not isNil(arg_101_1.actors_["1081"]) then
				if arg_101_1.var_.highlightMatValue1081 then
					local var_104_2 = Mathf.Lerp(1, 0.5, (arg_101_1.time_ - 0) / var_104_1)

					arg_101_1.var_.highlightMatValue1081.color.r = var_104_2
					arg_101_1.var_.highlightMatValue1081.color.g = var_104_2
					arg_101_1.var_.highlightMatValue1081.color.b = var_104_2
					arg_101_1.var_.highlightMatValue1081.color = arg_101_1.var_.highlightMatValue1081.color
				end
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 and not isNil(arg_101_1.actors_["1081"]) and arg_101_1.var_.highlightMatValue1081 then
				arg_101_1.var_.highlightMatValue1081.color.r = 0.5
				arg_101_1.var_.highlightMatValue1081.color.g = 0.5
				arg_101_1.var_.highlightMatValue1081.color.b = 0.5
				arg_101_1.var_.highlightMatValue1081.color = arg_101_1.var_.highlightMatValue1081.color
			end

			local var_104_3 = 0
			local var_104_4 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

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

				local var_104_5 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(112271026).content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 18 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 18)

				if (18 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 18)) > 0 and var_104_4 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_3 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_3
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_4, arg_101_1.talkMaxDuration)

			if var_104_3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_3 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_3) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_3 + var_104_8 and arg_101_1.time_ < var_104_3 + var_104_8 + arg_104_0 then
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
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1081"]) then
				local var_108_0 = arg_105_1.actors_["1081"]:GetComponent("Image")

				if var_108_0 then
					arg_105_1.var_.highlightMatValue1081 = var_108_0
				end
			end

			local var_108_1 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 and not isNil(arg_105_1.actors_["1081"]) then
				if arg_105_1.var_.highlightMatValue1081 then
					local var_108_2 = Mathf.Lerp(0.5, 1, (arg_105_1.time_ - 0) / var_108_1)

					arg_105_1.var_.highlightMatValue1081.color.r = var_108_2
					arg_105_1.var_.highlightMatValue1081.color.g = var_108_2
					arg_105_1.var_.highlightMatValue1081.color.b = var_108_2
					arg_105_1.var_.highlightMatValue1081.color = arg_105_1.var_.highlightMatValue1081.color
				end
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 and not isNil(arg_105_1.actors_["1081"]) and arg_105_1.var_.highlightMatValue1081 then
				arg_105_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_105_1.var_.highlightMatValue1081.color.r = 1
				arg_105_1.var_.highlightMatValue1081.color.g = 1
				arg_105_1.var_.highlightMatValue1081.color.b = 1
				arg_105_1.var_.highlightMatValue1081.color = arg_105_1.var_.highlightMatValue1081.color
			end

			local var_108_3 = 0
			local var_108_4 = 1.225

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:GetWordFromCfg(112271027)
				local var_108_6 = arg_105_1:FormatText(var_108_5.content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_8 = 49 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_6) / 49)

				if (49 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_6) / 49)) > 0 and var_108_4 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_3
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271027", "story_v_out_112271.awb") ~= 0 then
					local var_108_9 = manager.audio:GetVoiceLength("story_v_out_112271", "112271027", "story_v_out_112271.awb") / 1000

					if var_108_9 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_3
					end

					if var_108_5.prefab_name ~= "" and arg_105_1.actors_[var_108_5.prefab_name] ~= nil then
						local var_108_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_5.prefab_name].transform, "story_v_out_112271", "112271027", "story_v_out_112271.awb")

						arg_105_1:RecordAudio("112271027", var_108_10)
						arg_105_1:RecordAudio("112271027", var_108_10)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_112271", "112271027", "story_v_out_112271.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_112271", "112271027", "story_v_out_112271.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_11 = math.max(var_108_4, arg_105_1.talkMaxDuration)

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_3) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_3 + var_108_11 and arg_105_1.time_ < var_108_3 + var_108_11 + arg_108_0 then
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
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1081"]) then
				local var_112_0 = arg_109_1.actors_["1081"]:GetComponent("Image")

				if var_112_0 then
					arg_109_1.var_.highlightMatValue1081 = var_112_0
				end
			end

			local var_112_1 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 and not isNil(arg_109_1.actors_["1081"]) then
				if arg_109_1.var_.highlightMatValue1081 then
					local var_112_2 = Mathf.Lerp(1, 0.5, (arg_109_1.time_ - 0) / var_112_1)

					arg_109_1.var_.highlightMatValue1081.color.r = var_112_2
					arg_109_1.var_.highlightMatValue1081.color.g = var_112_2
					arg_109_1.var_.highlightMatValue1081.color.b = var_112_2
					arg_109_1.var_.highlightMatValue1081.color = arg_109_1.var_.highlightMatValue1081.color
				end
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 and not isNil(arg_109_1.actors_["1081"]) and arg_109_1.var_.highlightMatValue1081 then
				arg_109_1.var_.highlightMatValue1081.color.r = 0.5
				arg_109_1.var_.highlightMatValue1081.color.g = 0.5
				arg_109_1.var_.highlightMatValue1081.color.b = 0.5
				arg_109_1.var_.highlightMatValue1081.color = arg_109_1.var_.highlightMatValue1081.color
			end

			local var_112_3 = 0
			local var_112_4 = 0.425

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

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

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(112271028).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 17 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 17)

				if (17 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 17)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
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
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1081"]) then
				local var_116_0 = arg_113_1.actors_["1081"]:GetComponent("Image")

				if var_116_0 then
					arg_113_1.var_.highlightMatValue1081 = var_116_0
				end
			end

			local var_116_1 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 and not isNil(arg_113_1.actors_["1081"]) then
				if arg_113_1.var_.highlightMatValue1081 then
					local var_116_2 = Mathf.Lerp(0.5, 1, (arg_113_1.time_ - 0) / var_116_1)

					arg_113_1.var_.highlightMatValue1081.color.r = var_116_2
					arg_113_1.var_.highlightMatValue1081.color.g = var_116_2
					arg_113_1.var_.highlightMatValue1081.color.b = var_116_2
					arg_113_1.var_.highlightMatValue1081.color = arg_113_1.var_.highlightMatValue1081.color
				end
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 and not isNil(arg_113_1.actors_["1081"]) and arg_113_1.var_.highlightMatValue1081 then
				arg_113_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_113_1.var_.highlightMatValue1081.color.r = 1
				arg_113_1.var_.highlightMatValue1081.color.g = 1
				arg_113_1.var_.highlightMatValue1081.color.b = 1
				arg_113_1.var_.highlightMatValue1081.color = arg_113_1.var_.highlightMatValue1081.color
			end

			local var_116_3 = 0
			local var_116_4 = 0.525

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:GetWordFromCfg(112271029)
				local var_116_6 = arg_113_1:FormatText(var_116_5.content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_8 = 21 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_6) / 21)

				if (21 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_6) / 21)) > 0 and var_116_4 < var_116_8 then
					arg_113_1.talkMaxDuration = var_116_8

					if var_116_8 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271029", "story_v_out_112271.awb") ~= 0 then
					local var_116_9 = manager.audio:GetVoiceLength("story_v_out_112271", "112271029", "story_v_out_112271.awb") / 1000

					if var_116_9 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_3
					end

					if var_116_5.prefab_name ~= "" and arg_113_1.actors_[var_116_5.prefab_name] ~= nil then
						local var_116_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_5.prefab_name].transform, "story_v_out_112271", "112271029", "story_v_out_112271.awb")

						arg_113_1:RecordAudio("112271029", var_116_10)
						arg_113_1:RecordAudio("112271029", var_116_10)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_112271", "112271029", "story_v_out_112271.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_112271", "112271029", "story_v_out_112271.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_11 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_11 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_3) / var_116_11

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_3 + var_116_11 and arg_113_1.time_ < var_116_3 + var_116_11 + arg_116_0 then
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
			local var_120_0 = 0.35

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(112271030)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 14 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 14)

				if (14 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 14)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112271", "112271030", "story_v_out_112271.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_112271", "112271030", "story_v_out_112271.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_112271", "112271030", "story_v_out_112271.awb")

						arg_117_1:RecordAudio("112271030", var_120_6)
						arg_117_1:RecordAudio("112271030", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_112271", "112271030", "story_v_out_112271.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_112271", "112271030", "story_v_out_112271.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
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
