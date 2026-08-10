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

				local var_4_3 = arg_1_1:GetWordFromCfg(112282001)
				local var_4_4 = arg_1_1:FormatText(var_4_3.content)

				arg_1_1.text_.text = var_4_4

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_5 = 32
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
			end

			local var_10_5 = 0.001

			if var_10_4 <= arg_7_1.time_ and arg_7_1.time_ < var_10_4 + var_10_5 then
				local var_10_6 = (arg_7_1.time_ - var_10_4) / var_10_5
				local var_10_7 = Vector3.New(0, -500, 0)

				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1039, var_10_7, var_10_6)
			end

			if arg_7_1.time_ >= var_10_4 + var_10_5 and arg_7_1.time_ < var_10_4 + var_10_5 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0, -500, 0)
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

			local var_10_19 = 0
			local var_10_20 = 0.3

			if var_10_19 < arg_7_1.time_ and arg_7_1.time_ <= var_10_19 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_21 = arg_7_1:FormatText(StoryNameCfg[9].name)

				arg_7_1.leftNameTxt_.text = var_10_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_22 = arg_7_1:GetWordFromCfg(112282002)
				local var_10_23 = arg_7_1:FormatText(var_10_22.content)

				arg_7_1.text_.text = var_10_23

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_24 = 12
				local var_10_25 = utf8.len(var_10_23)
				local var_10_26 = var_10_24 <= 0 and var_10_20 or var_10_20 * (var_10_25 / var_10_24)

				if var_10_26 > 0 and var_10_20 < var_10_26 then
					arg_7_1.talkMaxDuration = var_10_26

					if var_10_26 + var_10_19 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_26 + var_10_19
					end
				end

				arg_7_1.text_.text = var_10_23
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282002", "story_v_out_112282.awb") ~= 0 then
					local var_10_27 = manager.audio:GetVoiceLength("story_v_out_112282", "112282002", "story_v_out_112282.awb") / 1000

					if var_10_27 + var_10_19 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_27 + var_10_19
					end

					if var_10_22.prefab_name ~= "" and arg_7_1.actors_[var_10_22.prefab_name] ~= nil then
						local var_10_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_22.prefab_name].transform, "story_v_out_112282", "112282002", "story_v_out_112282.awb")

						arg_7_1:RecordAudio("112282002", var_10_28)
						arg_7_1:RecordAudio("112282002", var_10_28)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112282", "112282002", "story_v_out_112282.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112282", "112282002", "story_v_out_112282.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_29 = math.max(var_10_20, arg_7_1.talkMaxDuration)

			if var_10_19 <= arg_7_1.time_ and arg_7_1.time_ < var_10_19 + var_10_29 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_19) / var_10_29

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_19 + var_10_29 and arg_7_1.time_ < var_10_19 + var_10_29 + arg_10_0 then
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
			local var_14_0 = "1148"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Object.Instantiate(arg_11_1.imageGo_, arg_11_1.canvasGo_.transform)

				var_14_1.transform:SetSiblingIndex(1)

				var_14_1.name = var_14_0

				local var_14_2 = var_14_1:GetComponent(typeof(Image))

				var_14_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1148")

				var_14_2:SetNativeSize()

				var_14_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_11_1.actors_[var_14_0] = var_14_1
			end

			local var_14_3 = arg_11_1.actors_["1148"].transform
			local var_14_4 = 0

			if var_14_4 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.var_.moveOldPos1148 = var_14_3.localPosition
				var_14_3.localScale = Vector3.New(1, 1, 1)
			end

			local var_14_5 = 0.001

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_5 then
				local var_14_6 = (arg_11_1.time_ - var_14_4) / var_14_5
				local var_14_7 = Vector3.New(500, -550, 0)

				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1148, var_14_7, var_14_6)
			end

			if arg_11_1.time_ >= var_14_4 + var_14_5 and arg_11_1.time_ < var_14_4 + var_14_5 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(500, -550, 0)
			end

			local var_14_8 = arg_11_1.actors_["1039"].transform
			local var_14_9 = 0

			if var_14_9 < arg_11_1.time_ and arg_11_1.time_ <= var_14_9 + arg_14_0 then
				arg_11_1.var_.moveOldPos1039 = var_14_8.localPosition
				var_14_8.localScale = Vector3.New(1, 1, 1)
			end

			local var_14_10 = 0.001

			if var_14_9 <= arg_11_1.time_ and arg_11_1.time_ < var_14_9 + var_14_10 then
				local var_14_11 = (arg_11_1.time_ - var_14_9) / var_14_10
				local var_14_12 = Vector3.New(-500, -500, 0)

				var_14_8.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1039, var_14_12, var_14_11)
			end

			if arg_11_1.time_ >= var_14_9 + var_14_10 and arg_11_1.time_ < var_14_9 + var_14_10 + arg_14_0 then
				var_14_8.localPosition = Vector3.New(-500, -500, 0)
			end

			local var_14_13 = arg_11_1.actors_["1148"]
			local var_14_14 = 0

			if var_14_14 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 and not isNil(var_14_13) then
				local var_14_15 = var_14_13:GetComponent("Image")

				if var_14_15 then
					arg_11_1.var_.highlightMatValue1148 = var_14_15
				end
			end

			local var_14_16 = 0.2

			if var_14_14 <= arg_11_1.time_ and arg_11_1.time_ < var_14_14 + var_14_16 and not isNil(var_14_13) then
				local var_14_17 = (arg_11_1.time_ - var_14_14) / var_14_16

				if arg_11_1.var_.highlightMatValue1148 then
					local var_14_18 = Mathf.Lerp(0.5, 1, var_14_17)
					local var_14_19 = arg_11_1.var_.highlightMatValue1148
					local var_14_20 = var_14_19.color

					var_14_20.r = var_14_18
					var_14_20.g = var_14_18
					var_14_20.b = var_14_18
					var_14_19.color = var_14_20
				end
			end

			if arg_11_1.time_ >= var_14_14 + var_14_16 and arg_11_1.time_ < var_14_14 + var_14_16 + arg_14_0 and not isNil(var_14_13) and arg_11_1.var_.highlightMatValue1148 then
				local var_14_21 = 1

				var_14_13.transform:SetSiblingIndex(1)

				local var_14_22 = arg_11_1.var_.highlightMatValue1148
				local var_14_23 = var_14_22.color

				var_14_23.r = var_14_21
				var_14_23.g = var_14_21
				var_14_23.b = var_14_21
				var_14_22.color = var_14_23
			end

			local var_14_24 = arg_11_1.actors_["1039"]
			local var_14_25 = 0

			if var_14_25 < arg_11_1.time_ and arg_11_1.time_ <= var_14_25 + arg_14_0 and not isNil(var_14_24) then
				local var_14_26 = var_14_24:GetComponent("Image")

				if var_14_26 then
					arg_11_1.var_.highlightMatValue1039 = var_14_26
				end
			end

			local var_14_27 = 0.2

			if var_14_25 <= arg_11_1.time_ and arg_11_1.time_ < var_14_25 + var_14_27 and not isNil(var_14_24) then
				local var_14_28 = (arg_11_1.time_ - var_14_25) / var_14_27

				if arg_11_1.var_.highlightMatValue1039 then
					local var_14_29 = Mathf.Lerp(1, 0.5, var_14_28)
					local var_14_30 = arg_11_1.var_.highlightMatValue1039
					local var_14_31 = var_14_30.color

					var_14_31.r = var_14_29
					var_14_31.g = var_14_29
					var_14_31.b = var_14_29
					var_14_30.color = var_14_31
				end
			end

			if arg_11_1.time_ >= var_14_25 + var_14_27 and arg_11_1.time_ < var_14_25 + var_14_27 + arg_14_0 and not isNil(var_14_24) and arg_11_1.var_.highlightMatValue1039 then
				local var_14_32 = 0.5
				local var_14_33 = arg_11_1.var_.highlightMatValue1039
				local var_14_34 = var_14_33.color

				var_14_34.r = var_14_32
				var_14_34.g = var_14_32
				var_14_34.b = var_14_32
				var_14_33.color = var_14_34
			end

			local var_14_35 = 0
			local var_14_36 = 0.175

			if var_14_35 < arg_11_1.time_ and arg_11_1.time_ <= var_14_35 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_37 = arg_11_1:FormatText(StoryNameCfg[8].name)

				arg_11_1.leftNameTxt_.text = var_14_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_38 = arg_11_1:GetWordFromCfg(112282003)
				local var_14_39 = arg_11_1:FormatText(var_14_38.content)

				arg_11_1.text_.text = var_14_39

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_40 = 7
				local var_14_41 = utf8.len(var_14_39)
				local var_14_42 = var_14_40 <= 0 and var_14_36 or var_14_36 * (var_14_41 / var_14_40)

				if var_14_42 > 0 and var_14_36 < var_14_42 then
					arg_11_1.talkMaxDuration = var_14_42

					if var_14_42 + var_14_35 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_42 + var_14_35
					end
				end

				arg_11_1.text_.text = var_14_39
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282003", "story_v_out_112282.awb") ~= 0 then
					local var_14_43 = manager.audio:GetVoiceLength("story_v_out_112282", "112282003", "story_v_out_112282.awb") / 1000

					if var_14_43 + var_14_35 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_43 + var_14_35
					end

					if var_14_38.prefab_name ~= "" and arg_11_1.actors_[var_14_38.prefab_name] ~= nil then
						local var_14_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_38.prefab_name].transform, "story_v_out_112282", "112282003", "story_v_out_112282.awb")

						arg_11_1:RecordAudio("112282003", var_14_44)
						arg_11_1:RecordAudio("112282003", var_14_44)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_112282", "112282003", "story_v_out_112282.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_112282", "112282003", "story_v_out_112282.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_45 = math.max(var_14_36, arg_11_1.talkMaxDuration)

			if var_14_35 <= arg_11_1.time_ and arg_11_1.time_ < var_14_35 + var_14_45 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_35) / var_14_45

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_35 + var_14_45 and arg_11_1.time_ < var_14_35 + var_14_45 + arg_14_0 then
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
			local var_18_0 = arg_15_1.actors_["1039"]
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 and not isNil(var_18_0) then
				local var_18_2 = var_18_0:GetComponent("Image")

				if var_18_2 then
					arg_15_1.var_.highlightMatValue1039 = var_18_2
				end
			end

			local var_18_3 = 0.2

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_3 and not isNil(var_18_0) then
				local var_18_4 = (arg_15_1.time_ - var_18_1) / var_18_3

				if arg_15_1.var_.highlightMatValue1039 then
					local var_18_5 = Mathf.Lerp(0.5, 1, var_18_4)
					local var_18_6 = arg_15_1.var_.highlightMatValue1039
					local var_18_7 = var_18_6.color

					var_18_7.r = var_18_5
					var_18_7.g = var_18_5
					var_18_7.b = var_18_5
					var_18_6.color = var_18_7
				end
			end

			if arg_15_1.time_ >= var_18_1 + var_18_3 and arg_15_1.time_ < var_18_1 + var_18_3 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.highlightMatValue1039 then
				local var_18_8 = 1

				var_18_0.transform:SetSiblingIndex(1)

				local var_18_9 = arg_15_1.var_.highlightMatValue1039
				local var_18_10 = var_18_9.color

				var_18_10.r = var_18_8
				var_18_10.g = var_18_8
				var_18_10.b = var_18_8
				var_18_9.color = var_18_10
			end

			local var_18_11 = arg_15_1.actors_["1148"]
			local var_18_12 = 0

			if var_18_12 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 and not isNil(var_18_11) then
				local var_18_13 = var_18_11:GetComponent("Image")

				if var_18_13 then
					arg_15_1.var_.highlightMatValue1148 = var_18_13
				end
			end

			local var_18_14 = 0.2

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_14 and not isNil(var_18_11) then
				local var_18_15 = (arg_15_1.time_ - var_18_12) / var_18_14

				if arg_15_1.var_.highlightMatValue1148 then
					local var_18_16 = Mathf.Lerp(1, 0.5, var_18_15)
					local var_18_17 = arg_15_1.var_.highlightMatValue1148
					local var_18_18 = var_18_17.color

					var_18_18.r = var_18_16
					var_18_18.g = var_18_16
					var_18_18.b = var_18_16
					var_18_17.color = var_18_18
				end
			end

			if arg_15_1.time_ >= var_18_12 + var_18_14 and arg_15_1.time_ < var_18_12 + var_18_14 + arg_18_0 and not isNil(var_18_11) and arg_15_1.var_.highlightMatValue1148 then
				local var_18_19 = 0.5
				local var_18_20 = arg_15_1.var_.highlightMatValue1148
				local var_18_21 = var_18_20.color

				var_18_21.r = var_18_19
				var_18_21.g = var_18_19
				var_18_21.b = var_18_19
				var_18_20.color = var_18_21
			end

			local var_18_22 = 0
			local var_18_23 = 0.475

			if var_18_22 < arg_15_1.time_ and arg_15_1.time_ <= var_18_22 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_24 = arg_15_1:FormatText(StoryNameCfg[9].name)

				arg_15_1.leftNameTxt_.text = var_18_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_25 = arg_15_1:GetWordFromCfg(112282004)
				local var_18_26 = arg_15_1:FormatText(var_18_25.content)

				arg_15_1.text_.text = var_18_26

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_27 = 19
				local var_18_28 = utf8.len(var_18_26)
				local var_18_29 = var_18_27 <= 0 and var_18_23 or var_18_23 * (var_18_28 / var_18_27)

				if var_18_29 > 0 and var_18_23 < var_18_29 then
					arg_15_1.talkMaxDuration = var_18_29

					if var_18_29 + var_18_22 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_29 + var_18_22
					end
				end

				arg_15_1.text_.text = var_18_26
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282004", "story_v_out_112282.awb") ~= 0 then
					local var_18_30 = manager.audio:GetVoiceLength("story_v_out_112282", "112282004", "story_v_out_112282.awb") / 1000

					if var_18_30 + var_18_22 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_30 + var_18_22
					end

					if var_18_25.prefab_name ~= "" and arg_15_1.actors_[var_18_25.prefab_name] ~= nil then
						local var_18_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_25.prefab_name].transform, "story_v_out_112282", "112282004", "story_v_out_112282.awb")

						arg_15_1:RecordAudio("112282004", var_18_31)
						arg_15_1:RecordAudio("112282004", var_18_31)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_112282", "112282004", "story_v_out_112282.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_112282", "112282004", "story_v_out_112282.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_32 = math.max(var_18_23, arg_15_1.talkMaxDuration)

			if var_18_22 <= arg_15_1.time_ and arg_15_1.time_ < var_18_22 + var_18_32 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_22) / var_18_32

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_22 + var_18_32 and arg_15_1.time_ < var_18_22 + var_18_32 + arg_18_0 then
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
			local var_22_0 = arg_19_1.actors_["1039"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) then
				local var_22_2 = var_22_0:GetComponent("Image")

				if var_22_2 then
					arg_19_1.var_.highlightMatValue1039 = var_22_2
				end
			end

			local var_22_3 = 0.2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_3 and not isNil(var_22_0) then
				local var_22_4 = (arg_19_1.time_ - var_22_1) / var_22_3

				if arg_19_1.var_.highlightMatValue1039 then
					local var_22_5 = Mathf.Lerp(1, 0.5, var_22_4)
					local var_22_6 = arg_19_1.var_.highlightMatValue1039
					local var_22_7 = var_22_6.color

					var_22_7.r = var_22_5
					var_22_7.g = var_22_5
					var_22_7.b = var_22_5
					var_22_6.color = var_22_7
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_3 and arg_19_1.time_ < var_22_1 + var_22_3 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.highlightMatValue1039 then
				local var_22_8 = 0.5
				local var_22_9 = arg_19_1.var_.highlightMatValue1039
				local var_22_10 = var_22_9.color

				var_22_10.r = var_22_8
				var_22_10.g = var_22_8
				var_22_10.b = var_22_8
				var_22_9.color = var_22_10
			end

			local var_22_11 = 0
			local var_22_12 = 0.4

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_13 = arg_19_1:FormatText(StoryNameCfg[7].name)

				arg_19_1.leftNameTxt_.text = var_22_13

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

				local var_22_14 = arg_19_1:GetWordFromCfg(112282005)
				local var_22_15 = arg_19_1:FormatText(var_22_14.content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_16 = 16
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
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_19 = math.max(var_22_12, arg_19_1.talkMaxDuration)

			if var_22_11 <= arg_19_1.time_ and arg_19_1.time_ < var_22_11 + var_22_19 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_11) / var_22_19

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_11 + var_22_19 and arg_19_1.time_ < var_22_11 + var_22_19 + arg_22_0 then
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
			local var_26_0 = arg_23_1.actors_["1039"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos1039 = var_26_0.localPosition
				var_26_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(0, -2000, 0)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1039, var_26_4, var_26_3)
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_26_5 = arg_23_1.actors_["1148"].transform
			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.var_.moveOldPos1148 = var_26_5.localPosition
				var_26_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_26_7 = 0.001

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_7 then
				local var_26_8 = (arg_23_1.time_ - var_26_6) / var_26_7
				local var_26_9 = Vector3.New(0, -550, 0)

				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1148, var_26_9, var_26_8)
			end

			if arg_23_1.time_ >= var_26_6 + var_26_7 and arg_23_1.time_ < var_26_6 + var_26_7 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(0, -550, 0)
			end

			local var_26_10 = arg_23_1.actors_["1148"]
			local var_26_11 = 0

			if var_26_11 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 and not isNil(var_26_10) then
				local var_26_12 = var_26_10:GetComponent("Image")

				if var_26_12 then
					arg_23_1.var_.highlightMatValue1148 = var_26_12
				end
			end

			local var_26_13 = 0.2

			if var_26_11 <= arg_23_1.time_ and arg_23_1.time_ < var_26_11 + var_26_13 and not isNil(var_26_10) then
				local var_26_14 = (arg_23_1.time_ - var_26_11) / var_26_13

				if arg_23_1.var_.highlightMatValue1148 then
					local var_26_15 = Mathf.Lerp(0.5, 1, var_26_14)
					local var_26_16 = arg_23_1.var_.highlightMatValue1148
					local var_26_17 = var_26_16.color

					var_26_17.r = var_26_15
					var_26_17.g = var_26_15
					var_26_17.b = var_26_15
					var_26_16.color = var_26_17
				end
			end

			if arg_23_1.time_ >= var_26_11 + var_26_13 and arg_23_1.time_ < var_26_11 + var_26_13 + arg_26_0 and not isNil(var_26_10) and arg_23_1.var_.highlightMatValue1148 then
				local var_26_18 = 1

				var_26_10.transform:SetSiblingIndex(1)

				local var_26_19 = arg_23_1.var_.highlightMatValue1148
				local var_26_20 = var_26_19.color

				var_26_20.r = var_26_18
				var_26_20.g = var_26_18
				var_26_20.b = var_26_18
				var_26_19.color = var_26_20
			end

			local var_26_21 = 0
			local var_26_22 = 0.45

			if var_26_21 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_23 = arg_23_1:FormatText(StoryNameCfg[8].name)

				arg_23_1.leftNameTxt_.text = var_26_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_24 = arg_23_1:GetWordFromCfg(112282006)
				local var_26_25 = arg_23_1:FormatText(var_26_24.content)

				arg_23_1.text_.text = var_26_25

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_26 = 18
				local var_26_27 = utf8.len(var_26_25)
				local var_26_28 = var_26_26 <= 0 and var_26_22 or var_26_22 * (var_26_27 / var_26_26)

				if var_26_28 > 0 and var_26_22 < var_26_28 then
					arg_23_1.talkMaxDuration = var_26_28

					if var_26_28 + var_26_21 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_21
					end
				end

				arg_23_1.text_.text = var_26_25
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282006", "story_v_out_112282.awb") ~= 0 then
					local var_26_29 = manager.audio:GetVoiceLength("story_v_out_112282", "112282006", "story_v_out_112282.awb") / 1000

					if var_26_29 + var_26_21 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_29 + var_26_21
					end

					if var_26_24.prefab_name ~= "" and arg_23_1.actors_[var_26_24.prefab_name] ~= nil then
						local var_26_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_24.prefab_name].transform, "story_v_out_112282", "112282006", "story_v_out_112282.awb")

						arg_23_1:RecordAudio("112282006", var_26_30)
						arg_23_1:RecordAudio("112282006", var_26_30)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_112282", "112282006", "story_v_out_112282.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_112282", "112282006", "story_v_out_112282.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_31 = math.max(var_26_22, arg_23_1.talkMaxDuration)

			if var_26_21 <= arg_23_1.time_ and arg_23_1.time_ < var_26_21 + var_26_31 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_21) / var_26_31

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_21 + var_26_31 and arg_23_1.time_ < var_26_21 + var_26_31 + arg_26_0 then
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
			local var_30_0 = arg_27_1.actors_["1148"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1148 = var_30_0.localPosition
				var_30_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(0, -2000, 0)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1148, var_30_4, var_30_3)
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_30_5 = "1081_1"

			if arg_27_1.actors_[var_30_5] == nil then
				local var_30_6 = Object.Instantiate(arg_27_1.imageGo_, arg_27_1.canvasGo_.transform)

				var_30_6.transform:SetSiblingIndex(1)

				var_30_6.name = var_30_5

				local var_30_7 = var_30_6:GetComponent(typeof(Image))

				var_30_7.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081_1")

				var_30_7:SetNativeSize()

				var_30_6.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_27_1.actors_[var_30_5] = var_30_6
			end

			local var_30_8 = arg_27_1.actors_["1081_1"].transform
			local var_30_9 = 0

			if var_30_9 < arg_27_1.time_ and arg_27_1.time_ <= var_30_9 + arg_30_0 then
				arg_27_1.var_.moveOldPos1081_1 = var_30_8.localPosition
				var_30_8.localScale = Vector3.New(1, 1, 1)
			end

			local var_30_10 = 0.001

			if var_30_9 <= arg_27_1.time_ and arg_27_1.time_ < var_30_9 + var_30_10 then
				local var_30_11 = (arg_27_1.time_ - var_30_9) / var_30_10
				local var_30_12 = Vector3.New(-500, -300, 0)

				var_30_8.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1081_1, var_30_12, var_30_11)
			end

			if arg_27_1.time_ >= var_30_9 + var_30_10 and arg_27_1.time_ < var_30_9 + var_30_10 + arg_30_0 then
				var_30_8.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_30_13 = "1081"

			if arg_27_1.actors_[var_30_13] == nil then
				local var_30_14 = Object.Instantiate(arg_27_1.imageGo_, arg_27_1.canvasGo_.transform)

				var_30_14.transform:SetSiblingIndex(1)

				var_30_14.name = var_30_13

				local var_30_15 = var_30_14:GetComponent(typeof(Image))

				var_30_15.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081")

				var_30_15:SetNativeSize()

				var_30_14.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_27_1.actors_[var_30_13] = var_30_14
			end

			local var_30_16 = arg_27_1.actors_["1081"]
			local var_30_17 = 0

			if var_30_17 < arg_27_1.time_ and arg_27_1.time_ <= var_30_17 + arg_30_0 and not isNil(var_30_16) then
				local var_30_18 = var_30_16:GetComponent("Image")

				if var_30_18 then
					arg_27_1.var_.highlightMatValue1081 = var_30_18
				end
			end

			local var_30_19 = 0.2

			if var_30_17 <= arg_27_1.time_ and arg_27_1.time_ < var_30_17 + var_30_19 and not isNil(var_30_16) then
				local var_30_20 = (arg_27_1.time_ - var_30_17) / var_30_19

				if arg_27_1.var_.highlightMatValue1081 then
					local var_30_21 = Mathf.Lerp(0.5, 1, var_30_20)
					local var_30_22 = arg_27_1.var_.highlightMatValue1081
					local var_30_23 = var_30_22.color

					var_30_23.r = var_30_21
					var_30_23.g = var_30_21
					var_30_23.b = var_30_21
					var_30_22.color = var_30_23
				end
			end

			if arg_27_1.time_ >= var_30_17 + var_30_19 and arg_27_1.time_ < var_30_17 + var_30_19 + arg_30_0 and not isNil(var_30_16) and arg_27_1.var_.highlightMatValue1081 then
				local var_30_24 = 1

				var_30_16.transform:SetSiblingIndex(1)

				local var_30_25 = arg_27_1.var_.highlightMatValue1081
				local var_30_26 = var_30_25.color

				var_30_26.r = var_30_24
				var_30_26.g = var_30_24
				var_30_26.b = var_30_24
				var_30_25.color = var_30_26
			end

			local var_30_27 = 0
			local var_30_28 = 1.05

			if var_30_27 < arg_27_1.time_ and arg_27_1.time_ <= var_30_27 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_29 = arg_27_1:FormatText(StoryNameCfg[202].name)

				arg_27_1.leftNameTxt_.text = var_30_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_30 = arg_27_1:GetWordFromCfg(112282007)
				local var_30_31 = arg_27_1:FormatText(var_30_30.content)

				arg_27_1.text_.text = var_30_31

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_32 = 42
				local var_30_33 = utf8.len(var_30_31)
				local var_30_34 = var_30_32 <= 0 and var_30_28 or var_30_28 * (var_30_33 / var_30_32)

				if var_30_34 > 0 and var_30_28 < var_30_34 then
					arg_27_1.talkMaxDuration = var_30_34

					if var_30_34 + var_30_27 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_34 + var_30_27
					end
				end

				arg_27_1.text_.text = var_30_31
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282007", "story_v_out_112282.awb") ~= 0 then
					local var_30_35 = manager.audio:GetVoiceLength("story_v_out_112282", "112282007", "story_v_out_112282.awb") / 1000

					if var_30_35 + var_30_27 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_35 + var_30_27
					end

					if var_30_30.prefab_name ~= "" and arg_27_1.actors_[var_30_30.prefab_name] ~= nil then
						local var_30_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_30.prefab_name].transform, "story_v_out_112282", "112282007", "story_v_out_112282.awb")

						arg_27_1:RecordAudio("112282007", var_30_36)
						arg_27_1:RecordAudio("112282007", var_30_36)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_112282", "112282007", "story_v_out_112282.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_112282", "112282007", "story_v_out_112282.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_37 = math.max(var_30_28, arg_27_1.talkMaxDuration)

			if var_30_27 <= arg_27_1.time_ and arg_27_1.time_ < var_30_27 + var_30_37 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_27) / var_30_37

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_27 + var_30_37 and arg_27_1.time_ < var_30_27 + var_30_37 + arg_30_0 then
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
			local var_34_0 = 0
			local var_34_1 = 0.75

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[202].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(112282008)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282008", "story_v_out_112282.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_112282", "112282008", "story_v_out_112282.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_112282", "112282008", "story_v_out_112282.awb")

						arg_31_1:RecordAudio("112282008", var_34_9)
						arg_31_1:RecordAudio("112282008", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112282", "112282008", "story_v_out_112282.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112282", "112282008", "story_v_out_112282.awb")
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
			local var_38_0 = arg_35_1.actors_["1081"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) then
				local var_38_2 = var_38_0:GetComponent("Image")

				if var_38_2 then
					arg_35_1.var_.highlightMatValue1081 = var_38_2
				end
			end

			local var_38_3 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_3 and not isNil(var_38_0) then
				local var_38_4 = (arg_35_1.time_ - var_38_1) / var_38_3

				if arg_35_1.var_.highlightMatValue1081 then
					local var_38_5 = Mathf.Lerp(1, 0.5, var_38_4)
					local var_38_6 = arg_35_1.var_.highlightMatValue1081
					local var_38_7 = var_38_6.color

					var_38_7.r = var_38_5
					var_38_7.g = var_38_5
					var_38_7.b = var_38_5
					var_38_6.color = var_38_7
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_3 and arg_35_1.time_ < var_38_1 + var_38_3 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.highlightMatValue1081 then
				local var_38_8 = 0.5
				local var_38_9 = arg_35_1.var_.highlightMatValue1081
				local var_38_10 = var_38_9.color

				var_38_10.r = var_38_8
				var_38_10.g = var_38_8
				var_38_10.b = var_38_8
				var_38_9.color = var_38_10
			end

			local var_38_11 = 0
			local var_38_12 = 0.6

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_13 = arg_35_1:FormatText(StoryNameCfg[7].name)

				arg_35_1.leftNameTxt_.text = var_38_13

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

				local var_38_14 = arg_35_1:GetWordFromCfg(112282009)
				local var_38_15 = arg_35_1:FormatText(var_38_14.content)

				arg_35_1.text_.text = var_38_15

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 24
				local var_38_17 = utf8.len(var_38_15)
				local var_38_18 = var_38_16 <= 0 and var_38_12 or var_38_12 * (var_38_17 / var_38_16)

				if var_38_18 > 0 and var_38_12 < var_38_18 then
					arg_35_1.talkMaxDuration = var_38_18

					if var_38_18 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_11
					end
				end

				arg_35_1.text_.text = var_38_15
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_19 = math.max(var_38_12, arg_35_1.talkMaxDuration)

			if var_38_11 <= arg_35_1.time_ and arg_35_1.time_ < var_38_11 + var_38_19 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_11) / var_38_19

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_11 + var_38_19 and arg_35_1.time_ < var_38_11 + var_38_19 + arg_38_0 then
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
			local var_42_0 = arg_39_1.actors_["1081"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) then
				local var_42_2 = var_42_0:GetComponent("Image")

				if var_42_2 then
					arg_39_1.var_.highlightMatValue1081 = var_42_2
				end
			end

			local var_42_3 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_3 and not isNil(var_42_0) then
				local var_42_4 = (arg_39_1.time_ - var_42_1) / var_42_3

				if arg_39_1.var_.highlightMatValue1081 then
					local var_42_5 = Mathf.Lerp(0.5, 1, var_42_4)
					local var_42_6 = arg_39_1.var_.highlightMatValue1081
					local var_42_7 = var_42_6.color

					var_42_7.r = var_42_5
					var_42_7.g = var_42_5
					var_42_7.b = var_42_5
					var_42_6.color = var_42_7
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_3 and arg_39_1.time_ < var_42_1 + var_42_3 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.highlightMatValue1081 then
				local var_42_8 = 1

				var_42_0.transform:SetSiblingIndex(1)

				local var_42_9 = arg_39_1.var_.highlightMatValue1081
				local var_42_10 = var_42_9.color

				var_42_10.r = var_42_8
				var_42_10.g = var_42_8
				var_42_10.b = var_42_8
				var_42_9.color = var_42_10
			end

			local var_42_11 = 0
			local var_42_12 = 0.475

			if var_42_11 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_13 = arg_39_1:FormatText(StoryNameCfg[202].name)

				arg_39_1.leftNameTxt_.text = var_42_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_14 = arg_39_1:GetWordFromCfg(112282010)
				local var_42_15 = arg_39_1:FormatText(var_42_14.content)

				arg_39_1.text_.text = var_42_15

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_16 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282010", "story_v_out_112282.awb") ~= 0 then
					local var_42_19 = manager.audio:GetVoiceLength("story_v_out_112282", "112282010", "story_v_out_112282.awb") / 1000

					if var_42_19 + var_42_11 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_19 + var_42_11
					end

					if var_42_14.prefab_name ~= "" and arg_39_1.actors_[var_42_14.prefab_name] ~= nil then
						local var_42_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_14.prefab_name].transform, "story_v_out_112282", "112282010", "story_v_out_112282.awb")

						arg_39_1:RecordAudio("112282010", var_42_20)
						arg_39_1:RecordAudio("112282010", var_42_20)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_112282", "112282010", "story_v_out_112282.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_112282", "112282010", "story_v_out_112282.awb")
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
			local var_46_0 = 0
			local var_46_1 = 0.9

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[202].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:GetWordFromCfg(112282011)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282011", "story_v_out_112282.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_112282", "112282011", "story_v_out_112282.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_112282", "112282011", "story_v_out_112282.awb")

						arg_43_1:RecordAudio("112282011", var_46_9)
						arg_43_1:RecordAudio("112282011", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_112282", "112282011", "story_v_out_112282.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_112282", "112282011", "story_v_out_112282.awb")
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
			local var_50_0 = 0
			local var_50_1 = 0.775

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[202].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:GetWordFromCfg(112282012)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282012", "story_v_out_112282.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_112282", "112282012", "story_v_out_112282.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_112282", "112282012", "story_v_out_112282.awb")

						arg_47_1:RecordAudio("112282012", var_50_9)
						arg_47_1:RecordAudio("112282012", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112282", "112282012", "story_v_out_112282.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112282", "112282012", "story_v_out_112282.awb")
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
			local var_54_0 = arg_51_1.actors_["1081"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) then
				local var_54_2 = var_54_0:GetComponent("Image")

				if var_54_2 then
					arg_51_1.var_.highlightMatValue1081 = var_54_2
				end
			end

			local var_54_3 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_3 and not isNil(var_54_0) then
				local var_54_4 = (arg_51_1.time_ - var_54_1) / var_54_3

				if arg_51_1.var_.highlightMatValue1081 then
					local var_54_5 = Mathf.Lerp(1, 0.5, var_54_4)
					local var_54_6 = arg_51_1.var_.highlightMatValue1081
					local var_54_7 = var_54_6.color

					var_54_7.r = var_54_5
					var_54_7.g = var_54_5
					var_54_7.b = var_54_5
					var_54_6.color = var_54_7
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_3 and arg_51_1.time_ < var_54_1 + var_54_3 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.highlightMatValue1081 then
				local var_54_8 = 0.5
				local var_54_9 = arg_51_1.var_.highlightMatValue1081
				local var_54_10 = var_54_9.color

				var_54_10.r = var_54_8
				var_54_10.g = var_54_8
				var_54_10.b = var_54_8
				var_54_9.color = var_54_10
			end

			local var_54_11 = 0
			local var_54_12 = 0.075

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_13 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_13

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

				local var_54_14 = arg_51_1:GetWordFromCfg(112282013)
				local var_54_15 = arg_51_1:FormatText(var_54_14.content)

				arg_51_1.text_.text = var_54_15

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_16 = 3
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
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_19 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_19 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_19

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_19 and arg_51_1.time_ < var_54_11 + var_54_19 + arg_54_0 then
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
			local var_58_0 = arg_55_1.actors_["1081_1"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1081_1 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, -2000, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1081_1, var_58_4, var_58_3)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_5 = arg_55_1.actors_["1148"].transform
			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.var_.moveOldPos1148 = var_58_5.localPosition
				var_58_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_58_7 = 0.001

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_7 then
				local var_58_8 = (arg_55_1.time_ - var_58_6) / var_58_7
				local var_58_9 = Vector3.New(0, -550, 0)

				var_58_5.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1148, var_58_9, var_58_8)
			end

			if arg_55_1.time_ >= var_58_6 + var_58_7 and arg_55_1.time_ < var_58_6 + var_58_7 + arg_58_0 then
				var_58_5.localPosition = Vector3.New(0, -550, 0)
			end

			local var_58_10 = arg_55_1.actors_["1148"]
			local var_58_11 = 0

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 and not isNil(var_58_10) then
				local var_58_12 = var_58_10:GetComponent("Image")

				if var_58_12 then
					arg_55_1.var_.highlightMatValue1148 = var_58_12
				end
			end

			local var_58_13 = 0.2

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_13 and not isNil(var_58_10) then
				local var_58_14 = (arg_55_1.time_ - var_58_11) / var_58_13

				if arg_55_1.var_.highlightMatValue1148 then
					local var_58_15 = Mathf.Lerp(0.5, 1, var_58_14)
					local var_58_16 = arg_55_1.var_.highlightMatValue1148
					local var_58_17 = var_58_16.color

					var_58_17.r = var_58_15
					var_58_17.g = var_58_15
					var_58_17.b = var_58_15
					var_58_16.color = var_58_17
				end
			end

			if arg_55_1.time_ >= var_58_11 + var_58_13 and arg_55_1.time_ < var_58_11 + var_58_13 + arg_58_0 and not isNil(var_58_10) and arg_55_1.var_.highlightMatValue1148 then
				local var_58_18 = 1

				var_58_10.transform:SetSiblingIndex(1)

				local var_58_19 = arg_55_1.var_.highlightMatValue1148
				local var_58_20 = var_58_19.color

				var_58_20.r = var_58_18
				var_58_20.g = var_58_18
				var_58_20.b = var_58_18
				var_58_19.color = var_58_20
			end

			local var_58_21 = 0
			local var_58_22 = 0.775

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_23 = arg_55_1:FormatText(StoryNameCfg[8].name)

				arg_55_1.leftNameTxt_.text = var_58_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_24 = arg_55_1:GetWordFromCfg(112282014)
				local var_58_25 = arg_55_1:FormatText(var_58_24.content)

				arg_55_1.text_.text = var_58_25

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_26 = 31
				local var_58_27 = utf8.len(var_58_25)
				local var_58_28 = var_58_26 <= 0 and var_58_22 or var_58_22 * (var_58_27 / var_58_26)

				if var_58_28 > 0 and var_58_22 < var_58_28 then
					arg_55_1.talkMaxDuration = var_58_28

					if var_58_28 + var_58_21 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_28 + var_58_21
					end
				end

				arg_55_1.text_.text = var_58_25
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282014", "story_v_out_112282.awb") ~= 0 then
					local var_58_29 = manager.audio:GetVoiceLength("story_v_out_112282", "112282014", "story_v_out_112282.awb") / 1000

					if var_58_29 + var_58_21 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_29 + var_58_21
					end

					if var_58_24.prefab_name ~= "" and arg_55_1.actors_[var_58_24.prefab_name] ~= nil then
						local var_58_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_24.prefab_name].transform, "story_v_out_112282", "112282014", "story_v_out_112282.awb")

						arg_55_1:RecordAudio("112282014", var_58_30)
						arg_55_1:RecordAudio("112282014", var_58_30)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_112282", "112282014", "story_v_out_112282.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_112282", "112282014", "story_v_out_112282.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_31 = math.max(var_58_22, arg_55_1.talkMaxDuration)

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_31 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_21) / var_58_31

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_21 + var_58_31 and arg_55_1.time_ < var_58_21 + var_58_31 + arg_58_0 then
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
			local var_62_0 = arg_59_1.actors_["1148"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1148 = var_62_0.localPosition
				var_62_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -2000, 0)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1148, var_62_4, var_62_3)
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_62_5 = arg_59_1.actors_["1081"]
			local var_62_6 = 0

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 and not isNil(var_62_5) then
				local var_62_7 = var_62_5:GetComponent("Image")

				if var_62_7 then
					arg_59_1.var_.highlightMatValue1081 = var_62_7
				end
			end

			local var_62_8 = 0.2

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_8 and not isNil(var_62_5) then
				local var_62_9 = (arg_59_1.time_ - var_62_6) / var_62_8

				if arg_59_1.var_.highlightMatValue1081 then
					local var_62_10 = Mathf.Lerp(0.5, 1, var_62_9)
					local var_62_11 = arg_59_1.var_.highlightMatValue1081
					local var_62_12 = var_62_11.color

					var_62_12.r = var_62_10
					var_62_12.g = var_62_10
					var_62_12.b = var_62_10
					var_62_11.color = var_62_12
				end
			end

			if arg_59_1.time_ >= var_62_6 + var_62_8 and arg_59_1.time_ < var_62_6 + var_62_8 + arg_62_0 and not isNil(var_62_5) and arg_59_1.var_.highlightMatValue1081 then
				local var_62_13 = 1

				var_62_5.transform:SetSiblingIndex(1)

				local var_62_14 = arg_59_1.var_.highlightMatValue1081
				local var_62_15 = var_62_14.color

				var_62_15.r = var_62_13
				var_62_15.g = var_62_13
				var_62_15.b = var_62_13
				var_62_14.color = var_62_15
			end

			local var_62_16 = arg_59_1.actors_["1081_1"].transform
			local var_62_17 = 0

			if var_62_17 < arg_59_1.time_ and arg_59_1.time_ <= var_62_17 + arg_62_0 then
				arg_59_1.var_.moveOldPos1081_1 = var_62_16.localPosition
				var_62_16.localScale = Vector3.New(1, 1, 1)
			end

			local var_62_18 = 0.001

			if var_62_17 <= arg_59_1.time_ and arg_59_1.time_ < var_62_17 + var_62_18 then
				local var_62_19 = (arg_59_1.time_ - var_62_17) / var_62_18
				local var_62_20 = Vector3.New(-500, -300, 0)

				var_62_16.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1081_1, var_62_20, var_62_19)
			end

			if arg_59_1.time_ >= var_62_17 + var_62_18 and arg_59_1.time_ < var_62_17 + var_62_18 + arg_62_0 then
				var_62_16.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_62_21 = 0
			local var_62_22 = 1.15

			if var_62_21 < arg_59_1.time_ and arg_59_1.time_ <= var_62_21 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_23 = arg_59_1:FormatText(StoryNameCfg[202].name)

				arg_59_1.leftNameTxt_.text = var_62_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_24 = arg_59_1:GetWordFromCfg(112282015)
				local var_62_25 = arg_59_1:FormatText(var_62_24.content)

				arg_59_1.text_.text = var_62_25

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_26 = 46
				local var_62_27 = utf8.len(var_62_25)
				local var_62_28 = var_62_26 <= 0 and var_62_22 or var_62_22 * (var_62_27 / var_62_26)

				if var_62_28 > 0 and var_62_22 < var_62_28 then
					arg_59_1.talkMaxDuration = var_62_28

					if var_62_28 + var_62_21 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_28 + var_62_21
					end
				end

				arg_59_1.text_.text = var_62_25
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282015", "story_v_out_112282.awb") ~= 0 then
					local var_62_29 = manager.audio:GetVoiceLength("story_v_out_112282", "112282015", "story_v_out_112282.awb") / 1000

					if var_62_29 + var_62_21 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_29 + var_62_21
					end

					if var_62_24.prefab_name ~= "" and arg_59_1.actors_[var_62_24.prefab_name] ~= nil then
						local var_62_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_24.prefab_name].transform, "story_v_out_112282", "112282015", "story_v_out_112282.awb")

						arg_59_1:RecordAudio("112282015", var_62_30)
						arg_59_1:RecordAudio("112282015", var_62_30)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112282", "112282015", "story_v_out_112282.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112282", "112282015", "story_v_out_112282.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_31 = math.max(var_62_22, arg_59_1.talkMaxDuration)

			if var_62_21 <= arg_59_1.time_ and arg_59_1.time_ < var_62_21 + var_62_31 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_21) / var_62_31

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_21 + var_62_31 and arg_59_1.time_ < var_62_21 + var_62_31 + arg_62_0 then
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
			local var_66_0 = arg_63_1.actors_["1081_1"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos1081_1 = var_66_0.localPosition
				var_66_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_66_2 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2
				local var_66_4 = Vector3.New(0, -2000, 0)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1081_1, var_66_4, var_66_3)
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_5 = arg_63_1.actors_["1148"]
			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 and not isNil(var_66_5) then
				local var_66_7 = var_66_5:GetComponent("Image")

				if var_66_7 then
					arg_63_1.var_.highlightMatValue1148 = var_66_7
				end
			end

			local var_66_8 = 0.2

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_8 and not isNil(var_66_5) then
				local var_66_9 = (arg_63_1.time_ - var_66_6) / var_66_8

				if arg_63_1.var_.highlightMatValue1148 then
					local var_66_10 = Mathf.Lerp(0.5, 1, var_66_9)
					local var_66_11 = arg_63_1.var_.highlightMatValue1148
					local var_66_12 = var_66_11.color

					var_66_12.r = var_66_10
					var_66_12.g = var_66_10
					var_66_12.b = var_66_10
					var_66_11.color = var_66_12
				end
			end

			if arg_63_1.time_ >= var_66_6 + var_66_8 and arg_63_1.time_ < var_66_6 + var_66_8 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.highlightMatValue1148 then
				local var_66_13 = 1

				var_66_5.transform:SetSiblingIndex(1)

				local var_66_14 = arg_63_1.var_.highlightMatValue1148
				local var_66_15 = var_66_14.color

				var_66_15.r = var_66_13
				var_66_15.g = var_66_13
				var_66_15.b = var_66_13
				var_66_14.color = var_66_15
			end

			local var_66_16 = arg_63_1.actors_["1148"].transform
			local var_66_17 = 0

			if var_66_17 < arg_63_1.time_ and arg_63_1.time_ <= var_66_17 + arg_66_0 then
				arg_63_1.var_.moveOldPos1148 = var_66_16.localPosition
				var_66_16.localScale = Vector3.New(1, 1, 1)
			end

			local var_66_18 = 0.001

			if var_66_17 <= arg_63_1.time_ and arg_63_1.time_ < var_66_17 + var_66_18 then
				local var_66_19 = (arg_63_1.time_ - var_66_17) / var_66_18
				local var_66_20 = Vector3.New(0, -550, 0)

				var_66_16.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1148, var_66_20, var_66_19)
			end

			if arg_63_1.time_ >= var_66_17 + var_66_18 and arg_63_1.time_ < var_66_17 + var_66_18 + arg_66_0 then
				var_66_16.localPosition = Vector3.New(0, -550, 0)
			end

			local var_66_21 = 0
			local var_66_22 = 0.05

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_23 = arg_63_1:FormatText(StoryNameCfg[8].name)

				arg_63_1.leftNameTxt_.text = var_66_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_24 = arg_63_1:GetWordFromCfg(112282016)
				local var_66_25 = arg_63_1:FormatText(var_66_24.content)

				arg_63_1.text_.text = var_66_25

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_26 = 2
				local var_66_27 = utf8.len(var_66_25)
				local var_66_28 = var_66_26 <= 0 and var_66_22 or var_66_22 * (var_66_27 / var_66_26)

				if var_66_28 > 0 and var_66_22 < var_66_28 then
					arg_63_1.talkMaxDuration = var_66_28

					if var_66_28 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_28 + var_66_21
					end
				end

				arg_63_1.text_.text = var_66_25
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282016", "story_v_out_112282.awb") ~= 0 then
					local var_66_29 = manager.audio:GetVoiceLength("story_v_out_112282", "112282016", "story_v_out_112282.awb") / 1000

					if var_66_29 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_29 + var_66_21
					end

					if var_66_24.prefab_name ~= "" and arg_63_1.actors_[var_66_24.prefab_name] ~= nil then
						local var_66_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_24.prefab_name].transform, "story_v_out_112282", "112282016", "story_v_out_112282.awb")

						arg_63_1:RecordAudio("112282016", var_66_30)
						arg_63_1:RecordAudio("112282016", var_66_30)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112282", "112282016", "story_v_out_112282.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112282", "112282016", "story_v_out_112282.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_31 = math.max(var_66_22, arg_63_1.talkMaxDuration)

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_31 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_21) / var_66_31

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_21 + var_66_31 and arg_63_1.time_ < var_66_21 + var_66_31 + arg_66_0 then
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
			local var_70_0 = arg_67_1.actors_["1148"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1148 = var_70_0.localPosition
				var_70_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, -2000, -5)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1148, var_70_4, var_70_3)
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -2000, -5)
			end

			local var_70_5 = "1084"

			if arg_67_1.actors_[var_70_5] == nil then
				local var_70_6 = Object.Instantiate(arg_67_1.imageGo_, arg_67_1.canvasGo_.transform)

				var_70_6.transform:SetSiblingIndex(1)

				var_70_6.name = var_70_5

				local var_70_7 = var_70_6:GetComponent(typeof(Image))

				var_70_7.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1084")

				var_70_7:SetNativeSize()

				var_70_6.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_67_1.actors_[var_70_5] = var_70_6
			end

			local var_70_8 = arg_67_1.actors_["1084"].transform
			local var_70_9 = 0

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1.var_.moveOldPos1084 = var_70_8.localPosition
				var_70_8.localScale = Vector3.New(1, 1, 1)
			end

			local var_70_10 = 0.001

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_10 then
				local var_70_11 = (arg_67_1.time_ - var_70_9) / var_70_10
				local var_70_12 = Vector3.New(0, -500, -5)

				var_70_8.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1084, var_70_12, var_70_11)
			end

			if arg_67_1.time_ >= var_70_9 + var_70_10 and arg_67_1.time_ < var_70_9 + var_70_10 + arg_70_0 then
				var_70_8.localPosition = Vector3.New(0, -500, -5)
			end

			local var_70_13 = arg_67_1.actors_["1084"]
			local var_70_14 = 0

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 and not isNil(var_70_13) then
				local var_70_15 = var_70_13:GetComponent("Image")

				if var_70_15 then
					arg_67_1.var_.highlightMatValue1084 = var_70_15
				end
			end

			local var_70_16 = 0.2

			if var_70_14 <= arg_67_1.time_ and arg_67_1.time_ < var_70_14 + var_70_16 and not isNil(var_70_13) then
				local var_70_17 = (arg_67_1.time_ - var_70_14) / var_70_16

				if arg_67_1.var_.highlightMatValue1084 then
					local var_70_18 = Mathf.Lerp(0.5, 1, var_70_17)
					local var_70_19 = arg_67_1.var_.highlightMatValue1084
					local var_70_20 = var_70_19.color

					var_70_20.r = var_70_18
					var_70_20.g = var_70_18
					var_70_20.b = var_70_18
					var_70_19.color = var_70_20
				end
			end

			if arg_67_1.time_ >= var_70_14 + var_70_16 and arg_67_1.time_ < var_70_14 + var_70_16 + arg_70_0 and not isNil(var_70_13) and arg_67_1.var_.highlightMatValue1084 then
				local var_70_21 = 1

				var_70_13.transform:SetSiblingIndex(1)

				local var_70_22 = arg_67_1.var_.highlightMatValue1084
				local var_70_23 = var_70_22.color

				var_70_23.r = var_70_21
				var_70_23.g = var_70_21
				var_70_23.b = var_70_21
				var_70_22.color = var_70_23
			end

			local var_70_24 = 0
			local var_70_25 = 0.8

			if var_70_24 < arg_67_1.time_ and arg_67_1.time_ <= var_70_24 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_26 = arg_67_1:FormatText(StoryNameCfg[6].name)

				arg_67_1.leftNameTxt_.text = var_70_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_27 = arg_67_1:GetWordFromCfg(112282017)
				local var_70_28 = arg_67_1:FormatText(var_70_27.content)

				arg_67_1.text_.text = var_70_28

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_29 = 32
				local var_70_30 = utf8.len(var_70_28)
				local var_70_31 = var_70_29 <= 0 and var_70_25 or var_70_25 * (var_70_30 / var_70_29)

				if var_70_31 > 0 and var_70_25 < var_70_31 then
					arg_67_1.talkMaxDuration = var_70_31

					if var_70_31 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_31 + var_70_24
					end
				end

				arg_67_1.text_.text = var_70_28
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282017", "story_v_out_112282.awb") ~= 0 then
					local var_70_32 = manager.audio:GetVoiceLength("story_v_out_112282", "112282017", "story_v_out_112282.awb") / 1000

					if var_70_32 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_32 + var_70_24
					end

					if var_70_27.prefab_name ~= "" and arg_67_1.actors_[var_70_27.prefab_name] ~= nil then
						local var_70_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_27.prefab_name].transform, "story_v_out_112282", "112282017", "story_v_out_112282.awb")

						arg_67_1:RecordAudio("112282017", var_70_33)
						arg_67_1:RecordAudio("112282017", var_70_33)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112282", "112282017", "story_v_out_112282.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112282", "112282017", "story_v_out_112282.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_34 = math.max(var_70_25, arg_67_1.talkMaxDuration)

			if var_70_24 <= arg_67_1.time_ and arg_67_1.time_ < var_70_24 + var_70_34 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_24) / var_70_34

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_24 + var_70_34 and arg_67_1.time_ < var_70_24 + var_70_34 + arg_70_0 then
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
			local var_74_0 = 0
			local var_74_1 = 0.875

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(112282018)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 35
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282018", "story_v_out_112282.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_112282", "112282018", "story_v_out_112282.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_112282", "112282018", "story_v_out_112282.awb")

						arg_71_1:RecordAudio("112282018", var_74_9)
						arg_71_1:RecordAudio("112282018", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_112282", "112282018", "story_v_out_112282.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_112282", "112282018", "story_v_out_112282.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
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
			local var_78_0 = arg_75_1.actors_["1084"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1084 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, -2000, 0)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1084, var_78_4, var_78_3)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_78_5 = "1027"

			if arg_75_1.actors_[var_78_5] == nil then
				local var_78_6 = Object.Instantiate(arg_75_1.imageGo_, arg_75_1.canvasGo_.transform)

				var_78_6.transform:SetSiblingIndex(1)

				var_78_6.name = var_78_5

				local var_78_7 = var_78_6:GetComponent(typeof(Image))

				var_78_7.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1027")

				var_78_7:SetNativeSize()

				var_78_6.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_75_1.actors_[var_78_5] = var_78_6
			end

			local var_78_8 = arg_75_1.actors_["1027"].transform
			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.var_.moveOldPos1027 = var_78_8.localPosition
				var_78_8.localScale = Vector3.New(1, 1, 1)
			end

			local var_78_10 = 0.001

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_10 then
				local var_78_11 = (arg_75_1.time_ - var_78_9) / var_78_10
				local var_78_12 = Vector3.New(0, -500, 0)

				var_78_8.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1027, var_78_12, var_78_11)
			end

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 then
				var_78_8.localPosition = Vector3.New(0, -500, 0)
			end

			local var_78_13 = arg_75_1.actors_["1027"]
			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 and not isNil(var_78_13) then
				local var_78_15 = var_78_13:GetComponent("Image")

				if var_78_15 then
					arg_75_1.var_.highlightMatValue1027 = var_78_15
				end
			end

			local var_78_16 = 0.2

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_16 and not isNil(var_78_13) then
				local var_78_17 = (arg_75_1.time_ - var_78_14) / var_78_16

				if arg_75_1.var_.highlightMatValue1027 then
					local var_78_18 = Mathf.Lerp(0.5, 1, var_78_17)
					local var_78_19 = arg_75_1.var_.highlightMatValue1027
					local var_78_20 = var_78_19.color

					var_78_20.r = var_78_18
					var_78_20.g = var_78_18
					var_78_20.b = var_78_18
					var_78_19.color = var_78_20
				end
			end

			if arg_75_1.time_ >= var_78_14 + var_78_16 and arg_75_1.time_ < var_78_14 + var_78_16 + arg_78_0 and not isNil(var_78_13) and arg_75_1.var_.highlightMatValue1027 then
				local var_78_21 = 1

				var_78_13.transform:SetSiblingIndex(1)

				local var_78_22 = arg_75_1.var_.highlightMatValue1027
				local var_78_23 = var_78_22.color

				var_78_23.r = var_78_21
				var_78_23.g = var_78_21
				var_78_23.b = var_78_21
				var_78_22.color = var_78_23
			end

			local var_78_24 = 0
			local var_78_25 = 0.25

			if var_78_24 < arg_75_1.time_ and arg_75_1.time_ <= var_78_24 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_26 = arg_75_1:FormatText(StoryNameCfg[56].name)

				arg_75_1.leftNameTxt_.text = var_78_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_27 = arg_75_1:GetWordFromCfg(112282019)
				local var_78_28 = arg_75_1:FormatText(var_78_27.content)

				arg_75_1.text_.text = var_78_28

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_29 = 10
				local var_78_30 = utf8.len(var_78_28)
				local var_78_31 = var_78_29 <= 0 and var_78_25 or var_78_25 * (var_78_30 / var_78_29)

				if var_78_31 > 0 and var_78_25 < var_78_31 then
					arg_75_1.talkMaxDuration = var_78_31

					if var_78_31 + var_78_24 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_31 + var_78_24
					end
				end

				arg_75_1.text_.text = var_78_28
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282019", "story_v_out_112282.awb") ~= 0 then
					local var_78_32 = manager.audio:GetVoiceLength("story_v_out_112282", "112282019", "story_v_out_112282.awb") / 1000

					if var_78_32 + var_78_24 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_32 + var_78_24
					end

					if var_78_27.prefab_name ~= "" and arg_75_1.actors_[var_78_27.prefab_name] ~= nil then
						local var_78_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_27.prefab_name].transform, "story_v_out_112282", "112282019", "story_v_out_112282.awb")

						arg_75_1:RecordAudio("112282019", var_78_33)
						arg_75_1:RecordAudio("112282019", var_78_33)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_112282", "112282019", "story_v_out_112282.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_112282", "112282019", "story_v_out_112282.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_34 = math.max(var_78_25, arg_75_1.talkMaxDuration)

			if var_78_24 <= arg_75_1.time_ and arg_75_1.time_ < var_78_24 + var_78_34 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_24) / var_78_34

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_24 + var_78_34 and arg_75_1.time_ < var_78_24 + var_78_34 + arg_78_0 then
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
			local var_82_0 = arg_79_1.actors_["1027"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1027 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, -2000, 0)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1027, var_82_4, var_82_3)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_5 = arg_79_1.actors_["1148"].transform
			local var_82_6 = 0

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.var_.moveOldPos1148 = var_82_5.localPosition
				var_82_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_82_7 = 0.001

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_7 then
				local var_82_8 = (arg_79_1.time_ - var_82_6) / var_82_7
				local var_82_9 = Vector3.New(0, -550, 0)

				var_82_5.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1148, var_82_9, var_82_8)
			end

			if arg_79_1.time_ >= var_82_6 + var_82_7 and arg_79_1.time_ < var_82_6 + var_82_7 + arg_82_0 then
				var_82_5.localPosition = Vector3.New(0, -550, 0)
			end

			local var_82_10 = arg_79_1.actors_["1148"]
			local var_82_11 = 0

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 and not isNil(var_82_10) then
				local var_82_12 = var_82_10:GetComponent("Image")

				if var_82_12 then
					arg_79_1.var_.highlightMatValue1148 = var_82_12
				end
			end

			local var_82_13 = 0.2

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_13 and not isNil(var_82_10) then
				local var_82_14 = (arg_79_1.time_ - var_82_11) / var_82_13

				if arg_79_1.var_.highlightMatValue1148 then
					local var_82_15 = Mathf.Lerp(0.5, 1, var_82_14)
					local var_82_16 = arg_79_1.var_.highlightMatValue1148
					local var_82_17 = var_82_16.color

					var_82_17.r = var_82_15
					var_82_17.g = var_82_15
					var_82_17.b = var_82_15
					var_82_16.color = var_82_17
				end
			end

			if arg_79_1.time_ >= var_82_11 + var_82_13 and arg_79_1.time_ < var_82_11 + var_82_13 + arg_82_0 and not isNil(var_82_10) and arg_79_1.var_.highlightMatValue1148 then
				local var_82_18 = 1

				var_82_10.transform:SetSiblingIndex(1)

				local var_82_19 = arg_79_1.var_.highlightMatValue1148
				local var_82_20 = var_82_19.color

				var_82_20.r = var_82_18
				var_82_20.g = var_82_18
				var_82_20.b = var_82_18
				var_82_19.color = var_82_20
			end

			local var_82_21 = 0
			local var_82_22 = 0.775

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_23 = arg_79_1:FormatText(StoryNameCfg[8].name)

				arg_79_1.leftNameTxt_.text = var_82_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:GetWordFromCfg(112282020)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.text_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 31
				local var_82_27 = utf8.len(var_82_25)
				local var_82_28 = var_82_26 <= 0 and var_82_22 or var_82_22 * (var_82_27 / var_82_26)

				if var_82_28 > 0 and var_82_22 < var_82_28 then
					arg_79_1.talkMaxDuration = var_82_28

					if var_82_28 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_25
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282020", "story_v_out_112282.awb") ~= 0 then
					local var_82_29 = manager.audio:GetVoiceLength("story_v_out_112282", "112282020", "story_v_out_112282.awb") / 1000

					if var_82_29 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_29 + var_82_21
					end

					if var_82_24.prefab_name ~= "" and arg_79_1.actors_[var_82_24.prefab_name] ~= nil then
						local var_82_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_24.prefab_name].transform, "story_v_out_112282", "112282020", "story_v_out_112282.awb")

						arg_79_1:RecordAudio("112282020", var_82_30)
						arg_79_1:RecordAudio("112282020", var_82_30)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_112282", "112282020", "story_v_out_112282.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_112282", "112282020", "story_v_out_112282.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_31 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_31 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_31

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_31 and arg_79_1.time_ < var_82_21 + var_82_31 + arg_82_0 then
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
			local var_86_0 = arg_83_1.actors_["1148"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1148 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, -2000, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1148, var_86_4, var_86_3)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_86_5 = arg_83_1.actors_["1081_1"].transform
			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.var_.moveOldPos1081_1 = var_86_5.localPosition
				var_86_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_86_7 = 0.001

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_7 then
				local var_86_8 = (arg_83_1.time_ - var_86_6) / var_86_7
				local var_86_9 = Vector3.New(-500, -300, 0)

				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1081_1, var_86_9, var_86_8)
			end

			if arg_83_1.time_ >= var_86_6 + var_86_7 and arg_83_1.time_ < var_86_6 + var_86_7 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_86_10 = arg_83_1.actors_["1081"]
			local var_86_11 = 0

			if var_86_11 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 and not isNil(var_86_10) then
				local var_86_12 = var_86_10:GetComponent("Image")

				if var_86_12 then
					arg_83_1.var_.highlightMatValue1081 = var_86_12
				end
			end

			local var_86_13 = 0.2

			if var_86_11 <= arg_83_1.time_ and arg_83_1.time_ < var_86_11 + var_86_13 and not isNil(var_86_10) then
				local var_86_14 = (arg_83_1.time_ - var_86_11) / var_86_13

				if arg_83_1.var_.highlightMatValue1081 then
					local var_86_15 = Mathf.Lerp(0.5, 1, var_86_14)
					local var_86_16 = arg_83_1.var_.highlightMatValue1081
					local var_86_17 = var_86_16.color

					var_86_17.r = var_86_15
					var_86_17.g = var_86_15
					var_86_17.b = var_86_15
					var_86_16.color = var_86_17
				end
			end

			if arg_83_1.time_ >= var_86_11 + var_86_13 and arg_83_1.time_ < var_86_11 + var_86_13 + arg_86_0 and not isNil(var_86_10) and arg_83_1.var_.highlightMatValue1081 then
				local var_86_18 = 1

				var_86_10.transform:SetSiblingIndex(1)

				local var_86_19 = arg_83_1.var_.highlightMatValue1081
				local var_86_20 = var_86_19.color

				var_86_20.r = var_86_18
				var_86_20.g = var_86_18
				var_86_20.b = var_86_18
				var_86_19.color = var_86_20
			end

			local var_86_21 = 0
			local var_86_22 = 0.2

			if var_86_21 < arg_83_1.time_ and arg_83_1.time_ <= var_86_21 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_23 = arg_83_1:FormatText(StoryNameCfg[202].name)

				arg_83_1.leftNameTxt_.text = var_86_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_24 = arg_83_1:GetWordFromCfg(112282021)
				local var_86_25 = arg_83_1:FormatText(var_86_24.content)

				arg_83_1.text_.text = var_86_25

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_26 = 8
				local var_86_27 = utf8.len(var_86_25)
				local var_86_28 = var_86_26 <= 0 and var_86_22 or var_86_22 * (var_86_27 / var_86_26)

				if var_86_28 > 0 and var_86_22 < var_86_28 then
					arg_83_1.talkMaxDuration = var_86_28

					if var_86_28 + var_86_21 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_28 + var_86_21
					end
				end

				arg_83_1.text_.text = var_86_25
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282021", "story_v_out_112282.awb") ~= 0 then
					local var_86_29 = manager.audio:GetVoiceLength("story_v_out_112282", "112282021", "story_v_out_112282.awb") / 1000

					if var_86_29 + var_86_21 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_29 + var_86_21
					end

					if var_86_24.prefab_name ~= "" and arg_83_1.actors_[var_86_24.prefab_name] ~= nil then
						local var_86_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_24.prefab_name].transform, "story_v_out_112282", "112282021", "story_v_out_112282.awb")

						arg_83_1:RecordAudio("112282021", var_86_30)
						arg_83_1:RecordAudio("112282021", var_86_30)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_112282", "112282021", "story_v_out_112282.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_112282", "112282021", "story_v_out_112282.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_31 = math.max(var_86_22, arg_83_1.talkMaxDuration)

			if var_86_21 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_31 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_21) / var_86_31

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_21 + var_86_31 and arg_83_1.time_ < var_86_21 + var_86_31 + arg_86_0 then
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
			local var_90_0 = arg_87_1.actors_["1148"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1148 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, -550, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1148, var_90_4, var_90_3)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -550, 0)
			end

			local var_90_5 = arg_87_1.actors_["1081_1"].transform
			local var_90_6 = 0

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.var_.moveOldPos1081_1 = var_90_5.localPosition
				var_90_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_90_7 = 0.001

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_7 then
				local var_90_8 = (arg_87_1.time_ - var_90_6) / var_90_7
				local var_90_9 = Vector3.New(0, -2000, 0)

				var_90_5.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1081_1, var_90_9, var_90_8)
			end

			if arg_87_1.time_ >= var_90_6 + var_90_7 and arg_87_1.time_ < var_90_6 + var_90_7 + arg_90_0 then
				var_90_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_10 = arg_87_1.actors_["1148"]
			local var_90_11 = 0

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 and not isNil(var_90_10) then
				local var_90_12 = var_90_10:GetComponent("Image")

				if var_90_12 then
					arg_87_1.var_.highlightMatValue1148 = var_90_12
				end
			end

			local var_90_13 = 0.2

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_13 and not isNil(var_90_10) then
				local var_90_14 = (arg_87_1.time_ - var_90_11) / var_90_13

				if arg_87_1.var_.highlightMatValue1148 then
					local var_90_15 = Mathf.Lerp(0.5, 1, var_90_14)
					local var_90_16 = arg_87_1.var_.highlightMatValue1148
					local var_90_17 = var_90_16.color

					var_90_17.r = var_90_15
					var_90_17.g = var_90_15
					var_90_17.b = var_90_15
					var_90_16.color = var_90_17
				end
			end

			if arg_87_1.time_ >= var_90_11 + var_90_13 and arg_87_1.time_ < var_90_11 + var_90_13 + arg_90_0 and not isNil(var_90_10) and arg_87_1.var_.highlightMatValue1148 then
				local var_90_18 = 1

				var_90_10.transform:SetSiblingIndex(1)

				local var_90_19 = arg_87_1.var_.highlightMatValue1148
				local var_90_20 = var_90_19.color

				var_90_20.r = var_90_18
				var_90_20.g = var_90_18
				var_90_20.b = var_90_18
				var_90_19.color = var_90_20
			end

			local var_90_21 = 0
			local var_90_22 = 0.05

			if var_90_21 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_23 = arg_87_1:FormatText(StoryNameCfg[8].name)

				arg_87_1.leftNameTxt_.text = var_90_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_24 = arg_87_1:GetWordFromCfg(112282022)
				local var_90_25 = arg_87_1:FormatText(var_90_24.content)

				arg_87_1.text_.text = var_90_25

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_26 = 2
				local var_90_27 = utf8.len(var_90_25)
				local var_90_28 = var_90_26 <= 0 and var_90_22 or var_90_22 * (var_90_27 / var_90_26)

				if var_90_28 > 0 and var_90_22 < var_90_28 then
					arg_87_1.talkMaxDuration = var_90_28

					if var_90_28 + var_90_21 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_28 + var_90_21
					end
				end

				arg_87_1.text_.text = var_90_25
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282022", "story_v_out_112282.awb") ~= 0 then
					local var_90_29 = manager.audio:GetVoiceLength("story_v_out_112282", "112282022", "story_v_out_112282.awb") / 1000

					if var_90_29 + var_90_21 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_29 + var_90_21
					end

					if var_90_24.prefab_name ~= "" and arg_87_1.actors_[var_90_24.prefab_name] ~= nil then
						local var_90_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_24.prefab_name].transform, "story_v_out_112282", "112282022", "story_v_out_112282.awb")

						arg_87_1:RecordAudio("112282022", var_90_30)
						arg_87_1:RecordAudio("112282022", var_90_30)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_112282", "112282022", "story_v_out_112282.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_112282", "112282022", "story_v_out_112282.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_31 = math.max(var_90_22, arg_87_1.talkMaxDuration)

			if var_90_21 <= arg_87_1.time_ and arg_87_1.time_ < var_90_21 + var_90_31 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_21) / var_90_31

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_21 + var_90_31 and arg_87_1.time_ < var_90_21 + var_90_31 + arg_90_0 then
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
			local var_94_0 = arg_91_1.actors_["1148"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1148 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, -2000, -5)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1148, var_94_4, var_94_3)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -2000, -5)
			end

			local var_94_5 = arg_91_1.actors_["1081_1"].transform
			local var_94_6 = 0

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.var_.moveOldPos1081_1 = var_94_5.localPosition
				var_94_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_94_7 = 0.001

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_7 then
				local var_94_8 = (arg_91_1.time_ - var_94_6) / var_94_7
				local var_94_9 = Vector3.New(-500, -300, -5)

				var_94_5.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1081_1, var_94_9, var_94_8)
			end

			if arg_91_1.time_ >= var_94_6 + var_94_7 and arg_91_1.time_ < var_94_6 + var_94_7 + arg_94_0 then
				var_94_5.localPosition = Vector3.New(-500, -300, -5)
			end

			local var_94_10 = arg_91_1.actors_["1081"]
			local var_94_11 = 0

			if var_94_11 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 and not isNil(var_94_10) then
				local var_94_12 = var_94_10:GetComponent("Image")

				if var_94_12 then
					arg_91_1.var_.highlightMatValue1081 = var_94_12
				end
			end

			local var_94_13 = 0.2

			if var_94_11 <= arg_91_1.time_ and arg_91_1.time_ < var_94_11 + var_94_13 and not isNil(var_94_10) then
				local var_94_14 = (arg_91_1.time_ - var_94_11) / var_94_13

				if arg_91_1.var_.highlightMatValue1081 then
					local var_94_15 = Mathf.Lerp(0.5, 1, var_94_14)
					local var_94_16 = arg_91_1.var_.highlightMatValue1081
					local var_94_17 = var_94_16.color

					var_94_17.r = var_94_15
					var_94_17.g = var_94_15
					var_94_17.b = var_94_15
					var_94_16.color = var_94_17
				end
			end

			if arg_91_1.time_ >= var_94_11 + var_94_13 and arg_91_1.time_ < var_94_11 + var_94_13 + arg_94_0 and not isNil(var_94_10) and arg_91_1.var_.highlightMatValue1081 then
				local var_94_18 = 1

				var_94_10.transform:SetSiblingIndex(1)

				local var_94_19 = arg_91_1.var_.highlightMatValue1081
				local var_94_20 = var_94_19.color

				var_94_20.r = var_94_18
				var_94_20.g = var_94_18
				var_94_20.b = var_94_18
				var_94_19.color = var_94_20
			end

			local var_94_21 = 0
			local var_94_22 = 0.575

			if var_94_21 < arg_91_1.time_ and arg_91_1.time_ <= var_94_21 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_23 = arg_91_1:FormatText(StoryNameCfg[202].name)

				arg_91_1.leftNameTxt_.text = var_94_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_24 = arg_91_1:GetWordFromCfg(112282023)
				local var_94_25 = arg_91_1:FormatText(var_94_24.content)

				arg_91_1.text_.text = var_94_25

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_26 = 23
				local var_94_27 = utf8.len(var_94_25)
				local var_94_28 = var_94_26 <= 0 and var_94_22 or var_94_22 * (var_94_27 / var_94_26)

				if var_94_28 > 0 and var_94_22 < var_94_28 then
					arg_91_1.talkMaxDuration = var_94_28

					if var_94_28 + var_94_21 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_28 + var_94_21
					end
				end

				arg_91_1.text_.text = var_94_25
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282023", "story_v_out_112282.awb") ~= 0 then
					local var_94_29 = manager.audio:GetVoiceLength("story_v_out_112282", "112282023", "story_v_out_112282.awb") / 1000

					if var_94_29 + var_94_21 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_29 + var_94_21
					end

					if var_94_24.prefab_name ~= "" and arg_91_1.actors_[var_94_24.prefab_name] ~= nil then
						local var_94_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_24.prefab_name].transform, "story_v_out_112282", "112282023", "story_v_out_112282.awb")

						arg_91_1:RecordAudio("112282023", var_94_30)
						arg_91_1:RecordAudio("112282023", var_94_30)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_112282", "112282023", "story_v_out_112282.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_112282", "112282023", "story_v_out_112282.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_31 = math.max(var_94_22, arg_91_1.talkMaxDuration)

			if var_94_21 <= arg_91_1.time_ and arg_91_1.time_ < var_94_21 + var_94_31 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_21) / var_94_31

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_21 + var_94_31 and arg_91_1.time_ < var_94_21 + var_94_31 + arg_94_0 then
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
			local var_98_0 = 0
			local var_98_1 = 1.05

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[202].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(112282024)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 42
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282024", "story_v_out_112282.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_112282", "112282024", "story_v_out_112282.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_112282", "112282024", "story_v_out_112282.awb")

						arg_95_1:RecordAudio("112282024", var_98_9)
						arg_95_1:RecordAudio("112282024", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_112282", "112282024", "story_v_out_112282.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_112282", "112282024", "story_v_out_112282.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
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
			local var_102_0 = 0
			local var_102_1 = 0.75

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[202].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(112282025)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 30
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282025", "story_v_out_112282.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_112282", "112282025", "story_v_out_112282.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_112282", "112282025", "story_v_out_112282.awb")

						arg_99_1:RecordAudio("112282025", var_102_9)
						arg_99_1:RecordAudio("112282025", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_112282", "112282025", "story_v_out_112282.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_112282", "112282025", "story_v_out_112282.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
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
			local var_106_0 = 0
			local var_106_1 = 1.125

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[202].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(112282026)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 45
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282026", "story_v_out_112282.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_112282", "112282026", "story_v_out_112282.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_112282", "112282026", "story_v_out_112282.awb")

						arg_103_1:RecordAudio("112282026", var_106_9)
						arg_103_1:RecordAudio("112282026", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_112282", "112282026", "story_v_out_112282.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_112282", "112282026", "story_v_out_112282.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
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
			local var_110_0 = arg_107_1.actors_["1081"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) then
				local var_110_2 = var_110_0:GetComponent("Image")

				if var_110_2 then
					arg_107_1.var_.highlightMatValue1081 = var_110_2
				end
			end

			local var_110_3 = 0.2

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_3 and not isNil(var_110_0) then
				local var_110_4 = (arg_107_1.time_ - var_110_1) / var_110_3

				if arg_107_1.var_.highlightMatValue1081 then
					local var_110_5 = Mathf.Lerp(1, 0.5, var_110_4)
					local var_110_6 = arg_107_1.var_.highlightMatValue1081
					local var_110_7 = var_110_6.color

					var_110_7.r = var_110_5
					var_110_7.g = var_110_5
					var_110_7.b = var_110_5
					var_110_6.color = var_110_7
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_3 and arg_107_1.time_ < var_110_1 + var_110_3 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.highlightMatValue1081 then
				local var_110_8 = 0.5
				local var_110_9 = arg_107_1.var_.highlightMatValue1081
				local var_110_10 = var_110_9.color

				var_110_10.r = var_110_8
				var_110_10.g = var_110_8
				var_110_10.b = var_110_8
				var_110_9.color = var_110_10
			end

			local var_110_11 = 0
			local var_110_12 = 0.95

			if var_110_11 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:GetWordFromCfg(112282027)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_15 = 38
				local var_110_16 = utf8.len(var_110_14)
				local var_110_17 = var_110_15 <= 0 and var_110_12 or var_110_12 * (var_110_16 / var_110_15)

				if var_110_17 > 0 and var_110_12 < var_110_17 then
					arg_107_1.talkMaxDuration = var_110_17

					if var_110_17 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_18 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_18 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_18

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_18 and arg_107_1.time_ < var_110_11 + var_110_18 + arg_110_0 then
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
			local var_114_0 = arg_111_1.actors_["1081"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) then
				local var_114_2 = var_114_0:GetComponent("Image")

				if var_114_2 then
					arg_111_1.var_.highlightMatValue1081 = var_114_2
				end
			end

			local var_114_3 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_3 and not isNil(var_114_0) then
				local var_114_4 = (arg_111_1.time_ - var_114_1) / var_114_3

				if arg_111_1.var_.highlightMatValue1081 then
					local var_114_5 = Mathf.Lerp(0.5, 1, var_114_4)
					local var_114_6 = arg_111_1.var_.highlightMatValue1081
					local var_114_7 = var_114_6.color

					var_114_7.r = var_114_5
					var_114_7.g = var_114_5
					var_114_7.b = var_114_5
					var_114_6.color = var_114_7
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_3 and arg_111_1.time_ < var_114_1 + var_114_3 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.highlightMatValue1081 then
				local var_114_8 = 1

				var_114_0.transform:SetSiblingIndex(1)

				local var_114_9 = arg_111_1.var_.highlightMatValue1081
				local var_114_10 = var_114_9.color

				var_114_10.r = var_114_8
				var_114_10.g = var_114_8
				var_114_10.b = var_114_8
				var_114_9.color = var_114_10
			end

			local var_114_11 = 0
			local var_114_12 = 0.725

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_13 = arg_111_1:FormatText(StoryNameCfg[202].name)

				arg_111_1.leftNameTxt_.text = var_114_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_14 = arg_111_1:GetWordFromCfg(112282028)
				local var_114_15 = arg_111_1:FormatText(var_114_14.content)

				arg_111_1.text_.text = var_114_15

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_16 = 29
				local var_114_17 = utf8.len(var_114_15)
				local var_114_18 = var_114_16 <= 0 and var_114_12 or var_114_12 * (var_114_17 / var_114_16)

				if var_114_18 > 0 and var_114_12 < var_114_18 then
					arg_111_1.talkMaxDuration = var_114_18

					if var_114_18 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_18 + var_114_11
					end
				end

				arg_111_1.text_.text = var_114_15
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282028", "story_v_out_112282.awb") ~= 0 then
					local var_114_19 = manager.audio:GetVoiceLength("story_v_out_112282", "112282028", "story_v_out_112282.awb") / 1000

					if var_114_19 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_19 + var_114_11
					end

					if var_114_14.prefab_name ~= "" and arg_111_1.actors_[var_114_14.prefab_name] ~= nil then
						local var_114_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_14.prefab_name].transform, "story_v_out_112282", "112282028", "story_v_out_112282.awb")

						arg_111_1:RecordAudio("112282028", var_114_20)
						arg_111_1:RecordAudio("112282028", var_114_20)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_112282", "112282028", "story_v_out_112282.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_112282", "112282028", "story_v_out_112282.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_21 = math.max(var_114_12, arg_111_1.talkMaxDuration)

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_21 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_11) / var_114_21

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_11 + var_114_21 and arg_111_1.time_ < var_114_11 + var_114_21 + arg_114_0 then
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
			local var_118_0 = "1080"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Object.Instantiate(arg_115_1.imageGo_, arg_115_1.canvasGo_.transform)

				var_118_1.transform:SetSiblingIndex(1)

				var_118_1.name = var_118_0

				local var_118_2 = var_118_1:GetComponent(typeof(Image))

				var_118_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1080")

				var_118_2:SetNativeSize()

				var_118_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_115_1.actors_[var_118_0] = var_118_1
			end

			local var_118_3 = arg_115_1.actors_["1080"]
			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 and not isNil(var_118_3) then
				local var_118_5 = var_118_3:GetComponent("Image")

				if var_118_5 then
					arg_115_1.var_.highlightMatValue1080 = var_118_5
				end
			end

			local var_118_6 = 0.2

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_6 and not isNil(var_118_3) then
				local var_118_7 = (arg_115_1.time_ - var_118_4) / var_118_6

				if arg_115_1.var_.highlightMatValue1080 then
					local var_118_8 = Mathf.Lerp(1, 0.5, var_118_7)
					local var_118_9 = arg_115_1.var_.highlightMatValue1080
					local var_118_10 = var_118_9.color

					var_118_10.r = var_118_8
					var_118_10.g = var_118_8
					var_118_10.b = var_118_8
					var_118_9.color = var_118_10
				end
			end

			if arg_115_1.time_ >= var_118_4 + var_118_6 and arg_115_1.time_ < var_118_4 + var_118_6 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.highlightMatValue1080 then
				local var_118_11 = 0.5
				local var_118_12 = arg_115_1.var_.highlightMatValue1080
				local var_118_13 = var_118_12.color

				var_118_13.r = var_118_11
				var_118_13.g = var_118_11
				var_118_13.b = var_118_11
				var_118_12.color = var_118_13
			end

			local var_118_14 = 0
			local var_118_15 = 0.05

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_16 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_16

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

				local var_118_17 = arg_115_1:GetWordFromCfg(112282029)
				local var_118_18 = arg_115_1:FormatText(var_118_17.content)

				arg_115_1.text_.text = var_118_18

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 2
				local var_118_20 = utf8.len(var_118_18)
				local var_118_21 = var_118_19 <= 0 and var_118_15 or var_118_15 * (var_118_20 / var_118_19)

				if var_118_21 > 0 and var_118_15 < var_118_21 then
					arg_115_1.talkMaxDuration = var_118_21

					if var_118_21 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_21 + var_118_14
					end
				end

				arg_115_1.text_.text = var_118_18
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_15, arg_115_1.talkMaxDuration)

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_22 and arg_115_1.time_ < var_118_14 + var_118_22 + arg_118_0 then
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
			local var_122_0 = 0
			local var_122_1 = 0.4

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_2

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

				local var_122_3 = arg_119_1:GetWordFromCfg(112282030)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 16
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_8 and arg_119_1.time_ < var_122_0 + var_122_8 + arg_122_0 then
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
			local var_126_0 = arg_123_1.actors_["1081"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) then
				local var_126_2 = var_126_0:GetComponent("Image")

				if var_126_2 then
					arg_123_1.var_.highlightMatValue1081 = var_126_2
				end
			end

			local var_126_3 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_3 and not isNil(var_126_0) then
				local var_126_4 = (arg_123_1.time_ - var_126_1) / var_126_3

				if arg_123_1.var_.highlightMatValue1081 then
					local var_126_5 = Mathf.Lerp(0.5, 1, var_126_4)
					local var_126_6 = arg_123_1.var_.highlightMatValue1081
					local var_126_7 = var_126_6.color

					var_126_7.r = var_126_5
					var_126_7.g = var_126_5
					var_126_7.b = var_126_5
					var_126_6.color = var_126_7
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_3 and arg_123_1.time_ < var_126_1 + var_126_3 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.highlightMatValue1081 then
				local var_126_8 = 1

				var_126_0.transform:SetSiblingIndex(1)

				local var_126_9 = arg_123_1.var_.highlightMatValue1081
				local var_126_10 = var_126_9.color

				var_126_10.r = var_126_8
				var_126_10.g = var_126_8
				var_126_10.b = var_126_8
				var_126_9.color = var_126_10
			end

			local var_126_11 = 0
			local var_126_12 = 0.65

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_13 = arg_123_1:FormatText(StoryNameCfg[202].name)

				arg_123_1.leftNameTxt_.text = var_126_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_14 = arg_123_1:GetWordFromCfg(112282031)
				local var_126_15 = arg_123_1:FormatText(var_126_14.content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_16 = 26
				local var_126_17 = utf8.len(var_126_15)
				local var_126_18 = var_126_16 <= 0 and var_126_12 or var_126_12 * (var_126_17 / var_126_16)

				if var_126_18 > 0 and var_126_12 < var_126_18 then
					arg_123_1.talkMaxDuration = var_126_18

					if var_126_18 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_11
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282031", "story_v_out_112282.awb") ~= 0 then
					local var_126_19 = manager.audio:GetVoiceLength("story_v_out_112282", "112282031", "story_v_out_112282.awb") / 1000

					if var_126_19 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_11
					end

					if var_126_14.prefab_name ~= "" and arg_123_1.actors_[var_126_14.prefab_name] ~= nil then
						local var_126_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_14.prefab_name].transform, "story_v_out_112282", "112282031", "story_v_out_112282.awb")

						arg_123_1:RecordAudio("112282031", var_126_20)
						arg_123_1:RecordAudio("112282031", var_126_20)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_112282", "112282031", "story_v_out_112282.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_112282", "112282031", "story_v_out_112282.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_21 = math.max(var_126_12, arg_123_1.talkMaxDuration)

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_21 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_11) / var_126_21

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_11 + var_126_21 and arg_123_1.time_ < var_126_11 + var_126_21 + arg_126_0 then
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
			local var_130_0 = 0
			local var_130_1 = 0.3

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[202].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(112282032)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 12
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112282", "112282032", "story_v_out_112282.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_112282", "112282032", "story_v_out_112282.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_112282", "112282032", "story_v_out_112282.awb")

						arg_127_1:RecordAudio("112282032", var_130_9)
						arg_127_1:RecordAudio("112282032", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_112282", "112282032", "story_v_out_112282.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_112282", "112282032", "story_v_out_112282.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
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
