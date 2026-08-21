return {
	Play106091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106091001
		arg_1_1.duration_ = 8.1

		local var_1_0 = {
			ja = 6.8,
			ko = 4.8,
			zh = 7.766,
			en = 8.1
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
				arg_1_0:Play106091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C05b"

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
				local var_4_5 = arg_1_1.bgs_.C05b

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
					if iter_4_0 ~= "C05b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C05b
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC05b = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC05b = var_4_18
				end

				arg_1_1.var_.alphaOldValueC05b = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC05b, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC05b then
					local var_4_22 = arg_1_1.var_.alphaMatValueC05b.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC05b.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC05b then
				local var_4_23 = arg_1_1.var_.alphaMatValueC05b
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = manager.ui.mainCamera.transform
			local var_4_26 = 1.5

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_25.localPosition
			end

			local var_4_27 = 0.6

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / 0.066
				local var_4_29, var_4_30 = math.modf(var_4_28)

				var_4_25.localPosition = Vector3.New(var_4_30 * 0.13, var_4_30 * 0.13, var_4_30 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				var_4_25.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_31 = 1.825

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_32 = 0.5

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_31) / var_4_32
				local var_4_34 = Color.New(1, 1, 1)

				var_4_34.a = Mathf.Lerp(1, 0, var_4_33)
				arg_1_1.mask_.color = var_4_34
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				local var_4_35 = Color.New(1, 1, 1)
				local var_4_36 = 0

				arg_1_1.mask_.enabled = false
				var_4_35.a = var_4_36
				arg_1_1.mask_.color = var_4_35
			end

			local var_4_37 = 0
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "music"

				arg_1_1:AudioAction(var_4_39, var_4_40, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_41 = ""
				local var_4_42 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_42 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_42 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_42

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_42
						arg_1_1.bgmTxt2_.text = var_4_42
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

			local var_4_43 = 0

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_44 = 2

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_45 = 0
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_6", "se_story_6_slap01", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 2
			local var_4_50 = 0.325

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_52 = arg_1_1:FormatText(StoryNameCfg[88].name)

				arg_1_1.leftNameTxt_.text = var_4_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_53 = arg_1_1:GetWordFromCfg(106091001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 13
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_50 or var_4_50 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_50 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_49 = var_4_49 + 0.3

					if var_4_57 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091001", "story_v_out_106091.awb") ~= 0 then
					local var_4_58 = manager.audio:GetVoiceLength("story_v_out_106091", "106091001", "story_v_out_106091.awb") / 1000

					if var_4_58 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_49
					end

					if var_4_53.prefab_name ~= "" and arg_1_1.actors_[var_4_53.prefab_name] ~= nil then
						local var_4_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_53.prefab_name].transform, "story_v_out_106091", "106091001", "story_v_out_106091.awb")

						arg_1_1:RecordAudio("106091001", var_4_59)
						arg_1_1:RecordAudio("106091001", var_4_59)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_106091", "106091001", "story_v_out_106091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_106091", "106091001", "story_v_out_106091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_60 = var_4_49 + 0.3
			local var_4_61 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_60) / var_4_61

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106091002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play106091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "2026_tpose"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "2026_tpose")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "2026_tpose"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["2026_tpose"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2026_tpose == nil then
				arg_8_1.var_.characterEffect2026_tpose = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect2026_tpose and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect2026_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2026_tpose then
				arg_8_1.var_.characterEffect2026_tpose.fillFlat = false
			end

			local var_11_9 = 0
			local var_11_10 = 1

			if var_11_9 < arg_8_1.time_ and arg_8_1.time_ <= var_11_9 + arg_11_0 then
				local var_11_11 = "play"
				local var_11_12 = "effect"

				arg_8_1:AudioAction(var_11_11, var_11_12, "se_story_6", "se_story_6_monster", "")
			end

			local var_11_13 = 0
			local var_11_14 = 0.1

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_15 = arg_8_1:FormatText(StoryNameCfg[68].name)

				arg_8_1.leftNameTxt_.text = var_11_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2037")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_16 = arg_8_1:GetWordFromCfg(106091002)
				local var_11_17 = arg_8_1:FormatText(var_11_16.content)

				arg_8_1.text_.text = var_11_17

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_18 = 4
				local var_11_19 = utf8.len(var_11_17)
				local var_11_20 = var_11_18 <= 0 and var_11_14 or var_11_14 * (var_11_19 / var_11_18)

				if var_11_20 > 0 and var_11_14 < var_11_20 then
					arg_8_1.talkMaxDuration = var_11_20

					if var_11_20 + var_11_13 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_20 + var_11_13
					end
				end

				arg_8_1.text_.text = var_11_17
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_21 = math.max(var_11_14, arg_8_1.talkMaxDuration)

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_21 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_13) / var_11_21

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_13 + var_11_21 and arg_8_1.time_ < var_11_13 + var_11_21 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play106091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106091003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play106091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["2026_tpose"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect2026_tpose == nil then
				arg_12_1.var_.characterEffect2026_tpose = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect2026_tpose and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect2026_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2026_tpose.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect2026_tpose then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect2026_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2026_tpose.fillRatio = var_15_5
			end

			local var_15_6 = arg_12_1.actors_["2026_tpose"].transform
			local var_15_7 = 0

			if var_15_7 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				arg_12_1.var_.moveOldPos2026_tpose = var_15_6.localPosition

				local var_15_8 = GameObjectTools.GetOrAddComponent(var_15_6.gameObject, typeof(DynamicBoneHelper))

				if var_15_8 then
					var_15_8:EnableDynamicBone(false)
				end
			end

			local var_15_9 = 0.001

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_9 then
				local var_15_10 = (arg_12_1.time_ - var_15_7) / var_15_9
				local var_15_11 = Vector3.New(0, 100, 0)

				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2026_tpose, var_15_11, var_15_10)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_6.position

				var_15_6.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_6.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_6.localEulerAngles = var_15_13
			end

			if arg_12_1.time_ >= var_15_7 + var_15_9 and arg_12_1.time_ < var_15_7 + var_15_9 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, 100, 0)

				local var_15_14 = manager.ui.mainCamera.transform.position - var_15_6.position

				var_15_6.forward = Vector3.New(var_15_14.x, var_15_14.y, var_15_14.z)

				local var_15_15 = var_15_6.localEulerAngles

				var_15_15.z = 0
				var_15_15.x = 0
				var_15_6.localEulerAngles = var_15_15

				local var_15_16 = GameObjectTools.GetOrAddComponent(var_15_6.gameObject, typeof(DynamicBoneHelper))

				if var_15_16 then
					var_15_16:EnableDynamicBone(true)
				end
			end

			local var_15_17 = 0
			local var_15_18 = 1

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				local var_15_19 = "play"
				local var_15_20 = "effect"

				arg_12_1:AudioAction(var_15_19, var_15_20, "se_story_6", "se_story_6_slap02", "")
			end

			local var_15_21 = 0
			local var_15_22 = 1.075

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_23 = arg_12_1:GetWordFromCfg(106091003)
				local var_15_24 = arg_12_1:FormatText(var_15_23.content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 43
				local var_15_26 = utf8.len(var_15_24)
				local var_15_27 = var_15_25 <= 0 and var_15_22 or var_15_22 * (var_15_26 / var_15_25)

				if var_15_27 > 0 and var_15_22 < var_15_27 then
					arg_12_1.talkMaxDuration = var_15_27

					if var_15_27 + var_15_21 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_27 + var_15_21
					end
				end

				arg_12_1.text_.text = var_15_24
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_28 = math.max(var_15_22, arg_12_1.talkMaxDuration)

			if var_15_21 <= arg_12_1.time_ and arg_12_1.time_ < var_15_21 + var_15_28 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_21) / var_15_28

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_21 + var_15_28 and arg_12_1.time_ < var_15_21 + var_15_28 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2026_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play106091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106091004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play106091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.125

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				local var_19_2 = "play"
				local var_19_3 = "effect"

				arg_16_1:AudioAction(var_19_2, var_19_3, "se_story_6", "se_story_6_corrosion_loop", "")
			end

			local var_19_4 = 0
			local var_19_5 = 1.125

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(106091004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_8 = 45
				local var_19_9 = utf8.len(var_19_7)
				local var_19_10 = var_19_8 <= 0 and var_19_5 or var_19_5 * (var_19_9 / var_19_8)

				if var_19_10 > 0 and var_19_5 < var_19_10 then
					arg_16_1.talkMaxDuration = var_19_10

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_11 and arg_16_1.time_ < var_19_4 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play106091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106091005
		arg_20_1.duration_ = 2

		local var_20_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
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
				arg_20_0:Play106091006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "4014_tpose"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "4014_tpose")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["4014_tpose"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect4014_tpose == nil then
				arg_20_1.var_.characterEffect4014_tpose = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect4014_tpose and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect4014_tpose then
				arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["4014_tpose"].transform
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.var_.moveOldPos4014_tpose = var_23_9.localPosition

				local var_23_11 = GameObjectTools.GetOrAddComponent(var_23_9.gameObject, typeof(DynamicBoneHelper))

				if var_23_11 then
					var_23_11:EnableDynamicBone(false)
				end
			end

			local var_23_12 = 0.001

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_10) / var_23_12
				local var_23_14 = Vector3.New(0, -1.95, -4.2)

				var_23_9.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos4014_tpose, var_23_14, var_23_13)

				local var_23_15 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_15.x, var_23_15.y, var_23_15.z)

				local var_23_16 = var_23_9.localEulerAngles

				var_23_16.z = 0
				var_23_16.x = 0
				var_23_9.localEulerAngles = var_23_16
			end

			if arg_20_1.time_ >= var_23_10 + var_23_12 and arg_20_1.time_ < var_23_10 + var_23_12 + arg_23_0 then
				var_23_9.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_23_17 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_17.x, var_23_17.y, var_23_17.z)

				local var_23_18 = var_23_9.localEulerAngles

				var_23_18.z = 0
				var_23_18.x = 0
				var_23_9.localEulerAngles = var_23_18

				local var_23_19 = GameObjectTools.GetOrAddComponent(var_23_9.gameObject, typeof(DynamicBoneHelper))

				if var_23_19 then
					var_23_19:EnableDynamicBone(true)
				end
			end

			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_23_21 = 0.4
			local var_23_22 = 1

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				local var_23_23 = "play"
				local var_23_24 = "effect"

				arg_20_1:AudioAction(var_23_23, var_23_24, "se_story_6", "se_story_6_slap03", "")
			end

			local var_23_25 = 0
			local var_23_26 = 1

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				local var_23_27 = "stop"
				local var_23_28 = "effect"

				arg_20_1:AudioAction(var_23_27, var_23_28, "se_story_6", "se_story_6_corrosion_loop", "")
			end

			local var_23_29 = 0
			local var_23_30 = 0.125

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_31 = arg_20_1:FormatText(StoryNameCfg[87].name)

				arg_20_1.leftNameTxt_.text = var_23_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_32 = arg_20_1:GetWordFromCfg(106091005)
				local var_23_33 = arg_20_1:FormatText(var_23_32.content)

				arg_20_1.text_.text = var_23_33

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_34 = 5
				local var_23_35 = utf8.len(var_23_33)
				local var_23_36 = var_23_34 <= 0 and var_23_30 or var_23_30 * (var_23_35 / var_23_34)

				if var_23_36 > 0 and var_23_30 < var_23_36 then
					arg_20_1.talkMaxDuration = var_23_36

					if var_23_36 + var_23_29 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_36 + var_23_29
					end
				end

				arg_20_1.text_.text = var_23_33
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091005", "story_v_out_106091.awb") ~= 0 then
					local var_23_37 = manager.audio:GetVoiceLength("story_v_out_106091", "106091005", "story_v_out_106091.awb") / 1000

					if var_23_37 + var_23_29 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_37 + var_23_29
					end

					if var_23_32.prefab_name ~= "" and arg_20_1.actors_[var_23_32.prefab_name] ~= nil then
						local var_23_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_32.prefab_name].transform, "story_v_out_106091", "106091005", "story_v_out_106091.awb")

						arg_20_1:RecordAudio("106091005", var_23_38)
						arg_20_1:RecordAudio("106091005", var_23_38)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106091", "106091005", "story_v_out_106091.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106091", "106091005", "story_v_out_106091.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_39 = math.max(var_23_30, arg_20_1.talkMaxDuration)

			if var_23_29 <= arg_20_1.time_ and arg_20_1.time_ < var_23_29 + var_23_39 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_29) / var_23_39

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_29 + var_23_39 and arg_20_1.time_ < var_23_29 + var_23_39 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play106091006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106091006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play106091007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["4014_tpose"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect4014_tpose == nil then
				arg_24_1.var_.characterEffect4014_tpose = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect4014_tpose and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_24_1.var_.characterEffect4014_tpose.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect4014_tpose then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_24_1.var_.characterEffect4014_tpose.fillRatio = var_27_5
			end

			local var_27_6 = arg_24_1.actors_["4014_tpose"].transform
			local var_27_7 = 0

			if var_27_7 < arg_24_1.time_ and arg_24_1.time_ <= var_27_7 + arg_27_0 then
				arg_24_1.var_.moveOldPos4014_tpose = var_27_6.localPosition

				local var_27_8 = GameObjectTools.GetOrAddComponent(var_27_6.gameObject, typeof(DynamicBoneHelper))

				if var_27_8 then
					var_27_8:EnableDynamicBone(false)
				end
			end

			local var_27_9 = 0.001

			if var_27_7 <= arg_24_1.time_ and arg_24_1.time_ < var_27_7 + var_27_9 then
				local var_27_10 = (arg_24_1.time_ - var_27_7) / var_27_9
				local var_27_11 = Vector3.New(0, 100, 0)

				var_27_6.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos4014_tpose, var_27_11, var_27_10)

				local var_27_12 = manager.ui.mainCamera.transform.position - var_27_6.position

				var_27_6.forward = Vector3.New(var_27_12.x, var_27_12.y, var_27_12.z)

				local var_27_13 = var_27_6.localEulerAngles

				var_27_13.z = 0
				var_27_13.x = 0
				var_27_6.localEulerAngles = var_27_13
			end

			if arg_24_1.time_ >= var_27_7 + var_27_9 and arg_24_1.time_ < var_27_7 + var_27_9 + arg_27_0 then
				var_27_6.localPosition = Vector3.New(0, 100, 0)

				local var_27_14 = manager.ui.mainCamera.transform.position - var_27_6.position

				var_27_6.forward = Vector3.New(var_27_14.x, var_27_14.y, var_27_14.z)

				local var_27_15 = var_27_6.localEulerAngles

				var_27_15.z = 0
				var_27_15.x = 0
				var_27_6.localEulerAngles = var_27_15

				local var_27_16 = GameObjectTools.GetOrAddComponent(var_27_6.gameObject, typeof(DynamicBoneHelper))

				if var_27_16 then
					var_27_16:EnableDynamicBone(true)
				end
			end

			local var_27_17 = 0
			local var_27_18 = 1

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				local var_27_19 = "play"
				local var_27_20 = "effect"

				arg_24_1:AudioAction(var_27_19, var_27_20, "se_story_6", "se_story_6_vessel_open", "")
			end

			local var_27_21 = 0
			local var_27_22 = 1.3

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_23 = arg_24_1:GetWordFromCfg(106091006)
				local var_27_24 = arg_24_1:FormatText(var_27_23.content)

				arg_24_1.text_.text = var_27_24

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_25 = 52
				local var_27_26 = utf8.len(var_27_24)
				local var_27_27 = var_27_25 <= 0 and var_27_22 or var_27_22 * (var_27_26 / var_27_25)

				if var_27_27 > 0 and var_27_22 < var_27_27 then
					arg_24_1.talkMaxDuration = var_27_27

					if var_27_27 + var_27_21 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_27 + var_27_21
					end
				end

				arg_24_1.text_.text = var_27_24
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_28 = math.max(var_27_22, arg_24_1.talkMaxDuration)

			if var_27_21 <= arg_24_1.time_ and arg_24_1.time_ < var_27_21 + var_27_28 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_21) / var_27_28

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_21 + var_27_28 and arg_24_1.time_ < var_27_21 + var_27_28 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play106091007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106091007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106091008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.9

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

				local var_31_2 = arg_28_1:GetWordFromCfg(106091007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 36
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
	Play106091008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106091008
		arg_32_1.duration_ = 7.73

		local var_32_0 = {
			ja = 7.233,
			ko = 5.2,
			zh = 6.266,
			en = 7.733
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play106091009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["4014_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect4014_tpose == nil then
				arg_32_1.var_.characterEffect4014_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect4014_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect4014_tpose then
				arg_32_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_35_4 = "10004ui_story"

			if arg_32_1.actors_[var_35_4] == nil then
				local var_35_5 = Asset.Load("Char/" .. "10004ui_story")

				if not isNil(var_35_5) then
					local var_35_6 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_32_1.stage_.transform)

					var_35_6.name = var_35_4
					var_35_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_4] = var_35_6

					local var_35_7 = var_35_6:GetComponentInChildren(typeof(CharacterEffect))

					var_35_7.enabled = true

					local var_35_8 = GameObjectTools.GetOrAddComponent(var_35_6, typeof(DynamicBoneHelper))

					if var_35_8 then
						var_35_8:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_7.transform, false)

					arg_32_1.var_[var_35_4 .. "Animator"] = var_35_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_4 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_4 .. "LipSync"] = var_35_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_9 = arg_32_1.actors_["10004ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect10004ui_story == nil then
				arg_32_1.var_.characterEffect10004ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.1

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect10004ui_story and not isNil(var_35_9) then
					local var_35_13 = Mathf.Lerp(0, 0.5, var_35_12)

					arg_32_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10004ui_story.fillRatio = var_35_13
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect10004ui_story then
				local var_35_14 = 0.5

				arg_32_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10004ui_story.fillRatio = var_35_14
			end

			local var_35_15 = arg_32_1.actors_["4014_tpose"].transform
			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.var_.moveOldPos4014_tpose = var_35_15.localPosition

				local var_35_17 = GameObjectTools.GetOrAddComponent(var_35_15.gameObject, typeof(DynamicBoneHelper))

				if var_35_17 then
					var_35_17:EnableDynamicBone(false)
				end
			end

			local var_35_18 = 0.001

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_18 then
				local var_35_19 = (arg_32_1.time_ - var_35_16) / var_35_18
				local var_35_20 = Vector3.New(-0.7, -1.95, -4.2)

				var_35_15.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4014_tpose, var_35_20, var_35_19)

				local var_35_21 = manager.ui.mainCamera.transform.position - var_35_15.position

				var_35_15.forward = Vector3.New(var_35_21.x, var_35_21.y, var_35_21.z)

				local var_35_22 = var_35_15.localEulerAngles

				var_35_22.z = 0
				var_35_22.x = 0
				var_35_15.localEulerAngles = var_35_22
			end

			if arg_32_1.time_ >= var_35_16 + var_35_18 and arg_32_1.time_ < var_35_16 + var_35_18 + arg_35_0 then
				var_35_15.localPosition = Vector3.New(-0.7, -1.95, -4.2)

				local var_35_23 = manager.ui.mainCamera.transform.position - var_35_15.position

				var_35_15.forward = Vector3.New(var_35_23.x, var_35_23.y, var_35_23.z)

				local var_35_24 = var_35_15.localEulerAngles

				var_35_24.z = 0
				var_35_24.x = 0
				var_35_15.localEulerAngles = var_35_24

				local var_35_25 = GameObjectTools.GetOrAddComponent(var_35_15.gameObject, typeof(DynamicBoneHelper))

				if var_35_25 then
					var_35_25:EnableDynamicBone(true)
				end
			end

			local var_35_26 = arg_32_1.actors_["10004ui_story"].transform
			local var_35_27 = 0

			if var_35_27 < arg_32_1.time_ and arg_32_1.time_ <= var_35_27 + arg_35_0 then
				arg_32_1.var_.moveOldPos10004ui_story = var_35_26.localPosition
			end

			local var_35_28 = 0.001

			if var_35_27 <= arg_32_1.time_ and arg_32_1.time_ < var_35_27 + var_35_28 then
				local var_35_29 = (arg_32_1.time_ - var_35_27) / var_35_28
				local var_35_30 = Vector3.New(0.7, -1.1, -5.6)

				var_35_26.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10004ui_story, var_35_30, var_35_29)

				local var_35_31 = manager.ui.mainCamera.transform.position - var_35_26.position

				var_35_26.forward = Vector3.New(var_35_31.x, var_35_31.y, var_35_31.z)

				local var_35_32 = var_35_26.localEulerAngles

				var_35_32.z = 0
				var_35_32.x = 0
				var_35_26.localEulerAngles = var_35_32
			end

			if arg_32_1.time_ >= var_35_27 + var_35_28 and arg_32_1.time_ < var_35_27 + var_35_28 + arg_35_0 then
				var_35_26.localPosition = Vector3.New(0.7, -1.1, -5.6)

				local var_35_33 = manager.ui.mainCamera.transform.position - var_35_26.position

				var_35_26.forward = Vector3.New(var_35_33.x, var_35_33.y, var_35_33.z)

				local var_35_34 = var_35_26.localEulerAngles

				var_35_34.z = 0
				var_35_34.x = 0
				var_35_26.localEulerAngles = var_35_34
			end

			local var_35_35 = 0

			if var_35_35 < arg_32_1.time_ and arg_32_1.time_ <= var_35_35 + arg_35_0 then
				arg_32_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_35_36 = 0

			if var_35_36 < arg_32_1.time_ and arg_32_1.time_ <= var_35_36 + arg_35_0 then
				arg_32_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			local var_35_37 = 0
			local var_35_38 = 0.525

			if var_35_37 < arg_32_1.time_ and arg_32_1.time_ <= var_35_37 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_39 = arg_32_1:FormatText(StoryNameCfg[87].name)

				arg_32_1.leftNameTxt_.text = var_35_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_40 = arg_32_1:GetWordFromCfg(106091008)
				local var_35_41 = arg_32_1:FormatText(var_35_40.content)

				arg_32_1.text_.text = var_35_41

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_42 = 21
				local var_35_43 = utf8.len(var_35_41)
				local var_35_44 = var_35_42 <= 0 and var_35_38 or var_35_38 * (var_35_43 / var_35_42)

				if var_35_44 > 0 and var_35_38 < var_35_44 then
					arg_32_1.talkMaxDuration = var_35_44

					if var_35_44 + var_35_37 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_44 + var_35_37
					end
				end

				arg_32_1.text_.text = var_35_41
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091008", "story_v_out_106091.awb") ~= 0 then
					local var_35_45 = manager.audio:GetVoiceLength("story_v_out_106091", "106091008", "story_v_out_106091.awb") / 1000

					if var_35_45 + var_35_37 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_45 + var_35_37
					end

					if var_35_40.prefab_name ~= "" and arg_32_1.actors_[var_35_40.prefab_name] ~= nil then
						local var_35_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_40.prefab_name].transform, "story_v_out_106091", "106091008", "story_v_out_106091.awb")

						arg_32_1:RecordAudio("106091008", var_35_46)
						arg_32_1:RecordAudio("106091008", var_35_46)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106091", "106091008", "story_v_out_106091.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106091", "106091008", "story_v_out_106091.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_47 = math.max(var_35_38, arg_32_1.talkMaxDuration)

			if var_35_37 <= arg_32_1.time_ and arg_32_1.time_ < var_35_37 + var_35_47 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_37) / var_35_47

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_37 + var_35_47 and arg_32_1.time_ < var_35_37 + var_35_47 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play106091009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106091009
		arg_36_1.duration_ = 10.97

		local var_36_0 = {
			ja = 9.1,
			ko = 10.6,
			zh = 9.4,
			en = 10.966
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
				arg_36_0:Play106091010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.05

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[87].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(106091009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 42
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091009", "story_v_out_106091.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_106091", "106091009", "story_v_out_106091.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_106091", "106091009", "story_v_out_106091.awb")

						arg_36_1:RecordAudio("106091009", var_39_9)
						arg_36_1:RecordAudio("106091009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106091", "106091009", "story_v_out_106091.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106091", "106091009", "story_v_out_106091.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play106091010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106091010
		arg_40_1.duration_ = 12.37

		local var_40_0 = {
			ja = 12.366,
			ko = 5.2,
			zh = 5.4,
			en = 5.266
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
				arg_40_0:Play106091011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.55

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[87].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(106091010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 22
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091010", "story_v_out_106091.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_106091", "106091010", "story_v_out_106091.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_106091", "106091010", "story_v_out_106091.awb")

						arg_40_1:RecordAudio("106091010", var_43_9)
						arg_40_1:RecordAudio("106091010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_106091", "106091010", "story_v_out_106091.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_106091", "106091010", "story_v_out_106091.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play106091011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106091011
		arg_44_1.duration_ = 12.23

		local var_44_0 = {
			ja = 9.766,
			ko = 11.066,
			zh = 9.566,
			en = 12.233
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
				arg_44_0:Play106091012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.95

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[87].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(106091011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 38
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091011", "story_v_out_106091.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_106091", "106091011", "story_v_out_106091.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_106091", "106091011", "story_v_out_106091.awb")

						arg_44_1:RecordAudio("106091011", var_47_9)
						arg_44_1:RecordAudio("106091011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106091", "106091011", "story_v_out_106091.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106091", "106091011", "story_v_out_106091.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play106091012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 106091012
		arg_48_1.duration_ = 4.43

		local var_48_0 = {
			ja = 0.9,
			ko = 0.566,
			zh = 4.433,
			en = 1.233
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
				arg_48_0:Play106091013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["4014_tpose"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4014_tpose == nil then
				arg_48_1.var_.characterEffect4014_tpose = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect4014_tpose and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_48_1.var_.characterEffect4014_tpose.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4014_tpose then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_48_1.var_.characterEffect4014_tpose.fillRatio = var_51_5
			end

			local var_51_6 = arg_48_1.actors_["10004ui_story"]
			local var_51_7 = 0

			if var_51_7 < arg_48_1.time_ and arg_48_1.time_ <= var_51_7 + arg_51_0 and not isNil(var_51_6) and arg_48_1.var_.characterEffect10004ui_story == nil then
				arg_48_1.var_.characterEffect10004ui_story = var_51_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_8 = 0.1

			if var_51_7 <= arg_48_1.time_ and arg_48_1.time_ < var_51_7 + var_51_8 and not isNil(var_51_6) then
				local var_51_9 = (arg_48_1.time_ - var_51_7) / var_51_8

				if arg_48_1.var_.characterEffect10004ui_story and not isNil(var_51_6) then
					arg_48_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_7 + var_51_8 and arg_48_1.time_ < var_51_7 + var_51_8 + arg_51_0 and not isNil(var_51_6) and arg_48_1.var_.characterEffect10004ui_story then
				arg_48_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_51_10 = 0
			local var_51_11 = 0.05

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[80].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(106091012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 2
				local var_51_16 = utf8.len(var_51_14)
				local var_51_17 = var_51_15 <= 0 and var_51_11 or var_51_11 * (var_51_16 / var_51_15)

				if var_51_17 > 0 and var_51_11 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_14
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091012", "story_v_out_106091.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_106091", "106091012", "story_v_out_106091.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_106091", "106091012", "story_v_out_106091.awb")

						arg_48_1:RecordAudio("106091012", var_51_19)
						arg_48_1:RecordAudio("106091012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_106091", "106091012", "story_v_out_106091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_106091", "106091012", "story_v_out_106091.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_20 and arg_48_1.time_ < var_51_10 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play106091013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106091013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play106091014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["4014_tpose"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos4014_tpose = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos4014_tpose, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_8 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_8.x, var_55_8.y, var_55_8.z)

				local var_55_9 = var_55_0.localEulerAngles

				var_55_9.z = 0
				var_55_9.x = 0
				var_55_0.localEulerAngles = var_55_9

				local var_55_10 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_10 then
					var_55_10:EnableDynamicBone(true)
				end
			end

			local var_55_11 = arg_52_1.actors_["10004ui_story"].transform
			local var_55_12 = 0

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.var_.moveOldPos10004ui_story = var_55_11.localPosition
			end

			local var_55_13 = 0.001

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_13 then
				local var_55_14 = (arg_52_1.time_ - var_55_12) / var_55_13
				local var_55_15 = Vector3.New(0, 100, 0)

				var_55_11.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10004ui_story, var_55_15, var_55_14)

				local var_55_16 = manager.ui.mainCamera.transform.position - var_55_11.position

				var_55_11.forward = Vector3.New(var_55_16.x, var_55_16.y, var_55_16.z)

				local var_55_17 = var_55_11.localEulerAngles

				var_55_17.z = 0
				var_55_17.x = 0
				var_55_11.localEulerAngles = var_55_17
			end

			if arg_52_1.time_ >= var_55_12 + var_55_13 and arg_52_1.time_ < var_55_12 + var_55_13 + arg_55_0 then
				var_55_11.localPosition = Vector3.New(0, 100, 0)

				local var_55_18 = manager.ui.mainCamera.transform.position - var_55_11.position

				var_55_11.forward = Vector3.New(var_55_18.x, var_55_18.y, var_55_18.z)

				local var_55_19 = var_55_11.localEulerAngles

				var_55_19.z = 0
				var_55_19.x = 0
				var_55_11.localEulerAngles = var_55_19
			end

			local var_55_20 = 0
			local var_55_21 = 1

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				local var_55_22 = "play"
				local var_55_23 = "effect"

				arg_52_1:AudioAction(var_55_22, var_55_23, "se_story_6", "se_story_6_foot", "")
			end

			local var_55_24 = 0
			local var_55_25 = 1.099999999999

			if var_55_24 < arg_52_1.time_ and arg_52_1.time_ <= var_55_24 + arg_55_0 then
				local var_55_26 = "play"
				local var_55_27 = "effect"

				arg_52_1:AudioAction(var_55_26, var_55_27, "se_story_6", "se_story_6_black_fog03", "")
			end

			local var_55_28 = 0
			local var_55_29 = 1.1

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_30 = arg_52_1:GetWordFromCfg(106091013)
				local var_55_31 = arg_52_1:FormatText(var_55_30.content)

				arg_52_1.text_.text = var_55_31

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_32 = 44
				local var_55_33 = utf8.len(var_55_31)
				local var_55_34 = var_55_32 <= 0 and var_55_29 or var_55_29 * (var_55_33 / var_55_32)

				if var_55_34 > 0 and var_55_29 < var_55_34 then
					arg_52_1.talkMaxDuration = var_55_34

					if var_55_34 + var_55_28 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_34 + var_55_28
					end
				end

				arg_52_1.text_.text = var_55_31
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_35 = math.max(var_55_29, arg_52_1.talkMaxDuration)

			if var_55_28 <= arg_52_1.time_ and arg_52_1.time_ < var_55_28 + var_55_35 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_28) / var_55_35

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_28 + var_55_35 and arg_52_1.time_ < var_55_28 + var_55_35 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play106091014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 106091014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play106091015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1.475

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(106091014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 59
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play106091015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 106091015
		arg_60_1.duration_ = 6.53

		local var_60_0 = {
			ja = 5.566,
			ko = 4.366,
			zh = 3.9,
			en = 6.533
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
				arg_60_0:Play106091016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.3

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_2 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_2:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_3 = arg_60_1:FormatText(StoryNameCfg[89].name)

				arg_60_1.leftNameTxt_.text = var_63_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(106091015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 12
				local var_63_7 = utf8.len(var_63_5)
				local var_63_8 = var_63_6 <= 0 and var_63_1 or var_63_1 * (var_63_7 / var_63_6)

				if var_63_8 > 0 and var_63_1 < var_63_8 then
					arg_60_1.talkMaxDuration = var_63_8
					var_63_0 = var_63_0 + 0.3

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091015", "story_v_out_106091.awb") ~= 0 then
					local var_63_9 = manager.audio:GetVoiceLength("story_v_out_106091", "106091015", "story_v_out_106091.awb") / 1000

					if var_63_9 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_0
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_106091", "106091015", "story_v_out_106091.awb")

						arg_60_1:RecordAudio("106091015", var_63_10)
						arg_60_1:RecordAudio("106091015", var_63_10)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_106091", "106091015", "story_v_out_106091.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_106091", "106091015", "story_v_out_106091.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = var_63_0 + 0.3
			local var_63_12 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_11) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_11 + var_63_12 and arg_60_1.time_ < var_63_11 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play106091016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 106091016
		arg_66_1.duration_ = 8.7

		local var_66_0 = {
			ja = 7.866,
			ko = 4.666,
			zh = 8.7,
			en = 8.666
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play106091017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = "2032_tpose"

			if arg_66_1.actors_[var_69_0] == nil then
				local var_69_1 = Asset.Load("Char/" .. "2032_tpose")

				if not isNil(var_69_1) then
					local var_69_2 = Object.Instantiate(Asset.Load("Char/" .. "2032_tpose"), arg_66_1.stage_.transform)

					var_69_2.name = var_69_0
					var_69_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_66_1.actors_[var_69_0] = var_69_2

					local var_69_3 = var_69_2:GetComponentInChildren(typeof(CharacterEffect))

					var_69_3.enabled = true

					local var_69_4 = GameObjectTools.GetOrAddComponent(var_69_2, typeof(DynamicBoneHelper))

					if var_69_4 then
						var_69_4:EnableDynamicBone(false)
					end

					arg_66_1:ShowWeapon(var_69_3.transform, false)

					arg_66_1.var_[var_69_0 .. "Animator"] = var_69_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_66_1.var_[var_69_0 .. "Animator"].applyRootMotion = true
					arg_66_1.var_[var_69_0 .. "LipSync"] = var_69_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_69_5 = arg_66_1.actors_["2032_tpose"]
			local var_69_6 = 0

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect2032_tpose == nil then
				arg_66_1.var_.characterEffect2032_tpose = var_69_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_7 = 0.1

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_7 and not isNil(var_69_5) then
				local var_69_8 = (arg_66_1.time_ - var_69_6) / var_69_7

				if arg_66_1.var_.characterEffect2032_tpose and not isNil(var_69_5) then
					arg_66_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_6 + var_69_7 and arg_66_1.time_ < var_69_6 + var_69_7 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect2032_tpose then
				arg_66_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_69_9 = 0

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				arg_66_1:PlayTimeline("2032_tpose", "StoryTimeline/CharAction/story2032/story2032action/2032action1_1")
			end

			local var_69_10 = arg_66_1.actors_["2032_tpose"].transform
			local var_69_11 = 0

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1.var_.moveOldPos2032_tpose = var_69_10.localPosition

				local var_69_12 = GameObjectTools.GetOrAddComponent(var_69_10.gameObject, typeof(DynamicBoneHelper))

				if var_69_12 then
					var_69_12:EnableDynamicBone(false)
				end
			end

			local var_69_13 = 0.001

			if var_69_11 <= arg_66_1.time_ and arg_66_1.time_ < var_69_11 + var_69_13 then
				local var_69_14 = (arg_66_1.time_ - var_69_11) / var_69_13
				local var_69_15 = Vector3.New(0, -1.15, -4.2)

				var_69_10.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos2032_tpose, var_69_15, var_69_14)

				local var_69_16 = manager.ui.mainCamera.transform.position - var_69_10.position

				var_69_10.forward = Vector3.New(var_69_16.x, var_69_16.y, var_69_16.z)

				local var_69_17 = var_69_10.localEulerAngles

				var_69_17.z = 0
				var_69_17.x = 0
				var_69_10.localEulerAngles = var_69_17
			end

			if arg_66_1.time_ >= var_69_11 + var_69_13 and arg_66_1.time_ < var_69_11 + var_69_13 + arg_69_0 then
				var_69_10.localPosition = Vector3.New(0, -1.15, -4.2)

				local var_69_18 = manager.ui.mainCamera.transform.position - var_69_10.position

				var_69_10.forward = Vector3.New(var_69_18.x, var_69_18.y, var_69_18.z)

				local var_69_19 = var_69_10.localEulerAngles

				var_69_19.z = 0
				var_69_19.x = 0
				var_69_10.localEulerAngles = var_69_19

				local var_69_20 = GameObjectTools.GetOrAddComponent(var_69_10.gameObject, typeof(DynamicBoneHelper))

				if var_69_20 then
					var_69_20:EnableDynamicBone(true)
				end
			end

			local var_69_21 = 0
			local var_69_22 = 0.325

			if var_69_21 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_23 = arg_66_1:FormatText(StoryNameCfg[88].name)

				arg_66_1.leftNameTxt_.text = var_69_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_24 = arg_66_1:GetWordFromCfg(106091016)
				local var_69_25 = arg_66_1:FormatText(var_69_24.content)

				arg_66_1.text_.text = var_69_25

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_26 = 13
				local var_69_27 = utf8.len(var_69_25)
				local var_69_28 = var_69_26 <= 0 and var_69_22 or var_69_22 * (var_69_27 / var_69_26)

				if var_69_28 > 0 and var_69_22 < var_69_28 then
					arg_66_1.talkMaxDuration = var_69_28

					if var_69_28 + var_69_21 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_28 + var_69_21
					end
				end

				arg_66_1.text_.text = var_69_25
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091016", "story_v_out_106091.awb") ~= 0 then
					local var_69_29 = manager.audio:GetVoiceLength("story_v_out_106091", "106091016", "story_v_out_106091.awb") / 1000

					if var_69_29 + var_69_21 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_29 + var_69_21
					end

					if var_69_24.prefab_name ~= "" and arg_66_1.actors_[var_69_24.prefab_name] ~= nil then
						local var_69_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_24.prefab_name].transform, "story_v_out_106091", "106091016", "story_v_out_106091.awb")

						arg_66_1:RecordAudio("106091016", var_69_30)
						arg_66_1:RecordAudio("106091016", var_69_30)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_106091", "106091016", "story_v_out_106091.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_106091", "106091016", "story_v_out_106091.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_31 = math.max(var_69_22, arg_66_1.talkMaxDuration)

			if var_69_21 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_31 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_21) / var_69_31

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_21 + var_69_31 and arg_66_1.time_ < var_69_21 + var_69_31 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play106091017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 106091017
		arg_70_1.duration_ = 9.4

		local var_70_0 = {
			ja = 9.4,
			ko = 6.733,
			zh = 5.766,
			en = 9.233
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play106091018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["2032_tpose"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect2032_tpose == nil then
				arg_70_1.var_.characterEffect2032_tpose = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect2032_tpose and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect2032_tpose.fillFlat = true
					arg_70_1.var_.characterEffect2032_tpose.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect2032_tpose then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect2032_tpose.fillFlat = true
				arg_70_1.var_.characterEffect2032_tpose.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.475

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[89].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_9 = arg_70_1:GetWordFromCfg(106091017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 19
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091017", "story_v_out_106091.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_106091", "106091017", "story_v_out_106091.awb") / 1000

					if var_73_14 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_6
					end

					if var_73_9.prefab_name ~= "" and arg_70_1.actors_[var_73_9.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_9.prefab_name].transform, "story_v_out_106091", "106091017", "story_v_out_106091.awb")

						arg_70_1:RecordAudio("106091017", var_73_15)
						arg_70_1:RecordAudio("106091017", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_106091", "106091017", "story_v_out_106091.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_106091", "106091017", "story_v_out_106091.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_16 and arg_70_1.time_ < var_73_6 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play106091018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 106091018
		arg_74_1.duration_ = 8.57

		local var_74_0 = {
			ja = 8.566,
			ko = 3.8,
			zh = 7.033,
			en = 4.5
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play106091019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["2032_tpose"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect2032_tpose == nil then
				arg_74_1.var_.characterEffect2032_tpose = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect2032_tpose and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect2032_tpose then
				arg_74_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_77_4 = 0
			local var_77_5 = 0.25

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_6 = arg_74_1:FormatText(StoryNameCfg[88].name)

				arg_74_1.leftNameTxt_.text = var_77_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:GetWordFromCfg(106091018)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 10
				local var_77_10 = utf8.len(var_77_8)
				local var_77_11 = var_77_9 <= 0 and var_77_5 or var_77_5 * (var_77_10 / var_77_9)

				if var_77_11 > 0 and var_77_5 < var_77_11 then
					arg_74_1.talkMaxDuration = var_77_11

					if var_77_11 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091018", "story_v_out_106091.awb") ~= 0 then
					local var_77_12 = manager.audio:GetVoiceLength("story_v_out_106091", "106091018", "story_v_out_106091.awb") / 1000

					if var_77_12 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_12 + var_77_4
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_106091", "106091018", "story_v_out_106091.awb")

						arg_74_1:RecordAudio("106091018", var_77_13)
						arg_74_1:RecordAudio("106091018", var_77_13)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_106091", "106091018", "story_v_out_106091.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_106091", "106091018", "story_v_out_106091.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_14 and arg_74_1.time_ < var_77_4 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play106091019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 106091019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play106091020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["2032_tpose"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect2032_tpose == nil then
				arg_78_1.var_.characterEffect2032_tpose = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect2032_tpose and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect2032_tpose.fillFlat = true
					arg_78_1.var_.characterEffect2032_tpose.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect2032_tpose then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect2032_tpose.fillFlat = true
				arg_78_1.var_.characterEffect2032_tpose.fillRatio = var_81_5
			end

			local var_81_6 = arg_78_1.actors_["2032_tpose"].transform
			local var_81_7 = 0

			if var_81_7 < arg_78_1.time_ and arg_78_1.time_ <= var_81_7 + arg_81_0 then
				arg_78_1.var_.moveOldPos2032_tpose = var_81_6.localPosition

				local var_81_8 = GameObjectTools.GetOrAddComponent(var_81_6.gameObject, typeof(DynamicBoneHelper))

				if var_81_8 then
					var_81_8:EnableDynamicBone(false)
				end
			end

			local var_81_9 = 0.001

			if var_81_7 <= arg_78_1.time_ and arg_78_1.time_ < var_81_7 + var_81_9 then
				local var_81_10 = (arg_78_1.time_ - var_81_7) / var_81_9
				local var_81_11 = Vector3.New(0, 100, 0)

				var_81_6.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos2032_tpose, var_81_11, var_81_10)

				local var_81_12 = manager.ui.mainCamera.transform.position - var_81_6.position

				var_81_6.forward = Vector3.New(var_81_12.x, var_81_12.y, var_81_12.z)

				local var_81_13 = var_81_6.localEulerAngles

				var_81_13.z = 0
				var_81_13.x = 0
				var_81_6.localEulerAngles = var_81_13
			end

			if arg_78_1.time_ >= var_81_7 + var_81_9 and arg_78_1.time_ < var_81_7 + var_81_9 + arg_81_0 then
				var_81_6.localPosition = Vector3.New(0, 100, 0)

				local var_81_14 = manager.ui.mainCamera.transform.position - var_81_6.position

				var_81_6.forward = Vector3.New(var_81_14.x, var_81_14.y, var_81_14.z)

				local var_81_15 = var_81_6.localEulerAngles

				var_81_15.z = 0
				var_81_15.x = 0
				var_81_6.localEulerAngles = var_81_15

				local var_81_16 = GameObjectTools.GetOrAddComponent(var_81_6.gameObject, typeof(DynamicBoneHelper))

				if var_81_16 then
					var_81_16:EnableDynamicBone(true)
				end
			end

			local var_81_17 = 0
			local var_81_18 = 0.725

			if var_81_17 < arg_78_1.time_ and arg_78_1.time_ <= var_81_17 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_19 = arg_78_1:GetWordFromCfg(106091019)
				local var_81_20 = arg_78_1:FormatText(var_81_19.content)

				arg_78_1.text_.text = var_81_20

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_21 = 29
				local var_81_22 = utf8.len(var_81_20)
				local var_81_23 = var_81_21 <= 0 and var_81_18 or var_81_18 * (var_81_22 / var_81_21)

				if var_81_23 > 0 and var_81_18 < var_81_23 then
					arg_78_1.talkMaxDuration = var_81_23

					if var_81_23 + var_81_17 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_17
					end
				end

				arg_78_1.text_.text = var_81_20
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_24 = math.max(var_81_18, arg_78_1.talkMaxDuration)

			if var_81_17 <= arg_78_1.time_ and arg_78_1.time_ < var_81_17 + var_81_24 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_17) / var_81_24

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_17 + var_81_24 and arg_78_1.time_ < var_81_17 + var_81_24 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play106091020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 106091020
		arg_82_1.duration_ = 2.5

		local var_82_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play106091021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["4014_tpose"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect4014_tpose == nil then
				arg_82_1.var_.characterEffect4014_tpose = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect4014_tpose and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_82_1.var_.characterEffect4014_tpose.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect4014_tpose then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_82_1.var_.characterEffect4014_tpose.fillRatio = var_85_5
			end

			local var_85_6 = arg_82_1.actors_["10004ui_story"]
			local var_85_7 = 0

			if var_85_7 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect10004ui_story == nil then
				arg_82_1.var_.characterEffect10004ui_story = var_85_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_8 = 0.1

			if var_85_7 <= arg_82_1.time_ and arg_82_1.time_ < var_85_7 + var_85_8 and not isNil(var_85_6) then
				local var_85_9 = (arg_82_1.time_ - var_85_7) / var_85_8

				if arg_82_1.var_.characterEffect10004ui_story and not isNil(var_85_6) then
					arg_82_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_7 + var_85_8 and arg_82_1.time_ < var_85_7 + var_85_8 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect10004ui_story then
				arg_82_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_85_10 = arg_82_1.actors_["4014_tpose"].transform
			local var_85_11 = 0

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				arg_82_1.var_.moveOldPos4014_tpose = var_85_10.localPosition

				local var_85_12 = GameObjectTools.GetOrAddComponent(var_85_10.gameObject, typeof(DynamicBoneHelper))

				if var_85_12 then
					var_85_12:EnableDynamicBone(false)
				end
			end

			local var_85_13 = 0.001

			if var_85_11 <= arg_82_1.time_ and arg_82_1.time_ < var_85_11 + var_85_13 then
				local var_85_14 = (arg_82_1.time_ - var_85_11) / var_85_13
				local var_85_15 = Vector3.New(-0.7, -1.95, -4.2)

				var_85_10.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4014_tpose, var_85_15, var_85_14)

				local var_85_16 = manager.ui.mainCamera.transform.position - var_85_10.position

				var_85_10.forward = Vector3.New(var_85_16.x, var_85_16.y, var_85_16.z)

				local var_85_17 = var_85_10.localEulerAngles

				var_85_17.z = 0
				var_85_17.x = 0
				var_85_10.localEulerAngles = var_85_17
			end

			if arg_82_1.time_ >= var_85_11 + var_85_13 and arg_82_1.time_ < var_85_11 + var_85_13 + arg_85_0 then
				var_85_10.localPosition = Vector3.New(-0.7, -1.95, -4.2)

				local var_85_18 = manager.ui.mainCamera.transform.position - var_85_10.position

				var_85_10.forward = Vector3.New(var_85_18.x, var_85_18.y, var_85_18.z)

				local var_85_19 = var_85_10.localEulerAngles

				var_85_19.z = 0
				var_85_19.x = 0
				var_85_10.localEulerAngles = var_85_19

				local var_85_20 = GameObjectTools.GetOrAddComponent(var_85_10.gameObject, typeof(DynamicBoneHelper))

				if var_85_20 then
					var_85_20:EnableDynamicBone(true)
				end
			end

			local var_85_21 = arg_82_1.actors_["10004ui_story"].transform
			local var_85_22 = 0

			if var_85_22 < arg_82_1.time_ and arg_82_1.time_ <= var_85_22 + arg_85_0 then
				arg_82_1.var_.moveOldPos10004ui_story = var_85_21.localPosition
			end

			local var_85_23 = 0.001

			if var_85_22 <= arg_82_1.time_ and arg_82_1.time_ < var_85_22 + var_85_23 then
				local var_85_24 = (arg_82_1.time_ - var_85_22) / var_85_23
				local var_85_25 = Vector3.New(0.7, -1.1, -5.6)

				var_85_21.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10004ui_story, var_85_25, var_85_24)

				local var_85_26 = manager.ui.mainCamera.transform.position - var_85_21.position

				var_85_21.forward = Vector3.New(var_85_26.x, var_85_26.y, var_85_26.z)

				local var_85_27 = var_85_21.localEulerAngles

				var_85_27.z = 0
				var_85_27.x = 0
				var_85_21.localEulerAngles = var_85_27
			end

			if arg_82_1.time_ >= var_85_22 + var_85_23 and arg_82_1.time_ < var_85_22 + var_85_23 + arg_85_0 then
				var_85_21.localPosition = Vector3.New(0.7, -1.1, -5.6)

				local var_85_28 = manager.ui.mainCamera.transform.position - var_85_21.position

				var_85_21.forward = Vector3.New(var_85_28.x, var_85_28.y, var_85_28.z)

				local var_85_29 = var_85_21.localEulerAngles

				var_85_29.z = 0
				var_85_29.x = 0
				var_85_21.localEulerAngles = var_85_29
			end

			local var_85_30 = 0

			if var_85_30 < arg_82_1.time_ and arg_82_1.time_ <= var_85_30 + arg_85_0 then
				arg_82_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_85_31 = 0

			if var_85_31 < arg_82_1.time_ and arg_82_1.time_ <= var_85_31 + arg_85_0 then
				arg_82_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			local var_85_32 = 0

			if var_85_32 < arg_82_1.time_ and arg_82_1.time_ <= var_85_32 + arg_85_0 then
				arg_82_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_85_33 = 0
			local var_85_34 = 0.25

			if var_85_33 < arg_82_1.time_ and arg_82_1.time_ <= var_85_33 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_35 = arg_82_1:FormatText(StoryNameCfg[80].name)

				arg_82_1.leftNameTxt_.text = var_85_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_36 = arg_82_1:GetWordFromCfg(106091020)
				local var_85_37 = arg_82_1:FormatText(var_85_36.content)

				arg_82_1.text_.text = var_85_37

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_38 = 10
				local var_85_39 = utf8.len(var_85_37)
				local var_85_40 = var_85_38 <= 0 and var_85_34 or var_85_34 * (var_85_39 / var_85_38)

				if var_85_40 > 0 and var_85_34 < var_85_40 then
					arg_82_1.talkMaxDuration = var_85_40

					if var_85_40 + var_85_33 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_40 + var_85_33
					end
				end

				arg_82_1.text_.text = var_85_37
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091020", "story_v_out_106091.awb") ~= 0 then
					local var_85_41 = manager.audio:GetVoiceLength("story_v_out_106091", "106091020", "story_v_out_106091.awb") / 1000

					if var_85_41 + var_85_33 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_41 + var_85_33
					end

					if var_85_36.prefab_name ~= "" and arg_82_1.actors_[var_85_36.prefab_name] ~= nil then
						local var_85_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_36.prefab_name].transform, "story_v_out_106091", "106091020", "story_v_out_106091.awb")

						arg_82_1:RecordAudio("106091020", var_85_42)
						arg_82_1:RecordAudio("106091020", var_85_42)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_106091", "106091020", "story_v_out_106091.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_106091", "106091020", "story_v_out_106091.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_43 = math.max(var_85_34, arg_82_1.talkMaxDuration)

			if var_85_33 <= arg_82_1.time_ and arg_82_1.time_ < var_85_33 + var_85_43 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_33) / var_85_43

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_33 + var_85_43 and arg_82_1.time_ < var_85_33 + var_85_43 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play106091021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 106091021
		arg_86_1.duration_ = 6.23

		local var_86_0 = {
			ja = 6.233,
			ko = 4.9,
			zh = 4.766,
			en = 5.9
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play106091022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["4014_tpose"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect4014_tpose == nil then
				arg_86_1.var_.characterEffect4014_tpose = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.1

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect4014_tpose and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect4014_tpose then
				arg_86_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["10004ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10004ui_story == nil then
				arg_86_1.var_.characterEffect10004ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.1

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect10004ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10004ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10004ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10004ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0
			local var_89_11 = 0.55

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_12 = arg_86_1:FormatText(StoryNameCfg[87].name)

				arg_86_1.leftNameTxt_.text = var_89_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_13 = arg_86_1:GetWordFromCfg(106091021)
				local var_89_14 = arg_86_1:FormatText(var_89_13.content)

				arg_86_1.text_.text = var_89_14

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 22
				local var_89_16 = utf8.len(var_89_14)
				local var_89_17 = var_89_15 <= 0 and var_89_11 or var_89_11 * (var_89_16 / var_89_15)

				if var_89_17 > 0 and var_89_11 < var_89_17 then
					arg_86_1.talkMaxDuration = var_89_17

					if var_89_17 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_17 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_14
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091021", "story_v_out_106091.awb") ~= 0 then
					local var_89_18 = manager.audio:GetVoiceLength("story_v_out_106091", "106091021", "story_v_out_106091.awb") / 1000

					if var_89_18 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_10
					end

					if var_89_13.prefab_name ~= "" and arg_86_1.actors_[var_89_13.prefab_name] ~= nil then
						local var_89_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_13.prefab_name].transform, "story_v_out_106091", "106091021", "story_v_out_106091.awb")

						arg_86_1:RecordAudio("106091021", var_89_19)
						arg_86_1:RecordAudio("106091021", var_89_19)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_106091", "106091021", "story_v_out_106091.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_106091", "106091021", "story_v_out_106091.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_20 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_20 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_20

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_20 and arg_86_1.time_ < var_89_10 + var_89_20 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play106091022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 106091022
		arg_90_1.duration_ = 9.7

		local var_90_0 = {
			ja = 8.666,
			ko = 7.2,
			zh = 8.633,
			en = 9.7
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play106091023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["4014_tpose"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect4014_tpose == nil then
				arg_90_1.var_.characterEffect4014_tpose = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.1

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect4014_tpose and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_90_1.var_.characterEffect4014_tpose.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect4014_tpose then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_90_1.var_.characterEffect4014_tpose.fillRatio = var_93_5
			end

			local var_93_6 = arg_90_1.actors_["10004ui_story"]
			local var_93_7 = 0

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect10004ui_story == nil then
				arg_90_1.var_.characterEffect10004ui_story = var_93_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_8 = 0.1

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_8 and not isNil(var_93_6) then
				local var_93_9 = (arg_90_1.time_ - var_93_7) / var_93_8

				if arg_90_1.var_.characterEffect10004ui_story and not isNil(var_93_6) then
					arg_90_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_7 + var_93_8 and arg_90_1.time_ < var_93_7 + var_93_8 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect10004ui_story then
				arg_90_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_93_11 = 0
			local var_93_12 = 0.95

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_13 = arg_90_1:FormatText(StoryNameCfg[80].name)

				arg_90_1.leftNameTxt_.text = var_93_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_14 = arg_90_1:GetWordFromCfg(106091022)
				local var_93_15 = arg_90_1:FormatText(var_93_14.content)

				arg_90_1.text_.text = var_93_15

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_16 = 38
				local var_93_17 = utf8.len(var_93_15)
				local var_93_18 = var_93_16 <= 0 and var_93_12 or var_93_12 * (var_93_17 / var_93_16)

				if var_93_18 > 0 and var_93_12 < var_93_18 then
					arg_90_1.talkMaxDuration = var_93_18

					if var_93_18 + var_93_11 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_18 + var_93_11
					end
				end

				arg_90_1.text_.text = var_93_15
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091022", "story_v_out_106091.awb") ~= 0 then
					local var_93_19 = manager.audio:GetVoiceLength("story_v_out_106091", "106091022", "story_v_out_106091.awb") / 1000

					if var_93_19 + var_93_11 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_11
					end

					if var_93_14.prefab_name ~= "" and arg_90_1.actors_[var_93_14.prefab_name] ~= nil then
						local var_93_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_14.prefab_name].transform, "story_v_out_106091", "106091022", "story_v_out_106091.awb")

						arg_90_1:RecordAudio("106091022", var_93_20)
						arg_90_1:RecordAudio("106091022", var_93_20)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_106091", "106091022", "story_v_out_106091.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_106091", "106091022", "story_v_out_106091.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_21 = math.max(var_93_12, arg_90_1.talkMaxDuration)

			if var_93_11 <= arg_90_1.time_ and arg_90_1.time_ < var_93_11 + var_93_21 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_11) / var_93_21

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_11 + var_93_21 and arg_90_1.time_ < var_93_11 + var_93_21 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play106091023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 106091023
		arg_94_1.duration_ = 15.6

		local var_94_0 = {
			ja = 15.6,
			ko = 10.233,
			zh = 11.733,
			en = 12.8
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play106091024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["4014_tpose"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect4014_tpose == nil then
				arg_94_1.var_.characterEffect4014_tpose = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.1

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect4014_tpose and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect4014_tpose then
				arg_94_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["10004ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect10004ui_story == nil then
				arg_94_1.var_.characterEffect10004ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.1

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect10004ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10004ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect10004ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10004ui_story.fillRatio = var_97_9
			end

			local var_97_10 = 0
			local var_97_11 = 1.175

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_12 = arg_94_1:FormatText(StoryNameCfg[87].name)

				arg_94_1.leftNameTxt_.text = var_97_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_13 = arg_94_1:GetWordFromCfg(106091023)
				local var_97_14 = arg_94_1:FormatText(var_97_13.content)

				arg_94_1.text_.text = var_97_14

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_15 = 47
				local var_97_16 = utf8.len(var_97_14)
				local var_97_17 = var_97_15 <= 0 and var_97_11 or var_97_11 * (var_97_16 / var_97_15)

				if var_97_17 > 0 and var_97_11 < var_97_17 then
					arg_94_1.talkMaxDuration = var_97_17

					if var_97_17 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_17 + var_97_10
					end
				end

				arg_94_1.text_.text = var_97_14
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091023", "story_v_out_106091.awb") ~= 0 then
					local var_97_18 = manager.audio:GetVoiceLength("story_v_out_106091", "106091023", "story_v_out_106091.awb") / 1000

					if var_97_18 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_18 + var_97_10
					end

					if var_97_13.prefab_name ~= "" and arg_94_1.actors_[var_97_13.prefab_name] ~= nil then
						local var_97_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_13.prefab_name].transform, "story_v_out_106091", "106091023", "story_v_out_106091.awb")

						arg_94_1:RecordAudio("106091023", var_97_19)
						arg_94_1:RecordAudio("106091023", var_97_19)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_106091", "106091023", "story_v_out_106091.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_106091", "106091023", "story_v_out_106091.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_20 = math.max(var_97_11, arg_94_1.talkMaxDuration)

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_20 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_10) / var_97_20

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_10 + var_97_20 and arg_94_1.time_ < var_97_10 + var_97_20 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play106091024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 106091024
		arg_98_1.duration_ = 20.13

		local var_98_0 = {
			ja = 20.133,
			ko = 12.2,
			zh = 11.966,
			en = 11.9
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play106091025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 1.15

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[87].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(106091024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 46
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091024", "story_v_out_106091.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_106091", "106091024", "story_v_out_106091.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_106091", "106091024", "story_v_out_106091.awb")

						arg_98_1:RecordAudio("106091024", var_101_9)
						arg_98_1:RecordAudio("106091024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_106091", "106091024", "story_v_out_106091.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_106091", "106091024", "story_v_out_106091.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play106091025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 106091025
		arg_102_1.duration_ = 6.8

		local var_102_0 = {
			ja = 6.8,
			ko = 4.266,
			zh = 2.566,
			en = 3.9
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play106091026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["4014_tpose"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect4014_tpose == nil then
				arg_102_1.var_.characterEffect4014_tpose = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect4014_tpose and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_102_1.var_.characterEffect4014_tpose.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect4014_tpose then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_102_1.var_.characterEffect4014_tpose.fillRatio = var_105_5
			end

			local var_105_6 = arg_102_1.actors_["10004ui_story"]
			local var_105_7 = 0

			if var_105_7 < arg_102_1.time_ and arg_102_1.time_ <= var_105_7 + arg_105_0 and not isNil(var_105_6) and arg_102_1.var_.characterEffect10004ui_story == nil then
				arg_102_1.var_.characterEffect10004ui_story = var_105_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_8 = 0.1

			if var_105_7 <= arg_102_1.time_ and arg_102_1.time_ < var_105_7 + var_105_8 and not isNil(var_105_6) then
				local var_105_9 = (arg_102_1.time_ - var_105_7) / var_105_8

				if arg_102_1.var_.characterEffect10004ui_story and not isNil(var_105_6) then
					arg_102_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_7 + var_105_8 and arg_102_1.time_ < var_105_7 + var_105_8 + arg_105_0 and not isNil(var_105_6) and arg_102_1.var_.characterEffect10004ui_story then
				arg_102_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_105_11 = 0
			local var_105_12 = 0.4

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_13 = arg_102_1:FormatText(StoryNameCfg[80].name)

				arg_102_1.leftNameTxt_.text = var_105_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_14 = arg_102_1:GetWordFromCfg(106091025)
				local var_105_15 = arg_102_1:FormatText(var_105_14.content)

				arg_102_1.text_.text = var_105_15

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_16 = 15
				local var_105_17 = utf8.len(var_105_15)
				local var_105_18 = var_105_16 <= 0 and var_105_12 or var_105_12 * (var_105_17 / var_105_16)

				if var_105_18 > 0 and var_105_12 < var_105_18 then
					arg_102_1.talkMaxDuration = var_105_18

					if var_105_18 + var_105_11 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_18 + var_105_11
					end
				end

				arg_102_1.text_.text = var_105_15
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091025", "story_v_out_106091.awb") ~= 0 then
					local var_105_19 = manager.audio:GetVoiceLength("story_v_out_106091", "106091025", "story_v_out_106091.awb") / 1000

					if var_105_19 + var_105_11 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_19 + var_105_11
					end

					if var_105_14.prefab_name ~= "" and arg_102_1.actors_[var_105_14.prefab_name] ~= nil then
						local var_105_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_14.prefab_name].transform, "story_v_out_106091", "106091025", "story_v_out_106091.awb")

						arg_102_1:RecordAudio("106091025", var_105_20)
						arg_102_1:RecordAudio("106091025", var_105_20)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_106091", "106091025", "story_v_out_106091.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_106091", "106091025", "story_v_out_106091.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_21 = math.max(var_105_12, arg_102_1.talkMaxDuration)

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_21 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_11) / var_105_21

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_11 + var_105_21 and arg_102_1.time_ < var_105_11 + var_105_21 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play106091026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 106091026
		arg_106_1.duration_ = 12.63

		local var_106_0 = {
			ja = 10.433,
			ko = 11.533,
			zh = 12.633,
			en = 10.533
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play106091027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["4014_tpose"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect4014_tpose == nil then
				arg_106_1.var_.characterEffect4014_tpose = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.1

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect4014_tpose and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect4014_tpose then
				arg_106_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["10004ui_story"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect10004ui_story == nil then
				arg_106_1.var_.characterEffect10004ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.1

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.characterEffect10004ui_story and not isNil(var_109_4) then
					local var_109_8 = Mathf.Lerp(0, 0.5, var_109_7)

					arg_106_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10004ui_story.fillRatio = var_109_8
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect10004ui_story then
				local var_109_9 = 0.5

				arg_106_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10004ui_story.fillRatio = var_109_9
			end

			local var_109_10 = 0
			local var_109_11 = 1.05

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_12 = arg_106_1:FormatText(StoryNameCfg[87].name)

				arg_106_1.leftNameTxt_.text = var_109_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_13 = arg_106_1:GetWordFromCfg(106091026)
				local var_109_14 = arg_106_1:FormatText(var_109_13.content)

				arg_106_1.text_.text = var_109_14

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_15 = 42
				local var_109_16 = utf8.len(var_109_14)
				local var_109_17 = var_109_15 <= 0 and var_109_11 or var_109_11 * (var_109_16 / var_109_15)

				if var_109_17 > 0 and var_109_11 < var_109_17 then
					arg_106_1.talkMaxDuration = var_109_17

					if var_109_17 + var_109_10 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_17 + var_109_10
					end
				end

				arg_106_1.text_.text = var_109_14
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091026", "story_v_out_106091.awb") ~= 0 then
					local var_109_18 = manager.audio:GetVoiceLength("story_v_out_106091", "106091026", "story_v_out_106091.awb") / 1000

					if var_109_18 + var_109_10 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_18 + var_109_10
					end

					if var_109_13.prefab_name ~= "" and arg_106_1.actors_[var_109_13.prefab_name] ~= nil then
						local var_109_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_13.prefab_name].transform, "story_v_out_106091", "106091026", "story_v_out_106091.awb")

						arg_106_1:RecordAudio("106091026", var_109_19)
						arg_106_1:RecordAudio("106091026", var_109_19)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_106091", "106091026", "story_v_out_106091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_106091", "106091026", "story_v_out_106091.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_20 = math.max(var_109_11, arg_106_1.talkMaxDuration)

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_20 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_10) / var_109_20

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_10 + var_109_20 and arg_106_1.time_ < var_109_10 + var_109_20 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play106091027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 106091027
		arg_110_1.duration_ = 2.43

		local var_110_0 = {
			ja = 2.433,
			ko = 2.266,
			zh = 2.2,
			en = 1.966
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play106091028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["4014_tpose"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect4014_tpose == nil then
				arg_110_1.var_.characterEffect4014_tpose = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.1

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect4014_tpose and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_110_1.var_.characterEffect4014_tpose.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect4014_tpose then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_110_1.var_.characterEffect4014_tpose.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.15

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[90].name)

				arg_110_1.leftNameTxt_.text = var_113_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_9 = arg_110_1:GetWordFromCfg(106091027)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 6
				local var_113_12 = utf8.len(var_113_10)
				local var_113_13 = var_113_11 <= 0 and var_113_7 or var_113_7 * (var_113_12 / var_113_11)

				if var_113_13 > 0 and var_113_7 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091027", "story_v_out_106091.awb") ~= 0 then
					local var_113_14 = manager.audio:GetVoiceLength("story_v_out_106091", "106091027", "story_v_out_106091.awb") / 1000

					if var_113_14 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_6
					end

					if var_113_9.prefab_name ~= "" and arg_110_1.actors_[var_113_9.prefab_name] ~= nil then
						local var_113_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_9.prefab_name].transform, "story_v_out_106091", "106091027", "story_v_out_106091.awb")

						arg_110_1:RecordAudio("106091027", var_113_15)
						arg_110_1:RecordAudio("106091027", var_113_15)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_106091", "106091027", "story_v_out_106091.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_106091", "106091027", "story_v_out_106091.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_16 and arg_110_1.time_ < var_113_6 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play106091028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 106091028
		arg_114_1.duration_ = 1

		local var_114_0 = {
			ja = 0.9,
			ko = 0.8,
			zh = 1,
			en = 0.966
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play106091029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["4014_tpose"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect4014_tpose == nil then
				arg_114_1.var_.characterEffect4014_tpose = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.1

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect4014_tpose and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect4014_tpose then
				arg_114_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_117_4 = 0
			local var_117_5 = 0.05

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_6 = arg_114_1:FormatText(StoryNameCfg[87].name)

				arg_114_1.leftNameTxt_.text = var_117_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_7 = arg_114_1:GetWordFromCfg(106091028)
				local var_117_8 = arg_114_1:FormatText(var_117_7.content)

				arg_114_1.text_.text = var_117_8

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 2
				local var_117_10 = utf8.len(var_117_8)
				local var_117_11 = var_117_9 <= 0 and var_117_5 or var_117_5 * (var_117_10 / var_117_9)

				if var_117_11 > 0 and var_117_5 < var_117_11 then
					arg_114_1.talkMaxDuration = var_117_11

					if var_117_11 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_8
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091028", "story_v_out_106091.awb") ~= 0 then
					local var_117_12 = manager.audio:GetVoiceLength("story_v_out_106091", "106091028", "story_v_out_106091.awb") / 1000

					if var_117_12 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_4
					end

					if var_117_7.prefab_name ~= "" and arg_114_1.actors_[var_117_7.prefab_name] ~= nil then
						local var_117_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_7.prefab_name].transform, "story_v_out_106091", "106091028", "story_v_out_106091.awb")

						arg_114_1:RecordAudio("106091028", var_117_13)
						arg_114_1:RecordAudio("106091028", var_117_13)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_106091", "106091028", "story_v_out_106091.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_106091", "106091028", "story_v_out_106091.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_14 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_14 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_14

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_14 and arg_114_1.time_ < var_117_4 + var_117_14 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play106091029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 106091029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play106091030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["4014_tpose"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect4014_tpose == nil then
				arg_118_1.var_.characterEffect4014_tpose = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect4014_tpose and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_118_1.var_.characterEffect4014_tpose.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect4014_tpose then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_118_1.var_.characterEffect4014_tpose.fillRatio = var_121_5
			end

			local var_121_6 = arg_118_1.actors_["4014_tpose"].transform
			local var_121_7 = 0

			if var_121_7 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.var_.moveOldPos4014_tpose = var_121_6.localPosition

				local var_121_8 = GameObjectTools.GetOrAddComponent(var_121_6.gameObject, typeof(DynamicBoneHelper))

				if var_121_8 then
					var_121_8:EnableDynamicBone(false)
				end
			end

			local var_121_9 = 0.001

			if var_121_7 <= arg_118_1.time_ and arg_118_1.time_ < var_121_7 + var_121_9 then
				local var_121_10 = (arg_118_1.time_ - var_121_7) / var_121_9
				local var_121_11 = Vector3.New(0, 100, 0)

				var_121_6.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos4014_tpose, var_121_11, var_121_10)

				local var_121_12 = manager.ui.mainCamera.transform.position - var_121_6.position

				var_121_6.forward = Vector3.New(var_121_12.x, var_121_12.y, var_121_12.z)

				local var_121_13 = var_121_6.localEulerAngles

				var_121_13.z = 0
				var_121_13.x = 0
				var_121_6.localEulerAngles = var_121_13
			end

			if arg_118_1.time_ >= var_121_7 + var_121_9 and arg_118_1.time_ < var_121_7 + var_121_9 + arg_121_0 then
				var_121_6.localPosition = Vector3.New(0, 100, 0)

				local var_121_14 = manager.ui.mainCamera.transform.position - var_121_6.position

				var_121_6.forward = Vector3.New(var_121_14.x, var_121_14.y, var_121_14.z)

				local var_121_15 = var_121_6.localEulerAngles

				var_121_15.z = 0
				var_121_15.x = 0
				var_121_6.localEulerAngles = var_121_15

				local var_121_16 = GameObjectTools.GetOrAddComponent(var_121_6.gameObject, typeof(DynamicBoneHelper))

				if var_121_16 then
					var_121_16:EnableDynamicBone(true)
				end
			end

			local var_121_17 = arg_118_1.actors_["10004ui_story"].transform
			local var_121_18 = 0

			if var_121_18 < arg_118_1.time_ and arg_118_1.time_ <= var_121_18 + arg_121_0 then
				arg_118_1.var_.moveOldPos10004ui_story = var_121_17.localPosition
			end

			local var_121_19 = 0.001

			if var_121_18 <= arg_118_1.time_ and arg_118_1.time_ < var_121_18 + var_121_19 then
				local var_121_20 = (arg_118_1.time_ - var_121_18) / var_121_19
				local var_121_21 = Vector3.New(0, 100, 0)

				var_121_17.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10004ui_story, var_121_21, var_121_20)

				local var_121_22 = manager.ui.mainCamera.transform.position - var_121_17.position

				var_121_17.forward = Vector3.New(var_121_22.x, var_121_22.y, var_121_22.z)

				local var_121_23 = var_121_17.localEulerAngles

				var_121_23.z = 0
				var_121_23.x = 0
				var_121_17.localEulerAngles = var_121_23
			end

			if arg_118_1.time_ >= var_121_18 + var_121_19 and arg_118_1.time_ < var_121_18 + var_121_19 + arg_121_0 then
				var_121_17.localPosition = Vector3.New(0, 100, 0)

				local var_121_24 = manager.ui.mainCamera.transform.position - var_121_17.position

				var_121_17.forward = Vector3.New(var_121_24.x, var_121_24.y, var_121_24.z)

				local var_121_25 = var_121_17.localEulerAngles

				var_121_25.z = 0
				var_121_25.x = 0
				var_121_17.localEulerAngles = var_121_25
			end

			local var_121_26 = 0
			local var_121_27 = 0.875

			if var_121_26 < arg_118_1.time_ and arg_118_1.time_ <= var_121_26 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_28 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_28:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_29 = arg_118_1:GetWordFromCfg(106091029)
				local var_121_30 = arg_118_1:FormatText(var_121_29.content)

				arg_118_1.text_.text = var_121_30

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_31 = 34
				local var_121_32 = utf8.len(var_121_30)
				local var_121_33 = var_121_31 <= 0 and var_121_27 or var_121_27 * (var_121_32 / var_121_31)

				if var_121_33 > 0 and var_121_27 < var_121_33 then
					arg_118_1.talkMaxDuration = var_121_33
					var_121_26 = var_121_26 + 0.3

					if var_121_33 + var_121_26 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_33 + var_121_26
					end
				end

				arg_118_1.text_.text = var_121_30
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_34 = var_121_26 + 0.3
			local var_121_35 = math.max(var_121_27, arg_118_1.talkMaxDuration)

			if var_121_34 <= arg_118_1.time_ and arg_118_1.time_ < var_121_34 + var_121_35 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_34) / var_121_35

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_34 + var_121_35 and arg_118_1.time_ < var_121_34 + var_121_35 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play106091030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 106091030
		arg_124_1.duration_ = 5.2

		local var_124_0 = {
			ja = 3.9,
			ko = 4.333,
			zh = 4.5,
			en = 5.2
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
				arg_124_0:Play106091031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.525

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[89].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(106091030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 21
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091030", "story_v_out_106091.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_106091", "106091030", "story_v_out_106091.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_106091", "106091030", "story_v_out_106091.awb")

						arg_124_1:RecordAudio("106091030", var_127_9)
						arg_124_1:RecordAudio("106091030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_106091", "106091030", "story_v_out_106091.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_106091", "106091030", "story_v_out_106091.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play106091031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 106091031
		arg_128_1.duration_ = 8.9

		local var_128_0 = {
			ja = 8.833,
			ko = 8.433,
			zh = 7.333,
			en = 8.9
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play106091032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["2032_tpose"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos2032_tpose = var_131_0.localPosition

				local var_131_2 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(false)
				end
			end

			local var_131_3 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_3 then
				local var_131_4 = (arg_128_1.time_ - var_131_1) / var_131_3
				local var_131_5 = Vector3.New(0, -1.15, -4.2)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos2032_tpose, var_131_5, var_131_4)

				local var_131_6 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_6.x, var_131_6.y, var_131_6.z)

				local var_131_7 = var_131_0.localEulerAngles

				var_131_7.z = 0
				var_131_7.x = 0
				var_131_0.localEulerAngles = var_131_7
			end

			if arg_128_1.time_ >= var_131_1 + var_131_3 and arg_128_1.time_ < var_131_1 + var_131_3 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -1.15, -4.2)

				local var_131_8 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_8.x, var_131_8.y, var_131_8.z)

				local var_131_9 = var_131_0.localEulerAngles

				var_131_9.z = 0
				var_131_9.x = 0
				var_131_0.localEulerAngles = var_131_9

				local var_131_10 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_10 then
					var_131_10:EnableDynamicBone(true)
				end
			end

			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1:PlayTimeline("2032_tpose", "StoryTimeline/CharAction/story2032/story2032action/2032action1_1")
			end

			local var_131_12 = 0
			local var_131_13 = 0.775

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_14 = arg_128_1:FormatText(StoryNameCfg[90].name)

				arg_128_1.leftNameTxt_.text = var_131_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_15 = arg_128_1:GetWordFromCfg(106091031)
				local var_131_16 = arg_128_1:FormatText(var_131_15.content)

				arg_128_1.text_.text = var_131_16

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_17 = 31
				local var_131_18 = utf8.len(var_131_16)
				local var_131_19 = var_131_17 <= 0 and var_131_13 or var_131_13 * (var_131_18 / var_131_17)

				if var_131_19 > 0 and var_131_13 < var_131_19 then
					arg_128_1.talkMaxDuration = var_131_19

					if var_131_19 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_12
					end
				end

				arg_128_1.text_.text = var_131_16
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091031", "story_v_out_106091.awb") ~= 0 then
					local var_131_20 = manager.audio:GetVoiceLength("story_v_out_106091", "106091031", "story_v_out_106091.awb") / 1000

					if var_131_20 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_20 + var_131_12
					end

					if var_131_15.prefab_name ~= "" and arg_128_1.actors_[var_131_15.prefab_name] ~= nil then
						local var_131_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_15.prefab_name].transform, "story_v_out_106091", "106091031", "story_v_out_106091.awb")

						arg_128_1:RecordAudio("106091031", var_131_21)
						arg_128_1:RecordAudio("106091031", var_131_21)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_106091", "106091031", "story_v_out_106091.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_106091", "106091031", "story_v_out_106091.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_22 = math.max(var_131_13, arg_128_1.talkMaxDuration)

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_22 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_12) / var_131_22

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_12 + var_131_22 and arg_128_1.time_ < var_131_12 + var_131_22 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play106091032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 106091032
		arg_132_1.duration_ = 7.07

		local var_132_0 = {
			ja = 5.7,
			ko = 1.966,
			zh = 3.3,
			en = 7.066
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play106091033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["2032_tpose"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect2032_tpose == nil then
				arg_132_1.var_.characterEffect2032_tpose = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.1

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect2032_tpose and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect2032_tpose then
				arg_132_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_135_4 = 0
			local var_135_5 = 0.05

			if var_135_4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_6 = arg_132_1:FormatText(StoryNameCfg[88].name)

				arg_132_1.leftNameTxt_.text = var_135_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:GetWordFromCfg(106091032)
				local var_135_8 = arg_132_1:FormatText(var_135_7.content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 2
				local var_135_10 = utf8.len(var_135_8)
				local var_135_11 = var_135_9 <= 0 and var_135_5 or var_135_5 * (var_135_10 / var_135_9)

				if var_135_11 > 0 and var_135_5 < var_135_11 then
					arg_132_1.talkMaxDuration = var_135_11

					if var_135_11 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091032", "story_v_out_106091.awb") ~= 0 then
					local var_135_12 = manager.audio:GetVoiceLength("story_v_out_106091", "106091032", "story_v_out_106091.awb") / 1000

					if var_135_12 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_4
					end

					if var_135_7.prefab_name ~= "" and arg_132_1.actors_[var_135_7.prefab_name] ~= nil then
						local var_135_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_7.prefab_name].transform, "story_v_out_106091", "106091032", "story_v_out_106091.awb")

						arg_132_1:RecordAudio("106091032", var_135_13)
						arg_132_1:RecordAudio("106091032", var_135_13)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_106091", "106091032", "story_v_out_106091.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_106091", "106091032", "story_v_out_106091.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_14 and arg_132_1.time_ < var_135_4 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play106091033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 106091033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play106091034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["2032_tpose"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos2032_tpose = var_139_0.localPosition

				local var_139_2 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(false)
				end
			end

			local var_139_3 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_1) / var_139_3
				local var_139_5 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos2032_tpose, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_0.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_0.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_1 + var_139_3 and arg_136_1.time_ < var_139_1 + var_139_3 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, 100, 0)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_0.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_0.localEulerAngles = var_139_9

				local var_139_10 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_10 then
					var_139_10:EnableDynamicBone(true)
				end
			end

			local var_139_11 = 0
			local var_139_12 = 1.2

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_13 = arg_136_1:GetWordFromCfg(106091033)
				local var_139_14 = arg_136_1:FormatText(var_139_13.content)

				arg_136_1.text_.text = var_139_14

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_15 = 48
				local var_139_16 = utf8.len(var_139_14)
				local var_139_17 = var_139_15 <= 0 and var_139_12 or var_139_12 * (var_139_16 / var_139_15)

				if var_139_17 > 0 and var_139_12 < var_139_17 then
					arg_136_1.talkMaxDuration = var_139_17

					if var_139_17 + var_139_11 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_17 + var_139_11
					end
				end

				arg_136_1.text_.text = var_139_14
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_18 = math.max(var_139_12, arg_136_1.talkMaxDuration)

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_18 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_11) / var_139_18

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_11 + var_139_18 and arg_136_1.time_ < var_139_11 + var_139_18 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play106091034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 106091034
		arg_140_1.duration_ = 10.3

		local var_140_0 = {
			ja = 8.7,
			ko = 8.9,
			zh = 10.3,
			en = 7.833
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play106091035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["4014_tpose"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect4014_tpose == nil then
				arg_140_1.var_.characterEffect4014_tpose = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect4014_tpose and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect4014_tpose then
				arg_140_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["4014_tpose"].transform
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.var_.moveOldPos4014_tpose = var_143_4.localPosition

				local var_143_6 = GameObjectTools.GetOrAddComponent(var_143_4.gameObject, typeof(DynamicBoneHelper))

				if var_143_6 then
					var_143_6:EnableDynamicBone(false)
				end
			end

			local var_143_7 = 0.001

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_7 then
				local var_143_8 = (arg_140_1.time_ - var_143_5) / var_143_7
				local var_143_9 = Vector3.New(-0.7, -1.95, -4.2)

				var_143_4.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos4014_tpose, var_143_9, var_143_8)

				local var_143_10 = manager.ui.mainCamera.transform.position - var_143_4.position

				var_143_4.forward = Vector3.New(var_143_10.x, var_143_10.y, var_143_10.z)

				local var_143_11 = var_143_4.localEulerAngles

				var_143_11.z = 0
				var_143_11.x = 0
				var_143_4.localEulerAngles = var_143_11
			end

			if arg_140_1.time_ >= var_143_5 + var_143_7 and arg_140_1.time_ < var_143_5 + var_143_7 + arg_143_0 then
				var_143_4.localPosition = Vector3.New(-0.7, -1.95, -4.2)

				local var_143_12 = manager.ui.mainCamera.transform.position - var_143_4.position

				var_143_4.forward = Vector3.New(var_143_12.x, var_143_12.y, var_143_12.z)

				local var_143_13 = var_143_4.localEulerAngles

				var_143_13.z = 0
				var_143_13.x = 0
				var_143_4.localEulerAngles = var_143_13

				local var_143_14 = GameObjectTools.GetOrAddComponent(var_143_4.gameObject, typeof(DynamicBoneHelper))

				if var_143_14 then
					var_143_14:EnableDynamicBone(true)
				end
			end

			local var_143_15 = 0

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_143_16 = 0
			local var_143_17 = 0.8

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_18 = arg_140_1:FormatText(StoryNameCfg[87].name)

				arg_140_1.leftNameTxt_.text = var_143_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_19 = arg_140_1:GetWordFromCfg(106091034)
				local var_143_20 = arg_140_1:FormatText(var_143_19.content)

				arg_140_1.text_.text = var_143_20

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_21 = 32
				local var_143_22 = utf8.len(var_143_20)
				local var_143_23 = var_143_21 <= 0 and var_143_17 or var_143_17 * (var_143_22 / var_143_21)

				if var_143_23 > 0 and var_143_17 < var_143_23 then
					arg_140_1.talkMaxDuration = var_143_23

					if var_143_23 + var_143_16 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_23 + var_143_16
					end
				end

				arg_140_1.text_.text = var_143_20
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091034", "story_v_out_106091.awb") ~= 0 then
					local var_143_24 = manager.audio:GetVoiceLength("story_v_out_106091", "106091034", "story_v_out_106091.awb") / 1000

					if var_143_24 + var_143_16 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_24 + var_143_16
					end

					if var_143_19.prefab_name ~= "" and arg_140_1.actors_[var_143_19.prefab_name] ~= nil then
						local var_143_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_19.prefab_name].transform, "story_v_out_106091", "106091034", "story_v_out_106091.awb")

						arg_140_1:RecordAudio("106091034", var_143_25)
						arg_140_1:RecordAudio("106091034", var_143_25)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_106091", "106091034", "story_v_out_106091.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_106091", "106091034", "story_v_out_106091.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_26 = math.max(var_143_17, arg_140_1.talkMaxDuration)

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_26 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_16) / var_143_26

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_16 + var_143_26 and arg_140_1.time_ < var_143_16 + var_143_26 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play106091035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 106091035
		arg_144_1.duration_ = 2.5

		local var_144_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play106091036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["4014_tpose"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect4014_tpose == nil then
				arg_144_1.var_.characterEffect4014_tpose = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.1

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect4014_tpose and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_144_1.var_.characterEffect4014_tpose.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect4014_tpose then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_144_1.var_.characterEffect4014_tpose.fillRatio = var_147_5
			end

			local var_147_6 = arg_144_1.actors_["10004ui_story"]
			local var_147_7 = 0

			if var_147_7 < arg_144_1.time_ and arg_144_1.time_ <= var_147_7 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect10004ui_story == nil then
				arg_144_1.var_.characterEffect10004ui_story = var_147_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_8 = 0.1

			if var_147_7 <= arg_144_1.time_ and arg_144_1.time_ < var_147_7 + var_147_8 and not isNil(var_147_6) then
				local var_147_9 = (arg_144_1.time_ - var_147_7) / var_147_8

				if arg_144_1.var_.characterEffect10004ui_story and not isNil(var_147_6) then
					arg_144_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_7 + var_147_8 and arg_144_1.time_ < var_147_7 + var_147_8 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect10004ui_story then
				arg_144_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_147_10 = arg_144_1.actors_["10004ui_story"].transform
			local var_147_11 = 0

			if var_147_11 < arg_144_1.time_ and arg_144_1.time_ <= var_147_11 + arg_147_0 then
				arg_144_1.var_.moveOldPos10004ui_story = var_147_10.localPosition
			end

			local var_147_12 = 0.001

			if var_147_11 <= arg_144_1.time_ and arg_144_1.time_ < var_147_11 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_11) / var_147_12
				local var_147_14 = Vector3.New(0.7, -1.1, -5.6)

				var_147_10.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10004ui_story, var_147_14, var_147_13)

				local var_147_15 = manager.ui.mainCamera.transform.position - var_147_10.position

				var_147_10.forward = Vector3.New(var_147_15.x, var_147_15.y, var_147_15.z)

				local var_147_16 = var_147_10.localEulerAngles

				var_147_16.z = 0
				var_147_16.x = 0
				var_147_10.localEulerAngles = var_147_16
			end

			if arg_144_1.time_ >= var_147_11 + var_147_12 and arg_144_1.time_ < var_147_11 + var_147_12 + arg_147_0 then
				var_147_10.localPosition = Vector3.New(0.7, -1.1, -5.6)

				local var_147_17 = manager.ui.mainCamera.transform.position - var_147_10.position

				var_147_10.forward = Vector3.New(var_147_17.x, var_147_17.y, var_147_17.z)

				local var_147_18 = var_147_10.localEulerAngles

				var_147_18.z = 0
				var_147_18.x = 0
				var_147_10.localEulerAngles = var_147_18
			end

			local var_147_19 = 0

			if var_147_19 < arg_144_1.time_ and arg_144_1.time_ <= var_147_19 + arg_147_0 then
				arg_144_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_2")
			end

			local var_147_20 = 0

			if var_147_20 < arg_144_1.time_ and arg_144_1.time_ <= var_147_20 + arg_147_0 then
				arg_144_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_147_21 = 0
			local var_147_22 = 0.2

			if var_147_21 < arg_144_1.time_ and arg_144_1.time_ <= var_147_21 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_23 = arg_144_1:FormatText(StoryNameCfg[80].name)

				arg_144_1.leftNameTxt_.text = var_147_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_24 = arg_144_1:GetWordFromCfg(106091035)
				local var_147_25 = arg_144_1:FormatText(var_147_24.content)

				arg_144_1.text_.text = var_147_25

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_26 = 8
				local var_147_27 = utf8.len(var_147_25)
				local var_147_28 = var_147_26 <= 0 and var_147_22 or var_147_22 * (var_147_27 / var_147_26)

				if var_147_28 > 0 and var_147_22 < var_147_28 then
					arg_144_1.talkMaxDuration = var_147_28

					if var_147_28 + var_147_21 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_28 + var_147_21
					end
				end

				arg_144_1.text_.text = var_147_25
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091035", "story_v_out_106091.awb") ~= 0 then
					local var_147_29 = manager.audio:GetVoiceLength("story_v_out_106091", "106091035", "story_v_out_106091.awb") / 1000

					if var_147_29 + var_147_21 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_29 + var_147_21
					end

					if var_147_24.prefab_name ~= "" and arg_144_1.actors_[var_147_24.prefab_name] ~= nil then
						local var_147_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_24.prefab_name].transform, "story_v_out_106091", "106091035", "story_v_out_106091.awb")

						arg_144_1:RecordAudio("106091035", var_147_30)
						arg_144_1:RecordAudio("106091035", var_147_30)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_106091", "106091035", "story_v_out_106091.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_106091", "106091035", "story_v_out_106091.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_31 = math.max(var_147_22, arg_144_1.talkMaxDuration)

			if var_147_21 <= arg_144_1.time_ and arg_144_1.time_ < var_147_21 + var_147_31 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_21) / var_147_31

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_21 + var_147_31 and arg_144_1.time_ < var_147_21 + var_147_31 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play106091036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 106091036
		arg_148_1.duration_ = 1.5

		local var_148_0 = {
			ja = 1.5,
			ko = 1.333,
			zh = 1.433,
			en = 1.5
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play106091037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["4014_tpose"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect4014_tpose == nil then
				arg_148_1.var_.characterEffect4014_tpose = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.1

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect4014_tpose and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect4014_tpose then
				arg_148_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["10004ui_story"]
			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect10004ui_story == nil then
				arg_148_1.var_.characterEffect10004ui_story = var_151_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_6 = 0.1

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 and not isNil(var_151_4) then
				local var_151_7 = (arg_148_1.time_ - var_151_5) / var_151_6

				if arg_148_1.var_.characterEffect10004ui_story and not isNil(var_151_4) then
					local var_151_8 = Mathf.Lerp(0, 0.5, var_151_7)

					arg_148_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10004ui_story.fillRatio = var_151_8
				end
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect10004ui_story then
				local var_151_9 = 0.5

				arg_148_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10004ui_story.fillRatio = var_151_9
			end

			local var_151_10 = 0
			local var_151_11 = 0.1

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_12 = arg_148_1:FormatText(StoryNameCfg[87].name)

				arg_148_1.leftNameTxt_.text = var_151_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_13 = arg_148_1:GetWordFromCfg(106091036)
				local var_151_14 = arg_148_1:FormatText(var_151_13.content)

				arg_148_1.text_.text = var_151_14

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_15 = 4
				local var_151_16 = utf8.len(var_151_14)
				local var_151_17 = var_151_15 <= 0 and var_151_11 or var_151_11 * (var_151_16 / var_151_15)

				if var_151_17 > 0 and var_151_11 < var_151_17 then
					arg_148_1.talkMaxDuration = var_151_17

					if var_151_17 + var_151_10 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_17 + var_151_10
					end
				end

				arg_148_1.text_.text = var_151_14
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091036", "story_v_out_106091.awb") ~= 0 then
					local var_151_18 = manager.audio:GetVoiceLength("story_v_out_106091", "106091036", "story_v_out_106091.awb") / 1000

					if var_151_18 + var_151_10 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_18 + var_151_10
					end

					if var_151_13.prefab_name ~= "" and arg_148_1.actors_[var_151_13.prefab_name] ~= nil then
						local var_151_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_13.prefab_name].transform, "story_v_out_106091", "106091036", "story_v_out_106091.awb")

						arg_148_1:RecordAudio("106091036", var_151_19)
						arg_148_1:RecordAudio("106091036", var_151_19)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_106091", "106091036", "story_v_out_106091.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_106091", "106091036", "story_v_out_106091.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_20 = math.max(var_151_11, arg_148_1.talkMaxDuration)

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_20 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_10) / var_151_20

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_10 + var_151_20 and arg_148_1.time_ < var_151_10 + var_151_20 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play106091037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 106091037
		arg_152_1.duration_ = 4.8

		local var_152_0 = {
			ja = 1.999999999999,
			ko = 3.566,
			zh = 4.8,
			en = 3.7
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play106091038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["4014_tpose"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect4014_tpose == nil then
				arg_152_1.var_.characterEffect4014_tpose = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.1

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect4014_tpose and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_152_1.var_.characterEffect4014_tpose.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect4014_tpose then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_152_1.var_.characterEffect4014_tpose.fillRatio = var_155_5
			end

			local var_155_6 = arg_152_1.actors_["10004ui_story"]
			local var_155_7 = 0

			if var_155_7 < arg_152_1.time_ and arg_152_1.time_ <= var_155_7 + arg_155_0 and not isNil(var_155_6) and arg_152_1.var_.characterEffect10004ui_story == nil then
				arg_152_1.var_.characterEffect10004ui_story = var_155_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_8 = 0.1

			if var_155_7 <= arg_152_1.time_ and arg_152_1.time_ < var_155_7 + var_155_8 and not isNil(var_155_6) then
				local var_155_9 = (arg_152_1.time_ - var_155_7) / var_155_8

				if arg_152_1.var_.characterEffect10004ui_story and not isNil(var_155_6) then
					arg_152_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_7 + var_155_8 and arg_152_1.time_ < var_155_7 + var_155_8 + arg_155_0 and not isNil(var_155_6) and arg_152_1.var_.characterEffect10004ui_story then
				arg_152_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_155_11 = 0
			local var_155_12 = 0.35

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_13 = arg_152_1:FormatText(StoryNameCfg[80].name)

				arg_152_1.leftNameTxt_.text = var_155_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_14 = arg_152_1:GetWordFromCfg(106091037)
				local var_155_15 = arg_152_1:FormatText(var_155_14.content)

				arg_152_1.text_.text = var_155_15

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_16 = 14
				local var_155_17 = utf8.len(var_155_15)
				local var_155_18 = var_155_16 <= 0 and var_155_12 or var_155_12 * (var_155_17 / var_155_16)

				if var_155_18 > 0 and var_155_12 < var_155_18 then
					arg_152_1.talkMaxDuration = var_155_18

					if var_155_18 + var_155_11 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_18 + var_155_11
					end
				end

				arg_152_1.text_.text = var_155_15
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091037", "story_v_out_106091.awb") ~= 0 then
					local var_155_19 = manager.audio:GetVoiceLength("story_v_out_106091", "106091037", "story_v_out_106091.awb") / 1000

					if var_155_19 + var_155_11 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_19 + var_155_11
					end

					if var_155_14.prefab_name ~= "" and arg_152_1.actors_[var_155_14.prefab_name] ~= nil then
						local var_155_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_14.prefab_name].transform, "story_v_out_106091", "106091037", "story_v_out_106091.awb")

						arg_152_1:RecordAudio("106091037", var_155_20)
						arg_152_1:RecordAudio("106091037", var_155_20)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_106091", "106091037", "story_v_out_106091.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_106091", "106091037", "story_v_out_106091.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_21 = math.max(var_155_12, arg_152_1.talkMaxDuration)

			if var_155_11 <= arg_152_1.time_ and arg_152_1.time_ < var_155_11 + var_155_21 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_11) / var_155_21

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_11 + var_155_21 and arg_152_1.time_ < var_155_11 + var_155_21 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play106091038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 106091038
		arg_156_1.duration_ = 3.93

		local var_156_0 = {
			ja = 2.9,
			ko = 3,
			zh = 3.933,
			en = 3
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play106091039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action5_1")
			end

			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_159_2 = 0
			local var_159_3 = 0.325

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_4 = arg_156_1:FormatText(StoryNameCfg[80].name)

				arg_156_1.leftNameTxt_.text = var_159_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:GetWordFromCfg(106091038)
				local var_159_6 = arg_156_1:FormatText(var_159_5.content)

				arg_156_1.text_.text = var_159_6

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 13
				local var_159_8 = utf8.len(var_159_6)
				local var_159_9 = var_159_7 <= 0 and var_159_3 or var_159_3 * (var_159_8 / var_159_7)

				if var_159_9 > 0 and var_159_3 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_6
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091038", "story_v_out_106091.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091038", "story_v_out_106091.awb") / 1000

					if var_159_10 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_2
					end

					if var_159_5.prefab_name ~= "" and arg_156_1.actors_[var_159_5.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_5.prefab_name].transform, "story_v_out_106091", "106091038", "story_v_out_106091.awb")

						arg_156_1:RecordAudio("106091038", var_159_11)
						arg_156_1:RecordAudio("106091038", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_106091", "106091038", "story_v_out_106091.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_106091", "106091038", "story_v_out_106091.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_12 and arg_156_1.time_ < var_159_2 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play106091039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 106091039
		arg_160_1.duration_ = 1.53

		local var_160_0 = {
			ja = 1,
			ko = 1.333,
			zh = 1.533,
			en = 1.433
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play106091040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10004ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10004ui_story == nil then
				arg_160_1.var_.characterEffect10004ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.1

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10004ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10004ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10004ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10004ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.05

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[82].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(106091039)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 2
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091039", "story_v_out_106091.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_106091", "106091039", "story_v_out_106091.awb") / 1000

					if var_163_14 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_6
					end

					if var_163_9.prefab_name ~= "" and arg_160_1.actors_[var_163_9.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_9.prefab_name].transform, "story_v_out_106091", "106091039", "story_v_out_106091.awb")

						arg_160_1:RecordAudio("106091039", var_163_15)
						arg_160_1:RecordAudio("106091039", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_106091", "106091039", "story_v_out_106091.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_106091", "106091039", "story_v_out_106091.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_16 and arg_160_1.time_ < var_163_6 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play106091040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 106091040
		arg_164_1.duration_ = 10.87

		local var_164_0 = {
			ja = 6.533,
			ko = 7.733,
			zh = 9.033,
			en = 10.866
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play106091041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["4014_tpose"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect4014_tpose == nil then
				arg_164_1.var_.characterEffect4014_tpose = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.1

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect4014_tpose and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect4014_tpose then
				arg_164_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_167_4 = arg_164_1.actors_["10004ui_story"]
			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect10004ui_story == nil then
				arg_164_1.var_.characterEffect10004ui_story = var_167_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_6 = 0.1

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_6 and not isNil(var_167_4) then
				local var_167_7 = (arg_164_1.time_ - var_167_5) / var_167_6

				if arg_164_1.var_.characterEffect10004ui_story and not isNil(var_167_4) then
					local var_167_8 = Mathf.Lerp(0, 0.5, var_167_7)

					arg_164_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10004ui_story.fillRatio = var_167_8
				end
			end

			if arg_164_1.time_ >= var_167_5 + var_167_6 and arg_164_1.time_ < var_167_5 + var_167_6 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect10004ui_story then
				local var_167_9 = 0.5

				arg_164_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10004ui_story.fillRatio = var_167_9
			end

			local var_167_10 = 0
			local var_167_11 = 0.95

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_12 = arg_164_1:FormatText(StoryNameCfg[87].name)

				arg_164_1.leftNameTxt_.text = var_167_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_13 = arg_164_1:GetWordFromCfg(106091040)
				local var_167_14 = arg_164_1:FormatText(var_167_13.content)

				arg_164_1.text_.text = var_167_14

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_15 = 36
				local var_167_16 = utf8.len(var_167_14)
				local var_167_17 = var_167_15 <= 0 and var_167_11 or var_167_11 * (var_167_16 / var_167_15)

				if var_167_17 > 0 and var_167_11 < var_167_17 then
					arg_164_1.talkMaxDuration = var_167_17

					if var_167_17 + var_167_10 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_17 + var_167_10
					end
				end

				arg_164_1.text_.text = var_167_14
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091040", "story_v_out_106091.awb") ~= 0 then
					local var_167_18 = manager.audio:GetVoiceLength("story_v_out_106091", "106091040", "story_v_out_106091.awb") / 1000

					if var_167_18 + var_167_10 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_18 + var_167_10
					end

					if var_167_13.prefab_name ~= "" and arg_164_1.actors_[var_167_13.prefab_name] ~= nil then
						local var_167_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_13.prefab_name].transform, "story_v_out_106091", "106091040", "story_v_out_106091.awb")

						arg_164_1:RecordAudio("106091040", var_167_19)
						arg_164_1:RecordAudio("106091040", var_167_19)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_106091", "106091040", "story_v_out_106091.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_106091", "106091040", "story_v_out_106091.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_20 = math.max(var_167_11, arg_164_1.talkMaxDuration)

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_20 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_10) / var_167_20

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_10 + var_167_20 and arg_164_1.time_ < var_167_10 + var_167_20 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play106091041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 106091041
		arg_168_1.duration_ = 3

		local var_168_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 3,
			en = 1.999999999999
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play106091042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["4014_tpose"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect4014_tpose == nil then
				arg_168_1.var_.characterEffect4014_tpose = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.1

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect4014_tpose and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_168_1.var_.characterEffect4014_tpose.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect4014_tpose then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_168_1.var_.characterEffect4014_tpose.fillRatio = var_171_5
			end

			local var_171_6 = arg_168_1.actors_["10004ui_story"]
			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect10004ui_story == nil then
				arg_168_1.var_.characterEffect10004ui_story = var_171_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_8 = 0.1

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_8 and not isNil(var_171_6) then
				local var_171_9 = (arg_168_1.time_ - var_171_7) / var_171_8

				if arg_168_1.var_.characterEffect10004ui_story and not isNil(var_171_6) then
					arg_168_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_7 + var_171_8 and arg_168_1.time_ < var_171_7 + var_171_8 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect10004ui_story then
				arg_168_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action5_2")
			end

			local var_171_11 = 0

			if var_171_11 < arg_168_1.time_ and arg_168_1.time_ <= var_171_11 + arg_171_0 then
				arg_168_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_171_12 = 0
			local var_171_13 = 0.15

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_14 = arg_168_1:FormatText(StoryNameCfg[80].name)

				arg_168_1.leftNameTxt_.text = var_171_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_15 = arg_168_1:GetWordFromCfg(106091041)
				local var_171_16 = arg_168_1:FormatText(var_171_15.content)

				arg_168_1.text_.text = var_171_16

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_17 = 6
				local var_171_18 = utf8.len(var_171_16)
				local var_171_19 = var_171_17 <= 0 and var_171_13 or var_171_13 * (var_171_18 / var_171_17)

				if var_171_19 > 0 and var_171_13 < var_171_19 then
					arg_168_1.talkMaxDuration = var_171_19

					if var_171_19 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_12
					end
				end

				arg_168_1.text_.text = var_171_16
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091041", "story_v_out_106091.awb") ~= 0 then
					local var_171_20 = manager.audio:GetVoiceLength("story_v_out_106091", "106091041", "story_v_out_106091.awb") / 1000

					if var_171_20 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_20 + var_171_12
					end

					if var_171_15.prefab_name ~= "" and arg_168_1.actors_[var_171_15.prefab_name] ~= nil then
						local var_171_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_15.prefab_name].transform, "story_v_out_106091", "106091041", "story_v_out_106091.awb")

						arg_168_1:RecordAudio("106091041", var_171_21)
						arg_168_1:RecordAudio("106091041", var_171_21)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_106091", "106091041", "story_v_out_106091.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_106091", "106091041", "story_v_out_106091.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_22 = math.max(var_171_13, arg_168_1.talkMaxDuration)

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_22 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_12) / var_171_22

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_12 + var_171_22 and arg_168_1.time_ < var_171_12 + var_171_22 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play106091042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 106091042
		arg_172_1.duration_ = 6.13

		local var_172_0 = {
			ja = 2.3,
			ko = 5.066,
			zh = 6.133,
			en = 4.066
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
			arg_172_1.auto_ = false
		end

		function arg_172_1.playNext_(arg_174_0)
			arg_172_1.onStoryFinished_()
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_175_1 = 0
			local var_175_2 = 0.55

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_3 = arg_172_1:FormatText(StoryNameCfg[80].name)

				arg_172_1.leftNameTxt_.text = var_175_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_4 = arg_172_1:GetWordFromCfg(106091042)
				local var_175_5 = arg_172_1:FormatText(var_175_4.content)

				arg_172_1.text_.text = var_175_5

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_6 = 22
				local var_175_7 = utf8.len(var_175_5)
				local var_175_8 = var_175_6 <= 0 and var_175_2 or var_175_2 * (var_175_7 / var_175_6)

				if var_175_8 > 0 and var_175_2 < var_175_8 then
					arg_172_1.talkMaxDuration = var_175_8

					if var_175_8 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_5
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091042", "story_v_out_106091.awb") ~= 0 then
					local var_175_9 = manager.audio:GetVoiceLength("story_v_out_106091", "106091042", "story_v_out_106091.awb") / 1000

					if var_175_9 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_1
					end

					if var_175_4.prefab_name ~= "" and arg_172_1.actors_[var_175_4.prefab_name] ~= nil then
						local var_175_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_4.prefab_name].transform, "story_v_out_106091", "106091042", "story_v_out_106091.awb")

						arg_172_1:RecordAudio("106091042", var_175_10)
						arg_172_1:RecordAudio("106091042", var_175_10)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_106091", "106091042", "story_v_out_106091.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_106091", "106091042", "story_v_out_106091.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_11 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_11 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_11

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_11 and arg_172_1.time_ < var_175_1 + var_175_11 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C05b"
	},
	voices = {
		"story_v_out_106091.awb"
	}
}
