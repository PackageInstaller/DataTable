return {
	Play112282001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112282001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112282002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.8

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_2 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_2:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_3 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112282001).content)

				arg_1_1.text_.text = var_4_3

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_5 = 32 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 32)

				if (32 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 32)) > 0 and var_4_1 < var_4_5 then
					arg_1_1.talkMaxDuration = var_4_5
					var_4_0 = var_4_0 + 0.3

					if var_4_5 + var_4_0 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_5 + var_4_0
					end
				end

				arg_1_1.text_.text = var_4_3
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_6 = var_4_0 + 0.3
			local var_4_7 = math.max(var_4_1, arg_1_1.talkMaxDuration)

			if var_4_0 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_6) / var_4_7

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112282002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112282002
		arg_7_1.duration_ = 4.6

		local var_7_0 = {
			ja = 4.2,
			ko = 3.533,
			zh = 3.233,
			en = 4.6
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
				arg_7_0:Play112282003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1039"] == nil then
				local var_10_0 = Object.Instantiate(arg_7_1.imageGo_, arg_7_1.canvasGo_.transform)

				var_10_0.transform:SetSiblingIndex(1)

				var_10_0.name = "1039"

				local var_10_1 = var_10_0:GetComponent(typeof(Image))

				var_10_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1039")

				var_10_1:SetNativeSize()

				var_10_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_7_1.actors_["1039"] = var_10_0
			end

			local var_10_2 = arg_7_1.actors_["1039"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1039 = var_10_2.localPosition
				var_10_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_10_3 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_3 then
				var_10_2.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1039, Vector3.New(0, -500, 0), (arg_7_1.time_ - 0) / var_10_3)
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 then
				var_10_2.localPosition = Vector3.New(0, -500, 0)
			end

			local var_10_4 = arg_7_1.actors_["1039"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_4) then
				local var_10_5 = var_10_4:GetComponent("Image")

				if var_10_5 then
					arg_7_1.var_.highlightMatValue1039 = var_10_5
				end
			end

			local var_10_6 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_4) then
				if arg_7_1.var_.highlightMatValue1039 then
					local var_10_7 = Mathf.Lerp(0.5, 1, (arg_7_1.time_ - 0) / var_10_6)

					arg_7_1.var_.highlightMatValue1039.color.r = var_10_7
					arg_7_1.var_.highlightMatValue1039.color.g = var_10_7
					arg_7_1.var_.highlightMatValue1039.color.b = var_10_7
					arg_7_1.var_.highlightMatValue1039.color = arg_7_1.var_.highlightMatValue1039.color
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_4) and arg_7_1.var_.highlightMatValue1039 then
				var_10_4.transform:SetSiblingIndex(1)

				arg_7_1.var_.highlightMatValue1039.color.r = 1
				arg_7_1.var_.highlightMatValue1039.color.g = 1
				arg_7_1.var_.highlightMatValue1039.color.b = 1
				arg_7_1.var_.highlightMatValue1039.color = arg_7_1.var_.highlightMatValue1039.color
			end

			local var_10_8 = 0
			local var_10_9 = 0.3

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_10 = arg_7_1:GetWordFromCfg(112282002)
				local var_10_11 = arg_7_1:FormatText(var_10_10.content)

				arg_7_1.text_.text = var_10_11

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_13 = 12 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 12)

				if (12 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 12)) > 0 and var_10_9 < var_10_13 then
					arg_7_1.talkMaxDuration = var_10_13

					if var_10_13 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_13 + var_10_8
					end
				end

				arg_7_1.text_.text = var_10_11
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282002", "story_v_out_112282.awb") ~= 0 then
					local var_10_14 = manager.audio:GetVoiceLength("story_v_out_112282", "112282002", "story_v_out_112282.awb") / 1000

					if var_10_14 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_14 + var_10_8
					end

					if var_10_10.prefab_name ~= "" and arg_7_1.actors_[var_10_10.prefab_name] ~= nil then
						local var_10_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_10.prefab_name].transform, "story_v_out_112282", "112282002", "story_v_out_112282.awb")

						arg_7_1:RecordAudio("112282002", var_10_15)
						arg_7_1:RecordAudio("112282002", var_10_15)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112282", "112282002", "story_v_out_112282.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112282", "112282002", "story_v_out_112282.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_16 = math.max(var_10_9, arg_7_1.talkMaxDuration)

			if var_10_8 <= arg_7_1.time_ and arg_7_1.time_ < var_10_8 + var_10_16 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_8) / var_10_16

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_8 + var_10_16 and arg_7_1.time_ < var_10_8 + var_10_16 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
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

		arg_7_1:InitPlayNodeList()
	end,
	Play112282003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112282003
		arg_11_1.duration_ = 4.5

		local var_11_0 = {
			ja = 4.233,
			ko = 2.666,
			zh = 4.5,
			en = 3.8
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
				arg_11_0:Play112282004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["1148"] == nil then
				local var_14_0 = Object.Instantiate(arg_11_1.imageGo_, arg_11_1.canvasGo_.transform)

				var_14_0.transform:SetSiblingIndex(1)

				var_14_0.name = "1148"

				local var_14_1 = var_14_0:GetComponent(typeof(Image))

				var_14_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1148")

				var_14_1:SetNativeSize()

				var_14_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_11_1.actors_["1148"] = var_14_0
			end

			local var_14_2 = arg_11_1.actors_["1148"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1148 = var_14_2.localPosition
				var_14_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_14_3 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_3 then
				var_14_2.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1148, Vector3.New(500, -550, 0), (arg_11_1.time_ - 0) / var_14_3)
			end

			if arg_11_1.time_ >= 0 + var_14_3 and arg_11_1.time_ < 0 + var_14_3 + arg_14_0 then
				var_14_2.localPosition = Vector3.New(500, -550, 0)
			end

			local var_14_4 = arg_11_1.actors_["1039"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1039 = var_14_4.localPosition
				var_14_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_14_5 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_5 then
				var_14_4.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1039, Vector3.New(-500, -500, 0), (arg_11_1.time_ - 0) / var_14_5)
			end

			if arg_11_1.time_ >= 0 + var_14_5 and arg_11_1.time_ < 0 + var_14_5 + arg_14_0 then
				var_14_4.localPosition = Vector3.New(-500, -500, 0)
			end

			local var_14_6 = arg_11_1.actors_["1148"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_6) then
				local var_14_7 = var_14_6:GetComponent("Image")

				if var_14_7 then
					arg_11_1.var_.highlightMatValue1148 = var_14_7
				end
			end

			local var_14_8 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_8 and not isNil(var_14_6) then
				if arg_11_1.var_.highlightMatValue1148 then
					local var_14_9 = Mathf.Lerp(0.5, 1, (arg_11_1.time_ - 0) / var_14_8)

					arg_11_1.var_.highlightMatValue1148.color.r = var_14_9
					arg_11_1.var_.highlightMatValue1148.color.g = var_14_9
					arg_11_1.var_.highlightMatValue1148.color.b = var_14_9
					arg_11_1.var_.highlightMatValue1148.color = arg_11_1.var_.highlightMatValue1148.color
				end
			end

			if arg_11_1.time_ >= 0 + var_14_8 and arg_11_1.time_ < 0 + var_14_8 + arg_14_0 and not isNil(var_14_6) and arg_11_1.var_.highlightMatValue1148 then
				var_14_6.transform:SetSiblingIndex(1)

				arg_11_1.var_.highlightMatValue1148.color.r = 1
				arg_11_1.var_.highlightMatValue1148.color.g = 1
				arg_11_1.var_.highlightMatValue1148.color.b = 1
				arg_11_1.var_.highlightMatValue1148.color = arg_11_1.var_.highlightMatValue1148.color
			end

			local var_14_10 = arg_11_1.actors_["1039"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_10) then
				local var_14_11 = var_14_10:GetComponent("Image")

				if var_14_11 then
					arg_11_1.var_.highlightMatValue1039 = var_14_11
				end
			end

			local var_14_12 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_12 and not isNil(var_14_10) then
				if arg_11_1.var_.highlightMatValue1039 then
					local var_14_13 = Mathf.Lerp(1, 0.5, (arg_11_1.time_ - 0) / var_14_12)

					arg_11_1.var_.highlightMatValue1039.color.r = var_14_13
					arg_11_1.var_.highlightMatValue1039.color.g = var_14_13
					arg_11_1.var_.highlightMatValue1039.color.b = var_14_13
					arg_11_1.var_.highlightMatValue1039.color = arg_11_1.var_.highlightMatValue1039.color
				end
			end

			if arg_11_1.time_ >= 0 + var_14_12 and arg_11_1.time_ < 0 + var_14_12 + arg_14_0 and not isNil(var_14_10) and arg_11_1.var_.highlightMatValue1039 then
				arg_11_1.var_.highlightMatValue1039.color.r = 0.5
				arg_11_1.var_.highlightMatValue1039.color.g = 0.5
				arg_11_1.var_.highlightMatValue1039.color.b = 0.5
				arg_11_1.var_.highlightMatValue1039.color = arg_11_1.var_.highlightMatValue1039.color
			end

			local var_14_14 = 0
			local var_14_15 = 0.175

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_16 = arg_11_1:GetWordFromCfg(112282003)
				local var_14_17 = arg_11_1:FormatText(var_14_16.content)

				arg_11_1.text_.text = var_14_17

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_19 = 7 <= 0 and var_14_15 or var_14_15 * (utf8.len(var_14_17) / 7)

				if (7 <= 0 and var_14_15 or var_14_15 * (utf8.len(var_14_17) / 7)) > 0 and var_14_15 < var_14_19 then
					arg_11_1.talkMaxDuration = var_14_19

					if var_14_19 + var_14_14 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_19 + var_14_14
					end
				end

				arg_11_1.text_.text = var_14_17
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282003", "story_v_out_112282.awb") ~= 0 then
					local var_14_20 = manager.audio:GetVoiceLength("story_v_out_112282", "112282003", "story_v_out_112282.awb") / 1000

					if var_14_20 + var_14_14 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_20 + var_14_14
					end

					if var_14_16.prefab_name ~= "" and arg_11_1.actors_[var_14_16.prefab_name] ~= nil then
						local var_14_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_16.prefab_name].transform, "story_v_out_112282", "112282003", "story_v_out_112282.awb")

						arg_11_1:RecordAudio("112282003", var_14_21)
						arg_11_1:RecordAudio("112282003", var_14_21)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_112282", "112282003", "story_v_out_112282.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_112282", "112282003", "story_v_out_112282.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_22 = math.max(var_14_15, arg_11_1.talkMaxDuration)

			if var_14_14 <= arg_11_1.time_ and arg_11_1.time_ < var_14_14 + var_14_22 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_14) / var_14_22

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_14 + var_14_22 and arg_11_1.time_ < var_14_14 + var_14_22 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
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
				actorName = "1039",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play112282004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 112282004
		arg_15_1.duration_ = 5.13

		local var_15_0 = {
			ja = 5.133,
			ko = 4.6,
			zh = 4.766,
			en = 4.666
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
				arg_15_0:Play112282005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1039"]) then
				local var_18_0 = arg_15_1.actors_["1039"]:GetComponent("Image")

				if var_18_0 then
					arg_15_1.var_.highlightMatValue1039 = var_18_0
				end
			end

			local var_18_1 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_1 and not isNil(arg_15_1.actors_["1039"]) then
				if arg_15_1.var_.highlightMatValue1039 then
					local var_18_2 = Mathf.Lerp(0.5, 1, (arg_15_1.time_ - 0) / var_18_1)

					arg_15_1.var_.highlightMatValue1039.color.r = var_18_2
					arg_15_1.var_.highlightMatValue1039.color.g = var_18_2
					arg_15_1.var_.highlightMatValue1039.color.b = var_18_2
					arg_15_1.var_.highlightMatValue1039.color = arg_15_1.var_.highlightMatValue1039.color
				end
			end

			if arg_15_1.time_ >= 0 + var_18_1 and arg_15_1.time_ < 0 + var_18_1 + arg_18_0 and not isNil(arg_15_1.actors_["1039"]) and arg_15_1.var_.highlightMatValue1039 then
				arg_15_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_15_1.var_.highlightMatValue1039.color.r = 1
				arg_15_1.var_.highlightMatValue1039.color.g = 1
				arg_15_1.var_.highlightMatValue1039.color.b = 1
				arg_15_1.var_.highlightMatValue1039.color = arg_15_1.var_.highlightMatValue1039.color
			end

			local var_18_3 = arg_15_1.actors_["1148"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_3) then
				local var_18_4 = var_18_3:GetComponent("Image")

				if var_18_4 then
					arg_15_1.var_.highlightMatValue1148 = var_18_4
				end
			end

			local var_18_5 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_5 and not isNil(var_18_3) then
				if arg_15_1.var_.highlightMatValue1148 then
					local var_18_6 = Mathf.Lerp(1, 0.5, (arg_15_1.time_ - 0) / var_18_5)

					arg_15_1.var_.highlightMatValue1148.color.r = var_18_6
					arg_15_1.var_.highlightMatValue1148.color.g = var_18_6
					arg_15_1.var_.highlightMatValue1148.color.b = var_18_6
					arg_15_1.var_.highlightMatValue1148.color = arg_15_1.var_.highlightMatValue1148.color
				end
			end

			if arg_15_1.time_ >= 0 + var_18_5 and arg_15_1.time_ < 0 + var_18_5 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.highlightMatValue1148 then
				arg_15_1.var_.highlightMatValue1148.color.r = 0.5
				arg_15_1.var_.highlightMatValue1148.color.g = 0.5
				arg_15_1.var_.highlightMatValue1148.color.b = 0.5
				arg_15_1.var_.highlightMatValue1148.color = arg_15_1.var_.highlightMatValue1148.color
			end

			local var_18_7 = 0
			local var_18_8 = 0.475

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_7 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_9 = arg_15_1:GetWordFromCfg(112282004)
				local var_18_10 = arg_15_1:FormatText(var_18_9.content)

				arg_15_1.text_.text = var_18_10

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_12 = 19 <= 0 and var_18_8 or var_18_8 * (utf8.len(var_18_10) / 19)

				if (19 <= 0 and var_18_8 or var_18_8 * (utf8.len(var_18_10) / 19)) > 0 and var_18_8 < var_18_12 then
					arg_15_1.talkMaxDuration = var_18_12

					if var_18_12 + var_18_7 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_12 + var_18_7
					end
				end

				arg_15_1.text_.text = var_18_10
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282004", "story_v_out_112282.awb") ~= 0 then
					local var_18_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282004", "story_v_out_112282.awb") / 1000

					if var_18_13 + var_18_7 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_7
					end

					if var_18_9.prefab_name ~= "" and arg_15_1.actors_[var_18_9.prefab_name] ~= nil then
						local var_18_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_9.prefab_name].transform, "story_v_out_112282", "112282004", "story_v_out_112282.awb")

						arg_15_1:RecordAudio("112282004", var_18_14)
						arg_15_1:RecordAudio("112282004", var_18_14)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_112282", "112282004", "story_v_out_112282.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_112282", "112282004", "story_v_out_112282.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_15 = math.max(var_18_8, arg_15_1.talkMaxDuration)

			if var_18_7 <= arg_15_1.time_ and arg_15_1.time_ < var_18_7 + var_18_15 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_7) / var_18_15

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_7 + var_18_15 and arg_15_1.time_ < var_18_7 + var_18_15 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play112282005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112282005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play112282006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1039"]) then
				local var_22_0 = arg_19_1.actors_["1039"]:GetComponent("Image")

				if var_22_0 then
					arg_19_1.var_.highlightMatValue1039 = var_22_0
				end
			end

			local var_22_1 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 and not isNil(arg_19_1.actors_["1039"]) then
				if arg_19_1.var_.highlightMatValue1039 then
					local var_22_2 = Mathf.Lerp(1, 0.5, (arg_19_1.time_ - 0) / var_22_1)

					arg_19_1.var_.highlightMatValue1039.color.r = var_22_2
					arg_19_1.var_.highlightMatValue1039.color.g = var_22_2
					arg_19_1.var_.highlightMatValue1039.color.b = var_22_2
					arg_19_1.var_.highlightMatValue1039.color = arg_19_1.var_.highlightMatValue1039.color
				end
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 and not isNil(arg_19_1.actors_["1039"]) and arg_19_1.var_.highlightMatValue1039 then
				arg_19_1.var_.highlightMatValue1039.color.r = 0.5
				arg_19_1.var_.highlightMatValue1039.color.g = 0.5
				arg_19_1.var_.highlightMatValue1039.color.b = 0.5
				arg_19_1.var_.highlightMatValue1039.color = arg_19_1.var_.highlightMatValue1039.color
			end

			local var_22_3 = 0
			local var_22_4 = 0.4

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_5 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(112282005).content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 16 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 16)

				if (16 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 16)) > 0 and var_22_4 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_3
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_8 = math.max(var_22_4, arg_19_1.talkMaxDuration)

			if var_22_3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_3 + var_22_8 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_3) / var_22_8

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_3 + var_22_8 and arg_19_1.time_ < var_22_3 + var_22_8 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play112282006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112282006
		arg_23_1.duration_ = 6.03

		local var_23_0 = {
			ja = 5.2,
			ko = 4.6,
			zh = 6.033,
			en = 3.566
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
				arg_23_0:Play112282007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1039 = arg_23_1.actors_["1039"].transform.localPosition
				arg_23_1.actors_["1039"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1039"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1039, Vector3.New(0, -2000, 0), (arg_23_1.time_ - 0) / var_26_0)
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1039"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_26_1 = arg_23_1.actors_["1148"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1148 = var_26_1.localPosition
				var_26_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_26_2 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 then
				var_26_1.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1148, Vector3.New(0, -550, 0), (arg_23_1.time_ - 0) / var_26_2)
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				var_26_1.localPosition = Vector3.New(0, -550, 0)
			end

			local var_26_3 = arg_23_1.actors_["1148"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_3) then
				local var_26_4 = var_26_3:GetComponent("Image")

				if var_26_4 then
					arg_23_1.var_.highlightMatValue1148 = var_26_4
				end
			end

			local var_26_5 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_5 and not isNil(var_26_3) then
				if arg_23_1.var_.highlightMatValue1148 then
					local var_26_6 = Mathf.Lerp(0.5, 1, (arg_23_1.time_ - 0) / var_26_5)

					arg_23_1.var_.highlightMatValue1148.color.r = var_26_6
					arg_23_1.var_.highlightMatValue1148.color.g = var_26_6
					arg_23_1.var_.highlightMatValue1148.color.b = var_26_6
					arg_23_1.var_.highlightMatValue1148.color = arg_23_1.var_.highlightMatValue1148.color
				end
			end

			if arg_23_1.time_ >= 0 + var_26_5 and arg_23_1.time_ < 0 + var_26_5 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.highlightMatValue1148 then
				var_26_3.transform:SetSiblingIndex(1)

				arg_23_1.var_.highlightMatValue1148.color.r = 1
				arg_23_1.var_.highlightMatValue1148.color.g = 1
				arg_23_1.var_.highlightMatValue1148.color.b = 1
				arg_23_1.var_.highlightMatValue1148.color = arg_23_1.var_.highlightMatValue1148.color
			end

			local var_26_7 = 0
			local var_26_8 = 0.45

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_7 + arg_26_0 then
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

				local var_26_9 = arg_23_1:GetWordFromCfg(112282006)
				local var_26_10 = arg_23_1:FormatText(var_26_9.content)

				arg_23_1.text_.text = var_26_10

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_12 = 18 <= 0 and var_26_8 or var_26_8 * (utf8.len(var_26_10) / 18)

				if (18 <= 0 and var_26_8 or var_26_8 * (utf8.len(var_26_10) / 18)) > 0 and var_26_8 < var_26_12 then
					arg_23_1.talkMaxDuration = var_26_12

					if var_26_12 + var_26_7 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_12 + var_26_7
					end
				end

				arg_23_1.text_.text = var_26_10
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282006", "story_v_out_112282.awb") ~= 0 then
					local var_26_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282006", "story_v_out_112282.awb") / 1000

					if var_26_13 + var_26_7 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_7
					end

					if var_26_9.prefab_name ~= "" and arg_23_1.actors_[var_26_9.prefab_name] ~= nil then
						local var_26_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_9.prefab_name].transform, "story_v_out_112282", "112282006", "story_v_out_112282.awb")

						arg_23_1:RecordAudio("112282006", var_26_14)
						arg_23_1:RecordAudio("112282006", var_26_14)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_112282", "112282006", "story_v_out_112282.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_112282", "112282006", "story_v_out_112282.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_15 = math.max(var_26_8, arg_23_1.talkMaxDuration)

			if var_26_7 <= arg_23_1.time_ and arg_23_1.time_ < var_26_7 + var_26_15 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_7) / var_26_15

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_7 + var_26_15 and arg_23_1.time_ < var_26_7 + var_26_15 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play112282007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112282007
		arg_27_1.duration_ = 11.77

		local var_27_0 = {
			ja = 11.766,
			ko = 9.633,
			zh = 7.9,
			en = 10.966
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
				arg_27_0:Play112282008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1148 = arg_27_1.actors_["1148"].transform.localPosition
				arg_27_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_27_1.time_ - 0) / var_30_0)
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_30_1 = "1081_1"

			if arg_27_1.actors_["1081_1"] == nil then
				local var_30_2 = Object.Instantiate(arg_27_1.imageGo_, arg_27_1.canvasGo_.transform)

				var_30_2.transform:SetSiblingIndex(1)

				var_30_2.name = var_30_1

				local var_30_3 = var_30_2:GetComponent(typeof(Image))

				var_30_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081_1")

				var_30_3:SetNativeSize()

				var_30_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_27_1.actors_[var_30_1] = var_30_2
			end

			local var_30_4 = arg_27_1.actors_["1081_1"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1081_1 = var_30_4.localPosition
				var_30_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_30_5 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 then
				var_30_4.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_27_1.time_ - 0) / var_30_5)
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 then
				var_30_4.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_30_6 = "1081"

			if arg_27_1.actors_["1081"] == nil then
				local var_30_7 = Object.Instantiate(arg_27_1.imageGo_, arg_27_1.canvasGo_.transform)

				var_30_7.transform:SetSiblingIndex(1)

				var_30_7.name = var_30_6

				local var_30_8 = var_30_7:GetComponent(typeof(Image))

				var_30_8.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081")

				var_30_8:SetNativeSize()

				var_30_7.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_27_1.actors_[var_30_6] = var_30_7
			end

			local var_30_9 = arg_27_1.actors_["1081"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_9) then
				local var_30_10 = var_30_9:GetComponent("Image")

				if var_30_10 then
					arg_27_1.var_.highlightMatValue1081 = var_30_10
				end
			end

			local var_30_11 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_11 and not isNil(var_30_9) then
				if arg_27_1.var_.highlightMatValue1081 then
					local var_30_12 = Mathf.Lerp(0.5, 1, (arg_27_1.time_ - 0) / var_30_11)

					arg_27_1.var_.highlightMatValue1081.color.r = var_30_12
					arg_27_1.var_.highlightMatValue1081.color.g = var_30_12
					arg_27_1.var_.highlightMatValue1081.color.b = var_30_12
					arg_27_1.var_.highlightMatValue1081.color = arg_27_1.var_.highlightMatValue1081.color
				end
			end

			if arg_27_1.time_ >= 0 + var_30_11 and arg_27_1.time_ < 0 + var_30_11 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.highlightMatValue1081 then
				var_30_9.transform:SetSiblingIndex(1)

				arg_27_1.var_.highlightMatValue1081.color.r = 1
				arg_27_1.var_.highlightMatValue1081.color.g = 1
				arg_27_1.var_.highlightMatValue1081.color.b = 1
				arg_27_1.var_.highlightMatValue1081.color = arg_27_1.var_.highlightMatValue1081.color
			end

			local var_30_13 = 0
			local var_30_14 = 1.05

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_15 = arg_27_1:GetWordFromCfg(112282007)
				local var_30_16 = arg_27_1:FormatText(var_30_15.content)

				arg_27_1.text_.text = var_30_16

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_18 = 42 <= 0 and var_30_14 or var_30_14 * (utf8.len(var_30_16) / 42)

				if (42 <= 0 and var_30_14 or var_30_14 * (utf8.len(var_30_16) / 42)) > 0 and var_30_14 < var_30_18 then
					arg_27_1.talkMaxDuration = var_30_18

					if var_30_18 + var_30_13 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_18 + var_30_13
					end
				end

				arg_27_1.text_.text = var_30_16
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282007", "story_v_out_112282.awb") ~= 0 then
					local var_30_19 = manager.audio:GetVoiceLength("story_v_out_112282", "112282007", "story_v_out_112282.awb") / 1000

					if var_30_19 + var_30_13 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_19 + var_30_13
					end

					if var_30_15.prefab_name ~= "" and arg_27_1.actors_[var_30_15.prefab_name] ~= nil then
						local var_30_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_15.prefab_name].transform, "story_v_out_112282", "112282007", "story_v_out_112282.awb")

						arg_27_1:RecordAudio("112282007", var_30_20)
						arg_27_1:RecordAudio("112282007", var_30_20)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_112282", "112282007", "story_v_out_112282.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_112282", "112282007", "story_v_out_112282.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_21 = math.max(var_30_14, arg_27_1.talkMaxDuration)

			if var_30_13 <= arg_27_1.time_ and arg_27_1.time_ < var_30_13 + var_30_21 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_13) / var_30_21

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_13 + var_30_21 and arg_27_1.time_ < var_30_13 + var_30_21 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play112282008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 112282008
		arg_31_1.duration_ = 8.63

		local var_31_0 = {
			ja = 8.633,
			ko = 7.733,
			zh = 6.266,
			en = 8.1
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
				arg_31_0:Play112282009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.75

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:GetWordFromCfg(112282008)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 30 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 30)

				if (30 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 30)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282008", "story_v_out_112282.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_112282", "112282008", "story_v_out_112282.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_112282", "112282008", "story_v_out_112282.awb")

						arg_31_1:RecordAudio("112282008", var_34_6)
						arg_31_1:RecordAudio("112282008", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112282", "112282008", "story_v_out_112282.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112282", "112282008", "story_v_out_112282.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play112282009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 112282009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play112282010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1081"]) then
				local var_38_0 = arg_35_1.actors_["1081"]:GetComponent("Image")

				if var_38_0 then
					arg_35_1.var_.highlightMatValue1081 = var_38_0
				end
			end

			local var_38_1 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 and not isNil(arg_35_1.actors_["1081"]) then
				if arg_35_1.var_.highlightMatValue1081 then
					local var_38_2 = Mathf.Lerp(1, 0.5, (arg_35_1.time_ - 0) / var_38_1)

					arg_35_1.var_.highlightMatValue1081.color.r = var_38_2
					arg_35_1.var_.highlightMatValue1081.color.g = var_38_2
					arg_35_1.var_.highlightMatValue1081.color.b = var_38_2
					arg_35_1.var_.highlightMatValue1081.color = arg_35_1.var_.highlightMatValue1081.color
				end
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 and not isNil(arg_35_1.actors_["1081"]) and arg_35_1.var_.highlightMatValue1081 then
				arg_35_1.var_.highlightMatValue1081.color.r = 0.5
				arg_35_1.var_.highlightMatValue1081.color.g = 0.5
				arg_35_1.var_.highlightMatValue1081.color.b = 0.5
				arg_35_1.var_.highlightMatValue1081.color = arg_35_1.var_.highlightMatValue1081.color
			end

			local var_38_3 = 0
			local var_38_4 = 0.6

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(112282009).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 24 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 24)

				if (24 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 24)) > 0 and var_38_4 < var_38_7 then
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
	Play112282010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 112282010
		arg_39_1.duration_ = 4.83

		local var_39_0 = {
			ja = 4.166,
			ko = 4.833,
			zh = 3.5,
			en = 4.7
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
				arg_39_0:Play112282011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1081"]) then
				local var_42_0 = arg_39_1.actors_["1081"]:GetComponent("Image")

				if var_42_0 then
					arg_39_1.var_.highlightMatValue1081 = var_42_0
				end
			end

			local var_42_1 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 and not isNil(arg_39_1.actors_["1081"]) then
				if arg_39_1.var_.highlightMatValue1081 then
					local var_42_2 = Mathf.Lerp(0.5, 1, (arg_39_1.time_ - 0) / var_42_1)

					arg_39_1.var_.highlightMatValue1081.color.r = var_42_2
					arg_39_1.var_.highlightMatValue1081.color.g = var_42_2
					arg_39_1.var_.highlightMatValue1081.color.b = var_42_2
					arg_39_1.var_.highlightMatValue1081.color = arg_39_1.var_.highlightMatValue1081.color
				end
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 and not isNil(arg_39_1.actors_["1081"]) and arg_39_1.var_.highlightMatValue1081 then
				arg_39_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_39_1.var_.highlightMatValue1081.color.r = 1
				arg_39_1.var_.highlightMatValue1081.color.g = 1
				arg_39_1.var_.highlightMatValue1081.color.b = 1
				arg_39_1.var_.highlightMatValue1081.color = arg_39_1.var_.highlightMatValue1081.color
			end

			local var_42_3 = 0
			local var_42_4 = 0.475

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:GetWordFromCfg(112282010)
				local var_42_6 = arg_39_1:FormatText(var_42_5.content)

				arg_39_1.text_.text = var_42_6

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_8 = 19 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 19)

				if (19 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 19)) > 0 and var_42_4 < var_42_8 then
					arg_39_1.talkMaxDuration = var_42_8

					if var_42_8 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_6
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282010", "story_v_out_112282.awb") ~= 0 then
					local var_42_9 = manager.audio:GetVoiceLength("story_v_out_112282", "112282010", "story_v_out_112282.awb") / 1000

					if var_42_9 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_3
					end

					if var_42_5.prefab_name ~= "" and arg_39_1.actors_[var_42_5.prefab_name] ~= nil then
						local var_42_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_5.prefab_name].transform, "story_v_out_112282", "112282010", "story_v_out_112282.awb")

						arg_39_1:RecordAudio("112282010", var_42_10)
						arg_39_1:RecordAudio("112282010", var_42_10)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_112282", "112282010", "story_v_out_112282.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_112282", "112282010", "story_v_out_112282.awb")
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
	Play112282011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112282011
		arg_43_1.duration_ = 8.77

		local var_43_0 = {
			ja = 8.766,
			ko = 8.333,
			zh = 6.133,
			en = 6.866
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
				arg_43_0:Play112282012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.9

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(112282011)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 36 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 36)

				if (36 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 36)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282011", "story_v_out_112282.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_112282", "112282011", "story_v_out_112282.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_112282", "112282011", "story_v_out_112282.awb")

						arg_43_1:RecordAudio("112282011", var_46_6)
						arg_43_1:RecordAudio("112282011", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_112282", "112282011", "story_v_out_112282.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_112282", "112282011", "story_v_out_112282.awb")
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
	Play112282012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112282012
		arg_47_1.duration_ = 6.37

		local var_47_0 = {
			ja = 4.766,
			ko = 6.366,
			zh = 5.033,
			en = 5.6
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play112282013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.775

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(112282012)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 31 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 31)

				if (31 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 31)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282012", "story_v_out_112282.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_112282", "112282012", "story_v_out_112282.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_112282", "112282012", "story_v_out_112282.awb")

						arg_47_1:RecordAudio("112282012", var_50_6)
						arg_47_1:RecordAudio("112282012", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112282", "112282012", "story_v_out_112282.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112282", "112282012", "story_v_out_112282.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play112282013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112282013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play112282014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1081"]) then
				local var_54_0 = arg_51_1.actors_["1081"]:GetComponent("Image")

				if var_54_0 then
					arg_51_1.var_.highlightMatValue1081 = var_54_0
				end
			end

			local var_54_1 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 and not isNil(arg_51_1.actors_["1081"]) then
				if arg_51_1.var_.highlightMatValue1081 then
					local var_54_2 = Mathf.Lerp(1, 0.5, (arg_51_1.time_ - 0) / var_54_1)

					arg_51_1.var_.highlightMatValue1081.color.r = var_54_2
					arg_51_1.var_.highlightMatValue1081.color.g = var_54_2
					arg_51_1.var_.highlightMatValue1081.color.b = var_54_2
					arg_51_1.var_.highlightMatValue1081.color = arg_51_1.var_.highlightMatValue1081.color
				end
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 and not isNil(arg_51_1.actors_["1081"]) and arg_51_1.var_.highlightMatValue1081 then
				arg_51_1.var_.highlightMatValue1081.color.r = 0.5
				arg_51_1.var_.highlightMatValue1081.color.g = 0.5
				arg_51_1.var_.highlightMatValue1081.color.b = 0.5
				arg_51_1.var_.highlightMatValue1081.color = arg_51_1.var_.highlightMatValue1081.color
			end

			local var_54_3 = 0
			local var_54_4 = 0.075

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_5 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(112282013).content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 3 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 3)

				if (3 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 3)) > 0 and var_54_4 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_3) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_3 + var_54_8 and arg_51_1.time_ < var_54_3 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play112282014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112282014
		arg_55_1.duration_ = 10.53

		local var_55_0 = {
			ja = 6.566,
			ko = 6.4,
			zh = 4.733,
			en = 10.533
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
				arg_55_0:Play112282015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1081_1 = arg_55_1.actors_["1081_1"].transform.localPosition
				arg_55_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_55_1.time_ - 0) / var_58_0)
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1081_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_1 = arg_55_1.actors_["1148"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1148 = var_58_1.localPosition
				var_58_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_58_2 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 then
				var_58_1.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1148, Vector3.New(0, -550, 0), (arg_55_1.time_ - 0) / var_58_2)
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 then
				var_58_1.localPosition = Vector3.New(0, -550, 0)
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
					local var_58_6 = Mathf.Lerp(0.5, 1, (arg_55_1.time_ - 0) / var_58_5)

					arg_55_1.var_.highlightMatValue1148.color.r = var_58_6
					arg_55_1.var_.highlightMatValue1148.color.g = var_58_6
					arg_55_1.var_.highlightMatValue1148.color.b = var_58_6
					arg_55_1.var_.highlightMatValue1148.color = arg_55_1.var_.highlightMatValue1148.color
				end
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.highlightMatValue1148 then
				var_58_3.transform:SetSiblingIndex(1)

				arg_55_1.var_.highlightMatValue1148.color.r = 1
				arg_55_1.var_.highlightMatValue1148.color.g = 1
				arg_55_1.var_.highlightMatValue1148.color.b = 1
				arg_55_1.var_.highlightMatValue1148.color = arg_55_1.var_.highlightMatValue1148.color
			end

			local var_58_7 = 0
			local var_58_8 = 0.775

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_9 = arg_55_1:GetWordFromCfg(112282014)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_12 = 31 <= 0 and var_58_8 or var_58_8 * (utf8.len(var_58_10) / 31)

				if (31 <= 0 and var_58_8 or var_58_8 * (utf8.len(var_58_10) / 31)) > 0 and var_58_8 < var_58_12 then
					arg_55_1.talkMaxDuration = var_58_12

					if var_58_12 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_7
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282014", "story_v_out_112282.awb") ~= 0 then
					local var_58_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282014", "story_v_out_112282.awb") / 1000

					if var_58_13 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_7
					end

					if var_58_9.prefab_name ~= "" and arg_55_1.actors_[var_58_9.prefab_name] ~= nil then
						local var_58_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_9.prefab_name].transform, "story_v_out_112282", "112282014", "story_v_out_112282.awb")

						arg_55_1:RecordAudio("112282014", var_58_14)
						arg_55_1:RecordAudio("112282014", var_58_14)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_112282", "112282014", "story_v_out_112282.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_112282", "112282014", "story_v_out_112282.awb")
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

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play112282015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112282015
		arg_59_1.duration_ = 11.17

		local var_59_0 = {
			ja = 11.166,
			ko = 9.6,
			zh = 8.1,
			en = 9.6
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
				arg_59_0:Play112282016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1148 = arg_59_1.actors_["1148"].transform.localPosition
				arg_59_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_59_1.time_ - 0) / var_62_0)
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_62_1 = arg_59_1.actors_["1081"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) then
				local var_62_2 = var_62_1:GetComponent("Image")

				if var_62_2 then
					arg_59_1.var_.highlightMatValue1081 = var_62_2
				end
			end

			local var_62_3 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_1) then
				if arg_59_1.var_.highlightMatValue1081 then
					local var_62_4 = Mathf.Lerp(0.5, 1, (arg_59_1.time_ - 0) / var_62_3)

					arg_59_1.var_.highlightMatValue1081.color.r = var_62_4
					arg_59_1.var_.highlightMatValue1081.color.g = var_62_4
					arg_59_1.var_.highlightMatValue1081.color.b = var_62_4
					arg_59_1.var_.highlightMatValue1081.color = arg_59_1.var_.highlightMatValue1081.color
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.highlightMatValue1081 then
				var_62_1.transform:SetSiblingIndex(1)

				arg_59_1.var_.highlightMatValue1081.color.r = 1
				arg_59_1.var_.highlightMatValue1081.color.g = 1
				arg_59_1.var_.highlightMatValue1081.color.b = 1
				arg_59_1.var_.highlightMatValue1081.color = arg_59_1.var_.highlightMatValue1081.color
			end

			local var_62_5 = arg_59_1.actors_["1081_1"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1081_1 = var_62_5.localPosition
				var_62_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_62_6 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_6 then
				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_59_1.time_ - 0) / var_62_6)
			end

			if arg_59_1.time_ >= 0 + var_62_6 and arg_59_1.time_ < 0 + var_62_6 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_62_7 = 0
			local var_62_8 = 1.15

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_9 = arg_59_1:GetWordFromCfg(112282015)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_12 = 46 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 46)

				if (46 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 46)) > 0 and var_62_8 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_7
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282015", "story_v_out_112282.awb") ~= 0 then
					local var_62_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282015", "story_v_out_112282.awb") / 1000

					if var_62_13 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_7
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_112282", "112282015", "story_v_out_112282.awb")

						arg_59_1:RecordAudio("112282015", var_62_14)
						arg_59_1:RecordAudio("112282015", var_62_14)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112282", "112282015", "story_v_out_112282.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112282", "112282015", "story_v_out_112282.awb")
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

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play112282016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112282016
		arg_63_1.duration_ = 1.9

		local var_63_0 = {
			ja = 1.9,
			ko = 1.2,
			zh = 1.466,
			en = 1.066
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
				arg_63_0:Play112282017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1081_1 = arg_63_1.actors_["1081_1"].transform.localPosition
				arg_63_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_63_1.time_ - 0) / var_66_0)
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1081_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_1 = arg_63_1.actors_["1148"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) then
				local var_66_2 = var_66_1:GetComponent("Image")

				if var_66_2 then
					arg_63_1.var_.highlightMatValue1148 = var_66_2
				end
			end

			local var_66_3 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_1) then
				if arg_63_1.var_.highlightMatValue1148 then
					local var_66_4 = Mathf.Lerp(0.5, 1, (arg_63_1.time_ - 0) / var_66_3)

					arg_63_1.var_.highlightMatValue1148.color.r = var_66_4
					arg_63_1.var_.highlightMatValue1148.color.g = var_66_4
					arg_63_1.var_.highlightMatValue1148.color.b = var_66_4
					arg_63_1.var_.highlightMatValue1148.color = arg_63_1.var_.highlightMatValue1148.color
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.highlightMatValue1148 then
				var_66_1.transform:SetSiblingIndex(1)

				arg_63_1.var_.highlightMatValue1148.color.r = 1
				arg_63_1.var_.highlightMatValue1148.color.g = 1
				arg_63_1.var_.highlightMatValue1148.color.b = 1
				arg_63_1.var_.highlightMatValue1148.color = arg_63_1.var_.highlightMatValue1148.color
			end

			local var_66_5 = arg_63_1.actors_["1148"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1148 = var_66_5.localPosition
				var_66_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_66_6 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 then
				var_66_5.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1148, Vector3.New(0, -550, 0), (arg_63_1.time_ - 0) / var_66_6)
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 then
				var_66_5.localPosition = Vector3.New(0, -550, 0)
			end

			local var_66_7 = 0
			local var_66_8 = 0.05

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 then
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

				local var_66_9 = arg_63_1:GetWordFromCfg(112282016)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_12 = 2 <= 0 and var_66_8 or var_66_8 * (utf8.len(var_66_10) / 2)

				if (2 <= 0 and var_66_8 or var_66_8 * (utf8.len(var_66_10) / 2)) > 0 and var_66_8 < var_66_12 then
					arg_63_1.talkMaxDuration = var_66_12

					if var_66_12 + var_66_7 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_7
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282016", "story_v_out_112282.awb") ~= 0 then
					local var_66_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282016", "story_v_out_112282.awb") / 1000

					if var_66_13 + var_66_7 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_7
					end

					if var_66_9.prefab_name ~= "" and arg_63_1.actors_[var_66_9.prefab_name] ~= nil then
						local var_66_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_9.prefab_name].transform, "story_v_out_112282", "112282016", "story_v_out_112282.awb")

						arg_63_1:RecordAudio("112282016", var_66_14)
						arg_63_1:RecordAudio("112282016", var_66_14)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112282", "112282016", "story_v_out_112282.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112282", "112282016", "story_v_out_112282.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_15 = math.max(var_66_8, arg_63_1.talkMaxDuration)

			if var_66_7 <= arg_63_1.time_ and arg_63_1.time_ < var_66_7 + var_66_15 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_7) / var_66_15

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_7 + var_66_15 and arg_63_1.time_ < var_66_7 + var_66_15 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play112282017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112282017
		arg_67_1.duration_ = 8.03

		local var_67_0 = {
			ja = 3.966,
			ko = 8.033,
			zh = 6.1,
			en = 5.766
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play112282018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1148 = arg_67_1.actors_["1148"].transform.localPosition
				arg_67_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1148, Vector3.New(0, -2000, -5), (arg_67_1.time_ - 0) / var_70_0)
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, -5)
			end

			local var_70_1 = "1084"

			if arg_67_1.actors_["1084"] == nil then
				local var_70_2 = Object.Instantiate(arg_67_1.imageGo_, arg_67_1.canvasGo_.transform)

				var_70_2.transform:SetSiblingIndex(1)

				var_70_2.name = var_70_1

				local var_70_3 = var_70_2:GetComponent(typeof(Image))

				var_70_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1084")

				var_70_3:SetNativeSize()

				var_70_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_67_1.actors_[var_70_1] = var_70_2
			end

			local var_70_4 = arg_67_1.actors_["1084"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1084 = var_70_4.localPosition
				var_70_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_70_5 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 then
				var_70_4.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1084, Vector3.New(0, -500, -5), (arg_67_1.time_ - 0) / var_70_5)
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 then
				var_70_4.localPosition = Vector3.New(0, -500, -5)
			end

			local var_70_6 = arg_67_1.actors_["1084"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_6) then
				local var_70_7 = var_70_6:GetComponent("Image")

				if var_70_7 then
					arg_67_1.var_.highlightMatValue1084 = var_70_7
				end
			end

			local var_70_8 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_8 and not isNil(var_70_6) then
				if arg_67_1.var_.highlightMatValue1084 then
					local var_70_9 = Mathf.Lerp(0.5, 1, (arg_67_1.time_ - 0) / var_70_8)

					arg_67_1.var_.highlightMatValue1084.color.r = var_70_9
					arg_67_1.var_.highlightMatValue1084.color.g = var_70_9
					arg_67_1.var_.highlightMatValue1084.color.b = var_70_9
					arg_67_1.var_.highlightMatValue1084.color = arg_67_1.var_.highlightMatValue1084.color
				end
			end

			if arg_67_1.time_ >= 0 + var_70_8 and arg_67_1.time_ < 0 + var_70_8 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.highlightMatValue1084 then
				var_70_6.transform:SetSiblingIndex(1)

				arg_67_1.var_.highlightMatValue1084.color.r = 1
				arg_67_1.var_.highlightMatValue1084.color.g = 1
				arg_67_1.var_.highlightMatValue1084.color.b = 1
				arg_67_1.var_.highlightMatValue1084.color = arg_67_1.var_.highlightMatValue1084.color
			end

			local var_70_10 = 0
			local var_70_11 = 0.8

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
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

				local var_70_12 = arg_67_1:GetWordFromCfg(112282017)
				local var_70_13 = arg_67_1:FormatText(var_70_12.content)

				arg_67_1.text_.text = var_70_13

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_15 = 32 <= 0 and var_70_11 or var_70_11 * (utf8.len(var_70_13) / 32)

				if (32 <= 0 and var_70_11 or var_70_11 * (utf8.len(var_70_13) / 32)) > 0 and var_70_11 < var_70_15 then
					arg_67_1.talkMaxDuration = var_70_15

					if var_70_15 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_15 + var_70_10
					end
				end

				arg_67_1.text_.text = var_70_13
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282017", "story_v_out_112282.awb") ~= 0 then
					local var_70_16 = manager.audio:GetVoiceLength("story_v_out_112282", "112282017", "story_v_out_112282.awb") / 1000

					if var_70_16 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_16 + var_70_10
					end

					if var_70_12.prefab_name ~= "" and arg_67_1.actors_[var_70_12.prefab_name] ~= nil then
						local var_70_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_12.prefab_name].transform, "story_v_out_112282", "112282017", "story_v_out_112282.awb")

						arg_67_1:RecordAudio("112282017", var_70_17)
						arg_67_1:RecordAudio("112282017", var_70_17)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112282", "112282017", "story_v_out_112282.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112282", "112282017", "story_v_out_112282.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_18 = math.max(var_70_11, arg_67_1.talkMaxDuration)

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_18 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_10) / var_70_18

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_10 + var_70_18 and arg_67_1.time_ < var_70_10 + var_70_18 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play112282018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112282018
		arg_71_1.duration_ = 8.13

		local var_71_0 = {
			ja = 7.3,
			ko = 8.133,
			zh = 7.133,
			en = 7.133
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
				arg_71_0:Play112282019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.875

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(112282018)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 35 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 35)

				if (35 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 35)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282018", "story_v_out_112282.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_112282", "112282018", "story_v_out_112282.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_112282", "112282018", "story_v_out_112282.awb")

						arg_71_1:RecordAudio("112282018", var_74_6)
						arg_71_1:RecordAudio("112282018", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_112282", "112282018", "story_v_out_112282.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_112282", "112282018", "story_v_out_112282.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play112282019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 112282019
		arg_75_1.duration_ = 6.13

		local var_75_0 = {
			ja = 6.133,
			ko = 3.1,
			zh = 2.833,
			en = 4.2
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
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play112282020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1084 = arg_75_1.actors_["1084"].transform.localPosition
				arg_75_1.actors_["1084"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1084"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1084, Vector3.New(0, -2000, 0), (arg_75_1.time_ - 0) / var_78_0)
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1084"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_78_1 = "1027"

			if arg_75_1.actors_["1027"] == nil then
				local var_78_2 = Object.Instantiate(arg_75_1.imageGo_, arg_75_1.canvasGo_.transform)

				var_78_2.transform:SetSiblingIndex(1)

				var_78_2.name = var_78_1

				local var_78_3 = var_78_2:GetComponent(typeof(Image))

				var_78_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1027")

				var_78_3:SetNativeSize()

				var_78_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_75_1.actors_[var_78_1] = var_78_2
			end

			local var_78_4 = arg_75_1.actors_["1027"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1027 = var_78_4.localPosition
				var_78_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_78_5 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 then
				var_78_4.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1027, Vector3.New(0, -500, 0), (arg_75_1.time_ - 0) / var_78_5)
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 then
				var_78_4.localPosition = Vector3.New(0, -500, 0)
			end

			local var_78_6 = arg_75_1.actors_["1027"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_6) then
				local var_78_7 = var_78_6:GetComponent("Image")

				if var_78_7 then
					arg_75_1.var_.highlightMatValue1027 = var_78_7
				end
			end

			local var_78_8 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_8 and not isNil(var_78_6) then
				if arg_75_1.var_.highlightMatValue1027 then
					local var_78_9 = Mathf.Lerp(0.5, 1, (arg_75_1.time_ - 0) / var_78_8)

					arg_75_1.var_.highlightMatValue1027.color.r = var_78_9
					arg_75_1.var_.highlightMatValue1027.color.g = var_78_9
					arg_75_1.var_.highlightMatValue1027.color.b = var_78_9
					arg_75_1.var_.highlightMatValue1027.color = arg_75_1.var_.highlightMatValue1027.color
				end
			end

			if arg_75_1.time_ >= 0 + var_78_8 and arg_75_1.time_ < 0 + var_78_8 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.highlightMatValue1027 then
				var_78_6.transform:SetSiblingIndex(1)

				arg_75_1.var_.highlightMatValue1027.color.r = 1
				arg_75_1.var_.highlightMatValue1027.color.g = 1
				arg_75_1.var_.highlightMatValue1027.color.b = 1
				arg_75_1.var_.highlightMatValue1027.color = arg_75_1.var_.highlightMatValue1027.color
			end

			local var_78_10 = 0
			local var_78_11 = 0.25

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_12 = arg_75_1:GetWordFromCfg(112282019)
				local var_78_13 = arg_75_1:FormatText(var_78_12.content)

				arg_75_1.text_.text = var_78_13

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_15 = 10 <= 0 and var_78_11 or var_78_11 * (utf8.len(var_78_13) / 10)

				if (10 <= 0 and var_78_11 or var_78_11 * (utf8.len(var_78_13) / 10)) > 0 and var_78_11 < var_78_15 then
					arg_75_1.talkMaxDuration = var_78_15

					if var_78_15 + var_78_10 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_15 + var_78_10
					end
				end

				arg_75_1.text_.text = var_78_13
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282019", "story_v_out_112282.awb") ~= 0 then
					local var_78_16 = manager.audio:GetVoiceLength("story_v_out_112282", "112282019", "story_v_out_112282.awb") / 1000

					if var_78_16 + var_78_10 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_16 + var_78_10
					end

					if var_78_12.prefab_name ~= "" and arg_75_1.actors_[var_78_12.prefab_name] ~= nil then
						local var_78_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_12.prefab_name].transform, "story_v_out_112282", "112282019", "story_v_out_112282.awb")

						arg_75_1:RecordAudio("112282019", var_78_17)
						arg_75_1:RecordAudio("112282019", var_78_17)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_112282", "112282019", "story_v_out_112282.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_112282", "112282019", "story_v_out_112282.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_18 = math.max(var_78_11, arg_75_1.talkMaxDuration)

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_18 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_10) / var_78_18

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_10 + var_78_18 and arg_75_1.time_ < var_78_10 + var_78_18 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play112282020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 112282020
		arg_79_1.duration_ = 6.4

		local var_79_0 = {
			ja = 6.4,
			ko = 6.366,
			zh = 6.133,
			en = 5.066
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play112282021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1027 = arg_79_1.actors_["1027"].transform.localPosition
				arg_79_1.actors_["1027"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1027"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1027, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0) / var_82_0)
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1027"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_1 = arg_79_1.actors_["1148"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1148 = var_82_1.localPosition
				var_82_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_82_2 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 then
				var_82_1.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1148, Vector3.New(0, -550, 0), (arg_79_1.time_ - 0) / var_82_2)
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 then
				var_82_1.localPosition = Vector3.New(0, -550, 0)
			end

			local var_82_3 = arg_79_1.actors_["1148"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_3) then
				local var_82_4 = var_82_3:GetComponent("Image")

				if var_82_4 then
					arg_79_1.var_.highlightMatValue1148 = var_82_4
				end
			end

			local var_82_5 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 and not isNil(var_82_3) then
				if arg_79_1.var_.highlightMatValue1148 then
					local var_82_6 = Mathf.Lerp(0.5, 1, (arg_79_1.time_ - 0) / var_82_5)

					arg_79_1.var_.highlightMatValue1148.color.r = var_82_6
					arg_79_1.var_.highlightMatValue1148.color.g = var_82_6
					arg_79_1.var_.highlightMatValue1148.color.b = var_82_6
					arg_79_1.var_.highlightMatValue1148.color = arg_79_1.var_.highlightMatValue1148.color
				end
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.highlightMatValue1148 then
				var_82_3.transform:SetSiblingIndex(1)

				arg_79_1.var_.highlightMatValue1148.color.r = 1
				arg_79_1.var_.highlightMatValue1148.color.g = 1
				arg_79_1.var_.highlightMatValue1148.color.b = 1
				arg_79_1.var_.highlightMatValue1148.color = arg_79_1.var_.highlightMatValue1148.color
			end

			local var_82_7 = 0
			local var_82_8 = 0.775

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(112282020)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 31 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 31)

				if (31 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 31)) > 0 and var_82_8 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_7
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282020", "story_v_out_112282.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282020", "story_v_out_112282.awb") / 1000

					if var_82_13 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_7
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_112282", "112282020", "story_v_out_112282.awb")

						arg_79_1:RecordAudio("112282020", var_82_14)
						arg_79_1:RecordAudio("112282020", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_112282", "112282020", "story_v_out_112282.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_112282", "112282020", "story_v_out_112282.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = math.max(var_82_8, arg_79_1.talkMaxDuration)

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_15 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_7) / var_82_15

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_7 + var_82_15 and arg_79_1.time_ < var_82_7 + var_82_15 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play112282021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 112282021
		arg_83_1.duration_ = 4.8

		local var_83_0 = {
			ja = 4.533,
			ko = 4.2,
			zh = 3.9,
			en = 4.8
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play112282022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1148 = arg_83_1.actors_["1148"].transform.localPosition
				arg_83_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_83_1.time_ - 0) / var_86_0)
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_86_1 = arg_83_1.actors_["1081_1"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1081_1 = var_86_1.localPosition
				var_86_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_86_2 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 then
				var_86_1.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_83_1.time_ - 0) / var_86_2)
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 then
				var_86_1.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_86_3 = arg_83_1.actors_["1081"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_3) then
				local var_86_4 = var_86_3:GetComponent("Image")

				if var_86_4 then
					arg_83_1.var_.highlightMatValue1081 = var_86_4
				end
			end

			local var_86_5 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_5 and not isNil(var_86_3) then
				if arg_83_1.var_.highlightMatValue1081 then
					local var_86_6 = Mathf.Lerp(0.5, 1, (arg_83_1.time_ - 0) / var_86_5)

					arg_83_1.var_.highlightMatValue1081.color.r = var_86_6
					arg_83_1.var_.highlightMatValue1081.color.g = var_86_6
					arg_83_1.var_.highlightMatValue1081.color.b = var_86_6
					arg_83_1.var_.highlightMatValue1081.color = arg_83_1.var_.highlightMatValue1081.color
				end
			end

			if arg_83_1.time_ >= 0 + var_86_5 and arg_83_1.time_ < 0 + var_86_5 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.highlightMatValue1081 then
				var_86_3.transform:SetSiblingIndex(1)

				arg_83_1.var_.highlightMatValue1081.color.r = 1
				arg_83_1.var_.highlightMatValue1081.color.g = 1
				arg_83_1.var_.highlightMatValue1081.color.b = 1
				arg_83_1.var_.highlightMatValue1081.color = arg_83_1.var_.highlightMatValue1081.color
			end

			local var_86_7 = 0
			local var_86_8 = 0.2

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_9 = arg_83_1:GetWordFromCfg(112282021)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_12 = 8 <= 0 and var_86_8 or var_86_8 * (utf8.len(var_86_10) / 8)

				if (8 <= 0 and var_86_8 or var_86_8 * (utf8.len(var_86_10) / 8)) > 0 and var_86_8 < var_86_12 then
					arg_83_1.talkMaxDuration = var_86_12

					if var_86_12 + var_86_7 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_7
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282021", "story_v_out_112282.awb") ~= 0 then
					local var_86_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282021", "story_v_out_112282.awb") / 1000

					if var_86_13 + var_86_7 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_7
					end

					if var_86_9.prefab_name ~= "" and arg_83_1.actors_[var_86_9.prefab_name] ~= nil then
						local var_86_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_9.prefab_name].transform, "story_v_out_112282", "112282021", "story_v_out_112282.awb")

						arg_83_1:RecordAudio("112282021", var_86_14)
						arg_83_1:RecordAudio("112282021", var_86_14)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_112282", "112282021", "story_v_out_112282.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_112282", "112282021", "story_v_out_112282.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_15 = math.max(var_86_8, arg_83_1.talkMaxDuration)

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_15 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_7) / var_86_15

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_7 + var_86_15 and arg_83_1.time_ < var_86_7 + var_86_15 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play112282022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 112282022
		arg_87_1.duration_ = 1.4

		local var_87_0 = {
			ja = 0.999999999999,
			ko = 1.4,
			zh = 1.166,
			en = 1.066
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play112282023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1148 = arg_87_1.actors_["1148"].transform.localPosition
				arg_87_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1148, Vector3.New(0, -550, 0), (arg_87_1.time_ - 0) / var_90_0)
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1148"].transform.localPosition = Vector3.New(0, -550, 0)
			end

			local var_90_1 = arg_87_1.actors_["1081_1"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1081_1 = var_90_1.localPosition
				var_90_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_90_2 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 then
				var_90_1.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_87_1.time_ - 0) / var_90_2)
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 then
				var_90_1.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_3 = arg_87_1.actors_["1148"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_3) then
				local var_90_4 = var_90_3:GetComponent("Image")

				if var_90_4 then
					arg_87_1.var_.highlightMatValue1148 = var_90_4
				end
			end

			local var_90_5 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 and not isNil(var_90_3) then
				if arg_87_1.var_.highlightMatValue1148 then
					local var_90_6 = Mathf.Lerp(0.5, 1, (arg_87_1.time_ - 0) / var_90_5)

					arg_87_1.var_.highlightMatValue1148.color.r = var_90_6
					arg_87_1.var_.highlightMatValue1148.color.g = var_90_6
					arg_87_1.var_.highlightMatValue1148.color.b = var_90_6
					arg_87_1.var_.highlightMatValue1148.color = arg_87_1.var_.highlightMatValue1148.color
				end
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 and not isNil(var_90_3) and arg_87_1.var_.highlightMatValue1148 then
				var_90_3.transform:SetSiblingIndex(1)

				arg_87_1.var_.highlightMatValue1148.color.r = 1
				arg_87_1.var_.highlightMatValue1148.color.g = 1
				arg_87_1.var_.highlightMatValue1148.color.b = 1
				arg_87_1.var_.highlightMatValue1148.color = arg_87_1.var_.highlightMatValue1148.color
			end

			local var_90_7 = 0
			local var_90_8 = 0.05

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_9 = arg_87_1:GetWordFromCfg(112282022)
				local var_90_10 = arg_87_1:FormatText(var_90_9.content)

				arg_87_1.text_.text = var_90_10

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_12 = 2 <= 0 and var_90_8 or var_90_8 * (utf8.len(var_90_10) / 2)

				if (2 <= 0 and var_90_8 or var_90_8 * (utf8.len(var_90_10) / 2)) > 0 and var_90_8 < var_90_12 then
					arg_87_1.talkMaxDuration = var_90_12

					if var_90_12 + var_90_7 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_7
					end
				end

				arg_87_1.text_.text = var_90_10
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282022", "story_v_out_112282.awb") ~= 0 then
					local var_90_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282022", "story_v_out_112282.awb") / 1000

					if var_90_13 + var_90_7 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_7
					end

					if var_90_9.prefab_name ~= "" and arg_87_1.actors_[var_90_9.prefab_name] ~= nil then
						local var_90_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_9.prefab_name].transform, "story_v_out_112282", "112282022", "story_v_out_112282.awb")

						arg_87_1:RecordAudio("112282022", var_90_14)
						arg_87_1:RecordAudio("112282022", var_90_14)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_112282", "112282022", "story_v_out_112282.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_112282", "112282022", "story_v_out_112282.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_15 = math.max(var_90_8, arg_87_1.talkMaxDuration)

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_15 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_7) / var_90_15

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_7 + var_90_15 and arg_87_1.time_ < var_90_7 + var_90_15 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play112282023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 112282023
		arg_91_1.duration_ = 5.73

		local var_91_0 = {
			ja = 5.733,
			ko = 5.7,
			zh = 3.833,
			en = 5.333
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play112282024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1148 = arg_91_1.actors_["1148"].transform.localPosition
				arg_91_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1148, Vector3.New(0, -2000, -5), (arg_91_1.time_ - 0) / var_94_0)
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, -5)
			end

			local var_94_1 = arg_91_1.actors_["1081_1"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1081_1 = var_94_1.localPosition
				var_94_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_94_2 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 then
				var_94_1.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, -5), (arg_91_1.time_ - 0) / var_94_2)
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 then
				var_94_1.localPosition = Vector3.New(-500, -300, -5)
			end

			local var_94_3 = arg_91_1.actors_["1081"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_3) then
				local var_94_4 = var_94_3:GetComponent("Image")

				if var_94_4 then
					arg_91_1.var_.highlightMatValue1081 = var_94_4
				end
			end

			local var_94_5 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 and not isNil(var_94_3) then
				if arg_91_1.var_.highlightMatValue1081 then
					local var_94_6 = Mathf.Lerp(0.5, 1, (arg_91_1.time_ - 0) / var_94_5)

					arg_91_1.var_.highlightMatValue1081.color.r = var_94_6
					arg_91_1.var_.highlightMatValue1081.color.g = var_94_6
					arg_91_1.var_.highlightMatValue1081.color.b = var_94_6
					arg_91_1.var_.highlightMatValue1081.color = arg_91_1.var_.highlightMatValue1081.color
				end
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.highlightMatValue1081 then
				var_94_3.transform:SetSiblingIndex(1)

				arg_91_1.var_.highlightMatValue1081.color.r = 1
				arg_91_1.var_.highlightMatValue1081.color.g = 1
				arg_91_1.var_.highlightMatValue1081.color.b = 1
				arg_91_1.var_.highlightMatValue1081.color = arg_91_1.var_.highlightMatValue1081.color
			end

			local var_94_7 = 0
			local var_94_8 = 0.575

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_9 = arg_91_1:GetWordFromCfg(112282023)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_12 = 23 <= 0 and var_94_8 or var_94_8 * (utf8.len(var_94_10) / 23)

				if (23 <= 0 and var_94_8 or var_94_8 * (utf8.len(var_94_10) / 23)) > 0 and var_94_8 < var_94_12 then
					arg_91_1.talkMaxDuration = var_94_12

					if var_94_12 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_7
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282023", "story_v_out_112282.awb") ~= 0 then
					local var_94_13 = manager.audio:GetVoiceLength("story_v_out_112282", "112282023", "story_v_out_112282.awb") / 1000

					if var_94_13 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_7
					end

					if var_94_9.prefab_name ~= "" and arg_91_1.actors_[var_94_9.prefab_name] ~= nil then
						local var_94_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_9.prefab_name].transform, "story_v_out_112282", "112282023", "story_v_out_112282.awb")

						arg_91_1:RecordAudio("112282023", var_94_14)
						arg_91_1:RecordAudio("112282023", var_94_14)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_112282", "112282023", "story_v_out_112282.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_112282", "112282023", "story_v_out_112282.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_15 = math.max(var_94_8, arg_91_1.talkMaxDuration)

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_15 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_7) / var_94_15

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_7 + var_94_15 and arg_91_1.time_ < var_94_7 + var_94_15 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play112282024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 112282024
		arg_95_1.duration_ = 9.5

		local var_95_0 = {
			ja = 9.5,
			ko = 8.333,
			zh = 6.933,
			en = 8.5
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play112282025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.05

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(112282024)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 42 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 42)

				if (42 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 42)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282024", "story_v_out_112282.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_112282", "112282024", "story_v_out_112282.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_112282", "112282024", "story_v_out_112282.awb")

						arg_95_1:RecordAudio("112282024", var_98_6)
						arg_95_1:RecordAudio("112282024", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_112282", "112282024", "story_v_out_112282.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_112282", "112282024", "story_v_out_112282.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play112282025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 112282025
		arg_99_1.duration_ = 11.23

		local var_99_0 = {
			ja = 11.233,
			ko = 5.266,
			zh = 5.666,
			en = 6.5
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play112282026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.75

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(112282025)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 30 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 30)

				if (30 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 30)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282025", "story_v_out_112282.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_112282", "112282025", "story_v_out_112282.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_112282", "112282025", "story_v_out_112282.awb")

						arg_99_1:RecordAudio("112282025", var_102_6)
						arg_99_1:RecordAudio("112282025", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_112282", "112282025", "story_v_out_112282.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_112282", "112282025", "story_v_out_112282.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play112282026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 112282026
		arg_103_1.duration_ = 14.23

		local var_103_0 = {
			ja = 14.233,
			ko = 10.866,
			zh = 9,
			en = 12.366
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play112282027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.125

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:GetWordFromCfg(112282026)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 45 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 45)

				if (45 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 45)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282026", "story_v_out_112282.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_112282", "112282026", "story_v_out_112282.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_112282", "112282026", "story_v_out_112282.awb")

						arg_103_1:RecordAudio("112282026", var_106_6)
						arg_103_1:RecordAudio("112282026", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_112282", "112282026", "story_v_out_112282.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_112282", "112282026", "story_v_out_112282.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play112282027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 112282027
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play112282028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1081"]) then
				local var_110_0 = arg_107_1.actors_["1081"]:GetComponent("Image")

				if var_110_0 then
					arg_107_1.var_.highlightMatValue1081 = var_110_0
				end
			end

			local var_110_1 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 and not isNil(arg_107_1.actors_["1081"]) then
				if arg_107_1.var_.highlightMatValue1081 then
					local var_110_2 = Mathf.Lerp(1, 0.5, (arg_107_1.time_ - 0) / var_110_1)

					arg_107_1.var_.highlightMatValue1081.color.r = var_110_2
					arg_107_1.var_.highlightMatValue1081.color.g = var_110_2
					arg_107_1.var_.highlightMatValue1081.color.b = var_110_2
					arg_107_1.var_.highlightMatValue1081.color = arg_107_1.var_.highlightMatValue1081.color
				end
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 and not isNil(arg_107_1.actors_["1081"]) and arg_107_1.var_.highlightMatValue1081 then
				arg_107_1.var_.highlightMatValue1081.color.r = 0.5
				arg_107_1.var_.highlightMatValue1081.color.g = 0.5
				arg_107_1.var_.highlightMatValue1081.color.b = 0.5
				arg_107_1.var_.highlightMatValue1081.color = arg_107_1.var_.highlightMatValue1081.color
			end

			local var_110_3 = 0
			local var_110_4 = 0.95

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_5 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(112282027).content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 38 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 38)

				if (38 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 38)) > 0 and var_110_4 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_3
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_4, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_3) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_8 and arg_107_1.time_ < var_110_3 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play112282028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 112282028
		arg_111_1.duration_ = 7.53

		local var_111_0 = {
			ja = 7.133,
			ko = 7.533,
			zh = 5.5,
			en = 6.6
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play112282029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1081"]) then
				local var_114_0 = arg_111_1.actors_["1081"]:GetComponent("Image")

				if var_114_0 then
					arg_111_1.var_.highlightMatValue1081 = var_114_0
				end
			end

			local var_114_1 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 and not isNil(arg_111_1.actors_["1081"]) then
				if arg_111_1.var_.highlightMatValue1081 then
					local var_114_2 = Mathf.Lerp(0.5, 1, (arg_111_1.time_ - 0) / var_114_1)

					arg_111_1.var_.highlightMatValue1081.color.r = var_114_2
					arg_111_1.var_.highlightMatValue1081.color.g = var_114_2
					arg_111_1.var_.highlightMatValue1081.color.b = var_114_2
					arg_111_1.var_.highlightMatValue1081.color = arg_111_1.var_.highlightMatValue1081.color
				end
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 and not isNil(arg_111_1.actors_["1081"]) and arg_111_1.var_.highlightMatValue1081 then
				arg_111_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_111_1.var_.highlightMatValue1081.color.r = 1
				arg_111_1.var_.highlightMatValue1081.color.g = 1
				arg_111_1.var_.highlightMatValue1081.color.b = 1
				arg_111_1.var_.highlightMatValue1081.color = arg_111_1.var_.highlightMatValue1081.color
			end

			local var_114_3 = 0
			local var_114_4 = 0.725

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:GetWordFromCfg(112282028)
				local var_114_6 = arg_111_1:FormatText(var_114_5.content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_8 = 29 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_6) / 29)

				if (29 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_6) / 29)) > 0 and var_114_4 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8

					if var_114_8 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_3
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282028", "story_v_out_112282.awb") ~= 0 then
					local var_114_9 = manager.audio:GetVoiceLength("story_v_out_112282", "112282028", "story_v_out_112282.awb") / 1000

					if var_114_9 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_3
					end

					if var_114_5.prefab_name ~= "" and arg_111_1.actors_[var_114_5.prefab_name] ~= nil then
						local var_114_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_5.prefab_name].transform, "story_v_out_112282", "112282028", "story_v_out_112282.awb")

						arg_111_1:RecordAudio("112282028", var_114_10)
						arg_111_1:RecordAudio("112282028", var_114_10)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_112282", "112282028", "story_v_out_112282.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_112282", "112282028", "story_v_out_112282.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_11 = math.max(var_114_4, arg_111_1.talkMaxDuration)

			if var_114_3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_3 + var_114_11 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_3) / var_114_11

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_3 + var_114_11 and arg_111_1.time_ < var_114_3 + var_114_11 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play112282029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 112282029
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play112282030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["1080"] == nil then
				local var_118_0 = Object.Instantiate(arg_115_1.imageGo_, arg_115_1.canvasGo_.transform)

				var_118_0.transform:SetSiblingIndex(1)

				var_118_0.name = "1080"

				local var_118_1 = var_118_0:GetComponent(typeof(Image))

				var_118_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1080")

				var_118_1:SetNativeSize()

				var_118_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_115_1.actors_["1080"] = var_118_0
			end

			local var_118_2 = arg_115_1.actors_["1080"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) then
				local var_118_3 = var_118_2:GetComponent("Image")

				if var_118_3 then
					arg_115_1.var_.highlightMatValue1080 = var_118_3
				end
			end

			local var_118_4 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 and not isNil(var_118_2) then
				if arg_115_1.var_.highlightMatValue1080 then
					local var_118_5 = Mathf.Lerp(1, 0.5, (arg_115_1.time_ - 0) / var_118_4)

					arg_115_1.var_.highlightMatValue1080.color.r = var_118_5
					arg_115_1.var_.highlightMatValue1080.color.g = var_118_5
					arg_115_1.var_.highlightMatValue1080.color.b = var_118_5
					arg_115_1.var_.highlightMatValue1080.color = arg_115_1.var_.highlightMatValue1080.color
				end
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.highlightMatValue1080 then
				arg_115_1.var_.highlightMatValue1080.color.r = 0.5
				arg_115_1.var_.highlightMatValue1080.color.g = 0.5
				arg_115_1.var_.highlightMatValue1080.color.b = 0.5
				arg_115_1.var_.highlightMatValue1080.color = arg_115_1.var_.highlightMatValue1080.color
			end

			local var_118_6 = 0
			local var_118_7 = 0.05

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_8 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(112282029).content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 2 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_8) / 2)

				if (2 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_8) / 2)) > 0 and var_118_7 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_11 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_11 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_11

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_11 and arg_115_1.time_ < var_118_6 + var_118_11 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play112282030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 112282030
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play112282031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.4

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(112282030).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 16 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 16)

				if (16 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 16)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play112282031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 112282031
		arg_123_1.duration_ = 7.97

		local var_123_0 = {
			ja = 7.966,
			ko = 5.533,
			zh = 5.8,
			en = 4.133
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play112282032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1081"]) then
				local var_126_0 = arg_123_1.actors_["1081"]:GetComponent("Image")

				if var_126_0 then
					arg_123_1.var_.highlightMatValue1081 = var_126_0
				end
			end

			local var_126_1 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 and not isNil(arg_123_1.actors_["1081"]) then
				if arg_123_1.var_.highlightMatValue1081 then
					local var_126_2 = Mathf.Lerp(0.5, 1, (arg_123_1.time_ - 0) / var_126_1)

					arg_123_1.var_.highlightMatValue1081.color.r = var_126_2
					arg_123_1.var_.highlightMatValue1081.color.g = var_126_2
					arg_123_1.var_.highlightMatValue1081.color.b = var_126_2
					arg_123_1.var_.highlightMatValue1081.color = arg_123_1.var_.highlightMatValue1081.color
				end
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 and not isNil(arg_123_1.actors_["1081"]) and arg_123_1.var_.highlightMatValue1081 then
				arg_123_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_123_1.var_.highlightMatValue1081.color.r = 1
				arg_123_1.var_.highlightMatValue1081.color.g = 1
				arg_123_1.var_.highlightMatValue1081.color.b = 1
				arg_123_1.var_.highlightMatValue1081.color = arg_123_1.var_.highlightMatValue1081.color
			end

			local var_126_3 = 0
			local var_126_4 = 0.65

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_5 = arg_123_1:GetWordFromCfg(112282031)
				local var_126_6 = arg_123_1:FormatText(var_126_5.content)

				arg_123_1.text_.text = var_126_6

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_8 = 26 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_6) / 26)

				if (26 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_6) / 26)) > 0 and var_126_4 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_3
					end
				end

				arg_123_1.text_.text = var_126_6
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282031", "story_v_out_112282.awb") ~= 0 then
					local var_126_9 = manager.audio:GetVoiceLength("story_v_out_112282", "112282031", "story_v_out_112282.awb") / 1000

					if var_126_9 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_3
					end

					if var_126_5.prefab_name ~= "" and arg_123_1.actors_[var_126_5.prefab_name] ~= nil then
						local var_126_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_5.prefab_name].transform, "story_v_out_112282", "112282031", "story_v_out_112282.awb")

						arg_123_1:RecordAudio("112282031", var_126_10)
						arg_123_1:RecordAudio("112282031", var_126_10)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_112282", "112282031", "story_v_out_112282.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_112282", "112282031", "story_v_out_112282.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_11 = math.max(var_126_4, arg_123_1.talkMaxDuration)

			if var_126_3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_3 + var_126_11 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_3) / var_126_11

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_3 + var_126_11 and arg_123_1.time_ < var_126_3 + var_126_11 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play112282032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 112282032
		arg_127_1.duration_ = 6.57

		local var_127_0 = {
			ja = 6.566,
			ko = 3.966,
			zh = 2.6,
			en = 4.766
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
			arg_127_1.auto_ = false
		end

		function arg_127_1.playNext_(arg_129_0)
			arg_127_1.onStoryFinished_()
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.3

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(112282032)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 12 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 12)

				if (12 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 12)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282032", "story_v_out_112282.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_112282", "112282032", "story_v_out_112282.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_112282", "112282032", "story_v_out_112282.awb")

						arg_127_1:RecordAudio("112282032", var_130_6)
						arg_127_1:RecordAudio("112282032", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_112282", "112282032", "story_v_out_112282.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_112282", "112282032", "story_v_out_112282.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_112282.awb"
	}
}
