return {
	Play104021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "effect"

				arg_1_1:AudioAction(var_4_2, var_4_3, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_4 = 0
			local var_4_5 = 1

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_6 = "play"
				local var_4_7 = "effect"

				arg_1_1:AudioAction(var_4_6, var_4_7, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_8 = "B08c"

			if arg_1_1.bgs_[var_4_8] == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			local var_4_10 = arg_1_1.bgs_.B08c
			local var_4_11 = 0

			if var_4_11 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				local var_4_12 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_12 then
					arg_1_1.var_.alphaOldValueB08c = var_4_12.color.a
					arg_1_1.var_.alphaMatValueB08c = var_4_12
				end

				arg_1_1.var_.alphaOldValueB08c = 0
			end

			local var_4_13 = 1.5

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_13 then
				local var_4_14 = (arg_1_1.time_ - var_4_11) / var_4_13
				local var_4_15 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB08c, 1, var_4_14)

				if arg_1_1.var_.alphaMatValueB08c then
					local var_4_16 = arg_1_1.var_.alphaMatValueB08c.color

					var_4_16.a = var_4_15
					arg_1_1.var_.alphaMatValueB08c.color = var_4_16
				end
			end

			if arg_1_1.time_ >= var_4_11 + var_4_13 and arg_1_1.time_ < var_4_11 + var_4_13 + arg_4_0 and arg_1_1.var_.alphaMatValueB08c then
				local var_4_17 = arg_1_1.var_.alphaMatValueB08c
				local var_4_18 = var_4_17.color

				var_4_18.a = 1
				var_4_17.color = var_4_18
			end

			local var_4_19 = 0

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				local var_4_20 = manager.ui.mainCamera.transform.localPosition
				local var_4_21 = Vector3.New(0, 0, 10) + Vector3.New(var_4_20.x, var_4_20.y, 0)
				local var_4_22 = arg_1_1.bgs_.B08c

				var_4_22.transform.localPosition = var_4_21
				var_4_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_23 = var_4_22:GetComponent("SpriteRenderer")

				if var_4_23 and var_4_23.sprite then
					local var_4_24 = (var_4_22.transform.localPosition - var_4_20).z
					local var_4_25 = manager.ui.mainCameraCom_
					local var_4_26 = 2 * var_4_24 * Mathf.Tan(var_4_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_27 = var_4_26 * var_4_25.aspect
					local var_4_28 = var_4_23.sprite.bounds.size.x
					local var_4_29 = var_4_23.sprite.bounds.size.y
					local var_4_30 = var_4_27 / var_4_28
					local var_4_31 = var_4_26 / var_4_29
					local var_4_32 = var_4_31 < var_4_30 and var_4_30 or var_4_31

					var_4_22.transform.localScale = Vector3.New(var_4_32, var_4_32, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_33 = 0

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_34 = 2

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_35 = 2
			local var_4_36 = 0.45

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_37 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_37:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_38 = arg_1_1:GetWordFromCfg(104021001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 18
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_36 or var_4_36 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_36 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_35 = var_4_35 + 0.3

					if var_4_42 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_35
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_35 + 0.3
			local var_4_44 = math.max(var_4_36, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104021002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 104021002
		arg_7_1.duration_ = 12.6

		local var_7_0 = {
			ja = 8.8,
			ko = 9.5,
			zh = 12.6,
			en = 8.2
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
				arg_7_0:Play104021003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.65

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_2 = arg_7_1:FormatText(StoryNameCfg[35].name)

				arg_7_1.leftNameTxt_.text = var_10_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_3 = arg_7_1:GetWordFromCfg(104021002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021002", "story_v_out_104021.awb") ~= 0 then
					local var_10_8 = manager.audio:GetVoiceLength("story_v_out_104021", "104021002", "story_v_out_104021.awb") / 1000

					if var_10_8 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_8 + var_10_0
					end

					if var_10_3.prefab_name ~= "" and arg_7_1.actors_[var_10_3.prefab_name] ~= nil then
						local var_10_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_3.prefab_name].transform, "story_v_out_104021", "104021002", "story_v_out_104021.awb")

						arg_7_1:RecordAudio("104021002", var_10_9)
						arg_7_1:RecordAudio("104021002", var_10_9)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_104021", "104021002", "story_v_out_104021.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_104021", "104021002", "story_v_out_104021.awb")
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
	Play104021003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 104021003
		arg_11_1.duration_ = 9.23

		local var_11_0 = {
			ja = 9.233,
			ko = 3.833,
			zh = 9.033,
			en = 4.233
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
				arg_11_0:Play104021005(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 0.625

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_2 = arg_11_1:FormatText(StoryNameCfg[35].name)

				arg_11_1.leftNameTxt_.text = var_14_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_3 = arg_11_1:GetWordFromCfg(104021003)
				local var_14_4 = arg_11_1:FormatText(var_14_3.content)

				arg_11_1.text_.text = var_14_4

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 25
				local var_14_6 = utf8.len(var_14_4)
				local var_14_7 = var_14_5 <= 0 and var_14_1 or var_14_1 * (var_14_6 / var_14_5)

				if var_14_7 > 0 and var_14_1 < var_14_7 then
					arg_11_1.talkMaxDuration = var_14_7

					if var_14_7 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_7 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_4
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021003", "story_v_out_104021.awb") ~= 0 then
					local var_14_8 = manager.audio:GetVoiceLength("story_v_out_104021", "104021003", "story_v_out_104021.awb") / 1000

					if var_14_8 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_8 + var_14_0
					end

					if var_14_3.prefab_name ~= "" and arg_11_1.actors_[var_14_3.prefab_name] ~= nil then
						local var_14_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_3.prefab_name].transform, "story_v_out_104021", "104021003", "story_v_out_104021.awb")

						arg_11_1:RecordAudio("104021003", var_14_9)
						arg_11_1:RecordAudio("104021003", var_14_9)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_104021", "104021003", "story_v_out_104021.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_104021", "104021003", "story_v_out_104021.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_10 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_10 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_10

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_10 and arg_11_1.time_ < var_14_0 + var_14_10 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play104021005 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 104021005
		arg_15_1.duration_ = 4.9

		local var_15_0 = {
			ja = 2.233,
			ko = 2.333,
			zh = 4.9,
			en = 3.833
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
				arg_15_0:Play104021006(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.175

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[35].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:GetWordFromCfg(104021005)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021005", "story_v_out_104021.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_104021", "104021005", "story_v_out_104021.awb") / 1000

					if var_18_8 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_0
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_104021", "104021005", "story_v_out_104021.awb")

						arg_15_1:RecordAudio("104021005", var_18_9)
						arg_15_1:RecordAudio("104021005", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_104021", "104021005", "story_v_out_104021.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_104021", "104021005", "story_v_out_104021.awb")
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
	Play104021006 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 104021006
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play104021007(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.85

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(104021006)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 33
				local var_22_5 = utf8.len(var_22_3)
				local var_22_6 = var_22_4 <= 0 and var_22_1 or var_22_1 * (var_22_5 / var_22_4)

				if var_22_6 > 0 and var_22_1 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_7 and arg_19_1.time_ < var_22_0 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play104021007 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 104021007
		arg_23_1.duration_ = 4.77

		local var_23_0 = {
			ja = 4.766,
			ko = 4.033,
			zh = 3.4,
			en = 4.3
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
				arg_23_0:Play104021008(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "10002ui_story"

			if arg_23_1.actors_[var_26_0] == nil then
				local var_26_1 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_26_1) then
					local var_26_2 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_23_1.stage_.transform)

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

			local var_26_5 = arg_23_1.actors_["10002ui_story"]
			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect10002ui_story == nil then
				arg_23_1.var_.characterEffect10002ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_7 = 0.1

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_7 and not isNil(var_26_5) then
				local var_26_8 = (arg_23_1.time_ - var_26_6) / var_26_7

				if arg_23_1.var_.characterEffect10002ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_6 + var_26_7 and arg_23_1.time_ < var_26_6 + var_26_7 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect10002ui_story then
				arg_23_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_26_9 = arg_23_1.actors_["10002ui_story"].transform
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 then
				arg_23_1.var_.moveOldPos10002ui_story = var_26_9.localPosition
			end

			local var_26_11 = 0.001

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11
				local var_26_13 = Vector3.New(0, -1.2, -5.8)

				var_26_9.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10002ui_story, var_26_13, var_26_12)

				local var_26_14 = manager.ui.mainCamera.transform.position - var_26_9.position

				var_26_9.forward = Vector3.New(var_26_14.x, var_26_14.y, var_26_14.z)

				local var_26_15 = var_26_9.localEulerAngles

				var_26_15.z = 0
				var_26_15.x = 0
				var_26_9.localEulerAngles = var_26_15
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 then
				var_26_9.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_26_16 = manager.ui.mainCamera.transform.position - var_26_9.position

				var_26_9.forward = Vector3.New(var_26_16.x, var_26_16.y, var_26_16.z)

				local var_26_17 = var_26_9.localEulerAngles

				var_26_17.z = 0
				var_26_17.x = 0
				var_26_9.localEulerAngles = var_26_17
			end

			local var_26_18 = 0

			if var_26_18 < arg_23_1.time_ and arg_23_1.time_ <= var_26_18 + arg_26_0 then
				arg_23_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 then
				arg_23_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_20 = 0
			local var_26_21 = 0.375

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_22 = arg_23_1:FormatText(StoryNameCfg[39].name)

				arg_23_1.leftNameTxt_.text = var_26_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_23 = arg_23_1:GetWordFromCfg(104021007)
				local var_26_24 = arg_23_1:FormatText(var_26_23.content)

				arg_23_1.text_.text = var_26_24

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_25 = 15
				local var_26_26 = utf8.len(var_26_24)
				local var_26_27 = var_26_25 <= 0 and var_26_21 or var_26_21 * (var_26_26 / var_26_25)

				if var_26_27 > 0 and var_26_21 < var_26_27 then
					arg_23_1.talkMaxDuration = var_26_27

					if var_26_27 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_27 + var_26_20
					end
				end

				arg_23_1.text_.text = var_26_24
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021007", "story_v_out_104021.awb") ~= 0 then
					local var_26_28 = manager.audio:GetVoiceLength("story_v_out_104021", "104021007", "story_v_out_104021.awb") / 1000

					if var_26_28 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_20
					end

					if var_26_23.prefab_name ~= "" and arg_23_1.actors_[var_26_23.prefab_name] ~= nil then
						local var_26_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_23.prefab_name].transform, "story_v_out_104021", "104021007", "story_v_out_104021.awb")

						arg_23_1:RecordAudio("104021007", var_26_29)
						arg_23_1:RecordAudio("104021007", var_26_29)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_104021", "104021007", "story_v_out_104021.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_104021", "104021007", "story_v_out_104021.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_30 = math.max(var_26_21, arg_23_1.talkMaxDuration)

			if var_26_20 <= arg_23_1.time_ and arg_23_1.time_ < var_26_20 + var_26_30 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_20) / var_26_30

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_20 + var_26_30 and arg_23_1.time_ < var_26_20 + var_26_30 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play104021008 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 104021008
		arg_27_1.duration_ = 5.33

		local var_27_0 = {
			ja = 4.133,
			ko = 2.866,
			zh = 5.333,
			en = 4.3
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
				arg_27_0:Play104021009(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["10002ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect10002ui_story == nil then
				arg_27_1.var_.characterEffect10002ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.1

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect10002ui_story and not isNil(var_30_0) then
					local var_30_4 = Mathf.Lerp(0, 0.5, var_30_3)

					arg_27_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_27_1.var_.characterEffect10002ui_story.fillRatio = var_30_4
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect10002ui_story then
				local var_30_5 = 0.5

				arg_27_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_27_1.var_.characterEffect10002ui_story.fillRatio = var_30_5
			end

			local var_30_6 = arg_27_1.actors_["10002ui_story"].transform
			local var_30_7 = 0

			if var_30_7 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 then
				arg_27_1.var_.moveOldPos10002ui_story = var_30_6.localPosition
			end

			local var_30_8 = 0.001

			if var_30_7 <= arg_27_1.time_ and arg_27_1.time_ < var_30_7 + var_30_8 then
				local var_30_9 = (arg_27_1.time_ - var_30_7) / var_30_8
				local var_30_10 = Vector3.New(0, 100, 0)

				var_30_6.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10002ui_story, var_30_10, var_30_9)

				local var_30_11 = manager.ui.mainCamera.transform.position - var_30_6.position

				var_30_6.forward = Vector3.New(var_30_11.x, var_30_11.y, var_30_11.z)

				local var_30_12 = var_30_6.localEulerAngles

				var_30_12.z = 0
				var_30_12.x = 0
				var_30_6.localEulerAngles = var_30_12
			end

			if arg_27_1.time_ >= var_30_7 + var_30_8 and arg_27_1.time_ < var_30_7 + var_30_8 + arg_30_0 then
				var_30_6.localPosition = Vector3.New(0, 100, 0)

				local var_30_13 = manager.ui.mainCamera.transform.position - var_30_6.position

				var_30_6.forward = Vector3.New(var_30_13.x, var_30_13.y, var_30_13.z)

				local var_30_14 = var_30_6.localEulerAngles

				var_30_14.z = 0
				var_30_14.x = 0
				var_30_6.localEulerAngles = var_30_14
			end

			local var_30_15 = 0
			local var_30_16 = 0.25

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_17 = arg_27_1:FormatText(StoryNameCfg[35].name)

				arg_27_1.leftNameTxt_.text = var_30_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_18 = arg_27_1:GetWordFromCfg(104021008)
				local var_30_19 = arg_27_1:FormatText(var_30_18.content)

				arg_27_1.text_.text = var_30_19

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_20 = 10
				local var_30_21 = utf8.len(var_30_19)
				local var_30_22 = var_30_20 <= 0 and var_30_16 or var_30_16 * (var_30_21 / var_30_20)

				if var_30_22 > 0 and var_30_16 < var_30_22 then
					arg_27_1.talkMaxDuration = var_30_22

					if var_30_22 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_22 + var_30_15
					end
				end

				arg_27_1.text_.text = var_30_19
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021008", "story_v_out_104021.awb") ~= 0 then
					local var_30_23 = manager.audio:GetVoiceLength("story_v_out_104021", "104021008", "story_v_out_104021.awb") / 1000

					if var_30_23 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_23 + var_30_15
					end

					if var_30_18.prefab_name ~= "" and arg_27_1.actors_[var_30_18.prefab_name] ~= nil then
						local var_30_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_18.prefab_name].transform, "story_v_out_104021", "104021008", "story_v_out_104021.awb")

						arg_27_1:RecordAudio("104021008", var_30_24)
						arg_27_1:RecordAudio("104021008", var_30_24)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_104021", "104021008", "story_v_out_104021.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_104021", "104021008", "story_v_out_104021.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_25 = math.max(var_30_16, arg_27_1.talkMaxDuration)

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_25 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_15) / var_30_25

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_15 + var_30_25 and arg_27_1.time_ < var_30_15 + var_30_25 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play104021009 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 104021009
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play104021010(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 1

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				local var_34_2 = "play"
				local var_34_3 = "music"

				arg_31_1:AudioAction(var_34_2, var_34_3, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				local var_34_4 = ""
				local var_34_5 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if var_34_5 ~= "" then
					if arg_31_1.bgmTxt_.text ~= var_34_5 and arg_31_1.bgmTxt_.text ~= "" then
						if arg_31_1.bgmTxt2_.text ~= "" then
							arg_31_1.bgmTxt_.text = arg_31_1.bgmTxt2_.text
						end

						arg_31_1.bgmTxt2_.text = var_34_5

						arg_31_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_31_1.bgmTxt_.text = var_34_5
						arg_31_1.bgmTxt2_.text = var_34_5
					end

					if arg_31_1.bgmTimer then
						arg_31_1.bgmTimer:Stop()

						arg_31_1.bgmTimer = nil
					end

					if arg_31_1.settingData.show_music_name == 1 then
						arg_31_1.musicController:SetSelectedState("show")
						arg_31_1.musicAnimator_:Play("open", 0, 0)

						if arg_31_1.settingData.music_time ~= 0 then
							arg_31_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_31_1.settingData.music_time), function()
								if arg_31_1 == nil or isNil(arg_31_1.bgmTxt_) then
									return
								end

								arg_31_1.musicController:SetSelectedState("hide")
								arg_31_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_34_6 = 0
			local var_34_7 = 0.55

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:GetWordFromCfg(104021009)
				local var_34_9 = arg_31_1:FormatText(var_34_8.content)

				arg_31_1.text_.text = var_34_9

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 22
				local var_34_11 = utf8.len(var_34_9)
				local var_34_12 = var_34_10 <= 0 and var_34_7 or var_34_7 * (var_34_11 / var_34_10)

				if var_34_12 > 0 and var_34_7 < var_34_12 then
					arg_31_1.talkMaxDuration = var_34_12

					if var_34_12 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_9
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_13 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_13 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_13

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_13 and arg_31_1.time_ < var_34_6 + var_34_13 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play104021010 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104021010
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play104021011(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.775

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(104021010)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 31
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104021011 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104021011
		arg_40_1.duration_ = 9

		local var_40_0 = {
			ja = 5.566,
			ko = 5.566,
			zh = 6.3,
			en = 9
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104021012(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10002ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10002ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10002ui_story then
				arg_40_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["10002ui_story"].transform
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.var_.moveOldPos10002ui_story = var_43_4.localPosition
			end

			local var_43_6 = 0.001

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6
				local var_43_8 = Vector3.New(-0.7, -1.2, -5.8)

				var_43_4.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10002ui_story, var_43_8, var_43_7)

				local var_43_9 = manager.ui.mainCamera.transform.position - var_43_4.position

				var_43_4.forward = Vector3.New(var_43_9.x, var_43_9.y, var_43_9.z)

				local var_43_10 = var_43_4.localEulerAngles

				var_43_10.z = 0
				var_43_10.x = 0
				var_43_4.localEulerAngles = var_43_10
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 then
				var_43_4.localPosition = Vector3.New(-0.7, -1.2, -5.8)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_4.position

				var_43_4.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_4.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_4.localEulerAngles = var_43_12
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_1")
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_43_15 = 0
			local var_43_16 = 0.875

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[39].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(104021011)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 31
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021011", "story_v_out_104021.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_104021", "104021011", "story_v_out_104021.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_104021", "104021011", "story_v_out_104021.awb")

						arg_40_1:RecordAudio("104021011", var_43_24)
						arg_40_1:RecordAudio("104021011", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104021", "104021011", "story_v_out_104021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104021", "104021011", "story_v_out_104021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_25 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_25

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_25 and arg_40_1.time_ < var_43_15 + var_43_25 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play104021012 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104021012
		arg_44_1.duration_ = 3.63

		local var_44_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 2.533,
			en = 1.999999999999
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104021013(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "1013ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "1013ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["1013ui_story"]
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1013ui_story == nil then
				arg_44_1.var_.characterEffect1013ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 and not isNil(var_47_5) then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7

				if arg_44_1.var_.characterEffect1013ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1013ui_story then
				arg_44_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_47_9 = arg_44_1.actors_["10002ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect10002ui_story == nil then
				arg_44_1.var_.characterEffect10002ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.1

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect10002ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10002ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect10002ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10002ui_story.fillRatio = var_47_14
			end

			local var_47_15 = arg_44_1.actors_["1013ui_story"].transform
			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.var_.moveOldPos1013ui_story = var_47_15.localPosition
			end

			local var_47_17 = 0.001

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Vector3.New(0.7, -0.66, -6.15)

				var_47_15.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1013ui_story, var_47_19, var_47_18)

				local var_47_20 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_20.x, var_47_20.y, var_47_20.z)

				local var_47_21 = var_47_15.localEulerAngles

				var_47_21.z = 0
				var_47_21.x = 0
				var_47_15.localEulerAngles = var_47_21
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				var_47_15.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_47_22 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_22.x, var_47_22.y, var_47_22.z)

				local var_47_23 = var_47_15.localEulerAngles

				var_47_23.z = 0
				var_47_23.x = 0
				var_47_15.localEulerAngles = var_47_23
			end

			local var_47_24 = 0

			if var_47_24 < arg_44_1.time_ and arg_44_1.time_ <= var_47_24 + arg_47_0 then
				arg_44_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action1_1")
			end

			local var_47_25 = 0

			if var_47_25 < arg_44_1.time_ and arg_44_1.time_ <= var_47_25 + arg_47_0 then
				arg_44_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_47_26 = 0
			local var_47_27 = 0.175

			if var_47_26 < arg_44_1.time_ and arg_44_1.time_ <= var_47_26 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_28 = arg_44_1:FormatText(StoryNameCfg[35].name)

				arg_44_1.leftNameTxt_.text = var_47_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_29 = arg_44_1:GetWordFromCfg(104021012)
				local var_47_30 = arg_44_1:FormatText(var_47_29.content)

				arg_44_1.text_.text = var_47_30

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_31 = 7
				local var_47_32 = utf8.len(var_47_30)
				local var_47_33 = var_47_31 <= 0 and var_47_27 or var_47_27 * (var_47_32 / var_47_31)

				if var_47_33 > 0 and var_47_27 < var_47_33 then
					arg_44_1.talkMaxDuration = var_47_33

					if var_47_33 + var_47_26 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_33 + var_47_26
					end
				end

				arg_44_1.text_.text = var_47_30
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021012", "story_v_out_104021.awb") ~= 0 then
					local var_47_34 = manager.audio:GetVoiceLength("story_v_out_104021", "104021012", "story_v_out_104021.awb") / 1000

					if var_47_34 + var_47_26 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_34 + var_47_26
					end

					if var_47_29.prefab_name ~= "" and arg_44_1.actors_[var_47_29.prefab_name] ~= nil then
						local var_47_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_29.prefab_name].transform, "story_v_out_104021", "104021012", "story_v_out_104021.awb")

						arg_44_1:RecordAudio("104021012", var_47_35)
						arg_44_1:RecordAudio("104021012", var_47_35)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104021", "104021012", "story_v_out_104021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104021", "104021012", "story_v_out_104021.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_36 = math.max(var_47_27, arg_44_1.talkMaxDuration)

			if var_47_26 <= arg_44_1.time_ and arg_44_1.time_ < var_47_26 + var_47_36 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_26) / var_47_36

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_26 + var_47_36 and arg_44_1.time_ < var_47_26 + var_47_36 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play104021013 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104021013
		arg_48_1.duration_ = 3.87

		local var_48_0 = {
			ja = 3.866,
			ko = 2.233,
			zh = 2.1,
			en = 3.066
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play104021014(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10002ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10002ui_story == nil then
				arg_48_1.var_.characterEffect10002ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10002ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10002ui_story then
				arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1013ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1013ui_story == nil then
				arg_48_1.var_.characterEffect1013ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1013ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1013ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1013ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1013ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_2")
			end

			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_51_12 = 0
			local var_51_13 = 0.225

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_14 = arg_48_1:FormatText(StoryNameCfg[39].name)

				arg_48_1.leftNameTxt_.text = var_51_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_15 = arg_48_1:GetWordFromCfg(104021013)
				local var_51_16 = arg_48_1:FormatText(var_51_15.content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 9
				local var_51_18 = utf8.len(var_51_16)
				local var_51_19 = var_51_17 <= 0 and var_51_13 or var_51_13 * (var_51_18 / var_51_17)

				if var_51_19 > 0 and var_51_13 < var_51_19 then
					arg_48_1.talkMaxDuration = var_51_19

					if var_51_19 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021013", "story_v_out_104021.awb") ~= 0 then
					local var_51_20 = manager.audio:GetVoiceLength("story_v_out_104021", "104021013", "story_v_out_104021.awb") / 1000

					if var_51_20 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_20 + var_51_12
					end

					if var_51_15.prefab_name ~= "" and arg_48_1.actors_[var_51_15.prefab_name] ~= nil then
						local var_51_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_15.prefab_name].transform, "story_v_out_104021", "104021013", "story_v_out_104021.awb")

						arg_48_1:RecordAudio("104021013", var_51_21)
						arg_48_1:RecordAudio("104021013", var_51_21)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104021", "104021013", "story_v_out_104021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104021", "104021013", "story_v_out_104021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_22 and arg_48_1.time_ < var_51_12 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play104021014 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104021014
		arg_52_1.duration_ = 2

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play104021015(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1013ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1013ui_story == nil then
				arg_52_1.var_.characterEffect1013ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1013ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1013ui_story then
				arg_52_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["10002ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect10002ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10002ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10002ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10002ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action2_1")
			end

			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_55_12 = 0
			local var_55_13 = 0.075

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[35].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(104021014)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 3
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021014", "story_v_out_104021.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_104021", "104021014", "story_v_out_104021.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_104021", "104021014", "story_v_out_104021.awb")

						arg_52_1:RecordAudio("104021014", var_55_21)
						arg_52_1:RecordAudio("104021014", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104021", "104021014", "story_v_out_104021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104021", "104021014", "story_v_out_104021.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104021015 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104021015
		arg_56_1.duration_ = 4.2

		local var_56_0 = {
			ja = 4.2,
			ko = 3.133,
			zh = 3.8,
			en = 4.2
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104021016(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action425")
			end

			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_59_2 = 0
			local var_59_3 = 0.375

			if var_59_2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_4 = arg_56_1:FormatText(StoryNameCfg[35].name)

				arg_56_1.leftNameTxt_.text = var_59_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_5 = arg_56_1:GetWordFromCfg(104021015)
				local var_59_6 = arg_56_1:FormatText(var_59_5.content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 15
				local var_59_8 = utf8.len(var_59_6)
				local var_59_9 = var_59_7 <= 0 and var_59_3 or var_59_3 * (var_59_8 / var_59_7)

				if var_59_9 > 0 and var_59_3 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021015", "story_v_out_104021.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021015", "story_v_out_104021.awb") / 1000

					if var_59_10 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_2
					end

					if var_59_5.prefab_name ~= "" and arg_56_1.actors_[var_59_5.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_5.prefab_name].transform, "story_v_out_104021", "104021015", "story_v_out_104021.awb")

						arg_56_1:RecordAudio("104021015", var_59_11)
						arg_56_1:RecordAudio("104021015", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104021", "104021015", "story_v_out_104021.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104021", "104021015", "story_v_out_104021.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_12 and arg_56_1.time_ < var_59_2 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play104021016 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104021016
		arg_60_1.duration_ = 7.37

		local var_60_0 = {
			ja = 3.5,
			ko = 7.1,
			zh = 7.366,
			en = 5.166
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play104021017(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4510")
			end

			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_63_2 = 0
			local var_63_3 = 0.975

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_4 = arg_60_1:FormatText(StoryNameCfg[35].name)

				arg_60_1.leftNameTxt_.text = var_63_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_5 = arg_60_1:GetWordFromCfg(104021016)
				local var_63_6 = arg_60_1:FormatText(var_63_5.content)

				arg_60_1.text_.text = var_63_6

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 38
				local var_63_8 = utf8.len(var_63_6)
				local var_63_9 = var_63_7 <= 0 and var_63_3 or var_63_3 * (var_63_8 / var_63_7)

				if var_63_9 > 0 and var_63_3 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_6
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021016", "story_v_out_104021.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021016", "story_v_out_104021.awb") / 1000

					if var_63_10 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_2
					end

					if var_63_5.prefab_name ~= "" and arg_60_1.actors_[var_63_5.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_5.prefab_name].transform, "story_v_out_104021", "104021016", "story_v_out_104021.awb")

						arg_60_1:RecordAudio("104021016", var_63_11)
						arg_60_1:RecordAudio("104021016", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104021", "104021016", "story_v_out_104021.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104021", "104021016", "story_v_out_104021.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_12 and arg_60_1.time_ < var_63_2 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play104021017 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104021017
		arg_64_1.duration_ = 2.27

		local var_64_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play104021018(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10002ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10002ui_story == nil then
				arg_64_1.var_.characterEffect10002ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10002ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10002ui_story then
				arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1013ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1013ui_story == nil then
				arg_64_1.var_.characterEffect1013ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1013ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1013ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1013ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1013ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_67_12 = 0
			local var_67_13 = 0.05

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_14 = arg_64_1:FormatText(StoryNameCfg[39].name)

				arg_64_1.leftNameTxt_.text = var_67_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_15 = arg_64_1:GetWordFromCfg(104021017)
				local var_67_16 = arg_64_1:FormatText(var_67_15.content)

				arg_64_1.text_.text = var_67_16

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 2
				local var_67_18 = utf8.len(var_67_16)
				local var_67_19 = var_67_17 <= 0 and var_67_13 or var_67_13 * (var_67_18 / var_67_17)

				if var_67_19 > 0 and var_67_13 < var_67_19 then
					arg_64_1.talkMaxDuration = var_67_19

					if var_67_19 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_12
					end
				end

				arg_64_1.text_.text = var_67_16
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021017", "story_v_out_104021.awb") ~= 0 then
					local var_67_20 = manager.audio:GetVoiceLength("story_v_out_104021", "104021017", "story_v_out_104021.awb") / 1000

					if var_67_20 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_20 + var_67_12
					end

					if var_67_15.prefab_name ~= "" and arg_64_1.actors_[var_67_15.prefab_name] ~= nil then
						local var_67_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_15.prefab_name].transform, "story_v_out_104021", "104021017", "story_v_out_104021.awb")

						arg_64_1:RecordAudio("104021017", var_67_21)
						arg_64_1:RecordAudio("104021017", var_67_21)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_104021", "104021017", "story_v_out_104021.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_104021", "104021017", "story_v_out_104021.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_22 = math.max(var_67_13, arg_64_1.talkMaxDuration)

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_22 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_12) / var_67_22

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_12 + var_67_22 and arg_64_1.time_ < var_67_12 + var_67_22 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play104021018 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104021018
		arg_68_1.duration_ = 9.37

		local var_68_0 = {
			ja = 9.366,
			ko = 8.6,
			zh = 6.433,
			en = 7.333
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play104021019(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action423")
			end

			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_71_2 = 0
			local var_71_3 = 0.8

			if var_71_2 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_4 = arg_68_1:FormatText(StoryNameCfg[39].name)

				arg_68_1.leftNameTxt_.text = var_71_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_5 = arg_68_1:GetWordFromCfg(104021018)
				local var_71_6 = arg_68_1:FormatText(var_71_5.content)

				arg_68_1.text_.text = var_71_6

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 32
				local var_71_8 = utf8.len(var_71_6)
				local var_71_9 = var_71_7 <= 0 and var_71_3 or var_71_3 * (var_71_8 / var_71_7)

				if var_71_9 > 0 and var_71_3 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_6
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021018", "story_v_out_104021.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021018", "story_v_out_104021.awb") / 1000

					if var_71_10 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_2
					end

					if var_71_5.prefab_name ~= "" and arg_68_1.actors_[var_71_5.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_5.prefab_name].transform, "story_v_out_104021", "104021018", "story_v_out_104021.awb")

						arg_68_1:RecordAudio("104021018", var_71_11)
						arg_68_1:RecordAudio("104021018", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104021", "104021018", "story_v_out_104021.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104021", "104021018", "story_v_out_104021.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_12 and arg_68_1.time_ < var_71_2 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play104021019 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104021019
		arg_72_1.duration_ = 9.1

		local var_72_0 = {
			ja = 9.1,
			ko = 7.7,
			zh = 5.9,
			en = 6.4
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play104021020(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1013ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1013ui_story == nil then
				arg_72_1.var_.characterEffect1013ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1013ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1013ui_story then
				arg_72_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["10002ui_story"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect10002ui_story == nil then
				arg_72_1.var_.characterEffect10002ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.1

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect10002ui_story and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10002ui_story.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect10002ui_story then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10002ui_story.fillRatio = var_75_9
			end

			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4104")
			end

			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_75_12 = 0
			local var_75_13 = 0.675

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_14 = arg_72_1:FormatText(StoryNameCfg[35].name)

				arg_72_1.leftNameTxt_.text = var_75_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_15 = arg_72_1:GetWordFromCfg(104021019)
				local var_75_16 = arg_72_1:FormatText(var_75_15.content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 27
				local var_75_18 = utf8.len(var_75_16)
				local var_75_19 = var_75_17 <= 0 and var_75_13 or var_75_13 * (var_75_18 / var_75_17)

				if var_75_19 > 0 and var_75_13 < var_75_19 then
					arg_72_1.talkMaxDuration = var_75_19

					if var_75_19 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_12
					end
				end

				arg_72_1.text_.text = var_75_16
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021019", "story_v_out_104021.awb") ~= 0 then
					local var_75_20 = manager.audio:GetVoiceLength("story_v_out_104021", "104021019", "story_v_out_104021.awb") / 1000

					if var_75_20 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_20 + var_75_12
					end

					if var_75_15.prefab_name ~= "" and arg_72_1.actors_[var_75_15.prefab_name] ~= nil then
						local var_75_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_15.prefab_name].transform, "story_v_out_104021", "104021019", "story_v_out_104021.awb")

						arg_72_1:RecordAudio("104021019", var_75_21)
						arg_72_1:RecordAudio("104021019", var_75_21)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_104021", "104021019", "story_v_out_104021.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_104021", "104021019", "story_v_out_104021.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_13, arg_72_1.talkMaxDuration)

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_12) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_12 + var_75_22 and arg_72_1.time_ < var_75_12 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play104021020 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 104021020
		arg_76_1.duration_ = 2.57

		local var_76_0 = {
			ja = 2.566,
			ko = 2.133,
			zh = 2.266,
			en = 1.999999999999
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play104021021(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10002ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10002ui_story == nil then
				arg_76_1.var_.characterEffect10002ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect10002ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10002ui_story then
				arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1013ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1013ui_story == nil then
				arg_76_1.var_.characterEffect1013ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.1

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1013ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1013ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1013ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1013ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			local var_79_11 = 0

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_79_12 = 0
			local var_79_13 = 0.15

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_14 = arg_76_1:FormatText(StoryNameCfg[39].name)

				arg_76_1.leftNameTxt_.text = var_79_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_15 = arg_76_1:GetWordFromCfg(104021020)
				local var_79_16 = arg_76_1:FormatText(var_79_15.content)

				arg_76_1.text_.text = var_79_16

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_17 = 6
				local var_79_18 = utf8.len(var_79_16)
				local var_79_19 = var_79_17 <= 0 and var_79_13 or var_79_13 * (var_79_18 / var_79_17)

				if var_79_19 > 0 and var_79_13 < var_79_19 then
					arg_76_1.talkMaxDuration = var_79_19

					if var_79_19 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_12
					end
				end

				arg_76_1.text_.text = var_79_16
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021020", "story_v_out_104021.awb") ~= 0 then
					local var_79_20 = manager.audio:GetVoiceLength("story_v_out_104021", "104021020", "story_v_out_104021.awb") / 1000

					if var_79_20 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_20 + var_79_12
					end

					if var_79_15.prefab_name ~= "" and arg_76_1.actors_[var_79_15.prefab_name] ~= nil then
						local var_79_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_15.prefab_name].transform, "story_v_out_104021", "104021020", "story_v_out_104021.awb")

						arg_76_1:RecordAudio("104021020", var_79_21)
						arg_76_1:RecordAudio("104021020", var_79_21)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_104021", "104021020", "story_v_out_104021.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_104021", "104021020", "story_v_out_104021.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_22 = math.max(var_79_13, arg_76_1.talkMaxDuration)

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_12) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_12 + var_79_22 and arg_76_1.time_ < var_79_12 + var_79_22 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play104021021 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 104021021
		arg_80_1.duration_ = 9.03

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play104021022(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10002ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10002ui_story == nil then
				arg_80_1.var_.characterEffect10002ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect10002ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10002ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10002ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10002ui_story.fillRatio = var_83_5
			end

			local var_83_6 = arg_80_1.actors_["10002ui_story"].transform
			local var_83_7 = 0

			if var_83_7 < arg_80_1.time_ and arg_80_1.time_ <= var_83_7 + arg_83_0 then
				arg_80_1.var_.moveOldPos10002ui_story = var_83_6.localPosition
			end

			local var_83_8 = 0.001

			if var_83_7 <= arg_80_1.time_ and arg_80_1.time_ < var_83_7 + var_83_8 then
				local var_83_9 = (arg_80_1.time_ - var_83_7) / var_83_8
				local var_83_10 = Vector3.New(0, 100, 0)

				var_83_6.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10002ui_story, var_83_10, var_83_9)

				local var_83_11 = manager.ui.mainCamera.transform.position - var_83_6.position

				var_83_6.forward = Vector3.New(var_83_11.x, var_83_11.y, var_83_11.z)

				local var_83_12 = var_83_6.localEulerAngles

				var_83_12.z = 0
				var_83_12.x = 0
				var_83_6.localEulerAngles = var_83_12
			end

			if arg_80_1.time_ >= var_83_7 + var_83_8 and arg_80_1.time_ < var_83_7 + var_83_8 + arg_83_0 then
				var_83_6.localPosition = Vector3.New(0, 100, 0)

				local var_83_13 = manager.ui.mainCamera.transform.position - var_83_6.position

				var_83_6.forward = Vector3.New(var_83_13.x, var_83_13.y, var_83_13.z)

				local var_83_14 = var_83_6.localEulerAngles

				var_83_14.z = 0
				var_83_14.x = 0
				var_83_6.localEulerAngles = var_83_14
			end

			local var_83_15 = arg_80_1.actors_["1013ui_story"].transform
			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.var_.moveOldPos1013ui_story = var_83_15.localPosition
			end

			local var_83_17 = 0.001

			if var_83_16 <= arg_80_1.time_ and arg_80_1.time_ < var_83_16 + var_83_17 then
				local var_83_18 = (arg_80_1.time_ - var_83_16) / var_83_17
				local var_83_19 = Vector3.New(0, 100, 0)

				var_83_15.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1013ui_story, var_83_19, var_83_18)

				local var_83_20 = manager.ui.mainCamera.transform.position - var_83_15.position

				var_83_15.forward = Vector3.New(var_83_20.x, var_83_20.y, var_83_20.z)

				local var_83_21 = var_83_15.localEulerAngles

				var_83_21.z = 0
				var_83_21.x = 0
				var_83_15.localEulerAngles = var_83_21
			end

			if arg_80_1.time_ >= var_83_16 + var_83_17 and arg_80_1.time_ < var_83_16 + var_83_17 + arg_83_0 then
				var_83_15.localPosition = Vector3.New(0, 100, 0)

				local var_83_22 = manager.ui.mainCamera.transform.position - var_83_15.position

				var_83_15.forward = Vector3.New(var_83_22.x, var_83_22.y, var_83_22.z)

				local var_83_23 = var_83_15.localEulerAngles

				var_83_23.z = 0
				var_83_23.x = 0
				var_83_15.localEulerAngles = var_83_23
			end

			local var_83_24 = 0
			local var_83_25 = 0.7

			if var_83_24 < arg_80_1.time_ and arg_80_1.time_ <= var_83_24 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_26 = arg_80_1:GetWordFromCfg(104021021)
				local var_83_27 = arg_80_1:FormatText(var_83_26.content)

				arg_80_1.text_.text = var_83_27

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_28 = 28
				local var_83_29 = utf8.len(var_83_27)
				local var_83_30 = var_83_28 <= 0 and var_83_25 or var_83_25 * (var_83_29 / var_83_28)

				if var_83_30 > 0 and var_83_25 < var_83_30 then
					arg_80_1.talkMaxDuration = var_83_30

					if var_83_30 + var_83_24 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_30 + var_83_24
					end
				end

				arg_80_1.text_.text = var_83_27
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021021", "story_v_out_104021.awb") ~= 0 then
					local var_83_31 = manager.audio:GetVoiceLength("story_v_out_104021", "104021021", "story_v_out_104021.awb") / 1000

					if var_83_31 + var_83_24 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_31 + var_83_24
					end

					if var_83_26.prefab_name ~= "" and arg_80_1.actors_[var_83_26.prefab_name] ~= nil then
						local var_83_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_26.prefab_name].transform, "story_v_out_104021", "104021021", "story_v_out_104021.awb")

						arg_80_1:RecordAudio("104021021", var_83_32)
						arg_80_1:RecordAudio("104021021", var_83_32)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_104021", "104021021", "story_v_out_104021.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_104021", "104021021", "story_v_out_104021.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_33 = math.max(var_83_25, arg_80_1.talkMaxDuration)

			if var_83_24 <= arg_80_1.time_ and arg_80_1.time_ < var_83_24 + var_83_33 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_24) / var_83_33

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_24 + var_83_33 and arg_80_1.time_ < var_83_24 + var_83_33 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play104021022 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104021022
		arg_84_1.duration_ = 7.07

		local var_84_0 = {
			ja = 7.066,
			ko = 3.9,
			zh = 4.466,
			en = 4.533
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play104021023(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				local var_87_2 = "play"
				local var_87_3 = "effect"

				arg_84_1:AudioAction(var_87_2, var_87_3, "se_story", "se_story_robot_long", "")
			end

			local var_87_4 = "2018_tpose"

			if arg_84_1.actors_[var_87_4] == nil then
				local var_87_5 = Asset.Load("Char/" .. "2018_tpose")

				if not isNil(var_87_5) then
					local var_87_6 = Object.Instantiate(Asset.Load("Char/" .. "2018_tpose"), arg_84_1.stage_.transform)

					var_87_6.name = var_87_4
					var_87_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_84_1.actors_[var_87_4] = var_87_6

					local var_87_7 = var_87_6:GetComponentInChildren(typeof(CharacterEffect))

					var_87_7.enabled = true

					local var_87_8 = GameObjectTools.GetOrAddComponent(var_87_6, typeof(DynamicBoneHelper))

					if var_87_8 then
						var_87_8:EnableDynamicBone(false)
					end

					arg_84_1:ShowWeapon(var_87_7.transform, false)

					arg_84_1.var_[var_87_4 .. "Animator"] = var_87_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_84_1.var_[var_87_4 .. "Animator"].applyRootMotion = true
					arg_84_1.var_[var_87_4 .. "LipSync"] = var_87_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_87_9 = arg_84_1.actors_["2018_tpose"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect2018_tpose == nil then
				arg_84_1.var_.characterEffect2018_tpose = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.1

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect2018_tpose and not isNil(var_87_9) then
					arg_84_1.var_.characterEffect2018_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect2018_tpose then
				arg_84_1.var_.characterEffect2018_tpose.fillFlat = false
			end

			local var_87_13 = arg_84_1.actors_["2018_tpose"].transform
			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1.var_.moveOldPos2018_tpose = var_87_13.localPosition

				local var_87_15 = GameObjectTools.GetOrAddComponent(var_87_13.gameObject, typeof(DynamicBoneHelper))

				if var_87_15 then
					var_87_15:EnableDynamicBone(false)
				end
			end

			local var_87_16 = 0.001

			if var_87_14 <= arg_84_1.time_ and arg_84_1.time_ < var_87_14 + var_87_16 then
				local var_87_17 = (arg_84_1.time_ - var_87_14) / var_87_16
				local var_87_18 = Vector3.New(0, -0.5, -0.7)

				var_87_13.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos2018_tpose, var_87_18, var_87_17)

				local var_87_19 = manager.ui.mainCamera.transform.position - var_87_13.position

				var_87_13.forward = Vector3.New(var_87_19.x, var_87_19.y, var_87_19.z)

				local var_87_20 = var_87_13.localEulerAngles

				var_87_20.z = 0
				var_87_20.x = 0
				var_87_13.localEulerAngles = var_87_20
			end

			if arg_84_1.time_ >= var_87_14 + var_87_16 and arg_84_1.time_ < var_87_14 + var_87_16 + arg_87_0 then
				var_87_13.localPosition = Vector3.New(0, -0.5, -0.7)

				local var_87_21 = manager.ui.mainCamera.transform.position - var_87_13.position

				var_87_13.forward = Vector3.New(var_87_21.x, var_87_21.y, var_87_21.z)

				local var_87_22 = var_87_13.localEulerAngles

				var_87_22.z = 0
				var_87_22.x = 0
				var_87_13.localEulerAngles = var_87_22

				local var_87_23 = GameObjectTools.GetOrAddComponent(var_87_13.gameObject, typeof(DynamicBoneHelper))

				if var_87_23 then
					var_87_23:EnableDynamicBone(true)
				end
			end

			local var_87_24 = 0

			if var_87_24 < arg_84_1.time_ and arg_84_1.time_ <= var_87_24 + arg_87_0 then
				arg_84_1:PlayTimeline("2018_tpose", "StoryTimeline/CharAction/story2018/story2018action/2018action1_1")
			end

			local var_87_25 = 0
			local var_87_26 = 0.375

			if var_87_25 < arg_84_1.time_ and arg_84_1.time_ <= var_87_25 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_27 = arg_84_1:FormatText(StoryNameCfg[29].name)

				arg_84_1.leftNameTxt_.text = var_87_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_28 = arg_84_1:GetWordFromCfg(104021022)
				local var_87_29 = arg_84_1:FormatText(var_87_28.content)

				arg_84_1.text_.text = var_87_29

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_30 = 15
				local var_87_31 = utf8.len(var_87_29)
				local var_87_32 = var_87_30 <= 0 and var_87_26 or var_87_26 * (var_87_31 / var_87_30)

				if var_87_32 > 0 and var_87_26 < var_87_32 then
					arg_84_1.talkMaxDuration = var_87_32

					if var_87_32 + var_87_25 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_32 + var_87_25
					end
				end

				arg_84_1.text_.text = var_87_29
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021022", "story_v_out_104021.awb") ~= 0 then
					local var_87_33 = manager.audio:GetVoiceLength("story_v_out_104021", "104021022", "story_v_out_104021.awb") / 1000

					if var_87_33 + var_87_25 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_33 + var_87_25
					end

					if var_87_28.prefab_name ~= "" and arg_84_1.actors_[var_87_28.prefab_name] ~= nil then
						local var_87_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_28.prefab_name].transform, "story_v_out_104021", "104021022", "story_v_out_104021.awb")

						arg_84_1:RecordAudio("104021022", var_87_34)
						arg_84_1:RecordAudio("104021022", var_87_34)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104021", "104021022", "story_v_out_104021.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104021", "104021022", "story_v_out_104021.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_35 = math.max(var_87_26, arg_84_1.talkMaxDuration)

			if var_87_25 <= arg_84_1.time_ and arg_84_1.time_ < var_87_25 + var_87_35 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_25) / var_87_35

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_25 + var_87_35 and arg_84_1.time_ < var_87_25 + var_87_35 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2018_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play104021023 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 104021023
		arg_88_1.duration_ = 4

		local var_88_0 = {
			ja = 4,
			ko = 2.533,
			zh = 4,
			en = 3.433
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play104021024(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				local var_91_2 = "play"
				local var_91_3 = "effect"

				arg_88_1:AudioAction(var_91_2, var_91_3, "se_story", "se_story_robot_short", "")
			end

			local var_91_4 = "2022_tpose"

			if arg_88_1.actors_[var_91_4] == nil then
				local var_91_5 = Asset.Load("Char/" .. "2022_tpose")

				if not isNil(var_91_5) then
					local var_91_6 = Object.Instantiate(Asset.Load("Char/" .. "2022_tpose"), arg_88_1.stage_.transform)

					var_91_6.name = var_91_4
					var_91_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_88_1.actors_[var_91_4] = var_91_6

					local var_91_7 = var_91_6:GetComponentInChildren(typeof(CharacterEffect))

					var_91_7.enabled = true

					local var_91_8 = GameObjectTools.GetOrAddComponent(var_91_6, typeof(DynamicBoneHelper))

					if var_91_8 then
						var_91_8:EnableDynamicBone(false)
					end

					arg_88_1:ShowWeapon(var_91_7.transform, false)

					arg_88_1.var_[var_91_4 .. "Animator"] = var_91_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_88_1.var_[var_91_4 .. "Animator"].applyRootMotion = true
					arg_88_1.var_[var_91_4 .. "LipSync"] = var_91_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_91_9 = arg_88_1.actors_["2022_tpose"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect2022_tpose == nil then
				arg_88_1.var_.characterEffect2022_tpose = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.1

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect2022_tpose and not isNil(var_91_9) then
					arg_88_1.var_.characterEffect2022_tpose.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect2022_tpose then
				arg_88_1.var_.characterEffect2022_tpose.fillFlat = false
			end

			local var_91_13 = arg_88_1.actors_["2018_tpose"]
			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 and not isNil(var_91_13) and arg_88_1.var_.characterEffect2018_tpose == nil then
				arg_88_1.var_.characterEffect2018_tpose = var_91_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_15 = 0.1

			if var_91_14 <= arg_88_1.time_ and arg_88_1.time_ < var_91_14 + var_91_15 and not isNil(var_91_13) then
				local var_91_16 = (arg_88_1.time_ - var_91_14) / var_91_15

				if arg_88_1.var_.characterEffect2018_tpose and not isNil(var_91_13) then
					local var_91_17 = Mathf.Lerp(0, 0.5, var_91_16)

					arg_88_1.var_.characterEffect2018_tpose.fillFlat = true
					arg_88_1.var_.characterEffect2018_tpose.fillRatio = var_91_17
				end
			end

			if arg_88_1.time_ >= var_91_14 + var_91_15 and arg_88_1.time_ < var_91_14 + var_91_15 + arg_91_0 and not isNil(var_91_13) and arg_88_1.var_.characterEffect2018_tpose then
				local var_91_18 = 0.5

				arg_88_1.var_.characterEffect2018_tpose.fillFlat = true
				arg_88_1.var_.characterEffect2018_tpose.fillRatio = var_91_18
			end

			local var_91_19 = arg_88_1.actors_["2018_tpose"].transform
			local var_91_20 = 0

			if var_91_20 < arg_88_1.time_ and arg_88_1.time_ <= var_91_20 + arg_91_0 then
				arg_88_1.var_.moveOldPos2018_tpose = var_91_19.localPosition

				local var_91_21 = GameObjectTools.GetOrAddComponent(var_91_19.gameObject, typeof(DynamicBoneHelper))

				if var_91_21 then
					var_91_21:EnableDynamicBone(false)
				end
			end

			local var_91_22 = 0.001

			if var_91_20 <= arg_88_1.time_ and arg_88_1.time_ < var_91_20 + var_91_22 then
				local var_91_23 = (arg_88_1.time_ - var_91_20) / var_91_22
				local var_91_24 = Vector3.New(0, 100, 0)

				var_91_19.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos2018_tpose, var_91_24, var_91_23)

				local var_91_25 = manager.ui.mainCamera.transform.position - var_91_19.position

				var_91_19.forward = Vector3.New(var_91_25.x, var_91_25.y, var_91_25.z)

				local var_91_26 = var_91_19.localEulerAngles

				var_91_26.z = 0
				var_91_26.x = 0
				var_91_19.localEulerAngles = var_91_26
			end

			if arg_88_1.time_ >= var_91_20 + var_91_22 and arg_88_1.time_ < var_91_20 + var_91_22 + arg_91_0 then
				var_91_19.localPosition = Vector3.New(0, 100, 0)

				local var_91_27 = manager.ui.mainCamera.transform.position - var_91_19.position

				var_91_19.forward = Vector3.New(var_91_27.x, var_91_27.y, var_91_27.z)

				local var_91_28 = var_91_19.localEulerAngles

				var_91_28.z = 0
				var_91_28.x = 0
				var_91_19.localEulerAngles = var_91_28

				local var_91_29 = GameObjectTools.GetOrAddComponent(var_91_19.gameObject, typeof(DynamicBoneHelper))

				if var_91_29 then
					var_91_29:EnableDynamicBone(true)
				end
			end

			local var_91_30 = arg_88_1.actors_["2022_tpose"].transform
			local var_91_31 = 0

			if var_91_31 < arg_88_1.time_ and arg_88_1.time_ <= var_91_31 + arg_91_0 then
				arg_88_1.var_.moveOldPos2022_tpose = var_91_30.localPosition

				local var_91_32 = GameObjectTools.GetOrAddComponent(var_91_30.gameObject, typeof(DynamicBoneHelper))

				if var_91_32 then
					var_91_32:EnableDynamicBone(false)
				end
			end

			local var_91_33 = 0.001

			if var_91_31 <= arg_88_1.time_ and arg_88_1.time_ < var_91_31 + var_91_33 then
				local var_91_34 = (arg_88_1.time_ - var_91_31) / var_91_33
				local var_91_35 = Vector3.New(-0.7, -0.55, -0.3)

				var_91_30.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos2022_tpose, var_91_35, var_91_34)

				local var_91_36 = manager.ui.mainCamera.transform.position - var_91_30.position

				var_91_30.forward = Vector3.New(var_91_36.x, var_91_36.y, var_91_36.z)

				local var_91_37 = var_91_30.localEulerAngles

				var_91_37.z = 0
				var_91_37.x = 0
				var_91_30.localEulerAngles = var_91_37
			end

			if arg_88_1.time_ >= var_91_31 + var_91_33 and arg_88_1.time_ < var_91_31 + var_91_33 + arg_91_0 then
				var_91_30.localPosition = Vector3.New(-0.7, -0.55, -0.3)

				local var_91_38 = manager.ui.mainCamera.transform.position - var_91_30.position

				var_91_30.forward = Vector3.New(var_91_38.x, var_91_38.y, var_91_38.z)

				local var_91_39 = var_91_30.localEulerAngles

				var_91_39.z = 0
				var_91_39.x = 0
				var_91_30.localEulerAngles = var_91_39

				local var_91_40 = GameObjectTools.GetOrAddComponent(var_91_30.gameObject, typeof(DynamicBoneHelper))

				if var_91_40 then
					var_91_40:EnableDynamicBone(true)
				end
			end

			local var_91_41 = 0

			if var_91_41 < arg_88_1.time_ and arg_88_1.time_ <= var_91_41 + arg_91_0 then
				arg_88_1:PlayTimeline("2022_tpose", "StoryTimeline/CharAction/story2022/story2022action/2022action1_1")
			end

			local var_91_42 = 0
			local var_91_43 = 0.225

			if var_91_42 < arg_88_1.time_ and arg_88_1.time_ <= var_91_42 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_44 = arg_88_1:FormatText(StoryNameCfg[29].name)

				arg_88_1.leftNameTxt_.text = var_91_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_45 = arg_88_1:GetWordFromCfg(104021023)
				local var_91_46 = arg_88_1:FormatText(var_91_45.content)

				arg_88_1.text_.text = var_91_46

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_47 = 9
				local var_91_48 = utf8.len(var_91_46)
				local var_91_49 = var_91_47 <= 0 and var_91_43 or var_91_43 * (var_91_48 / var_91_47)

				if var_91_49 > 0 and var_91_43 < var_91_49 then
					arg_88_1.talkMaxDuration = var_91_49

					if var_91_49 + var_91_42 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_49 + var_91_42
					end
				end

				arg_88_1.text_.text = var_91_46
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021023", "story_v_out_104021.awb") ~= 0 then
					local var_91_50 = manager.audio:GetVoiceLength("story_v_out_104021", "104021023", "story_v_out_104021.awb") / 1000

					if var_91_50 + var_91_42 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_50 + var_91_42
					end

					if var_91_45.prefab_name ~= "" and arg_88_1.actors_[var_91_45.prefab_name] ~= nil then
						local var_91_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_45.prefab_name].transform, "story_v_out_104021", "104021023", "story_v_out_104021.awb")

						arg_88_1:RecordAudio("104021023", var_91_51)
						arg_88_1:RecordAudio("104021023", var_91_51)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_104021", "104021023", "story_v_out_104021.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_104021", "104021023", "story_v_out_104021.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_52 = math.max(var_91_43, arg_88_1.talkMaxDuration)

			if var_91_42 <= arg_88_1.time_ and arg_88_1.time_ < var_91_42 + var_91_52 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_42) / var_91_52

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_42 + var_91_52 and arg_88_1.time_ < var_91_42 + var_91_52 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2018_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2022_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play104021024 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 104021024
		arg_92_1.duration_ = 4.17

		local var_92_0 = {
			ja = 3.266,
			ko = 2.466,
			zh = 4.166,
			en = 3.433
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play104021025(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				local var_95_2 = "play"
				local var_95_3 = "effect"

				arg_92_1:AudioAction(var_95_2, var_95_3, "se_story", "se_story_robot_short", "")
			end

			local var_95_4 = "2021_tpose"

			if arg_92_1.actors_[var_95_4] == nil then
				local var_95_5 = Asset.Load("Char/" .. "2021_tpose")

				if not isNil(var_95_5) then
					local var_95_6 = Object.Instantiate(Asset.Load("Char/" .. "2021_tpose"), arg_92_1.stage_.transform)

					var_95_6.name = var_95_4
					var_95_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_92_1.actors_[var_95_4] = var_95_6

					local var_95_7 = var_95_6:GetComponentInChildren(typeof(CharacterEffect))

					var_95_7.enabled = true

					local var_95_8 = GameObjectTools.GetOrAddComponent(var_95_6, typeof(DynamicBoneHelper))

					if var_95_8 then
						var_95_8:EnableDynamicBone(false)
					end

					arg_92_1:ShowWeapon(var_95_7.transform, false)

					arg_92_1.var_[var_95_4 .. "Animator"] = var_95_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_92_1.var_[var_95_4 .. "Animator"].applyRootMotion = true
					arg_92_1.var_[var_95_4 .. "LipSync"] = var_95_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_95_9 = arg_92_1.actors_["2021_tpose"]
			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect2021_tpose == nil then
				arg_92_1.var_.characterEffect2021_tpose = var_95_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.1

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 and not isNil(var_95_9) then
				local var_95_12 = (arg_92_1.time_ - var_95_10) / var_95_11

				if arg_92_1.var_.characterEffect2021_tpose and not isNil(var_95_9) then
					arg_92_1.var_.characterEffect2021_tpose.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect2021_tpose then
				arg_92_1.var_.characterEffect2021_tpose.fillFlat = false
			end

			local var_95_13 = arg_92_1.actors_["2022_tpose"]
			local var_95_14 = 0

			if var_95_14 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 and not isNil(var_95_13) and arg_92_1.var_.characterEffect2022_tpose == nil then
				arg_92_1.var_.characterEffect2022_tpose = var_95_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_15 = 0.1

			if var_95_14 <= arg_92_1.time_ and arg_92_1.time_ < var_95_14 + var_95_15 and not isNil(var_95_13) then
				local var_95_16 = (arg_92_1.time_ - var_95_14) / var_95_15

				if arg_92_1.var_.characterEffect2022_tpose and not isNil(var_95_13) then
					local var_95_17 = Mathf.Lerp(0, 0.5, var_95_16)

					arg_92_1.var_.characterEffect2022_tpose.fillFlat = true
					arg_92_1.var_.characterEffect2022_tpose.fillRatio = var_95_17
				end
			end

			if arg_92_1.time_ >= var_95_14 + var_95_15 and arg_92_1.time_ < var_95_14 + var_95_15 + arg_95_0 and not isNil(var_95_13) and arg_92_1.var_.characterEffect2022_tpose then
				local var_95_18 = 0.5

				arg_92_1.var_.characterEffect2022_tpose.fillFlat = true
				arg_92_1.var_.characterEffect2022_tpose.fillRatio = var_95_18
			end

			local var_95_19 = arg_92_1.actors_["2021_tpose"].transform
			local var_95_20 = 0

			if var_95_20 < arg_92_1.time_ and arg_92_1.time_ <= var_95_20 + arg_95_0 then
				arg_92_1.var_.moveOldPos2021_tpose = var_95_19.localPosition

				local var_95_21 = GameObjectTools.GetOrAddComponent(var_95_19.gameObject, typeof(DynamicBoneHelper))

				if var_95_21 then
					var_95_21:EnableDynamicBone(false)
				end
			end

			local var_95_22 = 0.001

			if var_95_20 <= arg_92_1.time_ and arg_92_1.time_ < var_95_20 + var_95_22 then
				local var_95_23 = (arg_92_1.time_ - var_95_20) / var_95_22
				local var_95_24 = Vector3.New(1.92, -0.6, 0.2)

				var_95_19.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos2021_tpose, var_95_24, var_95_23)

				local var_95_25 = manager.ui.mainCamera.transform.position - var_95_19.position

				var_95_19.forward = Vector3.New(var_95_25.x, var_95_25.y, var_95_25.z)

				local var_95_26 = var_95_19.localEulerAngles

				var_95_26.z = 0
				var_95_26.x = 0
				var_95_19.localEulerAngles = var_95_26
			end

			if arg_92_1.time_ >= var_95_20 + var_95_22 and arg_92_1.time_ < var_95_20 + var_95_22 + arg_95_0 then
				var_95_19.localPosition = Vector3.New(1.92, -0.6, 0.2)

				local var_95_27 = manager.ui.mainCamera.transform.position - var_95_19.position

				var_95_19.forward = Vector3.New(var_95_27.x, var_95_27.y, var_95_27.z)

				local var_95_28 = var_95_19.localEulerAngles

				var_95_28.z = 0
				var_95_28.x = 0
				var_95_19.localEulerAngles = var_95_28

				local var_95_29 = GameObjectTools.GetOrAddComponent(var_95_19.gameObject, typeof(DynamicBoneHelper))

				if var_95_29 then
					var_95_29:EnableDynamicBone(true)
				end
			end

			local var_95_30 = 0

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1:PlayTimeline("2021_tpose", "StoryTimeline/CharAction/story2021/story2021action/2021action1_1")
			end

			local var_95_31 = 0
			local var_95_32 = 0.225

			if var_95_31 < arg_92_1.time_ and arg_92_1.time_ <= var_95_31 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_33 = arg_92_1:FormatText(StoryNameCfg[29].name)

				arg_92_1.leftNameTxt_.text = var_95_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_34 = arg_92_1:GetWordFromCfg(104021024)
				local var_95_35 = arg_92_1:FormatText(var_95_34.content)

				arg_92_1.text_.text = var_95_35

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_36 = 9
				local var_95_37 = utf8.len(var_95_35)
				local var_95_38 = var_95_36 <= 0 and var_95_32 or var_95_32 * (var_95_37 / var_95_36)

				if var_95_38 > 0 and var_95_32 < var_95_38 then
					arg_92_1.talkMaxDuration = var_95_38

					if var_95_38 + var_95_31 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_38 + var_95_31
					end
				end

				arg_92_1.text_.text = var_95_35
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021024", "story_v_out_104021.awb") ~= 0 then
					local var_95_39 = manager.audio:GetVoiceLength("story_v_out_104021", "104021024", "story_v_out_104021.awb") / 1000

					if var_95_39 + var_95_31 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_39 + var_95_31
					end

					if var_95_34.prefab_name ~= "" and arg_92_1.actors_[var_95_34.prefab_name] ~= nil then
						local var_95_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_34.prefab_name].transform, "story_v_out_104021", "104021024", "story_v_out_104021.awb")

						arg_92_1:RecordAudio("104021024", var_95_40)
						arg_92_1:RecordAudio("104021024", var_95_40)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_104021", "104021024", "story_v_out_104021.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_104021", "104021024", "story_v_out_104021.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_41 = math.max(var_95_32, arg_92_1.talkMaxDuration)

			if var_95_31 <= arg_92_1.time_ and arg_92_1.time_ < var_95_31 + var_95_41 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_31) / var_95_41

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_31 + var_95_41 and arg_92_1.time_ < var_95_31 + var_95_41 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2021_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play104021025 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 104021025
		arg_96_1.duration_ = 3.47

		local var_96_0 = {
			ja = 2.766,
			ko = 2.5,
			zh = 1.966,
			en = 3.466
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
			arg_96_1.auto_ = false
		end

		function arg_96_1.playNext_(arg_98_0)
			arg_96_1.onStoryFinished_()
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["2021_tpose"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect2021_tpose == nil then
				arg_96_1.var_.characterEffect2021_tpose = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect2021_tpose and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect2021_tpose.fillFlat = true
					arg_96_1.var_.characterEffect2021_tpose.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect2021_tpose then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect2021_tpose.fillFlat = true
				arg_96_1.var_.characterEffect2021_tpose.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.225

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[39].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jolin")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(104021025)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 9
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021025", "story_v_out_104021.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_104021", "104021025", "story_v_out_104021.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_out_104021", "104021025", "story_v_out_104021.awb")

						arg_96_1:RecordAudio("104021025", var_99_15)
						arg_96_1:RecordAudio("104021025", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_104021", "104021025", "story_v_out_104021.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_104021", "104021025", "story_v_out_104021.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08c"
	},
	voices = {
		"story_v_out_104021.awb"
	}
}
