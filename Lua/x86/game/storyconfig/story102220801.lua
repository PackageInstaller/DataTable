return {
	Play222081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 222081001
		arg_1_1.duration_ = 13.9

		local var_1_0 = {
			ja = 13.899999999999,
			ko = 10.532999999999,
			zh = 10.565999999999
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play222081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "YZ0103"

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
				local var_4_5 = arg_1_1.bgs_.YZ0103

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
					if iter_4_0 ~= "YZ0103" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 0.266666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_0_battle_jingdu", "bgm_activity_2_0_battle_jingdu", "bgm_activity_2_0_battle_jingdu.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_0_battle_jingdu", "bgm_activity_2_0_battle_jingdu")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_222_00", "se_story_222_00_quarry", "")
			end

			local var_4_38 = arg_1_1.bgs_.YZ0103.transform
			local var_4_39 = 0.0333333333333333

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.var_.moveOldPosYZ0103 = var_4_38.localPosition
			end

			local var_4_40 = 0.001

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40
				local var_4_42 = Vector3.New(0, 1, 9.5)

				var_4_38.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosYZ0103, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				var_4_38.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_43 = arg_1_1.bgs_.YZ0103.transform
			local var_4_44 = 0.05

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.var_.moveOldPosYZ0103 = var_4_43.localPosition
			end

			local var_4_45 = 4.5

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				local var_4_46 = (arg_1_1.time_ - var_4_44) / var_4_45
				local var_4_47 = Vector3.New(0, 1, 10)

				var_4_43.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosYZ0103, var_4_47, var_4_46)
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				var_4_43.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_48 = 1.999999999999

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_49 = 2.550000000001

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_50 = 1.999999999999
			local var_4_51 = 0.825

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_52 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_52:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_53 = arg_1_1:FormatText(StoryNameCfg[464].name)

				arg_1_1.leftNameTxt_.text = var_4_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_54 = arg_1_1:GetWordFromCfg(222081001)
				local var_4_55 = arg_1_1:FormatText(var_4_54.content)

				arg_1_1.text_.text = var_4_55

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_56 = 33
				local var_4_57 = utf8.len(var_4_55)
				local var_4_58 = var_4_56 <= 0 and var_4_51 or var_4_51 * (var_4_57 / var_4_56)

				if var_4_58 > 0 and var_4_51 < var_4_58 then
					arg_1_1.talkMaxDuration = var_4_58
					var_4_50 = var_4_50 + 0.3

					if var_4_58 + var_4_50 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_50
					end
				end

				arg_1_1.text_.text = var_4_55
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081001", "story_v_out_222081.awb") ~= 0 then
					local var_4_59 = manager.audio:GetVoiceLength("story_v_out_222081", "222081001", "story_v_out_222081.awb") / 1000

					if var_4_59 + var_4_50 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_59 + var_4_50
					end

					if var_4_54.prefab_name ~= "" and arg_1_1.actors_[var_4_54.prefab_name] ~= nil then
						local var_4_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_54.prefab_name].transform, "story_v_out_222081", "222081001", "story_v_out_222081.awb")

						arg_1_1:RecordAudio("222081001", var_4_60)
						arg_1_1:RecordAudio("222081001", var_4_60)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_222081", "222081001", "story_v_out_222081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_222081", "222081001", "story_v_out_222081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_61 = var_4_50 + 0.3
			local var_4_62 = math.max(var_4_51, arg_1_1.talkMaxDuration)

			if var_4_61 <= arg_1_1.time_ and arg_1_1.time_ < var_4_61 + var_4_62 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_61) / var_4_62

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_61 + var_4_62 and arg_1_1.time_ < var_4_61 + var_4_62 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "YZ0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YZ0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.05,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play222081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 222081002
		arg_9_1.duration_ = 14.6

		local var_9_0 = {
			ja = 14.6,
			ko = 11,
			zh = 11
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play222081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.025

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[464].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(222081002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 39
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081002", "story_v_out_222081.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081002", "story_v_out_222081.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_222081", "222081002", "story_v_out_222081.awb")

						arg_9_1:RecordAudio("222081002", var_12_9)
						arg_9_1:RecordAudio("222081002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_222081", "222081002", "story_v_out_222081.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_222081", "222081002", "story_v_out_222081.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play222081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 222081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play222081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.925

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(222081003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 37
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play222081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 222081004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play222081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.625

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(222081004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 25
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play222081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 222081005
		arg_21_1.duration_ = 11.9

		local var_21_0 = {
			ja = 11.9,
			ko = 7.3,
			zh = 7.3
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
				arg_21_0:Play222081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.025

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[410].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(222081005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 41
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081005", "story_v_out_222081.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081005", "story_v_out_222081.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_222081", "222081005", "story_v_out_222081.awb")

						arg_21_1:RecordAudio("222081005", var_24_9)
						arg_21_1:RecordAudio("222081005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_222081", "222081005", "story_v_out_222081.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_222081", "222081005", "story_v_out_222081.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play222081006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 222081006
		arg_25_1.duration_ = 13.57

		local var_25_0 = {
			ja = 13.566,
			ko = 10.4,
			zh = 10.433
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play222081007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 1

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[464].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(222081006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 39
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081006", "story_v_out_222081.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081006", "story_v_out_222081.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_222081", "222081006", "story_v_out_222081.awb")

						arg_25_1:RecordAudio("222081006", var_28_9)
						arg_25_1:RecordAudio("222081006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_222081", "222081006", "story_v_out_222081.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_222081", "222081006", "story_v_out_222081.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play222081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 222081007
		arg_29_1.duration_ = 15.2

		local var_29_0 = {
			ja = 15.2,
			ko = 12.433,
			zh = 12.433
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
				arg_29_0:Play222081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.325

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[464].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(222081007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 53
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081007", "story_v_out_222081.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081007", "story_v_out_222081.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_222081", "222081007", "story_v_out_222081.awb")

						arg_29_1:RecordAudio("222081007", var_32_9)
						arg_29_1:RecordAudio("222081007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_222081", "222081007", "story_v_out_222081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_222081", "222081007", "story_v_out_222081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play222081008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 222081008
		arg_33_1.duration_ = 13.9

		local var_33_0 = {
			ja = 11.4,
			ko = 13.9,
			zh = 13.9
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
				arg_33_0:Play222081009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.35

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[464].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(222081008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 55
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081008", "story_v_out_222081.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081008", "story_v_out_222081.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_222081", "222081008", "story_v_out_222081.awb")

						arg_33_1:RecordAudio("222081008", var_36_9)
						arg_33_1:RecordAudio("222081008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_222081", "222081008", "story_v_out_222081.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_222081", "222081008", "story_v_out_222081.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play222081009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 222081009
		arg_37_1.duration_ = 10.03

		local var_37_0 = {
			ja = 10.033,
			ko = 6.633,
			zh = 6.633
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
				arg_37_0:Play222081010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.725

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[410].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(222081009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 29
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081009", "story_v_out_222081.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081009", "story_v_out_222081.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_222081", "222081009", "story_v_out_222081.awb")

						arg_37_1:RecordAudio("222081009", var_40_9)
						arg_37_1:RecordAudio("222081009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_222081", "222081009", "story_v_out_222081.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_222081", "222081009", "story_v_out_222081.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play222081010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 222081010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play222081011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.725

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(222081010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 69
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play222081011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 222081011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play222081012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.35

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(222081011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 54
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play222081012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 222081012
		arg_49_1.duration_ = 2.67

		local var_49_0 = {
			ja = 2.666,
			ko = 1.5,
			zh = 1.533
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play222081013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.25

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[410].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(222081012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 10
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081012", "story_v_out_222081.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081012", "story_v_out_222081.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_222081", "222081012", "story_v_out_222081.awb")

						arg_49_1:RecordAudio("222081012", var_52_9)
						arg_49_1:RecordAudio("222081012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_222081", "222081012", "story_v_out_222081.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_222081", "222081012", "story_v_out_222081.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play222081013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 222081013
		arg_53_1.duration_ = 12.73

		local var_53_0 = {
			ja = 12.733,
			ko = 8.5,
			zh = 8.5
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play222081014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.95

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[463].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(222081013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081013", "story_v_out_222081.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081013", "story_v_out_222081.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_222081", "222081013", "story_v_out_222081.awb")

						arg_53_1:RecordAudio("222081013", var_56_9)
						arg_53_1:RecordAudio("222081013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_222081", "222081013", "story_v_out_222081.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_222081", "222081013", "story_v_out_222081.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play222081014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 222081014
		arg_57_1.duration_ = 8.53

		local var_57_0 = {
			ja = 5.366,
			ko = 8.5,
			zh = 8.533
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play222081015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.775

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[464].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(222081014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081014", "story_v_out_222081.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081014", "story_v_out_222081.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_222081", "222081014", "story_v_out_222081.awb")

						arg_57_1:RecordAudio("222081014", var_60_9)
						arg_57_1:RecordAudio("222081014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_222081", "222081014", "story_v_out_222081.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_222081", "222081014", "story_v_out_222081.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play222081015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 222081015
		arg_61_1.duration_ = 7.3

		local var_61_0 = {
			ja = 6.733,
			ko = 7.3,
			zh = 7.3
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
				arg_61_0:Play222081016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.75

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[464].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(222081015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 30
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081015", "story_v_out_222081.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081015", "story_v_out_222081.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_222081", "222081015", "story_v_out_222081.awb")

						arg_61_1:RecordAudio("222081015", var_64_9)
						arg_61_1:RecordAudio("222081015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_222081", "222081015", "story_v_out_222081.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_222081", "222081015", "story_v_out_222081.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play222081016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 222081016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play222081017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.85

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(222081016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 34
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play222081017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 222081017
		arg_69_1.duration_ = 10.7

		local var_69_0 = {
			ja = 10,
			ko = 10.7,
			zh = 10.7
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play222081018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "J03g"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 2

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.J03g

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "J03g" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_17 = 2

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17
				local var_72_19 = Color.New(0, 0, 0)

				var_72_19.a = Mathf.Lerp(0, 1, var_72_18)
				arg_69_1.mask_.color = var_72_19
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				local var_72_20 = Color.New(0, 0, 0)

				var_72_20.a = 1
				arg_69_1.mask_.color = var_72_20
			end

			local var_72_21 = 2

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_22 = 2

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_22 then
				local var_72_23 = (arg_69_1.time_ - var_72_21) / var_72_22
				local var_72_24 = Color.New(0, 0, 0)

				var_72_24.a = Mathf.Lerp(1, 0, var_72_23)
				arg_69_1.mask_.color = var_72_24
			end

			if arg_69_1.time_ >= var_72_21 + var_72_22 and arg_69_1.time_ < var_72_21 + var_72_22 + arg_72_0 then
				local var_72_25 = Color.New(0, 0, 0)
				local var_72_26 = 0

				arg_69_1.mask_.enabled = false
				var_72_25.a = var_72_26
				arg_69_1.mask_.color = var_72_25
			end

			local var_72_27 = "10057ui_story"

			if arg_69_1.actors_[var_72_27] == nil then
				local var_72_28 = Asset.Load("Char/" .. "10057ui_story")

				if not isNil(var_72_28) then
					local var_72_29 = Object.Instantiate(Asset.Load("Char/" .. "10057ui_story"), arg_69_1.stage_.transform)

					var_72_29.name = var_72_27
					var_72_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_69_1.actors_[var_72_27] = var_72_29

					local var_72_30 = var_72_29:GetComponentInChildren(typeof(CharacterEffect))

					var_72_30.enabled = true

					local var_72_31 = GameObjectTools.GetOrAddComponent(var_72_29, typeof(DynamicBoneHelper))

					if var_72_31 then
						var_72_31:EnableDynamicBone(false)
					end

					arg_69_1:ShowWeapon(var_72_30.transform, false)

					arg_69_1.var_[var_72_27 .. "Animator"] = var_72_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_69_1.var_[var_72_27 .. "Animator"].applyRootMotion = true
					arg_69_1.var_[var_72_27 .. "LipSync"] = var_72_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_72_32 = arg_69_1.actors_["10057ui_story"].transform
			local var_72_33 = 3.96666666666667

			if var_72_33 < arg_69_1.time_ and arg_69_1.time_ <= var_72_33 + arg_72_0 then
				arg_69_1.var_.moveOldPos10057ui_story = var_72_32.localPosition
			end

			local var_72_34 = 0.001

			if var_72_33 <= arg_69_1.time_ and arg_69_1.time_ < var_72_33 + var_72_34 then
				local var_72_35 = (arg_69_1.time_ - var_72_33) / var_72_34
				local var_72_36 = Vector3.New(0, -1.13, -5.72)

				var_72_32.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10057ui_story, var_72_36, var_72_35)

				local var_72_37 = manager.ui.mainCamera.transform.position - var_72_32.position

				var_72_32.forward = Vector3.New(var_72_37.x, var_72_37.y, var_72_37.z)

				local var_72_38 = var_72_32.localEulerAngles

				var_72_38.z = 0
				var_72_38.x = 0
				var_72_32.localEulerAngles = var_72_38
			end

			if arg_69_1.time_ >= var_72_33 + var_72_34 and arg_69_1.time_ < var_72_33 + var_72_34 + arg_72_0 then
				var_72_32.localPosition = Vector3.New(0, -1.13, -5.72)

				local var_72_39 = manager.ui.mainCamera.transform.position - var_72_32.position

				var_72_32.forward = Vector3.New(var_72_39.x, var_72_39.y, var_72_39.z)

				local var_72_40 = var_72_32.localEulerAngles

				var_72_40.z = 0
				var_72_40.x = 0
				var_72_32.localEulerAngles = var_72_40
			end

			local var_72_41 = 3.96666666666667

			if var_72_41 < arg_69_1.time_ and arg_69_1.time_ <= var_72_41 + arg_72_0 then
				arg_69_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_72_42 = 3.96666666666667

			if var_72_42 < arg_69_1.time_ and arg_69_1.time_ <= var_72_42 + arg_72_0 then
				arg_69_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_72_43 = arg_69_1.actors_["10057ui_story"]
			local var_72_44 = 3.96666666666667

			if var_72_44 < arg_69_1.time_ and arg_69_1.time_ <= var_72_44 + arg_72_0 and not isNil(var_72_43) and arg_69_1.var_.characterEffect10057ui_story == nil then
				arg_69_1.var_.characterEffect10057ui_story = var_72_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_45 = 0.2

			if var_72_44 <= arg_69_1.time_ and arg_69_1.time_ < var_72_44 + var_72_45 and not isNil(var_72_43) then
				local var_72_46 = (arg_69_1.time_ - var_72_44) / var_72_45

				if arg_69_1.var_.characterEffect10057ui_story and not isNil(var_72_43) then
					arg_69_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_44 + var_72_45 and arg_69_1.time_ < var_72_44 + var_72_45 + arg_72_0 and not isNil(var_72_43) and arg_69_1.var_.characterEffect10057ui_story then
				arg_69_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_47 = 4
			local var_72_48 = 0.6

			if var_72_47 < arg_69_1.time_ and arg_69_1.time_ <= var_72_47 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_49 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_49:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_50 = arg_69_1:FormatText(StoryNameCfg[464].name)

				arg_69_1.leftNameTxt_.text = var_72_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_51 = arg_69_1:GetWordFromCfg(222081017)
				local var_72_52 = arg_69_1:FormatText(var_72_51.content)

				arg_69_1.text_.text = var_72_52

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_53 = 24
				local var_72_54 = utf8.len(var_72_52)
				local var_72_55 = var_72_53 <= 0 and var_72_48 or var_72_48 * (var_72_54 / var_72_53)

				if var_72_55 > 0 and var_72_48 < var_72_55 then
					arg_69_1.talkMaxDuration = var_72_55
					var_72_47 = var_72_47 + 0.3

					if var_72_55 + var_72_47 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_55 + var_72_47
					end
				end

				arg_69_1.text_.text = var_72_52
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081017", "story_v_out_222081.awb") ~= 0 then
					local var_72_56 = manager.audio:GetVoiceLength("story_v_out_222081", "222081017", "story_v_out_222081.awb") / 1000

					if var_72_56 + var_72_47 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_56 + var_72_47
					end

					if var_72_51.prefab_name ~= "" and arg_69_1.actors_[var_72_51.prefab_name] ~= nil then
						local var_72_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_51.prefab_name].transform, "story_v_out_222081", "222081017", "story_v_out_222081.awb")

						arg_69_1:RecordAudio("222081017", var_72_57)
						arg_69_1:RecordAudio("222081017", var_72_57)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_222081", "222081017", "story_v_out_222081.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_222081", "222081017", "story_v_out_222081.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_58 = var_72_47 + 0.3
			local var_72_59 = math.max(var_72_48, arg_69_1.talkMaxDuration)

			if var_72_58 <= arg_69_1.time_ and arg_69_1.time_ < var_72_58 + var_72_59 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_58) / var_72_59

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_58 + var_72_59 and arg_69_1.time_ < var_72_58 + var_72_59 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play222081018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 222081018
		arg_75_1.duration_ = 11.2

		local var_75_0 = {
			ja = 11.2,
			ko = 6.8,
			zh = 6.8
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
				arg_75_0:Play222081019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action2_1")
			end

			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_2 = 0
			local var_78_3 = 0.675

			if var_78_2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_4 = arg_75_1:FormatText(StoryNameCfg[464].name)

				arg_75_1.leftNameTxt_.text = var_78_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:GetWordFromCfg(222081018)
				local var_78_6 = arg_75_1:FormatText(var_78_5.content)

				arg_75_1.text_.text = var_78_6

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 27
				local var_78_8 = utf8.len(var_78_6)
				local var_78_9 = var_78_7 <= 0 and var_78_3 or var_78_3 * (var_78_8 / var_78_7)

				if var_78_9 > 0 and var_78_3 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_6
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081018", "story_v_out_222081.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081018", "story_v_out_222081.awb") / 1000

					if var_78_10 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_2
					end

					if var_78_5.prefab_name ~= "" and arg_75_1.actors_[var_78_5.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_5.prefab_name].transform, "story_v_out_222081", "222081018", "story_v_out_222081.awb")

						arg_75_1:RecordAudio("222081018", var_78_11)
						arg_75_1:RecordAudio("222081018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_222081", "222081018", "story_v_out_222081.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_222081", "222081018", "story_v_out_222081.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_12 and arg_75_1.time_ < var_78_2 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play222081019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 222081019
		arg_79_1.duration_ = 9.83

		local var_79_0 = {
			ja = 8.733,
			ko = 9.833,
			zh = 9.833
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
				arg_79_0:Play222081020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.9

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[464].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(222081019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 36
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081019", "story_v_out_222081.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081019", "story_v_out_222081.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_222081", "222081019", "story_v_out_222081.awb")

						arg_79_1:RecordAudio("222081019", var_82_9)
						arg_79_1:RecordAudio("222081019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_222081", "222081019", "story_v_out_222081.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_222081", "222081019", "story_v_out_222081.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play222081020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 222081020
		arg_83_1.duration_ = 9.1

		local var_83_0 = {
			ja = 9.1,
			ko = 7.4,
			zh = 7.4
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
				arg_83_0:Play222081021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = "1070ui_story"

			if arg_83_1.actors_[var_86_0] == nil then
				local var_86_1 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_86_1) then
					local var_86_2 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_83_1.stage_.transform)

					var_86_2.name = var_86_0
					var_86_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_83_1.actors_[var_86_0] = var_86_2

					local var_86_3 = var_86_2:GetComponentInChildren(typeof(CharacterEffect))

					var_86_3.enabled = true

					local var_86_4 = GameObjectTools.GetOrAddComponent(var_86_2, typeof(DynamicBoneHelper))

					if var_86_4 then
						var_86_4:EnableDynamicBone(false)
					end

					arg_83_1:ShowWeapon(var_86_3.transform, false)

					arg_83_1.var_[var_86_0 .. "Animator"] = var_86_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_83_1.var_[var_86_0 .. "Animator"].applyRootMotion = true
					arg_83_1.var_[var_86_0 .. "LipSync"] = var_86_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_86_5 = arg_83_1.actors_["1070ui_story"].transform
			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.var_.moveOldPos1070ui_story = var_86_5.localPosition
			end

			local var_86_7 = 0.001

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_7 then
				local var_86_8 = (arg_83_1.time_ - var_86_6) / var_86_7
				local var_86_9 = Vector3.New(0.7, -0.95, -6.05)

				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1070ui_story, var_86_9, var_86_8)

				local var_86_10 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_10.x, var_86_10.y, var_86_10.z)

				local var_86_11 = var_86_5.localEulerAngles

				var_86_11.z = 0
				var_86_11.x = 0
				var_86_5.localEulerAngles = var_86_11
			end

			if arg_83_1.time_ >= var_86_6 + var_86_7 and arg_83_1.time_ < var_86_6 + var_86_7 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_86_12 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_12.x, var_86_12.y, var_86_12.z)

				local var_86_13 = var_86_5.localEulerAngles

				var_86_13.z = 0
				var_86_13.x = 0
				var_86_5.localEulerAngles = var_86_13
			end

			local var_86_14 = arg_83_1.actors_["1070ui_story"]
			local var_86_15 = 0

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 and not isNil(var_86_14) and arg_83_1.var_.characterEffect1070ui_story == nil then
				arg_83_1.var_.characterEffect1070ui_story = var_86_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_16 = 0.200000002980232

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_16 and not isNil(var_86_14) then
				local var_86_17 = (arg_83_1.time_ - var_86_15) / var_86_16

				if arg_83_1.var_.characterEffect1070ui_story and not isNil(var_86_14) then
					arg_83_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_15 + var_86_16 and arg_83_1.time_ < var_86_15 + var_86_16 + arg_86_0 and not isNil(var_86_14) and arg_83_1.var_.characterEffect1070ui_story then
				arg_83_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_86_18 = 0

			if var_86_18 < arg_83_1.time_ and arg_83_1.time_ <= var_86_18 + arg_86_0 then
				arg_83_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_86_19 = 0

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				arg_83_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_86_20 = arg_83_1.actors_["10057ui_story"].transform
			local var_86_21 = 0

			if var_86_21 < arg_83_1.time_ and arg_83_1.time_ <= var_86_21 + arg_86_0 then
				arg_83_1.var_.moveOldPos10057ui_story = var_86_20.localPosition
			end

			local var_86_22 = 0.001

			if var_86_21 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_22 then
				local var_86_23 = (arg_83_1.time_ - var_86_21) / var_86_22
				local var_86_24 = Vector3.New(-0.7, -1.13, -5.72)

				var_86_20.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10057ui_story, var_86_24, var_86_23)

				local var_86_25 = manager.ui.mainCamera.transform.position - var_86_20.position

				var_86_20.forward = Vector3.New(var_86_25.x, var_86_25.y, var_86_25.z)

				local var_86_26 = var_86_20.localEulerAngles

				var_86_26.z = 0
				var_86_26.x = 0
				var_86_20.localEulerAngles = var_86_26
			end

			if arg_83_1.time_ >= var_86_21 + var_86_22 and arg_83_1.time_ < var_86_21 + var_86_22 + arg_86_0 then
				var_86_20.localPosition = Vector3.New(-0.7, -1.13, -5.72)

				local var_86_27 = manager.ui.mainCamera.transform.position - var_86_20.position

				var_86_20.forward = Vector3.New(var_86_27.x, var_86_27.y, var_86_27.z)

				local var_86_28 = var_86_20.localEulerAngles

				var_86_28.z = 0
				var_86_28.x = 0
				var_86_20.localEulerAngles = var_86_28
			end

			local var_86_29 = arg_83_1.actors_["10057ui_story"]
			local var_86_30 = 0

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 and not isNil(var_86_29) and arg_83_1.var_.characterEffect10057ui_story == nil then
				arg_83_1.var_.characterEffect10057ui_story = var_86_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_31 = 0.200000002980232

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_31 and not isNil(var_86_29) then
				local var_86_32 = (arg_83_1.time_ - var_86_30) / var_86_31

				if arg_83_1.var_.characterEffect10057ui_story and not isNil(var_86_29) then
					local var_86_33 = Mathf.Lerp(0, 0.5, var_86_32)

					arg_83_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10057ui_story.fillRatio = var_86_33
				end
			end

			if arg_83_1.time_ >= var_86_30 + var_86_31 and arg_83_1.time_ < var_86_30 + var_86_31 + arg_86_0 and not isNil(var_86_29) and arg_83_1.var_.characterEffect10057ui_story then
				local var_86_34 = 0.5

				arg_83_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10057ui_story.fillRatio = var_86_34
			end

			local var_86_35 = 0
			local var_86_36 = 0.95

			if var_86_35 < arg_83_1.time_ and arg_83_1.time_ <= var_86_35 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_37 = arg_83_1:FormatText(StoryNameCfg[318].name)

				arg_83_1.leftNameTxt_.text = var_86_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_38 = arg_83_1:GetWordFromCfg(222081020)
				local var_86_39 = arg_83_1:FormatText(var_86_38.content)

				arg_83_1.text_.text = var_86_39

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_40 = 38
				local var_86_41 = utf8.len(var_86_39)
				local var_86_42 = var_86_40 <= 0 and var_86_36 or var_86_36 * (var_86_41 / var_86_40)

				if var_86_42 > 0 and var_86_36 < var_86_42 then
					arg_83_1.talkMaxDuration = var_86_42

					if var_86_42 + var_86_35 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_42 + var_86_35
					end
				end

				arg_83_1.text_.text = var_86_39
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081020", "story_v_out_222081.awb") ~= 0 then
					local var_86_43 = manager.audio:GetVoiceLength("story_v_out_222081", "222081020", "story_v_out_222081.awb") / 1000

					if var_86_43 + var_86_35 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_43 + var_86_35
					end

					if var_86_38.prefab_name ~= "" and arg_83_1.actors_[var_86_38.prefab_name] ~= nil then
						local var_86_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_38.prefab_name].transform, "story_v_out_222081", "222081020", "story_v_out_222081.awb")

						arg_83_1:RecordAudio("222081020", var_86_44)
						arg_83_1:RecordAudio("222081020", var_86_44)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_222081", "222081020", "story_v_out_222081.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_222081", "222081020", "story_v_out_222081.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_45 = math.max(var_86_36, arg_83_1.talkMaxDuration)

			if var_86_35 <= arg_83_1.time_ and arg_83_1.time_ < var_86_35 + var_86_45 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_35) / var_86_45

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_35 + var_86_45 and arg_83_1.time_ < var_86_35 + var_86_45 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play222081021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 222081021
		arg_87_1.duration_ = 12.57

		local var_87_0 = {
			ja = 12.566,
			ko = 7.066,
			zh = 7.1
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
				arg_87_0:Play222081022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10057ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10057ui_story == nil then
				arg_87_1.var_.characterEffect10057ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect10057ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10057ui_story then
				arg_87_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_90_4 = 0

			if var_90_4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action2_2")
			end

			local var_90_5 = 0

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_6 = arg_87_1.actors_["1070ui_story"]
			local var_90_7 = 0

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1070ui_story == nil then
				arg_87_1.var_.characterEffect1070ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_8 = 0.200000002980232

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_8 and not isNil(var_90_6) then
				local var_90_9 = (arg_87_1.time_ - var_90_7) / var_90_8

				if arg_87_1.var_.characterEffect1070ui_story and not isNil(var_90_6) then
					local var_90_10 = Mathf.Lerp(0, 0.5, var_90_9)

					arg_87_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1070ui_story.fillRatio = var_90_10
				end
			end

			if arg_87_1.time_ >= var_90_7 + var_90_8 and arg_87_1.time_ < var_90_7 + var_90_8 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1070ui_story then
				local var_90_11 = 0.5

				arg_87_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1070ui_story.fillRatio = var_90_11
			end

			local var_90_12 = 0
			local var_90_13 = 0.525

			if var_90_12 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_14 = arg_87_1:FormatText(StoryNameCfg[464].name)

				arg_87_1.leftNameTxt_.text = var_90_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_15 = arg_87_1:GetWordFromCfg(222081021)
				local var_90_16 = arg_87_1:FormatText(var_90_15.content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_17 = 21
				local var_90_18 = utf8.len(var_90_16)
				local var_90_19 = var_90_17 <= 0 and var_90_13 or var_90_13 * (var_90_18 / var_90_17)

				if var_90_19 > 0 and var_90_13 < var_90_19 then
					arg_87_1.talkMaxDuration = var_90_19

					if var_90_19 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_12
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081021", "story_v_out_222081.awb") ~= 0 then
					local var_90_20 = manager.audio:GetVoiceLength("story_v_out_222081", "222081021", "story_v_out_222081.awb") / 1000

					if var_90_20 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_12
					end

					if var_90_15.prefab_name ~= "" and arg_87_1.actors_[var_90_15.prefab_name] ~= nil then
						local var_90_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_15.prefab_name].transform, "story_v_out_222081", "222081021", "story_v_out_222081.awb")

						arg_87_1:RecordAudio("222081021", var_90_21)
						arg_87_1:RecordAudio("222081021", var_90_21)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_222081", "222081021", "story_v_out_222081.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_222081", "222081021", "story_v_out_222081.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_22 = math.max(var_90_13, arg_87_1.talkMaxDuration)

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_22 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_12) / var_90_22

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_12 + var_90_22 and arg_87_1.time_ < var_90_12 + var_90_22 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play222081022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 222081022
		arg_91_1.duration_ = 3.7

		local var_91_0 = {
			ja = 3.7,
			ko = 2.9,
			zh = 2.866
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
				arg_91_0:Play222081023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1070ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1070ui_story == nil then
				arg_91_1.var_.characterEffect1070ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1070ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1070ui_story then
				arg_91_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_94_4 = 0

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_94_6 = arg_91_1.actors_["10057ui_story"]
			local var_94_7 = 0

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect10057ui_story == nil then
				arg_91_1.var_.characterEffect10057ui_story = var_94_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_8 = 0.200000002980232

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_8 and not isNil(var_94_6) then
				local var_94_9 = (arg_91_1.time_ - var_94_7) / var_94_8

				if arg_91_1.var_.characterEffect10057ui_story and not isNil(var_94_6) then
					local var_94_10 = Mathf.Lerp(0, 0.5, var_94_9)

					arg_91_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10057ui_story.fillRatio = var_94_10
				end
			end

			if arg_91_1.time_ >= var_94_7 + var_94_8 and arg_91_1.time_ < var_94_7 + var_94_8 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect10057ui_story then
				local var_94_11 = 0.5

				arg_91_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10057ui_story.fillRatio = var_94_11
			end

			local var_94_12 = 0
			local var_94_13 = 0.275

			if var_94_12 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_14 = arg_91_1:FormatText(StoryNameCfg[318].name)

				arg_91_1.leftNameTxt_.text = var_94_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_15 = arg_91_1:GetWordFromCfg(222081022)
				local var_94_16 = arg_91_1:FormatText(var_94_15.content)

				arg_91_1.text_.text = var_94_16

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_17 = 11
				local var_94_18 = utf8.len(var_94_16)
				local var_94_19 = var_94_17 <= 0 and var_94_13 or var_94_13 * (var_94_18 / var_94_17)

				if var_94_19 > 0 and var_94_13 < var_94_19 then
					arg_91_1.talkMaxDuration = var_94_19

					if var_94_19 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_12
					end
				end

				arg_91_1.text_.text = var_94_16
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081022", "story_v_out_222081.awb") ~= 0 then
					local var_94_20 = manager.audio:GetVoiceLength("story_v_out_222081", "222081022", "story_v_out_222081.awb") / 1000

					if var_94_20 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_20 + var_94_12
					end

					if var_94_15.prefab_name ~= "" and arg_91_1.actors_[var_94_15.prefab_name] ~= nil then
						local var_94_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_15.prefab_name].transform, "story_v_out_222081", "222081022", "story_v_out_222081.awb")

						arg_91_1:RecordAudio("222081022", var_94_21)
						arg_91_1:RecordAudio("222081022", var_94_21)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_222081", "222081022", "story_v_out_222081.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_222081", "222081022", "story_v_out_222081.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_13, arg_91_1.talkMaxDuration)

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_12) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_12 + var_94_22 and arg_91_1.time_ < var_94_12 + var_94_22 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play222081023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 222081023
		arg_95_1.duration_ = 16.6

		local var_95_0 = {
			ja = 16.6,
			ko = 11.8,
			zh = 11.8
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
				arg_95_0:Play222081024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10057ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10057ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, 100, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10057ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, 100, 0)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["10057ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect10057ui_story == nil then
				arg_95_1.var_.characterEffect10057ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect10057ui_story and not isNil(var_98_9) then
					local var_98_13 = Mathf.Lerp(0, 0.5, var_98_12)

					arg_95_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10057ui_story.fillRatio = var_98_13
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect10057ui_story then
				local var_98_14 = 0.5

				arg_95_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10057ui_story.fillRatio = var_98_14
			end

			local var_98_15 = "1074ui_story"

			if arg_95_1.actors_[var_98_15] == nil then
				local var_98_16 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_98_16) then
					local var_98_17 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_95_1.stage_.transform)

					var_98_17.name = var_98_15
					var_98_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_95_1.actors_[var_98_15] = var_98_17

					local var_98_18 = var_98_17:GetComponentInChildren(typeof(CharacterEffect))

					var_98_18.enabled = true

					local var_98_19 = GameObjectTools.GetOrAddComponent(var_98_17, typeof(DynamicBoneHelper))

					if var_98_19 then
						var_98_19:EnableDynamicBone(false)
					end

					arg_95_1:ShowWeapon(var_98_18.transform, false)

					arg_95_1.var_[var_98_15 .. "Animator"] = var_98_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_95_1.var_[var_98_15 .. "Animator"].applyRootMotion = true
					arg_95_1.var_[var_98_15 .. "LipSync"] = var_98_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_98_20 = arg_95_1.actors_["1074ui_story"].transform
			local var_98_21 = 0

			if var_98_21 < arg_95_1.time_ and arg_95_1.time_ <= var_98_21 + arg_98_0 then
				arg_95_1.var_.moveOldPos1074ui_story = var_98_20.localPosition
			end

			local var_98_22 = 0.001

			if var_98_21 <= arg_95_1.time_ and arg_95_1.time_ < var_98_21 + var_98_22 then
				local var_98_23 = (arg_95_1.time_ - var_98_21) / var_98_22
				local var_98_24 = Vector3.New(-0.7, -1.055, -6.12)

				var_98_20.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1074ui_story, var_98_24, var_98_23)

				local var_98_25 = manager.ui.mainCamera.transform.position - var_98_20.position

				var_98_20.forward = Vector3.New(var_98_25.x, var_98_25.y, var_98_25.z)

				local var_98_26 = var_98_20.localEulerAngles

				var_98_26.z = 0
				var_98_26.x = 0
				var_98_20.localEulerAngles = var_98_26
			end

			if arg_95_1.time_ >= var_98_21 + var_98_22 and arg_95_1.time_ < var_98_21 + var_98_22 + arg_98_0 then
				var_98_20.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_98_27 = manager.ui.mainCamera.transform.position - var_98_20.position

				var_98_20.forward = Vector3.New(var_98_27.x, var_98_27.y, var_98_27.z)

				local var_98_28 = var_98_20.localEulerAngles

				var_98_28.z = 0
				var_98_28.x = 0
				var_98_20.localEulerAngles = var_98_28
			end

			local var_98_29 = arg_95_1.actors_["1074ui_story"]
			local var_98_30 = 0

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 and not isNil(var_98_29) and arg_95_1.var_.characterEffect1074ui_story == nil then
				arg_95_1.var_.characterEffect1074ui_story = var_98_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_31 = 0.200000002980232

			if var_98_30 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_31 and not isNil(var_98_29) then
				local var_98_32 = (arg_95_1.time_ - var_98_30) / var_98_31

				if arg_95_1.var_.characterEffect1074ui_story and not isNil(var_98_29) then
					arg_95_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_30 + var_98_31 and arg_95_1.time_ < var_98_30 + var_98_31 + arg_98_0 and not isNil(var_98_29) and arg_95_1.var_.characterEffect1074ui_story then
				arg_95_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_98_33 = 0

			if var_98_33 < arg_95_1.time_ and arg_95_1.time_ <= var_98_33 + arg_98_0 then
				arg_95_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_98_34 = 0

			if var_98_34 < arg_95_1.time_ and arg_95_1.time_ <= var_98_34 + arg_98_0 then
				arg_95_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_35 = arg_95_1.actors_["1070ui_story"]
			local var_98_36 = 0

			if var_98_36 < arg_95_1.time_ and arg_95_1.time_ <= var_98_36 + arg_98_0 and not isNil(var_98_35) and arg_95_1.var_.characterEffect1070ui_story == nil then
				arg_95_1.var_.characterEffect1070ui_story = var_98_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_37 = 0.200000002980232

			if var_98_36 <= arg_95_1.time_ and arg_95_1.time_ < var_98_36 + var_98_37 and not isNil(var_98_35) then
				local var_98_38 = (arg_95_1.time_ - var_98_36) / var_98_37

				if arg_95_1.var_.characterEffect1070ui_story and not isNil(var_98_35) then
					local var_98_39 = Mathf.Lerp(0, 0.5, var_98_38)

					arg_95_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1070ui_story.fillRatio = var_98_39
				end
			end

			if arg_95_1.time_ >= var_98_36 + var_98_37 and arg_95_1.time_ < var_98_36 + var_98_37 + arg_98_0 and not isNil(var_98_35) and arg_95_1.var_.characterEffect1070ui_story then
				local var_98_40 = 0.5

				arg_95_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1070ui_story.fillRatio = var_98_40
			end

			local var_98_41 = 0
			local var_98_42 = 1.425

			if var_98_41 < arg_95_1.time_ and arg_95_1.time_ <= var_98_41 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_43 = arg_95_1:FormatText(StoryNameCfg[410].name)

				arg_95_1.leftNameTxt_.text = var_98_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_44 = arg_95_1:GetWordFromCfg(222081023)
				local var_98_45 = arg_95_1:FormatText(var_98_44.content)

				arg_95_1.text_.text = var_98_45

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_46 = 57
				local var_98_47 = utf8.len(var_98_45)
				local var_98_48 = var_98_46 <= 0 and var_98_42 or var_98_42 * (var_98_47 / var_98_46)

				if var_98_48 > 0 and var_98_42 < var_98_48 then
					arg_95_1.talkMaxDuration = var_98_48

					if var_98_48 + var_98_41 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_48 + var_98_41
					end
				end

				arg_95_1.text_.text = var_98_45
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081023", "story_v_out_222081.awb") ~= 0 then
					local var_98_49 = manager.audio:GetVoiceLength("story_v_out_222081", "222081023", "story_v_out_222081.awb") / 1000

					if var_98_49 + var_98_41 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_49 + var_98_41
					end

					if var_98_44.prefab_name ~= "" and arg_95_1.actors_[var_98_44.prefab_name] ~= nil then
						local var_98_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_44.prefab_name].transform, "story_v_out_222081", "222081023", "story_v_out_222081.awb")

						arg_95_1:RecordAudio("222081023", var_98_50)
						arg_95_1:RecordAudio("222081023", var_98_50)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_222081", "222081023", "story_v_out_222081.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_222081", "222081023", "story_v_out_222081.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_51 = math.max(var_98_42, arg_95_1.talkMaxDuration)

			if var_98_41 <= arg_95_1.time_ and arg_95_1.time_ < var_98_41 + var_98_51 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_41) / var_98_51

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_41 + var_98_51 and arg_95_1.time_ < var_98_41 + var_98_51 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play222081024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 222081024
		arg_99_1.duration_ = 10.8

		local var_99_0 = {
			ja = 10.8,
			ko = 6.366,
			zh = 6.466
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
				arg_99_0:Play222081025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1070ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1070ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1070ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, 100, 0)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["1070ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1070ui_story == nil then
				arg_99_1.var_.characterEffect1070ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect1070ui_story and not isNil(var_102_9) then
					local var_102_13 = Mathf.Lerp(0, 0.5, var_102_12)

					arg_99_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1070ui_story.fillRatio = var_102_13
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1070ui_story then
				local var_102_14 = 0.5

				arg_99_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1070ui_story.fillRatio = var_102_14
			end

			local var_102_15 = arg_99_1.actors_["10057ui_story"].transform
			local var_102_16 = 0

			if var_102_16 < arg_99_1.time_ and arg_99_1.time_ <= var_102_16 + arg_102_0 then
				arg_99_1.var_.moveOldPos10057ui_story = var_102_15.localPosition
			end

			local var_102_17 = 0.001

			if var_102_16 <= arg_99_1.time_ and arg_99_1.time_ < var_102_16 + var_102_17 then
				local var_102_18 = (arg_99_1.time_ - var_102_16) / var_102_17
				local var_102_19 = Vector3.New(0.7, -1.13, -5.72)

				var_102_15.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10057ui_story, var_102_19, var_102_18)

				local var_102_20 = manager.ui.mainCamera.transform.position - var_102_15.position

				var_102_15.forward = Vector3.New(var_102_20.x, var_102_20.y, var_102_20.z)

				local var_102_21 = var_102_15.localEulerAngles

				var_102_21.z = 0
				var_102_21.x = 0
				var_102_15.localEulerAngles = var_102_21
			end

			if arg_99_1.time_ >= var_102_16 + var_102_17 and arg_99_1.time_ < var_102_16 + var_102_17 + arg_102_0 then
				var_102_15.localPosition = Vector3.New(0.7, -1.13, -5.72)

				local var_102_22 = manager.ui.mainCamera.transform.position - var_102_15.position

				var_102_15.forward = Vector3.New(var_102_22.x, var_102_22.y, var_102_22.z)

				local var_102_23 = var_102_15.localEulerAngles

				var_102_23.z = 0
				var_102_23.x = 0
				var_102_15.localEulerAngles = var_102_23
			end

			local var_102_24 = arg_99_1.actors_["10057ui_story"]
			local var_102_25 = 0

			if var_102_25 < arg_99_1.time_ and arg_99_1.time_ <= var_102_25 + arg_102_0 and not isNil(var_102_24) and arg_99_1.var_.characterEffect10057ui_story == nil then
				arg_99_1.var_.characterEffect10057ui_story = var_102_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_26 = 0.200000002980232

			if var_102_25 <= arg_99_1.time_ and arg_99_1.time_ < var_102_25 + var_102_26 and not isNil(var_102_24) then
				local var_102_27 = (arg_99_1.time_ - var_102_25) / var_102_26

				if arg_99_1.var_.characterEffect10057ui_story and not isNil(var_102_24) then
					arg_99_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_25 + var_102_26 and arg_99_1.time_ < var_102_25 + var_102_26 + arg_102_0 and not isNil(var_102_24) and arg_99_1.var_.characterEffect10057ui_story then
				arg_99_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_102_28 = 0

			if var_102_28 < arg_99_1.time_ and arg_99_1.time_ <= var_102_28 + arg_102_0 then
				arg_99_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_102_29 = 0

			if var_102_29 < arg_99_1.time_ and arg_99_1.time_ <= var_102_29 + arg_102_0 then
				arg_99_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_30 = arg_99_1.actors_["1074ui_story"]
			local var_102_31 = 0

			if var_102_31 < arg_99_1.time_ and arg_99_1.time_ <= var_102_31 + arg_102_0 and not isNil(var_102_30) and arg_99_1.var_.characterEffect1074ui_story == nil then
				arg_99_1.var_.characterEffect1074ui_story = var_102_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_32 = 0.200000002980232

			if var_102_31 <= arg_99_1.time_ and arg_99_1.time_ < var_102_31 + var_102_32 and not isNil(var_102_30) then
				local var_102_33 = (arg_99_1.time_ - var_102_31) / var_102_32

				if arg_99_1.var_.characterEffect1074ui_story and not isNil(var_102_30) then
					local var_102_34 = Mathf.Lerp(0, 0.5, var_102_33)

					arg_99_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1074ui_story.fillRatio = var_102_34
				end
			end

			if arg_99_1.time_ >= var_102_31 + var_102_32 and arg_99_1.time_ < var_102_31 + var_102_32 + arg_102_0 and not isNil(var_102_30) and arg_99_1.var_.characterEffect1074ui_story then
				local var_102_35 = 0.5

				arg_99_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1074ui_story.fillRatio = var_102_35
			end

			local var_102_36 = 0
			local var_102_37 = 0.8

			if var_102_36 < arg_99_1.time_ and arg_99_1.time_ <= var_102_36 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_38 = arg_99_1:FormatText(StoryNameCfg[464].name)

				arg_99_1.leftNameTxt_.text = var_102_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_39 = arg_99_1:GetWordFromCfg(222081024)
				local var_102_40 = arg_99_1:FormatText(var_102_39.content)

				arg_99_1.text_.text = var_102_40

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_41 = 32
				local var_102_42 = utf8.len(var_102_40)
				local var_102_43 = var_102_41 <= 0 and var_102_37 or var_102_37 * (var_102_42 / var_102_41)

				if var_102_43 > 0 and var_102_37 < var_102_43 then
					arg_99_1.talkMaxDuration = var_102_43

					if var_102_43 + var_102_36 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_43 + var_102_36
					end
				end

				arg_99_1.text_.text = var_102_40
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081024", "story_v_out_222081.awb") ~= 0 then
					local var_102_44 = manager.audio:GetVoiceLength("story_v_out_222081", "222081024", "story_v_out_222081.awb") / 1000

					if var_102_44 + var_102_36 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_44 + var_102_36
					end

					if var_102_39.prefab_name ~= "" and arg_99_1.actors_[var_102_39.prefab_name] ~= nil then
						local var_102_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_39.prefab_name].transform, "story_v_out_222081", "222081024", "story_v_out_222081.awb")

						arg_99_1:RecordAudio("222081024", var_102_45)
						arg_99_1:RecordAudio("222081024", var_102_45)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_222081", "222081024", "story_v_out_222081.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_222081", "222081024", "story_v_out_222081.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_46 = math.max(var_102_37, arg_99_1.talkMaxDuration)

			if var_102_36 <= arg_99_1.time_ and arg_99_1.time_ < var_102_36 + var_102_46 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_36) / var_102_46

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_36 + var_102_46 and arg_99_1.time_ < var_102_36 + var_102_46 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play222081025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 222081025
		arg_103_1.duration_ = 8.1

		local var_103_0 = {
			ja = 8.1,
			ko = 5.766,
			zh = 5.766
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
				arg_103_0:Play222081026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1074ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1074ui_story == nil then
				arg_103_1.var_.characterEffect1074ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1074ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1074ui_story then
				arg_103_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_106_4 = 0

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_5 = arg_103_1.actors_["10057ui_story"]
			local var_106_6 = 0

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.characterEffect10057ui_story == nil then
				arg_103_1.var_.characterEffect10057ui_story = var_106_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_7 = 0.200000002980232

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_7 and not isNil(var_106_5) then
				local var_106_8 = (arg_103_1.time_ - var_106_6) / var_106_7

				if arg_103_1.var_.characterEffect10057ui_story and not isNil(var_106_5) then
					local var_106_9 = Mathf.Lerp(0, 0.5, var_106_8)

					arg_103_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10057ui_story.fillRatio = var_106_9
				end
			end

			if arg_103_1.time_ >= var_106_6 + var_106_7 and arg_103_1.time_ < var_106_6 + var_106_7 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.characterEffect10057ui_story then
				local var_106_10 = 0.5

				arg_103_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10057ui_story.fillRatio = var_106_10
			end

			local var_106_11 = 0
			local var_106_12 = 0.725

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_13 = arg_103_1:FormatText(StoryNameCfg[410].name)

				arg_103_1.leftNameTxt_.text = var_106_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_14 = arg_103_1:GetWordFromCfg(222081025)
				local var_106_15 = arg_103_1:FormatText(var_106_14.content)

				arg_103_1.text_.text = var_106_15

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 29
				local var_106_17 = utf8.len(var_106_15)
				local var_106_18 = var_106_16 <= 0 and var_106_12 or var_106_12 * (var_106_17 / var_106_16)

				if var_106_18 > 0 and var_106_12 < var_106_18 then
					arg_103_1.talkMaxDuration = var_106_18

					if var_106_18 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_18 + var_106_11
					end
				end

				arg_103_1.text_.text = var_106_15
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081025", "story_v_out_222081.awb") ~= 0 then
					local var_106_19 = manager.audio:GetVoiceLength("story_v_out_222081", "222081025", "story_v_out_222081.awb") / 1000

					if var_106_19 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_11
					end

					if var_106_14.prefab_name ~= "" and arg_103_1.actors_[var_106_14.prefab_name] ~= nil then
						local var_106_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_14.prefab_name].transform, "story_v_out_222081", "222081025", "story_v_out_222081.awb")

						arg_103_1:RecordAudio("222081025", var_106_20)
						arg_103_1:RecordAudio("222081025", var_106_20)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_222081", "222081025", "story_v_out_222081.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_222081", "222081025", "story_v_out_222081.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_21 = math.max(var_106_12, arg_103_1.talkMaxDuration)

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_21 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_11) / var_106_21

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_11 + var_106_21 and arg_103_1.time_ < var_106_11 + var_106_21 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play222081026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 222081026
		arg_107_1.duration_ = 10.63

		local var_107_0 = {
			ja = 10.633,
			ko = 8.966,
			zh = 8.966
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play222081027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10057ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10057ui_story == nil then
				arg_107_1.var_.characterEffect10057ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect10057ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10057ui_story then
				arg_107_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_110_4 = 0

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_6 = arg_107_1.actors_["1074ui_story"]
			local var_110_7 = 0

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1074ui_story == nil then
				arg_107_1.var_.characterEffect1074ui_story = var_110_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_8 = 0.200000002980232

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_8 and not isNil(var_110_6) then
				local var_110_9 = (arg_107_1.time_ - var_110_7) / var_110_8

				if arg_107_1.var_.characterEffect1074ui_story and not isNil(var_110_6) then
					local var_110_10 = Mathf.Lerp(0, 0.5, var_110_9)

					arg_107_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1074ui_story.fillRatio = var_110_10
				end
			end

			if arg_107_1.time_ >= var_110_7 + var_110_8 and arg_107_1.time_ < var_110_7 + var_110_8 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1074ui_story then
				local var_110_11 = 0.5

				arg_107_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1074ui_story.fillRatio = var_110_11
			end

			local var_110_12 = 0
			local var_110_13 = 0.95

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_14 = arg_107_1:FormatText(StoryNameCfg[464].name)

				arg_107_1.leftNameTxt_.text = var_110_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_15 = arg_107_1:GetWordFromCfg(222081026)
				local var_110_16 = arg_107_1:FormatText(var_110_15.content)

				arg_107_1.text_.text = var_110_16

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_17 = 38
				local var_110_18 = utf8.len(var_110_16)
				local var_110_19 = var_110_17 <= 0 and var_110_13 or var_110_13 * (var_110_18 / var_110_17)

				if var_110_19 > 0 and var_110_13 < var_110_19 then
					arg_107_1.talkMaxDuration = var_110_19

					if var_110_19 + var_110_12 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_19 + var_110_12
					end
				end

				arg_107_1.text_.text = var_110_16
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081026", "story_v_out_222081.awb") ~= 0 then
					local var_110_20 = manager.audio:GetVoiceLength("story_v_out_222081", "222081026", "story_v_out_222081.awb") / 1000

					if var_110_20 + var_110_12 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_20 + var_110_12
					end

					if var_110_15.prefab_name ~= "" and arg_107_1.actors_[var_110_15.prefab_name] ~= nil then
						local var_110_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_15.prefab_name].transform, "story_v_out_222081", "222081026", "story_v_out_222081.awb")

						arg_107_1:RecordAudio("222081026", var_110_21)
						arg_107_1:RecordAudio("222081026", var_110_21)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_222081", "222081026", "story_v_out_222081.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_222081", "222081026", "story_v_out_222081.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_22 = math.max(var_110_13, arg_107_1.talkMaxDuration)

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_22 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_12) / var_110_22

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_12 + var_110_22 and arg_107_1.time_ < var_110_12 + var_110_22 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play222081027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 222081027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play222081028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10057ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos10057ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0, 100, 0)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10057ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, 100, 0)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["10057ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect10057ui_story == nil then
				arg_111_1.var_.characterEffect10057ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect10057ui_story and not isNil(var_114_9) then
					local var_114_13 = Mathf.Lerp(0, 0.5, var_114_12)

					arg_111_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10057ui_story.fillRatio = var_114_13
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect10057ui_story then
				local var_114_14 = 0.5

				arg_111_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10057ui_story.fillRatio = var_114_14
			end

			local var_114_15 = arg_111_1.actors_["1074ui_story"].transform
			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.var_.moveOldPos1074ui_story = var_114_15.localPosition
			end

			local var_114_17 = 0.001

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_17 then
				local var_114_18 = (arg_111_1.time_ - var_114_16) / var_114_17
				local var_114_19 = Vector3.New(0, 100, 0)

				var_114_15.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1074ui_story, var_114_19, var_114_18)

				local var_114_20 = manager.ui.mainCamera.transform.position - var_114_15.position

				var_114_15.forward = Vector3.New(var_114_20.x, var_114_20.y, var_114_20.z)

				local var_114_21 = var_114_15.localEulerAngles

				var_114_21.z = 0
				var_114_21.x = 0
				var_114_15.localEulerAngles = var_114_21
			end

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 then
				var_114_15.localPosition = Vector3.New(0, 100, 0)

				local var_114_22 = manager.ui.mainCamera.transform.position - var_114_15.position

				var_114_15.forward = Vector3.New(var_114_22.x, var_114_22.y, var_114_22.z)

				local var_114_23 = var_114_15.localEulerAngles

				var_114_23.z = 0
				var_114_23.x = 0
				var_114_15.localEulerAngles = var_114_23
			end

			local var_114_24 = arg_111_1.actors_["1074ui_story"]
			local var_114_25 = 0

			if var_114_25 < arg_111_1.time_ and arg_111_1.time_ <= var_114_25 + arg_114_0 and not isNil(var_114_24) and arg_111_1.var_.characterEffect1074ui_story == nil then
				arg_111_1.var_.characterEffect1074ui_story = var_114_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_26 = 0.200000002980232

			if var_114_25 <= arg_111_1.time_ and arg_111_1.time_ < var_114_25 + var_114_26 and not isNil(var_114_24) then
				local var_114_27 = (arg_111_1.time_ - var_114_25) / var_114_26

				if arg_111_1.var_.characterEffect1074ui_story and not isNil(var_114_24) then
					local var_114_28 = Mathf.Lerp(0, 0.5, var_114_27)

					arg_111_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1074ui_story.fillRatio = var_114_28
				end
			end

			if arg_111_1.time_ >= var_114_25 + var_114_26 and arg_111_1.time_ < var_114_25 + var_114_26 + arg_114_0 and not isNil(var_114_24) and arg_111_1.var_.characterEffect1074ui_story then
				local var_114_29 = 0.5

				arg_111_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1074ui_story.fillRatio = var_114_29
			end

			local var_114_30 = 0
			local var_114_31 = 0.75

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_32 = arg_111_1:GetWordFromCfg(222081027)
				local var_114_33 = arg_111_1:FormatText(var_114_32.content)

				arg_111_1.text_.text = var_114_33

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_34 = 30
				local var_114_35 = utf8.len(var_114_33)
				local var_114_36 = var_114_34 <= 0 and var_114_31 or var_114_31 * (var_114_35 / var_114_34)

				if var_114_36 > 0 and var_114_31 < var_114_36 then
					arg_111_1.talkMaxDuration = var_114_36

					if var_114_36 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_36 + var_114_30
					end
				end

				arg_111_1.text_.text = var_114_33
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_37 = math.max(var_114_31, arg_111_1.talkMaxDuration)

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_37 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_30) / var_114_37

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_30 + var_114_37 and arg_111_1.time_ < var_114_30 + var_114_37 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play222081028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 222081028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play222081029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 1.425

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(222081028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 57
				local var_118_5 = utf8.len(var_118_3)
				local var_118_6 = var_118_4 <= 0 and var_118_1 or var_118_1 * (var_118_5 / var_118_4)

				if var_118_6 > 0 and var_118_1 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_7 and arg_115_1.time_ < var_118_0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play222081029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 222081029
		arg_119_1.duration_ = 4.93

		local var_119_0 = {
			ja = 3.666,
			ko = 4.9,
			zh = 4.933
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play222081030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1074ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1074ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1074ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1074ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1074ui_story == nil then
				arg_119_1.var_.characterEffect1074ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect1074ui_story and not isNil(var_122_9) then
					arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1074ui_story then
				arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_122_14 = 0

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 then
				arg_119_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_122_15 = 0
			local var_122_16 = 0.625

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[410].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(222081029)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 25
				local var_122_21 = utf8.len(var_122_19)
				local var_122_22 = var_122_20 <= 0 and var_122_16 or var_122_16 * (var_122_21 / var_122_20)

				if var_122_22 > 0 and var_122_16 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22

					if var_122_22 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_15
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081029", "story_v_out_222081.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_222081", "222081029", "story_v_out_222081.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_222081", "222081029", "story_v_out_222081.awb")

						arg_119_1:RecordAudio("222081029", var_122_24)
						arg_119_1:RecordAudio("222081029", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_222081", "222081029", "story_v_out_222081.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_222081", "222081029", "story_v_out_222081.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_25 = math.max(var_122_16, arg_119_1.talkMaxDuration)

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_25 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_15) / var_122_25

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_15 + var_122_25 and arg_119_1.time_ < var_122_15 + var_122_25 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play222081030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 222081030
		arg_123_1.duration_ = 6.7

		local var_123_0 = {
			ja = 6.7,
			ko = 4.933,
			zh = 4.933
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
				arg_123_0:Play222081031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1070ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1070ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0.7, -0.95, -6.05)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1070ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1070ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1070ui_story == nil then
				arg_123_1.var_.characterEffect1070ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1070ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1070ui_story then
				arg_123_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_126_15 = arg_123_1.actors_["1074ui_story"]
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.characterEffect1074ui_story == nil then
				arg_123_1.var_.characterEffect1074ui_story = var_126_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_17 = 0.200000002980232

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 and not isNil(var_126_15) then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17

				if arg_123_1.var_.characterEffect1074ui_story and not isNil(var_126_15) then
					local var_126_19 = Mathf.Lerp(0, 0.5, var_126_18)

					arg_123_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1074ui_story.fillRatio = var_126_19
				end
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.characterEffect1074ui_story then
				local var_126_20 = 0.5

				arg_123_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1074ui_story.fillRatio = var_126_20
			end

			local var_126_21 = 0
			local var_126_22 = 0.625

			if var_126_21 < arg_123_1.time_ and arg_123_1.time_ <= var_126_21 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_23 = arg_123_1:FormatText(StoryNameCfg[318].name)

				arg_123_1.leftNameTxt_.text = var_126_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_24 = arg_123_1:GetWordFromCfg(222081030)
				local var_126_25 = arg_123_1:FormatText(var_126_24.content)

				arg_123_1.text_.text = var_126_25

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_26 = 25
				local var_126_27 = utf8.len(var_126_25)
				local var_126_28 = var_126_26 <= 0 and var_126_22 or var_126_22 * (var_126_27 / var_126_26)

				if var_126_28 > 0 and var_126_22 < var_126_28 then
					arg_123_1.talkMaxDuration = var_126_28

					if var_126_28 + var_126_21 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_28 + var_126_21
					end
				end

				arg_123_1.text_.text = var_126_25
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081030", "story_v_out_222081.awb") ~= 0 then
					local var_126_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081030", "story_v_out_222081.awb") / 1000

					if var_126_29 + var_126_21 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_29 + var_126_21
					end

					if var_126_24.prefab_name ~= "" and arg_123_1.actors_[var_126_24.prefab_name] ~= nil then
						local var_126_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_24.prefab_name].transform, "story_v_out_222081", "222081030", "story_v_out_222081.awb")

						arg_123_1:RecordAudio("222081030", var_126_30)
						arg_123_1:RecordAudio("222081030", var_126_30)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_222081", "222081030", "story_v_out_222081.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_222081", "222081030", "story_v_out_222081.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_31 = math.max(var_126_22, arg_123_1.talkMaxDuration)

			if var_126_21 <= arg_123_1.time_ and arg_123_1.time_ < var_126_21 + var_126_31 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_21) / var_126_31

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_21 + var_126_31 and arg_123_1.time_ < var_126_21 + var_126_31 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play222081031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 222081031
		arg_127_1.duration_ = 4.9

		local var_127_0 = {
			ja = 4.9,
			ko = 3.766,
			zh = 3.766
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
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play222081032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1074ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1074ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, 100, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1074ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, 100, 0)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["1074ui_story"]
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1074ui_story == nil then
				arg_127_1.var_.characterEffect1074ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 and not isNil(var_130_9) then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect1074ui_story and not isNil(var_130_9) then
					local var_130_13 = Mathf.Lerp(0, 0.5, var_130_12)

					arg_127_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1074ui_story.fillRatio = var_130_13
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1074ui_story then
				local var_130_14 = 0.5

				arg_127_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1074ui_story.fillRatio = var_130_14
			end

			local var_130_15 = arg_127_1.actors_["10057ui_story"].transform
			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.var_.moveOldPos10057ui_story = var_130_15.localPosition
			end

			local var_130_17 = 0.001

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17
				local var_130_19 = Vector3.New(-0.7, -1.13, -5.72)

				var_130_15.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10057ui_story, var_130_19, var_130_18)

				local var_130_20 = manager.ui.mainCamera.transform.position - var_130_15.position

				var_130_15.forward = Vector3.New(var_130_20.x, var_130_20.y, var_130_20.z)

				local var_130_21 = var_130_15.localEulerAngles

				var_130_21.z = 0
				var_130_21.x = 0
				var_130_15.localEulerAngles = var_130_21
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				var_130_15.localPosition = Vector3.New(-0.7, -1.13, -5.72)

				local var_130_22 = manager.ui.mainCamera.transform.position - var_130_15.position

				var_130_15.forward = Vector3.New(var_130_22.x, var_130_22.y, var_130_22.z)

				local var_130_23 = var_130_15.localEulerAngles

				var_130_23.z = 0
				var_130_23.x = 0
				var_130_15.localEulerAngles = var_130_23
			end

			local var_130_24 = arg_127_1.actors_["10057ui_story"]
			local var_130_25 = 0

			if var_130_25 < arg_127_1.time_ and arg_127_1.time_ <= var_130_25 + arg_130_0 and not isNil(var_130_24) and arg_127_1.var_.characterEffect10057ui_story == nil then
				arg_127_1.var_.characterEffect10057ui_story = var_130_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_26 = 0.200000002980232

			if var_130_25 <= arg_127_1.time_ and arg_127_1.time_ < var_130_25 + var_130_26 and not isNil(var_130_24) then
				local var_130_27 = (arg_127_1.time_ - var_130_25) / var_130_26

				if arg_127_1.var_.characterEffect10057ui_story and not isNil(var_130_24) then
					arg_127_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_25 + var_130_26 and arg_127_1.time_ < var_130_25 + var_130_26 + arg_130_0 and not isNil(var_130_24) and arg_127_1.var_.characterEffect10057ui_story then
				arg_127_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_130_28 = 0

			if var_130_28 < arg_127_1.time_ and arg_127_1.time_ <= var_130_28 + arg_130_0 then
				arg_127_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_130_29 = 0

			if var_130_29 < arg_127_1.time_ and arg_127_1.time_ <= var_130_29 + arg_130_0 then
				arg_127_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_30 = arg_127_1.actors_["1070ui_story"]
			local var_130_31 = 0

			if var_130_31 < arg_127_1.time_ and arg_127_1.time_ <= var_130_31 + arg_130_0 and not isNil(var_130_30) and arg_127_1.var_.characterEffect1070ui_story == nil then
				arg_127_1.var_.characterEffect1070ui_story = var_130_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_32 = 0.200000002980232

			if var_130_31 <= arg_127_1.time_ and arg_127_1.time_ < var_130_31 + var_130_32 and not isNil(var_130_30) then
				local var_130_33 = (arg_127_1.time_ - var_130_31) / var_130_32

				if arg_127_1.var_.characterEffect1070ui_story and not isNil(var_130_30) then
					local var_130_34 = Mathf.Lerp(0, 0.5, var_130_33)

					arg_127_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1070ui_story.fillRatio = var_130_34
				end
			end

			if arg_127_1.time_ >= var_130_31 + var_130_32 and arg_127_1.time_ < var_130_31 + var_130_32 + arg_130_0 and not isNil(var_130_30) and arg_127_1.var_.characterEffect1070ui_story then
				local var_130_35 = 0.5

				arg_127_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1070ui_story.fillRatio = var_130_35
			end

			local var_130_36 = 0
			local var_130_37 = 0.35

			if var_130_36 < arg_127_1.time_ and arg_127_1.time_ <= var_130_36 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_38 = arg_127_1:FormatText(StoryNameCfg[464].name)

				arg_127_1.leftNameTxt_.text = var_130_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_39 = arg_127_1:GetWordFromCfg(222081031)
				local var_130_40 = arg_127_1:FormatText(var_130_39.content)

				arg_127_1.text_.text = var_130_40

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_41 = 14
				local var_130_42 = utf8.len(var_130_40)
				local var_130_43 = var_130_41 <= 0 and var_130_37 or var_130_37 * (var_130_42 / var_130_41)

				if var_130_43 > 0 and var_130_37 < var_130_43 then
					arg_127_1.talkMaxDuration = var_130_43

					if var_130_43 + var_130_36 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_43 + var_130_36
					end
				end

				arg_127_1.text_.text = var_130_40
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081031", "story_v_out_222081.awb") ~= 0 then
					local var_130_44 = manager.audio:GetVoiceLength("story_v_out_222081", "222081031", "story_v_out_222081.awb") / 1000

					if var_130_44 + var_130_36 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_44 + var_130_36
					end

					if var_130_39.prefab_name ~= "" and arg_127_1.actors_[var_130_39.prefab_name] ~= nil then
						local var_130_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_39.prefab_name].transform, "story_v_out_222081", "222081031", "story_v_out_222081.awb")

						arg_127_1:RecordAudio("222081031", var_130_45)
						arg_127_1:RecordAudio("222081031", var_130_45)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_222081", "222081031", "story_v_out_222081.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_222081", "222081031", "story_v_out_222081.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_46 = math.max(var_130_37, arg_127_1.talkMaxDuration)

			if var_130_36 <= arg_127_1.time_ and arg_127_1.time_ < var_130_36 + var_130_46 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_36) / var_130_46

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_36 + var_130_46 and arg_127_1.time_ < var_130_36 + var_130_46 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play222081032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 222081032
		arg_131_1.duration_ = 4.7

		local var_131_0 = {
			ja = 4.7,
			ko = 4.4,
			zh = 4.4
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play222081033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1070ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1070ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0.7, -0.95, -6.05)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1070ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1070ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1070ui_story == nil then
				arg_131_1.var_.characterEffect1070ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1070ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1070ui_story then
				arg_131_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_15 = arg_131_1.actors_["10057ui_story"]
			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 and not isNil(var_134_15) and arg_131_1.var_.characterEffect10057ui_story == nil then
				arg_131_1.var_.characterEffect10057ui_story = var_134_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_17 = 0.200000002980232

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 and not isNil(var_134_15) then
				local var_134_18 = (arg_131_1.time_ - var_134_16) / var_134_17

				if arg_131_1.var_.characterEffect10057ui_story and not isNil(var_134_15) then
					local var_134_19 = Mathf.Lerp(0, 0.5, var_134_18)

					arg_131_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10057ui_story.fillRatio = var_134_19
				end
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 and not isNil(var_134_15) and arg_131_1.var_.characterEffect10057ui_story then
				local var_134_20 = 0.5

				arg_131_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10057ui_story.fillRatio = var_134_20
			end

			local var_134_21 = 0
			local var_134_22 = 0.6

			if var_134_21 < arg_131_1.time_ and arg_131_1.time_ <= var_134_21 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_23 = arg_131_1:FormatText(StoryNameCfg[318].name)

				arg_131_1.leftNameTxt_.text = var_134_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_24 = arg_131_1:GetWordFromCfg(222081032)
				local var_134_25 = arg_131_1:FormatText(var_134_24.content)

				arg_131_1.text_.text = var_134_25

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_26 = 24
				local var_134_27 = utf8.len(var_134_25)
				local var_134_28 = var_134_26 <= 0 and var_134_22 or var_134_22 * (var_134_27 / var_134_26)

				if var_134_28 > 0 and var_134_22 < var_134_28 then
					arg_131_1.talkMaxDuration = var_134_28

					if var_134_28 + var_134_21 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_28 + var_134_21
					end
				end

				arg_131_1.text_.text = var_134_25
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081032", "story_v_out_222081.awb") ~= 0 then
					local var_134_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081032", "story_v_out_222081.awb") / 1000

					if var_134_29 + var_134_21 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_29 + var_134_21
					end

					if var_134_24.prefab_name ~= "" and arg_131_1.actors_[var_134_24.prefab_name] ~= nil then
						local var_134_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_24.prefab_name].transform, "story_v_out_222081", "222081032", "story_v_out_222081.awb")

						arg_131_1:RecordAudio("222081032", var_134_30)
						arg_131_1:RecordAudio("222081032", var_134_30)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_222081", "222081032", "story_v_out_222081.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_222081", "222081032", "story_v_out_222081.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_31 = math.max(var_134_22, arg_131_1.talkMaxDuration)

			if var_134_21 <= arg_131_1.time_ and arg_131_1.time_ < var_134_21 + var_134_31 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_21) / var_134_31

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_21 + var_134_31 and arg_131_1.time_ < var_134_21 + var_134_31 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play222081033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 222081033
		arg_135_1.duration_ = 7.03

		local var_135_0 = {
			ja = 7.033,
			ko = 4.933,
			zh = 4.933
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play222081034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10057ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10057ui_story == nil then
				arg_135_1.var_.characterEffect10057ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect10057ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10057ui_story then
				arg_135_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_6 = arg_135_1.actors_["1070ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1070ui_story == nil then
				arg_135_1.var_.characterEffect1070ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.200000002980232

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect1070ui_story and not isNil(var_138_6) then
					local var_138_10 = Mathf.Lerp(0, 0.5, var_138_9)

					arg_135_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1070ui_story.fillRatio = var_138_10
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1070ui_story then
				local var_138_11 = 0.5

				arg_135_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1070ui_story.fillRatio = var_138_11
			end

			local var_138_12 = 0
			local var_138_13 = 0.35

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[464].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(222081033)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 14
				local var_138_18 = utf8.len(var_138_16)
				local var_138_19 = var_138_17 <= 0 and var_138_13 or var_138_13 * (var_138_18 / var_138_17)

				if var_138_19 > 0 and var_138_13 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19

					if var_138_19 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081033", "story_v_out_222081.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_222081", "222081033", "story_v_out_222081.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_222081", "222081033", "story_v_out_222081.awb")

						arg_135_1:RecordAudio("222081033", var_138_21)
						arg_135_1:RecordAudio("222081033", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_222081", "222081033", "story_v_out_222081.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_222081", "222081033", "story_v_out_222081.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_22 and arg_135_1.time_ < var_138_12 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play222081034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 222081034
		arg_139_1.duration_ = 5.47

		local var_139_0 = {
			ja = 5,
			ko = 5.466,
			zh = 5.466
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play222081035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1070ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1070ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0.7, -0.95, -6.05)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1070ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1070ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1070ui_story == nil then
				arg_139_1.var_.characterEffect1070ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1070ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1070ui_story then
				arg_139_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_142_15 = arg_139_1.actors_["10057ui_story"]
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.characterEffect10057ui_story == nil then
				arg_139_1.var_.characterEffect10057ui_story = var_142_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_17 = 0.200000002980232

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 and not isNil(var_142_15) then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17

				if arg_139_1.var_.characterEffect10057ui_story and not isNil(var_142_15) then
					local var_142_19 = Mathf.Lerp(0, 0.5, var_142_18)

					arg_139_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10057ui_story.fillRatio = var_142_19
				end
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.characterEffect10057ui_story then
				local var_142_20 = 0.5

				arg_139_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10057ui_story.fillRatio = var_142_20
			end

			local var_142_21 = 0
			local var_142_22 = 0.8

			if var_142_21 < arg_139_1.time_ and arg_139_1.time_ <= var_142_21 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_23 = arg_139_1:FormatText(StoryNameCfg[318].name)

				arg_139_1.leftNameTxt_.text = var_142_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_24 = arg_139_1:GetWordFromCfg(222081034)
				local var_142_25 = arg_139_1:FormatText(var_142_24.content)

				arg_139_1.text_.text = var_142_25

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_26 = 32
				local var_142_27 = utf8.len(var_142_25)
				local var_142_28 = var_142_26 <= 0 and var_142_22 or var_142_22 * (var_142_27 / var_142_26)

				if var_142_28 > 0 and var_142_22 < var_142_28 then
					arg_139_1.talkMaxDuration = var_142_28

					if var_142_28 + var_142_21 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_28 + var_142_21
					end
				end

				arg_139_1.text_.text = var_142_25
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081034", "story_v_out_222081.awb") ~= 0 then
					local var_142_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081034", "story_v_out_222081.awb") / 1000

					if var_142_29 + var_142_21 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_29 + var_142_21
					end

					if var_142_24.prefab_name ~= "" and arg_139_1.actors_[var_142_24.prefab_name] ~= nil then
						local var_142_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_24.prefab_name].transform, "story_v_out_222081", "222081034", "story_v_out_222081.awb")

						arg_139_1:RecordAudio("222081034", var_142_30)
						arg_139_1:RecordAudio("222081034", var_142_30)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_222081", "222081034", "story_v_out_222081.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_222081", "222081034", "story_v_out_222081.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_31 = math.max(var_142_22, arg_139_1.talkMaxDuration)

			if var_142_21 <= arg_139_1.time_ and arg_139_1.time_ < var_142_21 + var_142_31 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_21) / var_142_31

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_21 + var_142_31 and arg_139_1.time_ < var_142_21 + var_142_31 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play222081035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 222081035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play222081036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1070ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1070ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, 100, 0)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1070ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, 100, 0)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["1070ui_story"]
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect1070ui_story == nil then
				arg_143_1.var_.characterEffect1070ui_story = var_146_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_11 = 0.200000002980232

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 and not isNil(var_146_9) then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11

				if arg_143_1.var_.characterEffect1070ui_story and not isNil(var_146_9) then
					local var_146_13 = Mathf.Lerp(0, 0.5, var_146_12)

					arg_143_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1070ui_story.fillRatio = var_146_13
				end
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect1070ui_story then
				local var_146_14 = 0.5

				arg_143_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1070ui_story.fillRatio = var_146_14
			end

			local var_146_15 = arg_143_1.actors_["10057ui_story"].transform
			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.var_.moveOldPos10057ui_story = var_146_15.localPosition
			end

			local var_146_17 = 0.001

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 then
				local var_146_18 = (arg_143_1.time_ - var_146_16) / var_146_17
				local var_146_19 = Vector3.New(0, 100, 0)

				var_146_15.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10057ui_story, var_146_19, var_146_18)

				local var_146_20 = manager.ui.mainCamera.transform.position - var_146_15.position

				var_146_15.forward = Vector3.New(var_146_20.x, var_146_20.y, var_146_20.z)

				local var_146_21 = var_146_15.localEulerAngles

				var_146_21.z = 0
				var_146_21.x = 0
				var_146_15.localEulerAngles = var_146_21
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 then
				var_146_15.localPosition = Vector3.New(0, 100, 0)

				local var_146_22 = manager.ui.mainCamera.transform.position - var_146_15.position

				var_146_15.forward = Vector3.New(var_146_22.x, var_146_22.y, var_146_22.z)

				local var_146_23 = var_146_15.localEulerAngles

				var_146_23.z = 0
				var_146_23.x = 0
				var_146_15.localEulerAngles = var_146_23
			end

			local var_146_24 = arg_143_1.actors_["10057ui_story"]
			local var_146_25 = 0

			if var_146_25 < arg_143_1.time_ and arg_143_1.time_ <= var_146_25 + arg_146_0 and not isNil(var_146_24) and arg_143_1.var_.characterEffect10057ui_story == nil then
				arg_143_1.var_.characterEffect10057ui_story = var_146_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_26 = 0.200000002980232

			if var_146_25 <= arg_143_1.time_ and arg_143_1.time_ < var_146_25 + var_146_26 and not isNil(var_146_24) then
				local var_146_27 = (arg_143_1.time_ - var_146_25) / var_146_26

				if arg_143_1.var_.characterEffect10057ui_story and not isNil(var_146_24) then
					local var_146_28 = Mathf.Lerp(0, 0.5, var_146_27)

					arg_143_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10057ui_story.fillRatio = var_146_28
				end
			end

			if arg_143_1.time_ >= var_146_25 + var_146_26 and arg_143_1.time_ < var_146_25 + var_146_26 + arg_146_0 and not isNil(var_146_24) and arg_143_1.var_.characterEffect10057ui_story then
				local var_146_29 = 0.5

				arg_143_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10057ui_story.fillRatio = var_146_29
			end

			local var_146_30 = 0
			local var_146_31 = 1

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				local var_146_32 = "play"
				local var_146_33 = "effect"

				arg_143_1:AudioAction(var_146_32, var_146_33, "se_story_222_00", "se_story_222_00_gun", "")
			end

			local var_146_34 = manager.ui.mainCamera.transform
			local var_146_35 = 0

			if var_146_35 < arg_143_1.time_ and arg_143_1.time_ <= var_146_35 + arg_146_0 then
				arg_143_1.var_.shakeOldPos = var_146_34.localPosition
			end

			local var_146_36 = 0.6

			if var_146_35 <= arg_143_1.time_ and arg_143_1.time_ < var_146_35 + var_146_36 then
				local var_146_37 = (arg_143_1.time_ - var_146_35) / 0.066
				local var_146_38, var_146_39 = math.modf(var_146_37)

				var_146_34.localPosition = Vector3.New(var_146_39 * 0.13, var_146_39 * 0.13, var_146_39 * 0.13) + arg_143_1.var_.shakeOldPos
			end

			if arg_143_1.time_ >= var_146_35 + var_146_36 and arg_143_1.time_ < var_146_35 + var_146_36 + arg_146_0 then
				var_146_34.localPosition = arg_143_1.var_.shakeOldPos
			end

			local var_146_40 = 0

			if var_146_40 < arg_143_1.time_ and arg_143_1.time_ <= var_146_40 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			local var_146_41 = 0.6

			if arg_143_1.time_ >= var_146_40 + var_146_41 and arg_143_1.time_ < var_146_40 + var_146_41 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_42 = 0
			local var_146_43 = 1.075

			if var_146_42 < arg_143_1.time_ and arg_143_1.time_ <= var_146_42 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_44 = arg_143_1:GetWordFromCfg(222081035)
				local var_146_45 = arg_143_1:FormatText(var_146_44.content)

				arg_143_1.text_.text = var_146_45

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_46 = 43
				local var_146_47 = utf8.len(var_146_45)
				local var_146_48 = var_146_46 <= 0 and var_146_43 or var_146_43 * (var_146_47 / var_146_46)

				if var_146_48 > 0 and var_146_43 < var_146_48 then
					arg_143_1.talkMaxDuration = var_146_48

					if var_146_48 + var_146_42 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_48 + var_146_42
					end
				end

				arg_143_1.text_.text = var_146_45
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_49 = math.max(var_146_43, arg_143_1.talkMaxDuration)

			if var_146_42 <= arg_143_1.time_ and arg_143_1.time_ < var_146_42 + var_146_49 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_42) / var_146_49

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_42 + var_146_49 and arg_143_1.time_ < var_146_42 + var_146_49 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play222081036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 222081036
		arg_147_1.duration_ = 5.57

		local var_147_0 = {
			ja = 5.566,
			ko = 4.8,
			zh = 4.8
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play222081037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1070ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1070ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -0.95, -6.05)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1070ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1070ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1070ui_story == nil then
				arg_147_1.var_.characterEffect1070ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1070ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1070ui_story then
				arg_147_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_150_15 = arg_147_1.actors_["10057ui_story"]
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect10057ui_story == nil then
				arg_147_1.var_.characterEffect10057ui_story = var_150_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_17 = 0.200000002980232

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 and not isNil(var_150_15) then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17

				if arg_147_1.var_.characterEffect10057ui_story and not isNil(var_150_15) then
					local var_150_19 = Mathf.Lerp(0, 0.5, var_150_18)

					arg_147_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10057ui_story.fillRatio = var_150_19
				end
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect10057ui_story then
				local var_150_20 = 0.5

				arg_147_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10057ui_story.fillRatio = var_150_20
			end

			local var_150_21 = 0
			local var_150_22 = 0.5

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_23 = arg_147_1:FormatText(StoryNameCfg[318].name)

				arg_147_1.leftNameTxt_.text = var_150_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_24 = arg_147_1:GetWordFromCfg(222081036)
				local var_150_25 = arg_147_1:FormatText(var_150_24.content)

				arg_147_1.text_.text = var_150_25

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_26 = 20
				local var_150_27 = utf8.len(var_150_25)
				local var_150_28 = var_150_26 <= 0 and var_150_22 or var_150_22 * (var_150_27 / var_150_26)

				if var_150_28 > 0 and var_150_22 < var_150_28 then
					arg_147_1.talkMaxDuration = var_150_28

					if var_150_28 + var_150_21 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_28 + var_150_21
					end
				end

				arg_147_1.text_.text = var_150_25
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081036", "story_v_out_222081.awb") ~= 0 then
					local var_150_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081036", "story_v_out_222081.awb") / 1000

					if var_150_29 + var_150_21 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_29 + var_150_21
					end

					if var_150_24.prefab_name ~= "" and arg_147_1.actors_[var_150_24.prefab_name] ~= nil then
						local var_150_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_24.prefab_name].transform, "story_v_out_222081", "222081036", "story_v_out_222081.awb")

						arg_147_1:RecordAudio("222081036", var_150_30)
						arg_147_1:RecordAudio("222081036", var_150_30)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_222081", "222081036", "story_v_out_222081.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_222081", "222081036", "story_v_out_222081.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_31 = math.max(var_150_22, arg_147_1.talkMaxDuration)

			if var_150_21 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_31 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_21) / var_150_31

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_21 + var_150_31 and arg_147_1.time_ < var_150_21 + var_150_31 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play222081037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 222081037
		arg_151_1.duration_ = 8.43

		local var_151_0 = {
			ja = 8.433,
			ko = 6.1,
			zh = 6.1
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play222081038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1070ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1070ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, 100, 0)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1070ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, 100, 0)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["1070ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1070ui_story == nil then
				arg_151_1.var_.characterEffect1070ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect1070ui_story and not isNil(var_154_9) then
					local var_154_13 = Mathf.Lerp(0, 0.5, var_154_12)

					arg_151_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1070ui_story.fillRatio = var_154_13
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1070ui_story then
				local var_154_14 = 0.5

				arg_151_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1070ui_story.fillRatio = var_154_14
			end

			local var_154_15 = arg_151_1.actors_["10057ui_story"].transform
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.var_.moveOldPos10057ui_story = var_154_15.localPosition
			end

			local var_154_17 = 0.001

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17
				local var_154_19 = Vector3.New(0, -1.13, -5.72)

				var_154_15.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10057ui_story, var_154_19, var_154_18)

				local var_154_20 = manager.ui.mainCamera.transform.position - var_154_15.position

				var_154_15.forward = Vector3.New(var_154_20.x, var_154_20.y, var_154_20.z)

				local var_154_21 = var_154_15.localEulerAngles

				var_154_21.z = 0
				var_154_21.x = 0
				var_154_15.localEulerAngles = var_154_21
			end

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				var_154_15.localPosition = Vector3.New(0, -1.13, -5.72)

				local var_154_22 = manager.ui.mainCamera.transform.position - var_154_15.position

				var_154_15.forward = Vector3.New(var_154_22.x, var_154_22.y, var_154_22.z)

				local var_154_23 = var_154_15.localEulerAngles

				var_154_23.z = 0
				var_154_23.x = 0
				var_154_15.localEulerAngles = var_154_23
			end

			local var_154_24 = arg_151_1.actors_["10057ui_story"]
			local var_154_25 = 0

			if var_154_25 < arg_151_1.time_ and arg_151_1.time_ <= var_154_25 + arg_154_0 and not isNil(var_154_24) and arg_151_1.var_.characterEffect10057ui_story == nil then
				arg_151_1.var_.characterEffect10057ui_story = var_154_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_26 = 0.200000002980232

			if var_154_25 <= arg_151_1.time_ and arg_151_1.time_ < var_154_25 + var_154_26 and not isNil(var_154_24) then
				local var_154_27 = (arg_151_1.time_ - var_154_25) / var_154_26

				if arg_151_1.var_.characterEffect10057ui_story and not isNil(var_154_24) then
					arg_151_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_25 + var_154_26 and arg_151_1.time_ < var_154_25 + var_154_26 + arg_154_0 and not isNil(var_154_24) and arg_151_1.var_.characterEffect10057ui_story then
				arg_151_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_154_28 = 0

			if var_154_28 < arg_151_1.time_ and arg_151_1.time_ <= var_154_28 + arg_154_0 then
				arg_151_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_154_29 = 0

			if var_154_29 < arg_151_1.time_ and arg_151_1.time_ <= var_154_29 + arg_154_0 then
				arg_151_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_154_30 = 0
			local var_154_31 = 0.65

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_32 = arg_151_1:FormatText(StoryNameCfg[464].name)

				arg_151_1.leftNameTxt_.text = var_154_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_33 = arg_151_1:GetWordFromCfg(222081037)
				local var_154_34 = arg_151_1:FormatText(var_154_33.content)

				arg_151_1.text_.text = var_154_34

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_35 = 26
				local var_154_36 = utf8.len(var_154_34)
				local var_154_37 = var_154_35 <= 0 and var_154_31 or var_154_31 * (var_154_36 / var_154_35)

				if var_154_37 > 0 and var_154_31 < var_154_37 then
					arg_151_1.talkMaxDuration = var_154_37

					if var_154_37 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_37 + var_154_30
					end
				end

				arg_151_1.text_.text = var_154_34
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081037", "story_v_out_222081.awb") ~= 0 then
					local var_154_38 = manager.audio:GetVoiceLength("story_v_out_222081", "222081037", "story_v_out_222081.awb") / 1000

					if var_154_38 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_38 + var_154_30
					end

					if var_154_33.prefab_name ~= "" and arg_151_1.actors_[var_154_33.prefab_name] ~= nil then
						local var_154_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_33.prefab_name].transform, "story_v_out_222081", "222081037", "story_v_out_222081.awb")

						arg_151_1:RecordAudio("222081037", var_154_39)
						arg_151_1:RecordAudio("222081037", var_154_39)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_222081", "222081037", "story_v_out_222081.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_222081", "222081037", "story_v_out_222081.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_40 = math.max(var_154_31, arg_151_1.talkMaxDuration)

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_40 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_30) / var_154_40

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_30 + var_154_40 and arg_151_1.time_ < var_154_30 + var_154_40 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play222081038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 222081038
		arg_155_1.duration_ = 6

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play222081039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10057ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10057ui_story == nil then
				arg_155_1.var_.characterEffect10057ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10057ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10057ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10057ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10057ui_story.fillRatio = var_158_5
			end

			local var_158_6 = 0
			local var_158_7 = 1

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				local var_158_8 = "play"
				local var_158_9 = "effect"

				arg_155_1:AudioAction(var_158_8, var_158_9, "se_story_222_00", "se_story_222_00_rockcollapse", "")
			end

			local var_158_10 = arg_155_1.actors_["10057ui_story"].transform
			local var_158_11 = 0

			if var_158_11 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				arg_155_1.var_.moveOldPos10057ui_story = var_158_10.localPosition
			end

			local var_158_12 = 0.001

			if var_158_11 <= arg_155_1.time_ and arg_155_1.time_ < var_158_11 + var_158_12 then
				local var_158_13 = (arg_155_1.time_ - var_158_11) / var_158_12
				local var_158_14 = Vector3.New(0, 100, 0)

				var_158_10.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10057ui_story, var_158_14, var_158_13)

				local var_158_15 = manager.ui.mainCamera.transform.position - var_158_10.position

				var_158_10.forward = Vector3.New(var_158_15.x, var_158_15.y, var_158_15.z)

				local var_158_16 = var_158_10.localEulerAngles

				var_158_16.z = 0
				var_158_16.x = 0
				var_158_10.localEulerAngles = var_158_16
			end

			if arg_155_1.time_ >= var_158_11 + var_158_12 and arg_155_1.time_ < var_158_11 + var_158_12 + arg_158_0 then
				var_158_10.localPosition = Vector3.New(0, 100, 0)

				local var_158_17 = manager.ui.mainCamera.transform.position - var_158_10.position

				var_158_10.forward = Vector3.New(var_158_17.x, var_158_17.y, var_158_17.z)

				local var_158_18 = var_158_10.localEulerAngles

				var_158_18.z = 0
				var_158_18.x = 0
				var_158_10.localEulerAngles = var_158_18
			end

			local var_158_19 = manager.ui.mainCamera.transform
			local var_158_20 = 0

			if var_158_20 < arg_155_1.time_ and arg_155_1.time_ <= var_158_20 + arg_158_0 then
				arg_155_1.var_.shakeOldPos = var_158_19.localPosition
			end

			local var_158_21 = 2

			if var_158_20 <= arg_155_1.time_ and arg_155_1.time_ < var_158_20 + var_158_21 then
				local var_158_22 = (arg_155_1.time_ - var_158_20) / 0.066
				local var_158_23, var_158_24 = math.modf(var_158_22)

				var_158_19.localPosition = Vector3.New(var_158_24 * 0.13, var_158_24 * 0.13, var_158_24 * 0.13) + arg_155_1.var_.shakeOldPos
			end

			if arg_155_1.time_ >= var_158_20 + var_158_21 and arg_155_1.time_ < var_158_20 + var_158_21 + arg_158_0 then
				var_158_19.localPosition = arg_155_1.var_.shakeOldPos
			end

			local var_158_25 = 0

			if var_158_25 < arg_155_1.time_ and arg_155_1.time_ <= var_158_25 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_26 = 2

			if var_158_25 <= arg_155_1.time_ and arg_155_1.time_ < var_158_25 + var_158_26 then
				local var_158_27 = (arg_155_1.time_ - var_158_25) / var_158_26
				local var_158_28 = Color.New(1, 1, 1)

				var_158_28.a = Mathf.Lerp(1, 0, var_158_27)
				arg_155_1.mask_.color = var_158_28
			end

			if arg_155_1.time_ >= var_158_25 + var_158_26 and arg_155_1.time_ < var_158_25 + var_158_26 + arg_158_0 then
				local var_158_29 = Color.New(1, 1, 1)
				local var_158_30 = 0

				arg_155_1.mask_.enabled = false
				var_158_29.a = var_158_30
				arg_155_1.mask_.color = var_158_29
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_31 = 1
			local var_158_32 = 1.125

			if var_158_31 < arg_155_1.time_ and arg_155_1.time_ <= var_158_31 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_33 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_33:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_34 = arg_155_1:GetWordFromCfg(222081038)
				local var_158_35 = arg_155_1:FormatText(var_158_34.content)

				arg_155_1.text_.text = var_158_35

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_36 = 45
				local var_158_37 = utf8.len(var_158_35)
				local var_158_38 = var_158_36 <= 0 and var_158_32 or var_158_32 * (var_158_37 / var_158_36)

				if var_158_38 > 0 and var_158_32 < var_158_38 then
					arg_155_1.talkMaxDuration = var_158_38
					var_158_31 = var_158_31 + 0.3

					if var_158_38 + var_158_31 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_38 + var_158_31
					end
				end

				arg_155_1.text_.text = var_158_35
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_39 = var_158_31 + 0.3
			local var_158_40 = math.max(var_158_32, arg_155_1.talkMaxDuration)

			if var_158_39 <= arg_155_1.time_ and arg_155_1.time_ < var_158_39 + var_158_40 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_39) / var_158_40

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_39 + var_158_40 and arg_155_1.time_ < var_158_39 + var_158_40 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play222081039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 222081039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play222081040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.5

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(222081039)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 60
				local var_164_5 = utf8.len(var_164_3)
				local var_164_6 = var_164_4 <= 0 and var_164_1 or var_164_1 * (var_164_5 / var_164_4)

				if var_164_6 > 0 and var_164_1 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_7 and arg_161_1.time_ < var_164_0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play222081040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 222081040
		arg_165_1.duration_ = 6.07

		local var_165_0 = {
			ja = 6.066,
			ko = 5.166,
			zh = 5.133
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play222081041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1074ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1074ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1074ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1074ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1074ui_story == nil then
				arg_165_1.var_.characterEffect1074ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1074ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1074ui_story then
				arg_165_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_168_15 = 0
			local var_168_16 = 0.675

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[410].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(222081040)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 27
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081040", "story_v_out_222081.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_out_222081", "222081040", "story_v_out_222081.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_out_222081", "222081040", "story_v_out_222081.awb")

						arg_165_1:RecordAudio("222081040", var_168_24)
						arg_165_1:RecordAudio("222081040", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_222081", "222081040", "story_v_out_222081.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_222081", "222081040", "story_v_out_222081.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play222081041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 222081041
		arg_169_1.duration_ = 9.03

		local var_169_0 = {
			ja = 6.1,
			ko = 9.033,
			zh = 9.033
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play222081042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1070ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1070ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0.7, -0.95, -6.05)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1070ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1070ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1070ui_story == nil then
				arg_169_1.var_.characterEffect1070ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1070ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1070ui_story then
				arg_169_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_172_15 = arg_169_1.actors_["1074ui_story"]
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.characterEffect1074ui_story == nil then
				arg_169_1.var_.characterEffect1074ui_story = var_172_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_17 = 0.200000002980232

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 and not isNil(var_172_15) then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17

				if arg_169_1.var_.characterEffect1074ui_story and not isNil(var_172_15) then
					local var_172_19 = Mathf.Lerp(0, 0.5, var_172_18)

					arg_169_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1074ui_story.fillRatio = var_172_19
				end
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.characterEffect1074ui_story then
				local var_172_20 = 0.5

				arg_169_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1074ui_story.fillRatio = var_172_20
			end

			local var_172_21 = 0
			local var_172_22 = 1.4

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_23 = arg_169_1:FormatText(StoryNameCfg[318].name)

				arg_169_1.leftNameTxt_.text = var_172_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_24 = arg_169_1:GetWordFromCfg(222081041)
				local var_172_25 = arg_169_1:FormatText(var_172_24.content)

				arg_169_1.text_.text = var_172_25

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_26 = 56
				local var_172_27 = utf8.len(var_172_25)
				local var_172_28 = var_172_26 <= 0 and var_172_22 or var_172_22 * (var_172_27 / var_172_26)

				if var_172_28 > 0 and var_172_22 < var_172_28 then
					arg_169_1.talkMaxDuration = var_172_28

					if var_172_28 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_28 + var_172_21
					end
				end

				arg_169_1.text_.text = var_172_25
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081041", "story_v_out_222081.awb") ~= 0 then
					local var_172_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081041", "story_v_out_222081.awb") / 1000

					if var_172_29 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_29 + var_172_21
					end

					if var_172_24.prefab_name ~= "" and arg_169_1.actors_[var_172_24.prefab_name] ~= nil then
						local var_172_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_24.prefab_name].transform, "story_v_out_222081", "222081041", "story_v_out_222081.awb")

						arg_169_1:RecordAudio("222081041", var_172_30)
						arg_169_1:RecordAudio("222081041", var_172_30)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_222081", "222081041", "story_v_out_222081.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_222081", "222081041", "story_v_out_222081.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_31 = math.max(var_172_22, arg_169_1.talkMaxDuration)

			if var_172_21 <= arg_169_1.time_ and arg_169_1.time_ < var_172_21 + var_172_31 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_21) / var_172_31

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_21 + var_172_31 and arg_169_1.time_ < var_172_21 + var_172_31 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play222081042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 222081042
		arg_173_1.duration_ = 2.97

		local var_173_0 = {
			ja = 2.966,
			ko = 2.6,
			zh = 2.6
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play222081043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1074ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1074ui_story == nil then
				arg_173_1.var_.characterEffect1074ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1074ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1074ui_story then
				arg_173_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_176_4 = 0

			if var_176_4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_1")
			end

			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_6 = arg_173_1.actors_["1070ui_story"]
			local var_176_7 = 0

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1070ui_story == nil then
				arg_173_1.var_.characterEffect1070ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.200000002980232

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 and not isNil(var_176_6) then
				local var_176_9 = (arg_173_1.time_ - var_176_7) / var_176_8

				if arg_173_1.var_.characterEffect1070ui_story and not isNil(var_176_6) then
					local var_176_10 = Mathf.Lerp(0, 0.5, var_176_9)

					arg_173_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1070ui_story.fillRatio = var_176_10
				end
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1070ui_story then
				local var_176_11 = 0.5

				arg_173_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1070ui_story.fillRatio = var_176_11
			end

			local var_176_12 = 0
			local var_176_13 = 0.275

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_14 = arg_173_1:FormatText(StoryNameCfg[410].name)

				arg_173_1.leftNameTxt_.text = var_176_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_15 = arg_173_1:GetWordFromCfg(222081042)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 11
				local var_176_18 = utf8.len(var_176_16)
				local var_176_19 = var_176_17 <= 0 and var_176_13 or var_176_13 * (var_176_18 / var_176_17)

				if var_176_19 > 0 and var_176_13 < var_176_19 then
					arg_173_1.talkMaxDuration = var_176_19

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081042", "story_v_out_222081.awb") ~= 0 then
					local var_176_20 = manager.audio:GetVoiceLength("story_v_out_222081", "222081042", "story_v_out_222081.awb") / 1000

					if var_176_20 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_20 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_222081", "222081042", "story_v_out_222081.awb")

						arg_173_1:RecordAudio("222081042", var_176_21)
						arg_173_1:RecordAudio("222081042", var_176_21)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_222081", "222081042", "story_v_out_222081.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_222081", "222081042", "story_v_out_222081.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_22 and arg_173_1.time_ < var_176_12 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play222081043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 222081043
		arg_177_1.duration_ = 8.5

		local var_177_0 = {
			ja = 8.5,
			ko = 5.566,
			zh = 5.566
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play222081044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1074ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1074ui_story == nil then
				arg_177_1.var_.characterEffect1074ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1074ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1074ui_story then
				arg_177_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_180_5 = 0
			local var_180_6 = 0.9

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_7 = arg_177_1:FormatText(StoryNameCfg[410].name)

				arg_177_1.leftNameTxt_.text = var_180_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(222081043)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 35
				local var_180_11 = utf8.len(var_180_9)
				local var_180_12 = var_180_10 <= 0 and var_180_6 or var_180_6 * (var_180_11 / var_180_10)

				if var_180_12 > 0 and var_180_6 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12

					if var_180_12 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081043", "story_v_out_222081.awb") ~= 0 then
					local var_180_13 = manager.audio:GetVoiceLength("story_v_out_222081", "222081043", "story_v_out_222081.awb") / 1000

					if var_180_13 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_5
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_222081", "222081043", "story_v_out_222081.awb")

						arg_177_1:RecordAudio("222081043", var_180_14)
						arg_177_1:RecordAudio("222081043", var_180_14)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_222081", "222081043", "story_v_out_222081.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_222081", "222081043", "story_v_out_222081.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_15 and arg_177_1.time_ < var_180_5 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play222081044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 222081044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play222081045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1074ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1074ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1074ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1074ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1074ui_story == nil then
				arg_181_1.var_.characterEffect1074ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1074ui_story and not isNil(var_184_9) then
					local var_184_13 = Mathf.Lerp(0, 0.5, var_184_12)

					arg_181_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1074ui_story.fillRatio = var_184_13
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1074ui_story then
				local var_184_14 = 0.5

				arg_181_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1074ui_story.fillRatio = var_184_14
			end

			local var_184_15 = arg_181_1.actors_["1070ui_story"].transform
			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.var_.moveOldPos1070ui_story = var_184_15.localPosition
			end

			local var_184_17 = 0.001

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 then
				local var_184_18 = (arg_181_1.time_ - var_184_16) / var_184_17
				local var_184_19 = Vector3.New(0, 100, 0)

				var_184_15.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1070ui_story, var_184_19, var_184_18)

				local var_184_20 = manager.ui.mainCamera.transform.position - var_184_15.position

				var_184_15.forward = Vector3.New(var_184_20.x, var_184_20.y, var_184_20.z)

				local var_184_21 = var_184_15.localEulerAngles

				var_184_21.z = 0
				var_184_21.x = 0
				var_184_15.localEulerAngles = var_184_21
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 then
				var_184_15.localPosition = Vector3.New(0, 100, 0)

				local var_184_22 = manager.ui.mainCamera.transform.position - var_184_15.position

				var_184_15.forward = Vector3.New(var_184_22.x, var_184_22.y, var_184_22.z)

				local var_184_23 = var_184_15.localEulerAngles

				var_184_23.z = 0
				var_184_23.x = 0
				var_184_15.localEulerAngles = var_184_23
			end

			local var_184_24 = arg_181_1.actors_["1070ui_story"]
			local var_184_25 = 0

			if var_184_25 < arg_181_1.time_ and arg_181_1.time_ <= var_184_25 + arg_184_0 and not isNil(var_184_24) and arg_181_1.var_.characterEffect1070ui_story == nil then
				arg_181_1.var_.characterEffect1070ui_story = var_184_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_26 = 0.200000002980232

			if var_184_25 <= arg_181_1.time_ and arg_181_1.time_ < var_184_25 + var_184_26 and not isNil(var_184_24) then
				local var_184_27 = (arg_181_1.time_ - var_184_25) / var_184_26

				if arg_181_1.var_.characterEffect1070ui_story and not isNil(var_184_24) then
					local var_184_28 = Mathf.Lerp(0, 0.5, var_184_27)

					arg_181_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1070ui_story.fillRatio = var_184_28
				end
			end

			if arg_181_1.time_ >= var_184_25 + var_184_26 and arg_181_1.time_ < var_184_25 + var_184_26 + arg_184_0 and not isNil(var_184_24) and arg_181_1.var_.characterEffect1070ui_story then
				local var_184_29 = 0.5

				arg_181_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1070ui_story.fillRatio = var_184_29
			end

			local var_184_30 = manager.ui.mainCamera.transform
			local var_184_31 = 0

			if var_184_31 < arg_181_1.time_ and arg_181_1.time_ <= var_184_31 + arg_184_0 then
				arg_181_1.var_.shakeOldPos = var_184_30.localPosition
			end

			local var_184_32 = 1

			if var_184_31 <= arg_181_1.time_ and arg_181_1.time_ < var_184_31 + var_184_32 then
				local var_184_33 = (arg_181_1.time_ - var_184_31) / 0.066
				local var_184_34, var_184_35 = math.modf(var_184_33)

				var_184_30.localPosition = Vector3.New(var_184_35 * 0.13, var_184_35 * 0.13, var_184_35 * 0.13) + arg_181_1.var_.shakeOldPos
			end

			if arg_181_1.time_ >= var_184_31 + var_184_32 and arg_181_1.time_ < var_184_31 + var_184_32 + arg_184_0 then
				var_184_30.localPosition = arg_181_1.var_.shakeOldPos
			end

			local var_184_36 = 0

			if var_184_36 < arg_181_1.time_ and arg_181_1.time_ <= var_184_36 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			local var_184_37 = 1

			if arg_181_1.time_ >= var_184_36 + var_184_37 and arg_181_1.time_ < var_184_36 + var_184_37 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end

			local var_184_38 = 0
			local var_184_39 = 1.675

			if var_184_38 < arg_181_1.time_ and arg_181_1.time_ <= var_184_38 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_40 = arg_181_1:GetWordFromCfg(222081044)
				local var_184_41 = arg_181_1:FormatText(var_184_40.content)

				arg_181_1.text_.text = var_184_41

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_42 = 67
				local var_184_43 = utf8.len(var_184_41)
				local var_184_44 = var_184_42 <= 0 and var_184_39 or var_184_39 * (var_184_43 / var_184_42)

				if var_184_44 > 0 and var_184_39 < var_184_44 then
					arg_181_1.talkMaxDuration = var_184_44

					if var_184_44 + var_184_38 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_44 + var_184_38
					end
				end

				arg_181_1.text_.text = var_184_41
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_45 = math.max(var_184_39, arg_181_1.talkMaxDuration)

			if var_184_38 <= arg_181_1.time_ and arg_181_1.time_ < var_184_38 + var_184_45 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_38) / var_184_45

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_38 + var_184_45 and arg_181_1.time_ < var_184_38 + var_184_45 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play222081045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 222081045
		arg_185_1.duration_ = 6.67

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play222081046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_2 = "play"
				local var_188_3 = "effect"

				arg_185_1:AudioAction(var_188_2, var_188_3, "se_story_222_00", "se_story_222_00_mosterenergy", "")
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_5 = 2

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_5 then
				local var_188_6 = (arg_185_1.time_ - var_188_4) / var_188_5
				local var_188_7 = Color.New(1, 1, 1)

				var_188_7.a = Mathf.Lerp(1, 0, var_188_6)
				arg_185_1.mask_.color = var_188_7
			end

			if arg_185_1.time_ >= var_188_4 + var_188_5 and arg_185_1.time_ < var_188_4 + var_188_5 + arg_188_0 then
				local var_188_8 = Color.New(1, 1, 1)
				local var_188_9 = 0

				arg_185_1.mask_.enabled = false
				var_188_8.a = var_188_9
				arg_185_1.mask_.color = var_188_8
			end

			local var_188_10 = manager.ui.mainCamera.transform
			local var_188_11 = 0

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1.var_.shakeOldPos = var_188_10.localPosition
			end

			local var_188_12 = 2

			if var_188_11 <= arg_185_1.time_ and arg_185_1.time_ < var_188_11 + var_188_12 then
				local var_188_13 = (arg_185_1.time_ - var_188_11) / 0.066
				local var_188_14, var_188_15 = math.modf(var_188_13)

				var_188_10.localPosition = Vector3.New(var_188_15 * 0.13, var_188_15 * 0.13, var_188_15 * 0.13) + arg_185_1.var_.shakeOldPos
			end

			if arg_185_1.time_ >= var_188_11 + var_188_12 and arg_185_1.time_ < var_188_11 + var_188_12 + arg_188_0 then
				var_188_10.localPosition = arg_185_1.var_.shakeOldPos
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_16 = 1.66666666666667
			local var_188_17 = 0.8

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_18 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_18:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_19 = arg_185_1:GetWordFromCfg(222081045)
				local var_188_20 = arg_185_1:FormatText(var_188_19.content)

				arg_185_1.text_.text = var_188_20

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_21 = 32
				local var_188_22 = utf8.len(var_188_20)
				local var_188_23 = var_188_21 <= 0 and var_188_17 or var_188_17 * (var_188_22 / var_188_21)

				if var_188_23 > 0 and var_188_17 < var_188_23 then
					arg_185_1.talkMaxDuration = var_188_23
					var_188_16 = var_188_16 + 0.3

					if var_188_23 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_16
					end
				end

				arg_185_1.text_.text = var_188_20
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_24 = var_188_16 + 0.3
			local var_188_25 = math.max(var_188_17, arg_185_1.talkMaxDuration)

			if var_188_24 <= arg_185_1.time_ and arg_185_1.time_ < var_188_24 + var_188_25 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_24) / var_188_25

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_24 + var_188_25 and arg_185_1.time_ < var_188_24 + var_188_25 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play222081046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 222081046
		arg_191_1.duration_ = 5.7

		local var_191_0 = {
			ja = 5.7,
			ko = 2.266,
			zh = 2.266
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play222081047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1070ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1070ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1070ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1070ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1070ui_story == nil then
				arg_191_1.var_.characterEffect1070ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect1070ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1070ui_story then
				arg_191_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_15 = 0
			local var_194_16 = 0.225

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[318].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(222081046)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 9
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081046", "story_v_out_222081.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_out_222081", "222081046", "story_v_out_222081.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_out_222081", "222081046", "story_v_out_222081.awb")

						arg_191_1:RecordAudio("222081046", var_194_24)
						arg_191_1:RecordAudio("222081046", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_222081", "222081046", "story_v_out_222081.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_222081", "222081046", "story_v_out_222081.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play222081047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 222081047
		arg_195_1.duration_ = 2

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play222081048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1074ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1074ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0.7, -1.055, -6.12)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1074ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["1074ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1074ui_story == nil then
				arg_195_1.var_.characterEffect1074ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect1074ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1074ui_story then
				arg_195_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_198_15 = arg_195_1.actors_["1070ui_story"]
			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.characterEffect1070ui_story == nil then
				arg_195_1.var_.characterEffect1070ui_story = var_198_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_17 = 0.200000002980232

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_17 and not isNil(var_198_15) then
				local var_198_18 = (arg_195_1.time_ - var_198_16) / var_198_17

				if arg_195_1.var_.characterEffect1070ui_story and not isNil(var_198_15) then
					local var_198_19 = Mathf.Lerp(0, 0.5, var_198_18)

					arg_195_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1070ui_story.fillRatio = var_198_19
				end
			end

			if arg_195_1.time_ >= var_198_16 + var_198_17 and arg_195_1.time_ < var_198_16 + var_198_17 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.characterEffect1070ui_story then
				local var_198_20 = 0.5

				arg_195_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1070ui_story.fillRatio = var_198_20
			end

			local var_198_21 = 0
			local var_198_22 = 0.1

			if var_198_21 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_23 = arg_195_1:FormatText(StoryNameCfg[410].name)

				arg_195_1.leftNameTxt_.text = var_198_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_24 = arg_195_1:GetWordFromCfg(222081047)
				local var_198_25 = arg_195_1:FormatText(var_198_24.content)

				arg_195_1.text_.text = var_198_25

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_26 = 4
				local var_198_27 = utf8.len(var_198_25)
				local var_198_28 = var_198_26 <= 0 and var_198_22 or var_198_22 * (var_198_27 / var_198_26)

				if var_198_28 > 0 and var_198_22 < var_198_28 then
					arg_195_1.talkMaxDuration = var_198_28

					if var_198_28 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_28 + var_198_21
					end
				end

				arg_195_1.text_.text = var_198_25
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081047", "story_v_out_222081.awb") ~= 0 then
					local var_198_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081047", "story_v_out_222081.awb") / 1000

					if var_198_29 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_29 + var_198_21
					end

					if var_198_24.prefab_name ~= "" and arg_195_1.actors_[var_198_24.prefab_name] ~= nil then
						local var_198_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_24.prefab_name].transform, "story_v_out_222081", "222081047", "story_v_out_222081.awb")

						arg_195_1:RecordAudio("222081047", var_198_30)
						arg_195_1:RecordAudio("222081047", var_198_30)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_222081", "222081047", "story_v_out_222081.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_222081", "222081047", "story_v_out_222081.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_31 = math.max(var_198_22, arg_195_1.talkMaxDuration)

			if var_198_21 <= arg_195_1.time_ and arg_195_1.time_ < var_198_21 + var_198_31 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_21) / var_198_31

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_21 + var_198_31 and arg_195_1.time_ < var_198_21 + var_198_31 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play222081048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 222081048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play222081049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1074ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1074ui_story = var_202_0.localPosition

				local var_202_2 = "1074ui_story"

				arg_199_1:ShowWeapon(arg_199_1.var_[var_202_2 .. "Animator"].transform, false)
			end

			local var_202_3 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_3 then
				local var_202_4 = (arg_199_1.time_ - var_202_1) / var_202_3
				local var_202_5 = Vector3.New(0, 100, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1074ui_story, var_202_5, var_202_4)

				local var_202_6 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_6.x, var_202_6.y, var_202_6.z)

				local var_202_7 = var_202_0.localEulerAngles

				var_202_7.z = 0
				var_202_7.x = 0
				var_202_0.localEulerAngles = var_202_7
			end

			if arg_199_1.time_ >= var_202_1 + var_202_3 and arg_199_1.time_ < var_202_1 + var_202_3 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, 100, 0)

				local var_202_8 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_8.x, var_202_8.y, var_202_8.z)

				local var_202_9 = var_202_0.localEulerAngles

				var_202_9.z = 0
				var_202_9.x = 0
				var_202_0.localEulerAngles = var_202_9
			end

			local var_202_10 = arg_199_1.actors_["1074ui_story"]
			local var_202_11 = 0

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 and not isNil(var_202_10) and arg_199_1.var_.characterEffect1074ui_story == nil then
				arg_199_1.var_.characterEffect1074ui_story = var_202_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_12 = 0.200000002980232

			if var_202_11 <= arg_199_1.time_ and arg_199_1.time_ < var_202_11 + var_202_12 and not isNil(var_202_10) then
				local var_202_13 = (arg_199_1.time_ - var_202_11) / var_202_12

				if arg_199_1.var_.characterEffect1074ui_story and not isNil(var_202_10) then
					local var_202_14 = Mathf.Lerp(0, 0.5, var_202_13)

					arg_199_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1074ui_story.fillRatio = var_202_14
				end
			end

			if arg_199_1.time_ >= var_202_11 + var_202_12 and arg_199_1.time_ < var_202_11 + var_202_12 + arg_202_0 and not isNil(var_202_10) and arg_199_1.var_.characterEffect1074ui_story then
				local var_202_15 = 0.5

				arg_199_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1074ui_story.fillRatio = var_202_15
			end

			local var_202_16 = arg_199_1.actors_["1070ui_story"].transform
			local var_202_17 = 0

			if var_202_17 < arg_199_1.time_ and arg_199_1.time_ <= var_202_17 + arg_202_0 then
				arg_199_1.var_.moveOldPos1070ui_story = var_202_16.localPosition
			end

			local var_202_18 = 0.001

			if var_202_17 <= arg_199_1.time_ and arg_199_1.time_ < var_202_17 + var_202_18 then
				local var_202_19 = (arg_199_1.time_ - var_202_17) / var_202_18
				local var_202_20 = Vector3.New(0, 100, 0)

				var_202_16.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1070ui_story, var_202_20, var_202_19)

				local var_202_21 = manager.ui.mainCamera.transform.position - var_202_16.position

				var_202_16.forward = Vector3.New(var_202_21.x, var_202_21.y, var_202_21.z)

				local var_202_22 = var_202_16.localEulerAngles

				var_202_22.z = 0
				var_202_22.x = 0
				var_202_16.localEulerAngles = var_202_22
			end

			if arg_199_1.time_ >= var_202_17 + var_202_18 and arg_199_1.time_ < var_202_17 + var_202_18 + arg_202_0 then
				var_202_16.localPosition = Vector3.New(0, 100, 0)

				local var_202_23 = manager.ui.mainCamera.transform.position - var_202_16.position

				var_202_16.forward = Vector3.New(var_202_23.x, var_202_23.y, var_202_23.z)

				local var_202_24 = var_202_16.localEulerAngles

				var_202_24.z = 0
				var_202_24.x = 0
				var_202_16.localEulerAngles = var_202_24
			end

			local var_202_25 = arg_199_1.actors_["1070ui_story"]
			local var_202_26 = 0

			if var_202_26 < arg_199_1.time_ and arg_199_1.time_ <= var_202_26 + arg_202_0 and not isNil(var_202_25) and arg_199_1.var_.characterEffect1070ui_story == nil then
				arg_199_1.var_.characterEffect1070ui_story = var_202_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_27 = 0.200000002980232

			if var_202_26 <= arg_199_1.time_ and arg_199_1.time_ < var_202_26 + var_202_27 and not isNil(var_202_25) then
				local var_202_28 = (arg_199_1.time_ - var_202_26) / var_202_27

				if arg_199_1.var_.characterEffect1070ui_story and not isNil(var_202_25) then
					local var_202_29 = Mathf.Lerp(0, 0.5, var_202_28)

					arg_199_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1070ui_story.fillRatio = var_202_29
				end
			end

			if arg_199_1.time_ >= var_202_26 + var_202_27 and arg_199_1.time_ < var_202_26 + var_202_27 + arg_202_0 and not isNil(var_202_25) and arg_199_1.var_.characterEffect1070ui_story then
				local var_202_30 = 0.5

				arg_199_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1070ui_story.fillRatio = var_202_30
			end

			local var_202_31 = 0
			local var_202_32 = 0.775

			if var_202_31 < arg_199_1.time_ and arg_199_1.time_ <= var_202_31 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_33 = arg_199_1:GetWordFromCfg(222081048)
				local var_202_34 = arg_199_1:FormatText(var_202_33.content)

				arg_199_1.text_.text = var_202_34

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_35 = 31
				local var_202_36 = utf8.len(var_202_34)
				local var_202_37 = var_202_35 <= 0 and var_202_32 or var_202_32 * (var_202_36 / var_202_35)

				if var_202_37 > 0 and var_202_32 < var_202_37 then
					arg_199_1.talkMaxDuration = var_202_37

					if var_202_37 + var_202_31 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_37 + var_202_31
					end
				end

				arg_199_1.text_.text = var_202_34
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_38 = math.max(var_202_32, arg_199_1.talkMaxDuration)

			if var_202_31 <= arg_199_1.time_ and arg_199_1.time_ < var_202_31 + var_202_38 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_31) / var_202_38

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_31 + var_202_38 and arg_199_1.time_ < var_202_31 + var_202_38 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play222081049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 222081049
		arg_203_1.duration_ = 6.8

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play222081050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.1

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				local var_206_2 = "stop"
				local var_206_3 = "effect"

				arg_203_1:AudioAction(var_206_2, var_206_3, "se_story_222_00", "se_story_222_00_quarry", "")
			end

			local var_206_4 = 0
			local var_206_5 = 1

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				local var_206_6 = "play"
				local var_206_7 = "effect"

				arg_203_1:AudioAction(var_206_6, var_206_7, "se_story_222_00", "se_story_222_00_enchantment_start", "")
			end

			local var_206_8 = 0

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_9 = 2

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_9 then
				local var_206_10 = (arg_203_1.time_ - var_206_8) / var_206_9
				local var_206_11 = Color.New(1, 1, 1)

				var_206_11.a = Mathf.Lerp(1, 0, var_206_10)
				arg_203_1.mask_.color = var_206_11
			end

			if arg_203_1.time_ >= var_206_8 + var_206_9 and arg_203_1.time_ < var_206_8 + var_206_9 + arg_206_0 then
				local var_206_12 = Color.New(1, 1, 1)
				local var_206_13 = 0

				arg_203_1.mask_.enabled = false
				var_206_12.a = var_206_13
				arg_203_1.mask_.color = var_206_12
			end

			local var_206_14 = "ST52"

			if arg_203_1.bgs_[var_206_14] == nil then
				local var_206_15 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_14)
				var_206_15.name = var_206_14
				var_206_15.transform.parent = arg_203_1.stage_.transform
				var_206_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_14] = var_206_15
			end

			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				local var_206_17 = manager.ui.mainCamera.transform.localPosition
				local var_206_18 = Vector3.New(0, 0, 10) + Vector3.New(var_206_17.x, var_206_17.y, 0)
				local var_206_19 = arg_203_1.bgs_.ST52

				var_206_19.transform.localPosition = var_206_18
				var_206_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_20 = var_206_19:GetComponent("SpriteRenderer")

				if var_206_20 and var_206_20.sprite then
					local var_206_21 = (var_206_19.transform.localPosition - var_206_17).z
					local var_206_22 = manager.ui.mainCameraCom_
					local var_206_23 = 2 * var_206_21 * Mathf.Tan(var_206_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_24 = var_206_23 * var_206_22.aspect
					local var_206_25 = var_206_20.sprite.bounds.size.x
					local var_206_26 = var_206_20.sprite.bounds.size.y
					local var_206_27 = var_206_24 / var_206_25
					local var_206_28 = var_206_23 / var_206_26
					local var_206_29 = var_206_28 < var_206_27 and var_206_27 or var_206_28

					var_206_19.transform.localScale = Vector3.New(var_206_29, var_206_29, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "ST52" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_30 = arg_203_1.bgs_.ST52.transform
			local var_206_31 = 0

			if var_206_31 < arg_203_1.time_ and arg_203_1.time_ <= var_206_31 + arg_206_0 then
				arg_203_1.var_.moveOldPosST52 = var_206_30.localPosition
			end

			local var_206_32 = 0.001

			if var_206_31 <= arg_203_1.time_ and arg_203_1.time_ < var_206_31 + var_206_32 then
				local var_206_33 = (arg_203_1.time_ - var_206_31) / var_206_32
				local var_206_34 = Vector3.New(0, 1, 9.5)

				var_206_30.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosST52, var_206_34, var_206_33)
			end

			if arg_203_1.time_ >= var_206_31 + var_206_32 and arg_203_1.time_ < var_206_31 + var_206_32 + arg_206_0 then
				var_206_30.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_206_35 = arg_203_1.bgs_.ST52.transform
			local var_206_36 = 0.0166666666666667

			if var_206_36 < arg_203_1.time_ and arg_203_1.time_ <= var_206_36 + arg_206_0 then
				arg_203_1.var_.moveOldPosST52 = var_206_35.localPosition
			end

			local var_206_37 = 4.083333

			if var_206_36 <= arg_203_1.time_ and arg_203_1.time_ < var_206_36 + var_206_37 then
				local var_206_38 = (arg_203_1.time_ - var_206_36) / var_206_37
				local var_206_39 = Vector3.New(0, 1, 10)

				var_206_35.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosST52, var_206_39, var_206_38)
			end

			if arg_203_1.time_ >= var_206_36 + var_206_37 and arg_203_1.time_ < var_206_36 + var_206_37 + arg_206_0 then
				var_206_35.localPosition = Vector3.New(0, 1, 10)
			end

			local var_206_40 = 2

			if var_206_40 < arg_203_1.time_ and arg_203_1.time_ <= var_206_40 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_41 = 2.09999966666667

			if arg_203_1.time_ >= var_206_40 + var_206_41 and arg_203_1.time_ < var_206_40 + var_206_41 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_42 = 1.8
			local var_206_43 = 0.875

			if var_206_42 < arg_203_1.time_ and arg_203_1.time_ <= var_206_42 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_44 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_44:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_45 = arg_203_1:GetWordFromCfg(222081049)
				local var_206_46 = arg_203_1:FormatText(var_206_45.content)

				arg_203_1.text_.text = var_206_46

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_47 = 35
				local var_206_48 = utf8.len(var_206_46)
				local var_206_49 = var_206_47 <= 0 and var_206_43 or var_206_43 * (var_206_48 / var_206_47)

				if var_206_49 > 0 and var_206_43 < var_206_49 then
					arg_203_1.talkMaxDuration = var_206_49
					var_206_42 = var_206_42 + 0.3

					if var_206_49 + var_206_42 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_49 + var_206_42
					end
				end

				arg_203_1.text_.text = var_206_46
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_50 = var_206_42 + 0.3
			local var_206_51 = math.max(var_206_43, arg_203_1.talkMaxDuration)

			if var_206_50 <= arg_203_1.time_ and arg_203_1.time_ < var_206_50 + var_206_51 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_50) / var_206_51

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_50 + var_206_51 and arg_203_1.time_ < var_206_50 + var_206_51 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST52",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST52",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.083333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play222081050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 222081050
		arg_209_1.duration_ = 3.47

		local var_209_0 = {
			ja = 2.9,
			ko = 3.433,
			zh = 3.466
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play222081051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1074ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1074ui_story = var_212_0.localPosition

				local var_212_2 = "1074ui_story"

				arg_209_1:ShowWeapon(arg_209_1.var_[var_212_2 .. "Animator"].transform, true)
			end

			local var_212_3 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_3 then
				local var_212_4 = (arg_209_1.time_ - var_212_1) / var_212_3
				local var_212_5 = Vector3.New(0, -1.055, -6.12)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1074ui_story, var_212_5, var_212_4)

				local var_212_6 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_6.x, var_212_6.y, var_212_6.z)

				local var_212_7 = var_212_0.localEulerAngles

				var_212_7.z = 0
				var_212_7.x = 0
				var_212_0.localEulerAngles = var_212_7
			end

			if arg_209_1.time_ >= var_212_1 + var_212_3 and arg_209_1.time_ < var_212_1 + var_212_3 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_212_8 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_8.x, var_212_8.y, var_212_8.z)

				local var_212_9 = var_212_0.localEulerAngles

				var_212_9.z = 0
				var_212_9.x = 0
				var_212_0.localEulerAngles = var_212_9
			end

			local var_212_10 = arg_209_1.actors_["1074ui_story"]
			local var_212_11 = 0

			if var_212_11 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 and not isNil(var_212_10) and arg_209_1.var_.characterEffect1074ui_story == nil then
				arg_209_1.var_.characterEffect1074ui_story = var_212_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_12 = 0.200000002980232

			if var_212_11 <= arg_209_1.time_ and arg_209_1.time_ < var_212_11 + var_212_12 and not isNil(var_212_10) then
				local var_212_13 = (arg_209_1.time_ - var_212_11) / var_212_12

				if arg_209_1.var_.characterEffect1074ui_story and not isNil(var_212_10) then
					arg_209_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_11 + var_212_12 and arg_209_1.time_ < var_212_11 + var_212_12 + arg_212_0 and not isNil(var_212_10) and arg_209_1.var_.characterEffect1074ui_story then
				arg_209_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action7_1")
			end

			local var_212_15 = 0

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_212_16 = 0
			local var_212_17 = 0.375

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_18 = arg_209_1:FormatText(StoryNameCfg[410].name)

				arg_209_1.leftNameTxt_.text = var_212_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_19 = arg_209_1:GetWordFromCfg(222081050)
				local var_212_20 = arg_209_1:FormatText(var_212_19.content)

				arg_209_1.text_.text = var_212_20

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_21 = 15
				local var_212_22 = utf8.len(var_212_20)
				local var_212_23 = var_212_21 <= 0 and var_212_17 or var_212_17 * (var_212_22 / var_212_21)

				if var_212_23 > 0 and var_212_17 < var_212_23 then
					arg_209_1.talkMaxDuration = var_212_23

					if var_212_23 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_16
					end
				end

				arg_209_1.text_.text = var_212_20
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081050", "story_v_out_222081.awb") ~= 0 then
					local var_212_24 = manager.audio:GetVoiceLength("story_v_out_222081", "222081050", "story_v_out_222081.awb") / 1000

					if var_212_24 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_24 + var_212_16
					end

					if var_212_19.prefab_name ~= "" and arg_209_1.actors_[var_212_19.prefab_name] ~= nil then
						local var_212_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_19.prefab_name].transform, "story_v_out_222081", "222081050", "story_v_out_222081.awb")

						arg_209_1:RecordAudio("222081050", var_212_25)
						arg_209_1:RecordAudio("222081050", var_212_25)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_222081", "222081050", "story_v_out_222081.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_222081", "222081050", "story_v_out_222081.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_26 = math.max(var_212_17, arg_209_1.talkMaxDuration)

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_26 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_16) / var_212_26

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_16 + var_212_26 and arg_209_1.time_ < var_212_16 + var_212_26 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play222081051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 222081051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play222081052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1074ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1074ui_story = var_216_0.localPosition

				local var_216_2 = "1074ui_story"

				arg_213_1:ShowWeapon(arg_213_1.var_[var_216_2 .. "Animator"].transform, false)
			end

			local var_216_3 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_3 then
				local var_216_4 = (arg_213_1.time_ - var_216_1) / var_216_3
				local var_216_5 = Vector3.New(0, 100, 0)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1074ui_story, var_216_5, var_216_4)

				local var_216_6 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_6.x, var_216_6.y, var_216_6.z)

				local var_216_7 = var_216_0.localEulerAngles

				var_216_7.z = 0
				var_216_7.x = 0
				var_216_0.localEulerAngles = var_216_7
			end

			if arg_213_1.time_ >= var_216_1 + var_216_3 and arg_213_1.time_ < var_216_1 + var_216_3 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, 100, 0)

				local var_216_8 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_8.x, var_216_8.y, var_216_8.z)

				local var_216_9 = var_216_0.localEulerAngles

				var_216_9.z = 0
				var_216_9.x = 0
				var_216_0.localEulerAngles = var_216_9
			end

			local var_216_10 = arg_213_1.actors_["1074ui_story"]
			local var_216_11 = 0

			if var_216_11 < arg_213_1.time_ and arg_213_1.time_ <= var_216_11 + arg_216_0 and not isNil(var_216_10) and arg_213_1.var_.characterEffect1074ui_story == nil then
				arg_213_1.var_.characterEffect1074ui_story = var_216_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_12 = 0.200000002980232

			if var_216_11 <= arg_213_1.time_ and arg_213_1.time_ < var_216_11 + var_216_12 and not isNil(var_216_10) then
				local var_216_13 = (arg_213_1.time_ - var_216_11) / var_216_12

				if arg_213_1.var_.characterEffect1074ui_story and not isNil(var_216_10) then
					local var_216_14 = Mathf.Lerp(0, 0.5, var_216_13)

					arg_213_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1074ui_story.fillRatio = var_216_14
				end
			end

			if arg_213_1.time_ >= var_216_11 + var_216_12 and arg_213_1.time_ < var_216_11 + var_216_12 + arg_216_0 and not isNil(var_216_10) and arg_213_1.var_.characterEffect1074ui_story then
				local var_216_15 = 0.5

				arg_213_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1074ui_story.fillRatio = var_216_15
			end

			local var_216_16 = 0
			local var_216_17 = 1.15

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(222081051)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 46
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_17 or var_216_17 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_17 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_16 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_16
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_23 = math.max(var_216_17, arg_213_1.talkMaxDuration)

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_23 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_16) / var_216_23

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_16 + var_216_23 and arg_213_1.time_ < var_216_16 + var_216_23 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play222081052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 222081052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play222081053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.775

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(222081052)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 31
				local var_220_5 = utf8.len(var_220_3)
				local var_220_6 = var_220_4 <= 0 and var_220_1 or var_220_1 * (var_220_5 / var_220_4)

				if var_220_6 > 0 and var_220_1 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_7 and arg_217_1.time_ < var_220_0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play222081053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 222081053
		arg_221_1.duration_ = 6.97

		local var_221_0 = {
			ja = 5.866,
			ko = 6.966,
			zh = 6.966
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play222081054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = "1071ui_story"

			if arg_221_1.actors_[var_224_0] == nil then
				local var_224_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_224_1) then
					local var_224_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_221_1.stage_.transform)

					var_224_2.name = var_224_0
					var_224_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_221_1.actors_[var_224_0] = var_224_2

					local var_224_3 = var_224_2:GetComponentInChildren(typeof(CharacterEffect))

					var_224_3.enabled = true

					local var_224_4 = GameObjectTools.GetOrAddComponent(var_224_2, typeof(DynamicBoneHelper))

					if var_224_4 then
						var_224_4:EnableDynamicBone(false)
					end

					arg_221_1:ShowWeapon(var_224_3.transform, false)

					arg_221_1.var_[var_224_0 .. "Animator"] = var_224_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_221_1.var_[var_224_0 .. "Animator"].applyRootMotion = true
					arg_221_1.var_[var_224_0 .. "LipSync"] = var_224_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_224_5 = arg_221_1.actors_["1071ui_story"].transform
			local var_224_6 = 0

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.var_.moveOldPos1071ui_story = var_224_5.localPosition
			end

			local var_224_7 = 0.001

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_7 then
				local var_224_8 = (arg_221_1.time_ - var_224_6) / var_224_7
				local var_224_9 = Vector3.New(-0.7, -1.05, -6.2)

				var_224_5.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1071ui_story, var_224_9, var_224_8)

				local var_224_10 = manager.ui.mainCamera.transform.position - var_224_5.position

				var_224_5.forward = Vector3.New(var_224_10.x, var_224_10.y, var_224_10.z)

				local var_224_11 = var_224_5.localEulerAngles

				var_224_11.z = 0
				var_224_11.x = 0
				var_224_5.localEulerAngles = var_224_11
			end

			if arg_221_1.time_ >= var_224_6 + var_224_7 and arg_221_1.time_ < var_224_6 + var_224_7 + arg_224_0 then
				var_224_5.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_224_12 = manager.ui.mainCamera.transform.position - var_224_5.position

				var_224_5.forward = Vector3.New(var_224_12.x, var_224_12.y, var_224_12.z)

				local var_224_13 = var_224_5.localEulerAngles

				var_224_13.z = 0
				var_224_13.x = 0
				var_224_5.localEulerAngles = var_224_13
			end

			local var_224_14 = arg_221_1.actors_["1071ui_story"]
			local var_224_15 = 0

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 and not isNil(var_224_14) and arg_221_1.var_.characterEffect1071ui_story == nil then
				arg_221_1.var_.characterEffect1071ui_story = var_224_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_16 = 0.200000002980232

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_16 and not isNil(var_224_14) then
				local var_224_17 = (arg_221_1.time_ - var_224_15) / var_224_16

				if arg_221_1.var_.characterEffect1071ui_story and not isNil(var_224_14) then
					arg_221_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_15 + var_224_16 and arg_221_1.time_ < var_224_15 + var_224_16 + arg_224_0 and not isNil(var_224_14) and arg_221_1.var_.characterEffect1071ui_story then
				arg_221_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_224_18 = 0

			if var_224_18 < arg_221_1.time_ and arg_221_1.time_ <= var_224_18 + arg_224_0 then
				arg_221_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_224_19 = 0
			local var_224_20 = 0.825

			if var_224_19 < arg_221_1.time_ and arg_221_1.time_ <= var_224_19 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_21 = arg_221_1:FormatText(StoryNameCfg[384].name)

				arg_221_1.leftNameTxt_.text = var_224_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_22 = arg_221_1:GetWordFromCfg(222081053)
				local var_224_23 = arg_221_1:FormatText(var_224_22.content)

				arg_221_1.text_.text = var_224_23

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_24 = 33
				local var_224_25 = utf8.len(var_224_23)
				local var_224_26 = var_224_24 <= 0 and var_224_20 or var_224_20 * (var_224_25 / var_224_24)

				if var_224_26 > 0 and var_224_20 < var_224_26 then
					arg_221_1.talkMaxDuration = var_224_26

					if var_224_26 + var_224_19 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_26 + var_224_19
					end
				end

				arg_221_1.text_.text = var_224_23
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081053", "story_v_out_222081.awb") ~= 0 then
					local var_224_27 = manager.audio:GetVoiceLength("story_v_out_222081", "222081053", "story_v_out_222081.awb") / 1000

					if var_224_27 + var_224_19 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_27 + var_224_19
					end

					if var_224_22.prefab_name ~= "" and arg_221_1.actors_[var_224_22.prefab_name] ~= nil then
						local var_224_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_22.prefab_name].transform, "story_v_out_222081", "222081053", "story_v_out_222081.awb")

						arg_221_1:RecordAudio("222081053", var_224_28)
						arg_221_1:RecordAudio("222081053", var_224_28)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_222081", "222081053", "story_v_out_222081.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_222081", "222081053", "story_v_out_222081.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_29 = math.max(var_224_20, arg_221_1.talkMaxDuration)

			if var_224_19 <= arg_221_1.time_ and arg_221_1.time_ < var_224_19 + var_224_29 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_19) / var_224_29

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_19 + var_224_29 and arg_221_1.time_ < var_224_19 + var_224_29 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play222081054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 222081054
		arg_225_1.duration_ = 8.5

		local var_225_0 = {
			ja = 8.5,
			ko = 6.033,
			zh = 6.033
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play222081055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10057ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10057ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0.7, -1.13, -5.72)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10057ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0.7, -1.13, -5.72)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["10057ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect10057ui_story == nil then
				arg_225_1.var_.characterEffect10057ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect10057ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect10057ui_story then
				arg_225_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_228_13 = 0

			if var_228_13 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_228_15 = arg_225_1.actors_["1071ui_story"]
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.characterEffect1071ui_story == nil then
				arg_225_1.var_.characterEffect1071ui_story = var_228_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_17 = 0.200000002980232

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 and not isNil(var_228_15) then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17

				if arg_225_1.var_.characterEffect1071ui_story and not isNil(var_228_15) then
					local var_228_19 = Mathf.Lerp(0, 0.5, var_228_18)

					arg_225_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1071ui_story.fillRatio = var_228_19
				end
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.characterEffect1071ui_story then
				local var_228_20 = 0.5

				arg_225_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1071ui_story.fillRatio = var_228_20
			end

			local var_228_21 = 0
			local var_228_22 = 0.65

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_23 = arg_225_1:FormatText(StoryNameCfg[464].name)

				arg_225_1.leftNameTxt_.text = var_228_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_24 = arg_225_1:GetWordFromCfg(222081054)
				local var_228_25 = arg_225_1:FormatText(var_228_24.content)

				arg_225_1.text_.text = var_228_25

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_26 = 26
				local var_228_27 = utf8.len(var_228_25)
				local var_228_28 = var_228_26 <= 0 and var_228_22 or var_228_22 * (var_228_27 / var_228_26)

				if var_228_28 > 0 and var_228_22 < var_228_28 then
					arg_225_1.talkMaxDuration = var_228_28

					if var_228_28 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_28 + var_228_21
					end
				end

				arg_225_1.text_.text = var_228_25
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081054", "story_v_out_222081.awb") ~= 0 then
					local var_228_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081054", "story_v_out_222081.awb") / 1000

					if var_228_29 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_29 + var_228_21
					end

					if var_228_24.prefab_name ~= "" and arg_225_1.actors_[var_228_24.prefab_name] ~= nil then
						local var_228_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_24.prefab_name].transform, "story_v_out_222081", "222081054", "story_v_out_222081.awb")

						arg_225_1:RecordAudio("222081054", var_228_30)
						arg_225_1:RecordAudio("222081054", var_228_30)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_222081", "222081054", "story_v_out_222081.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_222081", "222081054", "story_v_out_222081.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_31 = math.max(var_228_22, arg_225_1.talkMaxDuration)

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_31 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_21) / var_228_31

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_21 + var_228_31 and arg_225_1.time_ < var_228_21 + var_228_31 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play222081055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 222081055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play222081056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10057ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10057ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, 100, 0)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10057ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, 100, 0)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["10057ui_story"]
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect10057ui_story == nil then
				arg_229_1.var_.characterEffect10057ui_story = var_232_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 and not isNil(var_232_9) then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11

				if arg_229_1.var_.characterEffect10057ui_story and not isNil(var_232_9) then
					local var_232_13 = Mathf.Lerp(0, 0.5, var_232_12)

					arg_229_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10057ui_story.fillRatio = var_232_13
				end
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect10057ui_story then
				local var_232_14 = 0.5

				arg_229_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10057ui_story.fillRatio = var_232_14
			end

			local var_232_15 = arg_229_1.actors_["1071ui_story"].transform
			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.var_.moveOldPos1071ui_story = var_232_15.localPosition
			end

			local var_232_17 = 0.001

			if var_232_16 <= arg_229_1.time_ and arg_229_1.time_ < var_232_16 + var_232_17 then
				local var_232_18 = (arg_229_1.time_ - var_232_16) / var_232_17
				local var_232_19 = Vector3.New(0, 100, 0)

				var_232_15.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1071ui_story, var_232_19, var_232_18)

				local var_232_20 = manager.ui.mainCamera.transform.position - var_232_15.position

				var_232_15.forward = Vector3.New(var_232_20.x, var_232_20.y, var_232_20.z)

				local var_232_21 = var_232_15.localEulerAngles

				var_232_21.z = 0
				var_232_21.x = 0
				var_232_15.localEulerAngles = var_232_21
			end

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 then
				var_232_15.localPosition = Vector3.New(0, 100, 0)

				local var_232_22 = manager.ui.mainCamera.transform.position - var_232_15.position

				var_232_15.forward = Vector3.New(var_232_22.x, var_232_22.y, var_232_22.z)

				local var_232_23 = var_232_15.localEulerAngles

				var_232_23.z = 0
				var_232_23.x = 0
				var_232_15.localEulerAngles = var_232_23
			end

			local var_232_24 = arg_229_1.actors_["1071ui_story"]
			local var_232_25 = 0

			if var_232_25 < arg_229_1.time_ and arg_229_1.time_ <= var_232_25 + arg_232_0 and not isNil(var_232_24) and arg_229_1.var_.characterEffect1071ui_story == nil then
				arg_229_1.var_.characterEffect1071ui_story = var_232_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_26 = 0.200000002980232

			if var_232_25 <= arg_229_1.time_ and arg_229_1.time_ < var_232_25 + var_232_26 and not isNil(var_232_24) then
				local var_232_27 = (arg_229_1.time_ - var_232_25) / var_232_26

				if arg_229_1.var_.characterEffect1071ui_story and not isNil(var_232_24) then
					local var_232_28 = Mathf.Lerp(0, 0.5, var_232_27)

					arg_229_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1071ui_story.fillRatio = var_232_28
				end
			end

			if arg_229_1.time_ >= var_232_25 + var_232_26 and arg_229_1.time_ < var_232_25 + var_232_26 + arg_232_0 and not isNil(var_232_24) and arg_229_1.var_.characterEffect1071ui_story then
				local var_232_29 = 0.5

				arg_229_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1071ui_story.fillRatio = var_232_29
			end

			local var_232_30 = 0
			local var_232_31 = 1.225

			if var_232_30 < arg_229_1.time_ and arg_229_1.time_ <= var_232_30 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_32 = arg_229_1:GetWordFromCfg(222081055)
				local var_232_33 = arg_229_1:FormatText(var_232_32.content)

				arg_229_1.text_.text = var_232_33

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_34 = 49
				local var_232_35 = utf8.len(var_232_33)
				local var_232_36 = var_232_34 <= 0 and var_232_31 or var_232_31 * (var_232_35 / var_232_34)

				if var_232_36 > 0 and var_232_31 < var_232_36 then
					arg_229_1.talkMaxDuration = var_232_36

					if var_232_36 + var_232_30 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_36 + var_232_30
					end
				end

				arg_229_1.text_.text = var_232_33
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_37 = math.max(var_232_31, arg_229_1.talkMaxDuration)

			if var_232_30 <= arg_229_1.time_ and arg_229_1.time_ < var_232_30 + var_232_37 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_30) / var_232_37

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_30 + var_232_37 and arg_229_1.time_ < var_232_30 + var_232_37 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play222081056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 222081056
		arg_233_1.duration_ = 3.47

		local var_233_0 = {
			ja = 3.466,
			ko = 2.633,
			zh = 2.633
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play222081057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = manager.ui.mainCamera.transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.shakeOldPos = var_236_0.localPosition
			end

			local var_236_2 = 0.6

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / 0.066
				local var_236_4, var_236_5 = math.modf(var_236_3)

				var_236_0.localPosition = Vector3.New(var_236_5 * 0.13, var_236_5 * 0.13, var_236_5 * 0.13) + arg_233_1.var_.shakeOldPos
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = arg_233_1.var_.shakeOldPos
			end

			local var_236_6 = 0

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			local var_236_7 = 0.6

			if arg_233_1.time_ >= var_236_6 + var_236_7 and arg_233_1.time_ < var_236_6 + var_236_7 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_8 = 0
			local var_236_9 = 0.3

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_10 = arg_233_1:FormatText(StoryNameCfg[410].name)

				arg_233_1.leftNameTxt_.text = var_236_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_11 = arg_233_1:GetWordFromCfg(222081056)
				local var_236_12 = arg_233_1:FormatText(var_236_11.content)

				arg_233_1.text_.text = var_236_12

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 12
				local var_236_14 = utf8.len(var_236_12)
				local var_236_15 = var_236_13 <= 0 and var_236_9 or var_236_9 * (var_236_14 / var_236_13)

				if var_236_15 > 0 and var_236_9 < var_236_15 then
					arg_233_1.talkMaxDuration = var_236_15

					if var_236_15 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_12
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081056", "story_v_out_222081.awb") ~= 0 then
					local var_236_16 = manager.audio:GetVoiceLength("story_v_out_222081", "222081056", "story_v_out_222081.awb") / 1000

					if var_236_16 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_8
					end

					if var_236_11.prefab_name ~= "" and arg_233_1.actors_[var_236_11.prefab_name] ~= nil then
						local var_236_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_11.prefab_name].transform, "story_v_out_222081", "222081056", "story_v_out_222081.awb")

						arg_233_1:RecordAudio("222081056", var_236_17)
						arg_233_1:RecordAudio("222081056", var_236_17)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_222081", "222081056", "story_v_out_222081.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_222081", "222081056", "story_v_out_222081.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_18 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_18 and arg_233_1.time_ < var_236_8 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play222081057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 222081057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play222081058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 1

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				local var_240_2 = "play"
				local var_240_3 = "effect"

				arg_237_1:AudioAction(var_240_2, var_240_3, "se_story_121_04", "se_story_121_04_engineclose_loop", "")
			end

			local var_240_4 = 0
			local var_240_5 = 0.95

			if var_240_4 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(222081057)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_8 = 38
				local var_240_9 = utf8.len(var_240_7)
				local var_240_10 = var_240_8 <= 0 and var_240_5 or var_240_5 * (var_240_9 / var_240_8)

				if var_240_10 > 0 and var_240_5 < var_240_10 then
					arg_237_1.talkMaxDuration = var_240_10

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_11 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_11 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_11

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_11 and arg_237_1.time_ < var_240_4 + var_240_11 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play222081058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 222081058
		arg_241_1.duration_ = 8.77

		local var_241_0 = {
			ja = 8.766,
			ko = 5.933,
			zh = 5.9
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play222081059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1070ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1070ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, -0.95, -6.05)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1070ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1070ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1070ui_story == nil then
				arg_241_1.var_.characterEffect1070ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1070ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1070ui_story then
				arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_244_13 = 0

			if var_244_13 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_244_14 = 0

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_244_15 = 0
			local var_244_16 = 0.775

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[318].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_18 = arg_241_1:GetWordFromCfg(222081058)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 31
				local var_244_21 = utf8.len(var_244_19)
				local var_244_22 = var_244_20 <= 0 and var_244_16 or var_244_16 * (var_244_21 / var_244_20)

				if var_244_22 > 0 and var_244_16 < var_244_22 then
					arg_241_1.talkMaxDuration = var_244_22

					if var_244_22 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_15
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081058", "story_v_out_222081.awb") ~= 0 then
					local var_244_23 = manager.audio:GetVoiceLength("story_v_out_222081", "222081058", "story_v_out_222081.awb") / 1000

					if var_244_23 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_15
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_out_222081", "222081058", "story_v_out_222081.awb")

						arg_241_1:RecordAudio("222081058", var_244_24)
						arg_241_1:RecordAudio("222081058", var_244_24)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_222081", "222081058", "story_v_out_222081.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_222081", "222081058", "story_v_out_222081.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_25 = math.max(var_244_16, arg_241_1.talkMaxDuration)

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_25 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_15) / var_244_25

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_15 + var_244_25 and arg_241_1.time_ < var_244_15 + var_244_25 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play222081059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 222081059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play222081060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1070ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1070ui_story == nil then
				arg_245_1.var_.characterEffect1070ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1070ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1070ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1070ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1070ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 0.825

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:GetWordFromCfg(222081059)
				local var_248_9 = arg_245_1:FormatText(var_248_8.content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 33
				local var_248_11 = utf8.len(var_248_9)
				local var_248_12 = var_248_10 <= 0 and var_248_7 or var_248_7 * (var_248_11 / var_248_10)

				if var_248_12 > 0 and var_248_7 < var_248_12 then
					arg_245_1.talkMaxDuration = var_248_12

					if var_248_12 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_13 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_13 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_13

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_13 and arg_245_1.time_ < var_248_6 + var_248_13 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play222081060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 222081060
		arg_249_1.duration_ = 3.17

		local var_249_0 = {
			ja = 2.8,
			ko = 3.166,
			zh = 3.166
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play222081061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1070ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1070ui_story == nil then
				arg_249_1.var_.characterEffect1070ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1070ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1070ui_story then
				arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_252_4 = 0

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_6 = 0
			local var_252_7 = 0.25

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[318].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_9 = arg_249_1:GetWordFromCfg(222081060)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 10
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081060", "story_v_out_222081.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_222081", "222081060", "story_v_out_222081.awb") / 1000

					if var_252_14 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_6
					end

					if var_252_9.prefab_name ~= "" and arg_249_1.actors_[var_252_9.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_9.prefab_name].transform, "story_v_out_222081", "222081060", "story_v_out_222081.awb")

						arg_249_1:RecordAudio("222081060", var_252_15)
						arg_249_1:RecordAudio("222081060", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_222081", "222081060", "story_v_out_222081.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_222081", "222081060", "story_v_out_222081.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_16 and arg_249_1.time_ < var_252_6 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play222081061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 222081061
		arg_253_1.duration_ = 7.8

		local var_253_0 = {
			ja = 7.366,
			ko = 7.8,
			zh = 7.8
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play222081062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1070ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1070ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1070ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1070ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1070ui_story == nil then
				arg_253_1.var_.characterEffect1070ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect1070ui_story and not isNil(var_256_9) then
					local var_256_13 = Mathf.Lerp(0, 0.5, var_256_12)

					arg_253_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1070ui_story.fillRatio = var_256_13
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1070ui_story then
				local var_256_14 = 0.5

				arg_253_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1070ui_story.fillRatio = var_256_14
			end

			local var_256_15 = arg_253_1.actors_["1071ui_story"].transform
			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				arg_253_1.var_.moveOldPos1071ui_story = var_256_15.localPosition
			end

			local var_256_17 = 0.001

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_17 then
				local var_256_18 = (arg_253_1.time_ - var_256_16) / var_256_17
				local var_256_19 = Vector3.New(0.7, -1.05, -6.2)

				var_256_15.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1071ui_story, var_256_19, var_256_18)

				local var_256_20 = manager.ui.mainCamera.transform.position - var_256_15.position

				var_256_15.forward = Vector3.New(var_256_20.x, var_256_20.y, var_256_20.z)

				local var_256_21 = var_256_15.localEulerAngles

				var_256_21.z = 0
				var_256_21.x = 0
				var_256_15.localEulerAngles = var_256_21
			end

			if arg_253_1.time_ >= var_256_16 + var_256_17 and arg_253_1.time_ < var_256_16 + var_256_17 + arg_256_0 then
				var_256_15.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_256_22 = manager.ui.mainCamera.transform.position - var_256_15.position

				var_256_15.forward = Vector3.New(var_256_22.x, var_256_22.y, var_256_22.z)

				local var_256_23 = var_256_15.localEulerAngles

				var_256_23.z = 0
				var_256_23.x = 0
				var_256_15.localEulerAngles = var_256_23
			end

			local var_256_24 = arg_253_1.actors_["1071ui_story"]
			local var_256_25 = 0

			if var_256_25 < arg_253_1.time_ and arg_253_1.time_ <= var_256_25 + arg_256_0 and not isNil(var_256_24) and arg_253_1.var_.characterEffect1071ui_story == nil then
				arg_253_1.var_.characterEffect1071ui_story = var_256_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_26 = 0.200000002980232

			if var_256_25 <= arg_253_1.time_ and arg_253_1.time_ < var_256_25 + var_256_26 and not isNil(var_256_24) then
				local var_256_27 = (arg_253_1.time_ - var_256_25) / var_256_26

				if arg_253_1.var_.characterEffect1071ui_story and not isNil(var_256_24) then
					arg_253_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_25 + var_256_26 and arg_253_1.time_ < var_256_25 + var_256_26 + arg_256_0 and not isNil(var_256_24) and arg_253_1.var_.characterEffect1071ui_story then
				arg_253_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_256_28 = 0

			if var_256_28 < arg_253_1.time_ and arg_253_1.time_ <= var_256_28 + arg_256_0 then
				arg_253_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_256_29 = 0

			if var_256_29 < arg_253_1.time_ and arg_253_1.time_ <= var_256_29 + arg_256_0 then
				arg_253_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_30 = 0
			local var_256_31 = 0.875

			if var_256_30 < arg_253_1.time_ and arg_253_1.time_ <= var_256_30 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_32 = arg_253_1:FormatText(StoryNameCfg[384].name)

				arg_253_1.leftNameTxt_.text = var_256_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_33 = arg_253_1:GetWordFromCfg(222081061)
				local var_256_34 = arg_253_1:FormatText(var_256_33.content)

				arg_253_1.text_.text = var_256_34

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_35 = 35
				local var_256_36 = utf8.len(var_256_34)
				local var_256_37 = var_256_35 <= 0 and var_256_31 or var_256_31 * (var_256_36 / var_256_35)

				if var_256_37 > 0 and var_256_31 < var_256_37 then
					arg_253_1.talkMaxDuration = var_256_37

					if var_256_37 + var_256_30 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_37 + var_256_30
					end
				end

				arg_253_1.text_.text = var_256_34
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081061", "story_v_out_222081.awb") ~= 0 then
					local var_256_38 = manager.audio:GetVoiceLength("story_v_out_222081", "222081061", "story_v_out_222081.awb") / 1000

					if var_256_38 + var_256_30 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_38 + var_256_30
					end

					if var_256_33.prefab_name ~= "" and arg_253_1.actors_[var_256_33.prefab_name] ~= nil then
						local var_256_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_33.prefab_name].transform, "story_v_out_222081", "222081061", "story_v_out_222081.awb")

						arg_253_1:RecordAudio("222081061", var_256_39)
						arg_253_1:RecordAudio("222081061", var_256_39)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_222081", "222081061", "story_v_out_222081.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_222081", "222081061", "story_v_out_222081.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_40 = math.max(var_256_31, arg_253_1.talkMaxDuration)

			if var_256_30 <= arg_253_1.time_ and arg_253_1.time_ < var_256_30 + var_256_40 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_30) / var_256_40

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_30 + var_256_40 and arg_253_1.time_ < var_256_30 + var_256_40 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play222081062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 222081062
		arg_257_1.duration_ = 7.47

		local var_257_0 = {
			ja = 6.933,
			ko = 7.466,
			zh = 7.466
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play222081063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 1

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				local var_260_2 = "stop"
				local var_260_3 = "effect"

				arg_257_1:AudioAction(var_260_2, var_260_3, "se_story_121_04", "se_story_121_04_engineclose_loop", "")
			end

			local var_260_4 = 0
			local var_260_5 = 0.925

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_6 = arg_257_1:FormatText(StoryNameCfg[384].name)

				arg_257_1.leftNameTxt_.text = var_260_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:GetWordFromCfg(222081062)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 37
				local var_260_10 = utf8.len(var_260_8)
				local var_260_11 = var_260_9 <= 0 and var_260_5 or var_260_5 * (var_260_10 / var_260_9)

				if var_260_11 > 0 and var_260_5 < var_260_11 then
					arg_257_1.talkMaxDuration = var_260_11

					if var_260_11 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081062", "story_v_out_222081.awb") ~= 0 then
					local var_260_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081062", "story_v_out_222081.awb") / 1000

					if var_260_12 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_4
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_out_222081", "222081062", "story_v_out_222081.awb")

						arg_257_1:RecordAudio("222081062", var_260_13)
						arg_257_1:RecordAudio("222081062", var_260_13)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_222081", "222081062", "story_v_out_222081.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_222081", "222081062", "story_v_out_222081.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_14 and arg_257_1.time_ < var_260_4 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play222081063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 222081063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play222081064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1071ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1071ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, 100, 0)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1071ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, 100, 0)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1071ui_story"]
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1071ui_story == nil then
				arg_261_1.var_.characterEffect1071ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect1071ui_story and not isNil(var_264_9) then
					local var_264_13 = Mathf.Lerp(0, 0.5, var_264_12)

					arg_261_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1071ui_story.fillRatio = var_264_13
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1071ui_story then
				local var_264_14 = 0.5

				arg_261_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1071ui_story.fillRatio = var_264_14
			end

			local var_264_15 = arg_261_1.actors_["1070ui_story"].transform
			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1.var_.moveOldPos1070ui_story = var_264_15.localPosition
			end

			local var_264_17 = 0.001

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17
				local var_264_19 = Vector3.New(0, 100, 0)

				var_264_15.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1070ui_story, var_264_19, var_264_18)

				local var_264_20 = manager.ui.mainCamera.transform.position - var_264_15.position

				var_264_15.forward = Vector3.New(var_264_20.x, var_264_20.y, var_264_20.z)

				local var_264_21 = var_264_15.localEulerAngles

				var_264_21.z = 0
				var_264_21.x = 0
				var_264_15.localEulerAngles = var_264_21
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 then
				var_264_15.localPosition = Vector3.New(0, 100, 0)

				local var_264_22 = manager.ui.mainCamera.transform.position - var_264_15.position

				var_264_15.forward = Vector3.New(var_264_22.x, var_264_22.y, var_264_22.z)

				local var_264_23 = var_264_15.localEulerAngles

				var_264_23.z = 0
				var_264_23.x = 0
				var_264_15.localEulerAngles = var_264_23
			end

			local var_264_24 = arg_261_1.actors_["1070ui_story"]
			local var_264_25 = 0

			if var_264_25 < arg_261_1.time_ and arg_261_1.time_ <= var_264_25 + arg_264_0 and not isNil(var_264_24) and arg_261_1.var_.characterEffect1070ui_story == nil then
				arg_261_1.var_.characterEffect1070ui_story = var_264_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_26 = 0.200000002980232

			if var_264_25 <= arg_261_1.time_ and arg_261_1.time_ < var_264_25 + var_264_26 and not isNil(var_264_24) then
				local var_264_27 = (arg_261_1.time_ - var_264_25) / var_264_26

				if arg_261_1.var_.characterEffect1070ui_story and not isNil(var_264_24) then
					local var_264_28 = Mathf.Lerp(0, 0.5, var_264_27)

					arg_261_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1070ui_story.fillRatio = var_264_28
				end
			end

			if arg_261_1.time_ >= var_264_25 + var_264_26 and arg_261_1.time_ < var_264_25 + var_264_26 + arg_264_0 and not isNil(var_264_24) and arg_261_1.var_.characterEffect1070ui_story then
				local var_264_29 = 0.5

				arg_261_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1070ui_story.fillRatio = var_264_29
			end

			local var_264_30 = 0
			local var_264_31 = 1

			if var_264_30 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 then
				local var_264_32 = "play"
				local var_264_33 = "effect"

				arg_261_1:AudioAction(var_264_32, var_264_33, "se_story_222_00", "se_story_222_00_finger", "")
			end

			local var_264_34 = 0
			local var_264_35 = 1.425

			if var_264_34 < arg_261_1.time_ and arg_261_1.time_ <= var_264_34 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_36 = arg_261_1:GetWordFromCfg(222081063)
				local var_264_37 = arg_261_1:FormatText(var_264_36.content)

				arg_261_1.text_.text = var_264_37

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_38 = 57
				local var_264_39 = utf8.len(var_264_37)
				local var_264_40 = var_264_38 <= 0 and var_264_35 or var_264_35 * (var_264_39 / var_264_38)

				if var_264_40 > 0 and var_264_35 < var_264_40 then
					arg_261_1.talkMaxDuration = var_264_40

					if var_264_40 + var_264_34 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_40 + var_264_34
					end
				end

				arg_261_1.text_.text = var_264_37
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_41 = math.max(var_264_35, arg_261_1.talkMaxDuration)

			if var_264_34 <= arg_261_1.time_ and arg_261_1.time_ < var_264_34 + var_264_41 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_34) / var_264_41

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_34 + var_264_41 and arg_261_1.time_ < var_264_34 + var_264_41 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play222081064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 222081064
		arg_265_1.duration_ = 2.47

		local var_265_0 = {
			ja = 2.466,
			ko = 2.333,
			zh = 2.366
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play222081065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10057ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10057ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(-0.7, -1.13, -5.72)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10057ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(-0.7, -1.13, -5.72)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["10057ui_story"]
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect10057ui_story == nil then
				arg_265_1.var_.characterEffect10057ui_story = var_268_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_11 = 0.200000002980232

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_11 and not isNil(var_268_9) then
				local var_268_12 = (arg_265_1.time_ - var_268_10) / var_268_11

				if arg_265_1.var_.characterEffect10057ui_story and not isNil(var_268_9) then
					arg_265_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_10 + var_268_11 and arg_265_1.time_ < var_268_10 + var_268_11 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect10057ui_story then
				arg_265_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_268_13 = 0

			if var_268_13 < arg_265_1.time_ and arg_265_1.time_ <= var_268_13 + arg_268_0 then
				arg_265_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action6_1")
			end

			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_15 = 0
			local var_268_16 = 0.175

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_17 = arg_265_1:FormatText(StoryNameCfg[464].name)

				arg_265_1.leftNameTxt_.text = var_268_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_18 = arg_265_1:GetWordFromCfg(222081064)
				local var_268_19 = arg_265_1:FormatText(var_268_18.content)

				arg_265_1.text_.text = var_268_19

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_20 = 7
				local var_268_21 = utf8.len(var_268_19)
				local var_268_22 = var_268_20 <= 0 and var_268_16 or var_268_16 * (var_268_21 / var_268_20)

				if var_268_22 > 0 and var_268_16 < var_268_22 then
					arg_265_1.talkMaxDuration = var_268_22

					if var_268_22 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_22 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_19
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081064", "story_v_out_222081.awb") ~= 0 then
					local var_268_23 = manager.audio:GetVoiceLength("story_v_out_222081", "222081064", "story_v_out_222081.awb") / 1000

					if var_268_23 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_15
					end

					if var_268_18.prefab_name ~= "" and arg_265_1.actors_[var_268_18.prefab_name] ~= nil then
						local var_268_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_18.prefab_name].transform, "story_v_out_222081", "222081064", "story_v_out_222081.awb")

						arg_265_1:RecordAudio("222081064", var_268_24)
						arg_265_1:RecordAudio("222081064", var_268_24)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_222081", "222081064", "story_v_out_222081.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_222081", "222081064", "story_v_out_222081.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_25 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_25 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_25

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_25 and arg_265_1.time_ < var_268_15 + var_268_25 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play222081065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 222081065
		arg_269_1.duration_ = 3.53

		local var_269_0 = {
			ja = 3.533,
			ko = 2.433,
			zh = 2.433
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play222081066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10057ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect10057ui_story == nil then
				arg_269_1.var_.characterEffect10057ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect10057ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10057ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect10057ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10057ui_story.fillRatio = var_272_5
			end

			local var_272_6 = arg_269_1.actors_["1071ui_story"].transform
			local var_272_7 = 0

			if var_272_7 < arg_269_1.time_ and arg_269_1.time_ <= var_272_7 + arg_272_0 then
				arg_269_1.var_.moveOldPos1071ui_story = var_272_6.localPosition
			end

			local var_272_8 = 0.001

			if var_272_7 <= arg_269_1.time_ and arg_269_1.time_ < var_272_7 + var_272_8 then
				local var_272_9 = (arg_269_1.time_ - var_272_7) / var_272_8
				local var_272_10 = Vector3.New(0.7, -1.05, -6.2)

				var_272_6.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1071ui_story, var_272_10, var_272_9)

				local var_272_11 = manager.ui.mainCamera.transform.position - var_272_6.position

				var_272_6.forward = Vector3.New(var_272_11.x, var_272_11.y, var_272_11.z)

				local var_272_12 = var_272_6.localEulerAngles

				var_272_12.z = 0
				var_272_12.x = 0
				var_272_6.localEulerAngles = var_272_12
			end

			if arg_269_1.time_ >= var_272_7 + var_272_8 and arg_269_1.time_ < var_272_7 + var_272_8 + arg_272_0 then
				var_272_6.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_272_13 = manager.ui.mainCamera.transform.position - var_272_6.position

				var_272_6.forward = Vector3.New(var_272_13.x, var_272_13.y, var_272_13.z)

				local var_272_14 = var_272_6.localEulerAngles

				var_272_14.z = 0
				var_272_14.x = 0
				var_272_6.localEulerAngles = var_272_14
			end

			local var_272_15 = arg_269_1.actors_["1071ui_story"]
			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.characterEffect1071ui_story == nil then
				arg_269_1.var_.characterEffect1071ui_story = var_272_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_17 = 0.200000002980232

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 and not isNil(var_272_15) then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17

				if arg_269_1.var_.characterEffect1071ui_story and not isNil(var_272_15) then
					arg_269_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.characterEffect1071ui_story then
				arg_269_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_272_19 = 0

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 then
				arg_269_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_272_20 = 0

			if var_272_20 < arg_269_1.time_ and arg_269_1.time_ <= var_272_20 + arg_272_0 then
				arg_269_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_21 = 0
			local var_272_22 = 0.275

			if var_272_21 < arg_269_1.time_ and arg_269_1.time_ <= var_272_21 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_23 = arg_269_1:FormatText(StoryNameCfg[384].name)

				arg_269_1.leftNameTxt_.text = var_272_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_24 = arg_269_1:GetWordFromCfg(222081065)
				local var_272_25 = arg_269_1:FormatText(var_272_24.content)

				arg_269_1.text_.text = var_272_25

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_26 = 11
				local var_272_27 = utf8.len(var_272_25)
				local var_272_28 = var_272_26 <= 0 and var_272_22 or var_272_22 * (var_272_27 / var_272_26)

				if var_272_28 > 0 and var_272_22 < var_272_28 then
					arg_269_1.talkMaxDuration = var_272_28

					if var_272_28 + var_272_21 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_28 + var_272_21
					end
				end

				arg_269_1.text_.text = var_272_25
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081065", "story_v_out_222081.awb") ~= 0 then
					local var_272_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081065", "story_v_out_222081.awb") / 1000

					if var_272_29 + var_272_21 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_29 + var_272_21
					end

					if var_272_24.prefab_name ~= "" and arg_269_1.actors_[var_272_24.prefab_name] ~= nil then
						local var_272_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_24.prefab_name].transform, "story_v_out_222081", "222081065", "story_v_out_222081.awb")

						arg_269_1:RecordAudio("222081065", var_272_30)
						arg_269_1:RecordAudio("222081065", var_272_30)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_222081", "222081065", "story_v_out_222081.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_222081", "222081065", "story_v_out_222081.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_31 = math.max(var_272_22, arg_269_1.talkMaxDuration)

			if var_272_21 <= arg_269_1.time_ and arg_269_1.time_ < var_272_21 + var_272_31 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_21) / var_272_31

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_21 + var_272_31 and arg_269_1.time_ < var_272_21 + var_272_31 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play222081066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 222081066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play222081067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10057ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10057ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10057ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, 100, 0)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["10057ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect10057ui_story == nil then
				arg_273_1.var_.characterEffect10057ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect10057ui_story and not isNil(var_276_9) then
					local var_276_13 = Mathf.Lerp(0, 0.5, var_276_12)

					arg_273_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10057ui_story.fillRatio = var_276_13
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect10057ui_story then
				local var_276_14 = 0.5

				arg_273_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10057ui_story.fillRatio = var_276_14
			end

			local var_276_15 = arg_273_1.actors_["1071ui_story"].transform
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.var_.moveOldPos1071ui_story = var_276_15.localPosition
			end

			local var_276_17 = 0.001

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17
				local var_276_19 = Vector3.New(0, 100, 0)

				var_276_15.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1071ui_story, var_276_19, var_276_18)

				local var_276_20 = manager.ui.mainCamera.transform.position - var_276_15.position

				var_276_15.forward = Vector3.New(var_276_20.x, var_276_20.y, var_276_20.z)

				local var_276_21 = var_276_15.localEulerAngles

				var_276_21.z = 0
				var_276_21.x = 0
				var_276_15.localEulerAngles = var_276_21
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 then
				var_276_15.localPosition = Vector3.New(0, 100, 0)

				local var_276_22 = manager.ui.mainCamera.transform.position - var_276_15.position

				var_276_15.forward = Vector3.New(var_276_22.x, var_276_22.y, var_276_22.z)

				local var_276_23 = var_276_15.localEulerAngles

				var_276_23.z = 0
				var_276_23.x = 0
				var_276_15.localEulerAngles = var_276_23
			end

			local var_276_24 = arg_273_1.actors_["1071ui_story"]
			local var_276_25 = 0

			if var_276_25 < arg_273_1.time_ and arg_273_1.time_ <= var_276_25 + arg_276_0 and not isNil(var_276_24) and arg_273_1.var_.characterEffect1071ui_story == nil then
				arg_273_1.var_.characterEffect1071ui_story = var_276_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_26 = 0.200000002980232

			if var_276_25 <= arg_273_1.time_ and arg_273_1.time_ < var_276_25 + var_276_26 and not isNil(var_276_24) then
				local var_276_27 = (arg_273_1.time_ - var_276_25) / var_276_26

				if arg_273_1.var_.characterEffect1071ui_story and not isNil(var_276_24) then
					local var_276_28 = Mathf.Lerp(0, 0.5, var_276_27)

					arg_273_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1071ui_story.fillRatio = var_276_28
				end
			end

			if arg_273_1.time_ >= var_276_25 + var_276_26 and arg_273_1.time_ < var_276_25 + var_276_26 + arg_276_0 and not isNil(var_276_24) and arg_273_1.var_.characterEffect1071ui_story then
				local var_276_29 = 0.5

				arg_273_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1071ui_story.fillRatio = var_276_29
			end

			local var_276_30 = 0
			local var_276_31 = 1.625

			if var_276_30 < arg_273_1.time_ and arg_273_1.time_ <= var_276_30 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_32 = arg_273_1:GetWordFromCfg(222081066)
				local var_276_33 = arg_273_1:FormatText(var_276_32.content)

				arg_273_1.text_.text = var_276_33

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_34 = 65
				local var_276_35 = utf8.len(var_276_33)
				local var_276_36 = var_276_34 <= 0 and var_276_31 or var_276_31 * (var_276_35 / var_276_34)

				if var_276_36 > 0 and var_276_31 < var_276_36 then
					arg_273_1.talkMaxDuration = var_276_36

					if var_276_36 + var_276_30 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_36 + var_276_30
					end
				end

				arg_273_1.text_.text = var_276_33
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_37 = math.max(var_276_31, arg_273_1.talkMaxDuration)

			if var_276_30 <= arg_273_1.time_ and arg_273_1.time_ < var_276_30 + var_276_37 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_30) / var_276_37

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_30 + var_276_37 and arg_273_1.time_ < var_276_30 + var_276_37 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play222081067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 222081067
		arg_277_1.duration_ = 7.2

		local var_277_0 = {
			ja = 7.2,
			ko = 3.433,
			zh = 3.433
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play222081068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1070ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1070ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1070ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1070ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1070ui_story == nil then
				arg_277_1.var_.characterEffect1070ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect1070ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1070ui_story then
				arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_280_13 = 0

			if var_280_13 < arg_277_1.time_ and arg_277_1.time_ <= var_280_13 + arg_280_0 then
				arg_277_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_15 = 0
			local var_280_16 = 0.4

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[318].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(222081067)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 16
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081067", "story_v_out_222081.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_out_222081", "222081067", "story_v_out_222081.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_out_222081", "222081067", "story_v_out_222081.awb")

						arg_277_1:RecordAudio("222081067", var_280_24)
						arg_277_1:RecordAudio("222081067", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_222081", "222081067", "story_v_out_222081.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_222081", "222081067", "story_v_out_222081.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play222081068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 222081068
		arg_281_1.duration_ = 2.4

		local var_281_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play222081069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1074ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1074ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0.7, -1.055, -6.12)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1074ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1074ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1074ui_story == nil then
				arg_281_1.var_.characterEffect1074ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 and not isNil(var_284_9) then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect1074ui_story and not isNil(var_284_9) then
					arg_281_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1074ui_story then
				arg_281_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_284_13 = 0

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_284_15 = arg_281_1.actors_["1070ui_story"]
			local var_284_16 = 0

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.characterEffect1070ui_story == nil then
				arg_281_1.var_.characterEffect1070ui_story = var_284_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_17 = 0.200000002980232

			if var_284_16 <= arg_281_1.time_ and arg_281_1.time_ < var_284_16 + var_284_17 and not isNil(var_284_15) then
				local var_284_18 = (arg_281_1.time_ - var_284_16) / var_284_17

				if arg_281_1.var_.characterEffect1070ui_story and not isNil(var_284_15) then
					local var_284_19 = Mathf.Lerp(0, 0.5, var_284_18)

					arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1070ui_story.fillRatio = var_284_19
				end
			end

			if arg_281_1.time_ >= var_284_16 + var_284_17 and arg_281_1.time_ < var_284_16 + var_284_17 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.characterEffect1070ui_story then
				local var_284_20 = 0.5

				arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1070ui_story.fillRatio = var_284_20
			end

			local var_284_21 = 0
			local var_284_22 = 0.15

			if var_284_21 < arg_281_1.time_ and arg_281_1.time_ <= var_284_21 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_23 = arg_281_1:FormatText(StoryNameCfg[410].name)

				arg_281_1.leftNameTxt_.text = var_284_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_24 = arg_281_1:GetWordFromCfg(222081068)
				local var_284_25 = arg_281_1:FormatText(var_284_24.content)

				arg_281_1.text_.text = var_284_25

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_26 = 6
				local var_284_27 = utf8.len(var_284_25)
				local var_284_28 = var_284_26 <= 0 and var_284_22 or var_284_22 * (var_284_27 / var_284_26)

				if var_284_28 > 0 and var_284_22 < var_284_28 then
					arg_281_1.talkMaxDuration = var_284_28

					if var_284_28 + var_284_21 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_28 + var_284_21
					end
				end

				arg_281_1.text_.text = var_284_25
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081068", "story_v_out_222081.awb") ~= 0 then
					local var_284_29 = manager.audio:GetVoiceLength("story_v_out_222081", "222081068", "story_v_out_222081.awb") / 1000

					if var_284_29 + var_284_21 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_29 + var_284_21
					end

					if var_284_24.prefab_name ~= "" and arg_281_1.actors_[var_284_24.prefab_name] ~= nil then
						local var_284_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_24.prefab_name].transform, "story_v_out_222081", "222081068", "story_v_out_222081.awb")

						arg_281_1:RecordAudio("222081068", var_284_30)
						arg_281_1:RecordAudio("222081068", var_284_30)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_222081", "222081068", "story_v_out_222081.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_222081", "222081068", "story_v_out_222081.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_31 = math.max(var_284_22, arg_281_1.talkMaxDuration)

			if var_284_21 <= arg_281_1.time_ and arg_281_1.time_ < var_284_21 + var_284_31 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_21) / var_284_31

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_21 + var_284_31 and arg_281_1.time_ < var_284_21 + var_284_31 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play222081069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 222081069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
			arg_285_1.auto_ = false
		end

		function arg_285_1.playNext_(arg_287_0)
			arg_285_1.onStoryFinished_()
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1070ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1070ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(0, 100, 0)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1070ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, 100, 0)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1070ui_story"]
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1070ui_story == nil then
				arg_285_1.var_.characterEffect1070ui_story = var_288_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.200000002980232

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 and not isNil(var_288_9) then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11

				if arg_285_1.var_.characterEffect1070ui_story and not isNil(var_288_9) then
					local var_288_13 = Mathf.Lerp(0, 0.5, var_288_12)

					arg_285_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1070ui_story.fillRatio = var_288_13
				end
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1070ui_story then
				local var_288_14 = 0.5

				arg_285_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1070ui_story.fillRatio = var_288_14
			end

			local var_288_15 = arg_285_1.actors_["1074ui_story"].transform
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.var_.moveOldPos1074ui_story = var_288_15.localPosition
			end

			local var_288_17 = 0.001

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17
				local var_288_19 = Vector3.New(0, 100, 0)

				var_288_15.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1074ui_story, var_288_19, var_288_18)

				local var_288_20 = manager.ui.mainCamera.transform.position - var_288_15.position

				var_288_15.forward = Vector3.New(var_288_20.x, var_288_20.y, var_288_20.z)

				local var_288_21 = var_288_15.localEulerAngles

				var_288_21.z = 0
				var_288_21.x = 0
				var_288_15.localEulerAngles = var_288_21
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 then
				var_288_15.localPosition = Vector3.New(0, 100, 0)

				local var_288_22 = manager.ui.mainCamera.transform.position - var_288_15.position

				var_288_15.forward = Vector3.New(var_288_22.x, var_288_22.y, var_288_22.z)

				local var_288_23 = var_288_15.localEulerAngles

				var_288_23.z = 0
				var_288_23.x = 0
				var_288_15.localEulerAngles = var_288_23
			end

			local var_288_24 = arg_285_1.actors_["1074ui_story"]
			local var_288_25 = 0

			if var_288_25 < arg_285_1.time_ and arg_285_1.time_ <= var_288_25 + arg_288_0 and not isNil(var_288_24) and arg_285_1.var_.characterEffect1074ui_story == nil then
				arg_285_1.var_.characterEffect1074ui_story = var_288_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_26 = 0.200000002980232

			if var_288_25 <= arg_285_1.time_ and arg_285_1.time_ < var_288_25 + var_288_26 and not isNil(var_288_24) then
				local var_288_27 = (arg_285_1.time_ - var_288_25) / var_288_26

				if arg_285_1.var_.characterEffect1074ui_story and not isNil(var_288_24) then
					local var_288_28 = Mathf.Lerp(0, 0.5, var_288_27)

					arg_285_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1074ui_story.fillRatio = var_288_28
				end
			end

			if arg_285_1.time_ >= var_288_25 + var_288_26 and arg_285_1.time_ < var_288_25 + var_288_26 + arg_288_0 and not isNil(var_288_24) and arg_285_1.var_.characterEffect1074ui_story then
				local var_288_29 = 0.5

				arg_285_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1074ui_story.fillRatio = var_288_29
			end

			local var_288_30 = 0
			local var_288_31 = 0.65

			if var_288_30 < arg_285_1.time_ and arg_285_1.time_ <= var_288_30 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_32 = arg_285_1:GetWordFromCfg(222081069)
				local var_288_33 = arg_285_1:FormatText(var_288_32.content)

				arg_285_1.text_.text = var_288_33

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_34 = 26
				local var_288_35 = utf8.len(var_288_33)
				local var_288_36 = var_288_34 <= 0 and var_288_31 or var_288_31 * (var_288_35 / var_288_34)

				if var_288_36 > 0 and var_288_31 < var_288_36 then
					arg_285_1.talkMaxDuration = var_288_36

					if var_288_36 + var_288_30 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_36 + var_288_30
					end
				end

				arg_285_1.text_.text = var_288_33
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_37 = math.max(var_288_31, arg_285_1.talkMaxDuration)

			if var_288_30 <= arg_285_1.time_ and arg_285_1.time_ < var_288_30 + var_288_37 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_30) / var_288_37

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_30 + var_288_37 and arg_285_1.time_ < var_288_30 + var_288_37 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/YZ0103",
		"TextureConfig/Background/J03g",
		"TextureConfig/Background/ST52"
	},
	voices = {
		"story_v_out_222081.awb"
	}
}
