return {
	Play112021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H02"

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
				local var_4_5 = arg_1_1.bgs_.H02

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
					if iter_4_0 ~= "H02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.H02
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueH02 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueH02 = var_4_18
				end

				arg_1_1.var_.alphaOldValueH02 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueH02, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueH02 then
					local var_4_22 = arg_1_1.var_.alphaMatValueH02.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueH02.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueH02 then
				local var_4_23 = arg_1_1.var_.alphaMatValueH02
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_26 = 2

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_27 = 0
			local var_4_28 = 1

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_29 = "play"
				local var_4_30 = "effect"

				arg_1_1:AudioAction(var_4_29, var_4_30, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_31 = 2
			local var_4_32 = 1

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "music"

				arg_1_1:AudioAction(var_4_33, var_4_34, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_35 = ""
				local var_4_36 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if var_4_36 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_36 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_36

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_36
						arg_1_1.bgmTxt2_.text = var_4_36
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_37 = 2
			local var_4_38 = 1.225

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_39 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_39:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(112021001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 49
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_38 or var_4_38 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_38 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_37 = var_4_37 + 0.3

					if var_4_44 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_37
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_37 + 0.3
			local var_4_46 = math.max(var_4_38, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112021002
		arg_8_1.duration_ = 5.03

		local var_8_0 = {
			ja = 5.033,
			ko = 2.1,
			zh = 3,
			en = 2.4
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play112021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.15

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[202].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(112021002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 6
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021002", "story_v_out_112021.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_112021", "112021002", "story_v_out_112021.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_112021", "112021002", "story_v_out_112021.awb")

						arg_8_1:RecordAudio("112021002", var_11_9)
						arg_8_1:RecordAudio("112021002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_112021", "112021002", "story_v_out_112021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_112021", "112021002", "story_v_out_112021.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play112021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112021003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play112021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.05

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(112021003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 2
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play112021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112021004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play112021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.475

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(112021004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 19
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play112021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112021005
		arg_20_1.duration_ = 5.93

		local var_20_0 = {
			ja = 5.933,
			ko = 3.3,
			zh = 3.933,
			en = 3.766
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play112021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.15

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[202].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(112021005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 6
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021005", "story_v_out_112021.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_112021", "112021005", "story_v_out_112021.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_112021", "112021005", "story_v_out_112021.awb")

						arg_20_1:RecordAudio("112021005", var_23_9)
						arg_20_1:RecordAudio("112021005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_112021", "112021005", "story_v_out_112021.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_112021", "112021005", "story_v_out_112021.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play112021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112021006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play112021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.375

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(112021006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 15
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play112021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112021007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play112021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.925

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(112021007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 37
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play112021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112021008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play112021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1.4

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(112021008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 56
				local var_35_5 = utf8.len(var_35_3)
				local var_35_6 = var_35_4 <= 0 and var_35_1 or var_35_1 * (var_35_5 / var_35_4)

				if var_35_6 > 0 and var_35_1 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_7 and arg_32_1.time_ < var_35_0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play112021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112021009
		arg_36_1.duration_ = 4.5

		local var_36_0 = {
			ja = 4.5,
			ko = 2.766,
			zh = 2.2,
			en = 3.766
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play112021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "1081ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_39_7 = arg_36_1.actors_["1081ui_story"]
			local var_39_8 = 0

			if var_39_8 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1081ui_story == nil then
				arg_36_1.var_.characterEffect1081ui_story = var_39_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_9 = 0.2

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_9 and not isNil(var_39_7) then
				local var_39_10 = (arg_36_1.time_ - var_39_8) / var_39_9

				if arg_36_1.var_.characterEffect1081ui_story and not isNil(var_39_7) then
					arg_36_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_8 + var_39_9 and arg_36_1.time_ < var_39_8 + var_39_9 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1081ui_story then
				arg_36_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_39_11 = arg_36_1.actors_["1081ui_story"].transform
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.var_.moveOldPos1081ui_story = var_39_11.localPosition
			end

			local var_39_13 = 0.001

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_13 then
				local var_39_14 = (arg_36_1.time_ - var_39_12) / var_39_13
				local var_39_15 = Vector3.New(0, -0.92, -5.8)

				var_39_11.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1081ui_story, var_39_15, var_39_14)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_11.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_11.localEulerAngles = var_39_17
			end

			if arg_36_1.time_ >= var_39_12 + var_39_13 and arg_36_1.time_ < var_39_12 + var_39_13 + arg_39_0 then
				var_39_11.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_39_18 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_18.x, var_39_18.y, var_39_18.z)

				local var_39_19 = var_39_11.localEulerAngles

				var_39_19.z = 0
				var_39_19.x = 0
				var_39_11.localEulerAngles = var_39_19
			end

			local var_39_20 = 0
			local var_39_21 = 0.275

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_22 = arg_36_1:FormatText(StoryNameCfg[202].name)

				arg_36_1.leftNameTxt_.text = var_39_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_23 = arg_36_1:GetWordFromCfg(112021009)
				local var_39_24 = arg_36_1:FormatText(var_39_23.content)

				arg_36_1.text_.text = var_39_24

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_25 = 11
				local var_39_26 = utf8.len(var_39_24)
				local var_39_27 = var_39_25 <= 0 and var_39_21 or var_39_21 * (var_39_26 / var_39_25)

				if var_39_27 > 0 and var_39_21 < var_39_27 then
					arg_36_1.talkMaxDuration = var_39_27

					if var_39_27 + var_39_20 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_27 + var_39_20
					end
				end

				arg_36_1.text_.text = var_39_24
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021009", "story_v_out_112021.awb") ~= 0 then
					local var_39_28 = manager.audio:GetVoiceLength("story_v_out_112021", "112021009", "story_v_out_112021.awb") / 1000

					if var_39_28 + var_39_20 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_28 + var_39_20
					end

					if var_39_23.prefab_name ~= "" and arg_36_1.actors_[var_39_23.prefab_name] ~= nil then
						local var_39_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_23.prefab_name].transform, "story_v_out_112021", "112021009", "story_v_out_112021.awb")

						arg_36_1:RecordAudio("112021009", var_39_29)
						arg_36_1:RecordAudio("112021009", var_39_29)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_112021", "112021009", "story_v_out_112021.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_112021", "112021009", "story_v_out_112021.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_30 = math.max(var_39_21, arg_36_1.talkMaxDuration)

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_30 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_20) / var_39_30

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_20 + var_39_30 and arg_36_1.time_ < var_39_20 + var_39_30 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play112021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112021010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play112021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1081ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1081ui_story == nil then
				arg_40_1.var_.characterEffect1081ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1081ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1081ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1081ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1081ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.05

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(112021010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 2
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play112021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 112021011
		arg_44_1.duration_ = 13.57

		local var_44_0 = {
			ja = 13.566,
			ko = 9.3,
			zh = 8.5,
			en = 9.9
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
				arg_44_0:Play112021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_47_2 = arg_44_1.actors_["1081ui_story"]
			local var_47_3 = 0

			if var_47_3 < arg_44_1.time_ and arg_44_1.time_ <= var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1081ui_story == nil then
				arg_44_1.var_.characterEffect1081ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.2

			if var_47_3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_3 + var_47_4 and not isNil(var_47_2) then
				local var_47_5 = (arg_44_1.time_ - var_47_3) / var_47_4

				if arg_44_1.var_.characterEffect1081ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_3 + var_47_4 and arg_44_1.time_ < var_47_3 + var_47_4 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1081ui_story then
				arg_44_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_47_6 = 0
			local var_47_7 = 0.975

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[202].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_9 = arg_44_1:GetWordFromCfg(112021011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 39
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021011", "story_v_out_112021.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_112021", "112021011", "story_v_out_112021.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_112021", "112021011", "story_v_out_112021.awb")

						arg_44_1:RecordAudio("112021011", var_47_15)
						arg_44_1:RecordAudio("112021011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_112021", "112021011", "story_v_out_112021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_112021", "112021011", "story_v_out_112021.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play112021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 112021012
		arg_48_1.duration_ = 10.5

		local var_48_0 = {
			ja = 10.5,
			ko = 9.866,
			zh = 7.9,
			en = 6.833
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
				arg_48_0:Play112021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_51_1 = 0
			local var_51_2 = 1.025

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_3 = arg_48_1:FormatText(StoryNameCfg[202].name)

				arg_48_1.leftNameTxt_.text = var_51_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(112021012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 41
				local var_51_7 = utf8.len(var_51_5)
				local var_51_8 = var_51_6 <= 0 and var_51_2 or var_51_2 * (var_51_7 / var_51_6)

				if var_51_8 > 0 and var_51_2 < var_51_8 then
					arg_48_1.talkMaxDuration = var_51_8

					if var_51_8 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021012", "story_v_out_112021.awb") ~= 0 then
					local var_51_9 = manager.audio:GetVoiceLength("story_v_out_112021", "112021012", "story_v_out_112021.awb") / 1000

					if var_51_9 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_1
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_112021", "112021012", "story_v_out_112021.awb")

						arg_48_1:RecordAudio("112021012", var_51_10)
						arg_48_1:RecordAudio("112021012", var_51_10)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_112021", "112021012", "story_v_out_112021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_112021", "112021012", "story_v_out_112021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_11 and arg_48_1.time_ < var_51_1 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play112021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 112021013
		arg_52_1.duration_ = 10.73

		local var_52_0 = {
			ja = 10.733,
			ko = 6.5,
			zh = 6.4,
			en = 5.733
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play112021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_55_1 = 0
			local var_55_2 = 0.775

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_3 = arg_52_1:FormatText(StoryNameCfg[202].name)

				arg_52_1.leftNameTxt_.text = var_55_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(112021013)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 31
				local var_55_7 = utf8.len(var_55_5)
				local var_55_8 = var_55_6 <= 0 and var_55_2 or var_55_2 * (var_55_7 / var_55_6)

				if var_55_8 > 0 and var_55_2 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021013", "story_v_out_112021.awb") ~= 0 then
					local var_55_9 = manager.audio:GetVoiceLength("story_v_out_112021", "112021013", "story_v_out_112021.awb") / 1000

					if var_55_9 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_1
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_112021", "112021013", "story_v_out_112021.awb")

						arg_52_1:RecordAudio("112021013", var_55_10)
						arg_52_1:RecordAudio("112021013", var_55_10)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_112021", "112021013", "story_v_out_112021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_112021", "112021013", "story_v_out_112021.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_11 and arg_52_1.time_ < var_55_1 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play112021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 112021014
		arg_56_1.duration_ = 13.07

		local var_56_0 = {
			ja = 10.166,
			ko = 10.3,
			zh = 9.2,
			en = 13.066
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
				arg_56_0:Play112021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_59_1 = 0
			local var_59_2 = 1.075

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_3 = arg_56_1:FormatText(StoryNameCfg[202].name)

				arg_56_1.leftNameTxt_.text = var_59_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(112021014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 43
				local var_59_7 = utf8.len(var_59_5)
				local var_59_8 = var_59_6 <= 0 and var_59_2 or var_59_2 * (var_59_7 / var_59_6)

				if var_59_8 > 0 and var_59_2 < var_59_8 then
					arg_56_1.talkMaxDuration = var_59_8

					if var_59_8 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021014", "story_v_out_112021.awb") ~= 0 then
					local var_59_9 = manager.audio:GetVoiceLength("story_v_out_112021", "112021014", "story_v_out_112021.awb") / 1000

					if var_59_9 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_1
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_112021", "112021014", "story_v_out_112021.awb")

						arg_56_1:RecordAudio("112021014", var_59_10)
						arg_56_1:RecordAudio("112021014", var_59_10)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_112021", "112021014", "story_v_out_112021.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_112021", "112021014", "story_v_out_112021.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_11 and arg_56_1.time_ < var_59_1 + var_59_11 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play112021015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 112021015
		arg_60_1.duration_ = 0.05

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"

			SetActive(arg_60_1.choicesGo_, true)

			for iter_61_0, iter_61_1 in ipairs(arg_60_1.choices_) do
				local var_61_0 = iter_61_0 <= 2

				SetActive(iter_61_1.go, var_61_0)
			end

			arg_60_1.choices_[1].txt.text = arg_60_1:FormatText(StoryChoiceCfg[160].name)
			arg_60_1.choices_[2].txt.text = arg_60_1:FormatText(StoryChoiceCfg[161].name)
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play112021016(arg_60_1)
			end

			if arg_62_0 == 2 then
				arg_60_0:Play112021018(arg_60_1)
			end

			arg_60_1:RecordChoiceLog(112021015, 160, 161)
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			return
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play112021016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 112021016
		arg_64_1.duration_ = 8.1

		local var_64_0 = {
			ja = 8.1,
			ko = 5.966,
			zh = 3.766,
			en = 7.566
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
				arg_64_0:Play112021017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_67_1 = 0
			local var_67_2 = 0.5

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_3 = arg_64_1:FormatText(StoryNameCfg[202].name)

				arg_64_1.leftNameTxt_.text = var_67_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(112021016)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 20
				local var_67_7 = utf8.len(var_67_5)
				local var_67_8 = var_67_6 <= 0 and var_67_2 or var_67_2 * (var_67_7 / var_67_6)

				if var_67_8 > 0 and var_67_2 < var_67_8 then
					arg_64_1.talkMaxDuration = var_67_8

					if var_67_8 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021016", "story_v_out_112021.awb") ~= 0 then
					local var_67_9 = manager.audio:GetVoiceLength("story_v_out_112021", "112021016", "story_v_out_112021.awb") / 1000

					if var_67_9 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_1
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_112021", "112021016", "story_v_out_112021.awb")

						arg_64_1:RecordAudio("112021016", var_67_10)
						arg_64_1:RecordAudio("112021016", var_67_10)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_112021", "112021016", "story_v_out_112021.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_112021", "112021016", "story_v_out_112021.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_11 and arg_64_1.time_ < var_67_1 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play112021017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 112021017
		arg_68_1.duration_ = 10.73

		local var_68_0 = {
			ja = 9.433,
			ko = 9.933,
			zh = 9.5,
			en = 10.733
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
				arg_68_0:Play112021020(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			local var_71_2 = 0
			local var_71_3 = 1.075

			if var_71_2 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_4 = arg_68_1:FormatText(StoryNameCfg[202].name)

				arg_68_1.leftNameTxt_.text = var_71_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_5 = arg_68_1:GetWordFromCfg(112021017)
				local var_71_6 = arg_68_1:FormatText(var_71_5.content)

				arg_68_1.text_.text = var_71_6

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021017", "story_v_out_112021.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_112021", "112021017", "story_v_out_112021.awb") / 1000

					if var_71_10 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_2
					end

					if var_71_5.prefab_name ~= "" and arg_68_1.actors_[var_71_5.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_5.prefab_name].transform, "story_v_out_112021", "112021017", "story_v_out_112021.awb")

						arg_68_1:RecordAudio("112021017", var_71_11)
						arg_68_1:RecordAudio("112021017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_112021", "112021017", "story_v_out_112021.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_112021", "112021017", "story_v_out_112021.awb")
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
	Play112021020 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 112021020
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play112021021(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1081ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1081ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1081ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = 0
			local var_75_10 = 1.575

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_11 = arg_72_1:GetWordFromCfg(112021020)
				local var_75_12 = arg_72_1:FormatText(var_75_11.content)

				arg_72_1.text_.text = var_75_12

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 63
				local var_75_14 = utf8.len(var_75_12)
				local var_75_15 = var_75_13 <= 0 and var_75_10 or var_75_10 * (var_75_14 / var_75_13)

				if var_75_15 > 0 and var_75_10 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15

					if var_75_15 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_9
					end
				end

				arg_72_1.text_.text = var_75_12
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_10, arg_72_1.talkMaxDuration)

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_9) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_9 + var_75_16 and arg_72_1.time_ < var_75_9 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play112021021 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 112021021
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play112021022(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.4

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(112021021)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 16
				local var_79_5 = utf8.len(var_79_3)
				local var_79_6 = var_79_4 <= 0 and var_79_1 or var_79_1 * (var_79_5 / var_79_4)

				if var_79_6 > 0 and var_79_1 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_7 and arg_76_1.time_ < var_79_0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play112021022 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112021022
		arg_80_1.duration_ = 5.43

		local var_80_0 = {
			ja = 5.433,
			ko = 2.5,
			zh = 3.9,
			en = 3.233
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112021023(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.15

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[202].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(112021022)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 6
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021022", "story_v_out_112021.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_112021", "112021022", "story_v_out_112021.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_112021", "112021022", "story_v_out_112021.awb")

						arg_80_1:RecordAudio("112021022", var_83_9)
						arg_80_1:RecordAudio("112021022", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_112021", "112021022", "story_v_out_112021.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_112021", "112021022", "story_v_out_112021.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play112021023 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 112021023
		arg_84_1.duration_ = 3.83

		local var_84_0 = {
			ja = 2.4,
			ko = 2.833,
			zh = 2.766,
			en = 3.833
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
				arg_84_0:Play112021024(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.3

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(112021023)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 12
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021023", "story_v_out_112021.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_112021", "112021023", "story_v_out_112021.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_112021", "112021023", "story_v_out_112021.awb")

						arg_84_1:RecordAudio("112021023", var_87_9)
						arg_84_1:RecordAudio("112021023", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_112021", "112021023", "story_v_out_112021.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_112021", "112021023", "story_v_out_112021.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play112021024 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 112021024
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play112021025(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.9

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(112021024)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 36
				local var_91_5 = utf8.len(var_91_3)
				local var_91_6 = var_91_4 <= 0 and var_91_1 or var_91_1 * (var_91_5 / var_91_4)

				if var_91_6 > 0 and var_91_1 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_7 and arg_88_1.time_ < var_91_0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play112021025 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 112021025
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play112021026(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1.25

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(112021025)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 50
				local var_95_5 = utf8.len(var_95_3)
				local var_95_6 = var_95_4 <= 0 and var_95_1 or var_95_1 * (var_95_5 / var_95_4)

				if var_95_6 > 0 and var_95_1 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_7 and arg_92_1.time_ < var_95_0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play112021026 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 112021026
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play112021027(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.775

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(112021026)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 31
				local var_99_5 = utf8.len(var_99_3)
				local var_99_6 = var_99_4 <= 0 and var_99_1 or var_99_1 * (var_99_5 / var_99_4)

				if var_99_6 > 0 and var_99_1 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_7 and arg_96_1.time_ < var_99_0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play112021027 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 112021027
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play112021028(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.1

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(112021027)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 4
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play112021028 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 112021028
		arg_104_1.duration_ = 6.4

		local var_104_0 = {
			ja = 6.4,
			ko = 4.233,
			zh = 3.533,
			en = 3.666
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play112021029(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1081ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1081ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0, -0.92, -5.8)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1081ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_107_11 = arg_104_1.actors_["1081ui_story"]
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect1081ui_story == nil then
				arg_104_1.var_.characterEffect1081ui_story = var_107_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_13 = 0.2

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_13 and not isNil(var_107_11) then
				local var_107_14 = (arg_104_1.time_ - var_107_12) / var_107_13

				if arg_104_1.var_.characterEffect1081ui_story and not isNil(var_107_11) then
					arg_104_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_12 + var_107_13 and arg_104_1.time_ < var_107_12 + var_107_13 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect1081ui_story then
				arg_104_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_107_15 = 0
			local var_107_16 = 0.4

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_17 = arg_104_1:FormatText(StoryNameCfg[202].name)

				arg_104_1.leftNameTxt_.text = var_107_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_18 = arg_104_1:GetWordFromCfg(112021028)
				local var_107_19 = arg_104_1:FormatText(var_107_18.content)

				arg_104_1.text_.text = var_107_19

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_20 = 16
				local var_107_21 = utf8.len(var_107_19)
				local var_107_22 = var_107_20 <= 0 and var_107_16 or var_107_16 * (var_107_21 / var_107_20)

				if var_107_22 > 0 and var_107_16 < var_107_22 then
					arg_104_1.talkMaxDuration = var_107_22

					if var_107_22 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_22 + var_107_15
					end
				end

				arg_104_1.text_.text = var_107_19
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021028", "story_v_out_112021.awb") ~= 0 then
					local var_107_23 = manager.audio:GetVoiceLength("story_v_out_112021", "112021028", "story_v_out_112021.awb") / 1000

					if var_107_23 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_15
					end

					if var_107_18.prefab_name ~= "" and arg_104_1.actors_[var_107_18.prefab_name] ~= nil then
						local var_107_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_18.prefab_name].transform, "story_v_out_112021", "112021028", "story_v_out_112021.awb")

						arg_104_1:RecordAudio("112021028", var_107_24)
						arg_104_1:RecordAudio("112021028", var_107_24)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_112021", "112021028", "story_v_out_112021.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_112021", "112021028", "story_v_out_112021.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_25 = math.max(var_107_16, arg_104_1.talkMaxDuration)

			if var_107_15 <= arg_104_1.time_ and arg_104_1.time_ < var_107_15 + var_107_25 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_15) / var_107_25

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_15 + var_107_25 and arg_104_1.time_ < var_107_15 + var_107_25 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play112021029 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 112021029
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play112021030(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1081ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1081ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, 100, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1081ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, 100, 0)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = 0
			local var_111_10 = 0.7

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_11 = arg_108_1:GetWordFromCfg(112021029)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 28
				local var_111_14 = utf8.len(var_111_12)
				local var_111_15 = var_111_13 <= 0 and var_111_10 or var_111_10 * (var_111_14 / var_111_13)

				if var_111_15 > 0 and var_111_10 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_9 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_9
					end
				end

				arg_108_1.text_.text = var_111_12
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_10, arg_108_1.talkMaxDuration)

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_9) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_9 + var_111_16 and arg_108_1.time_ < var_111_9 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play112021030 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 112021030
		arg_112_1.duration_ = 10.3

		local var_112_0 = {
			ja = 10.3,
			ko = 9.066,
			zh = 9.466,
			en = 9.333
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play112021031(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = "1039ui_story"

			if arg_112_1.actors_[var_115_0] == nil then
				local var_115_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_115_1) then
					local var_115_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_112_1.stage_.transform)

					var_115_2.name = var_115_0
					var_115_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_112_1.actors_[var_115_0] = var_115_2

					local var_115_3 = var_115_2:GetComponentInChildren(typeof(CharacterEffect))

					var_115_3.enabled = true

					local var_115_4 = GameObjectTools.GetOrAddComponent(var_115_2, typeof(DynamicBoneHelper))

					if var_115_4 then
						var_115_4:EnableDynamicBone(false)
					end

					arg_112_1:ShowWeapon(var_115_3.transform, false)

					arg_112_1.var_[var_115_0 .. "Animator"] = var_115_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_112_1.var_[var_115_0 .. "Animator"].applyRootMotion = true
					arg_112_1.var_[var_115_0 .. "LipSync"] = var_115_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_115_5 = arg_112_1.actors_["1039ui_story"].transform
			local var_115_6 = 0

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.var_.moveOldPos1039ui_story = var_115_5.localPosition
			end

			local var_115_7 = 0.001

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_7 then
				local var_115_8 = (arg_112_1.time_ - var_115_6) / var_115_7
				local var_115_9 = Vector3.New(-0.7, -1.01, -5.9)

				var_115_5.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1039ui_story, var_115_9, var_115_8)

				local var_115_10 = manager.ui.mainCamera.transform.position - var_115_5.position

				var_115_5.forward = Vector3.New(var_115_10.x, var_115_10.y, var_115_10.z)

				local var_115_11 = var_115_5.localEulerAngles

				var_115_11.z = 0
				var_115_11.x = 0
				var_115_5.localEulerAngles = var_115_11
			end

			if arg_112_1.time_ >= var_115_6 + var_115_7 and arg_112_1.time_ < var_115_6 + var_115_7 + arg_115_0 then
				var_115_5.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_115_12 = manager.ui.mainCamera.transform.position - var_115_5.position

				var_115_5.forward = Vector3.New(var_115_12.x, var_115_12.y, var_115_12.z)

				local var_115_13 = var_115_5.localEulerAngles

				var_115_13.z = 0
				var_115_13.x = 0
				var_115_5.localEulerAngles = var_115_13
			end

			local var_115_14 = 0

			if var_115_14 < arg_112_1.time_ and arg_112_1.time_ <= var_115_14 + arg_115_0 then
				arg_112_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_115_15 = 0

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_115_16 = arg_112_1.actors_["1039ui_story"]
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 and not isNil(var_115_16) and arg_112_1.var_.characterEffect1039ui_story == nil then
				arg_112_1.var_.characterEffect1039ui_story = var_115_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_18 = 0.2

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_18 and not isNil(var_115_16) then
				local var_115_19 = (arg_112_1.time_ - var_115_17) / var_115_18

				if arg_112_1.var_.characterEffect1039ui_story and not isNil(var_115_16) then
					arg_112_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_17 + var_115_18 and arg_112_1.time_ < var_115_17 + var_115_18 + arg_115_0 and not isNil(var_115_16) and arg_112_1.var_.characterEffect1039ui_story then
				arg_112_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_115_20 = 0
			local var_115_21 = 1.125

			if var_115_20 < arg_112_1.time_ and arg_112_1.time_ <= var_115_20 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_22 = arg_112_1:FormatText(StoryNameCfg[9].name)

				arg_112_1.leftNameTxt_.text = var_115_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_23 = arg_112_1:GetWordFromCfg(112021030)
				local var_115_24 = arg_112_1:FormatText(var_115_23.content)

				arg_112_1.text_.text = var_115_24

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_25 = 45
				local var_115_26 = utf8.len(var_115_24)
				local var_115_27 = var_115_25 <= 0 and var_115_21 or var_115_21 * (var_115_26 / var_115_25)

				if var_115_27 > 0 and var_115_21 < var_115_27 then
					arg_112_1.talkMaxDuration = var_115_27

					if var_115_27 + var_115_20 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_27 + var_115_20
					end
				end

				arg_112_1.text_.text = var_115_24
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021030", "story_v_out_112021.awb") ~= 0 then
					local var_115_28 = manager.audio:GetVoiceLength("story_v_out_112021", "112021030", "story_v_out_112021.awb") / 1000

					if var_115_28 + var_115_20 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_28 + var_115_20
					end

					if var_115_23.prefab_name ~= "" and arg_112_1.actors_[var_115_23.prefab_name] ~= nil then
						local var_115_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_23.prefab_name].transform, "story_v_out_112021", "112021030", "story_v_out_112021.awb")

						arg_112_1:RecordAudio("112021030", var_115_29)
						arg_112_1:RecordAudio("112021030", var_115_29)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_112021", "112021030", "story_v_out_112021.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_112021", "112021030", "story_v_out_112021.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_30 = math.max(var_115_21, arg_112_1.talkMaxDuration)

			if var_115_20 <= arg_112_1.time_ and arg_112_1.time_ < var_115_20 + var_115_30 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_20) / var_115_30

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_20 + var_115_30 and arg_112_1.time_ < var_115_20 + var_115_30 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play112021031 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 112021031
		arg_116_1.duration_ = 7.47

		local var_116_0 = {
			ja = 7.466,
			ko = 5.8,
			zh = 4.266,
			en = 5.4
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
			arg_116_1.auto_ = false
		end

		function arg_116_1.playNext_(arg_118_0)
			arg_116_1.onStoryFinished_()
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_119_2 = arg_116_1.actors_["1081ui_story"]
			local var_119_3 = 0

			if var_119_3 < arg_116_1.time_ and arg_116_1.time_ <= var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1081ui_story == nil then
				arg_116_1.var_.characterEffect1081ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.2

			if var_119_3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_3 + var_119_4 and not isNil(var_119_2) then
				local var_119_5 = (arg_116_1.time_ - var_119_3) / var_119_4

				if arg_116_1.var_.characterEffect1081ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_3 + var_119_4 and arg_116_1.time_ < var_119_3 + var_119_4 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1081ui_story then
				arg_116_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_119_6 = arg_116_1.actors_["1039ui_story"]
			local var_119_7 = 0

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1039ui_story == nil then
				arg_116_1.var_.characterEffect1039ui_story = var_119_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_8 = 0.2

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_8 and not isNil(var_119_6) then
				local var_119_9 = (arg_116_1.time_ - var_119_7) / var_119_8

				if arg_116_1.var_.characterEffect1039ui_story and not isNil(var_119_6) then
					local var_119_10 = Mathf.Lerp(0, 0.5, var_119_9)

					arg_116_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1039ui_story.fillRatio = var_119_10
				end
			end

			if arg_116_1.time_ >= var_119_7 + var_119_8 and arg_116_1.time_ < var_119_7 + var_119_8 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1039ui_story then
				local var_119_11 = 0.5

				arg_116_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1039ui_story.fillRatio = var_119_11
			end

			local var_119_12 = arg_116_1.actors_["1081ui_story"].transform
			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1.var_.moveOldPos1081ui_story = var_119_12.localPosition
			end

			local var_119_14 = 0.001

			if var_119_13 <= arg_116_1.time_ and arg_116_1.time_ < var_119_13 + var_119_14 then
				local var_119_15 = (arg_116_1.time_ - var_119_13) / var_119_14
				local var_119_16 = Vector3.New(0.7, -0.92, -5.8)

				var_119_12.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1081ui_story, var_119_16, var_119_15)

				local var_119_17 = manager.ui.mainCamera.transform.position - var_119_12.position

				var_119_12.forward = Vector3.New(var_119_17.x, var_119_17.y, var_119_17.z)

				local var_119_18 = var_119_12.localEulerAngles

				var_119_18.z = 0
				var_119_18.x = 0
				var_119_12.localEulerAngles = var_119_18
			end

			if arg_116_1.time_ >= var_119_13 + var_119_14 and arg_116_1.time_ < var_119_13 + var_119_14 + arg_119_0 then
				var_119_12.localPosition = Vector3.New(0.7, -0.92, -5.8)

				local var_119_19 = manager.ui.mainCamera.transform.position - var_119_12.position

				var_119_12.forward = Vector3.New(var_119_19.x, var_119_19.y, var_119_19.z)

				local var_119_20 = var_119_12.localEulerAngles

				var_119_20.z = 0
				var_119_20.x = 0
				var_119_12.localEulerAngles = var_119_20
			end

			local var_119_21 = 0
			local var_119_22 = 0.625

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_23 = arg_116_1:FormatText(StoryNameCfg[202].name)

				arg_116_1.leftNameTxt_.text = var_119_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_24 = arg_116_1:GetWordFromCfg(112021031)
				local var_119_25 = arg_116_1:FormatText(var_119_24.content)

				arg_116_1.text_.text = var_119_25

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_26 = 25
				local var_119_27 = utf8.len(var_119_25)
				local var_119_28 = var_119_26 <= 0 and var_119_22 or var_119_22 * (var_119_27 / var_119_26)

				if var_119_28 > 0 and var_119_22 < var_119_28 then
					arg_116_1.talkMaxDuration = var_119_28

					if var_119_28 + var_119_21 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_28 + var_119_21
					end
				end

				arg_116_1.text_.text = var_119_25
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021031", "story_v_out_112021.awb") ~= 0 then
					local var_119_29 = manager.audio:GetVoiceLength("story_v_out_112021", "112021031", "story_v_out_112021.awb") / 1000

					if var_119_29 + var_119_21 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_29 + var_119_21
					end

					if var_119_24.prefab_name ~= "" and arg_116_1.actors_[var_119_24.prefab_name] ~= nil then
						local var_119_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_24.prefab_name].transform, "story_v_out_112021", "112021031", "story_v_out_112021.awb")

						arg_116_1:RecordAudio("112021031", var_119_30)
						arg_116_1:RecordAudio("112021031", var_119_30)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_112021", "112021031", "story_v_out_112021.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_112021", "112021031", "story_v_out_112021.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_31 = math.max(var_119_22, arg_116_1.talkMaxDuration)

			if var_119_21 <= arg_116_1.time_ and arg_116_1.time_ < var_119_21 + var_119_31 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_21) / var_119_31

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_21 + var_119_31 and arg_116_1.time_ < var_119_21 + var_119_31 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play112021018 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 112021018
		arg_120_1.duration_ = 6.63

		local var_120_0 = {
			ja = 6.033,
			ko = 6.4,
			zh = 5.833,
			en = 6.633
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play112021019(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = "1081ui_story"

			if arg_120_1.actors_[var_123_0] == nil then
				local var_123_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_123_1) then
					local var_123_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_120_1.stage_.transform)

					var_123_2.name = var_123_0
					var_123_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_120_1.actors_[var_123_0] = var_123_2

					local var_123_3 = var_123_2:GetComponentInChildren(typeof(CharacterEffect))

					var_123_3.enabled = true

					local var_123_4 = GameObjectTools.GetOrAddComponent(var_123_2, typeof(DynamicBoneHelper))

					if var_123_4 then
						var_123_4:EnableDynamicBone(false)
					end

					arg_120_1:ShowWeapon(var_123_3.transform, false)

					arg_120_1.var_[var_123_0 .. "Animator"] = var_123_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_120_1.var_[var_123_0 .. "Animator"].applyRootMotion = true
					arg_120_1.var_[var_123_0 .. "LipSync"] = var_123_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_123_6 = 0
			local var_123_7 = 1

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[202].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_9 = arg_120_1:GetWordFromCfg(112021018)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 33
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021018", "story_v_out_112021.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_out_112021", "112021018", "story_v_out_112021.awb") / 1000

					if var_123_14 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_6
					end

					if var_123_9.prefab_name ~= "" and arg_120_1.actors_[var_123_9.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_9.prefab_name].transform, "story_v_out_112021", "112021018", "story_v_out_112021.awb")

						arg_120_1:RecordAudio("112021018", var_123_15)
						arg_120_1:RecordAudio("112021018", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_112021", "112021018", "story_v_out_112021.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_112021", "112021018", "story_v_out_112021.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_16 and arg_120_1.time_ < var_123_6 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play112021019 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 112021019
		arg_124_1.duration_ = 7.43

		local var_124_0 = {
			ja = 7.433,
			ko = 5.166,
			zh = 3.966,
			en = 5.1
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play112021020(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_127_1 = 0
			local var_127_2 = 1

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_3 = arg_124_1:FormatText(StoryNameCfg[202].name)

				arg_124_1.leftNameTxt_.text = var_127_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(112021019)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_6 = 21
				local var_127_7 = utf8.len(var_127_5)
				local var_127_8 = var_127_6 <= 0 and var_127_2 or var_127_2 * (var_127_7 / var_127_6)

				if var_127_8 > 0 and var_127_2 < var_127_8 then
					arg_124_1.talkMaxDuration = var_127_8

					if var_127_8 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112021", "112021019", "story_v_out_112021.awb") ~= 0 then
					local var_127_9 = manager.audio:GetVoiceLength("story_v_out_112021", "112021019", "story_v_out_112021.awb") / 1000

					if var_127_9 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_1
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_112021", "112021019", "story_v_out_112021.awb")

						arg_124_1:RecordAudio("112021019", var_127_10)
						arg_124_1:RecordAudio("112021019", var_127_10)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_112021", "112021019", "story_v_out_112021.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_112021", "112021019", "story_v_out_112021.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_11 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_11 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_11

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_11 and arg_124_1.time_ < var_127_1 + var_127_11 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02"
	},
	voices = {
		"story_v_out_112021.awb"
	}
}
