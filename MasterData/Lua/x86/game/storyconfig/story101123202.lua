return {
	Play112322001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112322001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112322002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.5

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_3 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112322001).content)

				arg_1_1.text_.text = var_4_3

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_5 = 20 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 20)

				if (20 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 20)) > 0 and var_4_1 < var_4_5 then
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
	Play112322002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112322002
		arg_7_1.duration_ = 4.13

		local var_7_0 = {
			ja = 3.866,
			ko = 3.633,
			zh = 4.133,
			en = 4
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
				arg_7_0:Play112322003(arg_7_1)
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

				arg_7_1:CheckSpriteTmpPos("1039", 3)
			end

			local var_10_3 = 0.1

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

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_8 = arg_7_1.actors_["1039"]:GetComponent("Image")

				if var_10_8 then
					arg_7_1.var_.alphaMatValue1039 = var_10_8
					arg_7_1.var_.alphaOldValue1039 = var_10_8.color.a
				end

				arg_7_1.var_.alphaOldValue1039 = 0
			end

			local var_10_9 = 0.5

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_9 then
				if arg_7_1.var_.alphaMatValue1039 then
					arg_7_1.var_.alphaMatValue1039.color.a = Mathf.Lerp(arg_7_1.var_.alphaOldValue1039, 1, (arg_7_1.time_ - 0) / var_10_9)
					arg_7_1.var_.alphaMatValue1039.color = arg_7_1.var_.alphaMatValue1039.color
				end
			end

			if arg_7_1.time_ >= 0 + var_10_9 and arg_7_1.time_ < 0 + var_10_9 + arg_10_0 and arg_7_1.var_.alphaMatValue1039 then
				arg_7_1.var_.alphaMatValue1039.color.a = 1
				arg_7_1.var_.alphaMatValue1039.color = arg_7_1.var_.alphaMatValue1039.color
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_10 = 0.5
			local var_10_11 = 0.3

			if 0.5 < arg_7_1.time_ and arg_7_1.time_ <= var_10_10 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_12 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_12:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_13 = arg_7_1:GetWordFromCfg(112322002)
				local var_10_14 = arg_7_1:FormatText(var_10_13.content)

				arg_7_1.text_.text = var_10_14

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_16 = 12 <= 0 and var_10_11 or var_10_11 * (utf8.len(var_10_14) / 12)

				if (12 <= 0 and var_10_11 or var_10_11 * (utf8.len(var_10_14) / 12)) > 0 and var_10_11 < var_10_16 then
					arg_7_1.talkMaxDuration = var_10_16
					var_10_10 = var_10_10 + 0.3

					if var_10_16 + var_10_10 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_16 + var_10_10
					end
				end

				arg_7_1.text_.text = var_10_14
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322002", "story_v_out_112322.awb") ~= 0 then
					local var_10_17 = manager.audio:GetVoiceLength("story_v_out_112322", "112322002", "story_v_out_112322.awb") / 1000

					if var_10_17 + var_10_10 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_17 + var_10_10
					end

					if var_10_13.prefab_name ~= "" and arg_7_1.actors_[var_10_13.prefab_name] ~= nil then
						local var_10_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_13.prefab_name].transform, "story_v_out_112322", "112322002", "story_v_out_112322.awb")

						arg_7_1:RecordAudio("112322002", var_10_18)
						arg_7_1:RecordAudio("112322002", var_10_18)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112322", "112322002", "story_v_out_112322.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112322", "112322002", "story_v_out_112322.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_19 = var_10_10 + 0.3
			local var_10_20 = math.max(var_10_11, arg_7_1.talkMaxDuration)

			if var_10_10 + 0.3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_19 + var_10_20 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_19) / var_10_20

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_19 + var_10_20 and arg_7_1.time_ < var_10_19 + var_10_20 + arg_10_0 then
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
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play112322003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 112322003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play112322004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1039"]) then
				local var_16_0 = arg_13_1.actors_["1039"]:GetComponent("Image")

				if var_16_0 then
					arg_13_1.var_.highlightMatValue1039 = var_16_0
				end
			end

			local var_16_1 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 and not isNil(arg_13_1.actors_["1039"]) then
				if arg_13_1.var_.highlightMatValue1039 then
					local var_16_2 = Mathf.Lerp(1, 0.5, (arg_13_1.time_ - 0) / var_16_1)

					arg_13_1.var_.highlightMatValue1039.color.r = var_16_2
					arg_13_1.var_.highlightMatValue1039.color.g = var_16_2
					arg_13_1.var_.highlightMatValue1039.color.b = var_16_2
					arg_13_1.var_.highlightMatValue1039.color = arg_13_1.var_.highlightMatValue1039.color
				end
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 and not isNil(arg_13_1.actors_["1039"]) and arg_13_1.var_.highlightMatValue1039 then
				arg_13_1.var_.highlightMatValue1039.color.r = 0.5
				arg_13_1.var_.highlightMatValue1039.color.g = 0.5
				arg_13_1.var_.highlightMatValue1039.color.b = 0.5
				arg_13_1.var_.highlightMatValue1039.color = arg_13_1.var_.highlightMatValue1039.color
			end

			local var_16_3 = 0
			local var_16_4 = 0.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_5 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(112322003).content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 12 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 12)

				if (12 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 12)) > 0 and var_16_4 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_3) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_3 + var_16_8 and arg_13_1.time_ < var_16_3 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play112322004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 112322004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play112322005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.725

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(112322004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 29 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 29)

				if (29 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 29)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play112322005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 112322005
		arg_21_1.duration_ = 7.57

		local var_21_0 = {
			ja = 4.233,
			ko = 4.133,
			zh = 5.433,
			en = 7.566
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
				arg_21_0:Play112322006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1039"]) then
				local var_24_0 = arg_21_1.actors_["1039"]:GetComponent("Image")

				if var_24_0 then
					arg_21_1.var_.highlightMatValue1039 = var_24_0
				end
			end

			local var_24_1 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 and not isNil(arg_21_1.actors_["1039"]) then
				if arg_21_1.var_.highlightMatValue1039 then
					local var_24_2 = Mathf.Lerp(0.5, 1, (arg_21_1.time_ - 0) / var_24_1)

					arg_21_1.var_.highlightMatValue1039.color.r = var_24_2
					arg_21_1.var_.highlightMatValue1039.color.g = var_24_2
					arg_21_1.var_.highlightMatValue1039.color.b = var_24_2
					arg_21_1.var_.highlightMatValue1039.color = arg_21_1.var_.highlightMatValue1039.color
				end
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 and not isNil(arg_21_1.actors_["1039"]) and arg_21_1.var_.highlightMatValue1039 then
				arg_21_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_21_1.var_.highlightMatValue1039.color.r = 1
				arg_21_1.var_.highlightMatValue1039.color.g = 1
				arg_21_1.var_.highlightMatValue1039.color.b = 1
				arg_21_1.var_.highlightMatValue1039.color = arg_21_1.var_.highlightMatValue1039.color
			end

			local var_24_3 = 0
			local var_24_4 = 0.475

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:GetWordFromCfg(112322005)
				local var_24_6 = arg_21_1:FormatText(var_24_5.content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 19 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_6) / 19)

				if (19 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_6) / 19)) > 0 and var_24_4 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322005", "story_v_out_112322.awb") ~= 0 then
					local var_24_9 = manager.audio:GetVoiceLength("story_v_out_112322", "112322005", "story_v_out_112322.awb") / 1000

					if var_24_9 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_3
					end

					if var_24_5.prefab_name ~= "" and arg_21_1.actors_[var_24_5.prefab_name] ~= nil then
						local var_24_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_5.prefab_name].transform, "story_v_out_112322", "112322005", "story_v_out_112322.awb")

						arg_21_1:RecordAudio("112322005", var_24_10)
						arg_21_1:RecordAudio("112322005", var_24_10)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_112322", "112322005", "story_v_out_112322.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_112322", "112322005", "story_v_out_112322.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_11 and arg_21_1.time_ < var_24_3 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play112322006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 112322006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play112322007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1039"]) then
				local var_28_0 = arg_25_1.actors_["1039"]:GetComponent("Image")

				if var_28_0 then
					arg_25_1.var_.highlightMatValue1039 = var_28_0
				end
			end

			local var_28_1 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 and not isNil(arg_25_1.actors_["1039"]) then
				if arg_25_1.var_.highlightMatValue1039 then
					local var_28_2 = Mathf.Lerp(1, 0.5, (arg_25_1.time_ - 0) / var_28_1)

					arg_25_1.var_.highlightMatValue1039.color.r = var_28_2
					arg_25_1.var_.highlightMatValue1039.color.g = var_28_2
					arg_25_1.var_.highlightMatValue1039.color.b = var_28_2
					arg_25_1.var_.highlightMatValue1039.color = arg_25_1.var_.highlightMatValue1039.color
				end
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 and not isNil(arg_25_1.actors_["1039"]) and arg_25_1.var_.highlightMatValue1039 then
				arg_25_1.var_.highlightMatValue1039.color.r = 0.5
				arg_25_1.var_.highlightMatValue1039.color.g = 0.5
				arg_25_1.var_.highlightMatValue1039.color.b = 0.5
				arg_25_1.var_.highlightMatValue1039.color = arg_25_1.var_.highlightMatValue1039.color
			end

			local var_28_3 = 0
			local var_28_4 = 0.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(112322006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 12 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 12)

				if (12 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 12)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play112322007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 112322007
		arg_29_1.duration_ = 7.97

		local var_29_0 = {
			ja = 7.966,
			ko = 6.933,
			zh = 6.6,
			en = 5.5
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
				arg_29_0:Play112322008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1039"]) then
				local var_32_0 = arg_29_1.actors_["1039"]:GetComponent("Image")

				if var_32_0 then
					arg_29_1.var_.highlightMatValue1039 = var_32_0
				end
			end

			local var_32_1 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 and not isNil(arg_29_1.actors_["1039"]) then
				if arg_29_1.var_.highlightMatValue1039 then
					local var_32_2 = Mathf.Lerp(0.5, 1, (arg_29_1.time_ - 0) / var_32_1)

					arg_29_1.var_.highlightMatValue1039.color.r = var_32_2
					arg_29_1.var_.highlightMatValue1039.color.g = var_32_2
					arg_29_1.var_.highlightMatValue1039.color.b = var_32_2
					arg_29_1.var_.highlightMatValue1039.color = arg_29_1.var_.highlightMatValue1039.color
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and not isNil(arg_29_1.actors_["1039"]) and arg_29_1.var_.highlightMatValue1039 then
				arg_29_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_29_1.var_.highlightMatValue1039.color.r = 1
				arg_29_1.var_.highlightMatValue1039.color.g = 1
				arg_29_1.var_.highlightMatValue1039.color.b = 1
				arg_29_1.var_.highlightMatValue1039.color = arg_29_1.var_.highlightMatValue1039.color
			end

			local var_32_3 = 0
			local var_32_4 = 0.575

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
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

				local var_32_5 = arg_29_1:GetWordFromCfg(112322007)
				local var_32_6 = arg_29_1:FormatText(var_32_5.content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 23 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_6) / 23)

				if (23 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_6) / 23)) > 0 and var_32_4 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322007", "story_v_out_112322.awb") ~= 0 then
					local var_32_9 = manager.audio:GetVoiceLength("story_v_out_112322", "112322007", "story_v_out_112322.awb") / 1000

					if var_32_9 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_3
					end

					if var_32_5.prefab_name ~= "" and arg_29_1.actors_[var_32_5.prefab_name] ~= nil then
						local var_32_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_5.prefab_name].transform, "story_v_out_112322", "112322007", "story_v_out_112322.awb")

						arg_29_1:RecordAudio("112322007", var_32_10)
						arg_29_1:RecordAudio("112322007", var_32_10)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_112322", "112322007", "story_v_out_112322.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_112322", "112322007", "story_v_out_112322.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_11 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_11 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_11

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_11 and arg_29_1.time_ < var_32_3 + var_32_11 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play112322008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 112322008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play112322009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1039"]) then
				local var_36_0 = arg_33_1.actors_["1039"]:GetComponent("Image")

				if var_36_0 then
					arg_33_1.var_.highlightMatValue1039 = var_36_0
				end
			end

			local var_36_1 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 and not isNil(arg_33_1.actors_["1039"]) then
				if arg_33_1.var_.highlightMatValue1039 then
					local var_36_2 = Mathf.Lerp(1, 0.5, (arg_33_1.time_ - 0) / var_36_1)

					arg_33_1.var_.highlightMatValue1039.color.r = var_36_2
					arg_33_1.var_.highlightMatValue1039.color.g = var_36_2
					arg_33_1.var_.highlightMatValue1039.color.b = var_36_2
					arg_33_1.var_.highlightMatValue1039.color = arg_33_1.var_.highlightMatValue1039.color
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and not isNil(arg_33_1.actors_["1039"]) and arg_33_1.var_.highlightMatValue1039 then
				arg_33_1.var_.highlightMatValue1039.color.r = 0.5
				arg_33_1.var_.highlightMatValue1039.color.g = 0.5
				arg_33_1.var_.highlightMatValue1039.color.b = 0.5
				arg_33_1.var_.highlightMatValue1039.color = arg_33_1.var_.highlightMatValue1039.color
			end

			local var_36_3 = 0
			local var_36_4 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
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

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(112322008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 25 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 25)

				if (25 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 25)) > 0 and var_36_4 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_8 and arg_33_1.time_ < var_36_3 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play112322009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 112322009
		arg_37_1.duration_ = 13.9

		local var_37_0 = {
			ja = 6.833,
			ko = 11,
			zh = 9.466,
			en = 13.9
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
				arg_37_0:Play112322010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1039"]) then
				local var_40_0 = arg_37_1.actors_["1039"]:GetComponent("Image")

				if var_40_0 then
					arg_37_1.var_.highlightMatValue1039 = var_40_0
				end
			end

			local var_40_1 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(arg_37_1.actors_["1039"]) then
				if arg_37_1.var_.highlightMatValue1039 then
					local var_40_2 = Mathf.Lerp(0.5, 1, (arg_37_1.time_ - 0) / var_40_1)

					arg_37_1.var_.highlightMatValue1039.color.r = var_40_2
					arg_37_1.var_.highlightMatValue1039.color.g = var_40_2
					arg_37_1.var_.highlightMatValue1039.color.b = var_40_2
					arg_37_1.var_.highlightMatValue1039.color = arg_37_1.var_.highlightMatValue1039.color
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(arg_37_1.actors_["1039"]) and arg_37_1.var_.highlightMatValue1039 then
				arg_37_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_37_1.var_.highlightMatValue1039.color.r = 1
				arg_37_1.var_.highlightMatValue1039.color.g = 1
				arg_37_1.var_.highlightMatValue1039.color.b = 1
				arg_37_1.var_.highlightMatValue1039.color = arg_37_1.var_.highlightMatValue1039.color
			end

			local var_40_3 = 0
			local var_40_4 = 1.1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:GetWordFromCfg(112322009)
				local var_40_6 = arg_37_1:FormatText(var_40_5.content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_8 = 44 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_6) / 44)

				if (44 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_6) / 44)) > 0 and var_40_4 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322009", "story_v_out_112322.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_out_112322", "112322009", "story_v_out_112322.awb") / 1000

					if var_40_9 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_3
					end

					if var_40_5.prefab_name ~= "" and arg_37_1.actors_[var_40_5.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_5.prefab_name].transform, "story_v_out_112322", "112322009", "story_v_out_112322.awb")

						arg_37_1:RecordAudio("112322009", var_40_10)
						arg_37_1:RecordAudio("112322009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_112322", "112322009", "story_v_out_112322.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_112322", "112322009", "story_v_out_112322.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_11 and arg_37_1.time_ < var_40_3 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play112322010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 112322010
		arg_41_1.duration_ = 15.5

		local var_41_0 = {
			ja = 12.733,
			ko = 5.6,
			zh = 6.066,
			en = 15.5
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
				arg_41_0:Play112322011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(112322010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 26 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 26)

				if (26 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 26)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322010", "story_v_out_112322.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_112322", "112322010", "story_v_out_112322.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_112322", "112322010", "story_v_out_112322.awb")

						arg_41_1:RecordAudio("112322010", var_44_6)
						arg_41_1:RecordAudio("112322010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_112322", "112322010", "story_v_out_112322.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_112322", "112322010", "story_v_out_112322.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play112322011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 112322011
		arg_45_1.duration_ = 5.4

		local var_45_0 = {
			ja = 4.5,
			ko = 4.4,
			zh = 3.4,
			en = 5.4
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
				arg_45_0:Play112322012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(112322011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 14 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 14)

				if (14 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 14)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322011", "story_v_out_112322.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_112322", "112322011", "story_v_out_112322.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_112322", "112322011", "story_v_out_112322.awb")

						arg_45_1:RecordAudio("112322011", var_48_6)
						arg_45_1:RecordAudio("112322011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_112322", "112322011", "story_v_out_112322.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_112322", "112322011", "story_v_out_112322.awb")
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
	Play112322012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 112322012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play112322013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1039"]) then
				local var_52_0 = arg_49_1.actors_["1039"]:GetComponent("Image")

				if var_52_0 then
					arg_49_1.var_.highlightMatValue1039 = var_52_0
				end
			end

			local var_52_1 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 and not isNil(arg_49_1.actors_["1039"]) then
				if arg_49_1.var_.highlightMatValue1039 then
					local var_52_2 = Mathf.Lerp(1, 0.5, (arg_49_1.time_ - 0) / var_52_1)

					arg_49_1.var_.highlightMatValue1039.color.r = var_52_2
					arg_49_1.var_.highlightMatValue1039.color.g = var_52_2
					arg_49_1.var_.highlightMatValue1039.color.b = var_52_2
					arg_49_1.var_.highlightMatValue1039.color = arg_49_1.var_.highlightMatValue1039.color
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 and not isNil(arg_49_1.actors_["1039"]) and arg_49_1.var_.highlightMatValue1039 then
				arg_49_1.var_.highlightMatValue1039.color.r = 0.5
				arg_49_1.var_.highlightMatValue1039.color.g = 0.5
				arg_49_1.var_.highlightMatValue1039.color.b = 0.5
				arg_49_1.var_.highlightMatValue1039.color = arg_49_1.var_.highlightMatValue1039.color
			end

			local var_52_3 = 0
			local var_52_4 = 0.85

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
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

				local var_52_5 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(112322012).content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 34 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 34)

				if (34 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 34)) > 0 and var_52_4 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_8 and arg_49_1.time_ < var_52_3 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play112322013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 112322013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play112322014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.85

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
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

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(112322013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 34 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 34)

				if (34 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 34)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play112322014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 112322014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play112322015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.425

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(112322014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 17 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 17)

				if (17 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 17)) > 0 and var_60_0 < var_60_3 then
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
	Play112322015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 112322015
		arg_61_1.duration_ = 1.83

		local var_61_0 = {
			ja = 1.066,
			ko = 1.833,
			zh = 0.999999999999,
			en = 0.999999999999
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
				arg_61_0:Play112322016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1039"]) then
				local var_64_0 = arg_61_1.actors_["1039"]:GetComponent("Image")

				if var_64_0 then
					arg_61_1.var_.highlightMatValue1039 = var_64_0
				end
			end

			local var_64_1 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 and not isNil(arg_61_1.actors_["1039"]) then
				if arg_61_1.var_.highlightMatValue1039 then
					local var_64_2 = Mathf.Lerp(0.5, 1, (arg_61_1.time_ - 0) / var_64_1)

					arg_61_1.var_.highlightMatValue1039.color.r = var_64_2
					arg_61_1.var_.highlightMatValue1039.color.g = var_64_2
					arg_61_1.var_.highlightMatValue1039.color.b = var_64_2
					arg_61_1.var_.highlightMatValue1039.color = arg_61_1.var_.highlightMatValue1039.color
				end
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 and not isNil(arg_61_1.actors_["1039"]) and arg_61_1.var_.highlightMatValue1039 then
				arg_61_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_61_1.var_.highlightMatValue1039.color.r = 1
				arg_61_1.var_.highlightMatValue1039.color.g = 1
				arg_61_1.var_.highlightMatValue1039.color.b = 1
				arg_61_1.var_.highlightMatValue1039.color = arg_61_1.var_.highlightMatValue1039.color
			end

			local var_64_3 = 0
			local var_64_4 = 0.075

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:GetWordFromCfg(112322015)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_8 = 3 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_6) / 3)

				if (3 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_6) / 3)) > 0 and var_64_4 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322015", "story_v_out_112322.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_out_112322", "112322015", "story_v_out_112322.awb") / 1000

					if var_64_9 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_3
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_112322", "112322015", "story_v_out_112322.awb")

						arg_61_1:RecordAudio("112322015", var_64_10)
						arg_61_1:RecordAudio("112322015", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_112322", "112322015", "story_v_out_112322.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_112322", "112322015", "story_v_out_112322.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_11 and arg_61_1.time_ < var_64_3 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play112322016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 112322016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play112322017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1039"]) then
				local var_68_0 = arg_65_1.actors_["1039"]:GetComponent("Image")

				if var_68_0 then
					arg_65_1.var_.highlightMatValue1039 = var_68_0
				end
			end

			local var_68_1 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 and not isNil(arg_65_1.actors_["1039"]) then
				if arg_65_1.var_.highlightMatValue1039 then
					local var_68_2 = Mathf.Lerp(1, 0.5, (arg_65_1.time_ - 0) / var_68_1)

					arg_65_1.var_.highlightMatValue1039.color.r = var_68_2
					arg_65_1.var_.highlightMatValue1039.color.g = var_68_2
					arg_65_1.var_.highlightMatValue1039.color.b = var_68_2
					arg_65_1.var_.highlightMatValue1039.color = arg_65_1.var_.highlightMatValue1039.color
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and not isNil(arg_65_1.actors_["1039"]) and arg_65_1.var_.highlightMatValue1039 then
				arg_65_1.var_.highlightMatValue1039.color.r = 0.5
				arg_65_1.var_.highlightMatValue1039.color.g = 0.5
				arg_65_1.var_.highlightMatValue1039.color.b = 0.5
				arg_65_1.var_.highlightMatValue1039.color = arg_65_1.var_.highlightMatValue1039.color
			end

			local var_68_3 = 0
			local var_68_4 = 0.975

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

				local var_68_5 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(112322016).content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 39 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 39)

				if (39 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 39)) > 0 and var_68_4 < var_68_7 then
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
	Play112322017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 112322017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play112322018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.625

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
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

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(112322017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 25 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 25)

				if (25 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 25)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play112322018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 112322018
		arg_73_1.duration_ = 14.6

		local var_73_0 = {
			ja = 14.6,
			ko = 9.733,
			zh = 8.6,
			en = 9
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play112322019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1039"]) then
				local var_76_0 = arg_73_1.actors_["1039"]:GetComponent("Image")

				if var_76_0 then
					arg_73_1.var_.highlightMatValue1039 = var_76_0
				end
			end

			local var_76_1 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 and not isNil(arg_73_1.actors_["1039"]) then
				if arg_73_1.var_.highlightMatValue1039 then
					local var_76_2 = Mathf.Lerp(0.5, 1, (arg_73_1.time_ - 0) / var_76_1)

					arg_73_1.var_.highlightMatValue1039.color.r = var_76_2
					arg_73_1.var_.highlightMatValue1039.color.g = var_76_2
					arg_73_1.var_.highlightMatValue1039.color.b = var_76_2
					arg_73_1.var_.highlightMatValue1039.color = arg_73_1.var_.highlightMatValue1039.color
				end
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 and not isNil(arg_73_1.actors_["1039"]) and arg_73_1.var_.highlightMatValue1039 then
				arg_73_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_73_1.var_.highlightMatValue1039.color.r = 1
				arg_73_1.var_.highlightMatValue1039.color.g = 1
				arg_73_1.var_.highlightMatValue1039.color.b = 1
				arg_73_1.var_.highlightMatValue1039.color = arg_73_1.var_.highlightMatValue1039.color
			end

			local var_76_3 = 0
			local var_76_4 = 1.025

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:GetWordFromCfg(112322018)
				local var_76_6 = arg_73_1:FormatText(var_76_5.content)

				arg_73_1.text_.text = var_76_6

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_8 = 41 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 41)

				if (41 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 41)) > 0 and var_76_4 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_6
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322018", "story_v_out_112322.awb") ~= 0 then
					local var_76_9 = manager.audio:GetVoiceLength("story_v_out_112322", "112322018", "story_v_out_112322.awb") / 1000

					if var_76_9 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_3
					end

					if var_76_5.prefab_name ~= "" and arg_73_1.actors_[var_76_5.prefab_name] ~= nil then
						local var_76_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_5.prefab_name].transform, "story_v_out_112322", "112322018", "story_v_out_112322.awb")

						arg_73_1:RecordAudio("112322018", var_76_10)
						arg_73_1:RecordAudio("112322018", var_76_10)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_112322", "112322018", "story_v_out_112322.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_112322", "112322018", "story_v_out_112322.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_11 and arg_73_1.time_ < var_76_3 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play112322019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 112322019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play112322020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1039"]) then
				local var_80_0 = arg_77_1.actors_["1039"]:GetComponent("Image")

				if var_80_0 then
					arg_77_1.var_.highlightMatValue1039 = var_80_0
				end
			end

			local var_80_1 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 and not isNil(arg_77_1.actors_["1039"]) then
				if arg_77_1.var_.highlightMatValue1039 then
					local var_80_2 = Mathf.Lerp(1, 0.5, (arg_77_1.time_ - 0) / var_80_1)

					arg_77_1.var_.highlightMatValue1039.color.r = var_80_2
					arg_77_1.var_.highlightMatValue1039.color.g = var_80_2
					arg_77_1.var_.highlightMatValue1039.color.b = var_80_2
					arg_77_1.var_.highlightMatValue1039.color = arg_77_1.var_.highlightMatValue1039.color
				end
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 and not isNil(arg_77_1.actors_["1039"]) and arg_77_1.var_.highlightMatValue1039 then
				arg_77_1.var_.highlightMatValue1039.color.r = 0.5
				arg_77_1.var_.highlightMatValue1039.color.g = 0.5
				arg_77_1.var_.highlightMatValue1039.color.b = 0.5
				arg_77_1.var_.highlightMatValue1039.color = arg_77_1.var_.highlightMatValue1039.color
			end

			local var_80_3 = 0
			local var_80_4 = 0.875

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_5 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(112322019).content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 35 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 35)

				if (35 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 35)) > 0 and var_80_4 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_8 and arg_77_1.time_ < var_80_3 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play112322020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 112322020
		arg_81_1.duration_ = 5.43

		local var_81_0 = {
			ja = 5.433,
			ko = 3.966,
			zh = 3.633,
			en = 3.333
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
				arg_81_0:Play112322021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1039"]) then
				local var_84_0 = arg_81_1.actors_["1039"]:GetComponent("Image")

				if var_84_0 then
					arg_81_1.var_.highlightMatValue1039 = var_84_0
				end
			end

			local var_84_1 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 and not isNil(arg_81_1.actors_["1039"]) then
				if arg_81_1.var_.highlightMatValue1039 then
					local var_84_2 = Mathf.Lerp(0.5, 1, (arg_81_1.time_ - 0) / var_84_1)

					arg_81_1.var_.highlightMatValue1039.color.r = var_84_2
					arg_81_1.var_.highlightMatValue1039.color.g = var_84_2
					arg_81_1.var_.highlightMatValue1039.color.b = var_84_2
					arg_81_1.var_.highlightMatValue1039.color = arg_81_1.var_.highlightMatValue1039.color
				end
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 and not isNil(arg_81_1.actors_["1039"]) and arg_81_1.var_.highlightMatValue1039 then
				arg_81_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_81_1.var_.highlightMatValue1039.color.r = 1
				arg_81_1.var_.highlightMatValue1039.color.g = 1
				arg_81_1.var_.highlightMatValue1039.color.b = 1
				arg_81_1.var_.highlightMatValue1039.color = arg_81_1.var_.highlightMatValue1039.color
			end

			local var_84_3 = 0
			local var_84_4 = 0.275

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:GetWordFromCfg(112322020)
				local var_84_6 = arg_81_1:FormatText(var_84_5.content)

				arg_81_1.text_.text = var_84_6

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_8 = 11 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_6) / 11)

				if (11 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_6) / 11)) > 0 and var_84_4 < var_84_8 then
					arg_81_1.talkMaxDuration = var_84_8

					if var_84_8 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_6
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322020", "story_v_out_112322.awb") ~= 0 then
					local var_84_9 = manager.audio:GetVoiceLength("story_v_out_112322", "112322020", "story_v_out_112322.awb") / 1000

					if var_84_9 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_3
					end

					if var_84_5.prefab_name ~= "" and arg_81_1.actors_[var_84_5.prefab_name] ~= nil then
						local var_84_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_5.prefab_name].transform, "story_v_out_112322", "112322020", "story_v_out_112322.awb")

						arg_81_1:RecordAudio("112322020", var_84_10)
						arg_81_1:RecordAudio("112322020", var_84_10)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_112322", "112322020", "story_v_out_112322.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_112322", "112322020", "story_v_out_112322.awb")
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
	Play112322021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 112322021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play112322022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1039"]) then
				local var_88_0 = arg_85_1.actors_["1039"]:GetComponent("Image")

				if var_88_0 then
					arg_85_1.var_.highlightMatValue1039 = var_88_0
				end
			end

			local var_88_1 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 and not isNil(arg_85_1.actors_["1039"]) then
				if arg_85_1.var_.highlightMatValue1039 then
					local var_88_2 = Mathf.Lerp(1, 0.5, (arg_85_1.time_ - 0) / var_88_1)

					arg_85_1.var_.highlightMatValue1039.color.r = var_88_2
					arg_85_1.var_.highlightMatValue1039.color.g = var_88_2
					arg_85_1.var_.highlightMatValue1039.color.b = var_88_2
					arg_85_1.var_.highlightMatValue1039.color = arg_85_1.var_.highlightMatValue1039.color
				end
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 and not isNil(arg_85_1.actors_["1039"]) and arg_85_1.var_.highlightMatValue1039 then
				arg_85_1.var_.highlightMatValue1039.color.r = 0.5
				arg_85_1.var_.highlightMatValue1039.color.g = 0.5
				arg_85_1.var_.highlightMatValue1039.color.b = 0.5
				arg_85_1.var_.highlightMatValue1039.color = arg_85_1.var_.highlightMatValue1039.color
			end

			local var_88_3 = 0
			local var_88_4 = 0.775

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_5 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(112322021).content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 31 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 31)

				if (31 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 31)) > 0 and var_88_4 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_8 and arg_85_1.time_ < var_88_3 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play112322022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 112322022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play112322023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.35

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(112322022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 14 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 14)

				if (14 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 14)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play112322023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 112322023
		arg_93_1.duration_ = 4

		local var_93_0 = {
			ja = 3.6,
			ko = 2.333,
			zh = 4,
			en = 1.7
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
			arg_93_1.auto_ = false
		end

		function arg_93_1.playNext_(arg_95_0)
			arg_93_1.onStoryFinished_()
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1039"]) then
				local var_96_0 = arg_93_1.actors_["1039"]:GetComponent("Image")

				if var_96_0 then
					arg_93_1.var_.highlightMatValue1039 = var_96_0
				end
			end

			local var_96_1 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 and not isNil(arg_93_1.actors_["1039"]) then
				if arg_93_1.var_.highlightMatValue1039 then
					local var_96_2 = Mathf.Lerp(0.5, 1, (arg_93_1.time_ - 0) / var_96_1)

					arg_93_1.var_.highlightMatValue1039.color.r = var_96_2
					arg_93_1.var_.highlightMatValue1039.color.g = var_96_2
					arg_93_1.var_.highlightMatValue1039.color.b = var_96_2
					arg_93_1.var_.highlightMatValue1039.color = arg_93_1.var_.highlightMatValue1039.color
				end
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 and not isNil(arg_93_1.actors_["1039"]) and arg_93_1.var_.highlightMatValue1039 then
				arg_93_1.actors_["1039"].transform:SetSiblingIndex(1)

				arg_93_1.var_.highlightMatValue1039.color.r = 1
				arg_93_1.var_.highlightMatValue1039.color.g = 1
				arg_93_1.var_.highlightMatValue1039.color.b = 1
				arg_93_1.var_.highlightMatValue1039.color = arg_93_1.var_.highlightMatValue1039.color
			end

			local var_96_3 = 0
			local var_96_4 = 0.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:GetWordFromCfg(112322023)
				local var_96_6 = arg_93_1:FormatText(var_96_5.content)

				arg_93_1.text_.text = var_96_6

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_8 = 9 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 9)

				if (9 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 9)) > 0 and var_96_4 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_6
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322023", "story_v_out_112322.awb") ~= 0 then
					local var_96_9 = manager.audio:GetVoiceLength("story_v_out_112322", "112322023", "story_v_out_112322.awb") / 1000

					if var_96_9 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_3
					end

					if var_96_5.prefab_name ~= "" and arg_93_1.actors_[var_96_5.prefab_name] ~= nil then
						local var_96_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_5.prefab_name].transform, "story_v_out_112322", "112322023", "story_v_out_112322.awb")

						arg_93_1:RecordAudio("112322023", var_96_10)
						arg_93_1:RecordAudio("112322023", var_96_10)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_112322", "112322023", "story_v_out_112322.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_112322", "112322023", "story_v_out_112322.awb")
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
	assets = {},
	voices = {
		"story_v_out_112322.awb"
	}
}
