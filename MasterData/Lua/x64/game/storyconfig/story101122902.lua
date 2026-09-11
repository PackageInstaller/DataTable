return {
	Play112292001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112292001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112292002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0.575

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

				local var_4_1 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112292001).content)

				arg_1_1.text_.text = var_4_1

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_3 = 23 <= 0 and var_4_0 or var_4_0 * (utf8.len(var_4_1) / 23)

				if (23 <= 0 and var_4_0 or var_4_0 * (utf8.len(var_4_1) / 23)) > 0 and var_4_0 < var_4_3 then
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
	Play112292002 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 112292002
		arg_5_1.duration_ = 4.8

		local var_5_0 = {
			ja = 3.833,
			ko = 3.333,
			zh = 2.3,
			en = 4.8
		}
		local var_5_1 = manager.audio:GetLocalizationFlag()

		if var_5_0[var_5_1] ~= nil then
			arg_5_1.duration_ = var_5_0[var_5_1]
		end

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play112292003(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			if arg_5_1.actors_["1081_1"] == nil then
				local var_8_0 = Object.Instantiate(arg_5_1.imageGo_, arg_5_1.canvasGo_.transform)

				var_8_0.transform:SetSiblingIndex(1)

				var_8_0.name = "1081_1"

				local var_8_1 = var_8_0:GetComponent(typeof(Image))

				var_8_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081_1")

				var_8_1:SetNativeSize()

				var_8_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_5_1.actors_["1081_1"] = var_8_0
			end

			local var_8_2 = arg_5_1.actors_["1081_1"].transform

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				arg_5_1.var_.moveOldPos1081_1 = var_8_2.localPosition
				var_8_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_8_3 = 0.001

			if 0 <= arg_5_1.time_ and arg_5_1.time_ < 0 + var_8_3 then
				var_8_2.localPosition = Vector3.Lerp(arg_5_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_5_1.time_ - 0) / var_8_3)
			end

			if arg_5_1.time_ >= 0 + var_8_3 and arg_5_1.time_ < 0 + var_8_3 + arg_8_0 then
				var_8_2.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_8_4 = "1081"

			if arg_5_1.actors_["1081"] == nil then
				local var_8_5 = Object.Instantiate(arg_5_1.imageGo_, arg_5_1.canvasGo_.transform)

				var_8_5.transform:SetSiblingIndex(1)

				var_8_5.name = var_8_4

				local var_8_6 = var_8_5:GetComponent(typeof(Image))

				var_8_6.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081")

				var_8_6:SetNativeSize()

				var_8_5.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_5_1.actors_[var_8_4] = var_8_5
			end

			local var_8_7 = arg_5_1.actors_["1081"]

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 and not isNil(var_8_7) then
				local var_8_8 = var_8_7:GetComponent("Image")

				if var_8_8 then
					arg_5_1.var_.highlightMatValue1081 = var_8_8
				end
			end

			local var_8_9 = 0.2

			if 0 <= arg_5_1.time_ and arg_5_1.time_ < 0 + var_8_9 and not isNil(var_8_7) then
				if arg_5_1.var_.highlightMatValue1081 then
					local var_8_10 = Mathf.Lerp(0.5, 1, (arg_5_1.time_ - 0) / var_8_9)

					arg_5_1.var_.highlightMatValue1081.color.r = var_8_10
					arg_5_1.var_.highlightMatValue1081.color.g = var_8_10
					arg_5_1.var_.highlightMatValue1081.color.b = var_8_10
					arg_5_1.var_.highlightMatValue1081.color = arg_5_1.var_.highlightMatValue1081.color
				end
			end

			if arg_5_1.time_ >= 0 + var_8_9 and arg_5_1.time_ < 0 + var_8_9 + arg_8_0 and not isNil(var_8_7) and arg_5_1.var_.highlightMatValue1081 then
				var_8_7.transform:SetSiblingIndex(1)

				arg_5_1.var_.highlightMatValue1081.color.r = 1
				arg_5_1.var_.highlightMatValue1081.color.g = 1
				arg_5_1.var_.highlightMatValue1081.color.b = 1
				arg_5_1.var_.highlightMatValue1081.color = arg_5_1.var_.highlightMatValue1081.color
			end

			local var_8_11 = 0
			local var_8_12 = 0.25

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= var_8_11 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, true)

				arg_5_1.leftNameTxt_.text = arg_5_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_1.leftNameTxt_.transform)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1.leftNameTxt_.text)
				SetActive(arg_5_1.iconTrs_.gameObject, false)
				arg_5_1.callingController_:SetSelectedState("normal")

				local var_8_13 = arg_5_1:GetWordFromCfg(112292002)
				local var_8_14 = arg_5_1:FormatText(var_8_13.content)

				arg_5_1.text_.text = var_8_14

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_16 = 10 <= 0 and var_8_12 or var_8_12 * (utf8.len(var_8_14) / 10)

				if (10 <= 0 and var_8_12 or var_8_12 * (utf8.len(var_8_14) / 10)) > 0 and var_8_12 < var_8_16 then
					arg_5_1.talkMaxDuration = var_8_16

					if var_8_16 + var_8_11 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_16 + var_8_11
					end
				end

				arg_5_1.text_.text = var_8_14
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292002", "story_v_out_112292.awb") ~= 0 then
					local var_8_17 = manager.audio:GetVoiceLength("story_v_out_112292", "112292002", "story_v_out_112292.awb") / 1000

					if var_8_17 + var_8_11 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_17 + var_8_11
					end

					if var_8_13.prefab_name ~= "" and arg_5_1.actors_[var_8_13.prefab_name] ~= nil then
						local var_8_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_5_1.actors_[var_8_13.prefab_name].transform, "story_v_out_112292", "112292002", "story_v_out_112292.awb")

						arg_5_1:RecordAudio("112292002", var_8_18)
						arg_5_1:RecordAudio("112292002", var_8_18)
					else
						arg_5_1:AudioAction("play", "voice", "story_v_out_112292", "112292002", "story_v_out_112292.awb")
					end

					arg_5_1:RecordHistoryTalkVoice("story_v_out_112292", "112292002", "story_v_out_112292.awb")
				end

				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_19 = math.max(var_8_12, arg_5_1.talkMaxDuration)

			if var_8_11 <= arg_5_1.time_ and arg_5_1.time_ < var_8_11 + var_8_19 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - var_8_11) / var_8_19

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= var_8_11 + var_8_19 and arg_5_1.time_ < var_8_11 + var_8_19 + arg_8_0 then
				arg_5_1.typewritter.percent = 1

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(true)
			end
		end

		arg_5_1.nodeConfigList_ = {
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

		arg_5_1:InitPlayNodeList()
	end,
	Play112292003 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 112292003
		arg_9_1.duration_ = 3.17

		local var_9_0 = {
			ja = 3.166,
			ko = 2.966,
			zh = 2.633,
			en = 2.9
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
				arg_9_0:Play112292004(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.325

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(112292003)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 13 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 13)

				if (13 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 13)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292003", "story_v_out_112292.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_112292", "112292003", "story_v_out_112292.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_112292", "112292003", "story_v_out_112292.awb")

						arg_9_1:RecordAudio("112292003", var_12_6)
						arg_9_1:RecordAudio("112292003", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_112292", "112292003", "story_v_out_112292.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_112292", "112292003", "story_v_out_112292.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play112292004 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 112292004
		arg_13_1.duration_ = 5.7

		local var_13_0 = {
			ja = 5.433,
			ko = 5.066,
			zh = 5.7,
			en = 5.7
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
				arg_13_0:Play112292005(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1081_1 = arg_13_1.actors_["1081_1"].transform.localPosition
				arg_13_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_13_1.time_ - 0) / var_16_0)
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1081_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_16_1 = "1084"

			if arg_13_1.actors_["1084"] == nil then
				local var_16_2 = Object.Instantiate(arg_13_1.imageGo_, arg_13_1.canvasGo_.transform)

				var_16_2.transform:SetSiblingIndex(1)

				var_16_2.name = var_16_1

				local var_16_3 = var_16_2:GetComponent(typeof(Image))

				var_16_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1084")

				var_16_3:SetNativeSize()

				var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_13_1.actors_[var_16_1] = var_16_2
			end

			local var_16_4 = arg_13_1.actors_["1084"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1084 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_16_5 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 then
				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1084, Vector3.New(0, -500, 0), (arg_13_1.time_ - 0) / var_16_5)
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(0, -500, 0)
			end

			local var_16_6 = arg_13_1.actors_["1084"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_6) then
				local var_16_7 = var_16_6:GetComponent("Image")

				if var_16_7 then
					arg_13_1.var_.highlightMatValue1084 = var_16_7
				end
			end

			local var_16_8 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_6) then
				if arg_13_1.var_.highlightMatValue1084 then
					local var_16_9 = Mathf.Lerp(0.5, 1, (arg_13_1.time_ - 0) / var_16_8)

					arg_13_1.var_.highlightMatValue1084.color.r = var_16_9
					arg_13_1.var_.highlightMatValue1084.color.g = var_16_9
					arg_13_1.var_.highlightMatValue1084.color.b = var_16_9
					arg_13_1.var_.highlightMatValue1084.color = arg_13_1.var_.highlightMatValue1084.color
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.highlightMatValue1084 then
				var_16_6.transform:SetSiblingIndex(1)

				arg_13_1.var_.highlightMatValue1084.color.r = 1
				arg_13_1.var_.highlightMatValue1084.color.g = 1
				arg_13_1.var_.highlightMatValue1084.color.b = 1
				arg_13_1.var_.highlightMatValue1084.color = arg_13_1.var_.highlightMatValue1084.color
			end

			local var_16_10 = 0
			local var_16_11 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(112292004)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 18 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 18)

				if (18 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 18)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292004", "story_v_out_112292.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_112292", "112292004", "story_v_out_112292.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_112292", "112292004", "story_v_out_112292.awb")

						arg_13_1:RecordAudio("112292004", var_16_17)
						arg_13_1:RecordAudio("112292004", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_112292", "112292004", "story_v_out_112292.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_112292", "112292004", "story_v_out_112292.awb")
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
				actorName = "1081_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
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

		arg_13_1:InitPlayNodeList()
	end,
	Play112292005 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 112292005
		arg_17_1.duration_ = 4.8

		local var_17_0 = {
			ja = 4.133,
			ko = 3.766,
			zh = 4.333,
			en = 4.8
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
				arg_17_0:Play112292006(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1027"] == nil then
				local var_20_0 = Object.Instantiate(arg_17_1.imageGo_, arg_17_1.canvasGo_.transform)

				var_20_0.transform:SetSiblingIndex(1)

				var_20_0.name = "1027"

				local var_20_1 = var_20_0:GetComponent(typeof(Image))

				var_20_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1027")

				var_20_1:SetNativeSize()

				var_20_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_17_1.actors_["1027"] = var_20_0
			end

			local var_20_2 = arg_17_1.actors_["1027"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1027 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_20_3 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1027, Vector3.New(0, -500, 0), (arg_17_1.time_ - 0) / var_20_3)
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(0, -500, 0)
			end

			local var_20_4 = arg_17_1.actors_["1084"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084 = var_20_4.localPosition
				var_20_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_20_5 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 then
				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_5)
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_6 = arg_17_1.actors_["1027"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_6) then
				local var_20_7 = var_20_6:GetComponent("Image")

				if var_20_7 then
					arg_17_1.var_.highlightMatValue1027 = var_20_7
				end
			end

			local var_20_8 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_6) then
				if arg_17_1.var_.highlightMatValue1027 then
					local var_20_9 = Mathf.Lerp(0.5, 1, (arg_17_1.time_ - 0) / var_20_8)

					arg_17_1.var_.highlightMatValue1027.color.r = var_20_9
					arg_17_1.var_.highlightMatValue1027.color.g = var_20_9
					arg_17_1.var_.highlightMatValue1027.color.b = var_20_9
					arg_17_1.var_.highlightMatValue1027.color = arg_17_1.var_.highlightMatValue1027.color
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.highlightMatValue1027 then
				var_20_6.transform:SetSiblingIndex(1)

				arg_17_1.var_.highlightMatValue1027.color.r = 1
				arg_17_1.var_.highlightMatValue1027.color.g = 1
				arg_17_1.var_.highlightMatValue1027.color.b = 1
				arg_17_1.var_.highlightMatValue1027.color = arg_17_1.var_.highlightMatValue1027.color
			end

			local var_20_10 = 0
			local var_20_11 = 0.175

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(112292005)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 7 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 7)

				if (7 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 7)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292005", "story_v_out_112292.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_112292", "112292005", "story_v_out_112292.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_112292", "112292005", "story_v_out_112292.awb")

						arg_17_1:RecordAudio("112292005", var_20_17)
						arg_17_1:RecordAudio("112292005", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_112292", "112292005", "story_v_out_112292.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_112292", "112292005", "story_v_out_112292.awb")
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
				actorName = "1084",
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
	Play112292006 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 112292006
		arg_21_1.duration_ = 8.53

		local var_21_0 = {
			ja = 7.066,
			ko = 5.933,
			zh = 8.533,
			en = 6.766
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
				arg_21_0:Play112292007(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1148"] == nil then
				local var_24_0 = Object.Instantiate(arg_21_1.imageGo_, arg_21_1.canvasGo_.transform)

				var_24_0.transform:SetSiblingIndex(1)

				var_24_0.name = "1148"

				local var_24_1 = var_24_0:GetComponent(typeof(Image))

				var_24_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1148")

				var_24_1:SetNativeSize()

				var_24_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_21_1.actors_["1148"] = var_24_0
			end

			local var_24_2 = arg_21_1.actors_["1148"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_24_3 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148, Vector3.New(0, -550, 0), (arg_21_1.time_ - 0) / var_24_3)
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(0, -550, 0)
			end

			local var_24_4 = arg_21_1.actors_["1027"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1027 = var_24_4.localPosition
				var_24_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_24_5 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 then
				var_24_4.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1027, Vector3.New(0, -2000, 0), (arg_21_1.time_ - 0) / var_24_5)
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 then
				var_24_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_6 = arg_21_1.actors_["1148"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_6) then
				local var_24_7 = var_24_6:GetComponent("Image")

				if var_24_7 then
					arg_21_1.var_.highlightMatValue1148 = var_24_7
				end
			end

			local var_24_8 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_8 and not isNil(var_24_6) then
				if arg_21_1.var_.highlightMatValue1148 then
					local var_24_9 = Mathf.Lerp(0.5, 1, (arg_21_1.time_ - 0) / var_24_8)

					arg_21_1.var_.highlightMatValue1148.color.r = var_24_9
					arg_21_1.var_.highlightMatValue1148.color.g = var_24_9
					arg_21_1.var_.highlightMatValue1148.color.b = var_24_9
					arg_21_1.var_.highlightMatValue1148.color = arg_21_1.var_.highlightMatValue1148.color
				end
			end

			if arg_21_1.time_ >= 0 + var_24_8 and arg_21_1.time_ < 0 + var_24_8 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.highlightMatValue1148 then
				var_24_6.transform:SetSiblingIndex(1)

				arg_21_1.var_.highlightMatValue1148.color.r = 1
				arg_21_1.var_.highlightMatValue1148.color.g = 1
				arg_21_1.var_.highlightMatValue1148.color.b = 1
				arg_21_1.var_.highlightMatValue1148.color = arg_21_1.var_.highlightMatValue1148.color
			end

			local var_24_10 = 0
			local var_24_11 = 0.725

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
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

				local var_24_12 = arg_21_1:GetWordFromCfg(112292006)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 29 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 29)

				if (29 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 29)) > 0 and var_24_11 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292006", "story_v_out_112292.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_112292", "112292006", "story_v_out_112292.awb") / 1000

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end

					if var_24_12.prefab_name ~= "" and arg_21_1.actors_[var_24_12.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_12.prefab_name].transform, "story_v_out_112292", "112292006", "story_v_out_112292.awb")

						arg_21_1:RecordAudio("112292006", var_24_17)
						arg_21_1:RecordAudio("112292006", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_112292", "112292006", "story_v_out_112292.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_112292", "112292006", "story_v_out_112292.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_18 and arg_21_1.time_ < var_24_10 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "1027",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play112292007 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 112292007
		arg_25_1.duration_ = 5.8

		local var_25_0 = {
			ja = 3.433,
			ko = 5.133,
			zh = 3.7,
			en = 5.8
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
				arg_25_0:Play112292008(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1081_1 = arg_25_1.actors_["1081_1"].transform.localPosition
				arg_25_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_25_1.time_ - 0) / var_28_0)
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1081_1"].transform.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_28_1 = arg_25_1.actors_["1148"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148 = var_28_1.localPosition
				var_28_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_28_2 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 then
				var_28_1.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_25_1.time_ - 0) / var_28_2)
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 then
				var_28_1.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_3 = arg_25_1.actors_["1081"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) then
				local var_28_4 = var_28_3:GetComponent("Image")

				if var_28_4 then
					arg_25_1.var_.highlightMatValue1081 = var_28_4
				end
			end

			local var_28_5 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_3) then
				if arg_25_1.var_.highlightMatValue1081 then
					local var_28_6 = Mathf.Lerp(0.5, 1, (arg_25_1.time_ - 0) / var_28_5)

					arg_25_1.var_.highlightMatValue1081.color.r = var_28_6
					arg_25_1.var_.highlightMatValue1081.color.g = var_28_6
					arg_25_1.var_.highlightMatValue1081.color.b = var_28_6
					arg_25_1.var_.highlightMatValue1081.color = arg_25_1.var_.highlightMatValue1081.color
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.highlightMatValue1081 then
				var_28_3.transform:SetSiblingIndex(1)

				arg_25_1.var_.highlightMatValue1081.color.r = 1
				arg_25_1.var_.highlightMatValue1081.color.g = 1
				arg_25_1.var_.highlightMatValue1081.color.b = 1
				arg_25_1.var_.highlightMatValue1081.color = arg_25_1.var_.highlightMatValue1081.color
			end

			local var_28_7 = 0
			local var_28_8 = 0.45

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
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

				local var_28_9 = arg_25_1:GetWordFromCfg(112292007)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 18 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 18)

				if (18 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 18)) > 0 and var_28_8 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292007", "story_v_out_112292.awb") ~= 0 then
					local var_28_13 = manager.audio:GetVoiceLength("story_v_out_112292", "112292007", "story_v_out_112292.awb") / 1000

					if var_28_13 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_7
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_112292", "112292007", "story_v_out_112292.awb")

						arg_25_1:RecordAudio("112292007", var_28_14)
						arg_25_1:RecordAudio("112292007", var_28_14)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_112292", "112292007", "story_v_out_112292.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_112292", "112292007", "story_v_out_112292.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_15 and arg_25_1.time_ < var_28_7 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081_1",
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

		arg_25_1:InitPlayNodeList()
	end,
	Play112292008 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 112292008
		arg_29_1.duration_ = 5.07

		local var_29_0 = {
			ja = 5.066,
			ko = 3.6,
			zh = 3.3,
			en = 3.5
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
				arg_29_0:Play112292009(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1039"] == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.imageGo_, arg_29_1.canvasGo_.transform)

				var_32_0.transform:SetSiblingIndex(1)

				var_32_0.name = "1039"

				local var_32_1 = var_32_0:GetComponent(typeof(Image))

				var_32_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1039")

				var_32_1:SetNativeSize()

				var_32_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_29_1.actors_["1039"] = var_32_0
			end

			local var_32_2 = arg_29_1.actors_["1039"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1039 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_32_3 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1039, Vector3.New(0, -500, 0), (arg_29_1.time_ - 0) / var_32_3)
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(0, -500, 0)
			end

			local var_32_4 = arg_29_1.actors_["1081_1"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1081_1 = var_32_4.localPosition
				var_32_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_5)
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_6 = arg_29_1.actors_["1039"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_6) then
				local var_32_7 = var_32_6:GetComponent("Image")

				if var_32_7 then
					arg_29_1.var_.highlightMatValue1039 = var_32_7
				end
			end

			local var_32_8 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_8 and not isNil(var_32_6) then
				if arg_29_1.var_.highlightMatValue1039 then
					local var_32_9 = Mathf.Lerp(0.5, 1, (arg_29_1.time_ - 0) / var_32_8)

					arg_29_1.var_.highlightMatValue1039.color.r = var_32_9
					arg_29_1.var_.highlightMatValue1039.color.g = var_32_9
					arg_29_1.var_.highlightMatValue1039.color.b = var_32_9
					arg_29_1.var_.highlightMatValue1039.color = arg_29_1.var_.highlightMatValue1039.color
				end
			end

			if arg_29_1.time_ >= 0 + var_32_8 and arg_29_1.time_ < 0 + var_32_8 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.highlightMatValue1039 then
				var_32_6.transform:SetSiblingIndex(1)

				arg_29_1.var_.highlightMatValue1039.color.r = 1
				arg_29_1.var_.highlightMatValue1039.color.g = 1
				arg_29_1.var_.highlightMatValue1039.color.b = 1
				arg_29_1.var_.highlightMatValue1039.color = arg_29_1.var_.highlightMatValue1039.color
			end

			local var_32_10 = 0
			local var_32_11 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:GetWordFromCfg(112292008)
				local var_32_13 = arg_29_1:FormatText(var_32_12.content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 13 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 13)

				if (13 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 13)) > 0 and var_32_11 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292008", "story_v_out_112292.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_112292", "112292008", "story_v_out_112292.awb") / 1000

					if var_32_16 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_10
					end

					if var_32_12.prefab_name ~= "" and arg_29_1.actors_[var_32_12.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_12.prefab_name].transform, "story_v_out_112292", "112292008", "story_v_out_112292.awb")

						arg_29_1:RecordAudio("112292008", var_32_17)
						arg_29_1:RecordAudio("112292008", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_112292", "112292008", "story_v_out_112292.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_112292", "112292008", "story_v_out_112292.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_18 and arg_29_1.time_ < var_32_10 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039",
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

		arg_29_1:InitPlayNodeList()
	end,
	Play112292009 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 112292009
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play112292010(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1039 = arg_33_1.actors_["1039"].transform.localPosition
				arg_33_1.actors_["1039"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1039"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1039, Vector3.New(0, -2000, 0), (arg_33_1.time_ - 0) / var_36_0)
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1039"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_1 = 0
			local var_36_2 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(112292009).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 10 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 10)

				if (10 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 10)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play112292010 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 112292010
		arg_37_1.duration_ = 6.33

		local var_37_0 = {
			ja = 6.333,
			ko = 5.4,
			zh = 3.966,
			en = 5.466
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play112292011(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1081_1 = arg_37_1.actors_["1081_1"].transform.localPosition
				arg_37_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_37_1.time_ - 0) / var_40_0)
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1081_1"].transform.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_40_1 = arg_37_1.actors_["1081"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) then
				local var_40_2 = var_40_1:GetComponent("Image")

				if var_40_2 then
					arg_37_1.var_.highlightMatValue1081 = var_40_2
				end
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_1) then
				if arg_37_1.var_.highlightMatValue1081 then
					local var_40_4 = Mathf.Lerp(0.5, 1, (arg_37_1.time_ - 0) / var_40_3)

					arg_37_1.var_.highlightMatValue1081.color.r = var_40_4
					arg_37_1.var_.highlightMatValue1081.color.g = var_40_4
					arg_37_1.var_.highlightMatValue1081.color.b = var_40_4
					arg_37_1.var_.highlightMatValue1081.color = arg_37_1.var_.highlightMatValue1081.color
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.highlightMatValue1081 then
				var_40_1.transform:SetSiblingIndex(1)

				arg_37_1.var_.highlightMatValue1081.color.r = 1
				arg_37_1.var_.highlightMatValue1081.color.g = 1
				arg_37_1.var_.highlightMatValue1081.color.b = 1
				arg_37_1.var_.highlightMatValue1081.color = arg_37_1.var_.highlightMatValue1081.color
			end

			local var_40_5 = 0
			local var_40_6 = 0.55

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(112292010)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 22 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 22)

				if (22 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 22)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292010", "story_v_out_112292.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_112292", "112292010", "story_v_out_112292.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_112292", "112292010", "story_v_out_112292.awb")

						arg_37_1:RecordAudio("112292010", var_40_12)
						arg_37_1:RecordAudio("112292010", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_112292", "112292010", "story_v_out_112292.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_112292", "112292010", "story_v_out_112292.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play112292011 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 112292011
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play112292012(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1081_1 = arg_41_1.actors_["1081_1"].transform.localPosition
				arg_41_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_0)
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1081_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_1 = 0
			local var_44_2 = 1.075

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(112292011).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 43 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 43)

				if (43 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 43)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play112292012 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 112292012
		arg_45_1.duration_ = 6.97

		local var_45_0 = {
			ja = 3.6,
			ko = 6.033,
			zh = 6.966,
			en = 6.7
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play112292013(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.75

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(112292012)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 30 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 30)

				if (30 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 30)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292012", "story_v_out_112292.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_112292", "112292012", "story_v_out_112292.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_112292", "112292012", "story_v_out_112292.awb")

						arg_45_1:RecordAudio("112292012", var_48_6)
						arg_45_1:RecordAudio("112292012", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_112292", "112292012", "story_v_out_112292.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_112292", "112292012", "story_v_out_112292.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play112292013 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 112292013
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play112292014(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.275

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(112292013).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 51 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 51)

				if (51 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 51)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play112292014 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 112292014
		arg_53_1.duration_ = 8.93

		local var_53_0 = {
			ja = 8.933,
			ko = 7.9,
			zh = 5.833,
			en = 4.2
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play112292015(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(112292014)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)

				if (18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292014", "story_v_out_112292.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_112292", "112292014", "story_v_out_112292.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_112292", "112292014", "story_v_out_112292.awb")

						arg_53_1:RecordAudio("112292014", var_56_6)
						arg_53_1:RecordAudio("112292014", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_112292", "112292014", "story_v_out_112292.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_112292", "112292014", "story_v_out_112292.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play112292015 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 112292015
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play112292016(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.625

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(112292015).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 25 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 25)

				if (25 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 25)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play112292016 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 112292016
		arg_61_1.duration_ = 7.77

		local var_61_0 = {
			ja = 7.766,
			ko = 7.766,
			zh = 5.7,
			en = 7.433
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play112292017(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1081_1 = arg_61_1.actors_["1081_1"].transform.localPosition
				arg_61_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_61_1.time_ - 0) / var_64_0)
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1081_1"].transform.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_64_1 = arg_61_1.actors_["1081"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) then
				local var_64_2 = var_64_1:GetComponent("Image")

				if var_64_2 then
					arg_61_1.var_.highlightMatValue1081 = var_64_2
				end
			end

			local var_64_3 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_1) then
				if arg_61_1.var_.highlightMatValue1081 then
					local var_64_4 = Mathf.Lerp(0.5, 1, (arg_61_1.time_ - 0) / var_64_3)

					arg_61_1.var_.highlightMatValue1081.color.r = var_64_4
					arg_61_1.var_.highlightMatValue1081.color.g = var_64_4
					arg_61_1.var_.highlightMatValue1081.color.b = var_64_4
					arg_61_1.var_.highlightMatValue1081.color = arg_61_1.var_.highlightMatValue1081.color
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.highlightMatValue1081 then
				var_64_1.transform:SetSiblingIndex(1)

				arg_61_1.var_.highlightMatValue1081.color.r = 1
				arg_61_1.var_.highlightMatValue1081.color.g = 1
				arg_61_1.var_.highlightMatValue1081.color.b = 1
				arg_61_1.var_.highlightMatValue1081.color = arg_61_1.var_.highlightMatValue1081.color
			end

			local var_64_5 = 0
			local var_64_6 = 0.75

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(112292016)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 30 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 30)

				if (30 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 30)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292016", "story_v_out_112292.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_112292", "112292016", "story_v_out_112292.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_112292", "112292016", "story_v_out_112292.awb")

						arg_61_1:RecordAudio("112292016", var_64_12)
						arg_61_1:RecordAudio("112292016", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_112292", "112292016", "story_v_out_112292.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_112292", "112292016", "story_v_out_112292.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_13 and arg_61_1.time_ < var_64_5 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play112292017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 112292017
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play112292018(arg_65_1)
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
					local var_68_2 = Mathf.Lerp(1, 0.5, (arg_65_1.time_ - 0) / var_68_1)

					arg_65_1.var_.highlightMatValue1081.color.r = var_68_2
					arg_65_1.var_.highlightMatValue1081.color.g = var_68_2
					arg_65_1.var_.highlightMatValue1081.color.b = var_68_2
					arg_65_1.var_.highlightMatValue1081.color = arg_65_1.var_.highlightMatValue1081.color
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and not isNil(arg_65_1.actors_["1081"]) and arg_65_1.var_.highlightMatValue1081 then
				arg_65_1.var_.highlightMatValue1081.color.r = 0.5
				arg_65_1.var_.highlightMatValue1081.color.g = 0.5
				arg_65_1.var_.highlightMatValue1081.color.b = 0.5
				arg_65_1.var_.highlightMatValue1081.color = arg_65_1.var_.highlightMatValue1081.color
			end

			local var_68_3 = 0
			local var_68_4 = 0.85

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(112292017).content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 34 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 34)

				if (34 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 34)) > 0 and var_68_4 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_3
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_4, arg_65_1.talkMaxDuration)

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_3) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_3 + var_68_8 and arg_65_1.time_ < var_68_3 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play112292018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 112292018
		arg_69_1.duration_ = 7.27

		local var_69_0 = {
			ja = 6.233,
			ko = 5.333,
			zh = 7.266,
			en = 3.633
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play112292019(arg_69_1)
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
					local var_72_2 = Mathf.Lerp(0.5, 1, (arg_69_1.time_ - 0) / var_72_1)

					arg_69_1.var_.highlightMatValue1081.color.r = var_72_2
					arg_69_1.var_.highlightMatValue1081.color.g = var_72_2
					arg_69_1.var_.highlightMatValue1081.color.b = var_72_2
					arg_69_1.var_.highlightMatValue1081.color = arg_69_1.var_.highlightMatValue1081.color
				end
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 and not isNil(arg_69_1.actors_["1081"]) and arg_69_1.var_.highlightMatValue1081 then
				arg_69_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_69_1.var_.highlightMatValue1081.color.r = 1
				arg_69_1.var_.highlightMatValue1081.color.g = 1
				arg_69_1.var_.highlightMatValue1081.color.b = 1
				arg_69_1.var_.highlightMatValue1081.color = arg_69_1.var_.highlightMatValue1081.color
			end

			local var_72_3 = 0
			local var_72_4 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_5 = arg_69_1:GetWordFromCfg(112292018)
				local var_72_6 = arg_69_1:FormatText(var_72_5.content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_8 = 17 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_6) / 17)

				if (17 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_6) / 17)) > 0 and var_72_4 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112292", "112292018", "story_v_out_112292.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_112292", "112292018", "story_v_out_112292.awb") / 1000

					if var_72_9 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_3
					end

					if var_72_5.prefab_name ~= "" and arg_69_1.actors_[var_72_5.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_5.prefab_name].transform, "story_v_out_112292", "112292018", "story_v_out_112292.awb")

						arg_69_1:RecordAudio("112292018", var_72_10)
						arg_69_1:RecordAudio("112292018", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_112292", "112292018", "story_v_out_112292.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_112292", "112292018", "story_v_out_112292.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_3) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_3 + var_72_11 and arg_69_1.time_ < var_72_3 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play112292019 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 112292019
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
			arg_73_1.auto_ = false
		end

		function arg_73_1.playNext_(arg_75_0)
			arg_73_1.onStoryFinished_()
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1081_1 = arg_73_1.actors_["1081_1"].transform.localPosition
				arg_73_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_73_1.time_ - 0) / var_76_0)
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1081_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_1 = 0
			local var_76_2 = 1.025

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(112292019).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 41 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 41)

				if (41 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 41)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_112292.awb"
	}
}
