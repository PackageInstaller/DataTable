return {
	Play111121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111121001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D09a"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.D09a

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D09a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D09a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD09a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD09a = var_4_18
				end

				arg_1_1.var_.alphaOldValueD09a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD09a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueD09a then
					local var_4_22 = arg_1_1.var_.alphaMatValueD09a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD09a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD09a then
				local var_4_23 = arg_1_1.var_.alphaMatValueD09a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.875

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(111121001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 35
				local var_4_31 = utf8.len(var_4_29)
				local var_4_32 = var_4_30 <= 0 and var_4_26 or var_4_26 * (var_4_31 / var_4_30)

				if var_4_32 > 0 and var_4_26 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_25 = var_4_25 + 0.3

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_25 + 0.3
			local var_4_34 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111121002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 111121002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play111121003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.95

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_2 = arg_7_1:GetWordFromCfg(111121002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 38
				local var_10_5 = utf8.len(var_10_3)
				local var_10_6 = var_10_4 <= 0 and var_10_1 or var_10_1 * (var_10_5 / var_10_4)

				if var_10_6 > 0 and var_10_1 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_7 and arg_7_1.time_ < var_10_0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play111121003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 111121003
		arg_11_1.duration_ = 0.1

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"

			SetActive(arg_11_1.choicesGo_, true)

			for iter_12_0, iter_12_1 in ipairs(arg_11_1.choices_) do
				local var_12_0 = iter_12_0 <= 2

				SetActive(iter_12_1.go, var_12_0)
			end

			arg_11_1.choices_[1].txt.text = arg_11_1:FormatText(StoryChoiceCfg[115].name)
			arg_11_1.choices_[2].txt.text = arg_11_1:FormatText(StoryChoiceCfg[116].name)
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play111121004(arg_11_1)
			end

			if arg_13_0 == 2 then
				arg_11_0:Play111121005(arg_11_1)
			end

			arg_11_1:RecordChoiceLog(111121003, 115, 116)
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			return
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play111121004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 111121004
		arg_15_1.duration_ = 10.97

		local var_15_0 = {
			ja = 10.633,
			ko = 7.633,
			zh = 7.2,
			en = 10.966
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
				arg_15_0:Play111121005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.95

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[10].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:GetWordFromCfg(111121004)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_111121", "111121004", "story_v_out_111121.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_111121", "111121004", "story_v_out_111121.awb") / 1000

					if var_18_8 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_0
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_111121", "111121004", "story_v_out_111121.awb")

						arg_15_1:RecordAudio("111121004", var_18_9)
						arg_15_1:RecordAudio("111121004", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_111121", "111121004", "story_v_out_111121.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_111121", "111121004", "story_v_out_111121.awb")
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
	Play111121005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 111121005
		arg_19_1.duration_ = 7.9

		local var_19_0 = {
			ja = 7.9,
			ko = 4.333,
			zh = 4.833,
			en = 6.1
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
				arg_19_0:Play111121006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.95

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_2 = arg_19_1:FormatText(StoryNameCfg[10].name)

				arg_19_1.leftNameTxt_.text = var_22_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_3 = arg_19_1:GetWordFromCfg(111121005)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 21
				local var_22_6 = utf8.len(var_22_4)
				local var_22_7 = var_22_5 <= 0 and var_22_1 or var_22_1 * (var_22_6 / var_22_5)

				if var_22_7 > 0 and var_22_1 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111121", "111121005", "story_v_out_111121.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_111121", "111121005", "story_v_out_111121.awb") / 1000

					if var_22_8 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_0
					end

					if var_22_3.prefab_name ~= "" and arg_19_1.actors_[var_22_3.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_3.prefab_name].transform, "story_v_out_111121", "111121005", "story_v_out_111121.awb")

						arg_19_1:RecordAudio("111121005", var_22_9)
						arg_19_1:RecordAudio("111121005", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_111121", "111121005", "story_v_out_111121.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_111121", "111121005", "story_v_out_111121.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_10 and arg_19_1.time_ < var_22_0 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play111121006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 111121006
		arg_23_1.duration_ = 2.17

		local var_23_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.166,
			en = 1.999999999999
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
				arg_23_0:Play111121007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "1094ui_story"

			if arg_23_1.actors_[var_26_0] == nil then
				local var_26_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_26_1) then
					local var_26_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_23_1.stage_.transform)

					var_26_2.name = var_26_0
					var_26_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_23_1.actors_[var_26_0] = var_26_2

					local var_26_3 = var_26_2:GetComponentInChildren(typeof(CharacterEffect))

					var_26_3.enabled = true

					local var_26_4 = GameObjectTools.GetOrAddComponent(var_26_2, typeof(DynamicBoneHelper))

					if var_26_4 then
						var_26_4:EnableDynamicBone(false)
					end

					arg_23_1:ShowWeapon(var_26_3.transform, false)

					arg_23_1.var_[var_26_0 .. "Animator"] = var_26_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_23_1.var_[var_26_0 .. "Animator"].applyRootMotion = true
					arg_23_1.var_[var_26_0 .. "LipSync"] = var_26_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_26_5 = arg_23_1.actors_["1094ui_story"].transform
			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.var_.moveOldPos1094ui_story = var_26_5.localPosition
			end

			local var_26_7 = 0.001

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_7 then
				local var_26_8 = (arg_23_1.time_ - var_26_6) / var_26_7
				local var_26_9 = Vector3.New(0, -0.84, -6.1)

				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1094ui_story, var_26_9, var_26_8)

				local var_26_10 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_10.x, var_26_10.y, var_26_10.z)

				local var_26_11 = var_26_5.localEulerAngles

				var_26_11.z = 0
				var_26_11.x = 0
				var_26_5.localEulerAngles = var_26_11
			end

			if arg_23_1.time_ >= var_26_6 + var_26_7 and arg_23_1.time_ < var_26_6 + var_26_7 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_26_12 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_12.x, var_26_12.y, var_26_12.z)

				local var_26_13 = var_26_5.localEulerAngles

				var_26_13.z = 0
				var_26_13.x = 0
				var_26_5.localEulerAngles = var_26_13
			end

			local var_26_14 = 0

			if var_26_14 < arg_23_1.time_ and arg_23_1.time_ <= var_26_14 + arg_26_0 then
				arg_23_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_1")
			end

			local var_26_15 = 0

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 then
				arg_23_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_26_16 = arg_23_1.actors_["1094ui_story"]
			local var_26_17 = 0

			if var_26_17 < arg_23_1.time_ and arg_23_1.time_ <= var_26_17 + arg_26_0 and not isNil(var_26_16) and arg_23_1.var_.characterEffect1094ui_story == nil then
				arg_23_1.var_.characterEffect1094ui_story = var_26_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_18 = 0.2

			if var_26_17 <= arg_23_1.time_ and arg_23_1.time_ < var_26_17 + var_26_18 and not isNil(var_26_16) then
				local var_26_19 = (arg_23_1.time_ - var_26_17) / var_26_18

				if arg_23_1.var_.characterEffect1094ui_story and not isNil(var_26_16) then
					arg_23_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_17 + var_26_18 and arg_23_1.time_ < var_26_17 + var_26_18 + arg_26_0 and not isNil(var_26_16) and arg_23_1.var_.characterEffect1094ui_story then
				arg_23_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_26_20 = 0
			local var_26_21 = 1

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				local var_26_22 = "play"
				local var_26_23 = "effect"

				arg_23_1:AudioAction(var_26_22, var_26_23, "se_story_activity_1_1", "se_story_activity_1_1_hel_cannon", "")
			end

			local var_26_24 = 0
			local var_26_25 = 0.2

			if var_26_24 < arg_23_1.time_ and arg_23_1.time_ <= var_26_24 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_26 = arg_23_1:FormatText(StoryNameCfg[181].name)

				arg_23_1.leftNameTxt_.text = var_26_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_27 = arg_23_1:GetWordFromCfg(111121006)
				local var_26_28 = arg_23_1:FormatText(var_26_27.content)

				arg_23_1.text_.text = var_26_28

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_29 = 8
				local var_26_30 = utf8.len(var_26_28)
				local var_26_31 = var_26_29 <= 0 and var_26_25 or var_26_25 * (var_26_30 / var_26_29)

				if var_26_31 > 0 and var_26_25 < var_26_31 then
					arg_23_1.talkMaxDuration = var_26_31

					if var_26_31 + var_26_24 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_31 + var_26_24
					end
				end

				arg_23_1.text_.text = var_26_28
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111121", "111121006", "story_v_out_111121.awb") ~= 0 then
					local var_26_32 = manager.audio:GetVoiceLength("story_v_out_111121", "111121006", "story_v_out_111121.awb") / 1000

					if var_26_32 + var_26_24 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_32 + var_26_24
					end

					if var_26_27.prefab_name ~= "" and arg_23_1.actors_[var_26_27.prefab_name] ~= nil then
						local var_26_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_27.prefab_name].transform, "story_v_out_111121", "111121006", "story_v_out_111121.awb")

						arg_23_1:RecordAudio("111121006", var_26_33)
						arg_23_1:RecordAudio("111121006", var_26_33)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_111121", "111121006", "story_v_out_111121.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_111121", "111121006", "story_v_out_111121.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_34 = math.max(var_26_25, arg_23_1.talkMaxDuration)

			if var_26_24 <= arg_23_1.time_ and arg_23_1.time_ < var_26_24 + var_26_34 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_24) / var_26_34

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_24 + var_26_34 and arg_23_1.time_ < var_26_24 + var_26_34 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play111121007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 111121007
		arg_27_1.duration_ = 5.67

		local var_27_0 = {
			ja = 5.666,
			ko = 3.9,
			zh = 3.566,
			en = 4.066
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
				arg_27_0:Play111121008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_1 = 0.316666666666667

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_1 then
				local var_30_2 = (arg_27_1.time_ - var_30_0) / var_30_1
				local var_30_3 = Color.New(1, 1, 1)

				var_30_3.a = Mathf.Lerp(1, 0, var_30_2)
				arg_27_1.mask_.color = var_30_3
			end

			if arg_27_1.time_ >= var_30_0 + var_30_1 and arg_27_1.time_ < var_30_0 + var_30_1 + arg_30_0 then
				local var_30_4 = Color.New(1, 1, 1)
				local var_30_5 = 0

				arg_27_1.mask_.enabled = false
				var_30_4.a = var_30_5
				arg_27_1.mask_.color = var_30_4
			end

			local var_30_6 = manager.ui.mainCamera.transform
			local var_30_7 = 0

			if var_30_7 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 then
				arg_27_1.var_.shakeOldPos = var_30_6.localPosition
			end

			local var_30_8 = 0.8

			if var_30_7 <= arg_27_1.time_ and arg_27_1.time_ < var_30_7 + var_30_8 then
				local var_30_9 = (arg_27_1.time_ - var_30_7) / 0.066
				local var_30_10, var_30_11 = math.modf(var_30_9)

				var_30_6.localPosition = Vector3.New(var_30_11 * 0.13, var_30_11 * 0.13, var_30_11 * 0.13) + arg_27_1.var_.shakeOldPos
			end

			if arg_27_1.time_ >= var_30_7 + var_30_8 and arg_27_1.time_ < var_30_7 + var_30_8 + arg_30_0 then
				var_30_6.localPosition = arg_27_1.var_.shakeOldPos
			end

			local var_30_12 = 0

			if var_30_12 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				arg_27_1.allBtn_.enabled = false
			end

			local var_30_13 = 0.65

			if arg_27_1.time_ >= var_30_12 + var_30_13 and arg_27_1.time_ < var_30_12 + var_30_13 + arg_30_0 then
				arg_27_1.allBtn_.enabled = true
			end

			local var_30_14 = arg_27_1.actors_["1094ui_story"]
			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1094ui_story == nil then
				arg_27_1.var_.characterEffect1094ui_story = var_30_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_16 = 0.2

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_16 and not isNil(var_30_14) then
				local var_30_17 = (arg_27_1.time_ - var_30_15) / var_30_16

				if arg_27_1.var_.characterEffect1094ui_story and not isNil(var_30_14) then
					local var_30_18 = Mathf.Lerp(0, 0.5, var_30_17)

					arg_27_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1094ui_story.fillRatio = var_30_18
				end
			end

			if arg_27_1.time_ >= var_30_15 + var_30_16 and arg_27_1.time_ < var_30_15 + var_30_16 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1094ui_story then
				local var_30_19 = 0.5

				arg_27_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1094ui_story.fillRatio = var_30_19
			end

			local var_30_20 = 0
			local var_30_21 = 0.35

			if var_30_20 < arg_27_1.time_ and arg_27_1.time_ <= var_30_20 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_22 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_22:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_23 = arg_27_1:FormatText(StoryNameCfg[10].name)

				arg_27_1.leftNameTxt_.text = var_30_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_24 = arg_27_1:GetWordFromCfg(111121007)
				local var_30_25 = arg_27_1:FormatText(var_30_24.content)

				arg_27_1.text_.text = var_30_25

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_26 = 14
				local var_30_27 = utf8.len(var_30_25)
				local var_30_28 = var_30_26 <= 0 and var_30_21 or var_30_21 * (var_30_27 / var_30_26)

				if var_30_28 > 0 and var_30_21 < var_30_28 then
					arg_27_1.talkMaxDuration = var_30_28
					var_30_20 = var_30_20 + 0.3

					if var_30_28 + var_30_20 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_28 + var_30_20
					end
				end

				arg_27_1.text_.text = var_30_25
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111121", "111121007", "story_v_out_111121.awb") ~= 0 then
					local var_30_29 = manager.audio:GetVoiceLength("story_v_out_111121", "111121007", "story_v_out_111121.awb") / 1000

					if var_30_29 + var_30_20 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_29 + var_30_20
					end

					if var_30_24.prefab_name ~= "" and arg_27_1.actors_[var_30_24.prefab_name] ~= nil then
						local var_30_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_24.prefab_name].transform, "story_v_out_111121", "111121007", "story_v_out_111121.awb")

						arg_27_1:RecordAudio("111121007", var_30_30)
						arg_27_1:RecordAudio("111121007", var_30_30)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_111121", "111121007", "story_v_out_111121.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_111121", "111121007", "story_v_out_111121.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_31 = var_30_20 + 0.3
			local var_30_32 = math.max(var_30_21, arg_27_1.talkMaxDuration)

			if var_30_31 <= arg_27_1.time_ and arg_27_1.time_ < var_30_31 + var_30_32 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_31) / var_30_32

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_31 + var_30_32 and arg_27_1.time_ < var_30_31 + var_30_32 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play111121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 111121008
		arg_33_1.duration_ = 2.1

		local var_33_0 = {
			ja = 2.1,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play111121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_36_1 = arg_33_1.actors_["1094ui_story"]
			local var_36_2 = 0

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1094ui_story == nil then
				arg_33_1.var_.characterEffect1094ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.2

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_3 and not isNil(var_36_1) then
				local var_36_4 = (arg_33_1.time_ - var_36_2) / var_36_3

				if arg_33_1.var_.characterEffect1094ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_2 + var_36_3 and arg_33_1.time_ < var_36_2 + var_36_3 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1094ui_story then
				arg_33_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_36_5 = 0
			local var_36_6 = 0.175

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_7 = arg_33_1:FormatText(StoryNameCfg[181].name)

				arg_33_1.leftNameTxt_.text = var_36_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(111121008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 6
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_6 or var_36_6 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_6 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111121", "111121008", "story_v_out_111121.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_out_111121", "111121008", "story_v_out_111121.awb") / 1000

					if var_36_13 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_5
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_111121", "111121008", "story_v_out_111121.awb")

						arg_33_1:RecordAudio("111121008", var_36_14)
						arg_33_1:RecordAudio("111121008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_111121", "111121008", "story_v_out_111121.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_111121", "111121008", "story_v_out_111121.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_15 and arg_33_1.time_ < var_36_5 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play111121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 111121009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play111121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1094ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1094ui_story == nil then
				arg_37_1.var_.characterEffect1094ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1094ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1094ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1094ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1094ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 1.175

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(111121009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 47
				local var_40_11 = utf8.len(var_40_9)
				local var_40_12 = var_40_10 <= 0 and var_40_7 or var_40_7 * (var_40_11 / var_40_10)

				if var_40_12 > 0 and var_40_7 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_13 and arg_37_1.time_ < var_40_6 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play111121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 111121010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play111121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.2

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(111121010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 8
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
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play111121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 111121011
		arg_45_1.duration_ = 8

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play111121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "D10_1"

			if arg_45_1.bgs_[var_48_0] == nil then
				local var_48_1 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_0)
				var_48_1.name = var_48_0
				var_48_1.transform.parent = arg_45_1.stage_.transform
				var_48_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_0] = var_48_1
			end

			local var_48_2 = 1.5

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				local var_48_3 = manager.ui.mainCamera.transform.localPosition
				local var_48_4 = Vector3.New(0, 0, 10) + Vector3.New(var_48_3.x, var_48_3.y, 0)
				local var_48_5 = arg_45_1.bgs_.D10_1

				var_48_5.transform.localPosition = var_48_4
				var_48_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_6 = var_48_5:GetComponent("SpriteRenderer")

				if var_48_6 and var_48_6.sprite then
					local var_48_7 = (var_48_5.transform.localPosition - var_48_3).z
					local var_48_8 = manager.ui.mainCameraCom_
					local var_48_9 = 2 * var_48_7 * Mathf.Tan(var_48_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_10 = var_48_9 * var_48_8.aspect
					local var_48_11 = var_48_6.sprite.bounds.size.x
					local var_48_12 = var_48_6.sprite.bounds.size.y
					local var_48_13 = var_48_10 / var_48_11
					local var_48_14 = var_48_9 / var_48_12
					local var_48_15 = var_48_14 < var_48_13 and var_48_13 or var_48_14

					var_48_5.transform.localScale = Vector3.New(var_48_15, var_48_15, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "D10_1" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_16 = arg_45_1.bgs_.D09a
			local var_48_17 = 0

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				local var_48_18 = var_48_16:GetComponent("SpriteRenderer")

				if var_48_18 then
					arg_45_1.var_.alphaOldValueD09a = var_48_18.color.a
					arg_45_1.var_.alphaMatValueD09a = var_48_18
				end

				arg_45_1.var_.alphaOldValueD09a = 1
			end

			local var_48_19 = 1.5

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_19 then
				local var_48_20 = (arg_45_1.time_ - var_48_17) / var_48_19
				local var_48_21 = Mathf.Lerp(arg_45_1.var_.alphaOldValueD09a, 0, var_48_20)

				if arg_45_1.var_.alphaMatValueD09a then
					local var_48_22 = arg_45_1.var_.alphaMatValueD09a.color

					var_48_22.a = var_48_21
					arg_45_1.var_.alphaMatValueD09a.color = var_48_22
				end
			end

			if arg_45_1.time_ >= var_48_17 + var_48_19 and arg_45_1.time_ < var_48_17 + var_48_19 + arg_48_0 and arg_45_1.var_.alphaMatValueD09a then
				local var_48_23 = arg_45_1.var_.alphaMatValueD09a
				local var_48_24 = var_48_23.color

				var_48_24.a = 0
				var_48_23.color = var_48_24
			end

			local var_48_25 = arg_45_1.bgs_.D10_1
			local var_48_26 = 1.5

			if var_48_26 < arg_45_1.time_ and arg_45_1.time_ <= var_48_26 + arg_48_0 then
				local var_48_27 = var_48_25:GetComponent("SpriteRenderer")

				if var_48_27 then
					arg_45_1.var_.alphaOldValueD10_1 = var_48_27.color.a
					arg_45_1.var_.alphaMatValueD10_1 = var_48_27
				end

				arg_45_1.var_.alphaOldValueD10_1 = 0
			end

			local var_48_28 = 1.5

			if var_48_26 <= arg_45_1.time_ and arg_45_1.time_ < var_48_26 + var_48_28 then
				local var_48_29 = (arg_45_1.time_ - var_48_26) / var_48_28
				local var_48_30 = Mathf.Lerp(arg_45_1.var_.alphaOldValueD10_1, 1, var_48_29)

				if arg_45_1.var_.alphaMatValueD10_1 then
					local var_48_31 = arg_45_1.var_.alphaMatValueD10_1.color

					var_48_31.a = var_48_30
					arg_45_1.var_.alphaMatValueD10_1.color = var_48_31
				end
			end

			if arg_45_1.time_ >= var_48_26 + var_48_28 and arg_45_1.time_ < var_48_26 + var_48_28 + arg_48_0 and arg_45_1.var_.alphaMatValueD10_1 then
				local var_48_32 = arg_45_1.var_.alphaMatValueD10_1
				local var_48_33 = var_48_32.color

				var_48_33.a = 1
				var_48_32.color = var_48_33
			end

			local var_48_34 = arg_45_1.actors_["1094ui_story"].transform
			local var_48_35 = 0

			if var_48_35 < arg_45_1.time_ and arg_45_1.time_ <= var_48_35 + arg_48_0 then
				arg_45_1.var_.moveOldPos1094ui_story = var_48_34.localPosition
			end

			local var_48_36 = 0.001

			if var_48_35 <= arg_45_1.time_ and arg_45_1.time_ < var_48_35 + var_48_36 then
				local var_48_37 = (arg_45_1.time_ - var_48_35) / var_48_36
				local var_48_38 = Vector3.New(0, 100, 0)

				var_48_34.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1094ui_story, var_48_38, var_48_37)

				local var_48_39 = manager.ui.mainCamera.transform.position - var_48_34.position

				var_48_34.forward = Vector3.New(var_48_39.x, var_48_39.y, var_48_39.z)

				local var_48_40 = var_48_34.localEulerAngles

				var_48_40.z = 0
				var_48_40.x = 0
				var_48_34.localEulerAngles = var_48_40
			end

			if arg_45_1.time_ >= var_48_35 + var_48_36 and arg_45_1.time_ < var_48_35 + var_48_36 + arg_48_0 then
				var_48_34.localPosition = Vector3.New(0, 100, 0)

				local var_48_41 = manager.ui.mainCamera.transform.position - var_48_34.position

				var_48_34.forward = Vector3.New(var_48_41.x, var_48_41.y, var_48_41.z)

				local var_48_42 = var_48_34.localEulerAngles

				var_48_42.z = 0
				var_48_42.x = 0
				var_48_34.localEulerAngles = var_48_42
			end

			local var_48_43 = 0

			if var_48_43 < arg_45_1.time_ and arg_45_1.time_ <= var_48_43 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_44 = 3

			if arg_45_1.time_ >= var_48_43 + var_48_44 and arg_45_1.time_ < var_48_43 + var_48_44 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_45 = 3
			local var_48_46 = 1.6

			if var_48_45 < arg_45_1.time_ and arg_45_1.time_ <= var_48_45 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_47 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_47:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_48 = arg_45_1:GetWordFromCfg(111121011)
				local var_48_49 = arg_45_1:FormatText(var_48_48.content)

				arg_45_1.text_.text = var_48_49

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_50 = 64
				local var_48_51 = utf8.len(var_48_49)
				local var_48_52 = var_48_50 <= 0 and var_48_46 or var_48_46 * (var_48_51 / var_48_50)

				if var_48_52 > 0 and var_48_46 < var_48_52 then
					arg_45_1.talkMaxDuration = var_48_52
					var_48_45 = var_48_45 + 0.3

					if var_48_52 + var_48_45 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_52 + var_48_45
					end
				end

				arg_45_1.text_.text = var_48_49
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_53 = var_48_45 + 0.3
			local var_48_54 = math.max(var_48_46, arg_45_1.talkMaxDuration)

			if var_48_53 <= arg_45_1.time_ and arg_45_1.time_ < var_48_53 + var_48_54 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_53) / var_48_54

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_53 + var_48_54 and arg_45_1.time_ < var_48_53 + var_48_54 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play111121012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 111121012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play111121013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.35

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_2

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

				local var_54_3 = arg_51_1:GetWordFromCfg(111121012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 14
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play111121013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 111121013
		arg_55_1.duration_ = 4.5

		local var_55_0 = {
			ja = 4.5,
			ko = 2.966,
			zh = 3.966,
			en = 3.6
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
				arg_55_0:Play111121014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action423")
			end

			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_58_2 = arg_55_1.actors_["1094ui_story"]
			local var_58_3 = 0

			if var_58_3 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1094ui_story == nil then
				arg_55_1.var_.characterEffect1094ui_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.2

			if var_58_3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_3 + var_58_4 and not isNil(var_58_2) then
				local var_58_5 = (arg_55_1.time_ - var_58_3) / var_58_4

				if arg_55_1.var_.characterEffect1094ui_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_3 + var_58_4 and arg_55_1.time_ < var_58_3 + var_58_4 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1094ui_story then
				arg_55_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_58_6 = arg_55_1.actors_["1094ui_story"].transform
			local var_58_7 = 0

			if var_58_7 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.var_.moveOldPos1094ui_story = var_58_6.localPosition
			end

			local var_58_8 = 0.001

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_8 then
				local var_58_9 = (arg_55_1.time_ - var_58_7) / var_58_8
				local var_58_10 = Vector3.New(0, -0.84, -6.1)

				var_58_6.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1094ui_story, var_58_10, var_58_9)

				local var_58_11 = manager.ui.mainCamera.transform.position - var_58_6.position

				var_58_6.forward = Vector3.New(var_58_11.x, var_58_11.y, var_58_11.z)

				local var_58_12 = var_58_6.localEulerAngles

				var_58_12.z = 0
				var_58_12.x = 0
				var_58_6.localEulerAngles = var_58_12
			end

			if arg_55_1.time_ >= var_58_7 + var_58_8 and arg_55_1.time_ < var_58_7 + var_58_8 + arg_58_0 then
				var_58_6.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_58_13 = manager.ui.mainCamera.transform.position - var_58_6.position

				var_58_6.forward = Vector3.New(var_58_13.x, var_58_13.y, var_58_13.z)

				local var_58_14 = var_58_6.localEulerAngles

				var_58_14.z = 0
				var_58_14.x = 0
				var_58_6.localEulerAngles = var_58_14
			end

			local var_58_15 = 0
			local var_58_16 = 0.35

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[181].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(111121013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 14
				local var_58_21 = utf8.len(var_58_19)
				local var_58_22 = var_58_20 <= 0 and var_58_16 or var_58_16 * (var_58_21 / var_58_20)

				if var_58_22 > 0 and var_58_16 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22

					if var_58_22 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111121", "111121013", "story_v_out_111121.awb") ~= 0 then
					local var_58_23 = manager.audio:GetVoiceLength("story_v_out_111121", "111121013", "story_v_out_111121.awb") / 1000

					if var_58_23 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_15
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_out_111121", "111121013", "story_v_out_111121.awb")

						arg_55_1:RecordAudio("111121013", var_58_24)
						arg_55_1:RecordAudio("111121013", var_58_24)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_111121", "111121013", "story_v_out_111121.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_111121", "111121013", "story_v_out_111121.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_25 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_25 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_25

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_25 and arg_55_1.time_ < var_58_15 + var_58_25 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play111121014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 111121014
		arg_59_1.duration_ = 4.6

		local var_59_0 = {
			ja = 4.6,
			ko = 4.2,
			zh = 4,
			en = 3.866
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
			arg_59_1.auto_ = false
		end

		function arg_59_1.playNext_(arg_61_0)
			arg_59_1.onStoryFinished_()
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1094ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1094ui_story == nil then
				arg_59_1.var_.characterEffect1094ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1094ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1094ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1094ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1094ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 0.45

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[10].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(111121014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 18
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111121", "111121014", "story_v_out_111121.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_111121", "111121014", "story_v_out_111121.awb") / 1000

					if var_62_14 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_6
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_111121", "111121014", "story_v_out_111121.awb")

						arg_59_1:RecordAudio("111121014", var_62_15)
						arg_59_1:RecordAudio("111121014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_111121", "111121014", "story_v_out_111121.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_111121", "111121014", "story_v_out_111121.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_16 and arg_59_1.time_ < var_62_6 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D09a",
		"TextureConfig/Background/D10_1"
	},
	voices = {
		"story_v_out_111121.awb"
	}
}
