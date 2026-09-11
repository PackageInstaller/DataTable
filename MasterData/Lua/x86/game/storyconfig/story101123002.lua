return {
	Play112302001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112302001
		arg_1_1.duration_ = 7.33

		local var_1_0 = {
			ja = 7.333,
			ko = 5.633,
			zh = 6.633,
			en = 5.2
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112302002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["1084"] == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.imageGo_, arg_1_1.canvasGo_.transform)

				var_4_0.transform:SetSiblingIndex(1)

				var_4_0.name = "1084"

				local var_4_1 = var_4_0:GetComponent(typeof(Image))

				var_4_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1084")

				var_4_1:SetNativeSize()

				var_4_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_["1084"] = var_4_0
			end

			local var_4_2 = arg_1_1.actors_["1084"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084 = var_4_2.localPosition
				var_4_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_4_3 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_3 then
				var_4_2.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084, Vector3.New(-450, -450, 0), (arg_1_1.time_ - 0) / var_4_3)
			end

			if arg_1_1.time_ >= 0 + var_4_3 and arg_1_1.time_ < 0 + var_4_3 + arg_4_0 then
				var_4_2.localPosition = Vector3.New(-450, -450, 0)
			end

			local var_4_4 = arg_1_1.actors_["1084"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_4) then
				local var_4_5 = var_4_4:GetComponent("Image")

				if var_4_5 then
					arg_1_1.var_.highlightMatValue1084 = var_4_5
				end
			end

			local var_4_6 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 and not isNil(var_4_4) then
				if arg_1_1.var_.highlightMatValue1084 then
					local var_4_7 = Mathf.Lerp(0.5, 1, (arg_1_1.time_ - 0) / var_4_6)

					arg_1_1.var_.highlightMatValue1084.color.r = var_4_7
					arg_1_1.var_.highlightMatValue1084.color.g = var_4_7
					arg_1_1.var_.highlightMatValue1084.color.b = var_4_7
					arg_1_1.var_.highlightMatValue1084.color = arg_1_1.var_.highlightMatValue1084.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and not isNil(var_4_4) and arg_1_1.var_.highlightMatValue1084 then
				var_4_4.transform:SetSiblingIndex(1)

				arg_1_1.var_.highlightMatValue1084.color.r = 1
				arg_1_1.var_.highlightMatValue1084.color.g = 1
				arg_1_1.var_.highlightMatValue1084.color.b = 1
				arg_1_1.var_.highlightMatValue1084.color = arg_1_1.var_.highlightMatValue1084.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_8 = arg_1_1.actors_["1084"]:GetComponent("Image")

				if var_4_8 then
					arg_1_1.var_.alphaMatValue1084 = var_4_8
					arg_1_1.var_.alphaOldValue1084 = var_4_8.color.a
				end

				arg_1_1.var_.alphaOldValue1084 = 0
			end

			local var_4_9 = 0.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_9 then
				if arg_1_1.var_.alphaMatValue1084 then
					arg_1_1.var_.alphaMatValue1084.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValue1084, 1, (arg_1_1.time_ - 0) / var_4_9)
					arg_1_1.var_.alphaMatValue1084.color = arg_1_1.var_.alphaMatValue1084.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_9 and arg_1_1.time_ < 0 + var_4_9 + arg_4_0 and arg_1_1.var_.alphaMatValue1084 then
				arg_1_1.var_.alphaMatValue1084.color.a = 1
				arg_1_1.var_.alphaMatValue1084.color = arg_1_1.var_.alphaMatValue1084.color
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 0.5
			local var_4_11 = 0.55

			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_13 = arg_1_1:GetWordFromCfg(112302001)
				local var_4_14 = arg_1_1:FormatText(var_4_13.content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 22 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 22)

				if (22 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 22)) > 0 and var_4_11 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_10 = var_4_10 + 0.3

					if var_4_16 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302001", "story_v_out_112302.awb") ~= 0 then
					local var_4_17 = manager.audio:GetVoiceLength("story_v_out_112302", "112302001", "story_v_out_112302.awb") / 1000

					if var_4_17 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_10
					end

					if var_4_13.prefab_name ~= "" and arg_1_1.actors_[var_4_13.prefab_name] ~= nil then
						local var_4_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_13.prefab_name].transform, "story_v_out_112302", "112302001", "story_v_out_112302.awb")

						arg_1_1:RecordAudio("112302001", var_4_18)
						arg_1_1:RecordAudio("112302001", var_4_18)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_112302", "112302001", "story_v_out_112302.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_112302", "112302001", "story_v_out_112302.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_10 + 0.3
			local var_4_20 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
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

		arg_1_1:InitPlayNodeList()
	end,
	Play112302002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112302002
		arg_7_1.duration_ = 9.9

		local var_7_0 = {
			ja = 9.9,
			ko = 7.233,
			zh = 5.566,
			en = 7.3
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play112302003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1148"] == nil then
				local var_10_0 = Object.Instantiate(arg_7_1.imageGo_, arg_7_1.canvasGo_.transform)

				var_10_0.transform:SetSiblingIndex(1)

				var_10_0.name = "1148"

				local var_10_1 = var_10_0:GetComponent(typeof(Image))

				var_10_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1148")

				var_10_1:SetNativeSize()

				var_10_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_7_1.actors_["1148"] = var_10_0
			end

			local var_10_2 = arg_7_1.actors_["1148"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1148 = var_10_2.localPosition
				var_10_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_10_3 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_3 then
				var_10_2.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1148, Vector3.New(450, -560, 180), (arg_7_1.time_ - 0) / var_10_3)
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 then
				var_10_2.localPosition = Vector3.New(450, -560, 180)
			end

			local var_10_4 = arg_7_1.actors_["1084"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1084 = var_10_4.localPosition
				var_10_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_10_5 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_5 then
				var_10_4.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1084, Vector3.New(-450, -450, 0), (arg_7_1.time_ - 0) / var_10_5)
			end

			if arg_7_1.time_ >= 0 + var_10_5 and arg_7_1.time_ < 0 + var_10_5 + arg_10_0 then
				var_10_4.localPosition = Vector3.New(-450, -450, 0)
			end

			local var_10_6 = arg_7_1.actors_["1084"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_6) then
				local var_10_7 = var_10_6:GetComponent("Image")

				if var_10_7 then
					arg_7_1.var_.highlightMatValue1084 = var_10_7
				end
			end

			local var_10_8 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_8 and not isNil(var_10_6) then
				if arg_7_1.var_.highlightMatValue1084 then
					local var_10_9 = Mathf.Lerp(1, 0.5, (arg_7_1.time_ - 0) / var_10_8)

					arg_7_1.var_.highlightMatValue1084.color.r = var_10_9
					arg_7_1.var_.highlightMatValue1084.color.g = var_10_9
					arg_7_1.var_.highlightMatValue1084.color.b = var_10_9
					arg_7_1.var_.highlightMatValue1084.color = arg_7_1.var_.highlightMatValue1084.color
				end
			end

			if arg_7_1.time_ >= 0 + var_10_8 and arg_7_1.time_ < 0 + var_10_8 + arg_10_0 and not isNil(var_10_6) and arg_7_1.var_.highlightMatValue1084 then
				arg_7_1.var_.highlightMatValue1084.color.r = 0.5
				arg_7_1.var_.highlightMatValue1084.color.g = 0.5
				arg_7_1.var_.highlightMatValue1084.color.b = 0.5
				arg_7_1.var_.highlightMatValue1084.color = arg_7_1.var_.highlightMatValue1084.color
			end

			local var_10_10 = arg_7_1.actors_["1148"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_10) then
				local var_10_11 = var_10_10:GetComponent("Image")

				if var_10_11 then
					arg_7_1.var_.highlightMatValue1148 = var_10_11
				end
			end

			local var_10_12 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_12 and not isNil(var_10_10) then
				if arg_7_1.var_.highlightMatValue1148 then
					local var_10_13 = Mathf.Lerp(0.5, 1, (arg_7_1.time_ - 0) / var_10_12)

					arg_7_1.var_.highlightMatValue1148.color.r = var_10_13
					arg_7_1.var_.highlightMatValue1148.color.g = var_10_13
					arg_7_1.var_.highlightMatValue1148.color.b = var_10_13
					arg_7_1.var_.highlightMatValue1148.color = arg_7_1.var_.highlightMatValue1148.color
				end
			end

			if arg_7_1.time_ >= 0 + var_10_12 and arg_7_1.time_ < 0 + var_10_12 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.highlightMatValue1148 then
				var_10_10.transform:SetSiblingIndex(1)

				arg_7_1.var_.highlightMatValue1148.color.r = 1
				arg_7_1.var_.highlightMatValue1148.color.g = 1
				arg_7_1.var_.highlightMatValue1148.color.b = 1
				arg_7_1.var_.highlightMatValue1148.color = arg_7_1.var_.highlightMatValue1148.color
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_14 = arg_7_1.actors_["1148"]:GetComponent("Image")

				if var_10_14 then
					arg_7_1.var_.alphaMatValue1148 = var_10_14
					arg_7_1.var_.alphaOldValue1148 = var_10_14.color.a
				end

				arg_7_1.var_.alphaOldValue1148 = 0
			end

			local var_10_15 = 0.5

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_15 then
				if arg_7_1.var_.alphaMatValue1148 then
					arg_7_1.var_.alphaMatValue1148.color.a = Mathf.Lerp(arg_7_1.var_.alphaOldValue1148, 1, (arg_7_1.time_ - 0) / var_10_15)
					arg_7_1.var_.alphaMatValue1148.color = arg_7_1.var_.alphaMatValue1148.color
				end
			end

			if arg_7_1.time_ >= 0 + var_10_15 and arg_7_1.time_ < 0 + var_10_15 + arg_10_0 and arg_7_1.var_.alphaMatValue1148 then
				arg_7_1.var_.alphaMatValue1148.color.a = 1
				arg_7_1.var_.alphaMatValue1148.color = arg_7_1.var_.alphaMatValue1148.color
			end

			local var_10_16 = 0.5
			local var_10_17 = 0.7

			if 0.5 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_18 = arg_7_1:GetWordFromCfg(112302002)
				local var_10_19 = arg_7_1:FormatText(var_10_18.content)

				arg_7_1.text_.text = var_10_19

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_21 = 28 <= 0 and var_10_17 or var_10_17 * (utf8.len(var_10_19) / 28)

				if (28 <= 0 and var_10_17 or var_10_17 * (utf8.len(var_10_19) / 28)) > 0 and var_10_17 < var_10_21 then
					arg_7_1.talkMaxDuration = var_10_21

					if var_10_21 + var_10_16 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_21 + var_10_16
					end
				end

				arg_7_1.text_.text = var_10_19
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302002", "story_v_out_112302.awb") ~= 0 then
					local var_10_22 = manager.audio:GetVoiceLength("story_v_out_112302", "112302002", "story_v_out_112302.awb") / 1000

					if var_10_22 + var_10_16 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_22 + var_10_16
					end

					if var_10_18.prefab_name ~= "" and arg_7_1.actors_[var_10_18.prefab_name] ~= nil then
						local var_10_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_18.prefab_name].transform, "story_v_out_112302", "112302002", "story_v_out_112302.awb")

						arg_7_1:RecordAudio("112302002", var_10_23)
						arg_7_1:RecordAudio("112302002", var_10_23)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112302", "112302002", "story_v_out_112302.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112302", "112302002", "story_v_out_112302.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_24 = math.max(var_10_17, arg_7_1.talkMaxDuration)

			if var_10_16 <= arg_7_1.time_ and arg_7_1.time_ < var_10_16 + var_10_24 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_16) / var_10_24

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_16 + var_10_24 and arg_7_1.time_ < var_10_16 + var_10_24 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
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
				actorName = "1084",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play112302003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112302003
		arg_11_1.duration_ = 12.87

		local var_11_0 = {
			ja = 12.866,
			ko = 10.366,
			zh = 11.2,
			en = 9.8
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play112302004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["1084"]) then
				local var_14_0 = arg_11_1.actors_["1084"]:GetComponent("Image")

				if var_14_0 then
					arg_11_1.var_.highlightMatValue1084 = var_14_0
				end
			end

			local var_14_1 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_1 and not isNil(arg_11_1.actors_["1084"]) then
				if arg_11_1.var_.highlightMatValue1084 then
					local var_14_2 = Mathf.Lerp(0.5, 1, (arg_11_1.time_ - 0) / var_14_1)

					arg_11_1.var_.highlightMatValue1084.color.r = var_14_2
					arg_11_1.var_.highlightMatValue1084.color.g = var_14_2
					arg_11_1.var_.highlightMatValue1084.color.b = var_14_2
					arg_11_1.var_.highlightMatValue1084.color = arg_11_1.var_.highlightMatValue1084.color
				end
			end

			if arg_11_1.time_ >= 0 + var_14_1 and arg_11_1.time_ < 0 + var_14_1 + arg_14_0 and not isNil(arg_11_1.actors_["1084"]) and arg_11_1.var_.highlightMatValue1084 then
				arg_11_1.actors_["1084"].transform:SetSiblingIndex(1)

				arg_11_1.var_.highlightMatValue1084.color.r = 1
				arg_11_1.var_.highlightMatValue1084.color.g = 1
				arg_11_1.var_.highlightMatValue1084.color.b = 1
				arg_11_1.var_.highlightMatValue1084.color = arg_11_1.var_.highlightMatValue1084.color
			end

			local var_14_3 = arg_11_1.actors_["1148"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_3) then
				local var_14_4 = var_14_3:GetComponent("Image")

				if var_14_4 then
					arg_11_1.var_.highlightMatValue1148 = var_14_4
				end
			end

			local var_14_5 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_5 and not isNil(var_14_3) then
				if arg_11_1.var_.highlightMatValue1148 then
					local var_14_6 = Mathf.Lerp(1, 0.5, (arg_11_1.time_ - 0) / var_14_5)

					arg_11_1.var_.highlightMatValue1148.color.r = var_14_6
					arg_11_1.var_.highlightMatValue1148.color.g = var_14_6
					arg_11_1.var_.highlightMatValue1148.color.b = var_14_6
					arg_11_1.var_.highlightMatValue1148.color = arg_11_1.var_.highlightMatValue1148.color
				end
			end

			if arg_11_1.time_ >= 0 + var_14_5 and arg_11_1.time_ < 0 + var_14_5 + arg_14_0 and not isNil(var_14_3) and arg_11_1.var_.highlightMatValue1148 then
				arg_11_1.var_.highlightMatValue1148.color.r = 0.5
				arg_11_1.var_.highlightMatValue1148.color.g = 0.5
				arg_11_1.var_.highlightMatValue1148.color.b = 0.5
				arg_11_1.var_.highlightMatValue1148.color = arg_11_1.var_.highlightMatValue1148.color
			end

			local var_14_7 = 0
			local var_14_8 = 1.125

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_7 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_9 = arg_11_1:GetWordFromCfg(112302003)
				local var_14_10 = arg_11_1:FormatText(var_14_9.content)

				arg_11_1.text_.text = var_14_10

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_12 = 45 <= 0 and var_14_8 or var_14_8 * (utf8.len(var_14_10) / 45)

				if (45 <= 0 and var_14_8 or var_14_8 * (utf8.len(var_14_10) / 45)) > 0 and var_14_8 < var_14_12 then
					arg_11_1.talkMaxDuration = var_14_12

					if var_14_12 + var_14_7 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_12 + var_14_7
					end
				end

				arg_11_1.text_.text = var_14_10
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302003", "story_v_out_112302.awb") ~= 0 then
					local var_14_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302003", "story_v_out_112302.awb") / 1000

					if var_14_13 + var_14_7 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_13 + var_14_7
					end

					if var_14_9.prefab_name ~= "" and arg_11_1.actors_[var_14_9.prefab_name] ~= nil then
						local var_14_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_9.prefab_name].transform, "story_v_out_112302", "112302003", "story_v_out_112302.awb")

						arg_11_1:RecordAudio("112302003", var_14_14)
						arg_11_1:RecordAudio("112302003", var_14_14)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_112302", "112302003", "story_v_out_112302.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_112302", "112302003", "story_v_out_112302.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_15 = math.max(var_14_8, arg_11_1.talkMaxDuration)

			if var_14_7 <= arg_11_1.time_ and arg_11_1.time_ < var_14_7 + var_14_15 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_7) / var_14_15

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_7 + var_14_15 and arg_11_1.time_ < var_14_7 + var_14_15 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play112302004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 112302004
		arg_15_1.duration_ = 8.4

		local var_15_0 = {
			ja = 8.4,
			ko = 7.933,
			zh = 7.166,
			en = 8.1
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play112302005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.825

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:GetWordFromCfg(112302004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 33 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 33)

				if (33 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 33)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302004", "story_v_out_112302.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_112302", "112302004", "story_v_out_112302.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_112302", "112302004", "story_v_out_112302.awb")

						arg_15_1:RecordAudio("112302004", var_18_6)
						arg_15_1:RecordAudio("112302004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_112302", "112302004", "story_v_out_112302.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_112302", "112302004", "story_v_out_112302.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play112302005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112302005
		arg_19_1.duration_ = 8.63

		local var_19_0 = {
			ja = 8.633,
			ko = 7.4,
			zh = 4.7,
			en = 6.233
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play112302006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1084"]) then
				local var_22_0 = arg_19_1.actors_["1084"]:GetComponent("Image")

				if var_22_0 then
					arg_19_1.var_.highlightMatValue1084 = var_22_0
				end
			end

			local var_22_1 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 and not isNil(arg_19_1.actors_["1084"]) then
				if arg_19_1.var_.highlightMatValue1084 then
					local var_22_2 = Mathf.Lerp(1, 0.5, (arg_19_1.time_ - 0) / var_22_1)

					arg_19_1.var_.highlightMatValue1084.color.r = var_22_2
					arg_19_1.var_.highlightMatValue1084.color.g = var_22_2
					arg_19_1.var_.highlightMatValue1084.color.b = var_22_2
					arg_19_1.var_.highlightMatValue1084.color = arg_19_1.var_.highlightMatValue1084.color
				end
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 and not isNil(arg_19_1.actors_["1084"]) and arg_19_1.var_.highlightMatValue1084 then
				arg_19_1.var_.highlightMatValue1084.color.r = 0.5
				arg_19_1.var_.highlightMatValue1084.color.g = 0.5
				arg_19_1.var_.highlightMatValue1084.color.b = 0.5
				arg_19_1.var_.highlightMatValue1084.color = arg_19_1.var_.highlightMatValue1084.color
			end

			local var_22_3 = arg_19_1.actors_["1148"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_3) then
				local var_22_4 = var_22_3:GetComponent("Image")

				if var_22_4 then
					arg_19_1.var_.highlightMatValue1148 = var_22_4
				end
			end

			local var_22_5 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_5 and not isNil(var_22_3) then
				if arg_19_1.var_.highlightMatValue1148 then
					local var_22_6 = Mathf.Lerp(0.5, 1, (arg_19_1.time_ - 0) / var_22_5)

					arg_19_1.var_.highlightMatValue1148.color.r = var_22_6
					arg_19_1.var_.highlightMatValue1148.color.g = var_22_6
					arg_19_1.var_.highlightMatValue1148.color.b = var_22_6
					arg_19_1.var_.highlightMatValue1148.color = arg_19_1.var_.highlightMatValue1148.color
				end
			end

			if arg_19_1.time_ >= 0 + var_22_5 and arg_19_1.time_ < 0 + var_22_5 + arg_22_0 and not isNil(var_22_3) and arg_19_1.var_.highlightMatValue1148 then
				var_22_3.transform:SetSiblingIndex(1)

				arg_19_1.var_.highlightMatValue1148.color.r = 1
				arg_19_1.var_.highlightMatValue1148.color.g = 1
				arg_19_1.var_.highlightMatValue1148.color.b = 1
				arg_19_1.var_.highlightMatValue1148.color = arg_19_1.var_.highlightMatValue1148.color
			end

			local var_22_7 = 0
			local var_22_8 = 0.575

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_7 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_9 = arg_19_1:GetWordFromCfg(112302005)
				local var_22_10 = arg_19_1:FormatText(var_22_9.content)

				arg_19_1.text_.text = var_22_10

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_12 = 23 <= 0 and var_22_8 or var_22_8 * (utf8.len(var_22_10) / 23)

				if (23 <= 0 and var_22_8 or var_22_8 * (utf8.len(var_22_10) / 23)) > 0 and var_22_8 < var_22_12 then
					arg_19_1.talkMaxDuration = var_22_12

					if var_22_12 + var_22_7 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_12 + var_22_7
					end
				end

				arg_19_1.text_.text = var_22_10
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302005", "story_v_out_112302.awb") ~= 0 then
					local var_22_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302005", "story_v_out_112302.awb") / 1000

					if var_22_13 + var_22_7 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_7
					end

					if var_22_9.prefab_name ~= "" and arg_19_1.actors_[var_22_9.prefab_name] ~= nil then
						local var_22_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_9.prefab_name].transform, "story_v_out_112302", "112302005", "story_v_out_112302.awb")

						arg_19_1:RecordAudio("112302005", var_22_14)
						arg_19_1:RecordAudio("112302005", var_22_14)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_112302", "112302005", "story_v_out_112302.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_112302", "112302005", "story_v_out_112302.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_15 = math.max(var_22_8, arg_19_1.talkMaxDuration)

			if var_22_7 <= arg_19_1.time_ and arg_19_1.time_ < var_22_7 + var_22_15 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_7) / var_22_15

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_7 + var_22_15 and arg_19_1.time_ < var_22_7 + var_22_15 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play112302006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112302006
		arg_23_1.duration_ = 12.83

		local var_23_0 = {
			ja = 10.066,
			ko = 12.833,
			zh = 8.466,
			en = 11.9
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play112302007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.15

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:GetWordFromCfg(112302006)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 46 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 46)

				if (46 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 46)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302006", "story_v_out_112302.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_112302", "112302006", "story_v_out_112302.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_112302", "112302006", "story_v_out_112302.awb")

						arg_23_1:RecordAudio("112302006", var_26_6)
						arg_23_1:RecordAudio("112302006", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_112302", "112302006", "story_v_out_112302.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_112302", "112302006", "story_v_out_112302.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play112302007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112302007
		arg_27_1.duration_ = 4.17

		local var_27_0 = {
			ja = 2.999999999999,
			ko = 4.166,
			zh = 3,
			en = 2.999999999999
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play112302008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1084"]) then
				local var_30_0 = arg_27_1.actors_["1084"]:GetComponent("Image")

				if var_30_0 then
					arg_27_1.var_.highlightMatValue1084 = var_30_0
				end
			end

			local var_30_1 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 and not isNil(arg_27_1.actors_["1084"]) then
				if arg_27_1.var_.highlightMatValue1084 then
					local var_30_2 = Mathf.Lerp(0.5, 1, (arg_27_1.time_ - 0) / var_30_1)

					arg_27_1.var_.highlightMatValue1084.color.r = var_30_2
					arg_27_1.var_.highlightMatValue1084.color.g = var_30_2
					arg_27_1.var_.highlightMatValue1084.color.b = var_30_2
					arg_27_1.var_.highlightMatValue1084.color = arg_27_1.var_.highlightMatValue1084.color
				end
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 and not isNil(arg_27_1.actors_["1084"]) and arg_27_1.var_.highlightMatValue1084 then
				arg_27_1.actors_["1084"].transform:SetSiblingIndex(1)

				arg_27_1.var_.highlightMatValue1084.color.r = 1
				arg_27_1.var_.highlightMatValue1084.color.g = 1
				arg_27_1.var_.highlightMatValue1084.color.b = 1
				arg_27_1.var_.highlightMatValue1084.color = arg_27_1.var_.highlightMatValue1084.color
			end

			local var_30_3 = arg_27_1.actors_["1148"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_3) then
				local var_30_4 = var_30_3:GetComponent("Image")

				if var_30_4 then
					arg_27_1.var_.highlightMatValue1148 = var_30_4
				end
			end

			local var_30_5 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 and not isNil(var_30_3) then
				if arg_27_1.var_.highlightMatValue1148 then
					local var_30_6 = Mathf.Lerp(1, 0.5, (arg_27_1.time_ - 0) / var_30_5)

					arg_27_1.var_.highlightMatValue1148.color.r = var_30_6
					arg_27_1.var_.highlightMatValue1148.color.g = var_30_6
					arg_27_1.var_.highlightMatValue1148.color.b = var_30_6
					arg_27_1.var_.highlightMatValue1148.color = arg_27_1.var_.highlightMatValue1148.color
				end
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 and not isNil(var_30_3) and arg_27_1.var_.highlightMatValue1148 then
				arg_27_1.var_.highlightMatValue1148.color.r = 0.5
				arg_27_1.var_.highlightMatValue1148.color.g = 0.5
				arg_27_1.var_.highlightMatValue1148.color.b = 0.5
				arg_27_1.var_.highlightMatValue1148.color = arg_27_1.var_.highlightMatValue1148.color
			end

			local var_30_7 = 0
			local var_30_8 = 0.275

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_9 = arg_27_1:GetWordFromCfg(112302007)
				local var_30_10 = arg_27_1:FormatText(var_30_9.content)

				arg_27_1.text_.text = var_30_10

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_12 = 11 <= 0 and var_30_8 or var_30_8 * (utf8.len(var_30_10) / 11)

				if (11 <= 0 and var_30_8 or var_30_8 * (utf8.len(var_30_10) / 11)) > 0 and var_30_8 < var_30_12 then
					arg_27_1.talkMaxDuration = var_30_12

					if var_30_12 + var_30_7 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_7
					end
				end

				arg_27_1.text_.text = var_30_10
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302007", "story_v_out_112302.awb") ~= 0 then
					local var_30_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302007", "story_v_out_112302.awb") / 1000

					if var_30_13 + var_30_7 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_7
					end

					if var_30_9.prefab_name ~= "" and arg_27_1.actors_[var_30_9.prefab_name] ~= nil then
						local var_30_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_9.prefab_name].transform, "story_v_out_112302", "112302007", "story_v_out_112302.awb")

						arg_27_1:RecordAudio("112302007", var_30_14)
						arg_27_1:RecordAudio("112302007", var_30_14)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_112302", "112302007", "story_v_out_112302.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_112302", "112302007", "story_v_out_112302.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_15 = math.max(var_30_8, arg_27_1.talkMaxDuration)

			if var_30_7 <= arg_27_1.time_ and arg_27_1.time_ < var_30_7 + var_30_15 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_7) / var_30_15

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_7 + var_30_15 and arg_27_1.time_ < var_30_7 + var_30_15 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play112302008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 112302008
		arg_31_1.duration_ = 3.2

		local var_31_0 = {
			ja = 2.999999999999,
			ko = 2.999999999999,
			zh = 3.2,
			en = 2.999999999999
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play112302009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1084"]) then
				local var_34_0 = arg_31_1.actors_["1084"]:GetComponent("Image")

				if var_34_0 then
					arg_31_1.var_.highlightMatValue1084 = var_34_0
				end
			end

			local var_34_1 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 and not isNil(arg_31_1.actors_["1084"]) then
				if arg_31_1.var_.highlightMatValue1084 then
					local var_34_2 = Mathf.Lerp(1, 0.5, (arg_31_1.time_ - 0) / var_34_1)

					arg_31_1.var_.highlightMatValue1084.color.r = var_34_2
					arg_31_1.var_.highlightMatValue1084.color.g = var_34_2
					arg_31_1.var_.highlightMatValue1084.color.b = var_34_2
					arg_31_1.var_.highlightMatValue1084.color = arg_31_1.var_.highlightMatValue1084.color
				end
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 and not isNil(arg_31_1.actors_["1084"]) and arg_31_1.var_.highlightMatValue1084 then
				arg_31_1.var_.highlightMatValue1084.color.r = 0.5
				arg_31_1.var_.highlightMatValue1084.color.g = 0.5
				arg_31_1.var_.highlightMatValue1084.color.b = 0.5
				arg_31_1.var_.highlightMatValue1084.color = arg_31_1.var_.highlightMatValue1084.color
			end

			local var_34_3 = arg_31_1.actors_["1148"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_3) then
				local var_34_4 = var_34_3:GetComponent("Image")

				if var_34_4 then
					arg_31_1.var_.highlightMatValue1148 = var_34_4
				end
			end

			local var_34_5 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 and not isNil(var_34_3) then
				if arg_31_1.var_.highlightMatValue1148 then
					local var_34_6 = Mathf.Lerp(0.5, 1, (arg_31_1.time_ - 0) / var_34_5)

					arg_31_1.var_.highlightMatValue1148.color.r = var_34_6
					arg_31_1.var_.highlightMatValue1148.color.g = var_34_6
					arg_31_1.var_.highlightMatValue1148.color.b = var_34_6
					arg_31_1.var_.highlightMatValue1148.color = arg_31_1.var_.highlightMatValue1148.color
				end
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.highlightMatValue1148 then
				var_34_3.transform:SetSiblingIndex(1)

				arg_31_1.var_.highlightMatValue1148.color.r = 1
				arg_31_1.var_.highlightMatValue1148.color.g = 1
				arg_31_1.var_.highlightMatValue1148.color.b = 1
				arg_31_1.var_.highlightMatValue1148.color = arg_31_1.var_.highlightMatValue1148.color
			end

			local var_34_7 = 0
			local var_34_8 = 0.15

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_7 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_9 = arg_31_1:GetWordFromCfg(112302008)
				local var_34_10 = arg_31_1:FormatText(var_34_9.content)

				arg_31_1.text_.text = var_34_10

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_12 = 6 <= 0 and var_34_8 or var_34_8 * (utf8.len(var_34_10) / 6)

				if (6 <= 0 and var_34_8 or var_34_8 * (utf8.len(var_34_10) / 6)) > 0 and var_34_8 < var_34_12 then
					arg_31_1.talkMaxDuration = var_34_12

					if var_34_12 + var_34_7 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_7
					end
				end

				arg_31_1.text_.text = var_34_10
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302008", "story_v_out_112302.awb") ~= 0 then
					local var_34_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302008", "story_v_out_112302.awb") / 1000

					if var_34_13 + var_34_7 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_7
					end

					if var_34_9.prefab_name ~= "" and arg_31_1.actors_[var_34_9.prefab_name] ~= nil then
						local var_34_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_9.prefab_name].transform, "story_v_out_112302", "112302008", "story_v_out_112302.awb")

						arg_31_1:RecordAudio("112302008", var_34_14)
						arg_31_1:RecordAudio("112302008", var_34_14)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112302", "112302008", "story_v_out_112302.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112302", "112302008", "story_v_out_112302.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_15 = math.max(var_34_8, arg_31_1.talkMaxDuration)

			if var_34_7 <= arg_31_1.time_ and arg_31_1.time_ < var_34_7 + var_34_15 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_7) / var_34_15

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_7 + var_34_15 and arg_31_1.time_ < var_34_7 + var_34_15 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play112302009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 112302009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play112302010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1148"]) then
				local var_38_0 = arg_35_1.actors_["1148"]:GetComponent("Image")

				if var_38_0 then
					arg_35_1.var_.highlightMatValue1148 = var_38_0
				end
			end

			local var_38_1 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 and not isNil(arg_35_1.actors_["1148"]) then
				if arg_35_1.var_.highlightMatValue1148 then
					local var_38_2 = Mathf.Lerp(1, 0.5, (arg_35_1.time_ - 0) / var_38_1)

					arg_35_1.var_.highlightMatValue1148.color.r = var_38_2
					arg_35_1.var_.highlightMatValue1148.color.g = var_38_2
					arg_35_1.var_.highlightMatValue1148.color.b = var_38_2
					arg_35_1.var_.highlightMatValue1148.color = arg_35_1.var_.highlightMatValue1148.color
				end
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 and not isNil(arg_35_1.actors_["1148"]) and arg_35_1.var_.highlightMatValue1148 then
				arg_35_1.var_.highlightMatValue1148.color.r = 0.5
				arg_35_1.var_.highlightMatValue1148.color.g = 0.5
				arg_35_1.var_.highlightMatValue1148.color.b = 0.5
				arg_35_1.var_.highlightMatValue1148.color = arg_35_1.var_.highlightMatValue1148.color
			end

			local var_38_3 = 0
			local var_38_4 = 1.125

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(112302009).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 45 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 45)

				if (45 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 45)) > 0 and var_38_4 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_3 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_3
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_4, arg_35_1.talkMaxDuration)

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_3) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_3 + var_38_8 and arg_35_1.time_ < var_38_3 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play112302010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 112302010
		arg_39_1.duration_ = 8.93

		local var_39_0 = {
			ja = 8.666,
			ko = 8.933,
			zh = 6.933,
			en = 7.866
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play112302011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1148"]) then
				local var_42_0 = arg_39_1.actors_["1148"]:GetComponent("Image")

				if var_42_0 then
					arg_39_1.var_.highlightMatValue1148 = var_42_0
				end
			end

			local var_42_1 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 and not isNil(arg_39_1.actors_["1148"]) then
				if arg_39_1.var_.highlightMatValue1148 then
					local var_42_2 = Mathf.Lerp(0.5, 1, (arg_39_1.time_ - 0) / var_42_1)

					arg_39_1.var_.highlightMatValue1148.color.r = var_42_2
					arg_39_1.var_.highlightMatValue1148.color.g = var_42_2
					arg_39_1.var_.highlightMatValue1148.color.b = var_42_2
					arg_39_1.var_.highlightMatValue1148.color = arg_39_1.var_.highlightMatValue1148.color
				end
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 and not isNil(arg_39_1.actors_["1148"]) and arg_39_1.var_.highlightMatValue1148 then
				arg_39_1.actors_["1148"].transform:SetSiblingIndex(1)

				arg_39_1.var_.highlightMatValue1148.color.r = 1
				arg_39_1.var_.highlightMatValue1148.color.g = 1
				arg_39_1.var_.highlightMatValue1148.color.b = 1
				arg_39_1.var_.highlightMatValue1148.color = arg_39_1.var_.highlightMatValue1148.color
			end

			local var_42_3 = 0
			local var_42_4 = 0.8

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:GetWordFromCfg(112302010)
				local var_42_6 = arg_39_1:FormatText(var_42_5.content)

				arg_39_1.text_.text = var_42_6

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_8 = 32 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 32)

				if (32 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 32)) > 0 and var_42_4 < var_42_8 then
					arg_39_1.talkMaxDuration = var_42_8

					if var_42_8 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_6
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302010", "story_v_out_112302.awb") ~= 0 then
					local var_42_9 = manager.audio:GetVoiceLength("story_v_out_112302", "112302010", "story_v_out_112302.awb") / 1000

					if var_42_9 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_3
					end

					if var_42_5.prefab_name ~= "" and arg_39_1.actors_[var_42_5.prefab_name] ~= nil then
						local var_42_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_5.prefab_name].transform, "story_v_out_112302", "112302010", "story_v_out_112302.awb")

						arg_39_1:RecordAudio("112302010", var_42_10)
						arg_39_1:RecordAudio("112302010", var_42_10)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_112302", "112302010", "story_v_out_112302.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_112302", "112302010", "story_v_out_112302.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_11 = math.max(var_42_4, arg_39_1.talkMaxDuration)

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_11 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_3) / var_42_11

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_3 + var_42_11 and arg_39_1.time_ < var_42_3 + var_42_11 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play112302011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112302011
		arg_43_1.duration_ = 11.33

		local var_43_0 = {
			ja = 11.333,
			ko = 9.9,
			zh = 8.933,
			en = 11.1
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play112302012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 1.325

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(112302011)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 53 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 53)

				if (53 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 53)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302011", "story_v_out_112302.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_112302", "112302011", "story_v_out_112302.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_112302", "112302011", "story_v_out_112302.awb")

						arg_43_1:RecordAudio("112302011", var_46_6)
						arg_43_1:RecordAudio("112302011", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_112302", "112302011", "story_v_out_112302.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_112302", "112302011", "story_v_out_112302.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play112302012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112302012
		arg_47_1.duration_ = 3

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play112302013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1084"]) then
				local var_50_0 = arg_47_1.actors_["1084"]:GetComponent("Image")

				if var_50_0 then
					arg_47_1.var_.highlightMatValue1084 = var_50_0
				end
			end

			local var_50_1 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 and not isNil(arg_47_1.actors_["1084"]) then
				if arg_47_1.var_.highlightMatValue1084 then
					local var_50_2 = Mathf.Lerp(0.5, 1, (arg_47_1.time_ - 0) / var_50_1)

					arg_47_1.var_.highlightMatValue1084.color.r = var_50_2
					arg_47_1.var_.highlightMatValue1084.color.g = var_50_2
					arg_47_1.var_.highlightMatValue1084.color.b = var_50_2
					arg_47_1.var_.highlightMatValue1084.color = arg_47_1.var_.highlightMatValue1084.color
				end
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 and not isNil(arg_47_1.actors_["1084"]) and arg_47_1.var_.highlightMatValue1084 then
				arg_47_1.actors_["1084"].transform:SetSiblingIndex(1)

				arg_47_1.var_.highlightMatValue1084.color.r = 1
				arg_47_1.var_.highlightMatValue1084.color.g = 1
				arg_47_1.var_.highlightMatValue1084.color.b = 1
				arg_47_1.var_.highlightMatValue1084.color = arg_47_1.var_.highlightMatValue1084.color
			end

			local var_50_3 = arg_47_1.actors_["1148"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_3) then
				local var_50_4 = var_50_3:GetComponent("Image")

				if var_50_4 then
					arg_47_1.var_.highlightMatValue1148 = var_50_4
				end
			end

			local var_50_5 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_3) then
				if arg_47_1.var_.highlightMatValue1148 then
					local var_50_6 = Mathf.Lerp(1, 0.5, (arg_47_1.time_ - 0) / var_50_5)

					arg_47_1.var_.highlightMatValue1148.color.r = var_50_6
					arg_47_1.var_.highlightMatValue1148.color.g = var_50_6
					arg_47_1.var_.highlightMatValue1148.color.b = var_50_6
					arg_47_1.var_.highlightMatValue1148.color = arg_47_1.var_.highlightMatValue1148.color
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.highlightMatValue1148 then
				arg_47_1.var_.highlightMatValue1148.color.r = 0.5
				arg_47_1.var_.highlightMatValue1148.color.g = 0.5
				arg_47_1.var_.highlightMatValue1148.color.b = 0.5
				arg_47_1.var_.highlightMatValue1148.color = arg_47_1.var_.highlightMatValue1148.color
			end

			local var_50_7 = 0
			local var_50_8 = 0.2

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_9 = arg_47_1:GetWordFromCfg(112302012)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 8 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 8)

				if (8 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 8)) > 0 and var_50_8 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12

					if var_50_12 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302012", "story_v_out_112302.awb") ~= 0 then
					local var_50_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302012", "story_v_out_112302.awb") / 1000

					if var_50_13 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_7
					end

					if var_50_9.prefab_name ~= "" and arg_47_1.actors_[var_50_9.prefab_name] ~= nil then
						local var_50_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_9.prefab_name].transform, "story_v_out_112302", "112302012", "story_v_out_112302.awb")

						arg_47_1:RecordAudio("112302012", var_50_14)
						arg_47_1:RecordAudio("112302012", var_50_14)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112302", "112302012", "story_v_out_112302.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112302", "112302012", "story_v_out_112302.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_15 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_15 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_7) / var_50_15

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_7 + var_50_15 and arg_47_1.time_ < var_50_7 + var_50_15 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play112302013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112302013
		arg_51_1.duration_ = 6.83

		local var_51_0 = {
			ja = 5.8,
			ko = 5.1,
			zh = 6.833,
			en = 5.666
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play112302014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1084"]) then
				local var_54_0 = arg_51_1.actors_["1084"]:GetComponent("Image")

				if var_54_0 then
					arg_51_1.var_.highlightMatValue1084 = var_54_0
				end
			end

			local var_54_1 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 and not isNil(arg_51_1.actors_["1084"]) then
				if arg_51_1.var_.highlightMatValue1084 then
					local var_54_2 = Mathf.Lerp(1, 0.5, (arg_51_1.time_ - 0) / var_54_1)

					arg_51_1.var_.highlightMatValue1084.color.r = var_54_2
					arg_51_1.var_.highlightMatValue1084.color.g = var_54_2
					arg_51_1.var_.highlightMatValue1084.color.b = var_54_2
					arg_51_1.var_.highlightMatValue1084.color = arg_51_1.var_.highlightMatValue1084.color
				end
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 and not isNil(arg_51_1.actors_["1084"]) and arg_51_1.var_.highlightMatValue1084 then
				arg_51_1.var_.highlightMatValue1084.color.r = 0.5
				arg_51_1.var_.highlightMatValue1084.color.g = 0.5
				arg_51_1.var_.highlightMatValue1084.color.b = 0.5
				arg_51_1.var_.highlightMatValue1084.color = arg_51_1.var_.highlightMatValue1084.color
			end

			local var_54_3 = arg_51_1.actors_["1148"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_3) then
				local var_54_4 = var_54_3:GetComponent("Image")

				if var_54_4 then
					arg_51_1.var_.highlightMatValue1148 = var_54_4
				end
			end

			local var_54_5 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 and not isNil(var_54_3) then
				if arg_51_1.var_.highlightMatValue1148 then
					local var_54_6 = Mathf.Lerp(0.5, 1, (arg_51_1.time_ - 0) / var_54_5)

					arg_51_1.var_.highlightMatValue1148.color.r = var_54_6
					arg_51_1.var_.highlightMatValue1148.color.g = var_54_6
					arg_51_1.var_.highlightMatValue1148.color.b = var_54_6
					arg_51_1.var_.highlightMatValue1148.color = arg_51_1.var_.highlightMatValue1148.color
				end
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.highlightMatValue1148 then
				var_54_3.transform:SetSiblingIndex(1)

				arg_51_1.var_.highlightMatValue1148.color.r = 1
				arg_51_1.var_.highlightMatValue1148.color.g = 1
				arg_51_1.var_.highlightMatValue1148.color.b = 1
				arg_51_1.var_.highlightMatValue1148.color = arg_51_1.var_.highlightMatValue1148.color
			end

			local var_54_7 = 0
			local var_54_8 = 0.525

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_9 = arg_51_1:GetWordFromCfg(112302013)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_12 = 21 <= 0 and var_54_8 or var_54_8 * (utf8.len(var_54_10) / 21)

				if (21 <= 0 and var_54_8 or var_54_8 * (utf8.len(var_54_10) / 21)) > 0 and var_54_8 < var_54_12 then
					arg_51_1.talkMaxDuration = var_54_12

					if var_54_12 + var_54_7 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_7
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302013", "story_v_out_112302.awb") ~= 0 then
					local var_54_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302013", "story_v_out_112302.awb") / 1000

					if var_54_13 + var_54_7 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_7
					end

					if var_54_9.prefab_name ~= "" and arg_51_1.actors_[var_54_9.prefab_name] ~= nil then
						local var_54_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_9.prefab_name].transform, "story_v_out_112302", "112302013", "story_v_out_112302.awb")

						arg_51_1:RecordAudio("112302013", var_54_14)
						arg_51_1:RecordAudio("112302013", var_54_14)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_112302", "112302013", "story_v_out_112302.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_112302", "112302013", "story_v_out_112302.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_15 = math.max(var_54_8, arg_51_1.talkMaxDuration)

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_15 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_7) / var_54_15

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_7 + var_54_15 and arg_51_1.time_ < var_54_7 + var_54_15 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play112302014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112302014
		arg_55_1.duration_ = 9

		local var_55_0 = {
			ja = 9,
			ko = 5.866,
			zh = 5.4,
			en = 5.2
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play112302015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1084"]) then
				local var_58_0 = arg_55_1.actors_["1084"]:GetComponent("Image")

				if var_58_0 then
					arg_55_1.var_.highlightMatValue1084 = var_58_0
				end
			end

			local var_58_1 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 and not isNil(arg_55_1.actors_["1084"]) then
				if arg_55_1.var_.highlightMatValue1084 then
					local var_58_2 = Mathf.Lerp(0.5, 1, (arg_55_1.time_ - 0) / var_58_1)

					arg_55_1.var_.highlightMatValue1084.color.r = var_58_2
					arg_55_1.var_.highlightMatValue1084.color.g = var_58_2
					arg_55_1.var_.highlightMatValue1084.color.b = var_58_2
					arg_55_1.var_.highlightMatValue1084.color = arg_55_1.var_.highlightMatValue1084.color
				end
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 and not isNil(arg_55_1.actors_["1084"]) and arg_55_1.var_.highlightMatValue1084 then
				arg_55_1.actors_["1084"].transform:SetSiblingIndex(1)

				arg_55_1.var_.highlightMatValue1084.color.r = 1
				arg_55_1.var_.highlightMatValue1084.color.g = 1
				arg_55_1.var_.highlightMatValue1084.color.b = 1
				arg_55_1.var_.highlightMatValue1084.color = arg_55_1.var_.highlightMatValue1084.color
			end

			local var_58_3 = arg_55_1.actors_["1148"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) then
				local var_58_4 = var_58_3:GetComponent("Image")

				if var_58_4 then
					arg_55_1.var_.highlightMatValue1148 = var_58_4
				end
			end

			local var_58_5 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 and not isNil(var_58_3) then
				if arg_55_1.var_.highlightMatValue1148 then
					local var_58_6 = Mathf.Lerp(1, 0.5, (arg_55_1.time_ - 0) / var_58_5)

					arg_55_1.var_.highlightMatValue1148.color.r = var_58_6
					arg_55_1.var_.highlightMatValue1148.color.g = var_58_6
					arg_55_1.var_.highlightMatValue1148.color.b = var_58_6
					arg_55_1.var_.highlightMatValue1148.color = arg_55_1.var_.highlightMatValue1148.color
				end
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.highlightMatValue1148 then
				arg_55_1.var_.highlightMatValue1148.color.r = 0.5
				arg_55_1.var_.highlightMatValue1148.color.g = 0.5
				arg_55_1.var_.highlightMatValue1148.color.b = 0.5
				arg_55_1.var_.highlightMatValue1148.color = arg_55_1.var_.highlightMatValue1148.color
			end

			local var_58_7 = 0
			local var_58_8 = 0.525

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_9 = arg_55_1:GetWordFromCfg(112302014)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_12 = 21 <= 0 and var_58_8 or var_58_8 * (utf8.len(var_58_10) / 21)

				if (21 <= 0 and var_58_8 or var_58_8 * (utf8.len(var_58_10) / 21)) > 0 and var_58_8 < var_58_12 then
					arg_55_1.talkMaxDuration = var_58_12

					if var_58_12 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_7
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302014", "story_v_out_112302.awb") ~= 0 then
					local var_58_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302014", "story_v_out_112302.awb") / 1000

					if var_58_13 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_7
					end

					if var_58_9.prefab_name ~= "" and arg_55_1.actors_[var_58_9.prefab_name] ~= nil then
						local var_58_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_9.prefab_name].transform, "story_v_out_112302", "112302014", "story_v_out_112302.awb")

						arg_55_1:RecordAudio("112302014", var_58_14)
						arg_55_1:RecordAudio("112302014", var_58_14)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_112302", "112302014", "story_v_out_112302.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_112302", "112302014", "story_v_out_112302.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_15 = math.max(var_58_8, arg_55_1.talkMaxDuration)

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_15 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_7) / var_58_15

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_7 + var_58_15 and arg_55_1.time_ < var_58_7 + var_58_15 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play112302015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112302015
		arg_59_1.duration_ = 4.8

		local var_59_0 = {
			ja = 3.4,
			ko = 3.333,
			zh = 4.8,
			en = 3.1
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play112302016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1084"]) then
				local var_62_0 = arg_59_1.actors_["1084"]:GetComponent("Image")

				if var_62_0 then
					arg_59_1.var_.highlightMatValue1084 = var_62_0
				end
			end

			local var_62_1 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 and not isNil(arg_59_1.actors_["1084"]) then
				if arg_59_1.var_.highlightMatValue1084 then
					local var_62_2 = Mathf.Lerp(1, 0.5, (arg_59_1.time_ - 0) / var_62_1)

					arg_59_1.var_.highlightMatValue1084.color.r = var_62_2
					arg_59_1.var_.highlightMatValue1084.color.g = var_62_2
					arg_59_1.var_.highlightMatValue1084.color.b = var_62_2
					arg_59_1.var_.highlightMatValue1084.color = arg_59_1.var_.highlightMatValue1084.color
				end
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 and not isNil(arg_59_1.actors_["1084"]) and arg_59_1.var_.highlightMatValue1084 then
				arg_59_1.var_.highlightMatValue1084.color.r = 0.5
				arg_59_1.var_.highlightMatValue1084.color.g = 0.5
				arg_59_1.var_.highlightMatValue1084.color.b = 0.5
				arg_59_1.var_.highlightMatValue1084.color = arg_59_1.var_.highlightMatValue1084.color
			end

			local var_62_3 = arg_59_1.actors_["1148"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_3) then
				local var_62_4 = var_62_3:GetComponent("Image")

				if var_62_4 then
					arg_59_1.var_.highlightMatValue1148 = var_62_4
				end
			end

			local var_62_5 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 and not isNil(var_62_3) then
				if arg_59_1.var_.highlightMatValue1148 then
					local var_62_6 = Mathf.Lerp(0.5, 1, (arg_59_1.time_ - 0) / var_62_5)

					arg_59_1.var_.highlightMatValue1148.color.r = var_62_6
					arg_59_1.var_.highlightMatValue1148.color.g = var_62_6
					arg_59_1.var_.highlightMatValue1148.color.b = var_62_6
					arg_59_1.var_.highlightMatValue1148.color = arg_59_1.var_.highlightMatValue1148.color
				end
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 and not isNil(var_62_3) and arg_59_1.var_.highlightMatValue1148 then
				var_62_3.transform:SetSiblingIndex(1)

				arg_59_1.var_.highlightMatValue1148.color.r = 1
				arg_59_1.var_.highlightMatValue1148.color.g = 1
				arg_59_1.var_.highlightMatValue1148.color.b = 1
				arg_59_1.var_.highlightMatValue1148.color = arg_59_1.var_.highlightMatValue1148.color
			end

			local var_62_7 = 0
			local var_62_8 = 0.3

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_9 = arg_59_1:GetWordFromCfg(112302015)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_12 = 12 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 12)

				if (12 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 12)) > 0 and var_62_8 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_7
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302015", "story_v_out_112302.awb") ~= 0 then
					local var_62_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302015", "story_v_out_112302.awb") / 1000

					if var_62_13 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_7
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_112302", "112302015", "story_v_out_112302.awb")

						arg_59_1:RecordAudio("112302015", var_62_14)
						arg_59_1:RecordAudio("112302015", var_62_14)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112302", "112302015", "story_v_out_112302.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112302", "112302015", "story_v_out_112302.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_15 = math.max(var_62_8, arg_59_1.talkMaxDuration)

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_15 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_7) / var_62_15

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_7 + var_62_15 and arg_59_1.time_ < var_62_7 + var_62_15 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play112302016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112302016
		arg_63_1.duration_ = 9.4

		local var_63_0 = {
			ja = 9.4,
			ko = 6.066,
			zh = 5.6,
			en = 6.066
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play112302017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.425

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(112302016)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 17 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 17)

				if (17 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 17)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302016", "story_v_out_112302.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_112302", "112302016", "story_v_out_112302.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_112302", "112302016", "story_v_out_112302.awb")

						arg_63_1:RecordAudio("112302016", var_66_6)
						arg_63_1:RecordAudio("112302016", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112302", "112302016", "story_v_out_112302.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112302", "112302016", "story_v_out_112302.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play112302017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112302017
		arg_67_1.duration_ = 3

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play112302018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1084"]) then
				local var_70_0 = arg_67_1.actors_["1084"]:GetComponent("Image")

				if var_70_0 then
					arg_67_1.var_.highlightMatValue1084 = var_70_0
				end
			end

			local var_70_1 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 and not isNil(arg_67_1.actors_["1084"]) then
				if arg_67_1.var_.highlightMatValue1084 then
					local var_70_2 = Mathf.Lerp(0.5, 1, (arg_67_1.time_ - 0) / var_70_1)

					arg_67_1.var_.highlightMatValue1084.color.r = var_70_2
					arg_67_1.var_.highlightMatValue1084.color.g = var_70_2
					arg_67_1.var_.highlightMatValue1084.color.b = var_70_2
					arg_67_1.var_.highlightMatValue1084.color = arg_67_1.var_.highlightMatValue1084.color
				end
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 and not isNil(arg_67_1.actors_["1084"]) and arg_67_1.var_.highlightMatValue1084 then
				arg_67_1.actors_["1084"].transform:SetSiblingIndex(1)

				arg_67_1.var_.highlightMatValue1084.color.r = 1
				arg_67_1.var_.highlightMatValue1084.color.g = 1
				arg_67_1.var_.highlightMatValue1084.color.b = 1
				arg_67_1.var_.highlightMatValue1084.color = arg_67_1.var_.highlightMatValue1084.color
			end

			local var_70_3 = arg_67_1.actors_["1148"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_3) then
				local var_70_4 = var_70_3:GetComponent("Image")

				if var_70_4 then
					arg_67_1.var_.highlightMatValue1148 = var_70_4
				end
			end

			local var_70_5 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 and not isNil(var_70_3) then
				if arg_67_1.var_.highlightMatValue1148 then
					local var_70_6 = Mathf.Lerp(1, 0.5, (arg_67_1.time_ - 0) / var_70_5)

					arg_67_1.var_.highlightMatValue1148.color.r = var_70_6
					arg_67_1.var_.highlightMatValue1148.color.g = var_70_6
					arg_67_1.var_.highlightMatValue1148.color.b = var_70_6
					arg_67_1.var_.highlightMatValue1148.color = arg_67_1.var_.highlightMatValue1148.color
				end
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.highlightMatValue1148 then
				arg_67_1.var_.highlightMatValue1148.color.r = 0.5
				arg_67_1.var_.highlightMatValue1148.color.g = 0.5
				arg_67_1.var_.highlightMatValue1148.color.b = 0.5
				arg_67_1.var_.highlightMatValue1148.color = arg_67_1.var_.highlightMatValue1148.color
			end

			local var_70_7 = 0
			local var_70_8 = 0.075

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_9 = arg_67_1:GetWordFromCfg(112302017)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_12 = 3 <= 0 and var_70_8 or var_70_8 * (utf8.len(var_70_10) / 3)

				if (3 <= 0 and var_70_8 or var_70_8 * (utf8.len(var_70_10) / 3)) > 0 and var_70_8 < var_70_12 then
					arg_67_1.talkMaxDuration = var_70_12

					if var_70_12 + var_70_7 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_7
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302017", "story_v_out_112302.awb") ~= 0 then
					local var_70_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302017", "story_v_out_112302.awb") / 1000

					if var_70_13 + var_70_7 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_7
					end

					if var_70_9.prefab_name ~= "" and arg_67_1.actors_[var_70_9.prefab_name] ~= nil then
						local var_70_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_9.prefab_name].transform, "story_v_out_112302", "112302017", "story_v_out_112302.awb")

						arg_67_1:RecordAudio("112302017", var_70_14)
						arg_67_1:RecordAudio("112302017", var_70_14)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112302", "112302017", "story_v_out_112302.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112302", "112302017", "story_v_out_112302.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_15 = math.max(var_70_8, arg_67_1.talkMaxDuration)

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_15 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_7) / var_70_15

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_7 + var_70_15 and arg_67_1.time_ < var_70_7 + var_70_15 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play112302018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112302018
		arg_71_1.duration_ = 12.63

		local var_71_0 = {
			ja = 10.666,
			ko = 8.666,
			zh = 7.4,
			en = 12.633
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play112302019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1084"]) then
				local var_74_0 = arg_71_1.actors_["1084"]:GetComponent("Image")

				if var_74_0 then
					arg_71_1.var_.highlightMatValue1084 = var_74_0
				end
			end

			local var_74_1 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 and not isNil(arg_71_1.actors_["1084"]) then
				if arg_71_1.var_.highlightMatValue1084 then
					local var_74_2 = Mathf.Lerp(1, 0.5, (arg_71_1.time_ - 0) / var_74_1)

					arg_71_1.var_.highlightMatValue1084.color.r = var_74_2
					arg_71_1.var_.highlightMatValue1084.color.g = var_74_2
					arg_71_1.var_.highlightMatValue1084.color.b = var_74_2
					arg_71_1.var_.highlightMatValue1084.color = arg_71_1.var_.highlightMatValue1084.color
				end
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 and not isNil(arg_71_1.actors_["1084"]) and arg_71_1.var_.highlightMatValue1084 then
				arg_71_1.var_.highlightMatValue1084.color.r = 0.5
				arg_71_1.var_.highlightMatValue1084.color.g = 0.5
				arg_71_1.var_.highlightMatValue1084.color.b = 0.5
				arg_71_1.var_.highlightMatValue1084.color = arg_71_1.var_.highlightMatValue1084.color
			end

			local var_74_3 = arg_71_1.actors_["1148"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_3) then
				local var_74_4 = var_74_3:GetComponent("Image")

				if var_74_4 then
					arg_71_1.var_.highlightMatValue1148 = var_74_4
				end
			end

			local var_74_5 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 and not isNil(var_74_3) then
				if arg_71_1.var_.highlightMatValue1148 then
					local var_74_6 = Mathf.Lerp(0.5, 1, (arg_71_1.time_ - 0) / var_74_5)

					arg_71_1.var_.highlightMatValue1148.color.r = var_74_6
					arg_71_1.var_.highlightMatValue1148.color.g = var_74_6
					arg_71_1.var_.highlightMatValue1148.color.b = var_74_6
					arg_71_1.var_.highlightMatValue1148.color = arg_71_1.var_.highlightMatValue1148.color
				end
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.highlightMatValue1148 then
				var_74_3.transform:SetSiblingIndex(1)

				arg_71_1.var_.highlightMatValue1148.color.r = 1
				arg_71_1.var_.highlightMatValue1148.color.g = 1
				arg_71_1.var_.highlightMatValue1148.color.b = 1
				arg_71_1.var_.highlightMatValue1148.color = arg_71_1.var_.highlightMatValue1148.color
			end

			local var_74_7 = 0
			local var_74_8 = 0.85

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_9 = arg_71_1:GetWordFromCfg(112302018)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_12 = 35 <= 0 and var_74_8 or var_74_8 * (utf8.len(var_74_10) / 35)

				if (35 <= 0 and var_74_8 or var_74_8 * (utf8.len(var_74_10) / 35)) > 0 and var_74_8 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_7 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_7
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302018", "story_v_out_112302.awb") ~= 0 then
					local var_74_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302018", "story_v_out_112302.awb") / 1000

					if var_74_13 + var_74_7 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_7
					end

					if var_74_9.prefab_name ~= "" and arg_71_1.actors_[var_74_9.prefab_name] ~= nil then
						local var_74_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_9.prefab_name].transform, "story_v_out_112302", "112302018", "story_v_out_112302.awb")

						arg_71_1:RecordAudio("112302018", var_74_14)
						arg_71_1:RecordAudio("112302018", var_74_14)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_112302", "112302018", "story_v_out_112302.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_112302", "112302018", "story_v_out_112302.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_15 = math.max(var_74_8, arg_71_1.talkMaxDuration)

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_15 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_7) / var_74_15

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_7 + var_74_15 and arg_71_1.time_ < var_74_7 + var_74_15 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play112302019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 112302019
		arg_75_1.duration_ = 5.2

		local var_75_0 = {
			ja = 3.9,
			ko = 4.066,
			zh = 3.266,
			en = 5.2
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
			arg_75_1.auto_ = false
		end

		function arg_75_1.playNext_(arg_77_0)
			arg_75_1.onStoryFinished_()
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1084"]) then
				local var_78_0 = arg_75_1.actors_["1084"]:GetComponent("Image")

				if var_78_0 then
					arg_75_1.var_.highlightMatValue1084 = var_78_0
				end
			end

			local var_78_1 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 and not isNil(arg_75_1.actors_["1084"]) then
				if arg_75_1.var_.highlightMatValue1084 then
					local var_78_2 = Mathf.Lerp(0.5, 1, (arg_75_1.time_ - 0) / var_78_1)

					arg_75_1.var_.highlightMatValue1084.color.r = var_78_2
					arg_75_1.var_.highlightMatValue1084.color.g = var_78_2
					arg_75_1.var_.highlightMatValue1084.color.b = var_78_2
					arg_75_1.var_.highlightMatValue1084.color = arg_75_1.var_.highlightMatValue1084.color
				end
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 and not isNil(arg_75_1.actors_["1084"]) and arg_75_1.var_.highlightMatValue1084 then
				arg_75_1.actors_["1084"].transform:SetSiblingIndex(1)

				arg_75_1.var_.highlightMatValue1084.color.r = 1
				arg_75_1.var_.highlightMatValue1084.color.g = 1
				arg_75_1.var_.highlightMatValue1084.color.b = 1
				arg_75_1.var_.highlightMatValue1084.color = arg_75_1.var_.highlightMatValue1084.color
			end

			local var_78_3 = arg_75_1.actors_["1148"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_3) then
				local var_78_4 = var_78_3:GetComponent("Image")

				if var_78_4 then
					arg_75_1.var_.highlightMatValue1148 = var_78_4
				end
			end

			local var_78_5 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 and not isNil(var_78_3) then
				if arg_75_1.var_.highlightMatValue1148 then
					local var_78_6 = Mathf.Lerp(1, 0.5, (arg_75_1.time_ - 0) / var_78_5)

					arg_75_1.var_.highlightMatValue1148.color.r = var_78_6
					arg_75_1.var_.highlightMatValue1148.color.g = var_78_6
					arg_75_1.var_.highlightMatValue1148.color.b = var_78_6
					arg_75_1.var_.highlightMatValue1148.color = arg_75_1.var_.highlightMatValue1148.color
				end
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 and not isNil(var_78_3) and arg_75_1.var_.highlightMatValue1148 then
				arg_75_1.var_.highlightMatValue1148.color.r = 0.5
				arg_75_1.var_.highlightMatValue1148.color.g = 0.5
				arg_75_1.var_.highlightMatValue1148.color.b = 0.5
				arg_75_1.var_.highlightMatValue1148.color = arg_75_1.var_.highlightMatValue1148.color
			end

			local var_78_7 = 0
			local var_78_8 = 0.3

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_9 = arg_75_1:GetWordFromCfg(112302019)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_12 = 12 <= 0 and var_78_8 or var_78_8 * (utf8.len(var_78_10) / 12)

				if (12 <= 0 and var_78_8 or var_78_8 * (utf8.len(var_78_10) / 12)) > 0 and var_78_8 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_7
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302019", "story_v_out_112302.awb") ~= 0 then
					local var_78_13 = manager.audio:GetVoiceLength("story_v_out_112302", "112302019", "story_v_out_112302.awb") / 1000

					if var_78_13 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_7
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_out_112302", "112302019", "story_v_out_112302.awb")

						arg_75_1:RecordAudio("112302019", var_78_14)
						arg_75_1:RecordAudio("112302019", var_78_14)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_112302", "112302019", "story_v_out_112302.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_112302", "112302019", "story_v_out_112302.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_15 = math.max(var_78_8, arg_75_1.talkMaxDuration)

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_15 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_7) / var_78_15

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_7 + var_78_15 and arg_75_1.time_ < var_78_7 + var_78_15 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_112302.awb"
	}
}
