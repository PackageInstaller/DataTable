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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_3 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_3

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

				local var_4_4 = arg_1_1:GetWordFromCfg(112322001)
				local var_4_5 = arg_1_1:FormatText(var_4_4.content)

				arg_1_1.text_.text = var_4_5

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_6 = 20
				local var_4_7 = utf8.len(var_4_5)
				local var_4_8 = var_4_6 <= 0 and var_4_1 or var_4_1 * (var_4_7 / var_4_6)

				if var_4_8 > 0 and var_4_1 < var_4_8 then
					arg_1_1.talkMaxDuration = var_4_8
					var_4_0 = var_4_0 + 0.3

					if var_4_8 + var_4_0 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_8 + var_4_0
					end
				end

				arg_1_1.text_.text = var_4_5
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_9 = var_4_0 + 0.3
			local var_4_10 = math.max(var_4_1, arg_1_1.talkMaxDuration)

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_9) / var_4_10

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
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
			local var_10_0 = "1039"

			if arg_7_1.actors_[var_10_0] == nil then
				local var_10_1 = Object.Instantiate(arg_7_1.imageGo_, arg_7_1.canvasGo_.transform)

				var_10_1.transform:SetSiblingIndex(1)

				var_10_1.name = var_10_0

				local var_10_2 = var_10_1:GetComponent(typeof(Image))

				var_10_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1039")

				var_10_2:SetNativeSize()

				var_10_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_7_1.actors_[var_10_0] = var_10_1
			end

			local var_10_3 = arg_7_1.actors_["1039"].transform
			local var_10_4 = 0

			if var_10_4 < arg_7_1.time_ and arg_7_1.time_ <= var_10_4 + arg_10_0 then
				arg_7_1.var_.moveOldPos1039 = var_10_3.localPosition
				var_10_3.localScale = Vector3.New(1, 1, 1)

				arg_7_1:CheckSpriteTmpPos("1039", 3)
			end

			local var_10_5 = 0.1

			if var_10_4 <= arg_7_1.time_ and arg_7_1.time_ < var_10_4 + var_10_5 then
				local var_10_6 = (arg_7_1.time_ - var_10_4) / var_10_5
				local var_10_7 = Vector3.New(0, -450, 220)

				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1039, var_10_7, var_10_6)
			end

			if arg_7_1.time_ >= var_10_4 + var_10_5 and arg_7_1.time_ < var_10_4 + var_10_5 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0, -450, 220)
			end

			local var_10_8 = arg_7_1.actors_["1039"]
			local var_10_9 = 0

			if var_10_9 < arg_7_1.time_ and arg_7_1.time_ <= var_10_9 + arg_10_0 and not isNil(var_10_8) then
				local var_10_10 = var_10_8:GetComponent("Image")

				if var_10_10 then
					arg_7_1.var_.highlightMatValue1039 = var_10_10
				end
			end

			local var_10_11 = 0.2

			if var_10_9 <= arg_7_1.time_ and arg_7_1.time_ < var_10_9 + var_10_11 and not isNil(var_10_8) then
				local var_10_12 = (arg_7_1.time_ - var_10_9) / var_10_11

				if arg_7_1.var_.highlightMatValue1039 then
					local var_10_13 = Mathf.Lerp(0.5, 1, var_10_12)
					local var_10_14 = arg_7_1.var_.highlightMatValue1039
					local var_10_15 = var_10_14.color

					var_10_15.r = var_10_13
					var_10_15.g = var_10_13
					var_10_15.b = var_10_13
					var_10_14.color = var_10_15
				end
			end

			if arg_7_1.time_ >= var_10_9 + var_10_11 and arg_7_1.time_ < var_10_9 + var_10_11 + arg_10_0 and not isNil(var_10_8) and arg_7_1.var_.highlightMatValue1039 then
				local var_10_16 = 1

				var_10_8.transform:SetSiblingIndex(1)

				local var_10_17 = arg_7_1.var_.highlightMatValue1039
				local var_10_18 = var_10_17.color

				var_10_18.r = var_10_16
				var_10_18.g = var_10_16
				var_10_18.b = var_10_16
				var_10_17.color = var_10_18
			end

			local var_10_19 = arg_7_1.actors_["1039"]
			local var_10_20 = 0

			if var_10_20 < arg_7_1.time_ and arg_7_1.time_ <= var_10_20 + arg_10_0 then
				local var_10_21 = var_10_19:GetComponent("Image")

				if var_10_21 then
					arg_7_1.var_.alphaMatValue1039 = var_10_21
					arg_7_1.var_.alphaOldValue1039 = var_10_21.color.a
				end

				arg_7_1.var_.alphaOldValue1039 = 0
			end

			local var_10_22 = 0.5

			if var_10_20 <= arg_7_1.time_ and arg_7_1.time_ < var_10_20 + var_10_22 then
				local var_10_23 = (arg_7_1.time_ - var_10_20) / var_10_22
				local var_10_24 = Mathf.Lerp(arg_7_1.var_.alphaOldValue1039, 1, var_10_23)

				if arg_7_1.var_.alphaMatValue1039 then
					local var_10_25 = arg_7_1.var_.alphaMatValue1039.color

					var_10_25.a = var_10_24
					arg_7_1.var_.alphaMatValue1039.color = var_10_25
				end
			end

			if arg_7_1.time_ >= var_10_20 + var_10_22 and arg_7_1.time_ < var_10_20 + var_10_22 + arg_10_0 and arg_7_1.var_.alphaMatValue1039 then
				local var_10_26 = arg_7_1.var_.alphaMatValue1039
				local var_10_27 = var_10_26.color

				var_10_27.a = 1
				var_10_26.color = var_10_27
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_28 = 0.5
			local var_10_29 = 0.3

			if var_10_28 < arg_7_1.time_ and arg_7_1.time_ <= var_10_28 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_30 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_30:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_31 = arg_7_1:FormatText(StoryNameCfg[9].name)

				arg_7_1.leftNameTxt_.text = var_10_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_32 = arg_7_1:GetWordFromCfg(112322002)
				local var_10_33 = arg_7_1:FormatText(var_10_32.content)

				arg_7_1.text_.text = var_10_33

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_34 = 12
				local var_10_35 = utf8.len(var_10_33)
				local var_10_36 = var_10_34 <= 0 and var_10_29 or var_10_29 * (var_10_35 / var_10_34)

				if var_10_36 > 0 and var_10_29 < var_10_36 then
					arg_7_1.talkMaxDuration = var_10_36
					var_10_28 = var_10_28 + 0.3

					if var_10_36 + var_10_28 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_36 + var_10_28
					end
				end

				arg_7_1.text_.text = var_10_33
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322002", "story_v_out_112322.awb") ~= 0 then
					local var_10_37 = manager.audio:GetVoiceLength("story_v_out_112322", "112322002", "story_v_out_112322.awb") / 1000

					if var_10_37 + var_10_28 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_37 + var_10_28
					end

					if var_10_32.prefab_name ~= "" and arg_7_1.actors_[var_10_32.prefab_name] ~= nil then
						local var_10_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_32.prefab_name].transform, "story_v_out_112322", "112322002", "story_v_out_112322.awb")

						arg_7_1:RecordAudio("112322002", var_10_38)
						arg_7_1:RecordAudio("112322002", var_10_38)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112322", "112322002", "story_v_out_112322.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112322", "112322002", "story_v_out_112322.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_39 = var_10_28 + 0.3
			local var_10_40 = math.max(var_10_29, arg_7_1.talkMaxDuration)

			if var_10_39 <= arg_7_1.time_ and arg_7_1.time_ < var_10_39 + var_10_40 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_39) / var_10_40

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_39 + var_10_40 and arg_7_1.time_ < var_10_39 + var_10_40 + arg_10_0 then
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
			local var_16_0 = arg_13_1.actors_["1039"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) then
				local var_16_2 = var_16_0:GetComponent("Image")

				if var_16_2 then
					arg_13_1.var_.highlightMatValue1039 = var_16_2
				end
			end

			local var_16_3 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_3 and not isNil(var_16_0) then
				local var_16_4 = (arg_13_1.time_ - var_16_1) / var_16_3

				if arg_13_1.var_.highlightMatValue1039 then
					local var_16_5 = Mathf.Lerp(1, 0.5, var_16_4)
					local var_16_6 = arg_13_1.var_.highlightMatValue1039
					local var_16_7 = var_16_6.color

					var_16_7.r = var_16_5
					var_16_7.g = var_16_5
					var_16_7.b = var_16_5
					var_16_6.color = var_16_7
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_3 and arg_13_1.time_ < var_16_1 + var_16_3 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.highlightMatValue1039 then
				local var_16_8 = 0.5
				local var_16_9 = arg_13_1.var_.highlightMatValue1039
				local var_16_10 = var_16_9.color

				var_16_10.r = var_16_8
				var_16_10.g = var_16_8
				var_16_10.b = var_16_8
				var_16_9.color = var_16_10
			end

			local var_16_11 = 0
			local var_16_12 = 0.3

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_13 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_13

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

				local var_16_14 = arg_13_1:GetWordFromCfg(112322003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 12
				local var_16_17 = utf8.len(var_16_15)
				local var_16_18 = var_16_16 <= 0 and var_16_12 or var_16_12 * (var_16_17 / var_16_16)

				if var_16_18 > 0 and var_16_12 < var_16_18 then
					arg_13_1.talkMaxDuration = var_16_18

					if var_16_18 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_19 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_19 and arg_13_1.time_ < var_16_11 + var_16_19 + arg_16_0 then
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
			local var_20_0 = 0
			local var_20_1 = 0.725

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_2

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

				local var_20_3 = arg_17_1:GetWordFromCfg(112322004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 29
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
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
			local var_24_0 = arg_21_1.actors_["1039"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) then
				local var_24_2 = var_24_0:GetComponent("Image")

				if var_24_2 then
					arg_21_1.var_.highlightMatValue1039 = var_24_2
				end
			end

			local var_24_3 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_3 and not isNil(var_24_0) then
				local var_24_4 = (arg_21_1.time_ - var_24_1) / var_24_3

				if arg_21_1.var_.highlightMatValue1039 then
					local var_24_5 = Mathf.Lerp(0.5, 1, var_24_4)
					local var_24_6 = arg_21_1.var_.highlightMatValue1039
					local var_24_7 = var_24_6.color

					var_24_7.r = var_24_5
					var_24_7.g = var_24_5
					var_24_7.b = var_24_5
					var_24_6.color = var_24_7
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_3 and arg_21_1.time_ < var_24_1 + var_24_3 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.highlightMatValue1039 then
				local var_24_8 = 1

				var_24_0.transform:SetSiblingIndex(1)

				local var_24_9 = arg_21_1.var_.highlightMatValue1039
				local var_24_10 = var_24_9.color

				var_24_10.r = var_24_8
				var_24_10.g = var_24_8
				var_24_10.b = var_24_8
				var_24_9.color = var_24_10
			end

			local var_24_11 = 0
			local var_24_12 = 0.475

			if var_24_11 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_13 = arg_21_1:FormatText(StoryNameCfg[9].name)

				arg_21_1.leftNameTxt_.text = var_24_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(112322005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 19
				local var_24_17 = utf8.len(var_24_15)
				local var_24_18 = var_24_16 <= 0 and var_24_12 or var_24_12 * (var_24_17 / var_24_16)

				if var_24_18 > 0 and var_24_12 < var_24_18 then
					arg_21_1.talkMaxDuration = var_24_18

					if var_24_18 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322005", "story_v_out_112322.awb") ~= 0 then
					local var_24_19 = manager.audio:GetVoiceLength("story_v_out_112322", "112322005", "story_v_out_112322.awb") / 1000

					if var_24_19 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_11
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_112322", "112322005", "story_v_out_112322.awb")

						arg_21_1:RecordAudio("112322005", var_24_20)
						arg_21_1:RecordAudio("112322005", var_24_20)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_112322", "112322005", "story_v_out_112322.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_112322", "112322005", "story_v_out_112322.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_21 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_21 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_21

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_21 and arg_21_1.time_ < var_24_11 + var_24_21 + arg_24_0 then
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
			local var_28_0 = arg_25_1.actors_["1039"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) then
				local var_28_2 = var_28_0:GetComponent("Image")

				if var_28_2 then
					arg_25_1.var_.highlightMatValue1039 = var_28_2
				end
			end

			local var_28_3 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_3 and not isNil(var_28_0) then
				local var_28_4 = (arg_25_1.time_ - var_28_1) / var_28_3

				if arg_25_1.var_.highlightMatValue1039 then
					local var_28_5 = Mathf.Lerp(1, 0.5, var_28_4)
					local var_28_6 = arg_25_1.var_.highlightMatValue1039
					local var_28_7 = var_28_6.color

					var_28_7.r = var_28_5
					var_28_7.g = var_28_5
					var_28_7.b = var_28_5
					var_28_6.color = var_28_7
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_3 and arg_25_1.time_ < var_28_1 + var_28_3 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.highlightMatValue1039 then
				local var_28_8 = 0.5
				local var_28_9 = arg_25_1.var_.highlightMatValue1039
				local var_28_10 = var_28_9.color

				var_28_10.r = var_28_8
				var_28_10.g = var_28_8
				var_28_10.b = var_28_8
				var_28_9.color = var_28_10
			end

			local var_28_11 = 0
			local var_28_12 = 0.3

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_13

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

				local var_28_14 = arg_25_1:GetWordFromCfg(112322006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 12
				local var_28_17 = utf8.len(var_28_15)
				local var_28_18 = var_28_16 <= 0 and var_28_12 or var_28_12 * (var_28_17 / var_28_16)

				if var_28_18 > 0 and var_28_12 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_19 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_19 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_19

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_19 and arg_25_1.time_ < var_28_11 + var_28_19 + arg_28_0 then
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
			local var_32_0 = arg_29_1.actors_["1039"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) then
				local var_32_2 = var_32_0:GetComponent("Image")

				if var_32_2 then
					arg_29_1.var_.highlightMatValue1039 = var_32_2
				end
			end

			local var_32_3 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_3 and not isNil(var_32_0) then
				local var_32_4 = (arg_29_1.time_ - var_32_1) / var_32_3

				if arg_29_1.var_.highlightMatValue1039 then
					local var_32_5 = Mathf.Lerp(0.5, 1, var_32_4)
					local var_32_6 = arg_29_1.var_.highlightMatValue1039
					local var_32_7 = var_32_6.color

					var_32_7.r = var_32_5
					var_32_7.g = var_32_5
					var_32_7.b = var_32_5
					var_32_6.color = var_32_7
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_3 and arg_29_1.time_ < var_32_1 + var_32_3 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.highlightMatValue1039 then
				local var_32_8 = 1

				var_32_0.transform:SetSiblingIndex(1)

				local var_32_9 = arg_29_1.var_.highlightMatValue1039
				local var_32_10 = var_32_9.color

				var_32_10.r = var_32_8
				var_32_10.g = var_32_8
				var_32_10.b = var_32_8
				var_32_9.color = var_32_10
			end

			local var_32_11 = 0
			local var_32_12 = 0.575

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[9].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(112322007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 23
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322007", "story_v_out_112322.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_112322", "112322007", "story_v_out_112322.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_112322", "112322007", "story_v_out_112322.awb")

						arg_29_1:RecordAudio("112322007", var_32_20)
						arg_29_1:RecordAudio("112322007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_112322", "112322007", "story_v_out_112322.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_112322", "112322007", "story_v_out_112322.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
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
			local var_36_0 = arg_33_1.actors_["1039"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) then
				local var_36_2 = var_36_0:GetComponent("Image")

				if var_36_2 then
					arg_33_1.var_.highlightMatValue1039 = var_36_2
				end
			end

			local var_36_3 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_3 and not isNil(var_36_0) then
				local var_36_4 = (arg_33_1.time_ - var_36_1) / var_36_3

				if arg_33_1.var_.highlightMatValue1039 then
					local var_36_5 = Mathf.Lerp(1, 0.5, var_36_4)
					local var_36_6 = arg_33_1.var_.highlightMatValue1039
					local var_36_7 = var_36_6.color

					var_36_7.r = var_36_5
					var_36_7.g = var_36_5
					var_36_7.b = var_36_5
					var_36_6.color = var_36_7
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_3 and arg_33_1.time_ < var_36_1 + var_36_3 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.highlightMatValue1039 then
				local var_36_8 = 0.5
				local var_36_9 = arg_33_1.var_.highlightMatValue1039
				local var_36_10 = var_36_9.color

				var_36_10.r = var_36_8
				var_36_10.g = var_36_8
				var_36_10.b = var_36_8
				var_36_9.color = var_36_10
			end

			local var_36_11 = 0
			local var_36_12 = 0.625

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_13 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_13

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

				local var_36_14 = arg_33_1:GetWordFromCfg(112322008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 25
				local var_36_17 = utf8.len(var_36_15)
				local var_36_18 = var_36_16 <= 0 and var_36_12 or var_36_12 * (var_36_17 / var_36_16)

				if var_36_18 > 0 and var_36_12 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18

					if var_36_18 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_19 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_19 and arg_33_1.time_ < var_36_11 + var_36_19 + arg_36_0 then
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
			local var_40_0 = arg_37_1.actors_["1039"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) then
				local var_40_2 = var_40_0:GetComponent("Image")

				if var_40_2 then
					arg_37_1.var_.highlightMatValue1039 = var_40_2
				end
			end

			local var_40_3 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_3 and not isNil(var_40_0) then
				local var_40_4 = (arg_37_1.time_ - var_40_1) / var_40_3

				if arg_37_1.var_.highlightMatValue1039 then
					local var_40_5 = Mathf.Lerp(0.5, 1, var_40_4)
					local var_40_6 = arg_37_1.var_.highlightMatValue1039
					local var_40_7 = var_40_6.color

					var_40_7.r = var_40_5
					var_40_7.g = var_40_5
					var_40_7.b = var_40_5
					var_40_6.color = var_40_7
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_3 and arg_37_1.time_ < var_40_1 + var_40_3 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.highlightMatValue1039 then
				local var_40_8 = 1

				var_40_0.transform:SetSiblingIndex(1)

				local var_40_9 = arg_37_1.var_.highlightMatValue1039
				local var_40_10 = var_40_9.color

				var_40_10.r = var_40_8
				var_40_10.g = var_40_8
				var_40_10.b = var_40_8
				var_40_9.color = var_40_10
			end

			local var_40_11 = 0
			local var_40_12 = 1.1

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[9].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(112322009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322009", "story_v_out_112322.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_112322", "112322009", "story_v_out_112322.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_112322", "112322009", "story_v_out_112322.awb")

						arg_37_1:RecordAudio("112322009", var_40_20)
						arg_37_1:RecordAudio("112322009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_112322", "112322009", "story_v_out_112322.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_112322", "112322009", "story_v_out_112322.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_21 and arg_37_1.time_ < var_40_11 + var_40_21 + arg_40_0 then
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
			local var_44_0 = 0
			local var_44_1 = 0.65

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[9].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(112322010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 26
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322010", "story_v_out_112322.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_112322", "112322010", "story_v_out_112322.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_112322", "112322010", "story_v_out_112322.awb")

						arg_41_1:RecordAudio("112322010", var_44_9)
						arg_41_1:RecordAudio("112322010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_112322", "112322010", "story_v_out_112322.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_112322", "112322010", "story_v_out_112322.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
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
			local var_48_0 = 0
			local var_48_1 = 0.35

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[9].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(112322011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 14
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322011", "story_v_out_112322.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_112322", "112322011", "story_v_out_112322.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_112322", "112322011", "story_v_out_112322.awb")

						arg_45_1:RecordAudio("112322011", var_48_9)
						arg_45_1:RecordAudio("112322011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_112322", "112322011", "story_v_out_112322.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_112322", "112322011", "story_v_out_112322.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
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
			local var_52_0 = arg_49_1.actors_["1039"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) then
				local var_52_2 = var_52_0:GetComponent("Image")

				if var_52_2 then
					arg_49_1.var_.highlightMatValue1039 = var_52_2
				end
			end

			local var_52_3 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_3 and not isNil(var_52_0) then
				local var_52_4 = (arg_49_1.time_ - var_52_1) / var_52_3

				if arg_49_1.var_.highlightMatValue1039 then
					local var_52_5 = Mathf.Lerp(1, 0.5, var_52_4)
					local var_52_6 = arg_49_1.var_.highlightMatValue1039
					local var_52_7 = var_52_6.color

					var_52_7.r = var_52_5
					var_52_7.g = var_52_5
					var_52_7.b = var_52_5
					var_52_6.color = var_52_7
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_3 and arg_49_1.time_ < var_52_1 + var_52_3 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.highlightMatValue1039 then
				local var_52_8 = 0.5
				local var_52_9 = arg_49_1.var_.highlightMatValue1039
				local var_52_10 = var_52_9.color

				var_52_10.r = var_52_8
				var_52_10.g = var_52_8
				var_52_10.b = var_52_8
				var_52_9.color = var_52_10
			end

			local var_52_11 = 0
			local var_52_12 = 0.85

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_13 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_13

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

				local var_52_14 = arg_49_1:GetWordFromCfg(112322012)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 34
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
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_19 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_19 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_19

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_19 and arg_49_1.time_ < var_52_11 + var_52_19 + arg_52_0 then
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
			local var_56_0 = 0
			local var_56_1 = 0.85

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_2

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

				local var_56_3 = arg_53_1:GetWordFromCfg(112322013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 34
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
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
			local var_60_0 = 0
			local var_60_1 = 0.425

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

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

				local var_60_3 = arg_57_1:GetWordFromCfg(112322014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 17
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
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
			local var_64_0 = arg_61_1.actors_["1039"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) then
				local var_64_2 = var_64_0:GetComponent("Image")

				if var_64_2 then
					arg_61_1.var_.highlightMatValue1039 = var_64_2
				end
			end

			local var_64_3 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 and not isNil(var_64_0) then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3

				if arg_61_1.var_.highlightMatValue1039 then
					local var_64_5 = Mathf.Lerp(0.5, 1, var_64_4)
					local var_64_6 = arg_61_1.var_.highlightMatValue1039
					local var_64_7 = var_64_6.color

					var_64_7.r = var_64_5
					var_64_7.g = var_64_5
					var_64_7.b = var_64_5
					var_64_6.color = var_64_7
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.highlightMatValue1039 then
				local var_64_8 = 1

				var_64_0.transform:SetSiblingIndex(1)

				local var_64_9 = arg_61_1.var_.highlightMatValue1039
				local var_64_10 = var_64_9.color

				var_64_10.r = var_64_8
				var_64_10.g = var_64_8
				var_64_10.b = var_64_8
				var_64_9.color = var_64_10
			end

			local var_64_11 = 0
			local var_64_12 = 0.075

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_13 = arg_61_1:FormatText(StoryNameCfg[9].name)

				arg_61_1.leftNameTxt_.text = var_64_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(112322015)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322015", "story_v_out_112322.awb") ~= 0 then
					local var_64_19 = manager.audio:GetVoiceLength("story_v_out_112322", "112322015", "story_v_out_112322.awb") / 1000

					if var_64_19 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_11
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_out_112322", "112322015", "story_v_out_112322.awb")

						arg_61_1:RecordAudio("112322015", var_64_20)
						arg_61_1:RecordAudio("112322015", var_64_20)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_112322", "112322015", "story_v_out_112322.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_112322", "112322015", "story_v_out_112322.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_21 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_21 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_21

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_21 and arg_61_1.time_ < var_64_11 + var_64_21 + arg_64_0 then
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
			local var_68_0 = arg_65_1.actors_["1039"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) then
				local var_68_2 = var_68_0:GetComponent("Image")

				if var_68_2 then
					arg_65_1.var_.highlightMatValue1039 = var_68_2
				end
			end

			local var_68_3 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 and not isNil(var_68_0) then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3

				if arg_65_1.var_.highlightMatValue1039 then
					local var_68_5 = Mathf.Lerp(1, 0.5, var_68_4)
					local var_68_6 = arg_65_1.var_.highlightMatValue1039
					local var_68_7 = var_68_6.color

					var_68_7.r = var_68_5
					var_68_7.g = var_68_5
					var_68_7.b = var_68_5
					var_68_6.color = var_68_7
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.highlightMatValue1039 then
				local var_68_8 = 0.5
				local var_68_9 = arg_65_1.var_.highlightMatValue1039
				local var_68_10 = var_68_9.color

				var_68_10.r = var_68_8
				var_68_10.g = var_68_8
				var_68_10.b = var_68_8
				var_68_9.color = var_68_10
			end

			local var_68_11 = 0
			local var_68_12 = 0.975

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_13 = arg_65_1:GetWordFromCfg(112322016)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 39
				local var_68_16 = utf8.len(var_68_14)
				local var_68_17 = var_68_15 <= 0 and var_68_12 or var_68_12 * (var_68_16 / var_68_15)

				if var_68_17 > 0 and var_68_12 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17

					if var_68_17 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_18 and arg_65_1.time_ < var_68_11 + var_68_18 + arg_68_0 then
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
			local var_72_0 = 0
			local var_72_1 = 0.625

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_2

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

				local var_72_3 = arg_69_1:GetWordFromCfg(112322017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 25
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
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
			local var_76_0 = arg_73_1.actors_["1039"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) then
				local var_76_2 = var_76_0:GetComponent("Image")

				if var_76_2 then
					arg_73_1.var_.highlightMatValue1039 = var_76_2
				end
			end

			local var_76_3 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_3 and not isNil(var_76_0) then
				local var_76_4 = (arg_73_1.time_ - var_76_1) / var_76_3

				if arg_73_1.var_.highlightMatValue1039 then
					local var_76_5 = Mathf.Lerp(0.5, 1, var_76_4)
					local var_76_6 = arg_73_1.var_.highlightMatValue1039
					local var_76_7 = var_76_6.color

					var_76_7.r = var_76_5
					var_76_7.g = var_76_5
					var_76_7.b = var_76_5
					var_76_6.color = var_76_7
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_3 and arg_73_1.time_ < var_76_1 + var_76_3 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.highlightMatValue1039 then
				local var_76_8 = 1

				var_76_0.transform:SetSiblingIndex(1)

				local var_76_9 = arg_73_1.var_.highlightMatValue1039
				local var_76_10 = var_76_9.color

				var_76_10.r = var_76_8
				var_76_10.g = var_76_8
				var_76_10.b = var_76_8
				var_76_9.color = var_76_10
			end

			local var_76_11 = 0
			local var_76_12 = 1.025

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_13 = arg_73_1:FormatText(StoryNameCfg[9].name)

				arg_73_1.leftNameTxt_.text = var_76_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(112322018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 41
				local var_76_17 = utf8.len(var_76_15)
				local var_76_18 = var_76_16 <= 0 and var_76_12 or var_76_12 * (var_76_17 / var_76_16)

				if var_76_18 > 0 and var_76_12 < var_76_18 then
					arg_73_1.talkMaxDuration = var_76_18

					if var_76_18 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322018", "story_v_out_112322.awb") ~= 0 then
					local var_76_19 = manager.audio:GetVoiceLength("story_v_out_112322", "112322018", "story_v_out_112322.awb") / 1000

					if var_76_19 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_11
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_112322", "112322018", "story_v_out_112322.awb")

						arg_73_1:RecordAudio("112322018", var_76_20)
						arg_73_1:RecordAudio("112322018", var_76_20)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_112322", "112322018", "story_v_out_112322.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_112322", "112322018", "story_v_out_112322.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_21 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_21 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_21

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_21 and arg_73_1.time_ < var_76_11 + var_76_21 + arg_76_0 then
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
			local var_80_0 = arg_77_1.actors_["1039"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) then
				local var_80_2 = var_80_0:GetComponent("Image")

				if var_80_2 then
					arg_77_1.var_.highlightMatValue1039 = var_80_2
				end
			end

			local var_80_3 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_3 and not isNil(var_80_0) then
				local var_80_4 = (arg_77_1.time_ - var_80_1) / var_80_3

				if arg_77_1.var_.highlightMatValue1039 then
					local var_80_5 = Mathf.Lerp(1, 0.5, var_80_4)
					local var_80_6 = arg_77_1.var_.highlightMatValue1039
					local var_80_7 = var_80_6.color

					var_80_7.r = var_80_5
					var_80_7.g = var_80_5
					var_80_7.b = var_80_5
					var_80_6.color = var_80_7
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_3 and arg_77_1.time_ < var_80_1 + var_80_3 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.highlightMatValue1039 then
				local var_80_8 = 0.5
				local var_80_9 = arg_77_1.var_.highlightMatValue1039
				local var_80_10 = var_80_9.color

				var_80_10.r = var_80_8
				var_80_10.g = var_80_8
				var_80_10.b = var_80_8
				var_80_9.color = var_80_10
			end

			local var_80_11 = 0
			local var_80_12 = 0.875

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_13 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_13

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

				local var_80_14 = arg_77_1:GetWordFromCfg(112322019)
				local var_80_15 = arg_77_1:FormatText(var_80_14.content)

				arg_77_1.text_.text = var_80_15

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_16 = 35
				local var_80_17 = utf8.len(var_80_15)
				local var_80_18 = var_80_16 <= 0 and var_80_12 or var_80_12 * (var_80_17 / var_80_16)

				if var_80_18 > 0 and var_80_12 < var_80_18 then
					arg_77_1.talkMaxDuration = var_80_18

					if var_80_18 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_15
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_19 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_19 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_19

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_19 and arg_77_1.time_ < var_80_11 + var_80_19 + arg_80_0 then
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
			local var_84_0 = arg_81_1.actors_["1039"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) then
				local var_84_2 = var_84_0:GetComponent("Image")

				if var_84_2 then
					arg_81_1.var_.highlightMatValue1039 = var_84_2
				end
			end

			local var_84_3 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_3 and not isNil(var_84_0) then
				local var_84_4 = (arg_81_1.time_ - var_84_1) / var_84_3

				if arg_81_1.var_.highlightMatValue1039 then
					local var_84_5 = Mathf.Lerp(0.5, 1, var_84_4)
					local var_84_6 = arg_81_1.var_.highlightMatValue1039
					local var_84_7 = var_84_6.color

					var_84_7.r = var_84_5
					var_84_7.g = var_84_5
					var_84_7.b = var_84_5
					var_84_6.color = var_84_7
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_3 and arg_81_1.time_ < var_84_1 + var_84_3 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.highlightMatValue1039 then
				local var_84_8 = 1

				var_84_0.transform:SetSiblingIndex(1)

				local var_84_9 = arg_81_1.var_.highlightMatValue1039
				local var_84_10 = var_84_9.color

				var_84_10.r = var_84_8
				var_84_10.g = var_84_8
				var_84_10.b = var_84_8
				var_84_9.color = var_84_10
			end

			local var_84_11 = 0
			local var_84_12 = 0.275

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_13 = arg_81_1:FormatText(StoryNameCfg[9].name)

				arg_81_1.leftNameTxt_.text = var_84_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(112322020)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322020", "story_v_out_112322.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_112322", "112322020", "story_v_out_112322.awb") / 1000

					if var_84_19 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_11
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_112322", "112322020", "story_v_out_112322.awb")

						arg_81_1:RecordAudio("112322020", var_84_20)
						arg_81_1:RecordAudio("112322020", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_112322", "112322020", "story_v_out_112322.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_112322", "112322020", "story_v_out_112322.awb")
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
			local var_88_0 = arg_85_1.actors_["1039"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) then
				local var_88_2 = var_88_0:GetComponent("Image")

				if var_88_2 then
					arg_85_1.var_.highlightMatValue1039 = var_88_2
				end
			end

			local var_88_3 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_3 and not isNil(var_88_0) then
				local var_88_4 = (arg_85_1.time_ - var_88_1) / var_88_3

				if arg_85_1.var_.highlightMatValue1039 then
					local var_88_5 = Mathf.Lerp(1, 0.5, var_88_4)
					local var_88_6 = arg_85_1.var_.highlightMatValue1039
					local var_88_7 = var_88_6.color

					var_88_7.r = var_88_5
					var_88_7.g = var_88_5
					var_88_7.b = var_88_5
					var_88_6.color = var_88_7
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_3 and arg_85_1.time_ < var_88_1 + var_88_3 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.highlightMatValue1039 then
				local var_88_8 = 0.5
				local var_88_9 = arg_85_1.var_.highlightMatValue1039
				local var_88_10 = var_88_9.color

				var_88_10.r = var_88_8
				var_88_10.g = var_88_8
				var_88_10.b = var_88_8
				var_88_9.color = var_88_10
			end

			local var_88_11 = 0
			local var_88_12 = 0.775

			if var_88_11 < arg_85_1.time_ and arg_85_1.time_ <= var_88_11 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_13 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_13

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

				local var_88_14 = arg_85_1:GetWordFromCfg(112322021)
				local var_88_15 = arg_85_1:FormatText(var_88_14.content)

				arg_85_1.text_.text = var_88_15

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_16 = 31
				local var_88_17 = utf8.len(var_88_15)
				local var_88_18 = var_88_16 <= 0 and var_88_12 or var_88_12 * (var_88_17 / var_88_16)

				if var_88_18 > 0 and var_88_12 < var_88_18 then
					arg_85_1.talkMaxDuration = var_88_18

					if var_88_18 + var_88_11 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_11
					end
				end

				arg_85_1.text_.text = var_88_15
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_19 = math.max(var_88_12, arg_85_1.talkMaxDuration)

			if var_88_11 <= arg_85_1.time_ and arg_85_1.time_ < var_88_11 + var_88_19 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_11) / var_88_19

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_11 + var_88_19 and arg_85_1.time_ < var_88_11 + var_88_19 + arg_88_0 then
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
			local var_92_0 = 0
			local var_92_1 = 0.35

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(112322022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 14
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
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
			local var_96_0 = arg_93_1.actors_["1039"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) then
				local var_96_2 = var_96_0:GetComponent("Image")

				if var_96_2 then
					arg_93_1.var_.highlightMatValue1039 = var_96_2
				end
			end

			local var_96_3 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_3 and not isNil(var_96_0) then
				local var_96_4 = (arg_93_1.time_ - var_96_1) / var_96_3

				if arg_93_1.var_.highlightMatValue1039 then
					local var_96_5 = Mathf.Lerp(0.5, 1, var_96_4)
					local var_96_6 = arg_93_1.var_.highlightMatValue1039
					local var_96_7 = var_96_6.color

					var_96_7.r = var_96_5
					var_96_7.g = var_96_5
					var_96_7.b = var_96_5
					var_96_6.color = var_96_7
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_3 and arg_93_1.time_ < var_96_1 + var_96_3 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.highlightMatValue1039 then
				local var_96_8 = 1

				var_96_0.transform:SetSiblingIndex(1)

				local var_96_9 = arg_93_1.var_.highlightMatValue1039
				local var_96_10 = var_96_9.color

				var_96_10.r = var_96_8
				var_96_10.g = var_96_8
				var_96_10.b = var_96_8
				var_96_9.color = var_96_10
			end

			local var_96_11 = 0
			local var_96_12 = 0.225

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_13 = arg_93_1:FormatText(StoryNameCfg[9].name)

				arg_93_1.leftNameTxt_.text = var_96_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_14 = arg_93_1:GetWordFromCfg(112322023)
				local var_96_15 = arg_93_1:FormatText(var_96_14.content)

				arg_93_1.text_.text = var_96_15

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_112322", "112322023", "story_v_out_112322.awb") ~= 0 then
					local var_96_19 = manager.audio:GetVoiceLength("story_v_out_112322", "112322023", "story_v_out_112322.awb") / 1000

					if var_96_19 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_11
					end

					if var_96_14.prefab_name ~= "" and arg_93_1.actors_[var_96_14.prefab_name] ~= nil then
						local var_96_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_14.prefab_name].transform, "story_v_out_112322", "112322023", "story_v_out_112322.awb")

						arg_93_1:RecordAudio("112322023", var_96_20)
						arg_93_1:RecordAudio("112322023", var_96_20)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_112322", "112322023", "story_v_out_112322.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_112322", "112322023", "story_v_out_112322.awb")
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
	assets = {},
	voices = {
		"story_v_out_112322.awb"
	}
}
