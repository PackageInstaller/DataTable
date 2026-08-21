return {
	Play112342001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112342001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112342002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.75

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
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

				local var_4_3 = arg_1_1:GetWordFromCfg(112342001)
				local var_4_4 = arg_1_1:FormatText(var_4_3.content)

				arg_1_1.text_.text = var_4_4

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_5 = 30
				local var_4_6 = utf8.len(var_4_4)
				local var_4_7 = var_4_5 <= 0 and var_4_1 or var_4_1 * (var_4_6 / var_4_5)

				if var_4_7 > 0 and var_4_1 < var_4_7 then
					arg_1_1.talkMaxDuration = var_4_7
					var_4_0 = var_4_0 + 0.3

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

			local var_4_8 = var_4_0 + 0.3
			local var_4_9 = math.max(var_4_1, arg_1_1.talkMaxDuration)

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_9 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_8) / var_4_9

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_8 + var_4_9 and arg_1_1.time_ < var_4_8 + var_4_9 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112342002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112342002
		arg_7_1.duration_ = 6.77

		local var_7_0 = {
			ja = 5.2,
			ko = 6.766,
			zh = 5.433,
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
				arg_7_0:Play112342003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.55

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_2 = arg_7_1:FormatText(StoryNameCfg[36].name)

				arg_7_1.leftNameTxt_.text = var_10_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_3 = arg_7_1:GetWordFromCfg(112342002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 22
				local var_10_6 = utf8.len(var_10_4)
				local var_10_7 = var_10_5 <= 0 and var_10_1 or var_10_1 * (var_10_6 / var_10_5)

				if var_10_7 > 0 and var_10_1 < var_10_7 then
					arg_7_1.talkMaxDuration = var_10_7

					if var_10_7 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342002", "story_v_out_112342.awb") ~= 0 then
					local var_10_8 = manager.audio:GetVoiceLength("story_v_out_112342", "112342002", "story_v_out_112342.awb") / 1000

					if var_10_8 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_8 + var_10_0
					end

					if var_10_3.prefab_name ~= "" and arg_7_1.actors_[var_10_3.prefab_name] ~= nil then
						local var_10_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_3.prefab_name].transform, "story_v_out_112342", "112342002", "story_v_out_112342.awb")

						arg_7_1:RecordAudio("112342002", var_10_9)
						arg_7_1:RecordAudio("112342002", var_10_9)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112342", "112342002", "story_v_out_112342.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112342", "112342002", "story_v_out_112342.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_10 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_10 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_10

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_10 and arg_7_1.time_ < var_10_0 + var_10_10 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play112342003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112342003
		arg_11_1.duration_ = 7.07

		local var_11_0 = {
			ja = 5.2,
			ko = 4.266,
			zh = 4.2,
			en = 7.066
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
				arg_11_0:Play112342004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "1027"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Object.Instantiate(arg_11_1.imageGo_, arg_11_1.canvasGo_.transform)

				var_14_1.transform:SetSiblingIndex(1)

				var_14_1.name = var_14_0

				local var_14_2 = var_14_1:GetComponent(typeof(Image))

				var_14_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1027")

				var_14_2:SetNativeSize()

				var_14_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_11_1.actors_[var_14_0] = var_14_1
			end

			local var_14_3 = arg_11_1.actors_["1027"].transform
			local var_14_4 = 0

			if var_14_4 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.var_.moveOldPos1027 = var_14_3.localPosition
				var_14_3.localScale = Vector3.New(1, 1, 1)
			end

			local var_14_5 = 0.001

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_5 then
				local var_14_6 = (arg_11_1.time_ - var_14_4) / var_14_5
				local var_14_7 = Vector3.New(0, -450, 120)

				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1027, var_14_7, var_14_6)
			end

			if arg_11_1.time_ >= var_14_4 + var_14_5 and arg_11_1.time_ < var_14_4 + var_14_5 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(0, -450, 120)
			end

			local var_14_8 = arg_11_1.actors_["1027"]
			local var_14_9 = 0

			if var_14_9 < arg_11_1.time_ and arg_11_1.time_ <= var_14_9 + arg_14_0 and not isNil(var_14_8) then
				local var_14_10 = var_14_8:GetComponent("Image")

				if var_14_10 then
					arg_11_1.var_.highlightMatValue1027 = var_14_10
				end
			end

			local var_14_11 = 0.2

			if var_14_9 <= arg_11_1.time_ and arg_11_1.time_ < var_14_9 + var_14_11 and not isNil(var_14_8) then
				local var_14_12 = (arg_11_1.time_ - var_14_9) / var_14_11

				if arg_11_1.var_.highlightMatValue1027 then
					local var_14_13 = Mathf.Lerp(0.5, 1, var_14_12)
					local var_14_14 = arg_11_1.var_.highlightMatValue1027
					local var_14_15 = var_14_14.color

					var_14_15.r = var_14_13
					var_14_15.g = var_14_13
					var_14_15.b = var_14_13
					var_14_14.color = var_14_15
				end
			end

			if arg_11_1.time_ >= var_14_9 + var_14_11 and arg_11_1.time_ < var_14_9 + var_14_11 + arg_14_0 and not isNil(var_14_8) and arg_11_1.var_.highlightMatValue1027 then
				local var_14_16 = 1

				var_14_8.transform:SetSiblingIndex(1)

				local var_14_17 = arg_11_1.var_.highlightMatValue1027
				local var_14_18 = var_14_17.color

				var_14_18.r = var_14_16
				var_14_18.g = var_14_16
				var_14_18.b = var_14_16
				var_14_17.color = var_14_18
			end

			local var_14_19 = 0
			local var_14_20 = 0.475

			if var_14_19 < arg_11_1.time_ and arg_11_1.time_ <= var_14_19 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_21 = arg_11_1:FormatText(StoryNameCfg[56].name)

				arg_11_1.leftNameTxt_.text = var_14_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_22 = arg_11_1:GetWordFromCfg(112342003)
				local var_14_23 = arg_11_1:FormatText(var_14_22.content)

				arg_11_1.text_.text = var_14_23

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_24 = 19
				local var_14_25 = utf8.len(var_14_23)
				local var_14_26 = var_14_24 <= 0 and var_14_20 or var_14_20 * (var_14_25 / var_14_24)

				if var_14_26 > 0 and var_14_20 < var_14_26 then
					arg_11_1.talkMaxDuration = var_14_26

					if var_14_26 + var_14_19 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_26 + var_14_19
					end
				end

				arg_11_1.text_.text = var_14_23
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342003", "story_v_out_112342.awb") ~= 0 then
					local var_14_27 = manager.audio:GetVoiceLength("story_v_out_112342", "112342003", "story_v_out_112342.awb") / 1000

					if var_14_27 + var_14_19 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_27 + var_14_19
					end

					if var_14_22.prefab_name ~= "" and arg_11_1.actors_[var_14_22.prefab_name] ~= nil then
						local var_14_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_22.prefab_name].transform, "story_v_out_112342", "112342003", "story_v_out_112342.awb")

						arg_11_1:RecordAudio("112342003", var_14_28)
						arg_11_1:RecordAudio("112342003", var_14_28)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_112342", "112342003", "story_v_out_112342.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_112342", "112342003", "story_v_out_112342.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_29 = math.max(var_14_20, arg_11_1.talkMaxDuration)

			if var_14_19 <= arg_11_1.time_ and arg_11_1.time_ < var_14_19 + var_14_29 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_19) / var_14_29

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_19 + var_14_29 and arg_11_1.time_ < var_14_19 + var_14_29 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
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

		arg_11_1:InitPlayNodeList()
	end,
	Play112342004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 112342004
		arg_15_1.duration_ = 7.37

		local var_15_0 = {
			ja = 7.366,
			ko = 6.533,
			zh = 6.533,
			en = 5
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
				arg_15_0:Play112342005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.625

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[56].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:GetWordFromCfg(112342004)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 25
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342004", "story_v_out_112342.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_112342", "112342004", "story_v_out_112342.awb") / 1000

					if var_18_8 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_0
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_112342", "112342004", "story_v_out_112342.awb")

						arg_15_1:RecordAudio("112342004", var_18_9)
						arg_15_1:RecordAudio("112342004", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_112342", "112342004", "story_v_out_112342.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_112342", "112342004", "story_v_out_112342.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_10 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_10 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_10

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_10 and arg_15_1.time_ < var_18_0 + var_18_10 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play112342005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112342005
		arg_19_1.duration_ = 14.73

		local var_19_0 = {
			ja = 14.733,
			ko = 10.366,
			zh = 9.166,
			en = 8.1
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
				arg_19_0:Play112342006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1027"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) then
				local var_22_2 = var_22_0:GetComponent("Image")

				if var_22_2 then
					arg_19_1.var_.highlightMatValue1027 = var_22_2
				end
			end

			local var_22_3 = 0.2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_3 and not isNil(var_22_0) then
				local var_22_4 = (arg_19_1.time_ - var_22_1) / var_22_3

				if arg_19_1.var_.highlightMatValue1027 then
					local var_22_5 = Mathf.Lerp(1, 0.5, var_22_4)
					local var_22_6 = arg_19_1.var_.highlightMatValue1027
					local var_22_7 = var_22_6.color

					var_22_7.r = var_22_5
					var_22_7.g = var_22_5
					var_22_7.b = var_22_5
					var_22_6.color = var_22_7
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_3 and arg_19_1.time_ < var_22_1 + var_22_3 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.highlightMatValue1027 then
				local var_22_8 = 0.5
				local var_22_9 = arg_19_1.var_.highlightMatValue1027
				local var_22_10 = var_22_9.color

				var_22_10.r = var_22_8
				var_22_10.g = var_22_8
				var_22_10.b = var_22_8
				var_22_9.color = var_22_10
			end

			local var_22_11 = 0
			local var_22_12 = 1.1

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_13 = arg_19_1:FormatText(StoryNameCfg[36].name)

				arg_19_1.leftNameTxt_.text = var_22_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_14 = arg_19_1:GetWordFromCfg(112342005)
				local var_22_15 = arg_19_1:FormatText(var_22_14.content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_16 = 44
				local var_22_17 = utf8.len(var_22_15)
				local var_22_18 = var_22_16 <= 0 and var_22_12 or var_22_12 * (var_22_17 / var_22_16)

				if var_22_18 > 0 and var_22_12 < var_22_18 then
					arg_19_1.talkMaxDuration = var_22_18

					if var_22_18 + var_22_11 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_18 + var_22_11
					end
				end

				arg_19_1.text_.text = var_22_15
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342005", "story_v_out_112342.awb") ~= 0 then
					local var_22_19 = manager.audio:GetVoiceLength("story_v_out_112342", "112342005", "story_v_out_112342.awb") / 1000

					if var_22_19 + var_22_11 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_11
					end

					if var_22_14.prefab_name ~= "" and arg_19_1.actors_[var_22_14.prefab_name] ~= nil then
						local var_22_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_14.prefab_name].transform, "story_v_out_112342", "112342005", "story_v_out_112342.awb")

						arg_19_1:RecordAudio("112342005", var_22_20)
						arg_19_1:RecordAudio("112342005", var_22_20)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_112342", "112342005", "story_v_out_112342.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_112342", "112342005", "story_v_out_112342.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_21 = math.max(var_22_12, arg_19_1.talkMaxDuration)

			if var_22_11 <= arg_19_1.time_ and arg_19_1.time_ < var_22_11 + var_22_21 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_11) / var_22_21

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_11 + var_22_21 and arg_19_1.time_ < var_22_11 + var_22_21 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play112342006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112342006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play112342007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 1.15

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_2 = arg_23_1:GetWordFromCfg(112342006)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 46
				local var_26_5 = utf8.len(var_26_3)
				local var_26_6 = var_26_4 <= 0 and var_26_1 or var_26_1 * (var_26_5 / var_26_4)

				if var_26_6 > 0 and var_26_1 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_7 and arg_23_1.time_ < var_26_0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play112342007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112342007
		arg_27_1.duration_ = 7.17

		local var_27_0 = {
			ja = 7.166,
			ko = 4.366,
			zh = 4.966,
			en = 5.4
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
				arg_27_0:Play112342008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1027"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) then
				local var_30_2 = var_30_0:GetComponent("Image")

				if var_30_2 then
					arg_27_1.var_.highlightMatValue1027 = var_30_2
				end
			end

			local var_30_3 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_3 and not isNil(var_30_0) then
				local var_30_4 = (arg_27_1.time_ - var_30_1) / var_30_3

				if arg_27_1.var_.highlightMatValue1027 then
					local var_30_5 = Mathf.Lerp(0.5, 1, var_30_4)
					local var_30_6 = arg_27_1.var_.highlightMatValue1027
					local var_30_7 = var_30_6.color

					var_30_7.r = var_30_5
					var_30_7.g = var_30_5
					var_30_7.b = var_30_5
					var_30_6.color = var_30_7
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_3 and arg_27_1.time_ < var_30_1 + var_30_3 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.highlightMatValue1027 then
				local var_30_8 = 1

				var_30_0.transform:SetSiblingIndex(1)

				local var_30_9 = arg_27_1.var_.highlightMatValue1027
				local var_30_10 = var_30_9.color

				var_30_10.r = var_30_8
				var_30_10.g = var_30_8
				var_30_10.b = var_30_8
				var_30_9.color = var_30_10
			end

			local var_30_11 = 0
			local var_30_12 = 0.45

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_13 = arg_27_1:FormatText(StoryNameCfg[56].name)

				arg_27_1.leftNameTxt_.text = var_30_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_14 = arg_27_1:GetWordFromCfg(112342007)
				local var_30_15 = arg_27_1:FormatText(var_30_14.content)

				arg_27_1.text_.text = var_30_15

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_16 = 18
				local var_30_17 = utf8.len(var_30_15)
				local var_30_18 = var_30_16 <= 0 and var_30_12 or var_30_12 * (var_30_17 / var_30_16)

				if var_30_18 > 0 and var_30_12 < var_30_18 then
					arg_27_1.talkMaxDuration = var_30_18

					if var_30_18 + var_30_11 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_18 + var_30_11
					end
				end

				arg_27_1.text_.text = var_30_15
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342007", "story_v_out_112342.awb") ~= 0 then
					local var_30_19 = manager.audio:GetVoiceLength("story_v_out_112342", "112342007", "story_v_out_112342.awb") / 1000

					if var_30_19 + var_30_11 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_19 + var_30_11
					end

					if var_30_14.prefab_name ~= "" and arg_27_1.actors_[var_30_14.prefab_name] ~= nil then
						local var_30_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_14.prefab_name].transform, "story_v_out_112342", "112342007", "story_v_out_112342.awb")

						arg_27_1:RecordAudio("112342007", var_30_20)
						arg_27_1:RecordAudio("112342007", var_30_20)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_112342", "112342007", "story_v_out_112342.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_112342", "112342007", "story_v_out_112342.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_21 = math.max(var_30_12, arg_27_1.talkMaxDuration)

			if var_30_11 <= arg_27_1.time_ and arg_27_1.time_ < var_30_11 + var_30_21 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_11) / var_30_21

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_11 + var_30_21 and arg_27_1.time_ < var_30_11 + var_30_21 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play112342008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 112342008
		arg_31_1.duration_ = 2.57

		local var_31_0 = {
			ja = 1.8,
			ko = 2.233,
			zh = 1.7,
			en = 2.566
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
				arg_31_0:Play112342009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.15

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[56].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(112342008)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 6
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342008", "story_v_out_112342.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_112342", "112342008", "story_v_out_112342.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_112342", "112342008", "story_v_out_112342.awb")

						arg_31_1:RecordAudio("112342008", var_34_9)
						arg_31_1:RecordAudio("112342008", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112342", "112342008", "story_v_out_112342.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112342", "112342008", "story_v_out_112342.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_10 and arg_31_1.time_ < var_34_0 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play112342009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 112342009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play112342010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1027"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) then
				local var_38_2 = var_38_0:GetComponent("Image")

				if var_38_2 then
					arg_35_1.var_.highlightMatValue1027 = var_38_2
				end
			end

			local var_38_3 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_3 and not isNil(var_38_0) then
				local var_38_4 = (arg_35_1.time_ - var_38_1) / var_38_3

				if arg_35_1.var_.highlightMatValue1027 then
					local var_38_5 = Mathf.Lerp(1, 0.5, var_38_4)
					local var_38_6 = arg_35_1.var_.highlightMatValue1027
					local var_38_7 = var_38_6.color

					var_38_7.r = var_38_5
					var_38_7.g = var_38_5
					var_38_7.b = var_38_5
					var_38_6.color = var_38_7
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_3 and arg_35_1.time_ < var_38_1 + var_38_3 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.highlightMatValue1027 then
				local var_38_8 = 0.5
				local var_38_9 = arg_35_1.var_.highlightMatValue1027
				local var_38_10 = var_38_9.color

				var_38_10.r = var_38_8
				var_38_10.g = var_38_8
				var_38_10.b = var_38_8
				var_38_9.color = var_38_10
			end

			local var_38_11 = 0
			local var_38_12 = 0.9

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_13 = arg_35_1:GetWordFromCfg(112342009)
				local var_38_14 = arg_35_1:FormatText(var_38_13.content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_15 = 36
				local var_38_16 = utf8.len(var_38_14)
				local var_38_17 = var_38_15 <= 0 and var_38_12 or var_38_12 * (var_38_16 / var_38_15)

				if var_38_17 > 0 and var_38_12 < var_38_17 then
					arg_35_1.talkMaxDuration = var_38_17

					if var_38_17 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_17 + var_38_11
					end
				end

				arg_35_1.text_.text = var_38_14
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_18 = math.max(var_38_12, arg_35_1.talkMaxDuration)

			if var_38_11 <= arg_35_1.time_ and arg_35_1.time_ < var_38_11 + var_38_18 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_11) / var_38_18

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_11 + var_38_18 and arg_35_1.time_ < var_38_11 + var_38_18 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play112342010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 112342010
		arg_39_1.duration_ = 8.8

		local var_39_0 = {
			ja = 8.8,
			ko = 5.1,
			zh = 5.566,
			en = 6.7
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
				arg_39_0:Play112342011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1027"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) then
				local var_42_2 = var_42_0:GetComponent("Image")

				if var_42_2 then
					arg_39_1.var_.highlightMatValue1027 = var_42_2
				end
			end

			local var_42_3 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_3 and not isNil(var_42_0) then
				local var_42_4 = (arg_39_1.time_ - var_42_1) / var_42_3

				if arg_39_1.var_.highlightMatValue1027 then
					local var_42_5 = Mathf.Lerp(0.5, 1, var_42_4)
					local var_42_6 = arg_39_1.var_.highlightMatValue1027
					local var_42_7 = var_42_6.color

					var_42_7.r = var_42_5
					var_42_7.g = var_42_5
					var_42_7.b = var_42_5
					var_42_6.color = var_42_7
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_3 and arg_39_1.time_ < var_42_1 + var_42_3 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.highlightMatValue1027 then
				local var_42_8 = 1

				var_42_0.transform:SetSiblingIndex(1)

				local var_42_9 = arg_39_1.var_.highlightMatValue1027
				local var_42_10 = var_42_9.color

				var_42_10.r = var_42_8
				var_42_10.g = var_42_8
				var_42_10.b = var_42_8
				var_42_9.color = var_42_10
			end

			local var_42_11 = 0
			local var_42_12 = 0.525

			if var_42_11 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_13 = arg_39_1:FormatText(StoryNameCfg[56].name)

				arg_39_1.leftNameTxt_.text = var_42_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_14 = arg_39_1:GetWordFromCfg(112342010)
				local var_42_15 = arg_39_1:FormatText(var_42_14.content)

				arg_39_1.text_.text = var_42_15

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_16 = 21
				local var_42_17 = utf8.len(var_42_15)
				local var_42_18 = var_42_16 <= 0 and var_42_12 or var_42_12 * (var_42_17 / var_42_16)

				if var_42_18 > 0 and var_42_12 < var_42_18 then
					arg_39_1.talkMaxDuration = var_42_18

					if var_42_18 + var_42_11 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_18 + var_42_11
					end
				end

				arg_39_1.text_.text = var_42_15
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342010", "story_v_out_112342.awb") ~= 0 then
					local var_42_19 = manager.audio:GetVoiceLength("story_v_out_112342", "112342010", "story_v_out_112342.awb") / 1000

					if var_42_19 + var_42_11 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_19 + var_42_11
					end

					if var_42_14.prefab_name ~= "" and arg_39_1.actors_[var_42_14.prefab_name] ~= nil then
						local var_42_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_14.prefab_name].transform, "story_v_out_112342", "112342010", "story_v_out_112342.awb")

						arg_39_1:RecordAudio("112342010", var_42_20)
						arg_39_1:RecordAudio("112342010", var_42_20)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_112342", "112342010", "story_v_out_112342.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_112342", "112342010", "story_v_out_112342.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_21 = math.max(var_42_12, arg_39_1.talkMaxDuration)

			if var_42_11 <= arg_39_1.time_ and arg_39_1.time_ < var_42_11 + var_42_21 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_11) / var_42_21

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_11 + var_42_21 and arg_39_1.time_ < var_42_11 + var_42_21 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play112342011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112342011
		arg_43_1.duration_ = 9.9

		local var_43_0 = {
			ja = 7.933,
			ko = 8.1,
			zh = 7.066,
			en = 9.9
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
				arg_43_0:Play112342012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.95

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[56].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:GetWordFromCfg(112342011)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 38
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342011", "story_v_out_112342.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_112342", "112342011", "story_v_out_112342.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_112342", "112342011", "story_v_out_112342.awb")

						arg_43_1:RecordAudio("112342011", var_46_9)
						arg_43_1:RecordAudio("112342011", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_112342", "112342011", "story_v_out_112342.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_112342", "112342011", "story_v_out_112342.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_10 and arg_43_1.time_ < var_46_0 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play112342012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112342012
		arg_47_1.duration_ = 4.1

		local var_47_0 = {
			ja = 1.9,
			ko = 3.133,
			zh = 3.633,
			en = 4.1
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
				arg_47_0:Play112342013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.4

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[56].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:GetWordFromCfg(112342012)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 16
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342012", "story_v_out_112342.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_112342", "112342012", "story_v_out_112342.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_112342", "112342012", "story_v_out_112342.awb")

						arg_47_1:RecordAudio("112342012", var_50_9)
						arg_47_1:RecordAudio("112342012", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112342", "112342012", "story_v_out_112342.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112342", "112342012", "story_v_out_112342.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_10 and arg_47_1.time_ < var_50_0 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play112342013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112342013
		arg_51_1.duration_ = 10.23

		local var_51_0 = {
			ja = 10.233,
			ko = 8.2,
			zh = 8.466,
			en = 8.733
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
				arg_51_0:Play112342014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1027"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) then
				local var_54_2 = var_54_0:GetComponent("Image")

				if var_54_2 then
					arg_51_1.var_.highlightMatValue1027 = var_54_2
				end
			end

			local var_54_3 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_3 and not isNil(var_54_0) then
				local var_54_4 = (arg_51_1.time_ - var_54_1) / var_54_3

				if arg_51_1.var_.highlightMatValue1027 then
					local var_54_5 = Mathf.Lerp(1, 0.5, var_54_4)
					local var_54_6 = arg_51_1.var_.highlightMatValue1027
					local var_54_7 = var_54_6.color

					var_54_7.r = var_54_5
					var_54_7.g = var_54_5
					var_54_7.b = var_54_5
					var_54_6.color = var_54_7
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_3 and arg_51_1.time_ < var_54_1 + var_54_3 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.highlightMatValue1027 then
				local var_54_8 = 0.5
				local var_54_9 = arg_51_1.var_.highlightMatValue1027
				local var_54_10 = var_54_9.color

				var_54_10.r = var_54_8
				var_54_10.g = var_54_8
				var_54_10.b = var_54_8
				var_54_9.color = var_54_10
			end

			local var_54_11 = 0
			local var_54_12 = 0.95

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_13 = arg_51_1:FormatText(StoryNameCfg[36].name)

				arg_51_1.leftNameTxt_.text = var_54_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_14 = arg_51_1:GetWordFromCfg(112342013)
				local var_54_15 = arg_51_1:FormatText(var_54_14.content)

				arg_51_1.text_.text = var_54_15

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_16 = 38
				local var_54_17 = utf8.len(var_54_15)
				local var_54_18 = var_54_16 <= 0 and var_54_12 or var_54_12 * (var_54_17 / var_54_16)

				if var_54_18 > 0 and var_54_12 < var_54_18 then
					arg_51_1.talkMaxDuration = var_54_18

					if var_54_18 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_11
					end
				end

				arg_51_1.text_.text = var_54_15
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342013", "story_v_out_112342.awb") ~= 0 then
					local var_54_19 = manager.audio:GetVoiceLength("story_v_out_112342", "112342013", "story_v_out_112342.awb") / 1000

					if var_54_19 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_19 + var_54_11
					end

					if var_54_14.prefab_name ~= "" and arg_51_1.actors_[var_54_14.prefab_name] ~= nil then
						local var_54_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_14.prefab_name].transform, "story_v_out_112342", "112342013", "story_v_out_112342.awb")

						arg_51_1:RecordAudio("112342013", var_54_20)
						arg_51_1:RecordAudio("112342013", var_54_20)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_112342", "112342013", "story_v_out_112342.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_112342", "112342013", "story_v_out_112342.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_21 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_21 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_21

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_21 and arg_51_1.time_ < var_54_11 + var_54_21 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play112342014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112342014
		arg_55_1.duration_ = 10.9

		local var_55_0 = {
			ja = 10.9,
			ko = 9.666,
			zh = 9.233,
			en = 10.166
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
				arg_55_0:Play112342015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 1.05

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[36].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(112342014)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 42
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342014", "story_v_out_112342.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_112342", "112342014", "story_v_out_112342.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_112342", "112342014", "story_v_out_112342.awb")

						arg_55_1:RecordAudio("112342014", var_58_9)
						arg_55_1:RecordAudio("112342014", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_112342", "112342014", "story_v_out_112342.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_112342", "112342014", "story_v_out_112342.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play112342015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112342015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play112342016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.925

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(112342015)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 37
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play112342016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112342016
		arg_63_1.duration_ = 5.83

		local var_63_0 = {
			ja = 5.833,
			ko = 4.733,
			zh = 3.866,
			en = 4.3
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
				arg_63_0:Play112342017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1027"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) then
				local var_66_2 = var_66_0:GetComponent("Image")

				if var_66_2 then
					arg_63_1.var_.highlightMatValue1027 = var_66_2
				end
			end

			local var_66_3 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_3 and not isNil(var_66_0) then
				local var_66_4 = (arg_63_1.time_ - var_66_1) / var_66_3

				if arg_63_1.var_.highlightMatValue1027 then
					local var_66_5 = Mathf.Lerp(0.5, 1, var_66_4)
					local var_66_6 = arg_63_1.var_.highlightMatValue1027
					local var_66_7 = var_66_6.color

					var_66_7.r = var_66_5
					var_66_7.g = var_66_5
					var_66_7.b = var_66_5
					var_66_6.color = var_66_7
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_3 and arg_63_1.time_ < var_66_1 + var_66_3 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.highlightMatValue1027 then
				local var_66_8 = 1

				var_66_0.transform:SetSiblingIndex(1)

				local var_66_9 = arg_63_1.var_.highlightMatValue1027
				local var_66_10 = var_66_9.color

				var_66_10.r = var_66_8
				var_66_10.g = var_66_8
				var_66_10.b = var_66_8
				var_66_9.color = var_66_10
			end

			local var_66_11 = 0
			local var_66_12 = 0.375

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_13 = arg_63_1:FormatText(StoryNameCfg[56].name)

				arg_63_1.leftNameTxt_.text = var_66_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_14 = arg_63_1:GetWordFromCfg(112342016)
				local var_66_15 = arg_63_1:FormatText(var_66_14.content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_16 = 15
				local var_66_17 = utf8.len(var_66_15)
				local var_66_18 = var_66_16 <= 0 and var_66_12 or var_66_12 * (var_66_17 / var_66_16)

				if var_66_18 > 0 and var_66_12 < var_66_18 then
					arg_63_1.talkMaxDuration = var_66_18

					if var_66_18 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_11
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342016", "story_v_out_112342.awb") ~= 0 then
					local var_66_19 = manager.audio:GetVoiceLength("story_v_out_112342", "112342016", "story_v_out_112342.awb") / 1000

					if var_66_19 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_19 + var_66_11
					end

					if var_66_14.prefab_name ~= "" and arg_63_1.actors_[var_66_14.prefab_name] ~= nil then
						local var_66_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_14.prefab_name].transform, "story_v_out_112342", "112342016", "story_v_out_112342.awb")

						arg_63_1:RecordAudio("112342016", var_66_20)
						arg_63_1:RecordAudio("112342016", var_66_20)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112342", "112342016", "story_v_out_112342.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112342", "112342016", "story_v_out_112342.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_21 = math.max(var_66_12, arg_63_1.talkMaxDuration)

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_21 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_11) / var_66_21

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_11 + var_66_21 and arg_63_1.time_ < var_66_11 + var_66_21 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play112342017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112342017
		arg_67_1.duration_ = 5.13

		local var_67_0 = {
			ja = 5.133,
			ko = 2.666,
			zh = 2.933,
			en = 3.266
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
				arg_67_0:Play112342018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1027"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) then
				local var_70_2 = var_70_0:GetComponent("Image")

				if var_70_2 then
					arg_67_1.var_.highlightMatValue1027 = var_70_2
				end
			end

			local var_70_3 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_3 and not isNil(var_70_0) then
				local var_70_4 = (arg_67_1.time_ - var_70_1) / var_70_3

				if arg_67_1.var_.highlightMatValue1027 then
					local var_70_5 = Mathf.Lerp(1, 0.5, var_70_4)
					local var_70_6 = arg_67_1.var_.highlightMatValue1027
					local var_70_7 = var_70_6.color

					var_70_7.r = var_70_5
					var_70_7.g = var_70_5
					var_70_7.b = var_70_5
					var_70_6.color = var_70_7
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_3 and arg_67_1.time_ < var_70_1 + var_70_3 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.highlightMatValue1027 then
				local var_70_8 = 0.5
				local var_70_9 = arg_67_1.var_.highlightMatValue1027
				local var_70_10 = var_70_9.color

				var_70_10.r = var_70_8
				var_70_10.g = var_70_8
				var_70_10.b = var_70_8
				var_70_9.color = var_70_10
			end

			local var_70_11 = 0
			local var_70_12 = 0.225

			if var_70_11 < arg_67_1.time_ and arg_67_1.time_ <= var_70_11 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_13 = arg_67_1:FormatText(StoryNameCfg[36].name)

				arg_67_1.leftNameTxt_.text = var_70_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_14 = arg_67_1:GetWordFromCfg(112342017)
				local var_70_15 = arg_67_1:FormatText(var_70_14.content)

				arg_67_1.text_.text = var_70_15

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_16 = 9
				local var_70_17 = utf8.len(var_70_15)
				local var_70_18 = var_70_16 <= 0 and var_70_12 or var_70_12 * (var_70_17 / var_70_16)

				if var_70_18 > 0 and var_70_12 < var_70_18 then
					arg_67_1.talkMaxDuration = var_70_18

					if var_70_18 + var_70_11 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_18 + var_70_11
					end
				end

				arg_67_1.text_.text = var_70_15
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342017", "story_v_out_112342.awb") ~= 0 then
					local var_70_19 = manager.audio:GetVoiceLength("story_v_out_112342", "112342017", "story_v_out_112342.awb") / 1000

					if var_70_19 + var_70_11 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_19 + var_70_11
					end

					if var_70_14.prefab_name ~= "" and arg_67_1.actors_[var_70_14.prefab_name] ~= nil then
						local var_70_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_14.prefab_name].transform, "story_v_out_112342", "112342017", "story_v_out_112342.awb")

						arg_67_1:RecordAudio("112342017", var_70_20)
						arg_67_1:RecordAudio("112342017", var_70_20)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112342", "112342017", "story_v_out_112342.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112342", "112342017", "story_v_out_112342.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_21 = math.max(var_70_12, arg_67_1.talkMaxDuration)

			if var_70_11 <= arg_67_1.time_ and arg_67_1.time_ < var_70_11 + var_70_21 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_11) / var_70_21

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_11 + var_70_21 and arg_67_1.time_ < var_70_11 + var_70_21 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play112342018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112342018
		arg_71_1.duration_ = 7

		local var_71_0 = {
			ja = 7,
			ko = 5.366,
			zh = 4.833,
			en = 5.3
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
				arg_71_0:Play112342019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1027"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) then
				local var_74_2 = var_74_0:GetComponent("Image")

				if var_74_2 then
					arg_71_1.var_.highlightMatValue1027 = var_74_2
				end
			end

			local var_74_3 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_3 and not isNil(var_74_0) then
				local var_74_4 = (arg_71_1.time_ - var_74_1) / var_74_3

				if arg_71_1.var_.highlightMatValue1027 then
					local var_74_5 = Mathf.Lerp(0.5, 1, var_74_4)
					local var_74_6 = arg_71_1.var_.highlightMatValue1027
					local var_74_7 = var_74_6.color

					var_74_7.r = var_74_5
					var_74_7.g = var_74_5
					var_74_7.b = var_74_5
					var_74_6.color = var_74_7
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_3 and arg_71_1.time_ < var_74_1 + var_74_3 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.highlightMatValue1027 then
				local var_74_8 = 1

				var_74_0.transform:SetSiblingIndex(1)

				local var_74_9 = arg_71_1.var_.highlightMatValue1027
				local var_74_10 = var_74_9.color

				var_74_10.r = var_74_8
				var_74_10.g = var_74_8
				var_74_10.b = var_74_8
				var_74_9.color = var_74_10
			end

			local var_74_11 = 0
			local var_74_12 = 0.55

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_13 = arg_71_1:FormatText(StoryNameCfg[56].name)

				arg_71_1.leftNameTxt_.text = var_74_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_14 = arg_71_1:GetWordFromCfg(112342018)
				local var_74_15 = arg_71_1:FormatText(var_74_14.content)

				arg_71_1.text_.text = var_74_15

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_16 = 22
				local var_74_17 = utf8.len(var_74_15)
				local var_74_18 = var_74_16 <= 0 and var_74_12 or var_74_12 * (var_74_17 / var_74_16)

				if var_74_18 > 0 and var_74_12 < var_74_18 then
					arg_71_1.talkMaxDuration = var_74_18

					if var_74_18 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_11
					end
				end

				arg_71_1.text_.text = var_74_15
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342018", "story_v_out_112342.awb") ~= 0 then
					local var_74_19 = manager.audio:GetVoiceLength("story_v_out_112342", "112342018", "story_v_out_112342.awb") / 1000

					if var_74_19 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_11
					end

					if var_74_14.prefab_name ~= "" and arg_71_1.actors_[var_74_14.prefab_name] ~= nil then
						local var_74_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_14.prefab_name].transform, "story_v_out_112342", "112342018", "story_v_out_112342.awb")

						arg_71_1:RecordAudio("112342018", var_74_20)
						arg_71_1:RecordAudio("112342018", var_74_20)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_112342", "112342018", "story_v_out_112342.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_112342", "112342018", "story_v_out_112342.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_21 = math.max(var_74_12, arg_71_1.talkMaxDuration)

			if var_74_11 <= arg_71_1.time_ and arg_71_1.time_ < var_74_11 + var_74_21 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_11) / var_74_21

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_11 + var_74_21 and arg_71_1.time_ < var_74_11 + var_74_21 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play112342019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 112342019
		arg_75_1.duration_ = 5

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
			local var_78_0 = arg_75_1.actors_["1027"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) then
				local var_78_2 = var_78_0:GetComponent("Image")

				if var_78_2 then
					arg_75_1.var_.highlightMatValue1027 = var_78_2
				end
			end

			local var_78_3 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_3 and not isNil(var_78_0) then
				local var_78_4 = (arg_75_1.time_ - var_78_1) / var_78_3

				if arg_75_1.var_.highlightMatValue1027 then
					local var_78_5 = Mathf.Lerp(1, 0.5, var_78_4)
					local var_78_6 = arg_75_1.var_.highlightMatValue1027
					local var_78_7 = var_78_6.color

					var_78_7.r = var_78_5
					var_78_7.g = var_78_5
					var_78_7.b = var_78_5
					var_78_6.color = var_78_7
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_3 and arg_75_1.time_ < var_78_1 + var_78_3 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.highlightMatValue1027 then
				local var_78_8 = 0.5
				local var_78_9 = arg_75_1.var_.highlightMatValue1027
				local var_78_10 = var_78_9.color

				var_78_10.r = var_78_8
				var_78_10.g = var_78_8
				var_78_10.b = var_78_8
				var_78_9.color = var_78_10
			end

			local var_78_11 = 0
			local var_78_12 = 0.775

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_13 = arg_75_1:GetWordFromCfg(112342019)
				local var_78_14 = arg_75_1:FormatText(var_78_13.content)

				arg_75_1.text_.text = var_78_14

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_15 = 31
				local var_78_16 = utf8.len(var_78_14)
				local var_78_17 = var_78_15 <= 0 and var_78_12 or var_78_12 * (var_78_16 / var_78_15)

				if var_78_17 > 0 and var_78_12 < var_78_17 then
					arg_75_1.talkMaxDuration = var_78_17

					if var_78_17 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_11
					end
				end

				arg_75_1.text_.text = var_78_14
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_18 = math.max(var_78_12, arg_75_1.talkMaxDuration)

			if var_78_11 <= arg_75_1.time_ and arg_75_1.time_ < var_78_11 + var_78_18 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_11) / var_78_18

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_11 + var_78_18 and arg_75_1.time_ < var_78_11 + var_78_18 + arg_78_0 then
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
		"story_v_out_112342.awb"
	}
}
