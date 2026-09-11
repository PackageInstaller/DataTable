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

				local var_4_3 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112342001).content)

				arg_1_1.text_.text = var_4_3

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_5 = 30 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 30)

				if (30 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 30)) > 0 and var_4_1 < var_4_5 then
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
			local var_10_0 = 0.55

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[36].name)

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

				local var_10_1 = arg_7_1:GetWordFromCfg(112342002)
				local var_10_2 = arg_7_1:FormatText(var_10_1.content)

				arg_7_1.text_.text = var_10_2

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 22 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_2) / 22)

				if (22 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_2) / 22)) > 0 and var_10_0 < var_10_4 then
					arg_7_1.talkMaxDuration = var_10_4

					if var_10_4 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_4 + 0
					end
				end

				arg_7_1.text_.text = var_10_2
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342002", "story_v_out_112342.awb") ~= 0 then
					local var_10_5 = manager.audio:GetVoiceLength("story_v_out_112342", "112342002", "story_v_out_112342.awb") / 1000

					if var_10_5 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + 0
					end

					if var_10_1.prefab_name ~= "" and arg_7_1.actors_[var_10_1.prefab_name] ~= nil then
						local var_10_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_1.prefab_name].transform, "story_v_out_112342", "112342002", "story_v_out_112342.awb")

						arg_7_1:RecordAudio("112342002", var_10_6)
						arg_7_1:RecordAudio("112342002", var_10_6)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112342", "112342002", "story_v_out_112342.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112342", "112342002", "story_v_out_112342.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_7 and arg_7_1.time_ < 0 + var_10_7 + arg_10_0 then
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
			if arg_11_1.actors_["1027"] == nil then
				local var_14_0 = Object.Instantiate(arg_11_1.imageGo_, arg_11_1.canvasGo_.transform)

				var_14_0.transform:SetSiblingIndex(1)

				var_14_0.name = "1027"

				local var_14_1 = var_14_0:GetComponent(typeof(Image))

				var_14_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1027")

				var_14_1:SetNativeSize()

				var_14_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_11_1.actors_["1027"] = var_14_0
			end

			local var_14_2 = arg_11_1.actors_["1027"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1027 = var_14_2.localPosition
				var_14_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_14_3 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_3 then
				var_14_2.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1027, Vector3.New(0, -450, 120), (arg_11_1.time_ - 0) / var_14_3)
			end

			if arg_11_1.time_ >= 0 + var_14_3 and arg_11_1.time_ < 0 + var_14_3 + arg_14_0 then
				var_14_2.localPosition = Vector3.New(0, -450, 120)
			end

			local var_14_4 = arg_11_1.actors_["1027"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_4) then
				local var_14_5 = var_14_4:GetComponent("Image")

				if var_14_5 then
					arg_11_1.var_.highlightMatValue1027 = var_14_5
				end
			end

			local var_14_6 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 and not isNil(var_14_4) then
				if arg_11_1.var_.highlightMatValue1027 then
					local var_14_7 = Mathf.Lerp(0.5, 1, (arg_11_1.time_ - 0) / var_14_6)

					arg_11_1.var_.highlightMatValue1027.color.r = var_14_7
					arg_11_1.var_.highlightMatValue1027.color.g = var_14_7
					arg_11_1.var_.highlightMatValue1027.color.b = var_14_7
					arg_11_1.var_.highlightMatValue1027.color = arg_11_1.var_.highlightMatValue1027.color
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and not isNil(var_14_4) and arg_11_1.var_.highlightMatValue1027 then
				var_14_4.transform:SetSiblingIndex(1)

				arg_11_1.var_.highlightMatValue1027.color.r = 1
				arg_11_1.var_.highlightMatValue1027.color.g = 1
				arg_11_1.var_.highlightMatValue1027.color.b = 1
				arg_11_1.var_.highlightMatValue1027.color = arg_11_1.var_.highlightMatValue1027.color
			end

			local var_14_8 = 0
			local var_14_9 = 0.475

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_10 = arg_11_1:GetWordFromCfg(112342003)
				local var_14_11 = arg_11_1:FormatText(var_14_10.content)

				arg_11_1.text_.text = var_14_11

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_13 = 19 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_11) / 19)

				if (19 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_11) / 19)) > 0 and var_14_9 < var_14_13 then
					arg_11_1.talkMaxDuration = var_14_13

					if var_14_13 + var_14_8 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_13 + var_14_8
					end
				end

				arg_11_1.text_.text = var_14_11
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342003", "story_v_out_112342.awb") ~= 0 then
					local var_14_14 = manager.audio:GetVoiceLength("story_v_out_112342", "112342003", "story_v_out_112342.awb") / 1000

					if var_14_14 + var_14_8 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_14 + var_14_8
					end

					if var_14_10.prefab_name ~= "" and arg_11_1.actors_[var_14_10.prefab_name] ~= nil then
						local var_14_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_10.prefab_name].transform, "story_v_out_112342", "112342003", "story_v_out_112342.awb")

						arg_11_1:RecordAudio("112342003", var_14_15)
						arg_11_1:RecordAudio("112342003", var_14_15)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_112342", "112342003", "story_v_out_112342.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_112342", "112342003", "story_v_out_112342.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_16 = math.max(var_14_9, arg_11_1.talkMaxDuration)

			if var_14_8 <= arg_11_1.time_ and arg_11_1.time_ < var_14_8 + var_14_16 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_8) / var_14_16

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_8 + var_14_16 and arg_11_1.time_ < var_14_8 + var_14_16 + arg_14_0 then
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
			local var_18_0 = 0.625

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:GetWordFromCfg(112342004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 25 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 25)

				if (25 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 25)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342004", "story_v_out_112342.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_112342", "112342004", "story_v_out_112342.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_112342", "112342004", "story_v_out_112342.awb")

						arg_15_1:RecordAudio("112342004", var_18_6)
						arg_15_1:RecordAudio("112342004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_112342", "112342004", "story_v_out_112342.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_112342", "112342004", "story_v_out_112342.awb")
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
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1027"]) then
				local var_22_0 = arg_19_1.actors_["1027"]:GetComponent("Image")

				if var_22_0 then
					arg_19_1.var_.highlightMatValue1027 = var_22_0
				end
			end

			local var_22_1 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 and not isNil(arg_19_1.actors_["1027"]) then
				if arg_19_1.var_.highlightMatValue1027 then
					local var_22_2 = Mathf.Lerp(1, 0.5, (arg_19_1.time_ - 0) / var_22_1)

					arg_19_1.var_.highlightMatValue1027.color.r = var_22_2
					arg_19_1.var_.highlightMatValue1027.color.g = var_22_2
					arg_19_1.var_.highlightMatValue1027.color.b = var_22_2
					arg_19_1.var_.highlightMatValue1027.color = arg_19_1.var_.highlightMatValue1027.color
				end
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 and not isNil(arg_19_1.actors_["1027"]) and arg_19_1.var_.highlightMatValue1027 then
				arg_19_1.var_.highlightMatValue1027.color.r = 0.5
				arg_19_1.var_.highlightMatValue1027.color.g = 0.5
				arg_19_1.var_.highlightMatValue1027.color.b = 0.5
				arg_19_1.var_.highlightMatValue1027.color = arg_19_1.var_.highlightMatValue1027.color
			end

			local var_22_3 = 0
			local var_22_4 = 1.1

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[36].name)

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

				local var_22_5 = arg_19_1:GetWordFromCfg(112342005)
				local var_22_6 = arg_19_1:FormatText(var_22_5.content)

				arg_19_1.text_.text = var_22_6

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_8 = 44 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_6) / 44)

				if (44 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_6) / 44)) > 0 and var_22_4 < var_22_8 then
					arg_19_1.talkMaxDuration = var_22_8

					if var_22_8 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_3
					end
				end

				arg_19_1.text_.text = var_22_6
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342005", "story_v_out_112342.awb") ~= 0 then
					local var_22_9 = manager.audio:GetVoiceLength("story_v_out_112342", "112342005", "story_v_out_112342.awb") / 1000

					if var_22_9 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_3
					end

					if var_22_5.prefab_name ~= "" and arg_19_1.actors_[var_22_5.prefab_name] ~= nil then
						local var_22_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_5.prefab_name].transform, "story_v_out_112342", "112342005", "story_v_out_112342.awb")

						arg_19_1:RecordAudio("112342005", var_22_10)
						arg_19_1:RecordAudio("112342005", var_22_10)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_112342", "112342005", "story_v_out_112342.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_112342", "112342005", "story_v_out_112342.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_11 = math.max(var_22_4, arg_19_1.talkMaxDuration)

			if var_22_3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_3 + var_22_11 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_3) / var_22_11

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_3 + var_22_11 and arg_19_1.time_ < var_22_3 + var_22_11 + arg_22_0 then
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
			local var_26_0 = 1.15

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(112342006).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 46 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 46)

				if (46 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 46)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
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
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1027"]) then
				local var_30_0 = arg_27_1.actors_["1027"]:GetComponent("Image")

				if var_30_0 then
					arg_27_1.var_.highlightMatValue1027 = var_30_0
				end
			end

			local var_30_1 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 and not isNil(arg_27_1.actors_["1027"]) then
				if arg_27_1.var_.highlightMatValue1027 then
					local var_30_2 = Mathf.Lerp(0.5, 1, (arg_27_1.time_ - 0) / var_30_1)

					arg_27_1.var_.highlightMatValue1027.color.r = var_30_2
					arg_27_1.var_.highlightMatValue1027.color.g = var_30_2
					arg_27_1.var_.highlightMatValue1027.color.b = var_30_2
					arg_27_1.var_.highlightMatValue1027.color = arg_27_1.var_.highlightMatValue1027.color
				end
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 and not isNil(arg_27_1.actors_["1027"]) and arg_27_1.var_.highlightMatValue1027 then
				arg_27_1.actors_["1027"].transform:SetSiblingIndex(1)

				arg_27_1.var_.highlightMatValue1027.color.r = 1
				arg_27_1.var_.highlightMatValue1027.color.g = 1
				arg_27_1.var_.highlightMatValue1027.color.b = 1
				arg_27_1.var_.highlightMatValue1027.color = arg_27_1.var_.highlightMatValue1027.color
			end

			local var_30_3 = 0
			local var_30_4 = 0.45

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_3 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_5 = arg_27_1:GetWordFromCfg(112342007)
				local var_30_6 = arg_27_1:FormatText(var_30_5.content)

				arg_27_1.text_.text = var_30_6

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_8 = 18 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_6) / 18)

				if (18 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_6) / 18)) > 0 and var_30_4 < var_30_8 then
					arg_27_1.talkMaxDuration = var_30_8

					if var_30_8 + var_30_3 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_3
					end
				end

				arg_27_1.text_.text = var_30_6
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342007", "story_v_out_112342.awb") ~= 0 then
					local var_30_9 = manager.audio:GetVoiceLength("story_v_out_112342", "112342007", "story_v_out_112342.awb") / 1000

					if var_30_9 + var_30_3 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_3
					end

					if var_30_5.prefab_name ~= "" and arg_27_1.actors_[var_30_5.prefab_name] ~= nil then
						local var_30_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_5.prefab_name].transform, "story_v_out_112342", "112342007", "story_v_out_112342.awb")

						arg_27_1:RecordAudio("112342007", var_30_10)
						arg_27_1:RecordAudio("112342007", var_30_10)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_112342", "112342007", "story_v_out_112342.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_112342", "112342007", "story_v_out_112342.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_11 = math.max(var_30_4, arg_27_1.talkMaxDuration)

			if var_30_3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_3 + var_30_11 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_3) / var_30_11

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_3 + var_30_11 and arg_27_1.time_ < var_30_3 + var_30_11 + arg_30_0 then
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
			local var_34_0 = 0.15

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:GetWordFromCfg(112342008)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 6 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 6)

				if (6 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 6)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342008", "story_v_out_112342.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_112342", "112342008", "story_v_out_112342.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_112342", "112342008", "story_v_out_112342.awb")

						arg_31_1:RecordAudio("112342008", var_34_6)
						arg_31_1:RecordAudio("112342008", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112342", "112342008", "story_v_out_112342.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112342", "112342008", "story_v_out_112342.awb")
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
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1027"]) then
				local var_38_0 = arg_35_1.actors_["1027"]:GetComponent("Image")

				if var_38_0 then
					arg_35_1.var_.highlightMatValue1027 = var_38_0
				end
			end

			local var_38_1 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 and not isNil(arg_35_1.actors_["1027"]) then
				if arg_35_1.var_.highlightMatValue1027 then
					local var_38_2 = Mathf.Lerp(1, 0.5, (arg_35_1.time_ - 0) / var_38_1)

					arg_35_1.var_.highlightMatValue1027.color.r = var_38_2
					arg_35_1.var_.highlightMatValue1027.color.g = var_38_2
					arg_35_1.var_.highlightMatValue1027.color.b = var_38_2
					arg_35_1.var_.highlightMatValue1027.color = arg_35_1.var_.highlightMatValue1027.color
				end
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 and not isNil(arg_35_1.actors_["1027"]) and arg_35_1.var_.highlightMatValue1027 then
				arg_35_1.var_.highlightMatValue1027.color.r = 0.5
				arg_35_1.var_.highlightMatValue1027.color.g = 0.5
				arg_35_1.var_.highlightMatValue1027.color.b = 0.5
				arg_35_1.var_.highlightMatValue1027.color = arg_35_1.var_.highlightMatValue1027.color
			end

			local var_38_3 = 0
			local var_38_4 = 0.9

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

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(112342009).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 36 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 36)

				if (36 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 36)) > 0 and var_38_4 < var_38_7 then
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
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1027"]) then
				local var_42_0 = arg_39_1.actors_["1027"]:GetComponent("Image")

				if var_42_0 then
					arg_39_1.var_.highlightMatValue1027 = var_42_0
				end
			end

			local var_42_1 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 and not isNil(arg_39_1.actors_["1027"]) then
				if arg_39_1.var_.highlightMatValue1027 then
					local var_42_2 = Mathf.Lerp(0.5, 1, (arg_39_1.time_ - 0) / var_42_1)

					arg_39_1.var_.highlightMatValue1027.color.r = var_42_2
					arg_39_1.var_.highlightMatValue1027.color.g = var_42_2
					arg_39_1.var_.highlightMatValue1027.color.b = var_42_2
					arg_39_1.var_.highlightMatValue1027.color = arg_39_1.var_.highlightMatValue1027.color
				end
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 and not isNil(arg_39_1.actors_["1027"]) and arg_39_1.var_.highlightMatValue1027 then
				arg_39_1.actors_["1027"].transform:SetSiblingIndex(1)

				arg_39_1.var_.highlightMatValue1027.color.r = 1
				arg_39_1.var_.highlightMatValue1027.color.g = 1
				arg_39_1.var_.highlightMatValue1027.color.b = 1
				arg_39_1.var_.highlightMatValue1027.color = arg_39_1.var_.highlightMatValue1027.color
			end

			local var_42_3 = 0
			local var_42_4 = 0.525

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:GetWordFromCfg(112342010)
				local var_42_6 = arg_39_1:FormatText(var_42_5.content)

				arg_39_1.text_.text = var_42_6

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_8 = 21 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 21)

				if (21 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 21)) > 0 and var_42_4 < var_42_8 then
					arg_39_1.talkMaxDuration = var_42_8

					if var_42_8 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_6
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342010", "story_v_out_112342.awb") ~= 0 then
					local var_42_9 = manager.audio:GetVoiceLength("story_v_out_112342", "112342010", "story_v_out_112342.awb") / 1000

					if var_42_9 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_3
					end

					if var_42_5.prefab_name ~= "" and arg_39_1.actors_[var_42_5.prefab_name] ~= nil then
						local var_42_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_5.prefab_name].transform, "story_v_out_112342", "112342010", "story_v_out_112342.awb")

						arg_39_1:RecordAudio("112342010", var_42_10)
						arg_39_1:RecordAudio("112342010", var_42_10)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_112342", "112342010", "story_v_out_112342.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_112342", "112342010", "story_v_out_112342.awb")
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
			local var_46_0 = 0.95

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(112342011)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 38 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 38)

				if (38 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 38)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342011", "story_v_out_112342.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_112342", "112342011", "story_v_out_112342.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_112342", "112342011", "story_v_out_112342.awb")

						arg_43_1:RecordAudio("112342011", var_46_6)
						arg_43_1:RecordAudio("112342011", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_112342", "112342011", "story_v_out_112342.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_112342", "112342011", "story_v_out_112342.awb")
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
			local var_50_0 = 0.4

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(112342012)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 16 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 16)

				if (16 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 16)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342012", "story_v_out_112342.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_112342", "112342012", "story_v_out_112342.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_112342", "112342012", "story_v_out_112342.awb")

						arg_47_1:RecordAudio("112342012", var_50_6)
						arg_47_1:RecordAudio("112342012", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112342", "112342012", "story_v_out_112342.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112342", "112342012", "story_v_out_112342.awb")
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
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1027"]) then
				local var_54_0 = arg_51_1.actors_["1027"]:GetComponent("Image")

				if var_54_0 then
					arg_51_1.var_.highlightMatValue1027 = var_54_0
				end
			end

			local var_54_1 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 and not isNil(arg_51_1.actors_["1027"]) then
				if arg_51_1.var_.highlightMatValue1027 then
					local var_54_2 = Mathf.Lerp(1, 0.5, (arg_51_1.time_ - 0) / var_54_1)

					arg_51_1.var_.highlightMatValue1027.color.r = var_54_2
					arg_51_1.var_.highlightMatValue1027.color.g = var_54_2
					arg_51_1.var_.highlightMatValue1027.color.b = var_54_2
					arg_51_1.var_.highlightMatValue1027.color = arg_51_1.var_.highlightMatValue1027.color
				end
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 and not isNil(arg_51_1.actors_["1027"]) and arg_51_1.var_.highlightMatValue1027 then
				arg_51_1.var_.highlightMatValue1027.color.r = 0.5
				arg_51_1.var_.highlightMatValue1027.color.g = 0.5
				arg_51_1.var_.highlightMatValue1027.color.b = 0.5
				arg_51_1.var_.highlightMatValue1027.color = arg_51_1.var_.highlightMatValue1027.color
			end

			local var_54_3 = 0
			local var_54_4 = 0.95

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[36].name)

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

				local var_54_5 = arg_51_1:GetWordFromCfg(112342013)
				local var_54_6 = arg_51_1:FormatText(var_54_5.content)

				arg_51_1.text_.text = var_54_6

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_8 = 38 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_6) / 38)

				if (38 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_6) / 38)) > 0 and var_54_4 < var_54_8 then
					arg_51_1.talkMaxDuration = var_54_8

					if var_54_8 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_6
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342013", "story_v_out_112342.awb") ~= 0 then
					local var_54_9 = manager.audio:GetVoiceLength("story_v_out_112342", "112342013", "story_v_out_112342.awb") / 1000

					if var_54_9 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_3
					end

					if var_54_5.prefab_name ~= "" and arg_51_1.actors_[var_54_5.prefab_name] ~= nil then
						local var_54_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_5.prefab_name].transform, "story_v_out_112342", "112342013", "story_v_out_112342.awb")

						arg_51_1:RecordAudio("112342013", var_54_10)
						arg_51_1:RecordAudio("112342013", var_54_10)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_112342", "112342013", "story_v_out_112342.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_112342", "112342013", "story_v_out_112342.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_11 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_11 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_3) / var_54_11

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_3 + var_54_11 and arg_51_1.time_ < var_54_3 + var_54_11 + arg_54_0 then
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
			local var_58_0 = 1.05

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[36].name)

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

				local var_58_1 = arg_55_1:GetWordFromCfg(112342014)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 42 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 42)

				if (42 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 42)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342014", "story_v_out_112342.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_112342", "112342014", "story_v_out_112342.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_112342", "112342014", "story_v_out_112342.awb")

						arg_55_1:RecordAudio("112342014", var_58_6)
						arg_55_1:RecordAudio("112342014", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_112342", "112342014", "story_v_out_112342.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_112342", "112342014", "story_v_out_112342.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
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
			local var_62_0 = 0.925

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(112342015).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 37 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 37)

				if (37 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 37)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
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
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1027"]) then
				local var_66_0 = arg_63_1.actors_["1027"]:GetComponent("Image")

				if var_66_0 then
					arg_63_1.var_.highlightMatValue1027 = var_66_0
				end
			end

			local var_66_1 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 and not isNil(arg_63_1.actors_["1027"]) then
				if arg_63_1.var_.highlightMatValue1027 then
					local var_66_2 = Mathf.Lerp(0.5, 1, (arg_63_1.time_ - 0) / var_66_1)

					arg_63_1.var_.highlightMatValue1027.color.r = var_66_2
					arg_63_1.var_.highlightMatValue1027.color.g = var_66_2
					arg_63_1.var_.highlightMatValue1027.color.b = var_66_2
					arg_63_1.var_.highlightMatValue1027.color = arg_63_1.var_.highlightMatValue1027.color
				end
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 and not isNil(arg_63_1.actors_["1027"]) and arg_63_1.var_.highlightMatValue1027 then
				arg_63_1.actors_["1027"].transform:SetSiblingIndex(1)

				arg_63_1.var_.highlightMatValue1027.color.r = 1
				arg_63_1.var_.highlightMatValue1027.color.g = 1
				arg_63_1.var_.highlightMatValue1027.color.b = 1
				arg_63_1.var_.highlightMatValue1027.color = arg_63_1.var_.highlightMatValue1027.color
			end

			local var_66_3 = 0
			local var_66_4 = 0.375

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_3 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_5 = arg_63_1:GetWordFromCfg(112342016)
				local var_66_6 = arg_63_1:FormatText(var_66_5.content)

				arg_63_1.text_.text = var_66_6

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_8 = 15 <= 0 and var_66_4 or var_66_4 * (utf8.len(var_66_6) / 15)

				if (15 <= 0 and var_66_4 or var_66_4 * (utf8.len(var_66_6) / 15)) > 0 and var_66_4 < var_66_8 then
					arg_63_1.talkMaxDuration = var_66_8

					if var_66_8 + var_66_3 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_3
					end
				end

				arg_63_1.text_.text = var_66_6
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342016", "story_v_out_112342.awb") ~= 0 then
					local var_66_9 = manager.audio:GetVoiceLength("story_v_out_112342", "112342016", "story_v_out_112342.awb") / 1000

					if var_66_9 + var_66_3 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_3
					end

					if var_66_5.prefab_name ~= "" and arg_63_1.actors_[var_66_5.prefab_name] ~= nil then
						local var_66_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_5.prefab_name].transform, "story_v_out_112342", "112342016", "story_v_out_112342.awb")

						arg_63_1:RecordAudio("112342016", var_66_10)
						arg_63_1:RecordAudio("112342016", var_66_10)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112342", "112342016", "story_v_out_112342.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112342", "112342016", "story_v_out_112342.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_11 = math.max(var_66_4, arg_63_1.talkMaxDuration)

			if var_66_3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_3 + var_66_11 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_3) / var_66_11

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_3 + var_66_11 and arg_63_1.time_ < var_66_3 + var_66_11 + arg_66_0 then
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
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1027"]) then
				local var_70_0 = arg_67_1.actors_["1027"]:GetComponent("Image")

				if var_70_0 then
					arg_67_1.var_.highlightMatValue1027 = var_70_0
				end
			end

			local var_70_1 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 and not isNil(arg_67_1.actors_["1027"]) then
				if arg_67_1.var_.highlightMatValue1027 then
					local var_70_2 = Mathf.Lerp(1, 0.5, (arg_67_1.time_ - 0) / var_70_1)

					arg_67_1.var_.highlightMatValue1027.color.r = var_70_2
					arg_67_1.var_.highlightMatValue1027.color.g = var_70_2
					arg_67_1.var_.highlightMatValue1027.color.b = var_70_2
					arg_67_1.var_.highlightMatValue1027.color = arg_67_1.var_.highlightMatValue1027.color
				end
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 and not isNil(arg_67_1.actors_["1027"]) and arg_67_1.var_.highlightMatValue1027 then
				arg_67_1.var_.highlightMatValue1027.color.r = 0.5
				arg_67_1.var_.highlightMatValue1027.color.g = 0.5
				arg_67_1.var_.highlightMatValue1027.color.b = 0.5
				arg_67_1.var_.highlightMatValue1027.color = arg_67_1.var_.highlightMatValue1027.color
			end

			local var_70_3 = 0
			local var_70_4 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[36].name)

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

				local var_70_5 = arg_67_1:GetWordFromCfg(112342017)
				local var_70_6 = arg_67_1:FormatText(var_70_5.content)

				arg_67_1.text_.text = var_70_6

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_8 = 9 <= 0 and var_70_4 or var_70_4 * (utf8.len(var_70_6) / 9)

				if (9 <= 0 and var_70_4 or var_70_4 * (utf8.len(var_70_6) / 9)) > 0 and var_70_4 < var_70_8 then
					arg_67_1.talkMaxDuration = var_70_8

					if var_70_8 + var_70_3 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_3
					end
				end

				arg_67_1.text_.text = var_70_6
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342017", "story_v_out_112342.awb") ~= 0 then
					local var_70_9 = manager.audio:GetVoiceLength("story_v_out_112342", "112342017", "story_v_out_112342.awb") / 1000

					if var_70_9 + var_70_3 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_3
					end

					if var_70_5.prefab_name ~= "" and arg_67_1.actors_[var_70_5.prefab_name] ~= nil then
						local var_70_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_5.prefab_name].transform, "story_v_out_112342", "112342017", "story_v_out_112342.awb")

						arg_67_1:RecordAudio("112342017", var_70_10)
						arg_67_1:RecordAudio("112342017", var_70_10)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112342", "112342017", "story_v_out_112342.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112342", "112342017", "story_v_out_112342.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_11 = math.max(var_70_4, arg_67_1.talkMaxDuration)

			if var_70_3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_3 + var_70_11 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_3) / var_70_11

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_3 + var_70_11 and arg_67_1.time_ < var_70_3 + var_70_11 + arg_70_0 then
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
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1027"]) then
				local var_74_0 = arg_71_1.actors_["1027"]:GetComponent("Image")

				if var_74_0 then
					arg_71_1.var_.highlightMatValue1027 = var_74_0
				end
			end

			local var_74_1 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 and not isNil(arg_71_1.actors_["1027"]) then
				if arg_71_1.var_.highlightMatValue1027 then
					local var_74_2 = Mathf.Lerp(0.5, 1, (arg_71_1.time_ - 0) / var_74_1)

					arg_71_1.var_.highlightMatValue1027.color.r = var_74_2
					arg_71_1.var_.highlightMatValue1027.color.g = var_74_2
					arg_71_1.var_.highlightMatValue1027.color.b = var_74_2
					arg_71_1.var_.highlightMatValue1027.color = arg_71_1.var_.highlightMatValue1027.color
				end
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 and not isNil(arg_71_1.actors_["1027"]) and arg_71_1.var_.highlightMatValue1027 then
				arg_71_1.actors_["1027"].transform:SetSiblingIndex(1)

				arg_71_1.var_.highlightMatValue1027.color.r = 1
				arg_71_1.var_.highlightMatValue1027.color.g = 1
				arg_71_1.var_.highlightMatValue1027.color.b = 1
				arg_71_1.var_.highlightMatValue1027.color = arg_71_1.var_.highlightMatValue1027.color
			end

			local var_74_3 = 0
			local var_74_4 = 0.55

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_5 = arg_71_1:GetWordFromCfg(112342018)
				local var_74_6 = arg_71_1:FormatText(var_74_5.content)

				arg_71_1.text_.text = var_74_6

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_8 = 22 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 22)

				if (22 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 22)) > 0 and var_74_4 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8

					if var_74_8 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_6
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112342", "112342018", "story_v_out_112342.awb") ~= 0 then
					local var_74_9 = manager.audio:GetVoiceLength("story_v_out_112342", "112342018", "story_v_out_112342.awb") / 1000

					if var_74_9 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_3
					end

					if var_74_5.prefab_name ~= "" and arg_71_1.actors_[var_74_5.prefab_name] ~= nil then
						local var_74_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_5.prefab_name].transform, "story_v_out_112342", "112342018", "story_v_out_112342.awb")

						arg_71_1:RecordAudio("112342018", var_74_10)
						arg_71_1:RecordAudio("112342018", var_74_10)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_112342", "112342018", "story_v_out_112342.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_112342", "112342018", "story_v_out_112342.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_3) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_3 + var_74_11 and arg_71_1.time_ < var_74_3 + var_74_11 + arg_74_0 then
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
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1027"]) then
				local var_78_0 = arg_75_1.actors_["1027"]:GetComponent("Image")

				if var_78_0 then
					arg_75_1.var_.highlightMatValue1027 = var_78_0
				end
			end

			local var_78_1 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 and not isNil(arg_75_1.actors_["1027"]) then
				if arg_75_1.var_.highlightMatValue1027 then
					local var_78_2 = Mathf.Lerp(1, 0.5, (arg_75_1.time_ - 0) / var_78_1)

					arg_75_1.var_.highlightMatValue1027.color.r = var_78_2
					arg_75_1.var_.highlightMatValue1027.color.g = var_78_2
					arg_75_1.var_.highlightMatValue1027.color.b = var_78_2
					arg_75_1.var_.highlightMatValue1027.color = arg_75_1.var_.highlightMatValue1027.color
				end
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 and not isNil(arg_75_1.actors_["1027"]) and arg_75_1.var_.highlightMatValue1027 then
				arg_75_1.var_.highlightMatValue1027.color.r = 0.5
				arg_75_1.var_.highlightMatValue1027.color.g = 0.5
				arg_75_1.var_.highlightMatValue1027.color.b = 0.5
				arg_75_1.var_.highlightMatValue1027.color = arg_75_1.var_.highlightMatValue1027.color
			end

			local var_78_3 = 0
			local var_78_4 = 0.775

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(112342019).content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 31 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_5) / 31)

				if (31 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_5) / 31)) > 0 and var_78_4 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_3
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_4, arg_75_1.talkMaxDuration)

			if var_78_3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_3 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_3) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_3 + var_78_8 and arg_75_1.time_ < var_78_3 + var_78_8 + arg_78_0 then
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
