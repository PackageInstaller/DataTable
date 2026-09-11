return {
	Play112332001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112332001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112332002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.65

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

				local var_4_3 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112332001).content)

				arg_1_1.text_.text = var_4_3

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_5 = 26 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 26)

				if (26 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 26)) > 0 and var_4_1 < var_4_5 then
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
	Play112332002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112332002
		arg_7_1.duration_ = 5.8

		local var_7_0 = {
			ja = 4.9,
			ko = 5.433,
			zh = 5.366,
			en = 5.8
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
				arg_7_0:Play112332003(arg_7_1)
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
				var_10_2.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1039, Vector3.New(0, -450, 220), (arg_7_1.time_ - 0) / var_10_3)
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 then
				var_10_2.localPosition = Vector3.New(0, -450, 220)
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
			local var_10_9 = 0.65

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

				local var_10_10 = arg_7_1:GetWordFromCfg(112332002)
				local var_10_11 = arg_7_1:FormatText(var_10_10.content)

				arg_7_1.text_.text = var_10_11

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_13 = 26 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 26)

				if (26 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 26)) > 0 and var_10_9 < var_10_13 then
					arg_7_1.talkMaxDuration = var_10_13

					if var_10_13 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_13 + var_10_8
					end
				end

				arg_7_1.text_.text = var_10_11
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332002", "story_v_out_112332.awb") ~= 0 then
					local var_10_14 = manager.audio:GetVoiceLength("story_v_out_112332", "112332002", "story_v_out_112332.awb") / 1000

					if var_10_14 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_14 + var_10_8
					end

					if var_10_10.prefab_name ~= "" and arg_7_1.actors_[var_10_10.prefab_name] ~= nil then
						local var_10_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_10.prefab_name].transform, "story_v_out_112332", "112332002", "story_v_out_112332.awb")

						arg_7_1:RecordAudio("112332002", var_10_15)
						arg_7_1:RecordAudio("112332002", var_10_15)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112332", "112332002", "story_v_out_112332.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112332", "112332002", "story_v_out_112332.awb")
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
	Play112332003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112332003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play112332004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["1039"]) then
				local var_14_0 = arg_11_1.actors_["1039"]:GetComponent("Image")

				if var_14_0 then
					arg_11_1.var_.highlightMatValue1039 = var_14_0
				end
			end

			local var_14_1 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_1 and not isNil(arg_11_1.actors_["1039"]) then
				if arg_11_1.var_.highlightMatValue1039 then
					local var_14_2 = Mathf.Lerp(1, 0.5, (arg_11_1.time_ - 0) / var_14_1)

					arg_11_1.var_.highlightMatValue1039.color.r = var_14_2
					arg_11_1.var_.highlightMatValue1039.color.g = var_14_2
					arg_11_1.var_.highlightMatValue1039.color.b = var_14_2
					arg_11_1.var_.highlightMatValue1039.color = arg_11_1.var_.highlightMatValue1039.color
				end
			end

			if arg_11_1.time_ >= 0 + var_14_1 and arg_11_1.time_ < 0 + var_14_1 + arg_14_0 and not isNil(arg_11_1.actors_["1039"]) and arg_11_1.var_.highlightMatValue1039 then
				arg_11_1.var_.highlightMatValue1039.color.r = 0.5
				arg_11_1.var_.highlightMatValue1039.color.g = 0.5
				arg_11_1.var_.highlightMatValue1039.color.b = 0.5
				arg_11_1.var_.highlightMatValue1039.color = arg_11_1.var_.highlightMatValue1039.color
			end

			local var_14_3 = 0
			local var_14_4 = 0.35

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_3 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_5 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(112332003).content)

				arg_11_1.text_.text = var_14_5

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_7 = 14 <= 0 and var_14_4 or var_14_4 * (utf8.len(var_14_5) / 14)

				if (14 <= 0 and var_14_4 or var_14_4 * (utf8.len(var_14_5) / 14)) > 0 and var_14_4 < var_14_7 then
					arg_11_1.talkMaxDuration = var_14_7

					if var_14_7 + var_14_3 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_7 + var_14_3
					end
				end

				arg_11_1.text_.text = var_14_5
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_8 = math.max(var_14_4, arg_11_1.talkMaxDuration)

			if var_14_3 <= arg_11_1.time_ and arg_11_1.time_ < var_14_3 + var_14_8 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_3) / var_14_8

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_3 + var_14_8 and arg_11_1.time_ < var_14_3 + var_14_8 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play112332004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 112332004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play112332005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.4

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(112332004).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 16 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 16)

				if (16 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 16)) > 0 and var_18_0 < var_18_3 then
					arg_15_1.talkMaxDuration = var_18_3

					if var_18_3 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_3 + 0
					end
				end

				arg_15_1.text_.text = var_18_1
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_4 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_4

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play112332005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112332005
		arg_19_1.duration_ = 8.3

		local var_19_0 = {
			ja = 8.3,
			ko = 6.3,
			zh = 6,
			en = 7.166
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
				arg_19_0:Play112332006(arg_19_1)
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
					local var_22_2 = Mathf.Lerp(0.5, 1, (arg_19_1.time_ - 0) / var_22_1)

					arg_19_1.var_.highlightMatValue1039.color.r = var_22_2
					arg_19_1.var_.highlightMatValue1039.color.g = var_22_2
					arg_19_1.var_.highlightMatValue1039.color.b = var_22_2
					arg_19_1.var_.highlightMatValue1039.color = arg_19_1.var_.highlightMatValue1039.color
				end
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 and not isNil(arg_19_1.actors_["1039"]) and arg_19_1.var_.highlightMatValue1039 then
				arg_19_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_19_1.var_.highlightMatValue1039.color.r = 1
				arg_19_1.var_.highlightMatValue1039.color.g = 1
				arg_19_1.var_.highlightMatValue1039.color.b = 1
				arg_19_1.var_.highlightMatValue1039.color = arg_19_1.var_.highlightMatValue1039.color
			end

			local var_22_3 = 0
			local var_22_4 = 0.675

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_5 = arg_19_1:GetWordFromCfg(112332005)
				local var_22_6 = arg_19_1:FormatText(var_22_5.content)

				arg_19_1.text_.text = var_22_6

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_8 = 27 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_6) / 27)

				if (27 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_6) / 27)) > 0 and var_22_4 < var_22_8 then
					arg_19_1.talkMaxDuration = var_22_8

					if var_22_8 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_3
					end
				end

				arg_19_1.text_.text = var_22_6
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332005", "story_v_out_112332.awb") ~= 0 then
					local var_22_9 = manager.audio:GetVoiceLength("story_v_out_112332", "112332005", "story_v_out_112332.awb") / 1000

					if var_22_9 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_3
					end

					if var_22_5.prefab_name ~= "" and arg_19_1.actors_[var_22_5.prefab_name] ~= nil then
						local var_22_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_5.prefab_name].transform, "story_v_out_112332", "112332005", "story_v_out_112332.awb")

						arg_19_1:RecordAudio("112332005", var_22_10)
						arg_19_1:RecordAudio("112332005", var_22_10)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_112332", "112332005", "story_v_out_112332.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_112332", "112332005", "story_v_out_112332.awb")
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
	Play112332006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112332006
		arg_23_1.duration_ = 8.1

		local var_23_0 = {
			ja = 4.833,
			ko = 7.3,
			zh = 8.1,
			en = 7.8
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
				arg_23_0:Play112332007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.9

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:GetWordFromCfg(112332006)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 36 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 36)

				if (36 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 36)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332006", "story_v_out_112332.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_112332", "112332006", "story_v_out_112332.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_112332", "112332006", "story_v_out_112332.awb")

						arg_23_1:RecordAudio("112332006", var_26_6)
						arg_23_1:RecordAudio("112332006", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_112332", "112332006", "story_v_out_112332.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_112332", "112332006", "story_v_out_112332.awb")
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
	Play112332007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112332007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play112332008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1039"]) then
				local var_30_0 = arg_27_1.actors_["1039"]:GetComponent("Image")

				if var_30_0 then
					arg_27_1.var_.highlightMatValue1039 = var_30_0
				end
			end

			local var_30_1 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 and not isNil(arg_27_1.actors_["1039"]) then
				if arg_27_1.var_.highlightMatValue1039 then
					local var_30_2 = Mathf.Lerp(1, 0.5, (arg_27_1.time_ - 0) / var_30_1)

					arg_27_1.var_.highlightMatValue1039.color.r = var_30_2
					arg_27_1.var_.highlightMatValue1039.color.g = var_30_2
					arg_27_1.var_.highlightMatValue1039.color.b = var_30_2
					arg_27_1.var_.highlightMatValue1039.color = arg_27_1.var_.highlightMatValue1039.color
				end
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 and not isNil(arg_27_1.actors_["1039"]) and arg_27_1.var_.highlightMatValue1039 then
				arg_27_1.var_.highlightMatValue1039.color.r = 0.5
				arg_27_1.var_.highlightMatValue1039.color.g = 0.5
				arg_27_1.var_.highlightMatValue1039.color.b = 0.5
				arg_27_1.var_.highlightMatValue1039.color = arg_27_1.var_.highlightMatValue1039.color
			end

			local var_30_3 = 0
			local var_30_4 = 0.125

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_3 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_5 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(112332007).content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 5 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_5) / 5)

				if (5 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_5) / 5)) > 0 and var_30_4 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_3 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_3
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_4, arg_27_1.talkMaxDuration)

			if var_30_3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_3 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_3) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_3 + var_30_8 and arg_27_1.time_ < var_30_3 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play112332008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 112332008
		arg_31_1.duration_ = 11.43

		local var_31_0 = {
			ja = 7.666,
			ko = 8.7,
			zh = 7.6,
			en = 11.433
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
				arg_31_0:Play112332009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1039"]) then
				local var_34_0 = arg_31_1.actors_["1039"]:GetComponent("Image")

				if var_34_0 then
					arg_31_1.var_.highlightMatValue1039 = var_34_0
				end
			end

			local var_34_1 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 and not isNil(arg_31_1.actors_["1039"]) then
				if arg_31_1.var_.highlightMatValue1039 then
					local var_34_2 = Mathf.Lerp(0.5, 1, (arg_31_1.time_ - 0) / var_34_1)

					arg_31_1.var_.highlightMatValue1039.color.r = var_34_2
					arg_31_1.var_.highlightMatValue1039.color.g = var_34_2
					arg_31_1.var_.highlightMatValue1039.color.b = var_34_2
					arg_31_1.var_.highlightMatValue1039.color = arg_31_1.var_.highlightMatValue1039.color
				end
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 and not isNil(arg_31_1.actors_["1039"]) and arg_31_1.var_.highlightMatValue1039 then
				arg_31_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_31_1.var_.highlightMatValue1039.color.r = 1
				arg_31_1.var_.highlightMatValue1039.color.g = 1
				arg_31_1.var_.highlightMatValue1039.color.b = 1
				arg_31_1.var_.highlightMatValue1039.color = arg_31_1.var_.highlightMatValue1039.color
			end

			local var_34_3 = 0
			local var_34_4 = 0.95

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:GetWordFromCfg(112332008)
				local var_34_6 = arg_31_1:FormatText(var_34_5.content)

				arg_31_1.text_.text = var_34_6

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_8 = 38 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_6) / 38)

				if (38 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_6) / 38)) > 0 and var_34_4 < var_34_8 then
					arg_31_1.talkMaxDuration = var_34_8

					if var_34_8 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_6
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332008", "story_v_out_112332.awb") ~= 0 then
					local var_34_9 = manager.audio:GetVoiceLength("story_v_out_112332", "112332008", "story_v_out_112332.awb") / 1000

					if var_34_9 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_3
					end

					if var_34_5.prefab_name ~= "" and arg_31_1.actors_[var_34_5.prefab_name] ~= nil then
						local var_34_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_5.prefab_name].transform, "story_v_out_112332", "112332008", "story_v_out_112332.awb")

						arg_31_1:RecordAudio("112332008", var_34_10)
						arg_31_1:RecordAudio("112332008", var_34_10)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112332", "112332008", "story_v_out_112332.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112332", "112332008", "story_v_out_112332.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_11 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_11 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_11

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_11 and arg_31_1.time_ < var_34_3 + var_34_11 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play112332009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 112332009
		arg_35_1.duration_ = 17.07

		local var_35_0 = {
			ja = 17.066,
			ko = 11,
			zh = 9.4,
			en = 15.633
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play112332010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.025

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(112332009)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 41 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 41)

				if (41 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 41)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332009", "story_v_out_112332.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_112332", "112332009", "story_v_out_112332.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_112332", "112332009", "story_v_out_112332.awb")

						arg_35_1:RecordAudio("112332009", var_38_6)
						arg_35_1:RecordAudio("112332009", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_112332", "112332009", "story_v_out_112332.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_112332", "112332009", "story_v_out_112332.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play112332010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 112332010
		arg_39_1.duration_ = 14.1

		local var_39_0 = {
			ja = 14.1,
			ko = 7.466,
			zh = 6.5,
			en = 9.733
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
				arg_39_0:Play112332011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.75

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:GetWordFromCfg(112332010)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 30 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 30)

				if (30 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 30)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332010", "story_v_out_112332.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_112332", "112332010", "story_v_out_112332.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_112332", "112332010", "story_v_out_112332.awb")

						arg_39_1:RecordAudio("112332010", var_42_6)
						arg_39_1:RecordAudio("112332010", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_112332", "112332010", "story_v_out_112332.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_112332", "112332010", "story_v_out_112332.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play112332011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112332011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play112332012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1039"]) then
				local var_46_0 = arg_43_1.actors_["1039"]:GetComponent("Image")

				if var_46_0 then
					arg_43_1.var_.highlightMatValue1039 = var_46_0
				end
			end

			local var_46_1 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 and not isNil(arg_43_1.actors_["1039"]) then
				if arg_43_1.var_.highlightMatValue1039 then
					local var_46_2 = Mathf.Lerp(1, 0.5, (arg_43_1.time_ - 0) / var_46_1)

					arg_43_1.var_.highlightMatValue1039.color.r = var_46_2
					arg_43_1.var_.highlightMatValue1039.color.g = var_46_2
					arg_43_1.var_.highlightMatValue1039.color.b = var_46_2
					arg_43_1.var_.highlightMatValue1039.color = arg_43_1.var_.highlightMatValue1039.color
				end
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 and not isNil(arg_43_1.actors_["1039"]) and arg_43_1.var_.highlightMatValue1039 then
				arg_43_1.var_.highlightMatValue1039.color.r = 0.5
				arg_43_1.var_.highlightMatValue1039.color.g = 0.5
				arg_43_1.var_.highlightMatValue1039.color.b = 0.5
				arg_43_1.var_.highlightMatValue1039.color = arg_43_1.var_.highlightMatValue1039.color
			end

			local var_46_3 = 0
			local var_46_4 = 0.2

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_3 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_5 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(112332011).content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 8 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_5) / 8)

				if (8 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_5) / 8)) > 0 and var_46_4 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_3 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_3
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_4, arg_43_1.talkMaxDuration)

			if var_46_3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_3 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_3) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_3 + var_46_8 and arg_43_1.time_ < var_46_3 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play112332012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112332012
		arg_47_1.duration_ = 14.53

		local var_47_0 = {
			ja = 13.633,
			ko = 9.2,
			zh = 10.433,
			en = 14.533
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
				arg_47_0:Play112332013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1039"]) then
				local var_50_0 = arg_47_1.actors_["1039"]:GetComponent("Image")

				if var_50_0 then
					arg_47_1.var_.highlightMatValue1039 = var_50_0
				end
			end

			local var_50_1 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 and not isNil(arg_47_1.actors_["1039"]) then
				if arg_47_1.var_.highlightMatValue1039 then
					local var_50_2 = Mathf.Lerp(0.5, 1, (arg_47_1.time_ - 0) / var_50_1)

					arg_47_1.var_.highlightMatValue1039.color.r = var_50_2
					arg_47_1.var_.highlightMatValue1039.color.g = var_50_2
					arg_47_1.var_.highlightMatValue1039.color.b = var_50_2
					arg_47_1.var_.highlightMatValue1039.color = arg_47_1.var_.highlightMatValue1039.color
				end
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 and not isNil(arg_47_1.actors_["1039"]) and arg_47_1.var_.highlightMatValue1039 then
				arg_47_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_47_1.var_.highlightMatValue1039.color.r = 1
				arg_47_1.var_.highlightMatValue1039.color.g = 1
				arg_47_1.var_.highlightMatValue1039.color.b = 1
				arg_47_1.var_.highlightMatValue1039.color = arg_47_1.var_.highlightMatValue1039.color
			end

			local var_50_3 = 0
			local var_50_4 = 1.025

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_3 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_5 = arg_47_1:GetWordFromCfg(112332012)
				local var_50_6 = arg_47_1:FormatText(var_50_5.content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 41 <= 0 and var_50_4 or var_50_4 * (utf8.len(var_50_6) / 41)

				if (41 <= 0 and var_50_4 or var_50_4 * (utf8.len(var_50_6) / 41)) > 0 and var_50_4 < var_50_8 then
					arg_47_1.talkMaxDuration = var_50_8

					if var_50_8 + var_50_3 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_3
					end
				end

				arg_47_1.text_.text = var_50_6
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332012", "story_v_out_112332.awb") ~= 0 then
					local var_50_9 = manager.audio:GetVoiceLength("story_v_out_112332", "112332012", "story_v_out_112332.awb") / 1000

					if var_50_9 + var_50_3 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_3
					end

					if var_50_5.prefab_name ~= "" and arg_47_1.actors_[var_50_5.prefab_name] ~= nil then
						local var_50_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_5.prefab_name].transform, "story_v_out_112332", "112332012", "story_v_out_112332.awb")

						arg_47_1:RecordAudio("112332012", var_50_10)
						arg_47_1:RecordAudio("112332012", var_50_10)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112332", "112332012", "story_v_out_112332.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112332", "112332012", "story_v_out_112332.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_11 = math.max(var_50_4, arg_47_1.talkMaxDuration)

			if var_50_3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_3 + var_50_11 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_3) / var_50_11

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_3 + var_50_11 and arg_47_1.time_ < var_50_3 + var_50_11 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play112332013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112332013
		arg_51_1.duration_ = 9.93

		local var_51_0 = {
			ja = 6.766,
			ko = 7.9,
			zh = 8.066,
			en = 9.933
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
				arg_51_0:Play112332014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.975

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(112332013)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 39 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 39)

				if (39 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 39)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332013", "story_v_out_112332.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_112332", "112332013", "story_v_out_112332.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_112332", "112332013", "story_v_out_112332.awb")

						arg_51_1:RecordAudio("112332013", var_54_6)
						arg_51_1:RecordAudio("112332013", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_112332", "112332013", "story_v_out_112332.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_112332", "112332013", "story_v_out_112332.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play112332014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112332014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play112332015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1039"]) then
				local var_58_0 = arg_55_1.actors_["1039"]:GetComponent("Image")

				if var_58_0 then
					arg_55_1.var_.highlightMatValue1039 = var_58_0
				end
			end

			local var_58_1 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 and not isNil(arg_55_1.actors_["1039"]) then
				if arg_55_1.var_.highlightMatValue1039 then
					local var_58_2 = Mathf.Lerp(1, 0.5, (arg_55_1.time_ - 0) / var_58_1)

					arg_55_1.var_.highlightMatValue1039.color.r = var_58_2
					arg_55_1.var_.highlightMatValue1039.color.g = var_58_2
					arg_55_1.var_.highlightMatValue1039.color.b = var_58_2
					arg_55_1.var_.highlightMatValue1039.color = arg_55_1.var_.highlightMatValue1039.color
				end
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 and not isNil(arg_55_1.actors_["1039"]) and arg_55_1.var_.highlightMatValue1039 then
				arg_55_1.var_.highlightMatValue1039.color.r = 0.5
				arg_55_1.var_.highlightMatValue1039.color.g = 0.5
				arg_55_1.var_.highlightMatValue1039.color.b = 0.5
				arg_55_1.var_.highlightMatValue1039.color = arg_55_1.var_.highlightMatValue1039.color
			end

			local var_58_3 = 0
			local var_58_4 = 0.375

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_5 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(112332014).content)

				arg_55_1.text_.text = var_58_5

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_7 = 15 <= 0 and var_58_4 or var_58_4 * (utf8.len(var_58_5) / 15)

				if (15 <= 0 and var_58_4 or var_58_4 * (utf8.len(var_58_5) / 15)) > 0 and var_58_4 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_3 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_3
					end
				end

				arg_55_1.text_.text = var_58_5
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_4, arg_55_1.talkMaxDuration)

			if var_58_3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_3 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_3) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_3 + var_58_8 and arg_55_1.time_ < var_58_3 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play112332015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112332015
		arg_59_1.duration_ = 9.3

		local var_59_0 = {
			ja = 6.9,
			ko = 5.7,
			zh = 5.266,
			en = 9.3
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
				arg_59_0:Play112332016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1039"]) then
				local var_62_0 = arg_59_1.actors_["1039"]:GetComponent("Image")

				if var_62_0 then
					arg_59_1.var_.highlightMatValue1039 = var_62_0
				end
			end

			local var_62_1 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 and not isNil(arg_59_1.actors_["1039"]) then
				if arg_59_1.var_.highlightMatValue1039 then
					local var_62_2 = Mathf.Lerp(0.5, 1, (arg_59_1.time_ - 0) / var_62_1)

					arg_59_1.var_.highlightMatValue1039.color.r = var_62_2
					arg_59_1.var_.highlightMatValue1039.color.g = var_62_2
					arg_59_1.var_.highlightMatValue1039.color.b = var_62_2
					arg_59_1.var_.highlightMatValue1039.color = arg_59_1.var_.highlightMatValue1039.color
				end
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 and not isNil(arg_59_1.actors_["1039"]) and arg_59_1.var_.highlightMatValue1039 then
				arg_59_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_59_1.var_.highlightMatValue1039.color.r = 1
				arg_59_1.var_.highlightMatValue1039.color.g = 1
				arg_59_1.var_.highlightMatValue1039.color.b = 1
				arg_59_1.var_.highlightMatValue1039.color = arg_59_1.var_.highlightMatValue1039.color
			end

			local var_62_3 = 0
			local var_62_4 = 0.6

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_5 = arg_59_1:GetWordFromCfg(112332015)
				local var_62_6 = arg_59_1:FormatText(var_62_5.content)

				arg_59_1.text_.text = var_62_6

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_8 = 24 <= 0 and var_62_4 or var_62_4 * (utf8.len(var_62_6) / 24)

				if (24 <= 0 and var_62_4 or var_62_4 * (utf8.len(var_62_6) / 24)) > 0 and var_62_4 < var_62_8 then
					arg_59_1.talkMaxDuration = var_62_8

					if var_62_8 + var_62_3 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_3
					end
				end

				arg_59_1.text_.text = var_62_6
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332015", "story_v_out_112332.awb") ~= 0 then
					local var_62_9 = manager.audio:GetVoiceLength("story_v_out_112332", "112332015", "story_v_out_112332.awb") / 1000

					if var_62_9 + var_62_3 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_3
					end

					if var_62_5.prefab_name ~= "" and arg_59_1.actors_[var_62_5.prefab_name] ~= nil then
						local var_62_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_5.prefab_name].transform, "story_v_out_112332", "112332015", "story_v_out_112332.awb")

						arg_59_1:RecordAudio("112332015", var_62_10)
						arg_59_1:RecordAudio("112332015", var_62_10)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112332", "112332015", "story_v_out_112332.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112332", "112332015", "story_v_out_112332.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_11 = math.max(var_62_4, arg_59_1.talkMaxDuration)

			if var_62_3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_3 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_3) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_3 + var_62_11 and arg_59_1.time_ < var_62_3 + var_62_11 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play112332016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112332016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play112332017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1039"]) then
				local var_66_0 = arg_63_1.actors_["1039"]:GetComponent("Image")

				if var_66_0 then
					arg_63_1.var_.highlightMatValue1039 = var_66_0
				end
			end

			local var_66_1 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 and not isNil(arg_63_1.actors_["1039"]) then
				if arg_63_1.var_.highlightMatValue1039 then
					local var_66_2 = Mathf.Lerp(1, 0.5, (arg_63_1.time_ - 0) / var_66_1)

					arg_63_1.var_.highlightMatValue1039.color.r = var_66_2
					arg_63_1.var_.highlightMatValue1039.color.g = var_66_2
					arg_63_1.var_.highlightMatValue1039.color.b = var_66_2
					arg_63_1.var_.highlightMatValue1039.color = arg_63_1.var_.highlightMatValue1039.color
				end
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 and not isNil(arg_63_1.actors_["1039"]) and arg_63_1.var_.highlightMatValue1039 then
				arg_63_1.var_.highlightMatValue1039.color.r = 0.5
				arg_63_1.var_.highlightMatValue1039.color.g = 0.5
				arg_63_1.var_.highlightMatValue1039.color.b = 0.5
				arg_63_1.var_.highlightMatValue1039.color = arg_63_1.var_.highlightMatValue1039.color
			end

			local var_66_3 = 0
			local var_66_4 = 0.4

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_3 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_5 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(112332016).content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 16 <= 0 and var_66_4 or var_66_4 * (utf8.len(var_66_5) / 16)

				if (16 <= 0 and var_66_4 or var_66_4 * (utf8.len(var_66_5) / 16)) > 0 and var_66_4 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_3 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_3
					end
				end

				arg_63_1.text_.text = var_66_5
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_8 = math.max(var_66_4, arg_63_1.talkMaxDuration)

			if var_66_3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_3 + var_66_8 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_3) / var_66_8

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_3 + var_66_8 and arg_63_1.time_ < var_66_3 + var_66_8 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play112332017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112332017
		arg_67_1.duration_ = 8.2

		local var_67_0 = {
			ja = 6.866,
			ko = 8.2,
			zh = 6.6,
			en = 7.6
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
				arg_67_0:Play112332018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1039"]) then
				local var_70_0 = arg_67_1.actors_["1039"]:GetComponent("Image")

				if var_70_0 then
					arg_67_1.var_.highlightMatValue1039 = var_70_0
				end
			end

			local var_70_1 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 and not isNil(arg_67_1.actors_["1039"]) then
				if arg_67_1.var_.highlightMatValue1039 then
					local var_70_2 = Mathf.Lerp(0.5, 1, (arg_67_1.time_ - 0) / var_70_1)

					arg_67_1.var_.highlightMatValue1039.color.r = var_70_2
					arg_67_1.var_.highlightMatValue1039.color.g = var_70_2
					arg_67_1.var_.highlightMatValue1039.color.b = var_70_2
					arg_67_1.var_.highlightMatValue1039.color = arg_67_1.var_.highlightMatValue1039.color
				end
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 and not isNil(arg_67_1.actors_["1039"]) and arg_67_1.var_.highlightMatValue1039 then
				arg_67_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_67_1.var_.highlightMatValue1039.color.r = 1
				arg_67_1.var_.highlightMatValue1039.color.g = 1
				arg_67_1.var_.highlightMatValue1039.color.b = 1
				arg_67_1.var_.highlightMatValue1039.color = arg_67_1.var_.highlightMatValue1039.color
			end

			local var_70_3 = 0
			local var_70_4 = 0.675

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_5 = arg_67_1:GetWordFromCfg(112332017)
				local var_70_6 = arg_67_1:FormatText(var_70_5.content)

				arg_67_1.text_.text = var_70_6

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_8 = 27 <= 0 and var_70_4 or var_70_4 * (utf8.len(var_70_6) / 27)

				if (27 <= 0 and var_70_4 or var_70_4 * (utf8.len(var_70_6) / 27)) > 0 and var_70_4 < var_70_8 then
					arg_67_1.talkMaxDuration = var_70_8

					if var_70_8 + var_70_3 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_3
					end
				end

				arg_67_1.text_.text = var_70_6
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332017", "story_v_out_112332.awb") ~= 0 then
					local var_70_9 = manager.audio:GetVoiceLength("story_v_out_112332", "112332017", "story_v_out_112332.awb") / 1000

					if var_70_9 + var_70_3 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_3
					end

					if var_70_5.prefab_name ~= "" and arg_67_1.actors_[var_70_5.prefab_name] ~= nil then
						local var_70_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_5.prefab_name].transform, "story_v_out_112332", "112332017", "story_v_out_112332.awb")

						arg_67_1:RecordAudio("112332017", var_70_10)
						arg_67_1:RecordAudio("112332017", var_70_10)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112332", "112332017", "story_v_out_112332.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112332", "112332017", "story_v_out_112332.awb")
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
	Play112332018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112332018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play112332019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1039"]) then
				local var_74_0 = arg_71_1.actors_["1039"]:GetComponent("Image")

				if var_74_0 then
					arg_71_1.var_.highlightMatValue1039 = var_74_0
				end
			end

			local var_74_1 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 and not isNil(arg_71_1.actors_["1039"]) then
				if arg_71_1.var_.highlightMatValue1039 then
					local var_74_2 = Mathf.Lerp(1, 0.5, (arg_71_1.time_ - 0) / var_74_1)

					arg_71_1.var_.highlightMatValue1039.color.r = var_74_2
					arg_71_1.var_.highlightMatValue1039.color.g = var_74_2
					arg_71_1.var_.highlightMatValue1039.color.b = var_74_2
					arg_71_1.var_.highlightMatValue1039.color = arg_71_1.var_.highlightMatValue1039.color
				end
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 and not isNil(arg_71_1.actors_["1039"]) and arg_71_1.var_.highlightMatValue1039 then
				arg_71_1.var_.highlightMatValue1039.color.r = 0.5
				arg_71_1.var_.highlightMatValue1039.color.g = 0.5
				arg_71_1.var_.highlightMatValue1039.color.b = 0.5
				arg_71_1.var_.highlightMatValue1039.color = arg_71_1.var_.highlightMatValue1039.color
			end

			local var_74_3 = 0
			local var_74_4 = 0.25

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_5 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(112332018).content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 10 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 10)

				if (10 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 10)) > 0 and var_74_4 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_8 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_8 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_3) / var_74_8

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_3 + var_74_8 and arg_71_1.time_ < var_74_3 + var_74_8 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play112332019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 112332019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play112332020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.15

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(112332019).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 46 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 46)

				if (46 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 46)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play112332020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 112332020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play112332021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.4

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(112332020).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 16 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 16)

				if (16 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 16)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play112332021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 112332021
		arg_83_1.duration_ = 1.93

		local var_83_0 = {
			ja = 1.933,
			ko = 1.133,
			zh = 1.133,
			en = 0.999999999999
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
				arg_83_0:Play112332022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1039"]) then
				local var_86_0 = arg_83_1.actors_["1039"]:GetComponent("Image")

				if var_86_0 then
					arg_83_1.var_.highlightMatValue1039 = var_86_0
				end
			end

			local var_86_1 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 and not isNil(arg_83_1.actors_["1039"]) then
				if arg_83_1.var_.highlightMatValue1039 then
					local var_86_2 = Mathf.Lerp(0.5, 1, (arg_83_1.time_ - 0) / var_86_1)

					arg_83_1.var_.highlightMatValue1039.color.r = var_86_2
					arg_83_1.var_.highlightMatValue1039.color.g = var_86_2
					arg_83_1.var_.highlightMatValue1039.color.b = var_86_2
					arg_83_1.var_.highlightMatValue1039.color = arg_83_1.var_.highlightMatValue1039.color
				end
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 and not isNil(arg_83_1.actors_["1039"]) and arg_83_1.var_.highlightMatValue1039 then
				arg_83_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_83_1.var_.highlightMatValue1039.color.r = 1
				arg_83_1.var_.highlightMatValue1039.color.g = 1
				arg_83_1.var_.highlightMatValue1039.color.b = 1
				arg_83_1.var_.highlightMatValue1039.color = arg_83_1.var_.highlightMatValue1039.color
			end

			local var_86_3 = 0
			local var_86_4 = 0.05

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_5 = arg_83_1:GetWordFromCfg(112332021)
				local var_86_6 = arg_83_1:FormatText(var_86_5.content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 2 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_6) / 2)

				if (2 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_6) / 2)) > 0 and var_86_4 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_3
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332021", "story_v_out_112332.awb") ~= 0 then
					local var_86_9 = manager.audio:GetVoiceLength("story_v_out_112332", "112332021", "story_v_out_112332.awb") / 1000

					if var_86_9 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_3
					end

					if var_86_5.prefab_name ~= "" and arg_83_1.actors_[var_86_5.prefab_name] ~= nil then
						local var_86_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_5.prefab_name].transform, "story_v_out_112332", "112332021", "story_v_out_112332.awb")

						arg_83_1:RecordAudio("112332021", var_86_10)
						arg_83_1:RecordAudio("112332021", var_86_10)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_112332", "112332021", "story_v_out_112332.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_112332", "112332021", "story_v_out_112332.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_4, arg_83_1.talkMaxDuration)

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_3) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_3 + var_86_11 and arg_83_1.time_ < var_86_3 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play112332022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 112332022
		arg_87_1.duration_ = 4.83

		local var_87_0 = {
			ja = 4.266,
			ko = 4.833,
			zh = 4.1,
			en = 2.366
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
				arg_87_0:Play112332023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(112332022)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 18 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 18)

				if (18 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 18)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332022", "story_v_out_112332.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_112332", "112332022", "story_v_out_112332.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_112332", "112332022", "story_v_out_112332.awb")

						arg_87_1:RecordAudio("112332022", var_90_6)
						arg_87_1:RecordAudio("112332022", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_112332", "112332022", "story_v_out_112332.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_112332", "112332022", "story_v_out_112332.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play112332023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 112332023
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play112332024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1039"]) then
				local var_94_0 = arg_91_1.actors_["1039"]:GetComponent("Image")

				if var_94_0 then
					arg_91_1.var_.highlightMatValue1039 = var_94_0
				end
			end

			local var_94_1 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 and not isNil(arg_91_1.actors_["1039"]) then
				if arg_91_1.var_.highlightMatValue1039 then
					local var_94_2 = Mathf.Lerp(1, 0.5, (arg_91_1.time_ - 0) / var_94_1)

					arg_91_1.var_.highlightMatValue1039.color.r = var_94_2
					arg_91_1.var_.highlightMatValue1039.color.g = var_94_2
					arg_91_1.var_.highlightMatValue1039.color.b = var_94_2
					arg_91_1.var_.highlightMatValue1039.color = arg_91_1.var_.highlightMatValue1039.color
				end
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 and not isNil(arg_91_1.actors_["1039"]) and arg_91_1.var_.highlightMatValue1039 then
				arg_91_1.var_.highlightMatValue1039.color.r = 0.5
				arg_91_1.var_.highlightMatValue1039.color.g = 0.5
				arg_91_1.var_.highlightMatValue1039.color.b = 0.5
				arg_91_1.var_.highlightMatValue1039.color = arg_91_1.var_.highlightMatValue1039.color
			end

			local var_94_3 = 0
			local var_94_4 = 1.45

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_5 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(112332023).content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 58 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 58)

				if (58 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 58)) > 0 and var_94_4 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_3 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_3
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_4, arg_91_1.talkMaxDuration)

			if var_94_3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_3 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_3) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_3 + var_94_8 and arg_91_1.time_ < var_94_3 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play112332024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 112332024
		arg_95_1.duration_ = 8.33

		local var_95_0 = {
			ja = 8.333,
			ko = 4.733,
			zh = 6.4,
			en = 6.333
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
				arg_95_0:Play112332025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1039"]) then
				local var_98_0 = arg_95_1.actors_["1039"]:GetComponent("Image")

				if var_98_0 then
					arg_95_1.var_.highlightMatValue1039 = var_98_0
				end
			end

			local var_98_1 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 and not isNil(arg_95_1.actors_["1039"]) then
				if arg_95_1.var_.highlightMatValue1039 then
					local var_98_2 = Mathf.Lerp(0.5, 1, (arg_95_1.time_ - 0) / var_98_1)

					arg_95_1.var_.highlightMatValue1039.color.r = var_98_2
					arg_95_1.var_.highlightMatValue1039.color.g = var_98_2
					arg_95_1.var_.highlightMatValue1039.color.b = var_98_2
					arg_95_1.var_.highlightMatValue1039.color = arg_95_1.var_.highlightMatValue1039.color
				end
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 and not isNil(arg_95_1.actors_["1039"]) and arg_95_1.var_.highlightMatValue1039 then
				arg_95_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_95_1.var_.highlightMatValue1039.color.r = 1
				arg_95_1.var_.highlightMatValue1039.color.g = 1
				arg_95_1.var_.highlightMatValue1039.color.b = 1
				arg_95_1.var_.highlightMatValue1039.color = arg_95_1.var_.highlightMatValue1039.color
			end

			local var_98_3 = 0
			local var_98_4 = 0.6

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_5 = arg_95_1:GetWordFromCfg(112332024)
				local var_98_6 = arg_95_1:FormatText(var_98_5.content)

				arg_95_1.text_.text = var_98_6

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_8 = 24 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_6) / 24)

				if (24 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_6) / 24)) > 0 and var_98_4 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_3
					end
				end

				arg_95_1.text_.text = var_98_6
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112332", "112332024", "story_v_out_112332.awb") ~= 0 then
					local var_98_9 = manager.audio:GetVoiceLength("story_v_out_112332", "112332024", "story_v_out_112332.awb") / 1000

					if var_98_9 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_3
					end

					if var_98_5.prefab_name ~= "" and arg_95_1.actors_[var_98_5.prefab_name] ~= nil then
						local var_98_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_5.prefab_name].transform, "story_v_out_112332", "112332024", "story_v_out_112332.awb")

						arg_95_1:RecordAudio("112332024", var_98_10)
						arg_95_1:RecordAudio("112332024", var_98_10)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_112332", "112332024", "story_v_out_112332.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_112332", "112332024", "story_v_out_112332.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_4, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_3) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_11 and arg_95_1.time_ < var_98_3 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play112332025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 112332025
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
			arg_99_1.auto_ = false
		end

		function arg_99_1.playNext_(arg_101_0)
			arg_99_1.onStoryFinished_()
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1039"]) then
				local var_102_0 = arg_99_1.actors_["1039"]:GetComponent("Image")

				if var_102_0 then
					arg_99_1.var_.highlightMatValue1039 = var_102_0
				end
			end

			local var_102_1 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 and not isNil(arg_99_1.actors_["1039"]) then
				if arg_99_1.var_.highlightMatValue1039 then
					local var_102_2 = Mathf.Lerp(1, 0.5, (arg_99_1.time_ - 0) / var_102_1)

					arg_99_1.var_.highlightMatValue1039.color.r = var_102_2
					arg_99_1.var_.highlightMatValue1039.color.g = var_102_2
					arg_99_1.var_.highlightMatValue1039.color.b = var_102_2
					arg_99_1.var_.highlightMatValue1039.color = arg_99_1.var_.highlightMatValue1039.color
				end
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 and not isNil(arg_99_1.actors_["1039"]) and arg_99_1.var_.highlightMatValue1039 then
				arg_99_1.var_.highlightMatValue1039.color.r = 0.5
				arg_99_1.var_.highlightMatValue1039.color.g = 0.5
				arg_99_1.var_.highlightMatValue1039.color.b = 0.5
				arg_99_1.var_.highlightMatValue1039.color = arg_99_1.var_.highlightMatValue1039.color
			end

			local var_102_3 = 0
			local var_102_4 = 0.1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_5 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(112332025).content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 4 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 4)

				if (4 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 4)) > 0 and var_102_4 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_8 and arg_99_1.time_ < var_102_3 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_112332.awb"
	}
}
