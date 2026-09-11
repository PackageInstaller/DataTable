return {
	Play112272001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112272001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112272002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.575

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

				local var_4_3 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112272001).content)

				arg_1_1.text_.text = var_4_3

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_5 = 23 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 23)

				if (23 <= 0 and var_4_1 or var_4_1 * (utf8.len(var_4_3) / 23)) > 0 and var_4_1 < var_4_5 then
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
	Play112272002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112272002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play112272003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0.725

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(112272002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 29 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 29)

				if (29 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 29)) > 0 and var_10_0 < var_10_3 then
					arg_7_1.talkMaxDuration = var_10_3

					if var_10_3 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_3 + 0
					end
				end

				arg_7_1.text_.text = var_10_1
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_4 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_4

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play112272003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112272003
		arg_11_1.duration_ = 5.2

		local var_11_0 = {
			ja = 5.2,
			ko = 3.566,
			zh = 3.233,
			en = 4.733
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
				arg_11_0:Play112272004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["1081_1"] == nil then
				local var_14_0 = Object.Instantiate(arg_11_1.imageGo_, arg_11_1.canvasGo_.transform)

				var_14_0.transform:SetSiblingIndex(1)

				var_14_0.name = "1081_1"

				local var_14_1 = var_14_0:GetComponent(typeof(Image))

				var_14_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081_1")

				var_14_1:SetNativeSize()

				var_14_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_11_1.actors_["1081_1"] = var_14_0
			end

			local var_14_2 = arg_11_1.actors_["1081_1"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1081_1 = var_14_2.localPosition
				var_14_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_14_3 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_3 then
				var_14_2.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_11_1.time_ - 0) / var_14_3)
			end

			if arg_11_1.time_ >= 0 + var_14_3 and arg_11_1.time_ < 0 + var_14_3 + arg_14_0 then
				var_14_2.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_14_4 = "1081"

			if arg_11_1.actors_["1081"] == nil then
				local var_14_5 = Object.Instantiate(arg_11_1.imageGo_, arg_11_1.canvasGo_.transform)

				var_14_5.transform:SetSiblingIndex(1)

				var_14_5.name = var_14_4

				local var_14_6 = var_14_5:GetComponent(typeof(Image))

				var_14_6.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1081")

				var_14_6:SetNativeSize()

				var_14_5.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_11_1.actors_[var_14_4] = var_14_5
			end

			local var_14_7 = arg_11_1.actors_["1081"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_7) then
				local var_14_8 = var_14_7:GetComponent("Image")

				if var_14_8 then
					arg_11_1.var_.highlightMatValue1081 = var_14_8
				end
			end

			local var_14_9 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_9 and not isNil(var_14_7) then
				if arg_11_1.var_.highlightMatValue1081 then
					local var_14_10 = Mathf.Lerp(0.5, 1, (arg_11_1.time_ - 0) / var_14_9)

					arg_11_1.var_.highlightMatValue1081.color.r = var_14_10
					arg_11_1.var_.highlightMatValue1081.color.g = var_14_10
					arg_11_1.var_.highlightMatValue1081.color.b = var_14_10
					arg_11_1.var_.highlightMatValue1081.color = arg_11_1.var_.highlightMatValue1081.color
				end
			end

			if arg_11_1.time_ >= 0 + var_14_9 and arg_11_1.time_ < 0 + var_14_9 + arg_14_0 and not isNil(var_14_7) and arg_11_1.var_.highlightMatValue1081 then
				var_14_7.transform:SetSiblingIndex(1)

				arg_11_1.var_.highlightMatValue1081.color.r = 1
				arg_11_1.var_.highlightMatValue1081.color.g = 1
				arg_11_1.var_.highlightMatValue1081.color.b = 1
				arg_11_1.var_.highlightMatValue1081.color = arg_11_1.var_.highlightMatValue1081.color
			end

			local var_14_11 = 0
			local var_14_12 = 0.25

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_11 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_13 = arg_11_1:GetWordFromCfg(112272003)
				local var_14_14 = arg_11_1:FormatText(var_14_13.content)

				arg_11_1.text_.text = var_14_14

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_16 = 10 <= 0 and var_14_12 or var_14_12 * (utf8.len(var_14_14) / 10)

				if (10 <= 0 and var_14_12 or var_14_12 * (utf8.len(var_14_14) / 10)) > 0 and var_14_12 < var_14_16 then
					arg_11_1.talkMaxDuration = var_14_16

					if var_14_16 + var_14_11 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_16 + var_14_11
					end
				end

				arg_11_1.text_.text = var_14_14
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272003", "story_v_out_112272.awb") ~= 0 then
					local var_14_17 = manager.audio:GetVoiceLength("story_v_out_112272", "112272003", "story_v_out_112272.awb") / 1000

					if var_14_17 + var_14_11 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_17 + var_14_11
					end

					if var_14_13.prefab_name ~= "" and arg_11_1.actors_[var_14_13.prefab_name] ~= nil then
						local var_14_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_13.prefab_name].transform, "story_v_out_112272", "112272003", "story_v_out_112272.awb")

						arg_11_1:RecordAudio("112272003", var_14_18)
						arg_11_1:RecordAudio("112272003", var_14_18)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_112272", "112272003", "story_v_out_112272.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_112272", "112272003", "story_v_out_112272.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_19 = math.max(var_14_12, arg_11_1.talkMaxDuration)

			if var_14_11 <= arg_11_1.time_ and arg_11_1.time_ < var_14_11 + var_14_19 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_11) / var_14_19

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_11 + var_14_19 and arg_11_1.time_ < var_14_11 + var_14_19 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
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

		arg_11_1:InitPlayNodeList()
	end,
	Play112272004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 112272004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play112272005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1081"]) then
				local var_18_0 = arg_15_1.actors_["1081"]:GetComponent("Image")

				if var_18_0 then
					arg_15_1.var_.highlightMatValue1081 = var_18_0
				end
			end

			local var_18_1 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_1 and not isNil(arg_15_1.actors_["1081"]) then
				if arg_15_1.var_.highlightMatValue1081 then
					local var_18_2 = Mathf.Lerp(1, 0.5, (arg_15_1.time_ - 0) / var_18_1)

					arg_15_1.var_.highlightMatValue1081.color.r = var_18_2
					arg_15_1.var_.highlightMatValue1081.color.g = var_18_2
					arg_15_1.var_.highlightMatValue1081.color.b = var_18_2
					arg_15_1.var_.highlightMatValue1081.color = arg_15_1.var_.highlightMatValue1081.color
				end
			end

			if arg_15_1.time_ >= 0 + var_18_1 and arg_15_1.time_ < 0 + var_18_1 + arg_18_0 and not isNil(arg_15_1.actors_["1081"]) and arg_15_1.var_.highlightMatValue1081 then
				arg_15_1.var_.highlightMatValue1081.color.r = 0.5
				arg_15_1.var_.highlightMatValue1081.color.g = 0.5
				arg_15_1.var_.highlightMatValue1081.color.b = 0.5
				arg_15_1.var_.highlightMatValue1081.color = arg_15_1.var_.highlightMatValue1081.color
			end

			local var_18_3 = 0
			local var_18_4 = 0.175

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_3 + arg_18_0 then
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

				local var_18_5 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(112272004).content)

				arg_15_1.text_.text = var_18_5

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_7 = 7 <= 0 and var_18_4 or var_18_4 * (utf8.len(var_18_5) / 7)

				if (7 <= 0 and var_18_4 or var_18_4 * (utf8.len(var_18_5) / 7)) > 0 and var_18_4 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_3 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_3
					end
				end

				arg_15_1.text_.text = var_18_5
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_8 = math.max(var_18_4, arg_15_1.talkMaxDuration)

			if var_18_3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_3 + var_18_8 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_3) / var_18_8

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_3 + var_18_8 and arg_15_1.time_ < var_18_3 + var_18_8 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play112272005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112272005
		arg_19_1.duration_ = 13.4

		local var_19_0 = {
			ja = 13.4,
			ko = 10.033,
			zh = 8.866,
			en = 11.933
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
				arg_19_0:Play112272006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1081"]) then
				local var_22_0 = arg_19_1.actors_["1081"]:GetComponent("Image")

				if var_22_0 then
					arg_19_1.var_.highlightMatValue1081 = var_22_0
				end
			end

			local var_22_1 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 and not isNil(arg_19_1.actors_["1081"]) then
				if arg_19_1.var_.highlightMatValue1081 then
					local var_22_2 = Mathf.Lerp(0.5, 1, (arg_19_1.time_ - 0) / var_22_1)

					arg_19_1.var_.highlightMatValue1081.color.r = var_22_2
					arg_19_1.var_.highlightMatValue1081.color.g = var_22_2
					arg_19_1.var_.highlightMatValue1081.color.b = var_22_2
					arg_19_1.var_.highlightMatValue1081.color = arg_19_1.var_.highlightMatValue1081.color
				end
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 and not isNil(arg_19_1.actors_["1081"]) and arg_19_1.var_.highlightMatValue1081 then
				arg_19_1.actors_["1081"].transform:SetSiblingIndex(1)

				arg_19_1.var_.highlightMatValue1081.color.r = 1
				arg_19_1.var_.highlightMatValue1081.color.g = 1
				arg_19_1.var_.highlightMatValue1081.color.b = 1
				arg_19_1.var_.highlightMatValue1081.color = arg_19_1.var_.highlightMatValue1081.color
			end

			local var_22_3 = 0
			local var_22_4 = 1.2

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_5 = arg_19_1:GetWordFromCfg(112272005)
				local var_22_6 = arg_19_1:FormatText(var_22_5.content)

				arg_19_1.text_.text = var_22_6

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_8 = 48 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_6) / 48)

				if (48 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_6) / 48)) > 0 and var_22_4 < var_22_8 then
					arg_19_1.talkMaxDuration = var_22_8

					if var_22_8 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_3
					end
				end

				arg_19_1.text_.text = var_22_6
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272005", "story_v_out_112272.awb") ~= 0 then
					local var_22_9 = manager.audio:GetVoiceLength("story_v_out_112272", "112272005", "story_v_out_112272.awb") / 1000

					if var_22_9 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_3
					end

					if var_22_5.prefab_name ~= "" and arg_19_1.actors_[var_22_5.prefab_name] ~= nil then
						local var_22_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_5.prefab_name].transform, "story_v_out_112272", "112272005", "story_v_out_112272.awb")

						arg_19_1:RecordAudio("112272005", var_22_10)
						arg_19_1:RecordAudio("112272005", var_22_10)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_112272", "112272005", "story_v_out_112272.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_112272", "112272005", "story_v_out_112272.awb")
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
	Play112272006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112272006
		arg_23_1.duration_ = 4.17

		local var_23_0 = {
			ja = 4.166,
			ko = 3.133,
			zh = 2.233,
			en = 2.9
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
				arg_23_0:Play112272007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.35

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:GetWordFromCfg(112272006)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 14 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 14)

				if (14 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 14)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272006", "story_v_out_112272.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272006", "story_v_out_112272.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_112272", "112272006", "story_v_out_112272.awb")

						arg_23_1:RecordAudio("112272006", var_26_6)
						arg_23_1:RecordAudio("112272006", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_112272", "112272006", "story_v_out_112272.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_112272", "112272006", "story_v_out_112272.awb")
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
	Play112272007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112272007
		arg_27_1.duration_ = 10.03

		local var_27_0 = {
			ja = 10.033,
			ko = 8.1,
			zh = 7.033,
			en = 7.366
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
				arg_27_0:Play112272008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1081_1 = arg_27_1.actors_["1081_1"].transform.localPosition
				arg_27_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_27_1.time_ - 0) / var_30_0)
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1081_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_30_1 = "1084"

			if arg_27_1.actors_["1084"] == nil then
				local var_30_2 = Object.Instantiate(arg_27_1.imageGo_, arg_27_1.canvasGo_.transform)

				var_30_2.transform:SetSiblingIndex(1)

				var_30_2.name = var_30_1

				local var_30_3 = var_30_2:GetComponent(typeof(Image))

				var_30_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1084")

				var_30_3:SetNativeSize()

				var_30_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_27_1.actors_[var_30_1] = var_30_2
			end

			local var_30_4 = arg_27_1.actors_["1084"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084 = var_30_4.localPosition
				var_30_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_30_5 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 then
				var_30_4.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084, Vector3.New(0, -450, 0), (arg_27_1.time_ - 0) / var_30_5)
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 then
				var_30_4.localPosition = Vector3.New(0, -450, 0)
			end

			local var_30_6 = arg_27_1.actors_["1084"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_6) then
				local var_30_7 = var_30_6:GetComponent("Image")

				if var_30_7 then
					arg_27_1.var_.highlightMatValue1084 = var_30_7
				end
			end

			local var_30_8 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_8 and not isNil(var_30_6) then
				if arg_27_1.var_.highlightMatValue1084 then
					local var_30_9 = Mathf.Lerp(0.5, 1, (arg_27_1.time_ - 0) / var_30_8)

					arg_27_1.var_.highlightMatValue1084.color.r = var_30_9
					arg_27_1.var_.highlightMatValue1084.color.g = var_30_9
					arg_27_1.var_.highlightMatValue1084.color.b = var_30_9
					arg_27_1.var_.highlightMatValue1084.color = arg_27_1.var_.highlightMatValue1084.color
				end
			end

			if arg_27_1.time_ >= 0 + var_30_8 and arg_27_1.time_ < 0 + var_30_8 + arg_30_0 and not isNil(var_30_6) and arg_27_1.var_.highlightMatValue1084 then
				var_30_6.transform:SetSiblingIndex(1)

				arg_27_1.var_.highlightMatValue1084.color.r = 1
				arg_27_1.var_.highlightMatValue1084.color.g = 1
				arg_27_1.var_.highlightMatValue1084.color.b = 1
				arg_27_1.var_.highlightMatValue1084.color = arg_27_1.var_.highlightMatValue1084.color
			end

			local var_30_10 = 0
			local var_30_11 = 0.8

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
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

				local var_30_12 = arg_27_1:GetWordFromCfg(112272007)
				local var_30_13 = arg_27_1:FormatText(var_30_12.content)

				arg_27_1.text_.text = var_30_13

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_15 = 32 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 32)

				if (32 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 32)) > 0 and var_30_11 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_10
					end
				end

				arg_27_1.text_.text = var_30_13
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272007", "story_v_out_112272.awb") ~= 0 then
					local var_30_16 = manager.audio:GetVoiceLength("story_v_out_112272", "112272007", "story_v_out_112272.awb") / 1000

					if var_30_16 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_16 + var_30_10
					end

					if var_30_12.prefab_name ~= "" and arg_27_1.actors_[var_30_12.prefab_name] ~= nil then
						local var_30_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_12.prefab_name].transform, "story_v_out_112272", "112272007", "story_v_out_112272.awb")

						arg_27_1:RecordAudio("112272007", var_30_17)
						arg_27_1:RecordAudio("112272007", var_30_17)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_112272", "112272007", "story_v_out_112272.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_112272", "112272007", "story_v_out_112272.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = math.max(var_30_11, arg_27_1.talkMaxDuration)

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_18 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_18

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_18 and arg_27_1.time_ < var_30_10 + var_30_18 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play112272008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 112272008
		arg_31_1.duration_ = 6.77

		local var_31_0 = {
			ja = 5.733,
			ko = 5.5,
			zh = 6.766,
			en = 6.4
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
				arg_31_0:Play112272009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1084 = arg_31_1.actors_["1084"].transform.localPosition
				arg_31_1.actors_["1084"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1084"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1084, Vector3.New(0, -2000, 0), (arg_31_1.time_ - 0) / var_34_0)
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1084"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_34_1 = "1148"

			if arg_31_1.actors_["1148"] == nil then
				local var_34_2 = Object.Instantiate(arg_31_1.imageGo_, arg_31_1.canvasGo_.transform)

				var_34_2.transform:SetSiblingIndex(1)

				var_34_2.name = var_34_1

				local var_34_3 = var_34_2:GetComponent(typeof(Image))

				var_34_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1148")

				var_34_3:SetNativeSize()

				var_34_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_31_1.actors_[var_34_1] = var_34_2
			end

			local var_34_4 = arg_31_1.actors_["1148"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1148 = var_34_4.localPosition
				var_34_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_34_5 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 then
				var_34_4.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1148, Vector3.New(0, -550, 0), (arg_31_1.time_ - 0) / var_34_5)
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 then
				var_34_4.localPosition = Vector3.New(0, -550, 0)
			end

			local var_34_6 = arg_31_1.actors_["1148"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_6) then
				local var_34_7 = var_34_6:GetComponent("Image")

				if var_34_7 then
					arg_31_1.var_.highlightMatValue1148 = var_34_7
				end
			end

			local var_34_8 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_8 and not isNil(var_34_6) then
				if arg_31_1.var_.highlightMatValue1148 then
					local var_34_9 = Mathf.Lerp(0.5, 1, (arg_31_1.time_ - 0) / var_34_8)

					arg_31_1.var_.highlightMatValue1148.color.r = var_34_9
					arg_31_1.var_.highlightMatValue1148.color.g = var_34_9
					arg_31_1.var_.highlightMatValue1148.color.b = var_34_9
					arg_31_1.var_.highlightMatValue1148.color = arg_31_1.var_.highlightMatValue1148.color
				end
			end

			if arg_31_1.time_ >= 0 + var_34_8 and arg_31_1.time_ < 0 + var_34_8 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.highlightMatValue1148 then
				var_34_6.transform:SetSiblingIndex(1)

				arg_31_1.var_.highlightMatValue1148.color.r = 1
				arg_31_1.var_.highlightMatValue1148.color.g = 1
				arg_31_1.var_.highlightMatValue1148.color.b = 1
				arg_31_1.var_.highlightMatValue1148.color = arg_31_1.var_.highlightMatValue1148.color
			end

			local var_34_10 = 0
			local var_34_11 = 0.65

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
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

				local var_34_12 = arg_31_1:GetWordFromCfg(112272008)
				local var_34_13 = arg_31_1:FormatText(var_34_12.content)

				arg_31_1.text_.text = var_34_13

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_15 = 26 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_13) / 26)

				if (26 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_13) / 26)) > 0 and var_34_11 < var_34_15 then
					arg_31_1.talkMaxDuration = var_34_15

					if var_34_15 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_15 + var_34_10
					end
				end

				arg_31_1.text_.text = var_34_13
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272008", "story_v_out_112272.awb") ~= 0 then
					local var_34_16 = manager.audio:GetVoiceLength("story_v_out_112272", "112272008", "story_v_out_112272.awb") / 1000

					if var_34_16 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_10
					end

					if var_34_12.prefab_name ~= "" and arg_31_1.actors_[var_34_12.prefab_name] ~= nil then
						local var_34_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_12.prefab_name].transform, "story_v_out_112272", "112272008", "story_v_out_112272.awb")

						arg_31_1:RecordAudio("112272008", var_34_17)
						arg_31_1:RecordAudio("112272008", var_34_17)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112272", "112272008", "story_v_out_112272.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112272", "112272008", "story_v_out_112272.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_18 = math.max(var_34_11, arg_31_1.talkMaxDuration)

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_18 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_10) / var_34_18

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_10 + var_34_18 and arg_31_1.time_ < var_34_10 + var_34_18 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play112272009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 112272009
		arg_35_1.duration_ = 10.7

		local var_35_0 = {
			ja = 10.7,
			ko = 7.9,
			zh = 7.033,
			en = 9.666
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
				arg_35_0:Play112272010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.975

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(112272009)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 39 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 39)

				if (39 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 39)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272009", "story_v_out_112272.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272009", "story_v_out_112272.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_112272", "112272009", "story_v_out_112272.awb")

						arg_35_1:RecordAudio("112272009", var_38_6)
						arg_35_1:RecordAudio("112272009", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_112272", "112272009", "story_v_out_112272.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_112272", "112272009", "story_v_out_112272.awb")
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
	Play112272010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 112272010
		arg_39_1.duration_ = 9.73

		local var_39_0 = {
			ja = 9.733,
			ko = 7,
			zh = 6.266,
			en = 8.6
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
				arg_39_0:Play112272011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1148 = arg_39_1.actors_["1148"].transform.localPosition
				arg_39_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1148, Vector3.New(-600, -550, 0), (arg_39_1.time_ - 0) / var_42_0)
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1148"].transform.localPosition = Vector3.New(-600, -550, 0)
			end

			local var_42_1 = "1027"

			if arg_39_1.actors_["1027"] == nil then
				local var_42_2 = Object.Instantiate(arg_39_1.imageGo_, arg_39_1.canvasGo_.transform)

				var_42_2.transform:SetSiblingIndex(1)

				var_42_2.name = var_42_1

				local var_42_3 = var_42_2:GetComponent(typeof(Image))

				var_42_3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1027")

				var_42_3:SetNativeSize()

				var_42_2.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_39_1.actors_[var_42_1] = var_42_2
			end

			local var_42_4 = arg_39_1.actors_["1027"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1027 = var_42_4.localPosition
				var_42_4.localScale = Vector3.New(1, 1, 1)
			end

			local var_42_5 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				var_42_4.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1027, Vector3.New(500, -500, 0), (arg_39_1.time_ - 0) / var_42_5)
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				var_42_4.localPosition = Vector3.New(500, -500, 0)
			end

			local var_42_6 = arg_39_1.actors_["1027"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_6) then
				local var_42_7 = var_42_6:GetComponent("Image")

				if var_42_7 then
					arg_39_1.var_.highlightMatValue1027 = var_42_7
				end
			end

			local var_42_8 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_8 and not isNil(var_42_6) then
				if arg_39_1.var_.highlightMatValue1027 then
					local var_42_9 = Mathf.Lerp(0.5, 1, (arg_39_1.time_ - 0) / var_42_8)

					arg_39_1.var_.highlightMatValue1027.color.r = var_42_9
					arg_39_1.var_.highlightMatValue1027.color.g = var_42_9
					arg_39_1.var_.highlightMatValue1027.color.b = var_42_9
					arg_39_1.var_.highlightMatValue1027.color = arg_39_1.var_.highlightMatValue1027.color
				end
			end

			if arg_39_1.time_ >= 0 + var_42_8 and arg_39_1.time_ < 0 + var_42_8 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.highlightMatValue1027 then
				var_42_6.transform:SetSiblingIndex(1)

				arg_39_1.var_.highlightMatValue1027.color.r = 1
				arg_39_1.var_.highlightMatValue1027.color.g = 1
				arg_39_1.var_.highlightMatValue1027.color.b = 1
				arg_39_1.var_.highlightMatValue1027.color = arg_39_1.var_.highlightMatValue1027.color
			end

			local var_42_10 = arg_39_1.actors_["1148"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_10) then
				local var_42_11 = var_42_10:GetComponent("Image")

				if var_42_11 then
					arg_39_1.var_.highlightMatValue1148 = var_42_11
				end
			end

			local var_42_12 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_12 and not isNil(var_42_10) then
				if arg_39_1.var_.highlightMatValue1148 then
					local var_42_13 = Mathf.Lerp(1, 0.5, (arg_39_1.time_ - 0) / var_42_12)

					arg_39_1.var_.highlightMatValue1148.color.r = var_42_13
					arg_39_1.var_.highlightMatValue1148.color.g = var_42_13
					arg_39_1.var_.highlightMatValue1148.color.b = var_42_13
					arg_39_1.var_.highlightMatValue1148.color = arg_39_1.var_.highlightMatValue1148.color
				end
			end

			if arg_39_1.time_ >= 0 + var_42_12 and arg_39_1.time_ < 0 + var_42_12 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.highlightMatValue1148 then
				arg_39_1.var_.highlightMatValue1148.color.r = 0.5
				arg_39_1.var_.highlightMatValue1148.color.g = 0.5
				arg_39_1.var_.highlightMatValue1148.color.b = 0.5
				arg_39_1.var_.highlightMatValue1148.color = arg_39_1.var_.highlightMatValue1148.color
			end

			local var_42_14 = 0
			local var_42_15 = 0.8

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
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

				local var_42_16 = arg_39_1:GetWordFromCfg(112272010)
				local var_42_17 = arg_39_1:FormatText(var_42_16.content)

				arg_39_1.text_.text = var_42_17

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_19 = 32 <= 0 and var_42_15 or var_42_15 * (utf8.len(var_42_17) / 32)

				if (32 <= 0 and var_42_15 or var_42_15 * (utf8.len(var_42_17) / 32)) > 0 and var_42_15 < var_42_19 then
					arg_39_1.talkMaxDuration = var_42_19

					if var_42_19 + var_42_14 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_19 + var_42_14
					end
				end

				arg_39_1.text_.text = var_42_17
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272010", "story_v_out_112272.awb") ~= 0 then
					local var_42_20 = manager.audio:GetVoiceLength("story_v_out_112272", "112272010", "story_v_out_112272.awb") / 1000

					if var_42_20 + var_42_14 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_20 + var_42_14
					end

					if var_42_16.prefab_name ~= "" and arg_39_1.actors_[var_42_16.prefab_name] ~= nil then
						local var_42_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_16.prefab_name].transform, "story_v_out_112272", "112272010", "story_v_out_112272.awb")

						arg_39_1:RecordAudio("112272010", var_42_21)
						arg_39_1:RecordAudio("112272010", var_42_21)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_112272", "112272010", "story_v_out_112272.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_112272", "112272010", "story_v_out_112272.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_22 = math.max(var_42_15, arg_39_1.talkMaxDuration)

			if var_42_14 <= arg_39_1.time_ and arg_39_1.time_ < var_42_14 + var_42_22 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_14) / var_42_22

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_14 + var_42_22 and arg_39_1.time_ < var_42_14 + var_42_22 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play112272011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112272011
		arg_43_1.duration_ = 8.67

		local var_43_0 = {
			ja = 8.666,
			ko = 6,
			zh = 7.4,
			en = 8.4
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
				arg_43_0:Play112272012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1027"]) then
				local var_46_0 = arg_43_1.actors_["1027"]:GetComponent("Image")

				if var_46_0 then
					arg_43_1.var_.highlightMatValue1027 = var_46_0
				end
			end

			local var_46_1 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 and not isNil(arg_43_1.actors_["1027"]) then
				if arg_43_1.var_.highlightMatValue1027 then
					local var_46_2 = Mathf.Lerp(1, 0.5, (arg_43_1.time_ - 0) / var_46_1)

					arg_43_1.var_.highlightMatValue1027.color.r = var_46_2
					arg_43_1.var_.highlightMatValue1027.color.g = var_46_2
					arg_43_1.var_.highlightMatValue1027.color.b = var_46_2
					arg_43_1.var_.highlightMatValue1027.color = arg_43_1.var_.highlightMatValue1027.color
				end
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 and not isNil(arg_43_1.actors_["1027"]) and arg_43_1.var_.highlightMatValue1027 then
				arg_43_1.var_.highlightMatValue1027.color.r = 0.5
				arg_43_1.var_.highlightMatValue1027.color.g = 0.5
				arg_43_1.var_.highlightMatValue1027.color.b = 0.5
				arg_43_1.var_.highlightMatValue1027.color = arg_43_1.var_.highlightMatValue1027.color
			end

			local var_46_3 = arg_43_1.actors_["1148"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_3) then
				local var_46_4 = var_46_3:GetComponent("Image")

				if var_46_4 then
					arg_43_1.var_.highlightMatValue1148 = var_46_4
				end
			end

			local var_46_5 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 and not isNil(var_46_3) then
				if arg_43_1.var_.highlightMatValue1148 then
					local var_46_6 = Mathf.Lerp(0.5, 1, (arg_43_1.time_ - 0) / var_46_5)

					arg_43_1.var_.highlightMatValue1148.color.r = var_46_6
					arg_43_1.var_.highlightMatValue1148.color.g = var_46_6
					arg_43_1.var_.highlightMatValue1148.color.b = var_46_6
					arg_43_1.var_.highlightMatValue1148.color = arg_43_1.var_.highlightMatValue1148.color
				end
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.highlightMatValue1148 then
				var_46_3.transform:SetSiblingIndex(1)

				arg_43_1.var_.highlightMatValue1148.color.r = 1
				arg_43_1.var_.highlightMatValue1148.color.g = 1
				arg_43_1.var_.highlightMatValue1148.color.b = 1
				arg_43_1.var_.highlightMatValue1148.color = arg_43_1.var_.highlightMatValue1148.color
			end

			local var_46_7 = 0
			local var_46_8 = 0.85

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_7 + arg_46_0 then
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

				local var_46_9 = arg_43_1:GetWordFromCfg(112272011)
				local var_46_10 = arg_43_1:FormatText(var_46_9.content)

				arg_43_1.text_.text = var_46_10

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_12 = 34 <= 0 and var_46_8 or var_46_8 * (utf8.len(var_46_10) / 34)

				if (34 <= 0 and var_46_8 or var_46_8 * (utf8.len(var_46_10) / 34)) > 0 and var_46_8 < var_46_12 then
					arg_43_1.talkMaxDuration = var_46_12

					if var_46_12 + var_46_7 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_7
					end
				end

				arg_43_1.text_.text = var_46_10
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272011", "story_v_out_112272.awb") ~= 0 then
					local var_46_13 = manager.audio:GetVoiceLength("story_v_out_112272", "112272011", "story_v_out_112272.awb") / 1000

					if var_46_13 + var_46_7 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_7
					end

					if var_46_9.prefab_name ~= "" and arg_43_1.actors_[var_46_9.prefab_name] ~= nil then
						local var_46_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_9.prefab_name].transform, "story_v_out_112272", "112272011", "story_v_out_112272.awb")

						arg_43_1:RecordAudio("112272011", var_46_14)
						arg_43_1:RecordAudio("112272011", var_46_14)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_112272", "112272011", "story_v_out_112272.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_112272", "112272011", "story_v_out_112272.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_15 = math.max(var_46_8, arg_43_1.talkMaxDuration)

			if var_46_7 <= arg_43_1.time_ and arg_43_1.time_ < var_46_7 + var_46_15 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_7) / var_46_15

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_7 + var_46_15 and arg_43_1.time_ < var_46_7 + var_46_15 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play112272012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112272012
		arg_47_1.duration_ = 4.13

		local var_47_0 = {
			ja = 4.133,
			ko = 2.966,
			zh = 3.166,
			en = 2.666
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
				arg_47_0:Play112272013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.3

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(112272012)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 12 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 12)

				if (12 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 12)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272012", "story_v_out_112272.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272012", "story_v_out_112272.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_112272", "112272012", "story_v_out_112272.awb")

						arg_47_1:RecordAudio("112272012", var_50_6)
						arg_47_1:RecordAudio("112272012", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112272", "112272012", "story_v_out_112272.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112272", "112272012", "story_v_out_112272.awb")
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
	Play112272013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112272013
		arg_51_1.duration_ = 4.23

		local var_51_0 = {
			ja = 4.233,
			ko = 2.733,
			zh = 3.833,
			en = 3.7
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
				arg_51_0:Play112272014(arg_51_1)
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
					local var_54_2 = Mathf.Lerp(0.5, 1, (arg_51_1.time_ - 0) / var_54_1)

					arg_51_1.var_.highlightMatValue1027.color.r = var_54_2
					arg_51_1.var_.highlightMatValue1027.color.g = var_54_2
					arg_51_1.var_.highlightMatValue1027.color.b = var_54_2
					arg_51_1.var_.highlightMatValue1027.color = arg_51_1.var_.highlightMatValue1027.color
				end
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 and not isNil(arg_51_1.actors_["1027"]) and arg_51_1.var_.highlightMatValue1027 then
				arg_51_1.actors_["1027"].transform:SetSiblingIndex(1)

				arg_51_1.var_.highlightMatValue1027.color.r = 1
				arg_51_1.var_.highlightMatValue1027.color.g = 1
				arg_51_1.var_.highlightMatValue1027.color.b = 1
				arg_51_1.var_.highlightMatValue1027.color = arg_51_1.var_.highlightMatValue1027.color
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
					local var_54_6 = Mathf.Lerp(1, 0.5, (arg_51_1.time_ - 0) / var_54_5)

					arg_51_1.var_.highlightMatValue1148.color.r = var_54_6
					arg_51_1.var_.highlightMatValue1148.color.g = var_54_6
					arg_51_1.var_.highlightMatValue1148.color.b = var_54_6
					arg_51_1.var_.highlightMatValue1148.color = arg_51_1.var_.highlightMatValue1148.color
				end
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.highlightMatValue1148 then
				arg_51_1.var_.highlightMatValue1148.color.r = 0.5
				arg_51_1.var_.highlightMatValue1148.color.g = 0.5
				arg_51_1.var_.highlightMatValue1148.color.b = 0.5
				arg_51_1.var_.highlightMatValue1148.color = arg_51_1.var_.highlightMatValue1148.color
			end

			local var_54_7 = 0
			local var_54_8 = 0.3

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_9 = arg_51_1:GetWordFromCfg(112272013)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_12 = 12 <= 0 and var_54_8 or var_54_8 * (utf8.len(var_54_10) / 12)

				if (12 <= 0 and var_54_8 or var_54_8 * (utf8.len(var_54_10) / 12)) > 0 and var_54_8 < var_54_12 then
					arg_51_1.talkMaxDuration = var_54_12

					if var_54_12 + var_54_7 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_7
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272013", "story_v_out_112272.awb") ~= 0 then
					local var_54_13 = manager.audio:GetVoiceLength("story_v_out_112272", "112272013", "story_v_out_112272.awb") / 1000

					if var_54_13 + var_54_7 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_7
					end

					if var_54_9.prefab_name ~= "" and arg_51_1.actors_[var_54_9.prefab_name] ~= nil then
						local var_54_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_9.prefab_name].transform, "story_v_out_112272", "112272013", "story_v_out_112272.awb")

						arg_51_1:RecordAudio("112272013", var_54_14)
						arg_51_1:RecordAudio("112272013", var_54_14)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_112272", "112272013", "story_v_out_112272.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_112272", "112272013", "story_v_out_112272.awb")
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
	Play112272014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112272014
		arg_55_1.duration_ = 7.1

		local var_55_0 = {
			ja = 7.1,
			ko = 6.8,
			zh = 7.1,
			en = 6.166
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
				arg_55_0:Play112272015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.725

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(112272014)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 29 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 29)

				if (29 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 29)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272014", "story_v_out_112272.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272014", "story_v_out_112272.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_112272", "112272014", "story_v_out_112272.awb")

						arg_55_1:RecordAudio("112272014", var_58_6)
						arg_55_1:RecordAudio("112272014", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_112272", "112272014", "story_v_out_112272.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_112272", "112272014", "story_v_out_112272.awb")
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
	Play112272015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112272015
		arg_59_1.duration_ = 5.6

		local var_59_0 = {
			ja = 5.2,
			ko = 5.6,
			zh = 3.933,
			en = 5.366
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
				arg_59_0:Play112272016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1027"]) then
				local var_62_0 = arg_59_1.actors_["1027"]:GetComponent("Image")

				if var_62_0 then
					arg_59_1.var_.highlightMatValue1027 = var_62_0
				end
			end

			local var_62_1 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 and not isNil(arg_59_1.actors_["1027"]) then
				if arg_59_1.var_.highlightMatValue1027 then
					local var_62_2 = Mathf.Lerp(1, 0.5, (arg_59_1.time_ - 0) / var_62_1)

					arg_59_1.var_.highlightMatValue1027.color.r = var_62_2
					arg_59_1.var_.highlightMatValue1027.color.g = var_62_2
					arg_59_1.var_.highlightMatValue1027.color.b = var_62_2
					arg_59_1.var_.highlightMatValue1027.color = arg_59_1.var_.highlightMatValue1027.color
				end
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 and not isNil(arg_59_1.actors_["1027"]) and arg_59_1.var_.highlightMatValue1027 then
				arg_59_1.var_.highlightMatValue1027.color.r = 0.5
				arg_59_1.var_.highlightMatValue1027.color.g = 0.5
				arg_59_1.var_.highlightMatValue1027.color.b = 0.5
				arg_59_1.var_.highlightMatValue1027.color = arg_59_1.var_.highlightMatValue1027.color
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
			local var_62_8 = 0.425

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

				local var_62_9 = arg_59_1:GetWordFromCfg(112272015)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_12 = 17 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 17)

				if (17 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 17)) > 0 and var_62_8 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_7
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272015", "story_v_out_112272.awb") ~= 0 then
					local var_62_13 = manager.audio:GetVoiceLength("story_v_out_112272", "112272015", "story_v_out_112272.awb") / 1000

					if var_62_13 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_7
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_112272", "112272015", "story_v_out_112272.awb")

						arg_59_1:RecordAudio("112272015", var_62_14)
						arg_59_1:RecordAudio("112272015", var_62_14)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112272", "112272015", "story_v_out_112272.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112272", "112272015", "story_v_out_112272.awb")
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
	Play112272016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112272016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play112272017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1148 = arg_63_1.actors_["1148"].transform.localPosition
				arg_63_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_63_1.time_ - 0) / var_66_0)
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_1 = arg_63_1.actors_["1027"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1027 = var_66_1.localPosition
				var_66_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_66_2 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 then
				var_66_1.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1027, Vector3.New(0, -2000, 0), (arg_63_1.time_ - 0) / var_66_2)
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 then
				var_66_1.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_3 = 0
			local var_66_4 = 1.175

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

				local var_66_5 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(112272016).content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 47 <= 0 and var_66_4 or var_66_4 * (utf8.len(var_66_5) / 47)

				if (47 <= 0 and var_66_4 or var_66_4 * (utf8.len(var_66_5) / 47)) > 0 and var_66_4 < var_66_7 then
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

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play112272017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112272017
		arg_67_1.duration_ = 4.5

		local var_67_0 = {
			ja = 4.5,
			ko = 3.5,
			zh = 3,
			en = 3.833
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
				arg_67_0:Play112272018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.actors_["1039"] == nil then
				local var_70_0 = Object.Instantiate(arg_67_1.imageGo_, arg_67_1.canvasGo_.transform)

				var_70_0.transform:SetSiblingIndex(1)

				var_70_0.name = "1039"

				local var_70_1 = var_70_0:GetComponent(typeof(Image))

				var_70_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1039")

				var_70_1:SetNativeSize()

				var_70_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_67_1.actors_["1039"] = var_70_0
			end

			local var_70_2 = arg_67_1.actors_["1039"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1039 = var_70_2.localPosition
				var_70_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_70_3 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 then
				var_70_2.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1039, Vector3.New(0, -450, 0), (arg_67_1.time_ - 0) / var_70_3)
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 then
				var_70_2.localPosition = Vector3.New(0, -450, 0)
			end

			local var_70_4 = arg_67_1.actors_["1039"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_4) then
				local var_70_5 = var_70_4:GetComponent("Image")

				if var_70_5 then
					arg_67_1.var_.highlightMatValue1039 = var_70_5
				end
			end

			local var_70_6 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_4) then
				if arg_67_1.var_.highlightMatValue1039 then
					local var_70_7 = Mathf.Lerp(0.5, 1, (arg_67_1.time_ - 0) / var_70_6)

					arg_67_1.var_.highlightMatValue1039.color.r = var_70_7
					arg_67_1.var_.highlightMatValue1039.color.g = var_70_7
					arg_67_1.var_.highlightMatValue1039.color.b = var_70_7
					arg_67_1.var_.highlightMatValue1039.color = arg_67_1.var_.highlightMatValue1039.color
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.highlightMatValue1039 then
				var_70_4.transform:SetSiblingIndex(1)

				arg_67_1.var_.highlightMatValue1039.color.r = 1
				arg_67_1.var_.highlightMatValue1039.color.g = 1
				arg_67_1.var_.highlightMatValue1039.color.b = 1
				arg_67_1.var_.highlightMatValue1039.color = arg_67_1.var_.highlightMatValue1039.color
			end

			local var_70_8 = 0
			local var_70_9 = 0.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
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

				local var_70_10 = arg_67_1:GetWordFromCfg(112272017)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 12 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 12)

				if (12 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 12)) > 0 and var_70_9 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272017", "story_v_out_112272.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_112272", "112272017", "story_v_out_112272.awb") / 1000

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end

					if var_70_10.prefab_name ~= "" and arg_67_1.actors_[var_70_10.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_10.prefab_name].transform, "story_v_out_112272", "112272017", "story_v_out_112272.awb")

						arg_67_1:RecordAudio("112272017", var_70_15)
						arg_67_1:RecordAudio("112272017", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112272", "112272017", "story_v_out_112272.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112272", "112272017", "story_v_out_112272.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_16 and arg_67_1.time_ < var_70_8 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play112272018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112272018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play112272019(arg_71_1)
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
			local var_74_4 = 0.625

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

				local var_74_5 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(112272018).content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 25 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 25)

				if (25 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 25)) > 0 and var_74_4 < var_74_7 then
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
	Play112272019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 112272019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play112272020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.875

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

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(112272019).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 35 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 35)

				if (35 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 35)) > 0 and var_78_0 < var_78_3 then
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
	Play112272020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 112272020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play112272021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1039 = arg_79_1.actors_["1039"].transform.localPosition
				arg_79_1.actors_["1039"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1039"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1039, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0) / var_82_0)
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1039"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_1 = 0
			local var_82_2 = 0.925

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(112272020).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 37 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 37)

				if (37 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 37)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play112272021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 112272021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play112272022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.125

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(112272021).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 5 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 5)

				if (5 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 5)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play112272022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 112272022
		arg_87_1.duration_ = 3.77

		local var_87_0 = {
			ja = 3.766,
			ko = 2.966,
			zh = 3.433,
			en = 2.333
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
				arg_87_0:Play112272023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1081_1 = arg_87_1.actors_["1081_1"].transform.localPosition
				arg_87_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1081_1, Vector3.New(-500, -300, 0), (arg_87_1.time_ - 0) / var_90_0)
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1081_1"].transform.localPosition = Vector3.New(-500, -300, 0)
			end

			local var_90_1 = arg_87_1.actors_["1081"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) then
				local var_90_2 = var_90_1:GetComponent("Image")

				if var_90_2 then
					arg_87_1.var_.highlightMatValue1081 = var_90_2
				end
			end

			local var_90_3 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_1) then
				if arg_87_1.var_.highlightMatValue1081 then
					local var_90_4 = Mathf.Lerp(0.5, 1, (arg_87_1.time_ - 0) / var_90_3)

					arg_87_1.var_.highlightMatValue1081.color.r = var_90_4
					arg_87_1.var_.highlightMatValue1081.color.g = var_90_4
					arg_87_1.var_.highlightMatValue1081.color.b = var_90_4
					arg_87_1.var_.highlightMatValue1081.color = arg_87_1.var_.highlightMatValue1081.color
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.highlightMatValue1081 then
				var_90_1.transform:SetSiblingIndex(1)

				arg_87_1.var_.highlightMatValue1081.color.r = 1
				arg_87_1.var_.highlightMatValue1081.color.g = 1
				arg_87_1.var_.highlightMatValue1081.color.b = 1
				arg_87_1.var_.highlightMatValue1081.color = arg_87_1.var_.highlightMatValue1081.color
			end

			local var_90_5 = 0
			local var_90_6 = 0.375

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:GetWordFromCfg(112272022)
				local var_90_8 = arg_87_1:FormatText(var_90_7.content)

				arg_87_1.text_.text = var_90_8

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 15 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 15)

				if (15 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 15)) > 0 and var_90_6 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_8
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272022", "story_v_out_112272.awb") ~= 0 then
					local var_90_11 = manager.audio:GetVoiceLength("story_v_out_112272", "112272022", "story_v_out_112272.awb") / 1000

					if var_90_11 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_5
					end

					if var_90_7.prefab_name ~= "" and arg_87_1.actors_[var_90_7.prefab_name] ~= nil then
						local var_90_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_7.prefab_name].transform, "story_v_out_112272", "112272022", "story_v_out_112272.awb")

						arg_87_1:RecordAudio("112272022", var_90_12)
						arg_87_1:RecordAudio("112272022", var_90_12)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_112272", "112272022", "story_v_out_112272.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_112272", "112272022", "story_v_out_112272.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_13 and arg_87_1.time_ < var_90_5 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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
	Play112272023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 112272023
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play112272024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1081_1 = arg_91_1.actors_["1081_1"].transform.localPosition
				arg_91_1.actors_["1081_1"].transform.localScale = Vector3.New(1, 1, 1)
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1081_1"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1081_1, Vector3.New(0, -2000, 0), (arg_91_1.time_ - 0) / var_94_0)
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1081_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_94_1 = 0
			local var_94_2 = 1.05

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(112272023).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 42 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 42)

				if (42 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 42)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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
	Play112272024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 112272024
		arg_95_1.duration_ = 5.5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play112272025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if arg_95_1.bgs_.SA0202 == nil then
				local var_98_0 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SA0202")
				var_98_0.name = "SA0202"
				var_98_0.transform.parent = arg_95_1.stage_.transform
				var_98_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_.SA0202 = var_98_0
			end

			if 0.233333333333333 < arg_95_1.time_ and arg_95_1.time_ <= 0.233333333333333 + arg_98_0 then
				local var_98_1 = arg_95_1.bgs_.SA0202

				arg_95_1.bgs_.SA0202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_2 = var_98_1:GetComponent("SpriteRenderer")

				if var_98_2 and var_98_2.sprite then
					local var_98_3 = 2 * (var_98_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_1.transform.localScale = Vector3.New(var_98_3 / var_98_2.sprite.bounds.size.y < var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x and var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x or var_98_3 / var_98_2.sprite.bounds.size.y, var_98_3 / var_98_2.sprite.bounds.size.y < var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x and var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x or var_98_3 / var_98_2.sprite.bounds.size.y, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "SA0202" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_4 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_5 = 0.233333333333333

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_5 then
				local var_98_6 = Color.New(1, 1, 1)

				var_98_6.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_4) / var_98_5)
				arg_95_1.mask_.color = var_98_6
			end

			if arg_95_1.time_ >= var_98_4 + var_98_5 and arg_95_1.time_ < var_98_4 + var_98_5 + arg_98_0 then
				local var_98_7 = Color.New(1, 1, 1)

				var_98_7.a = 1
				arg_95_1.mask_.color = var_98_7
			end

			local var_98_8 = 0.233333333333333

			if 0.233333333333333 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_9 = 0.133333333333333

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_9 then
				local var_98_10 = Color.New(1, 1, 1)

				var_98_10.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_8) / var_98_9)
				arg_95_1.mask_.color = var_98_10
			end

			if arg_95_1.time_ >= var_98_8 + var_98_9 and arg_95_1.time_ < var_98_8 + var_98_9 + arg_98_0 then
				local var_98_11 = Color.New(1, 1, 1)

				arg_95_1.mask_.enabled = false
				var_98_11.a = 0
				arg_95_1.mask_.color = var_98_11
			end

			local var_98_12 = 0.366666666666667

			if 0.366666666666667 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_13 = 0.133333333333333

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_13 then
				local var_98_14 = Color.New(1, 1, 1)

				var_98_14.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_12) / var_98_13)
				arg_95_1.mask_.color = var_98_14
			end

			if arg_95_1.time_ >= var_98_12 + var_98_13 and arg_95_1.time_ < var_98_12 + var_98_13 + arg_98_0 then
				local var_98_15 = Color.New(1, 1, 1)

				arg_95_1.mask_.enabled = false
				var_98_15.a = 0
				arg_95_1.mask_.color = var_98_15
			end

			local var_98_16 = 0.6

			if 0.6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_17 = 0.133333333333333

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 then
				local var_98_18 = Color.New(1, 1, 1)

				var_98_18.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_16) / var_98_17)
				arg_95_1.mask_.color = var_98_18
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				local var_98_19 = Color.New(1, 1, 1)

				arg_95_1.mask_.enabled = false
				var_98_19.a = 0
				arg_95_1.mask_.color = var_98_19
			end

			local var_98_20 = 0.733333333333333

			if 0.733333333333333 < arg_95_1.time_ and arg_95_1.time_ <= var_98_20 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_21 = 0.133333333333334

			if var_98_20 <= arg_95_1.time_ and arg_95_1.time_ < var_98_20 + var_98_21 then
				local var_98_22 = Color.New(1, 1, 1)

				var_98_22.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_20) / var_98_21)
				arg_95_1.mask_.color = var_98_22
			end

			if arg_95_1.time_ >= var_98_20 + var_98_21 and arg_95_1.time_ < var_98_20 + var_98_21 + arg_98_0 then
				local var_98_23 = Color.New(1, 1, 1)

				arg_95_1.mask_.enabled = false
				var_98_23.a = 0
				arg_95_1.mask_.color = var_98_23
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_24 = 0.5
			local var_98_25 = 1.35

			if 0.5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_24 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_26 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_26:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_27 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(112272024).content)

				arg_95_1.text_.text = var_98_27

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_29 = 54 <= 0 and var_98_25 or var_98_25 * (utf8.len(var_98_27) / 54)

				if (54 <= 0 and var_98_25 or var_98_25 * (utf8.len(var_98_27) / 54)) > 0 and var_98_25 < var_98_29 then
					arg_95_1.talkMaxDuration = var_98_29
					var_98_24 = var_98_24 + 0.3

					if var_98_29 + var_98_24 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_29 + var_98_24
					end
				end

				arg_95_1.text_.text = var_98_27
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_30 = var_98_24 + 0.3
			local var_98_31 = math.max(var_98_25, arg_95_1.talkMaxDuration)

			if var_98_24 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_31 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_30) / var_98_31

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_30 + var_98_31 and arg_95_1.time_ < var_98_30 + var_98_31 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play112272025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 112272025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play112272026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.25

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(112272025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 50 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 50)

				if (50 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 50)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play112272026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 112272026
		arg_105_1.duration_ = 3.57

		local var_105_0 = {
			ja = 3.566,
			ko = 3.433,
			zh = 2.8,
			en = 2.5
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
				arg_105_0:Play112272027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.2

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(112272026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 8 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 8)

				if (8 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 8)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272026", "story_v_out_112272.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272026", "story_v_out_112272.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_112272", "112272026", "story_v_out_112272.awb")

						arg_105_1:RecordAudio("112272026", var_108_6)
						arg_105_1:RecordAudio("112272026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_112272", "112272026", "story_v_out_112272.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_112272", "112272026", "story_v_out_112272.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play112272027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 112272027
		arg_109_1.duration_ = 6.73

		local var_109_0 = {
			ja = 5.366,
			ko = 4.866,
			zh = 5,
			en = 6.733
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play112272028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.6

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(112272027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 24 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 24)

				if (24 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 24)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272027", "story_v_out_112272.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272027", "story_v_out_112272.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_112272", "112272027", "story_v_out_112272.awb")

						arg_109_1:RecordAudio("112272027", var_112_6)
						arg_109_1:RecordAudio("112272027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_112272", "112272027", "story_v_out_112272.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_112272", "112272027", "story_v_out_112272.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play112272028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 112272028
		arg_113_1.duration_ = 8.87

		local var_113_0 = {
			ja = 7.1,
			ko = 8.866,
			zh = 7.966,
			en = 6.733
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
				arg_113_0:Play112272029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.95

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(112272028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 38 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 38)

				if (38 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 38)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272028", "story_v_out_112272.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272028", "story_v_out_112272.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_112272", "112272028", "story_v_out_112272.awb")

						arg_113_1:RecordAudio("112272028", var_116_6)
						arg_113_1:RecordAudio("112272028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_112272", "112272028", "story_v_out_112272.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_112272", "112272028", "story_v_out_112272.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play112272029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 112272029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play112272030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.075

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(112272029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 3 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 3)

				if (3 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 3)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play112272030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 112272030
		arg_121_1.duration_ = 5.67

		local var_121_0 = {
			ja = 4.833,
			ko = 5.666,
			zh = 5,
			en = 3
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play112272031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.725

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(112272030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 29 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 29)

				if (29 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 29)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272030", "story_v_out_112272.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272030", "story_v_out_112272.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_112272", "112272030", "story_v_out_112272.awb")

						arg_121_1:RecordAudio("112272030", var_124_6)
						arg_121_1:RecordAudio("112272030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_112272", "112272030", "story_v_out_112272.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_112272", "112272030", "story_v_out_112272.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play112272031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 112272031
		arg_125_1.duration_ = 3.43

		local var_125_0 = {
			ja = 3.433,
			ko = 2.466,
			zh = 2.2,
			en = 2.2
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play112272032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.175

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(112272031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 7 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 7)

				if (7 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 7)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272031", "story_v_out_112272.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272031", "story_v_out_112272.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_112272", "112272031", "story_v_out_112272.awb")

						arg_125_1:RecordAudio("112272031", var_128_6)
						arg_125_1:RecordAudio("112272031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_112272", "112272031", "story_v_out_112272.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_112272", "112272031", "story_v_out_112272.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play112272032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 112272032
		arg_129_1.duration_ = 7.93

		local var_129_0 = {
			ja = 7.933,
			ko = 5.833,
			zh = 5.233,
			en = 6.566
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
			arg_129_1.auto_ = false
		end

		function arg_129_1.playNext_(arg_131_0)
			arg_129_1.onStoryFinished_()
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.625

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(112272032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 25 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 25)

				if (25 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 25)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112272", "112272032", "story_v_out_112272.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_112272", "112272032", "story_v_out_112272.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_112272", "112272032", "story_v_out_112272.awb")

						arg_129_1:RecordAudio("112272032", var_132_6)
						arg_129_1:RecordAudio("112272032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_112272", "112272032", "story_v_out_112272.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_112272", "112272032", "story_v_out_112272.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SA0202"
	},
	voices = {
		"story_v_out_112272.awb"
	}
}
